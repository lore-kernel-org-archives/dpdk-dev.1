Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F3C87FCA
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 11:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4541840611;
	Sat, 26 Jul 2025 13:51:27 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 497A040609
 for <dev@dpdk.org>; Sat, 26 Jul 2025 13:51:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 241EC50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753530685;
 bh=6iknixrfuI5YWrSlsG+3QUuZYbBDU2eIbb33hX/E7dk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XF0Hb2XjEuGOg4h/fB9meVD9R7UJg/glyu0rvgVYmnGUJ4BZ396MjfyrIrj0/V4fS
 IqkhMxpn7vYcyh0r2PpGNv2g8XFkg64lCZpRYQPFBqXn8w6qE/plkHiLdWXWN6YNeF
 qGe8wDEPMbcqpseNopkL7+oqlNSmq3pMzQwuhhf4=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 241EC50;
 Sat, 26 Jul 2025 14:51:25 +0300 (MSK)
Message-ID: <5d2ee34b-038c-4661-9bd6-1916fe1b0491@oktetlabs.ru>
Date: Sat, 26 Jul 2025 14:51:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] common/sfc_efx/base: fix compiler warnings in
 statistic code
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250711144349.9236-2-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250711144349.9236-2-ivan.malov@arknetworks.am>
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

On 7/11/25 17:43, Ivan Malov wrote:
> Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
> 
> Suggested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> ---
>   drivers/common/sfc_efx/base/efx_np.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
> index a19c986691..798fcce26c 100644
> --- a/drivers/common/sfc_efx/base/efx_np.c
> +++ b/drivers/common/sfc_efx/base/efx_np.c
> @@ -750,7 +750,7 @@ efx_np_stat_describe(
>   	return;
>   
>   found:
> -	if (sw_id >= lut_nentries) {
> +	if ((unsigned int)sw_id >= lut_nentries) {

Unfortunately it is not trivial to understand what's happening here
without looking at code. I bit more verbose description would be
helpful.

>   		/*
>   		 * Static mapping size and the size of lookup
>   		 * table are out-of-sync. Should never happen.
> @@ -782,7 +782,6 @@ efx_np_stats_describe(
>   	EFX_MCDI_DECLARE_BUF(payload,
>   	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
>   	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
> -	efx_port_t *epp = &(enp->en_port);

I guess the variable is simply unused.

>   	uint32_t nprocessed;
>   	efx_mcdi_req_t req;
>   	uint8_t *entries;

IMHO it would be better to group similar fixes as unused variables into
single patch which clearly explains what's happening.
The goal is to "fix unused variable warnings".
The way is to "Remove unused variables."

