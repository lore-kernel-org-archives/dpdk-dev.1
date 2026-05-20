Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B0CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D63940669;
	Wed, 20 May 2026 04:18:25 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 63C1B402F0
 for <dev@dpdk.org>; Wed, 20 May 2026 04:18:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAA3zRDnGQ1qhsnVEA--.10188S4;
 Wed, 20 May 2026 10:18:17 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v19 02/11] doc: add sxe2 guide and release notes
Date: Wed, 20 May 2026 10:18:00 +0800
Message-ID: <20260520021809.4019054-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3zRDnGQ1qhsnVEA--.10188S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18AF1ktrWktr4fXw1fZwb_yoWrWF43pa
 n3uFWakrnxJw1xXwnxta18Ar45Ca1vyay5Crn2q34rXFn8Cr18Zr4UKryxt3srJr93Za4f
 XF4Yqry7CF1UW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUUUUU
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
 doc/guides/nics/features/sxe2.ini      | 23 +++++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/nics/sxe2.rst               | 34 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  4 +++
 4 files changed, 62 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe2.ini
 create mode 100644 doc/guides/nics/sxe2.rst

diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
new file mode 100644
index 0000000000..09ba2f558c
--- /dev/null
+++ b/doc/guides/nics/features/sxe2.ini
@@ -0,0 +1,23 @@
+;
+; Supported features of the 'sxe2' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+; A feature with "P" indicates only be supported when non-vector path
+; is selected.
+;
+[Features]
+Fast mbuf free       = P
+Free Tx mbuf on demand = Y
+Burst mode info      = Y
+Queue start/stop     = Y
+Buffer split on Rx   = P
+Scattered Rx         = Y
+CRC offload          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+Rx descriptor status = Y
+Tx descriptor status = Y
+Linux                = Y
+x86-32               = Y
+x86-64               = Y
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
index 0000000000..7fcf9c085b
--- /dev/null
+++ b/doc/guides/nics/sxe2.rst
@@ -0,0 +1,34 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+
+SXE2 Poll Mode Driver
+======================
+
+The sxe2 PMD (**librte_net_sxe2**) provides poll mode driver support for
+10/25/50/100 Gbps Network Adapters.
+The embedded switch, Physical Functions (PF),
+and SR-IOV Virtual Functions (VF) are supported.
+
+Implementation details
+----------------------
+
+The sxe2 PMD is designed to operate alongside the sxe2 kernel network driver.
+For management and control operations, the PMD communicates with the kernel
+driver via ioctl interfaces. These commands are processed by the kernel
+driver and subsequently dispatched to the hardware firmware for execution.
+
+For security and robustness, the driver's data path is optimized to operate
+using virtual addresses (IOVA as VA mode). However, to ensure full
+compatibility in system environments where an IOMMU is absent or disabled,
+the driver also provides an explicit path to support physical addressing
+(IOVA as PA mode).
+
+The hardware is capable of handling the corresponding IOVA addresses (either
+VA or PA) directly, as provided by the DPDK memory subsystem. This ensures
+that DPDK applications can only access memory segments explicitly allocated
+to the current process, preventing unauthorized access to random physical
+memory.
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

