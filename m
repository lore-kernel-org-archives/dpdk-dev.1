Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECCC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2613400D6;
	Thu, 17 Apr 2025 09:57:23 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id A6E57400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru D99234C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744876641;
 bh=8tmN1yj4HTQwukMoHXJYsJEDxWDz6WvzQhrtnLQrJjk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hcijsJvNvbFXpxm4CBTR9xE+4l79s06QF/WwW3F4qpK8UxYlJgXTHglOeIPXII0rv
 E5zuEIhS9npKV49FAf5zaEmhAlhowUsicnG9xYbtkhBYNEQniAXsXo2Gi/j+LRMF13
 YXj3e322B7dGDa4shwvsbwF5DLfqSG+dxGS0II4c=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id D99234C;
 Thu, 17 Apr 2025 10:57:21 +0300 (MSK)
Message-ID: <e33103b4-74ab-48ec-b185-7b2b652dd0a2@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:57:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/46] common/sfc_efx/base: support controls for netport
 lane count
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-45-ivan.malov@arknetworks.am>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-45-ivan.malov@arknetworks.am>
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
> On netport MCDI capable adaptors, link modes exported by libefx can be
> backed by different technologies with different lane counts. Allow the
> client drivers to get and set the lane count and query possible values.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>

[snip]

> @@ -1190,8 +1357,9 @@ efx_np_link_ctrl(
>   
>   		rc = efx_np_sw_link_mode_to_cap(loopback_link_mode,
>   					    &cap_enum_sw);
> -		if (rc != 0)
> +		if (rc != 0) {
>   			goto fail2;
> +		}

Looks like unrelated style change

>   
>   		EFX_NP_CAP_ENUM_SW_TO_HW(efx_np_cap_map_tech,
>   		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_enum_sw,

