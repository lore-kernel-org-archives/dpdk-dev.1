Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2ACCD183
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 06:51:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0493A4025D;
	Fri,  3 Oct 2025 08:51:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D751240151
 for <dev@dpdk.org>; Fri,  3 Oct 2025 08:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759474273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PfeQSrVSpkvjdzG6vvUukFXzTsSDZJ6iMqfcJq/Eng=;
 b=E8+wN12b6KNB9GOEBqvwBz/L3yvJQIfS5k9dJ/1s+0xSTKnWi6OmCkSRUvjxvN8i6AVCM5
 TtWuDp/khRFvt8P3NWIIvh/uGAuze8xB1OmMQQtMZhFbjUvfsF4WlaSTsGsRKkK+2H3Vwn
 SnRGZOPyc+/2+InsFmwqumuAb348fK8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-l8uaKtfXOC2t-h1cpU4VPA-1; Fri,
 03 Oct 2025 02:51:11 -0400
X-MC-Unique: l8uaKtfXOC2t-h1cpU4VPA-1
X-Mimecast-MFC-AGG-ID: l8uaKtfXOC2t-h1cpU4VPA_1759474270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 534C8195608E; Fri,  3 Oct 2025 06:51:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94EDB1955F19; Fri,  3 Oct 2025 06:51:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2] test/debug: fix crash with mlx5 devices
Date: Fri,  3 Oct 2025 08:51:01 +0200
Message-ID: <20251003065101.617467-1-david.marchand@redhat.com>
In-Reply-To: <20251002165546.523435-1-david.marchand@redhat.com>
References: <20251002165546.523435-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uxGYv1evIe0nxwCQPvgqYLt6U2BVoY1F-jPGOvF13GE_1759474270
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Running rte_exit() in a forked process means that shared memory will be
released by the child process before the parent process does the same.
This issue has been seen recently when some GHA virtual machine (with
some mlx5 devices) runs the debug_autotest unit test.

Instead, run rte_panic() and rte_exit() from a new DPDK process spawned
like for other recursive unit tests.

Bugzilla ID: 1796
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- revert last minute cosmetic change that broke the fix... iow pass
  the name of the function to run, instead of __func__,

---
 app/test/process.h    |  2 +-
 app/test/test.c       |  2 +
 app/test/test.h       |  2 +
 app/test/test_debug.c | 92 ++++++++++++++++++++++++++++++-------------
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 9fb2bf481c..8e11d0b059 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -203,7 +203,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
  * tests attempting to use this function on FreeBSD.
  */
 #ifdef RTE_EXEC_ENV_LINUX
-static char *
+static inline char *
 get_current_prefix(char *prefix, int size)
 {
 	char path[PATH_MAX] = {0};
diff --git a/app/test/test.c b/app/test/test.c
index fd653cbbfd..8a4598baee 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -80,6 +80,8 @@ do_recursive_call(void)
 			{ "test_memory_flags", no_action },
 			{ "test_file_prefix", no_action },
 			{ "test_no_huge_flag", no_action },
+			{ "test_panic", test_panic },
+			{ "test_exit", test_exit },
 #ifdef RTE_LIB_TIMER
 #ifndef RTE_EXEC_ENV_WINDOWS
 			{ "timer_secondary_spawn_wait", test_timer_secondary },
diff --git a/app/test/test.h b/app/test/test.h
index ebc4864bf8..c6d7d23313 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -174,7 +174,9 @@ extern const char *prgname;
 int commands_init(void);
 int command_valid(const char *cmd);
 
+int test_exit(void);
 int test_mp_secondary(void);
+int test_panic(void);
 int test_timer_secondary(void);
 
 int test_set_rxtx_conf(cmdline_fixed_string_t mode);
diff --git a/app/test/test_debug.c b/app/test/test_debug.c
index 8ad6d40fcb..fe5dd5b02d 100644
--- a/app/test/test_debug.c
+++ b/app/test/test_debug.c
@@ -8,6 +8,18 @@
 #include <stdint.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
+int
+test_panic(void)
+{
+	printf("debug not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
+int
+test_exit(void)
+{
+	printf("debug not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
 static int
 test_debug(void)
 {
@@ -25,34 +37,31 @@ test_debug(void)
 #include <rte_debug.h>
 #include <rte_common.h>
 #include <rte_eal.h>
-#include <rte_service_component.h>
+#include <rte_lcore.h>
+
+#include "process.h"
 
 /*
  * Debug test
  * ==========
  */
 
-/* use fork() to test rte_panic() */
-static int
+static const char *test_args[7];
+
+int
 test_panic(void)
 {
-	int pid;
 	int status;
 
-	pid = fork();
-
-	if (pid == 0) {
+	if (getenv(RECURSIVE_ENV_VAR) != NULL) {
 		struct rlimit rl;
 
 		/* No need to generate a coredump when panicking. */
 		rl.rlim_cur = rl.rlim_max = 0;
 		setrlimit(RLIMIT_CORE, &rl);
 		rte_panic("Test Debug\n");
-	} else if (pid < 0) {
-		printf("Fork Failed\n");
-		return -1;
 	}
-	wait(&status);
+	status = process_dup(test_args, RTE_DIM(test_args), "test_panic");
 	if(status == 0){
 		printf("Child process terminated normally!\n");
 		return -1;
@@ -62,27 +71,16 @@ test_panic(void)
 	return 0;
 }
 
-/* use fork() to test rte_exit() */
 static int
 test_exit_val(int exit_val)
 {
-	int pid;
+	char buf[5];
 	int status;
 
-	/* manually cleanup EAL memory, as the fork() below would otherwise
-	 * cause the same hugepages to be free()-ed multiple times.
-	 */
-	rte_service_finalize();
-
-	pid = fork();
-
-	if (pid == 0)
-		rte_exit(exit_val, __func__);
-	else if (pid < 0){
-		printf("Fork Failed\n");
-		return -1;
-	}
-	wait(&status);
+	sprintf(buf, "%d", exit_val);
+	if (setenv("TEST_DEBUG_EXIT_VAL", buf, 1) == -1)
+		rte_panic("Failed to set exit value in env\n");
+	status = process_dup(test_args, RTE_DIM(test_args), "test_exit");
 	printf("Child process status: %d\n", status);
 	if(!WIFEXITED(status) || WEXITSTATUS(status) != (uint8_t)exit_val){
 		printf("Child process terminated with incorrect status (expected = %d)!\n",
@@ -92,11 +90,22 @@ test_exit_val(int exit_val)
 	return 0;
 }
 
-static int
+int
 test_exit(void)
 {
 	int test_vals[] = { 0, 1, 2, 255, -1 };
 	unsigned i;
+
+	if (getenv(RECURSIVE_ENV_VAR) != NULL) {
+		int exit_val;
+
+		if (!getenv("TEST_DEBUG_EXIT_VAL"))
+			rte_panic("No exit value set in env\n");
+
+		exit_val = strtol(getenv("TEST_DEBUG_EXIT_VAL"), NULL, 0);
+		rte_exit(exit_val, __func__);
+	}
+
 	for (i = 0; i < RTE_DIM(test_vals); i++) {
 		if (test_exit_val(test_vals[i]) < 0)
 			return -1;
@@ -128,6 +137,33 @@ test_usage(void)
 static int
 test_debug(void)
 {
+#ifdef RTE_EXEC_ENV_FREEBSD
+	/* BSD target doesn't support prefixes at this point, and we also need to
+	 * run another primary process here.
+	 */
+	const char * prefix = "--no-shconf";
+#else
+	const char * prefix = "--file-prefix=debug";
+#endif
+	char core[10];
+
+	sprintf(core, "%d", rte_get_main_lcore());
+
+	test_args[0] = prgname;
+	test_args[1] = prefix;
+	test_args[2] = "-l";
+	test_args[3] = core;
+
+	if (rte_eal_has_hugepages()) {
+		test_args[4] = "";
+		test_args[5] = "";
+		test_args[6] = "";
+	} else {
+		test_args[4] = "--no-huge";
+		test_args[5] = "-m";
+		test_args[6] = "2048";
+	}
+
 	rte_dump_stack();
 	if (test_panic() < 0)
 		return -1;
-- 
2.51.0

