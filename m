Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C6E109C033
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:27:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E7A5402CE;
	Wed, 25 Mar 2026 17:27:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3550F4028E;
 Wed, 25 Mar 2026 17:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774456034; x=1805992034;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zv7PY20CZFIwsR4Yv46nbjkQF81/RwIM+dhKbG/P8fI=;
 b=laVQ1Y1QGf/PP0Zypjwfo1L8+rXmhhXKZXxaKMKoilIp2VlNiIONCZql
 yKcW4lEJ3evVrf8Nq0vpEks75vlVZWSDSpypldgvtF13HnRKLqrybQkTR
 Wo8yxkt1PFk7zuH/wsHlUC9Dpq7VMc9sjyLR/C46zCGH0VWfiHn5fnpxC
 coOpHsuy8VIIhckpcCImGP+J8kO136CbtsK5cHdWjzvzQnwYBhLmLURQ4
 8dXOB35jH+Zv3j2QXRgaj5goIbaq9mXjRLYLS4EdMecNbPVoed25EtH4s
 KJf8a9GiSSoBKJM85ZCTx5ooI9hFV8bAyj5OO/WXBCoOS2nsteQTOKu7Z Q==;
X-CSE-ConnectionGUID: u2EfHJWlRcmNK0s2Pqpr6Q==
X-CSE-MsgGUID: YASmUOQnT4KeouO9j4Kn+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86193162"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86193162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 09:27:12 -0700
X-CSE-ConnectionGUID: BropEJUBQFGgcYCT8LGjpw==
X-CSE-MsgGUID: 3+qATSL4RVC1g4w4FJZO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="226367719"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by fmviesa004.fm.intel.com with ESMTP; 25 Mar 2026 09:27:11 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	Kai Ji <kai.ji@intel.com>,
	stable@dpdk.org
Subject: [dpdk-dev v1] crypto/openssl: fix SM2 pubkey buffer overflow in
 session setup
Date: Wed, 25 Mar 2026 16:27:08 +0000
Message-ID: <20260325162708.2931082-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

The SM2 session setup path in openssl_set_asym_session_parameters()
copies the caller-supplied public key coordinates into a fixed 65-byte
stack buffer (1 byte uncompressed-point prefix + 32 bytes X + 32 bytes
Y) without first validating that the coordinate lengths fit.

Since xform->ec.q.x.length and xform->ec.q.y.length are generic size_t
values from the caller and are not bounds-checked before this point in
the driver, an oversized coordinate pair would overflow the pubkey[]
stack buffer before any OpenSSL API is reached.

Add a guard that rejects the xform when
1 + x.length + y.length > sizeof(pubkey), failing the session create
with the existing err_sm2 error path.

Fixes: b2fc11b6f8f1 ("crypto/openssl: support SM2 algorithm")
Cc: stable@dpdk.org

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 6133622f1b..4e5fb07bb2 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -1773,6 +1773,12 @@ static int openssl_set_asym_session_parameters(
 			goto err_sm2;
 		}
 
+		if (xform->ec.q.x.length >= sizeof(pubkey) ||
+				xform->ec.q.y.length >=
+				sizeof(pubkey) - xform->ec.q.x.length) {
+			OPENSSL_LOG(ERR, "SM2 public key coordinates too large");
+			goto err_sm2;
+		}
 		memset(pubkey, 0, sizeof(pubkey));
 		pubkey[0] = 0x04;
 		len += 1;
-- 
2.43.0

