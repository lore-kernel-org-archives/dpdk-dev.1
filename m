Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B2D30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C905240669;
	Wed, 14 Jan 2026 00:01:07 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 8F0DD4066D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:06 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-432d2670932so3826091f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345266;
 x=1768950066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=tlpCFsH9hPdNiBb4n6W11h0nCV/xx/5pJwiMNonKEnwEq+0I16KJI59QzKB6Zu2TB3
 TZZ8x203B4Ybtx28ICn8SAFPztHGU3L17Zovj9He+hOA0omtL1DDXhFiEeDhFMG2yeKd
 ePUdMK+uGDodf8KZlMAuG1/DNSUvtI71YOr8/AOFQWQpv6TJN+rCv6n95pMK1WO3l0ZF
 xS2/7SEnqulipaLchtlX4dlHolXwlRhPFlWXD0e72w1XdUpUifDqTFf9aX7M7Th3iQgr
 W6sncgqGIR9JxUujm9+xLgwyXsbB2EPPb4GJcj2ou0zdALqTUIJdZf3e/rZSfS4a1Zlr
 VlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345266; x=1768950066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=Tk2IAlgnT9nwFiWJDqTkQ9lJTupWE8lF8miB017py8zR6KtEcFqMEAALiHiV76bOIH
 dUSPxcIw8yS0V8wSa24bFvsZ3RZZiThxsT0qIFaamArebY0csFg9IYjTlkMz6cm/so1k
 qB2/v66lHmF1n1D1bQ2uXfAkQGm6KKgxmdz+jMWJT4yEdDP3pOFB7bezLcFdEokfBrZF
 6GOB8GSHWvL2Bc5rrMcXACgVfTrp2p5fJKEc/lFjFEL0/ga32j4lgJ7Cb2y2/PVaRAsD
 k8FzWYyPSeSrWHy2OIv+a/a7fBDQ/a1aSC5WOGlRyazdYo2AHMDQJu3p07R/o/EX/VrM
 V/OA==
X-Gm-Message-State: AOJu0YyrA1xWOajy1eI9lFLGwu3KZ1uypCANrgTxwb/HS1TRizj+/8sK
 n91mML5NsJEBJGKIks8K758v/P87ywJY2nAs3vTG/N5UjBrA0nnhvz8jyzXj6Ono49ZEO8w45y7
 4G0KJ
X-Gm-Gg: AY/fxX6IkxKaJ6gsAhAWVAqY8D39u8uyNw6NlDjXT/W/Dg/aNHsAvzqPvsS3OndQ4ej
 6bK9p3+cQhRqwTwImys0JOxMM0DrfNK61frkZAogvmZ0xyAw+ud1wjX3wkt/HtPrKr1+0/QS6AA
 9HO1PZ6mcaOazLEQ7dhuQjADQsl0hfmCLaecPsAhB2+sPdfQ8Mm43geepkA/vMrDGz27E3/micM
 tyLg6VIU+oBP0k7p+lx2pSFwU9WsQ2eDthzS9vZCQZds9uuRAVirgliEpyPNCLUXkBtL9cJ649r
 DFVMIAwGkrAQLvvjDiBJUR/oBy/Z4iX86aJkbwQNwzy0kCqJvZY5kunnaBe8OVXBRu6m+8Y/mVd
 NK9fMG6qDzUSWrFYf5eP8nIybuVLWJEltjgrGw9JpujRRxy7Ty/hUqbuwQ+rFZVwvLxbhRLndYz
 HjnVqgO973Qugw+130kc4fDDTZzr85hkK2oFqzABf0OsjpbC/T3qCoStrRKCRl
X-Received: by 2002:a05:6000:220d:b0:430:b100:f591 with SMTP id
 ffacd0b85a97d-4342d39f650mr121106f8f.28.1768345266117; 
 Tue, 13 Jan 2026 15:01:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 04/11] doc: correct errors in Linux system requirements
 guide
Date: Tue, 13 Jan 2026 14:51:06 -0800
Message-ID: <20260113230052.54435-5-stephen@networkplumber.org>
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
- Fix capitalization of IBM Advance Toolchain
- Remove double spaces before "support"
- Add missing preposition "in" and article "the"
- Fix hugetlbfs mount command syntax (add -o flag and device)

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/sys_reqs.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 52a840fbe9..869584c344 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -68,7 +68,7 @@ Compilation of the DPDK
 
 *   Intel\ |reg| oneAPI DPC++/C++ Compiler.
 
-*   IBM\ |reg| Advance ToolChain for Powerlinux. This is a set of open source development tools and runtime libraries
+*   IBM\ |reg| Advance Toolchain for Powerlinux. This is a set of open source development tools and runtime libraries
     which allows users to take leading edge advantage of IBM's latest POWER hardware features on Linux. To install
     it, see the IBM official installation document.
 
@@ -93,7 +93,7 @@ e.g. :doc:`../nics/index`
 Running DPDK Applications
 -------------------------
 
-To run a DPDK application, some customization may be required on the target machine.
+To run a DPDK application, customization may be required on the target machine.
 
 System Software
 ~~~~~~~~~~~~~~~
@@ -127,9 +127,9 @@ System Software
 
     *   HUGETLBFS
 
-    *   PROC_PAGE_MONITOR  support
+    *   PROC_PAGE_MONITOR support
 
-    *   HPET and HPET_MMAP configuration options should also be enabled if HPET  support is required.
+    *   HPET and HPET_MMAP configuration options should also be enabled if HPET support is required.
         See the section on :ref:`High Precision Event Timer (HPET) Functionality <High_Precision_Event_Timer>` for more details.
 
 .. _linux_gsg_hugepages:
@@ -138,7 +138,7 @@ Use of Hugepages in the Linux Environment
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Hugepage support is required for the large memory pool allocation used for packet buffers
-(the HUGETLBFS option must be enabled in the running kernel as indicated the previous section).
+(the HUGETLBFS option must be enabled in the running kernel as indicated in the previous section).
 By using hugepage allocations, performance is increased since fewer pages are needed,
 and therefore less Translation Lookaside Buffers (TLBs, high speed translation caches),
 which reduce the time it takes to translate a virtual page address to a physical page address.
@@ -225,10 +225,10 @@ However, in order to use hugepage sizes other than the default, it is necessary
 to manually create mount points for those hugepage sizes (e.g. 1GB pages).
 
 To make the hugepages of size 1GB available for DPDK use,
-following steps must be performed::
+the following steps must be performed::
 
     mkdir /mnt/huge
-    mount -t hugetlbfs pagesize=1GB /mnt/huge
+    mount -t hugetlbfs -o pagesize=1GB none /mnt/huge
 
 The mount point can be made permanent across reboots, by adding the following line to the ``/etc/fstab`` file::
 
-- 
2.51.0

