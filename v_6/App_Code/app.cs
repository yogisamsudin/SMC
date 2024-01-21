using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// Summary description for appCookie
/// </summary>
namespace _test
{
    public partial class App
    {
        string AppName;
        HttpRequest Request;
        HttpResponse Response;
        string[] arrCookies;
        
        public string cookieSessionID;
        public string cookieUserID;
        public string cookieHTMLMenu;
        public string cookieListMenuPavorite;
        public string cookieApplicationDate;
        public string cookieCallCutOff;
        public string cookieBranchID;
        public string cookieBranchName;

        public string cookieSessionIDValue;
        public string cookieUserIDValue;
        public string cookieHTMLMenuValue;
        public string cookieListMenuPavoriteValue;
        public string cookieApplicationDateValue;
        
        
        public string CallCutOff
        {
            get
            {
                return Request.Cookies[cookieCallCutOff].Value;
            }
        }
        public string ApplicationDate
        {
            get
            {
                return Request.Cookies[cookieApplicationDate].Value;
            }
        }
        public string UserID
        {
            get
            {
                return Request.Cookies[cookieUserID].Value;
            }
        }
        public string BranchID
        {
            get
            {
                return Request.Cookies[cookieBranchID].Value;
            }
        }
        public string BranchName
        {
            get
            {
                return Request.Cookies[cookieBranchName].Value;
            }
        }

        public App(HttpRequest _request, HttpResponse _response=null)
        {
            string AppID = "AppName";

            Request = _request;
            Response = _response;

            if (System.Configuration.ConfigurationManager.AppSettings[AppID] == null)
            {
                AppName = VirtualPathUtility.GetFileName("~");
            }
            else
            {
                AppName = System.Configuration.ConfigurationManager.AppSettings[AppID].ToString();
            }
            cookieSessionID = AppName+ "SessionID";
            cookieUserID = AppName + "UserID";
            cookieHTMLMenu = AppName + "htmlMenu";
            cookieListMenuPavorite = AppName + "listMenuPavorite";
            cookieApplicationDate = AppName + "ApplicationDate";
            cookieCallCutOff = AppName + "CallCutOff";
            cookieBranchID = AppName + "BranchID";
            cookieBranchName = AppName + "BranchName";

            string[] arrC = { 
                cookieSessionID, 
                cookieUserID, 
                cookieHTMLMenu, 
                cookieListMenuPavorite, 
                cookieApplicationDate,
                cookieCallCutOff,
                cookieBranchID,
                cookieBranchName
            };

            arrCookies = arrC;

            //pastikan bahwa nilai cookie sudah terisi
            if (Request.Cookies[cookieSessionID] != null)
            {
                cookieSessionIDValue = Request.Cookies[cookieSessionID].Value;
                cookieUserIDValue = Request.Cookies[cookieUserID].Value;
                cookieApplicationDateValue = Request.Cookies[cookieApplicationDate].Value;

                //cookieHTMLMenuValue = Request.Cookies[cookieHTMLMenu].Value;                
                //cookieListMenuPavoriteValue = Request.Cookies[cookieListMenuPavorite].Value;
                
                //cookieBranchIDValue = Request.Cookies[cookieBranchID].Value;
                //cookieBranchNameValue = Request.Cookies[cookieBranchName].Value;
            }
        }
        public string getRoot()
        {
            return Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute("~/");            
        }
        public void deleteAllCookies()
        {
            foreach (var key in arrCookies)
            {
                HttpCookie myCookie = new HttpCookie(key);
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(myCookie);
            }
        }
    
    }
}