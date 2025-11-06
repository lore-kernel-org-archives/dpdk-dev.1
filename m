Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D3CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D862440BA6;
	Thu,  6 Nov 2025 15:10:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 545F74069D;
 Thu,  6 Nov 2025 15:10:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438215; x=1793974215;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rl0CC8MrCUSSflLK51DbqiML4nvv06unMhqn5s1jI/U=;
 b=EAwvNGI1QVvYi4kWhtWP8fxx5aOM24WFkeLlzRozQwtSXz17IL3hh+Nj
 WFsWgRn/C0iW03zWdqVRcSPrUe/j5NUV/02f9xpo6Hd3N2c2FJHR4dXgb
 eBbN/shzadQMo4UMZ5uFDiWpw62HJnKLcguSH2UgZsG7MazO3VNN2ruhE
 rLr6QNCJLkKCjQ/Fm9UAZjfevrQETPRLyqjX1Dgl9/Rw8dD9km7NMS4iS
 qedPK+EGeT70OvlFkecczBzWnnuEUpFG7Os8zh0LmZkuKYtjFIiCpEOT+
 UA+oXVg+6eIUij0pyiXarpM2g8l49CyCrrbJ7TTo2wz23THTHOfzwJvXj Q==;
X-CSE-ConnectionGUID: qUjYhawwQvqOTzSyqUd3mA==
X-CSE-MsgGUID: dz4S9PCHT9GsBvTU8TKtGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185314"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:14 -0800
X-CSE-ConnectionGUID: g3AhYMq2TgiAeXz6NOMGMw==
X-CSE-MsgGUID: v3T0k5TWQCO+aw5/45UywQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054752"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 11/19] bbdev: fix variable shadowing
Date: Thu,  6 Nov 2025 14:09:40 +0000
Message-ID: <20251106140948.2894678-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

The "ret" variable is declared twice in rte_bbdev_setup_queues function.
The second declaration is unneeded so remove it.

Fixes: 4935e1e9f76e ("bbdev: introduce wireless base band device lib")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/bbdev/rte_bbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index 6c98296bdb..ea644c1f9b 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -357,7 +357,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	if (dev->data->queues != NULL) {
 		VALID_FUNC_OR_RET_ERR(dev->dev_ops->queue_release, dev_id);
 		for (i = 0; i < dev->data->num_queues; i++) {
-			int ret = dev->dev_ops->queue_release(dev, i);
+			ret = dev->dev_ops->queue_release(dev, i);
 			if (ret < 0) {
 				rte_bbdev_log(ERR,
 						"Device %u queue %u release failed",
-- 
2.48.1

