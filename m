Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3BFCA188
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2795740676;
	Mon,  9 Mar 2026 22:19:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 526ED4066E
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091180; x=1804627180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c5mWnp50xKXpW8GkBbACN2R+eOQWBN5UvHkhKf+KJ3g=;
 b=M/pHRr09YhkwN4BE8yu/72d9KmMLAX4JYdOHtn6PkWFnrU6w+QWG+P/a
 K4mzlMpncgevE+02M00/5o2E0MZKN1W4c9MowV2wJBSlbbeel0I2Vfdbx
 2enketBxX0PBNn/xFk0E2rdl+N8HhGFnD2qM3aSjaijgzZNILPqdnlZHq
 kGLGk+p7hKwPl99YIjXTuPJty/uuG8W3m8yT+WAfDbWMlUcWGZk4kXfz+
 NJTmNQ1WUQ/rnQAUsPSheqpURKQ99yJqVGFp504DTYO1OXE4qSQx4XUdS
 HBq6SU8bBCGpODf7vu5Vo5QhPrWQ1U7tUWyOjrRBgQhoMKh5w8nR5cTlm A==;
X-CSE-ConnectionGUID: TQWt3ujxRz2d7IHfGGtJFQ==
X-CSE-MsgGUID: T8YdKh1qRbKfXzAgmUaGsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74241073"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74241073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:19:39 -0700
X-CSE-ConnectionGUID: muSs465ZRMGHTT/2x4j0xw==
X-CSE-MsgGUID: iDgSw6+ZTcyGlxpi8FU37g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219016178"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:19:37 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Pawel Sobczyk <pawel.sobczyk@intel.com>
Subject: [PATCH v1 5/6] net/ice/base: add pending admin queue events API
Date: Tue, 10 Mar 2026 05:52:17 -0400
Message-ID: <20260310095218.703423-15-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Pawel Sobczyk <pawel.sobczyk@intel.com>

Adds a new API ice_ctrlq_pending() to check if there
are pending messages in the admin control queue. The
function is intended to be called after clearing the
ADMINQ_EVENT_PENDING flag to ensure all pending
messages are processed before re-enabling interrupts.

Signed-off-by: Pawel Sobczyk <pawel.sobczyk@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/base/ice_common.h   |  1 +
 drivers/net/intel/ice/base/ice_controlq.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
index 884b8f7834..3e9d3c2f80 100644
--- a/drivers/net/intel/ice/base/ice_common.h
+++ b/drivers/net/intel/ice/base/ice_common.h
@@ -148,6 +148,7 @@ ice_aq_ena_dis_txtimeq(struct ice_hw *hw, u16 txtimeq, u16 q_count, bool q_ena,
 extern const struct ice_ctx_ele ice_txtime_ctx_info[];
 
 bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
+bool ice_ctrlq_pending(struct ice_hw *hw, struct ice_ctl_q_info *cq);
 int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
 void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
 extern const struct ice_ctx_ele ice_tlan_ctx_info[];
diff --git a/drivers/net/intel/ice/base/ice_controlq.c b/drivers/net/intel/ice/base/ice_controlq.c
index b210495827..d68e603a8c 100644
--- a/drivers/net/intel/ice/base/ice_controlq.c
+++ b/drivers/net/intel/ice/base/ice_controlq.c
@@ -965,6 +965,22 @@ static bool ice_sq_done(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 	return rd32(hw, cq->sq.head) == cq->sq.next_to_use;
 }
 
+/**
+ * ice_ctrlq_pending - check if there are pending messages on the control queue
+ * @hw: pointer to the HW struct
+ * @cq: pointer to the specific Control queue
+ *
+ * Returns: true if there are pending messages in a queue (i.e. next_to_clean
+ *          does not match the hardware head register), false otherwise
+ */
+bool ice_ctrlq_pending(struct ice_hw *hw, struct ice_ctl_q_info *cq)
+{
+	u16 ntu;
+
+	ntu = (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
+	return cq->rq.next_to_clean != ntu;
+}
+
 /**
  * ice_sq_send_cmd_nolock - send command to a control queue
  * @hw: pointer to the HW struct
-- 
2.47.1

