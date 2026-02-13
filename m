Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C6EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B084065F;
	Fri, 13 Feb 2026 10:10:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8166D40653
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973828; x=1802509828;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S6efqaiTIaZStJDxF4TVn4zHsgff2xrZUEXlsLC02lE=;
 b=aXZemEY0bMkY9UUA+kjPFJtoQnueKCZQx9MqGVTcTki/uzS4rAY4b5ff
 JopV5Pir6o+YRC7/8847SuIcrV9w5R02/lvP7Enol3EVnnZRw0ddbQCXF
 JAwhF3xsYbWf9YBuCg3lcsuPuBKHtHr2JRZUd7YTYbFpuVxTFx/h7EnMj
 LhxiBqlrmtEw3eG1vWHZ3H0yjqn0zVLIZ8F81rV3zr5JitKnsFbb6C4Pn
 mvxzzAuw+q7qOeaS627eYp4odtIWmXbznR5vCIqe2mad3m5mm8zmHt/fh
 WA3tkqt0ANaCOcamqy5co/K4EFhbRzr6qfFP9U3sZYJ51XHR7cZAsP5Bu A==;
X-CSE-ConnectionGUID: TKBngLuiRNWGHlIC8XPyRQ==
X-CSE-MsgGUID: +3NBil9uR9Km2VlJM7rsjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567864"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:27 -0800
X-CSE-ConnectionGUID: bqMhEEfySEG1CVhGgsBwjQ==
X-CSE-MsgGUID: /o/JdTgfQcq3QOMJhQsWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966063"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v6 04/12] net/ixgbe: fix potential null dereference in IPsec
Date: Fri, 13 Feb 2026 09:10:06 +0000
Message-ID: <eb0c3eeae61cffa4a7dfbc3094cf32cd2e63fd1c.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

Currently, IPsec flow parser will look for IPv4 flow item in the pattern,
and then pass it to IPsec SA flow function. However, we do not check if the
spec pointer is actually valid. Fix by adding the check.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 81b983ce69..90a24806d2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -251,6 +251,12 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 			}
 			item = next_no_void_pattern(pattern, item);
 		}
+		if (item->spec == NULL) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
+					"NULL IP pattern.");
+			return -rte_errno;
+		}
 
 		filter->proto = IPPROTO_ESP;
 		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
-- 
2.47.3

