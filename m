Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD8D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 798B04067B;
	Mon,  1 Dec 2025 12:45:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0BB1B4066B;
 Mon,  1 Dec 2025 12:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589514; x=1796125514;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oNag9pMdNuyeC4i8hoNVngDA+1Hf5dEQtTbpPm3P7oQ=;
 b=HqzJoMY23oHcgkEDzvg1mwbcij6XN8BN3V4DOnCLPXW4wqB4pEKdwq8r
 ikH69EXROiqL2H7dpYOtzG+UzuK3sR321JUdDYALwEF1lwsCbMpmm6VKZ
 m2Xk5zPg01kXouLBQw9mX3i9ZI4UmGwvsbaxEou2HTCX4rTmPWwVEEoGW
 bqU0SAdmXa/w7ekWI59Y1rt91ha0mtp9O3gKHUwr/Drq/8oT/dhULg2Vm
 kbePNx7yY7DESrCwftnJXs/z0FMJ2I7iuVVUsXNaBAcaV2sazKlLJ9vx4
 mGg5bQf6r4+oh4N7Z21AvKeRw+Zoa46+IkkC2vAFtqaFWi//cXpxSUpGx g==;
X-CSE-ConnectionGUID: andygmNyTDSRkori9WFKhw==
X-CSE-MsgGUID: rBkMbFEySqCyvLtIv7haEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991723"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991723"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:14 -0800
X-CSE-ConnectionGUID: +B7gZ4g1Tru+9+dywm+d5A==
X-CSE-MsgGUID: O7SCvl+DSMqM60LC7VHH7Q==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 10/31] bbdev: fix variable shadowing
Date: Mon,  1 Dec 2025 11:44:27 +0000
Message-ID: <20251201114448.1441377-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

