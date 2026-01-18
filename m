Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03FBC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C10740E0A;
	Sun, 18 Jan 2026 20:13:42 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id E288340DD8
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:40 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8768225837so497614566b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763620;
 x=1769368420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bu12+8AJls07NbcaACdFjX2Gxn/91E9ijgO3U0VVin8=;
 b=VPv8/+3gRHlEEbkDxz/k1crhcxvrUUxDaPXsXw32NX4axiF8fWBXxPWg6NVIOfne/M
 wrN877z7gD8ksm0XEJIMutTjEZrUJKGheavsYBfortkZfBG6tscCDDvMeTn/7gE4AnNz
 63tBQELae7h8dN1bfu7pWLXI63oSUTosfuvO+mtLolcqVdHLoB8iQ5e2RMdlOv6ZlJtb
 mGUQt8vDJCmnchQWw8prv4fZMmQGUPvAGtuJZ1VO4Tb5RP16okFBUlFyAE+GchTBlrC9
 D6EU34CFYKJBvgf1UFgy1pM1bhRFrGO8stLCovuBwWg9WiwGaxcoj0iMzCkM3swKCiJR
 VnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763620; x=1769368420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bu12+8AJls07NbcaACdFjX2Gxn/91E9ijgO3U0VVin8=;
 b=qLaQ4dd8PojBtJ22ad316ym0mE+SY8M3utCGaoONl+co978SnSY5Fny6kUarVDySms
 4hQQYgCUNLWuiAeXoXEgKTMIPfoTYfbrmkEYKi0UNEi3h0yhw0AB7DzpJCoewK3YPuS3
 oyIHXGVk9+Aivg8Mx8EtLwdcEFHZ/FEkQP+g2492bSn6D68jxrv/+AdJe+yY4DmG2axM
 yOb23Jz+7It4KcZxd8jD4fLg7lmRgf2vbtajFbJ3pSz8KAYMKcKxkmG/WG7pzUdUsUrT
 n0mTWdGvb26aeRf0IlmzrQ8aRYeQyCvQp26ffeMcNeFW3NeP4nYE/kjMaRjTvDkH0JR/
 LmhQ==
X-Gm-Message-State: AOJu0YzQ3DeVAhsBSL1S6OViB97zxM9Jze9hBH50g/OZE4+uW22V1AnW
 5nO1ru1d/dXkK1wOP0zL+7rKSgcrzm+b4PDSPefzlhYaciODN5iD+ONLcd1lf2DnDZLg/UW9VR4
 Leuwp
X-Gm-Gg: AY/fxX5cehaFEY8qftaXMXFO+airH1CjmfuhQjnu+TfGfosRbF235WSXL8k/tp/reuy
 4967Z25yyB9r4TyUPHfPSLMSRVnboWHdVpWMw3APM0bcrW2/4N1/63adSJOUCczfQMOlqqSkgqz
 F4kwZFjb8fR5H44YXeX9NDozEmHZDnMl+/RynR+e8TzH/G94hsMNueRB7uepRNP63WdxxOci8G1
 cnqb/W4JsrsRoeT0BixWr/F44bcpL8/VCmSNWrfLLWzIN+Tt9vG5ot0hmJTK8cPgOYPY9CKXUL7
 jfEidhFlkunJJ+ZrKM8+O6SkeXDiWCYtN89oPQwjT/PhfjrQCSfEsMsVCfZAPP1DYZB3xYoDxNN
 bn4cshLECBGfUu5788kKlREPnkhEF9QMyXL22TfUAUirbKUC1HwhQd4IvqtydfNMakmElY2+2jv
 nbstf8mhFFP43JtTOFZbuh0XmKhTMeh277t8Fesf2K2b9hu/VEWw==
X-Received: by 2002:a17:906:4793:b0:b87:1fb:8369 with SMTP id
 a640c23a62f3a-b879324c8aamr779174466b.57.1768763620412; 
 Sun, 18 Jan 2026 11:13:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 07/54] doc: correct errors in stack library guide
Date: Sun, 18 Jan 2026 11:10:10 -0800
Message-ID: <20260118191323.241013-8-stephen@networkplumber.org>
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

Change several errors in the stack library documentation:

- Change grammar: "These function are" -> "These functions are"
- Change grammar: "incorrect change" -> "incorrectly change"
- Change RST section hierarchy: "Implementation" was marked as a
  subsection (~~~~) but contained sections (----); corrected so
  Implementation is a section and Lock-based/Lock-free stack are
  subsections beneath it
- Change inconsistent header capitalization: "Lock-based Stack" and
  "Lock-free Stack" -> lowercase "stack" to match other DPDK docs
- Change awkward wording: "this algorithm stack uses" -> "this algorithm
  uses"
- Change inconsistent underline lengths in RST headers
- Add code formatting to function name: rte_stack_create() with
  backticks and parentheses
- Change hyphenation: "multi-threading safe" -> "multi-thread safe"
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

