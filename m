Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21AC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98B624029B;
	Fri, 10 Jul 2026 14:59:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9D52A400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783688386; x=1815224386;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=i7aDgBRh6cL/g6ffrr4odjRt34gqXT0OL0hA9EMQark=;
 b=mBvVWL0Rfym+qR3XK/GNcOgWuWu35xDMQpFoIFwn6k53BBf1A/4FZKiV
 rBJHr3DcouE/mGQK2LfAsIwu0MRqqnhr2khwIuX3cY3YjtQhauNrNp2Kj
 k2MO7cdl3E4GDb3JlqmPVKK4aUG9D5weFO4KhXon/vN7J2nlCXzVF5vTx
 KBzreDeC0Rqq3ML7ayEZygwDneXVN6XJ3dJrpijH7ik28hI4LMlhl1ZQy
 wuEk0moqq5yYlJ0h4alWbUVTau/QKj9MORFKNm5eYtu8B8mkD+zbwuiG7
 1MGCOMSC+HcUHXJtpOtfgkhH9DM1Ye613Ra9WcNqIuR9a1Wx9gluI1MDQ A==;
X-CSE-ConnectionGUID: 4G5DwgPeRf2XaQ3n/y9eew==
X-CSE-MsgGUID: 2RRJvMxfSkGWuZKBGfsVWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83503894"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83503894"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 05:59:45 -0700
X-CSE-ConnectionGUID: pivAttTbQ4eRaefV2LJR6w==
X-CSE-MsgGUID: mjDt9bZ9TNOAc4qk+UaCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="250466491"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 10 Jul 2026 05:59:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/iavf: check for NULL pointer before dereference
Date: Fri, 10 Jul 2026 13:59:40 +0100
Message-ID: <20260710125940.1572978-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Static analysis with Coverity flags a possible NULL pointer dereference
of "hdr1" when handling IPv4 or IPv6 fragements in
iavf_fdir_parse_pattern.  This is likely a false positive, since the
flow pattern protocol sequences are checked before this function is
called, so all paths leading to a hdr1 dereference start with an
ethernet protocol, which sets hdr1 to a non-NULL value.

However, this is a rather brittle situation, so to prevent any future
issues if a new set of allowed protocols is added with IP but no
Ethernet matching patterns, add explicit NULL checks for hdr1 before
it's used each time.

Coverity Id: 503768

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 8940132dff..ea620863ca 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -806,6 +806,14 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				 * ethertype, if the spec and mask is valid,
 				 * set ethertype into input set.
 				 */
+				/* ETH should be present via pattern pre-validation. */
+				if (hdr1 == NULL) {
+					rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Missing ETH header before IPv4 fragment.");
+					return -rte_errno;
+				}
 				input_set |= IAVF_INSET_ETHERTYPE;
 				VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr1, ETH,
 								 ETHERTYPE);
@@ -911,6 +919,14 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				 * ethertype, if the spec and mask is valid,
 				 * set ethertype into input set.
 				 */
+				/* ETH should be present via pattern pre-validation. */
+				if (hdr1 == NULL) {
+					rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Missing ETH header before IPv6 fragment.");
+					return -rte_errno;
+				}
 				input_set |= IAVF_INSET_ETHERTYPE;
 				VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr1, ETH,
 								 ETHERTYPE);
-- 
2.53.0

