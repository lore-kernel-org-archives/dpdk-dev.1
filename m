Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076FCC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A6440A6D;
	Tue, 13 Oct 2026 14:03:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D2259406A2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893025; x=1823429025;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gUHa5yhZwBo/PHF58GB6obhE4kEszBmCj7m3CPPU/CI=;
 b=j9FnoyZ/yms/oSMxUfSbLX0LiMHIdyFVqJc0y0a+9j0Xevn4kplnAll5
 dn6mDaAQpOYypvcAbge1kSf4Cv4u7HTjGNsDnwhXpOqx6fsJONRReUTVM
 LQ6ZJqLAX+smlhCTVYDVufC9QYxPnV5BM5gDmiAFb/IgQjAJMiRkKnUxl
 e0VZfkoV/yFctNcdTGZzjrMM62/0AMYZ1TD2Ha+zf+EZ4TcOveiM3qN0J
 FHgzNAMcTI+IcMi852LLbkyKYZumzluon6J9DtGSATRnxlWRrpEYMJHiY
 hT40vKcqXdEDf2e/BTQqgzd+Emwis/hiueGxD+RmX0LDnjd8a28mLO341 A==;
X-CSE-ConnectionGUID: TcXBf9cZTe++PINbqsx9hQ==
X-CSE-MsgGUID: g1NCtzWZRKW+Ly14I0UHKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="608368"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="608368"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:03:45 -0700
X-CSE-ConnectionGUID: yveOjiaFRYOoH3RengRzuQ==
X-CSE-MsgGUID: uUmOQ1KFRAOi0vnGWhnQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2908585"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa013.fm.intel.com with ESMTP; 13 Oct 2026 05:03:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Wei Dai <wei.dai@picocom.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v7 08/25] net/ixgbe: fix syn filter priority
Date: Tue, 13 Oct 2026 13:03:06 +0100
Message-ID: <7d14664f77d8f07ca58994e07fdca852fb82a9cd.1791892576.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index a2b9403d3a1..6ba36a8b44a 100644
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

