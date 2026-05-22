Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F9CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 07:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2451D40665;
	Fri, 22 May 2026 09:00:14 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 13F1040287
 for <dev@dpdk.org>; Fri, 22 May 2026 09:00:11 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id E366F20B7167;
 Fri, 22 May 2026 00:00:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E366F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779433202;
 bh=pkGQ7o/4hKO+dHrhvDaP/hGHl8b5U4FJByefTUOz9CE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hSd4hXzMhyLvAQTyMX57Nkkcr8Wz8P/oR5xivzzyVwkTreKgDoNV7z41q92hzYTOf
 spF51HwuVq4JoVNSwCEXAhK2AfKBn1Wr6wOZJg8K1s/KZHFr8RhTMD/MtZNR5uD4Pc
 fWaYQHB2OhDC933fYYBkGhEniOhWcwrZe7MXIi2Q=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v3 2/2] net/mana: add documentation for device reset support
Date: Thu, 21 May 2026 23:59:43 -0700
Message-Id: <20260522065943.126703-3-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522065943.126703-1-weh@linux.microsoft.com>
References: <20260522065943.126703-1-weh@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Wei Hu <weh@microsoft.com>

Add device reset section to mana.rst describing the two-phase
reset flow, recovery events, and PCI remove event dependency.
Add release note entry for the 26.07 release.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 doc/guides/nics/mana.rst               | 33 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  8 +++++++
 2 files changed, 41 insertions(+)

diff --git a/doc/guides/nics/mana.rst b/doc/guides/nics/mana.rst
index 0fcab6e2f6..a89338291a 100644
--- a/doc/guides/nics/mana.rst
+++ b/doc/guides/nics/mana.rst
@@ -71,3 +71,36 @@ The user can specify below argument in devargs.
     The default value is not set,
     meaning all the NICs will be probed and loaded.
     User can specify multiple mac=xx:xx:xx:xx:xx:xx arguments for up to 8 NICs.
+
+Device Reset Support
+--------------------
+
+The MANA PMD supports automatic recovery from hardware service reset events.
+When the MANA kernel driver receives a hardware service event,
+it initiates a device reset and notifies userspace
+via ``IBV_EVENT_DEVICE_FATAL``.
+
+The driver handles this transparently through a two-phase reset flow:
+
+* **Enter phase**: The driver stops the data path,
+  waits for all threads to reach a quiescent state using RCU,
+  tears down IB resources and queues,
+  and unmaps secondary process doorbell pages.
+
+* **Exit phase**: After a delay for hardware recovery,
+  a control thread re-probes the PCI device,
+  reinstalls the interrupt handler,
+  reinitializes resources, and restarts queues.
+
+The driver emits the following ethdev recovery events
+to notify upper layers (e.g. netvsc) of the reset lifecycle:
+
+* ``RTE_ETH_EVENT_ERR_RECOVERING`` — reset has started
+* ``RTE_ETH_EVENT_RECOVERY_SUCCESS`` — device has recovered successfully
+* ``RTE_ETH_EVENT_RECOVERY_FAILED`` — recovery failed
+
+To distinguish a PCI hot-remove from a service reset,
+the driver registers for PCI device removal events.
+This requires the application to call ``rte_dev_event_monitor_start()``
+for removal events to be delivered
+(e.g. testpmd ``--hot-plug-handling`` option).
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 92c90673bc..114bc09c5d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -77,6 +77,14 @@ New Features
 
   Added network driver for the Linkdata Network Adapters.
 
+* **Added device reset support to the MANA PMD.**
+
+  Added automatic recovery from hardware service reset events
+  in the MANA poll mode driver. The driver uses ethdev recovery events
+  (``RTE_ETH_EVENT_ERR_RECOVERING``, ``RTE_ETH_EVENT_RECOVERY_SUCCESS``,
+  ``RTE_ETH_EVENT_RECOVERY_FAILED``) to notify upper layers of the
+  reset lifecycle.
+
 
 Removed Items
 -------------
-- 
2.34.1

