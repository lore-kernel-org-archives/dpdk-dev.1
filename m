Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A43CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A1ED40296;
	Tue, 19 May 2026 11:26:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C65254021E;
 Tue, 19 May 2026 11:26:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FF52008;
 Tue, 19 May 2026 02:26:08 -0700 (PDT)
Received: from [10.1.28.83] (unknown [10.1.28.83])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8373F632;
 Tue, 19 May 2026 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1779182774; bh=cjX3oDfAWj/Ju2kLddWzQ/mxRUSIx5EAh/pgc2nt2GU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OKoKHhqCqw60CCVCH/iLaxsbPuoU8Otk29vPN4Rod01mcfxps1tgSEJmdfUIa9Bx4
 tfsqCSd71W71atJrG89CnGXluiEWJKc1EoxYsYJjSyDvS0LPXLTRgFNOOgbxZ5QMJl
 e5IkhidDJH6M6XdzN+h/MH3ZlDlBTH3ie17Tw6S8=
Message-ID: <1c15a80a-0ea1-403c-a2cf-91fc7601eb06@foss.arm.com>
Date: Tue, 19 May 2026 10:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal: silence -Wconstant-logical-operand in
 RTE_IS_POWER_OF_2
Content-Language: en-GB
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Gavin Hu <gahu@nvidia.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
References: <20260518163401.580696-1-stephen@networkplumber.org>
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
In-Reply-To: <20260518163401.580696-1-stephen@networkplumber.org>
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

On 18/05/2026 17:33, Stephen Hemminger wrote:
> Newer GCC warns when a non-boolean constant is an operand of &&, which
> trips whenever RTE_IS_POWER_OF_2 is used in a static_assert with a
> power-of-two literal. Make the zero check explicit.
> 
> Fixes: 7c872b96983a ("hash: validate hash bucket entries while compiling")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/eal/include/rte_bitops.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
> index aa6ac73abb..d2719ecd5e 100644
> --- a/lib/eal/include/rte_bitops.h
> +++ b/lib/eal/include/rte_bitops.h
> @@ -1299,7 +1299,7 @@ rte_fls_u64(uint64_t x)
>   /**
>    * Macro to return 1 if n is a power of 2, 0 otherwise
>    */
> -#define RTE_IS_POWER_OF_2(n) ((n) && !(((n) - 1) & (n)))
> +#define RTE_IS_POWER_OF_2(n) ((n) != 0 && !(((n) - 1) & (n)))
>   
>   /**
>    * Returns true if n is a power of 2

Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
