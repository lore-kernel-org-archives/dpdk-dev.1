Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53453CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A36FE40B90;
	Thu,  6 Nov 2025 15:10:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5CBA940A6B;
 Thu,  6 Nov 2025 15:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438214; x=1793974214;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PqSqy0xSqKqjm3o6kFI4/goHA6M/IqOUsD8xW+EDfi0=;
 b=QHjKFPRN39GBSEduYKcAuJSWRn5VirPmi7KCpUfd4qROIBRUTPciNnfw
 XZiCkyuFcLafdqCcDxeFClpQoEsZ45AZeX4ZvycsIp8wRxpQA4gA7ORVk
 1GW+gQvIktqKwInahA5NC6pDV25AN78Bv/nEPMTkRxb/Lphdov2CVQF16
 qqdL4TVTofUxFCedmewLwe9K5KA6kBIts7vtNHe9t8CKNFole2zgmgUHK
 LG8JUYLTjzXklCnm9RcxktFEcR2qo9R5jPjQniaXssB0pAFbeoJ5prjAe
 oNP9WwrR9WovrSRhMVFJAJc37kwo77hdNp9Cd77sih6pfl1Y3ZmpGv51Y Q==;
X-CSE-ConnectionGUID: GZz0Lz8HQue2xDycXei7tQ==
X-CSE-MsgGUID: sLVnRssaR/+MqYwBcJvUzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185309"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:13 -0800
X-CSE-ConnectionGUID: p4k7xktCS/CEZL24kfdAdA==
X-CSE-MsgGUID: vQPeTYegS+Ke7kiAUzAiEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054747"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 10/19] telemetry: make socket handler typedef private
Date: Thu,  6 Nov 2025 14:09:39 +0000
Message-ID: <20251106140948.2894678-11-bruce.richardson@intel.com>
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

