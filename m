Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B95C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E171C406BA;
	Thu, 23 Jul 2026 14:56:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 49C4640A72
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K18kk4rorRoKuahQgx10m1nDHQAaBApzWVE8ctn7Hys=;
 b=gHXTEsnceramMgIu+Fn/7xKwjMZ+sUtVnhG3dc/XxmRSUyuVnDwATYoCjKhfJ+BFandB6c
 4e8i5sTibGSq1zjJXKnUqMxBBVqfDGD2xjr9aiHL0CQhN4U2ypf99xrJ7XlXmSlgVlRF7e
 xeckDf7ZPX04isKnBMuWo8y6vde4Xg4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-qALbv2igM9WehZmUllabWQ-1; Thu,
 23 Jul 2026 08:56:24 -0400
X-MC-Unique: qALbv2igM9WehZmUllabWQ-1
X-Mimecast-MFC-AGG-ID: qALbv2igM9WehZmUllabWQ_1784811383
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59531805F3B; Thu, 23 Jul 2026 12:56:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF1A83000225; Thu, 23 Jul 2026 12:56:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/9] test: uninline helper for forking
Date: Thu, 23 Jul 2026 14:55:52 +0200
Message-ID: <20260723125559.3087579-4-david.marchand@redhat.com>
In-Reply-To: <20260723125559.3087579-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xGWoAossiw6DCw9d0zGqpwdcdUk3p5BGxKlPOLX1i3I_1784811383
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

There is no reason to keep those helpers inlined.

Besides, this code relies on internal API.
So any consumer of process.h requires internal API.

Move this code in process.c.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS           |   1 +
 app/test/meson.build  |   4 +
 app/test/process.c    | 229 ++++++++++++++++++++++++++++++++++++++++++
 app/test/process.h    | 228 ++---------------------------------------
 app/test/test_pdump.h |   3 +
 5 files changed, 246 insertions(+), 219 deletions(-)
 create mode 100644 app/test/process.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..971d15aa80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1951,6 +1951,7 @@ F: app/test/commands.c
 F: app/test/packet_burst_generator.c
 F: app/test/packet_burst_generator.h
 F: app/test/process.h
+F: app/test/process.c
 F: app/test/test.c
 F: app/test/test.h
 F: app/test/test_pmd_perf.c
diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..d8efa93050 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -5,6 +5,10 @@
 deps += ['cmdline', 'ring', 'mempool', 'mbuf']
 sources += files('commands.c', 'test.c')
 
+if not is_windows
+    sources += files('process.c')
+endif
+
 # optional dependencies: some files may use these - and so we should link them in -
 # but do not explicitly require them so they are not listed in the per-file lists below
 optional_deps = ['crypto_scheduler', 'lpm']
diff --git a/app/test/process.c b/app/test/process.c
new file mode 100644
index 0000000000..2b6d7ae84b
--- /dev/null
+++ b/app/test/process.c
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2014 Intel Corporation
+ */
+
+#include <errno.h>  /* errno */
+#include <limits.h> /* PATH_MAX */
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include <sys/wait.h>
+#endif
+#include <stdlib.h> /* NULL */
+#include <string.h> /* strerror */
+#include <unistd.h>
+#include <dirent.h>
+
+#include <rte_string_fns.h> /* strlcpy */
+#include <rte_devargs.h>
+#include <rte_eal.h>
+
+#ifdef RTE_LIB_PDUMP
+#ifdef RTE_NET_RING
+#include <rte_thread.h>
+#include "test_pdump.h"
+#endif
+#endif
+
+#include "test.h"
+#include "process.h"
+
+#define PREFIX_ALLOW "--allow="
+#define PREFIX_DRIVER_PATH "--driver-path="
+
+static int
+add_parameter_allow(char **argv, int max_capacity)
+{
+	struct rte_devargs *devargs;
+	int count = 0;
+
+	RTE_EAL_DEVARGS_FOREACH(NULL, devargs) {
+		if (strlen(devargs->name) == 0)
+			continue;
+
+		if (devargs->data == NULL || strlen(devargs->data) == 0) {
+			if (asprintf(&argv[count], PREFIX_ALLOW"%s", devargs->name) < 0)
+				break;
+		} else {
+			if (asprintf(&argv[count], PREFIX_ALLOW"%s,%s",
+					 devargs->name, devargs->data) < 0)
+				break;
+		}
+
+		if (++count == max_capacity)
+			break;
+	}
+
+	return count;
+}
+
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
+int
+process_dup(const char *const argv[], int numargs, const char *env_value)
+{
+	int num = 0;
+	char **argv_cpy;
+	int allow_num;
+	int driver_path_num;
+	int argv_num;
+	int i, status;
+#ifdef RTE_LIB_PDUMP
+#ifdef RTE_NET_RING
+	rte_thread_t thread;
+	int rc;
+#endif
+#endif
+
+	pid_t pid = fork();
+	if (pid < 0)
+		return -1;
+	else if (pid == 0) {
+		allow_num = rte_devargs_type_count(RTE_DEVTYPE_ALLOWED);
+		driver_path_num = rte_eal_driver_path_count(true);
+		argv_num = numargs + allow_num + driver_path_num + 1;
+		argv_cpy = calloc(argv_num, sizeof(char *));
+		if (!argv_cpy)
+			rte_panic("Memory allocation failed\n");
+
+		/* make a copy of the arguments to be passed to exec */
+		for (i = 0; i < numargs; i++) {
+			argv_cpy[i] = strdup(argv[i]);
+			if (argv_cpy[i] == NULL)
+				rte_panic("Error dup args\n");
+		}
+		if (allow_num > 0)
+			num = add_parameter_allow(&argv_cpy[i], allow_num);
+		num += numargs;
+
+		if (driver_path_num > 0) {
+			int added = add_parameter_driver_path(&argv_cpy[num], driver_path_num);
+			num += added;
+		}
+
+#ifdef RTE_EXEC_ENV_LINUX
+		{
+			const char *procdir = "/proc/self/fd/";
+			struct dirent *dirent;
+			char *endptr;
+			int fd, fdir;
+			DIR *dir;
+
+			/* close all open file descriptors, check /proc/self/fd
+			 * to only call close on open fds. Exclude fds 0, 1 and
+			 * 2
+			 */
+			dir = opendir(procdir);
+			if (dir == NULL) {
+				rte_panic("Error opening %s: %s\n", procdir,
+						strerror(errno));
+			}
+
+			fdir = dirfd(dir);
+			if (fdir < 0) {
+				status = errno;
+				closedir(dir);
+				rte_panic("Error %d obtaining fd for dir %s: %s\n",
+						fdir, procdir,
+						strerror(status));
+			}
+
+			while ((dirent = readdir(dir)) != NULL) {
+
+				if (strcmp(dirent->d_name, ".") == 0 ||
+					strcmp(dirent->d_name, "..") == 0)
+					continue;
+
+				errno = 0;
+				fd = strtol(dirent->d_name, &endptr, 10);
+				if (errno != 0 || endptr[0] != '\0') {
+					printf("Error converting name fd %d %s:\n",
+						fd, dirent->d_name);
+					continue;
+				}
+
+				if (fd == fdir || fd <= 2)
+					continue;
+
+				close(fd);
+			}
+			closedir(dir);
+		}
+#endif
+		printf("Running binary with argv[]:");
+		for (i = 0; i < num; i++)
+			printf("'%s' ", argv_cpy[i]);
+		printf("\n");
+		fflush(stdout);
+
+		/* set the environment variable */
+		if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
+			rte_panic("Cannot export environment variable\n");
+		if (execv(argv_cpy[0], argv_cpy) < 0)
+			rte_panic("Cannot exec: %s\n", strerror(errno));
+	}
+	/* parent process does a wait */
+#ifdef RTE_LIB_PDUMP
+#ifdef RTE_NET_RING
+	if ((strcmp(env_value, "run_pdump_server_tests") == 0)) {
+		rc = rte_thread_create(&thread, NULL, send_pkts, NULL);
+		if (rc != 0) {
+			rte_panic("Cannot start send pkts thread: %s\n",
+				  strerror(rc));
+		}
+	}
+#endif
+#endif
+
+	while (wait(&status) != pid)
+		;
+#ifdef RTE_LIB_PDUMP
+#ifdef RTE_NET_RING
+	if ((strcmp(env_value, "run_pdump_server_tests") == 0)) {
+		flag_for_send_pkts = 0;
+		rte_thread_join(thread, NULL);
+	}
+#endif
+#endif
+	return status;
+}
+
+#ifndef RTE_EXEC_ENV_LINUX
+const char *
+file_prefix_arg(void)
+{
+	return "";
+}
+#else /* RTE_EXEC_ENV_LINUX */
+char *
+get_current_prefix(char *prefix, int size)
+{
+	rte_basename(rte_eal_get_runtime_dir(), prefix, size);
+	return prefix;
+}
+
+/* Return a --file-prefix=XXXX argument */
+const char *
+file_prefix_arg(void)
+{
+	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
+	char tmp[NAME_MAX];
+
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s",
+			get_current_prefix(tmp, sizeof(tmp)));
+	return prefix;
+}
+#endif /* RTE_EXEC_ENV_LINUX */
diff --git a/app/test/process.h b/app/test/process.h
index 3ee899dbc8..cf2f95f035 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -5,73 +5,7 @@
 #ifndef _PROCESS_H_
 #define _PROCESS_H_
 
-#include <errno.h>  /* errno */
-#include <limits.h> /* PATH_MAX */
-#ifndef RTE_EXEC_ENV_WINDOWS
-#include <sys/wait.h>
-#endif
-#include <stdlib.h> /* NULL */
-#include <string.h> /* strerror */
-#include <unistd.h>
-#include <dirent.h>
-
-#include <rte_string_fns.h> /* strlcpy */
-#include <rte_devargs.h>
-#include <rte_eal.h>
-
-#ifdef RTE_LIB_PDUMP
-#ifdef RTE_NET_RING
-#include <rte_thread.h>
-extern uint32_t send_pkts(void *empty);
-extern uint16_t flag_for_send_pkts;
-#endif
-#endif
-
-#define PREFIX_ALLOW "--allow="
-#define PREFIX_DRIVER_PATH "--driver-path="
-
-static int
-add_parameter_allow(char **argv, int max_capacity)
-{
-	struct rte_devargs *devargs;
-	int count = 0;
-
-	RTE_EAL_DEVARGS_FOREACH(NULL, devargs) {
-		if (strlen(devargs->name) == 0)
-			continue;
-
-		if (devargs->data == NULL || strlen(devargs->data) == 0) {
-			if (asprintf(&argv[count], PREFIX_ALLOW"%s", devargs->name) < 0)
-				break;
-		} else {
-			if (asprintf(&argv[count], PREFIX_ALLOW"%s,%s",
-					 devargs->name, devargs->data) < 0)
-				break;
-		}
-
-		if (++count == max_capacity)
-			break;
-	}
-
-	return count;
-}
-
-static int
-add_parameter_driver_path(char **argv, int max_capacity)
-{
-	const char *driver_path;
-	int count = 0;
-
-	RTE_EAL_DRIVER_PATH_FOREACH(driver_path, true) {
-		if (asprintf(&argv[count], PREFIX_DRIVER_PATH"%s", driver_path) < 0)
-			break;
-
-		if (++count == max_capacity)
-			break;
-	}
-
-	return count;
-}
+#include <stdint.h>
 
 /*
  * launches a second copy of the test process using the given argv parameters,
@@ -79,161 +13,17 @@ add_parameter_driver_path(char **argv, int max_capacity)
  * subprocess the source of the call, the env_value parameter is set in the
  * environment as $RTE_TEST
  */
-static inline int
-process_dup(const char *const argv[], int numargs, const char *env_value)
-{
-	int num = 0;
-	char **argv_cpy;
-	int allow_num;
-	int driver_path_num;
-	int argv_num;
-	int i, status;
-#ifdef RTE_LIB_PDUMP
-#ifdef RTE_NET_RING
-	rte_thread_t thread;
-	int rc;
-#endif
-#endif
-
-	pid_t pid = fork();
-	if (pid < 0)
-		return -1;
-	else if (pid == 0) {
-		allow_num = rte_devargs_type_count(RTE_DEVTYPE_ALLOWED);
-		driver_path_num = rte_eal_driver_path_count(true);
-		argv_num = numargs + allow_num + driver_path_num + 1;
-		argv_cpy = calloc(argv_num, sizeof(char *));
-		if (!argv_cpy)
-			rte_panic("Memory allocation failed\n");
-
-		/* make a copy of the arguments to be passed to exec */
-		for (i = 0; i < numargs; i++) {
-			argv_cpy[i] = strdup(argv[i]);
-			if (argv_cpy[i] == NULL)
-				rte_panic("Error dup args\n");
-		}
-		if (allow_num > 0)
-			num = add_parameter_allow(&argv_cpy[i], allow_num);
-		num += numargs;
+int process_dup(const char *const argv[], int numargs, const char *env_value);
 
-		if (driver_path_num > 0) {
-			int added = add_parameter_driver_path(&argv_cpy[num], driver_path_num);
-			num += added;
-		}
+/*
+ * Return a --file-prefix=XXXX argument
+ * Note: only Linux supports file prefixes.
+ */
+const char *file_prefix_arg(void);
 
 #ifdef RTE_EXEC_ENV_LINUX
-		{
-			const char *procdir = "/proc/self/fd/";
-			struct dirent *dirent;
-			char *endptr;
-			int fd, fdir;
-			DIR *dir;
-
-			/* close all open file descriptors, check /proc/self/fd
-			 * to only call close on open fds. Exclude fds 0, 1 and
-			 * 2
-			 */
-			dir = opendir(procdir);
-			if (dir == NULL) {
-				rte_panic("Error opening %s: %s\n", procdir,
-						strerror(errno));
-			}
-
-			fdir = dirfd(dir);
-			if (fdir < 0) {
-				status = errno;
-				closedir(dir);
-				rte_panic("Error %d obtaining fd for dir %s: %s\n",
-						fdir, procdir,
-						strerror(status));
-			}
-
-			while ((dirent = readdir(dir)) != NULL) {
-
-				if (strcmp(dirent->d_name, ".") == 0 ||
-					strcmp(dirent->d_name, "..") == 0)
-					continue;
-
-				errno = 0;
-				fd = strtol(dirent->d_name, &endptr, 10);
-				if (errno != 0 || endptr[0] != '\0') {
-					printf("Error converting name fd %d %s:\n",
-						fd, dirent->d_name);
-					continue;
-				}
-
-				if (fd == fdir || fd <= 2)
-					continue;
-
-				close(fd);
-			}
-			closedir(dir);
-		}
+/* Get current hugepage file prefix */
+char *get_current_prefix(char *prefix, int size);
 #endif
-		printf("Running binary with argv[]:");
-		for (i = 0; i < num; i++)
-			printf("'%s' ", argv_cpy[i]);
-		printf("\n");
-		fflush(stdout);
-
-		/* set the environment variable */
-		if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
-			rte_panic("Cannot export environment variable\n");
-		if (execv(argv_cpy[0], argv_cpy) < 0)
-			rte_panic("Cannot exec: %s\n", strerror(errno));
-	}
-	/* parent process does a wait */
-#ifdef RTE_LIB_PDUMP
-#ifdef RTE_NET_RING
-	if ((strcmp(env_value, "run_pdump_server_tests") == 0)) {
-		rc = rte_thread_create(&thread, NULL, send_pkts, NULL);
-		if (rc != 0) {
-			rte_panic("Cannot start send pkts thread: %s\n",
-				  strerror(rc));
-		}
-	}
-#endif
-#endif
-
-	while (wait(&status) != pid)
-		;
-#ifdef RTE_LIB_PDUMP
-#ifdef RTE_NET_RING
-	if ((strcmp(env_value, "run_pdump_server_tests") == 0)) {
-		flag_for_send_pkts = 0;
-		rte_thread_join(thread, NULL);
-	}
-#endif
-#endif
-	return status;
-}
-
-/* Only Linux supports file prefixes. */
-#ifndef RTE_EXEC_ENV_LINUX
-static inline const char *
-file_prefix_arg(void)
-{
-	return "";
-}
-#else /* RTE_EXEC_ENV_LINUX */
-static inline char *
-get_current_prefix(char *prefix, int size)
-{
-	rte_basename(rte_eal_get_runtime_dir(), prefix, size);
-	return prefix;
-}
-
-/* Return a --file-prefix=XXXX argument */
-static inline const char *
-file_prefix_arg(void)
-{
-	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
-	char tmp[NAME_MAX];
-
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s",
-			get_current_prefix(tmp, sizeof(tmp)));
-	return prefix;
-}
-#endif /* RTE_EXEC_ENV_LINUX */
 
 #endif /* _PROCESS_H_ */
diff --git a/app/test/test_pdump.h b/app/test/test_pdump.h
index 8746d61269..b026dcc6fb 100644
--- a/app/test/test_pdump.h
+++ b/app/test/test_pdump.h
@@ -11,6 +11,9 @@
 /* sample test to send packets to the pdump client recursively */
 uint32_t send_pkts(void *empty);
 
+/* flag to stop send_pkts thread */
+extern uint16_t flag_for_send_pkts;
+
 /* Sample test to create setup for the pdump server tests */
 int test_pdump_init(void);
 
-- 
2.54.0

