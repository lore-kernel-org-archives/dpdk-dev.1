Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F0AD30CDB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B23440A72;
	Wed, 14 Jan 2026 00:01:18 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DCBAD40A7A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:16 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso48759195e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345276;
 x=1768950076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MakR9InelqrDorD+JLLKYj+AXUTchOxsEvX7xO+pBf8=;
 b=26nR1hKUE3+ST5iJN1f1ZVD3ltNLsmsxhZVp3TU5vSom84LsWlnXuriVJDqTao/8bX
 YBZtZz02UCdtA8wftbTsQqh+DP88UMspfd2dZorpnXPNM2oPV1aJqDP+9AJZRvi56amd
 Dav/sjStgNXhgWFRkBnoeO9yg2cxw9gZLyWJbyrVLiiVPHcvbYFFthnLz+4lmHM1Iv+x
 TYhvr/SHPkPSPmkQ3g9/KrvI8zgSsIvgEpEEXRRXfn2zV1qco/cLc1WOKFbFuHYP0Drr
 mr/ZfkAaLaPYjej6loLjDdyCY1Fx1D5meJ6zh+ZVTb7w7CPgt0U2UlpVPN8nfNsUz9vf
 d7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345276; x=1768950076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MakR9InelqrDorD+JLLKYj+AXUTchOxsEvX7xO+pBf8=;
 b=oIAeNJAioQj4b8qpyEKibYVq60Lorx6Qm8K9JtrqL4MP4LderojeJ0ywdYvBM1rAWe
 X7R7yvpASUGewL3wggxHipcCBl57gE4SmVZFUf8YalkRXte5geAxscEXehvYTuGyKFMJ
 SqSKH775hfwPXRQNQ9Lb0eD6dyN3rNAd7gU8fq1gkoTbWcvpJZwZSCtt2VDF47Hyi1ch
 IekOXdv7H2m6KynwlYuiLwWJm0De5vFt3OXbwBc00pyDm7PWp9ZpTaRHTxaf5jW5EZ0J
 Wep3ZWyEmvxNorJyzo+7daFQN5ALaZjpGh/lnLXa41pc2XyEKfoVSBJb4sM1rrK2EYeh
 RKtQ==
X-Gm-Message-State: AOJu0YxeQpcHxNYvBePE8gezBJi5yloaUXQccCZloOF13mF8Eo6BTfgK
 2ZfX2Fwg5IQAJhWibVMF13AZ+BXleoSLav/dzDqTU44yEa9NZ8vX4DXw5Q+duq8mp/OgZSNlPyd
 GWFQ9
X-Gm-Gg: AY/fxX5fFOCf0VgGUqybPGaII2zwy2n6NwpvyG11gnRjKiPZMI8k+NCUIV+DMFuDVnL
 p08/HHsgWlhdT0FVK9cj61t2gznnOPklMhMy1qcpUplNuGURpqtbAJUPMSnnqsvk4OBn0U78D0b
 mYQdNQJNw6hnWsPym1S3KxK5GSl04t06CMJ99YC9XunozStu7oCWiBVBqDDfCvwdKSpeLRq2Rlx
 K7Y36FooEDPLoN41zXzVE3pWYa1wJjcaR+s9Rbk6n8hlpSX5IVAccBUIhRM4T7f7az5J/43kc/N
 IjQwUuwlA8oC4ReL9wblLtN8seAHjKiezJYFeBEJsokv6WbhMag48+WK1ts/NBLaHchn0Xm77rX
 pBCDn6YNlRwJh2jute2sms6tiuoNQjkiydg8UWczFJdOVJQj3O9FbUHKtaHkIWGYLEL7oV2d7+j
 Qj+jA+8wsXFPFViTMKidXMnPHsRyHZEOFTZsL4J7G3TFoTGvSxCLq047Rltb1P
X-Received: by 2002:a05:600c:37cd:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-47ee4819eabmr1535115e9.19.1768345276212; 
 Tue, 13 Jan 2026 15:01:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 10/11] doc: correct errors in stack library guide
Date: Tue, 13 Jan 2026 14:51:12 -0800
Message-ID: <20260113230052.54435-11-stephen@networkplumber.org>
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

