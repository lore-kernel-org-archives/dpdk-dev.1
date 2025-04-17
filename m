Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03CC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 07:31:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF75E40263;
	Thu, 17 Apr 2025 09:31:18 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id A6EF8400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru CFFCE4C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744875076;
 bh=Kqt4fuGQPp5AuLLbg0UK+rvQn5mD2NKeLxOzB4wkDFc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k5UiIs+Jz3pzAHWIvSln1OfPzchjiOsM1rhrpyNC5wFQLSqAF7jp5FgDMY4BhzhmR
 rPn/oNDdODC9bX1mUoVCo3WHQlQPtZxYcfyJ4sCc0QL03vd8561Q+Q21eKD9jUW1Y0
 6FaChox9VKXzqWbYoslw29tPRnStUhtF3pYBWdJ4=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id CFFCE4C;
 Thu, 17 Apr 2025 10:31:16 +0300 (MSK)
Message-ID: <a4080576-6901-44f4-aae2-8952d539b46d@oktetlabs.ru>
Date: Thu, 17 Apr 2025 10:31:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/46] common/sfc_efx/base: implement PHY link control for
 Medford4
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-31-ivan.malov@arknetworks.am>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-31-ivan.malov@arknetworks.am>
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
> Use new MCDI to select loopback, speed, flow control and FEC.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>

[snip]

> +static					void
> +efx_np_cap_sw_mask_to_hw_enum(
> +	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
> +	__in				unsigned int hw_sw_map_nentries,
> +	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
> +	__in				size_t hw_cap_data_nbytes,
> +	__in				uint32_t mask_sw,
> +	__out				boolean_t *supportedp,
> +	__out_opt			uint16_t *enum_hwp)
> +{
> +	unsigned int sw_nflags_req = 0;
> +	unsigned int sw_nflags_sup = 0;
> +	uint32_t sw_check_mask = 0;
> +	unsigned int i;
> +
> +	for (i = 0; i < hw_sw_map_nentries; ++i) {
> +		uint32_t flag_sw = 1U << hw_sw_map->encm_sw;
> +		unsigned int byte_idx = CAP_BYTE(hw_sw_map);
> +		uint8_t flag_hw = CAP_FLAG(hw_sw_map);
> +
> +		if (byte_idx >= hw_cap_data_nbytes) {
> +			++(hw_sw_map);
> +			continue;
> +		}
> +
> +		if ((mask_sw & flag_sw) == flag_sw) {
> +			if ((sw_check_mask & flag_sw) == 0)
> +				++(sw_nflags_req);
> +
> +			sw_check_mask |= flag_sw;
> +
> +			if ((hw_cap_data[byte_idx] & flag_hw) == flag_hw) {
> +				mask_sw &= ~(flag_sw);
> +
> +				if (enum_hwp != NULL)
> +					*enum_hwp = hw_sw_map->encm_hw;
> +			}
> +		}
> +
> +		++(hw_sw_map);
> +	}
> +
> +	/*
> +	 * FIXME: in the absence of autonegotiation capability, drivers
> +	 * may still pass multiple capability bits of the same category.
> +	 * That is supposed to work on EF10; do not enforce below check.
> +	 */
> +#if 0

It looks rather strange when code with #if 0 comes.

> +	if (sw_nflags_req != 1) {
> +		/*
> +		 * The mask must contain exactly one relevant
> +		 * flag which represents some specific choice.
> +		 */
> +		*supportedp = B_FALSE;
> +		return;
> +	}
> +#endif
> +
> +	if (sw_check_mask != 0 && (mask_sw & sw_check_mask) == sw_check_mask) {
> +		/* Failed to select the enum by at least one capability bit. */
> +		*supportedp = B_FALSE;
> +		return;
> +	}
> +
> +	*supportedp = B_TRUE;
> +}

[snip]
