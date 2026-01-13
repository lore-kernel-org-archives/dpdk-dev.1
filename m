Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0540D30CDB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3AB40A80;
	Wed, 14 Jan 2026 00:01:19 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id B488240A80
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:18 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so741235e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345278;
 x=1768950078; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTYFvUTOth5TNtgjYFlcmpqGxERKbHqZbnG6TFDaj5s=;
 b=UlDSxv11+1tzaGby4bkb9U93qhkrg5YP33+1TOc9bgkQO87YwvUtN21mhNxukW9e9H
 IMeLnRHMZ/h7/e1X4Zgm7bnhlnK2QFLauE/mt8orUC9ZqZktVtn7/jusFVe+553IMDHf
 DfQv8WaCPm3TtuXyw824l9jyOajsT1o6i3d2t4XV3aWEdrPsHUX+tnORkOsyhrBO7jSn
 IfxuWMNT1Ri+LFW4+OzBwVGHISEr0128/huiMCCg8wKWVapnhpgtTk9B3XVolfkBSbCI
 sDhJtt9wpo412bcj+HtxQibbY1eUW+9k3tXHTb+l4IdR+CoPOnItllfZ9WREm5RgbbcR
 OzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345278; x=1768950078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTYFvUTOth5TNtgjYFlcmpqGxERKbHqZbnG6TFDaj5s=;
 b=QDM4o0nlGygV+icAsKbUZfNqit4hUrCfdGwJjPnWOKJOpxFQgNjNCefIU8npI0kVHb
 qN47UyhgeHu6LXIuHcSZttM5zjfbHsIOJfatxKToLS3KDh/6yYm6ItrmSF1ZAUwC+5X/
 4yEjldORy+Y/w9oHVGNyVnlxDETPWyl/w+W29O8CoizzG6ZK9H/6tgU9yOrSFz9UsotX
 WieU4VoEGWjTCf3x7kXqHnxQZOjUFVqWs4FnUIoZLNKSAZkba91RBiuvHYiXU8zuKxVM
 Gr1yn1PjZO/ERcwW7wuEWehUJQ8QmJQwvGRLaDFZhgvSJGJS3SWoxeNnZMcPM5uCCfcn
 iPMg==
X-Gm-Message-State: AOJu0Yze12gvRHVN1YuKEO1AeLvv7wd7ZThwKVAmjIa4th0Y4pThws+F
 TS/8mouy4i8Gdu/x1dEh1sOlFIWwahPG3fH+Hi2FLWxM5mHfLHmHvfPNZCKgcWbawkk3bdTNzPL
 FXtCD
X-Gm-Gg: AY/fxX7t+oAtgWQr8fgEtYDDy1V3XNYwWnwm2XK4gX34WtmbYhiA8flFuItMnTdtBdq
 vGGlXtOLI38LWn1wBlaIc6xJkxQILa7UaIRYXzVD14b0meCOnJfh79obLujThmQDc6hAbXYgd1n
 3VT1jS+Y2sAWo/qNZNdMuT1dQgpTJaYySyP6Px16S04AMcP+QB+UefQFj7o+2FcBgVFDHS7/bFg
 7NIaktexXqO2r5B8R5KH0DPmScZoIrMMRHO8P5UI3JyX1ZICsm9snVhLv86cuK8JYG8dVXoGmrK
 vx0R/bNhKfYcymm6/HGv/y5evUSQ39ALXxm74NE8mw9Q6QdEwno+tHBshevWHZId1QeENQd2wAh
 Yqpw7AtdHaWYHClk7TaczMhUhgyCE50EwiHc+UbZjki+HhuUskpX96Y7gq8BxAU6dBx9dJaLITf
 NflNrkW5Fk0KHfTTn66/klJUgSEBUJ+LIQRA5Dh6ak5ed4ryExFQ==
X-Received: by 2002:a05:6000:220d:b0:430:b100:f591 with SMTP id
 ffacd0b85a97d-4342d39f650mr121648f8f.28.1768345277920; 
 Tue, 13 Jan 2026 15:01:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 11/11] doc: correct errors in RCU library guide
Date: Tue, 13 Jan 2026 14:51:13 -0800
Message-ID: <20260113230052.54435-12-stephen@networkplumber.org>
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

Fix several errors in the RCU library documentation:

- Fix wrong word: "exasperate" -> "exacerbate" (exasperate means to
  annoy; exacerbate means to make worse)
- Fix typo: "such at rte_hash" -> "such as rte_hash"
- Fix grammar: "critical sections for D2 is" -> "critical section for
  D2 is"
- Fix subject-verb agreement: "length... and number... is proportional"
  -> "are proportional"
- Fix inconsistent abbreviation: "RT1" -> "reader thread 1" (RT1 was
  never defined)
- Fix missing articles: add "the" before "grace period", "API"
- Fix double space before "The reader thread must"
- Add missing function parentheses throughout for consistency
- Add missing code formatting (backticks) around function names:
  rte_rcu_qsbr_dq_enqueue, rte_rcu_qsbr_dq_reclaim,
  rte_rcu_qsbr_dq_delete, rte_hash, rte_lpm
- Fix unexplained asterisk after "Reclaiming Resources*"
- Fix inconsistent capitalization in numbered list items
- Rewrap overly long lines for readability
- Clarify awkward sentence about memory examples

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/rcu_lib.rst | 143 ++++++++++++++++++------------
 1 file changed, 86 insertions(+), 57 deletions(-)

diff --git a/doc/guides/prog_guide/rcu_lib.rst b/doc/guides/prog_guide/rcu_lib.rst
index 9f3654f398..ac573eecbc 100644
--- a/doc/guides/prog_guide/rcu_lib.rst
+++ b/doc/guides/prog_guide/rcu_lib.rst
@@ -6,17 +6,17 @@ Read-Copy-Update (RCU) Library
 
 Lockless data structures provide scalability and determinism.
 They enable use cases where locking may not be allowed
-(for example real-time applications).
+(for example, real-time applications).
 
 In the following sections, the term "memory" refers to memory allocated
 by typical APIs like malloc() or anything that is representative of
-memory, for example an index of a free element array.
+memory, such as an index into a free element array.
 
 Since these data structures are lockless, the writers and readers
 are accessing the data structures concurrently. Hence, while removing
 an element from a data structure, the writers cannot return the memory
-to the allocator, without knowing that the readers are not
-referencing that element/memory anymore. Hence, it is required to
+to the allocator without knowing that the readers are not
+referencing that element/memory anymore. Therefore, it is required to
 separate the operation of removing an element into two steps:
 
 #. Delete: in this step, the writer removes the reference to the element from
@@ -51,7 +51,7 @@ As shown in :numref:`figure_quiescent_state`, reader thread 1 accesses data
 structures D1 and D2. When it is accessing D1, if the writer has to remove an
 element from D1, the writer cannot free the memory associated with that
 element immediately. The writer can return the memory to the allocator only
-after the reader stops referencing D1. In other words, reader thread RT1 has
+after the reader stops referencing D1. In other words, reader thread 1 has
 to enter a quiescent state.
 
 Similarly, since reader thread 2 is also accessing D1, the writer has to
@@ -62,28 +62,28 @@ quiescent state. Reader thread 3 was not accessing D1 when the delete
 operation happened. So, reader thread 3 will not have a reference to the
 deleted entry.
 
-It can be noted that, the critical sections for D2 is a quiescent state
-for D1. i.e. for a given data structure Dx, any point in the thread execution
-that does not reference Dx is a quiescent state.
+Note that the critical section for D2 is a quiescent state
+for D1 (i.e. for a given data structure Dx, any point in the thread execution
+that does not reference Dx is a quiescent state).
 
 Since memory is not freed immediately, there might be a need for
-provisioning of additional memory, depending on the application requirements.
+provisioning additional memory depending on the application requirements.
 
 Factors affecting the RCU mechanism
 -----------------------------------
 
 It is important to make sure that this library keeps the overhead of
-identifying the end of grace period and subsequent freeing of memory,
-to a minimum. The following paras explain how grace period and critical
+identifying the end of the grace period and subsequent freeing of memory
+to a minimum. The following paragraphs explain how grace period and critical
 section affect this overhead.
 
-The writer has to poll the readers to identify the end of grace period.
+The writer has to poll the readers to identify the end of the grace period.
 Polling introduces memory accesses and wastes CPU cycles. The memory
 is not available for reuse during the grace period. Longer grace periods
-exasperate these conditions.
+exacerbate these conditions.
 
 The length of the critical section and the number of reader threads
-is proportional to the duration of the grace period. Keeping the critical
+are proportional to the duration of the grace period. Keeping the critical
 sections smaller will keep the grace period smaller. However, keeping the
 critical sections smaller requires additional CPU cycles (due to additional
 reporting) in the readers.
@@ -117,14 +117,14 @@ How to use this library
 The application must allocate memory and initialize a QS variable.
 
 Applications can call ``rte_rcu_qsbr_get_memsize()`` to calculate the size
-of memory to allocate. This API takes a maximum number of reader threads,
-using this variable, as a parameter.
+of memory to allocate. This API takes a maximum number of reader threads
+using this variable as a parameter.
 
 Further, the application can initialize a QS variable using the API
 ``rte_rcu_qsbr_init()``.
 
 Each reader thread is assumed to have a unique thread ID. Currently, the
-management of the thread ID (for example allocation/free) is left to the
+management of the thread ID (for example, allocation/free) is left to the
 application. The thread ID should be in the range of 0 to
 maximum number of threads provided while creating the QS variable.
 The application could also use ``lcore_id`` as the thread ID where applicable.
@@ -132,14 +132,14 @@ The application could also use ``lcore_id`` as the thread ID where applicable.
 The ``rte_rcu_qsbr_thread_register()`` API will register a reader thread
 to report its quiescent state. This can be called from a reader thread.
 A control plane thread can also call this on behalf of a reader thread.
-The reader thread must call ``rte_rcu_qsbr_thread_online()`` API to start
+The reader thread must call the ``rte_rcu_qsbr_thread_online()`` API to start
 reporting its quiescent state.
 
 Some of the use cases might require the reader threads to make blocking API
-calls (for example while using eventdev APIs). The writer thread should not
-wait for such reader threads to enter quiescent state.  The reader thread must
-call ``rte_rcu_qsbr_thread_offline()`` API, before calling blocking APIs. It
-can call ``rte_rcu_qsbr_thread_online()`` API once the blocking API call
+calls (for example, while using eventdev APIs). The writer thread should not
+wait for such reader threads to enter quiescent state. The reader thread must
+call the ``rte_rcu_qsbr_thread_offline()`` API before calling blocking APIs. It
+can call the ``rte_rcu_qsbr_thread_online()`` API once the blocking API call
 returns.
 
 The writer thread can trigger the reader threads to report their quiescent
@@ -147,13 +147,13 @@ state by calling the API ``rte_rcu_qsbr_start()``. It is possible for multiple
 writer threads to query the quiescent state status simultaneously. Hence,
 ``rte_rcu_qsbr_start()`` returns a token to each caller.
 
-The writer thread must call ``rte_rcu_qsbr_check()`` API with the token to
-get the current quiescent state status. Option to block till all the reader
+The writer thread must call the ``rte_rcu_qsbr_check()`` API with the token to
+get the current quiescent state status. The option to block till all the reader
 threads enter the quiescent state is provided. If this API indicates that
 all the reader threads have entered the quiescent state, the application
 can free the deleted entry.
 
-The APIs ``rte_rcu_qsbr_start()`` and ``rte_rcu_qsbr_check()`` are lock free.
+The APIs ``rte_rcu_qsbr_start()`` and ``rte_rcu_qsbr_check()`` are lock-free.
 Hence, they can be called concurrently from multiple writers even while
 running as worker threads.
 
@@ -171,7 +171,7 @@ polls till all the readers enter the quiescent state or go offline. This API
 does not allow the writer to do useful work while waiting and introduces
 additional memory accesses due to continuous polling. However, the application
 does not have to store the token or the reference to the deleted resource. The
-resource can be freed immediately after ``rte_rcu_qsbr_synchronize()`` API
+resource can be freed immediately after the ``rte_rcu_qsbr_synchronize()`` API
 returns.
 
 The reader thread must call ``rte_rcu_qsbr_thread_offline()`` and
@@ -179,9 +179,9 @@ The reader thread must call ``rte_rcu_qsbr_thread_offline()`` and
 quiescent state. The ``rte_rcu_qsbr_check()`` API will not wait for this reader
 thread to report the quiescent state status anymore.
 
-The reader threads should call ``rte_rcu_qsbr_quiescent()`` API to indicate that
+The reader threads should call the ``rte_rcu_qsbr_quiescent()`` API to indicate that
 they entered a quiescent state. This API checks if a writer has triggered a
-quiescent state query and update the state accordingly.
+quiescent state query and updates the state accordingly.
 
 The ``rte_rcu_qsbr_lock()`` and ``rte_rcu_qsbr_unlock()`` are empty functions.
 However, these APIs can aid in debugging issues. One can mark the access to
@@ -199,42 +199,71 @@ the application. When a writer deletes an entry from a data structure, the write
 #. Should check if the readers have completed a grace period and free the resources.
 
 There are several APIs provided to help with this process. The writer
-can create a FIFO to store the references to deleted resources using ``rte_rcu_qsbr_dq_create()``.
+can create a FIFO to store the references to deleted resources using
+``rte_rcu_qsbr_dq_create()``.
 The resources can be enqueued to this FIFO using ``rte_rcu_qsbr_dq_enqueue()``.
-If the FIFO is full, ``rte_rcu_qsbr_dq_enqueue`` will reclaim the resources before enqueuing. It will also reclaim resources on regular basis to keep the FIFO from growing too large. If the writer runs out of resources, the writer can call ``rte_rcu_qsbr_dq_reclaim`` API to reclaim resources. ``rte_rcu_qsbr_dq_delete`` is provided to reclaim any remaining resources and free the FIFO while shutting down.
+If the FIFO is full, ``rte_rcu_qsbr_dq_enqueue()`` will reclaim the resources
+before enqueuing.
+It will also reclaim resources on a regular basis to keep the FIFO from growing
+too large. If the writer runs out of resources, the writer can call
+``rte_rcu_qsbr_dq_reclaim()`` API to reclaim resources.
+``rte_rcu_qsbr_dq_delete()`` is provided to reclaim any remaining resources and
+free the FIFO while shutting down.
 
-However, if this resource reclamation process were to be integrated in lock-free data structure libraries, it
-hides this complexity from the application and makes it easier for the application to adopt lock-free algorithms. The following paragraphs discuss how the reclamation process can be integrated in DPDK libraries.
+However, if this resource reclamation process were to be integrated in lock-free
+data structure libraries, it hides this complexity from the application and
+makes it easier for the application to adopt lock-free algorithms.
 
-In any DPDK application, the resource reclamation process using QSBR can be split into 4 parts:
+The following paragraphs discuss how the reclamation process can be integrated
+in DPDK libraries.
+
+In any DPDK application, the resource reclamation process using QSBR can be
+split into 4 parts:
 
 #. Initialization
-#. Quiescent State Reporting
-#. Reclaiming Resources
+#. Quiescent state reporting
+#. Reclaiming resources
 #. Shutdown
 
-The design proposed here assigns different parts of this process to client libraries and applications. The term 'client library' refers to lock-free data structure libraries such at rte_hash, rte_lpm etc. in DPDK or similar libraries outside of DPDK. The term 'application' refers to the packet processing application that makes use of DPDK such as L3 Forwarding example application, OVS, VPP etc..
-
-The application has to handle 'Initialization' and 'Quiescent State Reporting'. So,
-
-* the application has to create the RCU variable and register the reader threads to report their quiescent state.
-* the application has to register the same RCU variable with the client library.
-* reader threads in the application have to report the quiescent state. This allows for the application to control the length of the critical section/how frequently the application wants to report the quiescent state.
-
-The client library will handle 'Reclaiming Resources' part of the process. The
-client libraries will make use of the writer thread context to execute the memory
-reclamation algorithm. So,
-
-* client library should provide an API to register a RCU variable that it will use. It should call ``rte_rcu_qsbr_dq_create()`` to create the FIFO to store the references to deleted entries.
-* client library should use ``rte_rcu_qsbr_dq_enqueue`` to enqueue the deleted resources on the FIFO and start the grace period.
-* if the library runs out of resources while adding entries, it should call ``rte_rcu_qsbr_dq_reclaim`` to reclaim the resources and try the resource allocation again.
-
-The 'Shutdown' process needs to be shared between the application and the
-client library.
-
-* the application should make sure that the reader threads are not using the shared data structure, unregister the reader threads from the QSBR variable before calling the client library's shutdown function.
-
-* client library should call ``rte_rcu_qsbr_dq_delete`` to reclaim any remaining resources and free the FIFO.
+The design proposed here assigns different parts of this process to client
+libraries and applications. The term "client library" refers to lock-free data
+structure libraries such as ``rte_hash``, ``rte_lpm`` etc. in DPDK or similar
+libraries outside of DPDK. The term "application" refers to the packet
+processing application that makes use of DPDK such as L3 Forwarding example
+application, OVS, VPP etc.
+
+The application must handle "Initialization" and "Quiescent State Reporting".
+Therefore, the application:
+
+* Must create the RCU variable and register the reader threads to report their
+  quiescent state.
+* Must register the same RCU variable with the client library.
+* Note that reader threads in the application have to report the quiescent
+  state. This allows for the application to control the length of the critical
+  section/how frequently the application wants to report the quiescent state.
+
+The client library will handle the "Reclaiming Resources" part of the process.
+The client libraries will make use of the writer thread context to execute the
+memory reclamation algorithm. So, the client library should:
+
+* Provide an API to register an RCU variable that it will use. It should call
+  ``rte_rcu_qsbr_dq_create()`` to create the FIFO to store the references to
+  deleted entries.
+* Use ``rte_rcu_qsbr_dq_enqueue()`` to enqueue the deleted resources on the FIFO
+  and start the grace period.
+* Note that if the library runs out of resources while adding entries, it should
+  call ``rte_rcu_qsbr_dq_reclaim()`` to reclaim the resources and try the
+  resource allocation again.
+
+The "Shutdown" process needs to be shared between the application and the
+client library. Note that:
+
+* The application should make sure that the reader threads are not using the
+  shared data structure, unregister the reader threads from the QSBR variable
+  before calling the client library's shutdown function.
+
+* The client library should call ``rte_rcu_qsbr_dq_delete()`` to reclaim any
+  remaining resources and free the FIFO.
 
 Integrating the resource reclamation with client libraries removes the burden from
 the application and makes it easy to use lock-free algorithms.
-- 
2.51.0

