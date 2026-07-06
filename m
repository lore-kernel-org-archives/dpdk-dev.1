Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED9C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 14:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7BB402E9;
	Mon,  6 Jul 2026 16:55:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EB1C402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 16:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783349721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ey8sa8B/CmCP5HdDhl6kiXAt2ogmQ3G2BvcvuZtAQCY=;
 b=LMtRbGKHDAHNnzlMcRWgI0fd5kAUXredxZlUhzqkqs1/lZKhLGDR9i01wRkxaukxBUVf8r
 JMPILILphUym5a3mngOWImvqkldZ5pch31ctyvu456oKM4bUNRQ+rq5Rgn9+EhLDsRI2qi
 QxSNv1bO2Vu/0HLGpSraw1k11hRTGM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-FAc1V0j7NkCrSULo8qjBcg-1; Mon,
 06 Jul 2026 10:55:18 -0400
X-MC-Unique: FAc1V0j7NkCrSULo8qjBcg-1
X-Mimecast-MFC-AGG-ID: FAc1V0j7NkCrSULo8qjBcg_1783349717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BC219560AD; Mon,  6 Jul 2026 14:55:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5732B3000B52; Mon,  6 Jul 2026 14:55:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com, Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] dev: fix hotplug notification to secondary
Date: Mon,  6 Jul 2026 16:55:10 +0200
Message-ID: <20260706145510.680077-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ykmh8eIZNQvW5jMs9KCZsUsKoPIj4WwpeJ0lqud6JuY_1783349717
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

There was a logical error when making some last minute change.
Fix the no_shconf evaluation.

Besides, we currently have no unit test checking device hotplug in the
fast-tests testsuite.
Instead, we rely on rcX tags validations when non regression tests
relying on the multiprocess examples are run.

Add some basic unit test that does not cover all that the examples do
yet provide a first gate on multiprocess changes.

Bugzilla ID: 1963
Fixes: 1a2e26d8701d ("dev: skip multi-process in hotplug")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 MAINTAINERS                     |   1 +
 app/test/meson.build            |   1 +
 app/test/test.c                 |   1 +
 app/test/test.h                 |   1 +
 app/test/test_dev_hotplug.c     | 320 ++++++++++++++++++++++++++++++++
 lib/eal/common/eal_common_dev.c |   4 +-
 6 files changed, 326 insertions(+), 2 deletions(-)
 create mode 100644 app/test/test_dev_hotplug.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84c528437f..0d77d9f1e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -177,6 +177,7 @@ F: app/test/test_common.c
 F: app/test/test_cpuflags.c
 F: app/test/test_cycles.c
 F: app/test/test_debug.c
+F: app/test/test_dev_hotplug.c
 F: app/test/test_devargs.c
 F: app/test/test_eal*
 F: app/test/test_errno.c
diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..4047a14586 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -61,6 +61,7 @@ source_file_deps = {
     'test_cryptodev_security_tls_record.c': ['cryptodev', 'security'],
     'test_cycles.c': [],
     'test_debug.c': [],
+    'test_dev_hotplug.c': ['net_null'],
     'test_devargs.c': ['kvargs'],
     'test_dispatcher.c': ['dispatcher'],
     'test_distributor.c': ['distributor'],
diff --git a/app/test/test.c b/app/test/test.c
index c610c3588e..597f256128 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -62,6 +62,7 @@ do_recursive_call(void)
 	} actions[] =  {
 #ifndef RTE_EXEC_ENV_WINDOWS
 			{ "run_secondary_instances", test_mp_secondary },
+			{ "run_hotplug_secondary", test_dev_hotplug_mp },
 #endif
 #ifdef RTE_LIB_PDUMP
 #ifdef RTE_NET_RING
diff --git a/app/test/test.h b/app/test/test.h
index b29233bb32..78f42d6177 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -216,6 +216,7 @@ int commands_init(void);
 int command_valid(const char *cmd);
 
 int test_exit(void);
+int test_dev_hotplug_mp(void);
 int test_mp_secondary(void);
 int test_panic(void);
 int test_timer_secondary(void);
diff --git a/app/test/test_dev_hotplug.c b/app/test/test_dev_hotplug.c
new file mode 100644
index 0000000000..b75761f520
--- /dev/null
+++ b/app/test/test_dev_hotplug.c
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Red Hat, Inc.
+ */
+
+#include <stdio.h>
+
+#include "test.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+
+#ifndef RTE_EXEC_ENV_LINUX
+
+static int
+test_dev_hotplug_api(void)
+{
+	printf("Hotplug API test only supported on Linux, skipping\n");
+	return TEST_SKIPPED;
+}
+
+int
+test_dev_hotplug_mp(void)
+{
+	printf("Hotplug MP test only supported on Linux, skipping\n");
+	return TEST_SKIPPED;
+}
+
+#else
+
+#include <sys/wait.h>
+
+#include <rte_bus.h>
+#include <rte_dev.h>
+#include <rte_devargs.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_memzone.h>
+#include <rte_stdatomic.h>
+
+#include "process.h"
+
+#define HOTPLUG_TEST_DEV "net_null0"
+
+static struct rte_device *
+find_device_by_name(const char *name)
+{
+	struct rte_dev_iterator it;
+	struct rte_device *dev;
+	struct rte_devargs da;
+	char filter[32];
+
+	memset(&da, 0, sizeof(da));
+	if (rte_devargs_parse(&da, name) != 0)
+		return NULL;
+
+	snprintf(filter, sizeof(filter), "bus=%s", rte_bus_name(da.bus));
+	rte_devargs_reset(&da);
+
+	RTE_DEV_FOREACH(dev, filter, &it) {
+		if (strcmp(rte_dev_name(dev), name) == 0 && rte_dev_is_probed(dev))
+			return dev;
+	}
+	return NULL;
+}
+
+/*
+ * Scenario A: Basic hotplug API test (single process)
+ *
+ * Tests that rte_dev_probe() and rte_dev_remove() work correctly.
+ * This test runs in a single process and validates basic API functionality.
+ */
+static int
+test_dev_hotplug_api(void)
+{
+	struct rte_device *dev;
+	int ret;
+
+	printf("== Testing rte_dev_probe/rte_dev_remove API ==\n");
+
+	dev = find_device_by_name(HOTPLUG_TEST_DEV);
+	if (dev != NULL) {
+		printf("Device %s already exists, cannot run test\n", HOTPLUG_TEST_DEV);
+		return TEST_FAILED;
+	}
+
+	printf("Probing device %s\n", HOTPLUG_TEST_DEV);
+	ret = rte_dev_probe(HOTPLUG_TEST_DEV);
+	if (ret != 0) {
+		printf("rte_dev_probe(%s) failed: %d (%s)\n",
+		       HOTPLUG_TEST_DEV, ret, rte_strerror(-ret));
+		return TEST_FAILED;
+	}
+
+	dev = find_device_by_name(HOTPLUG_TEST_DEV);
+	if (dev == NULL) {
+		printf("Device %s not found after probe\n", HOTPLUG_TEST_DEV);
+		return TEST_FAILED;
+	}
+	printf("Device %s probed successfully\n", HOTPLUG_TEST_DEV);
+
+	printf("Removing device %s\n", HOTPLUG_TEST_DEV);
+	ret = rte_dev_remove(dev);
+	if (ret != 0) {
+		printf("rte_dev_remove(%s) failed: %d (%s)\n",
+		       HOTPLUG_TEST_DEV, ret, rte_strerror(-ret));
+		return TEST_FAILED;
+	}
+
+	dev = find_device_by_name(HOTPLUG_TEST_DEV);
+	if (dev != NULL) {
+		printf("Device %s still exists after remove\n", HOTPLUG_TEST_DEV);
+		return TEST_FAILED;
+	}
+	printf("Device %s removed successfully\n", HOTPLUG_TEST_DEV);
+
+	printf("== Hotplug API test passed ==\n");
+	return TEST_SUCCESS;
+}
+
+/*
+ * Scenario B: Hotplug with multi-process notification
+ *
+ * Tests that when primary probes a device, running secondaries receive
+ * the MP notification and can see the device.
+ *
+ * Sequence:
+ * 1. Primary creates coordination memzone
+ * 2. Primary spawns secondary (via fork+exec)
+ * 3. Secondary signals ready via memzone
+ * 4. Primary probes device
+ * 5. Secondary should receive MP notification and see device
+ * 6. Secondary signals result via memzone
+ * 7. Primary collects result and cleans up
+ */
+
+#define MZ_HOTPLUG_STATE "hotplug_test_state"
+
+/* States for inter-process coordination */
+enum hotplug_test_state {
+	STATE_SECONDARY_READY = 1,
+	STATE_SECONDARY_CHECK_DEVICE,
+	STATE_SECONDARY_DONE,
+};
+
+struct hotplug_state {
+	RTE_ATOMIC(int) state;
+	RTE_ATOMIC(int) secondary_result;
+};
+
+static void
+signal_state(struct hotplug_state *state, int new_state)
+{
+	rte_atomic_store_explicit(&state->state, new_state, rte_memory_order_release);
+}
+
+static void
+wait_for_state(RTE_ATOMIC(int) *state_ptr, int expected_state)
+{
+	while (rte_atomic_load_explicit(state_ptr, rte_memory_order_acquire) != expected_state)
+		usleep(10000);
+}
+
+static int
+run_secondary_hotplug_test(void)
+{
+	const struct rte_memzone *mz;
+	struct hotplug_state *state;
+	struct rte_device *dev;
+	int ret = TEST_FAILED;
+
+	printf("Secondary: starting MP hotplug test\n");
+
+	mz = rte_memzone_lookup(MZ_HOTPLUG_STATE);
+	if (mz == NULL) {
+		printf("Secondary: cannot find coordination memzone\n");
+		return TEST_FAILED;
+	}
+	state = mz->addr;
+
+	printf("Secondary: signaling ready\n");
+	signal_state(state, STATE_SECONDARY_READY);
+
+	printf("Secondary: waiting for device probe\n");
+	wait_for_state(&state->state, STATE_SECONDARY_CHECK_DEVICE);
+
+	/*
+	 * Primary has probed the device. If MP notification worked correctly,
+	 * we should be able to find the device in our local device list.
+	 */
+	printf("Secondary: checking for device %s\n", HOTPLUG_TEST_DEV);
+	dev = find_device_by_name(HOTPLUG_TEST_DEV);
+	if (dev != NULL) {
+		printf("Secondary: device found - MP notification worked!\n");
+		ret = TEST_SUCCESS;
+	} else {
+		printf("Secondary: device NOT found - MP notification failed!\n");
+		ret = TEST_FAILED;
+	}
+
+	rte_atomic_store_explicit(&state->secondary_result, ret, rte_memory_order_relaxed);
+	signal_state(state, STATE_SECONDARY_DONE);
+
+	return ret;
+}
+
+static int
+run_primary_hotplug_test(void)
+{
+	const struct rte_memzone *mz = NULL;
+	int test_result = TEST_FAILED;
+	struct hotplug_state *state;
+	struct rte_device *dev;
+	pid_t pid = -1;
+	int ret;
+
+	printf("Primary: starting MP hotplug test\n");
+
+	mz = rte_memzone_reserve(MZ_HOTPLUG_STATE, sizeof(struct hotplug_state),
+				 rte_socket_id(), 0);
+	if (mz == NULL) {
+		printf("Primary: cannot create coordination memzone: %s\n",
+		       rte_strerror(rte_errno));
+		goto out;
+	}
+	state = mz->addr;
+	memset(state, 0, sizeof(*state));
+
+	printf("Primary: spawning secondary process\n");
+	pid = fork();
+	if (pid < 0) {
+		printf("Primary: fork failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	if (pid == 0) {
+		/* Child: exec as secondary */
+		const char *prefix;
+		char core_str[16];
+		char *argv[6];
+
+		prefix = file_prefix_arg();
+		snprintf(core_str, sizeof(core_str), "%u", rte_get_main_lcore());
+
+		argv[0] = strdup(prgname);
+		argv[1] = strdup("-l");
+		argv[2] = strdup(core_str);
+		argv[3] = strdup("--proc-type=secondary");
+		argv[4] = strdup(prefix);
+		argv[5] = NULL;
+
+		if (setenv(RECURSIVE_ENV_VAR, "run_hotplug_secondary", 1) == 0)
+			execv(argv[0], argv);
+		exit(TEST_FAILED);
+	}
+
+	/* Parent: continue as primary */
+
+	printf("Primary: waiting for secondary to be ready\n");
+	wait_for_state(&state->state, STATE_SECONDARY_READY);
+	printf("Primary: secondary is ready\n");
+
+	/* Probe device - this should send MP notification to secondary */
+	printf("Primary: probing device %s\n", HOTPLUG_TEST_DEV);
+	ret = rte_dev_probe(HOTPLUG_TEST_DEV);
+	if (ret != 0) {
+		printf("Primary: rte_dev_probe failed: %d (%s)\n", ret, rte_strerror(-ret));
+		goto out;
+	}
+
+	printf("Primary: device probed, signaling secondary\n");
+	signal_state(state, STATE_SECONDARY_CHECK_DEVICE);
+
+	printf("Primary: waiting for secondary result\n");
+	wait_for_state(&state->state, STATE_SECONDARY_DONE);
+
+	test_result = rte_atomic_load_explicit(&state->secondary_result, rte_memory_order_acquire);
+	printf("Primary: secondary reported %s\n",
+	       test_result == TEST_SUCCESS ? "SUCCESS" : "FAILURE");
+
+	dev = find_device_by_name(HOTPLUG_TEST_DEV);
+	if (dev != NULL) {
+		printf("Primary: removing device %s\n", HOTPLUG_TEST_DEV);
+		rte_dev_remove(dev);
+	}
+
+out:
+	if (pid > 0) {
+		int wstatus;
+
+		waitpid(pid, &wstatus, 0);
+		if (WIFEXITED(wstatus))
+			printf("Primary: secondary exited with status %d\n", WEXITSTATUS(wstatus));
+	}
+	rte_memzone_free(mz);
+
+	if (test_result == TEST_SUCCESS)
+		printf("== MP hotplug test passed ==\n");
+	else
+		printf("== MP hotplug test FAILED ==\n");
+
+	return test_result;
+}
+
+int
+test_dev_hotplug_mp(void)
+{
+	printf("== Testing hotplug with multi-process notification ==\n");
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		return run_primary_hotplug_test();
+
+	return run_secondary_hotplug_test();
+}
+
+#endif /* RTE_EXEC_ENV_LINUX */
+
+REGISTER_FAST_TEST(dev_hotplug_api_autotest, NOHUGE_OK, ASAN_OK, test_dev_hotplug_api);
+REGISTER_FAST_TEST(dev_hotplug_mp_autotest, NOHUGE_SKIP, ASAN_SKIP, test_dev_hotplug_mp);
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 9ed62a20e0..b43b0a4bb3 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -269,7 +269,7 @@ rte_dev_probe(const char *devargs)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	bool do_mp = !!internal_conf->no_shconf;
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	struct rte_device *dev;
 	int ret;
@@ -428,7 +428,7 @@ rte_dev_remove(struct rte_device *dev)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	bool do_mp = !!internal_conf->no_shconf;
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	char *devargs;
 	int ret;
-- 
2.54.0

