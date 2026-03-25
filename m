Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2D6109C033
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 15:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B77D402CE;
	Wed, 25 Mar 2026 16:50:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B94934028E;
 Wed, 25 Mar 2026 16:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774453846; x=1805989846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7b+Ig0jsrMSb6r5s0Gv/i+we4dzQ9MNduructHkzjVg=;
 b=fS4uK49FLbf9y/fd5xVdpXPkCNnhqQNVNaUst/ykYNQAwu6tgW49Z+wy
 SDOubPHB9ux3YXcljBjfr2QB82lpS7iCx0zPsS+jW21R4GNJtz9YNFH8A
 i7eA6QHyv3YjqX7hsEFe/hz+jEqHWDKKqL9CnTFbOEf4SzbMrNfiOtN4m
 OzULaiYAd/x9TfJwbqAQXFkrEq50gg6D/95je2wwE1ZkqdNMvpRVmu4JP
 TIQvuDOuhbPN/3RIaGcDWbeArQomSKqRSy79avzI7M+hduDMn4zE//2RR
 KPdZw3QmgJ216HLF/uEfcGm2eV4KdsAs7QUaYLZNH++IyRyG1DDhAQV6x Q==;
X-CSE-ConnectionGUID: aZKRqN1uRjaBg03G7P4rJg==
X-CSE-MsgGUID: SlLxOFLWRUe5sFjtsVGrew==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="98115741"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="98115741"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 08:50:45 -0700
X-CSE-ConnectionGUID: 1nghgeanT+6fZ3gvPiPTHQ==
X-CSE-MsgGUID: g4WKT1y7T4St65cBbnJGVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="224672904"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by orviesa009.jf.intel.com with ESMTP; 25 Mar 2026 08:50:43 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, chiluka@marvell.com, Kai Ji <kai.ji@intel.com>,
 stable@dpdk.org
Subject: [dpdk-dev v1] crypto/qat: fix EC session segfault on missing pkey/pub
 key
Date: Wed, 25 Mar 2026 15:50:40 +0000
Message-ID: <20260325155040.2922854-1-kai.ji@intel.com>
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

session_set_ec() checked qat_session->xform.ec.pkey.length for
the NULL-allocation guards, but that field is zero (from the
preceding memset) at that point, so the guards never fired.
When test_ecpm() created a session the xform had no pkey or
public-key fields set (ECPM only needs curve_id), so the
unchecked memcpy calls received a NULL destination and a
garbage-length source, causing a segfault.

Fix session_set_ec() to check xform->ec.*.length, the caller-
supplied value, before allocating and copying each optional
field (pkey, q.x, q.y), skipping the allocation entirely when
the length is zero.

Fix test_ecpm() to zero-initialise the xform with memset so
that uninitialised pkey/q fields are never passed to the driver.

Also add a QAT_LOG(ERR) in pick_curve() default case so that
unsupported curve IDs are surfaced immediately rather than
producing the misleading 'Unsupported xform type' message
from qat_asym_session_configure().

Fixes: 064ef1b098d1 (\"test/crypto: remove PMD-specific asym test suites\")

Cc: stable@dpdk.org

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 app/test/test_cryptodev_asym.c |  2 +-
 drivers/crypto/qat/qat_asym.c  | 58 ++++++++++++++++++----------------
 drivers/crypto/qat/qat_ec.h    |  1 +
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 07e5eb5842..bf1a1fc417 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -1816,7 +1816,7 @@ test_ecpm(enum curve curve_id)
 	asym_op = op->asym;
 
 	/* Setup asym xform */
-	xform.next = NULL;
+	memset(&xform, 0, sizeof(xform));
 	xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ECPM;
 	xform.ec.curve_id = input_params.curve;
 
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index 7a296cad6c..9276b86c0e 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -1492,36 +1492,38 @@ session_set_ec(struct qat_asym_session *qat_session,
 	uint8_t *q_x = xform->ec.q.x.data;
 	uint8_t *q_y = xform->ec.q.y.data;
 
-	qat_session->xform.ec.pkey.data =
-		rte_malloc(NULL, xform->ec.pkey.length, 0);
-	if (qat_session->xform.ec.pkey.length &&
-		qat_session->xform.ec.pkey.data == NULL)
-		return -ENOMEM;
-	qat_session->xform.ec.q.x.data = rte_malloc(NULL,
-		xform->ec.q.x.length, 0);
-	if (qat_session->xform.ec.q.x.length &&
-		qat_session->xform.ec.q.x.data == NULL) {
-		rte_free(qat_session->xform.ec.pkey.data);
-		return -ENOMEM;
+	if (xform->ec.pkey.length) {
+		qat_session->xform.ec.pkey.data =
+			rte_malloc(NULL, xform->ec.pkey.length, 0);
+		if (qat_session->xform.ec.pkey.data == NULL)
+			return -ENOMEM;
+		memcpy(qat_session->xform.ec.pkey.data, pkey,
+			xform->ec.pkey.length);
+		qat_session->xform.ec.pkey.length = xform->ec.pkey.length;
 	}
-	qat_session->xform.ec.q.y.data = rte_malloc(NULL,
-		xform->ec.q.y.length, 0);
-	if (qat_session->xform.ec.q.y.length &&
-		qat_session->xform.ec.q.y.data == NULL) {
-		rte_free(qat_session->xform.ec.pkey.data);
-		rte_free(qat_session->xform.ec.q.x.data);
-		return -ENOMEM;
+	if (xform->ec.q.x.length) {
+		qat_session->xform.ec.q.x.data = rte_malloc(NULL,
+			xform->ec.q.x.length, 0);
+		if (qat_session->xform.ec.q.x.data == NULL) {
+			rte_free(qat_session->xform.ec.pkey.data);
+			return -ENOMEM;
+		}
+		memcpy(qat_session->xform.ec.q.x.data, q_x,
+			xform->ec.q.x.length);
+		qat_session->xform.ec.q.x.length = xform->ec.q.x.length;
+	}
+	if (xform->ec.q.y.length) {
+		qat_session->xform.ec.q.y.data = rte_malloc(NULL,
+			xform->ec.q.y.length, 0);
+		if (qat_session->xform.ec.q.y.data == NULL) {
+			rte_free(qat_session->xform.ec.pkey.data);
+			rte_free(qat_session->xform.ec.q.x.data);
+			return -ENOMEM;
+		}
+		memcpy(qat_session->xform.ec.q.y.data, q_y,
+			xform->ec.q.y.length);
+		qat_session->xform.ec.q.y.length = xform->ec.q.y.length;
 	}
-
-	memcpy(qat_session->xform.ec.pkey.data, pkey,
-		xform->ec.pkey.length);
-	qat_session->xform.ec.pkey.length = xform->ec.pkey.length;
-	memcpy(qat_session->xform.ec.q.x.data, q_x,
-		xform->ec.q.x.length);
-	qat_session->xform.ec.q.x.length = xform->ec.q.x.length;
-	memcpy(qat_session->xform.ec.q.y.data, q_y,
-		xform->ec.q.y.length);
-	qat_session->xform.ec.q.y.length = xform->ec.q.y.length;
 	qat_session->xform.ec.curve_id = xform->ec.curve_id;
 
 	return 0;
diff --git a/drivers/crypto/qat/qat_ec.h b/drivers/crypto/qat/qat_ec.h
index 0e02722c18..653854abc4 100644
--- a/drivers/crypto/qat/qat_ec.h
+++ b/drivers/crypto/qat/qat_ec.h
@@ -274,6 +274,7 @@ pick_curve(const struct rte_crypto_asym_xform *xform)
 	case RTE_CRYPTO_EC_GROUP_SECP521R1:
 		return SECP521R1;
 	default:
+		QAT_LOG(ERR, "Unsupported curve id %d", xform->ec.curve_id);
 		return -1;
 	}
 }
-- 
2.43.0

