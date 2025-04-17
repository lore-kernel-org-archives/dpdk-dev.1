Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB2C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D815D400D6;
	Thu, 17 Apr 2025 09:43:31 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id CD566400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:43:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 0CAFD4C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744875810;
 bh=pbDgVzA1/vJiK25dYaA2Zeer53tjZbf48TZxpjpdz3g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xqbb7Ovc9/lXCPMNdf099Wno9XhmuhvE6ebf/xGwuYG17/N6rDO8UArIsRHI/E4n0
 g2E4EjEi9nYTGtsUAxMPwsIe6P8MzFDF0PG9KagIFhlaODyz/vKtTJfFXsMewBHYcs
 3+K3B1KXoIMf5IMTEvnWPdBL5pnAAdYNl3ux8di0=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 0CAFD4C;
 Thu, 17 Apr 2025 10:43:30 +0300 (MSK)
Message-ID: <fc881a88-03d1-4fc8-b9f5-bd9103c9b540@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:43:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/46] common/sfc_efx/base: support MAC statistics on
 Medford4 NICs
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-36-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-36-ivan.malov@arknetworks.am>
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
> Supply Medford4-specific methods to clear, upload and update
> MAC statistics, as well as the method to toggle periodic DMA
> updates. All of these leverage the same netport MCDI command.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>

[snip]

> diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
> index eb1b68b17e..31fcb361f2 100644
> --- a/drivers/common/sfc_efx/base/ef10_nic.c
> +++ b/drivers/common/sfc_efx/base/ef10_nic.c
> @@ -2523,7 +2523,9 @@ ef10_nic_probe(
>   
>   #if EFSYS_OPT_MAC_STATS
>   	/* Wipe the MAC statistics */
> -	if ((rc = efx_mcdi_mac_stats_clear(enp)) != 0)
> +
> +	rc = efx_mcdi_mac_stats_clear(enp);
> +	if (rc != 0)

it looks like unrelated style change.

>   		goto fail6;
>   #endif
>   

[snip]

> diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
> index d4ee17ffb4..df836f09a6 100644
> --- a/drivers/common/sfc_efx/base/efx_np.c
> +++ b/drivers/common/sfc_efx/base/efx_np.c
> @@ -1291,3 +1291,92 @@ efx_np_mac_ctrl(
>   	EFSYS_PROBE1(fail1, efx_rc_t, rc);
>   	return (rc);
>   }
> +
> +#if EFSYS_OPT_MAC_STATS
> +	__checkReturn	efx_rc_t
> +efx_np_mac_stats(
> +	__in		efx_nic_t *enp,
> +	__in		efx_np_handle_t nph,
> +	__in		efx_stats_action_t action,
> +	__in_opt	const efsys_mem_t *esmp,
> +	__in		uint16_t period_ms)
> +{
> +	EFX_MCDI_DECLARE_BUF(payload,
> +	    MC_CMD_GET_NETPORT_STATISTICS_IN_LEN,
> +	    MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN);
> +	int enable = (action == EFX_STATS_ENABLE_NOEVENTS);
> +	int events = (action == EFX_STATS_ENABLE_EVENTS);
> +	int disable = (action == EFX_STATS_DISABLE);
> +	int upload = (action == EFX_STATS_UPLOAD);
> +	int clear = (action == EFX_STATS_CLEAR);

IMHO boolean_t should be used for 5 above variables.

> +	efx_mcdi_req_t req;
> +	efx_rc_t rc;

[snip]

> +
> +		/* TODO: validate encp->enc_mac_stats_nstats */

TODO again. The new code is full of TODO and FIXME. It looks like it has
huge backlog. What's the problem to fix the TODO? Is the driver really
ready?

> +		sz = encp->enc_mac_stats_nstats * sizeof (efx_qword_t);
> +
[snip]

> +	__checkReturn		efx_rc_t
> +medford4_mac_stats_periodic(
> +	__in			efx_nic_t *enp,
> +	__in			efsys_mem_t *esmp,
> +	__in			uint16_t period_ms,
> +	__in			boolean_t events)
> +{
> +	efx_port_t *epp = &(enp->en_port);
> +	efx_rc_t rc;
> +
> +	if (period_ms == 0) {
> +		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
> +			    EFX_STATS_DISABLE, NULL, 0);
> +	} else if (events != B_FALSE) {
> +		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
> +			    EFX_STATS_ENABLE_EVENTS, esmp, period_ms);
> +	} else {
> +		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
> +			    EFX_STATS_ENABLE_NOEVENTS, esmp, period_ms);
> +	}
> +
> +	if (rc != 0)
> +		goto fail1;
> +
> +	return (0);
> +
> +fail1:
> +	EFSYS_PROBE1(fail1, efx_rc_t, rc);
> +	return (rc);
> +}
> +
> +#define	MEDFORD4_MAC_STAT_READ(_esmp, _field, _eqp)			\
> +	EFSYS_MEM_READQ((_esmp), (_field) * sizeof (efx_qword_t), _eqp)
> +
> +	__checkReturn			efx_rc_t
> +medford4_mac_stats_update(
> +	__in				efx_nic_t *enp,
> +	__in				efsys_mem_t *esmp,
> +	__inout_ecount(EFX_MAC_NSTATS)	efsys_stat_t *stats,
> +	__inout_opt			uint32_t *generationp)
> +{
> +	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
> +	efx_port_t *epp = &(enp->en_port);
> +	efx_qword_t generation_start;
> +	efx_qword_t generation_end;
> +	unsigned int i;
> +	efx_rc_t rc;
> +
> +	/* TODO: validate encp->enc_mac_stats_nstats */
> +	if (EFSYS_MEM_SIZE(esmp) <
> +	    (encp->enc_mac_stats_nstats * sizeof (efx_qword_t))) {
> +		/* DMA buffer too small */
> +		rc = ENOSPC;
> +		goto fail1;
> +	}
> +
> +	/* Read END first so we don't race with the MC */
> +	EFSYS_DMA_SYNC_FOR_KERNEL(esmp, 0, EFSYS_MEM_SIZE(esmp));
> +	MEDFORD4_MAC_STAT_READ(esmp, (encp->enc_mac_stats_nstats - 1),
> +	    &generation_end);
> +	EFSYS_MEM_READ_BARRIER();
> +
> +	for (i = 0; i < EFX_ARRAY_SIZE(epp->ep_np_mac_stat_lut); ++i) {
> +		efx_qword_t value;
> +
> +		if (epp->ep_np_mac_stat_lut[i].ens_valid == B_FALSE)
> +			continue;
> +
> +		MEDFORD4_MAC_STAT_READ(esmp,
> +		    epp->ep_np_mac_stat_lut[i].ens_dma_fld, &value);
> +
> +		EFSYS_STAT_SET_QWORD(&(stats[i]), &value);
> +	}
> +
> +	/* TODO: care about VADAPTOR statistics */

TODO again

> +
> +	/* Read START generation counter */
> +	EFSYS_DMA_SYNC_FOR_KERNEL(esmp, 0, EFSYS_MEM_SIZE(esmp));
> +	EFSYS_MEM_READ_BARRIER();
> +
> +	/* FIXME: we never parse marker descriptors; assume start is 0 offset */

FIXME again

> +	MEDFORD4_MAC_STAT_READ(esmp, 0, &generation_start);
> +
> +	/* Check that we didn't read the stats in the middle of a DMA */
> +	if (memcmp(&generation_start, &generation_end,
> +		    sizeof (generation_start)) != 0)
> +		return (EAGAIN);
> +
> +	if (generationp != NULL)
> +		*generationp = EFX_QWORD_FIELD(generation_start, EFX_DWORD_0);
> +
> +	return (0);
> +
> +fail1:
> +	EFSYS_PROBE1(fail1, efx_rc_t, rc);
> +	return (rc);
> +}
> +
> +#undef MEDFORD4_MAC_STAT_READ
>   #endif /* EFSYS_OPT_MAC_STATS */
>   #endif /* EFSYS_OPT_MEDFORD4 */

