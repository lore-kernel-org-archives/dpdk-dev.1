Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72978CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8A714066B;
	Tue, 23 Jun 2026 16:19:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E293E40150;
 Tue, 23 Jun 2026 16:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782224391; x=1813760391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2c/ett4L4fiun5LFerxIzTNzEtdDJ1A9lxsDV5VKdg0=;
 b=J9B1Nh7nl8pN0fdEs7/1nHOfY8kbo38ZK/YjFFNitoPkbEmtsK8h5tqp
 ZQALM5f3wGDW2jFttNhpBqN6VhziJy8BLOsGb0qj5OCA1I0sqtL9YgyRX
 kYvrNSTu+dwhLWB9468m3UGF7wWupzLXD/f6pnpZ0Do5eigt0fvzzBiKV
 zzXZOdGT1iYbG0LNcwW4Xy1CYXxY3zZaEJVGnSdQiA0//PqBKC73/uBAp
 c7AxY3sDyIIgAKmxesu2YD6tnGfS+YPcA9PRsb6p8j3n13vYzOPTczGF+
 sihtTuszta+/OVBlbrIAAiiIJR/wgHroXr9MLYGHRUeYQ3KF1cpjXXfw7 w==;
X-CSE-ConnectionGUID: srshXVxcQAK/xAZ9KbBJ8A==
X-CSE-MsgGUID: KROB7zGvRXiqzOHm14VCIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82970498"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82970498"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:19:50 -0700
X-CSE-ConnectionGUID: 5DhqZbnXTAOSot0/k5qq8g==
X-CSE-MsgGUID: jLE7ResgS9iCbXBrhun9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253888676"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 07:19:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Nikhil Rao <nikhil.rao@intel.com>
Subject: [PATCH 2/3] eventdev: improve bounds checks for names in adapter
 create
Date: Tue, 23 Jun 2026 15:19:28 +0100
Message-ID: <20260623141930.704771-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623141930.704771-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
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

