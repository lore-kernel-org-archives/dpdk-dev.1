Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACDC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F35406B7;
	Sun, 18 Jan 2026 20:13:35 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 30D6040670
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:34 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b876f3f603eso620248166b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763614;
 x=1769368414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfaJkMsXihpd5P2tKcophJ+bZhX0Wcy54FLKEnuo92s=;
 b=N22Ax6MIxyK6eGFfhH8I1scjvNSiDQEXg8j56bBtl57Rm2djW/vsmSQw5GhahHk7p7
 Wc16fnPYRxmuobmesAUFjxcZ7RD3MOvydpRwrbKpkRldc75tocLwDgvUYxwVjGnHw86+
 EvHEbcGQ+FxHhdm8uVtNqg/AgUiPhIDNKkYmSEAZf6ZzKQjw8UaOizQAR4wdSz8qL0zL
 Lo9N61T7tdbj3KaOqgyt5W/gxB6k+yZyS3RgYHbc1PfuLAQ//WQq35ELvO2nhUl2RHuE
 8j2O7o4bA8cPBzn/IUO+AFTJxRbRTgfVEgCqbIQqimkSZ2lXlMWk4TqgaK+6kN4D3fT/
 2wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763614; x=1769368414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cfaJkMsXihpd5P2tKcophJ+bZhX0Wcy54FLKEnuo92s=;
 b=sHGnTyj4HnZb9Fs6sB/99nZYj3yBGuNncpPr7Dpl8MVpabSAETQkoFuGyX3dzxj3YX
 REwmlI/nukXFlmlZQ/jrZtBx0ywvea5S6qNsRUcY1h0gzwLtu79+/xR3SRul+nlwwP3m
 4lMMi1eixOtl6jC+5bWQ1qEJiGHmAfIN+1Jkk8IPmyuPZKkRS5kT4slRj+3XqgG+FIYy
 /cZ/e6WZT9RJEELVI6ZFlNCe6Gf1g+tHZBMt4hTW4Nt8PYfBJ313ZW5y4pgqyxYOmS3p
 aXno3XPQ6jK7yCKPppxK2d2X0ib4TymokSZoaYhwweqQIU3XvP118lulXipAgBCROIeI
 iqBw==
X-Gm-Message-State: AOJu0YyAPrkyFI9vKNSCsA1ovhx9/XCi3wQMs5HHYb6kC+a61Vo4U44F
 9xkAKRXUoswDB4w1K/CkOaA21E/4v6GEMjx8WMS2rbsi83C+xeaQAld5eQLeoJw+yFBkH2WFOWc
 mL6zS
X-Gm-Gg: AY/fxX5+4vUJw2AuHE2cV+SKqzveSl3Nedh5RhvUvD2Rco00eNocZuLxLwepQPPGP5o
 j51ygk6n9dE9z6Kj5LHkMtfSZspzzocky1xLo7ZDggiC5k01XJ2hUQXbdjYL1BQoK14/0RGVnjn
 Of5RveAaR/HYxJIEZZ7iiXJrtHtAbOV4u/NT1vEmN8L+nWVxPJR/Ap1HsWVqnK2yKPZlySKAdvl
 WRqeKi5KCo1gUj67tlO/0K68Ul5XHKTjZjec0f4dZ3HAfOGfrt63OzxDkqb6fEFaddTaUGzBkGM
 8dswKdbt4tvfu0B0bpjveP/vow96d55owCxW+rAmMBFtoNvIywXWcldDC7/NzAXYVshpBNz3Izf
 HFRnyrruAPFPbvxFl7dZ1dXpZb2J7BTu2iQkphFpUAM4V7POneI3AprjtEK47pKORv728lWrQxK
 qy0rLMdDHrqMsVppxlVwqRyKkXngW5+kye8B1C4HOleaukllYn7g==
X-Received: by 2002:a17:907:9410:b0:b73:7fc8:a9c9 with SMTP id
 a640c23a62f3a-b8796a5bce3mr737522166b.29.1768763613614; 
 Sun, 18 Jan 2026 11:13:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 03/54] doc: correct grammar and errors in trace library
 guide
Date: Sun, 18 Jan 2026 11:10:06 -0800
Message-ID: <20260118191323.241013-4-stephen@networkplumber.org>
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
- CRITICAL: restore missing "out" in "compiled out by default"
  (RTE_TRACE_POINT_FP is disabled by default, not enabled)
- Add missing article and verb ("a framework", "are broadly divided")
- Change subject-verb agreement ("traces that use", "example greps/counts")
- Change article before vowel sound ("an EAL")
- Change preposition ("known to DPDK" not "known of DPDK")
- Use standard spelling "lockless" and "non-lcore"

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/trace_lib.rst | 68 ++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
index d9b17abe90..829a061074 100644
--- a/doc/guides/prog_guide/trace_lib.rst
+++ b/doc/guides/prog_guide/trace_lib.rst
@@ -14,29 +14,29 @@ When recording, specific instrumentation points placed in the software source
 code generate events that are saved on a giant tape: a trace file.
 The trace file then later can be opened in *trace viewers* to visualize and
 analyze the trace events with timestamps and multi-core views.
-Such a mechanism will be useful for resolving a wide range of problems such as
-multi-core synchronization issues, latency measurements, finding out the
-post analysis information like CPU idle time, etc that would otherwise be
-extremely challenging to get.
+This mechanism will be useful for resolving a wide range of problems such as
+multi-core synchronization issues, latency measurements, and finding
+post analysis information like CPU idle time, etc., that would otherwise be
+extremely challenging to gather.
 
 Tracing is often compared to *logging*. However, tracers and loggers are two
-different tools, serving two different purposes.
-Tracers are designed to record much lower-level events that occur much more
+different tools serving two different purposes.
+Tracers are designed to record much lower-level events that occur more
 frequently than log messages, often in the range of thousands per second, with
 very little execution overhead.
 Logging is more appropriate for a very high-level analysis of less frequent
 events: user accesses, exceptional conditions (errors and warnings, for
-example), database transactions, instant messaging communications, and such.
+example), database transactions, instant messaging communications, etc.
 Simply put, logging is one of the many use cases that can be satisfied with
 tracing.
 
 DPDK tracing library features
 -----------------------------
 
-- A framework to add tracepoints in control and fast path APIs with minimum
+- Provides a framework to add tracepoints in control and fast path APIs with minimum
   impact on performance.
   Typical trace overhead is ~20 cycles and instrumentation overhead is 1 cycle.
-- Enable and disable the tracepoints at runtime.
+- Enable and disable tracepoints at runtime.
 - Save the trace buffer to the filesystem at any point in time.
 - Support ``overwrite`` and ``discard`` trace mode operations.
 - String-based tracepoint object lookup.
@@ -47,7 +47,7 @@ DPDK tracing library features
   For detailed information, refer to
   `Common Trace Format <https://diamon.org/ctf/>`_.
 
-How to add a tracepoint?
+How to add a Tracepoint
 ------------------------
 
 This section steps you through the details of adding a simple tracepoint.
@@ -67,14 +67,14 @@ Create the tracepoint header file
         rte_trace_point_emit_string(str);
  )
 
-The above macro creates ``app_trace_string`` tracepoint.
+The above macro creates the ``app_trace_string`` tracepoint.
 The user can choose any name for the tracepoint.
 However, when adding a tracepoint in the DPDK library, the
 ``rte_<library_name>_trace_[<domain>_]<name>`` naming convention must be
 followed.
 The examples are ``rte_eal_trace_generic_str``, ``rte_mempool_trace_create``.
 
-The ``RTE_TRACE_POINT`` macro expands from above definition as the following
+The ``RTE_TRACE_POINT`` macro expands from the above definition as the following
 function template:
 
 .. code-block:: c
@@ -91,7 +91,7 @@ The consumer of this tracepoint can invoke
 ``app_trace_string(const char *str)`` to emit the trace event to the trace
 buffer.
 
-Register the tracepoint
+Register the Tracepoint
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: c
@@ -122,40 +122,40 @@ convention.
 
    The ``RTE_TRACE_POINT_REGISTER`` defines the placeholder for the
    ``rte_trace_point_t`` tracepoint object.
-   For generic tracepoint or for tracepoint used in public header files,
+   For a generic tracepoint or for the tracepoint used in public header files,
    the user must export a ``__<trace_function_name>`` symbol
    in the library ``.map`` file for this tracepoint
-   to be used out of the library, in shared builds.
+   to be used out of the library in shared builds.
    For example, ``__app_trace_string`` will be the exported symbol in the
    above example.
 
-Fast path tracepoint
+Fast Path Tracepoint
 --------------------
 
 In order to avoid performance impact in fast path code, the library introduced
 ``RTE_TRACE_POINT_FP``. When adding the tracepoint in fast path code,
 the user must use ``RTE_TRACE_POINT_FP`` instead of ``RTE_TRACE_POINT``.
 
-``RTE_TRACE_POINT_FP`` is compiled out by default and it can be enabled using
+``RTE_TRACE_POINT_FP`` is compiled out by default and can be enabled using
 the ``enable_trace_fp`` option for meson build.
 
-Event record mode
+Event Record Mode
 -----------------
 
-Event record mode is an attribute of trace buffers. Trace library exposes the
+Event record mode is an attribute of trace buffers. The trace library exposes the
 following modes:
 
 Overwrite
-   When the trace buffer is full, new trace events overwrites the existing
+   When the trace buffer is full, new trace events overwrite the existing
    captured events in the trace buffer.
 Discard
    When the trace buffer is full, new trace events will be discarded.
 
-The mode can be configured either using EAL command line parameter
-``--trace-mode`` on application boot up or use ``rte_trace_mode_set()`` API to
+The mode can be configured either using the EAL command line parameter
+``--trace-mode`` on application boot up or use the ``rte_trace_mode_set()`` API to
 configure at runtime.
 
-Trace file location
+Trace File Location
 -------------------
 
 On ``rte_trace_save()`` or ``rte_eal_cleanup()`` invocation, the library saves
@@ -167,7 +167,7 @@ option.
 For more information, refer to :doc:`../linux_gsg/linux_eal_parameters` for
 trace EAL command line options.
 
-View and analyze the recorded events
+View and Analyze Recorded Events
 ------------------------------------
 
 Once the trace directory is available, the user can view/inspect the recorded
@@ -176,7 +176,7 @@ events.
 There are many tools you can use to read DPDK traces:
 
 #. ``babeltrace`` is a command-line utility that converts trace formats; it
-   supports the format that DPDK trace library produces, CTF, as well as a
+   supports the format that the DPDK trace library produces, CTF, as well as a
    basic text output that can be grep'ed.
    The babeltrace command is part of the Open Source Babeltrace project.
 
@@ -195,12 +195,12 @@ to babeltrace with no options::
 all their events, merging them in chronological order.
 
 You can pipe the output of the babeltrace into a tool like grep(1) for further
-filtering. Below example grep the events for ``ethdev`` only::
+filtering. The example below greps the events for ``ethdev`` only::
 
     babeltrace /tmp/my-dpdk-trace | grep ethdev
 
 You can pipe the output of babeltrace into a tool like wc(1) to count the
-recorded events. Below example count the number of ``ethdev`` events::
+recorded events. The example below counts the number of ``ethdev`` events::
 
     babeltrace /tmp/my-dpdk-trace | grep ethdev | wc --lines
 
@@ -238,7 +238,7 @@ This section steps you through the details of generating trace and viewing it.
 Implementation details
 ----------------------
 
-As DPDK trace library is designed to generate traces that uses ``Common Trace
+As DPDK trace library is designed to generate traces that use ``Common Trace
 Format (CTF)``. ``CTF`` specification consists of the following units to create
 a trace.
 
@@ -249,7 +249,7 @@ a trace.
 For detailed information, refer to
 `Common Trace Format <https://diamon.org/ctf/>`_.
 
-The implementation details broadly divided into the following areas:
+The implementation details are broadly divided into the following areas:
 
 Trace metadata creation
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -272,16 +272,16 @@ Trace memory
 
 The trace memory will be allocated through an internal function
 ``__rte_trace_mem_per_thread_alloc()``. The trace memory will be allocated
-per thread to enable lock less trace-emit function.
+per thread to enable lockless trace-emit function.
 
-For non lcore threads, the trace memory is allocated on the first trace
+For non-lcore threads, the trace memory is allocated on the first trace
 emission.
 
-For lcore threads, if trace points are enabled through a EAL option, the trace
-memory is allocated when the threads are known of DPDK
+For lcore threads, if trace points are enabled through an EAL option, the trace
+memory is allocated when the threads are known to DPDK
 (``rte_eal_init`` for EAL lcores, ``rte_thread_register`` for non-EAL lcores).
 Otherwise, when trace points are enabled later in the life of the application,
-the behavior is the same as non lcore threads and the trace memory is allocated
+the behavior is the same as non-lcore threads and the trace memory is allocated
 on the first trace emission.
 
 Trace memory layout
-- 
2.51.0

