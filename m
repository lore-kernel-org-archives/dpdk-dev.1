Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9703C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0629340B9B;
	Fri, 25 Sep 2026 10:15:20 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3918840695
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:19 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4a1tO2365003; Fri, 25 Sep 2026 01:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 Op/8keVyNxQsdp59HnX8y4HNTLSUka8x7HJHMJw32A=; b=efnpRtqLxQ1EqM8td
 nLxeqYWKehClGsDmI0z6dGo6266CJdD4UrVCW7LHOckUBXdzlXTI+G2n1XZQtFtk
 8UPqDZklapZq+HawtU8J2h2iR1DAvWzGqCawQj1wo9HhbZHSxGIOXKgwOi8C5BT+
 xRTPhJBMafzWo6fm2sW58aCStd+UvYleKBhMQb8y47sEqDLh4smPpioGAYtZiVt6
 mtEF8Qe7VbxJgPQfeIRM2xkvdRkTCHQYs2UF5Hk9HJAzNv8wusMveZ1g3w5UZA0L
 xZehWRFE/rJO1RxnXIRBbIcKCEZIjAKlPJQU6No0vl2yTM5Bbw8gBntE1y+A0pO9
 vLdTA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gw76gc6sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:16 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 7C71F5B6954;
 Fri, 25 Sep 2026 01:15:13 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding support
Date: Fri, 25 Sep 2026 08:14:52 +0000
Message-ID: <20260925081500.3848187-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903082648.3610676-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX3VWdWTpEGh7i
 kbMOuDhIls1krBt10+Xv61oSc3f32ImFT4C5eAGlsRb9RjCP09z8rNBd9Nh/QAtcMuOwVLKlrmh
 i6RAMYt/7dWF6ou3BFe1UCXw72eXV9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX8cBtViAgzUsO
 xtUtYKCDbEukxYcuN0C1Bvb0pu2DZuZX10Fu+WdMd5JlcbizHIFhouZTiX0DnCSiwxnUtgdRlq4
 qW81e3eoTVClLRjw/nFTWJvXDScwo6FkNhzXpughk+dIxWkcMcCnFVrNyzdTtlNAJrqyFYctA6h
 8ZcS4D6FXaCSj4dRlWQ8m6jzU/THZnaX0jATZ4xaGt6wTRq+BV54HzvuYi3Kd7uQCzmb5US+OY2
 JmGd57g+uOIDwOfB68OXAKpBrTkFzngNvRTtkHdyufEUYxjf4o/TgoBjeji+grNI9Q+XiXVSZ6v
 72zA+lAVuXF25j97zgccQZNTcDgbX/oAa/9gyM3j0GJAaoy2kSbvy5lTWdBy6PMZ7ptya9Lokak
 znm6UT9V/sYiYlWIujX1mgV987Td4gxkrQHow+/aOSEbHtwkJoSULdZD+DrMKMHRv33Nw5hAOMP
 Ke053mNYT06H7eJQA/w==
X-Proofpoint-GUID: kZvpqXXHgqJbbwC-wYhAeEH0yq2g4WYJ
X-Proofpoint-ORIG-GUID: kZvpqXXHgqJbbwC-wYhAeEH0yq2g4WYJ
X-Authority-Analysis: v=2.4 cv=ZKhCCn7b c=1 sm=1 tr=0 ts=6ab62d96 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=eX-xP4TuJXF41AV6ppcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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

The asymmetric crypto capability structure currently reports only a
generic modulus length and primary hash algorithm for RSA, with no
way for a PMD to advertise which padding schemes (NONE, PKCS#1 v1.5,
OAEP, PSS) or MGF1 hash algorithms it supports. Applications have no
standard way to discover this, and the OpenSSL PMD itself only
implements NONE and PKCS#1 v1.5 padding.

This series first extends the capability API with a dedicated
rte_crypto_rsa_capa (modulus length, pad_types, mgf1_hash_algos, and
an explicit-PSS-salt flag), then updates the capability reporting in
the octeontx, cnxk, and openssl PMDs to use it.

On top of that, it adds actual RSA-OAEP and RSA-PSS support to the
OpenSSL PMD:
 - RSA-OAEP encrypt/decrypt, with configurable OAEP hash, MGF1 hash,
   and an optional label, defaulting MGF1 to the OAEP hash when
   unset.
 - RSA-PSS sign/verify, with configurable hash, MGF1 hash, and salt
   length (rte_crypto_rsa_padding::pss_saltlen), using a dedicated
   EVP_PKEY_verify()-based verification path since PSS does not
   support verify-recover. The PSS salt itself is always generated
   internally by the PMD; an application-supplied salt
   (rte_crypto_rsa_op_param::pss_salt, gated by the new
   pss_explicit_salt capability bit) is introduced by this series
   for future PMD support but is not yet implemented here, so it is
   rejected with RTE_CRYPTO_OP_STATUS_INVALID_ARGS.

Test coverage for both OAEP (encrypt/decrypt, default and custom
MGF1, with and without a label) and PSS (digest-length, maximum, and
zero-length salt) is added to the cryptodev asymmetric test suite.

v2:
 - Dropped the virtio and qat capability-advertisement patches from
   this series; they will be sent separately.
 - Documented the new rsa_capa/pss_salt fields in release_26_11.rst
   (this series' target release) instead of the already-released
   26.07 notes.

v3:
 - Renamed rsa_oaep_supported()/rsa_pss_supported() test helpers to
   is_rsa_oaep_supported()/is_rsa_pss_supported() and switched them
   to bool.
 - Marked the rsa_pss_digest_sha256 test vector as const.
 - Minor OpenSSL PMD cleanups: hoisted the mgf1 variable declaration
   and used memcpy() instead of rte_memcpy() for the OAEP label.
 - Reworded a few patch subjects for consistency (app/test ->
   test/crypto; shortened the OAEP/PSS OpenSSL commit titles).

Sucharitha Sarananaga (8):
  crypto: add RSA-specific capability parameters
  crypto/octeontx: advertise RSA PKCS#1 v1.5 padding support
  crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
  crypto/openssl: advertise RSA padding and hash capabilities
  crypto/openssl: support RSA-OAEP
  test/crypto: add RSA OAEP asymmetric test cases
  crypto/openssl: support RSA-PSS
  test/crypto: add RSA-PSS sign and verify test cases

 app/test/test_cryptodev_asym.c                | 663 ++++++++++++++++++
 app/test/test_cryptodev_rsa_test_vectors.h    | 317 +++++++++
 doc/guides/rel_notes/release_26_11.rst        |  16 +
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   8 +-
 .../octeontx/otx_cryptodev_capabilities.c     |   8 +-
 drivers/crypto/openssl/openssl_pmd_private.h  |  10 +
 drivers/crypto/openssl/rte_openssl_pmd.c      | 367 ++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  | 140 +++-
 lib/cryptodev/rte_crypto_asym.h               |  18 +
 lib/cryptodev/rte_cryptodev.h                 |  50 +-
 10 files changed, 1535 insertions(+), 62 deletions(-)

-- 
2.54.0

