Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998DD30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E1E40693;
	Wed, 14 Jan 2026 00:01:12 +0100 (CET)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66]) by mails.dpdk.org (Postfix) with ESMTP id 022094065A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:10 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so6800889f8f.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345269;
 x=1768950069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbfM3hLNOOXOJRwonW1kZKtVOsEJxhMKaBZubrH1jno=;
 b=HI2g/gGrtAFlTaiksffjovAQCUQi3Tcb0VfgZHRehTfLIDYMk9xXnRkpglHWP1XHzL
 CDXyH41ZiD+NeTiPOZ31xvvWOR7GUluE5XKSmKVGHhz3B64uMUTqW/+K1rdM1Gbguxsp
 nXpwNAhE9YNF471QGQUqCZqsVFoVYPg9pEWRFGuo+AgFvrrc611+PdSnOzDPysqF6pmB
 OiBb4mLBKy74FdzBSf+WEap4AC6yefLT9FEikRBmR/sICEuDgLACjAFnsIr+HhdrrfAD
 g6ElurBeYmhJpqjuz8PY8RNUvLmFWAGZP4a+Fk9ONw1osJcXJLR1DK5D4119jWzbQrSJ
 UJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345269; x=1768950069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WbfM3hLNOOXOJRwonW1kZKtVOsEJxhMKaBZubrH1jno=;
 b=IE/T506LAUazJ3X2Ttq6rKH9QTJTIgIEh5qNcmcECrx+jZGkOi2l/ei/7S9LXZmYOx
 jYKpucWCCFhbx/C5pXJ1XYxIBOhSYxmNAuU38PSQSVzSBMaR0HTXZSraMAdE17oK2iK7
 xa/2iz9Hrw0GvC+QYHdJf2lwpv3OLJjQxqUIGZSKxILXLjraaZzpCUjMyeFt2s3zHS9m
 3B9MIGg+Vx5R/fiCRw0bxuTNDE3gRoXTmCMCYea/P2I6N9YIaqc//92FlOAaRAXrT1TG
 NeWGfipQH0m2x/Mif1hPEr+wE12NrHvo5gCyOgHO1dpw/yUhd+Rt0nKbipj8Zqawjeu2
 iQ5g==
X-Gm-Message-State: AOJu0Yz4ENHtnf1lzvOXR4oyttfAHx6ZLHY2cAxeev/8MqFJ78suXQHN
 low7giXrgljNnN0hNNdgZn9olXdDFU8DQOc4GFvtcT5rEtiDJJuUET02WNoTHbQy+77vuUL1wmN
 UrKgD
X-Gm-Gg: AY/fxX5A+/OH0iLYctjmdnxS8tPiEJ78+0R0X2KLaXjb0eXs8iZe6ZSBRttZNstTK50
 bd9IMifeVNZE/fsDL6deSavPWVaEpAm7xzgN5FMI0mTJTK0PfPO3Y0IL4qm4SvUgbKKSlSJfQyB
 3o0c3p9PS+6rbMc+q/l7j52frPu1bkbqDInK3/g68abRLxkgQE5F5uiuQVnjK+4WeSa5ElyYYMb
 j+/IRgye1FVXXouebrypi4ffmVRgFCV3+wnrDRAztK5ZTlMIS5RMuzn/1YHrSXsCqQCZlZVyaQi
 jv6fNa43wkkXHKdXKDOfEnlLQBULYZNpM9hkap8Lwe4ZW5bd2rAd5uCbWjueC0YRzW4fDwEtESS
 K2w17GmO+I9dqII1jtN8eH+KbKQi+aIvxY/2iICLp8SHAlnFhC6QM/Ju7Bt6vTp3Jg1jG24WZ7H
 QVdbbdHnNomV1nS05flqjUivCeGR/xJG1uyW/P5MoTU9rkG0XyVg==
X-Received: by 2002:a05:6000:2303:b0:431:9dd:2cca with SMTP id
 ffacd0b85a97d-4342d38973dmr118602f8f.7.1768345269487; 
 Tue, 13 Jan 2026 15:01:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 06/11] doc: correct grammar and errors in trace library
 guide
Date: Tue, 13 Jan 2026 14:51:08 -0800
Message-ID: <20260113230052.54435-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113230052.54435-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260113230052.54435-1-stephen@networkplumber.org>
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

