Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85DCC98328
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC996402B3;
	Mon, 28 Sep 2026 07:04:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C6C48402AC
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:04:39 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RGGF8T3293495; Sun, 27 Sep 2026 22:04:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 MyieqCLQfyLPQolaWJYWkvbzx3EwGGfX5jT1O0C1BI=; b=curNMpoVq/peW6Su+
 /Jlhu88wRy2JnQExJifry2qHQXFvN6aOldWIrXiKzcgm16XkeDHyshd5Re26ili2
 kbQc2eINbY2/mwC9e04e6zoPSw6kkMWerLU2Wpf5+/wWUjyMISXh3u89FACtMaQo
 GZPP+0LXnqamb2hnrHQgqbmOe0rsWz6CfPm9rhwbOumBVlFyPszx3wkorYxu92yG
 ZMkY5udeR6VitKsRiz6HykNHEkU3PK2p4sjPwh0dB9801YxO0t6tQk8kIWqm/Ajr
 Nk3yBifGONHlZCxJtku2/LR/PdZJEs3D7uQSI9neuzAj7kZzO0cH2jaCV1n0MQLS
 zouMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gxbdm5f5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 22:04:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 22:04:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 22:04:37 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id E34503F70BD;
 Sun, 27 Sep 2026 22:04:33 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding support
Date: Mon, 28 Sep 2026 05:04:04 +0000
Message-ID: <20260928050412.276760-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX+GTM2JBqMFGu
 rgvHs4elhHWg/vaFR7fp3G9gQqwEGyrfat0eZS8kZ2yD9Sibgzi1xHXyBBnOzbrOzrHLE8a/Zgm
 sBdCFFBOgygIOCslL6LkINKg/MmThGOxbCaqLAkyI8k4pQBXy6xPtGOe1n6mmDeW5CAmu5ZLNey
 VvXSEOs+O3LQrGYeoqltmzgeIk483FeophIFsGUMucUBvkRlBAp0uFHb2FNb/h+M1aJGi+zCJUy
 VIQFgUEmlOqMf3we5ZmmKJccxuaPnlk8VKZcZhig8oinNRJAjTtgEcP0Tcz2VCI4P454wadASBA
 RmWD2Ou8SBqGdwK7kylKUnfKepeAYHiJb4LFdK77Ib3Sqe/tw+lYjHcUcgp2Lce2ka/pJeeHMrK
 vP/oco6dopnnWizs33me0rOSoxWW4tQk0SJQIaSDtYNWOgtalGB4YurX0pn6MPW/4bJ2Q5EMpK8
 6v/OiVP7ZXmeAGKlJcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX0PVpZYiS+VVf
 LDfRfTzzyACJtJyOTtM0gtnp3flm8N9vo3eOYcQ+BZnBn4SVEhHz7YfPeoP+SxqyzHhlF6nKUDx
 t2dVW1R54sxzgvKnAwPQphlxu2/d0do=
X-Authority-Analysis: v=2.4 cv=Lc6peTfi c=1 sm=1 tr=0 ts=6ab9f566 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=eX-xP4TuJXF41AV6ppcA:9
X-Proofpoint-GUID: 3Fj3tJB4-ZcknTRLwXf272pJpdjwc-O9
X-Proofpoint-ORIG-GUID: 3Fj3tJB4-ZcknTRLwXf272pJpdjwc-O9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
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
 - Minor OpenSSL PMD cleanups: hoisted the mgf1 variable declaration
   and used memcpy() instead of rte_memcpy() for the OAEP label.
 - Reworded a few patch subjects for consistency (app/test ->
   test/crypto; shortened the OAEP/PSS OpenSSL commit titles).

v4:
 - Fixed a build error in the test suite by making rsa_pss_digest_sha256
   a const struct.

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

