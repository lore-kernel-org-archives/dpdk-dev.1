Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D57D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD6514278F;
	Wed, 14 Jan 2026 23:28:40 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 30D044114B
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:39 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so3131535e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429719;
 x=1769034519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbfM3hLNOOXOJRwonW1kZKtVOsEJxhMKaBZubrH1jno=;
 b=S1GoiufaaOuYKy8GgCJQEqrstlLllebgg0h59ggTrL4sB6Oq3rRiips3WQXM3Rb+om
 N53rwh357TjH/d/q9pRtgYUkLOU5852L9Nt+D2Lz5SkzO1i6I9DkrV2O00J5qpdO0FqN
 pwGvV78xSsrvxA8CtDQmpIzkPagpp8+hWuAEmV/NetJE2gTBfjL3y9dugyQWjYtnzfcS
 dn3LsbYOuZWV5WCgQra5uMzxVkFC21ROFEHNMNFJP3fj/FUzswOxUCO5uHpwZ27H4qFR
 qOMmuweOEeizNuckhFyjClxVZVCQZUjLn9CQfNf3O4mtDDpTe5dauyeKxrtqw9Ir13/M
 hOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429719; x=1769034519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WbfM3hLNOOXOJRwonW1kZKtVOsEJxhMKaBZubrH1jno=;
 b=p2zp+xQNWRavv0dkW95tCb/qT6d7eXswHlnl6h6OE82Nl8NFYFnQPQjsm7yRn4bt/8
 rbJwjtiUc4Gw9Fshm2YxvgCsd7vld/mazZ1ciLfvqfyIesOAzMCRVKTEELXJ+8DVj9DP
 fHZAW6ZFwwgtYfgOAcMRWouT/h9hRU+lnzVa592e7SIJkdLJ0hdyDt80Ib0tDS17rdz/
 p8NFKjVdaQzjMLSUK7R/afu+ho9/bDIfelNyjwMZ593vt4KWHzd7Qaxid3cW4T9WbzYE
 /W8axUYCgUt7Ckeo36rPvSM1iCrc38HhZuYOxfLe2kJ6oSAvqnANyxUy4gjjiPs+bVE3
 I7Mg==
X-Gm-Message-State: AOJu0YxQL+VYrNyOL0tIdN+ldFwsEAl/2kNj+eZyG2chyK8L8Qiryz/L
 ULGPHraPwoSxBKK14jWawqpnTOvRO4aLjy70gEcq0wkZ9edoDTpsEMqa2n31OmS8bjD+PPDaxo5
 HVCfC
X-Gm-Gg: AY/fxX6tw+dvvJqKqbZ0WYGTZF/AwhGEylJigEgpIuttTZ93HMxLdPpscKbY0FyNIej
 HFbXqnrF8dYmgpNnL2/dC2nS4RXinXBoo8WLJd25He3zRxIQBFuWdjsNi+xkJqsWH29LTal3/h+
 j4cFabLDlfNqznNrIAxF1f76/9qjcOMZi/TYmGLfNW0umjp5eeyxrWpqxDiLHoxa5Revgc3hUYY
 nXE9Iur6zAu5494deJCsm2qOpQtJVynJ7Dx9fyKKderqG0VU8kFqk6rkLLAptPhokBuhKN3fjxK
 w1qK9QRMvZe1sIxrmFRpOofcsvpgrxa0Soj4E0UEmXuK0SUq0/DviTBgDYJWO+B1rwGdV+nQ7Ay
 jm955aKCojan1rBumEpTQZUEV7YZounNkjitoE1ad+CqRwWfpiCYWH47Wn4gSI6IjuiICl2tvu/
 fdCOzTZfELFq+dD3yPUHrju0MsYK+X6TFJ/vUqx42I4IMfjFwZvQ==
X-Received: by 2002:a5d:64c5:0:b0:430:fbe1:382a with SMTP id
 ffacd0b85a97d-4342d5d949amr5090767f8f.54.1768429718643; 
 Wed, 14 Jan 2026 14:28:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v4 06/11] doc: correct grammar and errors in trace library
 guide
Date: Wed, 14 Jan 2026 14:26:58 -0800
Message-ID: <20260114222821.87920-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222821.87920-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260114222821.87920-1-stephen@networkplumber.org>
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
- Fix subject-verb agreement ("traces that use", "example greps/counts")
- Fix article before vowel sound ("an EAL")
- Fix preposition ("known to DPDK" not "known of DPDK")
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

