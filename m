Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0259DD3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2914D427AE;
	Wed, 14 Jan 2026 23:28:48 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 297244114B
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:47 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2755525e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429727;
 x=1769034527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MakR9InelqrDorD+JLLKYj+AXUTchOxsEvX7xO+pBf8=;
 b=dCez+ZA2hHiN/Dd7uD5EW4+AEZxDZFmWQrExG2UGxwtSljVFt4wKpptJuBNqfyUQnK
 mDhYBWq5PzClsl55tNaFI6tVerahBPMaeD4tzsnGbEOtiCcuiifDkxj14H5aQipfZXc6
 jeZtp/piOdUfQ7KxuepEgUveG+84uS7irFyMBy4eVRWkIlWE7svCJ6TlX9sof+VMhoG7
 tR0LFxiBp4SxC1dhx7cq8GE2MlXaYtwIceb3cxM9/3T6htjQPi/u3gxYC1QOLMwC+qBm
 WlI+yuvvVD33/GnHrznH7VwkdrUe8njmS8IjCUPA8fCoF31G+uHMtqJpE8OVU6rF+1pX
 3iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429727; x=1769034527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MakR9InelqrDorD+JLLKYj+AXUTchOxsEvX7xO+pBf8=;
 b=AeLoTGmhPEUpff2FQbChTAoYxAcTurBCEFc0zU/I7PfsQvWzkqIKKlKykS5tx2Xto/
 B49v4OAVKChJtl6BZTIc1Iur0/vjpQjfUZ0hZ3MXPZSlp3Zc+ZHqLZ+hckqBOQgksja1
 De7/8M+6GQ1OpTiK7Ch5nFIfuzZNZBz+psrkq/MQuCM8CXJ4XKsmyikjTeFHNP9WBhas
 h6DHxNPAHP/JxBHhN/rjCaRK/C5np9NYrKOdmDCCbD9M0wuaAwQerdh3D4sWAh8Bzhdk
 uqsVYJvBHccDmqOe6Dd+Mj07ZQ2dnNv0AjFOftQgZ0fu5lGCMXcvEAXQKeKNOldiY3fl
 IHMg==
X-Gm-Message-State: AOJu0YxlFgu3uaHHe/xBMg7G/b8zUpytX0F7CPHVqMhqWZGorgOj3IPS
 FRBZdLz4ys9gnQHVzg/qDXG4/XMyKvoqjRSgvpyTeRlpcorPNgQidXdrfuSET1RUPJ3POC4KQH3
 V3zsV
X-Gm-Gg: AY/fxX5mhwitSPWvlYMHYnI2Ff0zlC3KsF7PiIEcwPl6hMVAwGSRvHTS78+hO7XkirJ
 UY69KwSXZdbIiaHtM1tXgRt3VQGdSUwslWi4qwVeLiePmo9De/rfNWJwzzNJLVoNozJlAKaVh4m
 53RypgNDhldDU7fAiaA9hHn1ym5bv7VCueIeGoxlyILyzeFaNhgT58yt9hR4SsCWCnMIn9urjxQ
 OrK5/2ijWkGQ5lsYqydaKPaiprULfMM11McV3Q7j1yly+jAN38nMVm2860J3HONy/WMcsf6Q8JV
 fSykJGfM5oj7BfbF41Zq1ckAgF33IB7sqDwzSoiXWq51s8MimMmDX1ujakDSFZO0UoCOBgzkou8
 +O8la3GG5LIwNIVphMTaZyVWggLLkxKio6OFoXXwMU860TaRyWv4P21Ls9KcIXfIgAMqs1BsKZK
 97qAoKdBBgyHTWU0OTp/GKQBCy6sGZgw1LDzVJK2Bdu4gXcJ57mQ==
X-Received: by 2002:a05:6000:25c8:b0:431:6ba:38bd with SMTP id
 ffacd0b85a97d-4342c3ef27fmr4998872f8f.10.1768429726790; 
 Wed, 14 Jan 2026 14:28:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 10/11] doc: correct errors in stack library guide
Date: Wed, 14 Jan 2026 14:27:02 -0800
Message-ID: <20260114222821.87920-11-stephen@networkplumber.org>
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

Fix several errors in the stack library documentation:

- Fix grammar: "These function are" -> "These functions are"
- Fix grammar: "incorrect change" -> "incorrectly change"
- Fix RST section hierarchy: "Implementation" was marked as a
  subsection (~~~~) but contained sections (----); corrected so
  Implementation is a section and Lock-based/Lock-free stack are
  subsections beneath it
- Fix inconsistent header capitalization: "Lock-based Stack" and
  "Lock-free Stack" -> lowercase "stack" to match other DPDK docs
- Fix awkward wording: "this algorithm stack uses" -> "this algorithm
  uses"
- Fix inconsistent underline lengths in RST headers
- Add code formatting to function name: rte_stack_create() with
  backticks and parentheses
- Fix hyphenation: "multi-threading safe" -> "multi-thread safe"
  (matches line 37 usage)

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/stack_lib.rst | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/guides/prog_guide/stack_lib.rst b/doc/guides/prog_guide/stack_lib.rst
index 975d3ad796..1ca9d73bc0 100644
--- a/doc/guides/prog_guide/stack_lib.rst
+++ b/doc/guides/prog_guide/stack_lib.rst
@@ -13,8 +13,8 @@ The stack library provides the following basic operations:
    user-specified socket, with either standard (lock-based) or lock-free
    behavior.
 
-*  Push and pop a burst of one or more stack objects (pointers). These function
-   are multi-threading safe.
+*  Push and pop a burst of one or more stack objects (pointers). These functions
+   are multi-thread safe.
 
 *  Free a previously created stack.
 
@@ -23,15 +23,15 @@ The stack library provides the following basic operations:
 *  Query a stack's current depth and number of free entries.
 
 Implementation
-~~~~~~~~~~~~~~
+--------------
 
 The library supports two types of stacks: standard (lock-based) and lock-free.
 Both types use the same set of interfaces, but their implementations differ.
 
 .. _Stack_Library_Std_Stack:
 
-Lock-based Stack
-----------------
+Lock-based stack
+~~~~~~~~~~~~~~~~
 
 The lock-based stack consists of a contiguous array of pointers, a current
 index, and a spinlock. Accesses to the stack are made multi-thread safe by the
@@ -39,13 +39,13 @@ spinlock.
 
 .. _Stack_Library_LF_Stack:
 
-Lock-free Stack
-------------------
+Lock-free stack
+~~~~~~~~~~~~~~~
 
 The lock-free stack consists of a linked list of elements, each containing a
 data pointer and a next pointer, and an atomic stack depth counter. The
-lock-free property means that multiple threads can push and pop simultaneously,
-and one thread being preempted/delayed in a push or pop operation will not
+lock-free property means that multiple threads can push and pop simultaneously.
+One thread being preempted/delayed in a push or pop operation will not
 impede the forward progress of any other thread.
 
 The lock-free push operation enqueues a linked list of pointers by pointing the
@@ -65,15 +65,15 @@ allocated before stack pushes and freed after stack pops. Since the stack has a
 fixed maximum depth, these elements do not need to be dynamically created.
 
 The lock-free behavior is selected by passing the *RTE_STACK_F_LF* flag to
-rte_stack_create().
+``rte_stack_create()``.
 
-Preventing the ABA Problem
+Preventing the ABA problem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-To prevent the ABA problem, this algorithm stack uses a 128-bit
-compare-and-swap instruction to atomically update both the stack top pointer
-and a modification counter. The ABA problem can occur without a modification
-counter if, for example:
+To prevent the ABA problem, this algorithm uses a 128-bit compare-and-swap
+instruction to atomically update both the stack top pointer and a modification
+counter. The ABA problem can occur without a modification counter if, for
+example:
 
 #. Thread A reads head pointer X and stores the pointed-to list element.
 
@@ -83,7 +83,7 @@ counter if, for example:
 #. Thread A changes the head pointer with a compare-and-swap and succeeds.
 
 In this case thread A would not detect that the list had changed, and would
-both pop stale data and incorrect change the head pointer. By adding a
+both pop stale data and incorrectly change the head pointer. By adding a
 modification counter that is updated on every push and pop as part of the
 compare-and-swap, the algorithm can detect when the list changes even if the
 head pointer remains the same.
-- 
2.51.0

