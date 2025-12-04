Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC7D29FA7
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CA3E406B4;
	Thu,  4 Dec 2025 19:21:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1CEEF4066E
 for <dev@dpdk.org>; Thu,  4 Dec 2025 19:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872467; x=1796408467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XZLZTnmz+PIwxYlBQVvxGVctpdIfdDKpdGicLmV63Q0=;
 b=oKIwrxeQxWX6u7lFW6va3U2cSL1luDc9BjhDPnjxgHsHBQon042XQSHe
 XjKbEnrcoHHXWmV1agMqmHmunhyf/ota1vLN99vHUzZ/vCYqwAAObcKc5
 ggMtVbI9TeVBKz4W7FkXgAXqmEDxbM92KZGK+WFM3ME9w/WThBb7GzDqN
 s2QSQBrtGy/NIJySQ36BOJ5rp6hIPYw/dEDF4+/Q3aGp4JwSdbh6FLKWU
 pqRYKT6iNqKGOSV/szpWYscJaDoTuLQtWnQ01p21T7cmlT2EKUrT45G9A
 iOa14O/E/pFca/XLPwy+z/gxI06w2D2toI7W5s2S8GkShfAzfO5xTdLXh Q==;
X-CSE-ConnectionGUID: xX4UxKLEQUW734ZRMaYdTA==
X-CSE-MsgGUID: hVbU3M58SM+yrjmBoJgr6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013029"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013029"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:06 -0800
X-CSE-ConnectionGUID: 6m+XYoflQ9S8s8cN4lkw1A==
X-CSE-MsgGUID: ZJ/GS63iSpunzk3urod70w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423176"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 06/10] app/test: pass loaded driver info to secondary procs
Date: Thu,  4 Dec 2025 18:20:43 +0000
Message-ID: <20251204182047.3154429-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

For unit tests which run secondary processes, allow passing the driver
paths used by the primary process to that secondary. This allows use of
mempools in those secondary tests. Without this, any tests using
mempools in secondary process will fail in shared builds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/app/test/process.h b/app/test/process.h
index f948a89786..0704616c38 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -18,6 +18,7 @@
 
 #include <rte_string_fns.h> /* strlcpy */
 #include <rte_devargs.h>
+#include <rte_eal.h>
 
 #ifdef RTE_EXEC_ENV_FREEBSD
 #define self "curproc"
@@ -36,6 +37,7 @@ extern uint16_t flag_for_send_pkts;
 #endif
 
 #define PREFIX_ALLOW "--allow="
+#define PREFIX_DRIVER_PATH "--driver-path="
 
 static int
 add_parameter_allow(char **argv, int max_capacity)
@@ -63,6 +65,23 @@ add_parameter_allow(char **argv, int max_capacity)
 	return count;
 }
 
+static int
+add_parameter_driver_path(char **argv, int max_capacity)
+{
+	const char *driver_path;
+	int count = 0;
+
+	RTE_EAL_DRIVER_PATH_FOREACH(driver_path, true) {
+		if (asprintf(&argv[count], PREFIX_DRIVER_PATH"%s", driver_path) < 0)
+			break;
+
+		if (++count == max_capacity)
+			break;
+	}
+
+	return count;
+}
+
 /*
  * launches a second copy of the test process using the given argv parameters,
  * which should include argv[0] as the process name. To identify in the
@@ -75,6 +94,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	int num = 0;
 	char **argv_cpy;
 	int allow_num;
+	int driver_path_num;
 	int argv_num;
 	int i, status;
 	char path[32];
@@ -90,7 +110,8 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 		return -1;
 	else if (pid == 0) {
 		allow_num = rte_devargs_type_count(RTE_DEVTYPE_ALLOWED);
-		argv_num = numargs + allow_num + 1;
+		driver_path_num = rte_eal_driver_path_count(true);
+		argv_num = numargs + allow_num + driver_path_num + 1;
 		argv_cpy = calloc(argv_num, sizeof(char *));
 		if (!argv_cpy)
 			rte_panic("Memory allocation failed\n");
@@ -105,6 +126,11 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 			num = add_parameter_allow(&argv_cpy[i], allow_num);
 		num += numargs;
 
+		if (driver_path_num > 0) {
+			int added = add_parameter_driver_path(&argv_cpy[num], driver_path_num);
+			num += added;
+		}
+
 #ifdef RTE_EXEC_ENV_LINUX
 		{
 			const char *procdir = "/proc/" self "/fd/";
-- 
2.51.0

