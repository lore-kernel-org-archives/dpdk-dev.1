Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F891D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC78740E03;
	Tue,  9 Dec 2025 12:27:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 716A940BA0;
 Tue,  9 Dec 2025 12:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279638; x=1796815638;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=15/LmDeYUh8AMHyUGVWFwc508zUltREfGVFrdMRqxk8=;
 b=l/LL0YALWyAnKKXH2i9OSM+rKEztwETzYWSAal+FM81hxyfAuMvZ9fQV
 uNXZzPshM0GMnlR8mq7Vlqxin4TByAhhspFg5j9JqMTrcsyrGYeLJDpn9
 MXkItRvuAJKZIxpoMUXOpJRR/3KWkr0XyZaTQju30Pbr3E3NLnuvk10EA
 8DBMlUBgpTCYDAnbW4BnQ6Yxq68NXGLSG8fKcjDK17+lIFLzJfQYJAnnB
 GssjIjBaD78H/ccbmhMtlj+75Q6CYrFajowDGJzICkXBruSEMDSuQ89uj
 SP4Mu9cqKOTnSvAx+VSZbJx9rO2xe2b4X7IX3GTthFr0pTHoYVdGwqExZ g==;
X-CSE-ConnectionGUID: 0job5t52Rxq9QJ14dTSkCw==
X-CSE-MsgGUID: kX1dhXgKTQW69YFqdbAWhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117050"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:17 -0800
X-CSE-ConnectionGUID: +xYvIncURE6iHZMjyhgpCQ==
X-CSE-MsgGUID: NYjwnTO2SQq/nBV8voXRpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270240"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:16 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 11/13] docs: fix TSO feature status in iavf driver
 documentation
Date: Tue,  9 Dec 2025 11:26:50 +0000
Message-ID: <20251209112652.963981-12-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change the status to
partially supported.

Fixes: 319c421f3890 ("net/avf: enable SSE Rx Tx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 7695e3ff7c..6c9e97594f 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -17,7 +17,7 @@ Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

