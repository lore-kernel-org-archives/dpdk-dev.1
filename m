Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8AED2E022
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 07:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06B8B40156;
	Fri,  5 Dec 2025 08:42:45 +0100 (CET)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 by mails.dpdk.org (Postfix) with UTF8SMTP id B6826400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 09:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1764662945; bh=qB7nhDPJ7YiN9Vt3GfWDMU6JrgsrAaG3rrEaKyozi4c=;
 h=From:To:Cc:Subject:Date;
 b=CvWJwXh2Otxq+0eOYvJ0okM3pKABAQxdxz/1a9LbnhZPvqAPHOCu2gI/GOltm6ji/
 H6oQSmooRDreL3zG/yZESh/i6oQmBTE1DfcXAwaOHgUNCU5RwKDWN2A7YRCW5inljx
 YnCd24GJLkxmNtvaJtxf4qZcu+DI5LcCBmBXiTe0=
Received: from localhost.localdomain ([115.194.9.190])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 2431A215; Tue, 02 Dec 2025 16:09:03 +0800
X-QQ-mid: xmsmtpt1764662943tupx7imvv
Message-ID: <tencent_0AAA93B91277A304E5303277E262EB7FC408@qq.com>
X-QQ-XMAILINFO: MGJQUKeBeYZpXVFNAYgbdNa372QVfBhR17/YR7m4mWRWF18JY2ht+ShhjmHwIk
 PM1ttWZSFsUEbVXzH+TX2KIfvhdBJ7k7a7cm2G70MjLL4e//YssERhpAwa1KayRBN+KLHWcD+BEd
 ByJ9QMvvNGKkHrxIgoAyYkOZJ2QR33eND5k8SXIdjCZV5oRnPuIzmsrCk5R2Sz+s33b15n6iAote
 i5w4gx5Mqhf+NvAOSIO1lqi64jeRrTSIncFPzFp5Z4/rUiLjrDqQdONLuyINFEjFzVDXlo+6k+sh
 pM1oB0QBhnrP6amlB7ZM9LFazUzQAXMIeBrmVfJIsCwFIfUXdFtAeARAB5AZQZuZdXs0jsTAywSe
 FlmIRp+OHon0nTkTvwkdPaAQ80Ub2QPR5KCdee0DEs8F489mHLs+u3i4lnnjJ+OwoVxZfSnBX1iC
 Zsw14ouAS6XMTawNBxB+DwHu8uVo62YQWVNGB1gLN/U/d/EEtg6JZo19OuLnVY1Trccx65m1ZWgl
 FX0uMLfnJCPd8S6Jt98F/FHEfcVY6o7/OenLbScGHoz0fOS0+4+CeJzj/Ljt0qamDPot/Acofofg
 JafTXmOfkMBJENO8X+TzVw2nGG28Xays/jK1/iL/q0aOtTlTtM9rHDYhmLnwKJ4ig0OE5huquso4
 ZwlR4+jsGgdaHwv16pJXWcOJze7ZUrOB24pccOVTiyeu39i+YvRB5ZZZroOdvorAU4NMTq8R9jg8
 DiTvTs8runbhrgIWxiRw7vGcO7OZCXWqWBGsweENobp7FTLaKnXIxFJMg5jNL2TmwPYfFLZC3FDC
 JglXUFyz9GwkN8KcNJo4ZHjMi9JwLpt4Bp37XxltoQKAtihEAXZ3NRcaxI2tG1N9T90CF5gNRX8i
 cNoiL2vqEB16EZrUDyxXPxoaXnIA4gwfVNyMCwth16HikYRNmBHaJOv/reAfXi8Pea+Du3R596Df
 bALk34LJha63zbCU0tM8iYY3DYm670vT7WfX5jXHtxQnq7+Utz0RQM94mo3lVwlLMJW8WfCi9LJ6
 LvK6gxfQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: luyan <973788536@qq.com>
To: maxime.coquelin@redhat.com,
	chenbox@nvidia.com
Cc: dev@dpdk.org,
	luyan <luyan@cmss.chinamobile.com>
Subject: [PATCH] eal/arm: include rte_config.h upfront to fix ARM arch header
 selection
Date: Tue,  2 Dec 2025 16:08:49 +0800
X-OQ-MSGID: <20251202080849.684-1-973788536@qq.com>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Dec 2025 08:42:43 +0100
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

From: luyan <luyan@cmss.chinamobile.com>

Fix incorrect arch header inclusion on ARM by adding rte_config.h before
architecture judgment.

Signed-off-by: Yan Lu <luyan@cmss.chinamobile.com>
---
 lib/eal/arm/include/rte_atomic.h   | 2 ++
 lib/eal/arm/include/rte_cpuflags.h | 2 ++
 lib/eal/arm/include/rte_cycles.h   | 2 ++
 lib/eal/arm/include/rte_io.h       | 2 ++
 lib/eal/arm/include/rte_memcpy.h   | 2 ++
 lib/eal/arm/include/rte_pause.h    | 2 ++
 lib/eal/arm/include/rte_prefetch.h | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/lib/eal/arm/include/rte_atomic.h b/lib/eal/arm/include/rte_atomic.h
index 40e14e56f7..c329b18761 100644
--- a/lib/eal/arm/include/rte_atomic.h
+++ b/lib/eal/arm/include/rte_atomic.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_ATOMIC_ARM_H_
 #define _RTE_ATOMIC_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_atomic_64.h>
 #else
diff --git a/lib/eal/arm/include/rte_cpuflags.h b/lib/eal/arm/include/rte_cpuflags.h
index 022e7da55e..3ee840593a 100644
--- a/lib/eal/arm/include/rte_cpuflags.h
+++ b/lib/eal/arm/include/rte_cpuflags.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_CPUFLAGS_ARM_H_
 #define _RTE_CPUFLAGS_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_cpuflags_64.h>
 #else
diff --git a/lib/eal/arm/include/rte_cycles.h b/lib/eal/arm/include/rte_cycles.h
index e8ffa894bb..196a947bf8 100644
--- a/lib/eal/arm/include/rte_cycles.h
+++ b/lib/eal/arm/include/rte_cycles.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_CYCLES_ARM_H_
 #define _RTE_CYCLES_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_cycles_64.h>
 #else
diff --git a/lib/eal/arm/include/rte_io.h b/lib/eal/arm/include/rte_io.h
index 781774dd72..0d9823e484 100644
--- a/lib/eal/arm/include/rte_io.h
+++ b/lib/eal/arm/include/rte_io.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_IO_ARM_H_
 #define _RTE_IO_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include "rte_io_64.h"
 #else
diff --git a/lib/eal/arm/include/rte_memcpy.h b/lib/eal/arm/include/rte_memcpy.h
index 47dea9a8cc..095bee3b63 100644
--- a/lib/eal/arm/include/rte_memcpy.h
+++ b/lib/eal/arm/include/rte_memcpy.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_MEMCPY_ARM_H_
 #define _RTE_MEMCPY_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_memcpy_64.h>
 #else
diff --git a/lib/eal/arm/include/rte_pause.h b/lib/eal/arm/include/rte_pause.h
index 9c793c8803..3670f4c94b 100644
--- a/lib/eal/arm/include/rte_pause.h
+++ b/lib/eal/arm/include/rte_pause.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_PAUSE_ARM_H_
 #define _RTE_PAUSE_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_pause_64.h>
 #else
diff --git a/lib/eal/arm/include/rte_prefetch.h b/lib/eal/arm/include/rte_prefetch.h
index 27870c2a88..1d1367d5e7 100644
--- a/lib/eal/arm/include/rte_prefetch.h
+++ b/lib/eal/arm/include/rte_prefetch.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_PREFETCH_ARM_H_
 #define _RTE_PREFETCH_ARM_H_
 
+#include <rte_config.h>
+
 #ifdef RTE_ARCH_64
 #include <rte_prefetch_64.h>
 #else
-- 
2.45.2.windows.1

