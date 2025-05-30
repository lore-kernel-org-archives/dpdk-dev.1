Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180DBC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 12:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F10944025E;
	Fri, 30 May 2025 14:28:56 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id E66074021E
 for <dev@dpdk.org>; Fri, 30 May 2025 14:28:54 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4766cb762b6so21312171cf.0
 for <dev@dpdk.org>; Fri, 30 May 2025 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748608134; x=1749212934; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHBYfGbmUR720Rz4OFbZPwiiWOxoNxsKiMbI1cBDHFM=;
 b=MaE4kb9bq7VTcmKC34n8u8y7pSicfT7My9Wvptt1+zwBogMQqZT6Wn9uAJMv37W7Iz
 aaKi1fcOfTkohxowe9PURMJsoFjZe1mlNCfvR5Sddl/qoCvzg+vHmnKOA8Une2jTGAFH
 t1E20zBO4AP2l7MLWqKE1xrMNAoWAWJ78lzwe2ADf9v+HdxCV6Mn0AqlgtNrvl2Qi+l8
 zpRuXoPJorjzTHQwi31TrwNWM5tJGiHpnxH1jU50pDh+4Ib2lVLZQcixoRl9wnDRM5jL
 8mluSoG1Ebwe/4J2d5MhrXttCdgWMLzLpSpOGOlI9up3aS3HY0W2qr0cWC3QREv/Fiho
 jLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748608134; x=1749212934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHBYfGbmUR720Rz4OFbZPwiiWOxoNxsKiMbI1cBDHFM=;
 b=IG3IlaFQLd+68yNZUjQ22Php4oU173v6ZOHMmGoerhX3YXV2krnVgz0JPXsZblj7n4
 bLQijGqEdUkEeZqs/Bc6zr3G/XzbsPtHSdC/0G0pL1iA7v3WVUYmLqvr6LYnNDds3DHs
 Or0zNU+uVpNWlyQx7PCBWumKh/nDNXJ+fT+GHTCoMTBWt6c9NeTax0nQyeE/FrRCL6lx
 Un7V/aWZblMUfmQFzEX/6WRBovUNPXWRtC69SU+98V/bRlO68KX67bgoHy9vyzRIpkmy
 Oa9iXur95+FrkmOaZc0Qq/IALZSGKs5aiNkUzNvtHz5nFDkZNF6oqGUhWzEzBiBW0WuW
 uzUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5n/w9JFL3c7nUndQS48KH8/YaGSBeW1q8+oxhKIpRUhkniOvDmaWgOWVOscZR5rafiRk=@dpdk.org
X-Gm-Message-State: AOJu0YwUa3kj+PHeo34OlzGhnG8bvh8xhiSupF9jD2O6WwUOgdpu4JxN
 vi4bgyU2A3JVsptiC1bNpFJII76imGJuH9KuAMihoI0CMn44CqEDqFgOFfmHnuWLMDR3p+/oRRv
 gFCUenJsgzD7wOA1uN5lIw7cw7OQ98ZM=
X-Gm-Gg: ASbGncuQQ0H7tSNYxfOM2DFpbbNNP9eF02ZgCcTTkmb+NR0OR3DkQkqIv6os+5EkkgS
 XQMTkhJcS7zwEo06y7+pL9HkLLiWfh5912WVFCmXGj1KP/j1ue7aYRp8bmZ8oTDTop3Rakfhz3/
 YuFaFg5JhZ7i8f1LqM7mgi5230Kt57WMGLI8gYKbGAzw==
X-Google-Smtp-Source: AGHT+IGa3jcDPV4Dv/sT640aE3zYZf/XvtYYfzxm/gn2oDQwmCznbYHonfKsGSJGeFXrhOQRf68QQNYsivJamLkZ91o=
X-Received: by 2002:a05:622a:2b0a:b0:494:6e91:99f0 with SMTP id
 d75a77b69052e-4a432225066mr96631901cf.3.1748608134117; Fri, 30 May 2025
 05:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250410180056.10368-1-pbhagavatula@marvell.com>
 <20250529222437.91818-1-pbhagavatula@marvell.com>
 <20250529222437.91818-2-pbhagavatula@marvell.com>
In-Reply-To: <20250529222437.91818-2-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 30 May 2025 17:58:27 +0530
X-Gm-Features: AX0GCFukfHNs0U-qdJpEgq8GxpsvMgUiGhgUCYxSdN-qXorC_GcGC14qLztO030
Message-ID: <CALBAE1McE+u_bYAKgg3AqF2rQYcXVqaFfvrOyJmaSGEO41v47g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eventdev: introduce event vector adapter
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, abhinandan.gujjar@intel.com, amitprakashs@marvell.com, 
 s.v.naga.harish.k@intel.com, sthotton@marvell.com, pravin.pathak@intel.com,
 hemant.agrawal@nxp.com, sachin.saxena@nxp.com, mattias.ronnblom@ericsson.com, 
 liangma@liangbit.com, peter.mccarthy@intel.com, harry.van.haaren@intel.com, 
 anatoly.burakov@intel.com, erik.g.carrillo@intel.com, 
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
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

On Fri, May 30, 2025 at 3:55=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
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

> +* **Added eventdev vector adapter.**
> +
> +  Added the Event vector Adapter Library. This library extends the event=
-based
> +  model by introducing APIs that allow applications to offload creation =
of
> +  event vectors, thereby reducing the scheduling latency.
> +
> +  Use cases for the Event Vector Adapter include:

# This additional description is not needed in the above line, link to
event adapter programming guide
# In the programing guide and header file description, emphasis on
this feature is when CPU is event producer
# Please below some documentation improvements[1]. Please include it
in the next version.
# Series-Acked-by: Jerin Jacob <jerinj@marvell.com>
# I will merge next version and when HW PMD v1 is ready. HW PMD
version will review separately and merge after rc1.


[1]
diff --git a/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
b/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
index 3a36245266..9126c5d79e 100644
--- a/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
@@ -5,14 +5,10 @@ Event Vector Adapter Library
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

 The Event Vector Adapter library extends the event-driven model by introdu=
cing
-a mechanism to aggregate multiple 8B objects (e.g., mbufs, u64s) into a si=
ngle
-vector event and enqueue it to an event queue, there by reducing the sched=
uling
-latency while preserving the ingress order and offloading vector allocatio=
n and
-aggregation to the vector adapter.
-
-@see struct rte_event_vector::mbufs
-@see struct rte_event_vector::u64s
-@see struct rte_event_vector::ptrs
+a mechanism to aggregate multiple 8B objects
+(e.g. ``rte_event_vector::mbufs``, ``rte_event_vector::u64s``) into a
single vector event
+and enqueue it to an event queue, there by reducing the scheduling
latency while preserving
+the ingress order and offloading vector allocation and aggregation to
the vector adapter.

 The Event Vector Adapter library is designed to interface with hardware or
 software implementations of vector aggregation. It queries an eventdev PMD
@@ -60,12 +56,12 @@ and configure a vector adapter and use it to
manage vector events.

 From a high level, the setup steps are:

-* rte_event_vector_adapter_create()
+* ``rte_event_vector_adapter_create()``

 And to enqueue and manage vectors:

-* rte_event_vector_adapter_enqueue()
-* rte_event_vector_adapter_stats_get()
+* ``rte_event_vector_adapter_enqueue()``
+* ``rte_event_vector_adapter_stats_get()``

 Create and Configure a Vector Adapter
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -204,7 +200,7 @@ Statistics and Cleanup
 ----------------------

 The application can retrieve statistics for the vector adapter using
-``rte_event_vector_adapter_stats_get()``:
+``rte_event_vector_adapter_stats_get()``

 .. code-block:: c

diff --git a/lib/eventdev/rte_event_vector_adapter.h
b/lib/eventdev/rte_event_vector_adapter.h
index 6b69f7ba3e..7ecaf5552b 100644
--- a/lib/eventdev/rte_event_vector_adapter.h
+++ b/lib/eventdev/rte_event_vector_adapter.h
@@ -19,24 +19,15 @@
  *
  *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
  *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=90
- *         =E2=94=82 adapter0 =E2=94=82 =E2=94=82
+ *         =E2=94=82 adapter 0=E2=94=82 =E2=94=82
  *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82
  *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82   =E2=94=8C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
  *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82  Event   =E2=94=82
- *         =E2=94=82 adapter1 =E2=94=82 =E2=94=82   =E2=94=82  Queue0  =E2=
=94=82
+ *         =E2=94=82 adapter 1=E2=94=82 =E2=94=82   =E2=94=82  Queue   =E2=
=94=82
  *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82   =E2=94=94=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
  *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82
  *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=98
- *         =E2=94=82 adapter2 =E2=94=82
- *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

- *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
- *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=90


                        - *         =E2=94=82 adapter0 =E2=94=82 =E2=94=82 =
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90
- *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=9C=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82  Event   =E2=94=82
- *         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82   =E2=94=82  Queue1=
  =E2=94=82
- *         =E2=94=82  Vector  =E2=94=9C=E2=94=80=E2=94=98   =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
- *         =E2=94=82 adapter1 =E2=94=82
+ *         =E2=94=82 adapter n=E2=94=82
  *         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
  *


                          * - A vector adapter can be seen as an
extension to event queue. It helps in
@@ -45,7 +36,7 @@
  *
  * - Multiple vector adapters can be created on an event queue, each with =
its
  *   own unique properties such as event properties, vector size, and time=
out.
- *   Note: If the target event queue doesn't support
RTE_EVENT_QUEUE_CFG_ALL_TYPES,
+ *   Note: If the target event queue doesn't support
#RTE_EVENT_QUEUE_CFG_ALL_TYPES,
  *         then the vector adapter should use the same schedule type
as the event
  *         queue.


                          *
@@ -61,13 +52,13 @@
  *   Note: Application should use the event_type and sub_event_type proper=
ly
  *         identifying the contents of vector event on dequeue.
  *
- * - If the vector adapter advertises the RTE_EVENT_VECTOR_ADAPTER_CAP_SOV=
_EOV
+ * - If the vector adapter advertises the #RTE_EVENT_VECTOR_ADAPTER_CAP_SO=
V_EOV
  *   capability, application can use the RTE_EVENT_VECTOR_ENQ_[S|E]OV flag=
s
  *   to indicate the start and end of a vector event.
- *   * When RTE_EVENT_VECTOR_ENQ_SOV is set, the vector adapter will flush=
 any
+ *   * When #RTE_EVENT_VECTOR_ENQ_SOV is set, the vector adapter will flus=
h any
  *     aggregation in-progress and start aggregating a new vector event wi=
th
  *     the enqueued objects.
- *   * When RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add t=
he
+ *   * When #RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add =
the
  *     objects enqueued to the in-progress aggregation and enqueue the vec=
tor
  *     event to the event queue, even if configured vector size or timeout=
 is
  *     not reached.
@@ -126,14 +117,14 @@ extern "C" {

 #define RTE_EVENT_VECTOR_ENQ_SOV RTE_BIT64(0)
 /**< Indicates the start of a vector event. When enqueue is called with
- *  RTE_EVENT_VECTOR_ENQ_SOV, the vector adapter will flush any vector
+ *  #RTE_EVENT_VECTOR_ENQ_SOV, the vector adapter will flush any vector
  *  aggregation in progress and start aggregating a new vector event with
  *  the enqueued objects.


                          *  @see RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV
  */
 #define RTE_EVENT_VECTOR_ENQ_EOV RTE_BIT64(1)
 /**< Indicates the end of a vector event. When enqueue is called with
- *  RTE_EVENT_VECTOR_ENQ_EOV, the vector adapter will add the objects
+ *  #RTE_EVENT_VECTOR_ENQ_EOV, the vector adapter will add the objects
  *  to any inprogress aggregation and flush the event vector.
  *  @see RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV


+/**
+ * Vector adapter vector structure
+ */
 struct __rte_cache_aligned rte_event_vector_adapter {
        rte_event_vector_adapter_enqueue_t enqueue;
        /**< Pointer to driver enqueue function. */
@@ -259,14 +253,14 @@ typedef int
(*rte_event_vector_adapter_port_conf_cb_t)(uint8_t event_dev_id, uin
  * configuration. The adapter can be used to combine multiple mbufs/ptrs/u=
64s
  * into a single vector event, i.e., rte_event_vector, which is then enque=
ued
  * to the event queue provided.
- * @see rte_event_vector_adapter_conf::ev::event_queue_id.
+ * @see rte_event_vector_adapter_conf::ev::queue_id
  *


                          * @param conf
  *   Configuration for the event vector adapter.
  * @return


                          *   - Pointer to the created event vector
adapter on success.
  *   - NULL on failure with rte_errno set to the error code.
- *     Possible rte_errno values include:
+ * Possible rte_errno values include:
  *    - EINVAL: Invalid event device identifier specified in config.
  *    - ENOMEM: Unable to allocate sufficient memory for adapter instances=
.
  *    - ENOSPC: Maximum number of adapters already created.
@@ -291,8 +285,8 @@ rte_event_vector_adapter_create(const struct
rte_event_vector_adapter_conf *conf
  *   Opaque pointer to the argument for the callback function.
  * @return
  *   - Pointer to the new allocated event vector adapter on success.
- *   - NULL on error with rte_errno set appropriately.
- *   Possible rte_errno values include:
+ *   - NULL on error with rte_errno set appropriately
+ * Possible rte_errno values include:
  *   - ERANGE: vector_timeout_ns is not in supported range.
  *   - ENOMEM: Unable to allocate sufficient memory for adapter instances.
  *   - EINVAL: Invalid event device identifier specified in config.
@@ -407,7 +401,7 @@ rte_event_vector_adapter_stats_get(struct
rte_event_vector_adapter *adapter,
                                   struct
rte_event_vector_adapter_stats *stats);



                         /**
- * @brief Reset the event vector adapter statistics.
+ * Reset the event vector adapter statistics.
  *


                          * This function resets the statistics of the
event vector adapter to their default values.
  *
> +    * Offload CPU event vector creation overhead i.e., vector allocation=
 and
> +      aggregation.
> +    * Splitting existing vectors to classify objects into different even=
t queues
> +      based on their properties.
> +
> +
>
