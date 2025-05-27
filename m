Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B5C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 22:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6519B40684;
	Wed, 28 May 2025 00:36:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DBE0540287
 for <dev@dpdk.org>; Wed, 28 May 2025 00:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748385394; x=1779921394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YSZcsObWt3ITkI8jZQ72KIrLRdrE9Dtxkjz+wKWjuL4=;
 b=DIAk6IB7HZnc2yzecuhRlIfQ/ToCUIVpn7m+w+k2QYmqnvLbCdFmnl3P
 IQk8ci5u2/bsWwn1Fc3pbu8sCVZMfc5ll2g2uOGaa2Z4B7cot2d08pZ2g
 e0kh3A9bAjpzPicM4tofNlCCgaWv4Wah12i0mbCPdQ9g+fuH9aS2/Pl3w
 qDAVCQHMeZdygOmYsOm3sKLLjT8z/91xe6t15rY8xS/CsnmjhSRbR+Q44
 ykqyRFQgZfoayNNXtynBGauiK27DzRaa8ulHn3LWN/nObBIAXJwqMknHM
 vu2NrCaZCcHNMnrjivsIbfDZCl6XmE9PWlNYvZw2Rj0DRd4j+4UlCGY4c Q==;
X-CSE-ConnectionGUID: UJ94rs1PTXW8TbsaP0vX/Q==
X-CSE-MsgGUID: g06ehE2JS3iS9Aj1XmrUyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50322742"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50322742"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 15:36:32 -0700
X-CSE-ConnectionGUID: fPyzrioASs2KyzxENISb2Q==
X-CSE-MsgGUID: deqa7/dtQhyJxYvL+j+xyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143973155"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by fmviesa009.fm.intel.com with ESMTP; 27 May 2025 15:36:32 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 2/2] baseband/acc: add trace points per operation
Date: Tue, 27 May 2025 15:36:42 -0700
Message-Id: <20250527223642.31577-3-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527223642.31577-1-nicolas.chautru@intel.com>
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
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

Add the details of the operation parameters into
trace when that operation is rejected by the PMD.

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 drivers/baseband/acc/acc_common.h | 1 +
 drivers/baseband/acc/vrb_trace.h  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/acc_common.h
index 4880444450..3d411cd25f 100644
--- a/drivers/baseband/acc/acc_common.h
+++ b/drivers/baseband/acc/acc_common.h
@@ -700,6 +700,7 @@ acc_error_log(struct acc_queue *q, void *op, uint8_t acc_error_idx, const char *
 
 	rte_bbdev_vrb_trace_error(0, rte_bbdev_op_type_str(q->op_type),
 			acc_error_string[acc_error_idx]);
+	rte_bbdev_ops_trace(op, q->op_type);
 
 	va_end(args);
 }
diff --git a/drivers/baseband/acc/vrb_trace.h b/drivers/baseband/acc/vrb_trace.h
index 0bbfdc47d1..c9ae239fec 100644
--- a/drivers/baseband/acc/vrb_trace.h
+++ b/drivers/baseband/acc/vrb_trace.h
@@ -11,7 +11,7 @@ extern "C" {
 
 #include <rte_trace_point.h>
 
-RTE_TRACE_POINT_FP(
+RTE_TRACE_POINT(
 	rte_bbdev_vrb_trace_error,
 	RTE_TRACE_POINT_ARGS(uint8_t dev_id, const char *op_string, const char *err_string),
 	rte_trace_point_emit_u8(dev_id);
@@ -19,7 +19,7 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_string(err_string);
 )
 
-RTE_TRACE_POINT_FP(
+RTE_TRACE_POINT(
 	rte_bbdev_vrb_trace_queue_error,
 	RTE_TRACE_POINT_ARGS(uint8_t qg_id, uint8_t aq_id, const char *str),
 	rte_trace_point_emit_u8(qg_id);
-- 
2.34.1

