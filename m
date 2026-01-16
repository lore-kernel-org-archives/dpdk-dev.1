Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFCC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F3A42EA1;
	Fri, 16 Jan 2026 21:17:51 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 3ECDB42E91
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:49 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso512756166b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594669;
 x=1769199469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rn58jYyg+elowINAy1l/kqRiUZnsOKFZKYd+1TXTMq4=;
 b=rAfTTLh8qNllfDoMK/q30G1LPYpWMECOjAemvpfsEXl21IO7DGyMkPK+yHViPcQFwI
 o306SoPB1CCOBttF9L1CvOmX0tScSrAsT5G2+G7HLUXB59GGPGMSKm1DEE2vqjxAHGIf
 sibCySSLcqPgq4sebRO+LffF3GUn25Lu/a1sYnuCUk12jwln6yxlOpGYUSFX0bKWzob5
 GcPpMoSLeLv/Y4h6vU/YSoVz8GOAMfQ/BlfWCbeO1yA6OKOJ/2loRNklYFwrqo2Y5xD/
 huOJhd5FRS/AnT/jjan9MbxeK5RB01lAZ5+yuKqs+G250DUSaNmPcwja+z/vIkIqzxiY
 HDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594669; x=1769199469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rn58jYyg+elowINAy1l/kqRiUZnsOKFZKYd+1TXTMq4=;
 b=HBhFeYbLH7nY3E2KFbdlANOxkaOT9z/sQNBZCFph8ul3052Yw4MZ9BZR07c4F3bKau
 TAdMVF0GoMVnoIuMx7Iycn1XmHjjEwejgyj04hjqd6WVi2hU70evflPpY2SsOYxFiO11
 BVMyY/0XrR9guvGnSzzDfdlQi3ZDQ0H7wNSL6GWZYW1FUBq4m/RltWI4BwB/BO1hD+b/
 BTt6237ROC/u11qQCbx5lb3Zj7CthN4O6ulXPuwDTq5gBpKxoWC8hAD59OtIC9O5bRMZ
 cg5WgpaZs6kkZrJ1Dx5d1B79X54fUWaaIE0ueL+1PYPt70S0jl542VQFml22Ek9gmcBv
 3jjQ==
X-Gm-Message-State: AOJu0YyHaMogY/HzlIG4vu1tHvTXvKze5gu3ul4C4vK1i/hE2CQSM7DM
 DSAhQ2h+85MjScH0+eAPz9xV6abaREwpv2gEC+IfSMFCmLZm4bNVddPkgci7FGHXgEjlrrbmQ02
 7A/5g
X-Gm-Gg: AY/fxX6GyQmnPgaJgTBbFZau6eHI8hRXmnjzZeKSyiMvpUSSAfXgneDzQKrHGz7bExQ
 ujbXUeRdN+xy5RNhsMWem/b/ZWvgS1683AEeEfqvRbY4Yv3BbtknBq0Me/ecOypQeACAvtPhd7X
 cLzbgZNCzuy50MvscOLh2ahZ/wV3eSRDCh074mWI55AuaJbaF+3r+EmhCF58V7l7QwtXSFNmiVA
 AfYNNdqZzgfMu7Sn0NfiXHsQSsIcEaTnIZDvfZIcbvgvUCvZuC8357ESPDECsSxK8kauxwjdQji
 e21HDpAOm5MRWxoTMbp2Gv/5wcGHdzXVl0bccMOv1UgIO4xrHhgToJjSIllMC9BF+TGO28SZkZY
 YdJ5neaYjkERbYkN/AcUtS4OyBDIFCF/VAAJ6xCxQO2lVQ2mj/sn/kUZ3y6EU2wvG9TzWkPH7S5
 UPkqDAeONrFmIAcPEsHl3OlS5Qgd1JkqqNeAkuptzvR2lAQGOmCQ==
X-Received: by 2002:a17:907:6ea8:b0:b87:59a8:4c8 with SMTP id
 a640c23a62f3a-b8793857864mr374239066b.5.1768594668759; 
 Fri, 16 Jan 2026 12:17:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 03/12] doc: improve coding style guide readability
Date: Fri, 16 Jan 2026 12:14:21 -0800
Message-ID: <20260116201738.74578-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

