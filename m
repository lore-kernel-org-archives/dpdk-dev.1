Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0DBC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 16:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D7D40E34;
	Mon,  9 Jun 2025 18:57:50 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id F0AD04064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 18:57:48 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 30A23254030A;
 Mon,  9 Jun 2025 12:57:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 12:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1749488268; x=
 1749574668; bh=jxPBgu2Dws6ttNrH6lWh4z8Cj5r5ydbQcOJFYX48S44=; b=P
 LrZkdgwO3nhJjf9YWJhc30Q43JDB3KxJGyFhhcWzKIZkcpG2k2xbw67xg8kfm1xq
 57Olphh2RpO5MvJHpZcwO6QneSmH6lrywmtDYhrKZsnLI3m/W0thHoLjRwRuK+Ri
 IILLR1OkZRZoQ3ssgTDJTYHxz4ttAvJzawdvlbH8jadVm+uxlMMZ5alUVL4zroVZ
 n4aKfEeCyJo7Htg2yv0wXZHRb5dC2fGfaqfgsjnv2bDXi5AqFMQ/zRg28OGffO+f
 04pqHuFV6qYzHCQ3JveUG80inuuomvJ//7ZV5l758ytvoa9T5EPzgEa5uwrYz6g6
 d1Cg4COQeqV34fxQdPsRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1749488268; x=1749574668; bh=j
 xPBgu2Dws6ttNrH6lWh4z8Cj5r5ydbQcOJFYX48S44=; b=A3jR9fspEygYs+ayL
 HXLxsRJJtc1nTvh9q5dDDnsObagQFnfOvcLonl35/R29WPg8TsZWuTXIkIIx2aud
 LySUB4RFQhvyzvYXjZQWn8D+TiRrH5P5BBnjzIACnTf8orOp18CH1y2xi6GuF1qa
 x4nyA0lJlMxzmlp0zWiWcRxTHvWJSMf0ljgIffvCnXDyHpOKqqtnKChiZuYxXfgG
 leM5rXR+lsTQ8FS65/3ZJ6/hHuQoJITsyiyeZUafBu3KeXhoUrvuftiFg21amXmZ
 blaJXLFq38fT6m4oT5Wqyqx6/KZfb0QPWM/iDsJn6peTcIut+vAzM0INoY2B1pEZ
 cnNCA==
X-ME-Sender: <xms:ixJHaJ1DmORY4n-wASVou0W4f9EILVa7CGRDefwnWoTOSRBLNDedyQ>
 <xme:ixJHaAH0ReSpG66mWNXXpmnbur89WCABdWT68wlNb1fpo-wjFI7DEQpS8YJIlqRDA
 j3QNGsLGRGtans3Ig>
X-ME-Received: <xmr:ixJHaJ4iTtGQbiBv6_3oP1lfCE9oGwwSnoAusv3VS_-7Ry503uOjD55FK9IYF__GcbnZZXBFveXkjStwNrUe3XWux9fWWLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedtudevudfhffettedthffghedtleef
 ueduueffudevkeffudeljeevvedvvdelkeenucffohhmrghinhepughirghmohhnrdhorh
 hgpdhpmhhurdhrvggrugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtth
 hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehtughushiihihnshhkihesmhgrrhhvvghllhdrtghomhdprhgtph
 htthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehskhhorhhi
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrd
 hmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:ixJHaG0d6oNhLSOJ1aXCE-Nip75N6GmN91A6tOhD3wCy8mHcVPyGbQ>
 <xmx:ixJHaME53mP4UACXYmQhBON1N3DnjEHuQiwo60sWYwSqrg_cEu2U-g>
 <xmx:ixJHaH-ZVEqrjpeDv5aDQa2IybumQDprKO6uGox3Wfos-6PDFdbaTg>
 <xmx:ixJHaJkGn71bMjBuD35-6PGylkr51nGDSGVGtD8eEP7p-TatF7Fhpw>
 <xmx:jBJHaPFxVNbrBHrxrwny3mAdrj6BwHUigjanmWL84Zw3oxgSKdHH9NH4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 12:57:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Tomasz Duszynski <tduszynski@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v18] trace: add PMU
Date: Mon,  9 Jun 2025 18:55:24 +0200
Message-ID: <20250609165736.2255515-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20221111094338.2736065-1-tduszynski@marvell.com>
References: <20221111094338.2736065-1-tduszynski@marvell.com>
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

From: Tomasz Duszynski <tduszynski@marvell.com>

In order to profile app, one needs to store significant amount of samples
somewhere for an analysis later on.
Since trace library supports storing data in a CTF format,
lets take advantage of that and add a dedicated PMU tracepoint.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
v17 was merged without this last patch.
It is largely rebased but not compiling.
Feel free to complete the work.
Impact on AMD and unsupported archs must be checked carefully.
---
 MAINTAINERS                              |  1 +
 app/test/test_trace_perf.c               | 10 ++++
 doc/guides/prog_guide/profile_app.rst    |  5 ++
 doc/guides/prog_guide/trace_lib.rst      | 31 +++++++++++
 doc/guides/rel_notes/release_25_07.rst   |  2 +
 lib/eal/common/eal_common_trace.c        |  5 +-
 lib/eal/common/eal_common_trace_pmu.c    | 37 +++++++++++++
 lib/eal/common/eal_common_trace_points.c |  5 ++
 lib/eal/common/eal_trace.h               |  4 ++
 lib/eal/common/meson.build               |  1 +
 lib/eal/include/rte_eal_trace.h          | 12 +++++
 lib/eal/meson.build                      |  3 ++
 lib/meson.build                          |  2 +-
 lib/pmu/pmu.c                            | 69 +++++++++++++++++++++++-
 lib/pmu/rte_pmu.h                        | 24 +++++++++
 15 files changed, 207 insertions(+), 4 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ed7abb038..43c577e0f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1851,6 +1851,7 @@ F: doc/guides/prog_guide/eventdev/dispatcher_lib.rst
 PMU - EXPERIMENTAL
 M: Tomasz Duszynski <tduszynski@marvell.com>
 F: lib/pmu/
+F: lib/eal/common/eal_common_trace_pmu.c
 F: app/test/test_pmu.c
 
 Job statistics
diff --git a/app/test/test_trace_perf.c b/app/test/test_trace_perf.c
index 8257cc02be..a45fe15b32 100644
--- a/app/test/test_trace_perf.c
+++ b/app/test/test_trace_perf.c
@@ -114,6 +114,10 @@ worker_fn_##func(void *arg) \
 #define GENERIC_DOUBLE rte_eal_trace_generic_double(3.66666)
 #define GENERIC_STR rte_eal_trace_generic_str("hello world")
 #define VOID_FP app_dpdk_test_fp()
+#ifdef RTE_PMU_SUPPORTED
+/* 0 corresponds first event passed via --trace= */
+#define READ_PMU rte_pmu_trace_read(0)
+#endif
 
 WORKER_DEFINE(GENERIC_VOID)
 WORKER_DEFINE(GENERIC_U64)
@@ -122,6 +126,9 @@ WORKER_DEFINE(GENERIC_FLOAT)
 WORKER_DEFINE(GENERIC_DOUBLE)
 WORKER_DEFINE(GENERIC_STR)
 WORKER_DEFINE(VOID_FP)
+#ifdef RTE_PMU_SUPPORTED
+WORKER_DEFINE(READ_PMU)
+#endif
 
 static void
 run_test(const char *str, lcore_function_t f, struct test_data *data, size_t sz)
@@ -174,6 +181,9 @@ test_trace_perf(void)
 	run_test("double", worker_fn_GENERIC_DOUBLE, data, sz);
 	run_test("string", worker_fn_GENERIC_STR, data, sz);
 	run_test("void_fp", worker_fn_VOID_FP, data, sz);
+#ifdef RTE_PMU_SUPPORTED
+	run_test("read_pmu", worker_fn_READ_PMU, data, sz);
+#endif
 
 	rte_free(data);
 	return TEST_SUCCESS;
diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guide/profile_app.rst
index 2f47680d5d..362fd20143 100644
--- a/doc/guides/prog_guide/profile_app.rst
+++ b/doc/guides/prog_guide/profile_app.rst
@@ -42,6 +42,11 @@ Current implementation imposes certain limitations:
 * EAL lcores must not share a CPU.
 * Each EAL lcore measures the same group of events.
 
+Alternatively tracing library can be used,
+which offers dedicated tracepoint ``rte_pmu_trace_read()``.
+
+Refer to :doc:`../prog_guide/trace_lib` for more details.
+
 
 Profiling on x86
 ----------------
diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
index d9b17abe90..97158cce37 100644
--- a/doc/guides/prog_guide/trace_lib.rst
+++ b/doc/guides/prog_guide/trace_lib.rst
@@ -46,6 +46,7 @@ DPDK tracing library features
   trace format and is compatible with ``LTTng``.
   For detailed information, refer to
   `Common Trace Format <https://diamon.org/ctf/>`_.
+- Support reading PMU events on ARM64 and x86-64 (Intel)
 
 How to add a tracepoint?
 ------------------------
@@ -139,6 +140,36 @@ the user must use ``RTE_TRACE_POINT_FP`` instead of ``RTE_TRACE_POINT``.
 ``RTE_TRACE_POINT_FP`` is compiled out by default and it can be enabled using
 the ``enable_trace_fp`` option for meson build.
 
+PMU tracepoint
+--------------
+
+Performance Monitoring Unit (PMU) event values can be read from hardware registers
+using the predefined ``rte_pmu_read`` tracepoint.
+
+Tracing is enabled via ``--trace`` EAL option by passing both expression
+matching PMU tracepoint name i.e ``lib.eal.pmu.read``
+and expression ``e=ev1[,ev2,...]`` matching particular events::
+
+    --trace='.*pmu.read\|e=cpu_cycles,l1d_cache'
+
+Event names are available under ``/sys/bus/event_source/devices/PMU/events`` directory,
+where ``PMU`` is a placeholder for either a ``cpu`` or a directory containing ``cpus``.
+
+In contrary to other tracepoints this does not need any extra variables
+added to source files.
+Instead, caller passes index
+which follows the order of events specified via ``--trace`` parameter.
+In the following example, index ``0`` corresponds to ``cpu_cyclces``,
+while index ``1`` corresponds to ``l1d_cache``.
+
+.. code-block:: c
+
+   rte_pmu_trace_read(0);
+   rte_pmu_trace_read(1);
+
+PMU tracing support must be explicitly enabled
+using the ``enable_trace_fp`` option for Meson build.
+
 Event record mode
 -----------------
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index f23ddb25a4..05ecb23f1f 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -59,6 +59,8 @@ New Features
 
   Added a Performance Monitoring Unit (PMU) library which allows Linux applications
   to perform self monitoring activities without depending on external utilities like perf.
+  After integration with :doc:`../prog_guide/trace_lib`, data gathered from hardware counters
+  can be stored in CTF format for further analysis.
 
 * **Added Mucse rnp net driver.**
 
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be1f78a68d..45e7f9aa56 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -75,8 +75,10 @@ eal_trace_init(void)
 		goto free_meta;
 
 	/* Apply global configurations */
-	STAILQ_FOREACH(arg, &trace.args, next)
+	STAILQ_FOREACH(arg, &trace.args, next) {
 		trace_args_apply(arg->val);
+		trace_pmu_args_apply(arg->val);
+	}
 
 	rte_trace_mode_set(trace.mode);
 
@@ -92,6 +94,7 @@ eal_trace_init(void)
 void
 eal_trace_fini(void)
 {
+	trace_pmu_args_free();
 	trace_mem_free();
 	trace_metadata_destroy();
 	eal_trace_args_free();
diff --git a/lib/eal/common/eal_common_trace_pmu.c b/lib/eal/common/eal_common_trace_pmu.c
new file mode 100644
index 0000000000..ffab869b10
--- /dev/null
+++ b/lib/eal/common/eal_common_trace_pmu.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <rte_common.h>
+#include <rte_pmu.h>
+
+#include "eal_trace.h"
+
+#ifdef RTE_PMU_SUPPORTED
+
+void
+trace_pmu_args_apply(const char *arg)
+{
+	static bool once;
+
+	if (!once) {
+		if (rte_pmu_init())
+			return;
+		once = true;
+	}
+
+	rte_pmu_add_events_by_pattern(arg);
+}
+
+void
+trace_pmu_args_free(void)
+{
+	rte_pmu_fini();
+}
+
+#else /* !RTE_PMU_SUPPORTED */
+
+void trace_pmu_args_apply(const char *arg __rte_unused) { return; }
+void trace_pmu_args_free(void) { return; }
+
+#endif /* RTE_PMU_SUPPORTED */
diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/eal_common_trace_points.c
index 0903f3c639..2531b704f7 100644
--- a/lib/eal/common/eal_common_trace_points.c
+++ b/lib/eal/common/eal_common_trace_points.c
@@ -119,3 +119,8 @@ RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enable,
 	lib.eal.intr.enable)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
 	lib.eal.intr.disable)
+
+#if defined(ALLOW_EXPERIMENTAL_API) && defined(RTE_PMU_SUPPORTED)
+RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
+	lib.pmu.read)
+#endif
diff --git a/lib/eal/common/eal_trace.h b/lib/eal/common/eal_trace.h
index 55262677e0..58fa43472a 100644
--- a/lib/eal/common/eal_trace.h
+++ b/lib/eal/common/eal_trace.h
@@ -104,6 +104,10 @@ int trace_epoch_time_save(void);
 void trace_mem_free(void);
 void trace_mem_per_thread_free(void);
 
+/* PMU wrappers */
+void trace_pmu_args_apply(const char *arg);
+void trace_pmu_args_free(void);
+
 /* EAL interface */
 int eal_trace_init(void);
 void eal_trace_fini(void);
diff --git a/lib/eal/common/meson.build b/lib/eal/common/meson.build
index e273745e93..239c111461 100644
--- a/lib/eal/common/meson.build
+++ b/lib/eal/common/meson.build
@@ -28,6 +28,7 @@ sources += files(
         'eal_common_tailqs.c',
         'eal_common_thread.c',
         'eal_common_timer.c',
+        'eal_common_trace_pmu.c',
         'eal_common_trace_points.c',
         'eal_common_uuid.c',
         'malloc_elem.c',
diff --git a/lib/eal/include/rte_eal_trace.h b/lib/eal/include/rte_eal_trace.h
index 9ad2112801..4ed9159514 100644
--- a/lib/eal/include/rte_eal_trace.h
+++ b/lib/eal/include/rte_eal_trace.h
@@ -127,6 +127,18 @@ RTE_TRACE_POINT(
 
 #define RTE_EAL_TRACE_GENERIC_FUNC rte_eal_trace_generic_func(__func__)
 
+#ifdef ALLOW_EXPERIMENTAL_API
+#include <rte_pmu.h>
+#ifdef RTE_PMU_SUPPORTED
+RTE_TRACE_POINT_FP(
+	rte_pmu_trace_read,
+	RTE_TRACE_POINT_ARGS(unsigned int index),
+	uint64_t val = rte_pmu_read(index);
+	rte_trace_point_emit_u64(val);
+)
+#endif
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..c46893aeaa 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -15,6 +15,9 @@ subdir(exec_env)
 subdir(arch_subdir)
 
 deps += ['log', 'kvargs']
+if is_linux
+    deps += ['pmu']
+endif
 if not is_windows
     deps += ['telemetry']
 endif
diff --git a/lib/meson.build b/lib/meson.build
index 1934cb4a29..87b567f01b 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -13,7 +13,7 @@ libraries = [
         'kvargs', # eal depends on kvargs
         'argparse',
         'telemetry', # basic info querying
-        'pmu',
+        'pmu', # trace depends on pmu
         'eal', # everything depends on eal
         'ptr_compress',
         'ring',
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 46b0b450ac..35ea451863 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <ctype.h>
+#include <regex.h>
 #include <dirent.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -408,13 +409,77 @@ rte_pmu_add_event(const char *name)
 	return event->index;
 }
 
+static int
+add_events(const char *pattern)
+{
+	char *token, *copy, *tmp;
+	int ret = 0;
+
+	copy = strdup(pattern);
+	if (copy == NULL)
+		return -ENOMEM;
+
+	token = strtok_r(copy, ",", &tmp);
+	while (token) {
+		ret = rte_pmu_add_event(token);
+		if (ret < 0)
+			break;
+
+		token = strtok_r(NULL, ",", &tmp);
+	}
+
+	free(copy);
+
+	return ret >= 0 ? 0 : ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_add_events_by_pattern, 25.07)
+int
+rte_pmu_add_events_by_pattern(const char *pattern)
+{
+	regmatch_t rmatch;
+	char buf[BUFSIZ];
+	unsigned int num;
+	regex_t reg;
+	int ret;
+
+	/* events are matched against occurrences of e=ev1[,ev2,..] pattern */
+	ret = regcomp(&reg, "e=([_[:alnum:]-],?)+", REG_EXTENDED);
+	if (ret) {
+		PMU_LOG(ERR, "Failed to compile event matching regexp");
+		return -EINVAL;
+	}
+
+	for (;;) {
+		if (regexec(&reg, pattern, 1, &rmatch, 0))
+			break;
+
+		num = rmatch.rm_eo - rmatch.rm_so;
+		if (num > sizeof(buf))
+			num = sizeof(buf);
+
+		/* skip e= pattern prefix */
+		memcpy(buf, pattern + rmatch.rm_so + 2, num - 2);
+		buf[num - 2] = '\0';
+		ret = add_events(buf);
+		if (ret)
+			break;
+
+		pattern += rmatch.rm_eo;
+	}
+
+	regfree(&reg);
+
+	return ret;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_init, 25.07)
 int
 rte_pmu_init(void)
 {
 	int ret;
 
-	if (rte_pmu.initialized)
+	if (rte_pmu.initialized && ++rte_pmu.initialized)
 		return 0;
 
 	ret = scan_pmus();
@@ -448,7 +513,7 @@ rte_pmu_fini(void)
 	struct rte_pmu_event_group *group;
 	unsigned int i;
 
-	if (!rte_pmu.initialized)
+	if (!rte_pmu.initialized || --rte_pmu.initialized)
 		return;
 
 	RTE_TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {
diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 57b634ecd8..c11c39fb09 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -21,6 +21,10 @@
  *
  * rte_pmu_init()
  * rte_pmu_add_event()
+ * rte_pmu_add_event() [or rte_pmu_add_events_by_pattern()]
+ *
+ * Note that if -Denable_trace_fp=True was passed to Meson,
+ * rte_pmu_init() gets called automatically.
  *
  * Afterwards all threads can read events by calling rte_pmu_read().
  */
@@ -148,6 +152,8 @@ __rte_pmu_enable_group(struct rte_pmu_event_group *group);
  *
  * Initialize PMU library.
  *
+ * It's safe to call it multiple times.
+ *
  * @return
  *   0 in case of success, negative value otherwise.
  */
@@ -160,6 +166,9 @@ rte_pmu_init(void);
  * @b EXPERIMENTAL: this API may change without prior notice.
  *
  * Finalize PMU library.
+ *
+ * Number of calls must match number of times rte_pmu_init() was called.
+ * Otherwise memory won't be freed properly.
  */
 __rte_experimental
 void
@@ -187,6 +196,21 @@ rte_pmu_add_event(const char *name);
 #define __rte_pmu_read_userpage(pc) ({ RTE_SET_USED(pc); 0; })
 #endif
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Add events matching pattern to the group of enabled events.
+ *
+ * @param pattern
+ *   Pattern e=ev1[,ev2,...] matching events
+ *   listed under /sys/bus/event_source/devices/pmu/events,
+ *   where evX and PMU are placeholders for respectively an event and an event source.
+ */
+__rte_experimental
+int
+rte_pmu_add_events_by_pattern(const char *pattern);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.47.1

