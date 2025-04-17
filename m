Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12692C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3E0440263;
	Thu, 17 Apr 2025 09:34:17 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 2E782400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 59ADF4C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744875255;
 bh=ELqoCEkwC0mh6ynJsyfGBwkGphovwa6hhVU1uNCFlyA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tXCkUCaI3+/mVmLG5Cft24liuOyuk1q4GX55BRUND7VL9uaW5STjju083vz2hmKNz
 2snd9nD83s7QtBjc/NzWCXTxBP9IehELuQ0ffnd58pc/m8GgtNO6cOjkk5X25qLJFB
 ULxAQBK0+ENZVDRJAYz9p5ArQWLiUfx/JkhH+Tbw=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 59ADF4C;
 Thu, 17 Apr 2025 10:34:15 +0300 (MSK)
Message-ID: <fbf426f5-7bb0-4666-bef1-41dc780265e9@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:34:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/46] common/sfc_efx/base: add MAC reconfigure method for
 Medford4
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-33-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-33-ivan.malov@arknetworks.am>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/16/25 17:00, Ivan Malov wrote:
> That leverages MAC control functionality of new netport MCDI.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---
>   drivers/common/sfc_efx/base/efx_impl.h      | 13 ++++
>   drivers/common/sfc_efx/base/efx_mac.c       |  2 +-
>   drivers/common/sfc_efx/base/efx_np.c        | 73 +++++++++++++++++++++
>   drivers/common/sfc_efx/base/medford4_impl.h |  5 ++
>   drivers/common/sfc_efx/base/medford4_mac.c  | 32 +++++++++
>   5 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
> index 15cf62506e..ac1cd5292b 100644
> --- a/drivers/common/sfc_efx/base/efx_impl.h
> +++ b/drivers/common/sfc_efx/base/efx_impl.h
> @@ -1947,6 +1947,19 @@ efx_np_link_ctrl(
>   	__in		uint32_t cap_mask_sw,
>   	__in		boolean_t fcntl_an);
>   
> +typedef struct efx_np_mac_ctrl_s {
> +	boolean_t	enmc_fcntl_autoneg;
> +	boolean_t	enmc_include_fcs;
> +	uint32_t	enmc_fcntl;
> +} efx_np_mac_ctrl_t;
> +
> +LIBEFX_INTERNAL
> +extern	__checkReturn	efx_rc_t
> +efx_np_mac_ctrl(
> +	__in		efx_nic_t *enp,
> +	__in		efx_np_handle_t nph,
> +	__in		const efx_np_mac_ctrl_t *mc);
> +
>   #ifdef	__cplusplus
>   }
>   #endif
> diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
> index dde0e5ab87..3c29db0016 100644
> --- a/drivers/common/sfc_efx/base/efx_mac.c
> +++ b/drivers/common/sfc_efx/base/efx_mac.c
> @@ -96,7 +96,7 @@ static const efx_mac_ops_t	__efx_mac_medford4_ops = {
>   	ef10_mac_addr_set,			/* emo_addr_set */
>   	ef10_mac_pdu_set,			/* emo_pdu_set */
>   	ef10_mac_pdu_get,			/* emo_pdu_get */
> -	ef10_mac_reconfigure,			/* emo_reconfigure */
> +	medford4_mac_reconfigure,		/* emo_reconfigure */
>   	ef10_mac_multicast_list_set,		/* emo_multicast_list_set */
>   	ef10_mac_filter_default_rxq_set,	/* emo_filter_default_rxq_set */
>   	ef10_mac_filter_default_rxq_clear,
> diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
> index 03d49b9c78..826ee93f0f 100644
> --- a/drivers/common/sfc_efx/base/efx_np.c
> +++ b/drivers/common/sfc_efx/base/efx_np.c
> @@ -923,6 +923,79 @@ efx_np_link_ctrl(
>   fail2:
>   	EFSYS_PROBE(fail2);
>   
> +fail1:
> +	EFSYS_PROBE1(fail1, efx_rc_t, rc);
> +	return (rc);
> +}
> +
> +	__checkReturn	efx_rc_t
> +efx_np_mac_ctrl(
> +	__in		efx_nic_t *enp,
> +	__in		efx_np_handle_t nph,
> +	__in		const efx_np_mac_ctrl_t *mc)
> +{
> +	EFX_MCDI_DECLARE_BUF(payload,
> +	    MC_CMD_MAC_CTRL_IN_LEN,
> +	    MC_CMD_MAC_CTRL_OUT_LEN);
> +	efx_mcdi_req_t req;
> +	uint32_t flags = 0;
> +	uint32_t cfg = 0;
> +	uint32_t fcntl;
> +	efx_rc_t rc;
> +
> +	req.emr_out_length = MC_CMD_MAC_CTRL_OUT_LEN;
> +	req.emr_in_length = MC_CMD_MAC_CTRL_IN_LEN;
> +	req.emr_cmd = MC_CMD_MAC_CTRL;
> +	req.emr_out_buf = payload;
> +	req.emr_in_buf = payload;
> +
> +	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_PORT_HANDLE, nph);
> +
> +	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
> +	if (mc->enmc_include_fcs != B_FALSE)
> +		flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
> +
> +	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FLAGS, flags);
> +
> +	if (mc->enmc_fcntl_autoneg != B_FALSE) {
> +		fcntl = MC_CMD_FCNTL_AUTO;
> +	} else {
> +		switch (mc->enmc_fcntl) {
> +		case 0:
> +			fcntl = MC_CMD_FCNTL_OFF;
> +			break;
> +		case EFX_FCNTL_RESPOND:
> +			fcntl = MC_CMD_FCNTL_RESPOND;
> +			break;
> +		case EFX_FCNTL_GENERATE:
> +			fcntl = MC_CMD_FCNTL_GENERATE;
> +			break;
> +		case EFX_FCNTL_RESPOND | EFX_FCNTL_GENERATE:
> +			fcntl = MC_CMD_FCNTL_BIDIR;
> +			break;
> +		default:
> +			rc = EINVAL;
> +			goto fail1;
> +		}
> +	}
> +
> +	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
> +	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
> +
> +	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_V2_CONTROL_FLAGS, cfg);
> +
> +	efx_mcdi_execute(enp, &req);
> +
> +	if (req.emr_rc != 0) {
> +		rc = req.emr_rc;
> +		goto fail2;
> +	}
> +
> +	return (0);
> +
> +fail2:
> +	EFSYS_PROBE(fail2);
> +
>   fail1:
>   	EFSYS_PROBE1(fail1, efx_rc_t, rc);
>   	return (rc);
> diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
> index 6aa065c730..8b232c516a 100644
> --- a/drivers/common/sfc_efx/base/medford4_impl.h
> +++ b/drivers/common/sfc_efx/base/medford4_impl.h
> @@ -51,6 +51,11 @@ medford4_mac_up(
>   	__in		efx_nic_t *enp,
>   	__out		boolean_t *mac_upp);
>   
> +LIBEFX_INTERNAL
> +extern	__checkReturn		efx_rc_t
> +medford4_mac_reconfigure(
> +	__in			efx_nic_t *enp);
> +
>   #ifdef	__cplusplus
>   }
>   #endif
> diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
> index 57ddbecfaa..c037c29b92 100644
> --- a/drivers/common/sfc_efx/base/medford4_mac.c
> +++ b/drivers/common/sfc_efx/base/medford4_mac.c
> @@ -47,6 +47,38 @@ medford4_mac_up(
>   	*mac_upp = els.els_mac_up;
>   	return (0);
>   
> +fail1:
> +	EFSYS_PROBE1(fail1, efx_rc_t, rc);
> +	return (rc);
> +}
> +
> +	__checkReturn		efx_rc_t
> +medford4_mac_reconfigure(
> +	__in			efx_nic_t *enp)
> +{
> +	efx_port_t *epp = &(enp->en_port);
> +	efx_np_mac_ctrl_t mc = {0};
> +	efx_rc_t rc;
> +
> +	mc.enmc_fcntl_autoneg = epp->ep_fcntl_autoneg;
> +	mc.enmc_include_fcs = epp->ep_include_fcs;
> +	mc.enmc_fcntl = epp->ep_fcntl;
> +
> +	rc = efx_np_mac_ctrl(enp, epp->ep_np_handle, &mc);
> +	if (rc != 0)
> +		goto fail1;
> +
> +	/*
> +	 * Apply the filters for the MAC configuration. If the NIC isn't ready
> +	 * to accept filters, this may return success without setting anything.
> +	 */
> +	rc = efx_filter_reconfigure(enp, epp->ep_mac_addr,
> +				    epp->ep_all_unicst, epp->ep_mulcst,
> +				    epp->ep_all_mulcst, epp->ep_brdcst,
> +				    epp->ep_mulcst_addr_list,
> +				    epp->ep_mulcst_addr_count);

I'm sorry, but above comments are insufficient for me to understand why
ignoring rc is OK and it looks like a bug.

> +	return (0);
> +
>   fail1:
>   	EFSYS_PROBE1(fail1, efx_rc_t, rc);
>   	return (rc);

