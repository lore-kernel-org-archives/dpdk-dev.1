Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724C606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Uy0yxJOO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED2C4060F;
	Tue,  3 Nov 2026 19:28:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A27C2400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:28:35 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B4A1595
 for <dev@dpdk.org>; Tue,  3 Nov 2026 10:28:31 -0800 (PST)
Received: from [10.118.144.157] (u104515.arm.com [10.118.144.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7CB3F628
 for <dev@dpdk.org>; Tue,  3 Nov 2026 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793730514; bh=qCDQIi/UOWosrvgtmdTZGMWgmOB6qu9AR1pxyNQM6yE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Uy0yxJOOv3wPOBPcPXCQucuWMBA9O3PnvS8oxGb0MN2yzHtQkjC19GTtfrHN36EiM
 bC9eYF0tZ3BlLopvsc3zXEkgPFM+Abq5AzZfc2QERWC3REId6VAdjhBCxg6y7fqBDY
 M3BLcY1QfbvBsLmsMst+6Ip22He0vKSLLJLXZDg0=
Message-ID: <040e3f91-ceff-48d9-bd28-5f94cc2b45d7@arm.com>
Date: Tue, 3 Nov 2026 12:28:34 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] test/crypto: add asym test suite for AESNI_MB
To: dev@dpdk.org
References: <20261015141426.2275568-1-radu.nicolau@intel.com>
 <20261015141426.2275568-5-radu.nicolau@intel.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20261015141426.2275568-5-radu.nicolau@intel.com>
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


> Enable asymmetric crypto unit test suite for AESNI_MB PMD.
>
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Acked-by: Kai Ji <kai.ji@intel.com>

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

> ---
>   app/test/test_cryptodev_asym.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
> index 7b8afe5f92..78b4942426 100644
> --- a/app/test/test_cryptodev_asym.c
> +++ b/app/test/test_cryptodev_asym.c
> @@ -5518,6 +5518,12 @@ test_cryptodev_virtio_user_asym(void)
>   	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
>   }
>   
> +static int
> +test_cryptodev_aesni_mb_asym(void)
> +{
> +	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_AESNI_MB_PMD));
> +}
> +
>   REGISTER_DRIVER_TEST(cryptodev_openssl_asym_autotest, test_cryptodev_openssl_asym);
>   REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
>   REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
> @@ -5526,3 +5532,4 @@ REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
>   REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
>   REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
>   REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
> +REGISTER_DRIVER_TEST(cryptodev_aesni_mb_asym_autotest, test_cryptodev_aesni_mb_asym);
