Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4430CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B50444042E;
	Wed,  5 Nov 2025 14:38:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AF1754021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 14:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762349921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGxvParVvsjlIhoQJV/Yt/1pM+ceMt1ooZF+l3656JA=;
 b=Bd+MKuCHAL/Q85hF4H0wgMu2BkXJjZu2QvdeiQ1oPvJYAiSFOl1oEeVKXZJ1XLWHgMrqcL
 C8YM8jdt5bacAjWoedsPWONcusoEyWzlUd3+FDYDrxCyx3IP+c41UR5xijEgnFwA+tRY+P
 a8tfOUoEjWppnEVBZa+/ZqFueAk3dO0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-F1gWI2e9MMKCibuhl8kwuw-1; Wed, 05 Nov 2025 08:38:39 -0500
X-MC-Unique: F1gWI2e9MMKCibuhl8kwuw-1
X-Mimecast-MFC-AGG-ID: F1gWI2e9MMKCibuhl8kwuw_1762349918
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-37a5a27d5f5so2305041fa.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 05:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762349917; x=1762954717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGxvParVvsjlIhoQJV/Yt/1pM+ceMt1ooZF+l3656JA=;
 b=SW0SabeeVdCml/VtQp5SQzfpxGLH/UexEL36dK0mDAcOCqe+0Y5D4C6R3oazA8uvCL
 XUylWIkPQSuDPMrnTzbQFFuPX3+M2dlgHAuaMVUGxuCaHNj0xR6i4mO9iLRYNJZHx5G4
 tS805ILR2QVPgA3qFO1xNYiXVbA0+0AEIOiehQGQPKCJK/ic87qm8YuNsnXa92e2heHn
 fYDBvWtS4W9WdWgtZh5G5DQJqZlLxrEvR5qXfCdzuqg51qV1/6FjtWKttdSMO6vC6NiY
 zJc2VCIL2h5tNEJtOPt/b9d7FT65Is9k69nL36b+7PplQGIa7M4lPoroBfz/7q1DM5IZ
 xtLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9v7unrjqW+lkC0tYCAXb0pbDx3wzvkOt6GzlC3PwJ0YReRyp/2HtsUbxJXiCih/E0Ro=@dpdk.org
X-Gm-Message-State: AOJu0YwFfh8RU6VlkDII4FBNstOyY+fYi2EjmMxbNcQkh+qJTzlk5KKi
 aUoyft5j1zelZc5VITpSc87BKFRFH5EeOy6IYHw0BvyMy+yQ8N7fJRgBHaSAXz+SiiRMkMME5Ok
 zXR/ItlcFocQsXCAqcnLmL+999MhE8jEJqQexAXM2oZ/z+v3xjnoE9EljsD1Ed0kXymqgS7k3KH
 9llCKWBeeO+quKatTf2EU=
X-Gm-Gg: ASbGncv+k5GWVDXl5A5NlhPHuVj5O7k6aWkFSGiIAmC/orgDHJFhAq5vBvBD1UE6nsP
 x9DU7jbb2cr4F57EMS2Jg6LBJjWL5DvCRKeCjjbWh+PC9jEWm2FGbGMPweGqqFVbTO+OdfsjcxB
 aXcDS3qA0GbuO8bmsI+pS6uACivwrPyBQoUNIk+Sk7i4pUJr4wtPZ1mlr0Xw==
X-Received: by 2002:a2e:a585:0:b0:37a:2b3d:12a8 with SMTP id
 38308e7fff4ca-37a513d81b7mr9227121fa.9.1762349917365; 
 Wed, 05 Nov 2025 05:38:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOVvWzO5ZqTXkwCVrOfiuhDdfX+jpbTsEwk5fDr98oKsHUuLb3EvsDaKb05Pjhyooz9lDhL1FAYiKjmBn4/m8=
X-Received: by 2002:a2e:a585:0:b0:37a:2b3d:12a8 with SMTP id
 38308e7fff4ca-37a513d81b7mr9226901fa.9.1762349916715; Wed, 05 Nov 2025
 05:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
 <20251024054830.933910-9-tduszynski@marvell.com>
In-Reply-To: <20251024054830.933910-9-tduszynski@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 14:38:22 +0100
X-Gm-Features: AWmQ_bmJD7hVEUQ7NR1J1TqmVGUpxj8iHCqKLoMb1vXr5hZ2BwQR838gFAX7KBI
Message-ID: <CAJFAV8xzDmFcHq_NPPQv-OGU7qXwHAQZgTD3W=yCp7xNaiBqWA@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] trace: add PMU
To: Tomasz Duszynski <tduszynski@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org,
 Ruifeng.Wang@arm.com, 
 bruce.richardson@intel.com, konstantin.v.ananyev@yandex.ru, 
 mattias.ronnblom@ericsson.com, mb@smartsharesystems.com, 
 stephen@networkplumber.org, zhoumin@loongson.cn, wathsala.vithanage@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ge8fUd8nU6yL4v5N4-QolFRpFHDwukYqMoSEjo6dVzM_1762349918
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Fri, 24 Oct 2025 at 07:49, Tomasz Duszynski <tduszynski@marvell.com> wrote:
>
> In order to profile app, one needs to store significant amount of samples
> somewhere for an analysis later on.
> Since trace library supports storing data in a CTF format,
> lets take advantage of that and add a dedicated PMU tracepoint.
>
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>

Two high level comments:
- the lib.pmu.read event has the following format:
event {
    id = 532;
    name = "lib.pmu.read";
    fields := struct {
        uint64_t val;
    };
};

Which means that traces will get PMU event, but without a way to
differentiate between counters that may have been used.
I propose a different tracepoint later in the comments.


- I have doubts on making pmu and tracing configurations intermixed
within a single --trace= option.

The use of indexes based on the cmdline looks fragile.
If an application calls the pmu API directly, won't the commandline
break the indexes of the pmu counters?


More comments on the implementation:

[snip]

> diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guide/profile_app.rst
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

Nit: a simple :doc:`trace_lib` works.

> +
>
>  Profiling on x86
>  ----------------
> diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
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
> @@ -139,6 +140,36 @@ the user must use ``RTE_TRACE_POINT_FP`` instead of ``RTE_TRACE_POINT``.
>  ``RTE_TRACE_POINT_FP`` is compiled out by default and it can be enabled using
>  the ``enable_trace_fp`` option for meson build.
>
> +PMU tracepoint
> +--------------
> +
> +Performance Monitoring Unit (PMU) event values can be read from hardware registers
> +using the predefined ``rte_pmu_read`` tracepoint.
> +
> +Tracing is enabled via ``--trace`` EAL option by passing both expression
> +matching PMU tracepoint name i.e ``lib.eal.pmu.read``
> +and expression ``e=ev1[,ev2,...]`` matching particular events::
> +
> +    --trace='.*pmu.read\|e=cpu_cycles,l1d_cache'
> +
> +Event names are available under ``/sys/bus/event_source/devices/PMU/events`` directory,
> +where ``PMU`` is a placeholder for either a ``cpu`` or a directory containing ``cpus``.
> +
> +In contrary to other tracepoints this does not need any extra variables
> +added to source files.
> +Instead, caller passes index
> +which follows the order of events specified via ``--trace`` parameter.
> +In the following example, index ``0`` corresponds to ``cpu_cyclces``,

Typo: cpu_cycles

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

[snip]

> diff --git a/lib/eal/common/eal_trace_pmu.h b/lib/eal/common/eal_trace_pmu.h
> new file mode 100644
> index 0000000000..27e890edea
> --- /dev/null
> +++ b/lib/eal/common/eal_trace_pmu.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef __EAL_TRACE_PMU_H
> +#define __EAL_TRACE_PMU_H

Nit: no __ prefix.

> +
> +/* PMU wrappers */
> +void trace_pmu_args_apply(const char *arg);
> +void trace_pmu_args_free(void);
> +
> +#endif /* __EAL_TRACE_PMU_H */
> diff --git a/lib/eal/common/meson.build b/lib/eal/common/meson.build
> index e273745e93..463c8f74db 100644
> --- a/lib/eal/common/meson.build
> +++ b/lib/eal/common/meson.build
> @@ -48,6 +48,7 @@ if not is_windows
>              'eal_common_hypervisor.c',
>              'eal_common_proc.c',
>              'eal_common_trace.c',
> +            'eal_common_trace_pmu.c',
>              'eal_common_trace_ctf.c',
>              'eal_common_trace_utils.c',

Nit: alphabetical order.


>              'hotplug_mp.c',
> diff --git a/lib/eal/include/rte_eal_trace.h b/lib/eal/include/rte_eal_trace.h
> index 9ad2112801..e7294b47f6 100644
> --- a/lib/eal/include/rte_eal_trace.h
> +++ b/lib/eal/include/rte_eal_trace.h
> @@ -127,6 +127,29 @@ RTE_TRACE_POINT(
>
>  #define RTE_EAL_TRACE_GENERIC_FUNC rte_eal_trace_generic_func(__func__)
>
> +#ifdef RTE_LIB_PMU
> +#include <rte_debug.h>
> +#include <rte_pmu.h>
> +RTE_TRACE_POINT_FP(
> +       rte_pmu_trace_read,
> +       RTE_TRACE_POINT_ARGS(unsigned int index),
> +       /* Embedded code should only execute in runtime so cut it out during registration in order
> +        * to avoid compilation issues because rte_pmu_trace_read_register(void) does not provide
> +        * any context.
> +        */
> +       RTE_TRACE_POINT_EMBED_CODE(
> +               uint64_t val;
> +#ifdef ALLOW_EXPERIMENTAL_API
> +               val = rte_pmu_read(index);
> +#else
> +               RTE_SET_USED(index);
> +               RTE_VERIFY(false);
> +#endif
> +       )
> +       rte_trace_point_emit_u64(val);
> +)
> +#endif
> +

As I commented earlier, with emitting a single u64, user will have no
clue what this pmu trace was about.

We need at least the pmu counter index in this trace point.

Besides, putting #ifdef in the middle of a call to a macro will break
MSVC, which I fixed with great pain recently.
And RTE_TRACE_POINT_EMBED_CODE will reintroduce issues too, please
don't revert implicitly (issues are not seen in CI probably because
this code is under #ifdef RTE_LIB_PMU).

In the end, the simpler and cleaner is to add a dedicated "emitter" helper.

This means here something like:
RTE_TRACE_POINT_FP(
       rte_pmu_trace_read,
       RTE_TRACE_POINT_ARGS(unsigned int index),
       rte_trace_point_emit_pmu(index);
)

Then in rte_trace_point.h, add a skeletton for doxygen and a "empty"
wrapper for the non ALLOW_EXPERIMENTAL_API block.

And add the new (non register) emitter as something like:

#ifdef RTE_LIB_PMU
#define rte_trace_point_emit_pmu(in) \
do { \
       uint64_t val; \
       __rte_trace_point_emit("index", &in, uint32_t); \
       val = rte_pmu_read(in); \
       __rte_trace_point_emit("val", &val, uint64_t); \
} while(0)
#else
#define rte_trace_point_emit_pmu(in) \
do { \
       RTE_SET_USED(in); \
       RTE_VERIFY(false); \
} while (0)
#endif /* RTE_LIB_PMU */


For the register emitter in rte_trace_point_register.h, add something like:

#define rte_trace_point_emit_pmu(in) \
do { \
        __rte_trace_point_emit_field(sizeof(uint32_t), \
                "index", \
                RTE_STR(uint32_t)); \
        __rte_trace_point_emit_field(sizeof(uint64_t), \
                "val", \
                RTE_STR(uint64_t)); \

>  #ifdef __cplusplus
>  }
>  #endif

[snip]

> diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
> index e4d4f146d1..4bce48c359 100644
> --- a/lib/pmu/pmu.c
> +++ b/lib/pmu/pmu.c
> @@ -4,6 +4,7 @@
>
>  #include <errno.h>
>  #include <ctype.h>
> +#include <regex.h>
>  #include <dirent.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -371,6 +372,7 @@ static void
>  free_event(struct rte_pmu_event *event)
>  {
>         free(event->name);
> +       event->name = NULL;
>         free(event);
>  }
>
> @@ -417,13 +419,77 @@ rte_pmu_add_event(const char *name)
>         return event->index;
>  }
>
> +static int
> +add_events(const char *pattern)
> +{
> +       char *token, *copy, *tmp;
> +       int ret = 0;
> +
> +       copy = strdup(pattern);
> +       if (copy == NULL)
> +               return -ENOMEM;
> +
> +       token = strtok_r(copy, ",", &tmp);
> +       while (token) {
> +               ret = rte_pmu_add_event(token);
> +               if (ret < 0)
> +                       break;
> +
> +               token = strtok_r(NULL, ",", &tmp);
> +       }
> +
> +       free(copy);
> +
> +       return ret >= 0 ? 0 : ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_add_events_by_pattern, 25.11)
> +int
> +rte_pmu_add_events_by_pattern(const char *pattern)
> +{
> +       regmatch_t rmatch;
> +       char buf[BUFSIZ];
> +       unsigned int num;
> +       regex_t reg;
> +       int ret;
> +
> +       /* events are matched against occurrences of e=ev1[,ev2,..] pattern */
> +       ret = regcomp(&reg, "e=([_[:alnum:]-],?)+", REG_EXTENDED);
> +       if (ret) {
> +               PMU_LOG(ERR, "Failed to compile event matching regexp");
> +               return -EINVAL;
> +       }
> +
> +       for (;;) {
> +               if (regexec(&reg, pattern, 1, &rmatch, 0))
> +                       break;
> +
> +               num = rmatch.rm_eo - rmatch.rm_so;
> +               if (num > sizeof(buf))
> +                       num = sizeof(buf);
> +
> +               /* skip e= pattern prefix */
> +               memcpy(buf, pattern + rmatch.rm_so + 2, num - 2);
> +               buf[num - 2] = '\0';
> +               ret = add_events(buf);
> +               if (ret)
> +                       break;
> +
> +               pattern += rmatch.rm_eo;
> +       }
> +
> +       regfree(&reg);
> +
> +       return ret;
> +}
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_init, 25.07)
>  int
>  rte_pmu_init(void)
>  {
>         int ret;
>
> -       if (rte_pmu.initialized)
> +       if (rte_pmu.initialized && ++rte_pmu.initialized)

It seems simpler as:
       if (rte_pmu.initialized++ != 0)

>                 return 0;
>
>         ret = scan_pmus();
> @@ -457,7 +523,7 @@ rte_pmu_fini(void)
>         struct rte_pmu_event_group *group;
>         unsigned int i;
>
> -       if (!rte_pmu.initialized)
> +       if (!rte_pmu.initialized || --rte_pmu.initialized)

       if (--rte_pmu.initialized != 0)


>                 return;
>
>         RTE_TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {


-- 
David Marchand

