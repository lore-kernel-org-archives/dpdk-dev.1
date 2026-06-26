Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71553C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 17:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F2D24026D;
	Fri, 26 Jun 2026 19:11:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D481F40264;
 Fri, 26 Jun 2026 19:11:04 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7EB1F60;
 Fri, 26 Jun 2026 10:10:59 -0700 (PDT)
Received: from [10.2.197.97] (KDFJ2LQKPJ.cambridge.arm.com [10.2.197.97])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EA923F632;
 Fri, 26 Jun 2026 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1782493864; bh=ZfxBypO+ymXQJUnolGKWbCQxh34iGMqbVZ0Zx9MgzzM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BHmWiC0Rzz+SQHPSYboRGPSfi9Jks1lNwKafCyrPpp4k0I/6CU1IieQAm9abh2hkf
 MfXJGAo+zuSNVvy10lGrgpqIacG3zJfSazuRxuBIy2PvNxRQ950AzFhEUHXQ8HWTia
 GGBojmcNeRxQ29lxe/lmvfsjFmLu8bBb9tyuTt8I=
Message-ID: <51dbe284-70ae-4439-bd4d-314b4f4e095f@foss.arm.com>
Date: Fri, 26 Jun 2026 18:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] crypto/armv8: use timing-safe digest comparison
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Siraj Luthfi Ananda <sirajluthfi@gmail.com>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260625160200.24170-5-stephen@networkplumber.org>
Content-Language: en-GB
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
In-Reply-To: <20260625160200.24170-5-stephen@networkplumber.org>
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

Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>

On 25/06/2026 16:56, Stephen Hemminger wrote:
> The chained-op verify path compared the computed and expected MAC
> with memcmp(), whose run time depends on the number of matching
> leading bytes and can leak the digest to an attacker submitting
> forged values.
> 
> Use rte_memeq_timingsafe() for the verify comparison.
> 
> Bugzilla ID: 1773
> Fixes: 169ca3db550c ("crypto/armv8: add PMD optimized for ARMv8 processors")
> Cc: stable@dpdk.org
> 
> Reported-by: Siraj Luthfi Ananda <sirajluthfi@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/crypto/armv8/rte_armv8_pmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
> index 320e2d4b3b..a7caac186d 100644
> --- a/drivers/crypto/armv8/rte_armv8_pmd.c
> +++ b/drivers/crypto/armv8/rte_armv8_pmd.c
> @@ -631,8 +631,8 @@ process_armv8_chained_op(struct armv8_crypto_qp *qp, struct rte_crypto_op *op,
>   
>   	op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
>   	if (sess->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY) {
> -		if (memcmp(adst, op->sym->auth.digest.data,
> -				sess->auth.digest_length) != 0) {
> +		if (!rte_memeq_timingsafe(adst, op->sym->auth.digest.data,
> +					  sess->auth.digest_length)) {
>   			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
>   		}
>   	}

