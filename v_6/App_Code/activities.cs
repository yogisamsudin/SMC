using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using _test;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class activities : System.Web.Services.WebService
{
    //#struct
    public struct s_fin_sales_log
    {
        public string log_date, status_desc;

        public s_fin_sales_log(string _log_date, string _status_desc)
        {
            log_date = _log_date;
            status_desc = _status_desc;
        }
    }
    public struct s_fin_proforma_service_opr
    {
        public double proforma_service_id, grand_price, fee;
        public int service_id;
        public string offer_no, offer_date;

        public s_fin_proforma_service_opr(double _proforma_service_id, double _grand_price, double _fee, int _service_id, string _offer_no, string _offer_date)
        {
            proforma_service_id = _proforma_service_id;
            grand_price = _grand_price;
            fee = _fee;
            service_id = _service_id;
            offer_no = _offer_no;
            offer_date = _offer_date;
        }
    }
    public struct s_fin_proforma_service
    {
        public long proforma_service_id;
        public string proforma_date, proforma_no, term_of_payment_id;
        public string po_no, afpo_no, create_date;
        public int term_of_payment_value, bill_id;
        public Boolean proforma_sts;
        public string proforma_note, bill_name, bill_no, bill_bank_name, term_of_payment_name, str_top_value;
        public int customer_id, an_id;
        public string customer_name;
        public Boolean pph_sts;
        public double grand_price;

        public s_fin_proforma_service(
            long _proforma_service_id,
            string _proforma_date, string _proforma_no, string _term_of_payment_id,
            string _po_no, string _afpo_no, string _create_date,
            int _term_of_payment_value, int _bill_id,
            Boolean _proforma_sts,
            string _proforma_note, string _bill_name, string _bill_no, string _bill_bank_name, string _term_of_payment_name, string _str_top_value,
            int _customer_id, int _an_id, string _customer_name,
            Boolean _pph_sts,
            double _grand_price
        )
        {
            proforma_service_id = _proforma_service_id;
            proforma_date = _proforma_date;
            proforma_no = _proforma_no;
            term_of_payment_id = _term_of_payment_id;
            po_no = _po_no;
            afpo_no = _afpo_no;
            create_date = _create_date;
            term_of_payment_value = _term_of_payment_value;
            bill_id = _bill_id;
            proforma_sts = _proforma_sts;
            proforma_note = _proforma_note;
            bill_name = _bill_name;
            bill_no = _bill_no;
            bill_bank_name = _bill_bank_name;
            term_of_payment_name = _term_of_payment_name;
            str_top_value = _str_top_value;
            customer_id = _customer_id;
            an_id = _an_id;
            customer_name = _customer_name;
            pph_sts = _pph_sts;
            grand_price = _grand_price;
        }
    }
    public struct s_tec_onsite_guarantee
    {
        public int guarantee_onsite_id;
        public string guarantee_onsite_name;
        public Boolean guarantee_sts;

        public s_tec_onsite_guarantee(int _guarantee_onsite_id, string _guarantee_onsite_name, Boolean _guarantee_sts)
        {
            guarantee_sts = _guarantee_sts;
            guarantee_onsite_id = _guarantee_onsite_id;
            guarantee_onsite_name = _guarantee_onsite_name;
        }
    }
    public struct s_tec_onsite_workorders_parts
    {
        public long workorder_id;
        public int part_id, total;
        public string part;

        public s_tec_onsite_workorders_parts( long _workorder_id, int _part_id, int _total, string _part)
        {
            workorder_id = _workorder_id;
            part_id = _part_id;
            total = _total;
            part = _part;
        }
    }
    public struct s_tec_onsite_workorders
    {
        public long workorder_id,onsite_id;
        public int device_id;
        public string sn, note, complient_note, device, segeldate, onsitedevicests_id, onsitedevicests, guarantee_date;

        public s_tec_onsite_workorders(long _workorder_id, long _onsite_id, int _device_id,
            string _sn, string _note, string _complient_note, string _device, string _segeldate,
            string _onsitedevicests_id, string _onsitedevicests, string _guarantee_date = "")
        {
            workorder_id = _workorder_id;
            onsite_id = _onsite_id;
            device_id = _device_id;
            sn = _sn;
            note = _note;
            complient_note = _complient_note;
            device = _device;
            segeldate = _segeldate;
            onsitedevicests_id = _onsitedevicests_id;
            onsitedevicests = _onsitedevicests;
            guarantee_date = _guarantee_date;
        }
 
    }
    public struct s_tec_onsite
    {
        public long onsite_id,customer_id, an_id;
        public int guarantee_onsite_id;
        public string onsite_no, onsite_date, onsite_date2, request_date, technician_name, done_date, note, onsitests_id,
            customer_name, customer_address, customer_address_location, onsitests, marketing_id, contact_name,
            guarantee_onsite_name;
        public Boolean guarantee_sts;
  
        public s_tec_onsite(long _onsite_id, long _customer_id, int _an_id,
            string _onsite_no, string _onsite_date, string _onsite_date2, string _request_date, string _technician_name, string _done_date, string _note, string _onsitests_id,
            string _customer_name, string _customer_address, string _customer_address_location, string _onsitests, string _marketing_id, string _contact_name,
            int _guarantee_onsite_id = 0, string _guarantee_onsite_name = "", Boolean _guarantee_sts = true

        )
        {
            onsite_id = _onsite_id;
            customer_id = _customer_id;
            onsite_no = _onsite_no;
            onsite_date = _onsite_date;
            onsite_date2 = _onsite_date2;
            request_date = _request_date;
            technician_name = _technician_name;
            done_date = _done_date;
            note = _note;
            onsitests_id = _onsitests_id;
            customer_name = _customer_name;
            customer_address = _customer_address;
            customer_address_location = _customer_address_location;
            onsitests = _onsitests;
            marketing_id = _marketing_id;
            an_id = _an_id;
            contact_name = _contact_name;
            guarantee_onsite_id = _guarantee_onsite_id;
            guarantee_onsite_name = _guarantee_onsite_name;
            guarantee_sts = _guarantee_sts;
        }
    }
    public struct s_opr_service_addicost
    {
        public long addicost_id, service_id;
        public string addicost_name;
        public double addicost_value;

        public s_opr_service_addicost(long _addicost_id, long _service_id, string _addicost_name, double _addicost_value)
        {
            addicost_id = _addicost_id;
            service_id = _service_id;
            addicost_name = _addicost_name;
            addicost_value = _addicost_value;
        }
    }
    public struct s_opr_service_document
    {
        public long service_id;
        public string typefileservice_id, file_name, typefilesales_name, file_type;
        public byte[] file_image;

        public s_opr_service_document(long _service_id, string _typefileservice_id, string _file_name, string _typefilesales_name, byte[] _file_image, string _file_type)
        {
            service_id = _service_id;
            typefileservice_id = _typefileservice_id;
            file_name = _file_name;
            typefilesales_name = _typefilesales_name;
            file_image = _file_image;
            file_type = _file_type;
        }
    }
    public struct s_fin_proforma_sales_opr
    {
        public double proforma_sales_id, grand_price, fee;
        public int sales_id;
        public string offer_no, offer_date;

        public s_fin_proforma_sales_opr(double _proforma_sales_id, double _grand_price, double _fee, int _sales_id, string _offer_no, string _offer_date)
        {
            proforma_sales_id = _proforma_sales_id;
            grand_price = _grand_price;
            fee = _fee;
            sales_id = _sales_id;
            offer_no = _offer_no;
            offer_date = _offer_date;
        }
    }
    public struct s_fin_proforma_sales
    {
        public long proforma_sales_id;
        public string proforma_date, proforma_no, term_of_payment_id;
        public string po_no, afpo_no, create_date;
        public int term_of_payment_value, bill_id;
        public Boolean proforma_sts;
        public string proforma_note, bill_name, bill_no, bill_bank_name, term_of_payment_name, str_top_value;
        public int customer_id,an_id;
        public string customer_name;
        public Boolean pph_sts;
        public double grand_price;
       
        public s_fin_proforma_sales(
            long _proforma_sales_id,
            string _proforma_date, string _proforma_no, string _term_of_payment_id,
            string _po_no, string _afpo_no, string _create_date,
            int _term_of_payment_value, int _bill_id,
            Boolean _proforma_sts,
            string _proforma_note, string _bill_name, string _bill_no, string _bill_bank_name, string _term_of_payment_name, string _str_top_value,
            int _customer_id, int _an_id, string _customer_name,
            Boolean _pph_sts,
            double _grand_price
        )
        {
            proforma_sales_id = _proforma_sales_id;
            proforma_date = _proforma_date;
            proforma_no = _proforma_no;
            term_of_payment_id = _term_of_payment_id;
            po_no = _po_no;
            afpo_no = _afpo_no;
            create_date = _create_date;
            term_of_payment_value = _term_of_payment_value;
            bill_id = _bill_id;
            proforma_sts = _proforma_sts;
            proforma_note = _proforma_note;
            bill_name = _bill_name;
            bill_no = _bill_no;
            bill_bank_name = _bill_bank_name;
            term_of_payment_name = _term_of_payment_name;
            str_top_value = _str_top_value;
            customer_id = _customer_id;
            an_id = _an_id;
            customer_name = _customer_name;
            pph_sts = _pph_sts;
            grand_price = _grand_price;
        }
    }
    public struct s_opr_sales_addicost
    {
        public long addicost_id, sales_id;
        public string addicost_name;
        public double addicost_value;

        public s_opr_sales_addicost(long _addicost_id, long _sales_id, string _addicost_name, double _addicost_value)
        {
            addicost_id = _addicost_id;
            sales_id = _sales_id;
            addicost_name = _addicost_name;
            addicost_value = _addicost_value;
        }
    }
    public struct s_opr_sales_document
    {
        public long sales_id;
        public string typefilesales_id, file_name, typefilesales_name, file_type;
        public byte[] file_image;

        public s_opr_sales_document(long _sales_id, string _typefilesales_id, string _file_name, string _typefilesales_name, byte[] _file_image, string _file_type)
        {
            sales_id = _sales_id;
            typefilesales_id = _typefilesales_id;
            file_name = _file_name;
            typefilesales_name = _typefilesales_name;
            file_image = _file_image;
            file_type = _file_type;
        }
    }
    public struct s_opr_sales_log
    {
        public long sales_log_id, sales_id;
        public string log_date, user_id, sales_status_id, sales_status_name;

        public s_opr_sales_log(long _sales_log_id, long _sales_id, string _log_date, string _user_id, string _sales_status_id, string _sales_status_name)
        {
            sales_log_id = _sales_log_id;
            sales_id = _sales_id;
            log_date = _log_date;
            user_id = _user_id;
            sales_status_id = _sales_status_id;
            sales_status_name = _sales_status_name;
        }
    }
    public struct s_opr_sales_approver
    {
        public int approver_id;
        public double limit_awal, limit_akhir;
        public string user_id, approver_name;
        public Boolean active_sts;

        public s_opr_sales_approver(int _approver_id, double _limit_awal, double _limit_akhir, string _user_id, string _approver_name, Boolean _active_sts)
        {
            approver_id = _approver_id;
            limit_awal = _limit_awal;
            limit_akhir = _limit_akhir;
            user_id = _user_id;
            approver_name = _approver_name;
            active_sts = _active_sts;
        }
    }
    public struct s_invoice_receipt
    {
        public int invoice_receipt_id, customer_id, messanger_id;
        public string deliver_date, receipt_date, receipt_name, customer_name, customer_address, messanger_name;

        public s_invoice_receipt(int _invoice_receipt_id, int _customer_id, int _messanger_id,
            string _deliver_date, string _receipt_date, string _receipt_name, string _customer_name, string _customer_address, string _messanger_name
            )
        {
            invoice_receipt_id = _invoice_receipt_id;
            customer_id = _customer_id;
            messanger_id = _messanger_id;
            deliver_date = _deliver_date;
            receipt_date = _receipt_date;
            receipt_name = _receipt_name;
            customer_name = _customer_name;
            customer_address = _customer_address;
            messanger_name = _messanger_name;
        }
    }
    public struct s_fin_invoice_receipt_detail
    {
        public int invoice_receipt_id, id;
        public string jenis, invoice_no, receipt_no;
        public double grand_price;

        public s_fin_invoice_receipt_detail(int _invoice_receipt_id, int _id, string _jenis, string _invoice_no, string _receipt_no, double _grand_price)
        {
            invoice_receipt_id = _invoice_receipt_id;
            id = _id;
            jenis = _jenis;
            invoice_no = _invoice_no;
            receipt_no = _receipt_no;
            grand_price = _grand_price;
        }
    }
    public struct s_dashboard_init
    {
        public double targettahunan, sisapencapaian;

        public s_dashboard_init(double _targettahunan, double _sisapencapaian)
        {
            targettahunan = _targettahunan;
            sisapencapaian = _sisapencapaian;
        }
    }
    public struct s_exp_messanger_geotag
    {
        public long geotag_id;
        public int messanger_id;
        public string messanger_name, ping_date, ping_time;
        public double latitude, longitude;

        public s_exp_messanger_geotag(long _geotag_id, int _messanger_id, string _messanger_name, string _ping_date, string _ping_time, double _latitude, double _longitude)
        {
            geotag_id = _geotag_id;
            messanger_id = _messanger_id;
            messanger_name = _messanger_name;
            ping_date = _ping_date;
            ping_time = _ping_time;
            latitude = _latitude;
            longitude = _longitude;
        }
    }
    public struct s_hr_nonsalary_employee_wageparam
    {
        public int nonsalary_employee_wageparam_id, nonsalary_employee_id, wageparam_id, total;
        public double nilai, total_nilai;
        public string note, wageparam_name, type_id, employee_name, type_name;

        public s_hr_nonsalary_employee_wageparam(int _nonsalary_employee_wageparam_id, int _nonsalary_employee_id, int _wageparam_id, int _total,
            double _nilai, double _total_nilai,
            string _note, string _wageparam_name, string _type_id, string _employee_name, string _type_name)
        {
            nonsalary_employee_wageparam_id = _nonsalary_employee_wageparam_id;
            nonsalary_employee_id = _nonsalary_employee_id;
            wageparam_id = _wageparam_id;
            total = _total;
            nilai = _nilai;
            note = _note;
            wageparam_name = _wageparam_name;
            type_id = _type_id;
            employee_name = _employee_name;
            type_name = _type_name;
            total_nilai = _total_nilai;
        }
    }
    public struct s_hr_nonsalary_employee
    {
        public int nonsalary_employee_id, nonsalary_id, employee_id;
        public string employee_name;
        public double total_salary;

        public s_hr_nonsalary_employee(int _nonsalary_employee_id, int _nonsalary_id, int _employee_id,
        string _employee_name, double _total_salary)
        {
            nonsalary_employee_id = _nonsalary_employee_id;
            nonsalary_id = _nonsalary_id;
            employee_id = _employee_id;
            employee_name = _employee_name;
            total_salary = _total_salary;
        }
    }
    public struct s_hr_nonsalary
    {
        public int nonsalary_id, month_issue, year_issue;
        public string nonsalary_name, nonsalary_date, month_issue_name;

        public s_hr_nonsalary(int _nonsalary_id, int _month_issue, int _year_issue,
            string _nonsalary_name, string _nonsalary_date, string _month_issue_name)
        {
            nonsalary_id = _nonsalary_id;
            month_issue = _month_issue;
            year_issue = _year_issue;
            nonsalary_name = _nonsalary_name;
            nonsalary_date = _nonsalary_date;
            month_issue_name = _month_issue_name;
        }
    }
    public struct s_hr_employee_loan_installment
    {
        public int loan_id, ins_period, ins_month, ins_year;
        public string ins_month_name;
        public Boolean paid_sts;

        public s_hr_employee_loan_installment(
            int _loan_id, int _ins_period, int _ins_month, int _ins_year,
            string _ins_month_name,
            Boolean _paid_sts
            )
        {
            loan_id = _loan_id;
            ins_period = _ins_period;
            ins_month = _ins_month;
            ins_year = _ins_year;
            paid_sts = _paid_sts;
            ins_month_name = _ins_month_name;
        }
    }

    public struct s_hr_employee_loan
    {
        public int loan_id, employee_id, tenor, loan_start_month, loan_start_year, wageparam_id;
        public double loan_amount, installment;
        public string loan_date, note, loan_no, loan_start_month_name, employee_name;
        public Boolean paidoff_sts, approve_sts;

        public s_hr_employee_loan(
            int _loan_id, int _employee_id, int _tenor, int _loan_start_month, int _loan_start_year,
            double _loan_amount, double _installment,
            string _loan_date, string _note, string _loan_no, string _loan_start_month_name, string _employee_name,
            Boolean _paidoff_sts, Boolean _approve_sts,
            int _wageparam_id)
        {
            loan_id = _loan_id;
            employee_id = _employee_id;
            tenor = _tenor;
            loan_start_month = _loan_start_month;
            loan_start_year = _loan_start_year;
            loan_amount = _loan_amount;
            installment = _installment;
            loan_date = _loan_date;
            note = _note;
            loan_no = _loan_no;
            loan_start_month_name = _loan_start_month_name;
            employee_name = _employee_name;
            paidoff_sts = _paidoff_sts;
            approve_sts = _approve_sts;
            wageparam_id = _wageparam_id;
        }
    }
    public struct s_hr_salary_employee_wageparam
    {
        public double salary_employee_wageparam_id;
        public int salary_employee_id, wageparam_id, employee_id, total;
        public double nilai, total_nilai;
        public Boolean tetap_sts, delete_restrict_sts;
        public string employee_name, salary_name, wageparam_name, type_id, type_name, note;

        public s_hr_salary_employee_wageparam(
            int _salary_employee_wageparam_id, int _salary_employee_id, int _wageparam_id, int _employee_id, int _total,
            double _nilai, double _total_nilai,
            Boolean _tetap_sts, Boolean _delete_restrict_sts,
            string _employee_name, string _salary_name, string _wageparam_name, string _type_id, string _type_name, string _note = ""
        )
        {
            salary_employee_wageparam_id = _salary_employee_wageparam_id;
            salary_employee_id = _salary_employee_id;
            wageparam_id = _wageparam_id;
            employee_id = _employee_id;
            total = _total;
            nilai = _nilai;
            total_nilai = _total_nilai;
            tetap_sts = _tetap_sts;
            employee_name = _employee_name;
            salary_name = _salary_name;
            wageparam_name = _wageparam_name;
            type_id = _type_id;
            type_name = _type_name;
            delete_restrict_sts = _delete_restrict_sts;
            note = _note;
        }
    }
    public struct s_hr_salary_employee
    {
        public int salary_employee_id, salary_id, employee_id;
        public string employee_name, salary_date;
        public double total_salary;

        public s_hr_salary_employee(
            int _salary_employee_id, int _salary_id, int _employee_id,
            string _employee_name, string _salary_date,
            double _total_salary
        )
        {
            salary_employee_id = _salary_employee_id;
            salary_id = _salary_id;
            employee_id = _employee_id;
            employee_name = _employee_name;
            salary_date = _salary_date;
            total_salary = _total_salary;
        }
    }
    public struct s_hr_salary
    {
        public int salary_id, month_issue, year_issue;
        public string salary_name, salary_date, month_name;

        public s_hr_salary(
            int _salary_id, int _month_issue, int _year_issue,
            string _salary_name, string _salary_date, string _month_name
        )
        {
            salary_id = _salary_id;
            salary_name = _salary_name;
            month_issue = _month_issue;
            year_issue = _year_issue;
            salary_date = _salary_date;
            month_name = _month_name;
        }
    }
    public struct s_hr_employee_wageparam
    {
        public int employeewageparam_id, employee_id, wageparam_id;
        public double nilai;
        public string employee_name, wageparam_name, type_id, type_name;
        public Boolean open_multiplier_sts;

        public s_hr_employee_wageparam(
            int _employeewageparam_id, int _employee_id, int _wageparam_id,
            double _nilai,
            string _employee_name, string _wageparam_name, string _type_id, string _type_name,
            Boolean _open_multiplier_sts = false
        )
        {
            employeewageparam_id = _employeewageparam_id;
            employee_id = _employee_id;
            wageparam_id = _wageparam_id;
            nilai = _nilai;
            employee_name = _employee_name;
            wageparam_name = _wageparam_name;
            type_id = _type_id;
            type_name = _type_name;
            open_multiplier_sts = _open_multiplier_sts;
        }

    }

    public struct s_hr_wageparam
    {
        public int wageparam_id;
        public string wageparam_name, type_id, type_name;

        public s_hr_wageparam(int _wageparam_id, string _wageparam_name, string _type_id, string _type_name)
        {
            wageparam_id = _wageparam_id;
            wageparam_name = _wageparam_name;
            type_id = _type_id;
            type_name = _type_name;
        }
    }
    public struct s_hr_employee
    {
        public int employee_id, position_id;
        public string nik, employee_name, date_in, date_out, position_name;
        public Boolean status;

        public s_hr_employee(
            int _employee_id, int _position_id,
            string _nik, string _employee_name, string _date_in, string _date_out, string _position_name,
            Boolean _status)
        {
            employee_id = _employee_id;
            position_id = _position_id;
            nik = _nik;
            employee_name = _employee_name;
            date_in = _date_in;
            date_out = _date_out;
            position_name = _position_name;
            status = _status;
        }
    }
    public struct s_hr_position
    {
        public int position_id;
        public string position_name;

        public s_hr_position(int _position_id, string _position_name)
        {
            position_id = _position_id;
            position_name = _position_name;
        }
    }
    public struct s_opr_vendor_category_merk
    {
        public int vendor_id, vendor_category_id, merk_id;
        public string vendor_name, vendor_category_name, merk_name;

        public s_opr_vendor_category_merk(int _vendor_id, int _vendor_category_id, int _merk_id, string _vendor_name, string _vendor_category_name, string _merk_name)
        {
            vendor_id = _vendor_id;
            vendor_category_id = _vendor_category_id;
            merk_id = _merk_id;
            vendor_name = _vendor_name;
            vendor_category_name = _vendor_category_name;
            merk_name = _merk_name;
        }
    }
    public struct s_opr_vendor_category
    {
        public int vendor_id, vendor_category_id;
        public string vendor_name, vendor_category_name;

        public s_opr_vendor_category(int _vendor_id, int _vendor_category_id, string _vendor_name, string _vendor_category_name)
        {
            vendor_id = _vendor_id;
            vendor_category_id = _vendor_category_id;
            vendor_name = _vendor_name;
            vendor_category_name = _vendor_category_name;
        }
    }

    public struct s_par_merk
    {
        public int merk_id;
        public string merk_name;

        public s_par_merk(int _merk_id, string _merk_name)
        {
            merk_id = _merk_id;
            merk_name = _merk_name;
        }
    }
    public struct s_par_vendor_category
    {
        public int vendor_category_id;
        public string vendor_category_name;

        public s_par_vendor_category(int _vendor_category_id, string _vendor_category_name)
        {
            vendor_category_id = _vendor_category_id;
            vendor_category_name = _vendor_category_name;
        }
    }

    public struct s_act_marketing_group
    {
        public int marketing_group_id;
        public string marketing_group_name;
        public double target_value;

        public s_act_marketing_group(int _marketing_group_id, string _marketing_group_name, double _target_value)
        {
            marketing_group_id = _marketing_group_id;
            marketing_group_name = _marketing_group_name;
            target_value = _target_value;
        }
    }
    public struct s_fin_receivable_payment_reverse
    {
        public double fin_receivable_payment_reverse_id, fin_receivable_payment_id, journal_transaction_id, pph_amount, receivable_amount;
        public string reverse_date, customer_name, invoice_no;

        public s_fin_receivable_payment_reverse(
            double _fin_receivable_payment_reverse_id, double _fin_receivable_payment_id, double _journal_transaction_id, double _pph_amount, double _receivable_amount,
            string _reverse_date, string _customer_name, string _invoice_no
            )
        {
            fin_receivable_payment_reverse_id = _fin_receivable_payment_reverse_id;
            fin_receivable_payment_id = _fin_receivable_payment_id;
            journal_transaction_id = _journal_transaction_id;
            pph_amount = _pph_amount;
            receivable_amount = _receivable_amount;
            reverse_date = _reverse_date;
            customer_name = _customer_name;
            invoice_no = _invoice_no;
        }
    }
    public struct s_fin_receivable_payment
    {
        public double fin_receivable_payment_id, fin_receivable_id, journal_transaction_id, pph_amount, receivable_amount, fin_receivable_payment_reverse_id;
        public string payment_date, payment_receivable_status_id, type_transaction, customer_name, invoice_no, reverse_date;
        public Boolean reverse_sign_sts;

        public s_fin_receivable_payment(
            double _fin_receivable_payment_id, double _fin_receivable_id, double _journal_transaction_id, double _pph_amount, double _receivable_amount, double _fin_receivable_payment_reverse_id,
            string _payment_date, string _payment_receivable_status_id, string _type_transaction, string _customer_name, string _invoice_no, string _reverse_date,
            Boolean _reverse_sign_sts)
        {
            fin_receivable_payment_id = _fin_receivable_payment_id;
            fin_receivable_id = _fin_receivable_id;
            journal_transaction_id = _journal_transaction_id;
            pph_amount = _pph_amount;
            receivable_amount = _receivable_amount;
            payment_date = _payment_date;
            payment_receivable_status_id = _payment_receivable_status_id;
            type_transaction = _type_transaction;
            customer_name = _customer_name;
            invoice_no = _invoice_no;
            reverse_sign_sts = _reverse_sign_sts;
            fin_receivable_payment_reverse_id = _fin_receivable_payment_reverse_id;
            reverse_date = _reverse_date;
        }
    }
    public struct s_acc_journal_transaction_detail
    {
        public double journal_transaction_id, coa_id, amount, coa_type_id;
        public string dbcr_id, coa_code, coa_name, coa_type_name;

        public s_acc_journal_transaction_detail(double _journal_transaction_id, double _coa_id, double _amount, double _coa_type_id,
            string _dbcr_id, string _coa_code, string _coa_name, string _coa_type_name)
        {
            journal_transaction_id = _journal_transaction_id;
            coa_id = _coa_id;
            amount = _amount;
            coa_type_id = _coa_type_id;
            dbcr_id = _dbcr_id;
            coa_code = _coa_code;
            coa_name = _coa_name;
            coa_type_name = _coa_type_name;
        }
    }
    public struct s_fin_receivable_reverse
    {
        public double fin_receivable_reverse_id, fin_receivable_id, journal_transaction_id, pph_amount, receivable_amount;
        public string transaction_date, transaction_type, invoice_no, customer_name, journal_function_code;

        public s_fin_receivable_reverse(double _fin_receivable_reverse_id, double _fin_receivable_id, double _journal_transaction_id, double _pph_amount, double _receivable_amount,
            string _transaction_date, string _transaction_type, string _invoice_no, string _customer_name, string _journal_function_code)
        {
            fin_receivable_reverse_id = _fin_receivable_reverse_id;
            fin_receivable_id = _fin_receivable_id;
            journal_transaction_id = _journal_transaction_id;
            pph_amount = _pph_amount;
            receivable_amount = _receivable_amount;

            transaction_date = _transaction_date;
            transaction_type = _transaction_type;
            invoice_no = _invoice_no;
            customer_name = _customer_name;
            journal_function_code = _journal_function_code;
        }
    }
    public struct s_fin_receivable
    {
        public double fin_receivable_id, pph_amount, receivable_amount, journal_transaction_id, invoice_salesservice_id;
        public string transaction_date, journal_function_code, journal_function_name, type_transaction, invoice_no, customer_name, reverse_date, payment_date, receivable_status_id, receivable_status;
        public Boolean reverse_sign_sts;

        public s_fin_receivable(
            double _fin_receivable_id, double _pph_amount, double _receivable_amount, double _journal_transaction_id, double _invoice_salesservice_id,
            string _transaction_date, string _journal_function_code, string _journal_function_name, string _type_transaction, string _invoice_no,
            string _customer_name,
            Boolean _reverse_sign_sts = false,
            string _reverse_date = "",
            string _payment_date = "", string _receivable_status_id = "", string _receivable_status = ""
            )
        {
            fin_receivable_id = _fin_receivable_id;
            pph_amount = _pph_amount;
            receivable_amount = _receivable_amount;
            journal_transaction_id = _journal_transaction_id;
            invoice_salesservice_id = _invoice_salesservice_id;
            transaction_date = _transaction_date;
            journal_function_code = _journal_function_code;
            journal_function_name = _journal_function_name;
            type_transaction = _type_transaction;
            invoice_no = _invoice_no;
            customer_name = _customer_name;
            reverse_sign_sts = _reverse_sign_sts;
            reverse_date = _reverse_date;
            payment_date = _payment_date;
            receivable_status_id = _receivable_status_id;
            receivable_status = _receivable_status;
        }
    }
    public struct s_acc_journal_function_detail
    {
        public string journal_function_code, journal_function_detail_code, journal_function_detail_name, dbcr_id, coa_name, dbcr_name;
        public int coa_id;

        public s_acc_journal_function_detail(string _journal_function_code, string _journal_function_detail_code, string _journal_function_detail_name, string _dbcr_id, string _coa_name, string _dbcr_name, int _coa_id)
        {
            journal_function_code = _journal_function_code;
            journal_function_detail_code = _journal_function_detail_code;
            journal_function_detail_name = _journal_function_detail_name;
            dbcr_id = _dbcr_id;
            coa_id = _coa_id;
            coa_name = _coa_name;
            dbcr_name = _dbcr_name;
        }
    }
    public struct s_acc_journal_function
    {
        public string journal_function_code, journal_function_name;
        public s_acc_journal_function(string _journal_function_code, string _journal_function_name)
        {
            journal_function_code = _journal_function_code;
            journal_function_name = _journal_function_name;
        }
    }
    public struct s_acc_coa
    {
        public int coa_id, coa_type_id, parent_coa_id;
        public string coa_code, coa_name, coa_type_name, parent_coa_name;

        public s_acc_coa(int _coa_id, int _coa_type_id, int _parent_coa_id, string _coa_code, string _coa_name, string _coa_type_name, string _parent_coa_name)
        {
            coa_id = _coa_id;
            coa_type_id = _coa_type_id;
            parent_coa_id = _parent_coa_id;
            coa_code = _coa_code;
            coa_name = _coa_name;
            coa_type_name = _coa_type_name;
            parent_coa_name = _parent_coa_name;
        }
    }
    public struct s_acc_coa_type
    {
        public int coa_type_id;
        public string coa_type_name;

        public s_acc_coa_type(int _coa_type_id, string _coa_type_name)
        {
            coa_type_id = _coa_type_id;
            coa_type_name = _coa_type_name;
        }
    }
    public struct s_app_parameter_user
    {
        public string code, type_id, description, parameter_type;
        public Boolean active;

        public s_app_parameter_user(string _code, string _type_id, string _description, string _parameter_type, Boolean _active)
        {
            code = _code;
            type_id = _type_id;
            description = _description;
            active = _active;
            parameter_type = _parameter_type;
        }
    }
    public struct s_par_principal_price_dtl
    {
        public int param_pp_id;
        public double param_pp_dtl_id, range1, range2;
        public float pcg;

        public s_par_principal_price_dtl(int _param_pp_id, double _param_pp_dtl_id, double _range1, double _range2, float _pcg)
        {
            param_pp_dtl_id = _param_pp_dtl_id;
            param_pp_id = _param_pp_id;
            range1 = _range1;
            range2 = _range2;
            pcg = _pcg;
        }
    }
    public struct s_par_principal_price
    {
        public int param_pp_id, par_principal_price_type_id;
        public string description, active_date, deactive_date;
        public Boolean active_sts;

        public s_par_principal_price(int _param_pp_id, int _par_principal_price_type_id,
            string _description, string _active_date, string _deactive_date, Boolean _active_sts)
        {
            param_pp_id = _param_pp_id;
            par_principal_price_type_id = _par_principal_price_type_id;
            description = _description;
            active_date = _active_date;
            deactive_date = _deactive_date;
            active_sts = _active_sts;

        }
    }

    public struct s_fin_petty_cash_transaction_hdr
    {
        public int petty_cash_transaction_hdr_id, petty_cash_name_id;
        public double begin_saldo, end_saldo;
        public string begin_date, close_date, petty_cash_name;
        public Boolean done_sts, approve_sts;

        public s_fin_petty_cash_transaction_hdr(
            int _petty_cash_transaction_hdr_id, int _petty_cash_name_id,
            double _begin_saldo, double _end_saldo, string _begin_date, string _close_date, string _petty_cash_name,
            Boolean _done_sts, Boolean _approve_sts
        )
        {
            petty_cash_transaction_hdr_id = _petty_cash_transaction_hdr_id;
            petty_cash_name_id = _petty_cash_name_id;
            begin_saldo = _begin_saldo;
            end_saldo = _end_saldo;
            begin_date = _begin_date;
            close_date = _close_date;
            petty_cash_name = _petty_cash_name;
            done_sts = _done_sts;
            approve_sts = _approve_sts;
        }
    }
    public struct s_fin_petty_cash_transaction_dtl
    {
        public int petty_cash_transaction_dtl_id, petty_cash_transaction_hdr_id, petty_cash_category_id, petty_cash_name_id, default_hdr_id;
        public string petty_cash_category, transaction_type_id, note, transaction_date, type_id, petty_cash_name;
        public double amount;
        public Boolean claim_sts, show_sts;

        public s_fin_petty_cash_transaction_dtl(
            int _petty_cash_transaction_dtl_id, int _petty_cash_transaction_hdr_id, int _petty_cash_category_id,
            string _petty_cash_category, string _transaction_type_id, string _note, string _transaction_date,
            double _amount, string _type_id,
            int _petty_cash_name_id = 0, string _petty_cash_name = "", int _default_hdr_id = 0,
            Boolean _claim_sts = false, Boolean _show_sts = false
            )
        {
            petty_cash_transaction_dtl_id = _petty_cash_transaction_dtl_id;
            petty_cash_transaction_hdr_id = _petty_cash_transaction_hdr_id;
            petty_cash_category_id = _petty_cash_category_id;
            petty_cash_category = _petty_cash_category;
            transaction_type_id = _transaction_type_id;
            note = _note;
            amount = _amount;
            transaction_date = _transaction_date;
            type_id = _type_id;
            petty_cash_name_id = _petty_cash_name_id;
            petty_cash_name = _petty_cash_name;
            default_hdr_id = _default_hdr_id;
            claim_sts = _claim_sts;
            show_sts = _show_sts;
        }
    }

    public struct s_fin_petty_cash_transaction_init
    {
        public int petty_cash_transaction_hdr_id;
        public string begin_date, end_date;
        public double begin_saldo, end_saldo;
        public Boolean open_sts, close_sts;

        public s_fin_petty_cash_transaction_init(int _petty_cash_transaction_hdr_id, string _begin_date, string _end_date, double _begin_saldo, double _end_saldo, Boolean _open_sts, Boolean _close_sts)
        {
            petty_cash_transaction_hdr_id = _petty_cash_transaction_hdr_id;
            begin_date = _begin_date;
            begin_saldo = _begin_saldo;
            open_sts = _open_sts;
            end_date = _end_date;
            end_saldo = _end_saldo;
            close_sts = _close_sts;
        }
    }
    public struct s_fin_petty_cash_category
    {
        public int petty_cash_category_id;
        public string petty_cash_category, transaction_type_id, transaction_type;
        public Boolean show_sts;

        public s_fin_petty_cash_category(int _petty_cash_category_id, string _petty_cash_category, string _transaction_type_id, string _transaction_type, Boolean _show_sts = true)
        {
            petty_cash_category_id = _petty_cash_category_id;
            petty_cash_category = _petty_cash_category;
            transaction_type_id = _transaction_type_id;
            transaction_type = _transaction_type;
            show_sts = _show_sts;
        }
    }
    public struct s_fin_petty_cash_name
    {
        public int petty_cash_name_id, branch_id;
        public string petty_cash_name, branch_name;

        public s_fin_petty_cash_name(int _petty_cash_name_id, int _branch_id, string _petty_cash_name, string _branch_name)
        {
            petty_cash_name_id = _petty_cash_name_id;
            branch_id = _branch_id;
            petty_cash_name = _petty_cash_name;
            branch_name = _branch_name;
        }
    }
    public struct s_trimming_status
    {
        public double trimming_id;
        public string trimming_name;
        public Boolean status;

        public s_trimming_status(int _trimming_id, string _trimming_name, Boolean _status)
        {
            trimming_id = _trimming_id;
            trimming_name = _trimming_name;
            status = _status;
        }
    }
    public struct s_borrow_service_device
    {
        public double borrow_service_id, inventory_device_id, device_type_id;
        public string device, sn, device_type;
        public Boolean borrow_sts;

        public s_borrow_service_device(double _borrow_service_id, double _inventory_device_id,
            string _device, string _sn, Boolean _borrow_sts, double _device_type_id, string _device_type)
        {
            borrow_service_id = _borrow_service_id;
            inventory_device_id = _inventory_device_id;
            device = _device;
            sn = _sn;
            borrow_sts = _borrow_sts;
            device_type_id = _device_type_id;
            device_type = _device_type;
        }
    }
    public struct s_tec_borrow_service
    {
        public double borrow_service_id, service_id;
        public string borrow_date, return_date, note, receiver, marketing_note, customer_name, marketing_id;
        public Boolean borrow_sts;

        public s_tec_borrow_service(double _borrow_service_id, double _service_id,
            string _borrow_date, string _return_date, string _note, string _receiver, string _marketing_note, string _customer_name, string _marketing_id,
            Boolean _borrow_sts)
        {
            borrow_service_id = _borrow_service_id;
            service_id = _service_id;
            borrow_date = _borrow_date;
            return_date = _return_date;
            note = _note;
            receiver = _receiver;
            marketing_note = _marketing_note;
            customer_name = _customer_name;
            marketing_id = _marketing_id;
            borrow_sts = _borrow_sts;
        }
    }
    public struct s_fin_transaction_vendor
    {
        public int transaction_vendor_id, vendor_id, bill_id, branch_id, broker_id;
        public string invoice_no, transaction_date, transaction_type_id, note, transaction_type, vendor_name, branch_name, broker_name;
        public double amount;
        public float ppn;
        public Boolean paid_sts;

        public s_fin_transaction_vendor(int _transaction_vendor_id, int _vendor_id,
            string _invoice_no, string _transaction_date, string _transaction_type_id, string _note,
            double _amount, Boolean _paid_sts, string _transaction_type = "", string _vendor_name = "",
            int _bill_id = 0, float _ppn = 0,
            int _branch_id = 0, int _broker_id = 0, string _branch_name = "", string _broker_name = "")
        {
            transaction_vendor_id = _transaction_vendor_id;
            vendor_id = _vendor_id;
            invoice_no = _invoice_no;
            transaction_date = _transaction_date;
            transaction_type_id = _transaction_type_id;
            note = _note;
            amount = _amount;
            paid_sts = _paid_sts;
            transaction_type = _transaction_type;
            vendor_name = _vendor_name;
            bill_id = _bill_id;
            ppn = _ppn;
            branch_id = _branch_id;
            broker_id = _broker_id;
            branch_name = _branch_name;
            broker_name = _broker_name;
        }
    }
    public struct s_fin_claim_debt
    {
        public int servicesales_id, result_id;
        public string contact, note, fin_type_id, call_date, result;

        public s_fin_claim_debt(int _servicesales_id, int _result_id, string _contact, string _note, string _fin_type_id, string _call_date, string _result)
        {
            servicesales_id = _servicesales_id;
            contact = _contact;
            note = _note;
            result_id = _result_id;
            fin_type_id = _fin_type_id;
            call_date = _call_date;
            result = _result;
        }
    }
    public struct s_fin_result
    {
        public int result_id;
        public string result;

        public s_fin_result(int _result_id, string _result)
        {
            result_id = _result_id;
            result = _result;
        }
    }
    public struct s_chart_dataset
    {
        public string label;
        public double[] data;

        public s_chart_dataset(string _label, double[] _data)
        {
            label = _label;
            data = _data;
        }
    }
    public struct s_chart_data
    {
        public string[] labels;
        public s_chart_dataset[] datasets;

    }
    public struct s_par_branch
    {
        public int branch_id, location_id;
        public string branch_name, address, location_address, phone, fax;
        public Boolean active_sts;

        public s_par_branch(int _branch_id, int _location_id, string _branch_name, string _address, Boolean _active_sts, string _location_address = "", string _phone = "", string _fax = "")
        {
            branch_id = _branch_id;
            location_id = _location_id;
            branch_name = _branch_name;
            address = _address;
            active_sts = _active_sts;
            location_address = _location_address;
            phone = _phone;
            fax = _fax;
        }
    }
    public struct s_exp_schedule_map_detail
    {
        public string note_ambil, note_kirim;
        public int messanger_id;
        public s_exp_schedule_map_detail(string _note_ambil, string _note_kirim, int _messanger_id)
        {
            note_ambil = _note_ambil;
            note_kirim = _note_kirim;
            messanger_id = _messanger_id;
        }
    }
    public struct s_xml_exp_schedule_map
    {
        public int address_id, schedule_id, messanger_id;
        public string customer_name, latitude, longitude, messanger_name, address_location, address;

        public s_xml_exp_schedule_map(int _address_id, string _customer_name, string _latitude, string _longitude, string _messanger_name = "", string _address_location = "", string _address = "", int _schedule_id = 0, int _messanger_id = 0)
        {
            address_id = _address_id;
            customer_name = _customer_name;
            latitude = _latitude;
            longitude = _longitude;
            messanger_name = _messanger_name;
            address_location = _address_location;
            address = _address;
            schedule_id = _schedule_id;
            messanger_id = _messanger_id;
        }
    }
    public struct s_fin_coa
    {
        public int coa_id;
        public string coa_code, coa_name, ticket_type_id, ticket_type, financial_transaction_type_id, financial_transaction_type;

        public s_fin_coa(int _coa_id, string _coa_code, string _coa_name, string _ticket_type_id, string _ticket_type, string _financial_transaction_type_id, string _financial_transaction_type)
        {
            coa_id = _coa_id;
            coa_code = _coa_code;
            coa_name = _coa_name;
            ticket_type_id = _ticket_type_id;
            ticket_type = _ticket_type;
            financial_transaction_type_id = _financial_transaction_type_id;
            financial_transaction_type = _financial_transaction_type;
        }
    }
    public struct s_exp_schedule_borrow_inventory_device
    {
        public int borrow_id, inventory_device_id;
        public string sn, device;

        public s_exp_schedule_borrow_inventory_device(int _borrow_id, int _inventory_device_id, string _sn, string _device)
        {
            borrow_id = _borrow_id;
            inventory_device_id = _inventory_device_id;
            sn = _sn;
            device = _device;
        }
    }
    public struct s_exp_schedule_borrow
    {
        public int borrow_id, schedule_id, customer_id;
        public string borrow_end_date, address_location, address, customer_name, borrow_note, borrowed_for_id, borrowed_for, borrow_sts_id, borrow_sts, code;

        public s_exp_schedule_borrow(int _borrow_id, int _schedule_id, int _customer_id, string _borrow_end_date, string _address_location, string _address, string _customer_name,
            string _borrow_note, string _borrowed_for_id, string _borrowed_for,
            string _borrow_sts_id, string _borrow_sts, string _code)
        {
            borrow_id = _borrow_id;
            schedule_id = _schedule_id;
            customer_id = _customer_id;
            borrow_end_date = _borrow_end_date;
            address_location = _address_location;
            address = _address;
            customer_name = _customer_name;
            borrow_note = _borrow_note;
            borrowed_for_id = _borrowed_for_id;
            borrowed_for = _borrowed_for;
            borrow_sts_id = _borrow_sts_id;
            borrow_sts = _borrow_sts;
            code = _code;
        }
    }
    public struct s_tec_inventory_device
    {
        public int inventory_device_id, inventory_id, device_register_id, device_id;
        public string sn, device;

        public s_tec_inventory_device(int _inventory_device_id, int _inventory_id, int _device_register_id, int _device_id, string _sn, string _device)
        {
            inventory_device_id = _inventory_device_id;
            inventory_id = _inventory_id;
            device_register_id = _device_register_id;
            sn = _sn;
            device = _device;
            device_id = _device_id;
        }
    }
    public struct s_tec_inventory
    {
        public int inventory_id, vendor_id;
        public string inventory_in, inventory_out, inventory_type_id, invoice_no, vendor_name, inventory_type;
        public Boolean inventory_sts, access_service_data_sts;

        public s_tec_inventory(int _inventory_id, int _vendor_id,
            string _inventory_in, string _inventory_out, string _inventory_type_id, string _invoice_no, string _vendor_name, string _inventory_type,
            Boolean _inventory_sts, Boolean _access_service_data_sts = false
            )
        {
            inventory_id = _inventory_id;
            vendor_id = _vendor_id;
            inventory_in = _inventory_in;
            inventory_out = _inventory_out;
            inventory_type_id = _inventory_type_id;
            invoice_no = _invoice_no;
            vendor_name = _vendor_name;
            inventory_type = _inventory_type;
            inventory_sts = _inventory_sts;
            access_service_data_sts = _access_service_data_sts;
        }
    }
    public struct s_schedule_sales
    {
        public int schedule_id, sales_id, delivery_address_location_id, kode_print;
        public string delivery_address, delivery_address_location, marketing_id, customer_name;

        public s_schedule_sales(int _schedule_id, int _sales_id, int _delivery_address_location_id,
            string _delivery_address, string _delivery_address_location, string _marketing_id, string _customer_name,
            int _kode_print = 0)
        {
            schedule_id = _schedule_id;
            sales_id = _sales_id;
            delivery_address_location_id = _delivery_address_location_id;
            delivery_address = _delivery_address;
            delivery_address_location = _delivery_address_location;
            marketing_id = _marketing_id;
            customer_name = _customer_name;
            kode_print = _kode_print;
        }


    }
    public struct s_fin_sales_opr
    {
        public double sales_id, grand_price, fee;
        public string offer_no, offer_date;

        public s_fin_sales_opr(double _sales_id, double _grand_price, double _fee, string _offer_no, string _offer_date)
        {
            sales_id = _sales_id;
            grand_price = _grand_price;
            fee = _fee;
            offer_no = _offer_no;
            offer_date = _offer_date;
        }
    }
    public struct s_fin_sales
    {
        public double invoice_sales_id, customer_id, an_id, grand_price, fee, bill_id, surat_jalan_id, fee_payment, amount_cut, total_ppn, fin_receivable_id;
        public string invoice_date, invoice_no, term_of_payment_id, term_of_payment, po_no, afpo_no, customer_name, str_top_value, paid_date, invoice_note, document_return_date, fee_date, document_return_date_exp, bill_name, bill_no;
        public Boolean paid_sts, send_sts, invoice_sts, pph_sts, document_return_sts;

        public s_fin_sales(double _invoice_sales_id, string _invoice_date, string _invoice_no, string _term_of_payment_id, string _term_of_payment, string _po_no, string _afpo_no,
            double _customer_id, double _an_id, double _grand_price, double _fee, string _customer_name, string _str_top_value, double _bill_id,
            Boolean _paid_sts, string _paid_date,
            Boolean _send_sts = false, Boolean _invoice_sts = false,
            int _surat_jalan_id = 0, string _invoice_note = "",
            Boolean _pph_sts = false, Boolean _document_return_sts = false,
            string _document_return_date = "",
            double _fee_payment = 0,
            string _fee_date = "", string _document_return_date_exp = "",
            double _amount_cut = 0,
            double _total_ppn = 0,
            double _fin_receivable_id = 0,
            string _bill_name = "", string _bill_no = ""
        )
        {
            invoice_sales_id = _invoice_sales_id;
            invoice_date = _invoice_date;
            invoice_no = _invoice_no;
            term_of_payment_id = _term_of_payment_id;
            term_of_payment = _term_of_payment;
            po_no = _po_no;
            afpo_no = _afpo_no;
            customer_id = _customer_id;
            an_id = _an_id;
            grand_price = _grand_price;
            fee = _fee;
            customer_name = _customer_name;
            str_top_value = _str_top_value;
            bill_id = _bill_id;
            paid_sts = _paid_sts;
            paid_date = _paid_date;
            send_sts = _send_sts;
            invoice_sts = _invoice_sts;
            surat_jalan_id = _surat_jalan_id;
            invoice_note = _invoice_note;
            pph_sts = _pph_sts;
            document_return_sts = _document_return_sts;
            document_return_date = _document_return_date;
            fee_payment = _fee_payment;
            fee_date = _fee_date;
            document_return_date_exp = _document_return_date_exp;
            amount_cut = _amount_cut;
            total_ppn = _total_ppn;
            fin_receivable_id = _fin_receivable_id;
            bill_name = _bill_name;
            bill_no = _bill_no;
        }
    }
    public struct s_sales_device
    {
        public double sales_id, device_id, cost, price, qty, vendor_id, principal_price, price_customer;
        public string device, description, vendor_name, marketing_note, creator_id, create_date, update_id, update_date;
        public Boolean pph21_sts, draft_sts;
        public string guarantee_id, guarantee_timetype_id, guarantee_timetype_name, availability_id, availability_timetype_id, availability_timetype_name;
        public int inden, guarantee_period;

        public s_sales_device(double _sales_id, double _device_id, double _cost, double _price, string _device, Boolean _pph21_sts, int _qty,
            string _description = "",
            double _vendor_id = 0, string _vendor_name = "",
            double _principal_price = 0,
            double _price_customer = 0,
            string _marketing_note = "",
            string _creator_id = "", string _create_date = "", string _update_id = "", string _update_date = "",
            Boolean _draft_sts = false,
            string _guarantee_id = "", string _availability_id = "", int _inden = 0, int _guarantee_period = 0,
            string _guarantee_timetype_id = "", string _guarantee_timetype_name = "", string _availability_timetype_id = "", string _availability_timetype_name = ""
            )
        {
            sales_id = _sales_id;
            device_id = _device_id;
            cost = _cost;
            price = _price;
            device = _device;
            pph21_sts = _pph21_sts;
            qty = _qty;
            description = _description;
            vendor_id = _vendor_id;
            vendor_name = _vendor_name;
            principal_price = _principal_price;
            price_customer = _price_customer;
            marketing_note = _marketing_note;
            creator_id = _creator_id;
            create_date = _create_date;
            update_id = _update_id;
            update_date = _update_date;
            draft_sts = _draft_sts;
            guarantee_id = _guarantee_id;
            availability_id = _availability_id;
            inden = _inden;
            guarantee_period = _guarantee_period;
            guarantee_timetype_id = _guarantee_timetype_id;
            guarantee_timetype_name = _guarantee_timetype_name;
            availability_timetype_id = _availability_timetype_id;
            availability_timetype_name = _availability_timetype_name;
        }
    }
    public struct s_trimming
    {
        public int trimming_id;
        public string trimming_name;

        public s_trimming(int _trimming_id, string _trimming_name)
        {
            trimming_id = _trimming_id;
            trimming_name = _trimming_name;
        }
    }
    public struct s_opr_sales
    {
        public double sales_id, broker_id, discount_value, fee, customer_id, group_customer_id;
        public string offer_date, discount_type_id, opr_note, broker_name, discount_type, customer_name, offer_no, sales_status_id, sales_status_marketing_id,
            sales_status, sales_status_marketing, invoice_no, update_status_date, reason_marketing_id, reason_marketing, additional_fee_note, sales_status_marketing_updatedate;
        public Boolean tax_sts, npwp_sts;
        public long ppn, pph21, total_price, total_cost, total_price_pph21, total_ppn, total_pph21, total_discount, net, grand_price, additional_fee, total_principal, principal_net;
        public float pcg_principal_price;
        public long additional_cost;
        public string po_no, ctgsales_id, ctgsales;

        public s_opr_sales(double _sales_id, double _broker_id, double _discount_value, double _fee,
            string _offer_date, string _discount_type_id, string _opr_note, string _broker_name, string _discount_type, string _customer_name, string _offer_no,
            string _sales_status_id, string _sales_status_marketing_id, string _sales_status, string _sales_status_marketing,
            Boolean _tax_sts, int _customer_id,
            long _ppn = 0, long _pph21 = 0, long _total_price = 0, long _total_cost = 0, long _total_price_pph21 = 0, long _total_ppn = 0, long _total_pph21 = 0, long _total_discount = 0, long _net = 0, long _grand_price = 0,
            double _group_customer_id = 0, Boolean _npwp_sts = false,
            string _invoice_no = "",
            float _pcg_principal_price = 0,
            string _update_status_date = "", string _reason_marketing_id = "", string _reason_marketing = "",
            long _total_principal = 0, long _principal_net = 0,
            long _additional_fee = 0, string _additional_fee_note = "",
            string _sales_status_marketing_updatedate = "",
            long _additional_cost = 0,string _po_no = "",
            string _ctgsales_id = "", string _ctgsales = ""
            )
        {
            sales_id = _sales_id;
            broker_id = _broker_id;
            discount_value = _discount_value;
            fee = _fee;
            offer_date = _offer_date;
            discount_type_id = _discount_type_id;
            opr_note = _opr_note;
            broker_name = _broker_name;
            discount_type = _discount_type;
            customer_name = _customer_name;
            offer_no = _offer_no;
            sales_status_id = _sales_status_id;
            sales_status_marketing_id = _sales_status_marketing_id;
            sales_status = _sales_status;
            sales_status_marketing = _sales_status_marketing;
            tax_sts = _tax_sts;
            customer_id = _customer_id;
            ppn = _ppn;
            pph21 = _pph21;
            total_price = _total_price;
            total_cost = _total_cost;
            total_price_pph21 = _total_price_pph21;
            total_ppn = _total_ppn;
            total_pph21 = _total_pph21;
            total_discount = _total_discount;
            net = _net;
            grand_price = _grand_price;
            group_customer_id = _group_customer_id;
            npwp_sts = _npwp_sts;

            invoice_no = _invoice_no;
            pcg_principal_price = _pcg_principal_price;
            update_status_date = _update_status_date;
            reason_marketing_id = _reason_marketing_id;
            reason_marketing = _reason_marketing;

            total_principal = _total_principal;
            principal_net = _principal_net;
            additional_fee = _additional_fee;
            additional_fee_note = _additional_fee_note;

            sales_status_marketing_updatedate = _sales_status_marketing_updatedate;
            additional_cost = _additional_cost;
            po_no = _po_no;
            ctgsales = _ctgsales;
            ctgsales_id = _ctgsales_id;
        }
    }
    public struct s_fin_bill
    {
        public int bill_id;
        public string bill_name, bill_no, bill_bank_name;

        public s_fin_bill(int _bill_id, string _bill_name, string _bill_no, string _bill_bank_name)
        {
            bill_id = _bill_id;
            bill_name = _bill_name;
            bill_no = _bill_no;
            bill_bank_name = _bill_bank_name;
        }
    }
    public struct s_fin_service_opr
    {
        public double service_id, grand_price, fee;
        public string offer_no, offer_date;

        public s_fin_service_opr(double _service_id, double _grand_price, double _fee, string _offer_no, string _offer_date)
        {
            service_id = _service_id;
            grand_price = _grand_price;
            fee = _fee;
            offer_no = _offer_no;
            offer_date = _offer_date;
        }
    }
    public struct s_fin_service
    {
        public double invoice_service_id, customer_id, an_id, grand_price, fee, bill_id, surat_jalan_id, fee_payment, amount_cut;
        public string invoice_date, invoice_no, term_of_payment_id, term_of_payment, po_no, afpo_no, customer_name, str_top_value, paid_date, invoice_note, document_return_date, fee_date, document_return_date_exp, bill_name, bill_no;
        public Boolean paid_sts, send_sts, invoice_sts, pph_sts, document_return_sts;

        public s_fin_service(double _invoice_service_id, string _invoice_date, string _invoice_no, string _term_of_payment_id, string _term_of_payment, string _po_no, string _afpo_no,
            double _customer_id, double _an_id, double _grand_price, double _fee, string _customer_name, string _str_top_value, double _bill_id,
            Boolean _paid_sts, string _paid_date,
            Boolean _send_sts = false, Boolean _invoice_sts = false,
            int _surat_jalan_id = 0, string _invoice_note = "",
            Boolean _pph_sts = false, Boolean _document_return_sts = false,
            string _document_return_date = "",
            double _fee_payment = 0,
            string _fee_date = "", string _document_return_date_exp = "",
            double _amount_cut = 0,
            string _bill_name = "", string _bill_no = ""
        )
        {
            invoice_service_id = _invoice_service_id;
            invoice_date = _invoice_date;
            invoice_no = _invoice_no;
            term_of_payment_id = _term_of_payment_id;
            term_of_payment = _term_of_payment;
            po_no = _po_no;
            afpo_no = _afpo_no;
            customer_id = _customer_id;
            an_id = _an_id;
            grand_price = _grand_price;
            fee = _fee;
            customer_name = _customer_name;
            str_top_value = _str_top_value;
            bill_id = _bill_id;
            paid_sts = _paid_sts;
            paid_date = _paid_date;
            send_sts = _send_sts;
            invoice_sts = _invoice_sts;
            surat_jalan_id = _surat_jalan_id;
            invoice_note = _invoice_note;
            pph_sts = _pph_sts;
            document_return_sts = _document_return_sts;
            document_return_date = _document_return_date;
            fee_payment = _fee_payment;
            fee_date = _fee_date;
            document_return_date_exp = _document_return_date_exp;
            amount_cut = _amount_cut;
            bill_name = _bill_name;
            bill_no = _bill_no;
        }
    }
    public struct s_opr_service_device_component_price_history
    {
        public string customer_name, offer_date;
        public double price;

        public s_opr_service_device_component_price_history(string _customer_name, string _offer_date, double _price)
        {
            customer_name = _customer_name;
            offer_date = _offer_date;
            price = _price;
        }
    }
    public struct s_opr_service_device_component
    {
        public double service_id, service_device_id, device_id, price, total, cost, tec_total, price_customer;
        public string device;
        public Boolean pph21, real_data_sts;

        public s_opr_service_device_component(double _service_id, double _service_device_id, double _device_id, double _price, double _total,
            string _device, Boolean _pph21, Boolean _real_data_sts, double _cost = 0, double _tec_total = 0,
            double _price_customer = 0)
        {
            service_id = _service_id;
            service_device_id = _service_device_id;
            device_id = _device_id;
            price = _price;
            total = _total;
            cost = _cost;
            tec_total = _tec_total;
            device = _device;
            pph21 = _pph21;
            real_data_sts = _real_data_sts;
            price_customer = _price_customer;
        }
    }
    public struct s_opr_service_device
    {
        public double service_id, service_device_id, service_cost, total_price, total_cost, total_price_pph21, service_cancel, total_price_customer;
        public string sn, device, customer_name, user_name, service_device_sts;
        public Boolean guarantee_sts;

        public s_opr_service_device(double _service_id, double _service_device_id, double _service_cost, double _total_price, double _total_cost,
            string _sn, string _device, string _customer_name, double _total_price_pph21 = 0, double _service_cancel = 0, string _user_name = "",
            string _service_device_sts = "", Boolean _guarantee_sts = false,
            double _total_price_customer = 0)
        {
            service_id = _service_id;
            service_device_id = _service_device_id;
            service_cost = _service_cost;
            total_price = _total_price;
            total_cost = _total_cost;
            sn = _sn;
            device = _device;
            customer_name = _customer_name;
            total_price_pph21 = _total_price_pph21;
            service_cancel = _service_cancel;
            user_name = _user_name;
            service_device_sts = _service_device_sts;
            guarantee_sts = _guarantee_sts;
            total_price_customer = _total_price_customer;
        }
    }
    public struct s_opr_service
    {
        public double service_id, broker_id, discount_value, fee, customer_id;
        public string offer_date, discount_type_id, opr_note, broker_name, discount_type, customer_name, offer_no, service_status_id,
            service_status_marketing_id, service_status, service_status_marketing, update_status_date, service_status_marketing_updatedate;
        public Boolean tax_sts, npwp_sts;
        public double ppn, pph21, total_price, total_cost, total_price_pph21, total_ppn, total_pph21, total_discount, net, grand_price, additional_fee, total_addicost;
        public string invoice_no, reason_marketing_id, reason_marketing, additional_fee_note;

        public s_opr_service(double _service_id, double _broker_id, double _discount_value, double _fee,
            string _offer_date, string _discount_type_id, string _opr_note, string _broker_name, string _discount_type, string _customer_name, string _offer_no,
            string _service_status_id, string _service_status_marketing_id, string _service_status, string _service_status_marketing,
            Boolean _tax_sts, int _customer_id,
            double _ppn = 0, double _pph21 = 0, double _total_price = 0, double _total_cost = 0, double _total_price_pph21 = 0, double _total_ppn = 0, double _total_pph21 = 0, double _total_discount = 0, double _net = 0, double _grand_price = 0,
            string _invoice_no = null, Boolean _npwp_sts = false, string _update_status_date = "", string _reason_marketing_id = "", string _reason_marketing = "",
            double _additional_fee = 0, string _additional_fee_note = "",
            string _service_status_marketing_updatedate = "", double _total_addicost = 0)
        {
            service_id = _service_id;
            broker_id = _broker_id;
            discount_value = _discount_value;
            fee = _fee;
            offer_date = _offer_date;
            discount_type_id = _discount_type_id;
            opr_note = _opr_note;
            broker_name = _broker_name;
            discount_type = _discount_type;
            customer_name = _customer_name;
            offer_no = _offer_no;
            service_status_id = _service_status_id;
            service_status_marketing_id = _service_status_marketing_id;
            service_status = _service_status;
            service_status_marketing = _service_status_marketing;
            tax_sts = _tax_sts;
            customer_id = _customer_id;
            ppn = _ppn;
            pph21 = _pph21;
            total_price = _total_price;
            total_cost = _total_cost;
            total_price_pph21 = _total_price_pph21;
            total_ppn = _total_ppn;
            total_pph21 = _total_pph21;
            total_discount = _total_discount;
            net = _net;
            grand_price = _grand_price;
            invoice_no = _invoice_no;
            npwp_sts = _npwp_sts;
            update_status_date = _update_status_date;
            reason_marketing_id = _reason_marketing_id;
            reason_marketing = _reason_marketing;
            additional_fee = _additional_fee;
            additional_fee_note = _additional_fee_note;

            service_status_marketing_updatedate = _service_status_marketing_updatedate;
            total_addicost = _total_addicost;
        }
    }
    public struct s_opr_borker
    {
        public int broker_id, guaranti_term;
        public string broker_name, broker_address, title_1, title_2, title_3, initial;
        public Boolean par_tax_sts;

        public s_opr_borker(int _broker_id, string _broker_name, string _broker_address, string _title_1, string _title_2, string _title_3,
            string _initial = "", Boolean _par_tax_sts = true, int _guaranti_term = 0)
        {
            broker_id = _broker_id;
            broker_name = _broker_name;
            broker_address = _broker_address;
            title_1 = _title_1;
            title_2 = _title_2;
            title_3 = _title_3;
            initial = _initial;
            par_tax_sts = _par_tax_sts;
            guaranti_term = _guaranti_term;
        }
    }
    public struct s_service_device_component
    {
        public int service_device_id, device_id, total, cost;
        public string device;

        public s_service_device_component(int _service_device_id, int _device_id, int _total, int _cost, string _device)
        {
            service_device_id = _service_device_id;
            device_id = _device_id;
            total = _total;
            cost = _cost;
            device = _device;
        }
    }
    public struct s_service_device_vendor
    {
        public int service_device_vendor_id, service_device_id, vendor_id;
        public string date_in, date_out, vendor_note, service_vendor_sts_id, service_vendor_sts, vendor_name;

        public s_service_device_vendor(int _service_device_vendor_id, int _service_device_id, int _vendor_id,
            string _date_in, string _date_out, string _vendor_note, string _service_vendor_sts_id, string _service_vendor_sts, string _vendor_name)
        {
            service_device_vendor_id = _service_device_vendor_id;
            service_device_id = _service_device_id;
            vendor_id = _vendor_id;
            date_in = _date_in;
            date_out = _date_out;
            vendor_note = _vendor_note;
            service_vendor_sts_id = _service_vendor_sts_id;
            service_vendor_sts = _service_vendor_sts;
            vendor_name = _vendor_name;
        }
    }
    public struct s_service_device_trimming
    {
        public int service_device_id, device_type_trimming_id;
        public string trimming_name;
        public Boolean status;

        public s_service_device_trimming(int _service_device_id, int _device_type_trimming_id, string _trimming_name, Boolean _status)
        {
            service_device_id = _service_device_id;
            device_type_trimming_id = _device_type_trimming_id;
            trimming_name = _trimming_name;
            status = _status;
        }
    }
    public struct s_device_type_trimming
    {
        public int device_type_trimming_id, device_type_id, trimming_id;
        public string trimming_name;

        public s_device_type_trimming(int _device_type_trimming_id, int _device_type_id, int _trimming_id, string _trimming_name)
        {
            device_type_trimming_id = _device_type_trimming_id;
            device_type_id = _device_type_id;
            trimming_id = _trimming_id;
            trimming_name = _trimming_name;
        }
    }
    public struct s_technician
    {
        public int technician_id;
        public string technician_name;
        public Boolean active_sts;

        public s_technician(int _technician_id, string _technician_name, Boolean _active_sts)
        {
            technician_id = _technician_id;
            technician_name = _technician_name;
            active_sts = _active_sts;
        }
    }
    public struct s_service_device
    {
        public int service_device_id, service_id, device_register_id, device_id, device_type_id, technician_id, schedule_id, opr_service_id, last_inventory_id;
        public string date_in, customer_note, sn, device, service_device_sts_id, technician_note, technician_name, date_done;
        public Boolean guarantee_sts;
        public string user_name;
        public string offer_no, service_status, service_status_marketing, invoice_no, invoice_date, schedule_date;

        public s_service_device(int _service_device_id, int _service_id, int _device_register_id, int _device_id,
            string _date_in, string _customer_note, string _sn, string _device, string _service_device_sts_id,
            Boolean _guarantee_sts,
            string _technician_note = "",
            int _device_type_id = 0,
            int _technician_id = 0,
            string _technician_name = "", string _date_done = "",
            string _user_name = "",
            string _offer_no = "", string _service_status = "", string _invoice_no = "", string _invoice_date = "", string _service_status_marketing = "",
            int _schedule_id = 0, string _schedule_date = "", int _opr_service_id = 0, int _last_inventory_id = 0
            )
        {
            service_device_id = _service_device_id;
            service_id = _service_id;
            device_register_id = _device_register_id;
            service_device_sts_id = _service_device_sts_id;
            device_id = _device_id;
            date_in = _date_in;
            customer_note = _customer_note;
            sn = _sn;
            device = _device;
            guarantee_sts = _guarantee_sts;
            technician_note = _technician_note;
            device_type_id = _device_type_id;
            technician_id = _technician_id;
            technician_name = _technician_name;
            date_done = _date_done;
            user_name = _user_name;
            offer_no = _offer_no;
            service_status = _service_status;
            invoice_no = _invoice_no;
            invoice_date = _invoice_date;
            service_status_marketing = _service_status_marketing;
            schedule_id = _schedule_id;
            schedule_date = _schedule_date;
            opr_service_id = _opr_service_id;
            last_inventory_id = _last_inventory_id;
        }
    }
    public struct s_vendor
    {
        public int vendor_id, location_id, distance;
        public string vendor_name, location_address, vendor_address, contact_name, phone1, phone2;
        public Boolean access_service_data_sts;

        public s_vendor(int _vendor_id, int _location_id, int _distance, string _vendor_name, string _location_address, string _vendor_address,
                string _contact_name, string _phone1, string _phone2,
            Boolean _access_service_data_sts = false)
        {
            vendor_id = _vendor_id;
            location_id = _location_id;
            distance = _distance;
            vendor_name = _vendor_name;
            location_address = _location_address;
            vendor_address = _vendor_address;
            contact_name = _contact_name;
            phone1 = _phone1;
            phone2 = _phone2;
            access_service_data_sts = _access_service_data_sts;
        }
    }
    public struct s_device_register
    {
        public int device_register_id, device_id, device_type_id;
        public string sn, device, device_type;
        public Boolean part_sts;

        public s_device_register(int _device_register_id, int _device_id, int _device_type_id, string _sn, string _device, string _device_type, Boolean _part_sts)
        {
            device_register_id = _device_register_id;
            device_id = _device_id;
            device_type_id = _device_type_id;
            sn = _sn;
            device = _device;
            device_type = _device_type;
            part_sts = _part_sts;
        }
    }
    public struct s_device
    {
        public int device_id, device_type_id;
        public string device, device_type;
        public Boolean part_sts;

        public s_device(int _device_id, int _device_type_id, string _device, string _device_type, Boolean _part_sts)
        {
            device_id = _device_id;
            device = _device;
            device_type_id = _device_type_id;
            device_type = _device_type;
            part_sts = _part_sts;
        }
    }

    public struct s_device_type
    {
        public int device_type_id;
        public string device_type;
        public Boolean part_sts;
        public s_device_type(int _device_type_id, string _device_type, Boolean _part_sts)
        {
            device_type_id = _device_type_id;
            device_type = _device_type;
            part_sts = _part_sts;
        }
    }
    public struct s_messanger
    {
        public int messanger_id;
        public string messanger_name, latitude, longitude, mobile_id, mobile_password, ping_date, ping_time;
        public Boolean active_sts;
        public s_messanger(int _messanger_id, string _messanger_name, Boolean _active_sts, string _latitude = "", string _longitude = "",
                string _mobile_id = "", string _mobile_password = "", string _ping_date = "", string _ping_time = "")
        {
            messanger_id = _messanger_id;
            messanger_name = _messanger_name;
            active_sts = _active_sts;
            latitude = _latitude;
            longitude = _longitude;
            mobile_id = _mobile_id;
            mobile_password = _mobile_password;
            ping_date = _ping_date;
            ping_time = _ping_time;
        }
    }
    public struct s_schedule_service
    {
        public int schedule_id, service_id, kode_print, customer_id;
        public string expedition_type, customer_name, pickup_address, expedition_type_id, schedule_date, backup_sts, messanger_name, exp_contact;
        public s_schedule_service(int _schedule_id, int _service_id, string _expedition_type, string _customer_name, string _pickup_address,
            string _expedition_type_id = "",
            string _schedule_date = "",
            int _kode_print = 0, string _backup_sts = "",
            string _messanger_name = "",
            string _exp_contact = "",
            int _customer_id = 0)
        {
            schedule_id = _schedule_id;
            service_id = _service_id;
            expedition_type = _expedition_type;
            customer_name = _customer_name;
            pickup_address = _pickup_address;
            expedition_type_id = _expedition_type_id;
            schedule_date = _schedule_date;
            kode_print = _kode_print;
            backup_sts = _backup_sts;
            messanger_name = _messanger_name;
            exp_contact = _exp_contact;
            customer_id = _customer_id;
        }
    }
    public struct s_schedule
    {
        public int schedule_id, location_id, distance, messanger_id;
        public string schedule_date, location_address, messanger_name, contact_name;
        public Boolean done_sts, canceled_sts, backup_approve_sts;
        public s_schedule(int _schedule_id, int _location_id, int _distance, string _schedule_date, string _location_address, Boolean _done_sts,
            int _messanger_id, string _messanger_name,
            string _contact_name = "", Boolean _canceled_sts = false, Boolean _backup_approve_sts = false)
        {
            schedule_id = _schedule_id;
            location_id = _location_id;
            distance = _distance;
            schedule_date = _schedule_date;
            location_address = _location_address;
            done_sts = _done_sts;
            messanger_id = _messanger_id;
            messanger_name = _messanger_name;
            contact_name = _contact_name;
            canceled_sts = _canceled_sts;
            backup_approve_sts = _backup_approve_sts;
        }
    }
    public struct s_location
    {
        public int location_id, distance;
        public string location_address;

        public s_location(int _location_id, int _distance, string _location_address)
        {
            location_id = _location_id;
            location_address = _location_address;
            distance = _distance;
        }
    }
    public struct s_customer_location
    {
        public int location_id;
        public string location_address, customer_address, latitude, longitude;

        public s_customer_location(int _location_id, string _location_address, string _customer_address, string _latitude = "", string _longitude = "")
        {
            location_id = _location_id;
            location_address = _location_address;
            customer_address = _customer_address;
            latitude = _latitude;
            longitude = _longitude;
        }
    }
    public struct s_sales
    {
        public int sales_id, customer_id, an_id, contact_id, delivery_address_location_id, fee, group_customer_id;
        public string sales_call_date, delivery_address, note, customer_name, an, contact_name, marketing_id, delivery_address_location, npwp, delivery_date;
        public string customer_phone, customer_fax, customer_email, latitude, longitude, branch_customer;

        public s_sales(int _sales_id, int _customer_id, int _an_id, int _contact_id,
            string _sales_call_date, string _delivery_address, string _note, string _customer_name, string _an, string _contact_name, string _marketing_id,
            int _delivery_address_location_id, string _delivery_address_location, int _fee, int _group_customer_id, string _npwp,
            string _delivery_date = "",
            string _customer_phone = "", string _customer_fax = "", string _customer_email = "",
            string _latitude = "", string _longitude = "",
            string _branch_customer = ""
            )
        {
            sales_id = _sales_id;
            customer_id = _customer_id;
            an_id = _an_id;
            contact_id = _contact_id;
            sales_call_date = _sales_call_date;
            delivery_address = _delivery_address;
            note = _note;
            customer_name = _customer_name;
            an = _an;
            contact_name = _contact_name;
            marketing_id = _marketing_id;
            delivery_address_location_id = _delivery_address_location_id;
            delivery_address_location = _delivery_address_location;
            fee = _fee;
            group_customer_id = _group_customer_id;
            npwp = _npwp;
            delivery_date = _delivery_date;
            customer_phone = _customer_phone;
            customer_fax = _customer_fax;
            customer_email = _customer_email;
            latitude = _latitude;
            longitude = _longitude;
            branch_customer = _branch_customer;
        }
    }
    public struct s_service
    {
        public int service_id, customer_id, an_id, contact_id, pickup_address_location_id, fee, group_customer_id, branch_id;
        public string service_call_date, pickup_address, note, customer_name, an, contact_name, marketing_id, pickup_address_location, pickup_date, npwp;
        public string customer_phone, customer_fax, customer_email, backup_sts_id, backup_sts, latitude, longitude, branch_name, branch_customer;

        public s_service(int _service_id, int _customer_id, int _an_id, int _contact_id,
            string _service_call_date, string _pickup_address, string _note, string _customer_name, string _an, string _contact_name, string _marketing_id,
            int _pickup_address_location_id, string _pickup_address_location, string _pickup_date, int _fee, int _group_customer_id, string _npwp = "",
            string _customer_phone = "", string _customer_fax = "", string _customer_email = "",
            string _backup_sts_id = "", string _backup_sts = "",
            string _latitude = "", string _longitude = "",
            int _branch_id = 0, string _branch_name = "",
            string _branch_customer = "")
        {
            service_id = _service_id;
            customer_id = _customer_id;
            an_id = _an_id;
            contact_id = _contact_id;
            service_call_date = _service_call_date;
            pickup_address = _pickup_address;
            note = _note;
            customer_name = _customer_name;
            an = _an;
            contact_name = _contact_name;
            marketing_id = _marketing_id;
            pickup_address_location_id = _pickup_address_location_id;
            pickup_address_location = _pickup_address_location;
            pickup_date = _pickup_date;
            fee = _fee;
            group_customer_id = _group_customer_id;
            npwp = _npwp;
            customer_phone = _customer_phone;
            customer_fax = _customer_fax;
            customer_email = _customer_email;
            backup_sts_id = _backup_sts_id;
            backup_sts = _backup_sts;
            latitude = _latitude;
            longitude = _longitude;
            branch_id = _branch_id;
            branch_name = _branch_name;
            branch_customer = _branch_customer;
        }
    }
    public struct s_customer_contact
    {
        public int contact_id, customer_id;
        public string contact_name, contact_phone, customer_name;

        public s_customer_contact(int _contact_id, int _customer_id, string _contact_name, string _contact_phone, string _customer_name)
        {
            contact_id = _contact_id;
            customer_id = _customer_id;
            contact_name = _contact_name;
            contact_phone = _contact_phone;
            customer_name = _customer_name;

        }
    }
    public struct s_customer
    {
        public int customer_id, distance, customer_address_location_id, group_customer_id, branch_id;
        public string customer_name, customer_address, customer_phone, customer_fax, customer_email, marketing_id, customer_address_location, group_customer, npwp, latitude, longitude, branch_name;
        public Boolean user_device_mandatory;
        public string tkuid, jenisidpembeli_id, jenisidpembeli_name;

        public s_customer(int _customer_id, int _distance, string _customer_name, string _customer_address, string _customer_phone, string _customer_fax, string _customer_email, string _marketing_id,
            int _customer_address_location_id, string _customer_address_location,
            int _group_customer_id, string _group_customer, string _npwp = "", string _latitude = "", string _longitude = "",
            int _branch_id = 0, string _branch_name = "",
            Boolean _user_device_mandatory = false,
            string _tkuid = "", string _jenisidpembeli_id = "", string _jenisidpembeli_name = "")
        {
            customer_id = _customer_id;
            customer_name = _customer_name;
            customer_address = _customer_address;
            customer_phone = _customer_phone;
            customer_fax = _customer_fax;
            customer_email = _customer_email;
            distance = _distance;
            marketing_id = _marketing_id;
            customer_address_location_id = _customer_address_location_id;
            customer_address_location = _customer_address_location;
            group_customer_id = _group_customer_id;
            group_customer = _group_customer;
            npwp = _npwp;
            latitude = _latitude;
            longitude = _longitude;
            branch_id = _branch_id;
            branch_name = _branch_name;
            user_device_mandatory = _user_device_mandatory;
            tkuid=_tkuid;
            jenisidpembeli_id=_jenisidpembeli_id;
            jenisidpembeli_name=_jenisidpembeli_name;
        }
    }
    public struct s_marketing
    {
        public string marketing_id, marketing_name, marketing_phone, user_id, marketing_group_name, file_type;
        public Boolean all_access, dashboard_visible;
        public double target_value;
        public int marketing_group_id;
        public byte[] ttd_image;
        public string assistant_user_id;

        public s_marketing(string _marketing_id, string _marketing_name, string _marketing_phone, string _user_id, Boolean _all_access,
            Boolean _dashboard_visible = false, double _target_value = 0,
            int _marketing_group_id = 0, string _marketing_group_name = "",
            byte[] _ttd_image = null, string _file_type = "",
            string _assistant_user_id = ""

        )
        {
            marketing_id = _marketing_id;
            marketing_name = _marketing_name;
            marketing_phone = _marketing_phone;
            user_id = _user_id;
            all_access = _all_access;
            dashboard_visible = _dashboard_visible;
            target_value = _target_value;
            marketing_group_id = _marketing_group_id;
            marketing_group_name = _marketing_group_name;
            ttd_image = _ttd_image;
            file_type = _file_type;
            assistant_user_id = _assistant_user_id;
        }
    }
    public struct s_drop_down
    {
        public string value, text, other_value;
        public s_drop_down(string _value, string _text, string _other_value = "")
        {
            value = _value;
            text = _text;
            other_value = _other_value;
        }
    }
    //#auto complete
    [WebMethod]
    public s_drop_down[] ac_sales_offerno_list(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select top 100 sales_id value, offer_no text from v_opr_sales where offer_no like '%" + nilai + "%' and marketing_id=(select marketing_id from act_marketing where user_id='"+where+"') order by offer_date, offer_no";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_acc_coa_list(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select coa_id value, coa_name+' : '+coa_code text from v_acc_coa where coa_name+' : '+coa_code like '%" + nilai + "%' order by coa_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_location_list(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select location_id value,location_address text from v_exp_location where location_address like '%" + nilai + "%' order by location_address";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_trimming(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select trimming_id value, trimming_name text from v_tec_trimming where trimming_name like '%" + nilai + "%' order by trimming_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_vendor(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select vendor_id value, vendor_name text from v_opr_vendor where vendor_name like '%" + nilai + "%' order by vendor_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_part(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select top 100 device_id value,device text from v_tec_device where part_sts=1 and device like '" + nilai + "' order by device";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_device_all(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select device_id value,device text from v_tec_device where "+ where + " device like '" + nilai + "' order by device";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_device(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select top 100 device_id value,device text from v_tec_device where part_sts=0 and device like '" + nilai + "' order by device";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ac_customer(string where, string nilai)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        string strWhere = (where == "") ? "" : where + " and ";

        string strSQL = "select customer_id value,customer_name text, group_customer_id other_value from v_act_customer where " + strWhere + " customer_name like '" + nilai + "' order by customer_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString(), row["other_value"].ToString()));
        }

        return data.ToArray();
    }
    //#dropdown
    [WebMethod]
    public s_drop_down[] dl_jenisidpembeli(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select jenisidpembeli_id code, jenisidpembeli_name keterangan from act_jenisidpembeli  " + where + " order by jenisidpembeli_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_timetype(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code,keterangan from appCommonParameter where type='timetype' " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_guaranteedevsts(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code,keterangan from appCommonParameter where type='guaranteedevsts' " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_availalibity(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code,keterangan from appCommonParameter where type='availability' " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_onsiteguarantee(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select guarantee_onsite_id,guarantee_onsite_name from v_tec_onsite_guarantee " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["guarantee_onsite_id"].ToString(), row["guarantee_onsite_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_onsitedevicests(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code,keterangan from  appCommonParameter where type='onsitedevicests' " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_onsitests(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code, keterangan from appCommonParameter "+ where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_messanger_geotag(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select messanger_id, messanger_name from v_exp_messanger where cast(ping_date as date)=dbo.f_getAplDate()";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["messanger_id"].ToString(), row["messanger_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_employee(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        if (where == "") where = "where status=1"; else where = where + " and status=1";

        string strSQL = "select employee_id, employee_name from hr_employee " + where + " order by employee_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["employee_id"].ToString(), row["employee_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_list_month(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code, keterangan from appCommonParameter where type='listmonth' order by cast(code as int)";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_hr_wageparam(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "SELECT wageparam_id, wageparam_name, type_id, type_name FROM v_hr_wageparam " + where + " order by wageparam_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["wageparam_id"].ToString(), row["wageparam_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_hr_wageparam_vs_employee(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "SELECT wageparam_id, wageparam_name, type_id, type_name FROM v_hr_wageparam where wageparam_id not in (select wageparam_id from hr_employee_wageparam " + where + ") order by wageparam_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["wageparam_id"].ToString(), row["wageparam_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_hr_wageparam_vs_salary_employee_wageparam(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "SELECT wageparam_id, wageparam_name, type_id, type_name FROM v_hr_wageparam where wageparam_id not in (select wageparam_id from hr_salary_employee_wageparam " + where + ") order by wageparam_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["wageparam_id"].ToString(), row["wageparam_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_hr_wageparam_type(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code, keterangan from appCommonParameter where type='wageparamtype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["code"].ToString(), row["keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_hr_position(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select position_id, position_name from v_hr_position order by position_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["position_id"].ToString(), row["position_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_merk_all(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select '%' value, '--All--' text union select cast(merk_id as varchar(100)) value, merk_name text from par_merk)a order by text";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_merk(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select merk_id value, merk_name text from par_merk order by merk_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_vendor_category_all(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select '%' value, '--All--' text union select cast(vendor_category_id as varchar(100)), vendor_category_name text from par_vendor_category)a order by text";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_vendor_category(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select vendor_category_id value, vendor_category_name text from par_vendor_category order by vendor_category_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_act_marketing_group(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select marketing_group_id value, marketing_group_name text from v_act_marketing_group order by marketing_group_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_comparameter(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value, 'All' text union select code value, keterangan text from appCommonParameter " + where + " ) a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_dbcr_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='dbcr'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_acc_coa_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select coa_type_id value, coa_type_name text from v_acc_coa_type order by coa_type_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_marketing_all_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select '%' value, 'All' text union select marketing_id value, marketing_id text from act_marketing)tbl";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_marketing_reason(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, description text from v_app_parameter_user where type_id='1'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_parameter_user(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value,keterangan text from appCommonParameter where type='paramuser'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_price_principal_type(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select par_principal_price_type_id value,par_principal_price_type text from v_par_principal_price_type";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_petty_cash_category_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select petty_cash_category_id value, petty_cash_category text from v_fin_petty_cash_category " + where + " order by petty_cash_category";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_petty_cash_name_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select petty_cash_name_id value, petty_Cash_name text from v_fin_petty_cash_name " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_vendor_bill_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select 0 value, '--none--' text union select bill_id,bill_name+'; '+bill_bank_name+': '+bill_no from opr_vendor_bill " + where + ")a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_transaction_vendor_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='tranven'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_fin_result_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select result_id value, result text from v_fin_result";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_branch_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value, '--All--' text union select cast(branch_id as varchar(10)),branch_name from par_branch)a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_par_branch_list_1(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select branch_id value,branch_name text from par_branch";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_pettycast_coa_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select coa_id value,coa_name text from v_fin_coa where ticket_type_id='1' and financial_transaction_type_id in ('2','4')";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_financial_transaction_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='fintrantype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_ticket_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='ticketype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_borrow_sts_all_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value,'-ALL' text union all select code value, keterangan text from appcommonparameter where type='borrowsts')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_borrow_sts_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='borrowsts'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_borrowed_for_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='borrowedfor'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_schedule_service_list(string str_schedule_id)
    {
        int schedule_id = Convert.ToInt32(str_schedule_id.Replace("where", ""));
        List<s_drop_down> data = new List<s_drop_down>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_exp_schedule_borrow_customer_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.Int,0,schedule_id)
        }))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_inventory_type_list_all(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value, '--All--' text union select code , keterangan from appcommonparameter where type='invtype')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_inventory_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='invtype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_backup_status_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='backupsts'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_bill_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select bill_id value, bill_no+' '+bill_name text from v_fin_bill";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_term_of_payment_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='top'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_act_marketing_service_status_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='mktservicests'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_act_marketing_service_status_all_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value, '--All--' text union select code value, keterangan text from appCommonParameter where type='mktservicests')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_status_service_all_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '%' value, '-ALL-' text union select ' ' value, '-none-' text union select code value, keterangan text from appCommonParameter where type='oprservicests')a order by text";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_status_sales_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='oprsalessts'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_status_sales_list1(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select code value, keterangan text from appCommonParameter where type='oprsalessts' union select '%','--All--')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_status_sales_list2(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_status_service_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='oprservicests'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_discount_type_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='discountype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_ctgsales_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='ctgsales'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_opr_broker_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select broker_id value, broker_name text from v_opr_broker";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_service_vendor_status_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value,keterangan text from appCommonParameter where type='servicevensts'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_tec_technician_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select '0' value,'-none' text union select technician_id,technician_name from tec_technician)a order by text";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_service_device_sts_all(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select '%' value, '-ALL-' text union select code value, keterangan text from appCommonParameter where type='servicedevsts')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_service_device_sts(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value, keterangan text from appCommonParameter where type='servicedevsts'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_device_type_nonpart(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select device_type_id value, device_type text from v_tec_device_type order by device_type";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_messanger(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from (select 0 value, '-none-' text union select messanger_id ,messanger_name from v_exp_messanger)a order by text ";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_expedition_type(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value,keterangan text from appcommonparameter where type='expeditiontype'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_schedule_undone_by_date_list(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select dbo.f_convertDateToChar(schedule_date) value, dbo.f_convertDateToChar(schedule_date) text from exp_schedule where done_sts=0 and schedule_id in (select schedule_id from v_exp_schedule_service where branch_id like '" + where + "' union select schedule_id from v_exp_schedule_sales where branch_id like '" + where + "' ) group by schedule_date";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_lvlmktsts_all(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value,text from(select '' code, '-All-' text union all select code,Keterangan from appcommonparameter where type='lvlmktsts')a " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_lvlmktsts(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select code value,Keterangan text from appcommonparameter where type='lvlmktsts' " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] dl_contact_an_by_customer_id(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select contact_id value, contact_name text from v_act_customer_contact " + where;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ddl_marketing(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select marketing_id value, marketing_id text from v_act_marketing";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ddl_user(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select userid value, userid text from v_appuser";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_drop_down[] ddl_user2(string where)
    {
        List<s_drop_down> data = new List<s_drop_down>();

        string strSQL = "select * from(select userid value, userid text from v_appuser union select '','-')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    //#sp query
    [WebMethod]
    public s_fin_proforma_service fin_proforma_service_data(string proforma_service_id)
    {
        s_fin_proforma_service data = new s_fin_proforma_service();

        string strSQL = "select proforma_service_id, dbo.f_convertDateToChar(proforma_date) proforma_date,proforma_no," +
        "term_of_payment_id,po_no,afpo_no," +
        "term_of_payment_value,bill_id, proforma_sts,proforma_note," +
        "bill_name,bill_no,bill_bank_name,term_of_payment_name,str_top_value," +
        "customer_id, an_id,customer_name, pph_sts, grand_price from v_fin_proforma_service where proforma_service_id=" + proforma_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_proforma_service(Convert.ToInt32(row["proforma_service_id"]), row["proforma_date"].ToString(), row["proforma_no"].ToString(),
                row["term_of_payment_id"].ToString(), row["po_no"].ToString(), row["po_no"].ToString(), row["afpo_no"].ToString(),
                Convert.ToInt32(row["term_of_payment_value"]), Convert.ToInt32(row["bill_id"]), Convert.ToBoolean(row["proforma_sts"]), row["proforma_note"].ToString(),
                row["bill_bank_name"].ToString(), row["bill_no"].ToString(), row["bill_bank_name"].ToString(), row["term_of_payment_name"].ToString(), row["str_top_value"].ToString(),
                Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), row["customer_name"].ToString(),
                Convert.ToBoolean(row["pph_sts"]), Convert.ToInt64(row["grand_price"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_proforma_sales fin_proforma_sales_data(string proforma_sales_id)
    {
        s_fin_proforma_sales data = new s_fin_proforma_sales();

        string strSQL = "select proforma_sales_id, dbo.f_convertDateToChar(proforma_date) proforma_date,proforma_no,"+
        "term_of_payment_id,po_no,afpo_no,"+
        "term_of_payment_value,bill_id, proforma_sts,proforma_note,"+
        "bill_name,bill_no,bill_bank_name,term_of_payment_name,str_top_value,"+
        "customer_id, an_id,customer_name, pph_sts, grand_price from v_fin_proforma_sales where proforma_sales_id=" + proforma_sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_proforma_sales(Convert.ToInt32(row["proforma_sales_id"]), row["proforma_date"].ToString(), row["proforma_no"].ToString(),
                row["term_of_payment_id"].ToString(), row["po_no"].ToString(), row["po_no"].ToString(), row["afpo_no"].ToString(),
                Convert.ToInt32(row["term_of_payment_value"]), Convert.ToInt32(row["bill_id"]),Convert.ToBoolean(row["proforma_sts"]), row["proforma_note"].ToString(),
                row["bill_bank_name"].ToString(), row["bill_no"].ToString(), row["bill_bank_name"].ToString(), row["term_of_payment_name"].ToString(), row["str_top_value"].ToString(),
                Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), row["customer_name"].ToString(),
                Convert.ToBoolean(row["pph_sts"]),Convert.ToInt64(row["grand_price"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_petty_cash_transaction_init xml_petty_cash_transaction_init(string petty_cash_name_id)
    {
        s_fin_petty_cash_transaction_init data = new s_fin_petty_cash_transaction_init();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_petty_cash_transaction_init", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.BigInt,0,petty_cash_name_id)
        }))
        {
            data = new s_fin_petty_cash_transaction_init(Convert.ToInt32(row["petty_cash_transaction_hdr_id"]),
                row["begin_date"].ToString(), row["end_date"].ToString(), Convert.ToInt32(row["begin_saldo"]), Convert.ToInt32(row["end_saldo"]),
                Convert.ToBoolean(row["open_sts"]), Convert.ToBoolean(row["close_sts"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_opr_service_device_component_price_history[] xml_opr_sales_device_price_history(int device_id, int customer_id, Boolean check_all_sts, int sales_id)
    {
        List<s_opr_service_device_component_price_history> data = new List<s_opr_service_device_component_price_history>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_opr_sales_device_price_history", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@check_all_sts",System.Data.SqlDbType.Bit,0,check_all_sts),
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.Int,0,sales_id)
        }))
        {
            data.Add(
                new s_opr_service_device_component_price_history(row["customer_name"].ToString(), row["offer_date"].ToString(), Convert.ToInt32(row["price"])
                ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_opr_service_device_component_price_history[] xml_opr_service_device_component_price_history(int service_device_id, int device_id, int customer_id, Boolean check_all_sts)
    {
        List<s_opr_service_device_component_price_history> data = new List<s_opr_service_device_component_price_history>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_opr_service_device_component_price_history", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.Int,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@check_all_sts",System.Data.SqlDbType.Bit,0,check_all_sts)
        }))
        {
            data.Add(
                new s_opr_service_device_component_price_history(row["customer_name"].ToString(), row["offer_date"].ToString(), Convert.ToInt32(row["price"])
                ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_opr_service_device_component xml_opr_service_device_component_data(int service_id, int service_device_id, int device_id)
    {
        s_opr_service_device_component data = new s_opr_service_device_component();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_opr_service_device_component_data", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.BigInt,0,device_id)
        }))
        {
            data = new s_opr_service_device_component(service_id, service_device_id, Convert.ToInt16(row["device_id"]), Convert.ToInt32(row["price"]),
                Convert.ToInt32(row["total"]), row["device"].ToString(), Convert.ToBoolean(row["pph21"]), Convert.ToBoolean(row["real_data_sts"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["tec_total"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_opr_service_device_component[] xml_opr_service_device_component_list(int service_id, int service_device_id)
    {
        List<s_opr_service_device_component> data = new List<s_opr_service_device_component>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_opr_service_device_component_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
        }))
        {
            data.Add(new s_opr_service_device_component(service_id, service_device_id, Convert.ToInt16(row["device_id"]), Convert.ToInt32(row["price"]),
                Convert.ToInt32(row["total"]), row["device"].ToString(), Convert.ToBoolean(row["pph21"]), Convert.ToBoolean(row["real_data_sts"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["tec_total"]),
                Convert.ToInt32(row["price_customer"])
            ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_customer_location[] xml_act_customer_location_list(int customer_id)
    {
        List<s_customer_location> data = new List<s_customer_location>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_act_customer_location_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id)
        }))
        {
            data.Add(new s_customer_location(Convert.ToInt32(row["location_id"]), row["location_address"].ToString(), row["customer_address"].ToString(), row["latitude"].ToString(), row["longitude"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_location[] xml_exp_location_check_address_list(string location_address)
    {
        List<s_location> data = new List<s_location>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_exp_location_check_address_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address)
        }))
        {
            data.Add(new s_location(Convert.ToInt32(row["location_id"]), Convert.ToInt32(row["distance"]), row["location_address"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_service_device_trimming[] xml_tec_service_device_trimming_list(int service_device_id, int device_type_id)
    {
        List<s_service_device_trimming> data = new List<s_service_device_trimming>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_tec_service_device_trimming_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id)
        }))
        {
            data.Add(new s_service_device_trimming(Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["device_type_trimming_id"]), row["trimming_name"].ToString(), Convert.ToBoolean(row["status"])));
        }

        return data.ToArray();
    }
    //[WebMethod]
    public string[] get_month_list()
    {
        List<string> data = new List<string>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ("select str_month from v_par_list_month order by int_month"))
        {
            data.Add(row["str_month"].ToString());
        }

        return data.ToArray();
    }
    public string[] get_marketing_list()
    {
        List<string> data = new List<string>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ("select marketing_id from act_marketing where dashboard_visible=1"))
        {
            data.Add(row["marketing_id"].ToString());
        }

        return data.ToArray();
    }
    public double[] get_marketing_total_net_list(string marketing_id)
    {
        List<double> data = new List<double>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ("select total_net/1000 total_net from tmp_dashboard_marketing_achievment where marketing_id='" + marketing_id + "' order by int_month"))
        {
            data.Add(Convert.ToInt32(row["total_net"]));
        }

        return data.ToArray();
    }

    //#query
    private s_fin_sales_log fin_sales_log_row(System.Data.DataRow row)
    {
        return new s_fin_sales_log(row["log_date"].ToString(), row["status_desc"].ToString());
    }
    [WebMethod]
    public s_fin_sales_log[] fin_sales_log_list(long sales_id)
    {
        List<s_fin_sales_log> data = new List<s_fin_sales_log>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("fin_sales_log", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id)
        }))
        {
            data.Add(fin_sales_log_row(row));
        }

        return data.ToArray();
    }
    private string tec_onsite_guarantee_select(string filter)
    {
        return "select guarantee_onsite_id,guarantee_onsite_name,guarantee_sts from v_tec_onsite_guarantee " + filter;
    }
    private s_tec_onsite_guarantee tec_onsite_guarantee_row(System.Data.DataRow row)
    {
        return new s_tec_onsite_guarantee(
            Convert.ToInt32(row["guarantee_onsite_id"]), row["guarantee_onsite_name"].ToString(), Convert.ToBoolean(row["guarantee_sts"])
            );
    }
    [WebMethod]
    public s_tec_onsite_guarantee tec_onsite_workorders_parts_data(string guarantee_onsite_id)
    {
        s_tec_onsite_guarantee data = new s_tec_onsite_guarantee();
        string strSQL = tec_onsite_guarantee_select(" where guarantee_onsite_id=" + guarantee_onsite_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = tec_onsite_guarantee_row(row);
        }

        return data;
    }
    private string tec_onsite_workorders_parts_select(string filter)
    {
        return "select workorder_id, part_id, total, part from v_tec_onsite_workorders_parts " + filter;
    }
    private s_tec_onsite_workorders_parts tec_onsite_workorders_parts_row(System.Data.DataRow row)
    {
        return new s_tec_onsite_workorders_parts(
            Convert.ToInt64(row["workorder_id"]), Convert.ToInt32(row["part_id"]), Convert.ToInt32(row["total"]),
            row["part"].ToString()
            );
    }
    [WebMethod]
    public s_tec_onsite_workorders_parts tec_onsite_workorders_parts_data(string workorder_id, string part_id)
    {
        s_tec_onsite_workorders_parts data = new s_tec_onsite_workorders_parts();
        string strSQL = tec_onsite_workorders_parts_select(" where workorder_id=" + workorder_id + " and part_id=" + part_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = tec_onsite_workorders_parts_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_tec_onsite_workorders_parts[] tec_onsite_workorders_parts_list(string workorder_id)
    {
        List<s_tec_onsite_workorders_parts> data = new List<s_tec_onsite_workorders_parts>();
        string strSQL = tec_onsite_workorders_parts_select(" where workorder_id=" + workorder_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data.Add(tec_onsite_workorders_parts_row(row));
        }

        return data.ToArray();
    }
    private string tec_onsite_workorders_select(string filter)
    {
        return "SELECT workorder_id,onsite_id,device_id,sn,note,complient_note, device,dbo.f_convertDateToChar(segeldate)segeldate,onsitedevicests_id,onsitedevicests, dbo.f_convertDateToChar(guarantee_date)guarantee_date  FROM [TEST4].[dbo].[v_tec_onsite_workorders] " + filter;
    }
    private s_tec_onsite_workorders tec_onsite_workorders_row(System.Data.DataRow row)
    {
        return new s_tec_onsite_workorders(
            Convert.ToInt64(row["workorder_id"]),Convert.ToInt64(row["onsite_id"]),Convert.ToInt32(row["device_id"]),
            row["sn"].ToString(),row["note"].ToString(),row["complient_note"].ToString(),row["device"].ToString(),
            row["segeldate"].ToString(), row["onsitedevicests_id"].ToString(), row["onsitedevicests"].ToString(),
            row["guarantee_date"].ToString()
            );
    }
    [WebMethod]
    public s_tec_onsite_workorders tec_onsite_wordorders_data(string workorder_id)
    {
        s_tec_onsite_workorders data = new s_tec_onsite_workorders();
        string strSQL = tec_onsite_workorders_select(" where workorder_id=" + workorder_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = tec_onsite_workorders_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_tec_onsite_workorders[] tec_onsite_wordorders_list(string onsite_id)
    {
        List<s_tec_onsite_workorders> data = new List<s_tec_onsite_workorders>();
        string strSQL = tec_onsite_workorders_select(" where onsite_id=" + onsite_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data.Add( tec_onsite_workorders_row(row));
        }

        return data.ToArray();
    }
    private string tec_onsite_select(string filter)
    {
        return "select onsite_id,customer_id, onsite_no,dbo.f_convertDateToChar(onsite_date)onsite_date,dbo.f_convertDateToChar(onsite_date2)onsite_date2, dbo.f_convertDateToChar(request_date)request_date, technician_name,done_date,Note,onsitests_id, customer_name,customer_address,customer_address_location,onsitests,marketing_id, an_id, contact_name, guarantee_onsite_id, guarantee_onsite_name, guarantee_sts  from v_tec_onsite " + filter;
    }
    private s_tec_onsite tec_onsite_row(System.Data.DataRow row)
    {
        return new s_tec_onsite(
            Convert.ToInt64(row["onsite_id"]), Convert.ToInt64(row["customer_id"]), Convert.ToInt32(row["an_id"]), 
            row["onsite_no"].ToString(), row["onsite_date"].ToString(),row["onsite_date2"].ToString(), row["request_date"].ToString(), row["technician_name"].ToString(), row["done_date"].ToString(), row["note"].ToString(), row["onsitests_id"].ToString(),
            row["customer_name"].ToString(), row["customer_address"].ToString(), row["customer_address_location"].ToString(), row["onsitests"].ToString(), row["marketing_id"].ToString(), row["contact_name"].ToString(),
            Convert.ToInt32(row["guarantee_onsite_id"]), row["guarantee_onsite_name"].ToString(),Convert.ToBoolean(row["guarantee_sts"])
        );
    }
    [WebMethod]
    public s_tec_onsite tec_onsite_data(string onsite_id)
    {
        s_tec_onsite data = new s_tec_onsite();
        string strSQL = tec_onsite_select(" where onsite_id=" + onsite_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = tec_onsite_row(row);
        }

        return data;
    }
    private string opr_service_addicost_select(string filter)
    {
        return "select addicost_id, service_id, addicost_name, addicost_value from v_opr_service_addicost " + filter;
    }
    private s_opr_sales_addicost opr_service_addicost_row(System.Data.DataRow row)
    {
        return new s_opr_sales_addicost(Convert.ToInt64(row["addicost_id"]), Convert.ToInt64(row["service_id"]), row["addicost_name"].ToString(), Convert.ToInt64(row["addicost_value"]));
    }
    [WebMethod]
    public s_opr_sales_addicost opr_service_addicost_data(string addicost_id)
    {
        s_opr_sales_addicost data = new s_opr_sales_addicost();
        string strSQL = opr_service_addicost_select(" where addicost_id=" + addicost_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = opr_service_addicost_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_opr_sales_addicost[] opr_service_addicost_list(string service_id)
    {
        List<s_opr_sales_addicost> data = new List<s_opr_sales_addicost>();
        string strSQL = opr_service_addicost_select(" where service_id=" + service_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data.Add(opr_service_addicost_row(row));
        }

        return data.ToArray();
    }
    private string opr_service_document_select(string filter)
    {
        return "select service_id, typefileservice_id,file_name,isnull(file_image,0x0)file_image, typefilesales_name, file_type from v_opr_service_document " + filter;

    }
    private s_opr_service_document opr_service_document_row(System.Data.DataRow row)
    {
        return new s_opr_service_document(Convert.ToInt64(row["service_id"]), row["typefileservice_id"].ToString(), row["file_name"].ToString(), row["typefilesales_name"].ToString(), (byte[])row["file_image"], row["file_type"].ToString());
    }
    
    [WebMethod]
    public s_opr_service_document opr_service_document_data(string service_id)
    {
        s_opr_service_document data = new s_opr_service_document();
        string strSQL = opr_service_document_select(" where service_id=" + service_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = opr_service_document_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_fin_proforma_sales_opr[] fin_proforma_sales_opr_list(string proforma_sales_id)
    {
        List<s_fin_proforma_sales_opr> data = new List<s_fin_proforma_sales_opr>();

        string strSQL = "select proforma_sales_id,sales_id,offer_no,dbo.f_convertDateToChar(offer_date)str_offer_date,grand_price,fee from v_fin_proforma_sales_opr  where proforma_sales_id=" + proforma_sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_fin_proforma_sales_opr(Convert.ToInt64(row["proforma_sales_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                    Convert.ToInt32(row["sales_id"]),
                row["offer_no"].ToString(), row["str_offer_date"].ToString()
            ));

        }
        return data.ToArray();
    }
    private string opr_sales_addicost_select(string filter)
    {
        return "select addicost_id, sales_id, addicost_name, addicost_value from v_opr_sales_addicost " + filter;
    }
    private s_opr_sales_addicost opr_sales_addicost_row(System.Data.DataRow row)
    {
        return new s_opr_sales_addicost(Convert.ToInt64(row["addicost_id"]), Convert.ToInt64(row["sales_id"]), row["addicost_name"].ToString(), Convert.ToInt64(row["addicost_value"]));
    }
    [WebMethod]
    public s_opr_sales_addicost opr_sales_addicost_data(string addicost_id)
    {
        s_opr_sales_addicost data = new s_opr_sales_addicost();
        string strSQL = opr_sales_addicost_select(" where addicost_id=" + addicost_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = opr_sales_addicost_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_opr_sales_addicost[] opr_sales_addicost_list(string sales_id)
    {
        List<s_opr_sales_addicost> data = new List<s_opr_sales_addicost>();
        string strSQL = opr_sales_addicost_select(" where sales_id=" + sales_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data.Add(opr_sales_addicost_row(row));
        }

        return data.ToArray();
    }

    private string opr_sales_document_select(string filter)
    {
        return "select sales_id, typefilesales_id,file_name,isnull(file_image,0x0)file_image, typefilesales_name, file_type from v_opr_sales_document " + filter;

    }
    private s_opr_sales_document opr_sales_document_row(System.Data.DataRow row)
    {
        return new s_opr_sales_document(Convert.ToInt64(row["sales_id"]), row["typefilesales_id"].ToString(), row["file_name"].ToString(), row["typefilesales_name"].ToString(), (byte[])row["file_image"], row["file_type"].ToString());
    }
    [WebMethod]
    public s_opr_sales_document opr_sales_document_data(string sales_id)
    {
        s_opr_sales_document data = new s_opr_sales_document();
        string strSQL = opr_sales_document_select(" where sales_id=" + sales_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = opr_sales_document_row(row);
        }

        return data;
    }
    private string opr_sales_log_select(string filter)
    {
        return "select sales_log_id,sales_id, cast(log_date as varchar(30))log_date, user_id, sales_status_id,  sales_status_name from v_opr_sales_log " + filter;
    }
    private s_opr_sales_log opr_sales_log_row(System.Data.DataRow row)
    {
        return new s_opr_sales_log(Convert.ToInt64(row["sales_log_id"]), Convert.ToInt64(row["sales_id"]), row["log_date"].ToString(), row["user_id"].ToString(), row["sales_status_id"].ToString(), row["sales_status_name"].ToString());
    }
    [WebMethod]
    public s_opr_sales_log[] opr_sales_log_list(string sales_id)
    {
        List<s_opr_sales_log> data = new List<s_opr_sales_log>();
        string strSQL = opr_sales_log_select(" where sales_id=" + sales_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(opr_sales_log_row(row));
        }

        return data.ToArray();
    }
    private string opr_sales_approver_select(string filter)
    {
        return "select approver_id, user_id, approver_name, limit_awal, limit_akhir, active_sts from v_opr_sales_approver" + filter;
    }
    private s_opr_sales_approver opr_sales_approver_row(System.Data.DataRow row)
    {
        return new s_opr_sales_approver(Convert.ToInt32(row["approver_Id"]), Convert.ToInt64(row["limit_awal"]), Convert.ToInt64(row["limit_akhir"]),
                row["user_id"].ToString(), row["approver_name"].ToString(), Convert.ToBoolean(row["active_sts"]));
    }
    [WebMethod]
    public s_opr_sales_approver opr_sales_approver_data(int approver_id)
    {
        s_opr_sales_approver data = new s_opr_sales_approver();
        string strSQL = opr_sales_approver_select(" where approver_id=" + approver_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = opr_sales_approver_row(row);
        }

        return data;
    }
    [WebMethod]
    public s_drop_down[] ac_fin_invoice_receipt_allinvoicedata(string where, string invoice_no)
    {
        List<s_drop_down> data = new List<s_drop_down>();
        //string strWhere = (where == "") ? "" : where + " and ";
        int customer_id = Convert.ToInt32(where.Split(';')[0]);
        string jenis = where.Split(';')[1].ToString();

        string strSQL = "ac_fin_invoice_receipt_allinvoicedata";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ(strSQL, new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@invoice_no",System.Data.SqlDbType.VarChar,50,invoice_no),
            new _DBcon.sComParameter("@jenis",System.Data.SqlDbType.VarChar,2,jenis)}
            ))
        {
            data.Add(new s_drop_down(row["value"].ToString(), row["text"].ToString(), ""));
        }

        return data.ToArray();
    }
    private string s_fin_invoice_receipt_select(string filter)
    {
        return "select invoice_receipt_id, isnull(dbo.f_convertDateToChar(deliver_date),'')deliver_date, isnull(messanger_id,0)messanger_id,customer_id,isnull(dbo.f_convertDateToChar(receipt_date),'') receipt_date,isnull(receipt_name,'')receipt_name,customer_name,customer_address,isnull(messanger_name,'')messanger_name from v_fin_invoice_receipt " + filter;
    }
    private s_invoice_receipt s_fin_invoice_receipt_row(System.Data.DataRow row)
    {
        return new s_invoice_receipt(Convert.ToInt32(row["invoice_receipt_id"]), Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["messanger_id"]),
            row["deliver_date"].ToString(), row["receipt_date"].ToString(), row["receipt_name"].ToString(), row["customer_name"].ToString(), row["customer_address"].ToString(), row["messanger_name"].ToString()
        );
    }
    [WebMethod]
    public s_invoice_receipt invoice_receipt_data(string invoice_receipt_id)
    {
        s_invoice_receipt data = new s_invoice_receipt();

        string strSQL = s_fin_invoice_receipt_select(" where invoice_receipt_id=" + invoice_receipt_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = s_fin_invoice_receipt_row(row);
        }
        return data;
    }

    private string s_fin_invoice_receipt_detail_select(string filter)
    {
        return "select invoice_receipt_id, id, jenis, invoice_no, receipt_no, grand_price from v_fin_invoice_receipt_detail " + filter;
    }
    private s_fin_invoice_receipt_detail s_fin_invoice_receipt_detail_row(System.Data.DataRow row)
    {
        return new s_fin_invoice_receipt_detail(Convert.ToInt32(row["invoice_receipt_id"]), Convert.ToInt32(row["id"]),
            row["jenis"].ToString(), row["invoice_no"].ToString(), row["receipt_no"].ToString(),
            Convert.ToDouble(row["grand_price"])
        );
    }
    [WebMethod]
    public s_fin_invoice_receipt_detail[] fin_invoice_receipt_detail_list(string invoice_receipt_id)
    {
        List<s_fin_invoice_receipt_detail> data = new List<s_fin_invoice_receipt_detail>();

        //string strSQL = "select invoice_receipt_id, id, jenis, invoice_no, receipt_no, grand_price from v_fin_invoice_receipt_detail where invoice_receipt_id=" + invoice_receipt_id;
        string strSQL = s_fin_invoice_receipt_detail_select("where invoice_receipt_id=" + invoice_receipt_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(s_fin_invoice_receipt_detail_row(row));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_dashboard_init xml_dashboard_init()
    {
        s_dashboard_init data = new s_dashboard_init();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_dashboard_init", null))
        {
            data = new s_dashboard_init(
                Convert.ToInt64(row["targettahunan"]),
                Convert.ToInt64(row["sisapencapaian"])
            );
        }

        return data;
    }
    private s_exp_messanger_geotag s_exp_messanger_geotag_row(System.Data.DataRow row)
    {
        return new s_exp_messanger_geotag(Convert.ToInt64(row["geotag_id"]), Convert.ToInt32(row["messanger_id"]),
            row["messanger_name"].ToString(), row["ping_date"].ToString(), row["ping_time"].ToString(),
            Convert.ToDouble(row["latitude"]), Convert.ToDouble(row["longitude"])
        );
    }
    [WebMethod]
    public s_exp_messanger_geotag[] s_exp_messanger_geotag_list(string messanger_id)
    {
        List<s_exp_messanger_geotag> data = new List<s_exp_messanger_geotag>();

        string strSQL = "select geotag_id,messanger_id,messanger_name, dbo.f_convertDateToChar(ping_date)ping_date,ping_time, latitude, longitude from v_exp_messanger_geotag where cast(ping_date as date)=dbo.f_getAplDate() and messanger_id=" + messanger_id;
        //string strSQL = "select messanger_id, messanger_name, active_sts,latitude, longitude,mobile_id, mobile_password from v_exp_messanger where ping_date is not null";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(s_exp_messanger_geotag_row(row));
        }
        return data.ToArray();
    }
    private s_messanger s_messanger_row(System.Data.DataRow row)
    {
        return new s_messanger(
            Convert.ToInt32(row["messanger_id"]), row["messanger_name"].ToString(), Convert.ToBoolean(row["active_sts"]),
            row["latitude"].ToString(), row["longitude"].ToString(), row["mobile_id"].ToString(), row["mobile_password"].ToString(),
            row["ping_date"].ToString(), row["ping_time"].ToString()
        );
    }
    [WebMethod]
    public s_messanger[] s_messanger_get_location()
    {
        List<s_messanger> data = new List<s_messanger>();

        string strSQL = "select messanger_id, messanger_name, active_sts,latitude, longitude,mobile_id, mobile_password,dbo.f_convertDateToChar(ping_date)ping_date,ping_time from v_exp_messanger where cast(ping_date as date)=dbo.f_getAplDate()";
        //string strSQL = "select messanger_id, messanger_name, active_sts,latitude, longitude,mobile_id, mobile_password from v_exp_messanger where ping_date is not null";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(s_messanger_row(row));
        }
        return data.ToArray();
    }
    private s_hr_nonsalary_employee_wageparam hr_nonsalary_employee_wageparam_row(System.Data.DataRow row)
    {
        return new s_hr_nonsalary_employee_wageparam(
            Convert.ToInt32(row["nonsalary_employee_wageparam_id"]), Convert.ToInt32(row["nonsalary_employee_id"]), Convert.ToInt32(row["wageparam_id"]), Convert.ToInt32(row["total"]),
            Convert.ToInt64(row["nilai"]), Convert.ToInt64(row["total_nilai"]),
            row["note"].ToString(), row["wageparam_name"].ToString(), row["type_id"].ToString(), row["employee_name"].ToString(), row["type_name"].ToString()
            );
    }
    [WebMethod]
    public s_hr_nonsalary_employee_wageparam[] hr_nonsalary_employee_wageparam_list(string nonsalary_employee_id)
    {
        List<s_hr_nonsalary_employee_wageparam> data = new List<s_hr_nonsalary_employee_wageparam>();

        string strSQL = "select nonsalary_employee_wageparam_id,nonsalary_employee_id,wageparam_id,nilai,total,note,wageparam_name,type_id,employee_name,type_name, total_nilai from v_hr_nonsalary_employee_wageparam where nonsalary_employee_id=" + nonsalary_employee_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(hr_nonsalary_employee_wageparam_row(row));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_hr_nonsalary_employee_wageparam hr_nonsalary_employee_wageparam_data(string nonsalary_employee_wageparam_id)
    {
        s_hr_nonsalary_employee_wageparam data = new s_hr_nonsalary_employee_wageparam();

        string strSQL = "select nonsalary_employee_wageparam_id,nonsalary_employee_id,wageparam_id,nilai,total,note,wageparam_name,type_id,employee_name,type_name, total_nilai from v_hr_nonsalary_employee_wageparam where nonsalary_employee_wageparam_id=" + nonsalary_employee_wageparam_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = hr_nonsalary_employee_wageparam_row(row);
        }
        return data;
    }
    [WebMethod]
    public s_hr_nonsalary_employee[] hr_nonsalary_employee_list(string nonsalary_id)
    {
        List<s_hr_nonsalary_employee> data = new List<s_hr_nonsalary_employee>();

        string strSQL = "select nonsalary_employee_id,nonsalary_id,employee_id,employee_name,total_salary from v_hr_nonsalary_employee where nonsalary_id=" + nonsalary_id + " order by employee_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_hr_nonsalary_employee(
            Convert.ToInt32(row["nonsalary_employee_id"]), Convert.ToInt32(row["nonsalary_id"]), Convert.ToInt32(row["employee_id"]),
            row["employee_name"].ToString(),
            Convert.ToInt64(row["total_salary"])
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_hr_nonsalary hr_nonsalary_data(string nonsalary_id)
    {
        s_hr_nonsalary data = new s_hr_nonsalary();

        string strSQL = "select nonsalary_id,nonsalary_name,month_issue,year_issue,dbo.f_convertDateToChar(nonsalary_date)nonsalary_date,month_issue_name from v_hr_nonsalary where nonsalary_id=" + nonsalary_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_hr_nonsalary(
            Convert.ToInt32(row["nonsalary_id"]), Convert.ToInt32(row["month_issue"]), Convert.ToInt32(row["year_issue"]),
            row["nonsalary_name"].ToString(), row["nonsalary_date"].ToString(), row["month_issue_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_hr_employee_loan_installment[] hr_employee_loan_installment_list(string loan_id)
    {
        List<s_hr_employee_loan_installment> data = new List<s_hr_employee_loan_installment>();

        string strSQL = "select loan_id, ins_period, ins_month,ins_year, paid_sts, ins_month_name from v_hr_employee_loan_installment where loan_id=" + loan_id + " order by loan_id, ins_period";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_hr_employee_loan_installment(
            Convert.ToInt32(row["loan_id"]), Convert.ToInt32(row["ins_period"]), Convert.ToInt32(row["ins_month"]), Convert.ToInt32(row["ins_year"]),
            row["ins_month_name"].ToString(),
            Convert.ToBoolean(row["paid_sts"])
            ));
        }
        return data.ToArray();
    }
    s_hr_employee_loan hr_employee_loan_row(System.Data.DataRow row)
    {
        return new s_hr_employee_loan(
            Convert.ToInt32(row["loan_id"]), Convert.ToInt32(row["employee_id"]), Convert.ToInt32(row["tenor"]), Convert.ToInt32(row["loan_start_month"]), Convert.ToInt32(row["loan_start_year"]),
            Convert.ToInt32(row["loan_amount"]), Convert.ToInt32(row["installment"]),
            row["str_loan_date"].ToString(), row["note"].ToString(), row["note"].ToString(), row["loan_start_month_name"].ToString(), row["employee_name"].ToString(),
            Convert.ToBoolean(row["paidoff_sts"]), Convert.ToBoolean(row["approve_sts"]), Convert.ToInt16(row["wageparam_id"])
            );
    }
    [WebMethod]
    public s_hr_employee_loan[] hr_employee_loan_unapprove_list()
    {
        List<s_hr_employee_loan> data = new List<s_hr_employee_loan>();

        string strSQL = "select loan_id,employee_id,dbo.f_convertDateToChar(loan_date)str_loan_date,note,tenor,loan_amount,loan_no,loan_start_month,loan_start_year,loan_start_month_name,employee_name, paidoff_sts, installment, approve_sts, wageparam_id from v_hr_employee_loan where approve_sts=0";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(hr_employee_loan_row(row));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_hr_employee_loan hr_employee_loan_data(string loan_id)
    {
        s_hr_employee_loan data = new s_hr_employee_loan();

        string strSQL = "select loan_id,employee_id,dbo.f_convertDateToChar(loan_date)str_loan_date,note,tenor,loan_amount,loan_no,loan_start_month,loan_start_year,loan_start_month_name,employee_name, paidoff_sts, installment, approve_sts, wageparam_id from v_hr_employee_loan where loan_id=" + loan_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = hr_employee_loan_row(row);
        }
        return data;
    }
    public s_hr_salary_employee_wageparam hr_salary_employee_wageparam_row(System.Data.DataRow row)
    {
        return new s_hr_salary_employee_wageparam(
            Convert.ToInt32(row["salary_employee_wageparam_id"]), Convert.ToInt32(row["salary_employee_id"]), Convert.ToInt32(row["wageparam_id"]), Convert.ToInt32(row["employee_id"]), Convert.ToInt32(row["total"]),
            Convert.ToInt32(row["nilai"]), Convert.ToInt32(row["total_nilai"]),
            Convert.ToBoolean(row["tetap_sts"]), Convert.ToBoolean(row["delete_restrict_sts"]),
            row["employee_name"].ToString(), row["salary_name"].ToString(), row["wageparam_name"].ToString(), row["type_id"].ToString(), row["type_name"].ToString(), row["note"].ToString()
        );
    }
    [WebMethod]
    public s_hr_salary_employee_wageparam[] hr_salary_employee_wageparam_list(string salary_employee_id)
    {
        List<s_hr_salary_employee_wageparam> data = new List<s_hr_salary_employee_wageparam>();

        string strSQL = "select salary_employee_wageparam_id,salary_employee_id,wageparam_id,nilai,total,tetap_sts,employee_name,salary_name,wageparam_name,type_id,type_name, employee_id, total_nilai,delete_restrict_sts, note from v_hr_salary_employee_wageparam where salary_employee_id=" + salary_employee_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(hr_salary_employee_wageparam_row(row));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_hr_salary_employee_wageparam hr_salary_employee_wageparam_data(string salary_employee_wageparam_id)
    {
        s_hr_salary_employee_wageparam data = new s_hr_salary_employee_wageparam();

        string strSQL = "select salary_employee_wageparam_id,salary_employee_id,wageparam_id,nilai,total,tetap_sts,employee_name,salary_name,wageparam_name,type_id,type_name, employee_id, total_nilai,delete_restrict_sts, note from v_hr_salary_employee_wageparam where salary_employee_wageparam_id=" + salary_employee_wageparam_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = hr_salary_employee_wageparam_row(row);
        }
        return data;
    }
    public s_hr_salary_employee hr_salary_row(System.Data.DataRow row)
    {
        return new s_hr_salary_employee(
            Convert.ToInt32(row["salary_employee_id"]), Convert.ToInt32(row["salary_id"]), Convert.ToInt32(row["employee_id"]),
            row["employee_name"].ToString(), row["salary_date"].ToString(), Convert.ToInt32(row["total_salary"])
        );
    }
    [WebMethod]
    public s_hr_salary_employee[] hr_salary_employee_list(string salary_id)
    {
        List<s_hr_salary_employee> data = new List<s_hr_salary_employee>();

        string strSQL = "select salary_employee_id,salary_id,employee_id,employee_name,dbo.f_convertDateToChar(salary_date)salary_date, total_salary from v_hr_salary_employee where salary_id=" + salary_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(hr_salary_row(row));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_hr_salary_employee hr_salary_employee_data(string salary_employee_id)
    {
        s_hr_salary_employee data = new s_hr_salary_employee();

        string strSQL = "select salary_employee_id,salary_id,employee_id,employee_name,dbo.f_convertDateToChar(salary_date)salary_date, total_salary from v_hr_salary_employee where salary_id=" + salary_employee_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = hr_salary_row(row);
        }
        return data;
    }
    [WebMethod]
    public s_hr_salary hr_salary_data(string salary_id)
    {
        s_hr_salary data = new s_hr_salary();

        string strSQL = "select salary_id,salary_name,month_issue,year_issue,dbo.f_convertDateToChar(salary_date)salary_date,month_name from v_hr_salary where salary_id=" + salary_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_hr_salary(
                Convert.ToInt32(row["salary_id"]), Convert.ToInt32(row["month_issue"]), Convert.ToInt32(row["year_issue"]),
                row["salary_name"].ToString(), row["salary_date"].ToString(), row["month_name"].ToString()
            );
        }
        return data;
    }
    public s_hr_employee_wageparam get_hr_employee_wageparam_row(System.Data.DataRow row)
    {
        return new s_hr_employee_wageparam(
                Convert.ToInt32(row["employeewageparam_id"]), Convert.ToInt32(row["employee_id"]), Convert.ToInt32(row["wageparam_id"]), Convert.ToInt32(row["nilai"]),
                row["employee_name"].ToString(), row["wageparam_name"].ToString(), row["type_id"].ToString(), row["type_name"].ToString(), Convert.ToBoolean(row["open_multiplier_sts"])
            );
    }
    [WebMethod]
    public s_hr_employee_wageparam hr_employee_wageparam_data(string employeewageparam_id)
    {
        s_hr_employee_wageparam data = new s_hr_employee_wageparam();

        string strSQL = "select employeewageparam_id,employee_id,wageparam_id,nilai,employee_name,wageparam_name,type_id,type_name,open_multiplier_sts from  v_hr_employee_wageparam where employeewageparam_id=" + employeewageparam_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = get_hr_employee_wageparam_row(row);
        }
        return data;
    }
    [WebMethod]
    public s_hr_employee_wageparam[] hr_employee_wageparam_list(string employee_id)
    {
        List<s_hr_employee_wageparam> data = new List<s_hr_employee_wageparam>();

        string strSQL = "select employeewageparam_id,employee_id,wageparam_id,nilai,employee_name,wageparam_name,type_id,type_name,open_multiplier_sts from  v_hr_employee_wageparam where employee_id=" + employee_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(get_hr_employee_wageparam_row(row));
        }
        return data.ToArray();
    }

    [WebMethod]
    public s_hr_wageparam hr_wageparam_data(string wageparam_id)
    {
        s_hr_wageparam data = new s_hr_wageparam();

        string strSQL = "SELECT wageparam_id, wageparam_name, type_id, type_name FROM v_hr_wageparam where wageparam_id=" + wageparam_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_hr_wageparam(
                Convert.ToInt32(row["wageparam_id"]),
                row["wageparam_name"].ToString(), row["type_id"].ToString(), row["type_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_hr_employee hr_employee_data(string employee_id)
    {
        s_hr_employee data = new s_hr_employee();

        string strSQL = "select employee_id,nik,employee_name,dbo.f_convertDateToChar(date_in)str_date_in,dbo.f_convertDateToChar(date_out)str_date_out,position_id,status,position_name from v_hr_employee where employee_id=" + employee_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_hr_employee(
                Convert.ToInt32(row["employee_id"]), Convert.ToInt32(row["position_id"]),
                row["nik"].ToString(), row["employee_name"].ToString(), row["str_date_in"].ToString(), row["str_date_out"].ToString(), row["position_name"].ToString(),
                Convert.ToBoolean(row["status"])
            );
        }
        return data;
    }
    [WebMethod]
    public s_hr_position hr_position_data(string position_id)
    {
        s_hr_position data = new s_hr_position();

        string strSQL = "select position_id, position_name from v_hr_position where position_id=" + position_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_hr_position(
                Convert.ToInt32(row["position_id"]), row["position_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_opr_vendor_category_merk[] opr_vendor_category_merk_list_by_vendor(string vendor_id)
    {
        List<s_opr_vendor_category_merk> data = new List<s_opr_vendor_category_merk>();

        string strSQL = "select vendor_id, vendor_category_id, merk_id, vendor_name, vendor_category_name, merk_name from v_opr_vendor_category_merk where vendor_id = " + vendor_id + " order by vendor_category_name, merk_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_opr_vendor_category_merk(
                Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_category_id"]), Convert.ToInt32(row["merk_id"]),
                row["vendor_name"].ToString(), row["vendor_category_name"].ToString(), row["merk_name"].ToString()
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_opr_vendor_category_merk[] opr_vendor_category_merk_list(string vendor_id, string vendor_category_id)
    {
        List<s_opr_vendor_category_merk> data = new List<s_opr_vendor_category_merk>();

        string strSQL = "select vendor_id, vendor_category_id, merk_id, vendor_name, vendor_category_name, merk_name from v_opr_vendor_category_merk where vendor_id = " + vendor_id + " and vendor_category_id = " + vendor_category_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_opr_vendor_category_merk(
                Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_category_id"]), Convert.ToInt32(row["merk_id"]),
                row["vendor_name"].ToString(), row["vendor_category_name"].ToString(), row["merk_name"].ToString()
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_opr_vendor_category_merk opr_vendor_category_merk_data(string vendor_id, string vendor_category_id, string merk_id)
    {
        s_opr_vendor_category_merk data = new s_opr_vendor_category_merk();

        string strSQL = "select vendor_id, vendor_category_id, merk_id, vendor_name, vendor_category_name, merk_name from v_opr_vendor_category_merk where vendor_id = " + vendor_id + " and vendor_category_id = " + vendor_category_id + " and merk_id = " + merk_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_vendor_category_merk(
                Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_category_id"]), Convert.ToInt32(row["merk_id"]),
                row["vendor_name"].ToString(), row["vendor_category_name"].ToString(), row["merk_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_opr_vendor_category[] opr_vendor_category_list(string vendor_id)
    {
        List<s_opr_vendor_category> data = new List<s_opr_vendor_category>();

        string strSQL = "select vendor_id, vendor_category_id, vendor_name, vendor_category_name from v_opr_vendor_category where vendor_id = " + vendor_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_opr_vendor_category(
                Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_category_id"]), row["vendor_name"].ToString(), row["vendor_category_name"].ToString()
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_opr_vendor_category opr_vendor_category_data(string vendor_id, string vendor_category_id)
    {
        s_opr_vendor_category data = new s_opr_vendor_category();

        string strSQL = "select vendor_id, vendor_category_id, vendor_name, vendor_category_name from v_opr_vendor_category where vendor_id = " + vendor_id + " and vendor_category_id = " + vendor_category_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_vendor_category(
                Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_category_id"]), row["vendor_name"].ToString(), row["vendor_category_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_par_merk par_merk_data(string merk_id)
    {
        s_par_merk data = new s_par_merk();

        string strSQL = "select merk_id, merk_name from par_merk where merk_id =" + merk_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_par_merk(
                Convert.ToInt32(row["merk_id"]), row["merk_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_par_vendor_category par_vendor_category_data(string vendor_category_id)
    {
        s_par_vendor_category data = new s_par_vendor_category();

        string strSQL = "select vendor_category_id, vendor_category_name from par_vendor_category where vendor_category_id =" + vendor_category_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_par_vendor_category(
                Convert.ToInt32(row["vendor_category_id"]), row["vendor_category_name"].ToString()
            );
        }
        return data;
    }

    [WebMethod]
    public s_act_marketing_group act_marketing_group_data(string marketing_group_id)
    {
        s_act_marketing_group data = new s_act_marketing_group();

        string strSQL = "select marketing_group_id, marketing_group_name, target_value from v_act_marketing_group where marketing_group_id =" + marketing_group_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_act_marketing_group(
                Convert.ToInt32(row["marketing_group_id"]), row["marketing_group_name"].ToString(), Convert.ToInt32(row["target_value"])
            );
        }
        return data;
    }
    [WebMethod]
    public s_fin_receivable_payment_reverse fin_receivable_payment_reverse_data(string fin_receivable_payment_reverse_id)
    {
        s_fin_receivable_payment_reverse data = new s_fin_receivable_payment_reverse();

        string strSQL = "select fin_receivable_payment_reverse_id,fin_receivable_payment_id,journal_transaction_id,pph_amount,receivable_amount,dbo.f_convertDateToChar(reverse_date)reverse_date,customer_name,invoice_no from v_fin_receivable_payment_reverse where fin_receivable_payment_reverse_id=" + fin_receivable_payment_reverse_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_receivable_payment_reverse(
                Convert.ToInt32(row["fin_receivable_payment_reverse_id"]), Convert.ToInt32(row["fin_receivable_payment_id"]), Convert.ToInt32(row["journal_transaction_id"]), Convert.ToInt32(row["pph_amount"]), Convert.ToInt32(row["receivable_amount"]),
                row["reverse_date"].ToString(), row["customer_name"].ToString(), row["invoice_no"].ToString()
                );
        }
        return data;
    }
    [WebMethod]
    public s_fin_receivable_payment fin_receivable_payment_data(string fin_receivable_payment_id)
    {
        s_fin_receivable_payment data = new s_fin_receivable_payment();

        string strSQL = "select fin_receivable_payment_id,fin_receivable_id,journal_transaction_id,pph_amount,receivable_amount,dbo.f_convertDateToChar(payment_date)payment_date,payment_receivable_status_id,	type_transaction,	customer_name,	invoice_no,	reverse_sign_sts, isnull(fin_receivable_payment_reverse_id,0)fin_receivable_payment_reverse_id, isnull(dbo.f_convertDateToChar(reverse_date),'') reverse_date from v_fin_receivable_payment where fin_receivable_payment_id=" + fin_receivable_payment_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_receivable_payment(
                Convert.ToInt32(row["fin_receivable_payment_id"]), Convert.ToInt32(row["fin_receivable_id"]), Convert.ToInt32(row["journal_transaction_id"]), Convert.ToInt32(row["pph_amount"]), Convert.ToInt32(row["receivable_amount"]), Convert.ToInt32(row["fin_receivable_payment_reverse_id"]),
                row["payment_date"].ToString(), row["payment_receivable_status_id"].ToString(), row["type_transaction"].ToString(), row["customer_name"].ToString(), row["invoice_no"].ToString(), row["reverse_date"].ToString(),
                Convert.ToBoolean(row["reverse_sign_sts"])
                );
        }
        return data;
    }
    [WebMethod]
    public s_acc_journal_transaction_detail[] acc_journal_transaction_detail_list(string journal_transaction_id)
    {
        List<s_acc_journal_transaction_detail> data = new List<s_acc_journal_transaction_detail>();

        string strSQL = "select journal_transaction_id,coa_id,amount,dbcr_id,coa_code,coa_name,coa_type_id,coa_type_name from v_acc_journal_transaction_detail where journal_transaction_id=" + journal_transaction_id + " order by coa_name";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_acc_journal_transaction_detail(
                Convert.ToInt32(row["journal_transaction_id"]), Convert.ToInt32(row["coa_id"]), Convert.ToInt32(row["amount"]), Convert.ToInt32(row["coa_type_id"]),
                row["dbcr_id"].ToString(), row["coa_code"].ToString(), row["coa_name"].ToString(), row["coa_type_name"].ToString()
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_receivable_reverse fin_receivable_reverse_data(string fin_receivable_reverse_id)
    {
        s_fin_receivable_reverse data = new s_fin_receivable_reverse();

        string strSQL = "select fin_receivable_reverse_id, dbo.f_convertDateToChar(transaction_date)transaction_date, transaction_type,invoice_no, fin_receivable_id, journal_transaction_id, pph_amount, receivable_amount, customer_name,journal_function_code from v_fin_receivable_reverse where fin_receivable_reverse_id =" + fin_receivable_reverse_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_receivable_reverse(
                Convert.ToInt32(row["fin_receivable_reverse_id"]), Convert.ToInt32(row["fin_receivable_id"]), Convert.ToInt32(row["journal_transaction_id"]), Convert.ToInt32(row["pph_amount"]), Convert.ToInt32(row["receivable_amount"]),
                row["transaction_date"].ToString(), row["transaction_type"].ToString(), row["invoice_no"].ToString(), row["customer_name"].ToString(), row["customer_name"].ToString()
                );
        }
        return data;
    }
    [WebMethod]
    public s_fin_receivable fin_receivable_data(string fin_receivable_id)
    {
        s_fin_receivable data = new s_fin_receivable();

        string strSQL = "select receivable_status_id,receivable_status, dbo.f_convertDateToChar(payment_date)payment_date,fin_receivable_id,dbo.f_convertDateToChar(transaction_date) transaction_date,pph_amount,receivable_amount,journal_transaction_id,journal_function_code,journal_function_name,type_transaction,invoice_salesservice_id,invoice_no,customer_name,reverse_sign_sts,dbo.f_convertDateToChar(reverse_date)reverse_date from v_fin_receivable where fin_receivable_id=" + fin_receivable_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_receivable(
                Convert.ToInt32(row["fin_receivable_id"]), Convert.ToInt32(row["pph_amount"]), Convert.ToInt32(row["receivable_amount"]),
                Convert.ToInt32(row["journal_transaction_id"]), Convert.ToInt32(row["invoice_salesservice_id"]),
                row["transaction_date"].ToString(), row["journal_function_code"].ToString(), row["journal_function_name"].ToString(), row["type_transaction"].ToString(),
                row["invoice_no"].ToString(), row["customer_name"].ToString(), Convert.ToBoolean(row["reverse_sign_sts"]),
                row["reverse_date"].ToString(), row["payment_date"].ToString(), row["receivable_status_id"].ToString(), row["receivable_status"].ToString()
                );
        }
        return data;
    }
    [WebMethod]
    public s_acc_journal_function_detail acc_journal_function_detail_data(string journal_function_detail_code)
    {
        s_acc_journal_function_detail data = new s_acc_journal_function_detail();

        string strSQL = "select journal_function_code,journal_function_name,journal_function_detail_name,journal_function_detail_code,coa_id,dbcr_id,coa_name, dbcr_name from v_acc_journal_function_detail where journal_function_detail_code='" + journal_function_detail_code + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_acc_journal_function_detail(
                row["journal_function_code"].ToString(), row["journal_function_detail_code"].ToString(), row["journal_function_detail_name"].ToString(),
                row["dbcr_id"].ToString(), row["coa_name"].ToString(), row["dbcr_name"].ToString(), Convert.ToInt32(row["coa_id"])
                );

        }
        return data;
    }
    [WebMethod]
    public s_acc_journal_function_detail[] acc_journal_function_detail_list(string journal_function_code)
    {
        List<s_acc_journal_function_detail> data = new List<s_acc_journal_function_detail>();

        string strSQL = "select journal_function_code,journal_function_name,journal_function_detail_name,journal_function_detail_code,coa_id,dbcr_id,coa_name, dbcr_name from v_acc_journal_function_detail where journal_function_code='" + journal_function_code + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_acc_journal_function_detail(
                row["journal_function_code"].ToString(), row["journal_function_detail_code"].ToString(), row["journal_function_detail_name"].ToString(),
                row["dbcr_id"].ToString(), row["coa_name"].ToString(), row["dbcr_name"].ToString(), Convert.ToInt32(row["coa_id"])
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_acc_journal_function acc_journal_function_data(string journal_function_code)
    {
        s_acc_journal_function data = new s_acc_journal_function();

        string strSQL = "select journal_function_code, journal_function_name from v_acc_journal_function where journal_function_code='" + journal_function_code + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_acc_journal_function(
                row["journal_function_code"].ToString(), row["journal_function_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_acc_coa[] acc_coa_child_list(string parent_coa_id)
    {
        List<s_acc_coa> data = new List<s_acc_coa>();

        string strSQL = "select coa_id, coa_code, coa_name, coa_type_id, coa_type_name, parent_coa_id, parent_coa_name from v_acc_coa where parent_coa_id = " + parent_coa_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_acc_coa(
                Convert.ToInt32(row["coa_id"]), Convert.ToInt32(row["coa_type_id"]), Convert.ToInt32(row["parent_coa_id"]),
                row["coa_code"].ToString(), row["coa_name"].ToString(), row["coa_type_name"].ToString(), row["parent_coa_name"].ToString()
                )
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_acc_coa acc_coa_data(string coa_id)
    {
        s_acc_coa data = new s_acc_coa();

        string strSQL = "select coa_id, coa_code, coa_name, coa_type_id, coa_type_name, parent_coa_id, parent_coa_name from v_acc_coa where coa_id = " + coa_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_acc_coa(
                Convert.ToInt32(row["coa_id"]), Convert.ToInt32(row["coa_type_id"]), Convert.ToInt32(row["parent_coa_id"]),
                row["coa_code"].ToString(), row["coa_name"].ToString(), row["coa_type_name"].ToString(), row["parent_coa_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_acc_coa_type acc_coa_type_data(string coa_type_id)
    {
        s_acc_coa_type data = new s_acc_coa_type();

        string strSQL = "select coa_type_id, coa_type_name from v_acc_coa_type where coa_type_id = " + coa_type_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_acc_coa_type(
                Convert.ToInt32(row["coa_type_id"]), row["coa_type_name"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_app_parameter_user app_parameter_user_data(string code, string type_id)
    {
        s_app_parameter_user data = new s_app_parameter_user();

        string strSQL = "select code, type_id, description,active,parameter_type from v_app_parameter_user where type_id='" + type_id + "' and code='" + code + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_app_parameter_user(
                row["code"].ToString(), row["type_id"].ToString(), row["description"].ToString(), row["parameter_type"].ToString(),
                Convert.ToBoolean(row["active"])
            );
        }
        return data;
    }
    [WebMethod]
    public s_par_principal_price_dtl par_principal_price_dtl_data(string param_pp_dtl_id)
    {
        s_par_principal_price_dtl data = new s_par_principal_price_dtl();

        string strSQL = "select param_pp_id,param_pp_dtl_id,range1,range2,pcg from v_par_principal_price_dtl where param_pp_dtl_id=" + param_pp_dtl_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_par_principal_price_dtl(
                Convert.ToInt32(row["param_pp_id"]), Convert.ToInt32(row["param_pp_dtl_id"]),
                Convert.ToInt32(row["range1"]), Convert.ToDouble(row["range2"]), Convert.ToInt32(row["pcg"])
            );
        }
        return data;
    }
    [WebMethod]
    public s_par_principal_price_dtl[] par_principal_price_dtl_list(string param_pp_id)
    {
        List<s_par_principal_price_dtl> data = new List<s_par_principal_price_dtl>();

        string strSQL = "select param_pp_id,param_pp_dtl_id,range1,range2,pcg from v_par_principal_price_dtl where param_pp_id=" + param_pp_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_par_principal_price_dtl(
                Convert.ToInt32(row["param_pp_id"]), Convert.ToInt32(row["param_pp_dtl_id"]),
                Convert.ToInt32(row["range1"]), Convert.ToDouble(row["range2"]), Convert.ToInt32(row["pcg"])
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_par_principal_price par_principal_price_data(string param_pp_id)
    {
        s_par_principal_price data = new s_par_principal_price();

        string strSQL = "select param_pp_id,par_principal_price_type_id,active_sts,dbo.f_convertDateToChar(active_date)active_date,dbo.f_convertDateToChar(deactive_date) deactive_date,description from v_par_principal_price where param_pp_id=" + param_pp_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_par_principal_price(
                Convert.ToInt32(row["param_pp_id"]), Convert.ToInt32(row["par_principal_price_type_id"]), row["description"].ToString(),
                row["active_date"].ToString(), row["deactive_date"].ToString(), Convert.ToBoolean(row["active_sts"])

            );
        }
        return data;
    }
    [WebMethod]
    public s_fin_petty_cash_transaction_hdr[] fin_petty_cash_transaction_hdr_unapprove_list(string branch_id)
    {
        List<s_fin_petty_cash_transaction_hdr> data = new List<s_fin_petty_cash_transaction_hdr>();

        string strSQL = "select * from (select done_sts,approve_sts,v_fin_petty_cash_transaction_hdr.petty_cash_transaction_hdr_id,petty_cash_name_id,dbo.f_convertDateToChar(begin_date)begin_date,dbo.f_convertDateToChar(close_date)close_date,petty_cash_name,begin_saldo,(begin_saldo+a.total_amount) as end_saldo from v_fin_petty_cash_transaction_hdr left join(select petty_cash_transaction_hdr_id,sum(case when transaction_type_id='1' then 1 else -1 end * amount)total_amount from v_fin_petty_cash_transaction_dtl group by petty_cash_transaction_hdr_id )a on a.petty_cash_transaction_hdr_id=v_fin_petty_cash_transaction_hdr.petty_cash_transaction_hdr_id where done_sts=0 and approve_sts=0 and branch_id like '" + branch_id + "')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_fin_petty_cash_transaction_hdr(
                Convert.ToInt32(row["petty_cash_transaction_hdr_id"]), Convert.ToInt32(row["petty_cash_name_id"]),
                Convert.ToInt32(row["begin_saldo"]), Convert.ToInt32(row["end_saldo"]), row["begin_date"].ToString(), row["close_date"].ToString(), row["petty_cash_name"].ToString(),
                Convert.ToBoolean(row["done_sts"]), Convert.ToBoolean(row["approve_sts"])
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_petty_cash_transaction_dtl[] fin_petty_cash_transaction_dtl_cash_advance_list(string parent_dtl_id)
    {
        List<s_fin_petty_cash_transaction_dtl> data = new List<s_fin_petty_cash_transaction_dtl>();

        string strSQL = "select petty_cash_transaction_dtl_id,petty_cash_category_id,petty_cash_category,note,amount,show_sts from v_fin_petty_cash_transaction_dtl where parent_dtl_id=" + parent_dtl_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_fin_petty_cash_transaction_dtl(
                Convert.ToInt32(row["petty_cash_transaction_dtl_id"]), 0, Convert.ToInt32(row["petty_cash_category_id"]),
                row["petty_cash_category"].ToString(), "", row["note"].ToString(), "", Convert.ToInt32(row["amount"]),
                "", 0, "", 0, false, Convert.ToBoolean(row["show_sts"])
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_petty_cash_transaction_dtl fin_petty_cash_transaction_dtl_data(string petty_cash_transaction_dtl_id)
    {
        s_fin_petty_cash_transaction_dtl data = new s_fin_petty_cash_transaction_dtl();

        string strSQL = "select isnull((select petty_cash_transaction_hdr_id from fin_petty_cash_transaction_hdr a where a.done_sts=0 and a.petty_cash_name_id=b.petty_cash_name_id),0)  default_hdr_id,petty_cash_transaction_dtl_id,petty_cash_transaction_hdr_id,petty_cash_category_id,petty_cash_category,transaction_type_id, amount,note,dbo.f_convertDateToChar(transaction_date)transaction_date,type_id,petty_cash_name_id, petty_cash_name,claim_sts from v_fin_petty_cash_transaction_dtl b where petty_cash_transaction_dtl_id=" + petty_cash_transaction_dtl_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_petty_cash_transaction_dtl(
                Convert.ToInt32(row["petty_cash_transaction_dtl_id"]), Convert.ToInt32(row["petty_cash_transaction_hdr_id"]), Convert.ToInt32(row["petty_cash_category_id"]),
                row["petty_cash_category"].ToString(), row["transaction_type_id"].ToString(), row["note"].ToString(), row["transaction_date"].ToString(), Convert.ToInt32(row["amount"]),
                row["type_id"].ToString(), Convert.ToInt32(row["petty_cash_name_id"]), row["petty_cash_name"].ToString(),
                Convert.ToInt32(row["default_hdr_id"]), Convert.ToBoolean(row["claim_sts"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_petty_cash_category fin_petty_cash_category_data(string petty_cash_category_id)
    {
        s_fin_petty_cash_category data = new s_fin_petty_cash_category();

        string strSQL = "select petty_cash_category_id,petty_cash_category,transaction_type_id,transaction_type,show_sts from v_fin_petty_cash_category where petty_cash_category_id=" + petty_cash_category_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_petty_cash_category(
                Convert.ToInt32(row["petty_cash_category_id"]),
                row["petty_cash_category"].ToString(), row["transaction_type_id"].ToString(), row["transaction_type"].ToString(), Convert.ToBoolean(row["show_sts"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_petty_cash_name fin_petty_cash_name_data(string petty_cash_name_id)
    {
        s_fin_petty_cash_name data = new s_fin_petty_cash_name();

        string strSQL = "select petty_cash_name_id,petty_cash_name,branch_id,branch_name from v_fin_petty_cash_name where petty_cash_name_id=" + petty_cash_name_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_petty_cash_name(
                Convert.ToInt32(row["petty_cash_name_id"]), Convert.ToInt32(row["branch_id"]),
                row["petty_cash_name"].ToString(), row["branch_name"].ToString()
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_bill[] opr_vendor_bill_list(string vendor_id)
    {
        List<s_fin_bill> data = new List<s_fin_bill>();

        string strSQL = "select bill_id, bill_name, bill_no, bill_bank_name from v_opr_vendor_bill where vendor_id=" + vendor_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_fin_bill(
                Convert.ToInt32(row["bill_id"]), row["bill_name"].ToString(), row["bill_no"].ToString(), row["bill_bank_name"].ToString()
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_bill opr_vendor_bill_data(string bill_id)
    {
        s_fin_bill data = new s_fin_bill();

        string strSQL = "select bill_id, bill_name, bill_no, bill_bank_name from v_opr_vendor_bill where bill_id=" + bill_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_bill(
                Convert.ToInt32(row["bill_id"]), row["bill_name"].ToString(), row["bill_no"].ToString(), row["bill_bank_name"].ToString()
            );


        }
        return data;
    }
    [WebMethod]
    public s_trimming_status[] tec_borrow_service_device_trimming_list(string borrow_service_id, double inventory_device_id, int device_type_id)
    {
        List<s_trimming_status> data = new List<s_trimming_status>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("tec_borrow_service_device_trimming_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.BigInt,0,inventory_device_id),
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id)
        }))
        {
            data.Add(new s_trimming_status(
                Convert.ToInt32(row["trimming_id"]), row["trimming_name"].ToString(), Convert.ToBoolean(row["status"])
            ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_borrow_service_device tec_borrow_service_device_data(string borrow_service_id, string inventory_device_id)
    {
        s_borrow_service_device data = new s_borrow_service_device();

        string strSQL = "select device_type_id, device_type,borrow_service_id,inventory_device_id,device,sn,borrow_sts from v_tec_borrow_service_device where borrow_service_id=" + borrow_service_id + " and inventory_device_id=" + inventory_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_borrow_service_device(
                Convert.ToInt32(row["borrow_service_id"]), Convert.ToInt32(row["inventory_device_id"]), row["device"].ToString(), row["sn"].ToString(),
                Convert.ToBoolean(row["borrow_sts"]), Convert.ToInt32(row["device_type_id"]), row["device_type"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_borrow_service_device[] tec_borrow_service_device_list(string borrow_service_id)
    {
        List<s_borrow_service_device> data = new List<s_borrow_service_device>();

        string strSQL = "select device_type_id, device_type,borrow_service_id,inventory_device_id,device,sn,borrow_sts from v_tec_borrow_service_device where borrow_service_id=" + borrow_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_borrow_service_device(
                Convert.ToInt32(row["borrow_service_id"]), Convert.ToInt32(row["inventory_device_id"]), row["device"].ToString(), row["sn"].ToString(),
                Convert.ToBoolean(row["borrow_sts"]), Convert.ToInt32(row["device_type_id"]), row["device_type"].ToString()
            ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_tec_borrow_service tec_borrow_service_data(string borrow_service_id)
    {
        s_tec_borrow_service data = new s_tec_borrow_service();

        string strSQL = "select borrow_service_id, dbo.f_convertDateToChar(borrow_date)borrow_date,service_id, note, dbo.f_convertDateToChar(return_date)return_date,receiver,customer_name,marketing_note,marketing_id,borrow_sts from v_tec_borrow_service where borrow_service_id=" + borrow_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_tec_borrow_service(Convert.ToInt32(row["borrow_service_id"]), Convert.ToInt32(row["service_id"]),
                row["borrow_date"].ToString(), row["return_date"].ToString(), row["note"].ToString(), row["receiver"].ToString(), row["marketing_note"].ToString(), row["customer_name"].ToString(), row["marketing_id"].ToString(),
                Convert.ToBoolean(row["borrow_sts"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_fin_transaction_vendor fin_transaction_vendor_data(string transaction_vendor_id)
    {
        s_fin_transaction_vendor data = new s_fin_transaction_vendor();

        string strSQL = "select  branch_id, branch_name, broker_id, broker_name, ppn, bill_id,transaction_vendor_id, vendor_id, dbo.f_convertDateToChar(transaction_date)transaction_date, transaction_type_id, amount,note,paid_sts,vendor_name,transaction_type,invoice_no from v_fin_transaction_vendor where transaction_vendor_id=" + transaction_vendor_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_transaction_vendor(Convert.ToInt32(row["transaction_vendor_id"]), Convert.ToInt32(row["vendor_id"]),
                row["invoice_no"].ToString(), row["transaction_date"].ToString(), row["transaction_type_id"].ToString(),
                row["note"].ToString(), Convert.ToInt32(row["amount"]), Convert.ToBoolean(row["paid_sts"]), row["transaction_type"].ToString(),
                row["vendor_name"].ToString(), Convert.ToInt32(row["bill_id"]), Convert.ToInt32(row["ppn"]),
                Convert.ToInt32(row["branch_id"]), Convert.ToInt32(row["broker_id"]),
                row["branch_name"].ToString(), row["broker_name"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_fin_claim_debt[] fin_claim_debt_list(string servicesales_id, string fin_type_id)
    {
        List<s_fin_claim_debt> data = new List<s_fin_claim_debt>();

        string strSQL = "select result_id,dbo.f_convertDateToChar(call_date) call_date,contact,result, note,fin_type_id from v_fin_claim_debt where fin_type_id='" + fin_type_id + "' and servicesales_id=" + servicesales_id + " order by call_date ";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_fin_claim_debt(Convert.ToInt32(servicesales_id), Convert.ToInt32(row["result_id"]), row["contact"].ToString(), row["note"].ToString(), row["fin_type_id"].ToString(), row["call_date"].ToString(), row["result"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_fin_result fin_result_data(string result_id)
    {
        s_fin_result data = new s_fin_result();

        string strSQL = "select result_id, result from v_fin_result where result_id=" + result_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_result(Convert.ToInt32(row["result_id"]), row["result"].ToString());
        }

        return data;
    }
    [WebMethod]
    public s_chart_data dashboard_marketing_achievment()
    {
        s_chart_data data = new s_chart_data();
        string[] marketing_list = get_marketing_list();
        List<s_chart_dataset> datasets = new List<s_chart_dataset>();

        data.labels = get_month_list();
        foreach (string marketing_id in marketing_list)
        {
            double[] net_list = get_marketing_total_net_list(marketing_id);
            datasets.Add(new s_chart_dataset(marketing_id, net_list));
        }

        data.datasets = datasets.ToArray();

        return data;
    }
    [WebMethod]
    public s_par_branch par_branch_data(string branch_id)
    {
        s_par_branch data = new s_par_branch();

        string strSQL = "select branch_id, branch_name, active_sts, location_id, address, location_address,phone, fax from v_par_branch where branch_id=" + branch_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_par_branch(Convert.ToInt32(row["branch_id"]), Convert.ToInt32(row["location_id"]), row["branch_name"].ToString(), row["address"].ToString(), Convert.ToBoolean(row["active_sts"]), row["location_address"].ToString(), row["phone"].ToString(), row["fax"].ToString());
        }

        return data;
    }
    [WebMethod]
    public s_messanger[] exp_schedule_messanger(string tanggal)
    {
        List<s_messanger> data = new List<s_messanger>();

        string strSQL = "select a.messanger_id,a.messanger_name,latitude,longitude from(select messanger_id,messanger_name,schedule_date from v_exp_schedule_service union select messanger_id,messanger_name,schedule_date from v_exp_schedule_sales )a  inner join exp_messanger on a.messanger_id=exp_messanger.messanger_id where a.messanger_id>0 and schedule_date=dbo.f_ConverToDate103('" + tanggal + "')";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_messanger(Convert.ToInt32(row["messanger_id"]), row["messanger_name"].ToString(), true, "", "", "", ""));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_xml_exp_schedule_map[] exp_schedule_map_matrix_distance_messanger(string tanggal, string messanger_id)
    {
        List<s_xml_exp_schedule_map> data = new List<s_xml_exp_schedule_map>();

        string strSQL = "select messanger_id,latitude, longitude from v_exp_schedule_map_matrix_distance where schedule_date=dbo.f_convertDateToChar('" + tanggal + "') and messanger_id=" + messanger_id + "order by matrix_distance";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_xml_exp_schedule_map(0, "", row["latitude"].ToString(), row["longitude"].ToString(), "", "", "", 0));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_exp_schedule_map_detail xml_exp_schedule_map_detail(int schedule_id)
    {
        s_exp_schedule_map_detail data = new s_exp_schedule_map_detail();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_exp_schedule_map_detail", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id)
        }))
        {
            data = new s_exp_schedule_map_detail(row["note_ambil"].ToString(), row["note_kirim"].ToString(), Convert.ToInt32(row["messanger_id"]));
        }

        return data;
    }
    [WebMethod]
    public s_xml_exp_schedule_map[] xml_exp_schedule_map_list(string tanggal)
    {
        List<s_xml_exp_schedule_map> data = new List<s_xml_exp_schedule_map>();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_exp_schedule_map_list", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@date",System.Data.SqlDbType.VarChar,100,tanggal)
        }))
        {
            data.Add(new s_xml_exp_schedule_map(Convert.ToInt32(row["address_id"]), row["customer_name"].ToString(), row["latitude"].ToString(), row["longitude"].ToString(), row["messanger_name"].ToString(), row["address_location"].ToString(), row["address"].ToString(), Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["messanger_id"])));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_opr_service_device_component_price_history[] opr_sales_cost_history(string device_id)
    {
        List<s_opr_service_device_component_price_history> data = new List<s_opr_service_device_component_price_history>();

        string strSQL = "select top 20 dbo.f_convertDateToChar(opr_sales.offer_date)offer_date, vendor_name, cost From v_opr_sales_device inner join opr_sales on v_opr_sales_device.sales_id=opr_sales.sales_id where device_id=" + device_id + " order by opr_sales.offer_date desc";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_opr_service_device_component_price_history(row["vendor_name"].ToString(), row["offer_date"].ToString(), Convert.ToInt32(row["cost"])
                )
            );
        }
        return data.ToArray();
    }
    private string sql_opr_sales_device(string filter = "")
    {
        filter = (filter != "") ? " where " + filter : "";

        //return "select isnull(vendor_id,0) vendor_id, vendor_name, sales_id, device_id, cost, price, device, pph21_sts,qty, description, draft_sts, guarantee_id, availability_id, inden, guarantee_period from v_opr_sales_device" + filter;
        return "select * from v_opr_sales_device_all" + filter;
    }
    private s_sales_device row_opr_sales_device(System.Data.DataRow row)
    {
        return new s_sales_device(Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["price"]),
                row["device"].ToString(), Convert.ToBoolean(row["pph21_sts"]), Convert.ToInt32(row["qty"]), row["description"].ToString(),
                Convert.ToInt32(row["vendor_id"]), row["vendor_name"].ToString(), Convert.ToInt32(row["principal_price"]), Convert.ToInt32(row["price_customer"]), row["marketing_note"].ToString(), row["creator_id"].ToString(), row["create_date"].ToString(), row["update_id"].ToString(), row["update_date"].ToString(), Convert.ToBoolean(row["draft_sts"]),
                row["guarantee_id"].ToString(), row["availability_id"].ToString(), Convert.ToInt32(row["inden"]), Convert.ToInt32(row["guarantee_period"]),
                row["guarantee_timetype_id"].ToString(), row["guarantee_timetype_name"].ToString(),row["availability_timetype_id"].ToString(), row["availability_timetype_name"].ToString()
            );
    }
    [WebMethod]
    public s_sales_device[] fin_sales_device_list(string invoice_sales_id)
    {
        List<s_sales_device> data = new List<s_sales_device>();
        string strSQL = sql_opr_sales_device("sales_id in (select sales_id from fin_sales_opr where invoice_sales_id=" + invoice_sales_id + ")");

        //string strSQL = "select isnull(vendor_id,0) vendor_id, vendor_name, sales_id, device_id, cost, price, device, pph21_sts,qty, description, draft_sts, guarantee_id, availability_id, inden from v_opr_sales_device where sales_id in (select sales_id from fin_sales_opr where invoice_sales_id=" + invoice_sales_id + ")";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                row_opr_sales_device(row)
                //new s_sales_device(Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["price"]),
                //row["device"].ToString(), Convert.ToBoolean(row["pph21_sts"]), Convert.ToInt32(row["qty"]), row["description"].ToString(),
                //Convert.ToInt32(row["vendor_id"]), row["vendor_name"].ToString(), 0, 0, "", "", "", "", "", Convert.ToBoolean(row["draft_sts"]),
                //row["guarantee_id"].ToString(), row["availability_id"].ToString(), Convert.ToInt32(row["inden"])
                //)
            );
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_opr_service_device_component[] fin_service_device_component_list(string invoice_service_id)
    {
        List<s_opr_service_device_component> data = new List<s_opr_service_device_component>();

        string strSQL = "select service_id, service_device_id, device_id, pph21,device,price,total from v_opr_service_device_component where service_id in (select service_id from fin_service_opr where invoice_service_id=" + invoice_service_id + ")";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_opr_service_device_component(Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["service_device_id"]),
                    Convert.ToInt16(row["device_id"]), Convert.ToInt32(row["price"]),
                Convert.ToInt32(row["total"]), row["device"].ToString(), Convert.ToBoolean(row["pph21"]), false

            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_coa fin_coa_data(string coa_id)
    {
        s_fin_coa data = new s_fin_coa();

        string strSQL = "select coa_id, coa_code, coa_name, ticket_type_id, ticket_type, financial_transaction_type_id,financial_transaction_type from v_fin_coa where coa_id=" + coa_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_coa(Convert.ToInt32(row["coa_id"]),
                    row["coa_code"].ToString(), row["coa_name"].ToString(), row["ticket_type_id"].ToString(), row["ticket_type"].ToString(),
                    row["financial_transaction_type_id"].ToString(), row["financial_transaction_type"].ToString()
            );

        }
        return data;
    }
    [WebMethod]
    public s_exp_schedule_borrow_inventory_device[] exp_schedule_borrow_inventory_device_list(string borrow_id)
    {
        List<s_exp_schedule_borrow_inventory_device> data = new List<s_exp_schedule_borrow_inventory_device>();

        string strSQL = "select borrow_id, inventory_device_id, sn, device from v_exp_schedule_borrow_inventory_device where borrow_id=" + borrow_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_exp_schedule_borrow_inventory_device(Convert.ToInt32(row["borrow_id"]), Convert.ToInt32(row["inventory_device_id"]), row["sn"].ToString(), row["device"].ToString()
            ));
        }
        return data.ToArray();
    }
    [WebMethod]
    public s_exp_schedule_borrow exp_schedule_borrow_data(string borrow_id)
    {
        s_exp_schedule_borrow data = new s_exp_schedule_borrow();

        string strSQL = "select code,borrow_id,schedule_id,dbo.f_convertdatetochar(borrow_end_date)borrow_end_date,customer_id,address_location,address,customer_name,borrow_note,borrowed_for_id, borrowed_for,borrow_sts_id, borrow_sts from v_exp_schedule_borrow where borrow_id=" + borrow_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_exp_schedule_borrow(Convert.ToInt32(row["borrow_id"]), Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["customer_id"]),
                    row["borrow_end_date"].ToString(), row["address_location"].ToString(), row["address"].ToString(), row["customer_name"].ToString(),
                    row["borrow_note"].ToString(), row["borrowed_for_id"].ToString(), row["borrowed_for"].ToString(),
                    row["borrow_sts_id"].ToString(), row["borrow_sts"].ToString(), row["code"].ToString()
            );

        }
        return data;
    }
    [WebMethod]
    public s_exp_schedule_borrow[] exp_schedule_borrow_list(string schedule_id)
    {
        List<s_exp_schedule_borrow> data = new List<s_exp_schedule_borrow>();

        string strSQL = "select code,borrow_id,schedule_id,dbo.f_convertdatetochar(borrow_end_date)borrow_end_date,customer_id,address_location,address,customer_name,borrow_note,borrowed_for_id, borrowed_for,borrow_sts_id, borrow_sts from v_exp_schedule_borrow where schedule_id=" + schedule_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_exp_schedule_borrow(Convert.ToInt32(row["borrow_id"]), Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["customer_id"]),
                    row["borrow_end_date"].ToString(), row["address_location"].ToString(), row["address"].ToString(), row["customer_name"].ToString(),
                    row["borrow_note"].ToString(), row["borrowed_for_id"].ToString(), row["borrowed_for"].ToString(),
                    row["borrow_sts_id"].ToString(), row["borrow_sts"].ToString(), row["code"].ToString()
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_tec_inventory_device tec_inventory_device_data(string inventory_device_id)
    {
        s_tec_inventory_device data = new s_tec_inventory_device();

        string strSQL = "select inventory_device_id, inventory_id, device_register_id,device_id,sn,device from v_tec_inventory_device where inventory_device_id=" + inventory_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_tec_inventory_device(Convert.ToInt32(row["inventory_device_id"]), Convert.ToInt32(row["inventory_id"]), Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]), row["sn"].ToString(), row["device"].ToString());

        }

        return data;
    }
    [WebMethod]
    public s_tec_inventory_device[] tec_inventory_device_list(string inventory_id)
    {
        List<s_tec_inventory_device> data = new List<s_tec_inventory_device>();

        string strSQL = "select inventory_device_id, inventory_id, device_register_id,device_id,sn,device from v_tec_inventory_device where inventory_id=" + inventory_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_tec_inventory_device(Convert.ToInt32(row["inventory_device_id"]), Convert.ToInt32(row["inventory_id"]), Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]), row["sn"].ToString(), row["device"].ToString()
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_tec_inventory tec_inventory_data(string inventory_id)
    {
        s_tec_inventory data = new s_tec_inventory();

        string strSQL = "select inventory_id, vendor_id, dbo.f_convertDateToChar(inventory_in)inventory_in, dbo.f_convertDateToChar(inventory_out)inventory_out,inventory_type_id,invoice_no,inventory_sts,vendor_name,inventory_type,access_service_data_sts from v_tec_inventory where inventory_id=" + inventory_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_tec_inventory(Convert.ToInt32(row["inventory_id"]), Convert.ToInt32(row["vendor_id"]),
                row["inventory_in"].ToString(), row["inventory_out"].ToString(), row["inventory_type_id"].ToString(), row["invoice_no"].ToString(), row["vendor_name"].ToString(), row["inventory_type"].ToString(),
                Convert.ToBoolean(row["inventory_sts"]), Convert.ToBoolean(row["access_service_data_sts"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_schedule_sales[] tec_schedule_sales_list(string schedule_id)
    {
        List<s_schedule_sales> data = new List<s_schedule_sales>();

        string strSQL = "select schedule_id, sales_id, delivery_address_location_id,delivery_address_location,delivery_address,marketing_id,customer_name,isnull((select invoice_sales_id from exp_schedule_sales_fin where exp_schedule_sales_fin.schedule_id=v_exp_schedule_sales.schedule_id),0) kode_print from v_exp_schedule_sales where schedule_id=" + schedule_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_schedule_sales(Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["delivery_address_location_id"]),
                    row["delivery_address"].ToString(), row["delivery_address_location"].ToString(), row["marketing_id"].ToString(), row["customer_name"].ToString(),
                    Convert.ToInt32(row["kode_print"])
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_sales_opr[] fin_sales_opr_list(string invoice_sales_id)
    {
        List<s_fin_sales_opr> data = new List<s_fin_sales_opr>();

        string strSQL = "select sales_id,offer_no,dbo.f_convertDateToChar(offer_date)str_offer_date,grand_price,fee from v_fin_sales_opr  where invoice_sales_id=" + invoice_sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_fin_sales_opr(Convert.ToInt32(row["sales_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                row["offer_no"].ToString(), row["str_offer_date"].ToString()
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_sales fin_sales_data(string invoice_sales_id)
    {
        s_fin_sales data = new s_fin_sales();

        string strSQL = "select isnull(fin_receivable_id,0)fin_receivable_id,amount_cut, dbo.f_convertDateToChar(document_return_date_exp) document_return_date_exp,dbo.f_convertDateToChar(fee_date)fee_date, fee_payment, dbo.f_convertDateToChar(document_return_date) document_return_date,document_return_sts, pph_sts, invoice_note, surat_jalan_id, paid_sts, dbo.f_convertDateToChar(paid_date) paid_date, bill_id,str_top_value,customer_name, invoice_sales_id,dbo.f_convertdatetochar(invoice_date)str_invoice_date,Invoice_no,term_of_payment_id,term_of_payment,po_no,afpo_no,customer_id, an_id, grand_price,fee,send_sts,invoice_sts,total_ppn, bill_name, bill_no from v_fin_sales where invoice_sales_id=" + invoice_sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_sales(Convert.ToInt32(row["invoice_sales_id"]), row["str_invoice_date"].ToString(), row["invoice_no"].ToString(),
                row["term_of_payment_id"].ToString(), row["term_of_payment"].ToString(), row["po_no"].ToString(), row["afpo_no"].ToString(),
                Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                row["customer_name"].ToString(), row["str_top_value"].ToString(), Convert.ToInt32(row["bill_id"]),
                Convert.ToBoolean(row["paid_sts"]), row["paid_date"].ToString(), Convert.ToBoolean(row["send_sts"]), Convert.ToBoolean(row["invoice_sts"]),
                Convert.ToInt32(row["surat_jalan_id"]), row["invoice_note"].ToString(), Convert.ToBoolean(row["pph_sts"]), Convert.ToBoolean(row["document_return_sts"]),
                row["document_return_date"].ToString(), Convert.ToInt32(row["fee_payment"]), row["fee_date"].ToString(), row["document_return_date_exp"].ToString(),
                Convert.ToInt32(row["amount_cut"]), Convert.ToInt32(row["total_ppn"]), Convert.ToInt32(row["fin_receivable_id"]),
                row["bill_name"].ToString(), row["bill_no"].ToString()
            );


        }
        return data;
    }
    [WebMethod]
    public s_schedule_service[] xml_tec_service_device_schedule(int service_device_id)
    {
        List<s_schedule_service> data = new List<s_schedule_service>();

        string strSQL = "xml_tec_service_device_schedule";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ(strSQL, new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
            
            
            
        }))
        {
            data.Add(new s_schedule_service(Convert.ToInt32(row["schedule_id"]), 0, row["expedition_type"].ToString(), "", "", "", row["schedule_date"].ToString(), 0, "", row["messanger_name"].ToString(), row["exp_contact"].ToString()));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_sales_device opr_sales_device_data(string sales_id, string device_id)
    {
        s_sales_device data = new s_sales_device();

        //string strSQL = "select isnull(vendor_id,0) vendor_id, vendor_name, sales_id, device_id, cost, price, device, pph21_sts,qty, description,principal_price, marketing_note, creator_id, cast(create_date as varchar(25))create_date, update_id, cast(update_date as varchar(25))update_date, draft_sts, guarantee_id, availability_id, inden from v_opr_sales_device where sales_id=" + sales_id + " and device_id=" + device_id;
        string strSQL = sql_opr_sales_device("sales_id=" + sales_id + " and device_id=" + device_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = row_opr_sales_device(row);
                //new s_sales_device(
                //Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["price"]),
                //row["device"].ToString(), Convert.ToBoolean(row["pph21_sts"]), Convert.ToInt32(row["qty"]), row["description"].ToString(),
                //Convert.ToInt32(row["vendor_id"]), row["vendor_name"].ToString(), Convert.ToInt32(row["principal_price"]), 0,
                //row["marketing_note"].ToString(),
                //row["creator_id"].ToString(), row["create_date"].ToString(), row["update_id"].ToString(), row["update_date"].ToString(),
                //Convert.ToBoolean(row["draft_sts"])
                //);

        }
        return data;
    }
    [WebMethod]
    public s_sales_device[] opr_sales_device_list(string sales_id)
    {
        List<s_sales_device> data = new List<s_sales_device>();

        //string strSQL = "select sales_id, device_id, cost, price, device, pph21_sts,qty, principal_price, price_customer, creator_id, cast(create_date as varchar(25))create_date, update_id, cast(update_date as varchar(25))update_date, draft_sts from v_opr_sales_device where sales_id=" + sales_id;
        string strSQL = sql_opr_sales_device("sales_id=" + sales_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                row_opr_sales_device(row)
                //new s_sales_device(Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["price"]),
                //row["device"].ToString(), Convert.ToBoolean(row["pph21_sts"]), Convert.ToInt32(row["qty"]), "", 0, "", Convert.ToInt32(row["principal_price"]),
                //Convert.ToInt32(row["price_customer"]), "",
                //row["creator_id"].ToString(), row["create_date"].ToString(), row["update_id"].ToString(), row["update_date"].ToString(),
                //Convert.ToBoolean(row["draft_sts"]))
            );

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_sales_device[] opr_sales_device_nondraft_list(string sales_id)
    {
        List<s_sales_device> data = new List<s_sales_device>();

        //string strSQL = "select sales_id, device_id, cost, price, device, pph21_sts,qty, principal_price, price_customer, creator_id, cast(create_date as varchar(25))create_date, update_id, cast(update_date as varchar(25))update_date, draft_sts from v_opr_sales_device where draft_sts=0 and sales_id=" + sales_id;
        string strSQL = sql_opr_sales_device("draft_sts=0 and sales_id=" + sales_id);

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                row_opr_sales_device(row)
                //new s_sales_device(Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["cost"]), Convert.ToInt32(row["price"]),
                //row["device"].ToString(), Convert.ToBoolean(row["pph21_sts"]), Convert.ToInt32(row["qty"]), "", 0, "", Convert.ToInt32(row["principal_price"]),
                //Convert.ToInt32(row["price_customer"]), "",
                //row["creator_id"].ToString(), row["create_date"].ToString(), row["update_id"].ToString(), row["update_date"].ToString(),
                //Convert.ToBoolean(row["draft_sts"]))
            );

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_trimming tec_trimming_data(string trimming_id)
    {
        s_trimming data = new s_trimming();

        string strSQL = "select trimming_id, trimming_name from v_tec_trimming where trimming_id=" + trimming_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_trimming(Convert.ToInt32(row["trimming_id"]), row["trimming_name"].ToString());

        }
        return data;
    }
    [WebMethod]
    public s_opr_sales opr_sales_data(string sales_id)
    {
        s_opr_sales data = new s_opr_sales();

        string strSQL = "select pcg_principal_price,invoice_no, npwp_sts, group_customer_id, total_price, total_cost, total_price_pph21, total_ppn, total_pph21,net,total_discount, grand_price, ppn, pph21, customer_id,sales_status,sales_status_marketing, sales_status_id, sales_status_marketing_id, sales_id, dbo.f_convertDateToChar(offer_date)offer_date, broker_id,discount_type_id,tax_sts,opr_note,broker_name,discount_type, discount_value,customer_name,offer_no,fee,convert(varchar(20),update_status_date,105)+' '+convert(varchar(20),update_status_date,108) update_status_date, reason_marketing_id, reason_marketing, total_principal, principal_net, additional_fee, additional_fee_note,isnull(cast(sales_status_marketing_updatedate as varchar(20)),'')sales_status_marketing_updatedate, additional_cost, po_no, ctgsales_id, ctgsales from v_opr_sales where sales_id=" + sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_sales(Convert.ToInt64(row["sales_id"]), Convert.ToInt64(row["broker_id"]), Convert.ToInt64(row["discount_value"]),
                Convert.ToInt64(row["fee"]), row["offer_date"].ToString(), row["discount_type_id"].ToString(), row["opr_note"].ToString(), row["broker_name"].ToString(),
                row["discount_type"].ToString(), row["customer_name"].ToString(), row["offer_no"].ToString(),
                row["sales_status_id"].ToString(), row["sales_status_marketing_id"].ToString(), row["sales_status"].ToString(),
                row["sales_status_marketing"].ToString(), Convert.ToBoolean(row["tax_sts"]), Convert.ToInt32(row["customer_id"]),
                Convert.ToInt64(row["ppn"]), Convert.ToInt64(row["pph21"]),
                Convert.ToInt64(row["total_price"]), Convert.ToInt64(row["total_cost"]), Convert.ToInt64(row["total_price_pph21"]), Convert.ToInt64(row["total_ppn"]), Convert.ToInt64(row["total_pph21"]), Convert.ToInt64(row["total_discount"]), Convert.ToInt64(row["net"]), Convert.ToInt64(row["grand_price"]),
                Convert.ToInt32(row["group_customer_id"]), Convert.ToBoolean(row["npwp_sts"]), row["invoice_no"].ToString(),
                Convert.ToInt64(row["pcg_principal_price"]), row["update_status_date"].ToString(), row["reason_marketing_id"].ToString(),
                row["reason_marketing"].ToString(),
                Convert.ToInt64(row["total_principal"]), Convert.ToInt64(row["principal_net"]), Convert.ToInt64(row["additional_fee"]), row["additional_fee_note"].ToString(), row["sales_status_marketing_updatedate"].ToString(),
                Convert.ToInt64(row["additional_cost"]),row["po_no"].ToString(),
                row["ctgsales_id"].ToString(), row["ctgsales"].ToString()
            );

        }
        return data;
    }
    [WebMethod]
    public s_fin_bill fin_bill_data(string bill_id)
    {
        s_fin_bill data = new s_fin_bill();

        string strSQL = "select bill_id, bill_name, bill_no, bill_bank_name from v_fin_bill where bill_id=" + bill_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_bill(
                Convert.ToInt32(row["bill_id"]), row["bill_name"].ToString(), row["bill_no"].ToString(), row["bill_bank_name"].ToString()
            );


        }
        return data;
    }
    [WebMethod]
    public s_fin_service_opr[] fin_service_opr_list(string invoice_service_id)
    {
        List<s_fin_service_opr> data = new List<s_fin_service_opr>();

        string strSQL = "select service_id,offer_no,dbo.f_convertDateToChar(offer_date)str_offer_date,grand_price,fee from v_fin_service_opr where invoice_service_id=" + invoice_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_fin_service_opr(Convert.ToInt32(row["service_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                row["offer_no"].ToString(), row["str_offer_date"].ToString()
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_fin_service fin_service_data(string invoice_service_id)
    {
        s_fin_service data = new s_fin_service();

        string strSQL = "select amount_cut, dbo.f_convertDateToChar(document_return_date_exp) document_return_date_exp,dbo.f_convertDateToChar(fee_date) fee_date, fee_payment, dbo.f_convertDateToChar(document_return_date) document_return_date,pph_sts, invoice_note, surat_jalan_id, send_sts, invoice_sts, paid_sts, dbo.f_convertDateToChar(paid_date) paid_date, bill_id,str_top_value,customer_name, invoice_service_id,dbo.f_convertdatetochar(invoice_date)str_invoice_date,Invoice_no,term_of_payment_id,term_of_payment,po_no,afpo_no,customer_id, an_id, grand_price, fee,document_return_sts, bill_name, bill_no from v_fin_service where invoice_service_id=" + invoice_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_fin_service(Convert.ToInt32(row["invoice_service_id"]), row["str_invoice_date"].ToString(), row["invoice_no"].ToString(),
                row["term_of_payment_id"].ToString(), row["term_of_payment"].ToString(), row["po_no"].ToString(), row["afpo_no"].ToString(),
                Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                row["customer_name"].ToString(), row["str_top_value"].ToString(), Convert.ToInt32(row["bill_id"]),
                Convert.ToBoolean(row["paid_sts"]), row["paid_date"].ToString(), Convert.ToBoolean(row["send_sts"]), Convert.ToBoolean(row["invoice_sts"]),
                Convert.ToInt32(row["surat_jalan_id"]), row["invoice_note"].ToString(), Convert.ToBoolean(row["pph_sts"]), Convert.ToBoolean(row["document_return_sts"]),
                row["document_return_date"].ToString(), Convert.ToInt32(row["fee_payment"]), row["fee_date"].ToString(), row["document_return_date_exp"].ToString(),
                Convert.ToInt32(row["amount_cut"]), row["bill_name"].ToString(), row["bill_no"].ToString()
            );
        }
        return data;
    }
    [WebMethod]
    public s_opr_service_device[] opr_service_device_list(string service_id)
    {
        List<s_opr_service_device> data = new List<s_opr_service_device>();

        string strSQL = "select service_id, service_device_id, service_cost, sn, device, customer_name, total_price, total_cost, total_price_pph21,service_cancel,service_device_sts,user_name, total_price_customer from v_opr_service_device where service_id=" + service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_opr_service_device(Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["service_cost"]),
                Convert.ToInt32(row["total_price"]), Convert.ToInt32(row["total_cost"]), row["sn"].ToString(), row["device"].ToString(), row["customer_name"].ToString(),
                Convert.ToInt32(row["total_price_pph21"]), Convert.ToInt32(row["service_cancel"]), row["user_name"].ToString(), row["service_device_sts"].ToString(), false,
                Convert.ToInt32(row["total_price_customer"])
            ));

        }
        return data.ToArray();
    }
    [WebMethod]
    public s_opr_service_device opr_service_device_data(string service_id, string service_device_id)
    {
        s_opr_service_device data = new s_opr_service_device();

        string strSQL = "select service_id, service_device_id, service_cost, sn, device, customer_name, total_price, total_cost, total_price_pph21,service_cancel,user_name,guarantee_sts,service_device_sts from v_opr_service_device where service_id=" + service_id + " and service_device_id=" + service_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_service_device(Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["service_cost"]),
                Convert.ToInt32(row["total_price"]), Convert.ToInt32(row["total_cost"]), row["sn"].ToString(), row["device"].ToString(), row["customer_name"].ToString(),
                Convert.ToInt32(row["total_price_pph21"]), Convert.ToInt32(row["service_cancel"]), row["user_name"].ToString(), row["service_device_sts"].ToString(),
                Convert.ToBoolean(row["guarantee_sts"])
            );


        }
        return data;
    }
    [WebMethod]
    public s_opr_service opr_service_data(string service_id)
    {
        s_opr_service data = new s_opr_service();

        string strSQL = "select npwp_sts, invoice_no, ppn, pph21, total_price, total_cost, total_price_pph21, total_ppn, total_pph21, total_discount, net, grand_price,customer_id,service_status,service_status_marketing, service_status_id, service_status_marketing_id, service_id, dbo.f_convertDateToChar(offer_date)offer_date, broker_id,discount_type_id,tax_sts,opr_note,broker_name,discount_type, discount_value,customer_name,offer_no,fee,convert(varchar(20),update_status_date,105)+' '+convert(varchar(20),update_status_date,108) update_status_date, reason_marketing_id, reason_marketing, additional_fee, additional_fee_note,isnull(cast(service_status_marketing_updatedate as varchar(20)),'')service_status_marketing_updatedate, total_addicost from v_opr_service where service_id=" + service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_service(Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["broker_id"]), Convert.ToInt32(row["discount_value"]),
                Convert.ToInt32(row["fee"]), row["offer_date"].ToString(), row["discount_type_id"].ToString(), row["opr_note"].ToString(), row["broker_name"].ToString(),
                row["discount_type"].ToString(), row["customer_name"].ToString(), row["offer_no"].ToString(), row["service_status_id"].ToString(),
                row["service_status_marketing_id"].ToString(), row["service_status"].ToString(), row["service_status_marketing"].ToString(), Convert.ToBoolean(row["tax_sts"]),
                Convert.ToInt32(row["customer_id"]),
                Convert.ToInt32(row["ppn"]), Convert.ToInt32(row["pph21"]), Convert.ToInt32(row["total_price"]), Convert.ToInt32(row["total_cost"]), Convert.ToInt32(row["total_price_pph21"]),
                Convert.ToInt32(row["total_ppn"]), Convert.ToInt32(row["total_pph21"]), Convert.ToInt32(row["total_discount"]), Convert.ToInt32(row["net"]), Convert.ToInt64(row["grand_price"]),
                row["invoice_no"].ToString(), Convert.ToBoolean(row["npwp_sts"]), row["update_status_date"].ToString(), row["reason_marketing_id"].ToString(),
                row["reason_marketing"].ToString(), Convert.ToInt32(row["additional_fee"]), row["additional_fee_note"].ToString(), row["service_status_marketing_updatedate"].ToString(),Convert.ToDouble(row["total_addicost"])
            );

        }
        return data;
    }
    [WebMethod]
    public s_opr_borker opr_broker_data(string borker_id)
    {
        s_opr_borker data = new s_opr_borker();

        string strSQL = "select initial, par_tax_sts,broker_id, broker_name,broker_address, title_1,title_2,title_3,guaranti_term from v_opr_broker where broker_id=" + borker_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_opr_borker(Convert.ToInt32(row["broker_id"]), row["broker_name"].ToString(), row["broker_address"].ToString(), row["title_1"].ToString(), row["title_2"].ToString(), row["title_3"].ToString(), row["initial"].ToString(), Convert.ToBoolean(row["par_tax_sts"]), Convert.ToInt32(row["guaranti_term"]));

        }
        return data;
    }
    [WebMethod]
    public s_service_device_component tec_service_device_component_data(string service_device_id, string device_id)
    {
        s_service_device_component data = new s_service_device_component();

        string strSQL = "select service_device_id, device_id, cost, total, device from v_tec_service_device_component where service_device_id=" + service_device_id + " and device_id=" + device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_service_device_component(Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["total"]), Convert.ToInt32(row["cost"]), row["device"].ToString());

        }

        return data;
    }
    [WebMethod]
    public s_service_device_component[] tec_service_device_component_list(string service_device_id)
    {
        List<s_service_device_component> data = new List<s_service_device_component>();

        string strSQL = "select service_device_id, device_id, cost, total, device from v_tec_service_device_component where service_device_id=" + service_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_service_device_component(Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["total"]), Convert.ToInt32(row["cost"]), row["device"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_service_device_vendor tec_service_device_vendor_data(string service_device_vendor_id)
    {
        s_service_device_vendor data = new s_service_device_vendor();

        string strSQL = "select service_device_vendor_id,service_device_id, vendor_id, dbo.f_ConvertDateToChar(date_in)date_in, dbo.f_ConvertDateToChar(date_out)date_out, vendor_note, service_vendor_sts_id, vendor_name, service_vendor_sts from v_tec_service_device_vendor where service_device_vendor_id=" + service_device_vendor_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_service_device_vendor(Convert.ToInt32(row["service_device_vendor_id"]), Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["vendor_id"]),
                row["date_in"].ToString(), row["date_out"].ToString(), row["vendor_note"].ToString(), row["service_vendor_sts_id"].ToString(), row["service_vendor_sts"].ToString(), row["vendor_name"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_service_device_vendor[] tec_service_device_vendor_list(string service_device_id)
    {
        List<s_service_device_vendor> data = new List<s_service_device_vendor>();

        string strSQL = "select service_device_vendor_id,service_device_id, vendor_id, dbo.f_ConvertDateToChar(date_in)date_in, dbo.f_ConvertDateToChar(date_out)date_out, vendor_note, service_vendor_sts_id, vendor_name, service_vendor_sts from v_tec_service_device_vendor where service_device_id=" + service_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_service_device_vendor(Convert.ToInt32(row["service_device_vendor_id"]), Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["vendor_id"]),
                row["date_in"].ToString(), row["date_out"].ToString(), row["vendor_note"].ToString(), row["service_vendor_sts_id"].ToString(), row["service_vendor_sts"].ToString(), row["vendor_name"].ToString()));
        }

        return data.ToArray();
    }

    [WebMethod]
    public s_device_type_trimming[] tec_device_type_trimming_list(string device_type_id)
    {
        List<s_device_type_trimming> data = new List<s_device_type_trimming>();

        string strSQL = "select device_type_trimming_id,device_type_id,trimming_id, trimming_name from v_tec_device_type_trimming where device_type_id=" + device_type_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_device_type_trimming(Convert.ToInt32(row["device_type_trimming_id"]), Convert.ToInt32(row["device_type_id"]), Convert.ToInt32(row["trimming_id"]), row["trimming_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_technician tec_technician_data(string technician_id)
    {
        s_technician data = new s_technician();

        string strSQL = "select technician_id, technician_name, active_sts from v_tec_technician where technician_id=" + technician_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_technician(Convert.ToInt32(row["technician_id"]), row["technician_name"].ToString(), Convert.ToBoolean(row["active_sts"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_service_device tec_service_device_data(string service_device_id)
    {
        s_service_device data = new s_service_device();

        string strSQL = "select opr_service_id, schedule_id, dbo.f_convertdatetochar(schedule_date)schedule_date, service_status_marketing, invoice_no, dbo.f_convertdatetochar(invoice_date)invoice_date, offer_no, service_status, user_name, dbo.f_convertdatetochar(date_done)date_done, technician_id, technician_name, device_type_id, technician_note, service_device_id, service_id, device_register_id, service_device_sts_id,device_id,dbo.f_convertdatetochar(date_in)date_in, customer_note,sn,device, guarantee_sts, last_inventory_id from v_tec_service_device where service_device_id=" + service_device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_service_device(Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]),
                row["date_in"].ToString(), row["customer_note"].ToString(), row["sn"].ToString(), row["device"].ToString(), row["service_device_sts_id"].ToString(), Convert.ToBoolean(row["guarantee_sts"]),
                row["technician_note"].ToString(), Convert.ToInt32(row["device_type_id"]),
                Convert.ToInt32(row["technician_id"]), row["technician_name"].ToString(), row["date_done"].ToString(), row["user_name"].ToString(),
                row["offer_no"].ToString(), row["service_status"].ToString(), row["invoice_no"].ToString(), row["invoice_date"].ToString(), row["service_status_marketing"].ToString(),
                Convert.ToInt32(row["schedule_id"]), row["schedule_date"].ToString(), Convert.ToInt32(row["opr_service_id"]), Convert.ToInt32(row["last_inventory_id"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_service_device[] tec_service_device_list_by_service_id(string service_id)
    {
        List<s_service_device> data = new List<s_service_device>();

        string strSQL = "select device_type_id,service_device_id, service_id, device_register_id, service_device_sts_id,device_id,dbo.f_convertdatetochar(date_in)date_in, customer_note,sn,device, guarantee_sts from v_tec_service_device where service_id=" + service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_service_device(Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]),
                row["date_in"].ToString(), row["customer_note"].ToString(), row["sn"].ToString(), row["device"].ToString(), row["service_device_sts_id"].ToString(), Convert.ToBoolean(row["guarantee_sts"])
                ));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_vendor opr_vendor_data(string vendor_id)
    {
        s_vendor data = new s_vendor();

        string strSQL = "select access_service_data_sts, vendor_id,vendor_name, vendor_location_id, vendor_address, location_address,distance,contact_name, phone1, phone2 from v_opr_vendor where vendor_id=" + vendor_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_vendor(Convert.ToInt32(row["vendor_id"]), Convert.ToInt32(row["vendor_location_id"]), Convert.ToInt32(row["distance"]), row["vendor_name"].ToString(), row["location_address"].ToString(), row["vendor_address"].ToString(),
                row["contact_name"].ToString(), row["phone1"].ToString(), row["phone2"].ToString(), Convert.ToBoolean(row["access_service_data_sts"]));
        }

        return data;
    }
    [WebMethod]
    public s_device_register tec_device_register_data_by_sn(string sn)
    {
        s_device_register data = new s_device_register();

        string strSQL = "select device_register_id, sn,device,device_id,device_type_id,device_type,part_sts from v_tec_device_register where sn='" + sn + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_device_register(Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["device_type_id"]), row["sn"].ToString(), row["device"].ToString(), row["device_type"].ToString(), Convert.ToBoolean(row["part_sts"]));
        }

        return data;
    }
    [WebMethod]
    public s_device_register tec_device_register_data(string device_register_id)
    {
        s_device_register data = new s_device_register();

        string strSQL = "select device_register_id, sn,device,device_id,device_type_id,device_type,part_sts from v_tec_device_register where device_register_id=" + device_register_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_device_register(Convert.ToInt32(row["device_register_id"]), Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["device_type_id"]), row["sn"].ToString(), row["device"].ToString(), row["device_type"].ToString(), Convert.ToBoolean(row["part_sts"]));
        }

        return data;
    }
    [WebMethod]
    public s_device tec_device_data(string device_id)
    {
        s_device data = new s_device();

        string strSQL = "select device_id, device, device_type_id, device_type,part_sts from v_tec_device where device_id=" + device_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_device(Convert.ToInt32(row["device_id"]), Convert.ToInt32(row["device_type_id"]), row["device"].ToString(), row["device_type"].ToString(), Convert.ToBoolean(row["part_sts"]));
        }

        return data;
    }
    [WebMethod]
    public s_device_type tec_device_type_data(string device_type_id)
    {
        s_device_type data = new s_device_type();

        string strSQL = "select device_type_id, device_type,part_sts from v_tec_device_type where device_type_id=" + device_type_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_device_type(Convert.ToInt32(row["device_type_id"]), row["device_type"].ToString(), Convert.ToBoolean(row["part_sts"]));
        }

        return data;
    }
    [WebMethod]
    public s_messanger exp_messanger_data(string messanger_id)
    {
        s_messanger data = new s_messanger();

        string strSQL = "select messanger_id, messanger_name, active_sts,latitude, longitude,mobile_id, mobile_password from exp_messanger where messanger_id=" + messanger_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_messanger(Convert.ToInt32(row["messanger_id"]), row["messanger_name"].ToString(), Convert.ToBoolean(row["active_sts"]), row["latitude"].ToString(), row["longitude"].ToString(), row["mobile_id"].ToString(), row["mobile_password"].ToString());
        }

        return data;
    }
    [WebMethod]
    public s_schedule_service[] exp_schedule_service_list_group(string schedule_id)
    {
        List<s_schedule_service> data = new List<s_schedule_service>();

        //string strSQL = "select backup_sts,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,service_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id;
        //string strSQL = "select customer_id,backup_sts,min(service_id)service_id,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id + " group by backup_sts,schedule_date,expedition_type_id, schedule_id,expedition_type,customer_name,pickup_address,customer_id";
        string strSQL = "select customer_id,backup_sts,service_id,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,expedition_type,customer_name,pickup_address,	isnull((select invoice_service_id from fin_service_opr where fin_service_opr.service_id=v_exp_schedule_service.service_id),0) as kode_print from v_exp_schedule_service where schedule_id=" + schedule_id;
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_schedule_service(Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["service_id"]), row["expedition_type"].ToString(), row["customer_name"].ToString(), row["pickup_address"].ToString(), row["expedition_type_id"].ToString(), row["schedule_date"].ToString(), Convert.ToInt32(row["kode_print"]), row["backup_sts"].ToString(), "", "", Convert.ToInt32(row["customer_id"])));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_schedule_service[] exp_schedule_service_list2(string schedule_id)
    {
        List<s_schedule_service> data = new List<s_schedule_service>();

        //string strSQL = "select backup_sts,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,service_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id;
        string strSQL = "select backup_sts,service_id,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id;
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_schedule_service(Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["service_id"]), row["expedition_type"].ToString(), row["customer_name"].ToString(), row["pickup_address"].ToString(), row["expedition_type_id"].ToString(), row["schedule_date"].ToString(), Convert.ToInt32(row["kode_print"]), row["backup_sts"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_schedule_service[] exp_schedule_service_list(string schedule_id)
    {
        List<s_schedule_service> data = new List<s_schedule_service>();

        //string strSQL = "select backup_sts,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,service_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id;
        string strSQL = "select min(backup_sts)backup_sts,min(service_id)service_id,dbo.f_convertdatetochar(schedule_date)schedule_date,expedition_type_id, schedule_id,expedition_type,customer_name,pickup_address,isnull((select invoice_service_id from exp_schedule_service_fin where exp_schedule_service_fin.schedule_id=v_exp_schedule_service.schedule_id),0) kode_print from v_exp_schedule_service where schedule_id=" + schedule_id + " group by schedule_date,expedition_type_id,schedule_id,expedition_type,customer_name,pickup_address";
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_schedule_service(Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["service_id"]), row["expedition_type"].ToString(), row["customer_name"].ToString(), row["pickup_address"].ToString(), row["expedition_type_id"].ToString(), row["schedule_date"].ToString(), Convert.ToInt32(row["kode_print"]), row["backup_sts"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_schedule act_schedule_data(string schedule_id)
    {
        s_schedule data = new s_schedule();

        string strSQL = "select backup_approve_sts,contact_name, canceled_sts, schedule_id, location_id,distance, location_address,dbo.f_convertDateToChar(schedule_date)schedule_date,done_sts,messanger_id, messanger_name from v_exp_schedule where schedule_id=" + schedule_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_schedule(Convert.ToInt32(row["schedule_id"]), Convert.ToInt32(row["location_id"]), Convert.ToInt32(row["distance"]), row["schedule_date"].ToString(), row["location_address"].ToString(), Convert.ToBoolean(row["done_sts"]),
                Convert.ToInt32(row["messanger_id"]), row["messanger_name"].ToString(), row["contact_name"].ToString(), Convert.ToBoolean(row["canceled_sts"]),
                Convert.ToBoolean(row["backup_approve_sts"])
            );
        }

        return data;
    }
    [WebMethod]
    public s_location act_location_data(string location_id)
    {
        s_location data = new s_location();

        string strSQL = "select location_id, location_address, distance from v_exp_location where location_id=" + location_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_location(Convert.ToInt32(row["location_id"]), Convert.ToInt32(row["distance"]), row["location_address"].ToString());
        }

        return data;
    }

    [WebMethod]
    public s_sales act_sales_data(string sales_id)
    {
        s_sales data = new s_sales();

        string strSQL = "select branch_customer, dbo.f_convertdatetochar(delivery_date)delivery_date, npwp,group_customer_id, sales_id,customer_id,dbo.f_convertDateToChar(sales_call_date) sales_call_date,an_id,contact_id,delivery_address,customer_name,note,contact_name,an,marketing_id, delivery_address_location_id, delivery_address_location,fee, customer_phone, customer_fax, customer_email, latitude, longitude from v_act_sales where sales_id=" + sales_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_sales(Convert.ToInt32(row["sales_id"]), Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), Convert.ToInt32(row["contact_id"]),
                row["sales_call_date"].ToString(), row["delivery_address"].ToString(), row["note"].ToString(), row["customer_name"].ToString(), row["an"].ToString(),
                row["contact_name"].ToString(), row["marketing_id"].ToString(), Convert.ToInt32(row["delivery_address_location_id"]), row["delivery_address_location"].ToString(), Convert.ToInt32(row["fee"]),
                Convert.ToInt32(row["group_customer_id"]), row["npwp"].ToString(), row["delivery_date"].ToString(),
                row["customer_phone"].ToString(), row["customer_fax"].ToString(), row["customer_email"].ToString(),
                row["latitude"].ToString(), row["longitude"].ToString(),
                row["branch_customer"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_service act_service_data(string service_id)
    {
        s_service data = new s_service();

        string strSQL = "select branch_customer, backup_sts_id, backup_sts, customer_phone, customer_fax, customer_email, npwp,group_customer_id, service_id, customer_id, an_id, contact_id, dbo.f_convertDateToChar(service_call_date)service_call_date, pickup_address,note, customer_name,an,contact_name,marketing_id,pickup_address_location_id, pickup_address_location,dbo.f_convertDateToChar(pickup_date)pickup_date,fee,latitude, longitude, branch_id, branch_name from v_act_service where service_id=" + service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_service(Convert.ToInt32(row["service_id"]), Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["an_id"]), Convert.ToInt32(row["contact_id"]),
                row["service_call_date"].ToString(), row["pickup_address"].ToString(), row["note"].ToString(), row["customer_name"].ToString(), row["an"].ToString(), row["contact_name"].ToString(), row["marketing_id"].ToString(),
                Convert.ToInt32(row["pickup_address_location_id"]), row["pickup_address_location"].ToString(), row["pickup_date"].ToString(), Convert.ToInt32(row["fee"]),
                Convert.ToInt32(row["group_customer_id"]), row["npwp"].ToString(), row["customer_phone"].ToString(), row["customer_fax"].ToString(), row["customer_email"].ToString(),
                row["backup_sts_id"].ToString(), row["backup_sts"].ToString(), row["latitude"].ToString(), row["longitude"].ToString(),
                Convert.ToInt32(row["branch_id"]), row["branch_name"].ToString(), row["branch_customer"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_customer_contact act_customer_contact_data(string contact_id)
    {
        s_customer_contact data = new s_customer_contact();

        string strSQL = "select contact_id, customer_id, contact_name,contact_phone, customer_name from v_act_customer_contact where contact_id=" + contact_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_customer_contact(Convert.ToInt32(row["contact_id"]), Convert.ToInt32(row["customer_id"]), row["contact_name"].ToString(), row["contact_phone"].ToString(), row["customer_name"].ToString()
                        );
        }

        return data;
    }
    [WebMethod]
    public s_customer_contact[] act_customer_contact_list(string customer_id)
    {
        List<s_customer_contact> data = new List<s_customer_contact>();

        string strSQL = "select contact_id, customer_id, contact_name,contact_phone, customer_name from v_act_customer_contact where customer_id=" + customer_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_customer_contact(Convert.ToInt32(row["contact_id"]), Convert.ToInt32(row["customer_id"]), row["contact_name"].ToString(), row["contact_phone"].ToString(), row["customer_name"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public s_customer act_customer_data(string customer_id)
    {
        s_customer data = new s_customer();

        string strSQL = "select user_device_mandatory,npwp,customer_id, customer_name, customer_address, customer_phone,customer_fax,distance,marketing_id,customer_email,customer_address_location_id, customer_address_location,group_customer_id, group_customer, latitude, longitude, branch_id, branch_name, tkuid, jenisidpembeli_id, jenisidpembeli_name from v_act_customer where customer_id='" + customer_id + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_customer(Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["distance"]),
                        row["customer_name"].ToString(), row["customer_address"].ToString(), row["customer_phone"].ToString(), row["customer_fax"].ToString(), row["customer_email"].ToString(), row["marketing_id"].ToString(),
                        Convert.ToInt32(row["customer_address_location_id"]), row["customer_address_location"].ToString(),
                        Convert.ToInt32(row["group_customer_id"]), row["group_customer"].ToString(), row["npwp"].ToString(),
                        row["latitude"].ToString(), row["longitude"].ToString(),
                        Convert.ToInt32(row["branch_id"]), row["branch_name"].ToString(),
                        Convert.ToBoolean(row["user_device_mandatory"]),
                        row["tkuid"].ToString(),row["jenisidpembeli_id"].ToString(),row["jenisidpembeli_name"].ToString()
            );
        }

        return data;
    }
    [WebMethod]
    public s_marketing act_marketing_data(string marketing_id)
    {
        s_marketing data = new s_marketing();

        string strSQL = "select marketing_id, marketing_name, marketing_phone, user_id,all_access,dashboard_visible, target_value, isnull(marketing_group_id,0)marketing_group_id, marketing_group_name, isnull(ttd_image,0x0)ttd_image, isnull(file_type,'')file_type,assistant_user_id from v_act_marketing where marketing_id='" + marketing_id + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ_sdr(strSQL))
        {
            data = new s_marketing(
                row["marketing_id"].ToString(), row["marketing_name"].ToString(), row["marketing_phone"].ToString(), row["user_id"].ToString(), Convert.ToBoolean(row["all_access"]),
                Convert.ToBoolean(row["dashboard_visible"]), Convert.ToInt32(row["target_value"]), Convert.ToInt32(row["marketing_group_id"]), row["marketing_group_name"].ToString(),
                (byte[])row["ttd_image"], row["file_type"].ToString(), row["assistant_user_id"].ToString()
            );
        }

        return data;
    }
    //#exec
    [WebMethod]
    public void act_customer_finance_update(string customer_id, string npwp, string tkuid, string jenisidpembeli_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_finance_update", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.BigInt,0,customer_id),
            new _DBcon.sComParameter("@npwp",System.Data.SqlDbType.VarChar,50,npwp),
            new _DBcon.sComParameter("@tkuid",System.Data.SqlDbType.VarChar,50,tkuid),
            new _DBcon.sComParameter("@jenisidpembeli_id",System.Data.SqlDbType.VarChar,15,jenisidpembeli_id)
        });

    }
    [WebMethod]
    public void tmp_generate_cortex(string tanggal)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tmp_generate_cortex", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@tanggal",System.Data.SqlDbType.VarChar,10,tanggal),
        });

    }
    [WebMethod]
    public void tec_onsite_workorders_parts_add(long workorder_id, int part_id, int total)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_parts_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@workorder_id",System.Data.SqlDbType.BigInt,0,workorder_id),
            new _DBcon.sComParameter("@part_id",System.Data.SqlDbType.Int,0,part_id),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
        });

    }
    [WebMethod]
    public void tec_onsite_workorders_parts_edit(long workorder_id, int part_id, int total)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_parts_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@workorder_id",System.Data.SqlDbType.BigInt,0,workorder_id),
            new _DBcon.sComParameter("@part_id",System.Data.SqlDbType.Int,0,part_id),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
        });

    }
    [WebMethod]
    public void tec_onsite_workorders_parts_delete(long workorder_id, int part_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_parts_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@workorder_id",System.Data.SqlDbType.BigInt,0,workorder_id),
            new _DBcon.sComParameter("@part_id",System.Data.SqlDbType.Int,0,part_id),
        });

    }
    [WebMethod]
    public long tec_onsite_workorders_add(long onsite_id, int device_id, string sn, string note, string complient_note,
        string onsitedevicests_id, string segeldate, string guarantee_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@onsite_id",System.Data.SqlDbType.BigInt,0,onsite_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@complient_note",System.Data.SqlDbType.Text,0,complient_note),
            new _DBcon.sComParameter("@onsitedevicests_id",System.Data.SqlDbType.VarChar,1,onsitedevicests_id),
            new _DBcon.sComParameter("@segeldate",System.Data.SqlDbType.VarChar,10,segeldate),
            new _DBcon.sComParameter("@guarantee_date",System.Data.SqlDbType.VarChar,10,guarantee_date),
            new _DBcon.sComParameter("@ret",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt64(hasil["@ret"]);
    }
    [WebMethod]
    public void tec_onsite_workorders_edit(long workorder_id, int device_id, string sn, string note, string complient_note,
        string onsitedevicests_id, string segeldate, string guarantee_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@workorder_id",System.Data.SqlDbType.BigInt,0,workorder_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@complient_note",System.Data.SqlDbType.Text,0,complient_note),
            new _DBcon.sComParameter("@onsitedevicests_id",System.Data.SqlDbType.VarChar,1,onsitedevicests_id),
            new _DBcon.sComParameter("@segeldate",System.Data.SqlDbType.VarChar,10,segeldate),
            new _DBcon.sComParameter("@guarantee_date",System.Data.SqlDbType.VarChar,10,guarantee_date),
        });

    }
    [WebMethod]
    public void tec_onsite_workorders_delete(long workorder_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_workorders_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@workorder_id",System.Data.SqlDbType.BigInt,0,workorder_id),
        });

    }
    [WebMethod]
    public long tec_onsite_add(int customer_id, string note, string user_id, int an_id, int guarantee_onsite_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@an_id",System.Data.SqlDbType.Int,0,an_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@guarantee_onsite_id",System.Data.SqlDbType.Int,0,guarantee_onsite_id),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,15,user_id),
            new _DBcon.sComParameter("@ret",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt64(hasil["@ret"]);
    }
    [WebMethod]
    public void tec_onsite_delete(long onsite_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@onsite_id",System.Data.SqlDbType.BigInt,0,onsite_id)
        });

    }
    [WebMethod]
    public void tec_onsite_edit1(long onsite_id, string note, string onsitests_id, int guarantee_onsite_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_edit1", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@onsite_id",System.Data.SqlDbType.BigInt,0,onsite_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@onsitests_id",System.Data.SqlDbType.VarChar,1,onsitests_id),
            new _DBcon.sComParameter("@guarantee_onsite_id",System.Data.SqlDbType.Int,0,guarantee_onsite_id),
            
        });

    }
    [WebMethod]
    public void tec_onsite_edit2(long onsite_id, string note, string onsite_date, string onsite_date2, string technician_name, string onsitests_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_onsite_edit2", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@onsite_id",System.Data.SqlDbType.BigInt,0,onsite_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@onsite_date",System.Data.SqlDbType.VarChar,10,onsite_date),
            new _DBcon.sComParameter("@onsite_date2",System.Data.SqlDbType.VarChar,10,onsite_date2),
            new _DBcon.sComParameter("@technician_name",System.Data.SqlDbType.VarChar,50,technician_name),
            new _DBcon.sComParameter("@onsitests_id",System.Data.SqlDbType.VarChar,20,onsitests_id),
        });

    }
    [WebMethod]
    public void opr_service_addicost_add(long service_id, string addicost_name, double addicost_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_addicost_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@addicost_name",System.Data.SqlDbType.VarChar,150,addicost_name),
            new _DBcon.sComParameter("@addicost_value",System.Data.SqlDbType.VarChar,0,addicost_value),
        });
    }
    [WebMethod]
    public void opr_service_addicost_edit(long addicosts_id, string addicost_name, double addicost_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_addicost_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@addicost_id",System.Data.SqlDbType.BigInt,0,addicosts_id),
            new _DBcon.sComParameter("@addicost_name",System.Data.SqlDbType.VarChar,100,addicost_name),
            new _DBcon.sComParameter("@addicost_value",System.Data.SqlDbType.Money,0,addicost_value),
        });
    }
    [WebMethod]
    public void opr_service_addicost_delete(long addicosts_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_addicost_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@addicost_id",System.Data.SqlDbType.BigInt,0,addicosts_id),
        });
    }
    [WebMethod]
    public void opr_service_document_save(long service_id, string file_name, byte[] data, string file_type)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_document_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@file_name",System.Data.SqlDbType.VarChar,200,file_name),
            new _DBcon.sComParameter("@file_type",System.Data.SqlDbType.VarChar,200,file_type),
            new _DBcon.sComParameter("@data",System.Data.SqlDbType.Image,0,data),
        });
    }
    [WebMethod]
    public void opr_sales_addicost_add(long sales_id, string addicost_name, double addicost_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_addicost_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@addicost_name",System.Data.SqlDbType.VarChar,150,addicost_name),
            new _DBcon.sComParameter("@addicost_value",System.Data.SqlDbType.VarChar,0,addicost_value),
        });
    }
    [WebMethod]
    public void opr_sales_addicost_edit(long addicosts_id, string addicost_name, double addicost_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_addicost_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@addicost_id",System.Data.SqlDbType.BigInt,0,addicosts_id),
            new _DBcon.sComParameter("@addicost_name",System.Data.SqlDbType.VarChar,100,addicost_name),
            new _DBcon.sComParameter("@addicost_value",System.Data.SqlDbType.Money,0,addicost_value),
        });
    }
    [WebMethod]
    public void opr_sales_addicost_delete(long addicosts_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_addicost_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@addicost_id",System.Data.SqlDbType.BigInt,0,addicosts_id),
        });
    }
    [WebMethod]
    public void opr_sales_document_save(long sales_id, string file_name, byte[] data, string file_type)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_document_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@file_name",System.Data.SqlDbType.VarChar,200,file_name),
            new _DBcon.sComParameter("@file_type",System.Data.SqlDbType.VarChar,200,file_type),
            new _DBcon.sComParameter("@data",System.Data.SqlDbType.Image,0,data),
        });
    }
    [WebMethod]
    public void fin_invoice_receipt_detail_add(int invoice_receipt_id, string jenis, int id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_invoice_receipt_detail_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_receipt_id",System.Data.SqlDbType.Int,0,invoice_receipt_id),
            new _DBcon.sComParameter("@jenis",System.Data.SqlDbType.VarChar,20,jenis),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.Int,0,id),
        });
    }
    [WebMethod]
    public void fin_invoice_receipt_detail_delete(int invoice_receipt_id, string jenis, int id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_invoice_receipt_detail_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_receipt_id",System.Data.SqlDbType.Int,0,invoice_receipt_id),
            new _DBcon.sComParameter("@jenis",System.Data.SqlDbType.VarChar,20,jenis),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.Int,0,id),
        });


    }
    [WebMethod]
    public int fin_invoice_receipt_add(int customer_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_invoice_receipt_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@invoice_receipt_id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output),
        });

        return Convert.ToInt32(hasil["@invoice_receipt_id"]);
    }
    [WebMethod]
    public int fin_invoice_receipt_edit(int invoice_receipt_id, string develivery_date, string messanger_id, string receipt_date, string receipt_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_invoice_receipt_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_receipt_id",System.Data.SqlDbType.Int,0,invoice_receipt_id),
            new _DBcon.sComParameter("@develivery_date",System.Data.SqlDbType.VarChar,10,develivery_date),
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.Int,0,messanger_id),
            new _DBcon.sComParameter("@receipt_date",System.Data.SqlDbType.VarChar,10,receipt_date),
            new _DBcon.sComParameter("@receipt_name",System.Data.SqlDbType.VarChar,50,receipt_name),
        });

        return Convert.ToInt32(hasil["invoice_receipt_id"]);
    }
    [WebMethod]
    public int fin_invoice_receipt_delete(int invoice_receipt_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_invoice_receipt_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_receipt_id",System.Data.SqlDbType.Int,0,invoice_receipt_id),
        });

        return Convert.ToInt32(hasil["invoice_receipt_id"]);
    }
    [WebMethod]
    public void hr_nonsalary_employee_wageparam_add(int nonsalary_employee_id, int wageparam_id, int total, double nilai, string note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_employee_wageparam_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_employee_id",System.Data.SqlDbType.Int,0,nonsalary_employee_id),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
        });


    }
    [WebMethod]
    public void hr_nonsalary_employee_wageparam_edit(int nonsalary_employee_wageparam_id, int total, double nilai, string note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_employee_wageparam_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_employee_wageparam_id",System.Data.SqlDbType.Int,0,nonsalary_employee_wageparam_id),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
        });


    }
    [WebMethod]
    public void hr_nonsalary_employee_wageparam_delete(int nonsalary_employee_wageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_employee_wageparam_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_employee_wageparam_id",System.Data.SqlDbType.Int,0,nonsalary_employee_wageparam_id)            
        });


    }
    [WebMethod]
    public int hr_nonsalary_employee_add(int nonsalary_id, int employee_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_employee_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_id",System.Data.SqlDbType.Int,0,nonsalary_id),
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void hr_nonsalary_employee_delete(int nonsalary_employee_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_employee_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_employee_id",System.Data.SqlDbType.Int,0,nonsalary_employee_id)
        });


    }
    [WebMethod]
    public int hr_nonsalary_add(string nonsalary_name, int month_issue, int year_issue, string nonsalary_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_name",System.Data.SqlDbType.VarChar,100,nonsalary_name),
            new _DBcon.sComParameter("@month_issue",System.Data.SqlDbType.Int,0,month_issue),
            new _DBcon.sComParameter("@year_issue",System.Data.SqlDbType.Int,0,year_issue),
            new _DBcon.sComParameter("@nonsalary_date",System.Data.SqlDbType.VarChar,10,nonsalary_date),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.VarChar,10,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void hr_nonsalary_edit(int nonsalary_id, string nonsalary_name, int month_issue, int year_issue, string nonsalary_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nonsalary_name",System.Data.SqlDbType.VarChar,100,nonsalary_name),
            new _DBcon.sComParameter("@month_issue",System.Data.SqlDbType.Int,0,month_issue),
            new _DBcon.sComParameter("@year_issue",System.Data.SqlDbType.Int,0,year_issue),
            new _DBcon.sComParameter("@nonsalary_date",System.Data.SqlDbType.VarChar,10,nonsalary_date),
            new _DBcon.sComParameter("@nonsalary_id",System.Data.SqlDbType.Int,0,nonsalary_id)
        });
    }
    [WebMethod]
    public void hr_nonsalary_delete(int nonsalary_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_nonsalary_delete", new _DBcon.sComParameter[]{
           new _DBcon.sComParameter("@nonsalary_id",System.Data.SqlDbType.Int,0,nonsalary_id)
        });
    }
    [WebMethod]
    public void hr_employee_loan_add(int employee_id, string loan_date, string note, int tenor, double loan_amount, int loan_start_month, int loan_start_year, double installment, int wageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_loan_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id),
            new _DBcon.sComParameter("@loan_date",System.Data.SqlDbType.VarChar,10,loan_date),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@tenor",System.Data.SqlDbType.SmallInt,0,tenor),
            new _DBcon.sComParameter("@loan_amount",System.Data.SqlDbType.Money,0,loan_amount),
            new _DBcon.sComParameter("@loan_start_month",System.Data.SqlDbType.SmallInt,0,loan_start_month),
            new _DBcon.sComParameter("@loan_start_year",System.Data.SqlDbType.Int,0,loan_start_year),
            new _DBcon.sComParameter("@installment",System.Data.SqlDbType.Money,0,installment),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id)
        });
    }
    [WebMethod]
    public void hr_employee_loan_edit(int loan_id, int employee_id, string loan_date, string note, int tenor, double loan_amount, int loan_start_month, int loan_start_year, double installment, int wageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_loan_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@loan_id",System.Data.SqlDbType.Int,0,loan_id),
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id),
            new _DBcon.sComParameter("@loan_date",System.Data.SqlDbType.VarChar,10,loan_date),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@tenor",System.Data.SqlDbType.SmallInt,0,tenor),
            new _DBcon.sComParameter("@loan_amount",System.Data.SqlDbType.Money,0,loan_amount),
            new _DBcon.sComParameter("@loan_start_month",System.Data.SqlDbType.SmallInt,0,loan_start_month),
            new _DBcon.sComParameter("@loan_start_year",System.Data.SqlDbType.Int,0,loan_start_year),
            new _DBcon.sComParameter("@installment",System.Data.SqlDbType.Money,0,installment),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id)
        });
    }
    [WebMethod]
    public void hr_employee_loan_approve(int loan_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_loan_approve", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@loan_id",System.Data.SqlDbType.Int,0,loan_id)
        });
    }
    [WebMethod]
    public void hr_employee_loan_delete(int loan_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_loan_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@loan_id",System.Data.SqlDbType.Int,0,loan_id)
        });
    }
    [WebMethod]
    public void hr_salary_employee_wageparam_add(int salaray_employee_id, int wageparam_id, double nilai, int total, string note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_employee_wageparam_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salaray_employee_id",System.Data.SqlDbType.Int,0,salaray_employee_id),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note)
        });
    }
    [WebMethod]
    public void hr_salary_employee_wageparam_edit(double salary_employee_wageparam_id, double nilai, int total, string note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_employee_wageparam_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salary_employee_wageparam_id",System.Data.SqlDbType.BigInt,0,salary_employee_wageparam_id),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.Int,0,total),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note)
        });
    }
    [WebMethod]
    public void hr_salary_employee_wageparam_delete(double salary_employee_wageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_employee_wageparam_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salary_employee_wageparam_id",System.Data.SqlDbType.BigInt,0,salary_employee_wageparam_id)
        });
    }
    [WebMethod]
    public int hr_salary_add(string salary_name, int month_issue, int year_issue, string salary_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salary_name",System.Data.SqlDbType.VarChar,100,salary_name),
            new _DBcon.sComParameter("@month_issue",System.Data.SqlDbType.Int,0,month_issue),
            new _DBcon.sComParameter("@year_issue",System.Data.SqlDbType.Int,0,year_issue),
            new _DBcon.sComParameter("@salary_date",System.Data.SqlDbType.VarChar,10,salary_date),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void hr_salary_edit(int salary_id, string salary_name, int month_issue, int year_issue, string salary_date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salary_id",System.Data.SqlDbType.Int,0,salary_id),
            new _DBcon.sComParameter("@salary_name",System.Data.SqlDbType.VarChar,100,salary_name),
            new _DBcon.sComParameter("@month_issue",System.Data.SqlDbType.Int,0,month_issue),
            new _DBcon.sComParameter("@year_issue",System.Data.SqlDbType.Int,0,year_issue),
            new _DBcon.sComParameter("@salary_date",System.Data.SqlDbType.VarChar,10,salary_date),
        });
    }
    [WebMethod]
    public void hr_salary_delete(int salary_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_salary_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@salary_id",System.Data.SqlDbType.Int,0,salary_id)
        });
    }
    [WebMethod]
    public void hr_employee_wageparam_add(int employee_id, int wageparam_id, double nilai, Boolean open_multiplier_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_wageparam_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@open_multiplier_sts",System.Data.SqlDbType.Bit,0,open_multiplier_sts)
        });
    }
    [WebMethod]
    public void hr_employee_wageparam_edit(int employeewageparam_id, double nilai, Boolean open_multiplier_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_wageparam_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employeewageparam_id",System.Data.SqlDbType.Int,0,employeewageparam_id),
            new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.Money,0,nilai),
            new _DBcon.sComParameter("@open_multiplier_sts",System.Data.SqlDbType.Bit,0,open_multiplier_sts)
        });
    }
    [WebMethod]
    public void hr_employee_wageparam_delete(int employeewageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_wageparam_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employeewageparam_id",System.Data.SqlDbType.Int,0,employeewageparam_id)
        });
    }
    [WebMethod]
    public void hr_wageparam_add(string wageparam_name, string type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_wageparam_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@wageparam_name",System.Data.SqlDbType.VarChar,50,wageparam_name),
            new _DBcon.sComParameter("@type_id",System.Data.SqlDbType.Char,1,type_id)
        });
    }
    [WebMethod]
    public void hr_wageparam_edit(int wageparam_id, string wageparam_name, string type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_wageparam_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@wageparam_name",System.Data.SqlDbType.VarChar,50,wageparam_name),
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id),
            new _DBcon.sComParameter("@type_id",System.Data.SqlDbType.Char,1,type_id)
        });
    }
    [WebMethod]
    public void hr_wageparam_delete(int wageparam_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_wageparam_delete", new _DBcon.sComParameter[]{
            
            new _DBcon.sComParameter("@wageparam_id",System.Data.SqlDbType.Int,0,wageparam_id)
        });
    }
    [WebMethod]
    public int hr_employee_add(string nik, string employee_name, string date_in, string date_out, int position_id, Boolean status)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@nik",System.Data.SqlDbType.VarChar,10,nik),
            new _DBcon.sComParameter("@employee_name",System.Data.SqlDbType.VarChar,150,employee_name),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,date_in),
            new _DBcon.sComParameter("@date_out",System.Data.SqlDbType.VarChar,10,date_out),
            new _DBcon.sComParameter("@position_id",System.Data.SqlDbType.Int,0,position_id),
            new _DBcon.sComParameter("@status",System.Data.SqlDbType.Bit,0,status),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void hr_employee_edit(int employee_id, string nik, string employee_name, string date_in, string date_out, int position_id, Boolean status)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id),
            new _DBcon.sComParameter("@nik",System.Data.SqlDbType.VarChar,10,nik),
            new _DBcon.sComParameter("@employee_name",System.Data.SqlDbType.VarChar,150,employee_name),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,date_in),
            new _DBcon.sComParameter("@date_out",System.Data.SqlDbType.VarChar,10,date_out),
            new _DBcon.sComParameter("@position_id",System.Data.SqlDbType.Int,0,position_id),
            new _DBcon.sComParameter("@status",System.Data.SqlDbType.Bit,0,status)
        });
    }
    [WebMethod]
    public void hr_employee_delete(int employee_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_employee_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@employee_id",System.Data.SqlDbType.Int,0,employee_id)
        });
    }
    [WebMethod]
    public void hr_position_add(string position_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_position_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@position_name",System.Data.SqlDbType.VarChar,50,position_name)
        });
    }
    [WebMethod]
    public void hr_position_edit(int position_id, string position_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_position_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@position_id",System.Data.SqlDbType.Int,0,position_id),
            new _DBcon.sComParameter("@position_name",System.Data.SqlDbType.VarChar,50,position_name)
        });
    }
    [WebMethod]
    public void hr_position_delete(int position_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("hr_position_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@position_id",System.Data.SqlDbType.Int,0,position_id)
        });
    }
    [WebMethod]
    public void opr_vendor_category_merk_add(int vendor_id, int vendor_category_id, int merk_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_category_merk_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id),
            new _DBcon.sComParameter("@merk_id",System.Data.SqlDbType.Int,0,merk_id)
        });
    }
    [WebMethod]
    public void opr_vendor_category_merk_delete(int vendor_id, int vendor_category_id, int merk_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_category_merk_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id),
            new _DBcon.sComParameter("@merk_id",System.Data.SqlDbType.Int,0,merk_id)
        });
    }
    [WebMethod]
    public void opr_vendor_category_add(int vendor_id, int vendor_category_id, int merk_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_category_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id),
            new _DBcon.sComParameter("@merk_id",System.Data.SqlDbType.Int,0,merk_id)
        });
    }
    [WebMethod]
    public void opr_vendor_category_delete(int vendor_id, int vendor_category_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_category_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id)
        });
    }
    [WebMethod]
    public void par_merk_add(string merk_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_merk_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@merk_name",System.Data.SqlDbType.VarChar,50,merk_name)
        });
    }
    [WebMethod]
    public void par_merk_edit(int merk_id, string merk_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_merk_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@merk_id",System.Data.SqlDbType.Int,0,merk_id),
            new _DBcon.sComParameter("@merk_name",System.Data.SqlDbType.VarChar,50,merk_name)
        });
    }
    [WebMethod]
    public void par_merk_delete(int merk_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_merk_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@merk_id",System.Data.SqlDbType.Int,0,merk_id)
        });
    }
    [WebMethod]
    public void par_vendor_category_add(string vendor_category_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_vendor_category_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_category_name",System.Data.SqlDbType.VarChar,50,vendor_category_name)
        });
    }
    [WebMethod]
    public void par_vendor_category_edit(int vendor_category_id, string vendor_category_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_vendor_category_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id),
            new _DBcon.sComParameter("@vendor_category_name",System.Data.SqlDbType.VarChar,50,vendor_category_name)
        });
    }
    [WebMethod]
    public void par_vendor_category_delete(int vendor_category_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_vendor_category_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_category_id",System.Data.SqlDbType.Int,0,vendor_category_id)
        });
    }
    [WebMethod]
    public void act_marketing_group_delete(int marketing_group_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_marketing_group_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@marketing_group_id",System.Data.SqlDbType.Int,0,marketing_group_id)
        });
    }
    [WebMethod]
    public void act_marketing_group_edit(int marketing_group_id, string marketing_group_name, double target_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_marketing_group_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@marketing_group_id",System.Data.SqlDbType.Int,0,marketing_group_id),
            new _DBcon.sComParameter("@marketing_group_name",System.Data.SqlDbType.VarChar,50,marketing_group_name),
            new _DBcon.sComParameter("@target_value",System.Data.SqlDbType.Money,0,target_value)
        });
    }
    [WebMethod]
    public void act_marketing_group_add(string marketing_group_name, double target_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_marketing_group_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@marketing_group_name",System.Data.SqlDbType.VarChar,50,marketing_group_name),
            new _DBcon.sComParameter("@target_value",System.Data.SqlDbType.Money,0,target_value)
        });
    }
    [WebMethod]
    public void fin_receivable_payment_reverse_add(double fin_receivable_payment_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_payment_reverse_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@fin_receivable_payment_id",System.Data.SqlDbType.BigInt,0,fin_receivable_payment_id)
        });
    }
    [WebMethod]
    public void fin_receivable_payment_save(double fin_receivable_payment_id, Boolean reverse_sign_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_payment_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@fin_receivable_payment_id",System.Data.SqlDbType.BigInt,0,fin_receivable_payment_id),
            new _DBcon.sComParameter("reverse_sign_sts",System.Data.SqlDbType.Bit,0,reverse_sign_sts)
        });
    }
    [WebMethod]
    public void fin_receivable_payment_add(double fin_receivable_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_payment_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@fin_receivable_id",System.Data.SqlDbType.BigInt,0,fin_receivable_id)
        });
    }
    [WebMethod]
    public void fin_receivable_reverse_add(double fin_receivable_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_reverse_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@fin_receivable_id",System.Data.SqlDbType.BigInt,0,fin_receivable_id)
        });
    }
    [WebMethod]
    public void fin_receivable_update(double fin_receivable_id, Boolean reverse_sign_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_update", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@fin_receivable_id",System.Data.SqlDbType.BigInt,0,fin_receivable_id),
            new _DBcon.sComParameter("@reverse_sign_sts",System.Data.SqlDbType.Bit,0,reverse_sign_sts)
        });
    }
    [WebMethod]
    public void fin_receivable_service_save(double invoice_service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_service_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id)
        });
    }
    [WebMethod]
    public void fin_receivable_sales_save(double invoice_sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_receivable_sales_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id)
        });
    }
    [WebMethod]
    public void acc_journal_function_detail_save(string journal_function_code, string journal_function_detail_code, string journal_function_detail_name, int coa_id, string dbcr_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_journal_function_detail_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@journal_function_code",System.Data.SqlDbType.Char,3,journal_function_code),
            new _DBcon.sComParameter("@journal_function_detail_code",System.Data.SqlDbType.VarChar,5,journal_function_detail_code),
            new _DBcon.sComParameter("@journal_function_detail_name",System.Data.SqlDbType.VarChar,50,journal_function_detail_name),            
            new _DBcon.sComParameter("@coa_id",System.Data.SqlDbType.Int,0,coa_id),
            new _DBcon.sComParameter("@dbcr_id",System.Data.SqlDbType.Char,1,dbcr_id)
        });
    }
    [WebMethod]
    public void acc_journal_function_add(string journal_function_code, string journal_function_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_journal_function_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@journal_function_code",System.Data.SqlDbType.Char,3,journal_function_code),
            new _DBcon.sComParameter("@journal_function_name",System.Data.SqlDbType.VarChar,50,journal_function_name)
        });
    }
    [WebMethod]
    public void acc_journal_function_edit(string journal_function_code, string journal_function_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_journal_function_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@journal_function_code",System.Data.SqlDbType.Char,3,journal_function_code),
            new _DBcon.sComParameter("@journal_function_name",System.Data.SqlDbType.VarChar,50,journal_function_name)
        });
    }
    [WebMethod]
    public void acc_coa_delete(int coa_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_id",System.Data.SqlDbType.Int,0,coa_id)
        });
    }
    [WebMethod]
    public void acc_coa_edit(int coa_id, string coa_code, string coa_name, int coa_type_id, int parent_coa_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_id",System.Data.SqlDbType.Int,0,coa_id),
            new _DBcon.sComParameter("@coa_code",System.Data.SqlDbType.VarChar,10,coa_code),
            new _DBcon.sComParameter("@coa_name",System.Data.SqlDbType.VarChar,100,coa_name),
            new _DBcon.sComParameter("@coa_type_id",System.Data.SqlDbType.Int,0,coa_type_id),
            new _DBcon.sComParameter("@parent_coa_id",System.Data.SqlDbType.Int,0,parent_coa_id)
        });
    }
    [WebMethod]
    public int acc_coa_add(string coa_code, string coa_name, int coa_type_id, int parent_coa_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_code",System.Data.SqlDbType.VarChar,10,coa_code),
            new _DBcon.sComParameter("@coa_name",System.Data.SqlDbType.VarChar,100,coa_name),
            new _DBcon.sComParameter("@coa_type_id",System.Data.SqlDbType.Int,0,coa_type_id),
            new _DBcon.sComParameter("@parent_coa_id",System.Data.SqlDbType.Int,0,parent_coa_id),
            new _DBcon.sComParameter("@ret_id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)            
        });

        return Convert.ToInt32(hasil["@ret_id"]);
    }
    [WebMethod]
    public void acc_coa_type_add(string coa_type_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_type_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_type_name",System.Data.SqlDbType.VarChar,50,coa_type_name)
        });
    }
    [WebMethod]
    public void acc_coa_type_edit(int coa_type_id, string coa_type_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_type_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_type_id",System.Data.SqlDbType.Int,0,coa_type_id),
            new _DBcon.sComParameter("@coa_type_name",System.Data.SqlDbType.VarChar,50,coa_type_name)
        });
    }
    [WebMethod]
    public void acc_coa_type_delete(int coa_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("acc_coa_type_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@coa_type_id",System.Data.SqlDbType.Int,0,coa_type_id)
        });
    }
    [WebMethod]
    public void app_parameter_user_save(string code, string type_id, string description, Boolean active)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("app_parameter_user_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@code",System.Data.SqlDbType.VarChar,3,code),
            new _DBcon.sComParameter("@type_id",System.Data.SqlDbType.VarChar,5,type_id),
            new _DBcon.sComParameter("@description",System.Data.SqlDbType.VarChar,100,description),
            new _DBcon.sComParameter("@active",System.Data.SqlDbType.Bit,0,active)
        });

    }
    [WebMethod]
    public double get_principal_price_value(double cost)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("get_principal_price_value", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@cost",System.Data.SqlDbType.Money,0,cost),
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.Money,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@retval"]);
    }
    [WebMethod]
    public void par_principal_price_dtl_delete(int param_pp_dtl_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_principal_price_dtl_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@param_pp_dtl_id",System.Data.SqlDbType.BigInt,0,param_pp_dtl_id)
        });

    }
    [WebMethod]
    public void par_principal_price_dtl_edit(int param_pp_dtl_id, double range1, double range2, float pcg)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_principal_price_dtl_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@param_pp_dtl_id",System.Data.SqlDbType.BigInt,0,param_pp_dtl_id),
            new _DBcon.sComParameter("@range1",System.Data.SqlDbType.Money,0,range1),
            new _DBcon.sComParameter("@range2",System.Data.SqlDbType.Money,0,range2),
            new _DBcon.sComParameter("@pcg",System.Data.SqlDbType.Float,0,pcg)
        });

    }
    [WebMethod]
    public void par_principal_price_dtl_add(int param_pp_id, double range1, double range2, float pcg)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_principal_price_dtl_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@param_pp_id",System.Data.SqlDbType.Int,0,param_pp_id),
            new _DBcon.sComParameter("@range1",System.Data.SqlDbType.Money,0,range1),
            new _DBcon.sComParameter("@range2",System.Data.SqlDbType.Money,0,range2),
            new _DBcon.sComParameter("@pcg",System.Data.SqlDbType.Float,0,pcg)
        });

    }
    [WebMethod]
    public void par_principal_price_edit(int param_pp_id, Boolean active_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_principal_price_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@param_pp_id",System.Data.SqlDbType.Int,0,param_pp_id),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts)
        });

    }
    [WebMethod]
    public int par_principal_price_add(int par_principal_price_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_principal_price_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@par_principal_price_type_id",System.Data.SqlDbType.Int,0,par_principal_price_type_id),
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@retval"]);
    }
    [WebMethod]
    public void dashboard_refresh()
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("dashboard_refresh", null);
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_claim_cancel(int parent_dtl_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_claim_cancel", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@parent_dtl_id",System.Data.SqlDbType.BigInt,0,parent_dtl_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_claim_ok(int parent_dtl_id, int petty_cash_name_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_claim_ok", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@parent_dtl_id",System.Data.SqlDbType.BigInt,0,parent_dtl_id),
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.Int,0,petty_cash_name_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_claim_delete(int petty_cash_transaction_dtl_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_claim_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_dtl_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_dtl_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_claim_edit(int petty_cash_transaction_dtl_id, int petty_cash_category_id, string note, double amount)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_claim_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_dtl_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_dtl_id),            
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_claim_add(int parent_dtl_id, int petty_cash_category_id, string note, double amount)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_claim_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@parent_dtl_id",System.Data.SqlDbType.BigInt,0,parent_dtl_id),
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_delete(int petty_cash_transaction_dtl_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_dtl_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_dtl_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_cash_advance_add(int petty_cash_name_id, string note, double amount)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_cash_advance_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.Int,0,petty_cash_name_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_approve(int petty_cash_transaction_hdr_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_approve", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_hdr_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_hdr_id)
        });
    }
    [WebMethod]
    public string fin_petty_cash_transaction_close(int petty_cash_transaction_hdr_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_close", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_hdr_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_hdr_id),
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.VarChar,100,System.Data.ParameterDirection.Output)
        });
        return hasil["@retval"].ToString();
    }
    [WebMethod]
    public void fin_petty_cash_transaction_dtl_delete(int petty_cash_transaction_dtl_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_dtl_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_dtl_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_dtl_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_dtl_edit(int petty_cash_transaction_dtl_id, int petty_cash_category_id, string note, double amount)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_dtl_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_dtl_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_dtl_id),
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_dtl_add(int petty_cash_transaction_hdr_id, int petty_cash_category_id, string note, double amount)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_dtl_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_transaction_hdr_id",System.Data.SqlDbType.BigInt,0,petty_cash_transaction_hdr_id),
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount)
        });
    }
    [WebMethod]
    public void fin_petty_cash_transaction_hdr_add(int petty_cash_name_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_transaction_hdr_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.Int,0,petty_cash_name_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_category_delete(int petty_cash_category_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_category_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_category_edit(int petty_cash_category_id, string petty_cash_category, string transaction_type_id, Boolean show_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_category_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_category_id",System.Data.SqlDbType.Int,0,petty_cash_category_id),
            new _DBcon.sComParameter("@petty_cash_category",System.Data.SqlDbType.VarChar,100,petty_cash_category),
            new _DBcon.sComParameter("@transaction_type_id",System.Data.SqlDbType.Char,1,transaction_type_id),
            new _DBcon.sComParameter("@show_sts",System.Data.SqlDbType.Bit,0,show_sts)
        });
    }
    [WebMethod]
    public void fin_petty_cash_category_add(string petty_cash_category, string transaction_type_id, Boolean show_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_category_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_category",System.Data.SqlDbType.VarChar,100,petty_cash_category),
            new _DBcon.sComParameter("@transaction_type_id",System.Data.SqlDbType.Char,1,transaction_type_id),
            new _DBcon.sComParameter("@show_sts",System.Data.SqlDbType.Bit,0,show_sts)
        });
    }
    [WebMethod]
    public void fin_petty_cash_name_delete(int petty_cash_name_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_name_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.Int,0,petty_cash_name_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_name_edit(int petty_cash_name_id, string petty_cash_name, int branch_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_name_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_name_id",System.Data.SqlDbType.Int,0,petty_cash_name_id),
            new _DBcon.sComParameter("@petty_cash_name",System.Data.SqlDbType.VarChar,100,petty_cash_name),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id)
        });
    }
    [WebMethod]
    public void fin_petty_cash_name_add(string petty_cash_name, int branch_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_petty_cash_name_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@petty_cash_name",System.Data.SqlDbType.VarChar,100,petty_cash_name),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id)
        });
    }
    [WebMethod]
    public void opr_vendor_bill_delete(int bill_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_bill_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id)
        });
    }
    [WebMethod]
    public void opr_vendor_bill_edit(int bill_id, int vendor_id, string bill_name, string bill_no, string bill_bank_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_bill_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@bill_name",System.Data.SqlDbType.VarChar,50,bill_name),
            new _DBcon.sComParameter("@bill_no",System.Data.SqlDbType.VarChar,50,bill_no),
            new _DBcon.sComParameter("@bill_bank_name",System.Data.SqlDbType.VarChar,50,bill_bank_name)
        });
    }
    [WebMethod]
    public void opr_vendor_bill_add(int vendor_id, string bill_name, string bill_no, string bill_bank_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_bill_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@bill_name",System.Data.SqlDbType.VarChar,50,bill_name),
            new _DBcon.sComParameter("@bill_no",System.Data.SqlDbType.VarChar,50,bill_no),
            new _DBcon.sComParameter("@bill_bank_name",System.Data.SqlDbType.VarChar,50,bill_bank_name)
        });
    }
    [WebMethod]
    public void tec_borrow_service_device_trimming_save(double borrow_service_id, double inventory_device_id, int trimming_id, Boolean check)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_device_trimming_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.BigInt,0,inventory_device_id),
            new _DBcon.sComParameter("@trimming_id",System.Data.SqlDbType.Int,0,trimming_id),
            new _DBcon.sComParameter("@check",System.Data.SqlDbType.Bit,0,check)
        });
    }
    [WebMethod]
    public void tec_borrow_service_device_delete(double borrow_service_id, double inventory_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_device_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.BigInt,0,inventory_device_id)
        });
    }
    [WebMethod]
    public void tec_borrow_service_device_add(double borrow_service_id, double inventory_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_device_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.BigInt,0,inventory_device_id)
        });
    }
    [WebMethod]
    public void tec_borrow_service_delete(double borrow_service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id)
        });
    }
    [WebMethod]
    public void tec_borrow_service_edit(double borrow_service_id, string borrow_date, string note, string return_date, string receiver)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,borrow_service_id),
            new _DBcon.sComParameter("@borrow_date",System.Data.SqlDbType.VarChar,10,borrow_date),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.VarChar,0,note),
            new _DBcon.sComParameter("@return_date",System.Data.SqlDbType.VarChar,10,return_date),
            new _DBcon.sComParameter("@receiver",System.Data.SqlDbType.VarChar,50,receiver)           
        });
    }
    [WebMethod]
    public double tec_borrow_service_add(string borrow_date, int service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_borrow_service_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@borrow_date",System.Data.SqlDbType.VarChar,10,borrow_date),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@borrow_service_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt32(hasil["@borrow_service_id"]);
    }
    [WebMethod]
    public void fin_transaction_vendor_delete(int transaction_vendor_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_transaction_vendor_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@transaction_vendor_id",System.Data.SqlDbType.BigInt,0,transaction_vendor_id)
        });
    }
    [WebMethod]
    public void fin_transaction_vendor_edit(int transaction_vendor_id, string invoice_no, int vendor_id, string transaction_date, string transaction_type_id, double amount, string note, Boolean paid_sts, int bill_id, float ppn, string receive_doc_date, string paid_date, int branch_id, int broker_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_transaction_vendor_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@transaction_vendor_id",System.Data.SqlDbType.BigInt,0,transaction_vendor_id),            
            new _DBcon.sComParameter("@invoice_no",System.Data.SqlDbType.VarChar,50,invoice_no),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@transaction_date",System.Data.SqlDbType.VarChar,10,transaction_date),
            new _DBcon.sComParameter("@transaction_type_id",System.Data.SqlDbType.Char,1,transaction_type_id),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.VarChar,250,note),
            new _DBcon.sComParameter("@paid_sts",System.Data.SqlDbType.Bit,0,paid_sts),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@ppn",System.Data.SqlDbType.Float,0,ppn),
            new _DBcon.sComParameter("@receive_doc_date",System.Data.SqlDbType.VarChar,10,receive_doc_date),
            new _DBcon.sComParameter("@paid_date",System.Data.SqlDbType.VarChar,10,paid_date),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id)
        });
    }
    [WebMethod]
    public void fin_transaction_vendor_add(string invoice_no, int vendor_id, string transaction_date, string transaction_type_id, double amount, string note, Boolean paid_sts, int bill_id, float ppn, string receive_doc_date, string paid_date, int branch_id, int broker_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_transaction_vendor_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@invoice_no",System.Data.SqlDbType.VarChar,50,invoice_no),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@transaction_date",System.Data.SqlDbType.VarChar,10,transaction_date),
            new _DBcon.sComParameter("@transaction_type_id",System.Data.SqlDbType.Char,1,transaction_type_id),
            new _DBcon.sComParameter("@amount",System.Data.SqlDbType.Money,0,amount),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.VarChar,250,note),
            new _DBcon.sComParameter("@paid_sts",System.Data.SqlDbType.Bit,0,paid_sts),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@ppn",System.Data.SqlDbType.Float,0,ppn),
            new _DBcon.sComParameter("@receive_doc_date",System.Data.SqlDbType.VarChar,10,receive_doc_date),
            new _DBcon.sComParameter("@paid_date",System.Data.SqlDbType.VarChar,10,paid_date),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id)
        });
    }
    [WebMethod]
    public void fin_claim_debt_add(int servicesales_id, string contact, string note, int result_id, string fin_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_claim_debt_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@servicesales_id",System.Data.SqlDbType.BigInt,0,servicesales_id),
            new _DBcon.sComParameter("@contact",System.Data.SqlDbType.VarChar,200,contact),
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.VarChar,200,note),
            new _DBcon.sComParameter("@result_id",System.Data.SqlDbType.Int,0,result_id),
            new _DBcon.sComParameter("@fin_type_id",System.Data.SqlDbType.Char,1,fin_type_id)
            
        });
    }
    [WebMethod]
    public void fin_result_delete(int result_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_result_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@result_id",System.Data.SqlDbType.Int,0,result_id)
        });
    }
    [WebMethod]
    public void fin_result_edit(int result_id, string result)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_result_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@result_id",System.Data.SqlDbType.Int,0,result_id),
            new _DBcon.sComParameter("@result",System.Data.SqlDbType.VarChar,100,result)
        });
    }
    [WebMethod]
    public void fin_result_add(string result)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_result_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@result",System.Data.SqlDbType.VarChar,100,result)
        });
    }
    [WebMethod]
    public void par_branch_delete(int branch_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_branch_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.BigInt,0,branch_id)
        });
    }
    [WebMethod]
    public void par_branch_edit(int branch_id, string branch_name, Boolean active_sts, int location_id, string address, string phone, string fax)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_branch_edit", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.BigInt,0,branch_id),
            new _DBcon.sComParameter("@branch_name",System.Data.SqlDbType.VarChar,50,branch_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id),
            new _DBcon.sComParameter("@address",System.Data.SqlDbType.VarChar,300,address),
            new _DBcon.sComParameter("@phone",System.Data.SqlDbType.VarChar,15,phone),
            new _DBcon.sComParameter("@fax",System.Data.SqlDbType.VarChar,15,fax)
        });
    }
    [WebMethod]
    public void par_branch_add(string branch_name, Boolean active_sts, int location_id, string address, string phone, string fax)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("par_branch_add", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@branch_name",System.Data.SqlDbType.VarChar,50,branch_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id),
            new _DBcon.sComParameter("@address",System.Data.SqlDbType.VarChar,300,address),
            new _DBcon.sComParameter("@phone",System.Data.SqlDbType.VarChar,15,phone),
            new _DBcon.sComParameter("@fax",System.Data.SqlDbType.VarChar,15,fax)
        });
    }
    [WebMethod]
    public void exp_schedule_map_update(int schedule_id, int messanger_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_map_update", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id),
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.Int,0,messanger_id)
        });
    }
    [WebMethod]
    public void exp_schedule_peta_save(string category_id, int id, int location_id, string address, string latitude, string longitude)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_peta_save", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@category_id",System.Data.SqlDbType.Char,1,category_id),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.BigInt,1,id),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,1,location_id),
            new _DBcon.sComParameter("@address",System.Data.SqlDbType.VarChar,300,address),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude)
        });
    }
    [WebMethod]
    public void exp_schedule_peta_set_geotag_automatic(string date)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_peta_set_geotag_automatic", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@date",System.Data.SqlDbType.VarChar,10,date)
        });
    }
    [WebMethod]
    public void fin_opr_sales_device_update_pph_sts(int sales_id, int device_id, Boolean pph_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_opr_sales_device_update_pph_sts", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts)
        });
    }
    [WebMethod]
    public void fin_opr_service_device_component_update_pph_sts(int service_id, int service_device_id, int device_id, Boolean pph_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_opr_service_device_component_update_pph_sts", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts)
        });
    }
    [WebMethod]
    public void fin_coa_delete(int coa_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_coa_delete", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@coa_id",System.Data.SqlDbType.Int,0,coa_id)
        });
    }
    [WebMethod]
    public void fin_coa_edit(int coa_id, string coa_code, string coa_name, string ticket_type_id, string financial_transaction_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_coa_edit", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@coa_id",System.Data.SqlDbType.Int,0,coa_id),
            new _DBcon.sComParameter("@coa_code",System.Data.SqlDbType.VarChar,10,coa_code),
            new _DBcon.sComParameter("@coa_name",System.Data.SqlDbType.VarChar,100,coa_name),
            new _DBcon.sComParameter("@ticket_type_id",System.Data.SqlDbType.VarChar,1,ticket_type_id),
            new _DBcon.sComParameter("@financial_transaction_type_id",System.Data.SqlDbType.VarChar,1,financial_transaction_type_id)
        });
    }
    [WebMethod]
    public void fin_coa_add(string coa_code, string coa_name, string ticket_type_id, string financial_transaction_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_coa_add", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@coa_code",System.Data.SqlDbType.VarChar,10,coa_code),
            new _DBcon.sComParameter("@coa_name",System.Data.SqlDbType.VarChar,100,coa_name),
            new _DBcon.sComParameter("@ticket_type_id",System.Data.SqlDbType.VarChar,1,ticket_type_id),
            new _DBcon.sComParameter("@financial_transaction_type_id",System.Data.SqlDbType.VarChar,1,financial_transaction_type_id)
        });
    }
    [WebMethod]
    public void exp_schedule_borrow_inventory_device_delete(int borrow_id, int inventory_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_borrow_inventory_device_delete", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@borrow_id",System.Data.SqlDbType.Int,0,borrow_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.Int,0,inventory_device_id)
        });
    }
    [WebMethod]
    public void exp_schedule_borrow_inventory_device_add(int borrow_id, int inventory_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_borrow_inventory_device_add", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@borrow_id",System.Data.SqlDbType.Int,0,borrow_id),
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.Int,0,inventory_device_id)
        });
    }
    [WebMethod]
    public void exp_schedule_borrow_delete(int borrow_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_borrow_delete", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@borrow_id",System.Data.SqlDbType.Int,0,borrow_id)
        });
    }
    [WebMethod]
    public void exp_schedule_borrow_edit(int borrow_id, string borrow_end_date, string borrow_note, string borrowed_for_id, string borrow_sts_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_borrow_edit", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@borrow_id",System.Data.SqlDbType.Int,0,borrow_id),            
            new _DBcon.sComParameter("@borrow_end_date",System.Data.SqlDbType.VarChar,10,borrow_end_date),            
            new _DBcon.sComParameter("@borrow_note",System.Data.SqlDbType.Text,0,borrow_note),
            new _DBcon.sComParameter("@borrowed_for_id",System.Data.SqlDbType.Char,1,borrowed_for_id),
            new _DBcon.sComParameter("@borrow_sts_id",System.Data.SqlDbType.Char,1,borrow_sts_id)
        });
    }
    [WebMethod]
    public void exp_schedule_borrow_add(string code, int schedule_id, string borrow_end_date, string borrow_note, string borrowed_for_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_borrow_add", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@code",System.Data.SqlDbType.VarChar,20,code),
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.Int,0,schedule_id),
            new _DBcon.sComParameter("@borrow_end_date",System.Data.SqlDbType.VarChar,10,borrow_end_date),
            new _DBcon.sComParameter("@borrow_note",System.Data.SqlDbType.Text,0,borrow_note),
            new _DBcon.sComParameter("@borrowed_for_id",System.Data.SqlDbType.Char,1,borrowed_for_id)
        });
    }
    [WebMethod]
    public void tec_inventory_device_delete(int inventory_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_device_delete", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.Int,0,inventory_device_id)
        });
    }
    [WebMethod]
    public void tec_inventory_device_edit(int inventory_device_id, string sn, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_device_edit", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@inventory_device_id",System.Data.SqlDbType.Int,0,inventory_device_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)
        });
    }
    [WebMethod]
    public void tec_inventory_device_add(int inventory_id, string sn, int device_id, int service_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_device_add", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@inventory_id",System.Data.SqlDbType.Int,0,inventory_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
        });
    }
    [WebMethod]
    public void tec_inventory_delete(int inventory_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_delete", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@inventory_id",System.Data.SqlDbType.Int,0,inventory_id)
        });
    }
    [WebMethod]
    public void tec_inventory_edit(int inventory_id, string inventory_in, string inventory_out, string inventory_type_id, int vendor_id, string invoice_no, Boolean inventory_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_edit", new _DBcon.sComParameter[]{  
            new _DBcon.sComParameter("@inventory_id",System.Data.SqlDbType.Int,0,inventory_id),              
            new _DBcon.sComParameter("@inventory_in",System.Data.SqlDbType.VarChar,10,inventory_in),
            new _DBcon.sComParameter("@inventory_out",System.Data.SqlDbType.VarChar,10,inventory_out),
            new _DBcon.sComParameter("@inventory_type_id",System.Data.SqlDbType.VarChar,1,inventory_type_id),             
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),             
            new _DBcon.sComParameter("@invoice_no",System.Data.SqlDbType.VarChar,50,invoice_no),             
            new _DBcon.sComParameter("@inventory_sts",System.Data.SqlDbType.Bit,0,inventory_sts)
        });
    }
    [WebMethod]
    public Int32 tec_inventory_add(string inventory_in, string inventory_out, string inventory_type_id, int vendor_id, string invoice_no, Boolean inventory_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_inventory_add", new _DBcon.sComParameter[]{   
            new _DBcon.sComParameter("@inventory_in",System.Data.SqlDbType.VarChar,10,inventory_in),
            new _DBcon.sComParameter("@inventory_out",System.Data.SqlDbType.VarChar,10,inventory_out),
            new _DBcon.sComParameter("@inventory_type_id",System.Data.SqlDbType.VarChar,1,inventory_type_id),             
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),             
            new _DBcon.sComParameter("@invoice_no",System.Data.SqlDbType.VarChar,50,invoice_no),             
            new _DBcon.sComParameter("@inventory_sts",System.Data.SqlDbType.Bit,0,inventory_sts),             
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@retval"]);
    }
    [WebMethod]
    public Boolean tec_service_device_guarantee_check(string sn, string date_in)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_guarantee_check", new _DBcon.sComParameter[]{   
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,50,date_in),             
            new _DBcon.sComParameter("@guarantee_sts",System.Data.SqlDbType.Bit,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToBoolean(hasil["@guarantee_sts"]);
    }
    [WebMethod]
    public void fin_sales_generate_schedule_print(int invoice_sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_sales_generate_schedule_print", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id)
        });
    }
    [WebMethod]
    public void fin_service_generate_schedule_print(int invoice_service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_service_generate_schedule_print", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id)
        });
    }
    [WebMethod]
    public void exp_schedule_sales_add(int schedule_id, int sales_id, int location_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_sales_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id),
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id)
        });
    }
    [WebMethod]
    public void fin_sales_edit(int invoice_sales_id, string invoice_date, string term_of_payment_id, string po_no, string afpo_no, string term_of_payment_value, int bill_id, Boolean paid_sts, string paid_date, Boolean send_sts, Boolean invoice_sts, string invoice_note, Boolean pph_sts, Boolean document_return_sts, string document_return_date, double fee_payment, string fee_date, double amount_cut)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_sales_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id),            
            new _DBcon.sComParameter("@invoice_date",System.Data.SqlDbType.VarChar,10,invoice_date),
            new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Char,1,term_of_payment_id),
            new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
            new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
            new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,term_of_payment_value),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@paid_sts",System.Data.SqlDbType.Bit,0,paid_sts),
            new _DBcon.sComParameter("@paid_date",System.Data.SqlDbType.VarChar,10,paid_date),
            new _DBcon.sComParameter("@send_sts",System.Data.SqlDbType.Bit,0,send_sts),
            new _DBcon.sComParameter("@invoice_sts",System.Data.SqlDbType.Bit,0,invoice_sts),
            new _DBcon.sComParameter("@invoice_note",System.Data.SqlDbType.Text,0,invoice_note),
            new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts),
            new _DBcon.sComParameter("@document_return_sts",System.Data.SqlDbType.Bit,0,document_return_sts),
            new _DBcon.sComParameter("@document_return_date",System.Data.SqlDbType.VarChar,10,document_return_date),
            new _DBcon.sComParameter("@fee_payment",System.Data.SqlDbType.Money,0,fee_payment),
            new _DBcon.sComParameter("@fee_date",System.Data.SqlDbType.VarChar,10,fee_date),
            new _DBcon.sComParameter("@amount_cut",System.Data.SqlDbType.Money,0,amount_cut)
        });
    }
    [WebMethod]
    public void fin_sales_delete(int invoice_sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_sales_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id)
        });
    }
    [WebMethod]
    public void fin_sales_opr_delete(int invoice_sales_id, int sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_sales_opr_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id),
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id)
        });
    }
    [WebMethod]
    public void opr_sales_device_delete(int sales_id, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_device_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)
            
            
        });
    }
    [WebMethod]
    public string opr_sales_device_save(int sales_id, int device_id, double cost, double price, int qty, Boolean pph21_sts, string description, int vendor_id, double principal_price, string marketing_note = "", string user_id = "", Boolean draft_sts = false,
        string guarantee_id = "", string availability_id = "", int inden = 0, int guarantee_period = 0,
        string guarantee_timetype_id = "1", string availability_timetype_id = "1"
        )
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_device_save", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@cost",System.Data.SqlDbType.Money,0,cost),
            new _DBcon.sComParameter("@price",System.Data.SqlDbType.Money,0,price),
            new _DBcon.sComParameter("@qty",System.Data.SqlDbType.SmallInt,0,qty),
            new _DBcon.sComParameter("@pph21_sts",System.Data.SqlDbType.Bit,0,pph21_sts),
            new _DBcon.sComParameter("@description",System.Data.SqlDbType.Text,0,description),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@principal_price",System.Data.SqlDbType.Money,0,principal_price),
            new _DBcon.sComParameter("@marketing_note",System.Data.SqlDbType.Text,0,marketing_note),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,25,user_id),
            new _DBcon.sComParameter("@draft_sts",System.Data.SqlDbType.Bit,0,draft_sts),
            new _DBcon.sComParameter("@guarantee_id",System.Data.SqlDbType.VarChar,1,guarantee_id),
            new _DBcon.sComParameter("@guarantee_period",System.Data.SqlDbType.Int,0,guarantee_period),
            new _DBcon.sComParameter("@availability_id",System.Data.SqlDbType.VarChar,1,availability_id),
            new _DBcon.sComParameter("@inden",System.Data.SqlDbType.Int,0,inden),
            new _DBcon.sComParameter("@guarantee_timetype_id",System.Data.SqlDbType.VarChar,1,guarantee_timetype_id),
            new _DBcon.sComParameter("@availability_timetype_id",System.Data.SqlDbType.VarChar,1,availability_timetype_id),
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.VarChar,200,System.Data.ParameterDirection.Output),
            
        });
        return hasil["@retval"].ToString();
    }
    [WebMethod]
    public string opr_sales_check_pending()
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_check_pending", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@retval",System.Data.SqlDbType.VarChar,200,System.Data.ParameterDirection.Output),
            
        });
        return hasil["@retval"].ToString();
    }
    [WebMethod]
    public void tec_trimming_delete(int trimming_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_trimming_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@trimming_id",System.Data.SqlDbType.Int,0,trimming_id)
            
        });
    }
    [WebMethod]
    public void tec_trimming_edit(int trimming_id, string trimming_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_trimming_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@trimming_id",System.Data.SqlDbType.Int,0,trimming_id),
            new _DBcon.sComParameter("@trimming_name",System.Data.SqlDbType.VarChar,50,trimming_name)
            
        });
    }
    [WebMethod]
    public void tec_trimming_add(string trimming_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_trimming_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@trimming_name",System.Data.SqlDbType.VarChar,50,trimming_name)
            
        });
    }
    [WebMethod]
    public void opr_sales_delete(int sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id)
        });
    }
    [WebMethod]
    public string opr_sales_edit_marketing(int sales_id, string sales_status_marketing_id, string reason_marketing_id, string user_id, string discount_type_id, double discount_value)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_edit_marketing", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@sales_status_marketing_id",System.Data.SqlDbType.Char,1,sales_status_marketing_id),
            new _DBcon.sComParameter("@reason_marketing_id",System.Data.SqlDbType.VarChar,3,reason_marketing_id),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,25,user_id),
            new _DBcon.sComParameter("@ret",System.Data.SqlDbType.VarChar,100,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@discount_type_id",System.Data.SqlDbType.VarChar,1,discount_type_id),
            new _DBcon.sComParameter("@discount_value",System.Data.SqlDbType.Money,0,discount_value),
        });
        return hasil["@ret"].ToString();
    }
    [WebMethod]
    public void opr_sales_edit_approve(int sales_id, string user_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_edit_approve", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,25,user_id)
        });
    }
    [WebMethod]
    public string opr_sales_edit(int sales_id, string offer_date, int broker_id, string discount_type_id, double discount_value, Boolean tax_sts, double fee, string opr_note, string sales_status_id, double additional_fee, string additional_fee_note, string user_id, string ctgsales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@offer_date",System.Data.SqlDbType.VarChar,10,offer_date),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
            new _DBcon.sComParameter("@discount_type_id",System.Data.SqlDbType.Char,1,discount_type_id),
            new _DBcon.sComParameter("@discount_value",System.Data.SqlDbType.Money,0,discount_value),
            new _DBcon.sComParameter("@tax_sts",System.Data.SqlDbType.Bit,0,tax_sts),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@opr_note",System.Data.SqlDbType.Text,0,opr_note),
            new _DBcon.sComParameter("@sales_status_id",System.Data.SqlDbType.Char,1,sales_status_id),
            new _DBcon.sComParameter("@additional_fee",System.Data.SqlDbType.Money,0,additional_fee),
            new _DBcon.sComParameter("@additional_fee_note",System.Data.SqlDbType.Text,0,additional_fee_note),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,25,user_id),
            new _DBcon.sComParameter("@ctgsales_id",System.Data.SqlDbType.VarChar,2,ctgsales_id),
            new _DBcon.sComParameter("@ret",System.Data.SqlDbType.VarChar,200,System.Data.ParameterDirection.Output)
        });
        return hasil["@ret"].ToString();
    }
    [WebMethod]
    public void opr_sales_add(int sales_id, string offer_date, int broker_id, string discount_type_id, double discount_value, Boolean tax_sts, double fee, string opr_note, string sales_status_id, double additional_fee, string additional_fee_note, string user_id, string ctgsales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@offer_date",System.Data.SqlDbType.VarChar,10,offer_date),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
            new _DBcon.sComParameter("@discount_type_id",System.Data.SqlDbType.Char,1,discount_type_id),
            new _DBcon.sComParameter("@discount_value",System.Data.SqlDbType.Money,0,discount_value),
            new _DBcon.sComParameter("@tax_sts",System.Data.SqlDbType.Bit,0,tax_sts),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@opr_note",System.Data.SqlDbType.Text,0,opr_note),
            new _DBcon.sComParameter("@sales_status_id",System.Data.SqlDbType.Char,1,sales_status_id),
            new _DBcon.sComParameter("@additional_fee",System.Data.SqlDbType.Money,0,additional_fee),
            new _DBcon.sComParameter("@additional_fee_note",System.Data.SqlDbType.Text,0,additional_fee_note),
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,25,user_id),
            new _DBcon.sComParameter("@ctgsales_id",System.Data.SqlDbType.VarChar,2,ctgsales_id),
        });
    }
    [WebMethod]
    public void fin_bill_delete(int bill_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_bill_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id)
        });
    }
    [WebMethod]
    public void fin_bill_edit(int bill_id, string bill_name, string bill_no, string bill_bank_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_bill_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@bill_name",System.Data.SqlDbType.VarChar,50,bill_name),
            new _DBcon.sComParameter("@bill_no",System.Data.SqlDbType.VarChar,50,bill_no),
            new _DBcon.sComParameter("@bill_bank_name",System.Data.SqlDbType.VarChar,50,bill_bank_name)
        });
    }
    [WebMethod]
    public void fin_bill_add(string bill_name, string bill_no, string bill_bank_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_bill_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@bill_name",System.Data.SqlDbType.VarChar,50,bill_name),
            new _DBcon.sComParameter("@bill_no",System.Data.SqlDbType.VarChar,50,bill_no),
            new _DBcon.sComParameter("@bill_bank_name",System.Data.SqlDbType.VarChar,50,bill_bank_name)
        });
    }
    [WebMethod]
    public Int32 fin_sales_add(int invoice_sales_id, int sales_id, string invoice_date, string term_of_payment_id, string po_no, string afpo_no, string term_of_payment_value, int bill_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_sales_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_sales_id",System.Data.SqlDbType.BigInt,0,invoice_sales_id),
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@invoice_date",System.Data.SqlDbType.VarChar,10,invoice_date),
            new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Char,1,term_of_payment_id),
            new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
            new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,term_of_payment_value),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id)
        });

        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void fin_service_opr_delete(int invoice_service_id, int service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_service_opr_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id)
        });
    }
    [WebMethod]
    public void fin_service_delete(int invoice_service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_service_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id)
        });
    }
    [WebMethod]
    public void fin_service_edit(int invoice_service_id, string invoice_date, string term_of_payment_id, string po_no, string afpo_no, string term_of_payment_value, int bill_id, Boolean paid_sts, string paid_date, Boolean send_sts, Boolean invoice_sts, string invoice_note, Boolean pph_sts, Boolean document_return_sts, string document_return_date, double fee_payment, string fee_date, double amount_cut)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_service_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id),            
            new _DBcon.sComParameter("@invoice_date",System.Data.SqlDbType.VarChar,10,invoice_date),
            new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Char,1,term_of_payment_id),
            new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
            new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
            new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,term_of_payment_value),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
            new _DBcon.sComParameter("@paid_sts",System.Data.SqlDbType.Bit,0,paid_sts),
            new _DBcon.sComParameter("@paid_date",System.Data.SqlDbType.VarChar,10,paid_date),
            new _DBcon.sComParameter("@send_sts",System.Data.SqlDbType.Bit,0,send_sts),
            new _DBcon.sComParameter("@invoice_sts",System.Data.SqlDbType.Bit,0,invoice_sts),
            new _DBcon.sComParameter("@invoice_note",System.Data.SqlDbType.Text,0,invoice_note),
            new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts),
            new _DBcon.sComParameter("@document_return_sts",System.Data.SqlDbType.Bit,0,document_return_sts),
            new _DBcon.sComParameter("@document_return_date",System.Data.SqlDbType.VarChar,10,document_return_date),
            new _DBcon.sComParameter("@fee_payment",System.Data.SqlDbType.Money,0,fee_payment),
            new _DBcon.sComParameter("@fee_date",System.Data.SqlDbType.VarChar,10,fee_date),
            new _DBcon.sComParameter("@amount_cut",System.Data.SqlDbType.Money,0,amount_cut)
        });
    }
    [WebMethod]
    public Int32 fin_service_add(int invoice_service_id, int service_id, string invoice_date, string term_of_payment_id, string po_no, string afpo_no, string term_of_payment_value, int bill_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_service_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@invoice_service_id",System.Data.SqlDbType.BigInt,0,invoice_service_id),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@invoice_date",System.Data.SqlDbType.VarChar,10,invoice_date),
            new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Char,1,term_of_payment_id),
            new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
            new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
            new _DBcon.sComParameter("@id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,term_of_payment_value),
            new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id)
        });

        return Convert.ToInt32(hasil["@id"]);
    }
    [WebMethod]
    public void opr_service_edit_marketing(int service_id, string service_status_marketing_id, string reason_marketing_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_edit_marketing", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_status_marketing_id",System.Data.SqlDbType.Char,1,service_status_marketing_id),
            new _DBcon.sComParameter("@reason_marketing_id",System.Data.SqlDbType.VarChar,3,reason_marketing_id)
        });

    }
    [WebMethod]
    public void opr_service_device_component_delete(int service_id, int service_device_id, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_device_component_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)            
        });

    }
    [WebMethod]
    public void opr_service_device_component_save(int service_id, int service_device_id, int device_id, double price, int total, Boolean pph21)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_device_component_save", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@price",System.Data.SqlDbType.Money,0,price),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.SmallInt,0,total),
            new _DBcon.sComParameter("@pph21",System.Data.SqlDbType.Bit,0,pph21)
        });

    }
    [WebMethod]
    public void opr_service_device_add(int service_id, int service_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_device_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
        });

    }
    [WebMethod]
    public void opr_service_device_delete(int service_id, int service_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_device_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
        });

    }
    [WebMethod]
    public void opr_service_device_edit(int service_id, int service_device_id, double service_cost, double service_cancel)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_device_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@service_cost",System.Data.SqlDbType.Money,0,service_cost),
            new _DBcon.sComParameter("@service_cancel",System.Data.SqlDbType.Money,0,service_cancel)
        });

    }
    [WebMethod]
    public void opr_service_delete(int service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id)
        });

    }
    [WebMethod]
    public void opr_service_edit(int service_id, string offer_date, int broker_id, string discount_type_id, double discount_value, Boolean tax_sts, double fee, string service_status_id, string opr_note, double additional_fee, string additional_fee_note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@offer_date",System.Data.SqlDbType.VarChar,10,offer_date),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
            new _DBcon.sComParameter("@discount_type_id",System.Data.SqlDbType.Char,1,discount_type_id),
            new _DBcon.sComParameter("@discount_value",System.Data.SqlDbType.Money,0,discount_value),
            new _DBcon.sComParameter("@tax_sts",System.Data.SqlDbType.Bit,0,tax_sts),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@service_status_id",System.Data.SqlDbType.Char,1,service_status_id),
            new _DBcon.sComParameter("@opr_note",System.Data.SqlDbType.Text,0,opr_note),
            new _DBcon.sComParameter("@additional_fee",System.Data.SqlDbType.Money,0,additional_fee),
            new _DBcon.sComParameter("@additional_fee_note",System.Data.SqlDbType.Text,0,additional_fee_note)
            
        });
    }
    [WebMethod]
    public int opr_service_add(string offer_date, int broker_id, string discount_type_id, double discount_value, Boolean tax_sts, double fee, int service_device_id, double additional_fee, string additional_fee_note)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_service_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@offer_date",System.Data.SqlDbType.VarChar,10,offer_date),
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
            new _DBcon.sComParameter("@discount_type_id",System.Data.SqlDbType.Char,1,discount_type_id),
            new _DBcon.sComParameter("@discount_value",System.Data.SqlDbType.Money,0,discount_value),
            new _DBcon.sComParameter("@tax_sts",System.Data.SqlDbType.Bit,0,tax_sts),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@additional_fee",System.Data.SqlDbType.Money,0,additional_fee),
            new _DBcon.sComParameter("@additional_fee_note",System.Data.SqlDbType.Text,0,additional_fee_note)
        });
        return Convert.ToInt32(hasil["@service_id"]);
    }
    [WebMethod]
    public void opr_broker_delete(int broker_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_broker_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id)
        });
    }
    [WebMethod]
    public void opr_broker_edit(int broker_id, string broker_name, string broker_address, string title_1, string title_2, string title_3, string initial, Boolean par_tax_sts, int guaranti_term)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_broker_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
            new _DBcon.sComParameter("@broker_name",System.Data.SqlDbType.VarChar,50,broker_name),
            new _DBcon.sComParameter("@broker_address",System.Data.SqlDbType.VarChar,300,broker_address),
            new _DBcon.sComParameter("@title_1",System.Data.SqlDbType.VarChar,200,title_1),
            new _DBcon.sComParameter("@title_2",System.Data.SqlDbType.VarChar,200,title_2),
            new _DBcon.sComParameter("@title_3",System.Data.SqlDbType.VarChar,200,title_3),
            new _DBcon.sComParameter("@initial",System.Data.SqlDbType.VarChar,3,initial),
            new _DBcon.sComParameter("@par_tax_sts",System.Data.SqlDbType.Bit,0,par_tax_sts),
            new _DBcon.sComParameter("@guaranti_term",System.Data.SqlDbType.SmallInt,0,guaranti_term)
        });
    }
    [WebMethod]
    public void opr_broker_add(string broker_name, string broker_address, string title_1, string title_2, string title_3, string initial, Boolean par_tax_sts, int guaranti_term)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_broker_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@broker_name",System.Data.SqlDbType.VarChar,50,broker_name),
            new _DBcon.sComParameter("@broker_address",System.Data.SqlDbType.VarChar,300,broker_address),
            new _DBcon.sComParameter("@title_1",System.Data.SqlDbType.VarChar,200,title_1),
            new _DBcon.sComParameter("@title_2",System.Data.SqlDbType.VarChar,200,title_2),
            new _DBcon.sComParameter("@title_3",System.Data.SqlDbType.VarChar,200,title_3),
            new _DBcon.sComParameter("@initial",System.Data.SqlDbType.VarChar,3,initial),
            new _DBcon.sComParameter("@par_tax_sts",System.Data.SqlDbType.Bit,0,par_tax_sts),
            new _DBcon.sComParameter("@guaranti_term",System.Data.SqlDbType.SmallInt,0,guaranti_term)
        });
    }
    [WebMethod]
    public void tec_service_device_component_delete(int service_device_id, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_component_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)
        });
    }
    [WebMethod]
    public void tec_service_device_component_save(int service_device_id, int device_id, double cost, int total)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_component_save", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@cost",System.Data.SqlDbType.Money,0,cost),
            new _DBcon.sComParameter("@total",System.Data.SqlDbType.SmallInt,0,total)
            
        });
    }
    [WebMethod]
    public void tec_service_device_vendor_delete(int service_device_vendor_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_vendor_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_vendor_id",System.Data.SqlDbType.BigInt,0,service_device_vendor_id)
            
        });
    }
    [WebMethod]
    public void tec_service_device_vendor_edit(int service_device_vendor_id, int vendor_id, string datein, string dateout, string vendor_note, string service_vendor_sts_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_vendor_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_vendor_id",System.Data.SqlDbType.BigInt,0,service_device_vendor_id),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,datein),
            new _DBcon.sComParameter("@date_out",System.Data.SqlDbType.VarChar,10,dateout),
            new _DBcon.sComParameter("@vendor_note",System.Data.SqlDbType.Text,0,vendor_note),
            new _DBcon.sComParameter("@service_vendor_sts_id",System.Data.SqlDbType.Char,1,service_vendor_sts_id)
            
        });
    }
    [WebMethod]
    public void tec_service_device_vendor_tambah(int service_device_id, int vendor_id, string datein, string dateout, string vendor_note, string service_vendor_sts_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_vendor_tambah", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,datein),
            new _DBcon.sComParameter("@date_out",System.Data.SqlDbType.VarChar,10,dateout),
            new _DBcon.sComParameter("@vendor_note",System.Data.SqlDbType.Text,0,vendor_note),
            new _DBcon.sComParameter("@service_vendor_sts_id",System.Data.SqlDbType.Char,1,service_vendor_sts_id)
            
        });
    }
    [WebMethod]
    public void tec_service_device_trimming_add(int service_device_id, int device_type_trimming_id, Boolean status)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_trimming_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@device_type_trimming_id",System.Data.SqlDbType.Int,0,device_type_trimming_id),
            new _DBcon.sComParameter("@status",System.Data.SqlDbType.Bit,0,status)            
        });
    }
    [WebMethod]
    public void tec_device_type_trimming_delete(int device_type_trimming_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_type_trimming_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@device_type_trimming_id",System.Data.SqlDbType.Int,0,device_type_trimming_id)
            
        });
    }
    [WebMethod]
    public void tec_device_type_trimming_add(int device_type_id, int trimming_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_type_trimming_add", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id),
            new _DBcon.sComParameter("@trimming_id",System.Data.SqlDbType.Int,0,trimming_id)
            
        });
    }
    [WebMethod]
    public void tec_technician_delete(int technician_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_technician_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@technician_id",System.Data.SqlDbType.Int,0,technician_id)
        });
    }
    [WebMethod]
    public void tec_technician_edit(int technician_id, string technician_name, Boolean active_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_technician_edit", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@technician_id",System.Data.SqlDbType.Int,0,technician_id),         
            new _DBcon.sComParameter("@technician_name",System.Data.SqlDbType.VarChar,50,technician_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts)
        });
    }
    [WebMethod]
    public void tec_technician_add(string technician_name, Boolean active_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_technician_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@technician_name",System.Data.SqlDbType.VarChar,50,technician_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts)
        });
    }
    [WebMethod]
    public void tec_service_device_edit(int service_device_id, string date_in, int device_register_id, string sn, int device_id, Boolean guarantee_sts, string technician_note,
        string service_device_sts_id, int technician_id, string date_done, string user_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,date_in),
            new _DBcon.sComParameter("@device_register_id",System.Data.SqlDbType.Int,0,device_register_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),            
            new _DBcon.sComParameter("@guarantee_sts",System.Data.SqlDbType.Bit,0,guarantee_sts),
            new _DBcon.sComParameter("@technician_note",System.Data.SqlDbType.Text,0,technician_note),
            new _DBcon.sComParameter("@service_device_sts_id",System.Data.SqlDbType.Char,1,service_device_sts_id),
            new _DBcon.sComParameter("@technician_id",System.Data.SqlDbType.Int,0,technician_id),
            new _DBcon.sComParameter("@date_done",System.Data.SqlDbType.VarChar,10,date_done),
            new _DBcon.sComParameter("@user_name",System.Data.SqlDbType.VarChar,50,user_name)
        });
    }
    [WebMethod]
    public void tec_service_device_register_delete(int service_device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_register_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id)
        });
    }
    [WebMethod]
    public void tec_service_device_register_edit(int service_device_id, string date_in, int device_register_id, string sn, int device_id, string customer_note, Boolean guarantee_sts, string user_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_register_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,service_device_id),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,date_in),
            new _DBcon.sComParameter("@device_register_id",System.Data.SqlDbType.Int,0,device_register_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@customer_note",System.Data.SqlDbType.VarChar,300,customer_note),
            new _DBcon.sComParameter("@guarantee_sts",System.Data.SqlDbType.Bit,0,guarantee_sts),
            new _DBcon.sComParameter("@user_name",System.Data.SqlDbType.VarChar,50,user_name),
        });
    }
    [WebMethod]
    public Int32 tec_service_device_register_add(int service_id, string date_in, string sn, int device_id, string customer_note, Boolean guarantee_sts, string user_name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_service_device_register_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@date_in",System.Data.SqlDbType.VarChar,10,date_in),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@customer_note",System.Data.SqlDbType.VarChar,300,customer_note),
            new _DBcon.sComParameter("@guarantee_sts",System.Data.SqlDbType.Bit,0,guarantee_sts),
            new _DBcon.sComParameter("@service_device_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@user_name",System.Data.SqlDbType.VarChar,50,user_name),
        });
        return Convert.ToInt32(hasil["@service_device_id"]);
    }
    [WebMethod]
    public void opr_vendor_delete(int vendor_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id)
        });
    }
    [WebMethod]
    public void opr_vendor_edit(int vendor_id, string vendor_name, int vendor_location_id, string location_address, string vendor_address, string contact_name, string phone1, string phone2, Boolean access_service_data_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@vendor_id",System.Data.SqlDbType.Int,0,vendor_id),
            new _DBcon.sComParameter("@vendor_name",System.Data.SqlDbType.VarChar,100,vendor_name),
            new _DBcon.sComParameter("@vendor_location_id",System.Data.SqlDbType.Int,0,vendor_location_id),
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
            new _DBcon.sComParameter("@vendor_address",System.Data.SqlDbType.VarChar,300,vendor_address),
            new _DBcon.sComParameter("@contact_name",System.Data.SqlDbType.VarChar,100,contact_name),
            new _DBcon.sComParameter("@phone1",System.Data.SqlDbType.VarChar,100,phone1),
            new _DBcon.sComParameter("@phone2",System.Data.SqlDbType.VarChar,100,phone2),
            new _DBcon.sComParameter("@access_service_data_sts",System.Data.SqlDbType.Bit,0,access_service_data_sts)
            
        });
    }
    [WebMethod]
    public void opr_vendor_add(string vendor_name, int vendor_location_id, string location_address, string vendor_address, string contact_name, string phone1, string phone2, Boolean access_service_data_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_vendor_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@vendor_name",System.Data.SqlDbType.VarChar,100,vendor_name),
            new _DBcon.sComParameter("@vendor_location_id",System.Data.SqlDbType.Int,0,vendor_location_id),
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
            new _DBcon.sComParameter("@vendor_address",System.Data.SqlDbType.VarChar,300,vendor_address),
            new _DBcon.sComParameter("@contact_name",System.Data.SqlDbType.VarChar,100,contact_name),
            new _DBcon.sComParameter("@phone1",System.Data.SqlDbType.VarChar,100,phone1),
            new _DBcon.sComParameter("@phone2",System.Data.SqlDbType.VarChar,100,phone2),
            new _DBcon.sComParameter("@access_service_data_sts",System.Data.SqlDbType.Bit,0,access_service_data_sts)
        });
    }
    [WebMethod]
    public void tec_device_register_delete(int device_register_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_register_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_register_id",System.Data.SqlDbType.Int,0,device_register_id)
        });
    }
    [WebMethod]
    public void tec_device_register_edit(int device_register_id, string sn, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_register_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_register_id",System.Data.SqlDbType.Int,0,device_register_id),
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)            
        });
    }
    [WebMethod]
    public int tec_device_register_add(string sn, int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_register_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@device_register_id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });

        return Convert.ToInt32(hasil["@device_register_id"]);
    }
    [WebMethod]
    public void tec_device_delete(int device_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id)
        });
    }
    [WebMethod]
    public void tec_device_edit(int device_id, string device, int device_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_id",System.Data.SqlDbType.Int,0,device_id),
            new _DBcon.sComParameter("@device",System.Data.SqlDbType.VarChar,50,device),
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id)
        });
    }
    [WebMethod]
    public void tec_device_add(string device, int device_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device",System.Data.SqlDbType.VarChar,50,device),
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id)
        });
    }
    [WebMethod]
    public void tec_device_type_delete(int device_type_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_type_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id)
        });
    }
    [WebMethod]
    public void tec_device_type_edit(int device_type_id, string device_type, Boolean part_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_type_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,device_type_id),
            new _DBcon.sComParameter("@device_type",System.Data.SqlDbType.VarChar,35,device_type),
            new _DBcon.sComParameter("@part_sts",System.Data.SqlDbType.Bit,0,part_sts)
        });
    }
    [WebMethod]
    public int tec_device_type_add(string device_type, Boolean part_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("tec_device_type_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@device_type",System.Data.SqlDbType.VarChar,35,device_type),
            new _DBcon.sComParameter("@part_sts",System.Data.SqlDbType.Bit,0,part_sts),
            new _DBcon.sComParameter("@device_type_id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
        });
        return Convert.ToInt32(hasil["@device_type_id"]);
    }
    [WebMethod]
    public void exp_messanger_delete(int messanger_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_messanger_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.SmallInt,0,messanger_id)
        });
    }
    [WebMethod]
    public void exp_messanger_map_edit(int messanger_id, string messanger_name, Boolean active_sts, string latitude, string longitude)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_messanger_map_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.SmallInt,0,messanger_id),
            new _DBcon.sComParameter("@messanger_name",System.Data.SqlDbType.VarChar,25,messanger_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude)
        });
    }
    [WebMethod]
    public void exp_messanger_edit(int messanger_id, string messanger_name, Boolean active_sts, string mobile_id, string mobile_password)
    {
        string password = "";
        if (mobile_password != "") password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(mobile_password, "SHA1");

        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_messanger_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.SmallInt,0,messanger_id),
            new _DBcon.sComParameter("@messanger_name",System.Data.SqlDbType.VarChar,25,messanger_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@mobile_id",System.Data.SqlDbType.VarChar,10,mobile_id),
            new _DBcon.sComParameter("@mobile_password",System.Data.SqlDbType.VarChar,50,password)
        });
    }
    [WebMethod]
    public void exp_messanger_map_add(string messanger_name, Boolean active_sts, string latitude, string longitude)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_messanger_map_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@messanger_name",System.Data.SqlDbType.VarChar,25,messanger_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude)
        });
    }
    [WebMethod]
    public void exp_messanger_add(string messanger_name, Boolean active_sts, string mobile_id, string mobile_password)
    {
        string password = "";
        if (mobile_password != "") password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(mobile_password, "SHA1");

        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_messanger_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@messanger_name",System.Data.SqlDbType.VarChar,25,messanger_name),
            new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            new _DBcon.sComParameter("@mobile_id",System.Data.SqlDbType.VarChar,10,mobile_id),
            new _DBcon.sComParameter("@mobile_password",System.Data.SqlDbType.VarChar,50,password)
        });
    }
    [WebMethod]
    public void exp_schedule_service_add(int schedule_id, int service_id, int location_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_service_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id)
        });
    }
    [WebMethod]
    public int exp_schedule_delete(int schedule_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id)
        });

        return Convert.ToInt32(hasil["@schedule_id"]);
    }
    [WebMethod]
    public int exp_schedule_edit(int schedule_id, string schedule_date, Boolean done_sts, int messanger_id, string contact_name, Boolean canceled_sts, Boolean backup_approve_sts = false)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,schedule_id),
            new _DBcon.sComParameter("@schedule_date",System.Data.SqlDbType.VarChar,10,schedule_date),
            new _DBcon.sComParameter("@done_sts",System.Data.SqlDbType.Bit,0,done_sts),
            new _DBcon.sComParameter("@messanger_id",System.Data.SqlDbType.SmallInt,0,messanger_id),
            new _DBcon.sComParameter("@contact_name",System.Data.SqlDbType.VarChar,15,contact_name),
            new _DBcon.sComParameter("@canceled_sts",System.Data.SqlDbType.Bit,0,canceled_sts),
            new _DBcon.sComParameter("@backup_approve_sts",System.Data.SqlDbType.Bit,0,backup_approve_sts)
        });

        return Convert.ToInt32(hasil["@schedule_id"]);
    }
    [WebMethod]
    public int exp_schedule_add(string schedule_date, int location_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_schedule_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@schedule_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@schedule_date",System.Data.SqlDbType.VarChar,10,schedule_date),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.Int,0,location_id)
        });

        return Convert.ToInt32(hasil["@schedule_id"]);
    }
    [WebMethod]
    public void exp_location_delete(int location_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_location_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id)
        });
    }
    [WebMethod]
    public void exp_location_edit(int location_id, string location_address, int distance)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_location_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id),
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
            new _DBcon.sComParameter("@distance",System.Data.SqlDbType.Int,0,distance)
        });
    }
    [WebMethod]
    public int exp_location_add(string location_address, int distance)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("exp_location_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output),
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
            new _DBcon.sComParameter("@distance",System.Data.SqlDbType.Int,0,distance)
        });

        return Convert.ToInt32(hasil["@location_id"]);
    }
    [WebMethod]
    public void act_sales_delete(int sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_sales_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id)
        });
    }
    [WebMethod]
    public void act_sales_edit(int sales_id, int customer_id, int an_id, int contact_id, string delivery_address, string note, int delivery_address_location_id, int fee, string delivery_date, string latitude, string longitude, string branch_customer)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_sales_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@an_id",System.Data.SqlDbType.Int,0,an_id),
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id),
            new _DBcon.sComParameter("@delivery_address",System.Data.SqlDbType.Text,0,delivery_address),            
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@delivery_address_location_id",System.Data.SqlDbType.BigInt,0,delivery_address_location_id),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@delivery_date",System.Data.SqlDbType.VarChar,10,delivery_date),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
            new _DBcon.sComParameter("@branch_customer",System.Data.SqlDbType.VarChar,50,branch_customer)
        });
    }
    [WebMethod]
    public void act_sales_add(int customer_id, int an_id, int contact_id, string delivery_address, string note, int delivery_address_location_id, int fee, string latitude, string longitude, string branch_customer)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_sales_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@an_id",System.Data.SqlDbType.Int,0,an_id),
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id),
            new _DBcon.sComParameter("@delivery_address",System.Data.SqlDbType.Text,0,delivery_address),                        
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@delivery_address_location_id",System.Data.SqlDbType.BigInt,0,delivery_address_location_id),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
            new _DBcon.sComParameter("@branch_customer",System.Data.SqlDbType.VarChar,50,branch_customer)
        });
    }
    [WebMethod]
    public void act_service_delete(int service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_service_delete", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id)}
        );
    }
    [WebMethod]
    public void act_service_edit(int service_id, int customer_id, int an_id, int contact_id, string pickup_address, string note, int pickup_address_location_id, string pickup_date, int fee, string backup_sts_id, string latitude, string longitude, string branch_customer)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_service_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@an_id",System.Data.SqlDbType.Int,0,an_id),
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id),
            new _DBcon.sComParameter("@pickup_address",System.Data.SqlDbType.Text,0,pickup_address),            
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@pickup_address_location_id",System.Data.SqlDbType.Int,0,pickup_address_location_id),
            new _DBcon.sComParameter("@pickup_date",System.Data.SqlDbType.VarChar,10,pickup_date),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@backup_sts_id",System.Data.SqlDbType.Char,1,backup_sts_id),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
            new _DBcon.sComParameter("@branch_customer",System.Data.SqlDbType.VarChar,50,branch_customer)
        });
    }
    [WebMethod]
    public void act_service_add(int customer_id, int an_id, int contact_id, string pickup_address, string note, int pickup_address_location_id, string pickup_date, int fee, string backup_sts_id, string latitude, string longitude, string branch_customer)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_service_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@an_id",System.Data.SqlDbType.Int,0,an_id),
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id),
            new _DBcon.sComParameter("@pickup_address",System.Data.SqlDbType.Text,0,pickup_address),            
            new _DBcon.sComParameter("@note",System.Data.SqlDbType.Text,0,note),
            new _DBcon.sComParameter("@pickup_address_location_id",System.Data.SqlDbType.Int,0,pickup_address_location_id),
            new _DBcon.sComParameter("@pickup_date",System.Data.SqlDbType.VarChar,10,pickup_date),
            new _DBcon.sComParameter("@fee",System.Data.SqlDbType.Money,0,fee),
            new _DBcon.sComParameter("@backup_sts_id",System.Data.SqlDbType.Char,1,backup_sts_id),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
            new _DBcon.sComParameter("@branch_customer",System.Data.SqlDbType.VarChar,50,branch_customer)
        });
    }
    [WebMethod]
    public void act_customer_contact_add(int customer_id, string contact_name, string contact_phone)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_contact_add", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@contact_name",System.Data.SqlDbType.VarChar,35,contact_name),
            new _DBcon.sComParameter("@contact_phone",System.Data.SqlDbType.VarChar,15,contact_phone)
        });
    }
    [WebMethod]
    public void act_customer_contact_edit(int contact_id, string contact_name, string contact_phone)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_contact_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id),
            new _DBcon.sComParameter("@contact_name",System.Data.SqlDbType.VarChar,35,contact_name),
            new _DBcon.sComParameter("@contact_phone",System.Data.SqlDbType.VarChar,15,contact_phone)
        });
    }
    [WebMethod]
    public void act_customer_contact_delete(int contact_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_contact_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@contact_id",System.Data.SqlDbType.Int,0,contact_id)            
        });
    }
    [WebMethod]
    public int act_customer_add(string customer_name, string location_address, string customer_address, string customer_phone, string customer_fax, string customer_email, string marketing_id, int customer_address_location_id, string npwp, string latitude, string longitude, int branch_id, Boolean user_device_mandatory)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_add", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@customer_name",System.Data.SqlDbType.VarChar,100,customer_name),
                new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
                new _DBcon.sComParameter("@customer_address",System.Data.SqlDbType.VarChar,300,customer_address),
                new _DBcon.sComParameter("@customer_phone",System.Data.SqlDbType.VarChar,15,customer_phone),
                new _DBcon.sComParameter("@customer_fax",System.Data.SqlDbType.VarChar,15,customer_fax),
                new _DBcon.sComParameter("@customer_email",System.Data.SqlDbType.VarChar,150,customer_email),                
                new _DBcon.sComParameter("@marketing_id",System.Data.SqlDbType.VarChar,15,marketing_id),
                new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output),
                new _DBcon.sComParameter("@customer_address_location_id",System.Data.SqlDbType.Int,0,customer_address_location_id),
                new _DBcon.sComParameter("@npwp",System.Data.SqlDbType.VarChar,50,npwp),
                new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
                new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
                new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id),
                new _DBcon.sComParameter("@user_device_mandatory",System.Data.SqlDbType.Bit,0,user_device_mandatory)
            });

        return Convert.ToInt32(hasil["@customer_id"]);

    }
    [WebMethod]
    public void act_customer_edit(int customer_id, string customer_name, string location_address, string customer_address, string customer_phone, string customer_fax, string customer_email, string marketing_id, int location_id, int group_customer_id, int customer_address_location_id, string npwp, string latitude, string longitude, int branch_id, Boolean user_device_mandatory)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_edit", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id),
            new _DBcon.sComParameter("@customer_name",System.Data.SqlDbType.VarChar,100,customer_name),
            new _DBcon.sComParameter("@location_address",System.Data.SqlDbType.VarChar,300,location_address),
            new _DBcon.sComParameter("@customer_address",System.Data.SqlDbType.Text,0,customer_address),
            new _DBcon.sComParameter("@customer_phone",System.Data.SqlDbType.VarChar,15,customer_phone),
            new _DBcon.sComParameter("@customer_fax",System.Data.SqlDbType.VarChar,15,customer_fax),
            new _DBcon.sComParameter("@customer_email",System.Data.SqlDbType.VarChar,150,customer_email),            
            new _DBcon.sComParameter("@marketing_id",System.Data.SqlDbType.VarChar,15,marketing_id),
            new _DBcon.sComParameter("@location_id",System.Data.SqlDbType.BigInt,0,location_id),
            new _DBcon.sComParameter("@group_customer_id",System.Data.SqlDbType.Int,0,group_customer_id),
            new _DBcon.sComParameter("@customer_address_location_id",System.Data.SqlDbType.Int,0,customer_address_location_id),
            new _DBcon.sComParameter("@npwp",System.Data.SqlDbType.VarChar,50,npwp),
            new _DBcon.sComParameter("@latitude",System.Data.SqlDbType.VarChar,50,latitude),
            new _DBcon.sComParameter("@longitude",System.Data.SqlDbType.VarChar,50,longitude),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id),
            new _DBcon.sComParameter("@user_device_mandatory",System.Data.SqlDbType.Bit,0,user_device_mandatory)
        });

    }
    [WebMethod]
    public void act_customer_delete(int customer_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_customer_delete", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@customer_id",System.Data.SqlDbType.Int,0,customer_id)
        });

    }
    [WebMethod]
    public void act_marketing_delete(string marketing_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_marketing_delete", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@marketing_id",System.Data.SqlDbType.VarChar,15,marketing_id)
            });

    }
    [WebMethod]
    public void act_marketing_save(string marketing_id, string marketing_name, string marketing_phone, string user_id, Boolean all_access, Boolean dashboard_visible, double target_value, int marketing_group_id, byte[] ttd_image, string assistant_user_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("act_marketing_save", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@marketing_id",System.Data.SqlDbType.VarChar,15,marketing_id),
                new _DBcon.sComParameter("@marketing_name",System.Data.SqlDbType.VarChar,50,marketing_name),
                new _DBcon.sComParameter("@marketing_phone",System.Data.SqlDbType.VarChar,15,marketing_phone),
                new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,15,user_id),
                new _DBcon.sComParameter("@all_access",System.Data.SqlDbType.Bit,0,all_access),
                new _DBcon.sComParameter("@dashboard_visible",System.Data.SqlDbType.Bit,0,dashboard_visible),
                new _DBcon.sComParameter("@target_value",System.Data.SqlDbType.Money,0,target_value),
                new _DBcon.sComParameter("@marketing_group_id",System.Data.SqlDbType.Int,0,marketing_group_id),
                new _DBcon.sComParameter("@ttd_image",System.Data.SqlDbType.Image,0,ttd_image),
                new _DBcon.sComParameter("@assistant_user_id",System.Data.SqlDbType.VarChar,15,assistant_user_id),
            });
    }
    [WebMethod]
    public Boolean get_closehour_sts()
    {
        int close_hour = 0;
        string strSQL = "select nilai from appParameter where kode='closehour'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            close_hour = Convert.ToInt32(row["nilai"]);
        }

        return (DateTime.Now.Hour >= close_hour);
    }
    [WebMethod]
    public string save_image(byte[] data)
    {
        return "tersimpan: " + data.Length.ToString();
    }
    [WebMethod]
    public string appParameter_nilai(string kode)
    {
        string nilai = "";
        string strSQL = "select * from (select Nilai from appParameter where kode='" + kode + "')a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            nilai = row["nilai"].ToString();
        }

        return nilai;
    }
    [WebMethod]
    public void opr_sales_approver_add(string user_id, string approver_name, double limit_awal, double limit_akhir, Boolean active_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_approver_add", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,15,user_id),
                new _DBcon.sComParameter("@approver_name",System.Data.SqlDbType.VarChar,50,approver_name),
                new _DBcon.sComParameter("@limit_awal",System.Data.SqlDbType.Money,0,limit_awal),
                new _DBcon.sComParameter("@limit_akhir",System.Data.SqlDbType.Money,0,limit_akhir),
                new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            });
    }
    [WebMethod]
    public void opr_sales_approver_edit(int approver_id, string user_id, string approver_name, double limit_awal, double limit_akhir, Boolean active_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_approver_edit", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@approver_id",System.Data.SqlDbType.Int,0,approver_id), 
                new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,15,user_id),
                new _DBcon.sComParameter("@approver_name",System.Data.SqlDbType.VarChar,50,approver_name),
                new _DBcon.sComParameter("@limit_awal",System.Data.SqlDbType.Money,0,limit_awal),
                new _DBcon.sComParameter("@limit_akhir",System.Data.SqlDbType.Money,0,limit_akhir),
                new _DBcon.sComParameter("@active_sts",System.Data.SqlDbType.Bit,0,active_sts),
            });
    }
    [WebMethod]
    public void opr_sales_approver_delete(int approver_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("opr_sales_approver_delete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@approver_id",System.Data.SqlDbType.Int,0,approver_id), 
            });
    }
    [WebMethod]
    public long fin_proforma_sales_add(long proforma_sales_id, string performa_date, int top_id, string po_no, string afpo_no, string top_value, int bill_id, long sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_sales_add", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@proforma_sales_id",System.Data.SqlDbType.BigInt,0,proforma_sales_id),      
                new _DBcon.sComParameter("@proforma_date",System.Data.SqlDbType.VarChar,10,performa_date), 
                new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Int,0,top_id),
                new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
                new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
                new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,top_value),
                new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
                new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id),
                new _DBcon.sComParameter("@ret_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output)
            });
        return Convert.ToInt64(hasil["@ret_id"]);
    }
    [WebMethod]
    public void fin_proforma_sales_opr_delete(long proforma_sales_id, int sales_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_sales_opr_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@proforma_sales_id",System.Data.SqlDbType.BigInt,0,proforma_sales_id),
            new _DBcon.sComParameter("@sales_id",System.Data.SqlDbType.BigInt,0,sales_id)
        });
    }
    [WebMethod]
    public void fin_proforma_sales_edit(long proforma_sales_id, string performa_date, int top_id, string po_no, string afpo_no, string top_value, int bill_id, Boolean pph_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_sales_edit", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@proforma_sales_id",System.Data.SqlDbType.BigInt,0,proforma_sales_id),      
                new _DBcon.sComParameter("@proforma_date",System.Data.SqlDbType.VarChar,10,performa_date), 
                new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Int,0,top_id),
                new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
                new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
                new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,top_value),
                new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
                new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts)
            });
        return;
    }
    [WebMethod]
    public long fin_proforma_service_add(long proforma_service_id, string performa_date, int top_id, string po_no, string afpo_no, string top_value, int bill_id, long service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_service_add", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@proforma_service_id",System.Data.SqlDbType.BigInt,0,proforma_service_id),      
                new _DBcon.sComParameter("@proforma_date",System.Data.SqlDbType.VarChar,10,performa_date), 
                new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Int,0,top_id),
                new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
                new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
                new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,top_value),
                new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
                new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id),
                new _DBcon.sComParameter("@ret_id",System.Data.SqlDbType.BigInt,0,System.Data.ParameterDirection.Output)
            });
        return Convert.ToInt64(hasil["@ret_id"]);
    }
    [WebMethod]
    public void fin_proforma_service_opr_delete(long proforma_service_id, int service_id)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_service_opr_delete", new _DBcon.sComParameter[]{    
            new _DBcon.sComParameter("@proforma_service_id",System.Data.SqlDbType.BigInt,0,proforma_service_id),
            new _DBcon.sComParameter("@service_id",System.Data.SqlDbType.BigInt,0,service_id)
        });
    }
    [WebMethod]
    public void fin_proforma_service_edit(long proforma_service_id, string performa_date, int top_id, string po_no, string afpo_no, string top_value, int bill_id, Boolean pph_sts)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("fin_proforma_service_edit", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@proforma_service_id",System.Data.SqlDbType.BigInt,0,proforma_service_id),      
                new _DBcon.sComParameter("@proforma_date",System.Data.SqlDbType.VarChar,10,performa_date), 
                new _DBcon.sComParameter("@term_of_payment_id",System.Data.SqlDbType.Int,0,top_id),
                new _DBcon.sComParameter("@po_no",System.Data.SqlDbType.VarChar,50,po_no),
                new _DBcon.sComParameter("@afpo_no",System.Data.SqlDbType.VarChar,50,afpo_no),
                new _DBcon.sComParameter("@term_of_payment_value",System.Data.SqlDbType.VarChar,10,top_value),
                new _DBcon.sComParameter("@bill_id",System.Data.SqlDbType.Int,0,bill_id),
                new _DBcon.sComParameter("@pph_sts",System.Data.SqlDbType.Bit,0,pph_sts)
            });
        return;
    }
    [WebMethod]
    public s_fin_proforma_service_opr[] fin_proforma_service_opr_list(string proforma_service_id)
    {
        List<s_fin_proforma_service_opr> data = new List<s_fin_proforma_service_opr>();

        string strSQL = "select proforma_service_id,service_id,offer_no,dbo.f_convertDateToChar(offer_date)str_offer_date,grand_price,fee from v_fin_proforma_service_opr  where proforma_service_id=" + proforma_service_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new s_fin_proforma_service_opr(Convert.ToInt64(row["proforma_service_id"]), Convert.ToInt64(row["grand_price"]), Convert.ToInt32(row["fee"]),
                    Convert.ToInt32(row["service_id"]),
                row["offer_no"].ToString(), row["str_offer_date"].ToString()
            ));

        }
        return data.ToArray();
    }

}