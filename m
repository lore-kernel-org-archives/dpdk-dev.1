Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF600C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 16:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2057340B95;
	Wed, 28 May 2025 18:58:34 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 9DCCA40E42
 for <dev@dpdk.org>; Wed, 28 May 2025 18:58:32 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so41576141cf.2
 for <dev@dpdk.org>; Wed, 28 May 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748451512; x=1749056312; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIGz1BenoVFfgbdBvqMo6bR2LIzZOQKoQmurYekPA3I=;
 b=NUYFr5AIHxaPCelBPyOq8EtdaMV8kV0H3J7Rm0KmAECpSw102SjezIe87+NHXWilno
 bpXb/kXYzoK0VWPFusvkG9QOocRiOVBoG+kabIxUDtmdAakENzJpqGXrgsVfrj1SR2Qf
 n/iw4VXct5RbAtwpRZDIDTqJYnRDhlH6Ro1haSODntxYrV1DdMU8fiPSQo/KuiuvoeWt
 7qlLec9eEXj4PoJFD1mCCFlcP/hd1xNz/jAQT/+wvIbuS4fLhXwPEDsfAthQbYeV6ArV
 gQTmN01688ri2GXT96ADtKXKKoaHpgQXW8DexjYjscfcfzyP1JxsBcO84V/s9wTYHU7+
 nIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451512; x=1749056312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIGz1BenoVFfgbdBvqMo6bR2LIzZOQKoQmurYekPA3I=;
 b=dpLgemMIL45UuuUCDwPE6N3i/A/FcgYYcpKOCyQGJvBpck+JTGtGRiNbjmbHBZNNmj
 TjxkCMADNnf3hcRG3s1wicZ4JNEjW4TxrC+53jh9csyXbbEhC6GaXw/SfxLQsismfsJD
 LPumAmQybBe7aEEYlY9F0VGCZ1Oz1JPDt5AQhjBuPMin3PfHMTx8TJYq6RE9MU20iNtf
 cXkoROraA/MvCeUX34dgM5dsJjL4igvswcZiKkskxUzhzibZ5T0cMLF4XpuzJLa4K4ET
 AlFI4vBy91CWcyF9Vd7P1nA1mWiw5dH8BGdMRT+LDglnhTLz7DLi3JuycBImTFL7Biw7
 4Ejg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZCgu77ZvReY9s43LzhcpS9FLMAvg2tArLrOmpeJqvZf3VqnaNd4dZ8g8XSAqlUCeHoYc=@dpdk.org
X-Gm-Message-State: AOJu0YyooGGDAJNzImfHAieh5USNHdOCo/QzeT+LmEYAuKsDs12V6nE0
 TfDHiM3BZLPMW73TVX77ZpGmYDPu971kDwSxL/pgj1r20Fw0VMLEvZdkmIlGZqeBjbHYhpOMKak
 SGfY/ld67muaKJ7WsytHtTGItM4xIvvw=
X-Gm-Gg: ASbGncvBQlCFimNCz96iFZbV3otCu7SSGdg4u7VACD8sSGYp/KOvZ4YdfW7ynoGvHEa
 W6Y9JzZdos0DeZmKajzEoR2WBSFRP1Bb30+7RedQsyecjuJE6tidu+Z6g/c364rPO98l3KTJfTI
 yRjFEnKbe38YlrbtCP4cQ7QuEVqtmgwuc=
X-Google-Smtp-Source: AGHT+IGovgBpGFZZQLlH54q/oEL2xqScDUVjICSXKq1/HhF5jvz3PFyiTDaduFXpF4cSpY4esjumGwhJ8vtLMQ74MQI=
X-Received: by 2002:a05:622a:1b1a:b0:476:aa7a:2f78 with SMTP id
 d75a77b69052e-49f48a821c0mr263498181cf.49.1748451511309; Wed, 28 May 2025
 09:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250326131441.5965-2-pbhagavatula@marvell.com>
 <20250410180056.10368-1-pbhagavatula@marvell.com>
 <20250410180056.10368-2-pbhagavatula@marvell.com>
In-Reply-To: <20250410180056.10368-2-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 28 May 2025 22:28:04 +0530
X-Gm-Features: AX0GCFv4v13k5AM-WzrpBUp5ORBRFpbbNnVpIRMOxMcElkeCXe81GVEwjZ2xcsA
Message-ID: <CALBAE1PYBgLuOj=BQ6vX6hVri+f-KoF7VGyuiN07YDhmc+L7Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] eventdev: introduce event vector adapter
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, pravin.pathak@intel.com, hemant.agrawal@nxp.com, 
 sachin.saxena@nxp.com, mattias.ronnblom@ericsson.com, liangma@liangbit.com, 
 peter.mccarthy@intel.com, harry.van.haaren@intel.com, 
 erik.g.carrillo@intel.com, abhinandan.gujjar@intel.com, 
 amitprakashs@marvell.com, s.v.naga.harish.k@intel.com, 
 anatoly.burakov@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 dev@dpdk.org
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

On Fri, Apr 11, 2025 at 12:10=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> The event vector adapter supports offloading creation of
> event vectors by vectorizing objects (mbufs/ptrs/u64s).
> Applications can create a vector adapter associated with
> an event queue and enqueue objects to be vectorized.
> When the vector reaches the configured size or when the timeout
> is reached, the vector adapter will enqueue the vector to the
> event queue.
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
>  config/rte_config.h                           |   1 +
>  doc/api/doxy-api-index.md                     |   1 +
>  doc/guides/eventdevs/features/default.ini     |   7 +
>  .../eventdev/event_vector_adapter.rst         | 208 ++++++++
>  doc/guides/prog_guide/eventdev/eventdev.rst   |  10 +-
>  doc/guides/prog_guide/eventdev/index.rst      |   1 +
>  doc/guides/rel_notes/release_25_07.rst        |   6 +
>  lib/eventdev/event_vector_adapter_pmd.h       |  85 ++++
>  lib/eventdev/eventdev_pmd.h                   |  36 ++
>  lib/eventdev/meson.build                      |   3 +
>  lib/eventdev/rte_event_vector_adapter.c       | 472 +++++++++++++++++
>  lib/eventdev/rte_event_vector_adapter.h       | 481 ++++++++++++++++++


Update MAINTAINER file for new file additions


>  lib/eventdev/rte_eventdev.c                   |  22 +
>  lib/eventdev/rte_eventdev.h                   |  10 +
>  14 files changed, 1338 insertions(+), 5 deletions(-)
>  create mode 100644 doc/guides/prog_guide/eventdev/event_vector_adapter.r=
st
>  create mode 100644 lib/eventdev/event_vector_adapter_pmd.h
>  create mode 100644 lib/eventdev/rte_event_vector_adapter.c
>  create mode 100644 lib/eventdev/rte_event_vector_adapter.h
>
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 86897de75e..9535c48d81 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -92,6 +92,7 @@
>  #define RTE_EVENT_CRYPTO_ADAPTER_MAX_INSTANCE 32
>  #define RTE_EVENT_ETH_TX_ADAPTER_MAX_INSTANCE 32
>  #define RTE_EVENT_DMA_ADAPTER_MAX_INSTANCE 32
> +#define RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE 32
>
>  /* rawdev defines */
>  #define RTE_RAWDEV_MAX_DEVS 64
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index 5c425a2cb9..a11bd59526 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -30,6 +30,7 @@ The public API headers are grouped by topics:
>    [event_timer_adapter](@ref rte_event_timer_adapter.h),
>    [event_crypto_adapter](@ref rte_event_crypto_adapter.h),
>    [event_dma_adapter](@ref rte_event_dma_adapter.h),
> +  [event_vector_adapter](@ref rte_event_vector_adapter.h),
>    [rawdev](@ref rte_rawdev.h),
>    [metrics](@ref rte_metrics.h),
>    [bitrate](@ref rte_bitrate.h),
> diff --git a/doc/guides/eventdevs/features/default.ini b/doc/guides/event=
devs/features/default.ini
> index fa24ba38b4..9fb68f946e 100644
> --- a/doc/guides/eventdevs/features/default.ini
> +++ b/doc/guides/eventdevs/features/default.ini
> @@ -64,3 +64,10 @@ internal_port_vchan_ev_bind =3D
>  [Timer adapter Features]
>  internal_port              =3D
>  periodic                   =3D
> +
> +;
> +; Features of a default Vector adapter
> +;
> +[Vector adapter Features]
> +internal_port              =3D
> +sov_eov                    =3D
> diff --git a/doc/guides/prog_guide/eventdev/event_vector_adapter.rst b/do=
c/guides/prog_guide/eventdev/event_vector_adapter.rst
> new file mode 100644
> index 0000000000..e257552d22
> --- /dev/null
> +++ b/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
> @@ -0,0 +1,208 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright(c) 2025 Marvell International Ltd.
> +
> +Event Vector Adapter Library
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +The Event Vector Adapter library extends the event-driven model by intro=
ducing
> +a mechanism to aggregate multiple 8B objects (e.g., mbufs, u64s) into a =
single

Add link to 8B object structure.

Also, tell the use case for this i.e when and why to use this

> +vector event and enqueue it to an event queue. It provides an API to cre=
ate,
> +configure, and manage vector adapters.
> +
> +The Event Vector Adapter library is designed to interface with hardware =
or
> +software implementations of vector aggregation. It queries an eventdev P=
MD
> +to determine the appropriate implementation.
> +
> +Examples of using the API are presented in the `API Overview`_ and
> +`Processing Vector Events`_ sections.
> +
> +.. _vector_event:
> +
> +Vector Event
> +~~~~~~~~~~~~
> +
> +A vector event is enqueued in the event device when the vector adapter
> +reaches the configured vector size or timeout. The event device uses the
> +attributes configured by the application when scheduling it.
> +
> +Fallback Behavior
> +~~~~~~~~~~~~~~~~~
> +
> +If the vector adapter cannot aggregate objects into a vector event, it
> +enqueues the objects as single events with fallback event properties con=
figured
> +by the application.
> +
> +Timeout and Size
> +~~~~~~~~~~~~~~~~
> +
> +The vector adapter aggregates objects until the configured vector size o=
r
> +timeout is reached. If the timeout is reached before the minimum vector =
size
> +is met, the adapter enqueues the objects as single events with fallback =
event
> +properties configured by the application.
> +
> +API Overview
> +------------
> +
> +This section introduces the Event Vector Adapter API, showing how to cre=
ate
> +and configure a vector adapter and use it to manage vector events.
> +
> +From a high level, the setup steps are:
> +
> +* rte_event_vector_adapter_create()
> +
> +And to enqueue and manage vectors:
> +
> +* rte_event_vector_adapter_enqueue()
> +* rte_event_vector_adapter_stats_get()
> +
> +Create and Configure a Vector Adapter
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To create a vector adapter instance, initialize an ``rte_event_vector_ad=
apter_conf``
> +struct with the desired values, and pass it to ``rte_event_vector_adapte=
r_create()``.
> +
> +.. code-block:: c
> +
> +       const struct rte_event_vector_adapter_conf adapter_config =3D {
> +               .event_dev_id =3D event_dev_id,
> +               .socket_id =3D rte_socket_id(),
> +               .ev =3D {
> +                       .queue_id =3D event_queue_id,
> +                       .sched_type =3D RTE_SCHED_TYPE_ATOMIC,
> +                       .priority =3D RTE_EVENT_DEV_PRIORITY_NORMAL,
> +                       .event_type =3D RTE_EVENT_TYPE_VECTOR | RTE_EVENT=
_TYPE_CPU,
> +               },
> +               .ev_fallback =3D {
> +                       .event_type =3D RTE_EVENT_TYPE_CPU,
> +               },
> +               .vector_sz =3D 64,
> +               .vector_timeout_ns =3D 1000000, // 1ms
> +               .vector_mp =3D vector_mempool,
> +       };
> +
> +       struct rte_event_vector_adapter *adapter;
> +       adapter =3D rte_event_vector_adapter_create(&adapter_config);
> +
> +       if (adapter =3D=3D NULL) { ... }
> +
> +Before creating an instance of a vector adapter, the application should =
create
> +and configure an event device along with its event ports. Based on the e=
vent
> +device's capability, it might require creating an additional event port =
to be
> +used by the vector adapter. If required, the ``rte_event_vector_adapter_=
create()``
> +function will use a default method to configure an event port.
> +
> +If the application desires finer control of event port allocation and se=
tup,
> +it can use the ``rte_event_vector_adapter_create_ext()`` function. This =
function
> +is passed a callback function that will be invoked if the adapter needs =
to
> +create an event port, giving the application the opportunity to control =
how
> +it is done.
> +
> +Retrieve Vector Adapter Contextual Information
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The vector adapter implementation may have constraints on vector size or
> +timeout based on the given event device or system. The application can r=
etrieve
> +these constraints using ``rte_event_vector_adapter_info_get()``. This fu=
nction
> +returns an ``rte_event_vector_adapter_info`` struct, which contains the =
following
> +members:
> +
> +* ``max_vector_adapters_per_event_queue`` - Maximum number of vector ada=
pters
> +  configurable per event queue.
> +* ``min_vector_sz`` - Minimum vector size configurable.
> +* ``max_vector_sz`` - Maximum vector size configurable.
> +* ``min_vector_timeout_ns`` - Minimum vector timeout configurable.
> +* ``max_vector_timeout_ns`` - Maximum vector timeout configurable.
> +* ``log2_sz`` - Vector size should be a power of 2.
> +
> +Enqueuing Objects to the Vector Adapter
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Once a vector adapter has been created, the application can enqueue obje=
cts
> +to it using ``rte_event_vector_adapter_enqueue()``. The adapter will agg=
regate
> +the objects into a vector event based on the configured size and timeout=
.
> +
> +.. code-block:: c
> +
> +       uint64_t objs[32];
> +       uint16_t num_elem =3D 32;
> +       uint64_t flags =3D 0;
> +
> +       int ret =3D rte_event_vector_adapter_enqueue(adapter, objs, num_e=
lem, flags);
> +       if (ret < 0) { ... }
> +
> +The application can use the ``RTE_EVENT_VECTOR_ENQ_SOV`` and ``RTE_EVENT=
_VECTOR_ENQ_EOV``
> +flags to control the start and end of vector aggregation.

Reference the relevant capability flag here. Also, if the capability
is not available mention this as NOP


> +
> +The ``RTE_EVENT_VECTOR_ENQ_SOV`` flag marks the beginning of a vector an=
d applies
> +to the first pointer in the enqueue operation. Any incomplete vectors wi=
ll be
> +enqueued to the event device.
> +
> +The ``RTE_EVENT_VECTOR_ENQ_EOV`` flag marks the end of a vector and appl=
ies to
> +the last pointer in the enqueue operation. The vector is enqueued to the=
 event
> +device even if the configured vector size is not reached.
> +
> +If both flags are set, the adapter will form a new vector event with the=
 given
> +objects and enqueue it to the event device.
> +
> +The ``RTE_EVENT_VECTOR_ENQ_FLUSH`` flag can be used to flush any remaini=
ng
> +objects in the vector adapter. This is useful when the application needs=
 to
> +ensure that all objects are processed, even if the configured vector siz=
e or
> +timeout is not reached. An enqueue call with this flag set will not hand=
le any
> +objects and will return 0.
> +
> +Processing Vector Events
> +------------------------
> +
> +Once a vector event has been enqueued in the event device, the applicati=
on will
> +subsequently dequeue it from the event device. The application can proce=
ss the
> +vector event and its aggregated objects as needed:
> +
> +.. code-block:: c
> +
> +       void
> +       event_processing_loop(...)
> +       {
> +               while (...) {
> +                       /* Receive events from the configured event port.=
 */
> +                       rte_event_dequeue_burst(event_dev_id, event_port,=
 &ev, 1, 0);
> +                       ...
> +                       switch(ev.event_type) {
> +                               ...
> +                               case RTE_EVENT_TYPE_VECTOR:
> +                                       process_vector_event(ev);
> +                                       ...
> +                                       break;
> +                       }
> +               }
> +       }
> +
> +       void
> +       process_vector_event(struct rte_event ev)
> +       {
> +               struct rte_event_vector *vector =3D ev.event_ptr;
> +               for (uint16_t i =3D 0; i < vector->nb_elem; i++) {
> +                       uint64_t obj =3D vector->u64s[i];
> +                       /* Process each object in the vector. */
> +                       ...
> +               }
> +       }
> +
> +Statistics and Cleanup
> +----------------------
> +
> +The application can retrieve statistics for the vector adapter using
> +``rte_event_vector_adapter_stats_get()``:
> +
> +.. code-block:: c
> +
> +       struct rte_event_vector_adapter_stats stats;
> +       rte_event_vector_adapter_stats_get(adapter, &stats);
> +
> +       printf("Vectors created: %" PRIu64 "\n", stats.vectorized);
> +       printf("Timeouts occurred: %" PRIu64 "\n", stats.vectors_timedout=
);
> +
> +To reset the statistics, use ``rte_event_vector_adapter_stats_reset()``.
> +
> +To destroy the vector adapter and release its resources, use
> +``rte_event_vector_adapter_destroy()``. The destroy function will
> +flush any remaining events in the vector adapter before destroying it.
> diff --git a/doc/guides/prog_guide/eventdev/eventdev.rst b/doc/guides/pro=
g_guide/eventdev/eventdev.rst
> index 8bb72da908..5e49db8983 100644
> --- a/doc/guides/prog_guide/eventdev/eventdev.rst
> +++ b/doc/guides/prog_guide/eventdev/eventdev.rst
> @@ -424,8 +424,8 @@ eventdev.
>  .. Note::
>
>           EventDev needs to be started before starting the event producer=
s such
> -         as event_eth_rx_adapter, event_timer_adapter, event_crypto_adap=
ter and
> -         event_dma_adapter.
> +         as event_eth_rx_adapter, event_timer_adapter, event_crypto_adap=
ter,
> +         event_dma_adapter and event_vector_adapter.
>
>  Ingress of New Events
>  ~~~~~~~~~~~~~~~~~~~~~
> @@ -561,9 +561,9 @@ using ``rte_event_dev_stop_flush_callback_register()`=
` function.
>  .. Note::
>
>          The event producers such as ``event_eth_rx_adapter``,
> -        ``event_timer_adapter``, ``event_crypto_adapter`` and
> -        ``event_dma_adapter`` need to be stopped before stopping
> -        the event device.
> +        ``event_timer_adapter``, ``event_crypto_adapter``,
> +        ``event_dma_adapter`` and ``event_vector_adapter``
> +        need to be stopped before stopping the event device.
>
>  Summary
>  -------
> diff --git a/doc/guides/prog_guide/eventdev/index.rst b/doc/guides/prog_g=
uide/eventdev/index.rst
> index 2e1940ce76..af11a57e71 100644
> --- a/doc/guides/prog_guide/eventdev/index.rst
> +++ b/doc/guides/prog_guide/eventdev/index.rst
> @@ -14,3 +14,4 @@ Event Device Library
>      event_crypto_adapter
>      event_dma_adapter
>      dispatcher_lib
> +    event_vector_adapter
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 093b85d206..e6e84eeec6 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,12 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> +* **Added eventdev vector adapter.**
> +
> +  * Added the Event vector Adapter Library. This library extends the eve=
nt-based
> +    model by introducing APIs that allow applications to offload creatio=
n of
> +    event vectors.


Change the description in such a way the end user understands when to
and why to use this library.


> +
>
>  Removed Items
>  -------------
> diff --git a/lib/eventdev/event_vector_adapter_pmd.h b/lib/eventdev/event=
_vector_adapter_pmd.h
> new file mode 100644
> index 0000000000..667363c496
> --- /dev/null
> +++ b/lib/eventdev/event_vector_adapter_pmd.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Marvell International Ltd.
> + * All rights reserved.
> + */
> +#ifndef __EVENT_VECTOR_ADAPTER_PMD_H__
> +#define __EVENT_VECTOR_ADAPTER_PMD_H__
> +/**
> + * @file
> + * RTE Event Vector Adapter API (PMD Side)
> + *
> + * @note
> + * This file provides implementation helpers for internal use by PMDs.  =
They
> + * are not intended to be exposed to applications and are not subject to=
 ABI
> + * versioning.
> + */
> +#include "eventdev_pmd.h"
> +#include "rte_event_vector_adapter.h"
> +
> +typedef int (*rte_event_vector_adapter_create_t)(struct rte_event_vector=
_adapter *adapter);
> +/**< @internal Event vector adapter implementation setup */
> +typedef int (*rte_event_vector_adapter_destroy_t)(struct rte_event_vecto=
r_adapter *adapter);
> +/**< @internal Event vector adapter implementation teardown */
> +typedef int (*rte_event_vector_adapter_stats_get_t)(const struct rte_eve=
nt_vector_adapter *adapter,
> +                                                   struct rte_event_vect=
or_adapter_stats *stats);
> +/**< @internal Get statistics for event vector adapter */
> +typedef int (*rte_event_vector_adapter_stats_reset_t)(
> +       const struct rte_event_vector_adapter *adapter);
> +/**< @internal Reset statistics for event vector adapter */
> +
> +/**
> + * @internal Structure containing the functions exported by an event vec=
tor
> + * adapter implementation.
> + */
> +struct event_vector_adapter_ops {
> +       rte_event_vector_adapter_create_t create;
> +       /**< Set up adapter */
> +       rte_event_vector_adapter_destroy_t destroy;
> +       /**< Tear down adapter */
> +       rte_event_vector_adapter_stats_get_t stats_get;
> +       /**< Get adapter statistics */
> +       rte_event_vector_adapter_stats_reset_t stats_reset;
> +       /**< Reset adapter statistics */
> +
> +       rte_event_vector_adapter_enqueue_t enqueue;
> +       /**< Enqueue objects into the event vector adapter */
> +};
> +/**
> + * @internal Adapter data; structure to be placed in shared memory to be
> + * accessible by various processes in a multi-process configuration.
> + */
> +struct __rte_cache_aligned rte_event_vector_adapter_data {
> +       uint32_t id;
> +       /**< Event vector adapter ID */
> +       uint8_t event_dev_id;
> +       /**< Event device ID */
> +       uint32_t socket_id;
> +       /**< Socket ID where memory is allocated */
> +       uint8_t event_port_id;
> +       /**< Optional: event port ID used when the inbuilt port is absent=
 */
> +       const struct rte_memzone *mz;
> +       /**< Event vector adapter memzone pointer */
> +       struct rte_event_vector_adapter_conf conf;
> +       /**< Configuration used to configure the adapter. */
> +       uint32_t caps;
> +       /**< Adapter capabilities */
> +       void *adapter_priv;
> +       /**< Vector adapter private data*/
> +       uint8_t service_inited;
> +       /**< Service initialization state */
> +       uint32_t unified_service_id;
> +       /**< Unified Service ID*/
> +};
> +
> +static inline int
> +dummy_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, u=
int64_t objs[],
> +                            uint16_t num_events, uint64_t flags)
> +{
> +       RTE_SET_USED(adapter);
> +       RTE_SET_USED(objs);
> +       RTE_SET_USED(num_events);
> +       RTE_SET_USED(flags);
> +       return 0;
> +}
> +
> +#endif /* __EVENT_VECTOR_ADAPTER_PMD_H__ */
> diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
> index ad13ba5b03..d03461316b 100644
> --- a/lib/eventdev/eventdev_pmd.h
> +++ b/lib/eventdev/eventdev_pmd.h
> @@ -26,6 +26,7 @@
>
>  #include "event_timer_adapter_pmd.h"
>  #include "rte_event_eth_rx_adapter.h"
> +#include "rte_event_vector_adapter.h"
>  #include "rte_eventdev.h"
>
>  #ifdef __cplusplus
> @@ -1555,6 +1556,36 @@ typedef int (*eventdev_dma_adapter_stats_get)(cons=
t struct rte_eventdev *dev,
>  typedef int (*eventdev_dma_adapter_stats_reset)(const struct rte_eventde=
v *dev,
>                                                 const int16_t dma_dev_id)=
;
>
> +/**
> + * Event device vector adapter capabilities.
> + *
> + * @param dev
> + *   Event device pointer
> + * @param caps
> + *   Vector adapter capabilities
> + * @param ops
> + *   Vector adapter ops
> + *
> + * @return
> + *   Return 0 on success.
> + *
> + */
> +typedef int (*eventdev_vector_adapter_caps_get_t)(const struct rte_event=
dev *dev, uint32_t *caps,
> +                                                 const struct event_vect=
or_adapter_ops **ops);
> +
> +/**
> + * Event device vector adapter info.
> + *
> + * @param dev
> + *   Event device pointer
> + * @param info
> + *   Vector adapter info
> + *
> + * @return
> + *   Return 0 on success.
> + */
> +typedef int (*eventdev_vector_adapter_info_get_t)(const struct rte_event=
dev *dev,
> +                                                 struct rte_event_vector=
_adapter_info *info);
>
>  /** Event device operations function pointer table */
>  struct eventdev_ops {
> @@ -1697,6 +1728,11 @@ struct eventdev_ops {
>         eventdev_dma_adapter_stats_reset dma_adapter_stats_reset;
>         /**< Reset DMA stats */
>
> +       eventdev_vector_adapter_caps_get_t vector_adapter_caps_get;
> +       /**< Get vector adapter capabilities */
> +       eventdev_vector_adapter_info_get_t vector_adapter_info_get;
> +       /**< Get vector adapter info */
> +
>         eventdev_selftest dev_selftest;
>         /**< Start eventdev Selftest */
>
> diff --git a/lib/eventdev/meson.build b/lib/eventdev/meson.build
> index 71dea91727..0797c145e7 100644
> --- a/lib/eventdev/meson.build
> +++ b/lib/eventdev/meson.build
> @@ -18,6 +18,7 @@ sources =3D files(
>          'rte_event_eth_tx_adapter.c',
>          'rte_event_ring.c',
>          'rte_event_timer_adapter.c',
> +        'rte_event_vector_adapter.c',
>          'rte_eventdev.c',
>  )
>  headers =3D files(
> @@ -27,6 +28,7 @@ headers =3D files(
>          'rte_event_eth_tx_adapter.h',
>          'rte_event_ring.h',
>          'rte_event_timer_adapter.h',
> +        'rte_event_vector_adapter.h',
>          'rte_eventdev.h',
>          'rte_eventdev_trace_fp.h',
>  )
> @@ -38,6 +40,7 @@ driver_sdk_headers +=3D files(
>          'eventdev_pmd_pci.h',
>          'eventdev_pmd_vdev.h',
>          'event_timer_adapter_pmd.h',
> +        'event_vector_adapter_pmd.h',
>  )
>
>  deps +=3D ['ring', 'ethdev', 'hash', 'mempool', 'mbuf', 'timer', 'crypto=
dev', 'dmadev']
> diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_e=
vent_vector_adapter.c
> new file mode 100644
> index 0000000000..ff6bc43b17
> --- /dev/null
> +++ b/lib/eventdev/rte_event_vector_adapter.c
> @@ -0,0 +1,472 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Marvell International Ltd.
> + * All rights reserved.
> + */
> +
> +#include <rte_errno.h>
> +#include <rte_malloc.h>
> +#include <rte_mcslock.h>
> +#include <rte_service_component.h>
> +#include <rte_tailq.h>
> +
> +#include <eal_export.h>
> +
> +#include "event_vector_adapter_pmd.h"
> +#include "eventdev_pmd.h"
> +#include "rte_event_vector_adapter.h"
> +
> +#define ADAPTER_ID(dev_id, queue_id, adapter_id)                        =
                           \
> +       ((uint32_t)dev_id << 16 | (uint32_t)queue_id << 8 | (uint32_t)ada=
pter_id)
> +#define DEV_ID_FROM_ADAPTER_ID(adapter_id)     ((adapter_id >> 16) & 0xF=
F)
> +#define QUEUE_ID_FROM_ADAPTER_ID(adapter_id)   ((adapter_id >> 8) & 0xFF=
)
> +#define ADAPTER_ID_FROM_ADAPTER_ID(adapter_id) (adapter_id & 0xFF)
> +
> +#define MZ_NAME_MAX_LEN            64
> +#define DATA_MZ_NAME_FORMAT "vector_adapter_data_%d_%d_%d"
> +
> +RTE_LOG_REGISTER_SUFFIX(ev_vector_logtype, adapter.vector, NOTICE);
> +#define RTE_LOGTYPE_EVVEC ev_vector_logtype
> +
> +struct rte_event_vector_adapter *adapters[RTE_EVENT_MAX_DEVS][RTE_EVENT_=
MAX_QUEUES_PER_DEV];
> +
> +#define EVVEC_LOG(level, logtype, ...)                                  =
                           \
> +       RTE_LOG_LINE_PREFIX(level, logtype,                              =
                          \
> +                           "EVVEC: %s() line %u: ", __func__ RTE_LOG_COM=
MA __LINE__, __VA_ARGS__)
> +#define EVVEC_LOG_ERR(...) EVVEC_LOG(ERR, EVVEC, __VA_ARGS__)
> +
> +#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
> +#define EVVEC_LOG_DBG(...) EVVEC_LOG(DEBUG, EVVEC, __VA_ARGS__)
> +#else
> +#define EVVEC_LOG_DBG(...) /* No debug logging */
> +#endif
> +
> +#define PTR_VALID_OR_ERR_RET(ptr, retval)                               =
                           \
> +       do {                                                             =
                          \
> +               if (ptr =3D=3D NULL) {                                   =
                              \
> +                       rte_errno =3D EINVAL;                            =
                            \
> +                       return retval;                                   =
                          \
> +               }                                                        =
                          \
> +       } while (0)
> +
> +static int
> +validate_conf(const struct rte_event_vector_adapter_conf *conf,
> +             struct rte_event_vector_adapter_info *info)
> +{
> +       int rc =3D -EINVAL;
> +
> +       RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(conf->event_dev_id, rc);
> +
> +       if (conf->vector_sz < info->min_vector_sz || conf->vector_sz > in=
fo->max_vector_sz) {
> +               EVVEC_LOG_DBG("invalid vector size %u, should be between =
%u and %u",
> +                             conf->vector_sz, info->min_vector_sz, info-=
>max_vector_sz);
> +               return rc;
> +       }
> +
> +       if (conf->vector_timeout_ns < info->min_vector_timeout_ns ||
> +           conf->vector_timeout_ns > info->max_vector_timeout_ns) {
> +               EVVEC_LOG_DBG("invalid vector timeout %" PRIu64 ", should=
 be between %" PRIu64
> +                             " and %" PRIu64,
> +                             conf->vector_timeout_ns, info->min_vector_t=
imeout_ns,
> +                             info->max_vector_timeout_ns);
> +               return rc;
> +       }
> +
> +       if (conf->vector_mp =3D=3D NULL) {
> +               EVVEC_LOG_DBG("invalid mempool for vector adapter");
> +               return rc;
> +       }
> +
> +       if (info->log2_sz && rte_is_power_of_2(conf->vector_sz) !=3D 0) {
> +               EVVEC_LOG_DBG("invalid vector size %u, should be a power =
of 2", conf->vector_sz);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +default_port_conf_cb(uint8_t event_dev_id, uint8_t *event_port_id, void =
*conf_arg)
> +{
> +       struct rte_event_port_conf *port_conf, def_port_conf =3D {0};
> +       struct rte_event_dev_config dev_conf;
> +       struct rte_eventdev *dev;
> +       uint8_t port_id;
> +       uint8_t dev_id;
> +       int started;
> +       int ret;
> +
> +       dev =3D &rte_eventdevs[event_dev_id];
> +       dev_id =3D dev->data->dev_id;
> +       dev_conf =3D dev->data->dev_conf;
> +
> +       started =3D dev->data->dev_started;
> +       if (started)
> +               rte_event_dev_stop(dev_id);
> +
> +       port_id =3D dev_conf.nb_event_ports;
> +       if (conf_arg !=3D NULL)
> +               port_conf =3D conf_arg;
> +       else {
> +               port_conf =3D &def_port_conf;
> +               ret =3D rte_event_port_default_conf_get(dev_id, (port_id =
- 1), port_conf);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       dev_conf.nb_event_ports +=3D 1;
> +       if (port_conf->event_port_cfg & RTE_EVENT_PORT_CFG_SINGLE_LINK)
> +               dev_conf.nb_single_link_event_port_queues +=3D 1;
> +
> +       ret =3D rte_event_dev_configure(dev_id, &dev_conf);
> +       if (ret < 0) {
> +               EVVEC_LOG_ERR("failed to configure event dev %u", dev_id)=
;
> +               if (started)
> +                       if (rte_event_dev_start(dev_id))
> +                               return -EIO;
> +
> +               return ret;
> +       }
> +
> +       ret =3D rte_event_port_setup(dev_id, port_id, port_conf);
> +       if (ret < 0) {
> +               EVVEC_LOG_ERR("failed to setup event port %u on event dev=
 %u", port_id, dev_id);
> +               return ret;
> +       }
> +
> +       *event_port_id =3D port_id;
> +
> +       if (started)
> +               ret =3D rte_event_dev_start(dev_id);
> +
> +       return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create, 25.07)
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_create(const struct rte_event_vector_adapter_co=
nf *conf)
> +{
> +       return rte_event_vector_adapter_create_ext(conf, default_port_con=
f_cb, NULL);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create_ext, 25.0=
7)
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapte=
r_conf *conf,
> +                                   rte_event_vector_adapter_port_conf_cb=
_t conf_cb, void *conf_arg)
> +{
> +       struct rte_event_vector_adapter *adapter =3D NULL;
> +       struct rte_event_vector_adapter_info info;
> +       char mz_name[MZ_NAME_MAX_LEN];
> +       const struct rte_memzone *mz;
> +       struct rte_eventdev *dev;
> +       uint32_t caps;
> +       int i, n, rc;
> +
> +       PTR_VALID_OR_ERR_RET(conf, NULL);
> +
> +       if (adapters[conf->event_dev_id][conf->ev.queue_id] =3D=3D NULL) =
{
> +               adapters[conf->event_dev_id][conf->ev.queue_id] =3D
> +                       rte_zmalloc("rte_event_vector_adapter",
> +                                   sizeof(struct rte_event_vector_adapte=
r) *
> +                                           RTE_EVENT_VECTOR_ADAPTER_MAX_=
INSTANCE_PER_QUEUE,
> +                                   RTE_CACHE_LINE_SIZE);
> +               if (adapters[conf->event_dev_id][conf->ev.queue_id] =3D=
=3D NULL) {
> +                       EVVEC_LOG_DBG("failed to allocate memory for vect=
or adapters");
> +                       rte_errno =3D ENOMEM;
> +                       return NULL;
> +               }
> +       }
> +
> +       for (i =3D 0; i < RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE=
; i++) {
> +               if (adapters[conf->event_dev_id][conf->ev.queue_id][i].us=
ed =3D=3D false) {
> +                       adapter =3D &adapters[conf->event_dev_id][conf->e=
v.queue_id][i];
> +                       adapter->adapter_id =3D ADAPTER_ID(conf->event_de=
v_id, conf->ev.queue_id, i);
> +                       adapter->used =3D true;
> +                       break;
> +               }
> +               EVVEC_LOG_DBG("adapter %u is already in use", i);
> +               rte_errno =3D EEXIST;
> +               return NULL;
> +       }
> +
> +       if (adapter =3D=3D NULL) {
> +               EVVEC_LOG_DBG("no available vector adapters");
> +               rte_errno =3D ENODEV;
> +               return NULL;
> +       }
> +
> +       RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(conf->event_dev_id, NULL);
> +
> +       dev =3D &rte_eventdevs[conf->event_dev_id];
> +       if (dev->dev_ops->vector_adapter_caps_get !=3D NULL &&
> +           dev->dev_ops->vector_adapter_info_get !=3D NULL) {
> +               rc =3D dev->dev_ops->vector_adapter_caps_get(dev, &caps, =
&adapter->ops);
> +               if (rc < 0) {
> +                       EVVEC_LOG_DBG("failed to get vector adapter capab=
ilities rc =3D %d", rc);
> +                       rte_errno =3D ENOTSUP;
> +                       goto error;
> +               }
> +
> +               rc =3D dev->dev_ops->vector_adapter_info_get(dev, &info);
> +               if (rc < 0) {
> +                       adapter->ops =3D NULL;
> +                       EVVEC_LOG_DBG("failed to get vector adapter info =
rc =3D %d", rc);
> +                       rte_errno =3D ENOTSUP;
> +                       goto error;
> +               }
> +       }
> +
> +       if (conf->ev.sched_type !=3D dev->data->queues_cfg[conf->ev.queue=
_id].schedule_type &&
> +           !(dev->data->event_dev_cap & RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPE=
S)) {
> +               EVVEC_LOG_DBG("invalid event schedule type, eventdev does=
n't support all types");
> +               rte_errno =3D EINVAL;
> +               goto error;
> +       }
> +
> +       rc =3D validate_conf(conf, &info);
> +       if (rc < 0) {
> +               adapter->ops =3D NULL;
> +               rte_errno =3D EINVAL;
> +               goto error;
> +       }
> +
> +       n =3D snprintf(mz_name, MZ_NAME_MAX_LEN, DATA_MZ_NAME_FORMAT, con=
f->event_dev_id,
> +                    conf->ev.queue_id, adapter->adapter_id);
> +       if (n >=3D (int)sizeof(mz_name)) {
> +               adapter->ops =3D NULL;
> +               EVVEC_LOG_DBG("failed to create memzone name");
> +               rte_errno =3D EINVAL;
> +               goto error;
> +       }
> +       mz =3D rte_memzone_reserve(mz_name, sizeof(struct rte_event_vecto=
r_adapter_data),
> +                                conf->socket_id, 0);
> +       if (mz =3D=3D NULL) {
> +               adapter->ops =3D NULL;
> +               EVVEC_LOG_DBG("failed to reserve memzone for vector adapt=
er");
> +               rte_errno =3D ENOMEM;
> +               goto error;
> +       }
> +
> +       adapter->data =3D mz->addr;
> +       memset(adapter->data, 0, sizeof(struct rte_event_vector_adapter_d=
ata));
> +
> +       adapter->data->mz =3D mz;
> +       adapter->data->event_dev_id =3D conf->event_dev_id;
> +       adapter->data->id =3D adapter->adapter_id;
> +       adapter->data->socket_id =3D conf->socket_id;
> +       adapter->data->conf =3D *conf;
> +
> +       if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT)) {
> +               if (conf_cb =3D=3D NULL) {
> +                       EVVEC_LOG_DBG("port config callback is NULL");
> +                       rte_errno =3D EINVAL;
> +                       goto error;
> +               }
> +
> +               rc =3D conf_cb(conf->event_dev_id, &adapter->data->event_=
port_id, conf_arg);
> +               if (rc < 0) {
> +                       EVVEC_LOG_DBG("failed to create port for vector a=
dapter");
> +                       rte_errno =3D EINVAL;
> +                       goto error;
> +               }
> +       }
> +
> +       FUNC_PTR_OR_ERR_RET(adapter->ops->create, NULL);
> +
> +       rc =3D adapter->ops->create(adapter);
> +       if (rc < 0) {
> +               adapter->ops =3D NULL;
> +               EVVEC_LOG_DBG("failed to create vector adapter");
> +               rte_errno =3D EINVAL;
> +               goto error;
> +       }
> +
> +       adapter->enqueue =3D adapter->ops->enqueue;
> +
> +       return adapter;
> +
> +error:
> +       adapter->used =3D false;
> +       return NULL;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_lookup, 25.07)
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_lookup(uint32_t adapter_id)
> +{
> +       uint8_t adapter_idx =3D ADAPTER_ID_FROM_ADAPTER_ID(adapter_id);
> +       uint8_t queue_id =3D QUEUE_ID_FROM_ADAPTER_ID(adapter_id);
> +       uint8_t dev_id =3D DEV_ID_FROM_ADAPTER_ID(adapter_id);
> +       struct rte_event_vector_adapter *adapter;
> +       const struct rte_memzone *mz;
> +       char name[MZ_NAME_MAX_LEN];
> +       struct rte_eventdev *dev;
> +       int rc;
> +
> +       if (dev_id >=3D RTE_EVENT_MAX_DEVS || queue_id >=3D RTE_EVENT_MAX=
_QUEUES_PER_DEV ||
> +           adapter_idx >=3D RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QU=
EUE) {
> +               EVVEC_LOG_ERR("invalid adapter id %u", adapter_id);
> +               rte_errno =3D EINVAL;
> +               return NULL;
> +       }
> +
> +       if (adapters[dev_id][queue_id] =3D=3D NULL) {
> +               adapters[dev_id][queue_id] =3D
> +                       rte_zmalloc("rte_event_vector_adapter",
> +                                   sizeof(struct rte_event_vector_adapte=
r) *
> +                                           RTE_EVENT_VECTOR_ADAPTER_MAX_=
INSTANCE_PER_QUEUE,
> +                                   RTE_CACHE_LINE_SIZE);
> +               if (adapters[dev_id][queue_id] =3D=3D NULL) {
> +                       EVVEC_LOG_DBG("failed to allocate memory for vect=
or adapters");
> +                       rte_errno =3D ENOMEM;
> +                       return NULL;
> +               }
> +       }
> +
> +       if (adapters[dev_id][queue_id][adapter_idx].used =3D=3D true)
> +               return &adapters[dev_id][queue_id][adapter_idx];
> +
> +       adapter =3D &adapters[dev_id][queue_id][adapter_idx];
> +
> +       snprintf(name, MZ_NAME_MAX_LEN, DATA_MZ_NAME_FORMAT, dev_id, queu=
e_id, adapter_idx);
> +       mz =3D rte_memzone_lookup(name);
> +       if (mz =3D=3D NULL) {
> +               EVVEC_LOG_DBG("failed to lookup memzone for vector adapte=
r");
> +               rte_errno =3D ENOENT;
> +               return NULL;
> +       }
> +
> +       adapter->data =3D mz->addr;
> +       dev =3D &rte_eventdevs[dev_id];
> +
> +       if (dev->dev_ops->vector_adapter_caps_get !=3D NULL) {
> +               rc =3D dev->dev_ops->vector_adapter_caps_get(dev, &adapte=
r->data->caps,
> +                                                          &adapter->ops)=
;
> +               if (rc < 0) {
> +                       EVVEC_LOG_DBG("failed to get vector adapter capab=
ilities");
> +                       rte_errno =3D ENOTSUP;
> +                       return NULL;
> +               }
> +       }
> +
> +       adapter->enqueue =3D adapter->ops->enqueue;
> +       adapter->adapter_id =3D adapter_id;
> +       adapter->used =3D true;
> +
> +       return adapter;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_service_id_get, =
25.07)
> +int
> +rte_event_vector_adapter_service_id_get(struct rte_event_vector_adapter =
*adapter,
> +                                       uint32_t *service_id)
> +{
> +       PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
> +
> +       if (adapter->data->service_inited && service_id !=3D NULL)
> +               *service_id =3D adapter->data->unified_service_id;
> +
> +       return adapter->data->service_inited ? 0 : -ESRCH;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_destroy, 25.07)
> +int
> +rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapte=
r)
> +{
> +       int rc;
> +
> +       PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
> +       if (adapter->used =3D=3D false) {
> +               EVVEC_LOG_ERR("event vector adapter is not allocated");
> +               return -EINVAL;
> +       }
> +
> +       FUNC_PTR_OR_ERR_RET(adapter->ops->destroy, -ENOTSUP);
> +
> +       rc =3D adapter->ops->destroy(adapter);
> +       if (rc < 0) {
> +               EVVEC_LOG_DBG("failed to destroy vector adapter");
> +               return rc;
> +       }
> +
> +       rte_memzone_free(adapter->data->mz);
> +       adapter->ops =3D NULL;
> +       adapter->enqueue =3D dummy_vector_adapter_enqueue;
> +       adapter->data =3D NULL;
> +       adapter->used =3D false;
> +
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_info_get, 25.07)
> +int
> +rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event=
_vector_adapter_info *info)
> +{
> +       RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(event_dev_id, -EINVAL);
> +       PTR_VALID_OR_ERR_RET(info, -EINVAL);
> +
> +       struct rte_eventdev *dev =3D &rte_eventdevs[event_dev_id];
> +       if (dev->dev_ops->vector_adapter_info_get !=3D NULL)
> +               return dev->dev_ops->vector_adapter_info_get(dev, info);
> +
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_conf_get, 25.07)
> +int
> +rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapt=
er,
> +                                 struct rte_event_vector_adapter_conf *c=
onf)
> +{
> +       PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
> +       PTR_VALID_OR_ERR_RET(conf, -EINVAL);
> +
> +       *conf =3D adapter->data->conf;
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_remaining, 25.07=
)
> +uint8_t
> +rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_q=
ueue_id)
> +{
> +       uint8_t remaining =3D 0;
> +       int i;
> +
> +       RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(event_dev_id, 0);
> +
> +       if (event_queue_id >=3D RTE_EVENT_MAX_QUEUES_PER_DEV)
> +               return 0;
> +
> +       for (i =3D 0; i < RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE=
; i++) {
> +               if (adapters[event_dev_id][event_queue_id][i].used =3D=3D=
 false)
> +                       remaining++;
> +       }
> +
> +       return remaining;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_get, 25.07=
)
> +int
> +rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adap=
ter,
> +                                  struct rte_event_vector_adapter_stats =
*stats)
> +{
> +       PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
> +       PTR_VALID_OR_ERR_RET(stats, -EINVAL);
> +
> +       FUNC_PTR_OR_ERR_RET(adapter->ops->stats_get, -ENOTSUP);
> +
> +       adapter->ops->stats_get(adapter, stats);
> +
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_reset, 25.=
07)
> +int
> +rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *ad=
apter)
> +{
> +       PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
> +
> +       FUNC_PTR_OR_ERR_RET(adapter->ops->stats_reset, -ENOTSUP);
> +
> +       adapter->ops->stats_reset(adapter);
> +
> +       return 0;
> +}
> diff --git a/lib/eventdev/rte_event_vector_adapter.h b/lib/eventdev/rte_e=
vent_vector_adapter.h
> new file mode 100644
> index 0000000000..61680ec307
> --- /dev/null
> +++ b/lib/eventdev/rte_event_vector_adapter.h
> @@ -0,0 +1,481 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Marvell International Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef __RTE_EVENT_VECTOR_ADAPTER_H__
> +#define __RTE_EVENT_VECTOR_ADAPTER_H__
> +
> +/**
> + * @file rte_event_vector_adapter.h
> + *
> + * @warning
> + * @b EXPERIMENTAL:
> + * All functions in this file may be changed or removed without prior no=
tice.
> + *
> + * Event vector adapter API.
> + *
> + * An event vector adapter has the following working model:
> + *
> + *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> + *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=90
> + *         =E2=94=82 adapter0 =E2=94=82 =E2=94=82
> + *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82
> + *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82   =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
> + *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82  Event   =E2=94=82
> + *         =E2=94=82 adapter1 =E2=94=82 =E2=94=82   =E2=94=82  Queue0  =
=E2=94=82
> + *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82   =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
> + *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82
> + *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=98
> + *         =E2=94=82 adapter2 =E2=94=82
> + *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> + *
> + *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> + *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=90
> + *         =E2=94=82 adapter0 =E2=94=82 =E2=94=82   =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90
> + *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=9C=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82  Event   =E2=94=82
> + *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82   =E2=94=82  Que=
ue1  =E2=94=82
> + *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=98   =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
> + *         =E2=94=82 adapter1 =E2=94=82
> + *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> + *
> + * - A vector adapter can be seen as an extension to event queue. It hel=
ps in
> + *   aggregating objects and generating a vector event which is enqueued=
 to the
> + *   event queue.
> + *
> + * - Multiple vector adapters can be created on an event queue, each wit=
h its
> + *   own unique properties such as event properties, vector size, and ti=
meout.
> + *   Note: If the target event queue doesn't support RTE_EVENT_QUEUE_CFG=
_ALL_TYPES,
> + *         then the vector adapter should use the same schedule type as =
the event
> + *         queue.
> + *
> + * - Each vector adapter aggregates 8B objects, generates a vector event=
 and
> + *   enqueues it to the event queue with the event properties mentioned =
in
> + *   rte_event_vector_adapter_conf::ev.
> + *
> + * - After configuring the vector adapter, Application needs to use the
> + *   rte_event_vector_adapter_enqueue() function to enqueue objects i.e.=
,
> + *   mbufs/ptrs/u64s to the vector adapter.
> + *   On reaching the configured vector size or timeout, the vector adapt=
er
> + *   enqueues the event vector to the event queue.
> + *   Note: Application should use the event_type and sub_event_type prop=
erly
> + *         identifying the contents of vector event on dequeue.
> + *
> + * - If the vector adapter advertises the RTE_EVENT_VECTOR_ADAPTER_CAP_S=
OV_EOV
> + *   capability, application can use the RTE_EVENT_VECTOR_ENQ_[S|E]OV fl=
ags
> + *   to indicate the start and end of a vector event.
> + *   * When RTE_EVENT_VECTOR_ENQ_SOV is set, the vector adapter will flu=
sh any
> + *     aggregation in-progress and start aggregating a new vector event =
with
> + *     the enqueued objects.
> + *   * When RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add=
 the
> + *     objects enqueued to the in-progress aggregation and enqueue the v=
ector
> + *     event to the event queue, even if configured vector size or timeo=
ut is
> + *     not reached.
> + *   * If both flags are set, the vector adapter will flush any aggregat=
ion in
> + *     progress and enqueue the objects as a new vector event to the eve=
nt
> + *     queue.
> + *
> + * - If the vector adapter reaches the configured vector size, it will e=
nqueue
> + *   the aggregated vector event to the event queue.
> + *
> + * - If the vector adapter reaches the configured vector timeout, it wil=
l flush
> + *   the aggregated objects as a vector event if the minimum vector size=
 is
> + *   reached, if not it will enqueue the objs as single events to the ev=
ent
> + *   queue.
> + *
> + * - If the vector adapter is unable to aggregate the objs into a vector=
 event,
> + *   it will enqueue the objs as single events to the event queue with t=
he event
> + *   properties mentioned in rte_event_vector_adapter_conf::ev_fallback.
> + *
> + * Before using the vector adapter, the application has to create and co=
nfigure
> + * an event device and based on the event device capability it might req=
uire
> + * creating an additional event port.
> + *
> + * When the application creates the vector adapter using the
> + * ``rte_event_vector_adapter_create()`` function, the event device driv=
er
> + * capabilities are checked. If an in-built port is absent, the applicat=
ion
> + * uses the default function to create a new event port.
> + * For finer control over event port creation, the application should us=
e
> + * the ``rte_event_vector_adapter_create_ext()`` function.
> + *
> + * The application can enqueue one or more objs to the vector adapter us=
ing the
> + * ``rte_event_vector_adapter_enqueue()`` function and control the aggre=
gation
> + * using the flags.
> + *
> + * Vector adapters report stats using the ``rte_event_vector_adapter_sta=
ts_get()``
> + * function and reset the stats using the ``rte_event_vector_adapter_sta=
ts_reset()``.
> + *
> + * The application can destroy the vector adapter using the
> + * ``rte_event_vector_adapter_destroy()`` function.
> + *
> + */
> +
> +#include <rte_eventdev.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV (1ULL << 0)


Use RTE_BIT_UL flavour everywhere in the new code.



> +/**< Vector adapter supports Start of Vector (SOV) and End of Vector (EO=
V) flags
> + *  in the enqueue flags.
> + *
> + * @see RTE_EVENT_VECTOR_ENQ_SOV
> + * @see RTE_EVENT_VECTOR_ENQ_EOV
> + */
> +
> +#define RTE_EVENT_VECTOR_ENQ_SOV   (1ULL << 0)
> +/**< Indicates the start of a vector event. When enqueue is called with
> + *  RTE_EVENT_VECTOR_ENQ_SOV, the vector adapter will flush any vector
> + *  aggregation in progress and start aggregating a new vector event wit=
h
> + *  the enqueued objects.


reference the capablity here

> + */
> +#define RTE_EVENT_VECTOR_ENQ_EOV   (1ULL << 1)
> +/**< Indicates the end of a vector event. When enqueue is called with
> + *  RTE_EVENT_VECTOR_ENQ_EOV, the vector adapter will add the objects
> + *  to any inprogress aggregation and flush the event vector.

reference the capablity here


> + */
> +#define RTE_EVENT_VECTOR_ENQ_FLUSH (1ULL << 2)
> +/**< Flush any in-progress vector aggregation. */
> +
> +/**
> + * Vector adapter configuration structure
> + */
> +struct rte_event_vector_adapter_conf {
> +       uint8_t event_dev_id;
> +       /**< Event device identifier */
> +       uint32_t socket_id;
> +       /**< Identifier of socket from which to allocate memory for adapt=
er */
> +       struct rte_event ev;
> +       /**<
> +        *  The values from the following event fields will be used when
> +        *  queuing work:
> +        *   - queue_id: Targeted event queue ID for vector event.
> +        *   - event_priority: Event priority of the vector event in
> +        *                     the event queue relative to other events.
> +        *   - sched_type: Scheduling type for events from this vector ad=
apter.
> +        *   - event_type: Event type for the vector event.
> +        *   - sub_event_type: Sub event type for the vector event.
> +        *   - flow_id: Flow ID for the vectors enqueued to the event que=
ue by
> +        *              the vector adapter.
> +        */
> +       struct rte_event ev_fallback;
> +       /**<
> +        * The values from the following event fields will be used when
> +        * aggregation fails and single event is enqueued:
> +        *   - event_type: Event type for the single event.
> +        *   - sub_event_type: Sub event type for the single event.
> +        *   - flow_id: Flow ID for the single event.
> +        *
> +        * Other fields are taken from rte_event_vector_adapter_conf::ev.
> +        */
> +       uint16_t vector_sz;
> +       /**<
> +        * Indicates the maximum number for enqueued work to combine and =
form a vector.
> +        * Should be within vectorization limits of the adapter.
> +        * @see rte_event_vector_adapter_info::min_vector_sz
> +        * @see rte_event_vector_adapter_info::max_vector_sz
> +        */
> +       uint64_t vector_timeout_ns;
> +       /**<
> +        * Indicates the maximum number of nanoseconds to wait for receiv=
ing
> +        * work. Should be within vectorization limits of the adapter.
> +        * @see rte_event_vector_adapter_info::min_vector_ns
> +        * @see rte_event_vector_adapter_info::max_vector_ns
> +        */
> +       struct rte_mempool *vector_mp;
> +       /**<
> +        * Indicates the mempool that should be used for allocating
> +        * rte_event_vector container.
> +        * @see rte_event_vector_pool_create
> +        */
> +};
> +
> +/**
> + * Vector adapter vector info structure
> + */
> +struct rte_event_vector_adapter_info {
> +       uint8_t max_vector_adapters_per_event_queue;
> +       /**< Maximum number of vector adapters configurable */
> +       uint16_t min_vector_sz;
> +       /**< Minimum vector size configurable */
> +       uint16_t max_vector_sz;
> +       /**< Maximum vector size configurable */
> +       uint64_t min_vector_timeout_ns;
> +       /**< Minimum vector timeout configurable */
> +       uint64_t max_vector_timeout_ns;
> +       /**< Maximum vector timeout configurable */
> +       uint8_t log2_sz;
> +       /**< True if the size configured should be in log2. */
> +};
> +
> +/**
> + * Vector adapter statistics structure
> + */
> +struct rte_event_vector_adapter_stats {
> +       uint64_t vectorized;
> +       /**< Number of events vectorized */
> +       uint64_t vectors_timedout;
> +       /**< Number of timeouts occurred */
> +       uint64_t vectors_flushed;
> +       /**< Number of vectors flushed */
> +       uint64_t alloc_failures;
> +       /**< Number of vector allocation failures */
> +};
> +
> +struct rte_event_vector_adapter;
> +
> +typedef int (*rte_event_vector_adapter_enqueue_t)(struct rte_event_vecto=
r_adapter *adapter,
> +                                                 uint64_t objs[], uint16=
_t num_elem,
> +                                                 uint64_t flags);
> +/**< @internal Enqueue objs into the event vector adapter. */
> +
> +struct __rte_cache_aligned rte_event_vector_adapter {
> +       rte_event_vector_adapter_enqueue_t enqueue;
> +       /**< Pointer to driver enqueue function. */
> +       struct rte_event_vector_adapter_data *data;
> +       /**< Pointer to the adapter data */
> +       const struct event_vector_adapter_ops *ops;
> +       /**< Functions exported by adapter driver */
> +
> +       uint32_t adapter_id;
> +       /**< Identifier of the adapter instance. */
> +       uint8_t used : 1;
> +       /**< Flag to indicate that this adapter is being used. */
> +};
> +
> +/**
> + * Callback function type for producer port creation.
> + */
> +typedef int (*rte_event_vector_adapter_port_conf_cb_t)(uint8_t event_dev=
_id, uint8_t *event_port_id,
> +                                                      void *conf_arg);
> +
> +/**
> + * Create an event vector adapter.
> + *
> + * This function creates an event vector adapter based on the provided
> + * configuration. The adapter can be used to combine multiple mbufs/ptrs=
/u64s
> + * into a single vector event, i.e., rte_event_vector, which is then enq=
ueued
> + * to the event queue provided.
> + * @see rte_event_vector_adapter_conf::ev::event_queue_id.
> + *
> + * @param conf
> + *   Configuration for the event vector adapter.
> + * @return
> + *   - Pointer to the created event vector adapter on success.
> + *   - NULL on failure with rte_errno set to the error code.
> + *     Possible rte_errno values include:
> + *    - EINVAL: Invalid event device identifier specified in config.
> + *    - ENOMEM: Unable to allocate sufficient memory for adapter instanc=
es.
> + *    - ENOSPC: Maximum number of adapters already created.
> + */
> +__rte_experimental
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_create(const struct rte_event_vector_adapter_co=
nf *conf);
> +
> +/**
> + * Create an event vector adapter with the supplied callback.
> + *
> + * This function can be used to have a more granular control over the ev=
ent
> + * vector adapter creation. If a built-in port is absent, then the funct=
ion uses
> + * the callback provided to create and get the port id to be used as a p=
roducer
> + * port.
> + *
> + * @param conf
> + *   The event vector adapter configuration structure.
> + * @param conf_cb
> + *   The port config callback function.
> + * @param conf_arg
> + *   Opaque pointer to the argument for the callback function.
> + * @return
> + *   - Pointer to the new allocated event vector adapter on success.
> + *   - NULL on error with rte_errno set appropriately.
> + *   Possible rte_errno values include:
> + *   - ERANGE: vector_timeout_ns is not in supported range.
> + *   - ENOMEM: Unable to allocate sufficient memory for adapter instance=
s.
> + *   - EINVAL: Invalid event device identifier specified in config.
> + *   - ENOSPC: Maximum number of adapters already created.
> + */
> +__rte_experimental
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapte=
r_conf *conf,
> +                                   rte_event_vector_adapter_port_conf_cb=
_t conf_cb,
> +                                   void *conf_arg);
> +
> +/**
> + * Lookup an event vector adapter using its identifier.
> + *
> + * This function returns the event vector adapter based on the adapter_i=
d.
> + * This is useful when the adapter is created in another process and the
> + * application wants to use the adapter in the current process.
> + *
> + * @param adapter_id
> + *   Identifier of the event vector adapter to look up.
> + * @return
> + *   - Pointer to the event vector adapter on success.
> + *   - NULL if the adapter is not found.
> + */
> +__rte_experimental
> +struct rte_event_vector_adapter *
> +rte_event_vector_adapter_lookup(uint32_t adapter_id);
> +
> +/**
> + * Destroy an event vector adapter.
> + *
> + * This function releases the resources associated with the event vector=
 adapter.
> + *
> + * @param adapter
> + *   Pointer to the event vector adapter to be destroyed.
> + * @return
> + *   - 0 on success.
> + *   - Negative value on failure with rte_errno set to the error code.
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapte=
r);
> +
> +/**
> + * Get the vector info of an event vector adapter.
> + *
> + * This function retrieves the vector info of the event vector adapter.
> + *
> + * @param event_dev_id
> + *   Event device identifier.
> + * @param info
> + *   Pointer to the structure where the vector info will be stored.
> + * @return
> + *   0 on success, negative value on failure.
> + *   - EINVAL if the event device identifier is invalid.
> + *   - ENOTSUP if the event device does not support vector adapters.
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_info_get(uint8_t event_dev_id,
> +                                 struct rte_event_vector_adapter_info *i=
nfo);
> +
> +/**
> + * Get the configuration of an event vector adapter.
> + *
> + * This function retrieves the configuration of the event vector adapter=
.
> + *
> + * @param adapter
> + *   Pointer to the event vector adapter.
> + * @param conf
> + *   Pointer to the structure where the configuration will be stored.
> + * @return
> + *   0 on success, negative value on failure.
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapt=
er,
> +                                 struct rte_event_vector_adapter_conf *c=
onf);
> +
> +/**
> + * Get the remaining event vector adapters.
> + *
> + * This function retrieves the number of remaining event vector adapters
> + * available for a given event device and event queue.
> + *
> + * @param event_dev_id
> + *   Event device identifier.
> + * @param event_queue_id
> + *   Event queue identifier.
> + * @return
> + *   Number of remaining slots available for enqueuing events.
> + */
> +__rte_experimental
> +uint8_t
> +rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_q=
ueue_id);
> +
> +/**
> + * Get the event vector adapter statistics.
> + *
> + * This function retrieves the statistics of the event vector adapter.
> + *
> + * @param adapter
> + *   Pointer to the event vector adapter.
> + * @param stats
> + *   Pointer to the structure where the statistics will be stored.
> + * @return
> + *   0 on success, negative value on failure.
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adap=
ter,
> +                                  struct rte_event_vector_adapter_stats =
*stats);
> +
> +/**
> + * @brief Reset the event vector adapter statistics.
> + *
> + * This function resets the statistics of the event vector adapter to th=
eir default values.
> + *
> + * @param adapter
> + *   Pointer to the event vector adapter whose statistics are to be rese=
t.
> + * @return
> + *   0 on success, negative value on failure.
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *ad=
apter);
> +
> +/**
> + * Retrieve the service ID of the event vector adapter. If the adapter d=
oesn't
> + * use an rte_service function, this function returns -ESRCH.
> + *
> + * @param adapter
> + *   A pointer to an event vector adapter.
> + * @param [out] service_id
> + *   A pointer to a uint32_t, to be filled in with the service id.
> + *
> + * @return
> + *   - 0: Success
> + *   - <0: Error code on failure
> + *   - -ESRCH: the adapter does not require a service to operate
> + */
> +__rte_experimental
> +int
> +rte_event_vector_adapter_service_id_get(struct rte_event_vector_adapter =
*adapter,
> +                                       uint32_t *service_id);
> +
> +/**
> + * Enqueue objs into the event vector adapter.
> + *
> + * This function enqueues a specified number of objs into the event vect=
or adapter.
> + * The objs are combined into a single vector event, i.e., rte_event_vec=
tor, which
> + * is then enqueued to the event queue configured in the adapter.
> + *
> + * @param adapter
> + *   Pointer to the event vector adapter.
> + * @param objs
> + *   Array of objs to be enqueued.
> + * @param num_elem
> + *   Number of objs to be enqueued.
> + * @param flags
> + *   Flags to be used for the enqueue operation.
> + * @return
> + *   Number of objs enqueued on success.
> + */
> +__rte_experimental
> +static inline int
> +rte_event_vector_adapter_enqueue(struct rte_event_vector_adapter *adapte=
r, uint64_t objs[],
> +                                uint16_t num_elem, uint64_t flags)
> +{
> +#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
> +       if (adapter =3D=3D NULL) {
> +               rte_errno =3D EINVAL;
> +               return 0;
> +       }
> +
> +       if (adapter->used =3D=3D false) {
> +               rte_errno =3D EINVAL;
> +               return 0;
> +       }
> +#endif
> +       return adapter->enqueue(adapter, objs, num_elem, flags);
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __RTE_EVENT_VECTOR_ADAPTER_H__ */
> diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
> index b66cbb4676..916bad6c2c 100644
> --- a/lib/eventdev/rte_eventdev.c
> +++ b/lib/eventdev/rte_eventdev.c
> @@ -257,6 +257,28 @@ rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8=
_t dma_dev_id, uint32_t *cap
>         return 0;
>  }
>
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_caps_get, 25.07)
> +int
> +rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
> +{
> +       const struct event_vector_adapter_ops *ops;
> +       struct rte_eventdev *dev;
> +
> +       RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
> +
> +       dev =3D &rte_eventdevs[dev_id];
> +
> +       if (caps =3D=3D NULL)
> +               return -EINVAL;
> +
> +       if (dev->dev_ops->vector_adapter_caps_get =3D=3D NULL)
> +               *caps =3D 0;
> +
> +       return dev->dev_ops->vector_adapter_caps_get ?
> +                      dev->dev_ops->vector_adapter_caps_get(dev, caps, &=
ops) :
> +                      0;
> +}
> +
>  static inline int
>  event_dev_queue_config(struct rte_eventdev *dev, uint8_t nb_queues)
>  {
> diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
> index 6400d6109f..3c7fcbf0be 100644
> --- a/lib/eventdev/rte_eventdev.h
> +++ b/lib/eventdev/rte_eventdev.h
> @@ -1985,6 +1985,16 @@ int
>  rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
>                                 uint32_t *caps);
>
> +/* Vector adapter capability bitmap flags */
> +#define RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT     0x1
> +/**< This flag is set when the vector adapter is capable of generating e=
vents
> + * using an internal event port.
> + */
> +
> +__rte_experimental
> +int
> +rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps);
> +
>  /**
>   * Converts nanoseconds to *timeout_ticks* value for rte_event_dequeue_b=
urst()
>   *
> --
> 2.43.0
>
