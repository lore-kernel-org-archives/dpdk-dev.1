Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E872F99344
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 08:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C6E402B8;
	Thu, 23 Apr 2026 10:22:41 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 9FA3340270;
 Thu, 23 Apr 2026 10:22:38 +0200 (CEST)
X-QQ-mid: Yeas3t1776932552t506t64001
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [115.220.225.180])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8381481365702199847
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260423034024.14404-13-zaiyuwang@trustnetic.com>
In-Reply-To: <20260423034024.14404-13-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH 12/18] net/txgbe: fix link stability for 25G NIC
Date: Thu, 23 Apr 2026 16:22:31 +0800
Message-ID: <026a01dcd2fa$5481c540$fd854fc0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwIqvBxstS5iiQA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nr5N425iK0yrNhGHWdpUCrNyYMU/Pktx8zGxvbQQDjjswQwGelcmAn0z
 1VasxE7Rkw9GB8JLBaZJ9IzZ11zFAuyo4jZBrXGmnCBSLB8mhzfdpmW9iKugzwp2MfWvLJg
 T8sTaUTv2C+V9foBR7WaqQpjoC59Yvj2OGyRnlElyeOF/1nY32TLki9sIez86RoiwYsXLy4
 7j9e2gJpHRj0WnyZZC7aJEzffN65MmCsyTCPDD7lUEi1QXgsqyRLhp+fDCgFIQ+uhsmU/W4
 N/vjs8zL1vStkMohTnoodUmccE8X8QSMQMDVTSXhjvuMJDmATfaQ1BvFe3kfxUWEoUM89PM
 uzcnefEKe1iRPGO4mt7IDXQJjt8v3gYt1AuS0nEQVwd35w4Ys9fXlWvBTcLHsaPSxiY2wRd
 RVmHns36DHWyOzuFjzxyrYxnvUkhD76ugKHqyHNZijJtqUyVJFKqszygTMfJc87+7vM1R8w
 sJ/XCrC2kfYZF7PrXPPAAzvYClM/f7VmU1PNTXoWFEaL3IiNct4c2nM4Ri4DYRrdmQ9K0pL
 uZHsi2Ev8B5G6KmmPrxAtxqwA5MMhmGNYRM8m4SAIXl9S+SJA2JuDdk/mUI3hArfKuqT32G
 V1gMVW2SQbED95hLo3ryaBQkvp+ulc/6maEE+5fpCWowAVapc+Iv/E8deLXLdLPz/I7MqmX
 6/M+HT+eAz9exG1hVMi8dz3gAWYboLE+ornGfqzFhNp0QB6MRdJgghfSKgxqVT7clzEZ3I9
 CI7yghZdIvAnsQKn4uY2v9kkkNNyTOzD4XZIZmoujrS6SUyBgxIDxJqSlJJO/X6fZnMUpLZ
 oqoDrJYT0qgw+Djzhj6+6ueYU1gs+1bfuprycgpN26NbzAagcqWxmnTpPGq1M02kzMSJ3T/
 3fGvtiF5GRQmhCVExoEELQvrbWYPO9XbZ8mF6xl200juukGpTX00xtRJoFxaEBZrwA9+2YL
 nEPmmIOVHihWVHxMEXq8U35FaPB63ch9lf6QwjYoLERuZ8+OaNnERiCNOalNBLs6snbPGtx
 gJiHM+6+9FKb83CKgYDnr5zM18zKXvdrDg1J5kXf4yplER8/m7
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

> @@ -197,33 +204,80 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
>  	if (status)
>  		return status;
> 
> +	/* setup the highest link when no autoneg */
> +	if (!autoneg) {
> +		if (speed & TXGBE_LINK_SPEED_25GB_FULL)
> +			speed = TXGBE_LINK_SPEED_25GB_FULL;
> +		else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
> +			speed = TXGBE_LINK_SPEED_10GB_FULL;
> +	}
> +
>  	speed &= link_capabilities;
>  	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
>  		return TXGBE_ERR_LINK_SETUP;
> 
> -	value = rd32(hw, TXGBE_GPIOEXT);
> -	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
> +	if (txgbe_gpio_ext_check(hw, TXGBE_SFP1_MOD_ABS_LS |
> +				 TXGBE_SFP1_RX_LOS_LS)) {
> +		DEBUGOUT("RX LOS");
>  		return status;
> +	}
> 
> -	status = hw->mac.check_link(hw, &link_speed, &link_up,
> -				    autoneg_wait_to_complete);
> +	for (i = 0; i < 4; i++) {
> +		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +		if (link_up) {
> +			DEBUGOUT("check phy link_up");
> +			break;
> +		}
> +		msleep(250);
> +	}
> 
> -	if (link_up && speed == TXGBE_LINK_SPEED_25GB_FULL)
> +	if (speed == TXGBE_LINK_SPEED_25GB_FULL)
>  		hw->cur_fec_link = txgbe_phy_fec_get(hw);
> 
>  	if (link_speed == speed && link_up &&
> -	   !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
> -	   !(hw->fec_mode & hw->cur_fec_link)))
> -		return status;
> +	    !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
> +	    !(hw->fec_mode & hw->cur_fec_link)))
> +		goto out;
> 
> -	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
> -		speed = 0x10;
> -	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
> -		speed = 0x08;
> +	rte_spinlock_lock(&hw->phy_lock);
> +	ret_status = txgbe_set_link_to_amlite(hw, speed);
> +	rte_spinlock_unlock(&hw->phy_lock);
> +
> +	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
> +		goto out;
> 
> -	status = hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
> +	if (ret_status == TXGBE_ERR_TIMEOUT) {
> +		hw->link_valid = false;
> +		*need_reset = true;
> +		goto out;
> +	} else {
> +		hw->link_valid = true;
> +	}
> +
> +	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
> +		txgbe_e56_fec_polling(hw, &link_up);
> +	} else {
> +		for (i = 0; i < 4; i++) {
> +			txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> +			if (link_up)
> +				goto out;
> +			msleep(250);
> +		}
> +	}
> 
> -	txgbe_wait_for_link_up_aml(hw, speed);
> +out:
> +	if (link_up) {
> +		value = rd32(hw, TXGBE_PORTSTAT);
> +		if (!(value & TXGBE_PORTSTAT_UP)) {
> +			PMD_DRV_LOG(DEBUG, "MAC link 0x14404: 0x%x", value);
> +			*need_reset = true;
> +			value = rd32(hw, 0x110b0);
> +			PMD_DRV_LOG(DEBUG, "MAC intr status 0x110b0: 0x%x", value);
> +		}
> +	} else {
> +		*need_reset = true;
> +		PMD_DRV_LOG(DEBUG, "Link reconfiguration required. Reset scheduled in 2000ms.");
> +	}
> 
 
DEBUGOUT() and PMD_DRV_LOG(DEBUG, ...) can be unified in this function.
 

