Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CC606A327
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=foss.arm.com header.i=@foss.arm.com header.a=rsa-sha256 header.s=main header.b=zK+UWDCo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9C82402A4;
	Fri, 13 Nov 2026 17:33:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 44C404028E;
 Fri, 13 Nov 2026 17:33:09 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF9E143D;
 Fri, 13 Nov 2026 08:33:05 -0800 (PST)
Received: from [10.2.197.111] (KDFJ2LQKPJ.cambridge.arm.com [10.2.197.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C65C3F673;
 Fri, 13 Nov 2026 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1794587588; bh=FaQ9UWRHVNzDSwEjpvQHf6ipIfeO5QdMMjuuBah/QQc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zK+UWDCoCK/jG90tf0b8IftdiPi6Jh3AM5s1maPNj9ChQXOAkaIBuDmpOQAqpYM64
 TjorI1u+HoWGQwLBXZdNPT7KTpKb4eFFmM//SO0BHv7QbFXbthCZfwBs2INCmTMow7
 aNtnMu2AzombQXa+Ozj7zstRnu+MnxS1VxIS3tMM=
Message-ID: <86c5a06e-fa7b-4f8b-bad2-70b5427281cf@foss.arm.com>
Date: Fri, 13 Nov 2026 16:32:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bitops: fix integer overflow in align64pow2
To: Bulatov Mark <ms.bulatov7@gmail.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Alexey Simakov <bigalex934@gmail.com>
References: <20261113141307.4727-1-ms.bulatov7@gmail.com>
Content-Language: en-GB
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
In-Reply-To: <20261113141307.4727-1-ms.bulatov7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 14:13, Bulatov Mark wrote:
> If the function rte_combine64ms1b() returns the maximum possible uint64_t
> value, it will result in an overflow.
> 
> To avoid this, add a check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7253e3d2a5 ("bitops: move bit count functions")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---
>   lib/eal/include/rte_bitops.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
> index 45255b68aa..d2ed0c3c61 100644
> --- a/lib/eal/include/rte_bitops.h
> +++ b/lib/eal/include/rte_bitops.h
> @@ -1307,6 +1307,9 @@ rte_align64pow2(uint64_t v)
>   	v--;
>   	v = rte_combine64ms1b(v);
>   
> +	if (v == UINT64_MAX)
> +		v--;
> +
>   	return v + 1;
>   }
>   

Reviewed-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>

