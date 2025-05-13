Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B1C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 23:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C794025D;
	Wed, 14 May 2025 01:53:12 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id CC3A640041
 for <dev@dpdk.org>; Wed, 14 May 2025 01:53:10 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-af5310c1ac1so3574265a12.2
 for <dev@dpdk.org>; Tue, 13 May 2025 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1747180390; x=1747785190; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PMJ3coG+M+hq7NTjYOCV3dlLibfoi47AkroSp1+pYG4=;
 b=ZRt+Ku6JmHdv3trfVgFIc5YZuqVkiYniH5zJbiM97jZXWnKPUg8ajJy64+rUOGv8EU
 4r1uonfuxQlxva2hnNVWuvK/isylOtToLyKeee0HkdX9csw2kzP9P83pg/VmA4DDQ5C+
 sx3bFzXqAW6psTJ9plHCVJ4hy3/0TKuWJ6KWpirNrCcgVeXrXozF5WY3iGG3QnCBXgGH
 JJKfKuqfasF1S75ZTU7yNwfNxx/o5udSQLCmfJ48XgnModouJKFhqTNEmIgtSiONawM2
 ImLWYWtIzHmozHr6xK1D7IZAeXmpb3/TFUlwjAtYRxkZkXQHjZ8ShA5W6Q96EGSwihHR
 Vm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747180390; x=1747785190;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMJ3coG+M+hq7NTjYOCV3dlLibfoi47AkroSp1+pYG4=;
 b=PgDP9y1eyxcSiw9YnmuIwI9qk1yJi6tumqcTYftLQQ4huw8nxqo/iI1iDYlsK7lh+7
 ulx1MyCIoqT7eVcj6EwkLfjF77SGiMGmVS+8xG1kntbz+pYaxbE09lcuJItfhlrbExID
 mVMvfQ/KDEJefL3hb7b/uK2T95cE5CN5QLVFyaVXt8RpYc58EeZmdetHdhb5F+uTQTNo
 eRv0Y9RVAfw71jSvjjBsgmozXwdPKl7FQ58T6fg0yqn34Y6yTU2i6YQJclhUgdlWcF6P
 Bw05aJUG8EC5J+BXUkdEeGEPwZYsWMev/qYOo6X2VczFZ9ZrGC2KpQrWkvAdtcDKbSoz
 IoDA==
X-Gm-Message-State: AOJu0YyzJRicWKmO2HfNkwJS9Kr7j1OCu4Nsd6jOed036Hep2SCjc/PW
 7LjqjoPtruVHx7QG5i6cfHTDsyVJdr2f+eTiByJYRmwXVhbU/MpehF8o3DlcX2kLX6AKzCY54Rt
 oez9U26x0Nw==
X-Google-Smtp-Source: AGHT+IGWniaL31dEVMz2ehE4JJEAM3eFcUYzOocN7a+2S/Q8TzMxhasR4CZMiWqWa00M9wb64kbeVal6FW/LJQ==
X-Received: from pjbsn16.prod.google.com ([2002:a17:90b:2e90:b0:2fa:15aa:4d2b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:dfc4:b0:30c:52c5:3dc6 with SMTP id
 98e67ed59e1d1-30e2e687936mr1781437a91.29.1747180389887; 
 Tue, 13 May 2025 16:53:09 -0700 (PDT)
Date: Tue, 13 May 2025 16:53:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513235308.2200865-1-joshwash@google.com>
Subject: [PATCH] net/gve: remove gve-specific PCI revision ID macros
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>, 
 Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Commit 5feee68de99e ("pci: define more standard register offsets") adds
a generic offset macro for the PCI revision ID, among a number of other
standard PCI config fields. Update GVE to make use of these macros
instead of defining its own.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve.h        |  2 --
 drivers/net/gve/base/gve_adminq.c | 21 +++++++++------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/gve/base/gve.h b/drivers/net/gve/base/gve.h
index 0c5f5e9ce4..99514cb5f9 100644
--- a/drivers/net/gve/base/gve.h
+++ b/drivers/net/gve/base/gve.h
@@ -14,8 +14,6 @@
 #endif
 
 #define GVE_DEV_ID		0x0042
-#define GVE_PCI_REV_OFFSET	0x8
-#define GVE_PCI_REV_SIZE	1
 
 #define GVE_REG_BAR		0
 #define GVE_DB_BAR		2
diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 2c5cfa2aa1..25f4481c1b 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -196,18 +196,10 @@ gve_process_device_options(struct gve_priv *priv,
 	return 0;
 }
 
-static uint8_t
-gve_get_pci_revision_id(struct gve_priv *priv)
-{
-	uint8_t rev_id;
-
-	rte_pci_read_config(priv->pci_dev, &rev_id, GVE_PCI_REV_SIZE,
-			    GVE_PCI_REV_OFFSET);
-	return rev_id;
-}
-
 int gve_adminq_alloc(struct gve_priv *priv)
 {
+	uint8_t pci_rev_id;
+
 	priv->adminq = gve_alloc_dma_mem(&priv->adminq_dma_mem, PAGE_SIZE);
 	if (unlikely(!priv->adminq))
 		return -ENOMEM;
@@ -231,7 +223,9 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 
 	/* Setup Admin queue with the device */
-	if (gve_get_pci_revision_id(priv) < 0x1) { /* Use AQ PFN. */
+	rte_pci_read_config(priv->pci_dev, &pci_rev_id, sizeof(pci_rev_id),
+			    RTE_PCI_REVISION_ID);
+	if (pci_rev_id < 0x1) { /* Use AQ PFN. */
 		iowrite32be(priv->adminq_dma_mem.pa / PAGE_SIZE,
 			    &priv->reg_bar0->adminq_pfn);
 	} else { /* Use full AQ address. */
@@ -251,10 +245,13 @@ int gve_adminq_alloc(struct gve_priv *priv)
 
 void gve_adminq_release(struct gve_priv *priv)
 {
+	uint8_t pci_rev_id;
 	int i = 0;
 
 	/* Tell the device the adminq is leaving */
-	if (gve_get_pci_revision_id(priv) < 0x1) {
+	rte_pci_read_config(priv->pci_dev, &pci_rev_id, sizeof(pci_rev_id),
+			    RTE_PCI_REVISION_ID);
+	if (pci_rev_id < 0x1) {
 		iowrite32be(0x0, &priv->reg_bar0->adminq_pfn);
 		while (ioread32be(&priv->reg_bar0->adminq_pfn)) {
 			/* If this is reached the device is unrecoverable and still
-- 
2.49.0.1045.g170613ef41-goog

