Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B042CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 02:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75ED240A4B;
	Wed,  6 May 2026 04:12:52 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E931640A71
 for <dev@dpdk.org>; Wed,  6 May 2026 04:12:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAB3CQ2Wo_ppYJSCDw--.25805S4;
 Wed, 06 May 2026 10:12:39 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v6 02/10] doc: add sxe2 guide and release notes
Date: Wed,  6 May 2026 10:12:24 +0800
Message-ID: <20260506021233.661892-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506021233.661892-1-liujie5@linkdatatechnology.com>
References: <20260501033401.316025-10-liujie5@linkdatatechnology.com>
 <20260506021233.661892-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB3CQ2Wo_ppYJSCDw--.25805S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18AF1ktrWktw15JF4rGrg_yoW5Zw4xpa
 n3CFySkr9xJw1xZr9xta18Ar45Ca1kAa45CFyIq34rXFn8ur18Zw4UKryxt34DJF95Z3Wr
 ZF4jqry7CF1DW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1le2I2
 62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
 AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
 0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUUUUU
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
 doc/guides/rel_notes/release_26_07.rst |  4 ++++
 4 files changed, 39 insertions(+)
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
index f012d47a4b..fa0f0f5cca 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -64,6 +64,10 @@ New Features
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
 
+* **Added Linkdata sxe2 ethernet driver.**
+
+  Added network driver for the Linkdata Network Adapters.
+
 Removed Items
 -------------
 
-- 
2.47.3

