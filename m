Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E950DD30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:02:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 825FD40A7A;
	Wed, 14 Jan 2026 00:01:17 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id BD90840A71
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:15 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-431048c4068so175048f8f.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345275;
 x=1768950075; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE2PIMt3Pk8YNzmMMj2QTAM2g5KVJA+fJxn1t5+pmKU=;
 b=1Lqoty4HEVmJny3aK5NpPTJr7xlewIEVncML6c7XORSWQHyTwRG4f3QZfxo5O37FE4
 3euLwgf/IdOsUMdL4zmeFEcqEkBL88FW11tAhHT1QjS+QvbCKavQJkg5nO6M1vwXVyLm
 4nefDwavaVWVuAwtgNE0moYrvZ1D5JjBQiyz4kQzVwc3CZPvQA6ZmSmfqNG+RKhMspAH
 UiKc0FOW+KFvzepQ680oUs4uvvzQaAWCNzjIcEErVZDVRCqP4jxmvrSZZ5Ut5EByXSaV
 sGv1JL73TDFRiOUOX3R/n0iuvcj3jnZGW0wBzSQbahoTw4iXm1Ve/FTawq2KiECTYy4k
 XwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345275; x=1768950075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dE2PIMt3Pk8YNzmMMj2QTAM2g5KVJA+fJxn1t5+pmKU=;
 b=VRU/7yB5QPRXGybxaUJZCoQmvfkPjTt7iPMpVJqUQJjA2Z86ZlRT25w9z4ImgtBQpy
 RvhNij5o8zaNd+0uKMr89bpmsjJqkMojgKhSRR50MrNiYWPGmFBrjreqoHXet/4LiBUA
 eL+mCDDIbEVSrg5suDPddiPAvdYZCZWj/quomPKGNWr7s/sWraqStF52yc23K2guoS/h
 Wk74YWFsqqhCO1yJLg4+B6Q8uJYeFuY/hJ0AJJJ4QZa99YQwhfSqUvZBADJ4++frRYut
 4TAIP6hCcftdmA/gA6YsmZrH4y8GxWHwIpy3LfGp5vIQTQ5ESiwnDdBGotsiGs+rzQ2N
 p66A==
X-Gm-Message-State: AOJu0YxR6iJ+HJdHHX+1If33C5oAWSDUEapAZ593Qx2bik/XwPnBabH2
 +K9wdu3E5VjfghOdasV4632sarq8LF29fKb/dAhmX5z9P6iAd6VR/msZ/9Q7Vu6UtPpB/bhXzgc
 zaOi7
X-Gm-Gg: AY/fxX4wLaHZ/0SxOR3yDjrkmpcNSOmHvreE+s2Xvag+7w/tP2BcKYKFQimLPPVR7rr
 8VEiJsEc1aeh8Pm7O0Zf+LMhob2JHCSumWV9mIILc5+l+4zyvFX32kiT3Cwiqbn9LRDYdKlI313
 0Y4oaESXx1U5/12VmDBGNk7xmmIWJNEPsjN+pAv4MGN1RksnErVirVVLn4nVwJbPlGp31Kj03f8
 cPBIVQo31V865H6ssHQJRwxTRXf5fSgYjx6qT3mjDeGMOlxwQ/s7SFgop9BmRfS2q2yI/z9RRfy
 9fRhjh7e89ruiwO0ATTFvtoF09piV6avM5uDiaxk/EVjrugcqLff5n1gmIH6Pj+DCJF50fOHqgf
 tduybhlXT2us1/5SyHWBu8NfYRoxL1YVXlAbqTGJRuRD4YOzu1XsRxc6cWhIW2dFh7SUVzSn1Ea
 UkJDv5aeUwRgt98uUWct+0nbuZ7RRLnJl20GZh4NF9XvH+Sh2fd9Us1ckeoSAt
X-Received: by 2002:a05:6000:2886:b0:432:59d4:f54a with SMTP id
 ffacd0b85a97d-43423ed9f25mr6521110f8f.30.1768345274576; 
 Tue, 13 Jan 2026 15:01:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 09/11] doc: correct errors in trace library guide
Date: Tue, 13 Jan 2026 14:51:11 -0800
Message-ID: <20260113230052.54435-10-stephen@networkplumber.org>
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
- Fix broken sentence in implementation details: "As DPDK trace library
  is designed..." was a sentence fragment
- Fix tense inconsistency: "will be useful" -> "is useful",
  "will be allocated" -> "is allocated",
  "will be discarded" -> "are discarded"
- Fix grammatical parallelism: "or use the API" -> "or by using the API"
- Fix inconsistent capitalization in section headers: "Tracepoint" ->
  "tracepoint" to match body text usage throughout
- Fix tool name consistency: "Tracecompass" -> "Trace Compass"
  (official name, two words)
- Fix awkward phrasing: "one of a CTF trace's streams" ->
  "one of the streams in a CTF trace"
- Fix trace header description for parallelism: "48 bits of timestamp
  and 16 bits event ID" -> "a 48-bit timestamp and a 16-bit event ID"
- Add missing article: "to trace library" -> "to the trace library"
- Remove incorrect article:
  "the ``my_tracepoint.h``" -> "``my_tracepoint.h``"
- Add function call parentheses: rte_eal_init -> rte_eal_init(),
  rte_thread_register -> rte_thread_register()
- Fix ambiguous pronoun: "It can be overridden" -> "This location can
  be overridden"
- Fix line wrap for readability in features list

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

