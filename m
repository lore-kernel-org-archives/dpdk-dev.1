Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CDDC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98E1402D8;
	Thu,  3 Sep 2026 10:27:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BAD1E4028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:27:08 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835mWAC157564; Thu, 3 Sep 2026 01:27:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 dgNhbxGT65EARmvwqfIx9tfmp67xAH1VjfE1sz8YXA=; b=hrXMs2J6xeqKGXWWd
 UpMSCdm2IiM1rXi3vYHJEseTlaGacv9h6q4TqzcWPvJkOHR9ybVx00XsAkaZZJiF
 WcbzKfh8Qvcui/hnAIOfNzRRrc+DaNf6SOWIgHpobgkHAXbBh/ywKi/MCiw1XNY9
 5zSmn5TR63n8gWLDCV4uiN/8LMIVUL6UMnJdikFnVf45oTUUwfPFE7OsA6qweJnX
 Ee2kaIRaVtP8PK99EzIbBvIsrOltd3xk4V5Z2jo+hpkrpBdKR8/xWAvrfEyHB17t
 MGEGyZMRDUa/9GWiRQOZbX6Q0XKKbjzX8Fn4G1shCT+iJTVBkoxknopVEdoktB//
 d2hKA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gegb63rpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:27:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 01:27:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 01:27:06 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 89D903F7068;
 Thu,  3 Sep 2026 01:27:03 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v2 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding support
Date: Thu, 3 Sep 2026 08:26:40 +0000
Message-ID: <20260903082648.3610676-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX0zgs0fvsHts5
 iZ0s1RZoDmg+39OuSRc4g81JFCiu9VKA+QzIGwKmk4YvnIjgsvMNiy3kP3xVizbQW4ht5jz6bbb
 6ylsfP2OLxo7SocHtqx6EEL7JeKzJkeOEchzEqCdOSyvEM2gTsXdHwbv+VqgbtBuj2bHwZEwFTU
 r/D0HoKPzrTdhbX4eQMs5mqiCYPbgC7clmNZ3+6RdnTKjb+Y0NZygY0Ai9USktmbCGeNCzfkV7e
 zH+V63PBqLJrzsoH6HzqA04Eq8N2hs6/JTyqYmS4+LytW3auOxnjFh7TKve/JiU1ttDcC04jcxN
 5s4FKv13ywG60Cc9sb4jd+S/S1oZ7swVJSxBI9Tntx+5DfktvFIAmYm9aDYHE2T9hgt4PYuq1lc
 0djgi540CLVHU9vcF3DOz4LkTJ/ziLaYMjCfHX2/8rIYnLRKXTiFMUqWB0/Y0i4APXW12deaGl2
 jAIGs2Z8SoIhyskFxuw==
X-Proofpoint-GUID: yGQcD8jHdW1cXBlwuUv2Y61aJkE1Riug
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX/8AGyteJVtex
 mLeIg7JpXdkQ0z9R2v1FuDLKMJhi1BcobX+MHelNwC5nkOHDdMAGpmFOy2xCu5tusZLLRDXWZFw
 bGlB+gt/4M60IIv4NdZKwynNN0OuhZE=
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a992f5b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=eX-xP4TuJXF41AV6ppcA:9
X-Proofpoint-ORIG-GUID: yGQcD8jHdW1cXBlwuUv2Y61aJkE1Riug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
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

Sucharitha Sarananaga (8):
  crypto: add RSA-specific capability parameters
  crypto/octeontx: advertise RSA PKCS#1 v1.5 padding support
  crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
  crypto/openssl: advertise RSA padding and hash capabilities
  crypto/openssl: add RSA-OAEP support for OpenSSL PMD
  app/test: add RSA OAEP asymmetric test cases
  crypto/openssl: add RSA-PSS support for RSA operations
  app/test: add RSA-PSS sign and verify test cases

 app/test/test_cryptodev_asym.c                | 663 ++++++++++++++++++
 app/test/test_cryptodev_rsa_test_vectors.h    | 317 +++++++++
 doc/guides/rel_notes/release_26_11.rst        |  16 +
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   8 +-
 .../octeontx/otx_cryptodev_capabilities.c     |   8 +-
 drivers/crypto/openssl/openssl_pmd_private.h  |  11 +
 drivers/crypto/openssl/rte_openssl_pmd.c      | 367 ++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  | 141 +++-
 lib/cryptodev/rte_crypto_asym.h               |  18 +
 lib/cryptodev/rte_cryptodev.h                 |  50 +-
 10 files changed, 1537 insertions(+), 62 deletions(-)

-- 
2.54.0

