Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC08CE98FD0
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 06:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A90EC402D3;
	Thu,  9 Apr 2026 08:40:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 179B0402D1;
 Thu,  9 Apr 2026 08:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775716828; x=1807252828;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EyDa9ORmWV/YWNJdirdoGtcJaOWwPdRccWdqz8AFCm0=;
 b=Xt/Xegx0U5C4h+6RoQJL9tliVF5fcucYS/PGG1ousiYx7SfpQhJqjhS+
 TOhv82sYrlAY6YFDo8LMaTagjXd87o8sFsSKyZ5x6yCtA9k75nVdBUjks
 TYiF/tBhK74HkD4mnwXdANlrv0mXK8VlhQkm8U3BcpTBPGBAgpFrTQUNy
 xlSnMUp21My8EUSvu+L3XCEwGs+VWQLYBYoZDLa1+wOclLQwbBKV4aQe/
 2ijunpyvVlD/ccuO4obk/uiu4Tn43I6INqBySMb2t1wPAkvbsVWjrjb+o
 tbjEqAiGrnsQFVID22e9RWLVo3Msv/0bvbZV8BQCziGULSPK8jQtBqJ9G g==;
X-CSE-ConnectionGUID: rZIdZXQeRJOXaG77dgtniw==
X-CSE-MsgGUID: e6+MeKgqRN26Jt3TqXrv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80574083"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="80574083"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 23:40:26 -0700
X-CSE-ConnectionGUID: uLPGuHsnQf6APP+3BBzteA==
X-CSE-MsgGUID: vdGE5vX5ThOSyZOCfLm3uA==
X-ExtLoop1: 1
Received: from icx009.iind.intel.com ([10.190.212.240])
 by fmviesa003.fm.intel.com with ESMTP; 08 Apr 2026 23:40:24 -0700
From: KAVYA AV <kavyax.a.v@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
	KAVYA AV <kavyax.a.v@intel.com>,
	stable@dpdk.org
Subject: [PATCH v4] app/testpmd: fix DCB queue allocation for VMDq devices
Date: Thu,  9 Apr 2026 06:43:46 +0000
Message-ID: <20260409064346.3513111-1-kavyax.a.v@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313101553.1827216-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
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

When using DCB mode with VT disabled and requesting more queues than
traffic classes (e.g., rxq=64 with 8 TCs), testpmd crashes with null
pointer errors because it artificially limits queue allocation to
num_tcs.

For VMDq devices, use actual VMDq queue layout (vmdq_queue_num) instead
of limiting to num_tcs. This allows VMDq devices to utilize their full
queue capacity while maintaining compatibility with non-VMDq devices.

Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
Cc: stable@dpdk.org

Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
---

v4:
* Replaced configured queue count with PF-based layout.
* Revised commit message.

v3:
* Replaced configured queue count with actual VMDQ queue layout.
* Changed comment accordingly.
* Revised commit message.

v2: Moved the comment inside the else block.
---
 app/test-pmd/testpmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..23a27322f8 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4481,8 +4481,11 @@ init_port_dcb_config(portid_t pid,
 				nb_rxq = rte_port->dev_info.max_rx_queues;
 				nb_txq = rte_port->dev_info.max_tx_queues;
 			} else {
-				nb_rxq = (queueid_t)num_tcs;
-				nb_txq = (queueid_t)num_tcs;
+				/* Use PF queue count for DCB-only mode with VMDQ devices */
+				nb_rxq = rte_port->dev_info.max_rx_queues -
+					 rte_port->dev_info.vmdq_queue_num;
+				nb_txq = rte_port->dev_info.max_tx_queues -
+					 rte_port->dev_info.vmdq_queue_num;
 			}
 		}
 	}
-- 
2.43.0

