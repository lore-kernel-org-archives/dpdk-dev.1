Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C12C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F4B540E01;
	Sun, 18 Jan 2026 20:13:41 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 4EDA040A67
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:39 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso7548545a12.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763619;
 x=1769368419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hs15bjqNon/Lc8U3hmFsbkGTHz3Jd+4+DWWgtlpgMrA=;
 b=qpPnt2nk9SW5OMiYmRlUCYXgpSKq5pFF+QwSTUUbUHgA2TEbp0af7+m7Bnt+GO1M22
 Drz0xruscqpWaPcYyRo0EVsZ/jHz/0SVZLn7/I6mnHj6T19LNQOZPCjNagb2NG1B3WXP
 Za5TckdnhiidWp4RHIo40LGSrx3UdARLDZqRu7THKEa2KSzzhux2m6mgj2KsWugAK/O8
 RoviI4zq6KruzGZ1rFM946kXQzhb5m1EOQrOQnMynd9B9Ho2aqmMupMTDdzn9rwXRNv6
 rCKgkP7ysfhWKRX746CsNUXYrRGPIkjC9BiBGw0+/itG0cveX/WOup1wQUTq32QTZgg0
 AFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763619; x=1769368419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hs15bjqNon/Lc8U3hmFsbkGTHz3Jd+4+DWWgtlpgMrA=;
 b=KXSiZhiV13r2FoTCNKeCPkP8siBLUYk7DbLtK8RXmQkqWMWp1AziwYFg57/TosOlhv
 S5hSiNaIKhYG1yEhC1XLX5pDbi/GB1QUd5zLUcubqhAN1b2z6thw4Hxc4yEkhV/wS+e4
 5dpEQK4CzsPPjWoEvA0PQR5l5WSBFC894nYugW+z54mMdQorXypZmoiPYTcbGlGflV1v
 pnw2jLW2SMy1bQK1hlh39HG3zE/J+rt1hZxtIBtQwIgCMBtJqHAQiqYujbwyTkmG6Yrc
 z9+JueFHqc9CJ5Jr4CNzdUEmlEyN9ZYe09XxqRPHMZV3XNXANCwuVkE6fiF+T8K75u+8
 5f6g==
X-Gm-Message-State: AOJu0YzxzBLJrWJHvPnqRKHo4+0olULPK7CoMpOa3N4GxdT5ec0z3bAU
 9mHdo8FK8+G6U1U7YqAwTRnHjRmJxkkaUWrKuIIpAuWPHh1iUQShHOMaJone/0madl6yB3Pxcsq
 bW9AN
X-Gm-Gg: AY/fxX6n/69Hj+Pwxb20zn/yBHA9lg0kiM32HJLWnrzG20VzXEhbhBKMzTirDY2S/A5
 BCJxa95noYThskcOpWGCBLasUBHcktrVhTW+F417BrgoL0u5ewJvD6dcGjr1tKN0amYSipP6+uC
 d+aLjOxB7oDXBRU5A+Xoa+GcCBV55vzRfU7j1SH687dI/fUOi2PffXKcaLnfqbVEv3cOYa0+pXi
 MK5CjYJro/YWC+GktGbbNYshJXaeR/qVnJ0HBuaa5W3q3nkY0k5S0wK2XVygIMqA9YErqKJPFlD
 EC4g7GFCHPJD/NOUKuIpcfnp0AQhD8ILW2jAqVmhednOSZ9SJ6FfCj7lwApdUO+Uk3vtALjYxvK
 WET6vok2WAQxi1MFRlw8ds1SMhtSeEqyAiWSXPu1rGGOHpoRM5EEz+Jt5JRvtxRqDADhXCmEpXq
 ka7i9UaXAM4ugNyEi6JgPaXH+0JOTg9ihx455Eu1N5/X+A4dmBVYfe3Yi+xQMd
X-Received: by 2002:a17:906:c147:b0:b87:2c88:ce40 with SMTP id
 a640c23a62f3a-b8796a55942mr823702266b.27.1768763618701; 
 Sun, 18 Jan 2026 11:13:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 06/54] doc: correct errors in trace library guide
Date: Sun, 18 Jan 2026 11:10:09 -0800
Message-ID: <20260118191323.241013-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Changes:
- Change broken sentence in implementation details: "As DPDK trace library
  is designed..." was a sentence fragment
- Change tense inconsistency: "will be useful" -> "is useful",
  "will be allocated" -> "is allocated",
  "will be discarded" -> "are discarded"
- Change grammatical parallelism: "or use the API" -> "or by using the API"
- Change inconsistent capitalization in section headers: "Tracepoint" ->
  "tracepoint" to match body text usage throughout
- Change tool name consistency: "Tracecompass" -> "Trace Compass"
  (official name, two words)
- Change awkward phrasing: "one of a CTF trace's streams" ->
  "one of the streams in a CTF trace"
- Change trace header description for parallelism: "48 bits of timestamp
  and 16 bits event ID" -> "a 48-bit timestamp and a 16-bit event ID"
- Add missing article: "to trace library" -> "to the trace library"
- Remove incorrect article:
  "the ``my_tracepoint.h``" -> "``my_tracepoint.h``"
- Add function call parentheses: rte_eal_init -> rte_eal_init(),
  rte_thread_register -> rte_thread_register()
- Change ambiguous pronoun: "It can be overridden" -> "This location can
  be overridden"
- Change line wrap for readability in features list

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/trace_lib.rst | 80 ++++++++++++++---------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
index 829a061074..33b6232ce3 100644
--- a/doc/guides/prog_guide/trace_lib.rst
+++ b/doc/guides/prog_guide/trace_lib.rst
@@ -14,7 +14,7 @@ When recording, specific instrumentation points placed in the software source
 code generate events that are saved on a giant tape: a trace file.
 The trace file then later can be opened in *trace viewers* to visualize and
 analyze the trace events with timestamps and multi-core views.
-This mechanism will be useful for resolving a wide range of problems such as
+This mechanism is useful for resolving a wide range of problems such as
 multi-core synchronization issues, latency measurements, and finding
 post analysis information like CPU idle time, etc., that would otherwise be
 extremely challenging to gather.
@@ -33,8 +33,8 @@ tracing.
 DPDK tracing library features
 -----------------------------
 
-- Provides a framework to add tracepoints in control and fast path APIs with minimum
-  impact on performance.
+- Provides a framework to add tracepoints in control and fast path APIs with
+  minimal impact on performance.
   Typical trace overhead is ~20 cycles and instrumentation overhead is 1 cycle.
 - Enable and disable tracepoints at runtime.
 - Save the trace buffer to the filesystem at any point in time.
@@ -47,8 +47,8 @@ DPDK tracing library features
   For detailed information, refer to
   `Common Trace Format <https://diamon.org/ctf/>`_.
 
-How to add a Tracepoint
-------------------------
+How to add a tracepoint
+-----------------------
 
 This section steps you through the details of adding a simple tracepoint.
 
@@ -91,7 +91,7 @@ The consumer of this tracepoint can invoke
 ``app_trace_string(const char *str)`` to emit the trace event to the trace
 buffer.
 
-Register the Tracepoint
+Register the tracepoint
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: c
@@ -103,7 +103,7 @@ Register the Tracepoint
  RTE_TRACE_POINT_REGISTER(app_trace_string, app.trace.string)
 
 The above code snippet registers the ``app_trace_string`` tracepoint to
-trace library. Here, the ``my_tracepoint.h`` is the header file
+the trace library. Here, ``my_tracepoint.h`` is the header file
 that the user created in the first step :ref:`create_tracepoint_header_file`.
 
 The second argument for the ``RTE_TRACE_POINT_REGISTER`` is the name for the
@@ -129,7 +129,7 @@ convention.
    For example, ``__app_trace_string`` will be the exported symbol in the
    above example.
 
-Fast Path Tracepoint
+Fast path tracepoint
 --------------------
 
 In order to avoid performance impact in fast path code, the library introduced
@@ -139,7 +139,7 @@ the user must use ``RTE_TRACE_POINT_FP`` instead of ``RTE_TRACE_POINT``.
 ``RTE_TRACE_POINT_FP`` is compiled out by default and can be enabled using
 the ``enable_trace_fp`` option for meson build.
 
-Event Record Mode
+Event record mode
 -----------------
 
 Event record mode is an attribute of trace buffers. The trace library exposes the
@@ -149,26 +149,26 @@ Overwrite
    When the trace buffer is full, new trace events overwrite the existing
    captured events in the trace buffer.
 Discard
-   When the trace buffer is full, new trace events will be discarded.
+   When the trace buffer is full, new trace events are discarded.
 
 The mode can be configured either using the EAL command line parameter
-``--trace-mode`` on application boot up or use the ``rte_trace_mode_set()`` API to
-configure at runtime.
+``--trace-mode`` on application boot up or by using the ``rte_trace_mode_set()``
+API at runtime.
 
-Trace File Location
+Trace file location
 -------------------
 
 On ``rte_trace_save()`` or ``rte_eal_cleanup()`` invocation, the library saves
 the trace buffers to the filesystem. By default, the trace files are stored in
 ``$HOME/dpdk-traces/rte-yyyy-mm-dd-[AP]M-hh-mm-ss/``.
-It can be overridden by the ``--trace-dir=<directory path>`` EAL command line
-option.
+This location can be overridden by the ``--trace-dir=<directory path>`` EAL
+command line option.
 
 For more information, refer to :doc:`../linux_gsg/linux_eal_parameters` for
 trace EAL command line options.
 
-View and Analyze Recorded Events
-------------------------------------
+View and analyze recorded events
+--------------------------------
 
 Once the trace directory is available, the user can view/inspect the recorded
 events.
@@ -204,28 +204,28 @@ recorded events. The example below counts the number of ``ethdev`` events::
 
     babeltrace /tmp/my-dpdk-trace | grep ethdev | wc --lines
 
-Use the tracecompass GUI tool
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Use the Trace Compass GUI tool
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-``Tracecompass`` is another tool to view/analyze the DPDK traces which gives
-a graphical view of events. Like ``babeltrace``, tracecompass also provides
+``Trace Compass`` is another tool to view/analyze the DPDK traces which gives
+a graphical view of events. Like ``babeltrace``, Trace Compass also provides
 an interface to search for a particular event.
-To use ``tracecompass``, following are the minimum required steps:
+To use ``Trace Compass``, the following are the minimum required steps:
 
-- Install ``tracecompass`` to the localhost. Variants are available for Linux,
+- Install ``Trace Compass`` to the localhost. Variants are available for Linux,
   Windows, and OS-X.
-- Launch ``tracecompass`` which will open a graphical window with trace
+- Launch ``Trace Compass`` which will open a graphical window with trace
   management interfaces.
-- Open a trace using ``File->Open Trace`` option and select metadata file which
-  is to be viewed/analyzed.
+- Open a trace using the ``File->Open Trace`` option and select the metadata file which
+  will be viewed/analyzed.
 
-For more details, refer
+For more details, refer to
 `Trace Compass <https://www.eclipse.org/tracecompass/>`_.
 
 Quick start
 -----------
 
-This section steps you through the details of generating trace and viewing it.
+This section steps you through the details of generating the trace and viewing it.
 
 - Start the dpdk-test::
 
@@ -238,9 +238,9 @@ This section steps you through the details of generating trace and viewing it.
 Implementation details
 ----------------------
 
-As DPDK trace library is designed to generate traces that use ``Common Trace
-Format (CTF)``. ``CTF`` specification consists of the following units to create
-a trace.
+The DPDK trace library is designed to generate traces that use
+``Common Trace Format (CTF)``. The ``CTF`` specification consists of the
+following units to create a trace.
 
 - ``Stream`` Sequence of packets.
 - ``Packet`` Header and one or more events.
@@ -249,15 +249,15 @@ a trace.
 For detailed information, refer to
 `Common Trace Format <https://diamon.org/ctf/>`_.
 
-The implementation details are broadly divided into the following areas:
+Implementation details are broadly divided into the following areas:
 
 Trace metadata creation
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-Based on the ``CTF`` specification, one of a CTF trace's streams is mandatory:
-the metadata stream. It contains exactly what you would expect: data about the
-trace itself. The metadata stream contains a textual description of the binary
-layouts of all the other streams.
+Based on the ``CTF`` specification, one of the streams in a CTF trace is
+mandatory: the metadata stream. It contains exactly what you would expect:
+data about the trace itself. The metadata stream contains a textual description
+of the binary layouts of all the other streams.
 
 This description is written using the Trace Stream Description Language (TSDL),
 a declarative language that exists only in the realm of CTF.
@@ -270,8 +270,8 @@ The internal ``trace_metadata_create()`` function generates the metadata.
 Trace memory
 ~~~~~~~~~~~~
 
-The trace memory will be allocated through an internal function
-``__rte_trace_mem_per_thread_alloc()``. The trace memory will be allocated
+The trace memory is allocated through an internal function
+``__rte_trace_mem_per_thread_alloc()``. The trace memory is allocated
 per thread to enable lockless trace-emit function.
 
 For non-lcore threads, the trace memory is allocated on the first trace
@@ -279,7 +279,7 @@ emission.
 
 For lcore threads, if trace points are enabled through an EAL option, the trace
 memory is allocated when the threads are known to DPDK
-(``rte_eal_init`` for EAL lcores, ``rte_thread_register`` for non-EAL lcores).
+(``rte_eal_init()`` for EAL lcores, ``rte_thread_register()`` for non-EAL lcores).
 Otherwise, when trace points are enabled later in the life of the application,
 the behavior is the same as non-lcore threads and the trace memory is allocated
 on the first trace emission.
@@ -348,7 +348,7 @@ trace.header
   | timestamp [47:0]     |
   +----------------------+
 
-The trace header is 64 bits, it consists of 48 bits of timestamp and 16 bits
+The trace header is 64 bits, consisting of a 48-bit timestamp and a 16-bit
 event ID.
 
 The ``packet.header`` and ``packet.context`` will be written in the slow path
-- 
2.51.0

