Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0959C44500
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27A9A402C5;
	Fri,  3 Jul 2026 16:31:23 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2CB104026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:31:22 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ca11143dbbso4812425ad.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783089081;
 x=1783693881; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AouU/2F3c4HYf6LzJY3DmE3qdqw7p2hhIgacx05DaQ=;
 b=Z/PP3OvEslh6R18YYliIdLxcxEpwoI+GvdiZg6YhsqLaT2OXgwaXhEwzjem60OEPqN
 +Qq7hlej6aLmvi8PtYO0GFXFyDRt/B6EFkXtIegrwCElCSn8Wz4A8QV2otJC8gTS/yVl
 vtEEX55TSuk4Uhdx4LTp8Xm3ixQIhMpQ8cpL2zwdVHJu7ne1M6igV6VRvbfhhhOsVGxp
 KU8q1axABj90X4xrURFJt9GQJ/ct06O0T7UtvB/1RG6cthzvBEc0CoJPKLSg++Ezcvl4
 LbIGmGtb1XUI6h427qCay97cdTU4bXpOQNqeS4IkDwS52gSdqSetTLEcYTsu7dSW8UZP
 VKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783089081; x=1783693881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AouU/2F3c4HYf6LzJY3DmE3qdqw7p2hhIgacx05DaQ=;
 b=Y82rVFiQc2w219Db1cb+Pj3QC5M2xrlYKfHZ3EQi/zevRr/LRb3NLMsi2ZUr1/uf6N
 +c2ZpkoT5HIYoK7gLGPaDr0hu37Iubw1L/3cN9kWWl2mJkE5Atx/PUlZL7LxHI6q8l6x
 J7Y0/NiC3k1n7Jtd7FpBfhF9vs1KSpOyqzYcWUbFJZr64MEbCbmmEDXWY/qaFvv/s5cj
 wpA49QGbofiCzLLPReSP8wY0EGp+qdeJJoiEo2D5Ut7aBxU+ByXeuYq/etr3DUXoaFIX
 pJbFFbgzR1QylaNSuXtpzhxnO/aJM988M4tBJBN6gHGF9qnhRY6YWTUrWqv9jSh9fNZg
 htew==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWfF1DtsaZWuvB7lcCvjzgtoiUh9XGo9NIt74tqERAO8j9i78mTDDXauDw28xYDMyET7s=@dpdk.org
X-Gm-Message-State: AOJu0YxoMTihlciU39ztHuL2UnT2yVOaxJFIS41CY8kCf1/m9UvAvfix
 6eoF5Il4dXf+eZnn5p06VFK6B0PMSDFhlwgvIKCsmHDUB6291/vpXmPXB+UqfOV7l08=
X-Gm-Gg: AfdE7clY/+GoIbdasidBsLCruEfco3uNj4UvlpX1j8ZSp1HbzRvGzcPlk0lVfS/cAwE
 tAkpQRHjKC6tUmVDO7sCySNP4ZXrtDTyCd3ZQzNYvJwxKGSbMZLA4ObxXhqa5Mz5yFsoqKh4+Au
 8Jv7tYgt2LwzjUDPC3uWE4sE0fGkajPicGpQ4tnRUXQj4jzuVSnIRAC4paqo8C7cmDc1PebSGlD
 gs5wYk9gziAvPlW0Xx/rMd3/TKGgm6u3VcSYiSE10k+uugKLGF3EdA2fZhhIyi/g1R3OJx3x/Yh
 45aCTBvYPhXhqr/tzNNkI46PLWPW1HTgUu9eFfOLCw1yWvtwWz19Z9aZSdbOKZr9ZIk0T1nCDgQ
 sg2xMfaQS5Rmoftf9Ied7uC1CeV7niDx63lYfYNKaeYd4w9rX6JEY8eKCCYfItgZLtjYubAdsvL
 FSZrURi5rUcr9r2Urf50ekQ8ax4HihBQqFib6Ii+UCyqetFFKmzm7E5A==
X-Received: by 2002:a17:902:f54d:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2ca7e90957cmr117086855ad.36.1783089081179; 
 Fri, 03 Jul 2026 07:31:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85bde6sm34392275c88.9.2026.07.03.07.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:31:20 -0700 (PDT)
Date: Fri, 3 Jul 2026 07:31:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: add 4x folding loop for aarch64 NEON
 implementation
Message-ID: <20260703073118.788f4324@phoenix.local>
In-Reply-To: <20260616091158.731075-1-16567adigashreesh@gmail.com>
References: <20260616091158.731075-1-16567adigashreesh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 16 Jun 2026 14:41:58 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Add a 64-byte loop that maintains 4 fold registers and processes
> 64 bytes at a time. The 4x fold registers is then reduced to 16 byte
> single fold, similar to x86 SSE implementation. This technique is
> described in the paper by Intel:
> "Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Instruction"
> 
> This results in roughly 2x performance improvement due to better ILP
> for large input sizes like 1024 observed on Cortex-X925.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Detailed AI review (not the CI one), spotted a correctness issue.

On the 4x folding loop patch:

The 4x-fold port matches the x86 SSE implementation and the constant
tables are correct, but the patch introduces one correctness bug.

Error: lib/net/net_crc_neon.c, "17 to 31 bytes" path uses the wrong
fold constant.

This patch repurposes rk1_rk2 as the fold-by-4 (512-bit) constant and
moves the fold-by-1 (128-bit) constant into the new rk3_rk4, matching
the SSE layout. The main paths were updated to select rk3_rk4 before
falling into partial_bytes, and the partial_bytes comment was correctly
updated to "k = rk3 & rk4".

The 17-to-31 byte branch was missed. It still does:

	/* 17 to 31 bytes */
	fold = vld1q_u64((const uint64_t *)data);
	fold = veorq_u64(fold, temp);
	n = 16;
	k = params->rk1_rk2;      /* now the fold-by-4 constant */
	goto partial_bytes;

partial_bytes performs a single 128-bit fold and needs the fold-by-1
constant, but this path now feeds it rk1_rk2, which after the change
holds the 512-bit constant. CRC results are therefore wrong for every
input of length 17-31 bytes. This affects both crc32_eth and
crc16_ccitt, since they share this routine.

The fix is one line -- use rk3_rk4 here as the other paths do:

	k = params->rk3_rk4;

Verification: I cross-compiled the routine (armv8-a+crypto) and ran it
under qemu against a scalar reflected CRC-32 reference for lengths
1-256. As submitted it mismatches at exactly lengths 17-31 (15
lengths); with the one-line change above, all lengths pass. The >=64,
>=32, ==16, and <16 paths are already correct.

One suggestion for v2, not required: the SSE version does not carry a
separate 17-31 branch at all -- it handles everything below 64 through
the single_fold_loop plus partial_bytes with rk3_rk4. Collapsing the
NEON path the same way would remove this class of bug rather than just
this instance.
