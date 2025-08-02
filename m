Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7B0C87FD2
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 08:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBFC40662;
	Sat,  2 Aug 2025 10:20:50 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 42A2040041
 for <dev@dpdk.org>; Sat,  2 Aug 2025 10:20:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 03F3A38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754122847;
 bh=npZuXo4pfGzB5kPz7bzc5PR9IhTlI6u7+g3YBwv/JyY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F3xu3yXVeIHbMvfRR7Y88EyjFCoBfVqdp+TsnM0dumAkBqICvdX22gHtdS8M+alPB
 P6WrxghFS3SO7Hiupa47XpnBdkwjXicsCQI5ZIx7vGu2VT7imWiGzG93jZSpJLRf3M
 R2axO3qd5xkJTp4+BnjEXZ4oOIl9ggDC1QigykpI=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 03F3A38;
 Sat,  2 Aug 2025 11:20:46 +0300 (MSK)
Message-ID: <06f2d1ec-713a-48bd-8b26-5469afca6e85@oktetlabs.ru>
Date: Sat, 2 Aug 2025 11:20:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] common/sfc_efx/base: fix compiler warnings in X4
 netport API
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250802043010.39134-1-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250802043010.39134-1-ivan.malov@arknetworks.am>
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

On 8/2/25 07:30, Ivan Malov wrote:
> The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
> This series is a follow-up to [1] to fix compiler warnings in the base
> driver that are seen in Windows driver build, also based on this driver.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=35095
> 
> v2:
> - re-group the changes the way Andrew suggested
> - include Cc to 'stable', to have this in 25.07
> 
> Ivan Malov (2):
>    common/sfc_efx/base: resolve warnings about unused variables
>    common/sfc_efx/base: clean up type-related compiler warnings
> 
>   drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
>   drivers/common/sfc_efx/base/medford4_phy.c | 1 -
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 

Series-acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

