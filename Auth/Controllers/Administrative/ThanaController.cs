﻿
using Auth.Model.Administrative.Model;
using Auth.Repository.Administrative;
using Auth.Utility;
using Microsoft.AspNetCore.Mvc;
using System;

/// <summary>
/// Created By Jahid
/// Dated: 22/11/2021
/// </summary>
namespace Auth.Controllers.Administrative
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class ThanaController : ControllerBase
    {

        //Intialize
        #region Constructor
        private IThanaRepository _thanaRepository;

        public ThanaController(
            IThanaRepository thanaRepository
            )
        {

            _thanaRepository = thanaRepository;
        }

        #endregion        

        [HttpGet]
        public dynamic GetAllThana()
        {
           
            dynamic data = (dynamic)null;
            try
            {
                data = _thanaRepository.GetAllThana();
            }
            catch (Exception ex)
            {
                data = ex.Message;
            }
            return data;
        }

        [HttpGet]
        public dynamic GetById(int thana_id)
        {
            
            dynamic data = (dynamic)null;
            try
            {
                data = _thanaRepository.GetById(thana_id);
            }
            catch (Exception ex)
            {
                data = "Error info:" + ex.Message;
            }
            return data;
        }

        [HttpPost]
        public  dynamic Create(Thana oThana)
        {
            var message = new CommonMessage();
            try
            {
                _thanaRepository.Add(oThana);
                message = CommonMessage.SetSuccessMessage(CommonMessage.CommonSaveMessage);
            }
            catch (Exception ex)
            {
                message = CommonMessage.SetErrorMessage(ex.Message);
            }
            return message;
        }

        [HttpPost]
        public dynamic Update(Thana oThana)
        {
            var message = new CommonMessage();
            try
            {
                _thanaRepository.Update(oThana);
                message = CommonMessage.SetSuccessMessage(CommonMessage.CommonUpdateMessage);
            }
            catch (Exception ex)
            {
                message = CommonMessage.SetErrorMessage(ex.Message);
            }
            return message;
        }

        [HttpPost]
        public dynamic Delete(int thana_id)
        {
           
            var message = new CommonMessage();
            try
            {
                _thanaRepository.Delete(thana_id);
                message = CommonMessage.SetSuccessMessage(CommonMessage.CommonDeleteMessage);
            }
            catch (Exception ex)
            {
                message = CommonMessage.SetErrorMessage(ex.Message);
            }
            return message;
        }

        [HttpGet]
        public dynamic ThanaCboList()
        {
            return _thanaRepository.ThanaCboList();
        }

        [HttpGet]
        public dynamic ThanaCboListByDistrictId( int district_id )
        {            
            dynamic data = (dynamic)null;
            try
            {
                data = _thanaRepository.ThanaCboListByDistrictId(district_id);
            }
            catch (Exception ex)
            {
                data = "Error info:" + ex.Message;
            }
            return data;
        }
    }
}
