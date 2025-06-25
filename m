Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0638C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 23:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4D8B40697;
	Thu, 26 Jun 2025 01:50:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C6CB24066E
 for <dev@dpdk.org>; Thu, 26 Jun 2025 01:50:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 02BB3206B741; Wed, 25 Jun 2025 16:50:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02BB3206B741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1750895447;
 bh=ElyplvZeFRuuw1EgbMOTC8fLRNb2gHSzrWe+FAiBS/s=;
 h=From:To:Cc:Subject:Date:Reply-To:From;
 b=pkAZU+Xaa5uBI7nq9JsTLWtmVn/5V+mPOIa4LLg8riplgWzsh/Ylr89MlNJE1fZHf
 w5+/WoagPJTA9PV+tWpYO0Of8kaazzZ5wt46aJEuCc0gCd1hF02b2xsqK7QHL4WEcX
 5dy8nYWABW/zWLKbq6xL4iyEfdunEFPappMA9yds=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] net/mana: support MANA in PF mode
Date: Wed, 25 Jun 2025 16:50:01 -0700
Message-Id: <1750895401-5903-1-git-send-email-longli@linuxonhyperv.com>
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
Reply-To: longli@microsoft.com
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

MANA can operate in both PF and VF mode. In PF mode, the PCI device
has a different device ID.

Add this ID to the PCI table for supporting MANA in PF mode.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 4 ++++
 drivers/net/mana/mana.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 2934da29f7..a02bd73836 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1636,6 +1636,10 @@ static const struct rte_pci_id mana_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT,
 			       PCI_DEVICE_ID_MICROSOFT_MANA)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT,
+			       PCI_DEVICE_ID_MICROSOFT_MANA_PF)
+	},
 	{
 		.vendor_id = 0
 	},
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 855d98911b..2b319da943 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -6,6 +6,7 @@
 #define __MANA_H__
 
 #define	PCI_VENDOR_ID_MICROSOFT		0x1414
+#define PCI_DEVICE_ID_MICROSOFT_MANA_PF	0x00b9
 #define PCI_DEVICE_ID_MICROSOFT_MANA	0x00ba
 
 struct mana_shared_data {
-- 
2.25.1

