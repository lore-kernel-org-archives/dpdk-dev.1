Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB02CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC1340E1D;
	Mon,  5 Oct 2026 18:38:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 522E940DDB
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218325; x=1822754325;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gH4qTK1b5PvC+cadBK7JKpCw5uPJOCtsUY5mznG+Ko4=;
 b=KzMBOi4gFdbu9xEesqrp/UOicNCByXg9zbdIYkAfDcQSSDp6qla86oSo
 IpwoNdzqLLNUmbFmz1WY/9Rh9dk7kFJzjfXySJM8Tzt/uE+mlc8HlHmtI
 BOPeBCPfbAXzBmFp5v4ufjtj5tTpjasHlqQ1yhNJQOdI80TauBdMeFleL
 /RUQXkFRr32qWiT08U7MEExmcO/tpZwlvNqJ5zz5vFpQ2zuOfWJyXmvvv
 3Z8eFd+MY9FqTymyY9fFm4hb0jVO2RXDOOnURDWpV0imq0GmTUC0yN3xx
 AhrKZ92OWeAX2+uleYQiOqDIG4Do4j5W4bzrwbp5c3kqtGiAogGFZ1MIU w==;
X-CSE-ConnectionGUID: Ojjka0WNTiaHdjrenaNzXQ==
X-CSE-MsgGUID: gckuD7dMSaG7wpsyZNeqpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665296"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665296"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:45 -0700
X-CSE-ConnectionGUID: qGp3d9HSSlqK+lXVj9PhFg==
X-CSE-MsgGUID: Kyw5k686TnG5zVV3jTUHPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945719"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Zhao <wei.zhao1@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Wei Dai <wei.dai@picocom.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v4 08/24] net/ixgbe: fix syn filter priority
Date: Mon,  5 Oct 2026 17:38:03 +0100
Message-ID: <88b6b21417eacb60bc5db2cd83478b3dac6734a7.1791218155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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

In rte_flow API, 0 means highest priority. Fix SYN filter priority being
wrongly set to lower priority when API requests priority 0.

Fixes: 429f6ebb42cc ("net/ixgbe: parse TCP SYN filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index acd5f8cdb11..f41f5501d88 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -804,10 +804,10 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_it
 	filter->queue = q_act->index;
 
 	/* Support 2 priorities, the lowest or highest. */
-	if (!attr->priority) {
-		filter->hig_pri = 0;
-	} else if (attr->priority == (uint32_t)~0U) {
+	if (attr->priority == 0) {
 		filter->hig_pri = 1;
+	} else if (attr->priority == (uint32_t)~0U) {
+		filter->hig_pri = 0;
 	} else {
 		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
 		rte_flow_error_set(error, EINVAL,
-- 
2.52.0

