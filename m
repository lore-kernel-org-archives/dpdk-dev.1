Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49525C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 05:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6649B410CF;
	Wed,  9 Sep 2026 07:44:21 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D00CB40272
 for <dev@dpdk.org>; Wed,  9 Sep 2026 07:44:15 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B16D4200118;
 Wed,  9 Sep 2026 07:44:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BE50200139;
 Wed,  9 Sep 2026 07:44:15 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A0EA180006C;
 Wed,  9 Sep 2026 13:44:14 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v14 05/15] net/enetc: add VF supported features file
Date: Wed,  9 Sep 2026 11:14:00 +0530
Message-Id: <20260909054410.1490944-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909054410.1490944-1-g.singh@nxp.com>
References: <20260908054736.842738-1-g.singh@nxp.com>
 <20260909054410.1490944-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

The upcoming VF-specific feature work needs its own supported-features
documentation, separate from the PF (enetc4). Add a dedicated
enetc4_vf.ini for the net_enetc4_vf PMD so that VF-only features can be
tracked independently, and reference it in MAINTAINERS.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 MAINTAINERS                            |  1 +
 doc/guides/nics/features/enetc4_vf.ini | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 doc/guides/nics/features/enetc4_vf.ini

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..8f64a7b3ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -995,6 +995,7 @@ F: doc/guides/nics/enetc.rst
 F: doc/guides/nics/enetc4.rst
 F: doc/guides/nics/features/enetc.ini
 F: doc/guides/nics/features/enetc4.ini
+F: doc/guides/nics/features/enetc4_vf.ini
 
 NXP enetfec - EXPERIMENTAL
 M: Apeksha Gupta <apeksha.gupta@nxp.com>
diff --git a/doc/guides/nics/features/enetc4_vf.ini b/doc/guides/nics/features/enetc4_vf.ini
new file mode 100644
index 0000000000..9107c8ede5
--- /dev/null
+++ b/doc/guides/nics/features/enetc4_vf.ini
@@ -0,0 +1,25 @@
+;
+; Supported features of the 'enetc4_vf' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Link status event    = Y
+Speed capabilities   = Y
+Link status          = Y
+LRO                  = Y
+TSO                  = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+VLAN filter          = Y
+RSS hash             = Y
+Packet type parsing  = Y
+Basic stats          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+CRC offload          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Linux                = Y
+ARMv8                = Y
+Usage doc            = Y
-- 
2.25.1

