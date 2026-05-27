Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F0CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 16:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2CDF4026C;
	Wed, 27 May 2026 18:37:41 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 3F7004014F
 for <dev@dpdk.org>; Wed, 27 May 2026 18:37:40 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so4109409eec.1
 for <dev@dpdk.org>; Wed, 27 May 2026 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779899859;
 x=1780504659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eJgzsP3pRRPb5HiEKLZmQuHWRH10X/4P+Gt/qCqNaWc=;
 b=AnqE/DMV31AaarCJxaQfqRGoRsTpFTaKqkFmH9PgHiQgqxMntPytT1EfgYwvda7rmi
 te0ymc7ZW6uCiLFnFaun4X4hFAy97XNUrcyzNk8w6eSal9FHMhzY9zWR/3k1Yw24jH6j
 GYPW+ENS0DVz+2wKTyjkU9EP0BzhJNIjOgMhwqWEBlTg9yXi6/VNs7NUkhIfrPnL4+Yb
 IcavVVzvbVjPVZHADN0deRkh8Zo6r6grBdMLLvzqBusdeew/+M+M3za2Knwn0QWXEOTO
 fXhquVG606dT+i1Of4U4GKjF0nXaQbdcCFWJfIUqZeZpcWOK9Ql2fe7OgfiBGLiNcdIa
 VnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899859; x=1780504659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJgzsP3pRRPb5HiEKLZmQuHWRH10X/4P+Gt/qCqNaWc=;
 b=V7CyEV27Q9abmhVuO14p5BEtga+wxqJ2CSf1k7Uh188/zFt3fw9YvTG7InTobgit03
 cV/ltviz5NIijboHNe5Tc23dA/WYcOQOXs+QU00Elf9QkusI3jaC4CDjIKZF/wsg0kub
 P4Up7ZTaZfXKVWq7tuyZzRum9vJjgDv+k0lwl9Ow7lRcccqjF6YgiAkuV3TYi5/PSt/E
 F2T7w+z5TqN3VyVZvoqWtEHTPyn4/xXrc9IGtRg+xczJGBZda9ov9qF7bp3X1Rqmy0qH
 yhpA5jPl9xVlgY25JZvnVRRXNzy6I/G6TP4TuAj6/L4I9NUBm3jemE66wBlXEMC47anK
 hSfw==
X-Gm-Message-State: AOJu0Yx0ioMkYukw79KadElviDs9B6jYXxPBPjav+t1rPYwaCJnatDfP
 LZzo4f2J6RH5f4e1gW4sWFrsSDXsLXl9qV96Th+2NudGECpKkuMZpqUoj9atZHm01P91erDJ09E
 GoM4A
X-Gm-Gg: Acq92OF9o9B+YLGH6xkTWtoJ9HiihXzxNwIz0X/uXsttvdBpDUyH7N9ZQm6jdTqiabb
 cJVSqEFp1XY0Y50C8Cz0i4KHvh1ZgCkpWcVZpThn85Cp1henM3Gh2WKKEPHKv3QOBgAgwJGtCMz
 xQPMahLTNJnIIT8Kfty/YW/awEuYTzm2nBGZg+exZRH0gufoB/CSAgkTmdjdNat3efa0N27TLWt
 u5pBjfoFNudFa6sn4iMNHlzJwpKj5KJUou+SZY9EsZy9Vevmx+ZJZf/hNnZrX87aeZ2jSNDZ0dI
 ErlE+arV4bC1IDHkRXuZY+6ovuGzuTivwSdQVLMcU5GbhAdjyUYZQ0JnmEGoezKtfh50LOf/3cR
 FLfH2tCPW9UlmmOi5QXDWiSLdWSWiM5m5pNECKLP+PrQbfhCNgjIdfV5rD9SND9WdTIwwXo8iJH
 e1Zo8lLqfAngunMtsMCqQOeBNBzcphGOGon/tPtxtASO+rW0kXYXJEndANh5k+eA==
X-Received: by 2002:a05:693c:830e:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-3046d184051mr4608994eec.0.1779899858811; 
 Wed, 27 May 2026 09:37:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30458ab1a46sm13205447eec.24.2026.05.27.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:37:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC] doc, devtools: discourage new __rte_always_inline
Date: Wed, 27 May 2026 09:37:33 -0700
Message-ID: <20260527163734.599602-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Modern compilers at -O2 make good inlining decisions for small
static inline functions; forced inlining via __rte_always_inline
should be reserved for cases where it is required for correctness
or for documented measured performance reasons.

Document the policy in the coding style guide and add a
checkpatches.sh entry that warns when new uses of the attribute
are introduced.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh                 |  8 ++++++++
 doc/guides/contributing/coding_style.rst | 25 +++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index f5dd77443f..2a3d364178 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -137,6 +137,14 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
+	# forbid new use of __rte_always_inline
+	awk -v FOLDERS="lib drivers app examples" \
+		-v EXPRESSIONS='\\<__rte_always_inline\\>' \
+		-v RET_ON_FAIL=1 \
+		-v MESSAGE='Adding __rte_always_inline; prefer plain inline' \
+		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
+		"$1" || res=1
+
 	# refrain from using compiler __rte_atomic_thread_fence()
 	# It should be avoided on x86 for SMP case.
 	awk -v FOLDERS="lib drivers app examples" \
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 243a3c2959..97e459853c 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -747,11 +747,34 @@ Static Variables and Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 * All functions and variables that are local to a file must be declared as ``static`` because it can often help the compiler to do some optimizations (such as, inlining the code).
-* Functions that should be inlined should to be declared as ``static inline`` and can be defined in a .c or a .h file.
+* Functions that should be inlined should be declared as ``static inline`` and can be defined in a .c or a .h file.
 
 .. note::
 	Static functions defined in a header file must be declared as ``static inline`` in order to prevent compiler warnings about the function being unused.
 
+Use of ``__rte_always_inline``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``__rte_always_inline`` attribute forces the compiler to inline a function regardless of its size or call-graph heuristics.
+Prefer plain ``inline`` (or no annotation at all for static functions) and let the compiler decide.
+Modern compilers at ``-O2`` make good inlining decisions for small ``static inline`` functions in headers,
+and forced inlining can hurt performance by inflating function bodies, increasing register pressure, and overriding profile-guided optimization.
+
+``__rte_always_inline`` should only be used when one of the following applies:
+
+* The function contains ``__builtin_constant_p`` checks that gate a constant-folded fast path, and the optimization is lost if the function is not inlined into the caller.
+  Examples include byte-order helpers and length-dispatched copy/compare routines.
+
+* The function wraps inline assembly or a compiler intrinsic whose correctness depends on being inlined into the caller's register context (for example, intrinsics requiring a compile-time constant argument).
+
+* Measurement on a representative workload shows that the annotation is required to retain performance, and the reason is documented in the commit message that introduces it.
+
+Each use must be justified at the point it is introduced. Adding ``__rte_always_inline`` because nearby code uses it is not a justification;
+if the constant or intrinsic that requires inlining is several call levels up the call chain,
+restructure the code rather than annotating the entire chain.
+
+The complementary attribute ``__rte_noinline`` is useful for explicitly marking cold paths (error handling, initialization, slow-path fallbacks) where outlining the function can reduce instruction-cache pressure on the hot path.
+
 Const Attribute
 ~~~~~~~~~~~~~~~
 
-- 
2.53.0

