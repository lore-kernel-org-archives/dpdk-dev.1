Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F27CD8C92
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E14A402BE;
	Tue,  9 Jun 2026 14:00:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8FBE54025E;
 Tue,  9 Jun 2026 14:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781006431; x=1812542431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UEiflrSh/lnjVW1S7IxEPbLOq3++gXu6N9rlUZd7HIU=;
 b=b0BCEKoGqLeeR51n9oZIonlmDD5liIYK9RdmEJxZizCDOni3qoFAsJWz
 g3iqiKST80gicR/rm//2OzCqbfmXUpydjesOj8Ul0tvZWlbpSAcjyIynV
 pKDnGDzybFdRn8WpIOk2QJAX1WPF+OUmGeec52kxXG7Ub4hbAFUT6Y1WJ
 1nC4CoNvnehRMlXDlsayxajgQ3MgUB67zPw1f3V6IwKg09WsQ4YfcTHkm
 7B/sXF0/ZRoWMuN6NjWJVGxyNGMWLCiYXZl9kaAoWIet0+LwFnydLy1x5
 aA1SAL+b8e8kUnu8GuZPvuNmrkOy7nzBmcxFv/YRVmvTAsrQXN+bPm5N5 w==;
X-CSE-ConnectionGUID: jHe2JV6kSqCH11fJWPGSOw==
X-CSE-MsgGUID: EtTCAqPfSf+Bj9CdcBFWFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99339790"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="99339790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:00:30 -0700
X-CSE-ConnectionGUID: 2VyEZmjZTNO3AQlVJseMYA==
X-CSE-MsgGUID: 07hDDQ5sTfG3qGOVJDBSow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250126425"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa004.jf.intel.com with ESMTP; 09 Jun 2026 05:00:28 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/iavf: fix misleading AQ failure logging
Date: Tue,  9 Jun 2026 12:00:50 +0000
Message-Id: <20260609120050.360907-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608171559.355521-1-anurag.mandal@intel.com>
References: <20260608171559.355521-1-anurag.mandal@intel.com>
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

iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
until iavf_clean_arq_element() reports that no descriptors are
pending. When the queue becomes empty, the base driver returns
IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
terminator for the drain loop, and is not an error.

The current loop treats every non-IAVF_SUCCESS return as a failure
and logs it as follows:

"Failed to read msg from AdminQ, ret: -57"

This message floods the logs on every interrupt cycle and misleads
the triage during VF reset by chasing a real virtchnl problem
seeing these spurious -57 AQ failure lines in logs and assumes
the admin queue is broken, when in fact it has just been drained.

This patch fixes the aforesaid issue by treating
IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
loop exit empty-queue condition and avoid logging it as an misleading
AQ failure.

Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Addressed Ciara Loftus's comment
 -  kept 'break" for ret == IAVF_ERR_ADMIN_QUEUE_NO_WORK case

 drivers/net/intel/iavf/iavf_vchnl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..39ebddff31 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -571,8 +571,16 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 		ret = iavf_clean_arq_element(hw, &info, &pending);
 
 		if (ret != IAVF_SUCCESS) {
-			PMD_DRV_LOG(INFO, "Failed to read msg from AdminQ,"
-				    "ret: %d", ret);
+			/*
+			 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is empty
+			 * and is a normal way to terminate the drain loop.
+			 * Log error only for genuine other failure codes.
+			 * Incorrect logging like this during VF resets might
+			 * mislead into chasing a non-existent AQ failure.
+			 */
+			if (ret != IAVF_ERR_ADMIN_QUEUE_NO_WORK)
+				PMD_DRV_LOG(INFO, "Failed to read msg from AdminQ,"
+					    "ret: %d", ret);
 			break;
 		}
 		aq_opc = rte_le_to_cpu_16(info.desc.opcode);
-- 
2.34.1

