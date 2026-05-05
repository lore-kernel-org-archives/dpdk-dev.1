Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B3CD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D884065B;
	Tue,  5 May 2026 07:30:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D331A40659
 for <dev@dpdk.org>; Tue,  5 May 2026 07:30:40 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64540ndd2563308; Mon, 4 May 2026 22:30:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 zOvareLN5IaqVej7DQcYjZ7CkVm+qdTTtLBUifJh/s=; b=OJkhcJEmzTR+K0xPH
 +gr6TgLFocFraIhRjkqMIBQnKLesvAorpWVTpK5laGQHKQ1fJBvVfEsUurCWEWke
 ECdRdqKCz2pyKIMGGqOVwwei+87FUYETVLAvVO/pT06x2tW3XnHm3f6RNV34Bh+B
 bzTc94CEOzGLft0ULpjfnaiRjeC+aN0pVw1LhOFV7kmjxzPebRtG5Zm3UpkT6Bqm
 A8M2wbSEw7agodff4BLaQluDzzVx8orgdXaEDfGycqBkN2R1ojqD2UG/SX5QSuZm
 nsGBETJ/tYnG9P610OaQb3CiZmeJCUNDlm/FYPpqO1Zp8M1QKNWbVW1yvcXyGbem
 xFTVQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dxw7tj1e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:30:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 22:30:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 22:30:39 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id C896C3F70B3;
 Mon,  4 May 2026 22:30:35 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Tomasz Duszynski
 <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <ndabilpuram@marvell.com>,
 <mb@smartsharesystems.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 3/5] trace: add PMU
Date: Tue, 5 May 2026 11:00:21 +0530
Message-ID: <20260505053023.3854665-3-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260505053023.3854665-1-rkudurumalla@marvell.com>
References: <20251024054830.933910-8-tduszynski@marvell.com>
 <20260505053023.3854665-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UoJT8ewB c=1 sm=1 tr=0 ts=69f9807f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=DnJVbuqOAAAA:8 a=M5GUcnROAAAA:8
 a=vvmkTYLNbfpVTxKEimsA:9 a=O8hF6Hzn-FEA:10 a=Sz6ghim2xQgRqd81wKBx:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9NMqRQoso6X04LEH7XdB2zrY5ySIK4YM
X-Proofpoint-GUID: 9NMqRQoso6X04LEH7XdB2zrY5ySIK4YM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA0OCBTYWx0ZWRfXwTfcBYw5nz59
 nlzwM/riK40NhWLNEOGRjM7NvGm26DgVTTZ+tMcpBfOPlHUkyOHgOYGGSiSK5NuSDZoTXSa9P/X
 stslRPSCtoS+AEyrhoLda1Gu3Ane60T9ZmJX/gxOhWlsEAMDoIujqCuObBgo0BPj1JODkKAO3CN
 6Q8X1e/ou62dMlptQtmjyfDvHlSzCK4oPpUwlJxIG+t40ncWfMuDYHsyVBlDl4ZMNU8D4yaKq2l
 YmoXCf+iYi+Z3LUvRRE65OZd4Ivurg2nhHT0yOe8tX6HtkZsFxP61C9SAu8QNOfe0GT1d4hw7JS
 M1kATehjU5/ySybS+TyjqQn0J6nZasK73kvkr9lEeZE6dpWTVEF97UJKc9mwJv5X2sEMG7UErKB
 8b1lIb7LVDsvNrj970Ge9nJM/Dj81WWfA1Hml58ioe9D7Frwic0llTqr9loUYBWGgT2NtH1IwiD
 MnZCTBIZTU1mu3nh0WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

In order to profile app, one needs to store significant amount of samples
somewhere for an analysis later on.
Since trace library supports storing data in a CTF format,
lets take advantage of that and add a dedicated PMU tracepoint.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 MAINTAINERS                                |  1 +
 app/test/test_trace_perf.c                 | 10 +++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 +++++++++
 lib/eal/common/eal_common_trace.c          |  6 +-
 lib/eal/common/eal_common_trace_pmu.c      | 46 +++++++++++++
 lib/eal/common/eal_trace_pmu.h             | 13 ++++
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 23 +++++++
 lib/eal/include/rte_trace_point.h          |  7 ++
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/pmu.c                              | 78 ++++++++++++++++++++--
 lib/pmu/rte_pmu.h                          | 24 +++++++
 15 files changed, 244 insertions(+), 8 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c
 create mode 100644 lib/eal/common/eal_trace_pmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..65cf8ed641 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1866,6 +1866,7 @@ F: doc/guides/prog_guide/eventdev/dispatcher_lib.rst
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
 
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index a76dff0017..bba0064e83 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -16,6 +16,7 @@
 
 #include <eal_export.h>
 #include "eal_trace.h"
+#include "eal_trace_pmu.h"
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05)
 RTE_DEFINE_PER_LCORE(volatile int, trace_point_sz);
@@ -75,8 +76,10 @@ eal_trace_init(void)
 		goto free_meta;
 
 	/* Apply global configurations */
-	STAILQ_FOREACH(arg, &trace.args, next)
+	STAILQ_FOREACH(arg, &trace.args, next) {
 		trace_args_apply(arg->val);
+		trace_pmu_args_apply(arg->val);
+	}
 
 	rte_trace_mode_set(trace.mode);
 
@@ -92,6 +95,7 @@ eal_trace_init(void)
 void
 eal_trace_fini(void)
 {
+	trace_pmu_args_free();
 	trace_mem_free();
 	trace_metadata_destroy();
 	eal_trace_args_free();
diff --git a/lib/eal/common/eal_common_trace_pmu.c b/lib/eal/common/eal_common_trace_pmu.c
new file mode 100644
index 0000000000..7c83ef11e1
--- /dev/null
+++ b/lib/eal/common/eal_common_trace_pmu.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <rte_common.h>
+
+#include "eal_trace_pmu.h"
+
+#ifdef RTE_LIB_PMU
+
+#include <eal_export.h>
+#include <rte_pmu.h>
+#include <rte_trace_point_register.h>
+#include <rte_eal_trace.h>
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.11)
+RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
+	lib.pmu.read)
+
+#else /* !RTE_LIB_PMU */
+
+void trace_pmu_args_apply(const char *arg __rte_unused) { return; }
+void trace_pmu_args_free(void) { return; }
+
+#endif /* RTE_LIB_PMU */
+
diff --git a/lib/eal/common/eal_trace_pmu.h b/lib/eal/common/eal_trace_pmu.h
new file mode 100644
index 0000000000..a8c8773b5a
--- /dev/null
+++ b/lib/eal/common/eal_trace_pmu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef __EAL_TRACE_PMU_H
+#define __EAL_TRACE_PMU_H
+
+/* PMU wrappers */
+void trace_pmu_args_apply(const char *arg);
+void trace_pmu_args_free(void);
+
+#endif /* __EAL_TRACE_PMU_H */
+
diff --git a/lib/eal/common/meson.build b/lib/eal/common/meson.build
index e273745e93..463c8f74db 100644
--- a/lib/eal/common/meson.build
+++ b/lib/eal/common/meson.build
@@ -48,6 +48,7 @@ if not is_windows
             'eal_common_hypervisor.c',
             'eal_common_proc.c',
             'eal_common_trace.c',
+            'eal_common_trace_pmu.c',
             'eal_common_trace_ctf.c',
             'eal_common_trace_utils.c',
             'hotplug_mp.c',
diff --git a/lib/eal/include/rte_eal_trace.h b/lib/eal/include/rte_eal_trace.h
index 152474bf84..0585fe08e4 100644
--- a/lib/eal/include/rte_eal_trace.h
+++ b/lib/eal/include/rte_eal_trace.h
@@ -127,6 +127,29 @@ RTE_TRACE_POINT(
 
 #define RTE_EAL_TRACE_GENERIC_FUNC rte_eal_trace_generic_func(__func__)
 
+#ifdef RTE_LIB_PMU
+#include <rte_debug.h>
+#include <rte_pmu.h>
+RTE_TRACE_POINT_FP(
+	rte_pmu_trace_read,
+	RTE_TRACE_POINT_ARGS(unsigned int index),
+	/* Embedded code should only execute in runtime so cut it out during registration in order
+	 * to avoid compilation issues because rte_pmu_trace_read_register(void) does not provide
+	 * any context.
+	 */
+	RTE_TRACE_POINT_EMBED_CODE(
+		uint64_t val;
+#ifdef ALLOW_EXPERIMENTAL_API
+		val = rte_pmu_read(index);
+#else
+		RTE_SET_USED(index);
+		RTE_VERIFY(false);
+#endif
+	)
+	rte_trace_point_emit_u64(val);
+)
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index 394b2619c5..6d6ec8e46d 100644
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
index f9fcee24ee..95aa66c791 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -15,6 +15,9 @@ subdir(exec_env)
 subdir(arch_subdir)
 
 deps += ['argparse', 'kvargs']
+if is_linux and dpdk_conf.has('RTE_LIB_PMU')
+    deps += ['pmu']
+endif
 if not is_windows
     deps += ['telemetry']
 endif
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..fe7e9c63bc 100644
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
index e4d4f146d1..c14ffa5a2a 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <ctype.h>
+#include <regex.h>
 #include <dirent.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -371,6 +372,7 @@ static void
 free_event(struct rte_pmu_event *event)
 {
 	free(event->name);
+	event->name = NULL;
 	free(event);
 }
 
@@ -417,13 +419,77 @@ rte_pmu_add_event(const char *name)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_add_events_by_pattern, 25.11)
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
@@ -440,11 +506,11 @@ rte_pmu_init(void)
 
 	TAILQ_INIT(&rte_pmu.event_list);
 	rte_pmu.initialized = 1;
+
+	return 0;
 out:
-	if (ret) {
-		free(rte_pmu.name);
-		rte_pmu.name = NULL;
-	}
+	free(rte_pmu.name);
+	rte_pmu.name = NULL;
 
 	return ret;
 }
@@ -457,7 +523,7 @@ rte_pmu_fini(void)
 	struct rte_pmu_event_group *group;
 	unsigned int i;
 
-	if (!rte_pmu.initialized)
+	if (!rte_pmu.initialized || --rte_pmu.initialized)
 		return;
 
 	RTE_TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {
diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 2e3678d966..9970282c76 100644
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
@@ -146,6 +150,8 @@ __rte_pmu_enable_group(struct rte_pmu_event_group *group);
  *
  * Initialize PMU library.
  *
+ * It's safe to call it multiple times.
+ *
  * @return
  *   0 in case of success, negative value otherwise.
  */
@@ -158,6 +164,9 @@ rte_pmu_init(void);
  * @b EXPERIMENTAL: this API may change without prior notice.
  *
  * Finalize PMU library.
+ *
+ * Number of calls must match number of times rte_pmu_init() was called.
+ * Otherwise memory won't be freed properly.
  */
 __rte_experimental
 void
@@ -179,6 +188,21 @@ __rte_experimental
 int
 rte_pmu_add_event(const char *name);
 
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
2.25.1

