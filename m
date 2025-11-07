Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA3BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AECA40B9B;
	Fri,  7 Nov 2025 16:51:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 38FFE40B8D;
 Fri,  7 Nov 2025 16:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530671; x=1794066671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PqSqy0xSqKqjm3o6kFI4/goHA6M/IqOUsD8xW+EDfi0=;
 b=Hjx+/0Yxr+lNh1xADFJUXj+exnX6MheLqsMucjkZSyfAKVRMXi5H1xs/
 VBTFAmDt8msx1SxgBWCmY9hKW4HQflNsTjzDtsOYxqGazVbA5RxKGk/PK
 nMrQUfVaOxa4EbWcy6dsITLjES4EuZCYKHvjoyi9yd9IARZXxvGFyGgVF
 cLG+rB0k1PCrbsNtnfey9FyF0HX5opDKthUTj6qvaMKOJrZndP9eVa63I
 l+fd08Hyt7Ml6zCFtdUciN2F0W3WdImLQgrWlGAHzHZhknZJdhYXwYsjt
 JdkkiPRQ8Yg81IuGafpaZiG7BQwUWuJHErfCXj9oFMFHslZWSq9TaLdHz w==;
X-CSE-ConnectionGUID: hs1rheL/QdSw44wLC2En2g==
X-CSE-MsgGUID: Tu9xFYy1S/WDPfFnS3vPjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151842"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151842"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:11 -0800
X-CSE-ConnectionGUID: wVAncH3TQ4agQby52HftPA==
X-CSE-MsgGUID: nK3rTut8SSGiy9kvGvA+kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321676"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ciara Power <ciara.power@intel.com>, Keith Wiles <keith.wiles@intel.com>
Subject: [RFC PATCH v2 10/33] telemetry: make socket handler typedef private
Date: Fri,  7 Nov 2025 15:50:06 +0000
Message-ID: <20251107155034.436809-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

