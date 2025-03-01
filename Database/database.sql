USE [master]
GO
/****** Object:  Database [RISERP]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE DATABASE [RISERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RISERP', FILENAME = N'C:\adnan\project\DB\RISERP.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RISERP_log', FILENAME = N'C:\adnan\project\DB\RISERP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RISERP] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RISERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RISERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RISERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RISERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RISERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RISERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [RISERP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RISERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RISERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RISERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RISERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RISERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RISERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RISERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RISERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RISERP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RISERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RISERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RISERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RISERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RISERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RISERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RISERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RISERP] SET RECOVERY FULL 
GO
ALTER DATABASE [RISERP] SET  MULTI_USER 
GO
ALTER DATABASE [RISERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RISERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RISERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RISERP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RISERP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RISERP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RISERP', N'ON'
GO
ALTER DATABASE [RISERP] SET QUERY_STORE = OFF
GO
USE [RISERP]
GO
/****** Object:  Schema [Accounting]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Accounting]
GO
/****** Object:  Schema [Administrative]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Administrative]
GO
/****** Object:  Schema [Attendance]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Attendance]
GO
/****** Object:  Schema [Auth]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Auth]
GO
/****** Object:  Schema [DBEnum]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [DBEnum]
GO
/****** Object:  Schema [HCM]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [HCM]
GO
/****** Object:  Schema [Leave]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Leave]
GO
/****** Object:  Schema [Party]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Party]
GO
/****** Object:  Schema [Payroll]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Payroll]
GO
/****** Object:  Schema [PIMS]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [PIMS]
GO
/****** Object:  Schema [Procurement]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Procurement]
GO
/****** Object:  Schema [Security]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [Security]
GO
/****** Object:  Schema [user]    Script Date: 1/28/2025 11:12:54 AM ******/
CREATE SCHEMA [user]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_date_diff_yy_mm_dd]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_date_diff_yy_mm_dd]
(    
      
      @StartDate              DATE,
      @EndDate                DATE
)
RETURNS varchar(50)
AS 
BEGIN

DECLARE @getyymmdd varchar(50);  

 WITH ex_table AS (
  SELECT @StartDate 'startdate',
         @EndDate 'enddate')
select @getyymmdd=result from (SELECT CAST(DATEDIFF(yy, t.startdate, t.enddate) AS varchar(4)) +' y '+
       CAST(DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.startdate, t.enddate), t.startdate), t.enddate) AS varchar(2)) +' m '+
       CAST(DATEDIFF(dd, DATEADD(mm, DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.startdate, t.enddate), t.startdate), t.enddate), DATEADD(yy, DATEDIFF(yy, t.startdate, t.enddate), t.startdate)), t.enddate) AS varchar(2)) +' d' AS result
  FROM ex_table t)tt
          
    IF (@getyymmdd IS NULL)   
        SET @getyymmdd = '';  
    RETURN @getyymmdd; 
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_get_first_letter_from_line]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[fn_get_first_letter_from_line]
(
   @param_String Varchar(Max) -- Variable for string
)
RETURNS Varchar(Max)
BEGIN
	Declare @pv_xml Xml
	Declare @pv_firstletter Varchar(Max)
	Declare @pv_delimiter Varchar(5)
 
	SET @pv_delimiter=' '
	SET @pv_xml = cast(('<a>'+replace(@param_String,@pv_delimiter,'</a><a>')+'</a>') AS XML)
 
	;With CTE AS (SELECT A.value('.', 'varchar(max)') as [Column]
		FROM @pv_xml.nodes('a') AS FN(a) )
		SELECT @pv_firstletter =Stuff((SELECT '' + LEFT([Column],1)
		FROM CTE
	FOR XML PATH('') ),1,0,'')
 
	RETURN (@pv_firstletter)
END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_remove_special_cheracter]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_remove_special_cheracter]
(@param_string varchar(500))  
RETURNS VARCHAR(500)  
BEGIN  
	DECLARE @pv_starting_index int  
	SET @pv_starting_index=0  
	WHILE 1=1  
	BEGIN  
		SET @pv_starting_index= PATINDEX('%[^0-9.]%',@param_string)  
		if @pv_starting_index <> 0  
		begin  
			set @param_string = REPLACE(@param_string,SUBSTRING(@param_string,@pv_starting_index,1),'')  
		end  
			else break;  
	END  
	return @param_string  
END 
GO
/****** Object:  Table [Attendance].[Late_Early_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Late_Early_Policy](
	[late_early_policy_id] [int] NOT NULL,
	[late_early_policy_name] [nvarchar](50) NULL,
	[code] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Late_Early_Policy] PRIMARY KEY CLUSTERED 
(
	[late_early_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy_Leave]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy_Leave](
	[attendance_policy_leave_id] [int] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[leave_policy_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy_Leave] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_leave_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Absenteeism_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Absenteeism_Policy](
	[absenteeism_policy_id] [int] NOT NULL,
	[absenteeism_policy_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](500) NULL,
	[is_leave_adjustment] [bit] NOT NULL,
	[salary_head_id] [int] NULL,
	[percent_value] [int] NULL,
	[is_gross] [bit] NOT NULL,
	[basic_salary_head_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Absenteeism_Policy] PRIMARY KEY CLUSTERED 
(
	[absenteeism_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Info]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Info](
	[user_info_id] [bigint] NOT NULL,
	[login_id] [nvarchar](50) NOT NULL,
	[employee_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[is_active] [bit] NOT NULL,
	[company_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[user_type_enum_id] [tinyint] NOT NULL,
	[phone_no] [nvarchar](50) NULL,
	[mobile_no] [nvarchar](50) NOT NULL,
	[email_address] [nvarchar](50) NOT NULL,
	[national_id] [nvarchar](50) NULL,
	[password] [nvarchar](150) NOT NULL,
	[user_image_path] [nvarchar](300) NULL,
	[signature_image_path] [nvarchar](300) NULL,
	[is_password_reset] [bit] NOT NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[created_user_info_id] [int] NOT NULL,
	[updated_user_info_id] [int] NULL,
	[company_group_id] [int] NOT NULL,
 CONSTRAINT [PK_User_Info] PRIMARY KEY CLUSTERED 
(
	[user_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_email_address] UNIQUE NONCLUSTERED 
(
	[email_address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_login_id] UNIQUE NONCLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy](
	[attendance_policy_id] [int] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[policy_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](500) NULL,
	[attendance_calendar_id] [int] NOT NULL,
	[late_early_policy_id] [int] NULL,
	[absenteeism_policy_id] [int] NULL,
	[roster_policy_id] [int] NULL,
	[is_random_dayoff] [bit] NOT NULL,
	[no_of_random_dayoff] [int] NULL,
	[is_allow_benefit_policy] [bit] NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NOT NULL,
	[approve_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Leave].[Leave_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Leave].[Leave_Policy](
	[leave_policy_id] [int] NOT NULL,
	[leave_policy_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[is_proportionate] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[leave_head_id] [int] NOT NULL,
	[default_leave_balance_day] [decimal](18, 2) NULL,
	[default_leave_balance_min] [int] NULL,
	[max_enjoyable_limit_min] [int] NULL,
	[max_carry_leave_limit_min] [int] NULL,
	[max_carry_year] [int] NULL,
	[is_hourly] [bit] NOT NULL,
	[is_attachment_required] [bit] NOT NULL,
	[attachment_required_for_min] [int] NULL,
	[is_allow_sandwich] [bit] NOT NULL,
	[is_sandwich_dayoff] [bit] NOT NULL,
	[is_sandwich_holiday] [bit] NOT NULL,
	[is_sandwich_uneven] [bit] NOT NULL,
	[is_prefix] [bit] NOT NULL,
	[is_prefix_dayoff] [bit] NOT NULL,
	[is_prefix_holiday] [bit] NOT NULL,
	[is_prefix_uneven] [bit] NOT NULL,
	[is_sufix] [bit] NOT NULL,
	[is_sufix_dayoff] [bit] NOT NULL,
	[is_sufix_holiday] [bit] NOT NULL,
	[is_sufix_uneven] [bit] NOT NULL,
	[is_required_purpose] [bit] NOT NULL,
	[purpose_required_for_min] [int] NULL,
	[is_leave_area_required] [bit] NOT NULL,
	[area_required_for_min] [int] NULL,
	[is_responsible_person_required] [bit] NOT NULL,
	[responsible_person_required_for_min] [int] NULL,
	[is_negetive_balance] [bit] NOT NULL,
	[max_negetive_balance_min] [int] NULL,
	[notice_period] [int] NULL,
	[notice_required_for_min] [int] NULL,
	[earn_day_count] [int] NULL,
	[is_earn_dayoff] [bit] NOT NULL,
	[is_earn_holiday] [bit] NOT NULL,
	[is_earn_uneven] [bit] NOT NULL,
	[is_earn_absent] [bit] NOT NULL,
	[encash_leave_balance_limit_min] [int] NULL,
	[encash_fixed_amount] [decimal](18, 2) NULL,
	[encash_amount_percent] [int] NULL,
	[is_gross] [bit] NOT NULL,
	[salary_head_id] [int] NULL,
	[activation_days] [int] NULL,
	[is_activation_on_joining] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Leave_Policy_Detail_1] PRIMARY KEY CLUSTERED 
(
	[leave_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Software_Sharing_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Software_Sharing_Policy](
	[software_sharing_policy_id] [int] NOT NULL,
	[is_shared] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
 CONSTRAINT [PK_Software_Sharing_Policy] PRIMARY KEY CLUSTERED 
(
	[software_sharing_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Roster_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Roster_Policy](
	[roster_policy_id] [int] NOT NULL,
	[roster_policy_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[roster_cycle] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Roster_Policy] PRIMARY KEY CLUSTERED 
(
	[roster_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Calendar]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Calendar](
	[attendance_calendar_id] [int] NOT NULL,
	[attendance_calendar_name] [nvarchar](100) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Attendance_Calendar] PRIMARY KEY CLUSTERED 
(
	[attendance_calendar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Attendance].[View_AttendancePolicies]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Attendance].[View_AttendancePolicies]
AS

		  SELECT ( select is_shared from Auth.Software_Sharing_Policy) isShared,S.attendance_policy_id,S.policy_name,ac.attendance_calendar_name,lp.leave_policy_name,l.late_early_policy_name,ap.absenteeism_policy_name,r.roster_policy_name, 
		  CASE WHEN(s.approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(s.approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
          ,s.is_active
		  FROM Attendance.Attendance_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
          LEFT JOIN Attendance.Attendance_Calendar ac on ac.attendance_calendar_id=s.attendance_calendar_id
          LEFT JOIN Attendance.Absenteeism_Policy ap on ap.absenteeism_policy_id=s.absenteeism_policy_id
          LEFT JOIN Attendance.Late_Early_Policy l on l.late_early_policy_id=s.late_early_policy_id
          LEFT JOIN Attendance.Roster_Policy r on r.roster_policy_id=s.roster_policy_id
          LEFT JOIN Attendance.Attendance_Policy_Leave apl on apl.attendance_policy_id=s.attendance_policy_id
          LEFT JOIN Leave.Leave_Policy lp on lp.leave_policy_id=apl.leave_policy_id
		
GO
/****** Object:  View [Attendance].[View_LateEarlyPolicies]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Attendance].[View_LateEarlyPolicies]
AS

          SELECT ( select is_shared from Auth.Software_Sharing_Policy) isShared,s.company_group_id,s.company_corporate_id,s.company_id,S.late_early_policy_id,S.late_early_policy_name,s.remarks, 
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
          ,s.is_active
		  FROM Attendance.Late_Early_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
GO
/****** Object:  View [Attendance].[View_AbsenteeismPolicy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [Attendance].[View_AbsenteeismPolicy]
AS

  
    SELECT     ( select is_shared from Auth.Software_Sharing_Policy) isShared,s.company_group_id,s.company_id,S.absenteeism_policy_id,S.absenteeism_policy_name,is_leave_adjustment,CASE WHEN (salary_head_id>0) THEN (Convert(varchar,percent_value)+ ' % of ' +CASE WHEN (is_gross=1) THEN 'Gross'  ELSE 'Basic' End) ELSE '' END salary_adjustment,  
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
		  FROM Attendance.Absenteeism_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 


GO
/****** Object:  Table [Attendance].[Attendance_Benefit_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Benefit_Policy](
	[abp_id] [int] NOT NULL,
	[abp_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[benefit_work_on_id_enum] [tinyint] NOT NULL,
	[minimum_working_hour_min] [int] NOT NULL,
	[time_start] [time](7) NULL,
	[time_end] [time](7) NULL,
	[holiday_id] [int] NULL,
	[OT_policy_id] [int] NULL,
	[leave_head_id] [int] NULL,
	[leave_amount] [int] NULL,
	[leave_expire_day] [int] NULL,
	[salary_head_id] [int] NULL,
	[fixed_value] [decimal](18, 2) NULL,
	[percent_value] [int] NULL,
	[is_gross] [bit] NOT NULL,
	[basic_salary_head_id] [int] NULL,
	[is_calculate_per_working_hour] [bit] NOT NULL,
	[is_effect_on_payroll] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Attendance_Benefit_Policy] PRIMARY KEY CLUSTERED 
(
	[abp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Attendance].[View_Att_Benefit_Policy]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Attendance].[View_Att_Benefit_Policy]
AS

  
  SELECT (select is_shared from Auth.Software_Sharing_Policy) isShared,S.abp_id,S.abp_name,s.benefit_work_on_id_enum,minimum_working_hour_min/60 minimum_working_hour_min,
  CASE When(OT_policy_id!=0 AND leave_head_id!=0) then 'Allow OT,' When(OT_policy_id!=0 AND leave_head_id=0) THEN 'Allow OT' else '' end +''+  Case When( leave_head_id!=0 AND salary_head_id!=0) then 'Allow Leave,' When( leave_head_id!=0 AND salary_head_id=0) THEN 'Allow Leave' else '' end  +''+   Case When(salary_head_id!=0) then 'Allow Monetary' else '' end as benefit,
  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
  FROM [Attendance].Attendance_Benefit_Policy s
  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id        


GO
/****** Object:  Table [Leave].[Leave_Head]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Leave].[Leave_Head](
	[leave_head_id] [int] NOT NULL,
	[head_name] [nvarchar](50) NOT NULL,
	[leave_head_short_name] [nvarchar](10) NOT NULL,
	[leave_type_id_enum] [tinyint] NOT NULL,
	[required_for_id_enum] [tinyint] NOT NULL,
	[name_in_local_language] [nvarchar](100) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
 CONSTRAINT [PK_Leave_Head] PRIMARY KEY CLUSTERED 
(
	[leave_head_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_head_name] UNIQUE NONCLUSTERED 
(
	[head_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_leave_head_short_name] UNIQUE NONCLUSTERED 
(
	[leave_head_short_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Leave].[View_LeavePolicies]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Leave].[View_LeavePolicies]
AS

  
    SELECT     ( select is_shared from Auth.Software_Sharing_Policy) isShared,L.head_name, S.leave_policy_id,s.company_group_id,s.company_corporate_id,s.company_id,S.leave_policy_name,s.remarks,L.leave_head_short_name,S.default_leave_balance_day,CASE WHEN (is_activation_on_joining=1) then  'After'+' '+cast(activation_days as varchar)+' '+'days of joining' else 'After'+' '+cast(activation_days as varchar) +' '+'days of confirmation' end activationdays,max_enjoyable_limit_min/60.0 max_enjoyable_limit,
	CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
	,s.is_active
	FROM Leave.Leave_Policy s
	LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
	LEFT JOIN Leave.Leave_Head L ON S.leave_head_id=L.leave_head_id


GO
/****** Object:  Table [Accounting].[Accounting_Voucher_Type]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accounting].[Accounting_Voucher_Type](
	[accounting_voucher_type_id] [int] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[voucher_type] [nvarchar](100) NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Accounting_Voucher_Type] PRIMARY KEY CLUSTERED 
(
	[accounting_voucher_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_accounting_voucher_type_code] UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Accounting].[Chart_Of_Accounts_Info]    Script Date: 1/28/2025 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accounting].[Chart_Of_Accounts_Info](
	[chart_of_accounts_info_id] [bigint] IDENTITY(1,1) NOT NULL,
	[parent_key] [varchar](50) NOT NULL,
	[node_key]  AS (CONVERT([varchar](100),ltrim(isnull([parent_key],''))+ltrim(str([chart_of_accounts_info_id])),(0))),
	[account_code] [varchar](50) NOT NULL,
	[account_head] [nvarchar](150) NOT NULL,
	[account_details] [nvarchar](350) NOT NULL,
	[ext] [nvarchar](50) NULL,
	[cat_code_1] [nvarchar](50) NULL,
	[cat_code_2] [nvarchar](50) NULL,
	[cat_code_3] [nvarchar](50) NULL,
	[cat_code_4] [nvarchar](50) NULL,
	[cat_code_5] [nvarchar](50) NULL,
	[cat_code_6] [nvarchar](50) NULL,
	[cat_code_7] [nvarchar](50) NULL,
	[cat_code_8] [nvarchar](50) NULL,
	[cat_code_9] [nvarchar](50) NULL,
	[cat_code_10] [nvarchar](50) NULL,
	[cat_code_11] [nvarchar](50) NULL,
	[cat_code_12] [nvarchar](50) NULL,
	[sub_head] [varchar](1) NOT NULL,
	[is_subsidiary] [varchar](1) NOT NULL,
	[is_system_head] [varchar](1) NOT NULL,
	[transaction_type] [varchar](10) NOT NULL,
	[branch_id] [int] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Chart_Of_Accounts_Info] PRIMARY KEY CLUSTERED 
(
	[chart_of_accounts_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_ChartOfAccountsInfo_account_code] UNIQUE NONCLUSTERED 
(
	[account_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Accounting].[Chart_Of_Accounts_Opening_Balance]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accounting].[Chart_Of_Accounts_Opening_Balance](
	[chart_of_accounts_opening_balance_id] [bigint] IDENTITY(1,1) NOT NULL,
	[chart_of_accounts_info_id] [bigint] NOT NULL,
	[opening_balance] [decimal](18, 2) NOT NULL,
	[branch_auto_id] [int] NULL,
	[opening_date] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Chart_Of_Accounts_Opening_Balance] PRIMARY KEY CLUSTERED 
(
	[chart_of_accounts_opening_balance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Accounting].[Voucher]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accounting].[Voucher](
	[voucher_id] [bigint] IDENTITY(1,1) NOT NULL,
	[accounting_voucher_type_id] [int] NOT NULL,
	[voucher_date] [datetime] NOT NULL,
	[voucher_no] [varchar](50) NOT NULL,
	[ref_no] [varchar](50) NULL,
	[receiver] [varchar](100) NULL,
	[cheque_no] [varchar](50) NULL,
	[remarks] [varchar](350) NULL,
	[branch_id] [int] NULL,
	[post] [varchar](1) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_id] [bigint] NULL,
	[created_datetime] [datetime] NULL,
	[updated_user_id] [int] NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NULL,
 CONSTRAINT [PK_Accounts_Transaction_Info] PRIMARY KEY CLUSTERED 
(
	[voucher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Accounting].[Voucher_Detail]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accounting].[Voucher_Detail](
	[voucher_details_id] [bigint] IDENTITY(1,1) NOT NULL,
	[voucher_id] [bigint] NOT NULL,
	[chart_of_account_auto_id] [bigint] NOT NULL,
	[tr_type] [char](2) NOT NULL,
	[debit] [decimal](18, 2) NOT NULL,
	[credit] [decimal](18, 2) NOT NULL,
	[remarks] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Voucher_Details] PRIMARY KEY CLUSTERED 
(
	[voucher_details_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Active_Inactive_History]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Active_Inactive_History](
	[active_inactive_history_id] [int] NOT NULL,
	[table_schema_name] [nvarchar](100) NOT NULL,
	[table_name] [nvarchar](100) NOT NULL,
	[obj_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Active_Inactive_History] PRIMARY KEY CLUSTERED 
(
	[active_inactive_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Association]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Association](
	[association_id] [int] NOT NULL,
	[association_name] [nvarchar](100) NOT NULL,
	[abbreviation] [nvarchar](10) NULL,
	[country_id] [int] NOT NULL,
	[organization_type_id_enum] [int] NOT NULL,
	[remarks] [nchar](100) NULL,
 CONSTRAINT [PK_Association] PRIMARY KEY CLUSTERED 
(
	[association_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_association] UNIQUE NONCLUSTERED 
(
	[organization_type_id_enum] ASC,
	[association_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Bank]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Bank](
	[bank_id] [int] NOT NULL,
	[bank_name] [nvarchar](100) NOT NULL,
	[bank_short_name] [nvarchar](30) NULL,
	[bank_swift_code] [nvarchar](20) NOT NULL,
	[bank_email] [nvarchar](50) NULL,
	[bank_web_url] [nvarchar](100) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[remarks] [nvarchar](300) NULL,
	[is_bank] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_local] [bit] NOT NULL,
 CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED 
(
	[bank_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_bank_name] UNIQUE NONCLUSTERED 
(
	[bank_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_bank_swift_code] UNIQUE NONCLUSTERED 
(
	[bank_swift_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Bank_Branch]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Bank_Branch](
	[bank_branch_id] [int] NOT NULL,
	[bank_branch_name] [nvarchar](50) NOT NULL,
	[bank_branch_short_name] [nvarchar](30) NULL,
	[bank_branch_routing] [nvarchar](20) NOT NULL,
	[bank_id] [int] NOT NULL,
	[bank_branch_contact_number] [nvarchar](20) NULL,
	[bank_branch_email] [nvarchar](40) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[remarks] [nvarchar](300) NULL,
	[is_branch] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_Bank_Branch] PRIMARY KEY CLUSTERED 
(
	[bank_branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_bank_branch_name] UNIQUE NONCLUSTERED 
(
	[bank_branch_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_bank_branch_routing] UNIQUE NONCLUSTERED 
(
	[bank_branch_routing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Business_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Business_Type](
	[business_type_id] [int] NOT NULL,
	[business_type_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Business_Type] PRIMARY KEY CLUSTERED 
(
	[business_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_business_type_name] UNIQUE NONCLUSTERED 
(
	[business_type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company](
	[company_id] [int] NOT NULL,
	[company_code] [nvarchar](20) NOT NULL,
	[company_name] [nvarchar](100) NOT NULL,
	[company_short_name] [nvarchar](10) NOT NULL,
	[company_prefix] [nvarchar](5) NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_reg_no] [nvarchar](20) NULL,
	[company_reg_date] [date] NULL,
	[company_reg_file_path] [nvarchar](300) NULL,
	[company_tin_no] [nvarchar](20) NULL,
	[company_tin_date] [date] NULL,
	[company_tin_file_path] [nvarchar](300) NULL,
	[currency_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[thana_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](300) NULL,
	[logo] [nvarchar](300) NULL,
	[slogan] [nvarchar](300) NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[address_in_local_language] [nvarchar](300) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_company_code] UNIQUE NONCLUSTERED 
(
	[company_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_company_name] UNIQUE NONCLUSTERED 
(
	[company_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_company_short_name] UNIQUE NONCLUSTERED 
(
	[company_short_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_BIN]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_BIN](
	[company_bin_id] [nvarchar](15) NOT NULL,
	[company_id] [int] NULL,
	[bin_reg_date] [date] NOT NULL,
	[bin_expire_date] [date] NULL,
	[bin_file_path] [nvarchar](300) NULL,
	[vat_circle_id] [int] NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Company_BIN] PRIMARY KEY CLUSTERED 
(
	[company_bin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Business_Nature]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Business_Nature](
	[company_business_nature_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[company_type_enum_id] [tinyint] NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Company_Business_Nature] PRIMARY KEY CLUSTERED 
(
	[company_business_nature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Corporate]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Corporate](
	[company_corporate_id] [int] NOT NULL,
	[company_corporate_name] [nvarchar](100) NOT NULL,
	[company_corporate_short_name] [nvarchar](10) NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](300) NULL,
	[logo] [nvarchar](300) NULL,
	[slogan] [nvarchar](300) NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Global_Corporate] PRIMARY KEY CLUSTERED 
(
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_company_corporate_name] UNIQUE NONCLUSTERED 
(
	[company_corporate_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_company_corporate_short_name] UNIQUE NONCLUSTERED 
(
	[company_corporate_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Group]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Group](
	[company_group_id] [int] NOT NULL,
	[group_name] [nvarchar](100) NOT NULL,
	[group_short_name] [nvarchar](10) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[thana_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](300) NULL,
	[currency_id] [int] NULL,
	[group_logo] [nvarchar](300) NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[address_in_local_language] [nvarchar](300) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Corporate_Group] PRIMARY KEY CLUSTERED 
(
	[company_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_group_name] UNIQUE NONCLUSTERED 
(
	[group_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_group_short_name] UNIQUE NONCLUSTERED 
(
	[group_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Group_Old]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Group_Old](
	[company_group_id] [int] NOT NULL,
	[group_name] [nvarchar](100) NOT NULL,
	[group_short_name] [nvarchar](10) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](300) NULL,
	[currency_id] [int] NULL,
	[group_logo] [nvarchar](300) NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[address_in_local_language] [nvarchar](300) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Industry_Sub_Sector]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Industry_Sub_Sector](
	[company_industry_sub_sector_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[industry_sub_sector_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Company_Industry_Sub_Sector] PRIMARY KEY CLUSTERED 
(
	[company_industry_sub_sector_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Company_Ownership_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Company_Ownership_Type](
	[company_ownership_type_id] [int] NOT NULL,
	[company_id] [int] NULL,
	[ownership_type_id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Company_Ownership_Type] PRIMARY KEY CLUSTERED 
(
	[company_ownership_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Competency]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Competency](
	[competency_id] [int] NOT NULL,
	[competency_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Competency] PRIMARY KEY CLUSTERED 
(
	[competency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_competency_name] UNIQUE NONCLUSTERED 
(
	[competency_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Contact_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Contact_Type](
	[contact_type_id] [int] NOT NULL,
	[contact_type_name] [nvarchar](50) NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Contact_Type] PRIMARY KEY CLUSTERED 
(
	[contact_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_contact_type] UNIQUE NONCLUSTERED 
(
	[contact_type_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Country]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Country](
	[country_id] [int] NOT NULL,
	[continent_enum_id] [tinyint] NOT NULL,
	[country_code] [nvarchar](10) NOT NULL,
	[country_name] [nvarchar](50) NOT NULL,
	[country_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_country_code] UNIQUE NONCLUSTERED 
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_country_name] UNIQUE NONCLUSTERED 
(
	[country_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_country_short_name] UNIQUE NONCLUSTERED 
(
	[country_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Currency]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Currency](
	[currency_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[currency_name] [nvarchar](50) NOT NULL,
	[issue_organization] [nvarchar](50) NOT NULL,
	[symbol] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_symbol] UNIQUE NONCLUSTERED 
(
	[symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Department]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Department](
	[department_id] [int] NOT NULL,
	[department_code] [nvarchar](20) NOT NULL,
	[department_name] [nvarchar](100) NOT NULL,
	[department_short_name] [nvarchar](10) NOT NULL,
	[department_type_id] [tinyint] NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[remarks] [nvarchar](500) NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_department_code] UNIQUE NONCLUSTERED 
(
	[department_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_department_name] UNIQUE NONCLUSTERED 
(
	[department_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_department_short_name] UNIQUE NONCLUSTERED 
(
	[department_short_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Designation]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Designation](
	[designation_id] [int] NOT NULL,
	[designation_code] [nvarchar](20) NOT NULL,
	[designation_name] [nvarchar](100) NOT NULL,
	[designation_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[remarks] [nvarchar](500) NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[designation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_designation_code] UNIQUE NONCLUSTERED 
(
	[designation_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_designation_name] UNIQUE NONCLUSTERED 
(
	[designation_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_designation_short_name] UNIQUE NONCLUSTERED 
(
	[designation_short_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[District]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[District](
	[district_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_code] [nvarchar](10) NOT NULL,
	[district_name] [nvarchar](50) NOT NULL,
	[district_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_district_code] UNIQUE NONCLUSTERED 
(
	[district_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_district_name] UNIQUE NONCLUSTERED 
(
	[district_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_district_short_name] UNIQUE NONCLUSTERED 
(
	[district_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Division]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Division](
	[division_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_code] [nvarchar](10) NOT NULL,
	[division_name] [nvarchar](50) NOT NULL,
	[division_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED 
(
	[division_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_division_code] UNIQUE NONCLUSTERED 
(
	[division_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_division_name] UNIQUE NONCLUSTERED 
(
	[division_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_division_short_name] UNIQUE NONCLUSTERED 
(
	[division_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Document_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Document_Type](
	[document_type_id] [int] NOT NULL,
	[document_type_name] [nvarchar](50) NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Document_Type] PRIMARY KEY CLUSTERED 
(
	[document_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_document_type] UNIQUE NONCLUSTERED 
(
	[document_type_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Ecommerce_Platforms]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Ecommerce_Platforms](
	[ecommerce_paltforms_id] [int] NOT NULL,
	[ecommerce_paltforms_name] [nvarchar](50) NOT NULL,
	[country_id] [int] NULL,
	[remarks] [nvarchar](100) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_Ecommerce_Platforms] PRIMARY KEY CLUSTERED 
(
	[ecommerce_paltforms_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_ecommerce_platforms] UNIQUE NONCLUSTERED 
(
	[ecommerce_paltforms_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Education]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Education](
	[education_id] [int] NOT NULL,
	[education_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Education] PRIMARY KEY CLUSTERED 
(
	[education_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_education_name] UNIQUE NONCLUSTERED 
(
	[education_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Industry_Sector]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Industry_Sector](
	[industry_sector_id] [int] NOT NULL,
	[industry_sector_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Industry_Sector] PRIMARY KEY CLUSTERED 
(
	[industry_sector_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_industry_sector_name] UNIQUE NONCLUSTERED 
(
	[industry_sector_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Industry_Sub_Sector]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Industry_Sub_Sector](
	[industry_sub_sector_id] [int] NOT NULL,
	[industry_sector_id] [int] NOT NULL,
	[industry_sub_sector_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Industry_Sub_Sector] PRIMARY KEY CLUSTERED 
(
	[industry_sub_sector_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_industry_sub_sector_name] UNIQUE NONCLUSTERED 
(
	[industry_sub_sector_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Key_Skill]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Key_Skill](
	[key_skill_id] [int] NOT NULL,
	[key_skill_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Key_Skill] PRIMARY KEY CLUSTERED 
(
	[key_skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_key_skill_name] UNIQUE NONCLUSTERED 
(
	[key_skill_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Location]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Location](
	[location_id] [int] NOT NULL,
	[location_code] [nvarchar](20) NOT NULL,
	[location_name] [nvarchar](100) NOT NULL,
	[location_short_name] [nvarchar](10) NOT NULL,
	[location_prefix] [nvarchar](5) NOT NULL,
	[location_reg_no] [nvarchar](20) NULL,
	[location_reg_date] [date] NULL,
	[location_reg_file_path] [nvarchar](300) NULL,
	[vat_applicable_type_enum_id] [tinyint] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[thana_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](300) NULL,
	[remarks] [nvarchar](500) NULL,
	[is_active] [bit] NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[address_in_local_language] [nvarchar](300) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NULL,
	[company_id] [int] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_location_code] UNIQUE NONCLUSTERED 
(
	[location_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_location_name] UNIQUE NONCLUSTERED 
(
	[location_name] ASC,
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_location_short_name] UNIQUE NONCLUSTERED 
(
	[location_short_name] ASC,
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Location_BIN]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Location_BIN](
	[location_bin_id] [nvarchar](15) NOT NULL,
	[location_id] [int] NOT NULL,
	[bin_reg_date] [date] NOT NULL,
	[bin_expire_date] [date] NULL,
	[bin_file_path] [nvarchar](300) NULL,
	[vat_circle_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
 CONSTRAINT [PK_Location_BIN] PRIMARY KEY CLUSTERED 
(
	[location_bin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Location_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Location_Type](
	[location_type_id] [int] NOT NULL,
	[location_type_name] [nvarchar](50) NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Location_Type] PRIMARY KEY CLUSTERED 
(
	[location_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_location_type] UNIQUE NONCLUSTERED 
(
	[location_type_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Mobile_Financial_Service]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Mobile_Financial_Service](
	[mfs_id] [int] NOT NULL,
	[mfs_name] [nvarchar](50) NOT NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Mobile_Financial_Service] PRIMARY KEY CLUSTERED 
(
	[mfs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_mobile_financial_service] UNIQUE NONCLUSTERED 
(
	[mfs_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram](
	[organogram_id] [int] NOT NULL,
	[organogram_code] [nvarchar](20) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[parent_id] [int] NOT NULL,
	[sorting_priority] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Organogram] PRIMARY KEY CLUSTERED 
(
	[organogram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Organogram_Code] UNIQUE NONCLUSTERED 
(
	[organogram_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Department]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Department](
	[organogram_department_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[organogram_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[parent_id] [int] NOT NULL,
	[sorting_priority] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Organogram_Department] PRIMARY KEY CLUSTERED 
(
	[organogram_department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Detail]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Detail](
	[organogram_detail_id] [int] NOT NULL,
	[organogram_id] [int] NOT NULL,
	[code] [nvarchar](20) NOT NULL,
	[position_id] [int] NOT NULL,
	[min_no_of_manpower] [int] NULL,
	[max_no_of_manpower] [int] NULL,
	[min_budget] [decimal](18, 2) NULL,
	[max_budget] [decimal](18, 2) NULL,
	[min_year_of_experience] [int] NULL,
	[max_year_of_experience] [int] NULL,
	[is_open] [bit] NOT NULL,
	[increment_percentage_yearly] [decimal](18, 2) NULL,
	[is_gross] [bit] NOT NULL,
	[salary_head_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[days_of_confirmation] [int] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Organogram_Detail] PRIMARY KEY CLUSTERED 
(
	[organogram_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Detail_Competency]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Detail_Competency](
	[organogram_detail_competency_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[competency_id] [int] NOT NULL,
 CONSTRAINT [PK_Organogram_Detail_Competency] PRIMARY KEY CLUSTERED 
(
	[organogram_detail_competency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Detail_Education]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Detail_Education](
	[organogram_detail_education_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[education_id] [int] NOT NULL,
 CONSTRAINT [PK_Organogram_Detail_Education] PRIMARY KEY CLUSTERED 
(
	[organogram_detail_education_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Detail_Key_Skill]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Detail_Key_Skill](
	[organogram_detail_key_skill_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[key_skill_id] [int] NOT NULL,
 CONSTRAINT [PK_Organogram_Detail_Key_Skill] PRIMARY KEY CLUSTERED 
(
	[organogram_detail_key_skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Detail_Supervisor]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Detail_Supervisor](
	[organogram_detail_supervisor_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[reporting_line_id] [tinyint] NOT NULL,
	[position_id] [int] NOT NULL,
 CONSTRAINT [PK_Organogram_Detail_Supervisor] PRIMARY KEY CLUSTERED 
(
	[organogram_detail_supervisor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_Permission]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_Permission](
	[organogram_permisison_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[permitted_organogram_detail_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Organogram_Permission] PRIMARY KEY CLUSTERED 
(
	[organogram_permisison_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Organogram_User_Permission]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Organogram_User_Permission](
	[oup_id] [int] NOT NULL,
	[user_info_id] [bigint] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[position_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Organogram_User_Permission] PRIMARY KEY CLUSTERED 
(
	[oup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Ownership_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Ownership_Type](
	[ownership_type_id] [int] NOT NULL,
	[ownership_type_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Ownership_Type] PRIMARY KEY CLUSTERED 
(
	[ownership_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_ownership_type_name] UNIQUE NONCLUSTERED 
(
	[ownership_type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Position]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Position](
	[position_id] [int] NOT NULL,
	[position_code] [nvarchar](20) NOT NULL,
	[position_name] [nvarchar](100) NOT NULL,
	[position_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[remarks] [nvarchar](500) NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_position_code] UNIQUE NONCLUSTERED 
(
	[position_code] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_position_name] UNIQUE NONCLUSTERED 
(
	[position_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_position_short_name] UNIQUE NONCLUSTERED 
(
	[position_short_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Registry_Authority]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Registry_Authority](
	[registry_authority_id] [int] NOT NULL,
	[registry_authority_name] [nvarchar](100) NOT NULL,
	[registry_authority_short_name] [nvarchar](10) NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](100) NULL,
 CONSTRAINT [PK_Registry_Authority] PRIMARY KEY CLUSTERED 
(
	[registry_authority_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_registry_authority_name_country_id] UNIQUE NONCLUSTERED 
(
	[registry_authority_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Regulator]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Regulator](
	[regulator_id] [int] NOT NULL,
	[regulator_name] [nvarchar](100) NOT NULL,
	[country_id] [int] NOT NULL,
	[remarks] [nvarchar](100) NULL,
 CONSTRAINT [PK_Regulator] PRIMARY KEY CLUSTERED 
(
	[regulator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_regulator_name_country_id] UNIQUE NONCLUSTERED 
(
	[regulator_name] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Security_Deposit]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Security_Deposit](
	[security_deposit_id] [int] NOT NULL,
	[security_deposit_name] [nvarchar](50) NOT NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Security_Deposit] PRIMARY KEY CLUSTERED 
(
	[security_deposit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_security_deposit_name] UNIQUE NONCLUSTERED 
(
	[security_deposit_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Thana]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Thana](
	[thana_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[thana_code] [nvarchar](10) NOT NULL,
	[thana_name] [nvarchar](50) NOT NULL,
	[thana_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Thana] PRIMARY KEY CLUSTERED 
(
	[thana_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_thana_code] UNIQUE NONCLUSTERED 
(
	[thana_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_thana_name] UNIQUE NONCLUSTERED 
(
	[thana_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_thana_short_name] UNIQUE NONCLUSTERED 
(
	[thana_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Vat_Circle]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Vat_Circle](
	[vat_circle_id] [int] NOT NULL,
	[vat_circle_name] [nvarchar](50) NOT NULL,
	[vat_division_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Vat_Circle] PRIMARY KEY CLUSTERED 
(
	[vat_circle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Vat_Circle_Name] UNIQUE NONCLUSTERED 
(
	[vat_circle_id] ASC,
	[district_id] ASC,
	[division_id] ASC,
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Vat_Commissionerate]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Vat_Commissionerate](
	[vat_commissionerate_id] [int] NOT NULL,
	[vat_commissionerate_name] [nvarchar](50) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[country_id] [int] NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Vat_Commissionerate] PRIMARY KEY CLUSTERED 
(
	[vat_commissionerate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Vat_Division]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Vat_Division](
	[vat_division_id] [int] NOT NULL,
	[vat_division_name] [nvarchar](50) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[vat_commissionerate_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](50) NULL,
	[remarks] [nvarchar](300) NULL,
 CONSTRAINT [PK_Vat_Division] PRIMARY KEY CLUSTERED 
(
	[vat_division_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Administrative].[Zone]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Administrative].[Zone](
	[zone_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[zone_code] [nvarchar](10) NOT NULL,
	[zone_name] [nvarchar](50) NOT NULL,
	[zone_short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[short_name_in_local_language] [nvarchar](10) NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Zone] PRIMARY KEY CLUSTERED 
(
	[zone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_zone_code] UNIQUE NONCLUSTERED 
(
	[zone_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_zone_name] UNIQUE NONCLUSTERED 
(
	[zone_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_zone_short_name] UNIQUE NONCLUSTERED 
(
	[zone_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Access_Point]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Access_Point](
	[attendance_access_point_id] [int] NOT NULL,
	[access_point_name] [nvarchar](100) NOT NULL,
	[short_name] [nvarchar](50) NOT NULL,
	[machine_sl_no] [nvarchar](100) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[data_provider] [tinyint] NOT NULL,
	[is_online] [bit] NOT NULL,
	[data_source] [nvarchar](100) NOT NULL,
	[login_id] [nvarchar](100) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[db_name] [nvarchar](100) NOT NULL,
	[query_to_get_data] [nvarchar](500) NOT NULL,
	[query_to_lock_data] [nvarchar](500) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Access_Point] PRIMARY KEY CLUSTERED 
(
	[attendance_access_point_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Benefit_Policy_Company]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Benefit_Policy_Company](
	[abp_company_id] [int] NOT NULL,
	[abp_id] [int] NULL,
	[company_id] [int] NULL,
	[is_active] [bit] NULL,
	[created_user_id] [bigint] NULL,
	[db_server_date_time] [datetime] NULL,
 CONSTRAINT [PK_Attendance_Benefit_Policy_Company] PRIMARY KEY CLUSTERED 
(
	[abp_company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Calendar_Companay]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Calendar_Companay](
	[acc_id] [int] NOT NULL,
	[attendance_calendar_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_id] [int] NOT NULL,
	[db_server_date_time] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Attendance_Calendar_Companay] PRIMARY KEY CLUSTERED 
(
	[acc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Calendar_Session]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Calendar_Session](
	[acs_id] [int] NOT NULL,
	[attendance_calendar_id] [int] NULL,
	[session_name] [nvarchar](100) NOT NULL,
	[session_start_date] [date] NOT NULL,
	[session_end_date] [date] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Calendar_Session] PRIMARY KEY CLUSTERED 
(
	[acs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_session_name] UNIQUE NONCLUSTERED 
(
	[session_name] ASC,
	[attendance_calendar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Calendar_Session_Holiday]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Calendar_Session_Holiday](
	[acs_holiday_id] [int] NOT NULL,
	[acs_id] [int] NOT NULL,
	[holiday_id] [int] NOT NULL,
	[session_start_date] [date] NOT NULL,
	[session_end_date] [date] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Calendar_Session_Holiday] PRIMARY KEY CLUSTERED 
(
	[acs_holiday_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy_Benefit]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy_Benefit](
	[attendance_policy_benefit_id] [int] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[abp_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy_Benefit] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_benefit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy_Dayoff]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy_Dayoff](
	[attendance_policy_dayoff_id] [int] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[week_day] [varchar](20) NOT NULL,
	[dayoff_type_id] [tinyint] NOT NULL,
	[dayoff_alternative_id] [tinyint] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy_Dayoff] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_dayoff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy_Organogram]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy_Organogram](
	[attendance_policy_organogram_id] [int] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy_Organogram] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_organogram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Attendance_Policy_Shift]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Attendance_Policy_Shift](
	[attendance_policy_shift_id] [int] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[shift_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendance_Policy_Shift] PRIMARY KEY CLUSTERED 
(
	[attendance_policy_shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[General_Working_Day]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[General_Working_Day](
	[gwd_id] [int] NOT NULL,
	[gwd_date] [date] NOT NULL,
	[gwd_close_date] [date] NOT NULL,
	[purpose] [nvarchar](300) NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_General_Working_Day] PRIMARY KEY CLUSTERED 
(
	[gwd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[General_Working_Day_Applicable_Area]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[General_Working_Day_Applicable_Area](
	[gwd_area_id] [int] NOT NULL,
	[gwd_id] [int] NOT NULL,
	[organogram_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_General_Working_Day_Applicable_Area] PRIMARY KEY CLUSTERED 
(
	[gwd_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[General_Working_Day_Shift]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[General_Working_Day_Shift](
	[gwd_shift_id] [int] NOT NULL,
	[gwd_id] [int] NULL,
	[shift_id] [int] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_General_Working_Day_Shift] PRIMARY KEY CLUSTERED 
(
	[gwd_shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Holiday]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Holiday](
	[holiday_id] [int] NOT NULL,
	[holiday_name] [nvarchar](100) NOT NULL,
	[type_of_holiday_id_enum] [tinyint] NOT NULL,
	[days_of_month] [nvarchar](10) NULL,
	[name_in_local_language] [nvarchar](100) NULL,
	[remarks] [nvarchar](500) NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
 CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED 
(
	[holiday_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_HolidayName] UNIQUE NONCLUSTERED 
(
	[holiday_name] ASC,
	[company_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Late_Early_Policy_Detail]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Late_Early_Policy_Detail](
	[lep_detail_id] [int] NOT NULL,
	[late_early_policy_id] [int] NOT NULL,
	[late_early_type_id_enum] [tinyint] NOT NULL,
	[is_allow_late_early_slab] [bit] NOT NULL,
	[min_late_early_min] [int] NULL,
	[max_late_early_min] [int] NULL,
	[late_early_days_for] [tinyint] NULL,
	[is_consecutive] [bit] NOT NULL,
	[is_leave_adjustment] [bit] NOT NULL,
	[leave_in_min] [int] NULL,
	[is_leave_as_late_early_min] [bit] NOT NULL,
	[salary_head_id] [int] NULL,
	[percent_value] [int] NULL,
	[is_gross] [bit] NOT NULL,
	[primary_salary_head_id] [int] NULL,
	[deduction_days] [int] NULL,
	[is_deduction_monthly_min] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Late_Early_Policy_Detail] PRIMARY KEY CLUSTERED 
(
	[lep_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Overtime_Policy]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Overtime_Policy](
	[OT_policy_id] [int] NOT NULL,
	[policy_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[minimum_OT_min] [int] NULL,
	[maximum_OT_min] [int] NULL,
	[OT_reduce_time_min] [int] NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Overtime_Policy] PRIMARY KEY CLUSTERED 
(
	[OT_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Overtime_Policy_Company]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Overtime_Policy_Company](
	[OT_policy_company_id] [int] NOT NULL,
	[OT_policy_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Overtime_Policy_Company] PRIMARY KEY CLUSTERED 
(
	[OT_policy_company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Overtime_Policy_Slab]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Overtime_Policy_Slab](
	[OT_policy_slab_id] [int] NOT NULL,
	[OT_policy_id] [int] NOT NULL,
	[minimum_OT_min] [int] NOT NULL,
	[maximum_OT_min] [int] NOT NULL,
	[acheive_OT_min] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Overtime_Slab] PRIMARY KEY CLUSTERED 
(
	[OT_policy_slab_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Roster_Policy_Detail]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Roster_Policy_Detail](
	[roster_policy_detail_id] [int] NOT NULL,
	[roster_policy_id] [int] NOT NULL,
	[shift_id] [int] NOT NULL,
	[next_shift_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Roster_Policy_Detail] PRIMARY KEY CLUSTERED 
(
	[roster_policy_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Shift_Break_Duration]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Shift_Break_Duration](
	[shift_break_duration_id] [int] NOT NULL,
	[shift_id] [int] NOT NULL,
	[shift_break_head_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_allow_start_end] [bit] NOT NULL,
	[break_start] [time](7) NULL,
	[break_end] [time](7) NULL,
	[break_duration_min] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Shift_Break_Duration] PRIMARY KEY CLUSTERED 
(
	[shift_break_duration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Shift_Break_Head]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Shift_Break_Head](
	[shift_break_head_id] [int] NOT NULL,
	[head_name] [nvarchar](50) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Shift_Break_Head] PRIMARY KEY CLUSTERED 
(
	[shift_break_head_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Shift_Break_Head_Name] UNIQUE NONCLUSTERED 
(
	[head_name] ASC,
	[company_corporate_id] ASC,
	[company_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Shift_Company]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Shift_Company](
	[shift_company_id] [int] NOT NULL,
	[shift_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Shift_Company] PRIMARY KEY CLUSTERED 
(
	[shift_company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Shift_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Shift_Info](
	[shift_id] [int] NOT NULL,
	[shift_name] [nvarchar](50) NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[shift_type_id_enum] [tinyint] NOT NULL,
	[remark] [nvarchar](300) NULL,
	[time_zone_id] [int] NOT NULL,
	[is_day_crossing] [bit] NOT NULL,
	[attendance_count] [tinyint] NOT NULL,
	[day_start] [time](7) NULL,
	[day_end] [time](7) NULL,
	[shift_start] [time](7) NULL,
	[shift_end] [time](7) NULL,
	[is_allow_half_day] [bit] NOT NULL,
	[half_shift_start] [time](7) NULL,
	[half_shift_end] [time](7) NULL,
	[report_time] [time](7) NULL,
	[late_tolerance_min] [int] NULL,
	[extended_time_min] [int] NULL,
	[early_tolerance_min] [int] NULL,
	[working_hour_min] [int] NULL,
	[half_working_hour_min] [int] NULL,
	[OT_policy_id] [int] NULL,
	[is_OT_before_shift] [bit] NOT NULL,
	[is_OT_after_shift] [bit] NOT NULL,
	[attendance_benefit_policy_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED 
(
	[shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Uneven_Day]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Uneven_Day](
	[uneven_day_id] [int] NOT NULL,
	[uneven_day_head_id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[is_late_early_uneven] [bit] NOT NULL,
	[late_consider_min] [int] NULL,
	[early_consider_min] [int] NULL,
	[purpose] [nvarchar](300) NULL,
	[is_holiday_consider] [bit] NOT NULL,
	[is_day_off_consider] [bit] NOT NULL,
	[is_leave_consider] [bit] NOT NULL,
	[compensate_dayoff_amount] [int] NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Uneven_Day] PRIMARY KEY CLUSTERED 
(
	[uneven_day_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Uneven_Day_Applicable_Area]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Uneven_Day_Applicable_Area](
	[uda_area_id] [int] NOT NULL,
	[uneven_day_id] [int] NOT NULL,
	[organogram_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Uneven_Day_Applicable_Area] PRIMARY KEY CLUSTERED 
(
	[uda_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Uneven_Day_Head]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Uneven_Day_Head](
	[uneven_day_head_id] [int] NOT NULL,
	[head_name] [nvarchar](100) NOT NULL,
	[remarks] [nvarchar](300) NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NULL,
	[company_group_id] [int] NULL,
 CONSTRAINT [PK_Uneven_Day_Head] PRIMARY KEY CLUSTERED 
(
	[uneven_day_head_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_head_name] UNIQUE NONCLUSTERED 
(
	[company_group_id] ASC,
	[head_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Uneven_Day_Leave]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Uneven_Day_Leave](
	[uda_leave_id] [int] NOT NULL,
	[uneven_day_id] [int] NOT NULL,
	[leave_head_id] [int] NOT NULL,
	[amount_days] [decimal](18, 2) NOT NULL,
	[amount_min] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Uneven_Day_Leave] PRIMARY KEY CLUSTERED 
(
	[uda_leave_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Attendance].[Uneven_Day_Shift]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Attendance].[Uneven_Day_Shift](
	[uda_shift_id] [int] NOT NULL,
	[uneven_day_id] [int] NOT NULL,
	[shift_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Uneven_Day_Shift] PRIMARY KEY CLUSTERED 
(
	[uda_shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Authorization_Role]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Authorization_Role](
	[authorization_role_id] [int] NOT NULL,
	[authorization_role_name] [nvarchar](150) NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](150) NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[created_user_info_id] [bigint] NOT NULL,
	[updated_user_info_id] [bigint] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NULL,
 CONSTRAINT [PK_Authorization_Role] PRIMARY KEY CLUSTERED 
(
	[authorization_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_authorization_role_name] UNIQUE NONCLUSTERED 
(
	[authorization_role_name] ASC,
	[company_corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Authorization_Role_Menu_Event]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Authorization_Role_Menu_Event](
	[authorization_role_menu_events_id] [int] NOT NULL,
	[authorization_role_id] [int] NOT NULL,
	[menu_event_id] [int] NULL,
	[menu_id] [int] NOT NULL,
 CONSTRAINT [PK_Authorization_Role_Menu_Event] PRIMARY KEY CLUSTERED 
(
	[authorization_role_menu_events_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Email_Configuration]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Email_Configuration](
	[company_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[email_from] [varchar](100) NOT NULL,
	[smtp_host] [varchar](100) NOT NULL,
	[smtp_port] [int] NOT NULL,
	[smtp_user] [varchar](100) NULL,
	[smtp_pass] [varchar](256) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Forgot_Password]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Forgot_Password](
	[user_info_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[email] [varchar](100) NOT NULL,
	[token] [varchar](500) NOT NULL,
	[tokenexpiedtime] [datetime] NULL,
	[old_password] [varchar](100) NOT NULL,
	[created_db_server_date_time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Geo_Location]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Geo_Location](
	[geo_location_id] [int] NOT NULL,
	[geo_location_name] [nvarchar](100) NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Geo_Location] PRIMARY KEY CLUSTERED 
(
	[geo_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Login_Activity]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Login_Activity](
	[login_activity_id] [int] NOT NULL,
	[user_info_id] [bigint] NOT NULL,
	[IPv4] [nvarchar](15) NOT NULL,
	[IPv6] [nvarchar](15) NULL,
	[geo_location_id] [int] NULL,
	[os_info] [nvarchar](50) NOT NULL,
	[browser_info] [varchar](50) NOT NULL,
	[country_code] [varchar](50) NOT NULL,
	[country_name] [varchar](100) NOT NULL,
	[deviceInfo] [varchar](150) NULL,
	[login_date] [datetime] NOT NULL,
	[logout_date] [datetime] NULL,
	[login_fail_message] [nvarchar](150) NULL,
	[login_status] [tinyint] NOT NULL,
 CONSTRAINT [PK_Login_Activity] PRIMARY KEY CLUSTERED 
(
	[login_activity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Menu]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Menu](
	[menu_id] [int] NOT NULL,
	[menu_parentid] [int] NOT NULL,
	[menu_name] [nvarchar](200) NOT NULL,
	[is_active] [bit] NOT NULL,
	[sorting_priority] [int] NOT NULL,
	[menu_icon_path] [nvarchar](200) NULL,
	[menu_routing_path] [nvarchar](200) NULL,
	[calling_parameter_value] [nvarchar](50) NULL,
	[calling_parameter_type] [nvarchar](50) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[created_user_info_id] [int] NOT NULL,
	[updated_user_info_id] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[menu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_manu_name] UNIQUE NONCLUSTERED 
(
	[menu_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Menu_Event]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Menu_Event](
	[menu_event_id] [int] NOT NULL,
	[menu_id] [int] NOT NULL,
	[event_enum_id] [int] NOT NULL,
 CONSTRAINT [PK_Menu_Event] PRIMARY KEY CLUSTERED 
(
	[menu_event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Password_Policy]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Password_Policy](
	[password_policy_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[password_element_enum] [tinyint] NOT NULL,
	[min_allowable_number] [tinyint] NOT NULL,
	[max_allowable_number] [tinyint] NOT NULL,
 CONSTRAINT [PK_Password_Policy] PRIMARY KEY CLUSTERED 
(
	[password_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Software_Version]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Software_Version](
	[software_version_id] [int] NOT NULL,
	[software_version_name] [nvarchar](100) NOT NULL,
	[software_version_No] [nvarchar](100) NOT NULL,
	[remarks] [nvarchar](500) NULL,
 CONSTRAINT [PK_Software_Version] PRIMARY KEY CLUSTERED 
(
	[software_version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Software_Version_Menu]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Software_Version_Menu](
	[software_version_id] [int] NOT NULL,
	[menu_id] [int] NOT NULL,
 CONSTRAINT [PK_Software_Version_Menu] PRIMARY KEY CLUSTERED 
(
	[software_version_id] ASC,
	[menu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Software_Version_Menu_Company]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Software_Version_Menu_Company](
	[company_id] [int] NOT NULL,
	[software_version_id] [int] NULL,
	[menu_id] [int] NOT NULL,
 CONSTRAINT [PK_Software_Version_Menu_Entity] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC,
	[menu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Time_Zone]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Time_Zone](
	[time_zone_id] [int] IDENTITY(1,1) NOT NULL,
	[standared_name] [varchar](100) NOT NULL,
	[short_name] [varchar](100) NULL,
	[is_dst] [bit] NOT NULL,
	[utc_offset] [varchar](100) NOT NULL,
 CONSTRAINT [PK_time_zone] PRIMARY KEY CLUSTERED 
(
	[time_zone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[Time_Zone_Country]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[Time_Zone_Country](
	[tzc_id] [int] NOT NULL,
	[time_zone_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NULL,
	[district_id] [int] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Time_Zone_Country] PRIMARY KEY CLUSTERED 
(
	[tzc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Group]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Group](
	[user_group_id] [int] IDENTITY(1,1) NOT NULL,
	[group_name] [varchar](100) NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](150) NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[created_user_info_id] [int] NOT NULL,
	[updated_user_info_id] [int] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_User_Group] PRIMARY KEY CLUSTERED 
(
	[user_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_user_group] UNIQUE NONCLUSTERED 
(
	[group_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Group_Mapping]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Group_Mapping](
	[user_group_mapping_id] [int] IDENTITY(1,1) NOT NULL,
	[user_group_id] [int] NOT NULL,
	[user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_User_Group_Mapping] PRIMARY KEY CLUSTERED 
(
	[user_group_mapping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Group_Menu_Authorization_Event]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Group_Menu_Authorization_Event](
	[user_group_menu_authorization_event_id] [int] IDENTITY(1,1) NOT NULL,
	[user_group_id] [int] NOT NULL,
	[menu_event_id] [int] NULL,
	[menu_id] [int] NOT NULL,
 CONSTRAINT [PK_User_Group_Menu_Authorization_Event] PRIMARY KEY CLUSTERED 
(
	[user_group_menu_authorization_event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Location_Binding]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Location_Binding](
	[user_location_binding_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_info_id] [bigint] NOT NULL,
	[IPv4] [nvarchar](15) NULL,
	[IPV6] [nvarchar](15) NULL,
	[geo_location_id] [int] NULL,
	[start_date_time] [datetime] NULL,
	[end_date_time] [datetime] NULL,
	[is_continous] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[remarks] [nvarchar](500) NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[created_user_info_id] [int] NOT NULL,
	[updated_user_info_id] [int] NULL,
 CONSTRAINT [PK_User_Location_Binding] PRIMARY KEY CLUSTERED 
(
	[user_location_binding_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auth].[User_Menu_Authorization_Event]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auth].[User_Menu_Authorization_Event](
	[user_menu_authorization_event_id] [int] NOT NULL,
	[user_info_id] [bigint] NOT NULL,
	[menu_event_id] [int] NULL,
	[menu_id] [int] NOT NULL,
	[user_group_id] [int] NULL,
	[authorization_role_id] [int] NULL,
	[is_active] [bit] NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[created_db_server_date_time] [datetime] NOT NULL,
	[updated_db_server_date_time] [datetime] NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_info_id] [int] NOT NULL,
	[updated_user_info_id] [int] NULL,
 CONSTRAINT [PK_User_Menu_Authorization_Event] PRIMARY KEY CLUSTERED 
(
	[user_menu_authorization_event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Bank_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Bank_Type](
	[bank_type_id] [int] NOT NULL,
	[bank_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Bank_Type] PRIMARY KEY CLUSTERED 
(
	[bank_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Confirmation_Status]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Confirmation_Status](
	[confirmation_status_id] [tinyint] NOT NULL,
	[confirmation_status_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Confirmation_Status] PRIMARY KEY CLUSTERED 
(
	[confirmation_status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Dayoff_Alternative]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Dayoff_Alternative](
	[dayoff_alternative_id] [tinyint] NOT NULL,
	[dayoff_alternative_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Dayoff_Alternative] PRIMARY KEY CLUSTERED 
(
	[dayoff_alternative_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Dayoff_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Dayoff_Type](
	[dayoff_type_id] [tinyint] NOT NULL,
	[dayoff_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dayoff_Type] PRIMARY KEY CLUSTERED 
(
	[dayoff_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Department_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Department_Type](
	[department_type_id] [tinyint] NOT NULL,
	[functionality_name] [varchar](50) NOT NULL,
	[department_type_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Department_Type] PRIMARY KEY CLUSTERED 
(
	[department_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Job_Domicile]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Job_Domicile](
	[job_domicile_id] [tinyint] NOT NULL,
	[job_domicile_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Job_Domicile] PRIMARY KEY CLUSTERED 
(
	[job_domicile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Job_Location]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Job_Location](
	[job_location_id] [tinyint] NOT NULL,
	[job_location_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Job_Location] PRIMARY KEY CLUSTERED 
(
	[job_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[MFS_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[MFS_Type](
	[mfs_type_id] [int] NOT NULL,
	[mfs_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MFS_Type] PRIMARY KEY CLUSTERED 
(
	[mfs_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Organization_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Organization_Type](
	[organization_type_id_enum] [int] NOT NULL,
	[organization_type_name_enum] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Organization_Type] PRIMARY KEY CLUSTERED 
(
	[organization_type_id_enum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Payment_Frequency]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Payment_Frequency](
	[payment_frequency_id] [int] NOT NULL,
	[payment_frequency_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Payment_Frequency] PRIMARY KEY CLUSTERED 
(
	[payment_frequency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Reporting_Line]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Reporting_Line](
	[reporting_line_id] [tinyint] NOT NULL,
	[reporting_line_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Reporting_Line] PRIMARY KEY CLUSTERED 
(
	[reporting_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Salary_Head_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Salary_Head_Type](
	[salary_head_type_id] [tinyint] NOT NULL,
	[salary_head_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Salary_Head_Type] PRIMARY KEY CLUSTERED 
(
	[salary_head_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Service_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Service_Type](
	[service_type_id] [tinyint] NOT NULL,
	[service_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Service_Type] PRIMARY KEY CLUSTERED 
(
	[service_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DBEnum].[Working_Action]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DBEnum].[Working_Action](
	[working_action_id] [tinyint] NOT NULL,
	[working_action_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Working_Action] PRIMARY KEY CLUSTERED 
(
	[working_action_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Dealer_Contact_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Dealer_Contact_Info](
	[dealer_contact_info_id] [int] NOT NULL,
	[dealer_info_id] [int] NOT NULL,
	[dealer_contact_info_code] [nvarchar](20) NOT NULL,
	[person_name] [nvarchar](100) NOT NULL,
	[person_designation] [nvarchar](100) NOT NULL,
	[father_name] [nvarchar](100) NULL,
	[mother_name] [nvarchar](100) NULL,
	[date_of_birth] [date] NULL,
	[religion_enum_id] [tinyint] NULL,
	[nationality] [nvarchar](50) NULL,
	[national_id_no] [nvarchar](20) NULL,
	[birth_certificate_no] [nvarchar](20) NULL,
	[passport_no] [nvarchar](20) NULL,
	[mobile] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[emergency_contact] [nvarchar](100) NULL,
	[blood_group_enum_id] [tinyint] NULL,
	[image_path] [nvarchar](300) NULL,
	[permanent_country_id] [int] NOT NULL,
	[permanent_division_id] [int] NOT NULL,
	[permanent_district_id] [int] NOT NULL,
	[permanent_thana_id] [int] NOT NULL,
	[permanent_zone_id] [int] NULL,
	[permanent_city] [nvarchar](50) NULL,
	[permanent_post_code] [nvarchar](50) NULL,
	[permanent_block] [nvarchar](50) NULL,
	[permanent_road_no] [nvarchar](50) NULL,
	[permanent_house_no] [nvarchar](50) NULL,
	[permanent_flat_no] [nvarchar](50) NULL,
	[present_country_id] [int] NOT NULL,
	[present_division_id] [int] NOT NULL,
	[present_district_id] [int] NOT NULL,
	[present_thana_id] [int] NOT NULL,
	[present_zone_id] [int] NULL,
	[present_city] [nvarchar](50) NULL,
	[present_post_code] [nvarchar](50) NULL,
	[present_block] [nvarchar](50) NULL,
	[present_road_no] [nvarchar](50) NULL,
	[present_house_no] [nvarchar](50) NULL,
	[present_flat_no] [nvarchar](50) NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_party.Dealer_Contact_Info] PRIMARY KEY CLUSTERED 
(
	[dealer_contact_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_contact_info_code] UNIQUE NONCLUSTERED 
(
	[dealer_contact_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Dealer_Contact_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Dealer_Document_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Dealer_Document_Info](
	[dealer_document_info_id] [int] NOT NULL,
	[dealer_info_id] [int] NOT NULL,
	[document_type_id] [int] NOT NULL,
	[document_number] [nvarchar](30) NOT NULL,
	[issue_date] [datetime] NOT NULL,
	[expiry_date] [datetime] NOT NULL,
	[image_file] [nvarchar](300) NOT NULL,
	[is_verified] [bit] NOT NULL,
	[is_complete] [bit] NOT NULL,
	[status] [nvarchar](50) NULL,
	[remarks] [nvarchar](300) NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Dealer_Document_Info] PRIMARY KEY CLUSTERED 
(
	[dealer_document_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Dealer_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Dealer_Info](
	[dealer_info_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[dealer_info_code] [nvarchar](20) NOT NULL,
	[dealer_info_short_name] [nvarchar](10) NOT NULL,
	[dealer_info_name] [nvarchar](100) NOT NULL,
	[dealer_info_display_name] [nvarchar](100) NULL,
	[trade_license] [nvarchar](20) NOT NULL,
	[year_established] [date] NULL,
	[TIN] [nvarchar](20) NULL,
	[BIN] [nvarchar](20) NULL,
	[domicile_enum_id] [tinyint] NOT NULL,
	[business_type_enum_id] [tinyint] NULL,
	[industry_sector_id] [int] NOT NULL,
	[industry_sub_sector_id] [int] NULL,
	[ownership_type_id] [int] NOT NULL,
	[organazation_type_enum_id] [tinyint] NULL,
	[registry_authority_id] [int] NULL,
	[regulator_id] [int] NULL,
	[currency_id] [int] NOT NULL,
	[security_type_enum_id] [tinyint] NULL,
	[prefered_method_enum_id] [tinyint] NULL,
	[internal_credit_rating] [decimal](18, 2) NULL,
	[allowable_credit] [decimal](18, 2) NULL,
	[maximum_credit] [decimal](18, 2) NULL,
	[credit_days] [decimal](18, 2) NULL,
	[mobile] [nvarchar](20) NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](100) NULL,
	[logo_path] [nvarchar](300) NULL,
	[continent_enum_id] [tinyint] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[thana_id] [int] NOT NULL,
	[zone_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
	[updated_user_info_id] [bigint] NULL,
 CONSTRAINT [PK_party.dealer_info] PRIMARY KEY CLUSTERED 
(
	[dealer_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_dealer_info_code] UNIQUE NONCLUSTERED 
(
	[dealer_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Dealer_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_dealer_info_short_name] UNIQUE NONCLUSTERED 
(
	[dealer_info_short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Dealer_Info_trade_license] UNIQUE NONCLUSTERED 
(
	[trade_license] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Dealer_Location_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Dealer_Location_Info](
	[dealer_location_info_id] [int] NOT NULL,
	[dealer_info_id] [int] NOT NULL,
	[dealer_location_info_code] [nvarchar](20) NOT NULL,
	[dealer_location_info_name] [nvarchar](100) NOT NULL,
	[dealer_location_info_short_name] [nvarchar](10) NOT NULL,
	[trade_license] [nvarchar](20) NULL,
	[trade_license_date] [date] NULL,
	[mobile] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[emergency_contact] [nvarchar](100) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[thana_id] [int] NOT NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Dealer_Info_Location] PRIMARY KEY CLUSTERED 
(
	[dealer_location_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_dealer_location_info_code] UNIQUE NONCLUSTERED 
(
	[dealer_location_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Dealer_Location_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Retailer_Contact_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Retailer_Contact_Info](
	[retailer_contact_info_id] [int] NOT NULL,
	[retailer_info_id] [int] NOT NULL,
	[retailer_contact_info_code] [nvarchar](20) NOT NULL,
	[person_name] [nvarchar](100) NOT NULL,
	[person_designation] [nvarchar](100) NOT NULL,
	[father_name] [nvarchar](100) NULL,
	[mother_name] [nvarchar](100) NULL,
	[date_of_birth] [date] NULL,
	[religion_enum_id] [tinyint] NULL,
	[nationality] [nvarchar](50) NULL,
	[national_id_no] [nvarchar](20) NULL,
	[birth_certificate_no] [nvarchar](20) NULL,
	[passport_no] [nvarchar](20) NULL,
	[mobile] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[emergency_contact] [nvarchar](100) NULL,
	[blood_group_enum_id] [tinyint] NULL,
	[image_path] [nvarchar](300) NULL,
	[permanent_country_id] [int] NOT NULL,
	[permanent_division_id] [int] NOT NULL,
	[permanent_district_id] [int] NOT NULL,
	[permanent_thana_id] [int] NOT NULL,
	[permanent_zone_id] [int] NULL,
	[permanent_city] [nvarchar](50) NULL,
	[permanent_post_code] [nvarchar](50) NULL,
	[permanent_block] [nvarchar](50) NULL,
	[permanent_road_no] [nvarchar](50) NULL,
	[permanent_house_no] [nvarchar](50) NULL,
	[permanent_flat_no] [nvarchar](50) NULL,
	[present_country_id] [int] NOT NULL,
	[present_division_id] [int] NOT NULL,
	[present_district_id] [int] NOT NULL,
	[present_thana_id] [int] NOT NULL,
	[present_zone_id] [int] NULL,
	[present_city] [nvarchar](50) NULL,
	[present_post_code] [nvarchar](50) NULL,
	[present_block] [nvarchar](50) NULL,
	[present_road_no] [nvarchar](50) NULL,
	[present_house_no] [nvarchar](50) NULL,
	[present_flat_no] [nvarchar](50) NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_party.Retailer_Contact_Info] PRIMARY KEY CLUSTERED 
(
	[retailer_contact_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_retailer_contact_info_code] UNIQUE NONCLUSTERED 
(
	[retailer_contact_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Retailer_Contact_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Retailer_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Retailer_Info](
	[retailer_info_id] [int] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[dealer_info_id] [int] NOT NULL,
	[retailer_info_code] [nvarchar](20) NOT NULL,
	[retailer_info_name] [nvarchar](100) NOT NULL,
	[retailer_info_short_name] [nvarchar](10) NOT NULL,
	[trade_license] [nvarchar](20) NULL,
	[trade_license_date] [date] NULL,
	[TIN] [nvarchar](20) NULL,
	[BIN] [nvarchar](20) NULL,
	[domicile_enum_id] [tinyint] NOT NULL,
	[business_type_enum_id] [tinyint] NULL,
	[industry_sector_id] [int] NOT NULL,
	[industry_sub_sector_id] [int] NULL,
	[ownership_type_id] [int] NOT NULL,
	[currency_id] [int] NOT NULL,
	[mobile] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[web_url] [nvarchar](100) NULL,
	[image_path] [nvarchar](300) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[thana_id] [int] NOT NULL,
	[zone_id] [int] NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Retailer_Info] PRIMARY KEY CLUSTERED 
(
	[retailer_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_retailer_info_code] UNIQUE NONCLUSTERED 
(
	[retailer_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Retailer_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Party].[Retailer_Location_Info]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Party].[Retailer_Location_Info](
	[retailer_location_info_id] [int] NOT NULL,
	[retailer_info_id] [int] NOT NULL,
	[retailer_location_info_code] [nvarchar](20) NOT NULL,
	[retailer_location_info_name] [nvarchar](100) NOT NULL,
	[retailer_location_info_short_name] [nvarchar](10) NOT NULL,
	[trade_license] [nvarchar](20) NULL,
	[trade_license_date] [date] NULL,
	[mobile] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[emergency_contact] [nvarchar](100) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[thana_id] [int] NOT NULL,
	[city] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[created_user_info_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Retailer_Info_Location] PRIMARY KEY CLUSTERED 
(
	[retailer_location_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_retailer_location_info_code] UNIQUE NONCLUSTERED 
(
	[retailer_location_info_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Retailer_Location_Info_mobile] UNIQUE NONCLUSTERED 
(
	[mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Payroll].[Salary_Head]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payroll].[Salary_Head](
	[salary_head_id] [int] NOT NULL,
	[salary_head_name] [nvarchar](50) NOT NULL,
	[salary_head_short_name] [nvarchar](10) NOT NULL,
	[salary_head_type_id] [tinyint] NOT NULL,
	[name_in_local_language] [nvarchar](100) NULL,
	[remarks] [nvarchar](500) NULL,
	[sorting_priority] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
 CONSTRAINT [PK_Salary_Head] PRIMARY KEY CLUSTERED 
(
	[salary_head_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Salary_Head_name] UNIQUE NONCLUSTERED 
(
	[salary_head_name] ASC,
	[company_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee](
	[employee_id] [bigint] NOT NULL,
	[code] [nvarchar](100) NOT NULL,
	[title_enum_id] [tinyint] NOT NULL,
	[employee_name]  AS (CONVERT([varchar](150),(((ltrim(isnull([first_name],''))+' ')+ltrim(isnull([middle_name],'')))+' ')+ltrim(isnull([sur_name],'')),(0))),
	[first_name] [nvarchar](150) NOT NULL,
	[middle_name] [nvarchar](150) NULL,
	[sur_name] [nvarchar](150) NOT NULL,
	[father_name] [nvarchar](150) NOT NULL,
	[mother_name] [nvarchar](150) NOT NULL,
	[gender_enum_id] [tinyint] NOT NULL,
	[marital_status_enum_id] [tinyint] NOT NULL,
	[spouse_name] [nvarchar](150) NULL,
	[date_of_marriage] [date] NULL,
	[personal_phone] [nvarchar](50) NOT NULL,
	[official_phone] [nvarchar](50) NULL,
	[personal_email] [nvarchar](50) NOT NULL,
	[official_email] [nvarchar](50) NULL,
	[date_of_birth] [date] NULL,
	[identification_mark] [nvarchar](50) NULL,
	[national_id] [nvarchar](150) NULL,
	[passport_no] [nvarchar](150) NULL,
	[birth_id] [nvarchar](150) NULL,
	[driving_license_no] [nvarchar](150) NULL,
	[nationality_id] [int] NOT NULL,
	[religion_enum_id] [int] NOT NULL,
	[country_of_birth_id] [int] NOT NULL,
	[blood_group_enum_id] [int] NULL,
	[ethnicity_id] [int] NOT NULL,
	[residentcial_status_enum_id] [int] NOT NULL,
	[present_country_id] [int] NULL,
	[present_division_id] [int] NULL,
	[present_district_id] [int] NULL,
	[present_city] [nvarchar](50) NULL,
	[present_ps_area] [nvarchar](50) NULL,
	[present_post_code] [nvarchar](50) NULL,
	[present_block] [nvarchar](50) NULL,
	[present_road_no] [nvarchar](50) NULL,
	[present_house_no] [nvarchar](50) NULL,
	[present_flat_no] [nvarchar](50) NULL,
	[present_address_note] [nvarchar](300) NULL,
	[permanent_country_id] [int] NULL,
	[permanent_division_id] [int] NULL,
	[permanent_district_id] [int] NULL,
	[permanent_city] [nvarchar](50) NULL,
	[permanent_ps_area] [nvarchar](50) NULL,
	[permanent_post_code] [nvarchar](50) NULL,
	[permanent_block] [nvarchar](50) NULL,
	[permanent_road_no] [nvarchar](50) NULL,
	[permanent_house_no] [nvarchar](50) NULL,
	[permanent_flat_no] [nvarchar](50) NULL,
	[permanent_address_note] [nvarchar](300) NULL,
	[company_corporate_id] [int] NOT NULL,
	[company_group_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_user_id] [bigint] NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NOT NULL,
	[is_active] [bit] NOT NULL,
	[employee_old_id] [bigint] NULL,
	[employee_old_code] [nvarchar](100) NULL,
	[employee_image_path] [nvarchar](100) NULL,
	[signature_image_path] [nvarchar](100) NULL,
	[approve_user_id] [bigint] NULL,
	[approve_date_time] [datetime] NULL,
 CONSTRAINT [PK_PIMS_Employee] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_PIMS_employee_code] UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Attendance_Policy]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Attendance_Policy](
	[employee_id] [bigint] NOT NULL,
	[attendance_policy_id] [int] NOT NULL,
	[attendance_calendar_id] [int] NOT NULL,
	[late_early_policy_id] [int] NULL,
	[absenteeism_policy_id] [int] NULL,
	[roster_policy_id] [int] NULL,
	[shift_id] [int] NOT NULL,
	[is_random_dayoff] [bit] NOT NULL,
	[no_of_random_dayoff] [int] NULL,
	[is_allow_benefit_policy] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [UC_Employee_Attendance_Policy] UNIQUE NONCLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Authentication]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Authentication](
	[employee_authentication_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[card_no] [varchar](100) NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Authentication] PRIMARY KEY CLUSTERED 
(
	[employee_authentication_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Benefit_Policy]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Benefit_Policy](
	[employee_benefit_policy_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[abp_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Benefit_Policy] PRIMARY KEY CLUSTERED 
(
	[employee_benefit_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Category]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Category](
	[employee_category_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[employee_category_type_id] [int] NOT NULL,
	[active_date] [date] NOT NULL,
	[inactive_date] [date] NULL,
	[inactive_by] [bigint] NULL,
	[sorting_priority] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Category] PRIMARY KEY CLUSTERED 
(
	[employee_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Category_Type]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Category_Type](
	[employee_category_type_id] [int] NOT NULL,
	[employee_category_name] [nvarchar](50) NULL,
	[remarks] [nvarchar](300) NULL,
	[created_user_id] [bigint] NULL,
	[db_server_date_time] [datetime] NULL,
	[company_corporate_id] [int] NULL,
	[company_group_id] [int] NULL,
	[company_id] [int] NULL,
 CONSTRAINT [PK_Employee_Category_Type] PRIMARY KEY CLUSTERED 
(
	[employee_category_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Dayoff]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Dayoff](
	[employee_dayoff_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[week_day] [varchar](20) NOT NULL,
	[dayoff_type_id] [tinyint] NOT NULL,
	[dayoff_alternative_id] [tinyint] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Dayoff] PRIMARY KEY CLUSTERED 
(
	[employee_dayoff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Leave_Ledger]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Leave_Ledger](
	[employee_leave_ledger_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[leave_policy_id] [int] NOT NULL,
	[acs_id] [int] NOT NULL,
	[leave_head_id] [int] NOT NULL,
	[total_leave_days] [decimal](18, 2) NOT NULL,
	[total_leave_min] [int] NOT NULL,
	[applied_days] [decimal](18, 2) NULL,
	[applied_min] [int] NULL,
	[cancel_days] [decimal](18, 2) NULL,
	[cancel_min] [int] NULL,
	[enjoy_days] [decimal](18, 2) NULL,
	[enjoy_min] [int] NULL,
	[leave_balance_days]  AS ([total_leave_days]-isnull([enjoy_days],(0))),
	[leave_balance_min]  AS ([total_leave_min]-isnull([enjoy_min],(0))),
	[eligible_leave_days]  AS (([total_leave_days]-isnull([applied_days],(0)))+isnull([cancel_days],(0))),
	[eligible_leave_min]  AS (([total_leave_min]-isnull([applied_min],(0)))+isnull([cancel_min],(0))),
	[no_of_carry_year] [int] NULL,
	[is_active] [bit] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Leave_Ledger] PRIMARY KEY CLUSTERED 
(
	[employee_leave_ledger_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Official]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Official](
	[employee_id] [bigint] NOT NULL,
	[organogram_detail_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[position_id] [int] NOT NULL,
	[designation_id] [int] NOT NULL,
	[job_domicile_id] [tinyint] NOT NULL,
	[service_type_id] [tinyint] NOT NULL,
	[confirmation_status_id] [tinyint] NOT NULL,
	[working_action_id] [tinyint] NOT NULL,
	[job_location_id] [tinyint] NOT NULL,
	[date_of_join] [date] NOT NULL,
	[date_of_confirmation] [date] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [UC_Employee_ID] UNIQUE NONCLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PIMS].[Employee_Reporting]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PIMS].[Employee_Reporting](
	[employee_reporting_id] [int] NOT NULL,
	[employee_id] [bigint] NOT NULL,
	[reporting_line_id] [tinyint] NOT NULL,
	[reporting_employee_id] [bigint] NOT NULL,
	[active_date] [date] NOT NULL,
	[inactive_date] [date] NULL,
	[inactive_by] [bigint] NULL,
	[sorting_priority] [int] NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[db_server_date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_Reporting] PRIMARY KEY CLUSTERED 
(
	[employee_reporting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Application]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Application](
	[supplier_id] [int] NOT NULL,
	[company_corporate_id] [int] NULL,
	[company_group_id] [int] NULL,
	[company_id] [int] NULL,
	[supplier_code] [nvarchar](20) NOT NULL,
	[legal_name] [nvarchar](50) NOT NULL,
	[short_name] [nvarchar](10) NOT NULL,
	[name_in_local_language] [nvarchar](50) NULL,
	[address_in_local_language] [nvarchar](100) NULL,
	[year_established] [datetime] NULL,
	[domicile_enum_id] [int] NOT NULL,
	[registry_authority_id] [int] NULL,
	[regulator_id] [int] NULL,
	[ownership_type_id] [int] NOT NULL,
	[supplier_logo] [nvarchar](300) NULL,
	[business_activities_enum_id] [int] NULL,
	[management_staff_no] [nvarchar](50) NULL,
	[nonmanagement_staff_no] [nvarchar](50) NULL,
	[permanent_worker_no] [nvarchar](50) NULL,
	[casual_worker_no] [nvarchar](50) NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[email] [nvarchar](50) NULL,
	[mobile_no] [nvarchar](20) NULL,
	[phone_no] [nvarchar](20) NULL,
	[pabx] [nvarchar](20) NULL,
	[remarks] [nvarchar](300) NULL,
	[is_active] [bit] NULL,
	[is_confirm] [bit] NULL,
	[created_datetime] [datetime] NOT NULL,
	[updated_datetime] [datetime] NULL,
	[db_server_date_time] [datetime] NULL,
	[created_user_info_id] [bigint] NULL,
	[updated_user_info_id] [bigint] NULL,
	[feedback_status] [int] NULL,
 CONSTRAINT [PK_Supplier_Application] PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_short_name] UNIQUE NONCLUSTERED 
(
	[short_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_code] UNIQUE NONCLUSTERED 
(
	[supplier_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Association]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Association](
	[supplier_association_id] [int] NOT NULL,
	[association_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[membership_type_enum_id] [int] NOT NULL,
	[association_number] [nvarchar](50) NULL,
	[start_date] [datetime] NOT NULL,
 CONSTRAINT [PK_Supplier_Association] PRIMARY KEY CLUSTERED 
(
	[supplier_association_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_association] UNIQUE NONCLUSTERED 
(
	[association_id] ASC,
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Bank_Account]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Bank_Account](
	[supplier_bank_account_id] [int] NOT NULL,
	[bank_id] [int] NOT NULL,
	[bank_branch_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[account_name] [nvarchar](50) NOT NULL,
	[account_number] [nvarchar](20) NOT NULL,
	[iban] [nvarchar](50) NULL,
 CONSTRAINT [PK_Supplier_Bank_Account] PRIMARY KEY CLUSTERED 
(
	[supplier_bank_account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_bank_account] UNIQUE NONCLUSTERED 
(
	[supplier_id] ASC,
	[bank_id] ASC,
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Card_Transaction]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Card_Transaction](
	[supplier_card_transaction_id] [int] NOT NULL,
	[card_type_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[card_name] [nvarchar](50) NOT NULL,
	[card_number] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Supplier_Card_Transaction] PRIMARY KEY CLUSTERED 
(
	[supplier_card_transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier__card_transaction] UNIQUE NONCLUSTERED 
(
	[card_type_id] ASC,
	[supplier_id] ASC,
	[card_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Contact]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Contact](
	[supplier_contact_id] [int] NOT NULL,
	[contact_type_id] [int] NOT NULL,
	[contact_person_name]  AS (CONVERT([varchar](150),(((ltrim(isnull([first_name],''))+' ')+ltrim(isnull([middle_name],'')))+' ')+ltrim(isnull([sur_name],'')),(0))),
	[first_name] [nvarchar](100) NOT NULL,
	[middle_name] [nvarchar](100) NULL,
	[sur_name] [nvarchar](100) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[supplier_location_id] [int] NULL,
	[supplier_warehouse_id] [int] NULL,
	[designation_id] [int] NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[mobile_no] [nvarchar](20) NOT NULL,
	[phone_no] [nvarchar](20) NULL,
	[whatsapp] [nvarchar](20) NULL,
	[facebook] [nvarchar](100) NULL,
	[linkedin] [nvarchar](100) NULL,
	[date_of_birth] [datetime] NULL,
	[nationality_id] [int] NOT NULL,
	[religion_enum_id] [int] NOT NULL,
	[gender_enum_id] [int] NOT NULL,
	[marital_status_enum_id] [int] NOT NULL,
	[blood_group_enum_id] [int] NULL,
	[date_of_marriage] [datetime] NULL,
	[nid_number] [nvarchar](50) NULL,
	[nid_file_path] [nvarchar](300) NULL,
	[passport_no] [nvarchar](50) NULL,
	[birth_id] [nvarchar](50) NULL,
	[driving_license_no] [nvarchar](50) NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Supplier_Contact] PRIMARY KEY CLUSTERED 
(
	[supplier_contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Contact_Location]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Contact_Location](
	[supplier_contact_location_id] [int] NOT NULL,
	[supplier_location_id] [int] NOT NULL,
	[supplier_contact_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[add_note] [nvarchar](100) NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Supplier_Contact_Location] PRIMARY KEY CLUSTERED 
(
	[supplier_contact_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Credit_History]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Credit_History](
	[supplier_credit_history_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[currency_id] [int] NOT NULL,
	[credit_days] [int] NULL,
	[credit_limit] [decimal](18, 0) NULL,
	[payment_frequency_id] [int] NULL,
	[is_active] [bit] NULL,
	[entry_datetime] [nchar](10) NULL,
	[entry_user_id] [bigint] NULL,
 CONSTRAINT [PK_Supplier_Credit_History] PRIMARY KEY CLUSTERED 
(
	[supplier_credit_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Document]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Document](
	[supplier_document_id] [int] NOT NULL,
	[document_type_id] [int] NOT NULL,
	[document_number] [nvarchar](30) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[issue_date] [datetime] NOT NULL,
	[expiry_date] [datetime] NOT NULL,
	[expired_notified_days] [int] NULL,
	[file_path] [nvarchar](100) NULL,
 CONSTRAINT [PK_Supplier_Document] PRIMARY KEY CLUSTERED 
(
	[supplier_document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_document] UNIQUE NONCLUSTERED 
(
	[document_type_id] ASC,
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Ecommerce_Platforms]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Ecommerce_Platforms](
	[supplier_ecommerce_platforms_id] [int] NOT NULL,
	[ecommerce_platforms_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
 CONSTRAINT [PK_Supplier_Ecommerce_Platforms] PRIMARY KEY CLUSTERED 
(
	[supplier_ecommerce_platforms_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_ecommerce_platforms] UNIQUE NONCLUSTERED 
(
	[ecommerce_platforms_id] ASC,
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Industry_Sub_Sector]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Industry_Sub_Sector](
	[supplier_industry_sub_sector_id] [int] NOT NULL,
	[industry_sub_sector_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
 CONSTRAINT [PK_Supplier_Industry_Sub_Sector] PRIMARY KEY CLUSTERED 
(
	[supplier_industry_sub_sector_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_industry_sub_sector] UNIQUE NONCLUSTERED 
(
	[industry_sub_sector_id] ASC,
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Info_Feedback_Detail]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Info_Feedback_Detail](
	[supplier_info_feedback_detail_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[approval_user_id] [int] NULL,
	[reject_user_id] [int] NULL,
	[comment] [nvarchar](50) NULL,
	[suggestion] [nvarchar](50) NULL,
	[approve_date] [datetime] NULL,
	[reject_date] [datetime] NULL,
	[created_datetime] [datetime] NULL,
 CONSTRAINT [PK_Supplier_Info_Approval_Detail] PRIMARY KEY CLUSTERED 
(
	[supplier_info_feedback_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Location]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Location](
	[supplier_location_id] [int] NOT NULL,
	[supplier_location_name] [nvarchar](50) NOT NULL,
	[location_type_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[division_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[city] [nvarchar](50) NULL,
	[ps_area] [nvarchar](50) NULL,
	[post_code] [nvarchar](50) NULL,
	[block] [nvarchar](50) NULL,
	[road_no] [nvarchar](50) NULL,
	[house_no] [nvarchar](50) NULL,
	[flat_no] [nvarchar](50) NULL,
	[address_note] [nvarchar](300) NULL,
	[email] [nvarchar](50) NULL,
	[mobile_no] [nvarchar](20) NULL,
	[phone_no] [nvarchar](20) NULL,
	[pabx] [nvarchar](20) NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Supplier_Location] PRIMARY KEY CLUSTERED 
(
	[supplier_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Mobile_Bank]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Mobile_Bank](
	[supplier_mobile_bank_id] [int] NOT NULL,
	[mfs_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[account_number] [nvarchar](20) NOT NULL,
	[mfs_type_id] [int] NOT NULL,
 CONSTRAINT [PK_Supplier_Mobile_Bank] PRIMARY KEY CLUSTERED 
(
	[supplier_mobile_bank_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_mobile_bank] UNIQUE NONCLUSTERED 
(
	[mfs_id] ASC,
	[supplier_id] ASC,
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Security]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Security](
	[supplier_security_id] [int] NOT NULL,
	[security_deposit_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[security_amount] [decimal](18, 0) NULL,
	[expiry_date] [datetime] NULL,
	[expired_notified_days] [int] NULL,
	[security_document_path] [nvarchar](100) NULL,
 CONSTRAINT [PK_Supplier_Security] PRIMARY KEY CLUSTERED 
(
	[supplier_security_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_supplier_security_supplier_Application] UNIQUE NONCLUSTERED 
(
	[security_deposit_id] ASC,
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Procurement].[Supplier_Warehouse]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Procurement].[Supplier_Warehouse](
	[supplier_warehouse_id] [int] NOT NULL,
	[supplier_warehouse_name] [nvarchar](50) NOT NULL,
	[supplier_location_id] [int] NOT NULL,
	[supplier_id] [int] NOT NULL,
	[add_note] [nvarchar](300) NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Supplier_Warehouse] PRIMARY KEY CLUSTERED 
(
	[supplier_warehouse_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Accounting].[Accounting_Voucher_Type] ADD  CONSTRAINT [DF_Accounting_Voucher_Type_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] ADD  CONSTRAINT [DF__Chart_Of___db_se__2C09769E]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Opening_Balance] ADD  CONSTRAINT [DF__Chart_Of___db_se__3592E0D8]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Accounting].[Voucher] ADD  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Administrative].[Bank] ADD  CONSTRAINT [DF_Bank_is_bank]  DEFAULT ((1)) FOR [is_bank]
GO
ALTER TABLE [Administrative].[Bank] ADD  CONSTRAINT [DF_Bank_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Bank] ADD  CONSTRAINT [DF_Bank_is_foreign]  DEFAULT ((1)) FOR [is_local]
GO
ALTER TABLE [Administrative].[Bank_Branch] ADD  CONSTRAINT [DF_Bank_Branch_is_branch]  DEFAULT ((1)) FOR [is_branch]
GO
ALTER TABLE [Administrative].[Bank_Branch] ADD  CONSTRAINT [DF_Bank_Branch_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Country] ADD  CONSTRAINT [DF_Country_continent_enum]  DEFAULT ((0)) FOR [continent_enum_id]
GO
ALTER TABLE [Administrative].[Department] ADD  CONSTRAINT [DF_Department_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Designation] ADD  CONSTRAINT [DF_Designation_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Education] ADD  CONSTRAINT [DF_Education_company_corporate_id]  DEFAULT ((0)) FOR [company_corporate_id]
GO
ALTER TABLE [Administrative].[Location] ADD  CONSTRAINT [DF_Location_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Location_BIN] ADD  CONSTRAINT [DF_Location_BIN_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram] ADD  CONSTRAINT [DF_Organogram_parent_id]  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [Administrative].[Organogram] ADD  CONSTRAINT [DF_Organogram_sorting_priority]  DEFAULT ((0)) FOR [sorting_priority]
GO
ALTER TABLE [Administrative].[Organogram] ADD  CONSTRAINT [DF_Organogram_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram] ADD  CONSTRAINT [DF_Organogram_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Administrative].[Organogram_Department] ADD  CONSTRAINT [DF_Organogram_Department_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram_Detail] ADD  CONSTRAINT [DF_Organogram_Detail_is_open]  DEFAULT ((1)) FOR [is_open]
GO
ALTER TABLE [Administrative].[Organogram_Detail] ADD  CONSTRAINT [DF_Organogram_Detail_is_gross]  DEFAULT ((0)) FOR [is_gross]
GO
ALTER TABLE [Administrative].[Organogram_Detail] ADD  CONSTRAINT [DF_Organogram_Detail_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram_Permission] ADD  CONSTRAINT [DF_Organogram_Permission_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram_Permission] ADD  CONSTRAINT [DF_Organogram_Permission_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Administrative].[Organogram_User_Permission] ADD  CONSTRAINT [DF_Organogram_User_Permission_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Administrative].[Organogram_User_Permission] ADD  CONSTRAINT [DF_Organogram_User_Permission_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Administrative].[Position] ADD  CONSTRAINT [DF_Position_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Absenteeism_Policy] ADD  CONSTRAINT [DF_Absenteeism_Policy_is_leave_adjustment]  DEFAULT ((0)) FOR [is_leave_adjustment]
GO
ALTER TABLE [Attendance].[Absenteeism_Policy] ADD  CONSTRAINT [DF_Absenteeism_Policy_is_gross]  DEFAULT ((0)) FOR [is_gross]
GO
ALTER TABLE [Attendance].[Absenteeism_Policy] ADD  CONSTRAINT [DF_Absenteeism_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Absenteeism_Policy] ADD  CONSTRAINT [DF_Absenteeism_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Access_Point] ADD  CONSTRAINT [DF_Attendance_Access_Point_is_online]  DEFAULT ((1)) FOR [is_online]
GO
ALTER TABLE [Attendance].[Attendance_Access_Point] ADD  CONSTRAINT [DF_Attendance_Access_Point_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Benefit_Policy] ADD  CONSTRAINT [DF_Attendance_Benefit_Policy_is_gross]  DEFAULT ((0)) FOR [is_gross]
GO
ALTER TABLE [Attendance].[Attendance_Benefit_Policy] ADD  CONSTRAINT [DF_Attendance_Benefit_Policy_is_calculate_per_working_hour]  DEFAULT ((0)) FOR [is_calculate_per_working_hour]
GO
ALTER TABLE [Attendance].[Attendance_Benefit_Policy] ADD  CONSTRAINT [DF_Attendance_Benefit_Policy_is_effect_on_payroll]  DEFAULT ((0)) FOR [is_effect_on_payroll]
GO
ALTER TABLE [Attendance].[Attendance_Benefit_Policy] ADD  CONSTRAINT [DF_Attendance_Benefit_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Benefit_Policy] ADD  CONSTRAINT [DF_Attendance_Benefit_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Calendar] ADD  CONSTRAINT [DF_Attendance_Calendar_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Calendar] ADD  CONSTRAINT [DF_Attendance_Calendar_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session] ADD  CONSTRAINT [DF_Attendance_Calendar_Session_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session] ADD  CONSTRAINT [DF_Attendance_Calendar_Session_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session_Holiday] ADD  CONSTRAINT [DF_Attendance_Calendar_Session_Holiday_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Policy] ADD  CONSTRAINT [DF_Attendance_Policy_is_random_dayoff]  DEFAULT ((0)) FOR [is_random_dayoff]
GO
ALTER TABLE [Attendance].[Attendance_Policy] ADD  CONSTRAINT [DF_Attendance_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Policy] ADD  CONSTRAINT [DF_Attendance_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Dayoff] ADD  CONSTRAINT [DF_Attendance_Policy_Dayoff_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Organogram] ADD  CONSTRAINT [DF_Attendance_Policy_Organogram_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Organogram] ADD  CONSTRAINT [DF_Attendance_Policy_Organogram_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[General_Working_Day_Shift] ADD  CONSTRAINT [DF_General_Working_Day_Shift_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Holiday] ADD  CONSTRAINT [DF_dbserverdatetime]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Late_Early_Policy] ADD  CONSTRAINT [DF_Late_Early_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Late_Early_Policy] ADD  CONSTRAINT [DF_Late_Early_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_late_early_slab]  DEFAULT ((0)) FOR [is_allow_late_early_slab]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_late_early_days_for]  DEFAULT ((0)) FOR [late_early_days_for]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_consecutive]  DEFAULT ((0)) FOR [is_consecutive]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_leave_adjustment]  DEFAULT ((0)) FOR [is_leave_adjustment]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_leave_in_min]  DEFAULT ((0)) FOR [leave_in_min]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_leave_as_late_early_min]  DEFAULT ((0)) FOR [is_leave_as_late_early_min]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_salary_adjustment]  DEFAULT ((0)) FOR [salary_head_id]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_gross]  DEFAULT ((0)) FOR [is_gross]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_is_deduction_monthly_min]  DEFAULT ((0)) FOR [is_deduction_monthly_min]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] ADD  CONSTRAINT [DF_Late_Early_Policy_Detail_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Overtime_Policy] ADD  CONSTRAINT [DF_Overtime_Policy_minimum_OT_min]  DEFAULT ((0)) FOR [minimum_OT_min]
GO
ALTER TABLE [Attendance].[Overtime_Policy] ADD  CONSTRAINT [DF_Overtime_Policy_maximum_OT_min]  DEFAULT ((0)) FOR [maximum_OT_min]
GO
ALTER TABLE [Attendance].[Overtime_Policy] ADD  CONSTRAINT [DF_Overtime_Policy_OT_reduce_time_min]  DEFAULT ((0)) FOR [OT_reduce_time_min]
GO
ALTER TABLE [Attendance].[Overtime_Policy] ADD  CONSTRAINT [DF_Overtime_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Overtime_Policy] ADD  CONSTRAINT [DF_Overtime_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Overtime_Policy_Company] ADD  CONSTRAINT [DF_Overtime_Policy_Company_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Overtime_Policy_Company] ADD  CONSTRAINT [DF_Overtime_Policy_Company_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Overtime_Policy_Slab] ADD  CONSTRAINT [DF_Overtime_Slab_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Roster_Policy] ADD  CONSTRAINT [DF_Roster_Policy_roster_cycle]  DEFAULT ((7)) FOR [roster_cycle]
GO
ALTER TABLE [Attendance].[Roster_Policy] ADD  CONSTRAINT [DF_Roster_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Roster_Policy] ADD  CONSTRAINT [DF_Roster_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail] ADD  CONSTRAINT [DF_Roster_Policy_Detail_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Shift_Break_Duration] ADD  CONSTRAINT [DF_Shift_Break_Duration_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Shift_Break_Duration] ADD  CONSTRAINT [DF_Shift_Break_Duration_is_allow_start_end]  DEFAULT ((0)) FOR [is_allow_start_end]
GO
ALTER TABLE [Attendance].[Shift_Break_Duration] ADD  CONSTRAINT [DF_Shift_Break_Duration_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Shift_Break_Head] ADD  CONSTRAINT [DF_Shift_Break_Head_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Shift_Break_Head] ADD  CONSTRAINT [DF_Shift_Break_Head_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_is_day_crossing]  DEFAULT ((0)) FOR [is_day_crossing]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_attendance_count]  DEFAULT ((1)) FOR [attendance_count]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_is_allow_half_day]  DEFAULT ((0)) FOR [is_allow_half_day]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_is_OT_before_shift]  DEFAULT ((0)) FOR [is_OT_before_shift]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_is_OT_after_shift]  DEFAULT ((0)) FOR [is_OT_after_shift]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_attendance_benefit_policy_id]  DEFAULT ((0)) FOR [attendance_benefit_policy_id]
GO
ALTER TABLE [Attendance].[Shift_Info] ADD  CONSTRAINT [DF_Shift_Info_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Uneven_Day] ADD  CONSTRAINT [DF_Uneven_Day_is_late_early_uneven]  DEFAULT ((0)) FOR [is_late_early_uneven]
GO
ALTER TABLE [Attendance].[Uneven_Day] ADD  CONSTRAINT [DF_Uneven_Day_is_holiday_consider]  DEFAULT ((0)) FOR [is_holiday_consider]
GO
ALTER TABLE [Attendance].[Uneven_Day] ADD  CONSTRAINT [DF_Uneven_Day_is_day_off_consider]  DEFAULT ((0)) FOR [is_day_off_consider]
GO
ALTER TABLE [Attendance].[Uneven_Day] ADD  CONSTRAINT [DF_Uneven_Day_is_leave_consider]  DEFAULT ((0)) FOR [is_leave_consider]
GO
ALTER TABLE [Attendance].[Uneven_Day] ADD  CONSTRAINT [DF_Uneven_Day_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Uneven_Day_Applicable_Area] ADD  CONSTRAINT [DF_Uneven_Day_Applicable_Area_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Uneven_Day_Head] ADD  CONSTRAINT [DF_Uneven_Day_Head_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Attendance].[Uneven_Day_Head] ADD  CONSTRAINT [DF_Uneven_Day_Head_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Uneven_Day_Leave] ADD  CONSTRAINT [DF_Uneven_Day_Leave_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Attendance].[Uneven_Day_Shift] ADD  CONSTRAINT [DF_Uneven_Day_Shift_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Auth].[Authorization_Role] ADD  CONSTRAINT [DF_Authorization_Role_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Auth].[Authorization_Role] ADD  CONSTRAINT [DF_Authorization_Role_db_server_date_time]  DEFAULT (getdate()) FOR [created_db_server_date_time]
GO
ALTER TABLE [Auth].[Menu] ADD  CONSTRAINT [DF_Menu_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Auth].[Menu] ADD  CONSTRAINT [DF__Menu__db_server___2B3F6F97]  DEFAULT (getdate()) FOR [created_db_server_date_time]
GO
ALTER TABLE [Auth].[Password_Policy] ADD  CONSTRAINT [DF_Password_Policy_min_allowable_number]  DEFAULT ((1)) FOR [min_allowable_number]
GO
ALTER TABLE [Auth].[Password_Policy] ADD  CONSTRAINT [DF_Password_Policy_max_allowable_number]  DEFAULT ((1)) FOR [max_allowable_number]
GO
ALTER TABLE [Auth].[User_Group] ADD  CONSTRAINT [DF_User_Group_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Auth].[User_Info] ADD  CONSTRAINT [DF_User_Info_is_password_reset]  DEFAULT ((0)) FOR [is_password_reset]
GO
ALTER TABLE [Auth].[User_Location_Binding] ADD  CONSTRAINT [DF_User_Location_Binding_is_continous]  DEFAULT ((0)) FOR [is_continous]
GO
ALTER TABLE [Auth].[User_Location_Binding] ADD  CONSTRAINT [DF_User_Location_Binding_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Leave].[Leave_Head] ADD  CONSTRAINT [DF_Leave_Head_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_remarks]  DEFAULT ((1)) FOR [remarks]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_proportionate]  DEFAULT ((1)) FOR [is_proportionate]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_hourly]  DEFAULT ((0)) FOR [is_hourly]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_attachment_required]  DEFAULT ((0)) FOR [is_attachment_required]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_allow_sandwich]  DEFAULT ((0)) FOR [is_allow_sandwich]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sandwich_dayoff]  DEFAULT ((0)) FOR [is_sandwich_dayoff]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sandwich_holiday]  DEFAULT ((0)) FOR [is_sandwich_holiday]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sandwich_uneven]  DEFAULT ((0)) FOR [is_sandwich_uneven]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_prefix]  DEFAULT ((0)) FOR [is_prefix]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_prefix_dayoff]  DEFAULT ((0)) FOR [is_prefix_dayoff]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_prefix_holiday]  DEFAULT ((0)) FOR [is_prefix_holiday]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_prefix_uneven]  DEFAULT ((0)) FOR [is_prefix_uneven]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sufix]  DEFAULT ((0)) FOR [is_sufix]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sufix_dayoff]  DEFAULT ((0)) FOR [is_sufix_dayoff]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sufix_holiday]  DEFAULT ((0)) FOR [is_sufix_holiday]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_sufix_uneven]  DEFAULT ((0)) FOR [is_sufix_uneven]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_required_purpose]  DEFAULT ((0)) FOR [is_required_purpose]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_leave_area_required]  DEFAULT ((0)) FOR [is_leave_area_required]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_responsible_person_required]  DEFAULT ((0)) FOR [is_responsible_person_required]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_negetive_balance]  DEFAULT ((0)) FOR [is_negetive_balance]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_earn_dayoff]  DEFAULT ((0)) FOR [is_earn_dayoff]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_earn_holiday]  DEFAULT ((0)) FOR [is_earn_holiday]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_earn_uneven]  DEFAULT ((0)) FOR [is_earn_uneven]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_earn_absent]  DEFAULT ((0)) FOR [is_earn_absent]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_is_gross]  DEFAULT ((0)) FOR [is_gross]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_is_activation_on_joining]  DEFAULT ((1)) FOR [is_activation_on_joining]
GO
ALTER TABLE [Leave].[Leave_Policy] ADD  CONSTRAINT [DF_Leave_Policy_Detail_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Payroll].[Salary_Head] ADD  CONSTRAINT [DF_Salary_Head_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee] ADD  CONSTRAINT [DF_Employee_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Attendance_Policy] ADD  CONSTRAINT [DF_Employee_Attendance_Policy_is_random_dayoff]  DEFAULT ((0)) FOR [is_random_dayoff]
GO
ALTER TABLE [PIMS].[Employee_Attendance_Policy] ADD  CONSTRAINT [DF_Employee_Attendance_Policy_is_allow_benefit_policy]  DEFAULT ((0)) FOR [is_allow_benefit_policy]
GO
ALTER TABLE [PIMS].[Employee_Attendance_Policy] ADD  CONSTRAINT [DF_Employee_Attendance_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Authentication] ADD  CONSTRAINT [DF_Employee_Authentication_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [PIMS].[Employee_Authentication] ADD  CONSTRAINT [DF_Employee_Authentication_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Benefit_Policy] ADD  CONSTRAINT [DF_Employee_Benefit_Policy_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [PIMS].[Employee_Benefit_Policy] ADD  CONSTRAINT [DF_Employee_Benefit_Policy_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Category] ADD  CONSTRAINT [DF_Employee_Category_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Dayoff] ADD  CONSTRAINT [DF_Employee_Dayoff_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Leave_Ledger] ADD  CONSTRAINT [DF_Employee_Leave_Ledger_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [PIMS].[Employee_Leave_Ledger] ADD  CONSTRAINT [DF_Employee_Leave_Ledger_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [PIMS].[Employee_Reporting] ADD  CONSTRAINT [DF_Employee_Reporting_db_server_date_time]  DEFAULT (getdate()) FOR [db_server_date_time]
GO
ALTER TABLE [Procurement].[Supplier_Application] ADD  CONSTRAINT [DF_Supplier_Application_legal_name]  DEFAULT ('') FOR [legal_name]
GO
ALTER TABLE [Procurement].[Supplier_Application] ADD  CONSTRAINT [DF_Supplier_Application_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [Procurement].[Supplier_Application] ADD  CONSTRAINT [DF_Supplier_Application_status]  DEFAULT ((0)) FOR [feedback_status]
GO
ALTER TABLE [Accounting].[Accounting_Voucher_Type]  WITH CHECK ADD  CONSTRAINT [FK_Accounting_Voucher_Type_User_Info] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Accounting].[Accounting_Voucher_Type] CHECK CONSTRAINT [FK_Accounting_Voucher_Type_User_Info]
GO
ALTER TABLE [Accounting].[Accounting_Voucher_Type]  WITH CHECK ADD  CONSTRAINT [FK_Accounting_Voucher_Type_User_Info1] FOREIGN KEY([updated_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Accounting].[Accounting_Voucher_Type] CHECK CONSTRAINT [FK_Accounting_Voucher_Type_User_Info1]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Of_Accounts_Info_Company] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] CHECK CONSTRAINT [FK_Chart_Of_Accounts_Info_Company]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Of_Accounts_Info_Company_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] CHECK CONSTRAINT [FK_Chart_Of_Accounts_Info_Company_Corporate]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Of_Accounts_Info_Company_Group] FOREIGN KEY([company_group_id])
REFERENCES [Administrative].[Company_Group] ([company_group_id])
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] CHECK CONSTRAINT [FK_Chart_Of_Accounts_Info_Company_Group]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Of_Accounts_Info_User_Info] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] CHECK CONSTRAINT [FK_Chart_Of_Accounts_Info_User_Info]
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Of_Accounts_Info_User_Info_Update] FOREIGN KEY([updated_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Accounting].[Chart_Of_Accounts_Info] CHECK CONSTRAINT [FK_Chart_Of_Accounts_Info_User_Info_Update]
GO
ALTER TABLE [Accounting].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Company] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Accounting].[Voucher] CHECK CONSTRAINT [FK_Voucher_Company]
GO
ALTER TABLE [Accounting].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Company_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Accounting].[Voucher] CHECK CONSTRAINT [FK_Voucher_Company_Corporate]
GO
ALTER TABLE [Accounting].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Company_Group] FOREIGN KEY([company_group_id])
REFERENCES [Administrative].[Company_Group] ([company_group_id])
GO
ALTER TABLE [Accounting].[Voucher] CHECK CONSTRAINT [FK_Voucher_Company_Group]
GO
ALTER TABLE [Accounting].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_User_Info] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Accounting].[Voucher] CHECK CONSTRAINT [FK_Voucher_User_Info]
GO
ALTER TABLE [Accounting].[Voucher_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Details_Chart_Of_Accounts_Info] FOREIGN KEY([chart_of_account_auto_id])
REFERENCES [Accounting].[Chart_Of_Accounts_Info] ([chart_of_accounts_info_id])
GO
ALTER TABLE [Accounting].[Voucher_Detail] CHECK CONSTRAINT [FK_Voucher_Details_Chart_Of_Accounts_Info]
GO
ALTER TABLE [Accounting].[Voucher_Detail]  WITH CHECK ADD  CONSTRAINT [FK_voucher_id] FOREIGN KEY([voucher_id])
REFERENCES [Accounting].[Voucher] ([voucher_id])
GO
ALTER TABLE [Accounting].[Voucher_Detail] CHECK CONSTRAINT [FK_voucher_id]
GO
ALTER TABLE [Administrative].[Association]  WITH CHECK ADD  CONSTRAINT [FK_Association_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Association] CHECK CONSTRAINT [FK_Association_Country]
GO
ALTER TABLE [Administrative].[Association]  WITH CHECK ADD  CONSTRAINT [FK_Association_Organization_Type] FOREIGN KEY([organization_type_id_enum])
REFERENCES [DBEnum].[Organization_Type] ([organization_type_id_enum])
GO
ALTER TABLE [Administrative].[Association] CHECK CONSTRAINT [FK_Association_Organization_Type]
GO
ALTER TABLE [Administrative].[Bank]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Bank] CHECK CONSTRAINT [FK_Bank_Country]
GO
ALTER TABLE [Administrative].[Bank]  WITH CHECK ADD  CONSTRAINT [FK_Bank_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Administrative].[Bank] CHECK CONSTRAINT [FK_Bank_District]
GO
ALTER TABLE [Administrative].[Bank]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Administrative].[Bank] CHECK CONSTRAINT [FK_Bank_Division]
GO
ALTER TABLE [Administrative].[Bank_Branch]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Branch_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Bank_Branch] CHECK CONSTRAINT [FK_Bank_Branch_Country]
GO
ALTER TABLE [Administrative].[Bank_Branch]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Branch_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Administrative].[Bank_Branch] CHECK CONSTRAINT [FK_Bank_Branch_District]
GO
ALTER TABLE [Administrative].[Bank_Branch]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Branch_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Administrative].[Bank_Branch] CHECK CONSTRAINT [FK_Bank_Branch_Division]
GO
ALTER TABLE [Administrative].[Business_Type]  WITH CHECK ADD  CONSTRAINT [FK_Business_Type_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Business_Type] CHECK CONSTRAINT [FK_Business_Type_Corporate]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Company_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_Company_Corporate]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Company_Group] FOREIGN KEY([company_group_id])
REFERENCES [Administrative].[Company_Group] ([company_group_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_Company_Group]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_Country]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Currency] FOREIGN KEY([currency_id])
REFERENCES [Administrative].[Currency] ([currency_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_Currency]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_District]
GO
ALTER TABLE [Administrative].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Administrative].[Company] CHECK CONSTRAINT [FK_Company_Division]
GO
ALTER TABLE [Administrative].[Company_BIN]  WITH CHECK ADD  CONSTRAINT [FK_Company_Circle] FOREIGN KEY([vat_circle_id])
REFERENCES [Administrative].[Vat_Circle] ([vat_circle_id])
GO
ALTER TABLE [Administrative].[Company_BIN] CHECK CONSTRAINT [FK_Company_Circle]
GO
ALTER TABLE [Administrative].[Company_Business_Nature]  WITH CHECK ADD  CONSTRAINT [FK_Company_Business_Nature_Entity] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Administrative].[Company_Business_Nature] CHECK CONSTRAINT [FK_Company_Business_Nature_Entity]
GO
ALTER TABLE [Administrative].[Company_Corporate]  WITH CHECK ADD  CONSTRAINT [FK_Global_Corporate_Create_User] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Administrative].[Company_Corporate] CHECK CONSTRAINT [FK_Global_Corporate_Create_User]
GO
ALTER TABLE [Administrative].[Company_Corporate]  WITH CHECK ADD  CONSTRAINT [FK_Global_Corporate_Update] FOREIGN KEY([updated_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Administrative].[Company_Corporate] CHECK CONSTRAINT [FK_Global_Corporate_Update]
GO
ALTER TABLE [Administrative].[Company_Group]  WITH CHECK ADD  CONSTRAINT [FK_Company_Group_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Company_Group] CHECK CONSTRAINT [FK_Company_Group_Corporate]
GO
ALTER TABLE [Administrative].[Company_Industry_Sub_Sector]  WITH CHECK ADD  CONSTRAINT [FK_Company_Industry_Sub_Sector_Company] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Administrative].[Company_Industry_Sub_Sector] CHECK CONSTRAINT [FK_Company_Industry_Sub_Sector_Company]
GO
ALTER TABLE [Administrative].[Company_Industry_Sub_Sector]  WITH CHECK ADD  CONSTRAINT [FK_Company_Industry_Sub_Sector_Industry_Sub_Sector] FOREIGN KEY([industry_sub_sector_id])
REFERENCES [Administrative].[Industry_Sub_Sector] ([industry_sub_sector_id])
GO
ALTER TABLE [Administrative].[Company_Industry_Sub_Sector] CHECK CONSTRAINT [FK_Company_Industry_Sub_Sector_Industry_Sub_Sector]
GO
ALTER TABLE [Administrative].[Company_Ownership_Type]  WITH CHECK ADD  CONSTRAINT [FK_Company_Ownership_Type_Entity] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Administrative].[Company_Ownership_Type] CHECK CONSTRAINT [FK_Company_Ownership_Type_Entity]
GO
ALTER TABLE [Administrative].[Company_Ownership_Type]  WITH CHECK ADD  CONSTRAINT [FK_Company_Ownership_Type_Ownership] FOREIGN KEY([ownership_type_id])
REFERENCES [Administrative].[Ownership_Type] ([ownership_type_id])
GO
ALTER TABLE [Administrative].[Company_Ownership_Type] CHECK CONSTRAINT [FK_Company_Ownership_Type_Ownership]
GO
ALTER TABLE [Administrative].[Competency]  WITH CHECK ADD  CONSTRAINT [FK_Competency_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Competency] CHECK CONSTRAINT [FK_Competency_Corporate]
GO
ALTER TABLE [Administrative].[Contact_Type]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Type_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Contact_Type] CHECK CONSTRAINT [FK_Contact_Type_Country]
GO
ALTER TABLE [Administrative].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Department] CHECK CONSTRAINT [FK_Department_Corporate]
GO
ALTER TABLE [Administrative].[Designation]  WITH CHECK ADD  CONSTRAINT [FK_Designation_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Designation] CHECK CONSTRAINT [FK_Designation_Corporate]
GO
ALTER TABLE [Administrative].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Administrative].[District] CHECK CONSTRAINT [FK_District_Division]
GO
ALTER TABLE [Administrative].[Division]  WITH CHECK ADD  CONSTRAINT [FK_Division_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Division] CHECK CONSTRAINT [FK_Division_Country]
GO
ALTER TABLE [Administrative].[Document_Type]  WITH CHECK ADD  CONSTRAINT [FK_Document_Type_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Document_Type] CHECK CONSTRAINT [FK_Document_Type_Country]
GO
ALTER TABLE [Administrative].[Ecommerce_Platforms]  WITH CHECK ADD  CONSTRAINT [FK_Ecommerce_Platforms_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Ecommerce_Platforms] CHECK CONSTRAINT [FK_Ecommerce_Platforms_Country]
GO
ALTER TABLE [Administrative].[Education]  WITH CHECK ADD  CONSTRAINT [FK_Education_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Education] CHECK CONSTRAINT [FK_Education_Corporate]
GO
ALTER TABLE [Administrative].[Industry_Sub_Sector]  WITH CHECK ADD  CONSTRAINT [FK_Industry_Sub_Sector_Industry_Sector] FOREIGN KEY([industry_sector_id])
REFERENCES [Administrative].[Industry_Sector] ([industry_sector_id])
GO
ALTER TABLE [Administrative].[Industry_Sub_Sector] CHECK CONSTRAINT [FK_Industry_Sub_Sector_Industry_Sector]
GO
ALTER TABLE [Administrative].[Key_Skill]  WITH CHECK ADD  CONSTRAINT [FK_Key_Skill_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Key_Skill] CHECK CONSTRAINT [FK_Key_Skill_Corporate]
GO
ALTER TABLE [Administrative].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Location] CHECK CONSTRAINT [FK_Location_Corporate]
GO
ALTER TABLE [Administrative].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Location] CHECK CONSTRAINT [FK_Location_Country]
GO
ALTER TABLE [Administrative].[Location_BIN]  WITH CHECK ADD  CONSTRAINT [FK_Location_Circle] FOREIGN KEY([vat_circle_id])
REFERENCES [Administrative].[Vat_Circle] ([vat_circle_id])
GO
ALTER TABLE [Administrative].[Location_BIN] CHECK CONSTRAINT [FK_Location_Circle]
GO
ALTER TABLE [Administrative].[Location_Type]  WITH CHECK ADD  CONSTRAINT [FK_Location_Type_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Location_Type] CHECK CONSTRAINT [FK_Location_Type_Country]
GO
ALTER TABLE [Administrative].[Mobile_Financial_Service]  WITH CHECK ADD  CONSTRAINT [FK_Mobile_Financial_Service_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Mobile_Financial_Service] CHECK CONSTRAINT [FK_Mobile_Financial_Service_Country]
GO
ALTER TABLE [Administrative].[Organogram]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Company_Group] FOREIGN KEY([company_group_id])
REFERENCES [Administrative].[Company_Group] ([company_group_id])
GO
ALTER TABLE [Administrative].[Organogram] CHECK CONSTRAINT [FK_Organogram_Company_Group]
GO
ALTER TABLE [Administrative].[Organogram]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Organogram] CHECK CONSTRAINT [FK_Organogram_Corporate]
GO
ALTER TABLE [Administrative].[Organogram]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Entity] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Administrative].[Organogram] CHECK CONSTRAINT [FK_Organogram_Entity]
GO
ALTER TABLE [Administrative].[Organogram]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Location] FOREIGN KEY([location_id])
REFERENCES [Administrative].[Location] ([location_id])
GO
ALTER TABLE [Administrative].[Organogram] CHECK CONSTRAINT [FK_Organogram_Location]
GO
ALTER TABLE [Administrative].[Organogram_Department]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Department_Department] FOREIGN KEY([department_id])
REFERENCES [Administrative].[Department] ([department_id])
GO
ALTER TABLE [Administrative].[Organogram_Department] CHECK CONSTRAINT [FK_Organogram_Department_Department]
GO
ALTER TABLE [Administrative].[Organogram_Department]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Department_Organogram] FOREIGN KEY([organogram_id])
REFERENCES [Administrative].[Organogram] ([organogram_id])
GO
ALTER TABLE [Administrative].[Organogram_Department] CHECK CONSTRAINT [FK_Organogram_Department_Organogram]
GO
ALTER TABLE [Administrative].[Organogram_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Organogram] FOREIGN KEY([organogram_id])
REFERENCES [Administrative].[Organogram] ([organogram_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail] CHECK CONSTRAINT [FK_Organogram_Detail_Organogram]
GO
ALTER TABLE [Administrative].[Organogram_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Position] FOREIGN KEY([position_id])
REFERENCES [Administrative].[Position] ([position_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail] CHECK CONSTRAINT [FK_Organogram_Detail_Position]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Competency]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Competency_Competency] FOREIGN KEY([competency_id])
REFERENCES [Administrative].[Competency] ([competency_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Competency] CHECK CONSTRAINT [FK_Organogram_Detail_Competency_Competency]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Competency]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Competency_Organogram_Detail] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Competency] CHECK CONSTRAINT [FK_Organogram_Detail_Competency_Organogram_Detail]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Education]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Education] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Education] CHECK CONSTRAINT [FK_Organogram_Detail_Education]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Education]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Education_Education] FOREIGN KEY([education_id])
REFERENCES [Administrative].[Education] ([education_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Education] CHECK CONSTRAINT [FK_Organogram_Detail_Education_Education]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Key_Skill]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Key_Skill_Key_Skill] FOREIGN KEY([key_skill_id])
REFERENCES [Administrative].[Key_Skill] ([key_skill_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Key_Skill] CHECK CONSTRAINT [FK_Organogram_Detail_Key_Skill_Key_Skill]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Key_Skill]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Key_Skill_Organogram_Detail] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Key_Skill] CHECK CONSTRAINT [FK_Organogram_Detail_Key_Skill_Organogram_Detail]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Supervisor_Organogram_Detail] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor] CHECK CONSTRAINT [FK_Organogram_Detail_Supervisor_Organogram_Detail]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Supervisor_Position] FOREIGN KEY([position_id])
REFERENCES [Administrative].[Position] ([position_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor] CHECK CONSTRAINT [FK_Organogram_Detail_Supervisor_Position]
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Detail_Supervisor_Reporting] FOREIGN KEY([reporting_line_id])
REFERENCES [DBEnum].[Reporting_Line] ([reporting_line_id])
GO
ALTER TABLE [Administrative].[Organogram_Detail_Supervisor] CHECK CONSTRAINT [FK_Organogram_Detail_Supervisor_Reporting]
GO
ALTER TABLE [Administrative].[Organogram_Permission]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Permission_Org_Detail] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Permission] CHECK CONSTRAINT [FK_Organogram_Permission_Org_Detail]
GO
ALTER TABLE [Administrative].[Organogram_Permission]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_Permission_Permitted_org] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_Permission] CHECK CONSTRAINT [FK_Organogram_Permission_Permitted_org]
GO
ALTER TABLE [Administrative].[Organogram_User_Permission]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_User_Permission_Org] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [Administrative].[Organogram_User_Permission] CHECK CONSTRAINT [FK_Organogram_User_Permission_Org]
GO
ALTER TABLE [Administrative].[Organogram_User_Permission]  WITH CHECK ADD  CONSTRAINT [FK_Organogram_User_Permission_User] FOREIGN KEY([user_info_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Administrative].[Organogram_User_Permission] CHECK CONSTRAINT [FK_Organogram_User_Permission_User]
GO
ALTER TABLE [Administrative].[Ownership_Type]  WITH CHECK ADD  CONSTRAINT [FK_Ownership_Type_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Ownership_Type] CHECK CONSTRAINT [FK_Ownership_Type_Corporate]
GO
ALTER TABLE [Administrative].[Position]  WITH CHECK ADD  CONSTRAINT [FK_Position_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Position] CHECK CONSTRAINT [FK_Position_Corporate]
GO
ALTER TABLE [Administrative].[Registry_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Registry_Authority_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Registry_Authority] CHECK CONSTRAINT [FK_Registry_Authority_Country]
GO
ALTER TABLE [Administrative].[Regulator]  WITH CHECK ADD  CONSTRAINT [FK_Regulator_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Regulator] CHECK CONSTRAINT [FK_Regulator_Country]
GO
ALTER TABLE [Administrative].[Thana]  WITH CHECK ADD  CONSTRAINT [FK_Thana_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Administrative].[Thana] CHECK CONSTRAINT [FK_Thana_District]
GO
ALTER TABLE [Administrative].[Vat_Circle]  WITH CHECK ADD  CONSTRAINT [FK_Vat_Circle_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Vat_Circle] CHECK CONSTRAINT [FK_Vat_Circle_Corporate]
GO
ALTER TABLE [Administrative].[Vat_Circle]  WITH CHECK ADD  CONSTRAINT [FK_Vat_Circle_Division] FOREIGN KEY([vat_division_id])
REFERENCES [Administrative].[Vat_Division] ([vat_division_id])
GO
ALTER TABLE [Administrative].[Vat_Circle] CHECK CONSTRAINT [FK_Vat_Circle_Division]
GO
ALTER TABLE [Administrative].[Vat_Commissionerate]  WITH CHECK ADD  CONSTRAINT [FK_Vat_Commissionerate_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Vat_Commissionerate] CHECK CONSTRAINT [FK_Vat_Commissionerate_Corporate]
GO
ALTER TABLE [Administrative].[Vat_Division]  WITH CHECK ADD  CONSTRAINT [FK_Vat_Division_Commissionerate] FOREIGN KEY([vat_commissionerate_id])
REFERENCES [Administrative].[Vat_Commissionerate] ([vat_commissionerate_id])
GO
ALTER TABLE [Administrative].[Vat_Division] CHECK CONSTRAINT [FK_Vat_Division_Commissionerate]
GO
ALTER TABLE [Administrative].[Vat_Division]  WITH CHECK ADD  CONSTRAINT [FK_Vat_Division_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Administrative].[Vat_Division] CHECK CONSTRAINT [FK_Vat_Division_Corporate]
GO
ALTER TABLE [Administrative].[Zone]  WITH CHECK ADD  CONSTRAINT [FK_Zone_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Administrative].[Zone] CHECK CONSTRAINT [FK_Zone_Country]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Companay]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Calendar_Companay_Attendance_Calendar] FOREIGN KEY([attendance_calendar_id])
REFERENCES [Attendance].[Attendance_Calendar] ([attendance_calendar_id])
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Companay] CHECK CONSTRAINT [FK_Attendance_Calendar_Companay_Attendance_Calendar]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Calendar_Session_Attendance_Calendar] FOREIGN KEY([attendance_calendar_id])
REFERENCES [Attendance].[Attendance_Calendar] ([attendance_calendar_id])
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session] CHECK CONSTRAINT [FK_Attendance_Calendar_Session_Attendance_Calendar]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session_Holiday]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Calendar_Session_Holiday_Attendance_Calendar_Session] FOREIGN KEY([acs_id])
REFERENCES [Attendance].[Attendance_Calendar_Session] ([acs_id])
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session_Holiday] CHECK CONSTRAINT [FK_Attendance_Calendar_Session_Holiday_Attendance_Calendar_Session]
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session_Holiday]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Calendar_Session_Holiday_Holiday] FOREIGN KEY([holiday_id])
REFERENCES [Attendance].[Holiday] ([holiday_id])
GO
ALTER TABLE [Attendance].[Attendance_Calendar_Session_Holiday] CHECK CONSTRAINT [FK_Attendance_Calendar_Session_Holiday_Holiday]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Benefit]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Benefit_Attendance_Benefit_Policy] FOREIGN KEY([abp_id])
REFERENCES [Attendance].[Attendance_Benefit_Policy] ([abp_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Benefit] CHECK CONSTRAINT [FK_Attendance_Policy_Benefit_Attendance_Benefit_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Benefit]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Benefit_Attendance_Policy] FOREIGN KEY([attendance_policy_id])
REFERENCES [Attendance].[Attendance_Policy] ([attendance_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Benefit] CHECK CONSTRAINT [FK_Attendance_Policy_Benefit_Attendance_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Dayoff]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Dayoff_Attendance] FOREIGN KEY([attendance_policy_id])
REFERENCES [Attendance].[Attendance_Policy] ([attendance_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Dayoff] CHECK CONSTRAINT [FK_Attendance_Policy_Dayoff_Attendance]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Dayoff]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Dayoff_Dayoff_Alternative] FOREIGN KEY([dayoff_alternative_id])
REFERENCES [DBEnum].[Dayoff_Alternative] ([dayoff_alternative_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Dayoff] CHECK CONSTRAINT [FK_Attendance_Policy_Dayoff_Dayoff_Alternative]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Leave]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Leave_Attendance_Policy] FOREIGN KEY([attendance_policy_id])
REFERENCES [Attendance].[Attendance_Policy] ([attendance_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Leave] CHECK CONSTRAINT [FK_Attendance_Policy_Leave_Attendance_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Leave]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Leave_Leave_Policy] FOREIGN KEY([leave_policy_id])
REFERENCES [Leave].[Leave_Policy] ([leave_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Leave] CHECK CONSTRAINT [FK_Attendance_Policy_Leave_Leave_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Organogram]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Organogram_Attendance_Policy] FOREIGN KEY([attendance_policy_id])
REFERENCES [Attendance].[Attendance_Policy] ([attendance_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Organogram] CHECK CONSTRAINT [FK_Attendance_Policy_Organogram_Attendance_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Shift]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Shift_Attendance_Policy] FOREIGN KEY([attendance_policy_id])
REFERENCES [Attendance].[Attendance_Policy] ([attendance_policy_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Shift] CHECK CONSTRAINT [FK_Attendance_Policy_Shift_Attendance_Policy]
GO
ALTER TABLE [Attendance].[Attendance_Policy_Shift]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Policy_Shift_Shift_Info] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Attendance_Policy_Shift] CHECK CONSTRAINT [FK_Attendance_Policy_Shift_Shift_Info]
GO
ALTER TABLE [Attendance].[General_Working_Day_Applicable_Area]  WITH CHECK ADD  CONSTRAINT [FK_General_Working_Day_Applicable_Area_General_GWD] FOREIGN KEY([gwd_id])
REFERENCES [Attendance].[General_Working_Day] ([gwd_id])
GO
ALTER TABLE [Attendance].[General_Working_Day_Applicable_Area] CHECK CONSTRAINT [FK_General_Working_Day_Applicable_Area_General_GWD]
GO
ALTER TABLE [Attendance].[General_Working_Day_Shift]  WITH CHECK ADD  CONSTRAINT [FK_General_Working_Day_Shift_Day] FOREIGN KEY([gwd_id])
REFERENCES [Attendance].[General_Working_Day] ([gwd_id])
GO
ALTER TABLE [Attendance].[General_Working_Day_Shift] CHECK CONSTRAINT [FK_General_Working_Day_Shift_Day]
GO
ALTER TABLE [Attendance].[General_Working_Day_Shift]  WITH CHECK ADD  CONSTRAINT [FK_General_Working_Day_Shift_Shift] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[General_Working_Day_Shift] CHECK CONSTRAINT [FK_General_Working_Day_Shift_Shift]
GO
ALTER TABLE [Attendance].[Holiday]  WITH CHECK ADD  CONSTRAINT [FK_Holiday_User_Info] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Attendance].[Holiday] CHECK CONSTRAINT [FK_Holiday_User_Info]
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Late_Early_Policy_Detail_Late_Early_Policy_Detail] FOREIGN KEY([late_early_policy_id])
REFERENCES [Attendance].[Late_Early_Policy] ([late_early_policy_id])
GO
ALTER TABLE [Attendance].[Late_Early_Policy_Detail] CHECK CONSTRAINT [FK_Late_Early_Policy_Detail_Late_Early_Policy_Detail]
GO
ALTER TABLE [Attendance].[Overtime_Policy_Company]  WITH CHECK ADD  CONSTRAINT [FK_Overtime_Policy_Company_Overtime_Policy] FOREIGN KEY([OT_policy_id])
REFERENCES [Attendance].[Overtime_Policy] ([OT_policy_id])
GO
ALTER TABLE [Attendance].[Overtime_Policy_Company] CHECK CONSTRAINT [FK_Overtime_Policy_Company_Overtime_Policy]
GO
ALTER TABLE [Attendance].[Overtime_Policy_Slab]  WITH CHECK ADD  CONSTRAINT [FK_Overtime_Slab_Overtime_Policy] FOREIGN KEY([OT_policy_id])
REFERENCES [Attendance].[Overtime_Policy] ([OT_policy_id])
GO
ALTER TABLE [Attendance].[Overtime_Policy_Slab] CHECK CONSTRAINT [FK_Overtime_Slab_Overtime_Policy]
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Roster_Policy_Detail_Next_Shift] FOREIGN KEY([next_shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail] CHECK CONSTRAINT [FK_Roster_Policy_Detail_Next_Shift]
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Roster_Policy_Detail_Roster_Policy] FOREIGN KEY([roster_policy_id])
REFERENCES [Attendance].[Roster_Policy] ([roster_policy_id])
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail] CHECK CONSTRAINT [FK_Roster_Policy_Detail_Roster_Policy]
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Roster_Policy_Detail_Shift] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Roster_Policy_Detail] CHECK CONSTRAINT [FK_Roster_Policy_Detail_Shift]
GO
ALTER TABLE [Attendance].[Shift_Break_Duration]  WITH CHECK ADD  CONSTRAINT [FK_Shift_Break_Duration_Shift] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Shift_Break_Duration] CHECK CONSTRAINT [FK_Shift_Break_Duration_Shift]
GO
ALTER TABLE [Attendance].[Shift_Break_Duration]  WITH CHECK ADD  CONSTRAINT [FK_Shift_Break_Duration_Shift_Break_Duration] FOREIGN KEY([shift_break_head_id])
REFERENCES [Attendance].[Shift_Break_Head] ([shift_break_head_id])
GO
ALTER TABLE [Attendance].[Shift_Break_Duration] CHECK CONSTRAINT [FK_Shift_Break_Duration_Shift_Break_Duration]
GO
ALTER TABLE [Attendance].[Shift_Company]  WITH CHECK ADD  CONSTRAINT [FK_Shift_Company_Company] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Attendance].[Shift_Company] CHECK CONSTRAINT [FK_Shift_Company_Company]
GO
ALTER TABLE [Attendance].[Shift_Company]  WITH CHECK ADD  CONSTRAINT [FK_Shift_Company_Shift] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Shift_Company] CHECK CONSTRAINT [FK_Shift_Company_Shift]
GO
ALTER TABLE [Attendance].[Uneven_Day]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day_Head] FOREIGN KEY([uneven_day_head_id])
REFERENCES [Attendance].[Uneven_Day_Head] ([uneven_day_head_id])
GO
ALTER TABLE [Attendance].[Uneven_Day] CHECK CONSTRAINT [FK_Uneven_Day_Head]
GO
ALTER TABLE [Attendance].[Uneven_Day_Applicable_Area]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day] FOREIGN KEY([uneven_day_id])
REFERENCES [Attendance].[Uneven_Day] ([uneven_day_id])
GO
ALTER TABLE [Attendance].[Uneven_Day_Applicable_Area] CHECK CONSTRAINT [FK_Uneven_Day]
GO
ALTER TABLE [Attendance].[Uneven_Day_Leave]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day_Leave_Leave] FOREIGN KEY([leave_head_id])
REFERENCES [Leave].[Leave_Head] ([leave_head_id])
GO
ALTER TABLE [Attendance].[Uneven_Day_Leave] CHECK CONSTRAINT [FK_Uneven_Day_Leave_Leave]
GO
ALTER TABLE [Attendance].[Uneven_Day_Leave]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day_Leave_Uneven_Day] FOREIGN KEY([uneven_day_id])
REFERENCES [Attendance].[Uneven_Day] ([uneven_day_id])
GO
ALTER TABLE [Attendance].[Uneven_Day_Leave] CHECK CONSTRAINT [FK_Uneven_Day_Leave_Uneven_Day]
GO
ALTER TABLE [Attendance].[Uneven_Day_Shift]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day_Shift_Shift] FOREIGN KEY([shift_id])
REFERENCES [Attendance].[Shift_Info] ([shift_id])
GO
ALTER TABLE [Attendance].[Uneven_Day_Shift] CHECK CONSTRAINT [FK_Uneven_Day_Shift_Shift]
GO
ALTER TABLE [Attendance].[Uneven_Day_Shift]  WITH CHECK ADD  CONSTRAINT [FK_Uneven_Day_Shift_Uneven_Day] FOREIGN KEY([uneven_day_id])
REFERENCES [Attendance].[Uneven_Day] ([uneven_day_id])
GO
ALTER TABLE [Attendance].[Uneven_Day_Shift] CHECK CONSTRAINT [FK_Uneven_Day_Shift_Uneven_Day]
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event]  WITH CHECK ADD  CONSTRAINT [FK_Authorization_Role_Menu_Event_Authorization_Role] FOREIGN KEY([authorization_role_id])
REFERENCES [Auth].[Authorization_Role] ([authorization_role_id])
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event] CHECK CONSTRAINT [FK_Authorization_Role_Menu_Event_Authorization_Role]
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event]  WITH CHECK ADD  CONSTRAINT [FK_Authorization_Role_Menu_Event_Menu] FOREIGN KEY([menu_id])
REFERENCES [Auth].[Menu] ([menu_id])
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event] CHECK CONSTRAINT [FK_Authorization_Role_Menu_Event_Menu]
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event]  WITH CHECK ADD  CONSTRAINT [FK_Authorization_Role_Menu_Event_Menu_Event] FOREIGN KEY([menu_event_id])
REFERENCES [Auth].[Menu_Event] ([menu_event_id])
GO
ALTER TABLE [Auth].[Authorization_Role_Menu_Event] CHECK CONSTRAINT [FK_Authorization_Role_Menu_Event_Menu_Event]
GO
ALTER TABLE [Auth].[Login_Activity]  WITH CHECK ADD  CONSTRAINT [FK_Login_Activity_User_Info] FOREIGN KEY([user_info_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Auth].[Login_Activity] CHECK CONSTRAINT [FK_Login_Activity_User_Info]
GO
ALTER TABLE [Auth].[Menu_Event]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Event_Menu] FOREIGN KEY([menu_id])
REFERENCES [Auth].[Menu] ([menu_id])
GO
ALTER TABLE [Auth].[Menu_Event] CHECK CONSTRAINT [FK_Menu_Event_Menu]
GO
ALTER TABLE [Auth].[Password_Policy]  WITH CHECK ADD  CONSTRAINT [FK_Password_Policy_Company] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Auth].[Password_Policy] CHECK CONSTRAINT [FK_Password_Policy_Company]
GO
ALTER TABLE [Auth].[Password_Policy]  WITH CHECK ADD  CONSTRAINT [FK_Password_Policy_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Auth].[Password_Policy] CHECK CONSTRAINT [FK_Password_Policy_Corporate]
GO
ALTER TABLE [Auth].[Software_Version_Menu]  WITH CHECK ADD  CONSTRAINT [FK_Software_Version_Menu_Menu] FOREIGN KEY([menu_id])
REFERENCES [Auth].[Menu] ([menu_id])
GO
ALTER TABLE [Auth].[Software_Version_Menu] CHECK CONSTRAINT [FK_Software_Version_Menu_Menu]
GO
ALTER TABLE [Auth].[Time_Zone_Country]  WITH CHECK ADD  CONSTRAINT [FK_Time_Zone_Country_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Auth].[Time_Zone_Country] CHECK CONSTRAINT [FK_Time_Zone_Country_Country]
GO
ALTER TABLE [Auth].[Time_Zone_Country]  WITH CHECK ADD  CONSTRAINT [FK_Time_Zone_Country_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Auth].[Time_Zone_Country] CHECK CONSTRAINT [FK_Time_Zone_Country_District]
GO
ALTER TABLE [Auth].[Time_Zone_Country]  WITH CHECK ADD  CONSTRAINT [FK_Time_Zone_Country_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Auth].[Time_Zone_Country] CHECK CONSTRAINT [FK_Time_Zone_Country_Division]
GO
ALTER TABLE [Auth].[Time_Zone_Country]  WITH CHECK ADD  CONSTRAINT [FK_Time_Zone_Country_time_zone] FOREIGN KEY([time_zone_id])
REFERENCES [Auth].[Time_Zone] ([time_zone_id])
GO
ALTER TABLE [Auth].[Time_Zone_Country] CHECK CONSTRAINT [FK_Time_Zone_Country_time_zone]
GO
ALTER TABLE [Auth].[User_Group_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_User_Group_Mapping_User_Group] FOREIGN KEY([user_group_id])
REFERENCES [Auth].[User_Group] ([user_group_id])
GO
ALTER TABLE [Auth].[User_Group_Mapping] CHECK CONSTRAINT [FK_User_Group_Mapping_User_Group]
GO
ALTER TABLE [Auth].[User_Group_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_User_Group_Mapping_user_info] FOREIGN KEY([user_info_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Auth].[User_Group_Mapping] CHECK CONSTRAINT [FK_User_Group_Mapping_user_info]
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Group_Menu_Authorization_Event_Menu] FOREIGN KEY([menu_id])
REFERENCES [Auth].[Menu] ([menu_id])
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Group_Menu_Authorization_Event_Menu]
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Group_Menu_Authorization_Event_Menu_Event] FOREIGN KEY([menu_event_id])
REFERENCES [Auth].[Menu_Event] ([menu_event_id])
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Group_Menu_Authorization_Event_Menu_Event]
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Group_Menu_Authorization_Event_User_Group] FOREIGN KEY([user_group_id])
REFERENCES [Auth].[User_Group] ([user_group_id])
GO
ALTER TABLE [Auth].[User_Group_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Group_Menu_Authorization_Event_User_Group]
GO
ALTER TABLE [Auth].[User_Info]  WITH CHECK ADD  CONSTRAINT [FK_User_Info_User_Info] FOREIGN KEY([user_info_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Auth].[User_Info] CHECK CONSTRAINT [FK_User_Info_User_Info]
GO
ALTER TABLE [Auth].[User_Location_Binding]  WITH CHECK ADD  CONSTRAINT [FK_User_Location_Binding_Geo_Location] FOREIGN KEY([geo_location_id])
REFERENCES [Auth].[Geo_Location] ([geo_location_id])
GO
ALTER TABLE [Auth].[User_Location_Binding] CHECK CONSTRAINT [FK_User_Location_Binding_Geo_Location]
GO
ALTER TABLE [Auth].[User_Location_Binding]  WITH CHECK ADD  CONSTRAINT [FK_User_Location_Binding_User_Info] FOREIGN KEY([user_info_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [Auth].[User_Location_Binding] CHECK CONSTRAINT [FK_User_Location_Binding_User_Info]
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Menu_Authorization_Event_Corporate] FOREIGN KEY([company_corporate_id])
REFERENCES [Administrative].[Company_Corporate] ([company_corporate_id])
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Menu_Authorization_Event_Corporate]
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Menu_Authorization_Event_Entity] FOREIGN KEY([company_id])
REFERENCES [Administrative].[Company] ([company_id])
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Menu_Authorization_Event_Entity]
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Menu_Authorization_Event_Menu] FOREIGN KEY([menu_id])
REFERENCES [Auth].[Menu] ([menu_id])
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Menu_Authorization_Event_Menu]
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event]  WITH CHECK ADD  CONSTRAINT [FK_User_Menu_Authorization_Event_Menu_Event] FOREIGN KEY([menu_event_id])
REFERENCES [Auth].[Menu_Event] ([menu_event_id])
GO
ALTER TABLE [Auth].[User_Menu_Authorization_Event] CHECK CONSTRAINT [FK_User_Menu_Authorization_Event_Menu_Event]
GO
ALTER TABLE [Party].[Dealer_Contact_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Contact_Info_Dealer_Info] FOREIGN KEY([dealer_info_id])
REFERENCES [Party].[Dealer_Info] ([dealer_info_id])
GO
ALTER TABLE [Party].[Dealer_Contact_Info] CHECK CONSTRAINT [FK_Dealer_Contact_Info_Dealer_Info]
GO
ALTER TABLE [Party].[Dealer_Document_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Document_Info_Dealer_Info] FOREIGN KEY([dealer_info_id])
REFERENCES [Party].[Dealer_Info] ([dealer_info_id])
GO
ALTER TABLE [Party].[Dealer_Document_Info] CHECK CONSTRAINT [FK_Dealer_Document_Info_Dealer_Info]
GO
ALTER TABLE [Party].[Dealer_Document_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Document_Info_Document_Type] FOREIGN KEY([document_type_id])
REFERENCES [Administrative].[Document_Type] ([document_type_id])
GO
ALTER TABLE [Party].[Dealer_Document_Info] CHECK CONSTRAINT [FK_Dealer_Document_Info_Document_Type]
GO
ALTER TABLE [Party].[Dealer_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Info_Industry_Sector] FOREIGN KEY([industry_sector_id])
REFERENCES [Administrative].[Industry_Sector] ([industry_sector_id])
GO
ALTER TABLE [Party].[Dealer_Info] CHECK CONSTRAINT [FK_Dealer_Info_Industry_Sector]
GO
ALTER TABLE [Party].[Dealer_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Info_Ownership_Type] FOREIGN KEY([ownership_type_id])
REFERENCES [Administrative].[Ownership_Type] ([ownership_type_id])
GO
ALTER TABLE [Party].[Dealer_Info] CHECK CONSTRAINT [FK_Dealer_Info_Ownership_Type]
GO
ALTER TABLE [Party].[Dealer_Location_Info]  WITH CHECK ADD  CONSTRAINT [FK_Dealer_Location_Info_Dealer_Info] FOREIGN KEY([dealer_info_id])
REFERENCES [Party].[Dealer_Info] ([dealer_info_id])
GO
ALTER TABLE [Party].[Dealer_Location_Info] CHECK CONSTRAINT [FK_Dealer_Location_Info_Dealer_Info]
GO
ALTER TABLE [Party].[Retailer_Contact_Info]  WITH CHECK ADD  CONSTRAINT [FK_Retailer_Contact_Info_Retailer_Info] FOREIGN KEY([retailer_info_id])
REFERENCES [Party].[Retailer_Info] ([retailer_info_id])
GO
ALTER TABLE [Party].[Retailer_Contact_Info] CHECK CONSTRAINT [FK_Retailer_Contact_Info_Retailer_Info]
GO
ALTER TABLE [Party].[Retailer_Info]  WITH CHECK ADD  CONSTRAINT [FK_Retailer_Info_Dealer_Info] FOREIGN KEY([dealer_info_id])
REFERENCES [Party].[Dealer_Info] ([dealer_info_id])
GO
ALTER TABLE [Party].[Retailer_Info] CHECK CONSTRAINT [FK_Retailer_Info_Dealer_Info]
GO
ALTER TABLE [Party].[Retailer_Location_Info]  WITH CHECK ADD  CONSTRAINT [FK_Retailer_Location_Info_Retailer_Info] FOREIGN KEY([retailer_info_id])
REFERENCES [Party].[Retailer_Info] ([retailer_info_id])
GO
ALTER TABLE [Party].[Retailer_Location_Info] CHECK CONSTRAINT [FK_Retailer_Location_Info_Retailer_Info]
GO
ALTER TABLE [PIMS].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Country_Present] FOREIGN KEY([present_country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [PIMS].[Employee] CHECK CONSTRAINT [FK_Employee_Country_Present]
GO
ALTER TABLE [PIMS].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_District_Present] FOREIGN KEY([present_district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [PIMS].[Employee] CHECK CONSTRAINT [FK_Employee_District_Present]
GO
ALTER TABLE [PIMS].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Division_Present] FOREIGN KEY([present_division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [PIMS].[Employee] CHECK CONSTRAINT [FK_Employee_Division_Present]
GO
ALTER TABLE [PIMS].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_User_Info] FOREIGN KEY([created_user_id])
REFERENCES [Auth].[User_Info] ([user_info_id])
GO
ALTER TABLE [PIMS].[Employee] CHECK CONSTRAINT [FK_Employee_User_Info]
GO
ALTER TABLE [PIMS].[Employee_Attendance_Policy]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Attendance_Policy_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Attendance_Policy] CHECK CONSTRAINT [FK_Employee_Attendance_Policy_Employee]
GO
ALTER TABLE [PIMS].[Employee_Authentication]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Authentication_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Authentication] CHECK CONSTRAINT [FK_Employee_Authentication_Employee]
GO
ALTER TABLE [PIMS].[Employee_Benefit_Policy]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Benefit_Policy_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Benefit_Policy] CHECK CONSTRAINT [FK_Employee_Benefit_Policy_Employee]
GO
ALTER TABLE [PIMS].[Employee_Category]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Category_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Category] CHECK CONSTRAINT [FK_Employee_Category_Employee]
GO
ALTER TABLE [PIMS].[Employee_Category]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Category_Type] FOREIGN KEY([employee_category_type_id])
REFERENCES [PIMS].[Employee_Category_Type] ([employee_category_type_id])
GO
ALTER TABLE [PIMS].[Employee_Category] CHECK CONSTRAINT [FK_Employee_Category_Type]
GO
ALTER TABLE [PIMS].[Employee_Dayoff]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Dayoff_Alternative] FOREIGN KEY([dayoff_alternative_id])
REFERENCES [DBEnum].[Dayoff_Alternative] ([dayoff_alternative_id])
GO
ALTER TABLE [PIMS].[Employee_Dayoff] CHECK CONSTRAINT [FK_Employee_Dayoff_Alternative]
GO
ALTER TABLE [PIMS].[Employee_Dayoff]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Dayoff_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Dayoff] CHECK CONSTRAINT [FK_Employee_Dayoff_Employee]
GO
ALTER TABLE [PIMS].[Employee_Dayoff]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Dayoff_Type] FOREIGN KEY([dayoff_type_id])
REFERENCES [DBEnum].[Dayoff_Type] ([dayoff_type_id])
GO
ALTER TABLE [PIMS].[Employee_Dayoff] CHECK CONSTRAINT [FK_Employee_Dayoff_Type]
GO
ALTER TABLE [PIMS].[Employee_Leave_Ledger]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Leave_Ledger_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Leave_Ledger] CHECK CONSTRAINT [FK_Employee_Leave_Ledger_Employee]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Confirmation] FOREIGN KEY([confirmation_status_id])
REFERENCES [DBEnum].[Confirmation_Status] ([confirmation_status_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Confirmation]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Designation] FOREIGN KEY([designation_id])
REFERENCES [Administrative].[Designation] ([designation_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Designation]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Employee] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Employee]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Job_Domicile] FOREIGN KEY([job_domicile_id])
REFERENCES [DBEnum].[Job_Domicile] ([job_domicile_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Job_Domicile]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Job_Location] FOREIGN KEY([job_location_id])
REFERENCES [DBEnum].[Job_Location] ([job_location_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Job_Location]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_organogram] FOREIGN KEY([organogram_detail_id])
REFERENCES [Administrative].[Organogram_Detail] ([organogram_detail_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_organogram]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Service_Type] FOREIGN KEY([service_type_id])
REFERENCES [DBEnum].[Service_Type] ([service_type_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Service_Type]
GO
ALTER TABLE [PIMS].[Employee_Official]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Official_Working_Status] FOREIGN KEY([working_action_id])
REFERENCES [DBEnum].[Working_Action] ([working_action_id])
GO
ALTER TABLE [PIMS].[Employee_Official] CHECK CONSTRAINT [FK_Employee_Official_Working_Status]
GO
ALTER TABLE [PIMS].[Employee_Reporting]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Reporting_Line] FOREIGN KEY([reporting_line_id])
REFERENCES [DBEnum].[Reporting_Line] ([reporting_line_id])
GO
ALTER TABLE [PIMS].[Employee_Reporting] CHECK CONSTRAINT [FK_Employee_Reporting_Line]
GO
ALTER TABLE [PIMS].[Employee_Reporting]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Reporting_Person] FOREIGN KEY([employee_id])
REFERENCES [PIMS].[Employee] ([employee_id])
GO
ALTER TABLE [PIMS].[Employee_Reporting] CHECK CONSTRAINT [FK_Employee_Reporting_Person]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Application_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Application_Country]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Application_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Application_District]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Application_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Application_Division]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Application_Ownership_Type] FOREIGN KEY([ownership_type_id])
REFERENCES [Administrative].[Ownership_Type] ([ownership_type_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Application_Ownership_Type]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Application_Registry_Authority] FOREIGN KEY([registry_authority_id])
REFERENCES [Administrative].[Registry_Authority] ([registry_authority_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Application_Registry_Authority]
GO
ALTER TABLE [Procurement].[Supplier_Application]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Regulator] FOREIGN KEY([regulator_id])
REFERENCES [Administrative].[Regulator] ([regulator_id])
GO
ALTER TABLE [Procurement].[Supplier_Application] CHECK CONSTRAINT [FK_Supplier_Regulator]
GO
ALTER TABLE [Procurement].[Supplier_Association]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Association_Association] FOREIGN KEY([association_id])
REFERENCES [Administrative].[Association] ([association_id])
GO
ALTER TABLE [Procurement].[Supplier_Association] CHECK CONSTRAINT [FK_Supplier_Association_Association]
GO
ALTER TABLE [Procurement].[Supplier_Association]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Association_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Association] CHECK CONSTRAINT [FK_Supplier_Association_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Bank_Account]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Bank_Account_Bank_Branch] FOREIGN KEY([bank_branch_id])
REFERENCES [Administrative].[Bank_Branch] ([bank_branch_id])
GO
ALTER TABLE [Procurement].[Supplier_Bank_Account] CHECK CONSTRAINT [FK_Supplier_Bank_Account_Bank_Branch]
GO
ALTER TABLE [Procurement].[Supplier_Bank_Account]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Bank_Account_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Bank_Account] CHECK CONSTRAINT [FK_Supplier_Bank_Account_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Card_Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Card_Transaction_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Card_Transaction] CHECK CONSTRAINT [FK_Supplier_Card_Transaction_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Contact]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact_Designation] FOREIGN KEY([designation_id])
REFERENCES [Administrative].[Designation] ([designation_id])
GO
ALTER TABLE [Procurement].[Supplier_Contact] CHECK CONSTRAINT [FK_Supplier_Contact_Designation]
GO
ALTER TABLE [Procurement].[Supplier_Contact]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Contact] CHECK CONSTRAINT [FK_Supplier_Contact_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Contact]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact_Supplier_Warehouse] FOREIGN KEY([supplier_warehouse_id])
REFERENCES [Procurement].[Supplier_Warehouse] ([supplier_warehouse_id])
GO
ALTER TABLE [Procurement].[Supplier_Contact] CHECK CONSTRAINT [FK_Supplier_Contact_Supplier_Warehouse]
GO
ALTER TABLE [Procurement].[Supplier_Contact_Location]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact_Location_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Contact_Location] CHECK CONSTRAINT [FK_Supplier_Contact_Location_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Contact_Location]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact_Location_Supplier_Location] FOREIGN KEY([supplier_location_id])
REFERENCES [Procurement].[Supplier_Location] ([supplier_location_id])
GO
ALTER TABLE [Procurement].[Supplier_Contact_Location] CHECK CONSTRAINT [FK_Supplier_Contact_Location_Supplier_Location]
GO
ALTER TABLE [Procurement].[Supplier_Credit_History]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Credit_History_Currency] FOREIGN KEY([currency_id])
REFERENCES [Administrative].[Currency] ([currency_id])
GO
ALTER TABLE [Procurement].[Supplier_Credit_History] CHECK CONSTRAINT [FK_Supplier_Credit_History_Currency]
GO
ALTER TABLE [Procurement].[Supplier_Credit_History]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Credit_History_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Credit_History] CHECK CONSTRAINT [FK_Supplier_Credit_History_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Document]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Document_Document_Type] FOREIGN KEY([document_type_id])
REFERENCES [Administrative].[Document_Type] ([document_type_id])
GO
ALTER TABLE [Procurement].[Supplier_Document] CHECK CONSTRAINT [FK_Supplier_Document_Document_Type]
GO
ALTER TABLE [Procurement].[Supplier_Document]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Document_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Document] CHECK CONSTRAINT [FK_Supplier_Document_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Ecommerce_Platforms]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Ecommerce_Platforms_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Ecommerce_Platforms] CHECK CONSTRAINT [FK_Supplier_Ecommerce_Platforms_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Info_Feedback_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Info_Feedback_Detail_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Info_Feedback_Detail] CHECK CONSTRAINT [FK_Supplier_Info_Feedback_Detail_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Location]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Location_Country] FOREIGN KEY([country_id])
REFERENCES [Administrative].[Country] ([country_id])
GO
ALTER TABLE [Procurement].[Supplier_Location] CHECK CONSTRAINT [FK_Supplier_Location_Country]
GO
ALTER TABLE [Procurement].[Supplier_Location]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Location_District] FOREIGN KEY([district_id])
REFERENCES [Administrative].[District] ([district_id])
GO
ALTER TABLE [Procurement].[Supplier_Location] CHECK CONSTRAINT [FK_Supplier_Location_District]
GO
ALTER TABLE [Procurement].[Supplier_Location]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Location_Division] FOREIGN KEY([division_id])
REFERENCES [Administrative].[Division] ([division_id])
GO
ALTER TABLE [Procurement].[Supplier_Location] CHECK CONSTRAINT [FK_Supplier_Location_Division]
GO
ALTER TABLE [Procurement].[Supplier_Mobile_Bank]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Mobile_Bank_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Mobile_Bank] CHECK CONSTRAINT [FK_Supplier_Mobile_Bank_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Security]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Security_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Security] CHECK CONSTRAINT [FK_Supplier_Security_Supplier_Application]
GO
ALTER TABLE [Procurement].[Supplier_Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Warehouse_Supplier_Application] FOREIGN KEY([supplier_id])
REFERENCES [Procurement].[Supplier_Application] ([supplier_id])
GO
ALTER TABLE [Procurement].[Supplier_Warehouse] CHECK CONSTRAINT [FK_Supplier_Warehouse_Supplier_Application]
GO
/****** Object:  StoredProcedure [Administrative].[SP_Active_Inactive_History_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md. Masud Iqbal
-- Create date: 05 Dec 2021
-- Description:	Get Activity History
-- =============================================
CREATE PROCEDURE [Administrative].[SP_Active_Inactive_History_Get]
--DECLARE
	@param_shcema_name as nvarchar(100)
	,@param_table_name as nvarchar(100)
	,@param_object_id as int

	--SET @param_shcema_name='Administrative'
	--SET @param_table_name='Company_Business_Nature'
	--SET @param_object_id=1
AS
BEGIN

	DECLARE @tbl_Activity_history AS TABLE (obj_id int, actvity varchar(50), action_time datetime, user_info_id int)

	INSERT INTO @tbl_Activity_history
	EXEC ('SELECT obj_id, CASE WHEN is_active=1 THEN ''Active'' ELSE ''Inactive'' END AS activity
	, db_server_date_time AS action_time, created_user_id FROM [Administrative].[Active_Inactive_History] 
	WHERE table_schema_name='''+@param_shcema_name+''' AND table_name='''+@param_table_name+''' AND obj_id='+@param_object_id+'')

	SELECT a.obj_id,a.actvity,a.action_time,u.[user_name] FROM @tbl_Activity_history a
	INNER JOIN Auth.User_Info u ON a.user_info_id=u.user_info_id 
	ORDER BY a.action_time
	
END

GO
/****** Object:  StoredProcedure [Administrative].[SP_Activity]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md. Masud Iqbal
-- Create date: 05 Dec 2021
-- Description:	Make an object Active or inactive and keep history
-- =============================================
CREATE PROCEDURE [Administrative].[SP_Activity]
	@param_shcema_name as nvarchar(100)
	,@param_table_name as nvarchar(100)
	,@param_object_id as int
	,@param_user_info_id as int
	,@param_remarks as nvarchar(300)
	,@param_created_datetime as datetime
AS
BEGIN TRAN

	--SET @param_shcema_name='Auth'
	--SET @param_table_name='Menu'
	--SET @param_user_info_id=7
	--SET @param_object_id=2
	--SET @param_created_datetime=GETDATE()

	DECLARE 
		@pv_company_corporate_id as int
		,@pv_company_id as int
		,@pv_is_active as bit
		,@pv_current_is_active as bit
		,@pv_object_field as nvarchar(100)
		,@pv_table_name as nvarchar(300)
		,@pv_sql as nvarchar(max)
		,@pv_active_inactive_history_id as int

	SET @pv_table_name=@param_shcema_name+'.'+@param_table_name

	--check valid user
	IF NOT EXISTS (SELECT * FROM Auth.User_Info WHERE user_info_id=@param_user_info_id and is_active=1)
	BEGIN
		ROLLBACK
			RAISERROR(N'Invalid User.',16,1);
		RETURN
	END

	--Find company corporate and company id
	SELECT @pv_company_corporate_id=u.company_corporate_id
	,@pv_company_id=u.company_id
	FROm auth.User_Info u WHERE u.user_info_id=@param_user_info_id

	--IF NOT EXISTS (SELECT * FROM Administrative.Company_Corporate WHERE company_corporate_id=@pv_company_corporate_id)
	--BEGIN
	--	ROLLBACK
	--		RAISERROR(N'Invalid User.',16,1);
	--	RETURN
	--END

	--IF NOT EXISTS (SELECT * FROM Administrative.Company WHERE company_id=@pv_company_id)
	--BEGIN
	--	ROLLBACK
	--		RAISERROR(N'Invalid User.',16,1);
	--	RETURN
	--END

	--Find object field
	SET @pv_object_field=(SELECT C.COLUMN_NAME 
						FROM  INFORMATION_SCHEMA.TABLE_CONSTRAINTS T  
						JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE C  ON C.CONSTRAINT_NAME=T.CONSTRAINT_NAME  
						WHERE  C.TABLE_NAME=@param_table_name and T.CONSTRAINT_TYPE='PRIMARY KEY' )

	IF (@pv_object_field='' OR @pv_object_field IS NULL)
	BEGIN
		ROLLBACK
			RAISERROR(N'Opps. Something went wrong. Please contact with vendor',16,1);
		RETURN
	END

	-- find the current activation
	SET @pv_sql='SELECT @pv_activity=is_active FROM '+@pv_table_name+' tbl WHERE tbl.'+@pv_object_field+'='+CONVERT(VARCHAR(50),@param_object_id)+''

	EXEC sp_executesql @pv_sql, N'@pv_activity bit out', @pv_current_is_active out
	SELECT @pv_current_is_active

	IF (@pv_current_is_active IS NULL)
	BEGIN
		ROLLBACK
			RAISERROR(N'Opps. invalid Operation. Please contact with vendor',16,1);
		RETURN
	END

	IF @pv_current_is_active=1
	BEGIN
		SET @pv_is_active=0
	END ELSE BEGIN
		SET @pv_is_active=1
	END

	--Update table
	EXEC('UPDATE '+@pv_table_name+' SET is_active= '+@pv_is_active+' WHERE '+@pv_object_field+'='+@param_object_id+'')


	--insert history
	SET @pv_active_inactive_history_id=(SELECT ISNULL(MAX(ISNULL(active_inactive_history_id,0)),0)+1 FROM Administrative.Active_Inactive_History)

	INSERT INTO [Administrative].[Active_Inactive_History]
				([active_inactive_history_id],	[table_schema_name],[table_name],		[obj_id],			[is_active],	[remarks],		[created_datetime],		[db_server_date_time],	[created_user_id],	[company_corporate_id],	[company_id])
	VALUES		(@pv_active_inactive_history_id,@param_shcema_name,	@param_table_name,	@param_object_id,	@pv_is_active,	@param_remarks,	@param_created_datetime,GETDATE(),				@param_user_info_id,@pv_company_corporate_id,@pv_company_id)



	EXEC('SELECT * FROM '+@pv_table_name+' WHERE '+@pv_object_field+'='+@param_object_id+'')


COMMIT TRAN

GO
/****** Object:  StoredProcedure [Administrative].[SP_Bank_Branch_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 1-Dec-2022
	-- Description:	This is a user delete operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Administrative].[SP_Bank_Branch_D]
@bank_branch_id INT=0
,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran

IF(@DBOperation=3 AND EXISTS(SELECT bank_branch_id FROM [Administrative].Bank_Branch WHERE bank_branch_id=@bank_branch_id))
	BEGIN
		DELETE FROM [Administrative].[Bank_Branch] WHERE bank_branch_id=@bank_branch_id
	END
			
Commit Tran
GO
/****** Object:  StoredProcedure [Administrative].[SP_Bank_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 1-Dec-2022
	-- Description:	This is a user delete operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Administrative].[SP_Bank_D]
@bank_id INT=0
,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran

IF(@DBOperation=3 AND EXISTS(SELECT bank_id FROM Administrative.Bank WHERE bank_id=@bank_id))
	BEGIN
		DELETE FROM [Administrative].[Bank] WHERE bank_id=@bank_id
	END
			
Commit Tran
GO
/****** Object:  StoredProcedure [Administrative].[SP_Bank_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 23-Dec-2021
	-- Description:	This is a bank operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Administrative].[SP_Bank_IUD]
	@bank_id INT=0
	,@bank_name NVARCHAR(100)=''
	,@bank_short_name NVARCHAR(30)=''
	,@bank_swift_code NVARCHAR(20)=''
	,@bank_email NVARCHAR(50)=''
	,@bank_web_url NVARCHAR(100)=''
	,@country_id INT=0
	,@division_id INT=0
	,@district_id INT=0
	,@city NVARCHAR(50)=''
	,@ps_area NVARCHAR(50)=''
	,@post_code NVARCHAR(50)=''
	,@block NVARCHAR(50)=''
	,@road_no NVARCHAR(50)=''
	,@house_no NVARCHAR(50)=''
	,@flat_no NVARCHAR(50)=''
	,@address_note NVARCHAR(300)=''
	,@remarks NVARCHAR(300)=''
	,@is_bank BIT=1
	,@is_active BIT=1
	,@is_local BIT=1
	,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran
Declare @db_server_date_time as datetime=GETDATE()

IF(@DBOperation=1 AND NOT EXISTS(SELECT bank_id FROM Administrative.Bank WHERE bank_id=@bank_id))
	BEGIN
	SELECT @bank_id=iSNULL(MAX(bank_id),0)+1 FROM Administrative.Bank
	--Validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Administrative.Bank WHERE bank_name=@bank_name)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Name must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Administrative.Bank WHERE bank_swift_code=@bank_swift_code)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Swift Code must be unique. Please try another mobile no.',16,1);
			RETURN
		END
    INSERT INTO [Administrative].[Bank] ([bank_id],[bank_name],[bank_short_name],[bank_swift_code],[bank_email],[bank_web_url],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[address_note],[remarks],[is_bank],[is_active],[is_local])
	VALUES (@bank_id,@bank_name, @bank_short_name, @bank_swift_code, @bank_email, @bank_web_url,@country_id, @division_id, @district_id,@city,@ps_area,@post_code,@block,@road_no,@house_no,@flat_no,@address_note,@remarks,@is_bank,@is_active,@is_local)
	END

IF(@DBOperation=2 AND EXISTS(SELECT bank_id FROM Administrative.Bank WHERE bank_id=@bank_id))
        --Validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Administrative.Bank WHERE bank_name=@bank_name AND bank_id<>@bank_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Name must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Administrative.Bank WHERE bank_swift_code=@bank_swift_code AND bank_id<>@bank_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Swift Code must be unique. Please try another mobile no.',16,1);
			RETURN
		END


BEGIN
        UPDATE [Administrative].[Bank] SET [bank_name]=@bank_name,[bank_short_name]=@bank_short_name,
[bank_swift_code]=@bank_swift_code,[bank_email]=@bank_email,[bank_web_url]=@bank_web_url,[country_id]=@country_id,[division_id]=@division_id,[district_id]=@district_id,[city]=@city,[ps_area]=@ps_area,[post_code]=@post_code,[block]=@block,[road_no]=@road_no,[house_no]=@house_no,[flat_no]=@flat_no,[address_note]=@address_note,[remarks]=@remarks,[is_bank]=@is_bank,[is_active]=@is_active,[is_local]=@is_local
		WHERE bank_id=@bank_id
	END


SELECT B.*,C.country_name,dv.division_name,ds.district_name
FROM [Administrative].[Bank] B 
left join[Administrative].[Country] C on B.country_id = C.country_id 
left join[Administrative].[Division] DV on B.division_id = DV.division_id 
left join[Administrative].[District] DS on B.district_id = DS.district_id 
WHERE [bank_id]=@bank_id
	
	
Commit Tran


GO
/****** Object:  StoredProcedure [Administrative].[SP_BankBranch_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 27-Dec-2021
	-- Description:	This is a bank operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Administrative].[SP_BankBranch_IUD]
	 @bank_branch_id INT=0
	,@bank_branch_name NVARCHAR(100)=''
	,@bank_branch_short_name NVARCHAR(30)=''
	,@bank_branch_routing NVARCHAR(20)=''
	,@bank_id INT=0
	,@bank_branch_contact_number NVARCHAR(50)=''
	,@bank_branch_email NVARCHAR(100)=''
	,@country_id INT=0
	,@division_id INT=0
	,@district_id INT=0
	,@city NVARCHAR(50)=''
	,@ps_area NVARCHAR(50)=''
	,@post_code NVARCHAR(50)=''
	,@block NVARCHAR(50)=''
	,@road_no NVARCHAR(50)=''
	,@house_no NVARCHAR(50)=''
	,@flat_no NVARCHAR(50)=''
	,@address_note NVARCHAR(300)=''
	,@remarks NVARCHAR(300)=''
	,@is_branch BIT=1
	,@is_active BIT=1
	,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran
Declare @db_server_date_time as datetime=GETDATE()

IF(@DBOperation=1 AND NOT EXISTS(SELECT bank_branch_id FROM Administrative.Bank_Branch WHERE bank_branch_id=@bank_branch_id))
	BEGIN
	SELECT @bank_branch_id=iSNULL(MAX(bank_branch_id),0)+1 FROM Administrative.Bank_Branch
	--Validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Administrative.Bank_Branch WHERE bank_branch_name=@bank_branch_name)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Branch Name must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Administrative.Bank_Branch WHERE bank_branch_routing=@bank_branch_routing)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Branch Routing must be unique. Please try another mobile no.',16,1);
			RETURN
		END
    INSERT INTO [Administrative].[Bank_Branch] ([bank_branch_id],[bank_branch_name],[bank_branch_short_name],[bank_branch_routing],[bank_id],[bank_branch_contact_number],[bank_branch_email],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[address_note],[remarks],[is_branch],[is_active])
	VALUES (@bank_branch_id,@bank_branch_name, @bank_branch_short_name, @bank_branch_routing, @bank_id, @bank_branch_contact_number,@bank_branch_email,@country_id, @division_id, @district_id,@city,@ps_area,@post_code,@block,@road_no,@house_no,@flat_no,@address_note,@remarks,@is_branch,@is_active)
	END

IF(@DBOperation=2 AND EXISTS(SELECT bank_branch_id FROM Administrative.Bank_Branch WHERE bank_branch_id=@bank_branch_id))
	    --Validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Administrative.Bank_Branch WHERE bank_branch_name=@bank_branch_name AND bank_branch_id<>@bank_branch_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Branch Name must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Administrative.Bank_Branch WHERE bank_branch_routing=@bank_branch_routing AND bank_branch_id<>@bank_branch_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Bank Branch Routing must be unique. Please try another mobile no.',16,1);
			RETURN
		END


BEGIN
        UPDATE [Administrative].[Bank_Branch] SET [bank_branch_name]=@bank_branch_name,[bank_branch_short_name]=@bank_branch_short_name,
[bank_branch_routing]=@bank_branch_routing,[bank_id]=@bank_id,[bank_branch_contact_number]=@bank_branch_contact_number,[bank_branch_email]=@bank_branch_email,[country_id]=@country_id,[division_id]=@division_id,[district_id]=@district_id,[city]=@city,[ps_area]=@ps_area,[post_code]=@post_code,[block]=@block,[road_no]=@road_no,[house_no]=@house_no,[flat_no]=@flat_no,[address_note]=@address_note,[remarks]=@remarks,[is_branch]=@is_branch,[is_active]=@is_active
		WHERE bank_branch_id=@bank_branch_id
	END

	
SELECT BB.*,C.country_name,dv.division_name,ds.district_name,B.bank_name
FROM [Administrative].[Bank_Branch] BB 
left join[Administrative].[Bank] B on BB.bank_id = B.bank_id 
left join[Administrative].[Country] C on BB.country_id = C.country_id 
left join[Administrative].[Division] DV on BB.division_id = DV.division_id 
left join[Administrative].[District] DS on BB.district_id = DS.district_id 
WHERE bank_branch_id=@bank_branch_id

	
Commit Tran


GO
/****** Object:  StoredProcedure [Administrative].[SP_Organogram_Detail_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Masum Billah
	-- Create date: 31-Mar-2022
	-- Description:	For Insert,Update And Delete
	-- =============================================
	DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec [Administrative].[SP_Organogram_Detail_IUD]
3,--id
2,--o
'003',--code
2,--p
5,--mmp
15,--xmp
5,--mb
15,--xb
1,--mye
10,--xye
1,--op
10,--ipy
100,--gss
1,--sh
1,--act
90,--cd
1,--ui
4--addeditdelete
 -- entry

select *from Administrative.Organogram_Detail ogd
*/  
--drop procedure [Administrative].[SP_administrative_Organogram_IUD]
CREATE PROCEDURE [Administrative].[SP_Organogram_Detail_IUD]
@param_organogram_detail_id int=0,
@param_organogram_id int=0,
@param_code nvarchar(20)='',
@param_position_id int=0
,@param_min_no_of_manpower int=0
,@param_max_no_of_manpower int=0
,@param_min_budget decimal=0
,@param_max_budget decimal=0
,@param_min_year_of_experience INT=0
,@param_max_year_of_experience INT=0
,@param_is_open INT=0
,@param_increment_percentage_yearly decimal=0
,@param_is_gross int=0
,@param_salary_head_id INT=0
,@param_is_active INT=0
,@param_days_of_confirmation INT=0
,@param_created_user_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     declare @IsApprove NVARCHAR(100);
	IF (@param_DBOperation=1)
	BEGIN 
        	--Duplicate checking
        IF (EXISTS (SELECT position_id FROM Administrative.Organogram_Detail ogd WHERE position_id=@param_position_id and  ogd.organogram_id=@param_organogram_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Organogram Position must be unique. Please try another.',16,1);
			RETURN
		END 
        SET @param_organogram_detail_id= (SELECT ISNULL(MAX(ISNULL(organogram_detail_id,0)),0)+1 from Administrative.Organogram_Detail)		
		
		IF NOT EXISTS (SELECT organogram_detail_id FROM Administrative.Organogram_Detail ogd WHERE ogd.organogram_detail_id=@param_organogram_detail_id)
		BEGIN
			INSERT INTO Administrative.Organogram_Detail 
                       (
					   organogram_detail_id,
					   organogram_id,
					   code,
					   position_id,			  
					   min_no_of_manpower,		   
					   max_no_of_manpower ,       
					   min_budget,       
					   max_budget,                  
					   min_year_of_experience,                  
					   max_year_of_experience,
					   is_open,
					   increment_percentage_yearly,
					   is_gross,
					   salary_head_id,
					   is_active,
					   days_of_confirmation,
					   created_user_id,
					   db_server_date_time)
		    VALUES	   (@param_organogram_detail_id,
						@param_organogram_id,
						@param_code,
						@param_position_id, 
						@param_min_no_of_manpower, 
						@param_max_no_of_manpower,
						@param_min_budget,
						@param_max_budget,
						@param_min_year_of_experience,
						@param_max_year_of_experience,
						@param_is_open,
						@param_increment_percentage_yearly,
						@param_is_gross,
						@param_salary_head_id,
						@param_is_active,
						@param_days_of_confirmation,
						@param_created_user_id,
						GETDATE())
		END		
	END ----Data Inserted Begin End 
	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking		
		SELECT @IsApprove= isnull(approve_user_id,'0') FROM Administrative.Organogram_Detail ogd WHERE ogd.organogram_detail_id=@param_organogram_detail_id;
	IF (@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'Already Approved! you can not delete.',16,1);
			RETURN
		END
		DELETE FROM Administrative.Organogram WHERE organogram_id=@param_organogram_detail_id
		--end      
	END
	IF (@param_DBOperation=4)--Approval
	BEGIN	
	SELECT @IsApprove= isnull(approve_user_id,'0') FROM Administrative.Organogram_Detail ogd WHERE ogd.organogram_detail_id=@param_organogram_detail_id;
	IF (@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'Already Approved!',16,1);
			RETURN
		END
		UPDATE Administrative.Organogram_Detail SET 			
			approve_user_id=@param_created_user_id,
			approve_date_time=GETDATE()
			WHERE organogram_detail_id=@param_organogram_detail_id;		
		--end	      
	END
	 SELECT * FROM Administrative.Organogram_Detail WHERE organogram_id=@param_organogram_id
COMMIT TRAN


GO
/****** Object:  StoredProcedure [Administrative].[SP_Organogram_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Masum Billah
	-- Create date: 30-Mar-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

	DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec [Administrative].[SP_Organogram_IUD]3,'003',1,1,1,1,2,1,1,1,0,3,1 -- entry
exec [Administrative].[SP_Organogram_IUD]1,'001',1,1,1,1,1,0,1,1,0,3,1 -- Update
exec [Administrative].[SP_Organogram_IUD]2,'001',1,1,1,1,1,0,1,1,0,3,4 -- Approve
exec [Administrative].[SP_Organogram_IUD]3,'001',1,1,1,1,1,0,1,1,0,3,3 -- Delete
select *from Administrative.Organogram og
*/  
--drop procedure [Administrative].[SP_administrative_Organogram_IUD]
CREATE PROCEDURE [Administrative].[SP_Organogram_IUD]
@param_administrative_organogram_id int=0
,@param_administrative_organogram_code NVARCHAR(20)=''
,@param_company_group_id INT=0
,@param_company_corporate_id INT=0
,@param_company_id INT=0
,@param_organogram_location_id INT=0
,@param_organogram_department_id INT=0
,@param_organogram_parrent_id INT=0
,@param_organogram_sorting_priority INT=0
,@param_organogram_is_active INT=0
,@param_organogram_approve_user_id INT=0
,@param_created_user_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     declare @IsApprove NVARCHAR(100);    

	IF (@param_DBOperation=1)
	BEGIN
	
        	--Duplicate checking
        IF (EXISTS (SELECT organogram_code FROM Administrative.Organogram og WHERE Upper(organogram_code)=Upper(@param_administrative_organogram_code) and  og.company_corporate_id=@param_company_corporate_id and og.company_group_id=@param_company_group_id and  og.company_id= @param_company_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Organogram code must be unique. Please try another code.',16,1);
			RETURN
		END

       IF (EXISTS (SELECT organogram_code FROM Administrative.Organogram og WHERE og.company_corporate_id=@param_company_corporate_id and og.company_group_id=@param_company_group_id and  og.company_id= @param_company_id and location_id=@param_organogram_location_id and department_id=@param_organogram_department_id )) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Organogram location wise department must be unique. Please try another.',16,1);
			RETURN
		END

        SET @param_administrative_organogram_id= (SELECT ISNULL(MAX(ISNULL(organogram_id,0)),0)+1 from Administrative.Organogram)		
		
		IF NOT EXISTS (SELECT organogram_id FROM Administrative.Organogram og WHERE og.organogram_id=@param_administrative_organogram_id)
		BEGIN
			INSERT INTO Administrative.Organogram 
                       (organogram_id,			  
					   organogram_code,			  
					   company_corporate_id,		   
					   company_group_id ,       
					   company_id,       
					   location_id,                  
					   department_id,                  
					   parent_id,
					   sorting_priority,
					   is_active,
					   created_user_id,
					   db_server_date_time)
		    VALUES	   (@param_administrative_organogram_id,
						@param_administrative_organogram_code,
						@param_company_corporate_id, 
						@param_company_group_id, 
						@param_company_id,
						@param_organogram_location_id,
						@param_organogram_department_id,
						@param_organogram_parrent_id,
						@param_organogram_sorting_priority,
						@param_organogram_is_active,
						@param_created_user_id,
						GETDATE())
		END		
	END ----Data Inserted Begin End    
    IF (@param_DBOperation=2)
	BEGIN
			--Duplicate checking			
        IF (EXISTS (SELECT organogram_code FROM Administrative.Organogram og WHERE upper(organogram_code)=upper(@param_administrative_organogram_code) and  og.company_corporate_id=@param_company_corporate_id and og.company_group_id=@param_company_group_id and  og.company_id= @param_company_id and  organogram_id<>@param_administrative_organogram_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Organogram Code must be unique. Please try another code.',16,1);
			RETURN
		END
		 IF (EXISTS (SELECT organogram_code FROM Administrative.Organogram og WHERE  og.company_corporate_id=@param_company_corporate_id and og.company_group_id=@param_company_group_id and  og.company_id= @param_company_id and location_id=@param_organogram_location_id and department_id=@param_organogram_department_id and organogram_id<>@param_administrative_organogram_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Organogram location wise department must be unique. Please try another.',16,1);
			RETURN
		END

		SELECT @IsApprove= isnull(approve_user_id,'0') FROM Administrative.Organogram og WHERE og.organogram_id=@param_administrative_organogram_id;

	IF (@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'Already Approved! you can not update.',16,1);
			RETURN
		END


		--Validation chaecking
		if (@param_administrative_organogram_id=0)
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Select Organogram.',16,1);
			RETURN
			END
			UPDATE Administrative.Organogram SET 
			location_id=@param_organogram_location_id ,
			department_id=@param_organogram_department_id,
			parent_id=@param_organogram_parrent_id,
			sorting_priority=@param_organogram_sorting_priority,
			is_active=@param_organogram_is_active
			WHERE organogram_id=@param_administrative_organogram_id;
		
		
	END----Data Updated Begin End


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		--IF EXISTS (SELECT * FROM administrative.administrative_employee_Companay rm WHERE rm.administrative_employee_id=@param_administrative_employee_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in administrative employee Company.',16,1);
		--	RETURN
		--END
		SELECT @IsApprove= isnull(approve_user_id,'0') FROM Administrative.Organogram og WHERE og.organogram_id=@param_administrative_organogram_id;

	IF (@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'Already Approved! you can not delete.',16,1);
			RETURN
		END
		DELETE FROM Administrative.Organogram WHERE organogram_id=@param_administrative_organogram_id
		--end	
      
	END
	IF (@param_DBOperation=4)--Approval
	BEGIN
	
	SELECT @IsApprove= isnull(approve_user_id,'0') FROM Administrative.Organogram og WHERE og.organogram_id=@param_administrative_organogram_id;

	IF (@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'Already Approved!',16,1);
			RETURN
		END

		UPDATE Administrative.Organogram SET 			
			approve_user_id=@param_created_user_id,
			approve_date_time=GETDATE()
			WHERE organogram_id=@param_administrative_organogram_id;
		
		--end	
      
	END

	 SELECT * FROM Administrative.Organogram WHERE organogram_id=@param_administrative_organogram_id
--	select c.company_name,location_code,location_name,(select d.department_name from Administrative.Department d where d.department_id=og.department_id)as department,og.department_id,og.location_id,c.company_id from Administrative.Location l left join Administrative.Company c on l.company_id=c.company_id
--left join Administrative.Organogram og on l.location_id=og.location_id where l.company_id=@param_company_id and l.company_corporate_id=@param_company_corporate_id and l.company_group_id=@param_company_group_id;
    
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[Roster_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 12-Mar-2022
	-- Description:	This is a Roster Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[Roster_Policy_IUD]
 @param_roster_policy_id INT=0
,@param_roster_policy_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_roster_cycle INT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT roster_policy_name FROM Attendance.Roster_Policy WHERE roster_policy_name=@param_roster_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT roster_policy_name FROM Attendance.Roster_Policy WHERE roster_policy_name=@param_roster_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_roster_policy_id= (SELECT ISNULL(MAX(ISNULL(roster_policy_id,0)),0)+1 from Attendance.Roster_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_roster_policy_id)

		IF NOT EXISTS (SELECT roster_policy_id FROM Attendance.Roster_Policy M WHERE m.roster_policy_id=@param_roster_policy_id)
		BEGIN
			INSERT INTO Attendance.Roster_Policy 
                       (roster_policy_id       ,roster_policy_name       ,code       ,roster_cycle  ,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_roster_policy_id,@param_roster_policy_name,@param_code,@param_roster_cycle,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT roster_policy_name FROM Attendance.Roster_Policy WHERE roster_policy_name=@param_roster_policy_name AND company_group_id=@param_company_group_id AND roster_policy_id<>@param_roster_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT roster_policy_name FROM Attendance.Roster_Policy WHERE roster_policy_name=@param_roster_policy_name AND company_id=@param_company_id AND roster_policy_id<>@param_roster_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT roster_policy_id FROM Attendance.Roster_Policy M WHERE m.roster_policy_id=@param_roster_policy_id)
		BEGIN
			UPDATE Attendance.Roster_Policy SET 
			 roster_policy_name=@param_roster_policy_name
            ,roster_cycle= @param_roster_cycle
            
           
          WHERE roster_policy_id=@param_roster_policy_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Roster_Policy_Detail rm WHERE rm.roster_policy_id=@param_roster_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in roster details.',16,1);
			RETURN
		END
	 
	
		
		--Delete  Shift_Info
		
    DELETE FROM Attendance.Roster_Policy WHERE roster_policy_id=@param_roster_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT roster_policy_id FROM Attendance.Roster_Policy M WHERE m.roster_policy_id=@param_roster_policy_id)
		BEGIN
			UPDATE Attendance.Roster_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE roster_policy_id=@param_roster_policy_id
		END
	END

		  SELECT S.roster_policy_id,S.roster_policy_name,CAST (s.roster_cycle as varchar)+' '+'Days'roster_cycle, 
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
          ,s.is_active
		  FROM Attendance.Roster_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
		  WHERE  roster_policy_id=@param_roster_policy_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Absenteeism_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 13-FEB-2022
	-- Description:	This is a Absenteeism Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Absenteeism_Policy_IUD]
 @param_absenteeism_policy_id INT=0
,@param_absenteeism_policy_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_remarks NVARCHAR(500)=''
,@param_is_leave_adjustment BIT=0
,@param_salary_head_id INT=0
,@param_percent_value INT=0
,@param_is_gross BIT=0
,@param_basic_salary_head_id INT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT absenteeism_policy_name FROM Attendance.Absenteeism_Policy WHERE absenteeism_policy_name=@param_absenteeism_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT absenteeism_policy_name FROM Attendance.Absenteeism_Policy WHERE absenteeism_policy_name=@param_absenteeism_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_absenteeism_policy_id= (SELECT ISNULL(MAX(ISNULL(absenteeism_policy_id,0)),0)+1 from Attendance.Absenteeism_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_absenteeism_policy_id)

		IF NOT EXISTS (SELECT absenteeism_policy_id FROM Attendance.Absenteeism_Policy M WHERE m.absenteeism_policy_id=@param_absenteeism_policy_id)
		BEGIN
			INSERT INTO Attendance.Absenteeism_Policy 
                       (absenteeism_policy_id       ,absenteeism_policy_name       ,code       ,remarks       ,is_leave_adjustment       ,salary_head_id       ,percent_value,       is_gross       ,basic_salary_head_id       ,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_absenteeism_policy_id,@param_absenteeism_policy_name,@param_code,@param_remarks,@param_is_leave_adjustment,@param_salary_head_id,@param_percent_value,@param_is_gross,@param_basic_salary_head_id,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT absenteeism_policy_name FROM Attendance.Absenteeism_Policy WHERE absenteeism_policy_name=@param_absenteeism_policy_name AND company_group_id=@param_company_group_id AND absenteeism_policy_id<>@param_absenteeism_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT absenteeism_policy_name FROM Attendance.Absenteeism_Policy WHERE absenteeism_policy_name=@param_absenteeism_policy_name AND company_id=@param_company_id AND absenteeism_policy_id<>@param_absenteeism_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT absenteeism_policy_id FROM Attendance.Absenteeism_Policy M WHERE m.absenteeism_policy_id=@param_absenteeism_policy_id)
		BEGIN
			UPDATE Attendance.Absenteeism_Policy SET 
			 absenteeism_policy_name=@param_absenteeism_policy_name
            ,remarks= @param_remarks
            ,is_leave_adjustment=@param_is_leave_adjustment
            ,salary_head_id=@param_salary_head_id
            ,percent_value=@param_percent_value
            ,is_gross=@param_is_gross
            ,basic_salary_head_id=@param_basic_salary_head_id
           
          WHERE absenteeism_policy_id=@param_absenteeism_policy_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		--IF EXISTS (SELECT * FROM Attendance.Absenteeism_Policy_Company rm WHERE rm.absenteeism_policy_id=@param_absenteeism_policy_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in Shift Company.',16,1);
		--	RETURN
		--END
	 
	
		
		--Delete  Shift_Info
		
    DELETE FROM Attendance.Absenteeism_Policy WHERE absenteeism_policy_id=@param_absenteeism_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT absenteeism_policy_id FROM Attendance.Absenteeism_Policy M WHERE m.absenteeism_policy_id=@param_absenteeism_policy_id)
		BEGIN
			UPDATE Attendance.Absenteeism_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE absenteeism_policy_id=@param_absenteeism_policy_id
		END
	END

		  SELECT S.absenteeism_policy_id,S.absenteeism_policy_name,is_leave_adjustment,CASE WHEN (salary_head_id>0) THEN (Convert(varchar,percent_value)+ ' % of ' +CASE WHEN (is_gross=1) THEN 'Gross'  ELSE 'Basic' End) ELSE '' END salary_adjustment,
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
		  FROM Attendance.Absenteeism_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
		  WHERE  absenteeism_policy_id=@param_absenteeism_policy_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_All_Absenteeism_Policy_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 13-Feb-2022
	-- Description:	This is a Absenteeism Policy Get store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_All_Absenteeism_Policy_Get]
	@param_company_group_id	as int,
    @param_company_id as int
AS
BEGIN
  DECLARE @pv_is_shared BIT
  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy

  SELECT S.absenteeism_policy_id,S.absenteeism_policy_name,is_leave_adjustment,CASE WHEN (salary_head_id>0) THEN (Convert(varchar,percent_value)+ ' % of ' +CASE WHEN (is_gross=1) THEN 'Gross'  ELSE 'Basic' End) ELSE '' END salary_adjustment,  
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
		  FROM Attendance.Absenteeism_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
		  WHERE   S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
		  AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END 
          ORDER BY S.absenteeism_policy_id DESC
END



GO
/****** Object:  StoredProcedure [Attendance].[SP_All_Attendance_Benefit_Policy_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 07-Feb-2022
	-- Description:	This is a  Benefit Policy Get store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_All_Attendance_Benefit_Policy_Get]
	@param_company_group_id	as int,
    @param_company_id as int
AS
BEGIN
  DECLARE @pv_is_shared BIT
  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy

  SELECT S.abp_id,S.abp_name,s.benefit_work_on_id_enum,s.is_active,minimum_working_hour_min/60 minimum_working_hour_min,
  CASE When(OT_policy_id!=0 AND leave_head_id!=0) then 'Allow OT,' When(OT_policy_id!=0 AND leave_head_id=0) THEN 'Allow OT' else '' end +''+  Case When( leave_head_id!=0 AND salary_head_id!=0) then 'Allow Leave,' When( leave_head_id!=0 AND salary_head_id=0) THEN 'Allow Leave' else '' end  +''+   Case When(salary_head_id!=0) then 'Allow Monetary' else '' end as benefit,
  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
  FROM [Attendance].Attendance_Benefit_Policy s
  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
  WHERE   S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
  AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END
  ORDER BY S.abp_id DESC
END



GO
/****** Object:  StoredProcedure [Attendance].[SP_All_Shift_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 30-Jan-2022
	-- Description:	This is a Shift Get store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_All_Shift_Get]
	@param_company_group_id	as int,
    @param_company_id as int
AS
BEGIN
  DECLARE @pv_is_shared BIT
  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy

  SELECT S.shift_id,S.shift_name,s.shift_type_id_enum,s.is_active,CONVERT(varchar(5), day_start)+'-'+ CONVERT(varchar(5), day_end) day_time,
  CONVERT(varchar(5), [shift_start])+'-'+ CONVERT(varchar(5), [shift_end]) shift_time,
  CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then 'L'+'-'+CONVERT(varchar, late_tolerance_min) ELSE '' end +''+ CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then ', E'+'-'+CONVERT(varchar, early_tolerance_min) else ''end as tollerence,
  CASE When(is_allow_half_day=1) then 'Allow Half Day' else '' end +''+  Case When(OT_policy_id is not null or OT_policy_id!=0) then ', Allow OT' else '' end  +''+   Case When(attendance_benefit_policy_id is not null or attendance_benefit_policy_id!=0) then ', Allow Benefit' else '' end+''+   Case When(sb.shift_break_head_id is not null or sb.shift_break_head_id!=0) then ', Allow Break' else '' end as OtherInfo,
  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
  FROM [Attendance].[Shift_Info] s
  LEFT join  [Attendance].Shift_Break_Duration sb on s.shift_id=sb.shift_id
  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
  WHERE   S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
 AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END
END



GO
/****** Object:  StoredProcedure [Attendance].[SP_All_Shift_Get_By_Filtering]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 1-Feb-2022
	-- Description:	This is a Shift create and update and delete store procedure.
	-- =============================================

*/
-- exec [Attendance].[SP_All_Shift_Get_By_Filtering] 1,97,0,0,1,0,0,0,'tt',null,null,1,1,0

CREATE PROCEDURE [Attendance].[SP_All_Shift_Get_By_Filtering]
	@param_shift_type_id_enum	as int='%',
    @param_time_zone_id	as int,
    @param_attendance_count	as int,
    @param_is_allow_half_day	as bit,
    @param_is_inactive	as bit,
    @param_is_allow_OT	as bit,
    @param_is_allow_benifit	as bit,
    @param_is_night_shift	as bit,
    @param_shift_name as NVARCHAR(50),
    @param_shift_start as time,
    @param_shift_end as time,
    @param_company_group_id	as int,
    @param_company_id	as int,
    @param_isAdvanceSearch as bit
AS
BEGIN
  DECLARE @pv_is_shared BIT


  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
        	--Duplicate checking
 IF(@param_isAdvanceSearch=1)
 BEGIN
		SELECT S.shift_id,S.shift_name,s.shift_type_id_enum,s.is_active,CONVERT(varchar(5), day_start)+'-'+ CONVERT(varchar(5), day_end) day_time,
		CONVERT(varchar(5), [shift_start])+'-'+ CONVERT(varchar(5), [shift_end]) shift_time,
		CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then 'L'+'-'+CONVERT(varchar, late_tolerance_min) ELSE '' end +''+ CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then ', E'+'-'+CONVERT(varchar, early_tolerance_min) else ''end as tollerence,
		CASE When(is_allow_half_day=1) then 'Allow Half Day' else '' end +''+  Case When(OT_policy_id is not null or OT_policy_id!=0) then ', Allow OT' else '' end  +''+   Case When(attendance_benefit_policy_id is not null or attendance_benefit_policy_id!=0) then ', Allow Benefit' else '' end+''+   Case When(sb.shift_break_head_id is not null or sb.shift_break_head_id!=0) then ', Allow Break' else '' end as OtherInfo,
		CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
		FROM [Attendance].[Shift_Info] s
		LEFT join  [Attendance].Shift_Break_Duration sb on s.shift_id=sb.shift_id
		LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id
		WHERE S.shift_name LIKE @param_shift_name
			AND shift_type_id_enum = @param_shift_type_id_enum
			And s.is_allow_half_day = case when(@param_is_allow_half_day=1) then 1 else S.is_allow_half_day end 
			And attendance_count = @param_attendance_count
			And s.is_day_crossing = case when(@param_is_night_shift=1) then 1 else S.is_day_crossing end 
			And s.is_active = case when(@param_is_inactive=1) then 0 else 1 end 
			AND s.OT_policy_id = case when(@param_is_allow_OT=0) then s.OT_policy_id else 0 end 
			AND attendance_benefit_policy_id = case when(@param_is_allow_benifit=0) then s.attendance_benefit_policy_id else 0 end 
			AND S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
			AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END
			AND CONVERT(varchar(5),shift_start)=Isnull(@param_shift_start,S.shift_start)
			AND CONVERT(varchar(5),s.shift_end)=Isnull(@param_shift_end,CONVERT(varchar(5),s.shift_end))

END
ELSE
BEGIN
SELECT S.shift_id,S.shift_name,s.shift_type_id_enum,s.is_active,CONVERT(varchar(5), day_start)+'-'+ CONVERT(varchar(5), day_end) day_time,
	  CONVERT(varchar(5), [shift_start])+'-'+ CONVERT(varchar(5), [shift_end]) shift_time,
	  CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then 'L'+'-'+CONVERT(varchar, late_tolerance_min) ELSE '' end +''+ CASE WHEN(early_tolerance_min is not null or early_tolerance_min !='' ) Then ', E'+'-'+CONVERT(varchar, early_tolerance_min) else ''end as tollerence,
	  CASE When(is_allow_half_day=1) then 'Allow Half Day' else '' end +''+  Case When(OT_policy_id is not null or OT_policy_id!=0) then ', Allow OT' else '' end  +''+   Case When(attendance_benefit_policy_id is not null or attendance_benefit_policy_id!=0) then ', Allow Benefit' else '' end+''+   Case When(sb.shift_break_head_id is not null or sb.shift_break_head_id!=0) then ', Allow Break' else '' end as OtherInfo,
	  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
	  FROM [Attendance].[Shift_Info] s
	  LEFT join  [Attendance].Shift_Break_Duration sb on s.shift_id=sb.shift_id
	  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id
      WHERE S.shift_name LIKE @param_shift_name
      And s.is_day_crossing = case when(@param_is_night_shift=1) then 1 else 0 end 
      AND S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
      AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END
 

END
END



GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Benefit_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 06-fEB-2022
	-- Description:	This is a Attendance Benifit Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Attendance_Benefit_Policy_IUD]
 @param_abp_id INT=0
,@param_abp_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_benefit_work_on_id_enum INT=0
,@param_remarks NVARCHAR(300)=''
,@param_minimum_working_hour_min INT=0
,@param_holiday_id BIT=0
,@param_OT_policy_id INT=0
,@param_time_start time=''
,@param_time_end time=''
,@param_leave_head_id INT=0
,@param_leave_amount INT=0
,@param_leave_expire_day INT=0
,@param_salary_head_id INT=0
,@param_fixed_value decimal=0
,@param_percent_value INT=0
,@param_is_gross BIT=0
,@param_basic_salary_head_id INT=0
,@param_is_calculate_per_working_hour BIT =0
,@param_is_effect_on_payroll BIT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT abp_name FROM Attendance.Attendance_Benefit_Policy WHERE abp_name=@param_abp_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT abp_name FROM Attendance.Attendance_Benefit_Policy WHERE abp_name=@param_abp_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_abp_id= (SELECT ISNULL(MAX(ISNULL(abp_id,0)),0)+1 from Attendance.Attendance_Benefit_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_abp_id)

		IF NOT EXISTS (SELECT abp_id FROM Attendance.Attendance_Benefit_Policy M WHERE m.abp_id=@param_abp_id)
		BEGIN
			INSERT INTO Attendance.Attendance_Benefit_Policy 
                       (abp_id       ,abp_name       ,code       ,benefit_work_on_id_enum            ,remarks       ,minimum_working_hour_min  ,time_start       ,time_end       ,holiday_id       ,OT_policy_id      ,leave_head_id       ,leave_amount        ,leave_expire_day       ,salary_head_id       ,fixed_value      ,percent_value,is_gross              ,basic_salary_head_id,is_calculate_per_working_hour               ,is_effect_on_payroll,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_abp_id,@param_abp_name,@param_code,@param_benefit_work_on_id_enum,@param_remarks,@param_minimum_working_hour_min,@param_time_start,@param_time_end,@param_holiday_id,@param_OT_policy_id,@param_leave_head_id,@param_leave_amount,@param_leave_expire_day,@param_salary_head_id,@param_fixed_value,@param_percent_value,@param_is_gross,@param_basic_salary_head_id,@param_is_calculate_per_working_hour,@param_is_effect_on_payroll,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT abp_name FROM Attendance.Attendance_Benefit_Policy WHERE abp_name=@param_abp_name AND company_group_id=@param_company_group_id AND abp_id<>@param_abp_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT abp_name FROM Attendance.Attendance_Benefit_Policy WHERE abp_name=@param_abp_name AND company_id=@param_company_id AND abp_id<>@param_abp_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT abp_id FROM Attendance.Attendance_Benefit_Policy M WHERE m.abp_id=@param_abp_id)
		BEGIN
			UPDATE Attendance.Attendance_Benefit_Policy SET 
			 abp_name=@param_abp_name
            ,minimum_working_hour_min=@param_minimum_working_hour_min
		    ,remarks= @param_remarks
            ,time_start=@param_time_start
            ,time_end=@param_time_end
            ,holiday_id=@param_holiday_id
            ,OT_policy_id=@param_OT_policy_id
            ,leave_head_id=@param_leave_head_id
            ,salary_head_id=@param_salary_head_id
            ,leave_amount=@param_leave_amount
            ,leave_expire_day=@param_leave_expire_day
            ,fixed_value=@param_fixed_value
            ,percent_value=@param_percent_value
            ,is_gross=@param_is_gross
            ,basic_salary_head_id=@param_basic_salary_head_id
            ,is_calculate_per_working_hour=@param_is_calculate_per_working_hour
            ,is_effect_on_payroll=@param_is_effect_on_payroll
          WHERE abp_id=@param_abp_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Attendance_Benefit_Policy_Company rm WHERE rm.abp_id=@param_abp_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Shift Company.',16,1);
			RETURN
		END
	 --  IF EXISTS (SELECT * FROM Attendance.Shift_Break_Duration rm WHERE rm.shift_id=@param_shift_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in Shift Break Duration.',16,1);
		--	RETURN
		--END
	
		
		--Delete  Shift_Info
		
    DELETE FROM Attendance.Attendance_Benefit_Policy WHERE abp_id=@param_abp_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT abp_id FROM Attendance.Attendance_Benefit_Policy M WHERE m.abp_id=@param_abp_id)
		BEGIN
			UPDATE Attendance.Attendance_Benefit_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE abp_id=@param_abp_id
		END
	END

		  SELECT S.abp_id,S.abp_name,s.benefit_work_on_id_enum,s.is_active,minimum_working_hour_min/60 minimum_working_hour_min,
		  CASE When(OT_policy_id!=0 AND leave_head_id!=0) then 'Allow OT,' When(OT_policy_id!=0 AND leave_head_id=0) THEN 'Allow OT' else '' end +''+  Case When( leave_head_id!=0 AND salary_head_id!=0) then 'Allow Leave,' When( leave_head_id!=0 AND salary_head_id=0) THEN 'Allow Leave' else '' end  +''+   Case When(salary_head_id!=0) then 'Allow Monetary' else '' end as benefit,
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy,s.is_active
		  FROM [Attendance].Attendance_Benefit_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
		  WHERE abp_id=@param_abp_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Calendar_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 11-Jan-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/
--exec [Attendance].[SP_Attendance_Calendar_IUD] 
--DROP PROCEDURE [Attendance].[SP_Attendance_Calendar_IUD]
CREATE PROCEDURE [Attendance].[SP_Attendance_Calendar_IUD]
@param_attendance_calendar_id INT=0
,@param_attendance_calendar_name NVARCHAR(100)=''
,@param_is_active BIT=1
,@param_remarks NVARCHAR(300)=''
,@param_created_user_info_id INT=0
,@param_company_group_id INT=0
,@param_company_corporate_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
    DECLARE @pv_is_shared BIT
    SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
	IF (@param_DBOperation=1)
	BEGIN
		
        	--Duplicate checking
        
		
        IF (@pv_is_shared=1 AND EXISTS (SELECT attendance_calendar_name FROM Attendance.Attendance_Calendar WHERE attendance_calendar_name=@param_attendance_calendar_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Calendar name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT attendance_calendar_name FROM Attendance.Attendance_Calendar WHERE attendance_calendar_name=@param_attendance_calendar_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Calendar name must be unique. Please try another name.',16,1);
			RETURN
		END

        SET @param_attendance_calendar_id= (SELECT ISNULL(MAX(ISNULL(attendance_calendar_id,0)),0)+1 from Attendance.Attendance_Calendar)

		
		IF NOT EXISTS (SELECT attendance_calendar_id FROM Attendance.Attendance_Calendar M WHERE m.attendance_calendar_id=@param_attendance_calendar_id)
		BEGIN
			INSERT INTO Attendance.Attendance_Calendar 
                       (attendance_calendar_id       ,attendance_calendar_name       ,remarks       ,created_user_id            ,company_group_id       ,company_corporate_id       ,company_id)
		    VALUES	   (@param_attendance_calendar_id,@param_attendance_calendar_name,@param_remarks,@param_created_user_info_id,@param_company_group_id,@param_company_corporate_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     
	    IF (@pv_is_shared=1 AND EXISTS (SELECT attendance_calendar_name FROM Attendance.Attendance_Calendar WHERE attendance_calendar_name=@param_attendance_calendar_name AND company_group_id=@param_company_group_id and attendance_calendar_id<>@param_attendance_calendar_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Calendar name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT attendance_calendar_name FROM Attendance.Attendance_Calendar WHERE attendance_calendar_name=@param_attendance_calendar_name AND company_id=@param_company_id  and attendance_calendar_id<>@param_attendance_calendar_id)) 
	  	BEGIN

			ROLLBACK

				RAISERROR(N'Calendar name must be unique. Please try another name.',16,1);
			RETURN
		END
		--Duplicate checking
		IF EXISTS (SELECT attendance_calendar_id FROM Attendance.Attendance_Calendar M WHERE m.attendance_calendar_id=@param_attendance_calendar_id)
		BEGIN
			UPDATE Attendance.Attendance_Calendar SET 
			attendance_calendar_name=@param_attendance_calendar_name
		    ,remarks= @param_remarks
		WHERE attendance_calendar_id=@param_attendance_calendar_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Attendance_Calendar_Companay rm WHERE rm.attendance_calendar_id=@param_attendance_calendar_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Attendance Calendar Company.',16,1);
			RETURN
		END
	   IF EXISTS (SELECT * FROM Attendance.Attendance_Calendar_Session rm WHERE rm.attendance_calendar_id=@param_attendance_calendar_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Attendance Calendar Session.',16,1);
			RETURN
		END
		
    
		--Delete  authorization
		
    DELETE FROM Attendance.Attendance_Calendar WHERE attendance_calendar_id=@param_attendance_calendar_id
      
	END

	 SELECT  attendance_calendar_id,attendance_calendar_name,remarks,is_active FROM Attendance.Attendance_Calendar s WHERE  S.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
		  AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END AND  attendance_calendar_id=@param_attendance_calendar_id
     
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Calendar_Session_Holiday_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


			--INSERT INTO Attendance.Attendance_Calendar_Session_Holiday (acs_holiday_id,acs_id		,holiday_id,session_start_date,session_end_date,created_user_id)
			--					VALUES	( 1,9,2,'11-Jan-2021','11-Jan-2021',13)
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 11-Jan-2021
	-- Description:	Only for Insert and delete 
	-- =============================================

*/
--DROP PROCEDURE [Attendance].[Calendar_Session_Holiday_IUD]
CREATE PROCEDURE [Attendance].[SP_Attendance_Calendar_Session_Holiday_IUD]
@param_acs_holiday_id INT=0
,@param_acs_id INT=0
,@param_holiday_id INT=0
,@param_session_start_date DATETIME=''
,@param_session_end_date DATETIME=''
,@param_created_user_id INT
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	IF (@param_DBOperation=1)
	BEGIN
		SET @param_acs_holiday_id= (SELECT ISNULL(MAX(ISNULL(acs_holiday_id,0)),0)+1 from Attendance.Attendance_Calendar_Session_Holiday)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT * FROM Attendance.Attendance_Calendar_Session_Holiday M WHERE m.acs_holiday_id=@param_acs_holiday_id )
		BEGIN
			INSERT INTO Attendance.Attendance_Calendar_Session_Holiday (acs_holiday_id,acs_id		,holiday_id,session_start_date,session_end_date,created_user_id)
								VALUES	( @param_acs_holiday_id,@param_acs_id,@param_holiday_id,@param_session_start_date,@param_session_end_date,@param_created_user_id)
		END
		
	END

	IF (@param_DBOperation=3)
	BEGIN
	
		
       DELETE FROM Attendance.Attendance_Calendar_Session_Holiday WHERE acs_id=@param_acs_id and holiday_id=@param_holiday_id  
      
	END

	 SELECT * FROM Attendance.Attendance_Calendar_Session_Holiday WHERE acs_holiday_id=@param_acs_holiday_id
     
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Calendar_Session_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 11-Jan-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/
--Exec[Attendance].[SP_Attendance_Calendar_Session_IUD] '0',1,'tt','1-Jan-2021','1-Jan-2021',13,1
CREATE PROCEDURE [Attendance].[SP_Attendance_Calendar_Session_IUD]
@param_acs_id INT=0
,@param_attendance_calendar_id INT=0
,@param_session_name NVARCHAR(100)=''
,@param_session_start_date DATETIME=''
,@param_session_end_date DATETIME=''
,@param_created_user_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
    DECLARE @pv_is_shared BIT

	IF (@param_DBOperation=1)
	BEGIN
        IF (EXISTS (SELECT session_name FROM Attendance.Attendance_Calendar_Session WHERE  attendance_calendar_id=@param_attendance_calendar_id and session_name=@param_session_name) )
		BEGIN
			ROLLBACK
				RAISERROR(N'Session already exist. Please try another session.',16,1);
			RETURN
		END
	    IF (EXISTS (SELECT acs_id FROM Attendance.Attendance_Calendar_Session WHERE  (@param_session_start_date BETWEEN session_start_date AND session_end_date
           OR @param_session_end_date BETWEEN session_start_date AND session_end_date)  and attendance_calendar_id=@param_attendance_calendar_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'This Seeion period already exist. Please try another date.',16,1);
			RETURN
		END
     
        SET @param_acs_id= (SELECT ISNULL(MAX(ISNULL(acs_id,0)),0)+1 from Attendance.Attendance_Calendar_Session)

		IF NOT EXISTS (SELECT acs_id FROM Attendance.Attendance_Calendar_Session M WHERE m.acs_id=@param_acs_id)
		BEGIN
			INSERT INTO Attendance.Attendance_Calendar_Session 
                       (acs_id                        ,attendance_calendar_id       ,session_name       ,session_start_date       ,session_end_date       ,created_user_id)
		    VALUES	   (@param_acs_id,@param_attendance_calendar_id,@param_session_name,@param_session_start_date,@param_session_end_date,@param_created_user_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
        IF (EXISTS (SELECT session_name FROM Attendance.Attendance_Calendar_Session WHERE  attendance_calendar_id=@param_attendance_calendar_id and acs_id<>@param_acs_id and session_name=@param_session_name) )
		BEGIN
			ROLLBACK
				RAISERROR(N'Duplicate Session Name. Please try another session name.',16,1);
			RETURN
		END
       IF (EXISTS (SELECT acs_id FROM Attendance.Attendance_Calendar_Session WHERE  (@param_session_start_date BETWEEN session_start_date AND session_end_date
           OR @param_session_end_date BETWEEN session_start_date AND session_end_date)  and acs_id<>@param_acs_id and attendance_calendar_id=@param_attendance_calendar_id)) 
		BEGIN
		    ROLLBACK
				RAISERROR(N'This Seeion period already exist. Please try another date.',16,1);
			RETURN
		END
        



      
		--Duplicate checking
		IF EXISTS (SELECT acs_id FROM Attendance.Attendance_Calendar_Session M WHERE m.acs_id=@param_acs_id)
		BEGIN
			UPDATE Attendance.Attendance_Calendar_Session SET 
			session_name=@param_session_name
		    ,session_start_date= @param_session_start_date
            ,session_end_date=@param_session_end_date
		WHERE acs_id=@param_acs_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Attendance_Calendar_Session_Holiday rm WHERE rm.acs_id=@param_acs_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Attendance Calendar Session Holiday.',16,1);
			RETURN
		END

		
    
		--Delete  authorization
		
    DELETE FROM Attendance.Attendance_Calendar_Session WHERE acs_id=@param_acs_id
      
	END
    
     IF(@param_DBOperation=5)
     BEGIN
		DECLARE @pv_acs_holiday_id AS INT 
        DECLARE @pv_acs_id AS INT      
		SET @pv_acs_id= @param_acs_id
		SET @param_acs_id=(SELECT ISNULL(MAX(ISNULL(acs_id,0)),0)+1 from Attendance.Attendance_Calendar_Session)
        INSERT INTO Attendance.Attendance_Calendar_Session 
		SELECT @param_acs_id,attendance_calendar_id,session_name+'_'+'Copy',session_start_date,session_end_date,is_active,created_user_id,GETDATE() 
		FROM Attendance.Attendance_Calendar_Session 
		WHERE acs_id=@pv_acs_id

		IF EXISTS(SELECT acs_holiday_id FROM Attendance.Attendance_Calendar_Session_Holiday WHERE acs_id=@pv_acs_id)
		BEGIN
			SET @pv_acs_holiday_id= (SELECT ISNULL(MAX(ISNULL(acs_holiday_id,0)),0)+1 from Attendance.Attendance_Calendar_Session_Holiday)
			INSERT INTO Attendance.Attendance_Calendar_Session_Holiday 
			SELECT @pv_acs_holiday_id,@param_acs_id,holiday_id,session_start_date,session_end_date,created_user_id,GetDate()
			FROM Attendance.Attendance_Calendar_Session_Holiday WHERE acs_id=@pv_acs_id
		END
     END
     SELECT acs_id,a.attendance_calendar_name,FORMAT(session_start_date, 'dd-MMM-yyyy')  session_start_date_str,FORMAT (session_end_date, 'dd-MMM-yyyy') session_end_date_str,s.attendance_calendar_id,session_name,session_start_date,session_end_date,s.is_active 
     FROM  Attendance.Attendance_Calendar_Session  s inner join Attendance.Attendance_Calendar a on a.attendance_calendar_id=s.attendance_calendar_id WHERE acs_id=@param_acs_id
     
    

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Policy_Benefit_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 31-Mar-2022
	-- Description:	This is a Attendance Policy Benefit create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Attendance_Policy_Benefit_IUD]
@param_attendance_policy_benefit_id INT=0 
,@param_attendance_policy_id INT=0
,@param_abp_id INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     DECLARE @pv_is_shared BIT
     SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
     Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
       
     
		SET @param_attendance_policy_benefit_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_benefit_id,0)),0)+1 from Attendance.Attendance_Policy_Benefit)
	

		--Duplicate checking
		IF NOT EXISTS (SELECT attendance_policy_benefit_id FROM Attendance.Attendance_Policy_Benefit M WHERE m.attendance_policy_benefit_id=@param_attendance_policy_benefit_id )
		BEGIN
			INSERT INTO Attendance.Attendance_Policy_Benefit (attendance_policy_benefit_id,attendance_policy_id,abp_id,created_user_id)
								VALUES	( @param_attendance_policy_benefit_id,@param_attendance_policy_id,@param_abp_id,@param_created_user_id)
		END
		
	END
  

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Attendance_Policy_Benefit WHERE  attendance_policy_benefit_id=@param_attendance_policy_benefit_id  

	END

	  SELECT r.attendance_policy_benefit_id,r.attendance_policy_id,r.abp_id,s.abp_name FROM Attendance.Attendance_Policy_Benefit r 
      Inner join Attendance.Attendance_Benefit_Policy s on s.abp_id=r.abp_id
      WHERE attendance_policy_benefit_id=@param_attendance_policy_benefit_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Policy_Dayoff_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 31-Mar-2022
	-- Description:	This is a Attendance Policy Shift create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Attendance_Policy_Dayoff_IUD]
@param_attendance_policy_dayoff_id INT=0 
,@param_attendance_policy_id INT=0
,@param_week_day VARCHAR=''
,@param_dayoff_type_id INT =0
,@param_dayoff_alternative_id INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     DECLARE @pv_is_shared BIT
     SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
     Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
       
     
		SET @param_attendance_policy_dayoff_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_dayoff_id,0)),0)+1 from Attendance.Attendance_Policy_Dayoff)
	

		--Duplicate checking
		IF NOT EXISTS (SELECT attendance_policy_dayoff_id FROM Attendance.Attendance_Policy_Dayoff M WHERE m.attendance_policy_dayoff_id=@param_attendance_policy_dayoff_id )
		BEGIN
			INSERT INTO Attendance.Attendance_Policy_Dayoff (attendance_policy_dayoff_id,attendance_policy_id,week_day,dayoff_type_id,dayoff_alternative_id,created_user_id)
								VALUES	( @param_attendance_policy_dayoff_id,@param_attendance_policy_id,@param_week_day,@param_dayoff_type_id,@param_dayoff_alternative_id,@param_created_user_id)
		END
		
	END
  

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Attendance_Policy_Dayoff WHERE  attendance_policy_dayoff_id=@param_attendance_policy_dayoff_id  

	END

	  SELECT r.attendance_policy_dayoff_id,r.attendance_policy_id,r.dayoff_type_id,r.week_day+'['+d.dayoff_type_name+']' week_day FROM Attendance.Attendance_Policy_Dayoff r 
      Inner join DBEnum.Dayoff_Type d on d.dayoff_type_id=r.dayoff_type_id
      WHERE attendance_policy_dayoff_id=@param_attendance_policy_dayoff_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Policy_Leave_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 31-Mar-2022
	-- Description:	This is a Attendance Policy Leave create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Attendance_Policy_Leave_IUD]
@param_attendance_policy_leave_id INT=0 
,@param_attendance_policy_id INT=0
,@param_leave_policy_id INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     DECLARE @pv_is_shared BIT
     SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
     Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
       
     
		SET @param_attendance_policy_leave_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_leave_id,0)),0)+1 from Attendance.Attendance_Policy_Leave)
	

		--Duplicate checking
		IF NOT EXISTS (SELECT attendance_policy_leave_id FROM Attendance.Attendance_Policy_Leave M WHERE m.attendance_policy_leave_id=@param_attendance_policy_leave_id )
		BEGIN
			INSERT INTO Attendance.Attendance_Policy_Leave (attendance_policy_leave_id,attendance_policy_id,leave_policy_id,created_user_id)
								VALUES	( @param_attendance_policy_leave_id,@param_attendance_policy_id,@param_leave_policy_id,@param_created_user_id)
		END
		
	END
  

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Attendance_Policy_Leave WHERE  attendance_policy_leave_id=@param_attendance_policy_leave_id  

	END

	  SELECT r.attendance_policy_leave_id,r.attendance_policy_id,r.leave_policy_id,l.leave_policy_name FROM Attendance.Attendance_Policy_Leave r 
      Inner join leave.Leave_Policy l on l.leave_policy_id=r.leave_policy_id
      WHERE attendance_policy_leave_id=@param_attendance_policy_leave_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Attendance_Policy_Shift_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 31-Mar-2022
	-- Description:	This is a Attendance Policy Shift create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Attendance_Policy_Shift_IUD]
@param_attendance_policy_shift_id INT=0 
,@param_attendance_policy_id INT=0
,@param_shift_id INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     DECLARE @pv_is_shared BIT
     SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
     Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
        SET @param_attendance_policy_shift_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_shift_id,0)),0)+1 from Attendance.Attendance_Policy_Shift)
	    --Duplicate checking
		IF NOT EXISTS (SELECT attendance_policy_shift_id FROM Attendance.Attendance_Policy_Shift M WHERE m.attendance_policy_shift_id=@param_attendance_policy_shift_id )
		BEGIN
			INSERT INTO Attendance.Attendance_Policy_Shift (attendance_policy_shift_id       ,attendance_policy_id       ,shift_id       ,created_user_id)
								                  VALUES   (@param_attendance_policy_shift_id,@param_attendance_policy_id,@param_shift_id,@param_created_user_id)
		END
		
	END
  
	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Attendance_Policy_Shift 
	   WHERE  attendance_policy_shift_id=@param_attendance_policy_shift_id  

	END

	  SELECT r.attendance_policy_shift_id,r.attendance_policy_shift_id,r.shift_id,s.shift_name FROM Attendance.Attendance_Policy_Shift r 
      INNER JOIN Attendance.Shift_Info s on s.shift_id=r.shift_id
      WHERE attendance_policy_shift_id=@param_attendance_policy_shift_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_AttendancePolicy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 30-MAR-2022
	-- Description:	This is a Attendance Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_AttendancePolicy_IUD]
 @param_attendance_policy_id INT=0
,@param_policy_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_remarks NVARCHAR(500)=''
,@param_attendance_calendar_id INT=0
,@param_late_early_policy_id INT=0
,@param_absenteeism_policy_id INT=0
,@param_roster_policy_id INT=0
,@param_is_random_dayoff BIT=0
,@param_no_of_random_dayoff INT=0
,@param_is_allow_benefit_policy BIT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT policy_name FROM Attendance.Attendance_Policy WHERE policy_name=@param_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT policy_name FROM Attendance.Attendance_Policy WHERE policy_name=@param_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_attendance_policy_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_id,0)),0)+1 from Attendance.Attendance_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_attendance_policy_id)

		IF NOT EXISTS (SELECT attendance_policy_id FROM Attendance.Attendance_Policy M WHERE m.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
			INSERT INTO Attendance.Attendance_Policy 
                       (attendance_policy_id       ,policy_name       ,code       ,remarks       ,attendance_calendar_id,late_early_policy_id,absenteeism_policy_id,roster_policy_id,is_random_dayoff,no_of_random_dayoff,is_allow_benefit_policy,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_attendance_policy_id,@param_policy_name,@param_code,@param_remarks,@param_attendance_calendar_id,@param_late_early_policy_id,@param_absenteeism_policy_id,@param_roster_policy_id,@param_is_random_dayoff,@param_no_of_random_dayoff,@param_is_allow_benefit_policy,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT policy_name FROM Attendance.Attendance_Policy WHERE policy_name=@param_policy_name AND company_group_id=@param_company_group_id AND attendance_policy_id<>@param_attendance_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT policy_name FROM Attendance.Attendance_Policy WHERE policy_name=@param_policy_name AND company_id=@param_company_id AND attendance_policy_id<>@param_attendance_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT attendance_policy_id FROM Attendance.Attendance_Policy M WHERE m.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
			UPDATE Attendance.Attendance_Policy SET 
			policy_name=@param_policy_name
            ,remarks= @param_remarks
            ,attendance_calendar_id=@param_attendance_calendar_id
			,late_early_policy_id=@param_late_early_policy_id
			,absenteeism_policy_id=@param_absenteeism_policy_id
			,roster_policy_id=@param_roster_policy_id
			,is_random_dayoff=@param_is_random_dayoff
			,no_of_random_dayoff=@param_no_of_random_dayoff
			,is_allow_benefit_policy=@param_is_allow_benefit_policy
            
           
          WHERE attendance_policy_id=@param_attendance_policy_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Attendance_Policy_Benefit rm WHERE rm.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
		    DELETE FROM Attendance.Attendance_Policy_Benefit WHERE attendance_policy_id=@param_attendance_policy_id
		END
	 
		IF EXISTS (SELECT * FROM Attendance.Attendance_Policy_Leave rm WHERE rm.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
		    DELETE FROM Attendance.Attendance_Policy_Leave WHERE attendance_policy_id=@param_attendance_policy_id
		END

	 	IF EXISTS (SELECT * FROM Attendance.Attendance_Policy_Dayoff rm WHERE rm.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
		    DELETE FROM Attendance.Attendance_Policy_Dayoff WHERE attendance_policy_id=@param_attendance_policy_id
		END

	  	IF EXISTS (SELECT * FROM Attendance.Attendance_Policy_Shift rm WHERE rm.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
		    DELETE FROM Attendance.Attendance_Policy_Shift WHERE attendance_policy_id=@param_attendance_policy_id
		END
	 
		
		--Delete  Attendance_Policy
		
          DELETE FROM Attendance.Attendance_Policy WHERE attendance_policy_id=@param_attendance_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT attendance_policy_id FROM Attendance.Attendance_Policy M WHERE m.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
			 UPDATE Attendance.Attendance_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE attendance_policy_id=@param_attendance_policy_id
		END
	END

     IF(@param_DBOperation=5)
     BEGIN
         DECLARE @pv_attendance_policy_id AS INT      
		SET @pv_attendance_policy_id= @param_attendance_policy_id
		SET @param_attendance_policy_id= (SELECT ISNULL(MAX(ISNULL(attendance_policy_id,0)),0)+1 from Attendance.Attendance_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_attendance_policy_id)

		IF NOT EXISTS (SELECT attendance_policy_id FROM Attendance.Attendance_Policy M WHERE m.attendance_policy_id=@param_attendance_policy_id)
		BEGIN
			INSERT INTO Attendance.Attendance_Policy( attendance_policy_id,policy_name     ,[code]  ,remarks       ,attendance_calendar_id,late_early_policy_id,absenteeism_policy_id,roster_policy_id,is_random_dayoff,no_of_random_dayoff,is_allow_benefit_policy,created_user_id,company_corporate_id,company_group_id,company_id)
            SELECT @param_attendance_policy_id                           ,policy_name+'_'+'Copy',[code],[remarks],attendance_calendar_id,late_early_policy_id,absenteeism_policy_id,roster_policy_id,is_random_dayoff,no_of_random_dayoff,is_allow_benefit_policy,created_user_id,company_corporate_id,company_group_id,company_id 
            FROM Attendance.Attendance_Policy WHERE absenteeism_policy_id=@pv_attendance_policy_id
		END
     END

		  SELECT * FROM [Attendance].[View_AttendancePolicies] s
		  WHERE  s.attendance_policy_id=@param_attendance_policy_id
	

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Attendance].[SP_Late_Early_Policy_Detail_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 22-fEB-2022
	-- Description:	This is a Late Early Policy Details create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Late_Early_Policy_Detail_IUD]
@param_lep_detail_id INT=0 
,@param_late_early_policy_id INT=0
,@param_late_early_type_id_enum INT=0
,@param_is_allow_late_early_slab bit=0
,@param_min_late_early_min INT=0
,@param_max_late_early_min INT=0
,@param_late_early_days_for INT=0
,@param_is_consecutive bit=0
,@param_is_leave_adjustment bit=0
,@param_leave_in_min INT=0
,@param_is_leave_as_late_early_min bit=0
,@param_salary_head_id INT=0
,@param_percent_value INT=0
,@param_is_gross bit=0
,@param_primary_salary_head_id INT=0
,@param_deduction_days INT=0
,@param_is_deduction_monthly_min bit=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
	IF (@param_DBOperation=1)
	BEGIN
  
		SET @param_lep_detail_id= (SELECT ISNULL(MAX(ISNULL(lep_detail_id,0)),0)+1 from Attendance.Late_Early_Policy_Detail)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT lep_detail_id FROM Attendance.Late_Early_Policy_Detail M WHERE m.lep_detail_id=@param_lep_detail_id )
		BEGIN
			INSERT INTO Attendance.Late_Early_Policy_Detail (lep_detail_id,late_early_policy_id		,late_early_type_id_enum,is_allow_late_early_slab,min_late_early_min,max_late_early_min,late_early_days_for,is_consecutive,is_leave_adjustment,leave_in_min,is_leave_as_late_early_min,salary_head_id,percent_value,is_gross,primary_salary_head_id,deduction_days,is_deduction_monthly_min,created_user_id)
								VALUES	( @param_lep_detail_id,@param_late_early_policy_id,@param_late_early_type_id_enum,@param_is_allow_late_early_slab,@param_min_late_early_min,@param_max_late_early_min,@param_late_early_days_for,@param_is_consecutive,@param_is_leave_adjustment,@param_leave_in_min,@param_is_leave_as_late_early_min,@param_salary_head_id,@param_percent_value,@param_is_gross,@param_primary_salary_head_id,@param_deduction_days,@param_is_deduction_monthly_min,@param_created_user_id)
		END
		
	END

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Late_Early_Policy_Detail WHERE  lep_detail_id=@param_lep_detail_id  

	END

	  SELECT * FROM Attendance.Late_Early_Policy_Detail WHERE lep_detail_id=@param_lep_detail_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Late_Early_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 22-FEB-2022
	-- Description:	This is a Late Early Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Late_Early_Policy_IUD]
 @param_late_early_policy_id INT=0
,@param_late_early_policy_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_remarks NVARCHAR(500)=''
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT late_early_policy_name FROM Attendance.Late_Early_Policy WHERE late_early_policy_name=@param_late_early_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT late_early_policy_name FROM Attendance.Late_Early_Policy WHERE late_early_policy_name=@param_late_early_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_late_early_policy_id= (SELECT ISNULL(MAX(ISNULL(late_early_policy_id,0)),0)+1 from Attendance.Late_Early_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_late_early_policy_id)

		IF NOT EXISTS (SELECT late_early_policy_id FROM Attendance.Late_Early_Policy M WHERE m.late_early_policy_id=@param_late_early_policy_id)
		BEGIN
			INSERT INTO Attendance.Late_Early_Policy 
                       (late_early_policy_id       ,late_early_policy_name       ,code       ,remarks  ,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_late_early_policy_id,@param_late_early_policy_name,@param_code,@param_remarks,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT late_early_policy_name FROM Attendance.Late_Early_Policy WHERE late_early_policy_name=@param_late_early_policy_name AND company_group_id=@param_company_group_id AND late_early_policy_id<>@param_late_early_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT late_early_policy_name FROM Attendance.Late_Early_Policy WHERE late_early_policy_name=@param_late_early_policy_name AND company_id=@param_company_id AND late_early_policy_id<>@param_late_early_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT late_early_policy_id FROM Attendance.Late_Early_Policy M WHERE m.late_early_policy_id=@param_late_early_policy_id)
		BEGIN
			UPDATE Attendance.Late_Early_Policy SET 
			 late_early_policy_name=@param_late_early_policy_name
            ,remarks= @param_remarks
            
           
          WHERE late_early_policy_id=@param_late_early_policy_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Late_Early_Policy_Detail rm WHERE rm.late_early_policy_id=@param_late_early_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Late Early Policy Details.',16,1);
			RETURN
		END
	 
	
		
		--Delete  Shift_Info
		
    DELETE FROM Attendance.Late_Early_Policy WHERE late_early_policy_id=@param_late_early_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT late_early_policy_id FROM Attendance.Late_Early_Policy M WHERE m.late_early_policy_id=@param_late_early_policy_id)
		BEGIN
			UPDATE Attendance.Late_Early_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE late_early_policy_id=@param_late_early_policy_id
		END
	END

		  SELECT S.late_early_policy_id,S.late_early_policy_name,s.remarks, 
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
          ,s.is_active
		  FROM Attendance.Late_Early_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
		  WHERE  late_early_policy_id=@param_late_early_policy_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Overtime_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 19-Jan-2022
	-- Description:	This is a Overtime policy create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Overtime_Policy_IUD]
 @param_OT_policy_id INT=0
,@param_policy_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_minimum_OT_min INT=0
,@param_maximum_OT_min INT=0
,@param_OT_reduce_time_min INT=0
,@param_is_active BIT=0
,@param_remarks NVARCHAR(50)=''
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy

	IF (@param_DBOperation=1)
	BEGIN

        IF (@pv_is_shared=1 AND EXISTS (SELECT policy_name FROM Attendance.Overtime_Policy WHERE policy_name=@param_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT policy_name FROM Attendance.Overtime_Policy WHERE policy_name=@param_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
       IF (@param_minimum_OT_min>@param_maximum_OT_min) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Minimum OT must be less than Maximum OT.',16,1);
			RETURN
		END


        SET @param_OT_policy_id= (SELECT ISNULL(MAX(ISNULL(OT_policy_id,0)),0)+1 from Attendance.Overtime_Policy)

		SET @param_code=1000+''+@param_OT_policy_id

		IF NOT EXISTS (SELECT OT_policy_id FROM Attendance.Overtime_Policy M WHERE m.OT_policy_id=@param_OT_policy_id)
		BEGIN
			INSERT INTO Attendance.Overtime_Policy 
                       (OT_policy_id       ,policy_name       ,code       ,minimum_OT_min            ,maximum_OT_min       ,OT_reduce_time_min       ,remarks,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_OT_policy_id,@param_policy_name,@param_code,@param_minimum_OT_min,@param_maximum_OT_min,@param_OT_reduce_time_min,@param_remarks,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT policy_name FROM Attendance.Overtime_Policy WHERE policy_name=@param_policy_name AND company_group_id=@param_company_group_id And OT_policy_id<>@param_OT_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT policy_name FROM Attendance.Overtime_Policy WHERE policy_name=@param_policy_name AND company_id=@param_company_id And OT_policy_id<>@param_OT_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
       IF (@param_minimum_OT_min>@param_maximum_OT_min) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Minimum OT must be less than Maximum OT.',16,1);
			RETURN
		END
		--Duplicate checking
		IF EXISTS (SELECT OT_policy_id FROM Attendance.Overtime_Policy M WHERE m.OT_policy_id=@param_OT_policy_id)
		BEGIN
			UPDATE Attendance.Overtime_Policy SET 
			 policy_name=@param_policy_name
		    ,remarks= @param_remarks
            ,minimum_OT_min=@param_minimum_OT_min
            ,maximum_OT_min=@param_maximum_OT_min
            ,OT_reduce_time_min=@param_OT_reduce_time_min
		WHERE OT_policy_id=@param_OT_policy_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Overtime_Policy_Company rm WHERE rm.OT_policy_id=@param_OT_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Over time policy Company.',16,1);
			RETURN
		END
	   IF EXISTS (SELECT * FROM Attendance.Shift_Info rm WHERE rm.OT_policy_id=@param_OT_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Shift Info.',16,1);
			RETURN
		END
		
        IF EXISTS (SELECT * FROM Attendance.Overtime_Policy_Slab rm WHERE rm.OT_policy_id=@param_OT_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Overtime Policy Slab.',16,1);
			RETURN
		END
		
		--Delete  authorization
		
    DELETE FROM Attendance.Overtime_Policy WHERE OT_policy_id=@param_OT_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT OT_policy_id FROM Attendance.Overtime_Policy M WHERE m.OT_policy_id=@param_OT_policy_id)
		BEGIN
			UPDATE Attendance.Overtime_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE OT_policy_id=@param_OT_policy_id
		END
	END

	 SELECT * FROM Attendance.Overtime_Policy WHERE OT_policy_id=@param_OT_policy_id
     
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Overtime_Policy_Slab_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 19-Jan-2022
	-- Description:	This is a Overtime Slab create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Overtime_Policy_Slab_IUD]
@param_OT_policy_slab_id INT=0 
,@param_OT_policy_id INT=0
,@param_minimum_OT_min INT=0
,@param_maximum_OT_min INT=0
,@param_acheive_OT_min INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
	IF (@param_DBOperation=1)
	BEGIN
       IF (@param_minimum_OT_min>@param_maximum_OT_min) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Minimum OT must be less than Maximum OT.',16,1);
			RETURN
		END
		SET @param_OT_policy_slab_id= (SELECT ISNULL(MAX(ISNULL(OT_policy_slab_id,0)),0)+1 from Attendance.Overtime_Policy_Slab)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT OT_policy_slab_id FROM Attendance.Overtime_Policy_Slab M WHERE m.OT_policy_slab_id=@param_OT_policy_slab_id )
		BEGIN
			INSERT INTO Attendance.Overtime_Policy_Slab (OT_policy_slab_id,OT_policy_id		,minimum_OT_min,maximum_OT_min,acheive_OT_min,created_user_id)
								VALUES	( @param_OT_policy_slab_id,@param_OT_policy_id,@param_minimum_OT_min,@param_maximum_OT_min,@param_acheive_OT_min,@param_created_user_id)
		END
		
	END

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Overtime_Policy_Slab WHERE  OT_policy_slab_id=@param_OT_policy_slab_id  

	END

	 SELECT * FROM Attendance.Overtime_Policy_Slab WHERE OT_policy_slab_id=@param_OT_policy_slab_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Roster_Policy_Details_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 12-Mar-2022
	-- Description:	This is a Roster policy details create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Roster_Policy_Details_IUD]
@param_roster_policy_detail_id INT=0 
,@param_roster_policy_id INT=0
,@param_shift_id INT=0
,@param_next_shift_id INT=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     DECLARE @pv_is_shared BIT
     SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
     Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
       
     
		SET @param_roster_policy_detail_id= (SELECT ISNULL(MAX(ISNULL(roster_policy_detail_id,0)),0)+1 from Attendance.Roster_Policy_Detail)
	

		--Duplicate checking
		IF NOT EXISTS (SELECT roster_policy_detail_id FROM Attendance.Roster_Policy_Detail M WHERE m.roster_policy_detail_id=@param_roster_policy_detail_id )
		BEGIN
			INSERT INTO Attendance.Roster_Policy_Detail (roster_policy_detail_id,roster_policy_id		,shift_id,next_shift_id,created_user_id)
								VALUES	( @param_roster_policy_detail_id,@param_roster_policy_id,@param_shift_id,@param_next_shift_id,@param_created_user_id)
		END
		
	END
  

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Roster_Policy_Detail WHERE  roster_policy_detail_id=@param_roster_policy_detail_id  

	END

	  SELECT r.roster_policy_id,r.roster_policy_detail_id,r.shift_id,r.next_shift_id,s.shift_name ,s1.shift_name next_shift_name FROM Attendance.Roster_Policy_Detail r 
      Inner join Attendance.Shift_Info s on s.shift_id=r.shift_id
      Inner join Attendance.Shift_Info s1 on s1.shift_id=r.next_shift_id
      WHERE roster_policy_detail_id=@param_roster_policy_detail_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Shift_Break_Duration_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 19-Jan-2022
	-- Description:	This is a Shift Break Duration create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Shift_Break_Duration_IUD]
@param_shift_break_duration_id INT=0 
,@param_shift_id INT=0
,@param_shift_break_head_id INT=0
,@param_is_allow_start_end bit=0
,@param_break_start time=''
,@param_break_end time=''
,@param_break_duration_min int=0
,@param_created_user_id BIGINT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
	IF (@param_DBOperation=1)
	BEGIN
  --     IF (@param_minimum_OT_min>@param_maximum_OT_min) 
	 -- 	BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Minimum OT must be less than Maximum OT.',16,1);
		--	RETURN
		--END
		SET @param_shift_break_duration_id= (SELECT ISNULL(MAX(ISNULL(shift_break_duration_id,0)),0)+1 from Attendance.Shift_Break_Duration)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT shift_break_duration_id FROM Attendance.Shift_Break_Duration M WHERE m.shift_break_duration_id=@param_shift_break_duration_id )
		BEGIN
			INSERT INTO [Attendance].[Shift_Break_Duration]([shift_break_duration_id],[shift_id],[shift_break_head_id],[is_allow_start_end],[break_start],[break_end],[break_duration_min],[created_user_id])
								                   VALUES	(@param_shift_break_duration_id,@param_shift_id,@param_shift_break_head_id,0,NULL,NULL,@param_break_duration_min,@param_created_user_id)
		END
		
	END

	IF (@param_DBOperation=3)
	BEGIN
	
       DELETE FROM Attendance.Shift_Break_Duration WHERE  shift_break_duration_id=@param_shift_break_duration_id  

	END

	 SELECT * FROM Attendance.Shift_Break_Duration WHERE shift_break_duration_id=@param_shift_break_duration_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Attendance].[SP_Shift_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 29-Jan-2022
	-- Description:	This is a Shift create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Attendance].[SP_Shift_Info_IUD]
 @param_shift_id INT=0
,@param_shift_name NVARCHAR(50)=''
,@param_code NVARCHAR(50)=''
,@param_shift_type_id_enum INT=0
,@param_remark NVARCHAR(300)=''
,@param_time_zone_id INT=0
,@param_is_day_crossing BIT=0
,@param_attendance_count INT=0
,@param_day_start time=''
,@param_day_end time=''
,@param_shift_start time=''
,@param_shift_end time=''
,@param_is_allow_half_day BIT=0
,@param_half_shift_start time=''
,@param_half_shift_end time=''
,@param_report_time time=''
,@param_late_tolerance_min INT=0
,@param_extended_time_min INT=0
,@param_early_tolerance_min INT=0
,@param_working_hour_min INT=0
,@param_half_working_hour_min INT=0
,@param_OT_policy_id INT=0
,@param_is_OT_before_shift BIT=0
,@param_is_OT_after_shift BIT=0
,@param_attendance_benefit_policy_id INT =0
,@param_is_active BIT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   Declare @pv_corporate_short_name nvarchar(10)
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
	IF (@param_DBOperation=1)
	BEGIN
		--Duplicate checking
        IF (@pv_is_shared=1 AND EXISTS (SELECT shift_name FROM Attendance.Shift_Info WHERE shift_name=@param_shift_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT shift_name FROM Attendance.Shift_Info WHERE shift_name=@param_shift_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_shift_id= (SELECT ISNULL(MAX(ISNULL(shift_id,0)),0)+1 from Attendance.Shift_Info)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+1000+''+@param_shift_id

		IF NOT EXISTS (SELECT shift_id FROM Attendance.Shift_Info M WHERE m.shift_id=@param_shift_id)
		BEGIN
			INSERT INTO Attendance.Shift_Info 
                       (shift_id       ,shift_name       ,code       ,shift_type_id_enum            ,remark       ,time_zone_id  ,is_day_crossing,       attendance_count       ,day_start       ,day_end       ,shift_start       ,shift_end      ,is_allow_half_day       ,half_shift_start        ,half_shift_end       ,report_time       ,late_tolerance_min      ,extended_time_min,early_tolerance_min              ,working_hour_min,half_working_hour_min               ,OT_policy_id,is_OT_before_shift,is_OT_after_shift,attendance_benefit_policy_id,is_active,created_user_id,company_corporate_id,company_group_id,company_id)
		    VALUES	   (@param_shift_id,@param_shift_name,@param_code,@param_shift_type_id_enum,@param_remark,@param_time_zone_id,@param_is_day_crossing,@param_attendance_count,@param_day_start,@param_day_end,@param_shift_start,@param_shift_end,@param_is_allow_half_day,@param_half_shift_start,@param_half_shift_end,@param_report_time,@param_late_tolerance_min,@param_extended_time_min,@param_early_tolerance_min,@param_working_hour_min,@param_half_working_hour_min,@param_OT_policy_id,@param_is_OT_before_shift,@param_is_OT_after_shift,@param_attendance_benefit_policy_id,1,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT shift_name FROM Attendance.Shift_Info WHERE shift_name=@param_shift_name AND company_group_id=@param_company_group_id AND shift_id<>@param_shift_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT shift_name FROM Attendance.Shift_Info WHERE shift_name=@param_shift_name AND company_id=@param_company_id AND shift_id<>@param_shift_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT shift_id FROM Attendance.Shift_Info M WHERE m.shift_id=@param_shift_id)
		BEGIN
			UPDATE Attendance.Shift_Info SET 
			 shift_name=@param_shift_name
            ,shift_type_id_enum=@param_shift_type_id_enum
		    ,remark= @param_remark
            ,time_zone_id=@param_time_zone_id
            ,is_day_crossing=@param_is_day_crossing
            ,attendance_count=@param_attendance_count
            ,day_start=@param_day_start
            ,day_end=@param_day_end
            ,shift_start=@param_shift_start
            ,shift_end=@param_shift_end
            ,is_allow_half_day=@param_is_allow_half_day
            ,half_shift_start=@param_half_shift_start
            ,half_shift_end=@param_half_shift_end
            ,report_time=@param_report_time
            ,late_tolerance_min=@param_late_tolerance_min
            ,extended_time_min=@param_extended_time_min
            ,working_hour_min=@param_working_hour_min
            ,half_working_hour_min=@param_half_working_hour_min
            ,OT_policy_id=@param_OT_policy_id
            ,is_OT_after_shift=@param_is_OT_after_shift
            ,is_OT_before_shift=@param_is_OT_before_shift
            ,attendance_benefit_policy_id=@param_attendance_benefit_policy_id
           
		WHERE shift_id=@param_shift_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Shift_Company rm WHERE rm.shift_id=@param_shift_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Shift Company.',16,1);
			RETURN
		END
	   IF EXISTS (SELECT * FROM Attendance.Shift_Break_Duration rm WHERE rm.shift_id=@param_shift_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Shift Break Duration.',16,1);
			RETURN
		END
	
		
		--Delete  Shift_Info
		
    DELETE FROM Attendance.Shift_Info WHERE shift_id=@param_shift_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT shift_id FROM Attendance.Shift_Info M WHERE m.shift_id=@param_shift_id)
		BEGIN
			UPDATE Attendance.Shift_Info SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE shift_id=@param_shift_id
		END
	END

	 SELECT * FROM Attendance.Shift_Info WHERE shift_id=@param_shift_id
     
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Authorization_Role_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 04-Dec-2021
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/
--DROP PROCEDURE [Auth].[SP_Authorization_Role_IUD]
CREATE PROCEDURE [Auth].[SP_Authorization_Role_IUD]
@param_authorization_role_id INT=0
,@param_authorization_role_name NVARCHAR(150)=''
,@param_is_active BIT=0
,@param_remarks NVARCHAR(150)=''
,@param_created_datetime DATETIME=''
,@param_updated_datetime DATETIME=''
,@param_created_user_info_id INT=0
,@param_updated_user_info_id INT=0
,@param_company_corporate_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	IF (@param_DBOperation=1)
	BEGIN
        	--Duplicate checking
		IF EXISTS (SELECT * FROM Auth.Authorization_Role WHERE authorization_role_name=@param_authorization_role_name)
		BEGIN
			ROLLBACK
				RAISERROR(N'Authorization Role name must be unique. Please try another name.',16,1);
			RETURN
		END

		SET @param_authorization_role_id= (SELECT ISNULL(MAX(ISNULL(authorization_role_id,0)),0)+1 from Auth.Authorization_Role)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT * FROM Auth.Authorization_Role M WHERE m.authorization_role_id=@param_authorization_role_id)
		BEGIN
			INSERT INTO Auth.Authorization_Role 
                       (authorization_role_id       ,authorization_role_name       ,remarks       ,created_datetime       ,updated_datetime       ,created_user_info_id       ,updated_user_info_id       ,company_corporate_id       ,company_id)
		    VALUES	   (@param_authorization_role_id,@param_authorization_role_name,@param_remarks,@param_created_datetime,@param_updated_datetime,@param_created_user_info_id,@param_updated_user_info_id,@param_company_corporate_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
        	--Duplicate checking
		IF EXISTS (SELECT * FROM Auth.Authorization_Role WHERE authorization_role_name=@param_authorization_role_name And authorization_role_id<>@param_authorization_role_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Authorization Role name must be unique. Please try another name.',16,1);
			RETURN
		END

	
		--Duplicate checking
		IF EXISTS (SELECT * FROM Auth.Authorization_Role M WHERE m.authorization_role_id=@param_authorization_role_id)
		BEGIN
			UPDATE Auth.Authorization_Role SET 
			authorization_role_name=@param_authorization_role_name
		    ,remarks= @param_remarks
			,updated_datetime=@param_updated_datetime
			,updated_db_server_date_time=GETDATE()
			,updated_user_info_id=@param_updated_user_info_id
			
		WHERE authorization_role_id=@param_authorization_role_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Auth.User_Menu_Authorization_Event rm WHERE rm.authorization_role_id=@param_authorization_role_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in User Menu Authorization Event.',16,1);
			RETURN
		END
	   IF EXISTS (SELECT * FROM Auth.Authorization_Role_Menu_Event rm WHERE rm.authorization_role_id=@param_authorization_role_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Authorization Role Menu Event.',16,1);
			RETURN
		END
		
        IF NOT EXISTS(SELECT * FROM Auth.Authorization_Role rm WHERE rm.authorization_role_id=@param_authorization_role_id)
	    BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible.Your deleted item is not exist.',16,1);
			RETURN
		END
		--Delete  authorization
		
       DELETE FROM Auth.Authorization_Role WHERE authorization_role_id=@param_authorization_role_id
      
	END

	 SELECT * FROM Auth.Authorization_Role WHERE authorization_role_id=@param_authorization_role_id
     
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Authorization_Role_Menu_Event_Permission]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 04-Dec-2021
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/
--DROP PROCEDURE [Auth].[SP_Authorization_Role_Menu_Event_Permission]
CREATE PROCEDURE [Auth].[SP_Authorization_Role_Menu_Event_Permission]
@param_authorization_role_menu_events_id INT=0
,@param_authorization_role_id NVARCHAR(150)=''
,@param_menu_event_id INT=0
,@param_menu_id NVARCHAR(150)=''
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
 

		
		--Duplicate checking
	    IF(@param_DBOperation=1)
        BEGIN
            SET @param_authorization_role_menu_events_id= (SELECT ISNULL(MAX(ISNULL(authorization_role_menu_events_id,0)),0)+1 from Auth.Authorization_Role_Menu_Event)
	        DECLARE @prv_user_info_id INT  
	        DECLARE @prv_user_menu_authorization_event_id INT
            DECLARE @prv_user_group_id INT
            DECLARE @prv_company_corporate_id INT
            DECLARE @prv_company_id INT
            DECLARE @prv_created_user_info_id INT
        	IF NOT EXISTS (SELECT * FROM Auth.Authorization_Role_Menu_Event M WHERE m.authorization_role_menu_events_id=@param_authorization_role_menu_events_id)
		    BEGIN
			INSERT INTO Auth.Authorization_Role_Menu_Event 
                       (authorization_role_menu_events_id       ,authorization_role_id       ,menu_event_id       ,menu_id)
		    VALUES	   (@param_authorization_role_menu_events_id,@param_authorization_role_id,@param_menu_event_id,@param_menu_id)
		    END
            IF  EXISTS(SELECT * FROM AUTH.User_Menu_Authorization_Event WHERE authorization_role_id=@param_authorization_role_id )
            BEGIN
               DECLARE Role_Menu_Event_CURSOR CURSOR  
				LOCAL  FORWARD_ONLY  FOR  
					SELECT DISTINCT user_info_id from Auth.Authorization_Role_Menu_Event m
                    INNER join auth.User_Menu_Authorization_Event b on m.authorization_role_id=b.authorization_role_id 
                    WHERE B.authorization_role_id=@param_authorization_role_id
                 
				OPEN Role_Menu_Event_CURSOR  
				FETCH NEXT FROM Role_Menu_Event_CURSOR INTO @prv_user_info_id
				WHILE @@FETCH_STATUS = 0  
				BEGIN  
   
					SET @prv_user_menu_authorization_event_id= (SELECT ISNULL(MAX(ISNULL(user_menu_authorization_event_id,0)),0)+1 from Auth.User_Menu_Authorization_Event)
		            SELECT DISTINCT @prv_company_id=company_id,@prv_company_corporate_id=company_corporate_id,@prv_created_user_info_id=created_user_info_id FROM Auth.User_Menu_Authorization_Event WHERE user_info_id=@prv_user_info_id
		  
					INSERT INTO Auth.User_Menu_Authorization_Event(user_menu_authorization_event_id,user_info_id       ,menu_event_id       ,menu_id,user_group_id,authorization_role_id,is_active,created_datetime,created_db_server_date_time,company_corporate_id,company_id,created_user_info_id)
					SELECT   @prv_user_menu_authorization_event_id,@prv_user_info_id,@param_menu_event_id,@param_menu_id,@prv_user_group_id,@param_authorization_role_id,1,GETDATE(),GETDATE(),@prv_company_corporate_id,@prv_company_id,@prv_created_user_info_id 

				FETCH NEXT FROM Role_Menu_Event_CURSOR INTO  @prv_user_info_id
				END  
				CLOSE Role_Menu_Event_CURSOR  
				DEALLOCATE Role_Menu_Event_CURSOR 
            END  

        END
	    
        IF(@param_DBOperation=3)
		BEGIN
	    IF EXISTS (SELECT * FROM Auth.User_Menu_Authorization_Event rm WHERE rm.authorization_role_id=@param_authorization_role_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in User Authorization Event.',16,1);
			RETURN
		END
			DELETE FROM Auth.Authorization_Role_Menu_Event WHERE authorization_role_menu_events_id=@param_authorization_role_menu_events_id
		END 


    

	    SELECT menu_id,menu_event_id,authorization_role_id FROM Auth.Authorization_Role_Menu_Event WHERE authorization_role_id=@param_authorization_role_id
     

    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Menu_Delete]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 3-Nov-2021
	-- Description:	This is a menu create and update store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Auth].[SP_Menu_Delete]
@param_menu_id INT=0,
@param_DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran
   	IF(@param_DBOperation=3 AND EXISTS(SELECT menu_id FROM Auth.Menu WHERE menu_id=@param_menu_id))
	BEGIN
        	--Reference checking
		IF EXISTS (SELECT * FROM Auth.Authorization_Role_Menu_Event rm WHERE rm.menu_id=@param_menu_id )
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Role Authorization',16,1);
			RETURN
		END

		IF EXISTS (SELECT * FROM Auth.User_Menu_Authorization_Event me WHERE me.menu_id=@param_menu_id )
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in user menu authorization',16,1);
			RETURN
		END

		IF EXISTS (SELECT * FROM Auth.User_Group_Menu_Authorization_Event ge WHERE ge.menu_id=@param_menu_id )
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in user group menu authorization',16,1);
			RETURN
		END
        IF NOT EXISTS(SELECT * FROM Auth.Menu WHERE menu_id=@param_menu_id)
	    BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible.Your deleted item is not exist',16,1);
			RETURN
		END

		DELETE FROM Auth.Menu WHERE menu_id=@param_menu_id
	END			
Commit Tran


GO
/****** Object:  StoredProcedure [Auth].[SP_Menu_Event_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Masud Iqbal
	-- Create date: 21-Nov-2021
	-- Description:	Only for Insert and delete 
	-- =============================================

*/
--DROP PROCEDURE [Auth].[SP_Menu_Event_ID]
CREATE PROCEDURE [Auth].[SP_Menu_Event_IUD]
@param_menu_event_id INT=0
,@param_menu_id INT=0
,@param_event_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	IF (@param_DBOperation=1)
	BEGIN
		SET @param_menu_event_id= (SELECT ISNULL(MAX(ISNULL(menu_event_id,0)),0)+1 from Auth.Menu_Event)
		
		--Duplicate checking
		IF NOT EXISTS (SELECT * FROM Auth.Menu_Event M WHERE m.menu_id=@param_menu_id AND M.event_enum_id=@param_event_id)
		BEGIN
			INSERT INTO Auth.Menu_Event (menu_event_id,menu_id		,event_enum_id)
								VALUES	( @param_menu_event_id,@param_menu_id,@param_event_id)
		END
		
	END

	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Auth.Authorization_Role_Menu_Event rm WHERE rm.menu_id=@param_menu_id AND rm.menu_event_id=@param_event_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Role Authorization',16,1);
			RETURN
		END

		IF EXISTS (SELECT * FROM Auth.User_Menu_Authorization_Event me WHERE me.menu_id=@param_menu_id AND me.menu_event_id=@param_event_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in user menu authorization.',16,1);
			RETURN
		END

		IF EXISTS (SELECT * FROM Auth.User_Group_Menu_Authorization_Event ge WHERE ge.menu_id=@param_menu_id AND ge.menu_event_id=@param_event_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in user group menu authorization.',16,1);
			RETURN
		END
        IF NOT EXISTS(SELECT * FROM Auth.Menu_Event WHERE menu_event_id=@param_menu_event_id)
	    BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible.Your deleted item is not exist.',16,1);
			RETURN
		END
		--Delete menu authorization
		
       DELETE FROM Auth.Menu_Event WHERE menu_event_id=@param_menu_event_id
      
	END

	 SELECT * FROM Auth.Menu_Event WHERE menu_event_id=@param_menu_event_id
     
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Menu_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 3-Nov-2021
	-- Description:	This is a menu create and update store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Auth].[SP_Menu_IUD]
@param_menu_id INT=0
,@param_menu_parent_id INT=0
,@param_menu_name NVARCHAR(200)=''
,@param_is_active BIT=0
,@param_sorting_priority INT=0
,@param_menu_icon_path NVARCHAR(200)=''
,@param_menu_routing_path NVARCHAR(200)=''
,@param_calling_parameter_value NVARCHAR(50)=''
,@param_calling_parameter_type NVARCHAR(50)=''
,@param_created_datetime DATETIME=''
,@param_updated_datetime DATETIME=''
,@param_created_user_info_id INT=0
,@param_updated_user_info_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	DECLARE @pv_db_server_date_time as datetime=GETDATE()
	DECLARE @pv_sortingpriority as int

	--SELECT TOP 1  @pv_sortingpriority=Isnull(sorting_priority,0)+1 from Auth.Menu WHERE menu_parentid=@param_menu_parent_id
	--ORDER BY sorting_priority DESC



	IF NOT EXISTS (SELECT * FROM Auth.Menu WHERE menu_parentid=@param_menu_parent_id)
	BEGIN
		SET @pv_sortingpriority=1;
	END ELSE
	BEGIN
		SET @pv_sortingpriority= (SELECT MAX(ISNULL(sorting_priority,0))+1 FROM Auth.Menu WHERE menu_parentid=@param_menu_parent_id)
	END


	--Insert
	IF(@param_DBOperation=1 AND NOT EXISTS(SELECT menu_id FROM Auth.Menu WHERE menu_id=@param_menu_id))
	BEGIN
		--Validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Auth.Menu WHERE menu_name=@param_menu_name)
		BEGIN
			ROLLBACK
				RAISERROR(N'Menu name must be unique. Please try another name.',16,1);
			RETURN
		END

		--Get Menu ID
		SET @param_menu_id=(SELECT MAX(ISNULL(menu_id,0))+1 from Auth.Menu)

		--Inser record
		INSERT INTO Auth.Menu
					(menu_id		,menu_parentid			,menu_name			,is_active			,sorting_priority	,menu_icon_path			,menu_routing_path			,calling_parameter_value		,calling_parameter_type			,[created_db_server_date_time]	,[created_datetime]		,[updated_datetime]		,[created_user_info_id]		,[updated_user_info_id])
		VALUES 		(@param_menu_id,@param_menu_parent_id	,@param_menu_name	,@param_is_active	,@pv_sortingpriority,@param_menu_icon_path	,@param_menu_routing_path	,@param_calling_parameter_value	,@param_calling_parameter_type	,@pv_db_server_date_time		,@param_created_datetime,@param_updated_datetime,@param_created_user_info_id,@param_updated_user_info_id)
	END

	--Update
	IF(@param_DBOperation=2 AND EXISTS(SELECT menu_id FROM Auth.Menu WHERE menu_id=@param_menu_id))
	BEGIN
		--validation
		--Duplicate checking
		IF EXISTS (SELECT * FROM Auth.Menu WHERE menu_name=@param_menu_name AND menu_id<>@param_menu_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Menu name must be unique. Please try another name.',16,1);
			RETURN
		END

		UPDATE Auth.Menu SET 
			menu_name=@param_menu_name
			,is_active=@param_is_active
			,menu_icon_path=CASE WHEN (@param_menu_icon_path is null or @param_menu_icon_path='') Then menu_icon_path else @param_menu_icon_path end
			,menu_routing_path=@param_menu_routing_path
			,calling_parameter_type=@param_calling_parameter_type
			,calling_parameter_value=@param_calling_parameter_value
			,[updated_datetime]=@param_updated_datetime
			,updated_db_server_date_time=@pv_db_server_date_time
			,[updated_user_info_id]=@param_updated_user_info_id
		WHERE menu_id=@param_menu_id
	END

    SELECT menu_id,menu_parentid,menu_name,is_active,menu_icon_path,menu_routing_path,calling_parameter_value,calling_parameter_type FROM [Auth].[Menu]
    WHERE menu_id=@param_menu_id
COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Menu_List_Swapping]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 6-Nov-2021
	-- Description:	This is a menu swapping store procedure.
	-- =============================================

*/

-- EXEC[Auth].[SP_Menu_Swapping] @param_menu_parent_id = 3,@param_upper_sorting=0

CREATE PROCEDURE [Auth].[SP_Menu_List_Swapping]
@param_menu_parent_id INT=0
,@param_upper_sorting bit=1

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	DECLARE @pv_count AS INT
    DECLARE @pv_initial AS INT=1
    DECLARE @pv_menu_id AS INT
    DECLARE @pv_updated_sorting_priority AS INT

    SELECT @pv_count=COUNT(menu_parentid) FROM Auth.Menu WHERE menu_parentid=@param_menu_parent_id
    
    IF OBJECT_ID('tempdb..#Sorting_Result') IS NOT NULL
    DROP TABLE #Results
    CREATE TABLE #Sorting_Result (menu_id INT,sorting_priority INT)
    
    --Upper Sorting
	IF(@param_upper_sorting=@pv_count)
	BEGIN
		WHILE(@pv_initial <=@pv_count)
		BEGIN
			SELECT @pv_menu_id=menu_id FROM Auth.Menu WHERE sorting_priority=@pv_initial
			
            IF(@pv_initial=1)
			SELECT @pv_updated_sorting_priority=(sorting_priority) FROM Auth.Menu WHERE sorting_priority=@pv_count
			ELSE
			SELECT @pv_updated_sorting_priority=(sorting_priority) FROM Auth.Menu WHERE sorting_priority=@pv_initial-1
			
            INSERT INTO #Sorting_Result    
			SELECT @pv_menu_id,@pv_updated_sorting_priority

			SET @pv_initial=@pv_initial+1
        END 
	END
    --Lower Sorting
	ELSE
	BEGIN
		WHILE(@pv_initial <=@pv_count)
		BEGIN
			SELECT @pv_menu_id=menu_id FROM Auth.Menu WHERE sorting_priority=@pv_initial
			
            IF(@pv_initial=@pv_count)
			SELECT @pv_updated_sorting_priority=(sorting_priority) FROM Auth.Menu WHERE sorting_priority=1
			ELSE
			SELECT @pv_updated_sorting_priority=(sorting_priority) FROM Auth.Menu WHERE sorting_priority=@pv_initial+1
			
            INSERT INTO #Sorting_Result    
			SELECT @pv_menu_id,@pv_updated_sorting_priority

			SET @pv_initial=@pv_initial+1
		END
    END	

    --Update Sorting Priority Column
	UPDATE m SET 
           m.sorting_priority=b.sorting_priority 
    FROM  Auth.Menu m
	INNER JOIN #Sorting_Result b ON m.menu_id=b.menu_id

    --Sorted List Selection
	SELECT sorting_priority,menu_name FROM Auth.Menu WHERE menu_parentid=@param_menu_parent_id
    ORDER BY sorting_priority
   
COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Menu_Swapping]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 6-Nov-2021
	-- Description:	This is a menu swapping store procedure.
	-- =============================================

*/

-- EXEC[Auth].[SP_Menu_Swapping] @param_menu_id=4,@param_menu_parent_id = 3,@param_is_upper_sorting=1

CREATE PROCEDURE [Auth].[SP_Menu_Swapping]
@param_menu_id INT=0
,@param_menu_parent_id INT=0
,@param_is_upper_sorting bit=1

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	DECLARE @pv_total_menu_list AS INT
    DECLARE @pv_count AS INT
    DECLARE @pv_initial AS INT=1
    DECLARE @pv_previous_menu_id AS INT
    DECLARE @pv_next_menu_id AS INT
    DECLARE @pv_previous_sorting_priority AS INT
    DECLARE @pv_next_sorting_priority AS INT
    DECLARE @pv_current_sorting_priority AS INT

    SELECT @pv_count=COUNT(menu_parentid) FROM Auth.Menu WHERE menu_parentid=@param_menu_parent_id
    
    IF OBJECT_ID('tsortingdb..#Sorting_Result') IS NOT NULL
    DROP TABLE #Sorting_Result

    --Parent wise sorting priority list stored
	SELECT menu_id,sorting_priority INTO #Sorting_Result
	FROM Auth.Menu 
	WHERE menu_parentid=@param_menu_parent_id 
	ORDER BY sorting_priority;
  
    SELECT @pv_current_sorting_priority=sorting_priority 
    FROM #Sorting_Result 
    WHERE menu_id=@param_menu_id

    IF(@param_is_upper_sorting=1 AND @pv_current_sorting_priority =1)
	BEGIN
		ROLLBACK
			RAISERROR(N'This menu already in upper position',16,1);
		RETURN
	END
    
    IF(@param_is_upper_sorting=0 AND @pv_current_sorting_priority=@pv_count)
	BEGIN
		ROLLBACK
			RAISERROR(N'This menu already in down position.',16,1);
		RETURN
	END

    --Upper Sorting
	IF(@param_is_upper_sorting=1 AND @pv_current_sorting_priority !=1)
    BEGIN
		SELECT @pv_previous_menu_id=menu_id,@pv_previous_sorting_priority=sorting_priority 
		FROM #Sorting_Result 
		WHERE sorting_priority=@pv_current_sorting_priority-1
        IF(@pv_previous_menu_id IS NOT NULL)
        BEGIN
			UPDATE Auth.Menu SET sorting_priority=@pv_previous_sorting_priority 
			WHERE menu_id=@param_menu_id
        
			UPDATE Auth.Menu SET sorting_priority=@pv_current_sorting_priority 
			WHERE menu_id=@pv_previous_menu_id
        END
    END
    --Lower sorting
	IF(@param_is_upper_sorting=0 AND @pv_current_sorting_priority!=@pv_count)
    BEGIN
		SELECT @pv_next_menu_id=menu_id,@pv_next_sorting_priority=sorting_priority 
		FROM #Sorting_Result 
		WHERE sorting_priority=@pv_current_sorting_priority+1

        IF(@pv_next_menu_id IS NOT NULL)
        BEGIN
			UPDATE Auth.Menu SET sorting_priority=@pv_next_sorting_priority 
			WHERE menu_id=@param_menu_id

			UPDATE Auth.Menu SET sorting_priority=@pv_current_sorting_priority 
			WHERE menu_id=@pv_next_menu_id
        END
	END

	SELECT sorting_priority,menu_name,menu_id FROM Auth.Menu 
	WHERE menu_parentid=@param_menu_parent_id
    ORDER BY sorting_priority
COMMIT TRAN


GO
/****** Object:  StoredProcedure [Auth].[SP_Role_Wise_Menu_For_Sidebar]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 5-Jan-2022
	-- Description:	This is a Role wise menu store procedure.
	-- =============================================

*/


-- EXEC[Auth].[SP_Role_Wise_Menu_For_Sidebar] @param_user_info_id=13

CREATE PROCEDURE [Auth].[SP_Role_Wise_Menu_For_Sidebar]
@param_user_info_id INT=0


WITH EXECUTE AS CALLER
AS
BEGIN
         set @param_user_info_id=ISNULL(@param_user_info_id,13)
		 DECLARE @pv_authorization_role_id AS INT=0

		 SELECT top 1 @pv_authorization_role_id=authorization_role_id FROM Auth.User_Menu_Authorization_Event WHERE user_info_id=@param_user_info_id AND authorization_role_id!=0 AND is_active=1

	

		;WITH #UserWiseMenuList AS
		(
		SELECT  M.menu_id,M.menu_parentid,menu_name,is_active,menu_icon_path,menu_routing_path,calling_parameter_value,calling_parameter_type,sorting_priority 
        FROM 
		(SELECT M.menu_id,M.menu_parentid
		FROM    Auth.User_Menu_Authorization_Event ME
				INNER JOIN Auth.[Menu] M on ME.menu_id=M.menu_id 
		Where   user_info_id=@param_user_info_id AND authorization_role_id=0 and me.is_active=1
		UNION 
		SELECT  M.menu_id,M.menu_parentid FROM Auth.Authorization_Role_Menu_Event ARE
				INNER JOIN Auth.[Menu] M on ARE.menu_id=M.menu_id 
		WHERE   authorization_role_id=@pv_authorization_role_id 
		)UM INNER JOIN
		Auth.Menu M ON UM.menu_parentid=M.menu_parentid AND UM.menu_id=M.menu_id

		UNION ALL

		SELECT  M.menu_id,M.menu_parentid,M.menu_name,M.is_active,M.menu_icon_path,M.menu_routing_path,M.calling_parameter_value,M.calling_parameter_type,m.sorting_priority
		FROM    [Auth].[Menu] M
				INNER JOIN #UserWiseMenuList UWM ON UWM.menu_parentid = M.menu_id 
		WHERE  M.menu_parentid<>0   
		)             
		SELECT  DISTINCT *
		FROM    #UserWiseMenuList
		ORDER BY menu_parentid,sorting_priority ASC


--SELECT  M.menu_id,M.menu_parentid,M.menu_name,M.is_active,M.menu_icon_path,M.menu_routing_path,M.calling_parameter_value,M.calling_parameter_type,m.sorting_priority
--		FROM    [Auth].[Menu] M WHERE menu_parentid<>0 ORDER BY menu_parentid,sorting_priority ASC
END


GO
/****** Object:  StoredProcedure [Auth].[SP_Time_Zone_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md. Masud Iqbal
-- Create date: 26 Jan 2022
-- Description:	get all timezone order by user priority
-- =============================================
CREATE PROCEDURE [Auth].[SP_Time_Zone_Get]
	@param_user_id	as bigint
AS
BEGIN
	SELECT tz.time_zone_id,tz.short_name+''+utc_offset as time_Zone_name FROM Auth.Time_Zone tz WHERE tz.time_zone_id IN (
	SELECT tzc.time_zone_id FROM Auth.Time_Zone_Country tzc WHERE tzc.country_id IN (
	SELECT c.country_id FROM Administrative.Company c WHERE c.company_id IN (
	SELECT u.company_id FROM Auth.User_Info u WHERE u.user_info_id=@param_user_id)))
	UNION ALL
	SELECT tz.time_zone_id,tz.short_name+''+utc_offset as time_Zone_name FROM Auth.Time_Zone tz WHERE tz.time_zone_id NOT IN (
	SELECT tzc.time_zone_id FROM Auth.Time_Zone_Country tzc WHERE tzc.country_id IN (
	SELECT c.country_id FROM Administrative.Company c WHERE c.company_id IN (
	SELECT u.company_id FROM Auth.User_Info u WHERE u.user_info_id=@param_user_id)))
END
GO
/****** Object:  StoredProcedure [Auth].[SP_User_Info_Delete]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 23-Oct-2021
	-- Description:	This is a user delete operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Auth].[SP_User_Info_Delete]
@user_info_id INT=0
,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran

IF(@DBOperation=3 AND EXISTS(SELECT user_info_id FROM Auth.User_Info WHERE user_info_id=@user_info_id))
	BEGIN
		DELETE FROM [Auth].[User_Info] WHERE user_info_id=@user_info_id
	END
			
Commit Tran


GO
/****** Object:  StoredProcedure [Auth].[SP_User_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 14-Oct-2021
	-- Description:	This is a user crud operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Auth].[SP_User_Info_IUD]
	@user_info_id INT=0
	,@user_name NVARCHAR(100)=''
	,@employee_id INT=0
	,@is_active BIT=0
	,@company_id INT=0
	,@company_corporate_id tinyint=0
	,@user_type_enum_id INT=0
	,@login_id NVARCHAR(50)=''
	,@phone_no NVARCHAR(15)=''
	,@email_address NVARCHAR(50)=''
	,@password NVARCHAR(150)=''
	,@national_id NVARCHAR(50)=''
	,@mobile_no NVARCHAR(50)=''
	,@user_image_path NVARCHAR(300)=''
    ,@signature_image_path NVARCHAR(300)=''
	,@is_password_reset BIT=0
	,@remarks NVARCHAR (150)=''
	,@created_datetime DATETIME=''
	,@updated_datetime DATETIME=''
	,@created_user_info_id INT=0
	,@updated_user_info_id INT=0
	,@DBOperation INT
WITH EXECUTE AS CALLER
AS
BEGIN Tran
Declare @db_server_date_time as datetime=GETDATE()
DECLARE @pv_company_group_id as int


IF(@DBOperation=1 AND NOT EXISTS(SELECT user_info_id FROM Auth.User_Info WHERE user_info_id=@user_info_id))
	BEGIN
	SELECT @user_info_id=iSNULL(MAX(user_info_id),0)+1 FROM Auth.User_Info
	--Validation
		--Duplicate checking

		IF EXISTS (SELECT * FROM Auth.User_Info WHERE login_id=@login_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Login Id must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE national_id=@national_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'National Id must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE mobile_no=@mobile_no)
		BEGIN
			ROLLBACK
				RAISERROR(N'Mobile No must be unique. Please try another mobile no.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE phone_no=@phone_no)
		BEGIN
			ROLLBACK
				RAISERROR(N'Phone no must be unique. Please try another phone no.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE email_address=@email_address)
		BEGIN
			ROLLBACK
				RAISERROR(N'Email Address must be unique. Please try another address.',16,1);
			RETURN
		END

	--get company group Id by company id
	SET @pv_company_group_id=(SELECT company_group_id FROm Administrative.Company WHERE company_id=@company_id);

    INSERT INTO [Auth].[User_Info] ([user_info_id],[user_name],[employee_id],[remarks],[is_active],[company_id],[company_corporate_id],[user_type_enum_id],[login_id],[phone_no],[email_address],[password],[national_id],[mobile_no],[user_image_path],[is_password_reset] ,[created_db_server_date_time],[created_datetime],[updated_datetime],[created_user_info_id],[updated_user_info_id],[company_group_id])
	VALUES (@user_info_id,@user_name, @employee_id, @remarks, @is_active, @company_id, @company_corporate_id, @user_type_enum_id, @login_id, @phone_no, @email_address, @password, @national_id, @mobile_no ,@user_image_path, @is_password_reset, @db_server_date_time, @created_datetime, @updated_datetime, @created_user_info_id, @updated_user_info_id,@pv_company_group_id)
	END

IF(@DBOperation=2 AND EXISTS(SELECT user_info_id FROM Auth.User_Info WHERE user_info_id=@user_info_id))
		IF EXISTS (SELECT * FROM Auth.User_Info WHERE login_id=@login_id AND user_info_id<>@user_info_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Login Id must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE national_id=@national_id AND user_info_id<>@user_info_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'National Id must be unique. Please try another Id.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE mobile_no=@mobile_no AND user_info_id<>@user_info_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Mobile No must be unique. Please try another mobile no.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE phone_no=@phone_no AND user_info_id<>@user_info_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Phone no must be unique. Please try another phone no.',16,1);
			RETURN
		END
	IF EXISTS (SELECT * FROM Auth.User_Info WHERE email_address=@email_address AND user_info_id<>@user_info_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Email Address must be unique. Please try another address.',16,1);
			RETURN
		END

BEGIN
        UPDATE [Auth].[User_Info] SET [employee_id]=@employee_id,[remarks]=@remarks,
[user_type_enum_id]=@user_type_enum_id,[phone_no]=@phone_no,[email_address]=@email_address,[national_id]=@national_id,[mobile_no]=@mobile_no,[user_image_path]=@user_image_path,signature_image_path=@signature_image_path,[updated_datetime]=@updated_datetime,[updated_user_info_id]=@updated_user_info_id
		WHERE user_info_id=@user_info_id
	END


SELECT [user_info_id],[user_name],[employee_id],[remarks],[is_active],[login_id],[email_address] 
FROM [Auth].[User_Info] 
WHERE [user_info_id]=@user_info_id
	
	
Commit Tran


GO
/****** Object:  StoredProcedure [Auth].[SP_User_Role_Menu_Event_Permission]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 22-Dec-2021
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/
--DROP PROCEDURE [Auth].[SP_Authorization_Role_Menu_Event_Permission]
CREATE PROCEDURE [Auth].[SP_User_Role_Menu_Event_Permission]
@param_user_menu_authorization_event_id INT=0
,@param_authorization_role_id INT=0
,@param_user_info_id INT=0
,@param_user_group_id INT=0
,@param_menu_event_id INT=0
,@param_menu_id INT=0
,@param_is_active bit =1
,@param_created_datetime DATETIME=''
,@param_updated_datetime DATETIME=''
,@param_created_user_info_id INT=0
,@param_updated_user_info_id INT=0
,@param_company_id int =0
,@param_company_corporate_id int=0
,@param_is_role_wise_event bit
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
	    DECLARE @prv_menu_id INT  
		DECLARE @prv_menu_event_id INT   

       IF(@param_is_role_wise_event=1)
       BEGIN  
			IF EXISTS (SELECT authorization_role_id,user_info_id FROM Auth.User_Menu_Authorization_Event rm WHERE rm.user_info_id=@param_user_info_id AND rm.authorization_role_id=@param_authorization_role_id AND is_active=1)
				BEGIN
					ROLLBACK
						RAISERROR(N'This role already exist,please select another role',16,1);
					RETURN
				END

        	IF (EXISTS(SELECT * FROM Auth.Authorization_Role_Menu_Event M WHERE m.authorization_role_id=@param_authorization_role_id))
		    BEGIN
                  
			IF(NOT EXISTS(SELECT * FROM Auth.User_Menu_Authorization_Event WHERE user_info_id=@param_user_info_id))
			BEGIN
				DECLARE Role_Menu_Event_CURSOR CURSOR  
				LOCAL  FORWARD_ONLY  FOR  
				SELECT menu_event_id,menu_id FROM auth.Authorization_Role_Menu_Event where authorization_role_id=@param_authorization_role_id
				OPEN Role_Menu_Event_CURSOR  
				FETCH NEXT FROM Role_Menu_Event_CURSOR INTO @prv_menu_event_id, @prv_menu_id 
				WHILE @@FETCH_STATUS = 0  
				BEGIN  
   
					SET @param_user_menu_authorization_event_id= (SELECT ISNULL(MAX(ISNULL(user_menu_authorization_event_id,0)),0)+1 from Auth.User_Menu_Authorization_Event)
		 
					INSERT INTO Auth.User_Menu_Authorization_Event(user_menu_authorization_event_id,user_info_id       ,menu_event_id       ,menu_id,user_group_id,authorization_role_id,is_active,created_datetime,created_db_server_date_time,company_corporate_id,company_id,created_user_info_id)
					SELECT   @param_user_menu_authorization_event_id,@param_user_info_id,@prv_menu_event_id,@prv_menu_id,@param_user_group_id,@param_authorization_role_id,@param_is_active,@param_created_datetime,GETDATE(),@param_company_corporate_id,@param_company_id,@param_created_user_info_id 

				FETCH NEXT FROM Role_Menu_Event_CURSOR INTO  @prv_menu_event_id ,@prv_menu_id
				END  
				CLOSE Role_Menu_Event_CURSOR  
				DEALLOCATE Role_Menu_Event_CURSOR 
             END

	        ELSE
			BEGIN
                    UPDATE Auth.User_Menu_Authorization_Event SET is_active=0 WHERE user_info_id=@param_user_info_id
					DECLARE Role_Menu_Event_CURSOR CURSOR  
					LOCAL  FORWARD_ONLY  FOR  
					SELECT menu_event_id,menu_id FROM auth.Authorization_Role_Menu_Event where authorization_role_id=@param_authorization_role_id
					OPEN Role_Menu_Event_CURSOR  
					FETCH NEXT FROM Role_Menu_Event_CURSOR INTO @prv_menu_event_id, @prv_menu_id 
					WHILE @@FETCH_STATUS = 0  
					BEGIN  
					   SET @param_user_menu_authorization_event_id= (SELECT ISNULL(MAX(ISNULL(user_menu_authorization_event_id,0)),0)+1 from Auth.User_Menu_Authorization_Event)
		
						INSERT INTO Auth.User_Menu_Authorization_Event(user_menu_authorization_event_id,user_info_id       ,menu_event_id       ,menu_id,user_group_id,authorization_role_id,is_active,created_datetime,created_db_server_date_time,company_corporate_id,company_id,created_user_info_id)
						SELECT   @param_user_menu_authorization_event_id,@param_user_info_id,@prv_menu_event_id,@prv_menu_id,@param_user_group_id,@param_authorization_role_id,1,@param_created_datetime,GETDATE(),@param_company_corporate_id,@param_company_id,@param_created_user_info_id 
					FETCH NEXT FROM Role_Menu_Event_CURSOR INTO  @prv_menu_event_id ,@prv_menu_id
					END  
					CLOSE Role_Menu_Event_CURSOR  
					DEALLOCATE Role_Menu_Event_CURSOR 
					END 

		    END        
					
			
		
		
        END

     
    ELSE
        BEGIN 

        IF(@param_DBOperation=1)
		BEGIN
	       IF NOT EXISTS (SELECT * FROM Auth.User_Menu_Authorization_Event M WHERE m.user_menu_authorization_event_id=@param_user_menu_authorization_event_id AND EXISTS(SELECT * FROM Auth.Authorization_Role_Menu_Event M WHERE m.authorization_role_id=@param_authorization_role_id))
		    BEGIN
             SET @param_user_menu_authorization_event_id= (SELECT ISNULL(MAX(ISNULL(user_menu_authorization_event_id,0)),0)+1 from Auth.User_Menu_Authorization_Event)
		
            INSERT INTO Auth.User_Menu_Authorization_Event(user_menu_authorization_event_id       ,user_info_id       ,menu_event_id       ,menu_id,user_group_id,authorization_role_id,is_active,created_datetime,created_db_server_date_time,company_corporate_id,company_id,created_user_info_id)
			VALUES( @param_user_menu_authorization_event_id,@param_user_info_id,@param_menu_event_id,@param_menu_id,@param_user_group_id,@param_authorization_role_id,@param_is_active,@param_created_datetime,GETDATE(),@param_company_corporate_id,@param_company_id,@param_created_user_info_id)
		END
        END
       IF(@param_DBOperation=3)
		BEGIN
			DELETE FROM Auth.User_Menu_Authorization_Event WHERE user_info_id=@param_user_info_id AND menu_id=@param_menu_id AND menu_event_id=@param_menu_event_id
		END 

	   
     
       END
    
 SELECT menu_id,menu_event_id,authorization_role_id FROM Auth.User_Menu_Authorization_Event WHERE authorization_role_id=@param_authorization_role_id
COMMIT TRAN


GO
/****** Object:  StoredProcedure [Leave].[SP_All_Leave_Policy_Get]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 15-Mar-2022
	-- Description:	This is a  Leave Policy Get store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Leave].[SP_All_Leave_Policy_Get]
	@param_company_group_id	as int,
    @param_company_id as int
AS
BEGIN
  DECLARE @pv_is_shared BIT
  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy

	SELECT S.leave_policy_id,S.leave_policy_name,s.remarks,L.leave_head_short_name,S.default_leave_balance_day,CASE WHEN (is_activation_on_joining=1) then  'After'+' '+cast(activation_days as varchar)+' '+'day of joining' else 'After'+' '+cast(activation_days as varchar) +' '+'days of confirmation' end activationdays,max_enjoyable_limit_min/8.0 max_enjoyable_limit,
	CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
	,s.is_active
	FROM Leave.Leave_Policy s
	LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
	LEFT JOIN Leave.Leave_Head L ON S.leave_head_id=L.leave_head_id
		 
	WHERE   S.company_group_id like CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE S.company_group_id END
	AND S.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE S.company_id END
	ORDER BY S.leave_policy_id DESC
END



GO
/****** Object:  StoredProcedure [Leave].[SP_Leave_Policy_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [Attendance].[SP_Leave_Policy_IUD]    Script Date: 3/14/2022 12:00:25 PM ******/


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 14-MAR-2022
	-- Description:	This is a Leave Policy Create and update and delete store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Leave].[SP_Leave_Policy_IUD]
 @param_leave_policy_id INT=0
,@param_leave_policy_name nvarchar(50)=''
,@param_code nvarchar(50)='' 
,@param_remarks nvarchar(300)=''
,@param_is_proportionate BIT=0
,@param_leave_head_id INT=0
,@param_default_leave_balance_day [decimal](18, 2)=0
,@param_default_leave_balance_min INT=0
,@param_max_enjoyable_limit_min INT=0
,@param_max_carry_leave_limit_min INT=0
,@param_max_carry_year INT=0
,@param_is_hourly BIT=0
,@param_is_attachment_required BIT=0
,@param_attachment_required_for_min INT=0
,@param_is_allow_sandwich BIT=0
,@param_is_sandwich_dayoff BIT=0
,@param_is_sandwich_holiday BIT=0
,@param_is_sandwich_uneven BIT=0
,@param_is_prefix BIT=0
,@param_is_prefix_dayoff BIT=0
,@param_is_prefix_holiday BIT=0
,@param_is_prefix_uneven BIT=0
,@param_is_sufix BIT=0
,@param_is_sufix_dayoff BIT=0
,@param_is_sufix_holiday BIT=0
,@param_is_sufix_uneven BIT=0
,@param_is_required_purpose BIT=0
,@param_purpose_required_for_min INT=0
,@param_is_leave_area_required BIT=0
,@param_area_required_for_min INT=0
,@param_is_responsible_person_required BIT=0
,@param_responsible_person_required_for_min INT=0
,@param_is_negetive_balance BIT=0
,@param_max_negetive_balance_min INT=0
,@param_notice_period INT=0
,@param_notice_required_for_min INT=0
,@param_earn_day_count INT=0
,@param_is_earn_dayoff BIT=0
,@param_is_earn_holiday BIT=0
,@param_is_earn_uneven BIT=0
,@param_is_earn_absent BIT=0
,@param_encash_leave_balance_limit_min INT=0
,@param_encash_fixed_amount decimal(18, 2)=0
,@param_encash_amount_percent INT=0
,@param_is_gross BIT=0
,@param_salary_head_id INT=0
,@param_activation_days INT=0
,@param_is_activation_on_joining BIT=0
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT
   SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
   Declare @pv_corporate_short_name nvarchar(10)
	IF (@param_DBOperation=1)
	BEGIN
	
        IF (@pv_is_shared=1 AND EXISTS (SELECT leave_policy_name FROM Leave.Leave_Policy WHERE leave_policy_name=@param_leave_policy_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF (@pv_is_shared=0 AND EXISTS (SELECT leave_policy_name FROM Leave.Leave_Policy WHERE leave_policy_name=@param_leave_policy_name AND company_id=@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
  
        SET @param_leave_policy_id= (SELECT ISNULL(MAX(ISNULL(leave_policy_id,0)),0)+1 from Leave.Leave_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_leave_policy_id)

		IF NOT EXISTS (SELECT leave_policy_id FROM Leave.Leave_Policy M WHERE m.leave_policy_id=@param_leave_policy_id)
		BEGIN
			INSERT INTO Leave.Leave_Policy 
                      ([leave_policy_id]     ,[leave_policy_name]     ,[code]     ,[remarks]     ,[is_proportionate]     ,[leave_head_id]     ,[default_leave_balance_day]     ,[default_leave_balance_min]     ,[max_enjoyable_limit_min]           ,[max_carry_leave_limit_min]        ,[max_carry_year]     ,[is_hourly]     ,[is_attachment_required]     ,[attachment_required_for_min]     ,[is_allow_sandwich]     ,[is_sandwich_dayoff]     ,[is_sandwich_holiday]     ,[is_sandwich_uneven]     ,[is_prefix]     ,[is_prefix_dayoff]     ,[is_prefix_holiday]     ,[is_prefix_uneven]     ,[is_sufix]     ,[is_sufix_dayoff]     ,[is_sufix_holiday]     ,[is_sufix_uneven]     ,[is_required_purpose]     ,[purpose_required_for_min]           ,[is_leave_area_required]     ,[area_required_for_min]     ,[is_responsible_person_required]     ,[responsible_person_required_for_min]           ,[is_negetive_balance]     ,max_negetive_balance_min          ,[notice_period]     ,[notice_required_for_min]        ,[earn_day_count]     ,[is_earn_dayoff]     ,[is_earn_holiday]     ,[is_earn_uneven]     ,[is_earn_absent]     ,[encash_leave_balance_limit_min]     ,[encash_fixed_amount]     ,[encash_amount_percent]     ,[is_gross]     ,[salary_head_id]     ,[activation_days]     ,[is_activation_on_joining]     ,created_user_id,company_corporate_id              ,company_group_id       ,company_id)
            VALUES    (@param_leave_policy_id,@param_leave_policy_name,@param_code,@param_remarks,@param_is_proportionate,@param_leave_head_id,@param_default_leave_balance_day,@param_default_leave_balance_day*60,@param_max_enjoyable_limit_min*60,@param_max_carry_leave_limit_min*60,@param_max_carry_year,@param_is_hourly,@param_is_attachment_required,@param_attachment_required_for_min*60,@param_is_allow_sandwich,@param_is_sandwich_dayoff,@param_is_sandwich_holiday,@param_is_sandwich_uneven,@param_is_prefix,@param_is_prefix_dayoff,@param_is_prefix_holiday,@param_is_prefix_uneven,@param_is_sufix,@param_is_sufix_dayoff,@param_is_sufix_holiday,@param_is_sufix_uneven,@param_is_required_purpose,@param_purpose_required_for_min*60,@param_is_leave_area_required,@param_area_required_for_min*60,@param_is_responsible_person_required,@param_responsible_person_required_for_min*60,@param_is_negetive_balance,@param_max_negetive_balance_min*60,@param_notice_period,@param_notice_required_for_min*60,@param_earn_day_count,@param_is_earn_dayoff,@param_is_earn_holiday,@param_is_earn_uneven,@param_is_earn_absent,@param_encash_leave_balance_limit_min*60,@param_encash_fixed_amount,@param_encash_amount_percent,@param_is_gross,@param_salary_head_id,@param_activation_days,@param_is_activation_on_joining,@param_created_user_id,@param_company_corporate_id,@param_company_group_id,@param_company_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF (@pv_is_shared=1 AND EXISTS (SELECT leave_policy_name FROM Leave.Leave_Policy WHERE leave_policy_name=@param_leave_policy_name AND company_group_id=@param_company_group_id AND leave_policy_id<>@param_leave_policy_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF (@pv_is_shared=0 AND EXISTS (SELECT leave_policy_name FROM Leave.Leave_Policy WHERE leave_policy_name=@param_leave_policy_name AND company_id=@param_company_id AND leave_policy_id<>@param_leave_policy_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END
   
		--Duplicate checking
		IF EXISTS (SELECT leave_policy_id FROM Leave.Leave_Policy M WHERE m.leave_policy_id=@param_leave_policy_id)
		BEGIN
	    UPDATE [Leave].[Leave_Policy]
            SET 
			[leave_policy_name] = @param_leave_policy_name
			,[code] = @param_code
			,[remarks] = @param_remarks
			,[is_proportionate] = @param_is_proportionate
			,[leave_head_id] = @param_leave_head_id
			,[default_leave_balance_day] = @param_default_leave_balance_day
			,[default_leave_balance_min] = @param_default_leave_balance_day*60
			,[max_enjoyable_limit_min] = @param_max_enjoyable_limit_min*60
			,[max_carry_leave_limit_min] = @param_max_carry_leave_limit_min*60
			,[max_carry_year] = @param_max_carry_year
			,[is_hourly] = @param_is_hourly
			,[is_attachment_required] = @param_is_attachment_required
			,[attachment_required_for_min] = @param_attachment_required_for_min*60
			,[is_allow_sandwich] = @param_is_allow_sandwich
			,[is_sandwich_dayoff] = @param_is_sandwich_dayoff
			,[is_sandwich_holiday] = @param_is_sandwich_holiday
			,[is_sandwich_uneven] = @param_is_sandwich_uneven
			,[is_prefix] = @param_is_prefix
			,[is_prefix_dayoff] = @param_is_prefix_dayoff
			,[is_prefix_holiday] = @param_is_prefix_holiday
			,[is_prefix_uneven] = @param_is_prefix_uneven
			,[is_sufix] = @param_is_sufix
			,[is_sufix_dayoff] = @param_is_sufix_dayoff
			,[is_sufix_holiday] = @param_is_sufix_holiday
			,[is_sufix_uneven] = @param_is_sufix_uneven
			,[is_required_purpose] = @param_is_required_purpose
			,[purpose_required_for_min] = @param_purpose_required_for_min*60
			,[is_leave_area_required] = @param_is_leave_area_required
			,[area_required_for_min] = @param_area_required_for_min*60
			,[is_responsible_person_required] = @param_is_responsible_person_required
			,[responsible_person_required_for_min] = @param_responsible_person_required_for_min*60
			,[is_negetive_balance] = @param_is_negetive_balance
            ,[max_negetive_balance_min]=@param_max_negetive_balance_min*60
			,[notice_period] = @param_notice_period
			,[notice_required_for_min] = @param_notice_required_for_min*60
			,[earn_day_count] = @param_earn_day_count
			,[is_earn_dayoff] = @param_is_earn_dayoff
			,[is_earn_holiday] = @param_is_earn_holiday 
			,[is_earn_uneven] = @param_is_earn_uneven
			,[is_earn_absent] = @param_is_earn_absent
			,[encash_leave_balance_limit_min] = @param_encash_leave_balance_limit_min*60
			,[encash_fixed_amount] = @param_encash_fixed_amount
			,[encash_amount_percent] = @param_encash_amount_percent
			,[is_gross] = @param_is_gross
			,[salary_head_id] = @param_salary_head_id
			,[activation_days] = @param_activation_days
			,[is_activation_on_joining] = @param_is_activation_on_joining
    
      WHERE leave_policy_id=@param_leave_policy_id
		
END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		IF EXISTS (SELECT * FROM Attendance.Attendance_Policy_Leave rm WHERE rm.leave_policy_id=@param_leave_policy_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in Late Early Policy Details.',16,1);
			RETURN
		END
	 
	
		
		--Delete  Shift_Info
		
    DELETE FROM Leave.Leave_Policy WHERE leave_policy_id=@param_leave_policy_id AND approve_user_id IS  NULL
      
	END

	IF (@param_DBOperation=4)
	BEGIN
		IF EXISTS (SELECT leave_policy_id FROM Leave.Leave_Policy M WHERE m.leave_policy_id=@param_leave_policy_id)
		BEGIN
			UPDATE Leave.Leave_Policy SET 
			 approve_user_id=@param_created_user_id
		    ,approve_date_time= GETDATE()
           
            
		    WHERE leave_policy_id=@param_leave_policy_id
		END
	END
    
    IF(@param_DBOperation=5)
     BEGIN
         DECLARE @pv_leave_policy_id AS INT      
		SET @pv_leave_policy_id= @param_leave_policy_id
		SET @param_leave_policy_id= (SELECT ISNULL(MAX(ISNULL(leave_policy_id,0)),0)+1 from Leave.Leave_Policy)
        
        SET @pv_corporate_short_name=(SELECT company_corporate_short_name FROM Administrative.Company_Corporate WHERE company_corporate_id=@param_company_corporate_id)
		
        SET @param_code=@pv_corporate_short_name+'-'+'1000'+''+Convert(nvarchar,@param_leave_policy_id)

		IF NOT EXISTS (SELECT leave_policy_id FROM Leave.Leave_Policy M WHERE m.leave_policy_id=@param_leave_policy_id)
		BEGIN
			INSERT INTO Leave.Leave_Policy  ([leave_policy_id]     ,[leave_policy_name]     ,[code]     ,[remarks]     ,[is_proportionate]     ,[leave_head_id]     ,[default_leave_balance_day]     ,[default_leave_balance_min]     ,[max_enjoyable_limit_min]     ,[max_carry_leave_limit_min]     ,[max_carry_year]     ,[is_hourly]     ,[is_attachment_required]     ,[attachment_required_for_min]     ,[is_allow_sandwich]     ,[is_sandwich_dayoff]     ,[is_sandwich_holiday]     ,[is_sandwich_uneven]     ,[is_prefix]     ,[is_prefix_dayoff]     ,[is_prefix_holiday]     ,[is_prefix_uneven]     ,[is_sufix]     ,[is_sufix_dayoff]     ,[is_sufix_holiday]     ,[is_sufix_uneven]     ,[is_required_purpose]     ,[purpose_required_for_min]     ,[is_leave_area_required]     ,[area_required_for_min]     ,[is_responsible_person_required]     ,[responsible_person_required_for_min]     ,[is_negetive_balance] ,[max_negetive_balance_min]    ,[notice_period]     ,[notice_required_for_min]     ,[earn_day_count]     ,[is_earn_dayoff]     ,[is_earn_holiday]     ,[is_earn_uneven]     ,[is_earn_absent]     ,[encash_leave_balance_limit_min]     ,[encash_fixed_amount]     ,[encash_amount_percent]     ,[is_gross]     ,[salary_head_id]     ,[activation_days]     ,[is_activation_on_joining]     ,created_user_id,company_corporate_id              ,company_group_id       ,company_id)
            SELECT @param_leave_policy_id,leave_policy_name+'_'+'Copy',[code],[remarks],[is_proportionate],[leave_head_id],[default_leave_balance_day],[default_leave_balance_min],[max_enjoyable_limit_min],[max_carry_leave_limit_min],[max_carry_year],[is_hourly],[is_attachment_required],[attachment_required_for_min],[is_allow_sandwich],[is_sandwich_dayoff],[is_sandwich_holiday],[is_sandwich_uneven],[is_prefix],[is_prefix_dayoff],[is_prefix_holiday],[is_prefix_uneven],[is_sufix],[is_sufix_dayoff],[is_sufix_holiday],[is_sufix_uneven],[is_required_purpose],[purpose_required_for_min],[is_leave_area_required],[area_required_for_min],[is_responsible_person_required],[responsible_person_required_for_min],[is_negetive_balance],max_negetive_balance_min,[notice_period],[notice_required_for_min],[earn_day_count],[is_earn_dayoff],[is_earn_holiday],[is_earn_uneven],[is_earn_absent],[encash_leave_balance_limit_min],[encash_fixed_amount],[encash_amount_percent],[is_gross],[salary_head_id],[activation_days],[is_activation_on_joining],created_user_id,company_corporate_id,company_group_id ,company_id FROM Leave.Leave_Policy WHERE leave_policy_id=@pv_leave_policy_id
		END
     END

    


		  SELECT S.leave_policy_id,S.leave_policy_name,s.remarks,L.leave_head_short_name,S.default_leave_balance_day,CASE WHEN (is_activation_on_joining=1) then  'After'+' '+cast(activation_days as varchar)+' '+'days of joining' else 'After'+' '+cast(activation_days as varchar) +' '+'days of confirmation' end activationdays,max_enjoyable_limit_min/60.0 max_enjoyable_limit,
		  CASE WHEN(approve_user_id IS NOT NULL) THEN user_name+'[' + FORMAT(approve_date_time, 'dd-MMM-yyyy') + ']' ELSE '' END approvedBy
          ,s.is_active
		  FROM Leave.Leave_Policy s
		  LEFT JOIN Auth.User_Info U ON s.approve_user_id = U.user_info_id 
          LEFT JOIN Leave.Leave_Head L ON S.leave_head_id=L.leave_head_id
		  WHERE  leave_policy_id=@param_leave_policy_id
	

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Leave].[SP_LeaveHead_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 24-Jan-2022
	-- Description:	This is a Leave head create,update and delete  store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Leave].[SP_LeaveHead_IUD]
 @param_leave_head_id INT=0
,@param_head_name NVARCHAR(50)=''
,@param_leave_head_short_name NVARCHAR(10)=''
,@param_leave_type_id_enum INT=0
,@param_required_for_id_enum INT=0
,@param_name_in_local_language NVARCHAR(100)=''
,@param_remarks NVARCHAR(500)=''
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT

	IF (@param_DBOperation=1)
	BEGIN
		SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
        	--Duplicate checking
        
		
        IF ( EXISTS (SELECT head_name FROM Leave.Leave_Head WHERE head_name=@param_head_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Leave head name must be unique. Please try another name.',16,1);
			RETURN
		END


        SET @param_leave_head_id= (SELECT ISNULL(MAX(ISNULL(leave_head_id,0)),0)+1 from Leave.Leave_Head)

		

		IF NOT EXISTS (SELECT leave_head_id FROM Leave.Leave_Head M WHERE m.leave_head_id=@param_leave_head_id)
		BEGIN
			INSERT INTO Leave.Leave_Head 
                       (leave_head_id       ,head_name        ,leave_head_short_name      ,leave_type_id_enum       ,required_for_id_enum       ,name_in_local_language       ,remarks       ,created_user_id,company_corporate_id,company_group_id)
		    VALUES	   (@param_leave_head_id,@param_head_name,@param_leave_head_short_name,@param_leave_type_id_enum,@param_required_for_id_enum,@param_name_in_local_language,@param_remarks,@param_created_user_id,@param_company_corporate_id,@param_company_group_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF ( EXISTS (SELECT leave_head_id FROM Leave.Leave_Head WHERE head_name=@param_head_name AND company_group_id=@param_company_group_id AND leave_head_id<>@param_leave_head_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Leave head name must be unique. Please try another name.',16,1);
			RETURN
		END

      
		--Duplicate checking
		IF EXISTS (SELECT leave_head_id FROM Leave.Leave_Head M WHERE m.leave_head_id=@param_leave_head_id)
		BEGIN
			 UPDATE Leave.Leave_Head SET 
			 head_name=@param_head_name
		    ,remarks= @param_remarks
            ,leave_head_short_name=@param_leave_head_short_name
            ,leave_type_id_enum=@param_leave_type_id_enum
            ,required_for_id_enum=@param_required_for_id_enum
            ,name_in_local_language=@param_name_in_local_language

		 WHERE leave_head_id=@param_leave_head_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
	
		
		--Delete  Leave_Head
		
    DELETE FROM Leave.Leave_Head  WHERE leave_head_id=@param_leave_head_id
      
	END

	

	 SELECT * FROM Leave.Leave_Head WHERE leave_head_id=@param_leave_head_id
     
	

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Party].[SP_Dealer_Contact_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Party].[SP_Dealer_Contact_Info_IUD]
	@param_dealer_contact_info_id int=0
	,@param_dealer_info_id int=0
	,@param_dealer_contact_info_code NVARCHAR(20)=''
	,@param_person_name NVARCHAR(10)=''
	,@param_person_designation NVARCHAR(100)=''
	,@param_father_name NVARCHAR(100)=''
	,@param_mother_name NVARCHAR(100)=''
	,@param_date_of_birth DATE=''
	,@param_religion_enum_id tinyint=0
	,@param_nationality NVARCHAR(20)=''
	,@param_national_id_no NVARCHAR(20)=''
	,@param_birth_certificate_no NVARCHAR(20)=''
	,@param_passport_no NVARCHAR(20)=''
	,@param_mobile NVARCHAR(50)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_emergency_contact NVARCHAR(100)=''
	,@param_blood_group_enum_id tinyint=0
	,@param_image_path NVARCHAR(300)=''
	,@param_permanent_country_id int=0
	,@param_permanent_division_id int=0
	,@param_permanent_district_id int=0
	,@param_permanent_thana_id int=0
	,@param_permanent_zone_id int=0
	,@param_permanent_city NVARCHAR(50)=''
	,@param_permanent_post_code NVARCHAR(50)=''
	,@param_permanent_block NVARCHAR(150)=''
	,@param_permanent_road_no NVARCHAR(150)=''
	,@param_permanent_house_no NVARCHAR(150)=''
	,@param_permanent_flat_no NVARCHAR(50)=''
	,@param_present_country_id int=0
	,@param_present_division_id int=0
	,@param_present_district_id int=0
	,@param_present_thana_id int=0
	,@param_present_zone_id int=0
	,@param_present_city NVARCHAR(50)=''
	,@param_present_post_code NVARCHAR(50)=''
	,@param_present_block NVARCHAR(150)=''
	,@param_present_road_no NVARCHAR(150)=''
	,@param_present_house_no NVARCHAR(150)=''
	,@param_present_flat_no NVARCHAR(50)=''
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT dealer_contact_info_code FROM Party.Dealer_Contact_Info WHERE dealer_contact_info_code=@param_dealer_contact_info_code)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Dealer code must be unique. Please try another code.',16,1);
			RETURN
		END
		
        SET @param_dealer_contact_info_id= (SELECT ISNULL(MAX(ISNULL(dealer_contact_info_id,0)),0)+1 from Party.Dealer_Contact_Info)
				
		IF NOT EXISTS (SELECT dealer_contact_info_id FROM Party.Dealer_Contact_Info DI WHERE DI.dealer_contact_info_id=@param_dealer_contact_info_id)
		BEGIN
			INSERT INTO Party.Dealer_Contact_Info 
                       (
						dealer_contact_info_id
						,dealer_info_id
						,dealer_contact_info_code
						,person_name
						,person_designation
						,father_name
						,mother_name
						,date_of_birth
						,religion_enum_id
						,nationality
						,national_id_no
						,birth_certificate_no
						,passport_no
						,mobile
						,phone
						,email
						,emergency_contact
						,blood_group_enum_id
						,image_path
						,permanent_country_id
						,permanent_division_id
						,permanent_district_id
						,permanent_thana_id
						,permanent_zone_id
						,permanent_city
						,permanent_post_code
						,permanent_block
						,permanent_road_no
						,permanent_house_no
						,permanent_flat_no
						,present_country_id
						,present_division_id
						,present_district_id
						,present_thana_id
						,present_zone_id
						,present_city
						,present_post_code
						,present_block
						,present_road_no
						,present_house_no
						,present_flat_no
						,created_datetime
						,db_server_date_time
						,created_user_info_id
						)
		    VALUES	   (
						@param_dealer_contact_info_id
						,@param_dealer_info_id
						,@param_dealer_contact_info_id ---param_dealer_contact_info_code
						,@param_person_name
						,@param_person_designation
						,@param_father_name
						,@param_mother_name
						,@param_date_of_birth
						,@param_religion_enum_id
						,@param_nationality
						,@param_national_id_no
						,@param_birth_certificate_no
						,@param_passport_no
						,@param_mobile
						,@param_phone
						,@param_email
						,@param_emergency_contact
						,@param_blood_group_enum_id
						,@param_image_path
						,@param_permanent_country_id
						,@param_permanent_division_id
						,@param_permanent_district_id
						,@param_permanent_thana_id
						,@param_permanent_zone_id
						,@param_permanent_city
						,@param_permanent_post_code
						,@param_permanent_block
						,@param_permanent_road_no
						,@param_permanent_house_no
						,@param_permanent_flat_no
						,@param_present_country_id
						,@param_present_division_id
						,@param_present_district_id
						,@param_present_thana_id
						,@param_present_zone_id
						,@param_present_city
						,@param_present_post_code
						,@param_present_block
						,@param_present_road_no
						,@param_present_house_no
						,@param_present_flat_no
						,@param_created_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id

						)
			END
		
	END  ----Data Inserted Begin End
    
    IF (@param_DBOperation=2)
			BEGIN  
					UPDATE Party.Dealer_Contact_Info SET 
					dealer_info_id=@param_dealer_info_id
					,dealer_contact_info_code=@param_dealer_contact_info_code
					,person_name=@param_person_name
					,person_designation=@param_person_designation
					,father_name=@param_father_name
					,mother_name=@param_mother_name
					,date_of_birth=@param_date_of_birth
					,religion_enum_id=@param_religion_enum_id
					,nationality=@param_nationality
					,national_id_no=@param_national_id_no
					,birth_certificate_no=@param_birth_certificate_no
					,passport_no=@param_passport_no
					,mobile=@param_mobile
					,phone=@param_phone
					,email=@param_email
					,emergency_contact=@param_emergency_contact
					,blood_group_enum_id=@param_blood_group_enum_id
					,image_path=@param_image_path
					,permanent_country_id=@param_permanent_country_id
					,permanent_division_id=@param_permanent_division_id
					,permanent_district_id=@param_permanent_district_id
					,permanent_thana_id=@param_permanent_thana_id
					,permanent_zone_id=@param_permanent_zone_id
					,permanent_city=@param_permanent_city
					,permanent_post_code=@param_permanent_post_code
					,permanent_block=@param_permanent_block
					,permanent_road_no=@param_permanent_road_no
					,permanent_house_no=@param_permanent_house_no
					,permanent_flat_no=@param_permanent_flat_no
					,present_country_id=@param_present_country_id
					,present_division_id=@param_present_division_id
					,present_district_id=@param_present_district_id
					,present_thana_id=@param_present_thana_id
					,present_zone_id=@param_present_zone_id
					,present_city=@param_present_city
					,present_post_code=@param_present_post_code
					,present_block=@param_present_block
					,present_road_no=@param_present_road_no
					,present_house_no=@param_present_house_no
					,present_flat_no=@param_present_flat_no
					,created_datetime=@param_created_datetime
					,db_server_date_time=@param_db_server_date_time
					,created_user_info_id=@param_created_user_info_id
					WHERE dealer_contact_info_id=@param_dealer_contact_info_id
				
			END ------Data Updated Begin End

	IF (@param_DBOperation=3)

			BEGIN		
				--Delete  authorization
				
			DELETE FROM Party.Dealer_Contact_Info WHERE dealer_contact_info_id=@param_dealer_contact_info_id
			  
			END ------Data Delated Begin End

		------Data Selected 
		SELECT * FROM Party.Dealer_Contact_Info WHERE dealer_contact_info_id=@param_dealer_contact_info_id

COMMIT TRAN
GO
/****** Object:  StoredProcedure [Party].[SP_Dealer_Document_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Party].[SP_Dealer_Document_Info_IUD]
	@param_dealer_document_info_id int=0
	,@param_dealer_info_id int=0
	,@param_document_type_id int=0
	,@param_document_number NVARCHAR(50)=''
	,@param_issue_date DATE=''
	,@param_expiry_date DATE=''
	,@param_image_file NVARCHAR(100)=''
	,@param_is_verified bit=1 
	,@param_is_complete bit=1 
	,@param_status NVARCHAR(50)=''
	,@param_remarks NVARCHAR(300)=''
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
 
        SET @param_dealer_document_info_id= (SELECT ISNULL(MAX(ISNULL(dealer_document_info_id,0)),0)+1 from Party.Dealer_Document_Info)
				
		IF NOT EXISTS (SELECT dealer_document_info_id FROM Party.Dealer_Document_Info DI WHERE DI.dealer_document_info_id=@param_dealer_document_info_id)
		BEGIN
			INSERT INTO Party.Dealer_Document_Info 
                       (
						 dealer_document_info_id
						,dealer_info_id
						,document_type_id
						,document_number
						,issue_date
						,expiry_date
						,image_file
						,is_verified
						,is_complete
						,status
						,remarks
						,created_datetime
						,db_server_date_time
						,created_user_info_id
				
						)
		    VALUES	   (
						@param_dealer_document_info_id
						,@param_dealer_info_id
						,@param_document_type_id
						,@param_document_number
						,@param_issue_date
						,@param_expiry_date
						,@param_image_file
						,@param_is_verified
						,@param_is_complete
						,@param_status
						,@param_remarks
						,@param_created_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id
						)
			END
		
	END ----Data Inserted Begin End 
    
    IF (@param_DBOperation=2)
			BEGIN
  
					UPDATE Party.Dealer_Document_Info SET 
							dealer_document_info_id=@param_dealer_document_info_id
							,dealer_info_id=@param_dealer_info_id
							,document_type_id=@param_document_type_id
							,document_number=@param_document_number
							,issue_date=@param_issue_date
							,expiry_date=@param_expiry_date
							,image_file=@param_image_file
							,is_verified=@param_is_verified
							,is_complete=@param_is_complete
							,status=@param_status
							,remarks=@param_remarks
							,created_datetime=@param_created_datetime
							,db_server_date_time=@param_db_server_date_time
							,created_user_info_id=@param_created_user_info_id				
					WHERE dealer_document_info_id=@param_dealer_document_info_id
				
			END  ----Data Updated Begin End

	IF (@param_DBOperation=3)
			BEGIN
				
				--Delete  authorization
				
			DELETE FROM Party.Dealer_Document_Info WHERE dealer_document_info_id=@param_dealer_document_info_id
			  
			END  ----Data Deleted Begin End
		------Data Selected 
		SELECT * FROM Party.Dealer_Document_Info WHERE dealer_document_info_id=@param_dealer_document_info_id

COMMIT TRAN 
GO
/****** Object:  StoredProcedure [Party].[SP_Dealer_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Zahangir Alam Jahid
	-- Create date: 13-Feb-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

*/

CREATE PROCEDURE [Party].[SP_Dealer_Info_IUD]
	@param_dealer_info_id int=0
	,@param_company_corporate_id int=0
	,@param_company_group_id int=0
	,@param_company_id int=0
	,@param_dealer_info_code NVARCHAR(20)=''
	,@param_dealer_info_short_name NVARCHAR(10)=''
	,@param_dealer_info_name NVARCHAR(100)=''
	,@param_dealer_info_display_name NVARCHAR(100)=''
	,@param_trade_license NVARCHAR(20)=''
	,@param_year_established DATE=''
	,@param_TIN NVARCHAR(20)=''
	,@param_BIN NVARCHAR(20)=''
	,@param_domicile_enum_id tinyint=0
	,@param_business_type_enum_id tinyint=0
	,@param_industry_sector_id int=0
	,@param_industry_sub_sector_id int=0
	,@param_ownership_type_id int=0
	,@param_organazation_type_enum_id tinyint=0
	,@param_registry_authority_id int=0
	,@param_regulator_id int=0
	,@param_currency_id int=0
	,@param_security_type_enum_id tinyint=0
	,@param_prefered_method_enum_id tinyint=0
	,@param_internal_credit_rating DECIMAL(18,2)=0
	,@param_allowable_credit DECIMAL(18,2)=0
	,@param_maximum_credit DECIMAL(18,2)=0
	,@param_credit_days DECIMAL(18,2)=0
	,@param_mobile NVARCHAR(20)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_web_url NVARCHAR(100)=''
	,@param_logo_path NVARCHAR(100)=''
	,@param_continent_enum_id tinyint=0
	,@param_country_id int=0
	,@param_division_id int=0
	,@param_district_id int=0
	,@param_thana_id int=0
	,@param_zone_id int=0
	,@param_city NVARCHAR(50)=''
	,@param_post_code NVARCHAR(50)=''
	,@param_block NVARCHAR(150)=''
	,@param_road_no NVARCHAR(150)=''
	,@param_house_no NVARCHAR(150)=''
	,@param_flat_no NVARCHAR(50)=''
	,@param_address_note NVARCHAR(50)=''
	,@param_is_active bit=1 
	,@param_created_datetime DATETIME=''
	,@param_updated_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_updated_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT dealer_info_code FROM Party.Dealer_Info WHERE dealer_info_code=@param_dealer_info_code AND company_id<>@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Dealer code must be unique. Please try another code.',16,1);
			RETURN
		END
		IF (EXISTS (SELECT dealer_info_short_name FROM Party.Dealer_Info WHERE dealer_info_short_name=@param_dealer_info_short_name AND company_id<>@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Dealer short name must be unique. Please try another short name.',16,1);
			RETURN
		END

        SET @param_dealer_info_id= (SELECT ISNULL(MAX(ISNULL(dealer_info_id,0)),0)+1 from Party.Dealer_Info)
				
		IF NOT EXISTS (SELECT dealer_info_id FROM Party.Dealer_Info DI WHERE DI.dealer_info_id=@param_dealer_info_id)
		BEGIN
			INSERT INTO Party.Dealer_Info 
                       (
						dealer_info_id
						,company_corporate_id
						,company_group_id
						,company_id
						,dealer_info_code
						,dealer_info_short_name
						,dealer_info_name
						,dealer_info_display_name
						,trade_license
						,year_established
						,TIN
						,BIN
						,domicile_enum_id
						,business_type_enum_id
						,industry_sector_id
						,industry_sub_sector_id
						,ownership_type_id
						,organazation_type_enum_id
						,registry_authority_id
						,regulator_id
						,currency_id
						,security_type_enum_id
						,prefered_method_enum_id
						,internal_credit_rating
						,allowable_credit
						,maximum_credit
						,credit_days
						,mobile
						,phone
						,email
						,web_url
						,logo_path
						,continent_enum_id
						,country_id
						,division_id
						,district_id
						,thana_id
						,zone_id
						,city
						,post_code
						,[block]
						,road_no
						,house_no
						,flat_no
						,address_note
						,is_active
						,created_datetime
						,updated_datetime
						,db_server_date_time
						,created_user_info_id
						,updated_user_info_id
						)
		    VALUES	   (
						@param_dealer_info_id
						,@param_company_corporate_id
						,@param_company_group_id
						,@param_company_id
						,@param_dealer_info_id ---@param_dealer_info_code
						,@param_dealer_info_short_name
						,@param_dealer_info_name
						,@param_dealer_info_display_name
						,@param_trade_license
						,@param_year_established
						,@param_TIN
						,@param_BIN
						,@param_domicile_enum_id
						,@param_business_type_enum_id
						,@param_industry_sector_id
						,@param_industry_sub_sector_id
						,@param_ownership_type_id
						,@param_organazation_type_enum_id
						,@param_registry_authority_id
						,@param_regulator_id
						,@param_currency_id
						,@param_security_type_enum_id
						,@param_prefered_method_enum_id
						,@param_internal_credit_rating
						,@param_allowable_credit
						,@param_maximum_credit
						,@param_credit_days
						,@param_mobile
						,@param_phone
						,@param_email
						,@param_web_url
						,@param_logo_path
						,@param_continent_enum_id
						,@param_country_id
						,@param_division_id
						,@param_district_id
						,@param_thana_id
						,@param_zone_id
						,@param_city
						,@param_post_code
						,@param_block
						,@param_road_no
						,@param_house_no
						,@param_flat_no
						,@param_address_note
						,@param_is_active
						,@param_created_datetime
						,@param_updated_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id
						,@param_updated_user_info_id
						)
			END
		
	END  ----Data Inserted Begin End
    
    IF (@param_DBOperation=2)
			BEGIN
  
					UPDATE Party.Dealer_Info SET 
					company_corporate_id=@param_company_corporate_id
					,company_group_id=@param_company_group_id
					,company_id=@param_company_id
					,dealer_info_code=@param_dealer_info_code
					,dealer_info_short_name=@param_dealer_info_short_name
					,dealer_info_name=@param_dealer_info_name
					,dealer_info_display_name=@param_dealer_info_display_name
					,trade_license=@param_trade_license
					,year_established=@param_year_established
					,TIN=@param_TIN
					,BIN=@param_BIN
					,domicile_enum_id=@param_domicile_enum_id
					,business_type_enum_id=@param_business_type_enum_id
					,industry_sector_id=@param_industry_sector_id
					,industry_sub_sector_id=@param_industry_sub_sector_id
					,ownership_type_id=@param_ownership_type_id
					,organazation_type_enum_id=@param_organazation_type_enum_id
					,registry_authority_id=@param_registry_authority_id
					,regulator_id=@param_regulator_id
					,currency_id=@param_currency_id
					,security_type_enum_id=@param_security_type_enum_id
					,prefered_method_enum_id=@param_prefered_method_enum_id
					,internal_credit_rating=@param_internal_credit_rating
					,allowable_credit=@param_allowable_credit
					,maximum_credit=@param_maximum_credit
					,credit_days=@param_credit_days
					,mobile=@param_mobile
					,phone=@param_phone
					,email=@param_email
					,web_url=@param_web_url
					,logo_path=@param_logo_path
					,continent_enum_id=@param_continent_enum_id
					,country_id=@param_country_id
					,division_id=@param_division_id
					,district_id=@param_district_id
					,thana_id=@param_thana_id
					,zone_id=@param_zone_id
					,city=@param_city
					,post_code=@param_post_code
					,[block]=@param_block
					,road_no=@param_road_no
					,house_no=@param_house_no
					,flat_no=@param_flat_no
					,address_note=@param_address_note
					,updated_datetime=@param_updated_datetime
					,updated_user_info_id=@param_updated_user_info_id
					WHERE dealer_info_id=@param_dealer_info_id
				
			END  ----Data Updated Begin End

	IF (@param_DBOperation=3)
			BEGIN
				
				--Delete  authorization
				
			DELETE FROM Party.Dealer_Info WHERE dealer_info_id=@param_dealer_info_id
			  
			END ----Data Deleted Begin End

		------Data Selected 
		SELECT * FROM Party.Dealer_Info WHERE dealer_info_id=@param_dealer_info_id

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Party].[SP_Dealer_Location_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Party].[SP_Dealer_Location_Info_IUD]
	@param_dealer_location_info_id int=0
	,@param_dealer_info_id int=0
	,@param_dealer_location_info_code NVARCHAR(20)=''
	,@param_dealer_location_info_name NVARCHAR(10)=''
	,@param_dealer_location_info_short_name NVARCHAR(100)=''
	,@param_trade_license NVARCHAR(20)=''
	,@param_trade_license_date DATE=''
	,@param_mobile NVARCHAR(50)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_emergency_contact NVARCHAR(100)=''
	,@param_country_id int=0
	,@param_division_id int=0
	,@param_district_id int=0
	,@param_thana_id int=0
	,@param_city NVARCHAR(50)=''
	,@param_post_code NVARCHAR(50)=''
	,@param_block NVARCHAR(150)=''
	,@param_road_no NVARCHAR(150)=''
	,@param_house_no NVARCHAR(150)=''
	,@param_flat_no NVARCHAR(50)=''
	,@param_address_note NVARCHAR(50)=''
	,@param_is_active bit=1 
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT dealer_location_info_code FROM Party.Dealer_Location_Info WHERE dealer_location_info_code=@param_dealer_location_info_code)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Dealer location code must be unique. Please try another code.',16,1);
			RETURN
		END
		
        SET @param_dealer_location_info_id= (SELECT ISNULL(MAX(ISNULL(dealer_location_info_id,0)),0)+1 from Party.Dealer_Location_Info)
				
		IF NOT EXISTS (SELECT dealer_location_info_id FROM Party.Dealer_Location_Info DI WHERE DI.dealer_location_info_id=@param_dealer_location_info_id)
		BEGIN
			INSERT INTO Party.Dealer_Location_Info 
                       (
					    dealer_location_info_id
					   ,dealer_info_id
					   ,dealer_location_info_code
					   ,dealer_location_info_name
					   ,dealer_location_info_short_name
					   ,trade_license
					   ,trade_license_date
					   ,mobile
					   ,phone
					   ,email
					   ,emergency_contact
					   ,country_id
					   ,division_id
					   ,district_id
					   ,thana_id
					   ,city
					   ,post_code
					   ,block
					   ,road_no
					   ,house_no
					   ,flat_no
					   ,address_note
					   ,is_active
					   ,created_datetime
					   ,db_server_date_time
					   ,created_user_info_id						
						)
		    VALUES	   (
						@param_dealer_location_info_id
						,@param_dealer_info_id
						,@param_dealer_location_info_id ---param_dealer_location_info_code
						,@param_dealer_location_info_name
						,@param_dealer_location_info_short_name
						,@param_trade_license
						,@param_trade_license_date
						,@param_mobile
						,@param_phone
						,@param_email
						,@param_emergency_contact
						,@param_country_id
						,@param_division_id
						,@param_district_id
						,@param_thana_id
						,@param_city
						,@param_post_code
						,@param_block
						,@param_road_no
						,@param_house_no
						,@param_flat_no
						,@param_address_note
						,@param_is_active
						,@param_created_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id
						)
			END
		
	END ----Data Inserted Begin End 
    
    IF (@param_DBOperation=2)
			BEGIN
  
					UPDATE Party.Dealer_Location_Info SET 
							dealer_info_id=@param_dealer_info_id
							,dealer_location_info_code=@param_dealer_location_info_code
							,dealer_location_info_name=@param_dealer_location_info_name
							,dealer_location_info_short_name=@param_dealer_location_info_short_name
							,trade_license=@param_trade_license
							,trade_license_date=@param_trade_license_date
							,mobile=@param_mobile
							,phone=@param_phone
							,email=@param_email
							,emergency_contact=@param_emergency_contact
							,country_id=@param_country_id
							,division_id=@param_division_id
							,district_id=@param_district_id
							,thana_id=@param_thana_id
							,city=@param_city
							,post_code=@param_post_code
							,block=@param_block
							,road_no=@param_road_no
							,house_no=@param_house_no
							,flat_no=@param_flat_no
							,address_note=@param_address_note
							,is_active=@param_is_active
							,created_datetime=@param_created_datetime
							,db_server_date_time=@param_db_server_date_time
							,created_user_info_id=@param_created_user_info_id					
					WHERE dealer_location_info_id=@param_dealer_location_info_id
				
			END  ----Data Updated Begin End

	IF (@param_DBOperation=3)
			BEGIN
				
				--Delete  authorization
				
			DELETE FROM Party.Dealer_Location_Info WHERE dealer_location_info_id=@param_dealer_location_info_id
			  
			END  ----Data Deleted Begin End
		------Data Selected 
		SELECT * FROM Party.Dealer_Location_Info WHERE dealer_location_info_id=@param_dealer_location_info_id

COMMIT TRAN 
GO
/****** Object:  StoredProcedure [Party].[SP_Retailer_Contact_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Party].[SP_Retailer_Contact_Info_IUD]
	@param_retailer_contact_info_id int=0
	,@param_retailer_info_id int=0
	,@param_retailer_contact_info_code NVARCHAR(20)=''
	,@param_person_name NVARCHAR(10)=''
	,@param_person_designation NVARCHAR(100)=''
	,@param_father_name NVARCHAR(100)=''
	,@param_mother_name NVARCHAR(100)=''
	,@param_date_of_birth DATE=''
	,@param_religion_enum_id tinyint=0
	,@param_nationality NVARCHAR(20)=''
	,@param_national_id_no NVARCHAR(20)=''
	,@param_birth_certificate_no NVARCHAR(20)=''
	,@param_passport_no NVARCHAR(20)=''
	,@param_mobile NVARCHAR(50)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_emergency_contact NVARCHAR(100)=''
	,@param_blood_group_enum_id tinyint=0
	,@param_image_path NVARCHAR(300)=''
	,@param_permanent_country_id int=0
	,@param_permanent_division_id int=0
	,@param_permanent_district_id int=0
	,@param_permanent_thana_id int=0
	,@param_permanent_zone_id int=0
	,@param_permanent_city NVARCHAR(50)=''
	,@param_permanent_post_code NVARCHAR(50)=''
	,@param_permanent_block NVARCHAR(150)=''
	,@param_permanent_road_no NVARCHAR(150)=''
	,@param_permanent_house_no NVARCHAR(150)=''
	,@param_permanent_flat_no NVARCHAR(50)=''
	,@param_present_country_id int=0
	,@param_present_division_id int=0
	,@param_present_district_id int=0
	,@param_present_thana_id int=0
	,@param_present_zone_id int=0
	,@param_present_city NVARCHAR(50)=''
	,@param_present_post_code NVARCHAR(50)=''
	,@param_present_block NVARCHAR(150)=''
	,@param_present_road_no NVARCHAR(150)=''
	,@param_present_house_no NVARCHAR(150)=''
	,@param_present_flat_no NVARCHAR(50)=''
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT retailer_contact_info_code FROM Party.Retailer_Contact_Info WHERE retailer_contact_info_code=@param_retailer_contact_info_code)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Retailer code must be unique. Please try another code.',16,1);
			RETURN
		END
		
        SET @param_retailer_contact_info_id= (SELECT ISNULL(MAX(ISNULL(retailer_contact_info_id,0)),0)+1 from Party.Retailer_Contact_Info)
				
		IF NOT EXISTS (SELECT retailer_contact_info_id FROM Party.Retailer_Contact_Info DI WHERE DI.retailer_contact_info_id=@param_retailer_contact_info_id)
		BEGIN
			INSERT INTO Party.Retailer_Contact_Info 
                       (
						retailer_contact_info_id
						,retailer_info_id
						,retailer_contact_info_code
						,person_name
						,person_designation
						,father_name
						,mother_name
						,date_of_birth
						,religion_enum_id
						,nationality
						,national_id_no
						,birth_certificate_no
						,passport_no
						,mobile
						,phone
						,email
						,emergency_contact
						,blood_group_enum_id
						,image_path
						,permanent_country_id
						,permanent_division_id
						,permanent_district_id
						,permanent_thana_id
						,permanent_zone_id
						,permanent_city
						,permanent_post_code
						,permanent_block
						,permanent_road_no
						,permanent_house_no
						,permanent_flat_no
						,present_country_id
						,present_division_id
						,present_district_id
						,present_thana_id
						,present_zone_id
						,present_city
						,present_post_code
						,present_block
						,present_road_no
						,present_house_no
						,present_flat_no
						,created_datetime
						,db_server_date_time
						,created_user_info_id
						)
		    VALUES	   (
						@param_retailer_contact_info_id
						,@param_retailer_info_id
						,@param_retailer_contact_info_id  --param_retailer_contact_info_code
						,@param_person_name
						,@param_person_designation
						,@param_father_name
						,@param_mother_name
						,@param_date_of_birth
						,@param_religion_enum_id
						,@param_nationality
						,@param_national_id_no
						,@param_birth_certificate_no
						,@param_passport_no
						,@param_mobile
						,@param_phone
						,@param_email
						,@param_emergency_contact
						,@param_blood_group_enum_id
						,@param_image_path
						,@param_permanent_country_id
						,@param_permanent_division_id
						,@param_permanent_district_id
						,@param_permanent_thana_id
						,@param_permanent_zone_id
						,@param_permanent_city
						,@param_permanent_post_code
						,@param_permanent_block
						,@param_permanent_road_no
						,@param_permanent_house_no
						,@param_permanent_flat_no
						,@param_present_country_id
						,@param_present_division_id
						,@param_present_district_id
						,@param_present_thana_id
						,@param_present_zone_id
						,@param_present_city
						,@param_present_post_code
						,@param_present_block
						,@param_present_road_no
						,@param_present_house_no
						,@param_present_flat_no
						,@param_created_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id

						)
			END
		
	END  ----Data Inserted Begin End
    
    IF (@param_DBOperation=2)
			BEGIN  
					UPDATE Party.Retailer_Contact_Info SET 
					retailer_info_id=@param_retailer_info_id
					,retailer_contact_info_code=@param_retailer_contact_info_code
					,person_name=@param_person_name
					,person_designation=@param_person_designation
					,father_name=@param_father_name
					,mother_name=@param_mother_name
					,date_of_birth=@param_date_of_birth
					,religion_enum_id=@param_religion_enum_id
					,nationality=@param_nationality
					,national_id_no=@param_national_id_no
					,birth_certificate_no=@param_birth_certificate_no
					,passport_no=@param_passport_no
					,mobile=@param_mobile
					,phone=@param_phone
					,email=@param_email
					,emergency_contact=@param_emergency_contact
					,blood_group_enum_id=@param_blood_group_enum_id
					,image_path=@param_image_path
					,permanent_country_id=@param_permanent_country_id
					,permanent_division_id=@param_permanent_division_id
					,permanent_district_id=@param_permanent_district_id
					,permanent_thana_id=@param_permanent_thana_id
					,permanent_zone_id=@param_permanent_zone_id
					,permanent_city=@param_permanent_city
					,permanent_post_code=@param_permanent_post_code
					,permanent_block=@param_permanent_block
					,permanent_road_no=@param_permanent_road_no
					,permanent_house_no=@param_permanent_house_no
					,permanent_flat_no=@param_permanent_flat_no
					,present_country_id=@param_present_country_id
					,present_division_id=@param_present_division_id
					,present_district_id=@param_present_district_id
					,present_thana_id=@param_present_thana_id
					,present_zone_id=@param_present_zone_id
					,present_city=@param_present_city
					,present_post_code=@param_present_post_code
					,present_block=@param_present_block
					,present_road_no=@param_present_road_no
					,present_house_no=@param_present_house_no
					,present_flat_no=@param_present_flat_no
					,created_datetime=@param_created_datetime
					,db_server_date_time=@param_db_server_date_time
					,created_user_info_id=@param_created_user_info_id
					WHERE retailer_contact_info_id=@param_retailer_contact_info_id
				
			END ------Data Updated Begin End

	IF (@param_DBOperation=3)

			BEGIN		
				--Delete  authorization
				
			DELETE FROM Party.Retailer_Contact_Info WHERE retailer_contact_info_id=@param_retailer_contact_info_id
			  
			END ------Data Delated Begin End

		------Data Selected 
		SELECT * FROM Party.Retailer_Contact_Info WHERE retailer_contact_info_id=@param_retailer_contact_info_id

COMMIT TRAN
GO
/****** Object:  StoredProcedure [Party].[SP_Retailer_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Party].[SP_Retailer_Info_IUD]
	@param_retailer_info_id int=0
	,@param_company_corporate_id int=0
	,@param_company_group_id int=0
	,@param_company_id int=0
	,@param_dealer_info_id int=0
	,@param_retailer_info_code NVARCHAR(20)=''
	,@param_retailer_info_name NVARCHAR(10)=''
	,@param_retailer_info_short_name NVARCHAR(100)=''
	,@param_trade_license NVARCHAR(20)=''
	,@param_trade_license_date DATE=''
	,@param_TIN NVARCHAR(50)=''
	,@param_BIN NVARCHAR(50)=''
	,@param_domicile_enum_id tinyint=0
	,@param_business_type_enum_id tinyint=0
	,@param_industry_sector_id int=0
	,@param_industry_sub_sector_id int=0
	,@param_ownership_type_id int=0
	,@param_currency_id int=0
	,@param_mobile NVARCHAR(50)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_web_url NVARCHAR(100)=''
	,@param_image_path NVARCHAR(100)=''
	,@param_country_id int=0
	,@param_division_id int=0
	,@param_district_id int=0
	,@param_thana_id int=0
	,@param_zone_id int=0
	,@param_city NVARCHAR(50)=''
	,@param_post_code NVARCHAR(50)=''
	,@param_block NVARCHAR(150)=''
	,@param_road_no NVARCHAR(150)=''
	,@param_house_no NVARCHAR(150)=''
	,@param_flat_no NVARCHAR(50)=''
	,@param_address_note NVARCHAR(50)=''
	,@param_is_active bit=1 
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT retailer_info_code FROM Party.Retailer_Info WHERE retailer_info_code=@param_retailer_info_code)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Retailer code must be unique. Please try another code.',16,1);
			RETURN
		END
		
        SET @param_retailer_info_id= (SELECT ISNULL(MAX(ISNULL(retailer_info_id,0)),0)+1 from Party.Retailer_Info)
				
		IF NOT EXISTS (SELECT retailer_info_id FROM Party.Retailer_Info DI WHERE DI.retailer_info_id=@param_retailer_info_id)
		BEGIN
			INSERT INTO Party.Retailer_Info 
                       (
					    retailer_info_id
					   ,company_corporate_id
					   ,company_group_id
					   ,company_id
					   ,dealer_info_id
					   ,retailer_info_code
					   ,retailer_info_name
					   ,retailer_info_short_name
					   ,trade_license
					   ,trade_license_date
					   ,TIN
					   ,BIN
					   ,domicile_enum_id
					   ,business_type_enum_id
					   ,industry_sector_id
					   ,industry_sub_sector_id
					   ,ownership_type_id
					   ,currency_id
					   ,mobile
					   ,phone
					   ,email
					   ,web_url
					   ,image_path
					   ,country_id
					   ,division_id
					   ,district_id
					   ,thana_id
					   ,zone_id
					   ,city
					   ,post_code
					   ,block
					   ,road_no
					   ,house_no
					   ,flat_no
					   ,address_note
					   ,is_active
					   ,created_datetime
					   ,db_server_date_time
					   ,created_user_info_id					
						)
		    VALUES	   (
						  @param_retailer_info_id
						 ,@param_company_corporate_id
						 ,@param_company_group_id
						 ,@param_company_id
						 ,@param_dealer_info_id
						 ,@param_retailer_info_id ---param_retailer_info_code
						 ,@param_retailer_info_name
						 ,@param_retailer_info_short_name
						 ,@param_trade_license
						 ,@param_trade_license_date
						 ,@param_TIN
						 ,@param_BIN
						 ,@param_domicile_enum_id
						 ,@param_business_type_enum_id
						 ,@param_industry_sector_id
						 ,@param_industry_sub_sector_id
						 ,@param_ownership_type_id
						 ,@param_currency_id
						 ,@param_mobile
						 ,@param_phone
						 ,@param_email
						 ,@param_web_url
						 ,@param_image_path
						 ,@param_country_id
						 ,@param_division_id
						 ,@param_district_id
						 ,@param_thana_id
						 ,@param_zone_id
						 ,@param_city
						 ,@param_post_code
						 ,@param_block
						 ,@param_road_no
						 ,@param_house_no
						 ,@param_flat_no
						 ,@param_address_note
						 ,@param_is_active
						 ,@param_created_datetime
						 ,@param_db_server_date_time
						 ,@param_created_user_info_id	
						)
			END
		
	END ----Data Inserted Begin End 
    
    IF (@param_DBOperation=2)
			BEGIN
  
					UPDATE Party.Retailer_Info SET 
							company_corporate_id=@param_company_corporate_id
							,company_group_id=@param_company_group_id
							,company_id=@param_company_id
							,dealer_info_id=@param_dealer_info_id
							,retailer_info_code=@param_retailer_info_code
							,retailer_info_name=@param_retailer_info_name
							,retailer_info_short_name=@param_retailer_info_short_name
							,trade_license=@param_trade_license
							,trade_license_date=@param_trade_license_date
							,TIN=@param_TIN
							,BIN=@param_BIN
							,domicile_enum_id=@param_domicile_enum_id
							,business_type_enum_id=@param_business_type_enum_id
							,industry_sector_id=@param_industry_sector_id
							,industry_sub_sector_id=@param_industry_sub_sector_id
							,ownership_type_id=@param_ownership_type_id
							,currency_id=@param_currency_id
							,mobile=@param_mobile
							,phone=@param_phone
							,email=@param_email
							,web_url=@param_web_url
							,image_path=@param_image_path
							,country_id=@param_country_id
							,division_id=@param_division_id
							,district_id=@param_district_id
							,thana_id=@param_thana_id
							,zone_id=@param_zone_id
							,city=@param_city
							,post_code=@param_post_code
							,block=@param_block
							,road_no=@param_road_no
							,house_no=@param_house_no
							,flat_no=@param_flat_no
							,address_note=@param_address_note
					WHERE retailer_info_id=@param_retailer_info_id
				
			END  ----Data Updated Begin End

	IF (@param_DBOperation=3)
			BEGIN
				
				--Delete  authorization
				
			DELETE FROM Party.Retailer_Info WHERE retailer_info_id=@param_retailer_info_id
			  
			END  ----Data Deleted Begin End
		------Data Selected 
		SELECT * FROM Party.Retailer_Info WHERE retailer_info_id=@param_retailer_info_id

COMMIT TRAN 
GO
/****** Object:  StoredProcedure [Party].[SP_Retailer_Location_Info_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Party].[SP_Retailer_Location_Info_IUD]
	@param_retailer_location_info_id int=0
	,@param_retailer_info_id int=0
	,@param_retailer_location_info_code NVARCHAR(20)=''
	,@param_retailer_location_info_name NVARCHAR(10)=''
	,@param_retailer_location_info_short_name NVARCHAR(100)=''
	,@param_trade_license NVARCHAR(20)=''
	,@param_trade_license_date DATE=''
	,@param_mobile NVARCHAR(50)=''
	,@param_phone NVARCHAR(20)=''
	,@param_email NVARCHAR(50)=''
	,@param_emergency_contact NVARCHAR(100)=''
	,@param_country_id int=0
	,@param_division_id int=0
	,@param_district_id int=0
	,@param_thana_id int=0
	,@param_city NVARCHAR(50)=''
	,@param_post_code NVARCHAR(50)=''
	,@param_block NVARCHAR(150)=''
	,@param_road_no NVARCHAR(150)=''
	,@param_house_no NVARCHAR(150)=''
	,@param_flat_no NVARCHAR(50)=''
	,@param_address_note NVARCHAR(50)=''
	,@param_is_active bit=1 
	,@param_created_datetime DATETIME=''
	,@param_created_user_info_id INT=0
	,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     Declare @param_db_server_date_time as datetime=GETDATE();

	IF (@param_DBOperation=1)
	BEGIN		
		
        IF (EXISTS (SELECT retailer_location_info_code FROM Party.Retailer_Location_Info WHERE retailer_location_info_code=@param_retailer_location_info_code)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Retailer location code must be unique. Please try another code.',16,1);
			RETURN
		END
		
        SET @param_retailer_location_info_id= (SELECT ISNULL(MAX(ISNULL(retailer_location_info_id,0)),0)+1 from Party.Retailer_Location_Info)
				
		IF NOT EXISTS (SELECT retailer_location_info_id FROM Party.Retailer_Location_Info DI WHERE DI.retailer_location_info_id=@param_retailer_location_info_id)
		BEGIN
			INSERT INTO Party.Retailer_Location_Info 
                       (
					    retailer_location_info_id
					   ,retailer_info_id
					   ,retailer_location_info_code
					   ,retailer_location_info_name
					   ,retailer_location_info_short_name
					   ,trade_license
					   ,trade_license_date
					   ,mobile
					   ,phone
					   ,email
					   ,emergency_contact
					   ,country_id
					   ,division_id
					   ,district_id
					   ,thana_id
					   ,city
					   ,post_code
					   ,block
					   ,road_no
					   ,house_no
					   ,flat_no
					   ,address_note
					   ,is_active
					   ,created_datetime
					   ,db_server_date_time
					   ,created_user_info_id						
						)
		    VALUES	   (
						@param_retailer_location_info_id
						,@param_retailer_info_id
						,@param_retailer_location_info_id  --param_retailer_location_info_code
						,@param_retailer_location_info_name
						,@param_retailer_location_info_short_name
						,@param_trade_license
						,@param_trade_license_date
						,@param_mobile
						,@param_phone
						,@param_email
						,@param_emergency_contact
						,@param_country_id
						,@param_division_id
						,@param_district_id
						,@param_thana_id
						,@param_city
						,@param_post_code
						,@param_block
						,@param_road_no
						,@param_house_no
						,@param_flat_no
						,@param_address_note
						,@param_is_active
						,@param_created_datetime
						,@param_db_server_date_time
						,@param_created_user_info_id
						)
			END
		
	END ----Data Inserted Begin End 
    
    IF (@param_DBOperation=2)
			BEGIN
  
					UPDATE Party.Retailer_Location_Info SET 
							retailer_info_id=@param_retailer_info_id
							,retailer_location_info_code=@param_retailer_location_info_code
							,retailer_location_info_name=@param_retailer_location_info_name
							,retailer_location_info_short_name=@param_retailer_location_info_short_name
							,trade_license=@param_trade_license
							,trade_license_date=@param_trade_license_date
							,mobile=@param_mobile
							,phone=@param_phone
							,email=@param_email
							,emergency_contact=@param_emergency_contact
							,country_id=@param_country_id
							,division_id=@param_division_id
							,district_id=@param_district_id
							,thana_id=@param_thana_id
							,city=@param_city
							,post_code=@param_post_code
							,block=@param_block
							,road_no=@param_road_no
							,house_no=@param_house_no
							,flat_no=@param_flat_no
							,address_note=@param_address_note
							,is_active=@param_is_active
							,created_datetime=@param_created_datetime
							,db_server_date_time=@param_db_server_date_time
							,created_user_info_id=@param_created_user_info_id					
					WHERE retailer_location_info_id=@param_retailer_location_info_id
				
			END  ----Data Updated Begin End

	IF (@param_DBOperation=3)
			BEGIN
				
				--Delete  authorization
				
			DELETE FROM Party.Retailer_Location_Info WHERE retailer_location_info_id=@param_retailer_location_info_id
			  
			END  ----Data Deleted Begin End
		------Data Selected 
		SELECT * FROM Party.Retailer_Location_Info WHERE retailer_location_info_id=@param_retailer_location_info_id

COMMIT TRAN 
GO
/****** Object:  StoredProcedure [Payroll].[SP_Salary_Head_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Al-Amin Mollick
	-- Create date: 14-Feb-2022
	-- Description:	This is a Salary head create,update and delete  store procedure.
	-- =============================================

*/
CREATE PROCEDURE [Payroll].[SP_Salary_Head_IUD]
 @param_salary_head_id INT=0
,@param_salary_head_name NVARCHAR(50)=''
,@param_salary_head_short_name NVARCHAR(10)=''
,@param_salary_head_type_id INT=0
,@param_sorting_priority INT=0
,@param_name_in_local_language NVARCHAR(100)=''
,@param_remarks NVARCHAR(500)=''
,@param_created_user_id BIGINT=0
,@param_company_corporate_id INT=0
,@param_company_group_id INT=0
,@param_DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
   DECLARE @pv_is_shared BIT

	IF (@param_DBOperation=1)
	BEGIN
		SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
        	--Duplicate checking
        
		
        IF (EXISTS (SELECT salary_head_name FROM Payroll.Salary_Head WHERE salary_head_name=@param_salary_head_name AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

       IF EXISTS(SELECT sorting_priority FROM Payroll.Salary_Head WHERE sorting_priority=@param_sorting_priority AND salary_head_type_id=@param_salary_head_type_id) 
		BEGIN
			ROLLBACK
				RAISERROR(N'This sorting priority already exist.Please try another number.',16,1);
			RETURN
		END
        SET @param_salary_head_id= (SELECT ISNULL(MAX(ISNULL(salary_head_id,0)),0)+1 from Payroll.Salary_Head)

		

		IF NOT EXISTS (SELECT salary_head_id FROM Payroll.Salary_Head M WHERE m.salary_head_id=@param_salary_head_id)
		BEGIN
			INSERT INTO Payroll.Salary_Head 
                       (salary_head_id       ,salary_head_name        ,salary_head_short_name      ,salary_head_type_id       ,sorting_priority       ,name_in_local_language       ,remarks       ,created_user_id,company_corporate_id,company_group_id)
		    VALUES	   (@param_salary_head_id,@param_salary_head_name,@param_salary_head_short_name,@param_salary_head_type_id,@param_sorting_priority,@param_name_in_local_language,@param_remarks,@param_created_user_id,@param_company_corporate_id,@param_company_group_id)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN
     

	    IF ( EXISTS (SELECT salary_head_id FROM Payroll.Salary_Head WHERE salary_head_name=@param_salary_head_name AND company_group_id=@param_company_group_id AND salary_head_id<>@param_salary_head_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Policy name must be unique. Please try another name.',16,1);
			RETURN
		END

        IF EXISTS(SELECT sorting_priority FROM Payroll.Salary_Head WHERE sorting_priority=@param_sorting_priority AND salary_head_type_id=@param_salary_head_type_id AND salary_head_id<>@param_salary_head_id) 
		BEGIN
			ROLLBACK
				RAISERROR(N'This sorting priority already exist.Please try another number.',16,1);
			RETURN
		END
		--Duplicate checking
		IF EXISTS (SELECT salary_head_id FROM Payroll.Salary_Head M WHERE m.salary_head_id=@param_salary_head_id)
		BEGIN
			 UPDATE Payroll.Salary_Head SET 
			 salary_head_name=@param_salary_head_name
		    ,remarks= @param_remarks
            ,salary_head_short_name=@param_salary_head_short_name
            ,salary_head_type_id=@param_salary_head_type_id
            ,sorting_priority=@param_sorting_priority
            ,name_in_local_language=@param_name_in_local_language

		 WHERE salary_head_id=@param_salary_head_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
	
	   IF EXISTS (SELECT * FROM Attendance.Attendance_Benefit_Policy rm WHERE rm.salary_head_id=@param_salary_head_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in attendance benefit policy.',16,1);
			RETURN
		END
      IF EXISTS (SELECT * FROM Attendance.Absenteeism_Policy rm WHERE rm.salary_head_id=@param_salary_head_id)
		BEGIN
			ROLLBACK
				RAISERROR(N'Delete is not possible. reference exists in absenteeism policy.',16,1);
			RETURN
		END
		
    DELETE FROM Payroll.Salary_Head  WHERE salary_head_id=@param_salary_head_id
      
	END

	

	 SELECT salary_head_id,salary_head_name,h.salary_head_type_id,h.salary_head_type_name,sorting_priority FROM Payroll.Salary_Head s 
     INNER JOIN [DBEnum].[Salary_Head_Type] h on s.salary_head_type_id=h.salary_head_type_id WHERE salary_head_id=@param_salary_head_id
     AND S.company_group_id=@param_company_group_id
	

COMMIT TRAN

GO
/****** Object:  StoredProcedure [PIMS].[SP_PIMS_Employee_Category_Type_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Masum Billah
	-- Create date: 21-Mar-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

	DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec pims.[SP_PIMS_Employee_Category_Type_IUD]5,'Time Rate','Test by Masum',1,1,1,2,2
select *from pims.Employee_Category_Type
*/  
CREATE PROCEDURE [PIMS].[SP_PIMS_Employee_Category_Type_IUD]
@param_pims_employee_category_type_id int=0
,@param_pims_employee_category_name NVARCHAR(50)=''
,@param_pims_remarks NVARCHAR(300)=''
,@param_created_user_info_id INT=0
,@param_company_group_id INT=0
,@param_company_corporate_id INT=0
,@param_company_id INT=0
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     declare @IsApprove NVARCHAR(100);     

	 DECLARE @pv_is_shared BIT
  SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy where is_active=1
	IF (@param_DBOperation=1)
	BEGIN
	
        	--Duplicate checking
        IF (EXISTS (SELECT employee_category_name FROM pims.Employee_Category_Type ECT WHERE Upper(employee_category_name)=Upper(@param_pims_employee_category_name) and ECT.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE ECT.company_group_id END AND ECT.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE ECT.company_id END)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Employee category must be unique. Please try another category.',16,1);
			RETURN
		END
		 

        SET @param_pims_employee_category_type_id= (SELECT ISNULL(MAX(ISNULL(employee_category_type_id,0)),0)+1 from pims.Employee_Category_Type)

		
		IF NOT EXISTS (SELECT employee_category_type_id FROM pims.Employee_Category_Type M WHERE m.employee_category_type_id=@param_pims_employee_category_type_id)
		BEGIN
			INSERT INTO pims.Employee_Category_Type 
                       (employee_category_type_id,			  employee_category_name,			  remarks,			   created_user_id ,           db_server_date_time, company_corporate_id,        company_group_id,        company_id)
		    VALUES	   (@param_pims_employee_category_type_id,@param_pims_employee_category_name, @param_pims_remarks, @param_created_user_info_id ,GETDATE(),          @param_company_corporate_id, @param_company_group_id, @param_company_id)
		END
		
	END ----Data Inserted Begin End
    
    IF (@param_DBOperation=2)
	BEGIN
			--Duplicate checking
        IF (EXISTS (SELECT employee_category_name FROM pims.Employee_Category_Type ECT WHERE upper(employee_category_name)=upper(@param_pims_employee_category_name) and ECT.company_group_id= CASE WHEN (@pv_is_shared=1) THEN @param_company_group_id ELSE ECT.company_group_id END AND ECT.company_id= CASE WHEN (@pv_is_shared=0) THEN  @param_company_id ELSE ECT.company_id END AND employee_category_type_id<>@param_pims_employee_category_type_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Employee Category must be unique. Please try another Category.',16,1);
			RETURN
		END
		--Validation chaecking
		if (@param_pims_employee_category_type_id=0)
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Select Employee Category Name.',16,1);
			RETURN
			END
			UPDATE pims.Employee_Category_Type SET 
			employee_category_name=@param_pims_employee_category_name ,
			remarks=@param_pims_remarks
			WHERE employee_category_type_id=@param_pims_employee_category_type_id
		
		
	END----Data Updated Begin End


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		--IF EXISTS (SELECT * FROM pims.pims_employee_Companay rm WHERE rm.pims_employee_id=@param_pims_employee_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in pims employee Company.',16,1);
		--	RETURN
		--END

		DELETE FROM pims.Employee_Category_Type WHERE employee_category_type_id=@param_pims_employee_category_type_id
		--end	
      
	END
	 SELECT * FROM pims.Employee_Category_Type WHERE employee_category_type_id=@param_pims_employee_category_type_id
    
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [PIMS].[SP_PIMS_Employee_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Masum Billah
	-- Create date: 13-Jan-2022
	-- Description:	For Insert,Update And Delete 
	-- =============================================

	DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec pims.[SP_PIMS_Employee_IUD]1,'001',1,'Masum','',
'Billah','Nurul Islam','Zobeda',1,1,'Nazia','2013-05-11','01728473506','01728473506',
'g@gmail.com','g@gmail.com','1984-07-04','Left hand sew','2834243087','8965444','6687','878787',
1,1,1,1,1,1,1,1,1,'city-01','ps area','post code','present_block','present_road_no','present_house_no',
'present_flat_no','present_address_note',1,1,1,'permanent_city','permanent_ps_area','permanent_post_code',
'permanent_block','permanent_road_no','permanent_house_no','permanent_flat_no','permanent_address_note',1 ,3,@tmp,0,'',1,1,1,2,'',''
*/
 --exec [SP_PIMS_Employee_IUD]employee_id, code, title_id_enum ,first_name, middle_name, sur_name, father_name, mother_name, gender_id, marital_status_id, spouse_name, date_of_marriage, personal_phone, official_phone, personal_email, official_email, date_of_birth, identification_mark, national_id,passport_no, birth_id, driving_license_no, nationality_id, religion_id, country_of_birth_id, blood_group_id, ethnicity_id, residentcial_status_id , company_corporate_id , company_group_id, company_id, created_user_id, created_datetime, is_active
CREATE PROCEDURE [PIMS].[SP_PIMS_Employee_IUD]
@param_pims_employee_id bigint=0
,@param_pims_employee_code NVARCHAR(100)=''
,@param_pims_title_id_enum tinyint=0
,@param_pims_first_name NVARCHAR(150)=''
,@param_pims_middle_name NVARCHAR(150)=''
,@param_pims_sur_name NVARCHAR(150)=''
,@param_pims_father_name NVARCHAR(150)=''
,@param_pims_mother_name NVARCHAR(150)=''
,@param_pims_gender_id tinyint=0
,@param_pims_marital_status_id tinyint=0
,@param_pims_spouse_name NVARCHAR(150)=''
,@param_pims_date_of_marriage date=''
,@param_pims_personal_phone NVARCHAR(50)=''
,@param_pims_official_phone NVARCHAR(50)=''
,@param_pims_personal_email NVARCHAR(50)=''
,@param_pims_official_email NVARCHAR(50)=''
,@param_pims_date_of_birth date=''
,@param_pims_identification_mark NVARCHAR(50)=''
,@param_pims_national_id NVARCHAR(50)=''
,@param_pims_passport_no NVARCHAR(150)=''
,@param_pims_birth_id NVARCHAR(150)=''
,@param_pims_driving_license_no NVARCHAR(150)=''
,@param_pims_nationality_id int=0
,@param_pims_religion_id int=0
,@param_pims_country_of_birth_id int=0
,@param_pims_blood_group_id int=0
,@param_pims_ethnicity_id int=0
,@param_pims_residentcial_status_id int=0
,@param_pims_present_country_id int=0
,@param_pims_present_division_id int=0
,@param_pims_present_district_id int=0
,@param_pims_present_city NVARCHAR(50)=''
,@param_pims_present_ps_area NVARCHAR(50)=''
,@param_pims_present_post_code NVARCHAR(50)=''
,@param_pims_present_block NVARCHAR(50)=''
,@param_pims_present_road_no  NVARCHAR(50)=''
,@param_pims_present_house_no  NVARCHAR(50)=''
,@param_pims_present_flat_no  NVARCHAR(50)=''
,@param_pims_present_address_note  NVARCHAR(300)=''
,@param_pims_permanent_country_id int=0
,@param_pims_permanent_division_id int=0
,@param_pims_permanent_district_id int=0
,@param_pims_permanent_city NVARCHAR(50)=''
,@param_pims_permanent_ps_area NVARCHAR(50)=''
,@param_pims_permanent_post_code NVARCHAR(50)=''
,@param_pims_permanent_block NVARCHAR(50)=''
,@param_pims_permanent_road_no  NVARCHAR(50)=''
,@param_pims_permanent_house_no  NVARCHAR(50)=''
,@param_pims_permanent_flat_no  NVARCHAR(50)=''
,@param_pims_permanent_address_note  NVARCHAR(300)=''
,@param_is_active BIT=1 
,@param_created_user_info_id INT=0
,@param_created_datetime datetime=''
,@param_employee_old_id INT=0
,@param_employee_old_code NVARCHAR(100)=''
,@param_company_group_id INT=0
,@param_company_corporate_id INT=0
,@param_company_id INT=0
,@param_employee_image_path NVARCHAR(100)=''
,@param_signature_image_path NVARCHAR(100)=''
,@param_DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
     declare @IsApprove NVARCHAR(100);
	-- select @param_pims_date_of_marriage
	IF (@param_DBOperation=1)
	BEGIN
		--SELECT @pv_is_shared= is_shared from Auth.Software_Sharing_Policy
        	--Duplicate checking
        
		
        IF (EXISTS (SELECT employee_name FROM pims.employee WHERE code=@param_pims_employee_code AND company_group_id=@param_company_group_id)) 
		BEGIN
			ROLLBACK
				RAISERROR(N'Employee code must be unique. Please try another code.',16,1);
			RETURN
		END


        SET @param_pims_employee_id= (SELECT ISNULL(MAX(ISNULL(employee_id,0)),0)+1 from pims.Employee)

		
		IF NOT EXISTS (SELECT employee_id FROM pims.Employee M WHERE m.employee_id=@param_pims_employee_id)
		BEGIN
			INSERT INTO pims.Employee 
                       (employee_id, code, title_enum_id ,first_name, middle_name, sur_name, father_name, mother_name, gender_enum_id, marital_status_enum_id, spouse_name, date_of_marriage, personal_phone, official_phone, personal_email, official_email, date_of_birth, identification_mark, national_id,passport_no, birth_id, driving_license_no, nationality_id, religion_enum_id, country_of_birth_id, blood_group_enum_id, ethnicity_id, residentcial_status_enum_id , company_corporate_id , company_group_id, company_id, created_user_id, created_datetime, is_active, employee_old_id, employee_old_code,employee_image_path,signature_image_path)
		    VALUES	   (@param_pims_employee_id, @param_pims_employee_code, @param_pims_title_id_enum ,@param_pims_first_name, @param_pims_middle_name, @param_pims_sur_name, @param_pims_father_name, @param_pims_mother_name, @param_pims_gender_id, @param_pims_marital_status_id, @param_pims_spouse_name, @param_pims_date_of_marriage, @param_pims_personal_phone, @param_pims_official_phone, @param_pims_personal_email, @param_pims_official_email, @param_pims_date_of_birth, @param_pims_identification_mark, @param_pims_national_id,@param_pims_passport_no, @param_pims_birth_id, @param_pims_driving_license_no, @param_pims_nationality_id, @param_pims_religion_id, @param_pims_country_of_birth_id, @param_pims_blood_group_id, @param_pims_ethnicity_id, @param_pims_residentcial_status_id , @param_company_corporate_id , @param_company_group_id, @param_company_id, @param_created_user_info_id, @param_created_datetime, @param_is_active,@param_employee_old_id,@param_employee_old_code,@param_employee_image_path,@param_signature_image_path)
		END
		
	END
    
    IF (@param_DBOperation=2)
	BEGIN

		set @IsApprove=isnull((SELECT approve_user_id FROM pims.employee WHERE code=@param_pims_employee_code),'0')
		if	(@IsApprove!='0')
		BEGIN
			ROLLBACK
					RAISERROR(N'This employee is already approved, you can not modify.',16,1);
			RETURN
		END

        IF (EXISTS (SELECT employee_name FROM pims.employee WHERE code=@param_pims_employee_code AND company_id<>@param_company_id)) 
	  	BEGIN
			ROLLBACK
				RAISERROR(N'Employee code must be unique. Please try another name.',16,1);
			RETURN
		END
		--Duplicate checking
		IF EXISTS (SELECT employee_id FROM pims.employee M WHERE m.employee_id=@param_pims_employee_id)
		BEGIN
		--Validation chaecking
		if (@param_pims_present_country_id=0)
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Select Employee Present Country.',16,1);
			RETURN
		END
		if (@param_pims_present_division_id=0)
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Select Employee Present Division.',16,1);
			RETURN
		END
		if (@param_pims_present_district_id=0)
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Select Employee Present District.',16,1);
			RETURN
		END
		if (@param_pims_present_city='')
			BEGIN
			ROLLBACK
				RAISERROR(N' Please Input Employee Present City or Twon.',16,1);
			RETURN
		END
			UPDATE pims.employee SET 
			title_enum_id=@param_pims_title_id_enum ,
			first_name=@param_pims_first_name, middle_name=@param_pims_middle_name,
			sur_name=@param_pims_sur_name, father_name=@param_pims_father_name, mother_name=@param_pims_mother_name,
			gender_enum_id=@param_pims_gender_id, marital_status_enum_id=@param_pims_marital_status_id,
			spouse_name=@param_pims_spouse_name, date_of_marriage=@param_pims_date_of_marriage,
			personal_phone=@param_pims_personal_phone, official_phone=@param_pims_official_phone,
			personal_email=@param_pims_personal_email, official_email=@param_pims_official_email,
			date_of_birth=@param_pims_date_of_birth, identification_mark=@param_pims_identification_mark,
			national_id=@param_pims_national_id,passport_no=@param_pims_passport_no,
			birth_id=@param_pims_birth_id, driving_license_no=@param_pims_driving_license_no,
			nationality_id=@param_pims_nationality_id, religion_enum_id=@param_pims_religion_id,
			country_of_birth_id=@param_pims_country_of_birth_id, blood_group_enum_id=@param_pims_blood_group_id,
			ethnicity_id=@param_pims_ethnicity_id, residentcial_status_enum_id=@param_pims_residentcial_status_id,
			present_country_id=@param_pims_present_country_id,present_division_id=@param_pims_present_division_id,
			present_district_id=@param_pims_present_district_id,present_city=@param_pims_present_city,
			present_ps_area=@param_pims_present_ps_area,present_post_code=@param_pims_present_post_code,
			present_block=@param_pims_present_block,present_road_no=@param_pims_present_road_no,
			present_house_no=@param_pims_present_house_no,present_flat_no=@param_pims_present_flat_no,
			present_address_note=@param_pims_present_address_note,
			permanent_country_id=@param_pims_permanent_country_id,permanent_division_id=@param_pims_permanent_division_id,
			permanent_district_id=@param_pims_permanent_district_id,permanent_city=@param_pims_permanent_city,
			permanent_ps_area=@param_pims_permanent_ps_area,permanent_post_code=@param_pims_permanent_post_code,
			permanent_block=@param_pims_permanent_block,permanent_road_no=@param_pims_permanent_road_no,
			permanent_house_no=@param_pims_permanent_house_no,@param_pims_permanent_flat_no=@param_pims_permanent_flat_no,
			permanent_address_note=@param_pims_permanent_address_note,
			employee_old_id=@param_employee_old_id, employee_old_code=@param_employee_old_code,
			employee_image_path=@param_employee_image_path,signature_image_path=@param_signature_image_path
			WHERE employee_id=@param_pims_employee_id
		END
		
	END


	IF (@param_DBOperation=3)
	BEGIN
		--Reference checking
		--IF EXISTS (SELECT * FROM pims.pims_employee_Companay rm WHERE rm.pims_employee_id=@param_pims_employee_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in pims employee Company.',16,1);
		--	RETURN
		--END
	 --  IF EXISTS (SELECT * FROM pims.pims_employee_Session rm WHERE rm.pims_employee_id=@param_pims_employee_id)
		--BEGIN
		--	ROLLBACK
		--		RAISERROR(N'Delete is not possible. reference exists in pims employee Session.',16,1);
		--	RETURN
		--END
		
    
		--Delete  authorization
		set @IsApprove=isnull((SELECT approve_user_id FROM pims.employee WHERE code=@param_pims_employee_code),'0')
		if	(@IsApprove!='0')
		BEGIN
			ROLLBACK
				RAISERROR(N'This employee is already approved, you can not modify.',16,1);
			RETURN
		END
		else 
		begin
		DELETE FROM pims.employee WHERE employee_id=@param_pims_employee_id
		end
		
      
	END

	 SELECT * FROM pims.employee WHERE employee_id=@param_pims_employee_id
    -- select @IsApprove as Isapprove
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Association_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 29-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Association_IUD]
 @supplier_association_id INT=0
,@association_id INT=0
,@supplier_id INT=0
,@membership_type_enum_id INT=0
,@association_number NVARCHAR(50)=''
,@start_date DATETIME=''
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

    IF(@DBOperation=2)
	BEGIN
	SELECT @supplier_association_id=iSNULL(MAX(supplier_association_id),0)+1 FROM Procurement.Supplier_Association
    
	--Validation
		--Mandatory Field checking
    INSERT INTO Procurement.Supplier_Association ([supplier_association_id],[association_id],[supplier_id],[membership_type_enum_id],[association_number],[start_date])
	VALUES (@supplier_association_id, @association_id, @supplier_id,@membership_type_enum_id,@association_number,@start_date)
	END

	IF (@DBOperation=3)
	BEGIN
	
       DELETE FROM Procurement.Supplier_Association WHERE  supplier_association_id=@supplier_association_id 

	END

	SELECT * FROM [Procurement].[Supplier_Association]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN



GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Bank_Account_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Bank_Account_IUD]
	 @supplier_bank_account_id INT=0
	,@bank_id INT=0
	,@bank_branch_id INT=0
	,@supplier_id INT=0
	,@account_name NVARCHAR(50)=''
    ,@account_number NVARCHAR(20)=''
    ,@iban NVARCHAR(50)=''
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


    IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_bank_account_id=iSNULL(MAX(supplier_bank_account_id),0)+1 FROM Procurement.Supplier_Bank_Account
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Bank_Account] ([supplier_bank_account_id],[bank_id],[bank_branch_id],[supplier_id],[account_name],[account_number],[iban])
	VALUES (@supplier_bank_account_id,@bank_id, @bank_branch_id, @supplier_id,@account_name,@account_number,@iban)
	END

	IF (@DBOperation=3)

	BEGIN	
    DELETE FROM Procurement.Supplier_Bank_Account WHERE  supplier_bank_account_id=@supplier_bank_account_id 
	END

	SELECT * FROM [Procurement].[Supplier_Bank_Account]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Contact_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Contact_IUD]
	 @supplier_contact_id INT=0
	,@supplier_id INT=0
	,@contact_type_id INT=0
	,@first_name NVARCHAR(100)=''
	,@middle_name NVARCHAR(100)=''
	,@sur_name NVARCHAR(100)=''
	,@designation_id INT=0
	,@email NVARCHAR(50)=''
	,@mobile_no NVARCHAR(20)=''
	,@phone_no NVARCHAR(20)=''
	,@whatsapp NVARCHAR(20)=''
	,@facebook NVARCHAR(100)=''
	,@linkedin NVARCHAR(100)=''
	,@date_of_birth DATETIME=''
    ,@nationality_id INT=0
	,@religion_enum_id INT=0
	,@gender_enum_id INT=0
	,@marital_status_enum_id INT=0
	,@blood_group_enum_id INT=0
	,@date_of_marriage DATETIME=''
	,@nid_number NVARCHAR(50)=''
	,@nid_file_path nvarchar(300)=''
	,@passport_no NVARCHAR(50)=''
	,@birth_id NVARCHAR(50)=''
	,@driving_license_no NVARCHAR(50)=''
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


    IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_contact_id=iSNULL(MAX(supplier_contact_id),0)+1 FROM Procurement.Supplier_Contact
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Contact] ([supplier_contact_id],[supplier_id],[contact_type_id],[first_name],[middle_name],[sur_name],[designation_id],[email],[mobile_no],[phone_no],[whatsapp],[facebook],[linkedin],[date_of_birth],[nationality_id],[religion_enum_id],[gender_enum_id],[marital_status_enum_id],[blood_group_enum_id],[date_of_marriage],[nid_number],[nid_file_path],[passport_no],[birth_id],[driving_license_no])
	VALUES (@supplier_contact_id, @supplier_id, @contact_type_id,@first_name,@middle_name, @sur_name,@designation_id,@email,@mobile_no,@phone_no,@whatsapp,@facebook,@linkedin,@date_of_birth,@nationality_id,@religion_enum_id,@gender_enum_id,@marital_status_enum_id,@blood_group_enum_id,@date_of_marriage,@nid_number,@nid_file_path,@passport_no,@birth_id,@driving_license_no)

	END

	IF (@DBOperation=3)
	--VDelete

	BEGIN	
    DELETE FROM Procurement.Supplier_Contact WHERE  supplier_contact_id=@supplier_contact_id 
	END

	SELECT * FROM [Procurement].[Supplier_Contact]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Contact_Location_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Contact_Location_IUD]
	 @supplier_contact_location_id INT=0
	,@supplier_location_id INT=0
	,@supplier_contact_id INT=0
	,@supplier_id INT=0
	,@add_note NVARCHAR(100)=''
    ,@is_active BIT=1
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


    IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_contact_location_id=iSNULL(MAX(supplier_contact_location_id),0)+1 FROM [Procurement].[Supplier_Contact_Location]
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Contact_Location] ([supplier_contact_location_id],[supplier_location_id],[supplier_contact_id],[supplier_id],[add_note],[is_active])
	VALUES (@supplier_contact_location_id, @supplier_location_id, @supplier_contact_id, @supplier_id,@add_note, @is_active)

	END

	
	IF (@DBOperation=3)
	--VDelete

	BEGIN	
    DELETE FROM Procurement.Supplier_Contact_Location WHERE  supplier_contact_location_id=@supplier_contact_location_id 
	END

	--Select
	SELECT * FROM [Procurement].[Supplier_Contact_Location]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Credit_History_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 15-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Credit_History_D]
 @supplier_id INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2 AND EXISTS(SELECT supplier_credit_history_id FROM Procurement.Supplier_Credit_History WHERE supplier_id=@supplier_id))
	--Validation
		--Mandatory Field checking
	 BEGIN
	
     DELETE FROM Procurement.Supplier_Credit_History WHERE supplier_id=@supplier_id
      
	 END

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Credit_History_I]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Credit_History_I]
	 @supplier_credit_history_id INT=0
	,@supplier_id INT=0
	,@currency_id INT=0
    ,@credit_days INT=0
	,@credit_limit decimal=0
	,@payment_frequency_id INT=0
	,@is_active BIT=1
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_credit_history_id=iSNULL(MAX(supplier_credit_history_id),0)+1 FROM Procurement.Supplier_Credit_History


	UPDATE Procurement.Supplier_Credit_History SET [is_active]=0
		WHERE supplier_id=@supplier_id
      

    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Credit_History] ([supplier_credit_history_id],[supplier_id],[currency_id],[credit_days],[credit_limit],[payment_frequency_id],[is_active])
	VALUES (@supplier_credit_history_id,@supplier_id,@currency_id,@credit_days, @credit_limit,@payment_frequency_id,@is_active)

	END

	SELECT * FROM [Procurement].[Supplier_Credit_History]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Document_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Document_IUD]
 @supplier_document_id INT=0
,@document_type_id INT=0
,@document_number NVARCHAR(30)=''
,@supplier_id INT=0
,@issue_date DATETIME=''
,@expiry_date DATETIME=''
,@file_path NVARCHAR(100)=''
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN
    IF(@DBOperation=2)
	BEGIN
	SELECT @supplier_document_id=iSNULL(MAX(supplier_document_id),0)+1 FROM Procurement.Supplier_Document
    
	--Validation
		--Mandatory Field checking
    INSERT INTO Procurement.Supplier_Document([supplier_document_id],[document_type_id],[document_number],[supplier_id],[issue_date],[expiry_date],[file_path])
	VALUES (@supplier_document_id, @document_type_id, @document_number, @supplier_id, @issue_date, @expiry_date, @file_path)
	END

    IF (@DBOperation=3)
	BEGIN
	
       DELETE FROM Procurement.Supplier_Document WHERE  supplier_document_id=@supplier_document_id  

	END
     
    SELECT [supplier_document_id],[document_type_id],[document_number],[supplier_id],[issue_date],[expiry_date],[file_path] 
	FROM [Procurement].[Supplier_Document]  
	WHERE [supplier_id]=@supplier_id


COMMIT TRAN




GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Ecommerce_Platforms_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Ecommerce_Platforms_D]
 @supplier_id INT=0
,@business_activities_enum_id INT=0
,@management_staff_no INT=0
,@nonmanagement_staff_no INT=0
,@permanent_worker_no INT=0
,@casual_worker_no INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2 AND EXISTS(SELECT ecommerce_platforms_id FROM Procurement.Supplier_Ecommerce_Platforms WHERE supplier_id=@supplier_id))
	--Validation
		--Mandatory Field checking
	 BEGIN
	
     DELETE FROM Procurement.Supplier_Ecommerce_Platforms WHERE supplier_id=@supplier_id
      
	 END

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Ecommerce_Platforms_I]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Ecommerce_Platforms_I]
 @supplier_ecommerce_platforms_id INT=0
,@ecommerce_platforms_id INT=0
,@supplier_id INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_ecommerce_platforms_id=iSNULL(MAX(supplier_ecommerce_platforms_id),0)+1 FROM Procurement.Supplier_Ecommerce_Platforms
    

	--Validation
		--Mandatory Field checking
    INSERT INTO Procurement.Supplier_Ecommerce_Platforms ([supplier_ecommerce_platforms_id],[ecommerce_platforms_id],[supplier_id])
	VALUES (@supplier_ecommerce_platforms_id, @ecommerce_platforms_id, @supplier_id)

	END
     
    
COMMIT TRAN



GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Industry_Sub_Sector_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Industry_Sub_Sector_D]
 @supplier_id INT=0
,@business_activities_enum_id INT=0
,@management_staff_no INT=0
,@nonmanagement_staff_no INT=0
,@permanent_worker_no INT=0
,@casual_worker_no INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2 AND EXISTS(SELECT industry_sub_sector_id FROM Procurement.Supplier_Industry_Sub_Sector WHERE supplier_id=@supplier_id))
	--Validation
		--Mandatory Field checking
	 BEGIN
	
     DELETE FROM Procurement.Supplier_Industry_Sub_Sector WHERE supplier_id=@supplier_id
      
	 END

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Industry_Sub_Sector_I]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Industry_Sub_Sector_I]
 @supplier_industry_sub_sector_id INT=0
,@industry_sub_sector_id INT=0
,@supplier_id INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_industry_sub_sector_id=iSNULL(MAX(supplier_industry_sub_sector_id),0)+1 FROM Procurement.Supplier_Industry_Sub_Sector
    
	--Validation
		--Mandatory Field checking
    INSERT INTO Procurement.Supplier_Industry_Sub_Sector ([supplier_industry_sub_sector_id],[industry_sub_sector_id],[supplier_id])
	VALUES (@supplier_industry_sub_sector_id, @industry_sub_sector_id, @supplier_id)

	END
     

   SELECT * FROM [Procurement].[Supplier_Industry_Sub_Sector]  WHERE [supplier_id]=@supplier_id

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Info_Feedback_Approval_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 07-Mar-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/
CREATE PROCEDURE [Procurement].[SP_Supplier_Info_Feedback_Approval_IUD]
	 @supplier_info_feedback_detail_id INT=0
	,@supplier_id INT=0
	,@approval_user_id INT=0
	,@reject_user_id INT=0
	,@comment NVARCHAR(50)=''
	,@suggestion NVARCHAR(50)=''
	,@feedback_status INT=2
	,@created_datetime DATETIME=''
	,@updated_datetime DATETIME=''
	,@created_user_info_id INT=0
	,@updated_user_info_id INT=0
    ,@DBOperation INT


WITH EXECUTE AS CALLER
AS
BEGIN Tran

  Declare @db_server_date_time as datetime=GETDATE()




IF(@DBOperation=1)
	
	BEGIN

	        SELECT @supplier_info_feedback_detail_id=iSNULL(MAX(supplier_info_feedback_detail_id),0)+1 FROM Procurement.Supplier_Info_Feedback_Detail 

			INSERT INTO Procurement.Supplier_Info_Feedback_Detail ([supplier_info_feedback_detail_id],[supplier_id],[approval_user_id],[comment],[suggestion],[approve_date],[created_datetime])
			VALUES (@supplier_info_feedback_detail_id, @supplier_id,@approval_user_id,@comment,@suggestion,@created_datetime,@created_datetime)

	END

	BEGIN

	
	UPDATE Procurement.Supplier_Application SET [feedback_status]=@feedback_status
		WHERE [supplier_id]=@supplier_id
      
    END  
	


SELECT * FROM [Procurement].[Supplier_Info_Feedback_Detail]  WHERE [supplier_id]=@supplier_id
		

Commit Tran


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Info_Feedback_Reject_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 07-Mar-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/
CREATE PROCEDURE [Procurement].[SP_Supplier_Info_Feedback_Reject_IUD]
	 @supplier_info_feedback_detail_id INT=0
	,@supplier_id INT=0
	,@approval_user_id INT=0
	,@reject_user_id INT=0
	,@comment NVARCHAR(50)=''
	,@suggestion NVARCHAR(50)=''
	,@feedback_status INT=99
	,@created_datetime DATETIME=''
	,@updated_datetime DATETIME=''
	,@created_user_info_id INT=0
	,@updated_user_info_id INT=0
    ,@DBOperation INT


WITH EXECUTE AS CALLER
AS
BEGIN Tran

  Declare @db_server_date_time as datetime=GETDATE()


IF(@DBOperation=1)
	
	BEGIN

	        SELECT supplier_info_feedback_detail_id=iSNULL(MAX(supplier_info_feedback_detail_id),0)+1 FROM Procurement.Supplier_Info_Feedback_Detail 

			INSERT INTO Procurement.Supplier_Info_Feedback_Detail ([supplier_info_feedback_detail_id],[supplier_id],[reject_user_id],[comment],[suggestion],[reject_date],[created_datetime])
			VALUES (@supplier_info_feedback_detail_id, @supplier_id,@reject_user_id,@comment,@suggestion,@created_datetime,@created_datetime)

	END

	BEGIN

	
	UPDATE Procurement.Supplier_Application SET [feedback_status]=@feedback_status
		WHERE [supplier_id]=@supplier_id
      
    END  
	


SELECT * FROM [Procurement].[Supplier_Info_Feedback_Detail]  WHERE [supplier_id]=@supplier_id
		

Commit Tran


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Location_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Location_IUD]
	 @supplier_location_id INT=0
	,@location_type_id INT=0
	,@supplier_id INT=0
	,@supplier_location_name NVARCHAR(50)=''
	,@country_id INT=0
	,@division_id INT=0
	,@district_id INT=0
	,@city NVARCHAR(50)=''
	,@ps_area NVARCHAR(50)=''
	,@post_code NVARCHAR(50)=''
	,@block NVARCHAR(50)=''
	,@road_no NVARCHAR(50)=''
	,@house_no NVARCHAR(50)=''
	,@flat_no NVARCHAR(50)=''
	,@email NVARCHAR(50)=''
	,@mobile_no NVARCHAR(20)=''
	,@phone_no NVARCHAR(20)=''
	,@pabx NVARCHAR(20)=''
    ,@is_active BIT=1
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


    IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_location_id=iSNULL(MAX(supplier_location_id),0)+1 FROM Procurement.Supplier_Location
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Location] ([supplier_location_id],[location_type_id],[supplier_id],[supplier_location_name],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[email],[mobile_no],[phone_no],[pabx],[is_active])
	VALUES (@supplier_location_id, @location_type_id, @supplier_id,@supplier_location_name,@country_id, @division_id, @district_id,@city,@ps_area,@post_code,@block,@road_no,@house_no,@flat_no,@email,@mobile_no,@phone_no,@pabx,@is_active)

	END

	IF(@DBOperation=3)

    BEGIN
	
     DELETE FROM Procurement.Supplier_Location WHERE supplier_location_id=@supplier_location_id
      
	 END

	SELECT * FROM [Procurement].[Supplier_Location]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Mobile_Bank_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Mobile_Bank_IUD]
	 @supplier_mobile_bank_id INT=0
	,@mfs_id INT=0
	,@supplier_id INT=0
	,@account_number NVARCHAR(20)=''
    ,@mfs_type_id INT=0
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


   IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_mobile_bank_id=iSNULL(MAX(supplier_mobile_bank_id),0)+1 FROM Procurement.Supplier_Mobile_Bank
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Mobile_Bank] ([supplier_mobile_bank_id],[mfs_id],[supplier_id],[account_number],[mfs_type_id])
	VALUES (@supplier_mobile_bank_id, @mfs_id, @supplier_id,@account_number, @mfs_type_id)

	END

		
	IF (@DBOperation=3)
	
	BEGIN
	
       DELETE FROM Procurement.Supplier_Mobile_Bank WHERE  supplier_mobile_bank_id=@supplier_mobile_bank_id 

	END

	SELECT * FROM [Procurement].[Supplier_Mobile_Bank]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Security_D]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 15-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Security_D]
 @supplier_id INT=0
,@currency_id INT=0
,@credit_days INT=0
,@credit_limit Decimal=0
,@payment_frequency_id INT=0
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2 AND EXISTS(SELECT supplier_security_id FROM Procurement.Supplier_Security WHERE supplier_id=@supplier_id))
	--Validation
		--Mandatory Field checking
	 BEGIN
	
     DELETE FROM Procurement.Supplier_Security WHERE supplier_id=@supplier_id
      
	 END

COMMIT TRAN

GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Security_I]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Security_I]
	 @supplier_security_id INT=0
	,@security_deposit_id INT=0
	,@supplier_id INT=0
	,@security_amount decimal=0
    ,@expiry_date datetime
	,@expired_notified_days int=0
	,@security_document_path NVARCHAR(50)=''
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_security_id=iSNULL(MAX(supplier_security_id),0)+1 FROM Procurement.Supplier_Security
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Security] ([supplier_security_id],[security_deposit_id],[supplier_id],[security_amount],[expiry_date],[expired_notified_days],[security_document_path])
	VALUES (@supplier_security_id, @security_deposit_id, @supplier_id,@security_amount,@expiry_date, @expired_notified_days,@security_document_path )

	END

	SELECT * FROM [Procurement].[Supplier_Security]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_Supplier_Warehouse_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 06-Feb-2022
	-- Description:	Only for Insert and delete 
	-- =============================================

*/

CREATE PROCEDURE [Procurement].[SP_Supplier_Warehouse_IUD]
	 @supplier_warehouse_id INT=0
	,@supplier_warehouse_name NVARCHAR(50)=''
	,@supplier_location_id INT=0
	,@supplier_id INT=0
	,@add_note NVARCHAR(300)=''
    ,@is_active BIT=1
    ,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN


    IF(@DBOperation=2)

	BEGIN
	SELECT @supplier_warehouse_id=iSNULL(MAX(supplier_warehouse_id),0)+1 FROM Procurement.Supplier_Warehouse
    
	--Validation
		--Mandatory Field checking
    INSERT INTO [Procurement].[Supplier_Warehouse] ([supplier_warehouse_id],[supplier_warehouse_name],[supplier_location_id],[supplier_id],[add_note],[is_active])
	VALUES (@supplier_warehouse_id, @supplier_warehouse_name, @supplier_location_id, @supplier_id,@add_note, @is_active)

	END

	IF (@DBOperation=3)
	
	BEGIN
	
       DELETE FROM Procurement.Supplier_Warehouse WHERE  supplier_warehouse_id=@supplier_warehouse_id 

	END

	SELECT * FROM [Procurement].[Supplier_Warehouse]  WHERE [supplier_id]=@supplier_id
     

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_SupplierApplication_Business_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 24-Jan-2022
	-- Description:	Only for Insert and delete 
	-- =============================================
*/

CREATE PROCEDURE [Procurement].[SP_SupplierApplication_Business_IUD]
 @supplier_id INT=0
,@business_activities_enum_id INT=0
,@management_staff_no nvarchar(50)=''
,@nonmanagement_staff_no nvarchar(50)=''
,@permanent_worker_no nvarchar(50)=''
,@casual_worker_no nvarchar(50)=''
,@DBOperation INT

WITH EXECUTE AS CALLER
AS
BEGIN TRAN

	
IF(@DBOperation=2 AND EXISTS(SELECT supplier_code FROM Procurement.Supplier_Application WHERE supplier_id=@supplier_id))
	--Validation
		--Mandatory Field checking

BEGIN
        UPDATE Procurement.Supplier_Application SET [business_activities_enum_id]=@business_activities_enum_id,[management_staff_no]=@management_staff_no,[nonmanagement_staff_no]=@nonmanagement_staff_no,[permanent_worker_no]=@permanent_worker_no,[casual_worker_no]=@casual_worker_no
		WHERE supplier_id=@supplier_id
	END

	 SELECT * FROM Procurement.Supplier_Application WHERE supplier_id=@supplier_id
     
    

COMMIT TRAN


GO
/****** Object:  StoredProcedure [Procurement].[SP_SupplierApplication_IUD]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 13-Jan-2021
	-- Description:	This is a bank operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Procurement].[SP_SupplierApplication_IUD]
	 @supplier_id INT=0
	,@company_corporate_id int=0
	,@company_group_id int=0
	,@company_id int=0
	,@supplier_code NVARCHAR(50)=''
	,@legal_name NVARCHAR(50)=''
	,@short_name NVARCHAR(10)=''
	,@name_in_local_language NVARCHAR(50)=''
	,@address_in_local_language NVARCHAR(100)=''
	,@year_established DATETIME=''
    ,@domicile_enum_id INT=0
	,@registry_authority_id INT=0
	,@regulator_id INT=0
	,@ownership_type_id INT=0
	,@supplier_logo NVARCHAR(300)=''
	,@country_id INT=0
	,@division_id INT=0
	,@district_id INT=0
	,@city NVARCHAR(50)=''
	,@ps_area NVARCHAR(50)=''
	,@post_code NVARCHAR(50)=''
	,@block NVARCHAR(50)=''
	,@road_no NVARCHAR(50)=''
	,@house_no NVARCHAR(50)=''
	,@flat_no NVARCHAR(50)=''
	,@email NVARCHAR(50)=''
	,@mobile_no NVARCHAR(20)=''
	,@phone_no NVARCHAR(20)=''
	,@pabx NVARCHAR(20)=''
    ,@is_active BIT=1
	,@is_confirm BIT=0
	,@created_datetime DATETIME=''
	,@updated_datetime DATETIME=''
	,@created_user_info_id INT=0
	,@updated_user_info_id INT=0
	,@DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN Tran

  Declare @db_server_date_time as datetime=GETDATE()


IF(@DBOperation=1 AND NOT EXISTS(SELECT supplier_id FROM Procurement.Supplier_Application WHERE supplier_id=@supplier_id))
	
	BEGIN

	        SELECT @supplier_id=iSNULL(MAX(supplier_id),0)+1 FROM Procurement.Supplier_Application
    
			INSERT INTO Procurement.Supplier_Application ([supplier_id],[company_corporate_id],[company_group_id],[company_id],[supplier_code],[legal_name],[short_name],[name_in_local_language],[address_in_local_language],[year_established],[domicile_enum_id],[registry_authority_id],[regulator_id],[ownership_type_id],[supplier_logo],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[email],[mobile_no],[phone_no],[pabx],[is_active],[is_confirm],[created_datetime],[updated_datetime],[db_server_date_time],[created_user_info_id],[updated_user_info_id])
			VALUES (@supplier_id,@company_corporate_id,@company_group_id,@company_id, @supplier_id, @legal_name, @short_name, @name_in_local_language, @address_in_local_language, @year_established, @domicile_enum_id, @registry_authority_id, @regulator_id,@ownership_type_id,@supplier_logo,@country_id, @division_id, @district_id,@city,@ps_area,@post_code,@block,@road_no,@house_no,@flat_no,@email,@mobile_no,@phone_no,@pabx,@is_active,@is_confirm,@created_datetime,@updated_datetime,@db_server_date_time,@created_user_info_id,@updated_user_info_id)

	END
	


IF(@DBOperation=2)
	--Validation
		--Mandatory Field checking


   BEGIN
       	UPDATE Procurement.Supplier_Application SET 
			company_corporate_id=@company_corporate_id
			,company_group_id=@company_group_id
			,company_id=@company_id
			,legal_name=@legal_name
			,short_name=@short_name
			,name_in_local_language=@name_in_local_language
			,address_in_local_language=@address_in_local_language
			,year_established=@year_established
			,domicile_enum_id=@domicile_enum_id
			,registry_authority_id=@registry_authority_id
			,regulator_id=@regulator_id
			,ownership_type_id=@ownership_type_id
			,supplier_logo=@supplier_logo
			,country_id=@country_id
			,division_id=@division_id
			,district_id=@district_id
			,city=@city
			,ps_area=@ps_area
			,post_code=@post_code
			,[block]=@block
			,road_no=@road_no
			,house_no=@house_no
			,flat_no=@flat_no
			,email=@email
			,mobile_no=@mobile_no
			,phone_no=@phone_no
			,pabx=@pabx
			,updated_datetime=@updated_datetime
			,updated_user_info_id=@updated_user_info_id
			WHERE [supplier_id]=@supplier_id
	END

IF(@DBOperation=3)

	 BEGIN
	
	
	 DELETE FROM Procurement.Supplier_Association WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Bank_Account WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Contact WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Contact_Location WHERE supplier_id=@supplier_id
     DELETE FROM Procurement.Supplier_Credit_History WHERE supplier_id=@supplier_id
     DELETE FROM Procurement.Supplier_Document WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Ecommerce_Platforms WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Industry_Sub_Sector WHERE supplier_id=@supplier_id
     DELETE FROM Procurement.Supplier_Location WHERE supplier_id=@supplier_id
     DELETE FROM Procurement.Supplier_Mobile_Bank WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Security WHERE supplier_id=@supplier_id
	 DELETE FROM Procurement.Supplier_Warehouse WHERE supplier_id=@supplier_id	 
     DELETE FROM Procurement.Supplier_Application WHERE supplier_id=@supplier_id
      
	 END

IF(@DBOperation=5)

	 BEGIN
	
     Update Procurement.Supplier_Application SET
	 is_confirm='1'
	,feedback_status='1'
	 WHERE supplier_id=@supplier_id
      
	 END



SELECT [supplier_id],[supplier_code],[legal_name],[short_name],[name_in_local_language],[address_in_local_language],[year_established],[domicile_enum_id],[registry_authority_id],[regulator_id],[ownership_type_id],[supplier_logo],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[email],[mobile_no],[phone_no],[pabx]
FROM [Procurement].[Supplier_Application] 
WHERE [supplier_id]=@supplier_id
		

Commit Tran


GO
/****** Object:  StoredProcedure [Procurement].[SP_SupplierApplication_IUD_P]    Script Date: 1/28/2025 11:12:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	-- =============================================
	-- Author:		Md. Adnan Amin
	-- Create date: 13-Jan-2021
	-- Description:	This is a bank operation store procedure.
	-- =============================================
	*/
CREATE PROCEDURE [Procurement].[SP_SupplierApplication_IUD_P]
	 @supplier_id INT=0
	,@company_corporate_id int=0
	,@company_group_id int=0
	,@company_id int=0
	,@supplier_code NVARCHAR(50)=''
	,@legal_name NVARCHAR(50)=''
	,@short_name NVARCHAR(10)=''
	,@name_in_local_language NVARCHAR(50)=''
	,@address_in_local_language NVARCHAR(100)=''
	,@year_established DATETIME
    ,@domicile_enum_id INT=0
	,@registry_authority_id INT=0
	,@regulator_id INT=0
	,@ownership_type_id INT=0
	,@supplier_logo NVARCHAR(300)=''
	,@country_id INT=0
	,@division_id INT=0
	,@district_id INT=0
	,@city NVARCHAR(50)=''
	,@ps_area NVARCHAR(50)=''
	,@post_code NVARCHAR(50)=''
	,@block NVARCHAR(50)=''
	,@road_no NVARCHAR(50)=''
	,@house_no NVARCHAR(50)=''
	,@flat_no NVARCHAR(50)=''
	,@email NVARCHAR(50)=''
	,@mobile_no NVARCHAR(20)=''
	,@phone_no NVARCHAR(20)=''
	,@pabx NVARCHAR(20)=''
    ,@is_active BIT=1
	,@is_confirm BIT=0
	,@created_datetime DATETIME=''
	,@updated_datetime DATETIME=''
	,@created_user_info_id INT=0
	,@updated_user_info_id INT=0
    ,@user_info_id INT=0
	,@DBOperation INT=0

WITH EXECUTE AS CALLER
AS
BEGIN Tran

  Declare @db_server_date_time as datetime=GETDATE()


IF(@DBOperation=1 AND NOT EXISTS(SELECT supplier_id FROM Procurement.Supplier_Application WHERE supplier_id=@supplier_id))
	BEGIN
	SELECT @supplier_id=iSNULL(MAX(supplier_id),0)+1 FROM Procurement.Supplier_Application
    
	SELECT @supplier_code=iSNULL(MAX(supplier_id),0)+1 FROM Procurement.Supplier_Application

	--Validation
		--Mandatory Field checking
    INSERT INTO Procurement.Supplier_Application ([supplier_id],[company_corporate_id],[company_group_id],[company_id],[supplier_code],[legal_name],[short_name],[name_in_local_language],[address_in_local_language],[year_established],[domicile_enum_id],[registry_authority_id],[regulator_id],[ownership_type_id],[supplier_logo],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[email],[mobile_no],[phone_no],[pabx],[is_active],[is_confirm],[created_datetime],[updated_datetime],[db_server_date_time],[created_user_info_id],[updated_user_info_id])
	VALUES (@supplier_id,@company_corporate_id,@company_group_id,@company_id, @supplier_code, @legal_name, @short_name, @name_in_local_language, @address_in_local_language, @year_established, @domicile_enum_id, @registry_authority_id, @regulator_id,@ownership_type_id,@supplier_logo,@country_id, @division_id, @district_id,@city,@ps_area,@post_code,@block,@road_no,@house_no,@flat_no,@email,@mobile_no,@phone_no,@pabx,@is_active,@is_confirm,@created_datetime,@updated_datetime,@db_server_date_time,@created_user_info_id,@updated_user_info_id)

	END
	
	BEGIN

	
	UPDATE Auth.User_Info SET [employee_id]=@supplier_id
		WHERE user_info_id=@user_info_id
      
    END  

IF(@DBOperation=2)
	--Validation
		--Mandatory Field checking


   BEGIN
       	UPDATE Procurement.Supplier_Application SET 
			company_corporate_id=@company_corporate_id
			,company_group_id=@company_group_id
			,company_id=@company_id
			,supplier_code=@supplier_code
			,legal_name=@legal_name
			,short_name=@short_name
			,name_in_local_language=@name_in_local_language
			,address_in_local_language=@address_in_local_language
			,year_established=@year_established
			,domicile_enum_id=@domicile_enum_id
			,registry_authority_id=@registry_authority_id
			,regulator_id=@regulator_id
			,ownership_type_id=@ownership_type_id
			,supplier_logo=@supplier_logo
			,country_id=@country_id
			,division_id=@division_id
			,district_id=@district_id
			,city=@city
			,ps_area=@ps_area
			,post_code=@post_code
			,[block]=@block
			,road_no=@road_no
			,house_no=@house_no
			,flat_no=@flat_no
			,email=@email
			,mobile_no=@mobile_no
			,phone_no=@phone_no
			,pabx=@pabx
			,updated_datetime=@updated_datetime
			,updated_user_info_id=@updated_user_info_id
			WHERE [supplier_id]=@supplier_id
	END


SELECT [supplier_id],[supplier_code],[legal_name],[short_name],[name_in_local_language],[address_in_local_language],[year_established],[domicile_enum_id],[registry_authority_id],[regulator_id],[ownership_type_id],[supplier_logo],[country_id],[division_id],[district_id],[city],[ps_area],[post_code],[block],[road_no],[house_no],[flat_no],[email],[mobile_no],[phone_no],[pabx]
FROM [Procurement].[Supplier_Application] 
WHERE [supplier_id]=@supplier_id
		

Commit Tran


GO
USE [master]
GO
ALTER DATABASE [RISERP] SET  READ_WRITE 
GO
