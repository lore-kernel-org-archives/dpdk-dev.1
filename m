Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF96C36010
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 02:08:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBDC2402DB;
	Wed,  9 Apr 2025 04:08:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 81545402D7;
 Wed,  9 Apr 2025 04:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744164502; x=1775700502;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+u8DYHl2wNe46eLs4hdrGpmNTlqjpzUNgaaJeNLfArI=;
 b=m6tenwrFdLd3RCBVLKkNxFKmSog1zGR60cQgjoGcksNq+XZFcUnPzG35
 wfJPgl78LjTdmQGSzLJsIebwbx1oSJQDUCWZBzeaGHZHaTFeczWdKERnX
 5XgJEG/fS/Kc9/7pr61C9ziLXteUaYGw8SKVwgyzyPJSyuarekupQZYpx
 P3gT00omqFmUI0Gh0gbAObAT7aFzipIHkvk7iff/j+EyTqPyK0a3r86aE
 uUuIUIkSASs/NjZ9UdDGnxsYguDMQe7wHt46nZf0a8N0v4MNlwckODTS5
 p8SlHO7C+P2IgW+33NfGoX84bMXxBkBDwHy1Q0v4Z3dQD6aNgIRlj+/g4 Q==;
X-CSE-ConnectionGUID: u1BrtdFAQWq2zDmPZ01kUA==
X-CSE-MsgGUID: c76tVj3uQcOCO4lnDt7XZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45509546"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="45509546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:08:20 -0700
X-CSE-ConnectionGUID: UPcd1NySSLKgnyzjMZD0/g==
X-CSE-MsgGUID: dgPZ2q5CQvSoq6fG6GH3yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="128177821"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:08:19 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>, Alvin Zhang <alvinx.zhang@intel.com>
Subject: [PATCH] net/igc: fix xstats name
Date: Wed,  9 Apr 2025 09:07:11 +0800
Message-Id: <20250409010711.761050-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
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

The xstats name needs to be changed correctly
tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.

Fixes: e6defdfddc3b ("net/igc: enable statistics")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/e1000/igc_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index e712cfcf7c..68444e4fba 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -181,7 +181,7 @@ static const struct rte_igc_xstats_name_off rte_igc_stats_strings[] = {
 	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
 	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
+	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
 	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
 	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
-- 
2.34.1

