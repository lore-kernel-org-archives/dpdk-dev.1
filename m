Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA380FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C4440673;
	Thu, 30 Apr 2026 12:18:37 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 277AE4021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:18:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACnUW11LPNplJjRDg--.60427S4;
 Thu, 30 Apr 2026 18:18:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 2/9] doc: add sxe2 guide and release notes
Date: Thu, 30 Apr 2026 18:18:10 +0800
Message-ID: <20260430101819.4094628-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430101819.4094628-1-liujie5@linkdatatechnology.com>
References: <20260430092231.4068642-10-liujie5@linkdatatechnology.com>
 <20260430101819.4094628-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnUW11LPNplJjRDg--.60427S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18AF1ktrWktw15JF4rGrg_yoW5ur45pa
 n3CFySkr9xJ34xZr9xta1UAr45Ca1kAa45CF1Iq34rXFn8Cr18Zw4UKryxt34DGF95Z3Wr
 XF4jqry7CF1UW3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxkF7I
 0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
 3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
 WUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
 cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
 AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
 Xa7VUjm0PDUUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add a new guide for SXE2 PMD in the nics directory.
The guide contains driver capabilities, prerequisites,
and compilation/usage instructions.

Update the release notes to announce the addition of the
sxe2 network driver.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/features/sxe2.ini      | 11 +++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/nics/sxe2.rst               | 23 +++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 4 files changed, 38 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe2.ini
 create mode 100644 doc/guides/nics/sxe2.rst

diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
new file mode 100644
index 0000000000..cbf5a773fb
--- /dev/null
+++ b/doc/guides/nics/features/sxe2.ini
@@ -0,0 +1,11 @@
+;
+; Supported features of the 'sxe2' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+; A feature with "P" indicates only be supported when non-vector path
+; is selected.
+;
+[Features]
+Queue start/stop     = Y
+Linux                = Y
\ No newline at end of file
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index cb818284fe..e20be478f8 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -68,6 +68,7 @@ Network Interface Controller Drivers
     rnp
     sfc_efx
     softnic
+    sxe2
     tap
     thunderx
     txgbe
diff --git a/doc/guides/nics/sxe2.rst b/doc/guides/nics/sxe2.rst
new file mode 100644
index 0000000000..2f9ba91c33
--- /dev/null
+++ b/doc/guides/nics/sxe2.rst
@@ -0,0 +1,23 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+
+SXE2 Poll Mode Driver
+======================
+
+The sxe2 PMD (**librte_net_sxe2**) provides poll mode driver support for
+10/25/50/100/200 Gbps Network Adapters.
+The embedded switch, Physical Functions (PF),
+and SR-IOV Virtual Functions (VF) are supported
+
+Implementation details
+----------------------
+
+For security reasons and robustness, this driver only deals with virtual
+memory addresses. The way resources allocations are handled by the kernel
+combined with hardware specifications that allow it to handle virtual memory
+addresses directly ensure that DPDK applications cannot access random
+physical memory (or memory that does not belong to the current process).
+
+This capability allows the PMD to coexist with kernel network interfaces
+which remain functional, although they stop receiving unicast packets as
+long as they share the same MAC address.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..93fb0072a9 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added Linkdata sxe2 ethernet driver.**
+
+  Added network driver for the Linkdata Network Adapters.
 
 Removed Items
 -------------
-- 
2.47.3

