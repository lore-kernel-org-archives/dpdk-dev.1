Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6DACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 09:33:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A9C540264;
	Fri,  7 Nov 2025 10:33:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8EEBC4021F;
 Fri,  7 Nov 2025 10:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762507993; x=1794043993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ovmy3fTDH6MmlG5ltfo/yraEubQ08kj2X/rkvA9m3qQ=;
 b=nmbIr5iXPvKYxYLw6UiUNhIqN9zA2Q8l3xTuEAt8vKVLu0lnbYy2RXPz
 B9rG+uPi1MTJTO8ibwSgW5CnDvbY5x9crmRkuFHCblehBeccZNEXryWQ2
 AqUBmEhirV3yaFdaEvuPfXJ5uqV22Hgq7LEtjEcRcRiKaCOTKJg5wv3JZ
 x9EqbCuB+AOlOVVs2voOQW+VD1mFjxSZVggQ7S0YF5/SNZobiWaTst8Yn
 H8Enk3a9vhBMH0fbUh08kFE8Avbl2nnyP7rhroOxQeQAwHnduj8nAzxyi
 O0BOcoI5wSSyqfXKJWM9ol3dpFx1MzGTGtXC2w57T9vcrYL1FENQp8ewP g==;
X-CSE-ConnectionGUID: sI7dZFHpRpuivjnkS0RS+g==
X-CSE-MsgGUID: hEXoaUylTn2IWrgpvTQkxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562262"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64562262"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 01:33:11 -0800
X-CSE-ConnectionGUID: ixJELWORRTyAXD+mLf3XKw==
X-CSE-MsgGUID: bTIrtnc2SKOY7rVhGUuArg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; d="scan'208";a="192091218"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 07 Nov 2025 01:33:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH] telemetry: make socket handler typedef private
Date: Fri,  7 Nov 2025 09:32:59 +0000
Message-ID: <20251107093259.3305537-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The socket handler typedef, just called "handler" does not belong in the
public namespace, especially since it is unprefixed. Rename to
"telemetry_sock_handler" and move to internal header.

Doing so also clears shadowing warnings in dmadev library, when it is
built with -Wshadow.

Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

---
NOTE: This patch was originally submitted as part of series[1], but I
think this is a serious enough fix to consider taking into 25.11.

[1] https://patches.dpdk.org/project/dpdk/list/?series=36607&state=*
---
 lib/telemetry/rte_telemetry.h      | 11 -----------
 lib/telemetry/telemetry.c          |  2 +-
 lib/telemetry/telemetry_internal.h | 11 +++++++++++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
index b9662a5213..0a58e518f7 100644
--- a/lib/telemetry/rte_telemetry.h
+++ b/lib/telemetry/rte_telemetry.h
@@ -325,17 +325,6 @@ typedef int (*telemetry_cb)(const char *cmd, const char *params,
 typedef int (*telemetry_arg_cb)(const char *cmd, const char *params, void *arg,
 		struct rte_tel_data *info);
 
-/**
- * Used for handling data received over a telemetry socket.
- *
- * @param sock_id
- * ID for the socket to be used by the handler.
- *
- * @return
- * Void.
- */
-typedef void * (*handler)(void *sock_id);
-
 /**
  * Used when registering a command and callback function with telemetry.
  *
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index 1cbbffbf3f..cf4324421d 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -47,7 +47,7 @@ struct cmd_callback {
 struct socket {
 	int sock;
 	char path[sizeof(((struct sockaddr_un *)0)->sun_path)];
-	handler fn;
+	telemetry_sock_handler fn;
 	RTE_ATOMIC(uint16_t) *num_clients;
 };
 static struct socket v2_socket; /* socket for v2 telemetry */
diff --git a/lib/telemetry/telemetry_internal.h b/lib/telemetry/telemetry_internal.h
index b331e9458f..2fd9fbd7c1 100644
--- a/lib/telemetry/telemetry_internal.h
+++ b/lib/telemetry/telemetry_internal.h
@@ -25,6 +25,17 @@ enum rte_telemetry_legacy_data_req {
 	DATA_REQ
 };
 
+/**
+ * Used for handling data received over a telemetry socket.
+ *
+ * @param sock_id
+ * ID for the socket to be used by the handler.
+ *
+ * @return
+ * Void.
+ */
+typedef void * (*telemetry_sock_handler)(void *sock_id);
+
 /**
  * This telemetry callback is used when registering a legacy telemetry command.
  * It handles getting and formatting stats to be returned to telemetry when
-- 
2.48.1

