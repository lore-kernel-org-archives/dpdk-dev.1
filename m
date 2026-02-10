Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D4AEA813A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A2E40A76;
	Tue, 10 Feb 2026 16:52:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4DCD840A6C
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738741; x=1802274741;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z7diHGNt++cT5woFQfm8GFwgCBla9nt3aHQi0eDDeOc=;
 b=SKb/u/YMkYPgruoUZfFoI8QouyTsTkzgbkJ09kxYEMq81EkmtMBOki/l
 QfRIlLxRet9k+UTwBnVfWfYRuR/eQO++7uan+rf4Ejch11TZ7As0CrNiz
 kEeB9cMKWldYzYxhb9bzVI7c98+ThEYO7gElvYq7aN33JFPPmZGKTBcpq
 rwqX96AiFvPZYhXT7OIBiHeI6DlKX6ISOuKqdJ8uK4ejbaf+/E1IbnKTO
 JM3YBLS/i/E6Rm24d3FM+Lam9bPkHb5H7ISk+GHzkT9M4fICj5GQbTvcS
 MWIWvwakHXjYHtVcjzsODd1kXeQzQORTwCmHoiK+lNmib13xZdjiVWLfY A==;
X-CSE-ConnectionGUID: rIjHpfsyRfWGonFty96pQw==
X-CSE-MsgGUID: dnIUUFMERjmh/bxtP2TGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080900"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:21 -0800
X-CSE-ConnectionGUID: SCHgaLk+RzCvVFW9g5PTUw==
X-CSE-MsgGUID: 9K8z1gL0QveX3aq+XsxlWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285387"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>
Subject: [PATCH v2 6/7] net/iavf: fix IPv4 flow subscription
Date: Tue, 10 Feb 2026 15:52:08 +0000
Message-ID: <b61460111a2f4695c0567898a7fb73a9a2f3209f.1770738711.git.anatoly.burakov@intel.com>
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

Currently, when IPv4 is parsed as part of flow subscription input set, we
add two bytes to the total number of bytes in the input set for IPv4 source
or destination addresses, whereas they should be 4 bytes. Fix to add the
correct number of bytes.

Fixes: 6d42380e5983 ("net/iavf: add flow subscrption supported pattern")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 18df9c6500..cf1030320f 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -314,11 +314,11 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 
 				if (ipv4_mask->hdr.src_addr) {
 					*input |= IAVF_INSET_IPV4_SRC;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.dst_addr) {
 					*input |= IAVF_INSET_IPV4_DST;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.time_to_live) {
 					*input |= IAVF_INSET_IPV4_TTL;
-- 
2.47.3

