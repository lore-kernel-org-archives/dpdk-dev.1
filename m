Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FCD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C17941140;
	Wed, 14 Jan 2026 23:28:36 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 566F540F16
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:35 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so638243f8f.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429715;
 x=1769034515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=kowOIC2BiOnrk4ajEYmn2PlwKoNd/V0Zy6BjBWtAlWY9ITaA3ycMWUoa42iNrm55R5
 PuhnsT9QwqGXqTXdYs2KFYB8Fn72Jip5nT4clnsOQy04Rut0wbf8fxqtryfQMeNsPPx0
 b6wq6PlL8f328uVXlqh+9KOKGXnHLC/WMiTvMJCCLzrLyck/c5l7SwKyNDnCJXeMj/Ak
 Wgv3mbM+Z783qS4eIHotpI/ddSGvvvAQbU351Okf2Ig8IB4xBVRu/YbOKrVuXNSkg8rL
 eFiAockau8GjMQMfvjwuhyEyrBDlNT5EQ0LfP6f9vs6RQKTlSqf7C8UeZkM+JPSjEzi+
 ZWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429715; x=1769034515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=EbFz6GEUMlIz4zCPzkpMtDu4V9HtqyXWgZvdCTMtGFrpFg8fgYmx0exizrHWBkQX08
 CTu6IFYe9JYc2SugShpTwamUZ3c0TAT9MvVJC8346niY06UNHxh9I9tTNsbq8wM2q4O6
 O2+fa9KlP8i9EkPrmKPsdAtaMV3ef/jZsRw3zfV0q/atGln+3XrLqqoDrzZdbYWPTPk3
 3FC47M9saW4oGTkIzmy7jCY7v5H5Yvo8/jQs0saaAdT9yXuUIB2BzNu2BfJArXNg2NGV
 hhAauwZVk0AYDUeXDHkRexWYHeRKaO7We/oyOXPtqzjgs+OfE815NfJZ/3quyGZ4trSo
 Lp1Q==
X-Gm-Message-State: AOJu0YwV0F0QafOGGIqrgPXlf2BbHomZXW5tp7Dfy/ArnHp/Mb8r2DLZ
 E55s1MBQDvxhC63mvtdUfCVXPOM6i5z9kgwX/tn2+ZRJqoCxvU/dPEaOf0NZERcq6HVyE0UeHaj
 5TIqU
X-Gm-Gg: AY/fxX5Ed2v4aftFxYEUzN8eK/Eb9ytgP0gU307nRMjLsdfrUxWWvk/PmuUoz7h2npV
 zNt4ufywrxtWKJUOX9UcmZkFpoXnPhPhEGHSC4OLYLniEvEZLx5sEV9JYMZG+i+6KeoGQkjKzmp
 /gGgn9tz2mEKZ9n5Q6N5cLMi9jfosONqD3k8wPDXDafNPDo+rJiRFoXGgWgCsP9L1EjHwptnckf
 ncmWqaAN2KXoMraKg+SbOLzjWDwN3cCPoh3iPtQEYgMlIHjeycjEClTqu/ocDQUgMRa9OJKcaf5
 Wea/hIvPz8pJVwdjXTTQFNpRlCBb+KgMa7bhBqFn2LznDIIoqJ9Q1Ewx0akBYGG+CIYGjmH67Fl
 sYTsQoMGuj7pcUVV5X0cPqNdjHo9eW01cEGFliGXELPcoOk7eh7i1o31QeaaS9vDacKlkKH0mtw
 1wDKva6eiCHhPg6HREtQ1TghU7sqDkgR00AdKetBypoWI5WITqaw==
X-Received: by 2002:a05:6000:4312:b0:430:f593:aa34 with SMTP id
 ffacd0b85a97d-434d75c15a7mr1229194f8f.17.1768429714956; 
 Wed, 14 Jan 2026 14:28:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 04/11] doc: correct errors in Linux system requirements
 guide
Date: Wed, 14 Jan 2026 14:26:56 -0800
Message-ID: <20260114222821.87920-5-stephen@networkplumber.org>
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

