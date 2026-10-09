Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EDCA6015
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 04:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74FC64027A;
	Fri,  9 Oct 2026 06:05:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7578F4026D
 for <dev@dpdk.org>; Fri,  9 Oct 2026 06:05:20 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632D51692;
 Thu,  8 Oct 2026 21:05:16 -0700 (PDT)
Received: from [10.122.30.109] (unknown [10.122.30.109])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27813F66F;
 Thu,  8 Oct 2026 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791518719; bh=tAgUjjpYWsNsPkSFPHGxZtvoQLowPZCybGAODHOpCf0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W7913np2SPi3XxlA4kuNUgyZUDISDs++XrU8mx3Mhn+ULEcEXPbvQp7Wvj5+THmFB
 swGUOSJ7pBdGCQJAxy/nAGyIK8s2ECVlwsJtd4v5X01Ex/5HL1keen38OlOdzJavJl
 uSgz8cmGyDqRP0y/XXliMGc1jJlcp5eE/xWrt3Aw=
Message-ID: <c672f023-1b29-433b-8e11-ffba3debc830@arm.com>
Date: Thu, 8 Oct 2026 23:05:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/29] ring: replace SMP read barrier with C11 acquire
 fence
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-13-stephen@networkplumber.org>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20261008233649.1260843-13-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

On 10/8/26 18:35, Stephen Hemminger wrote:
> rte_smp_rmb() is deprecated. This code is only used where
> RTE_USE_C11_MEM_MODEL is unset: x86, ppc64, loongarch and ThunderX.
> The acquire fence generates the same code on x86 (a compiler
> barrier) and on ThunderX (dmb ishld). On ppc64 the barrier becomes
> lwsync instead of sync, which still orders load against load.
>
> The gcc implementation itself is kept: unlike the lock-free stack,
> the in-tree comment records a 10% x86 performance drop with the
> C11 version, which needs re-measuring with current compilers
> before RTE_USE_C11_MEM_MODEL can be removed.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>   lib/ring/rte_ring_gcc_pvt.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
> index 340ece28c7..9c2c58824d 100644
> --- a/lib/ring/rte_ring_gcc_pvt.h
> +++ b/lib/ring/rte_ring_gcc_pvt.h
> @@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
>   
>   	*old_head = d->head;
>   
> -	/* add rmb barrier to avoid load/load reorder in weak
> -	 * memory model. It is noop on x86
> +	/* Acquire fence to avoid load/load reorder in weak
> +	 * memory model. It is noop on x86.
>   	 */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>   
>   	/*
>   	 *  The subtraction is done between two unsigned 32bits value
