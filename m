Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90DC282EC
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Mar 2025 00:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C28C540263;
	Sat, 15 Mar 2025 01:35:06 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C2D9B400D6
 for <dev@dpdk.org>; Sat, 15 Mar 2025 01:35:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id D96722033455; Fri, 14 Mar 2025 17:35:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D96722033455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741998904;
 bh=usyaawPM8rHIEgz3Th2h2xhYANieL7eKFd6rzF5dZUM=;
 h=From:To:Cc:Subject:Date:From;
 b=I5twyNidJUW9MV/SI5GytTVd3H+kn8FQVnmuFCmULA5k/L+QExRfWfANJzzCaVCqc
 CC4aW0QrmuDZPAIV5rdQPOQXVAcq/TTcdufPSasNKBd/mP2kpodTWtu8NK7xC5L00A
 mHPWT+AypplhfDENzGlsswGbAN8R/QVHXEwto1qs=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2] doc: announce bus/vmbus API changes
Date: Fri, 14 Mar 2025 17:34:55 -0700
Message-Id: <1741998895-31065-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
It's not feasible or practical to use those APIs by the application.
Those APIs will be moved from "DPDK" to "Internal" in DPDK 25.11.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in v2:
add details on what APIs will be changed

 doc/guides/rel_notes/deprecation.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 3f5f0e949c..0ff7dd69cd 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -138,3 +138,27 @@ Deprecation Notices
   will be deprecated and subsequently removed in DPDK 24.11 release.
   Before this, the new port library API (functions rte_swx_port_*)
   will gradually transition from experimental to stable status.
+
+* bus/vmbus: Starting DPDK 25.11, all the vmbus APIs will be moved
+  from "DPDK" to "INTERNAL" in drivers/bus/vmbus/version.map.
+  Those APIs are used only by DPDK core and net/netvsc PMD.
+  The following APIs wil be moved:
+  rte_vmbus_chan_close
+  rte_vmbus_chan_open
+  rte_vmbus_chan_recv
+  rte_vmbus_chan_recv_raw
+  rte_vmbus_chan_rx_empty
+  rte_vmbus_chan_send
+  rte_vmbus_chan_send_sglist
+  rte_vmbus_chan_signal_read
+  rte_vmbus_chan_signal_tx
+  rte_vmbus_irq_mask
+  rte_vmbus_irq_read
+  rte_vmbus_irq_unmask
+  rte_vmbus_map_device
+  rte_vmbus_max_channels
+  rte_vmbus_probe
+  rte_vmbus_scan
+  rte_vmbus_set_latency
+  rte_vmbus_sub_channel_index
+  rte_vmbus_subchan_open
-- 
2.34.1

