Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E22D38FF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:37:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E46AC40A76;
	Wed, 14 Jan 2026 18:37:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D0B764027D;
 Wed, 14 Jan 2026 18:37:35 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C0E1515;
 Wed, 14 Jan 2026 09:37:28 -0800 (PST)
Received: from [10.122.40.95] (unknown [10.122.40.95])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6C943F59E;
 Wed, 14 Jan 2026 09:37:34 -0800 (PST)
Message-ID: <63f59ea1-983c-48b2-a502-c6546f149a1e@arm.com>
Date: Wed, 14 Jan 2026 11:37:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config/arm: fix 32-bit cross compile with latest GCC
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org
References: <20260114171335.3051704-1-bruce.richardson@intel.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260114171335.3051704-1-bruce.richardson@intel.com>
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


On 1/14/26 11:13, Bruce Richardson wrote:
> When building for 32-bit arm with GCC versions >=11 and using the
> DPDK-provided cross-file, the initial configuration step fails  The
> error given is:
>
>    config/meson.build:189:8: ERROR: Problem encountered: \
> 		Compiler does not support "armv8-a" arch flag.
>
> but the real problem is actually an fpu-related error which is explained
> in the meson log file:
>
>    cc1: error: '-mfloat-abi=hard': selected architecture lacks an FPU
>
> This error can be fixed by specifying an fpu explicitly, and a number of
> options will work, e.g. -mfpu=neon, -mfpu=fp-armv8. Choosing the latter
> here to avoid mandating neon by default.
>
> Fixes: e754875c296c ("config/arm: add aarch32 cross-compilation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

>
> ---
> This patch should fix errors seen in the CI when building for 32-bit arm
> on Ubuntu 24.04 and later. CI systems running older Ubuntu using GCC 9
> do not show this error, which is why it hasn't been an issue till
> recently.
> ---
>   config/arm/arm32_armv8_linux_gcc | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/config/arm/arm32_armv8_linux_gcc b/config/arm/arm32_armv8_linux_gcc
> index abcb182b16..231c9ac7a7 100644
> --- a/config/arm/arm32_armv8_linux_gcc
> +++ b/config/arm/arm32_armv8_linux_gcc
> @@ -13,5 +13,8 @@ cpu_family = 'aarch32'
>   cpu = 'armv8-a'
>   endian = 'little'
>   
> +[built-in options]
> +c_args = '-mfpu=fp-armv8'
> +
>   [properties]
>   platform = 'generic_aarch32'
