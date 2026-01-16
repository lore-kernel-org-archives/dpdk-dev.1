Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD9C98302
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 22:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74FD342E48;
	Fri, 16 Jan 2026 23:06:26 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 6EBCD427A0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 23:06:24 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so21522575e9.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768601184;
 x=1769205984; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=511WIPaHoRBEKhl9ipgp4M7MgJq+r1Eka6EKOAU/duw=;
 b=P5AVagdfv3QHqdKBJRbVQ3tBerY2br1WfG02RridjwCfow89jbyrQQrt3jtk28w58d
 AjrGlLKRpP1q7hj3dNCt9NlIkeRhRJKvo/0yX3h3/57o1HX9mr7odAX4cxoRsLZdAmr8
 Q4x6RhGmrnzlRG31iQw752NU7FoVmfeBMSxsIvJ3cfWBGlZDkgL/NzFUT86+Iy1M8hja
 HI+EO8wJkI53sj2E1X6Bq41VpaNsVIlu8HFAbBY4GYQFkJxP6EdsbCYKHjI1EKCpk0P4
 G9AAHOTqX+haxVkgw8DYuewj5PrsmHvl5xMfOwg8XajoWJKveDX56jUcFayy6q9BkfwV
 Ki0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601184; x=1769205984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=511WIPaHoRBEKhl9ipgp4M7MgJq+r1Eka6EKOAU/duw=;
 b=EMlxcW1JFdUT//9cz2GTgEfzBCrNQSl703qSuO4rLer7dydKm2YB35szElu8E/LrwF
 o+uYVtl2YuJNS1pQyQfHK75DhB5hopDf8XwxBMW+9BdWUKeE6r3boxPHwQ5lcK70OZ5n
 n83fFtgTnRma0LrwzhJrP8UZnAxqd/kD0unT+KjD6ZEXY8pyHhsNGbfvEMD/bF8RHnX8
 gTBMLB7bTmzXFlW4AZEs8G9rOhb/NI35V+XBXgZgWnDXwlDHTjRf1J3jn/qneQkjPek0
 FAvJLge4ELIupLO46dC4/jtiUPahKNwUMTLHaGVZYa0e96Dj0Y5yhddLGYJpiJ8O5HPy
 HNfA==
X-Gm-Message-State: AOJu0Ywz51/CyLPjnWUGpiV9Wo/yfiMah6URSF8BJDQVQmwCssxm+rBq
 DMno/KZlEhdrJQ/DbnJXxkQ+BhFGr5pNq2D2ZLt+CMBD4XaRoyrRod84Qqd1l3CGdKBvX+Brmq9
 rKWrm
X-Gm-Gg: AY/fxX5xUa5Qu0GeVJ/ZXyk2EkUndfLZTGbwbD9Timwt5ysoYxG5XfVNnDk5lN96Mog
 Z7BdB6kE4NIT33goy+Rmh6Us6FIt8Ic0YwuzObcQqor7vMLWX8OShW7idw8IgMeDT+xdaFSl8b7
 jy+mXm4nGIWb+vpmS1mG0j8WfGQbvjWjgbPfLnZCKQ3aXGfldFiXWDSGT2AW8t/YraH8a3q/Phr
 czKhTVVvLNeCRx6gfCBiYlmeiNwuwPol99GmwzSxy5CAF7ep795PnOZP5VEuHgkTnshbimVZk6O
 GYq8X5nw1nI/2IS7pqFZY/eKjiG0Fi3qsW3LJPluSym7jofZXUMxffQey0Eo45PL1jqQ51CA9JJ
 wxUr1lBP5oq5mrkpKCPkFO7GkfjhbuCBFqnM22yhiNGC+h8ozoaKpl8J2MhoBTKTs/Q0rlThpR7
 QUZ06huH9qnV/9QQJ+NDK6Zjddg3rWLA3jm3fjDYQUleUym8GbXhJdAaIgwqdM
X-Received: by 2002:a05:600c:3b8e:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-4801e2fe362mr52282125e9.13.1768601183774; 
 Fri, 16 Jan 2026 14:06:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acae8sm117985185e9.4.2026.01.16.14.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 14:06:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH] doc/eventdev: correct grammar and style issues
Date: Fri, 16 Jan 2026 14:05:40 -0800
Message-ID: <20260116220617.116295-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Use AI review to find and address various documentation issues
in the eventdev programmer's guide:

Grammar
- Fix subject-verb agreement in multiple places
- Fix article usage ("a" vs "an" before consonant/vowel sounds)
- Fix relative pronoun usage ("which" vs "that")
- Replace nonstandard verb "invocated" with "invoked"

Spelling
- Fix "setup up" to "set up"
- Fix "as show below" to "as shown below" (multiple files)
- Fix "rte mbuf" to "rte_mbuf"
- Fix "rte_mbufs" to "rte_mbuf"
- Fix missing backtick in RST markup

Style
- Capitalize "api" to "API"
- Replace informal "For e.g," with "For example,"
- Remove extra whitespace
- Fix "benefit of" to "benefit from"
- Clarify awkward phrasing

Code example
- Fix invalid switch syntax "case default:" to "default:"

Path corrections
- Update outdated library path from libs/librte_eventdev to lib/eventdev

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../prog_guide/eventdev/dispatcher_lib.rst    | 10 ++++-----
 .../eventdev/event_crypto_adapter.rst         |  8 +++----
 .../prog_guide/eventdev/event_dma_adapter.rst |  4 ++--
 .../eventdev/event_ethernet_rx_adapter.rst    | 18 +++++++--------
 .../eventdev/event_ethernet_tx_adapter.rst    |  4 ++--
 doc/guides/prog_guide/eventdev/eventdev.rst   | 22 +++++++++----------
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/doc/guides/prog_guide/eventdev/dispatcher_lib.rst b/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
index e8d645d474..262343d1bf 100644
--- a/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
+++ b/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
@@ -191,7 +191,7 @@ The event handler interface consists of two function pointers:
 
 An event handler registration is valid on all lcores.
 
-The functions pointed to by the match and process callbacks resides in
+The functions pointed to by the match and process callbacks reside in
 the application's domain logic, with one or more handlers per
 application module.
 
@@ -215,7 +215,7 @@ An event is routed to no more than one handler. Thus, if a match
 function returns true, no further match functions will be invoked for
 that event.
 
-Match functions must not depend on being invocated in any particular
+Match functions must not depend on being invoked in any particular
 order (e.g., in the handler registration order).
 
 Events failing to match any handler are dropped, and the
@@ -224,15 +224,15 @@ Events failing to match any handler are dropped, and the
 Event Delivery
 ^^^^^^^^^^^^^^
 
-The handler callbacks are invocated by the dispatcher's service
+The handler callbacks are invoked by the dispatcher's service
 function, upon the arrival of events to the event ports bound to the
 running service lcore.
 
 A particular event is delivered to at most one handler.
 
 The application must not depend on all match callback invocations for
-a particular event batch being made prior to any process calls are
-being made. For example, if the dispatcher dequeues two events from
+a particular event batch being made before any process calls are
+made. For example, if the dispatcher dequeues two events from
 the event device, it may choose to find out the destination for the
 first event, and deliver it, and then continue to find out the
 destination for the second, and then deliver that event as well. The
diff --git a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
index e2481904b1..bf449bcf52 100644
--- a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
@@ -7,8 +7,8 @@ Event Crypto Adapter Library
 The DPDK :doc:`Eventdev library <eventdev>` provides event driven
 programming model with features to schedule events.
 The :doc:`../cryptodev_lib` provides an interface to
-the crypto poll mode drivers which supports different crypto operations.
-The Event Crypto Adapter is one of the adapter which is intended to
+the crypto poll mode drivers that support different crypto operations.
+The Event Crypto Adapter is one of the adapters that is intended to
 bridge between the event device and the crypto device.
 
 The packet flow from crypto device to the event device can be accomplished
@@ -115,7 +115,7 @@ Adapter can be started in ``RTE_EVENT_CRYPTO_ADAPTER_OP_NEW`` or
 
 If the application desires to have finer control of eventdev port allocation
 and setup, it can use the ``rte_event_crypto_adapter_create_ext()`` function.
-The ``rte_event_crypto_adapter_create_ext()`` function is passed as a callback
+The ``rte_event_crypto_adapter_create_ext()`` function is passed a callback
 function. The callback function is invoked if the adapter needs to use a
 service function and needs to create an event port for it. The callback is
 expected to fill the ``struct rte_event_crypto_adapter_conf`` structure
@@ -229,7 +229,7 @@ Configure the service function
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the adapter uses a service function, the application is required to assign
-a service core to the service function as show below.
+a service core to the service function as shown below.
 
 .. code-block:: c
 
diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
index e8437a3297..6339dddc2b 100644
--- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
@@ -36,7 +36,7 @@ RTE_EVENT_DMA_ADAPTER_OP_NEW mode
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In the ``RTE_EVENT_DMA_ADAPTER_OP_NEW`` mode,
-application submits DMA operations directly to an DMA device.
+application submits DMA operations directly to a DMA device.
 The adapter then dequeues DMA completions from the DMA device
 and enqueues them as events to the event device.
 This mode does not ensure ingress ordering
@@ -230,7 +230,7 @@ Configuring service function
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the adapter uses a service function, the application is required
-to assign a service core to the service function as show below.
+to assign a service core to the service function as shown below.
 
 .. code-block:: c
 
diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
index 1f497d2540..c7fb15d10d 100644
--- a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
@@ -63,7 +63,7 @@ expected to fill the ``struct rte_event_eth_rx_adapter_conf structure``
 passed to it.
 
 If the application desires to control the event buffer size at adapter level,
-it can use the ``rte_event_eth_rx_adapter_create_with_params()`` api. The event
+it can use the ``rte_event_eth_rx_adapter_create_with_params()`` API. The event
 buffer size is specified using ``struct rte_event_eth_rx_adapter_params::
 event_buf_size``. To configure the event buffer size at queue level, the boolean
 flag ``struct rte_event_eth_rx_adapter_params::use_queue_event_buf`` need to be
@@ -170,7 +170,7 @@ Querying Adapter Capabilities
 
 The ``rte_event_eth_rx_adapter_caps_get()`` function allows
 the application to query the adapter capabilities for an eventdev and ethdev
-combination. For e.g, if the ``RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID``
+combination. For example, if the ``RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID``
 is set, the application can override the adapter generated flow ID in the event
 using ``rx_queue_flags`` field in ``struct rte_event_eth_rx_adapter_queue_conf``
 which is passed as a parameter to the ``rte_event_eth_rx_adapter_queue_add()``
@@ -191,7 +191,7 @@ Configuring the Service Function
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the adapter uses a service function, the application is required to assign
-a service core to the service function as show below.
+a service core to the service function as shown below.
 
 .. code-block:: c
 
@@ -216,7 +216,7 @@ service function if one exists.
 Getting Adapter Statistics
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The  ``rte_event_eth_rx_adapter_stats_get()`` function reports counters defined
+The ``rte_event_eth_rx_adapter_stats_get()`` function reports counters defined
 in struct ``rte_event_eth_rx_adapter_stats``. The received packet and
 enqueued event counts are a sum of the counts from the eventdev PMD callbacks
 if the callback is supported, and the counts maintained by the service function,
@@ -248,7 +248,7 @@ adapter queue counters defined in struct ``rte_event_eth_rx_adapter_queue_stats`
 This function reports queue level stats only when queue level event buffer is
 used otherwise it returns -EINVAL.
 
-The ``rte_event_eth_rx_adapter_queue_stats_reset`` function can be used to
+The ``rte_event_eth_rx_adapter_queue_stats_reset()`` function can be used to
 reset queue level stats when queue level event buffer is in use.
 
 Getting Adapter Instance ID
@@ -294,7 +294,7 @@ monitor the buffer fill level and instruct the service function to selectively
 enqueue packets to the event device. The application may also use some other
 criteria to decide which packets should enter the event device even when
 the event buffer fill level is low. The
-``rte_event_eth_rx_adapter_cb_register()`` function allow the application
+``rte_event_eth_rx_adapter_cb_register()`` function allows the application
 to register a callback that selects which packets to enqueue to the event
 device.
 
@@ -330,14 +330,14 @@ A loop processing ``rte_event_vector`` containing mbufs is shown below.
         switch (ev.event_type) {
         case RTE_EVENT_TYPE_ETH_RX_ADAPTER_VECTOR:
         case RTE_EVENT_TYPE_ETHDEV_VECTOR:
-                struct rte_mbufs **mbufs;
+        struct rte_mbuf **mbufs;
 
-                mbufs = (struct rte_mbufs **)ev[i].vec->mbufs;
+                mbufs = (struct rte_mbuf **)ev[i].vec->mbufs;
                 for (i = 0; i < ev.vec->nb_elem; i++) {
                         /* Process each mbuf. */
                 }
         break;
-        case default:
+        default:
                 /* Handle other event_types. */
         }
 
diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst b/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
index 59f9d9d54c..79727c0e8a 100644
--- a/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
@@ -137,7 +137,7 @@ Enqueuing Packets to the Adapter
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The application needs to notify the adapter about the transmit port and queue used
-to send the packet. The transmit port is set in the ``struct rte mbuf::port`` field
+to send the packet. The transmit port is set in the ``struct rte_mbuf::port`` field
 and the transmit queue is set using the ``rte_event_eth_tx_adapter_txq_set()``
 function.
 
@@ -196,7 +196,7 @@ The event device, ethernet device pairs which support the capability
 ``RTE_EVENT_ETH_TX_ADAPTER_CAP_EVENT_VECTOR`` can process event vector of mbufs.
 Additionally, application can provide a hint to the Tx adapter that all the
 mbufs are destined to the same ethernet port and queue by setting the bit
-``rte_event_vector::attr_valid`` and filling `rte_event_vector::port`` and
+``rte_event_vector::attr_valid`` and filling ``rte_event_vector::port`` and
 ``rte_event_vector::queue``.
 If ``rte_event_vector::attr_valid`` is not set then the Tx adapter should peek
 into each mbuf and transmit them to the requested ethernet port and queue pair.
diff --git a/doc/guides/prog_guide/eventdev/eventdev.rst b/doc/guides/prog_guide/eventdev/eventdev.rst
index 5e49db8983..9ec566925c 100644
--- a/doc/guides/prog_guide/eventdev/eventdev.rst
+++ b/doc/guides/prog_guide/eventdev/eventdev.rst
@@ -24,7 +24,7 @@ and event driven programming models for packet processing, and applications are
 free to choose whatever model (or combination of the two) best suits their
 needs.
 
-Step-by-step instructions of the eventdev design is available in the `API
+Step-by-step instructions of the eventdev design are available in the `API
 Walk-through`_ section later in this document.
 
 Event struct
@@ -33,7 +33,7 @@ Event struct
 The eventdev API represents each event with a generic struct, which contains a
 payload and metadata required for scheduling by an eventdev.  The
 ``rte_event`` struct is a 16 byte C structure, defined in
-``libs/librte_eventdev/rte_eventdev.h``.
+``lib/eventdev/rte_eventdev.h``.
 
 Event Metadata
 ~~~~~~~~~~~~~~
@@ -67,8 +67,8 @@ the actual event being scheduled is. The payload is a union of the following:
 
 These four items in a union occupy the same 64 bits at the end of the rte_event
 structure. The application can utilize the 64 bits directly by accessing the
-u64 variable, while the event_ptr, mbuf, vec are provided as a convenience
-variables.  For example the mbuf pointer in the union can used to schedule a
+u64 variable, while the event_ptr, mbuf, vec are provided as convenience
+variables.  For example, the mbuf pointer in the union can be used to schedule a
 DPDK packet.
 
 Event Vector
@@ -320,8 +320,8 @@ can be achieved like this:
 Linking Queues to Ports with link profiles
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-An application can use link profiles if supported by the underlying event device to setup up
-multiple link profile per port and change them run time depending up on heuristic data.
+An application can use link profiles if supported by the underlying event device to set up
+multiple link profiles per port and change them at runtime depending on heuristic data.
 Using Link profiles can reduce the overhead of linking/unlinking and wait for unlinks in progress
 in fast-path and gives applications the ability to switch between preset profiles on the fly.
 
@@ -397,11 +397,11 @@ it will be treated as a no-op.
    // Disable pre-scheduling if thread is about to be scheduled out
    // and issue dequeue() to drain pending events.
 
-Application may  provide a hint to the eventdev PMD
+Application may provide a hint to the eventdev PMD
 to pre-schedule the next event without releasing the current flow context.
 Event device that support this feature advertises the capability
 via the ``RTE_EVENT_DEV_CAP_PRESCHEDULE_EXPLICIT`` flag.
-If pre-scheduling is already enabled at a event device or event port level
+If pre-scheduling is already enabled at an event device or event port level
 or if the capability is not supported then the hint is ignored.
 
 .. code-block:: c
@@ -412,8 +412,8 @@ Starting the EventDev
 ~~~~~~~~~~~~~~~~~~~~~
 
 A single function call tells the eventdev instance to start processing
-events. Note that all queues must be linked to for the instance to start, as
-if any queue is not linked to, enqueuing to that queue will cause the
+events. Note that all queues must be linked to at least one port for the instance to start, as
+if any queue is not linked, enqueuing to that queue will cause the
 application to backpressure and eventually stall due to no space in the
 eventdev.
 
@@ -572,5 +572,5 @@ The eventdev library allows an application to easily schedule events as it
 requires, either using a run-to-completion or pipeline processing model.  The
 queues and ports abstract the logical functionality of an eventdev, providing
 the application with a generic method to schedule events.  With the flexible
-PMD infrastructure applications benefit of improvements in existing eventdevs
+PMD infrastructure applications benefit from improvements in existing eventdevs
 and additions of new ones without modification.
-- 
2.51.0

