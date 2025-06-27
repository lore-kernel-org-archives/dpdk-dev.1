Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1138BC7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 934D1406FF;
	Fri, 27 Jun 2025 12:58:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D27E040A4B
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:58:06 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QNUWgY019195;
 Fri, 27 Jun 2025 03:58:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 cut4KiCKEiJuoqaIr9GrZqLfPQ/xrLkc71+xg/qzzw=; b=jClxtz3H3YSb8UXFS
 8AY1xZfgT44qpS3v80PEFDQrBM6w/MMkUlEAZaNkKWSbEHULzBTPPqu8xudZ9K1M
 1kkLQJqTv/VzFSMkVWHgxB8iJWaCbkebPEtiAvFsdQfyPVPy3ytnvdxpxEWk+MsR
 uK6hoxiII6MTG5HZ/XzeOYjwNPUomv1+auXtRBOJxlhOrmhEHmvN3sLRlfzK01Ov
 u8/ui/STzd7gi//zkceEQ6b1iEIkX0ULigLD3OxzGdFfzjkaMSGDbLBE2lR/Anjd
 tLpYvDabVFlltF2bn78mtSR9yob9L09RGTpVq+akMbXGY6sqRVAJdP68DZuDrNDo
 BUEQw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47hfx69647-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:58:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:58:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:58:04 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 5B89E5C68E3;
 Fri, 27 Jun 2025 03:58:02 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 7/8] trace: add PMU
Date: Fri, 27 Jun 2025 12:57:39 +0200
Message-ID: <20250627105740.3388237-8-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX4KObmllALRSY
 5vm72lJ39kdZNOMNpA8gKiCrzWsqUVFHw8RUdGjaZ4/Gd75Dz+bqlS3QRNOtv1rngv6vqovP91i
 i8cQ2lumXBbGPlNrSkR+qdDrTqkozC26LN+nzm3fffVE2fqP/UYINf6Kd7JapjMffGcu6fR44kP
 GOTDTjsRVxO7JT37IbKRVu8wk2BhO67WZfJHmuvxvGgBQieJf8lvQ4tbmGEETAR486lNPg8LxAQ
 eX02GrHdhxdeDA4QrRf2lQXkj7madJbpgOTwKykgZT3JpFC30AL/do0YLj/xzHa944T1q0bceaQ
 l7wSKfdIRMc80gl64N+WOFkCRJ1BNGeCCPqClMzV05YcHu2xvbQzuAXBKYc2c5MfT4e3s1byCKh
 Tg3B2VfRo8u6BEMoYCc1I6MkTOtiY7SHdQ2vqK6ebDtfBSoNK+kQelqbm6rHFBS5oSXu8H3B
X-Proofpoint-GUID: XGIuvnsap8ylU-80cPHphArsxDhP6ez-
X-Proofpoint-ORIG-GUID: XGIuvnsap8ylU-80cPHphArsxDhP6ez-
X-Authority-Analysis: v=2.4 cv=N+4pF39B c=1 sm=1 tr=0 ts=685e793e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=DnJVbuqOAAAA:8 a=M5GUcnROAAAA:8 a=456vVYsqqi_a754giqEA:9
 a=Sz6ghim2xQgRqd81wKBx:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

In order to profile app, one needs to store significant amount of samples
somewhere for an analysis later on.
Since trace library supports storing data in a CTF format,
lets take advantage of that and add a dedicated PMU tracepoint.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 MAINTAINERS                                |  1 +
 app/test/test_trace_perf.c                 | 10 ++++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++++
 doc/guides/rel_notes/release_25_07.rst     |  2 +
 lib/eal/common/eal_common_trace.c          |  5 +-
 lib/eal/common/eal_common_trace_pmu.c      | 38 ++++++++++++
 lib/eal/common/eal_common_trace_points.c   | 20 +++++++
 lib/eal/common/eal_trace.h                 |  4 ++
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 16 +++++
 lib/eal/include/rte_trace_point.h          |  7 +++
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/pmu.c                              | 69 +++++++++++++++++++++-
 lib/pmu/rte_pmu.h                          | 24 ++++++++
 17 files changed, 236 insertions(+), 4 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9357f3a3..74cc8fc195 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,6 +1850,7 @@ F: doc/guides/prog_guide/eventdev/dispatcher_lib.rst
 PMU - EXPERIMENTAL
 M: Tomasz Duszynski <tduszynski@marvell.com>
 F: lib/pmu/
+F: lib/eal/common/eal_common_trace_pmu.c
 F: app/test/test_pmu.c
 
 Job statistics
diff --git a/app/test/test_trace_perf.c b/app/test/test_trace_perf.c
index 8257cc02be..28f908ce40 100644
--- a/app/test/test_trace_perf.c
+++ b/app/test/test_trace_perf.c
@@ -114,6 +114,10 @@ worker_fn_##func(void *arg) \
 #define GENERIC_DOUBLE rte_eal_trace_generic_double(3.66666)
 #define GENERIC_STR rte_eal_trace_generic_str("hello world")
 #define VOID_FP app_dpdk_test_fp()
+#ifdef RTE_LIB_PMU
+/* 0 corresponds first event passed via --trace= */
+#define READ_PMU rte_pmu_trace_read(0)
+#endif
 
 WORKER_DEFINE(GENERIC_VOID)
 WORKER_DEFINE(GENERIC_U64)
@@ -122,6 +126,9 @@ WORKER_DEFINE(GENERIC_FLOAT)
 WORKER_DEFINE(GENERIC_DOUBLE)
 WORKER_DEFINE(GENERIC_STR)
 WORKER_DEFINE(VOID_FP)
+#ifdef RTE_LIB_PMU
+WORKER_DEFINE(READ_PMU)
+#endif
 
 static void
 run_test(const char *str, lcore_function_t f, struct test_data *data, size_t sz)
@@ -174,6 +181,9 @@ test_trace_perf(void)
 	run_test("double", worker_fn_GENERIC_DOUBLE, data, sz);
 	run_test("string", worker_fn_GENERIC_STR, data, sz);
 	run_test("void_fp", worker_fn_VOID_FP, data, sz);
+#ifdef RTE_LIB_PMU
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
index 19be7740c4..3c55f93853 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -71,6 +71,8 @@ New Features
 
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
index 0000000000..3824904481
--- /dev/null
+++ b/lib/eal/common/eal_common_trace_pmu.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <rte_common.h>
+
+#include "eal_trace.h"
+
+#ifdef RTE_LIB_PMU
+
+#include <rte_pmu.h>
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
+#else /* !RTE_LIB_PMU */
+
+void trace_pmu_args_apply(const char *arg __rte_unused) { return; }
+void trace_pmu_args_free(void) { return; }
+
+#endif /* RTE_LIB_PMU */
diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/eal_common_trace_points.c
index 0903f3c639..ea90279d77 100644
--- a/lib/eal/common/eal_common_trace_points.c
+++ b/lib/eal/common/eal_common_trace_points.c
@@ -119,3 +119,23 @@ RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enable,
 	lib.eal.intr.enable)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
 	lib.eal.intr.disable)
+
+#ifdef RTE_LIB_PMU
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.07)
+RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
+	lib.pmu.read)
+#endif
+#ifdef RTE_EXEC_ENV_IS_WINDOWS
+/* gen-version-map.py script generates export symbol maps by scanning source files without
+ * evaluating conditional compilation. Hence __rte_pmu_trace_read will be included the version map
+ * even if library is not compiled.
+ *
+ * On Windows if msvc linker is used this leads to a hard link error
+ * (LNK2001: unresolved external symbol) because msvc requires all symbols listed in the .def file
+ * to be present in the object files.
+ *
+ * Other linkers, e.g: gnu ld or mingw ld, are more forgiving. They silently ignore symbols listed
+ * in the map file if those symbols are not present in the binary.
+ */
+rte_trace_point_t __rte_pmu_trace_read;
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
index 9ad2112801..ebea74744f 100644
--- a/lib/eal/include/rte_eal_trace.h
+++ b/lib/eal/include/rte_eal_trace.h
@@ -127,6 +127,22 @@ RTE_TRACE_POINT(
 
 #define RTE_EAL_TRACE_GENERIC_FUNC rte_eal_trace_generic_func(__func__)
 
+#ifdef RTE_LIB_PMU
+#include <rte_pmu.h>
+RTE_TRACE_POINT_FP(
+	rte_pmu_trace_read,
+	RTE_TRACE_POINT_ARGS(unsigned int index),
+	/* Embedded code should only execute in runtime so cut it out during registration in order
+	 * to avoid compilation issues because rte_pmu_trace_read_register(void) does not provide
+	 * any context.
+	 */
+	RTE_TRACE_POINT_EMBED_CODE(
+		uint64_t val = rte_pmu_read(index);
+	)
+	rte_trace_point_emit_u64(val);
+)
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index c0ebf1ce13..df91447d4a 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -46,6 +46,13 @@ typedef RTE_ATOMIC(uint64_t) rte_trace_point_t;
  */
 #define RTE_TRACE_POINT_ARGS
 
+/**
+ * Macro to define the tracepoint code in RTE_TRACE_POINT, RTE_TRACE_POINT_FP macros.
+
+ * @see RTE_TRACE_POINT, RTE_TRACE_POINT_FP
+ */
+#define RTE_TRACE_POINT_EMBED_CODE(...) __VA_ARGS__
+
 /** @internal Helper macro to support RTE_TRACE_POINT and RTE_TRACE_POINT_FP */
 #define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \
 extern rte_trace_point_t __##_tp; \
diff --git a/lib/eal/include/rte_trace_point_register.h b/lib/eal/include/rte_trace_point_register.h
index b036121959..81c28cdb5b 100644
--- a/lib/eal/include/rte_trace_point_register.h
+++ b/lib/eal/include/rte_trace_point_register.h
@@ -45,6 +45,8 @@ RTE_DECLARE_PER_LCORE(volatile int, trace_point_sz);
 #define RTE_TRACE_POINT_ARGS(...) \
 	(RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0, __VA_ARGS__), __VA_ARGS__))
 
+#define RTE_TRACE_POINT_EMBED_CODE(...)
+
 #define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \
 extern rte_trace_point_t __##_tp; \
 static __rte_always_inline void _tp _args { } \
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..8b0243eba4 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -15,6 +15,9 @@ subdir(exec_env)
 subdir(arch_subdir)
 
 deps += ['log', 'kvargs']
+if is_linux and dpdk_conf.has('RTE_LIB_PMU')
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
index 3cae29891c..742829cf9d 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <ctype.h>
+#include <regex.h>
 #include <dirent.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -389,13 +390,77 @@ rte_pmu_add_event(const char *name)
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
@@ -429,7 +494,7 @@ rte_pmu_fini(void)
 	struct rte_pmu_event_group *group;
 	unsigned int i;
 
-	if (!rte_pmu.initialized)
+	if (!rte_pmu.initialized || --rte_pmu.initialized)
 		return;
 
 	RTE_TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {
diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index e997f62334..e6df54b304 100644
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
@@ -145,6 +149,8 @@ __rte_pmu_enable_group(struct rte_pmu_event_group *group);
  *
  * Initialize PMU library.
  *
+ * It's safe to call it multiple times.
+ *
  * @return
  *   0 in case of success, negative value otherwise.
  */
@@ -157,6 +163,9 @@ rte_pmu_init(void);
  * @b EXPERIMENTAL: this API may change without prior notice.
  *
  * Finalize PMU library.
+ *
+ * Number of calls must match number of times rte_pmu_init() was called.
+ * Otherwise memory won't be freed properly.
  */
 __rte_experimental
 void
@@ -184,6 +193,21 @@ rte_pmu_add_event(const char *name);
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
2.34.1

