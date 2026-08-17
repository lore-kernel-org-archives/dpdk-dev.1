Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA5C5DF74
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B214067B;
	Mon, 17 Aug 2026 15:44:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D25D74021F;
 Mon, 17 Aug 2026 15:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786974281; x=1818510281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U3dXOzMfzBq7DaHqV3UnQDhDUm1GAw8ZTZF+AaLmeZQ=;
 b=a5qJBvsGsl9OTa90T5Q40cqcfn1lH+cB014/g3DoTvDf0afZmylHIf7E
 GZO+pxfjbIxa39k5WLgyJyWTjUDeRhUxC1QETN0I0GcNm8rx7dIWZOTUN
 yb5yUAdmBnhc8+syhU8DCsl1x8L0MB7/iYTTCNCDOIf5Ojd/w/nB1bVRh
 gkENWAH/OKOeVU0M+gM2PnxZjjl/Lt7jpvxG04X/N/ntcFv6wjt0coTXq
 NihqFn+S9V4kcAanD6PWU1r5coAZVSAQOiGeCv46pcM+3wc65Lc831b9J
 qmK9DNH3ocmYCpb4CDiF8qt4YM7A9R9feZKm7Re1Yp+vRxNEa/xnzUesc Q==;
X-CSE-ConnectionGUID: GoFHm0brQDyvJJ+Jw9mnFA==
X-CSE-MsgGUID: /Sc4D9v9RAqbcnEjU9S5sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104831497"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="104831497"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:44:40 -0700
X-CSE-ConnectionGUID: es5U8JQLR3aTl1zdnG3WGw==
X-CSE-MsgGUID: gvJerQRbT9qf60Bt54rNXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="263165826"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 17 Aug 2026 06:44:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 2/3] eventdev: improve bounds checks for names in adapter
 create
Date: Mon, 17 Aug 2026 14:42:41 +0100
Message-ID: <20260817134432.1206297-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817134432.1206297-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
 <20260817134432.1206297-1-bruce.richardson@intel.com>
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

The bounds checks for snprintf and then strncpy used different constant
defines, which happened to resolve to the same value (32). Make this
code more resilient by using sizeof() operator rather than the defines,
and replace use of strncpy with the better strlcpy.

Fixes: a3bbf2e09756 ("eventdev: add eth Tx adapter implementation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/eventdev/rte_event_eth_tx_adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 91c7be55c7..d531da5d69 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -748,7 +748,7 @@ txa_service_adapter_create_ext(uint8_t id, struct rte_eventdev *dev,
 		return -EINVAL;
 
 	socket_id = dev->data->socket_id;
-	snprintf(mem_name, TXA_MEM_NAME_LEN,
+	snprintf(mem_name, sizeof(mem_name),
 		"rte_event_eth_txa_%d",
 		id);
 
@@ -767,7 +767,7 @@ txa_service_adapter_create_ext(uint8_t id, struct rte_eventdev *dev,
 	txa->id = id;
 	txa->eventdev_id = dev->data->dev_id;
 	txa->socket_id = socket_id;
-	strncpy(txa->mem_name, mem_name, TXA_SERVICE_NAME_LEN);
+	strlcpy(txa->mem_name, mem_name, sizeof(txa->mem_name));
 	txa->conf_cb = conf_cb;
 	txa->conf_arg = conf_arg;
 	txa->service_id = TXA_INVALID_SERVICE_ID;
-- 
2.53.0

