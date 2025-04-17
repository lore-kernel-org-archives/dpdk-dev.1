Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6494DC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C674025A;
	Thu, 17 Apr 2025 09:14:29 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id D3978400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:14:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 6BA174C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744874066;
 bh=gVqqUez0TwcU2dNMXWG+zhJlb+5zxJg9IiVpYNZgVMY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AHJ9XCwzzyJyk5Wafjm4tyJe3MG5zOlTMsMnkgAu9frWOplAuNIHsDIWgaJkm/PE4
 VP9RT1KrcOi2Y28nwNEHzkLp8iUqP/5DMhvE+a4T69kQQxm3qJdQTftRhTR/qVgRMd
 FNotp3HPcUUaHH7BawqvKNmdNmxwLC6b7rJLntRY=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 6BA174C;
 Thu, 17 Apr 2025 10:14:26 +0300 (MSK)
Message-ID: <d7aedb23-9e97-4a49-bf50-acf81286ae86@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:14:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/46] common/sfc_efx/base: add Medford4 support to NIC
 module
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-4-ivan.malov@arknetworks.am>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-4-ivan.malov@arknetworks.am>
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

On 4/16/25 16:59, Ivan Malov wrote:
> From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
> 
> Implement NIC family discovery and minimum probe support.
> 
> Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>

[snip]

> @@ -1922,6 +1923,36 @@ static struct ef10_external_port_map_s {
>   		(1U << TLV_PORT_MODE_1x1_1x1),			/* mode 2 */
>   		{ 0, 1, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
>   	},
> +	/*
> +	 * Modes that on Medford4 allocate 2 adjacent port numbers to cage 1
> +	 * and the rest to cage 2.
> +	 *	port 0 -> cage 1
> +	 *	port 1 -> cage 1
> +	 *	port 2 -> cage 2
> +	 *	port 3 -> cage 2
> +	 */
> +	{
> +		EFX_FAMILY_MEDFORD4,
> +		(1U << TLV_PORT_MODE_2x1_2x1) |			/* mode 5 */
> +		(1U << TLV_PORT_MODE_2x1_1x4) |			/* mode 7 */
> +		(1U << TLV_PORT_MODE_2x2_NA) |			/* mode 13 */
> +		(1U << TLV_PORT_MODE_2x1_1x2),			/* mode 18 */
> +		{ 0, 2, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
> +	},
> +	/*
> +	 * Modes that on Medford4 allocate up to 4 adjacent port numbers
> +	 * to cage 1.
> +	 *	port 0 -> cage 1
> +	 *	port 1 -> cage 1
> +	 *	port 2 -> cage 1
> +	 *	port 3 -> cage 1
> +	 */
> +	{
> +		EFX_FAMILY_MEDFORD4,
> +		(1U << TLV_PORT_MODE_4x1_NA),			/* mode 4 */
> +		{ 0, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
> +	},
> +	/* FIXME: review Medford4 port modes */

Is it still true at the moment of submission?

>   };
>   
>   static	__checkReturn	efx_rc_t
> diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
> index dabf2e0e0b..442dfa0830 100644
> --- a/drivers/common/sfc_efx/base/efx.h
> +++ b/drivers/common/sfc_efx/base/efx.h
> @@ -190,6 +190,7 @@ efx_family_probe_bar(
>   /* FIXME Fix it when memory bar is fixed in FPGA image. It must be 0. */
>   #define	EFX_MEM_BAR_RIVERHEAD			2
>   
> +#define	EFX_MEM_BAR_MEDFORD4			0

IMHO it is wrong that you add it here and fix in later patches.
It just adds noise to mailing list and git blame.
IMHO fix should be squashed and correct BAR should be specified
from the very beginning.

>   
>   /* Error codes */
>   

[snip]

> diff --git a/drivers/common/sfc_efx/base/efx_nic.c b/drivers/common/sfc_efx/base/efx_nic.c
> index 172488e083..5bcc0a04ff 100644
> --- a/drivers/common/sfc_efx/base/efx_nic.c
> +++ b/drivers/common/sfc_efx/base/efx_nic.c
> @@ -79,6 +79,19 @@ efx_family(
>   			return (0);
>   #endif /* EFSYS_OPT_MEDFORD2 */
>   
> +#if EFSYS_OPT_MEDFORD4
> +		case EFX_PCI_DEVID_MEDFORD4_PF_UNINIT:
> +			/*
> +			 * Hardware default for PF0 of uninitialised Medford4.
> +			 * manftest must be able to cope with this device id.
> +			 */
> +		case EFX_PCI_DEVID_MEDFORD4:
> +		case EFX_PCI_DEVID_MEDFORD4_VF:
> +			*efp = EFX_FAMILY_MEDFORD4;
> +			*membarp = EFX_MEM_BAR_MEDFORD4;
> +			return (0);
> +#endif /* EFSYS_OPT_MEDFORD4 */
> +

It is a dead code from build point of view if I stop on the patch since
EFSYS_OPT_MEDFORD4 is 0. May be it is OK, but I'd like to ensure that
you have checked it if EFSYS_OPT_MEDFORD4==1 before the patch to avoid
build fixes noise later.

Same for all similar blocks below and subsequent patches.

>   		case EFX_PCI_DEVID_FALCON:	/* Obsolete, not supported */
>   		default:
>   			break;

[snip]


