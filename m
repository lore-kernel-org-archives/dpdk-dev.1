Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9ECAC5B9
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Sep 2025 06:34:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 352BE40268;
	Sat, 27 Sep 2025 08:34:00 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 076C540261;
 Sat, 27 Sep 2025 08:33:58 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 8B92611C27;
 Sat, 27 Sep 2025 08:33:58 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 7081111C88; Sat, 27 Sep 2025 08:33:58 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 4693811BD8;
 Sat, 27 Sep 2025 08:33:56 +0200 (CEST)
Message-ID: <28464878-8221-4bdb-b63a-8e1414c24302@lysator.liu.se>
Date: Sat, 27 Sep 2025 08:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] eal/arm: fix C++ build for 32-bit memcpy
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-7-david.marchand@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250926124103.750844-7-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 9/26/25 14:40, David Marchand wrote:
> This was caught while checking ARM arch headers.
> 
> In file included from buildtools/chkincs/chkincs-cpp.p/rte_memcpy_32.cpp:1:
> /home/runner/work/dpdk/dpdk/lib/eal/arm/include/rte_memcpy_32.h:302:1:
> 	error: expected declaration before ‘}’ token
>    302 | }
>        | ^
> 

Acked-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

> Fixes: 719834a6849e ("use C linkage where appropriate in headers")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>   lib/eal/arm/include/rte_memcpy_32.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/arm/include/rte_memcpy_32.h b/lib/eal/arm/include/rte_memcpy_32.h
> index 99fd5757ca..861be06f5e 100644
> --- a/lib/eal/arm/include/rte_memcpy_32.h
> +++ b/lib/eal/arm/include/rte_memcpy_32.h
> @@ -19,10 +19,14 @@
>   /* ARM NEON Intrinsics are used to copy data */
>   #include <arm_neon.h>
>   
> +#endif /* RTE_ARCH_ARM_NEON_MEMCPY */
> +
>   #ifdef __cplusplus
>   extern "C" {
>   #endif
>   
> +#ifdef RTE_ARCH_ARM_NEON_MEMCPY
> +
>   static inline void
>   rte_mov16(uint8_t *dst, const uint8_t *src)
>   {
> @@ -252,7 +256,7 @@ rte_memcpy_func(void *dst, const void *src, size_t n)
>   	return ret;
>   }
>   
> -#else
> +#else /* ! RTE_ARCH_ARM_NEON_MEMCPY */
>   
>   static inline void
>   rte_mov16(uint8_t *dst, const uint8_t *src)

