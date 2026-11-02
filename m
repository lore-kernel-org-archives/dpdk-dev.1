Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8B606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=foss.arm.com header.i=@foss.arm.com header.a=rsa-sha256 header.s=main header.b=BLKeLNu5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF7D040264;
	Mon,  2 Nov 2026 12:39:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DFC4A4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 12:39:45 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A28E1FC4
 for <dev@dpdk.org>; Mon,  2 Nov 2026 03:39:41 -0800 (PST)
Received: from [10.2.197.105] (KDFJ2LQKPJ.cambridge.arm.com [10.2.197.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727C93F632
 for <dev@dpdk.org>; Mon,  2 Nov 2026 03:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1793619584; bh=ESvi975oLHuBimxVqEtTfvGrOQcIxmc8U31pLp1l5YI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=BLKeLNu5fSff7vToI1LuUTQKrWvcVf1s3/P5k3+wZms2eSc6z1LyT1YvFH7JUglsB
 edjhDP5D9fdhR+3rg9G4ZTt4tUigk6UR6bBv57cMNg1LUaZP14H8VFTldb5Ef3xBi0
 yaQ8bILUS5bhFX9znAqgrVD2fWAMDVEcSqYrh2DM=
Message-ID: <1baa873b-0d94-46db-9fb3-d5272c05d14d@foss.arm.com>
Date: Mon, 2 Nov 2026 11:39:42 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/armv8: validate xform auth key length
To: dev@dpdk.org
References: <20261013133559.65758-1-jack.bond-preston@foss.arm.com>
Content-Language: en-GB
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
In-Reply-To: <20261013133559.65758-1-jack.bond-preston@foss.arm.com>
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

Recheck-request: iol-unit-arm64-testing

On 13/10/2026 14:35, Jack Bond-Preston wrote:
> Validate that the provided rte_crypto_auth_xform's key length is not
> too large, and that the provided data pointer is not NULL.
> 
> Previously, providing a key which has a size > SHA_BLOCK_MAX will cause
> the key memcpy to write out of bounds. Since the rte_crypto_auth_xform
> documentation states that it is the user's responsibility to validate
> the authentication key length, this is not a bug in DPDK. However,
> other PMDs are validating this, and it is more user-friendly to do so -
> with negligible performance impact.
> 
> Reported-by: pengpeng <pengpeng@iscas.ac.cn>
> Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> ---
>   drivers/crypto/armv8/rte_armv8_pmd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
> index a7caac186d..f4ddfb6395 100644
> --- a/drivers/crypto/armv8/rte_armv8_pmd.c
> +++ b/drivers/crypto/armv8/rte_armv8_pmd.c
> @@ -262,6 +262,13 @@ auth_set_prerequisites(struct armv8_crypto_session *sess,
>   	uint8_t partial[64] = { 0 };
>   	int error;
>   
> +	/* Validate key */
> +	if (xform->auth.key.data == NULL ||
> +			xform->auth.key.length > SHA_BLOCK_MAX) {
> +		ARMV8_CRYPTO_LOG_ERR("Invalid authentication key provided.");
> +		return -1;
> +	}
> +
>   	switch (xform->auth.algo) {
>   	case RTE_CRYPTO_AUTH_SHA1_HMAC:
>   		/*

