Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B1D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:17:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D4240E3E;
	Thu, 11 Dec 2025 18:17:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7F63A40E15
 for <dev@dpdk.org>; Thu, 11 Dec 2025 18:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473441; x=1797009441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XZLZTnmz+PIwxYlBQVvxGVctpdIfdDKpdGicLmV63Q0=;
 b=af18Vt8fWi+37sRzWDKuOCXFGIOmxfKOD65Bqg1k0W689vyheBXJaw+1
 wjkNb867/7qtbqg+hmG2TDJ5i5FN0O5z4EkNGq/h4dvAgFUxJyAojLBbi
 LBxwoumJTIE5N+ag3j8nlMBhSpLQAjIrIT+Pk/X1wVOdxc47am7tDPVTf
 SPkH6peT5P5uDHfDQBLBMMkPfS9NdBqEqkVDDz6bS6zXoDR9zlJzsQN8z
 1SbBvpFAC5EE0EQs4VunIfSMa6oq27qDjOdm2nQ3jNGuiQXv82cTRWwK3
 XD6zKM40M8PrplLmqnOJrgPU4wPzjIyp7Ld9S/KLXqx6ZD8Id7pwIMYcz w==;
X-CSE-ConnectionGUID: GSQq4GBCS6WycXS1RDkjfg==
X-CSE-MsgGUID: Ob8WImziQRaavX9Kkp/dug==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069987"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069987"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:20 -0800
X-CSE-ConnectionGUID: E7iqAfObR/y6jfZm/xaz8g==
X-CSE-MsgGUID: ke3YyRIhR7Wmtht+ps/lIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461578"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 06/11] app/test: pass loaded driver info to secondary procs
Date: Thu, 11 Dec 2025 17:17:04 +0000
Message-ID: <20251211171709.714229-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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

