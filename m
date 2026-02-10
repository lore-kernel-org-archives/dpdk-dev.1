Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A558CEA8139
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88D9C40A6F;
	Tue, 10 Feb 2026 16:52:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EEBB940A6C
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738740; x=1802274740;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=g8+Y92jbPKrVPW+9DiqNFrdDFFq/EA8SNrP5i/FGp60=;
 b=B0jTpPGpXZMcRXmMdF7FxjfghJx7I0seGKVRxobIeBHB4z4h5IeB7Pxn
 bgBE9xG5BXlI5O3VuNYVOp+lwcvzkQeNOa396Ku/qkMEmqHtM57HmJTEr
 xa32ykrWfvnjoS1jmHQfyWqIxQ8AVLL8TK0Nkxo7lBz/y7ipKaKVGeEUu
 eZAoox6Cl4/ql2Sw+WqozPNK8xFbyWyzY8uR0dToTCNdCiCXMK7eVqQvj
 2Xmy8faex1wnbIWMZQqcWt0FbjMhxSG85DNSWcPlGOCN+RwIaDc1m9cJv
 wggjB2iMYHgahlR1JsrKZHaV0hTp9Mm4Sa9z/dFmDl9vVXJACNemuAuqT Q==;
X-CSE-ConnectionGUID: 3FtdmLZfT1OLqUYTVk177g==
X-CSE-MsgGUID: 2M/jnXoGTA2gMLm+leGAZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080897"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080897"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:19 -0800
X-CSE-ConnectionGUID: Re3/IKDqRpugFnJ308aB5Q==
X-CSE-MsgGUID: H0TSUD2cR9Kv3qyLZUP2Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285383"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 5/7] net/i40e: fix IPv6 GTPU handling
Date: Tue, 10 Feb 2026 15:52:07 +0000
Message-ID: <ea9d2aeced6551e2259b97f281f40adafdd60540.1770738711.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com>
References: 
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

GTP tunnel code declares support for IPv6 GTPU flows but does not actually
handle IPv6 flow pattern item, resulting in incorrect parsing for IPv6
GTPU flows. Add IPv6 flow item handling.

Fixes: 47ba0398da3f ("net/i40e: add cloud filter parsing function for GTP")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 193b1b6725..2374b9bbca 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -3580,6 +3580,19 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 				return -rte_errno;
 			}
 			break;
+		case RTE_FLOW_ITEM_TYPE_IPV6:
+			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
+			/* IPv6 is used to describe protocol,
+			 * spec and mask should be NULL.
+			 */
+			if (item->spec || item->mask) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Invalid IPv6 item");
+				return -rte_errno;
+			}
+			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			if (item->spec || item->mask) {
 				rte_flow_error_set(error, EINVAL,
-- 
2.47.3

