Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE32C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A4844021E;
	Mon, 21 Jul 2025 12:25:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5BF284014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:25:26 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L3weUe016004;
 Mon, 21 Jul 2025 03:25:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 8YORPjqKTGJkC/bK/tFajceoUvElw7cX1CQjM9Po5k=; b=kCWMswYrb0JTMJS4c
 2uyfuj/iNMevYja1wxXGIDYFUu4Lr12H2G/fBe86RZqeubgV2AodLlv4+3RAAqBt
 /L1lUeF25kV989Wlco6Msh29x+Yr83Rxg2bUJMl7+Dulo/+O9NXNcnVClW4ejJpw
 6b7yvmH227CJlUR9D5qBZSVI871zyvZvf1rQQ+VBkGJWrs7jfMK1sUhMcv+utI4T
 Rr/Hiz9+9edZHAO33sL0/MxCsSxOVI2kuQlW1xk6p6QA543O8jFTev+wBP4NYWrc
 bgxdYdmyIcuX8o8kVQBNMISKcl7Ug19PlBE6VpbinCoOPlcVPq0+2f+X3uiFKpoS
 3w1xg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 481e3v0qbk-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 03:25:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Jul 2025 03:25:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Jul 2025 03:25:01 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 892E93F703F;
 Mon, 21 Jul 2025 03:24:58 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <david.marchand@redhat.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <tduszynski@marvell.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v7 7/8] trace: add PMU
Date: Mon, 21 Jul 2025 12:24:57 +0200
Message-ID: <20250721102457.2399936-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8zDBgpEyg_GL-Pzh-5n5kGjYE6g2JedgZeoTgGiDN97OQ@mail.gmail.com>
References: <CAJFAV8zDBgpEyg_GL-Pzh-5n5kGjYE6g2JedgZeoTgGiDN97OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ej4t3UX37jaIIrSBxaIgGwhvQawSu7za
X-Authority-Analysis: v=2.4 cv=FuUF/3rq c=1 sm=1 tr=0 ts=687e1595 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DnJVbuqOAAAA:8 a=M5GUcnROAAAA:8
 a=IkMtNAoAnOvGHdVNiekA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Sz6ghim2xQgRqd81wKBx:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ej4t3UX37jaIIrSBxaIgGwhvQawSu7za
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA5MiBTYWx0ZWRfXxgjT6CZkKujp
 HpJex58J/TsSgIpT9HD94BRXLjgSEAbESMvHOCT3AEp+w0ocPlTqBsPYJN33WWBjdrt4w7nbnjN
 a84BtlxVK0/E9ywbkb98gnKX0oop1O34PFJQITs88VfCyEi7Ju1F7rJyP83Yj4dCYA8q8KL9t5S
 VIq2gwR3MReSNiaMwtndbYnLcPuWYGQisODBZspcIGyG6mNI1/dsvvXJOVMIOqO9ZCgNf4yZNho
 j173Ub7/2fPwJYnio1U2yBYgRrLj3soaje8ig/zQrKhC8akh0hmITU2AiBBLJcV3YgZnWQX96vq
 o42fReg9BLoPD2JK0keFjkzZ70apBM2DRYteb7nmc+HflN0tYrLUUvsNRcnc5f0adVWR4aMpLeL
 V0yn18Tr2Ok+q52qM6JQUWAB/zAeLrKgOPVa/PuLaGIzFgnS/QdOoFUjZMA2klQGsDQgiEpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
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

> On Fri, Jun 27, 2025 at 5:41 PM Tomasz Duszynski <tduszynski@marvell.com> wrote:
> >
> > In order to profile app, one needs to store significant amount of samples
> > somewhere for an analysis later on.
> > Since trace library supports storing data in a CTF format,
> > lets take advantage of that and add a dedicated PMU tracepoint.
> >
> > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > ---
> >  MAINTAINERS                                |  1 +
> >  app/test/test_trace_perf.c                 | 10 ++++
> >  doc/guides/prog_guide/profile_app.rst      |  5 ++
> >  doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++++
> >  doc/guides/rel_notes/release_25_07.rst     |  2 +
> >  lib/eal/common/eal_common_trace.c          |  5 +-
> >  lib/eal/common/eal_common_trace_pmu.c      | 38 ++++++++++++
> >  lib/eal/common/eal_common_trace_points.c   | 20 +++++++
> >  lib/eal/common/eal_trace.h                 |  4 ++
> >  lib/eal/common/meson.build                 |  1 +
> >  lib/eal/include/rte_eal_trace.h            | 16 +++++
> >  lib/eal/include/rte_trace_point.h          |  7 +++
> >  lib/eal/include/rte_trace_point_register.h |  2 +
> >  lib/eal/meson.build                        |  3 +
> >  lib/meson.build                            |  2 +-
> >  lib/pmu/pmu.c                              | 69 +++++++++++++++++++++-
> >  lib/pmu/rte_pmu.h                          | 24 ++++++++
> >  17 files changed, 236 insertions(+), 4 deletions(-)
> >  create mode 100644 lib/eal/common/eal_common_trace_pmu.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0e9357f3a3..74cc8fc195 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1850,6 +1850,7 @@ F: doc/guides/prog_guide/eventdev/dispatcher_lib.rst
> >  PMU - EXPERIMENTAL
> >  M: Tomasz Duszynski <tduszynski@marvell.com>
> >  F: lib/pmu/
> > +F: lib/eal/common/eal_common_trace_pmu.c
> >  F: app/test/test_pmu.c
> >
> >  Job statistics
> > diff --git a/app/test/test_trace_perf.c b/app/test/test_trace_perf.c
> > index 8257cc02be..28f908ce40 100644
> > --- a/app/test/test_trace_perf.c
> > +++ b/app/test/test_trace_perf.c
> > @@ -114,6 +114,10 @@ worker_fn_##func(void *arg) \
> >  #define GENERIC_DOUBLE rte_eal_trace_generic_double(3.66666)
> >  #define GENERIC_STR rte_eal_trace_generic_str("hello world")
> >  #define VOID_FP app_dpdk_test_fp()
> > +#ifdef RTE_LIB_PMU
> > +/* 0 corresponds first event passed via --trace= */
> > +#define READ_PMU rte_pmu_trace_read(0)
> > +#endif
> >
> >  WORKER_DEFINE(GENERIC_VOID)
> >  WORKER_DEFINE(GENERIC_U64)
> > @@ -122,6 +126,9 @@ WORKER_DEFINE(GENERIC_FLOAT)
> >  WORKER_DEFINE(GENERIC_DOUBLE)
> >  WORKER_DEFINE(GENERIC_STR)
> >  WORKER_DEFINE(VOID_FP)
> > +#ifdef RTE_LIB_PMU
> > +WORKER_DEFINE(READ_PMU)
> > +#endif
> >
> >  static void
> >  run_test(const char *str, lcore_function_t f, struct test_data *data, size_t sz)
> > @@ -174,6 +181,9 @@ test_trace_perf(void)
> >         run_test("double", worker_fn_GENERIC_DOUBLE, data, sz);
> >         run_test("string", worker_fn_GENERIC_STR, data, sz);
> >         run_test("void_fp", worker_fn_VOID_FP, data, sz);
> > +#ifdef RTE_LIB_PMU
> > +       run_test("read_pmu", worker_fn_READ_PMU, data, sz);
> > +#endif
> >
> >         rte_free(data);
> >         return TEST_SUCCESS;
> > diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guide/profile_app.rst
> > index 2f47680d5d..362fd20143 100644
> > --- a/doc/guides/prog_guide/profile_app.rst
> > +++ b/doc/guides/prog_guide/profile_app.rst
> > @@ -42,6 +42,11 @@ Current implementation imposes certain limitations:
> >  * EAL lcores must not share a CPU.
> >  * Each EAL lcore measures the same group of events.
> >
> > +Alternatively tracing library can be used,
> > +which offers dedicated tracepoint ``rte_pmu_trace_read()``.
> > +
> > +Refer to :doc:`../prog_guide/trace_lib` for more details.
> > +
> >
> >  Profiling on x86
> >  ----------------
> > diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
> > index d9b17abe90..97158cce37 100644
> > --- a/doc/guides/prog_guide/trace_lib.rst
> > +++ b/doc/guides/prog_guide/trace_lib.rst
> > @@ -46,6 +46,7 @@ DPDK tracing library features
> >    trace format and is compatible with ``LTTng``.
> >    For detailed information, refer to
> >    `Common Trace Format <https://diamon.org/ctf/>`_.
> > +- Support reading PMU events on ARM64 and x86-64 (Intel)
> >
> >  How to add a tracepoint?
> >  ------------------------
> > @@ -139,6 +140,36 @@ the user must use ``RTE_TRACE_POINT_FP`` instead of ``RTE_TRACE_POINT``.
> >  ``RTE_TRACE_POINT_FP`` is compiled out by default and it can be enabled using
> >  the ``enable_trace_fp`` option for meson build.
> >
> > +PMU tracepoint
> > +--------------
> > +
> > +Performance Monitoring Unit (PMU) event values can be read from hardware registers
> > +using the predefined ``rte_pmu_read`` tracepoint.
> > +
> > +Tracing is enabled via ``--trace`` EAL option by passing both expression
> > +matching PMU tracepoint name i.e ``lib.eal.pmu.read``
> > +and expression ``e=ev1[,ev2,...]`` matching particular events::
> > +
> > +    --trace='.*pmu.read\|e=cpu_cycles,l1d_cache'
> > +
> > +Event names are available under ``/sys/bus/event_source/devices/PMU/events`` directory,
> > +where ``PMU`` is a placeholder for either a ``cpu`` or a directory containing ``cpus``.
> > +
> > +In contrary to other tracepoints this does not need any extra variables
> > +added to source files.
> > +Instead, caller passes index
> > +which follows the order of events specified via ``--trace`` parameter.
> > +In the following example, index ``0`` corresponds to ``cpu_cyclces``,
> > +while index ``1`` corresponds to ``l1d_cache``.
> > +
> > +.. code-block:: c
> > +
> > +   rte_pmu_trace_read(0);
> > +   rte_pmu_trace_read(1);
> > +
> > +PMU tracing support must be explicitly enabled
> > +using the ``enable_trace_fp`` option for Meson build.
> > +
> >  Event record mode
> >  -----------------
> >
> > diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> > index 19be7740c4..3c55f93853 100644
> > --- a/doc/guides/rel_notes/release_25_07.rst
> > +++ b/doc/guides/rel_notes/release_25_07.rst
> > @@ -71,6 +71,8 @@ New Features
> >
> >    Added a Performance Monitoring Unit (PMU) library which allows Linux applications
> >    to perform self monitoring activities without depending on external utilities like perf.
> > +  After integration with :doc:`../prog_guide/trace_lib`, data gathered from hardware counters
> > +  can be stored in CTF format for further analysis.
> >
> >  * **Added Mucse rnp net driver.**
> >
> > diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
> > index be1f78a68d..45e7f9aa56 100644
> > --- a/lib/eal/common/eal_common_trace.c
> > +++ b/lib/eal/common/eal_common_trace.c
> > @@ -75,8 +75,10 @@ eal_trace_init(void)
> >                 goto free_meta;
> >
> >         /* Apply global configurations */
> > -       STAILQ_FOREACH(arg, &trace.args, next)
> > +       STAILQ_FOREACH(arg, &trace.args, next) {
> >                 trace_args_apply(arg->val);
> > +               trace_pmu_args_apply(arg->val);
> > +       }
> >
> >         rte_trace_mode_set(trace.mode);
> >
> > @@ -92,6 +94,7 @@ eal_trace_init(void)
> >  void
> >  eal_trace_fini(void)
> >  {
> > +       trace_pmu_args_free();
> >         trace_mem_free();
> >         trace_metadata_destroy();
> >         eal_trace_args_free();
> > diff --git a/lib/eal/common/eal_common_trace_pmu.c b/lib/eal/common/eal_common_trace_pmu.c
> > new file mode 100644
> > index 0000000000..3824904481
> > --- /dev/null
> > +++ b/lib/eal/common/eal_common_trace_pmu.c
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +
> > +#include <rte_common.h>
> > +
> > +#include "eal_trace.h"
> > +
> > +#ifdef RTE_LIB_PMU
> > +
> > +#include <rte_pmu.h>
> > +
> > +void
> > +trace_pmu_args_apply(const char *arg)
> > +{
> > +       static bool once;
> > +
> > +       if (!once) {
> > +               if (rte_pmu_init())
> > +                       return;
> > +               once = true;
> > +       }
> > +
> > +       rte_pmu_add_events_by_pattern(arg);
> > +}
> > +
> > +void
> > +trace_pmu_args_free(void)
> > +{
> > +       rte_pmu_fini();
> > +}
> > +
> > +#else /* !RTE_LIB_PMU */
> > +
> > +void trace_pmu_args_apply(const char *arg __rte_unused) { return; }
> > +void trace_pmu_args_free(void) { return; }
> > +
> > +#endif /* RTE_LIB_PMU */
> > diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/eal_common_trace_points.c
> > index 0903f3c639..ea90279d77 100644
> > --- a/lib/eal/common/eal_common_trace_points.c
> > +++ b/lib/eal/common/eal_common_trace_points.c
> > @@ -119,3 +119,23 @@ RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enable,
> >         lib.eal.intr.enable)
> >  RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
> >         lib.eal.intr.disable)
> > +
> > +#ifdef RTE_LIB_PMU
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.07)
> > +RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
> > +       lib.pmu.read)
> > +#endif
> > +#ifdef RTE_EXEC_ENV_IS_WINDOWS
> > +/* gen-version-map.py script generates export symbol maps by scanning source files without
> > + * evaluating conditional compilation. Hence __rte_pmu_trace_read will be included the version map
> > + * even if library is not compiled.
> > + *
> > + * On Windows if msvc linker is used this leads to a hard link error
> > + * (LNK2001: unresolved external symbol) because msvc requires all symbols listed in the .def file
> > + * to be present in the object files.
> > + *
> > + * Other linkers, e.g: gnu ld or mingw ld, are more forgiving. They silently ignore symbols listed
> > + * in the map file if those symbols are not present in the binary.
> > + */
> > +rte_trace_point_t __rte_pmu_trace_read;
> > +#endif
>
> From a quick look, could you export this symbol from the PMU library itself?

Got caught up, but here is my take. It would likely make trace a dependency, but I believe the
dependency should be reversed. Also from my perspective this suggestion feels more like a
refactoring.

So unless I've misunderstood your point, I'd rater keep the current solution as is.
