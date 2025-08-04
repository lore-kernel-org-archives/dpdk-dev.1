Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E77C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 06:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35A684025D;
	Mon,  4 Aug 2025 08:35:06 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id CD366400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 08:35:03 +0200 (CEST)
X-QQ-mid: Yeas6t1754289298t087t38540
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5054904436230728590
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-5-zaiyuwang@trustnetic.com>
In-Reply-To: <20250625125047.18072-5-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v2 04/15] net/txgbe: add basic link configuration for
 Amber-Lite NICs
Date: Mon, 4 Aug 2025 14:34:57 +0800
Message-ID: <073401dc0509$e53d0be0$afb723a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAFw0qYVApkmLlKypadMkA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NRkWGnbnkwTm4o7m5ZwESgANXu3NNNpSwzRXiiH1itQ9ucT3rzle8xt6
 MVPIFK5bdLufapLl0T7ZEgMoVppM/6ZdJujRRQVeyFHbTsg2nVulFSQzq2mmKGCAH6Sk5/X
 w7j8QTNo7R5uLn/d5GHSuzlAWBPWbsCdMRUlUraWwbEEC9OSD8RFLtnlT6I9TZamW4cS6jp
 8FqWNUeJlfiDuLZ08Xpse4ghQaBuYX7Q7Ciop+HJpURiiGjbQRft4vy6fdBFA9SPDZMKEYp
 q1CoY8UGR73bXH/b6Ws1w1N22bX05xVPOAGMcrhsTfJ01NdUGlgiSerFmo9poGx2aQgvFIh
 qIzh1JuSCEpKBMqypz27iX+ly+zE1Y+FRgNtmiOerPYr9J+fnpCcvxhov8vwfi4FYgh7ljz
 j+/yyQAfUyIRX90x0ZLrxfv628C+204B1P3G0bI34wXGb9ok3vO8nvl6aZsd89JOfO1JYvK
 Stcmk4Xl7hJk3xjQw7pSvOtBthbUU7aoGjfAVfGEVbo0EnAxHlYVivt7tYY2HqnJNVZ7+tD
 Z1HzWfuxydCnoZBYTXtGZtVKYQuLWAFs+VzQdZ3lx5K6woPzMPzj9tyri7XMNWxZIu/b3/O
 CTIIVgWoD4cF+KpsC9d/xlo/boYJl5EVGikd8kbqnRZNSwZFFSDULgaE5a0k32/tLWJ4Rt2
 KNnZInXmRdTj5rk9tbzzTX1RRqk+zgDwE702CnvvgeupabGB744U9guG9XQvQS9Wo1Fb9n1
 6pIDh92A4wfhdDdTDeVWAUVYw3maS5FlF1gPL+WRmUvlDPinVIK41Yw/NJgaGMGyViDD/Rt
 NmkXh00LuQEC0p5dYIWgP6ouKZxnXZ30GpzzaZBif8OI+9nETNLnolZKZindQ7tRjvKAakY
 nEz9n6ywo81+epZcD05mgskK2B2G0VZhJQfjkiIgg8Leb8B5QhQAI0qd1dLAdtcOx57zSWB
 UTRoPK1RZyAxwnVsaTY7m6vOXkYltowYf3FqJ9+paT0onUW84F9bOtPMoHdh8o9is39V3eZ
 vQSGTeercdTGWgv9XmySiMT1xfMIg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> +s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
> +			       u32 speed,
> +			       bool autoneg_wait_to_complete)
> +{
> +	bool autoneg = false;
> +	s32 status = 0;
> +	s32 ret_status = 0;
> +	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
> +	bool link_up = false;
> +	int i;
> +	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
> +	u32 value = 0;
> +
> +	UNREFERENCED_PARAMETER(autoneg_wait_to_complete);
> +
> +	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
> +		DEBUGOUT("SFP not detected, skip setup mac link");
> +		return 0;
> +	}
> +
> +	/* Check to see if speed passed in is supported. */
> +	status = hw->mac.get_link_capabilities(hw,
> +			&link_capabilities, &autoneg);
> +	if (status)
> +		return status;
> +
> +	speed &= link_capabilities;
> +	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
> +		return TXGBE_ERR_LINK_SETUP;
> +
> +	value = rd32(hw, TXGBE_GPIOEXT);
> +	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
> +		return status;
> +
> +	for (i = 0; i < 4; i++) {
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +		if (link_up)
> +			break;
> +		msleep(250);
> +	}
> +
> +	if (link_speed == speed && link_up &&
> +	   !(speed == TXGBE_LINK_SPEED_25GB_FULL))
> +		return status;

speed != TXGBE_LINK_SPEED_25GB_FULL

> +
> +	rte_spinlock_lock(&hw->phy_lock);
> +	ret_status = 0;
> +	rte_spinlock_unlock(&hw->phy_lock);
> +
> +	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
> +		return status;
> +
> +	for (i = 0; i < 4; i++) {
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +		if (link_up)
> +			return status;
> +		msleep(250);
> +		}

Double tab.

> +
> +	return status;
> +}
> +
> +/**
> + *  txgbe_setup_mac_link_multispeed_fiber_aml - Set MAC link speed
> + *  @hw: pointer to hardware structure
> + *  @speed: new link speed
> + *  @autoneg_wait_to_complete: true when waiting for completion is needed
> + *
> + *  Set the link speed in the MAC and/or PHY register and restarts link.
> + **/
> +static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
> +					  u32 speed,
> +					  bool autoneg_wait_to_complete)
> +{
> +	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
> +	u32 highest_link_speed = TXGBE_LINK_SPEED_UNKNOWN;
> +	s32 status = 0;
> +	u32 speedcnt = 0;
> +	bool autoneg, link_up = false;
> +
> +	/* Mask off requested but non-supported speeds */
> +	status = hw->mac.get_link_capabilities(hw, &link_speed, &autoneg);
> +	if (status != 0)
> +		return status;
> +
> +	speed &= link_speed;
> +
> +	/* Try each speed one by one, highest priority first.  We do this in
> +	 * software because 10Gb fiber doesn't support speed autonegotiation.
> +	 */

Neither 25Gb fiber.

> +	if (speed & TXGBE_LINK_SPEED_25GB_FULL) {
> +		speedcnt++;
> +		highest_link_speed = TXGBE_LINK_SPEED_25GB_FULL;
> +
> +		/* If we already have link at this speed, just jump out */
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +
> +		if ((link_speed == TXGBE_LINK_SPEED_25GB_FULL) && link_up)
> +			goto out;
> +
> +		/* Allow module to change analog characteristics (1G->10G) */

10G -> 25G

> +		msec_delay(40);
> +
> +		status = hw->mac.setup_mac_link(hw,
> +				TXGBE_LINK_SPEED_25GB_FULL,
> +				autoneg_wait_to_complete);
> +		if (status != 0)
> +			return status;
> +
> +		/*aml wait link in setup,no need to repeatly wait*/
> +		/* If we have link, just jump out */
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +
> +		if (link_up)
> +			goto out;
> +
> +	}
> +
> +	if (speed & TXGBE_LINK_SPEED_10GB_FULL) {
> +		speedcnt++;
> +		if (highest_link_speed == TXGBE_LINK_SPEED_UNKNOWN)
> +			highest_link_speed = TXGBE_LINK_SPEED_10GB_FULL;
> +
> +		/* If we already have link at this speed, just jump out */
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +
> +		if ((link_speed == TXGBE_LINK_SPEED_10GB_FULL) && link_up)
> +			goto out;
> +
> +		/* Allow module to change analog characteristics (25G->10G) */
> +		msec_delay(40);
> +
> +		status = hw->mac.setup_mac_link(hw, TXGBE_LINK_SPEED_10GB_FULL,
> +				autoneg_wait_to_complete);
> +		if (status != 0)
> +			return status;
> +
> +		/*aml wait link in setup,no need to repeatly wait*/
> +		/* If we have link, just jump out */
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +
> +		if (link_up)
> +			goto out;
> +	}
> +
> +	/* We didn't get link.  Configure back to the highest speed we tried,
> +	 * (if there was more than one).  We call ourselves back with just the
> +	 * single highest speed that the user requested.
> +	 */
> +	if (speedcnt > 1)
> +		status = txgbe_setup_mac_link_multispeed_fiber_aml(hw,
> +						      highest_link_speed,
> +						      autoneg_wait_to_complete);
> +
> +out:
> +	/* Set autoneg_advertised value based on input link speed */
> +	hw->phy.autoneg_advertised = 0;
> +
> +	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
> +		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_25GB_FULL;
> +
> +	if (speed & TXGBE_LINK_SPEED_10GB_FULL)
> +		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_10GB_FULL;
> +
> +	return status;
> +}
> +


> diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
> index 85dbbc5eff..b14ab90466 100644
> --- a/drivers/net/txgbe/base/txgbe_hw.c
> +++ b/drivers/net/txgbe/base/txgbe_hw.c
> @@ -11,6 +11,8 @@
>  #include "txgbe_eeprom.h"
>  #include "txgbe_mng.h"
>  #include "txgbe_hw.h"
> +#include "txgbe_aml.h"
> +#include "txgbe_aml40.h"
> 
>  #define TXGBE_RAPTOR_MAX_TX_QUEUES 128
>  #define TXGBE_RAPTOR_MAX_RX_QUEUES 128
> @@ -1906,7 +1908,7 @@ static bool txgbe_need_crosstalk_fix(struct txgbe_hw *hw)
>   *
>   *  Reads the links register to determine if link is up and the current speed
>   **/
> -s32 txgbe_check_mac_link(struct txgbe_hw *hw, u32 *speed,
> +s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw, u32 *speed,
>  				 bool *link_up, bool link_up_wait_to_complete)
>  {
>  	u32 links_reg, links_orig;
> @@ -2459,7 +2461,7 @@ s32 txgbe_setup_mac_link_multispeed_fiber(struct txgbe_hw *hw,
>   **/
>  s32 txgbe_init_shared_code(struct txgbe_hw *hw)
>  {
> -	s32 status;
> +	s32 status = 0;
> 
>  	/*
>  	 * Set the mac type
> @@ -2469,11 +2471,16 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
>  	txgbe_init_ops_dummy(hw);
>  	switch (hw->mac.type) {
>  	case txgbe_mac_raptor:
> +		txgbe_init_ops_sp(hw);
> +		break;
>  	case txgbe_mac_aml:
> +		txgbe_init_ops_aml(hw);
> +		break;
>  	case txgbe_mac_aml40:
> -		status = txgbe_init_ops_pf(hw);
> +		txgbe_init_ops_aml40(hw);
>  		break;
>  	case txgbe_mac_raptor_vf:
> +	case txgbe_mac_aml_vf:
>  		status = txgbe_init_ops_vf(hw);
>  		break;
>  	default:
> @@ -2539,7 +2546,7 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
>  	return err;
>  }
> 
> -void txgbe_init_mac_link_ops(struct txgbe_hw *hw)
> +void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw)
>  {
>  	struct txgbe_mac_info *mac = &hw->mac;
> 
> @@ -2599,7 +2606,7 @@ s32 txgbe_init_phy_raptor(struct txgbe_hw *hw)
>  		goto init_phy_ops_out;
> 
>  	/* Setup function pointers based on detected SFP module and speeds */
> -	txgbe_init_mac_link_ops(hw);
> +	hw->mac.init_mac_link_ops(hw);
> 
>  	/* If copper media, overwrite with copper function pointers */
>  	if (phy->media_type == txgbe_media_type_copper) {
> @@ -2634,7 +2641,7 @@ s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw)
>  	if (hw->phy.sfp_type == txgbe_sfp_type_unknown)
>  		return 0;
> 
> -	txgbe_init_mac_link_ops(hw);
> +	hw->mac.init_mac_link_ops(hw);
> 
>  	/* PHY config will finish before releasing the semaphore */
>  	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
> @@ -2781,7 +2788,7 @@ s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data)
>   *  Initialize the function pointers and assign the MAC type.
>   *  Does not touch the hardware.
>   **/
> -s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
> +s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
>  {
>  	struct txgbe_bus_info *bus = &hw->bus;
>  	struct txgbe_mac_info *mac = &hw->mac;
> @@ -2793,7 +2800,6 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
>  	bus->set_lan_id = txgbe_set_lan_id_multi_port;
> 
>  	/* PHY */
> -	phy->get_media_type = txgbe_get_media_type_raptor;
>  	phy->identify = txgbe_identify_phy;
>  	phy->init = txgbe_init_phy_raptor;
>  	phy->read_reg = txgbe_read_phy_reg;
> @@ -2861,8 +2867,6 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
>  	mac->fc_autoneg = txgbe_fc_autoneg;
> 
>  	/* Link */
> -	mac->get_link_capabilities = txgbe_get_link_capabilities_raptor;
> -	mac->check_link = txgbe_check_mac_link;
>  	mac->setup_pba = txgbe_set_pba;
> 
>  	/* Manageability interface */
> @@ -2901,6 +2905,22 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
>  	return 0;
>  }
> 
> +void txgbe_init_ops_sp(struct txgbe_hw *hw)
> +{
> +	struct txgbe_mac_info *mac = &hw->mac;
> +	struct txgbe_phy_info *phy = &hw->phy;
> +
> +	txgbe_init_ops_generic(hw);
> +
> +	/* PHY */
> +	phy->get_media_type = txgbe_get_media_type_sp;
> +
> +	/* LINK */
> +	mac->init_mac_link_ops = txgbe_init_mac_link_ops_sp;
> +	mac->get_link_capabilities = txgbe_get_link_capabilities_sp;
> +	mac->check_link = txgbe_check_mac_link_sp;
> +}
> +
>  /**
>   *  txgbe_get_link_capabilities_raptor - Determines link capabilities
>   *  @hw: pointer to hardware structure
> @@ -2909,7 +2929,7 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
>   *
>   *  Determines the link capabilities by reading the AUTOC register.
>   **/
> -s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
> +s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
>  				      u32 *speed,
>  				      bool *autoneg)
>  {
> @@ -3015,7 +3035,7 @@ s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
>   *
>   *  Returns the media type (fiber, copper, backplane)
>   **/
> -u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw)
> +u32 txgbe_get_media_type_sp(struct txgbe_hw *hw)

I think it should be a separate patch to cleanup codes: *_raptor -> *_sp

>  {
>  	u32 media_type;
> 
> @@ -3849,3 +3869,37 @@ s32 txgbe_reset_pipeline_raptor(struct txgbe_hw *hw)
>  	return err;
>  }
> 
> +s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
> +				bool *link_up)
> +{
> +	u32 rdata = 0;
> +	u32 links_reg = 0;
> +
> +	/* must read it twice because the state may
> +	 * not be correct the first time you read it
> +	 */
> +	rdata = rd32_epcs(hw, 0x30001);
> +	rdata = rd32_epcs(hw, 0x30001);
> +
> +	if (rdata & TXGBE_AML_PHY_LINK_UP)
> +		*link_up = true;
> +	else
> +		*link_up = false;
> +
> +	links_reg = rd32(hw, TXGBE_PORTSTAT);
> +	if (*link_up) {
> +		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
> +				TXGBE_CFG_PORT_ST_AML_LINK_40G)
> +			*speed = TXGBE_LINK_SPEED_40GB_FULL;
> +		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) ==
> +				TXGBE_CFG_PORT_ST_AML_LINK_25G)
> +			*speed = TXGBE_LINK_SPEED_25GB_FULL;
> +		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
> +				TXGBE_CFG_PORT_ST_AML_LINK_10G)
> +			*speed = TXGBE_LINK_SPEED_10GB_FULL;
> +	} else {
> +		*speed = TXGBE_LINK_SPEED_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
> index 1ed2892f61..476a9688bd 100644
> --- a/drivers/net/txgbe/base/txgbe_hw.h
> +++ b/drivers/net/txgbe/base/txgbe_hw.h
> @@ -56,7 +56,7 @@ s32 txgbe_set_vlvf(struct txgbe_hw *hw, u32 vlan, u32 vind,
>  s32 txgbe_clear_vfta(struct txgbe_hw *hw);
>  s32 txgbe_find_vlvf_slot(struct txgbe_hw *hw, u32 vlan, bool vlvf_bypass);
> 
> -s32 txgbe_check_mac_link(struct txgbe_hw *hw,
> +s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw,
>  			       u32 *speed,
>  			       bool *link_up, bool link_up_wait_to_complete);
> 
> @@ -86,10 +86,11 @@ s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
>  			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
>  s32 txgbe_init_shared_code(struct txgbe_hw *hw);
>  s32 txgbe_set_mac_type(struct txgbe_hw *hw);
> -s32 txgbe_init_ops_pf(struct txgbe_hw *hw);
> -s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
> +s32 txgbe_init_ops_generic(struct txgbe_hw *hw);
> +void txgbe_init_ops_sp(struct txgbe_hw *hw);
> +s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
>  				      u32 *speed, bool *autoneg);
> -u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw);
> +u32 txgbe_get_media_type_sp(struct txgbe_hw *hw);
>  void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
>  void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
>  void txgbe_flap_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
> @@ -103,7 +104,7 @@ s32 txgbe_start_mac_link_raptor(struct txgbe_hw *hw,
>  s32 txgbe_setup_mac_link(struct txgbe_hw *hw, u32 speed,
>  			       bool autoneg_wait_to_complete);
>  s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw);
> -void txgbe_init_mac_link_ops(struct txgbe_hw *hw);
> +void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw);
>  s32 txgbe_reset_hw(struct txgbe_hw *hw);
>  s32 txgbe_start_hw_raptor(struct txgbe_hw *hw);
>  s32 txgbe_init_phy_raptor(struct txgbe_hw *hw);
> @@ -114,4 +115,6 @@ s32 txgbe_reinit_fdir_tables(struct txgbe_hw *hw);
>  bool txgbe_verify_lesm_fw_enabled_raptor(struct txgbe_hw *hw);
>  s32 txgbe_fmgr_cmd_op(struct txgbe_hw *hw, u32 cmd, u32 cmd_addr);
>  s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data);
> +s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
> +				bool *link_up);
>  #endif /* _TXGBE_HW_H_ */
 

