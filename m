Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CFC369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D0614042F;
	Wed, 23 Apr 2025 21:15:16 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id B4533400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 287BE4A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1745435714;
 bh=gGJ55jzWrON3UPBM0ZN7iz+rTj3KbDU0Y0sbwKJie6w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bWYr7c+bnfOi1ozzaZFns4CGIiUJR6oYuxJoJSv8QrBTI9fB9PxDNEHX9JtJDEpLp
 RFmJAPFKlMqwjCyj+Ex1Xb64W/kkv3se8JAMyCqzGJZz6P+JZs8dunQOkZzvA0HZgU
 lN6INahc5U+xjTQSts3zZv44I9OMw99kQyNfKRRc=
Received: from [192.168.1.41] (unknown [188.242.176.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 287BE4A;
 Wed, 23 Apr 2025 22:15:14 +0300 (MSK)
Message-ID: <2abe7a87-1083-4ec3-a3d4-50f2c00c4a59@oktetlabs.ru>
Date: Wed, 23 Apr 2025 22:15:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/45] common/sfc_efx/base: add Medford4 support to PHY
 module
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-9-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250423160002.35706-9-ivan.malov@arknetworks.am>
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

On 4/23/25 18:59, Ivan Malov wrote:
> From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
> 
> Use common EF10 method table for that.
> 
> Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> ---
>   drivers/common/sfc_efx/base/efx_phy.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
> index d55becae18..3d792f20b8 100644
> --- a/drivers/common/sfc_efx/base/efx_phy.c
> +++ b/drivers/common/sfc_efx/base/efx_phy.c
> @@ -114,6 +114,12 @@ efx_phy_probe(
>   		break;
>   #endif	/* EFSYS_OPT_MEDFORD2 */
>   
> +#if EFSYS_OPT_MEDFORD4
> +	case EFX_FAMILY_MEDFORD4:
> +		epop = &__efx_phy_ef10_ops;
> +	break;

Strange location of break

> +#endif	/* EFSYS_OPT_MEDFORD4 */
> +
>   	default:
>   		rc = ENOTSUP;
>   		goto fail1;

