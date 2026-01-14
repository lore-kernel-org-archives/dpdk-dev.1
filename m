Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67513D3CC87
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32AB74278A;
	Wed, 14 Jan 2026 23:56:08 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 3CF46410D2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:05 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso2919535e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431365;
 x=1769036165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rn58jYyg+elowINAy1l/kqRiUZnsOKFZKYd+1TXTMq4=;
 b=0bR8h+P8xns3dvb50fz0sbBEkl45uX91J7GJyqywFttUtNGjH3L7YwxKLqYlpD8Bil
 +wddeU8FfjJr9XYzLH5WYVowfGWIUvfNyo+3oS3hIA39gX5ddvODMCCdMOLU6XzANDlG
 dp+Boze7by+6fU1ZEv/Q6nPGQ/Y+n7iKOn+BoqXfDb3sfM46QTT3yyGmttvqaWhL1k1y
 C4NhrOISojquRJssddQ2UWgz9M5YXmnRGhmoEEN+eZzrbbm3mwNXYi5F9rb2SLHspOU2
 u0I2nAzeNJhgVMhbdNhJok67Lq3UNHwYZO4zYNs8RP39zFEO90yp6QEl/cUX6CsG97WQ
 3BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431365; x=1769036165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rn58jYyg+elowINAy1l/kqRiUZnsOKFZKYd+1TXTMq4=;
 b=THAtvdSiQNVQjiJBaIPxEhhwjWOpSkuT0p1QlCMx8QNh8hNFX7RSfHmPj8QCAqk2io
 ygTy+ZSDcuJB8CLlDIud6k3BtltbfvEk6moAQoaiB6xF+chWgzspes9l8a0h8zkT/vDP
 lxuF3i6v4pKAYDnhy3wDwHFosfxiSU2unS9lr4hZVZCfjFE9cYpCSDIRYWdYZVDQq/mr
 avkEizSMJyBe/qLoTFfeLBlA2S+4LoOQNCulKlGS0aoMICCFOa0YNWHbOP4PWEZ4NuxG
 EasGcAbn0LHt++bkA/OXOZK5hvsgeHP0c6DwI0w0bVeKppjrTu5L5IAa9zDWKINF0R41
 wjqg==
X-Gm-Message-State: AOJu0YxZDS2+clIFbLgLV9uUe+jyG0zgRkP6F7KvdaTt5Bjy7h9aXmox
 nmDFmhCV+i+XXcINDSKSKxsZLyzgdijZUrBmZa4beMGGrDe1KxUWMY7q47nOCfSNwxpvqZQSokp
 DzLOl
X-Gm-Gg: AY/fxX5RmxYMsfnucGcrxxkQjNELXwXJ4+aSEh//1T+uIlpp4yGivEFTPRjWjlh7v1A
 RqOdj/H5rHctExfDZ48j+Hb9iSpIKBlUs+cxuKJgtE4+GzXeT/Xw+12Ho7rnpBuBPdYOdE3HTsg
 Ib5e+pqU7apYPvv3hdvnteU937VjEFdIQ5kG716BpLKV1BVqtbdZcbdOl+m5wXATE8eTRVur4rx
 HFvwPfDiYxYRTM7EAQEjEpnRrFrfJVUzAES0Yf+mGoMlc/LDoSKYLgzVYuI3gynRiJymPIp5HqK
 vm4hRnQKb1hMwlaX0KznniQFPc6/LkaCe8hfw8GGUn2XTpNYqkSUPdu27PR8PJ6ypS+sHxmn3qo
 gKZJJE4oUFJnG9D9wtPREGZA/8CQWAO6ApEh4+gixcHc32Rqzxj89h60j6DuvsDlAbrR1lFrHbp
 TqkF+5p64nL32CeQ+NKjpUnRwe/wWppRmvWgG0kIGYJxU5KwCMdg==
X-Received: by 2002:a05:600c:8b55:b0:47e:d774:80a6 with SMTP id
 5b1f17b1804b1-47ee339b71fmr48219055e9.34.1768431364751; 
 Wed, 14 Jan 2026 14:56:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/11] doc: improve coding style guide readability
Date: Wed, 14 Jan 2026 14:54:07 -0800
Message-ID: <20260114225555.127448-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve the coding style documentation
- Converting passive voice to active voice
- Using imperative mood for instructions
- Simplifying redundant phrasing
- Clarifying guidance on bool usage in structures

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/coding_style.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 243a3c2959..898c84ceec 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -9,8 +9,8 @@ DPDK Coding Style
 Description
 -----------
 
-This document specifies the preferred style for source files in the DPDK source tree.
-It is based on the Linux Kernel coding guidelines and the FreeBSD 7.2 Kernel Developer's Manual (see man style(9)), but was heavily modified for the needs of the DPDK.
+This document specifies the preferred style for source files in the DPDK source tree,
+based on the Linux Kernel coding guidelines and the FreeBSD 7.2 Kernel Developer's Manual (see man style(9)), but was heavily modified for the needs of the DPDK.
 
 General Guidelines
 ------------------
@@ -95,7 +95,7 @@ Example:
 Header File Guards
 ~~~~~~~~~~~~~~~~~~
 
-Headers should be protected against multiple inclusion with the usual:
+Protect headers against multiple inclusion with the usual:
 
 .. code-block:: c
 
@@ -293,7 +293,7 @@ Structure Declarations
 * In general, when declaring variables in new structures, declare them sorted by use, then by size (largest to smallest), and then in alphabetical order.
   Sorting by use means that commonly used variables are used together and that the structure layout makes logical sense.
   Ordering by size then ensures that as little padding is added to the structure as possible.
-* For existing structures, additions to structures should be added to the end so for backward compatibility reasons.
+* For existing structures, add new members to the end for backward compatibility.
 * Each structure element gets its own line.
 * Try to make the structure readable by aligning the member names using spaces as shown below.
 * Names following extremely long types, which therefore cannot be easily aligned with the rest, should be separated by a single space.
@@ -308,14 +308,14 @@ Structure Declarations
  };
 
 
-* Major structures should be declared at the top of the file in which they are used, or in separate header files if they are used in multiple source files.
+* Declare major structures at the top of the file where they are used, or in separate header files if they are used in multiple source files.
 * Use of the structures should be by separate variable declarations and those declarations must be extern if they are declared in a header file.
 * Externally visible structure definitions should have the structure name prefixed by ``rte_`` to avoid namespace collisions.
 
 .. note::
 
-    Uses of ``bool`` in structures are not preferred as is wastes space and
-    it's also not clear as to what type size the bool is. A preferred use of
+    Avoid using ``bool`` in structures because it wastes space and
+    the type size is unclear. A preferred use of
     ``bool`` is mainly as a return type from functions that return true/false,
     and maybe local variable functions.
 
@@ -584,7 +584,7 @@ C Function Definition, Declaration and Use
 Prototypes
 ~~~~~~~~~~
 
-* It is recommended (and generally required by the compiler) that all non-static functions are prototyped somewhere.
+* Prototype all non-static functions (the compiler generally requires this).
 * Functions local to one source module should be declared static, and should not be prototyped unless absolutely necessary.
 * Functions used from other parts of code (external API) must be prototyped in the relevant include file.
 * Function prototypes should be listed in a logical order, preferably alphabetical unless there is a compelling reason to use a different ordering.
@@ -747,7 +747,7 @@ Static Variables and Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 * All functions and variables that are local to a file must be declared as ``static`` because it can often help the compiler to do some optimizations (such as, inlining the code).
-* Functions that should be inlined should to be declared as ``static inline`` and can be defined in a .c or a .h file.
+* Declare functions that should be inlined as ``static inline`` and can be defined in a .c or a .h file.
 
 .. note::
 	Static functions defined in a header file must be declared as ``static inline`` in order to prevent compiler warnings about the function being unused.
@@ -755,7 +755,7 @@ Static Variables and Functions
 Const Attribute
 ~~~~~~~~~~~~~~~
 
-The ``const`` attribute should be used as often as possible when a variable is read-only.
+Use the ``const`` attribute as often as possible when a variable is read-only.
 
 Inline ASM in C code
 ~~~~~~~~~~~~~~~~~~~~
-- 
2.51.0

