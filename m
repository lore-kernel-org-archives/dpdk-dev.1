Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569EDC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F17402B9;
	Tue,  1 Jul 2025 15:34:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9C56E40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751376855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6JTNAYcxlI2HEzVVLTLmXLalFHpVaMR09dw21jdGko=;
 b=TzaNMrB/pTMmW85j7Mi5Oljso3cEa5i3aMAAaxHjOfT3nncyMmakG2TQWC8p33R2vICKPi
 qlpAgQ7UFPxSBqdAw41KGbVyJHsgdJah9EXd2T/kDX6AvC7jDzr38ic1WXFGG+0Us79Eg5
 9N+WpEEKmEKHgHRzRxzqtABKaCYt4v0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-DiMjmEJfOv608zYzK-MtHA-1; Tue, 01 Jul 2025 09:34:14 -0400
X-MC-Unique: DiMjmEJfOv608zYzK-MtHA-1
X-Mimecast-MFC-AGG-ID: DiMjmEJfOv608zYzK-MtHA_1751376853
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-553decb7e3cso3300435e87.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751376853; x=1751981653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6JTNAYcxlI2HEzVVLTLmXLalFHpVaMR09dw21jdGko=;
 b=AtwMWYLXOceuLhuQYhuF6TZsDF0xwd/U4MOWjFbe139Tkg7khhr1BvGyagY59XQt1q
 uGmRH1ULVjiXQ7sHzX/45jko3OGlawtyCBeZUmlDI4Nyc3jy+2sOVy31ZAZJjUKg55xa
 HrJ3N1TKO1Y8YLyArnkrbeDup96Wwg++vxUOeH3cbFSVpl+P4Yl6XIcBZD8tIn/Ji2Q2
 6WQ1xYkMMquIm5rCBkckWjj8dqKic+DEMJzwq3f0C7gQK/jlbCRSJWVyU511rChF0ozE
 6xvnJ5DA88OhEtA3WNVz3TJ59GkMZMY2XKWifYQtbKFblAkRuceNAR7DvCty0JaFNRJi
 HGaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKCwNrJcSqLIbXAjCYh+6bh484rRYFunmar+XA3FTZf1PN7pIWrScrJAseK1mIjWO4Es=@dpdk.org
X-Gm-Message-State: AOJu0YzzUdxYgiQ49ml+zOYho1obOv4ZMYOlsIuiOBfH/8b58zY3V5ST
 SGwmgRHokTn3ovkvPtsmKtum3pv4IhHTvUP43fwEKwoerl8U7yaujmJnt/6ZbwWRdPZ525arnRc
 uB7vRi7qLu1j1VKQ47xG/1dKeejvUfQNp1sb75KgszhJVLKpZQg/C96QBNamitvyDAAgFeeG2l9
 Jm6vvapsCzzS4Q3bXVHVg7ZE3IDN4=
X-Gm-Gg: ASbGncsly2QyPUGC0BazRWP9y1Cg7b9MBzz6gpT9bqHUpt+diZKiTsMsmCeB3vnxGxS
 oWCzsKuZKDbZFZL0YFMMeaKNf5OpbfruLgWGgiGc/KpVkBhyDaFqJ0FoQNHyqLS1rzagDkAD41g
 17IAsx+g==
X-Received: by 2002:a05:6512:1599:b0:553:3127:b00 with SMTP id
 2adb3069b0e04-5550b9eeb01mr6848201e87.32.1751376851979; 
 Tue, 01 Jul 2025 06:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJjIg5lVerhisrXT4axA9rvV0cueOmCj+PnWkczGqta/qxsyePk8FsK/OV8J4vBirDYKWde9TJ5RiwHow1+kg=
X-Received: by 2002:a05:6512:1599:b0:553:3127:b00 with SMTP id
 2adb3069b0e04-5550b9eeb01mr6848188e87.32.1751376851254; Tue, 01 Jul 2025
 06:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250627154107.3405768-8-tduszynski@marvell.com>
In-Reply-To: <20250627154107.3405768-8-tduszynski@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Jul 2025 15:33:59 +0200
X-Gm-Features: Ac12FXzJyVjp3MzL6m0HSDRx3VI_WifK2NJ9Z0W3w4aQr9yaaiO4qBpTDdd7Odk
Message-ID: <CAJFAV8zDBgpEyg_GL-Pzh-5n5kGjYE6g2JedgZeoTgGiDN97OQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] trace: add PMU
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, jerinj@marvell.com, 
 mb@smartsharesystems.com, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J6f0GeWq8JddgCkvoh6byjy-d6bxUKHRmWJZnCCn5JQ_1751376853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 27, 2025 at 5:41=E2=80=AFPM Tomasz Duszynski <tduszynski@marvel=
l.com> wrote:
>
> In order to profile app, one needs to store significant amount of samples
> somewhere for an analysis later on.
> Since trace library supports storing data in a CTF format,
> lets take advantage of that and add a dedicated PMU tracepoint.
>
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> ---
>  MAINTAINERS                                |  1 +
>  app/test/test_trace_perf.c                 | 10 ++++
>  doc/guides/prog_guide/profile_app.rst      |  5 ++
>  doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++++
>  doc/guides/rel_notes/release_25_07.rst     |  2 +
>  lib/eal/common/eal_common_trace.c          |  5 +-
>  lib/eal/common/eal_common_trace_pmu.c      | 38 ++++++++++++
>  lib/eal/common/eal_common_trace_points.c   | 20 +++++++
>  lib/eal/common/eal_trace.h                 |  4 ++
>  lib/eal/common/meson.build                 |  1 +
>  lib/eal/include/rte_eal_trace.h            | 16 +++++
>  lib/eal/include/rte_trace_point.h          |  7 +++
>  lib/eal/include/rte_trace_point_register.h |  2 +
>  lib/eal/meson.build                        |  3 +
>  lib/meson.build                            |  2 +-
>  lib/pmu/pmu.c                              | 69 +++++++++++++++++++++-
>  lib/pmu/rte_pmu.h                          | 24 ++++++++
>  17 files changed, 236 insertions(+), 4 deletions(-)
>  create mode 100644 lib/eal/common/eal_common_trace_pmu.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..74cc8fc195 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1850,6 +1850,7 @@ F: doc/guides/prog_guide/eventdev/dispatcher_lib.rs=
t
>  PMU - EXPERIMENTAL
>  M: Tomasz Duszynski <tduszynski@marvell.com>
>  F: lib/pmu/
> +F: lib/eal/common/eal_common_trace_pmu.c
>  F: app/test/test_pmu.c
>
>  Job statistics
> diff --git a/app/test/test_trace_perf.c b/app/test/test_trace_perf.c
> index 8257cc02be..28f908ce40 100644
> --- a/app/test/test_trace_perf.c
> +++ b/app/test/test_trace_perf.c
> @@ -114,6 +114,10 @@ worker_fn_##func(void *arg) \
>  #define GENERIC_DOUBLE rte_eal_trace_generic_double(3.66666)
>  #define GENERIC_STR rte_eal_trace_generic_str("hello world")
>  #define VOID_FP app_dpdk_test_fp()
> +#ifdef RTE_LIB_PMU
> +/* 0 corresponds first event passed via --trace=3D */
> +#define READ_PMU rte_pmu_trace_read(0)
> +#endif
>
>  WORKER_DEFINE(GENERIC_VOID)
>  WORKER_DEFINE(GENERIC_U64)
> @@ -122,6 +126,9 @@ WORKER_DEFINE(GENERIC_FLOAT)
>  WORKER_DEFINE(GENERIC_DOUBLE)
>  WORKER_DEFINE(GENERIC_STR)
>  WORKER_DEFINE(VOID_FP)
> +#ifdef RTE_LIB_PMU
> +WORKER_DEFINE(READ_PMU)
> +#endif
>
>  static void
>  run_test(const char *str, lcore_function_t f, struct test_data *data, si=
ze_t sz)
> @@ -174,6 +181,9 @@ test_trace_perf(void)
>         run_test("double", worker_fn_GENERIC_DOUBLE, data, sz);
>         run_test("string", worker_fn_GENERIC_STR, data, sz);
>         run_test("void_fp", worker_fn_VOID_FP, data, sz);
> +#ifdef RTE_LIB_PMU
> +       run_test("read_pmu", worker_fn_READ_PMU, data, sz);
> +#endif
>
>         rte_free(data);
>         return TEST_SUCCESS;
> diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guid=
e/profile_app.rst
> index 2f47680d5d..362fd20143 100644
> --- a/doc/guides/prog_guide/profile_app.rst
> +++ b/doc/guides/prog_guide/profile_app.rst
> @@ -42,6 +42,11 @@ Current implementation imposes certain limitations:
>  * EAL lcores must not share a CPU.
>  * Each EAL lcore measures the same group of events.
>
> +Alternatively tracing library can be used,
> +which offers dedicated tracepoint ``rte_pmu_trace_read()``.
> +
> +Refer to :doc:`../prog_guide/trace_lib` for more details.
> +
>
>  Profiling on x86
>  ----------------
> diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/=
trace_lib.rst
> index d9b17abe90..97158cce37 100644
> --- a/doc/guides/prog_guide/trace_lib.rst
> +++ b/doc/guides/prog_guide/trace_lib.rst
> @@ -46,6 +46,7 @@ DPDK tracing library features
>    trace format and is compatible with ``LTTng``.
>    For detailed information, refer to
>    `Common Trace Format <https://diamon.org/ctf/>`_.
> +- Support reading PMU events on ARM64 and x86-64 (Intel)
>
>  How to add a tracepoint?
>  ------------------------
> @@ -139,6 +140,36 @@ the user must use ``RTE_TRACE_POINT_FP`` instead of =
``RTE_TRACE_POINT``.
>  ``RTE_TRACE_POINT_FP`` is compiled out by default and it can be enabled =
using
>  the ``enable_trace_fp`` option for meson build.
>
> +PMU tracepoint
> +--------------
> +
> +Performance Monitoring Unit (PMU) event values can be read from hardware=
 registers
> +using the predefined ``rte_pmu_read`` tracepoint.
> +
> +Tracing is enabled via ``--trace`` EAL option by passing both expression
> +matching PMU tracepoint name i.e ``lib.eal.pmu.read``
> +and expression ``e=3Dev1[,ev2,...]`` matching particular events::
> +
> +    --trace=3D'.*pmu.read\|e=3Dcpu_cycles,l1d_cache'
> +
> +Event names are available under ``/sys/bus/event_source/devices/PMU/even=
ts`` directory,
> +where ``PMU`` is a placeholder for either a ``cpu`` or a directory conta=
ining ``cpus``.
> +
> +In contrary to other tracepoints this does not need any extra variables
> +added to source files.
> +Instead, caller passes index
> +which follows the order of events specified via ``--trace`` parameter.
> +In the following example, index ``0`` corresponds to ``cpu_cyclces``,
> +while index ``1`` corresponds to ``l1d_cache``.
> +
> +.. code-block:: c
> +
> +   rte_pmu_trace_read(0);
> +   rte_pmu_trace_read(1);
> +
> +PMU tracing support must be explicitly enabled
> +using the ``enable_trace_fp`` option for Meson build.
> +
>  Event record mode
>  -----------------
>
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 19be7740c4..3c55f93853 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -71,6 +71,8 @@ New Features
>
>    Added a Performance Monitoring Unit (PMU) library which allows Linux a=
pplications
>    to perform self monitoring activities without depending on external ut=
ilities like perf.
> +  After integration with :doc:`../prog_guide/trace_lib`, data gathered f=
rom hardware counters
> +  can be stored in CTF format for further analysis.
>
>  * **Added Mucse rnp net driver.**
>
> diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_commo=
n_trace.c
> index be1f78a68d..45e7f9aa56 100644
> --- a/lib/eal/common/eal_common_trace.c
> +++ b/lib/eal/common/eal_common_trace.c
> @@ -75,8 +75,10 @@ eal_trace_init(void)
>                 goto free_meta;
>
>         /* Apply global configurations */
> -       STAILQ_FOREACH(arg, &trace.args, next)
> +       STAILQ_FOREACH(arg, &trace.args, next) {
>                 trace_args_apply(arg->val);
> +               trace_pmu_args_apply(arg->val);
> +       }
>
>         rte_trace_mode_set(trace.mode);
>
> @@ -92,6 +94,7 @@ eal_trace_init(void)
>  void
>  eal_trace_fini(void)
>  {
> +       trace_pmu_args_free();
>         trace_mem_free();
>         trace_metadata_destroy();
>         eal_trace_args_free();
> diff --git a/lib/eal/common/eal_common_trace_pmu.c b/lib/eal/common/eal_c=
ommon_trace_pmu.c
> new file mode 100644
> index 0000000000..3824904481
> --- /dev/null
> +++ b/lib/eal/common/eal_common_trace_pmu.c
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#include <rte_common.h>
> +
> +#include "eal_trace.h"
> +
> +#ifdef RTE_LIB_PMU
> +
> +#include <rte_pmu.h>
> +
> +void
> +trace_pmu_args_apply(const char *arg)
> +{
> +       static bool once;
> +
> +       if (!once) {
> +               if (rte_pmu_init())
> +                       return;
> +               once =3D true;
> +       }
> +
> +       rte_pmu_add_events_by_pattern(arg);
> +}
> +
> +void
> +trace_pmu_args_free(void)
> +{
> +       rte_pmu_fini();
> +}
> +
> +#else /* !RTE_LIB_PMU */
> +
> +void trace_pmu_args_apply(const char *arg __rte_unused) { return; }
> +void trace_pmu_args_free(void) { return; }
> +
> +#endif /* RTE_LIB_PMU */
> diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/ea=
l_common_trace_points.c
> index 0903f3c639..ea90279d77 100644
> --- a/lib/eal/common/eal_common_trace_points.c
> +++ b/lib/eal/common/eal_common_trace_points.c
> @@ -119,3 +119,23 @@ RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enable,
>         lib.eal.intr.enable)
>  RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
>         lib.eal.intr.disable)
> +
> +#ifdef RTE_LIB_PMU
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.07)
> +RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
> +       lib.pmu.read)
> +#endif
> +#ifdef RTE_EXEC_ENV_IS_WINDOWS
> +/* gen-version-map.py script generates export symbol maps by scanning so=
urce files without
> + * evaluating conditional compilation. Hence __rte_pmu_trace_read will b=
e included the version map
> + * even if library is not compiled.
> + *
> + * On Windows if msvc linker is used this leads to a hard link error
> + * (LNK2001: unresolved external symbol) because msvc requires all symbo=
ls listed in the .def file
> + * to be present in the object files.
> + *
> + * Other linkers, e.g: gnu ld or mingw ld, are more forgiving. They sile=
ntly ignore symbols listed
> + * in the map file if those symbols are not present in the binary.
> + */
> +rte_trace_point_t __rte_pmu_trace_read;
> +#endif

From a quick look, could you export this symbol from the PMU library itself=
?


--=20
David Marchand

