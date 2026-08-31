Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A6C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80FD14025A;
	Mon, 31 Aug 2026 12:23:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3F2F8400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:23:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V85d4G334296; Mon, 31 Aug 2026 03:23:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=m7LcsiR3R/QsWjv0O0FsikA
 LMZs5aJQ10dfhrMHdEJc=; b=lMKzcuuJju/TndWQar5MTx4jh6wWmot5nC7dKju
 R6iWf3b+3TYD9y1ien5l67sn95RK3WnmolxZvK0mQCoYe8c1mOOhi/8RpFO+A9lz
 t1SHN0Yj/Un0kuQaUpWJSY5Znzk+2+hZnjYpMApKAKfc2cOV1+MbaxYw7XX+ly6o
 VAQsqHcrwcGDvNgto5R8sgxZq3NJnaWVW2mX5/UIAXA+0BKkBtsjtDCWhxGPKN0Q
 67cNQsG/QRStJ3GLVaiMTYERnTD/a4Zy7DVaZNCJj6B7Wk6zYriItVWNp78rNOmw
 FAnc4HEzHGnvyM08E9Yh9joXL+3qrnMBZUEFtr/FbBd+kow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68j900-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:23:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:23:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:23:42 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 7EA533F7062;
 Mon, 31 Aug 2026 03:23:39 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 00/10] cryptodev: add RSA-OAEP and RSA-PSS padding support
Date: Mon, 31 Aug 2026 10:23:18 +0000
Message-ID: <20260831102328.2813604-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BLpSmwdc6xLrexIz0lkQZ4NIbagrnfqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX7DiDUGQ0hmqV
 yWpCS/RY9DF03c63Aa5m3t8HsPrnV/l9XEwaw9QfiYckfFctMq2aFCP9p/+b+yBwJjlRGHOOReI
 Ec5VLkPpoOO/uD1caFkOnB72WDylbIcA3mCiCr4+pRR61e6araKHLznp2mouNT6f6UEBXmkf1Zx
 19yFcPv+FBDJwtIMG6hsYR+wnERcI09tNqyc7WuVBApMEHfW0n624IVEC9GLBtjMi7im8gi84GY
 JrJeU0wx/TY+xEaiH6k4ntYIDFMS3IWBoHzBTELMVp8k2zKbruvQbiQj6D25NJt7UjZdvhGabgF
 lwFraXxh3Ydz/koFTD7Q8q6yYfL9B2ZB3cfyDLNp9ONmBo/ScRtMfalO05fp1X3GwJ0Z5Y4nCmK
 TPECf4k1sR+Z8HA7823d1DziRl6fpUpUsnPK458ine6YKKnl1VgANuPj4873arGtaK6NK2STYq0
 5s7Jcc4Fq5BaSMHTRQw==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a95562f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=t8gS2tw4dzSAODIcAfMA:9
X-Proofpoint-GUID: BLpSmwdc6xLrexIz0lkQZ4NIbagrnfqf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX2wxOOA47F3IR
 dUBpI9BhU2XG6STuS0WIAWu7DqUK4cOeWROPcVlWiYSldVkS6NEMwAC4ET4jVKziB/SlvKryPkV
 sBGr3hcaox2/6kQ23e/oG70Thf8l3aU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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
the virtio, octeontx, cnxk, qat, and openssl PMDs to use it.

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

Sucharitha Sarananaga (10):
  crypto: add RSA-specific capability parameters
  crypto/virtio: advertise RSA padding and hash capabilities
  crypto/octeontx: advertise RSA PKCS#1 v1.5 padding support
  crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
  crypto/qat: advertise RSA padding capabilities
  crypto/openssl: advertise RSA padding and hash capabilities
  crypto/openssl: add RSA-OAEP support for OpenSSL PMD
  app/test: add RSA OAEP asymmetric test cases
  crypto/openssl: add RSA-PSS support for RSA operations
  app/test: add RSA-PSS sign and verify test cases

 app/test/test_cryptodev_asym.c                | 663 ++++++++++++++++++
 app/test/test_cryptodev_rsa_test_vectors.h    | 317 +++++++++
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   8 +-
 .../octeontx/otx_cryptodev_capabilities.c     |   8 +-
 drivers/crypto/openssl/openssl_pmd_private.h  |  11 +
 drivers/crypto/openssl/rte_openssl_pmd.c      | 367 ++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  | 147 +++-
 drivers/crypto/qat/asym/qat_asym.h            |  20 +
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c    |   5 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |   5 +-
 .../virtio/virtio_crypto_capabilities.h       |  19 +-
 lib/cryptodev/rte_crypto_asym.h               |  18 +
 lib/cryptodev/rte_cryptodev.h                 |  50 +-
 13 files changed, 1567 insertions(+), 71 deletions(-)

-- 
2.54.0

