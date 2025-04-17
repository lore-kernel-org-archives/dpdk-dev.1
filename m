Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDEAC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D614025A;
	Thu, 17 Apr 2025 09:08:24 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 9887E400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:08:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 3054F4C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744873701;
 bh=vd/yR2gI/VznLzkkBPlCJlBAHKEFyYFD9AKrrmEgM8I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IAbORM/c9CRNwATD0wrpfOBhWFEXihZK1cJHx2F8aUBPyYcYORns8pq5Y/nlRuePG
 KhZsP0CiLCqFbGjEA6QpdtUVt1FH/zepo7aplew3DJU+/6ou8AUlq7FmsD7u4CIJ3n
 aBn3EgCiJFI/ktaCBZhzhmdPpjv+7HBpVrIKFRjA=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 3054F4C;
 Thu, 17 Apr 2025 10:08:21 +0300 (MSK)
Message-ID: <0c7ada9e-26ea-4dae-a1ce-39a3be6127c8@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/46] common/sfc_efx/base: add efsys option for Medford4
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-3-ivan.malov@arknetworks.am>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-3-ivan.malov@arknetworks.am>
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
> Later patches will use this to implement support for Medford4.
> 
> Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> ---
>   drivers/common/sfc_efx/base/efx_check.h | 24 ++++++++++++++----------
>   drivers/common/sfc_efx/efsys.h          |  2 ++
>   2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/common/sfc_efx/base/efx_check.h b/drivers/common/sfc_efx/base/efx_check.h
> index 66b38eeae0..0b9f4fb516 100644
> --- a/drivers/common/sfc_efx/base/efx_check.h
> +++ b/drivers/common/sfc_efx/base/efx_check.h

[snip]

> @@ -197,7 +198,7 @@
>   
>   #if EFSYS_OPT_IMAGE_LAYOUT
>   /* Support signed image layout handling */
> -# if !(EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
> +# if !(EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4)
>   #  error "IMAGE_LAYOUT requires MEDFORD or MEDFORD2"

MEDRORD4 is lost here in error message

>   # endif
>   #endif /* EFSYS_OPT_IMAGE_LAYOUT */
> @@ -338,8 +339,10 @@
>   
>   #if EFSYS_OPT_ALLOW_UNCONFIGURED_NIC
>   /* Support adapters with missing static config (for factory use only) */
> -# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
> -#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2"
> +# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || \
> +	EFSYS_OPT_MEDFORD4)
> +#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2 " \
> +	"or MEDFORD4"

Typically it is a bad idea to split error message since it complicates grep.
Please, double-check that base driver code style requires.
As far as I remember - no.

>   # endif
>   #endif /* EFSYS_OPT_ALLOW_UNCONFIGURED_NIC */
>   

[snip]

