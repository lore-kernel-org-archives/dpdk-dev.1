Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA07C369AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 02:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9546E40655;
	Wed, 16 Apr 2025 04:44:25 +0200 (CEST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id 0C87D40289
 for <dev@dpdk.org>; Wed, 16 Apr 2025 04:44:24 +0200 (CEST)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-3055f2e1486so9109556a91.0
 for <dev@dpdk.org>; Tue, 15 Apr 2025 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744771463; x=1745376263; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R2MYsACSSeUB/BeXja/fxS60DG+8fNSWXIDU1gcUfFM=;
 b=iLUVDSdhEF62fYvcCZ+0RSZv7eI5xWrqLzM5bmZ1wzi3SNunAPHrG7PzxfvaR1cGOV
 rNHO+ec53YRFsWTciqOpQqdZgjvQtBkmjGAahplsxL7TE/TaEQgjG22IaMDAle2dSC/m
 seEvAzOcn6JHyhR88vM3jsL/AAXRn6gWtxfFAaJYE5oY2VCNzdmeOqB0Pjfuisob0W9E
 /U4+yONG3fya32e2Ufd2TlBZGUz5GFU4SwD3QrcmsMTmieAMSvNjFLE/zfBoChIMuOFm
 WoNuDkatTx/0v3v2DyTaiJOFVskbm3sYt/E7IwZt1RptPuKQuKDyxUtPeGLlDdR1svgJ
 M0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744771463; x=1745376263;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2MYsACSSeUB/BeXja/fxS60DG+8fNSWXIDU1gcUfFM=;
 b=AzJG+yQjFpb8Z0AMi3CgaTADKqRcDTbrSsS7e8Mj40h2tWDjJkopmRXg095PlCzSkV
 ipcYZV/2zZZGuXuHL5DdXGPBHBVDmUaIZ1y2J/XSyFR0zjvluTEyWQO2yNNhR+0sAK6L
 NXAHB9wppbGklUk6jKXgknZQ05LlfYAvNsrsf8MiDRwzBdGqj3Pv5vKdI5FgUpi+j0o5
 PY0AgUBGuJ0tY26jdVg6IfDcJTSoigWb+EAEz+N6rzb4L+3zgl6R6ED+VjfHq/X3t2Nu
 hw8B+8T/BLXaejSwubn/m/SXdtqBA3p8dh+/fC4JXz5agoTYX75zKcm9eNPE0gttJXSw
 FiVg==
X-Gm-Message-State: AOJu0YyYQWTecKKy1agUSPkz42dJjLtM6iuCpYuQuA5WI/sHD2QZXab5
 6yHQmcuoaWZBKdSsuADY2OQTeFJvbfD7lbuj0ZCf0VSuMp3lMsV1pwjZ3V5EmvcSspwWf+LGh3k
 RDWuRbtdUOA==
X-Google-Smtp-Source: AGHT+IE9R3+6JHd0kCc8Cv5BYEAuaWHRmgqgDJQb/MTvWObUJFBDCEOfnf6QrleysSUe2JZQ53PWh2q90rcndA==
X-Received: from pjh15.prod.google.com ([2002:a17:90b:3f8f:b0:2fc:ccfe:368])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5483:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-3086415e1camr57000a91.26.1744771463184; 
 Tue, 15 Apr 2025 19:44:23 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:44:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416024421.722135-1-joshwash@google.com>
Subject: [PATCH] net/gve: support for gVNIC PCI revision 1 and later
From: Joshua Washington <joshwash@google.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Jeroen de Borst <jeroendb@google.com>, 
 Rushil Gupta <rushilg@google.com>, Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Ziwei Xiao <ziweixiao@google.com>
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

gVNIC PCI revisions greater than 0 have support for setting the admin
queue by its full address instead of using the PFN, which can be
problematic if the system page size is not actually 4K as the device
assumes. Beyond that, a new device/driver reset mechanism is introduced.
Originally, a device reset was triggered by writing 0 to the admin queue
PFN. Newer device reivisons set a status flag, instead.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ziwei Xiao <ziweixiao@google.com>
---
 .mailmap                            |  1 +
 drivers/net/gve/base/gve.h          |  4 ++
 drivers/net/gve/base/gve_adminq.c   | 59 +++++++++++++++++++++++------
 drivers/net/gve/base/gve_osdep.h    | 18 +++++++++
 drivers/net/gve/base/gve_register.h | 10 +++++
 5 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/.mailmap b/.mailmap
index d8439b79ce..f18f6eaefb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1831,6 +1831,7 @@ Zhiyong Yang <zhiyong.yang@intel.com>
 Zhuobin Huang <zobin1999@gmail.com>
 Zi Hu <huzilucky@gmail.com>
 Zijie Pan <zijie.pan@6wind.com>
+Ziwei Xiao <ziweixiao@google.com>
 Ziyang Xuan <xuanziyang2@huawei.com>
 Ziye Yang <ziye.yang@intel.com>
 Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
diff --git a/drivers/net/gve/base/gve.h b/drivers/net/gve/base/gve.h
index 9c58fc4238..0c5f5e9ce4 100644
--- a/drivers/net/gve/base/gve.h
+++ b/drivers/net/gve/base/gve.h
@@ -14,6 +14,8 @@
 #endif
 
 #define GVE_DEV_ID		0x0042
+#define GVE_PCI_REV_OFFSET	0x8
+#define GVE_PCI_REV_SIZE	1
 
 #define GVE_REG_BAR		0
 #define GVE_DB_BAR		2
@@ -24,6 +26,8 @@
 /* PTYPEs are always 10 bits. */
 #define GVE_NUM_PTYPES		1024
 
+#define GVE_ADMINQ_BUFFER_SIZE	4096
+
 struct gve_irq_db {
 	rte_be32_t id;
 } ____cacheline_aligned;
diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index bcb983e4a0..2c5cfa2aa1 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -196,6 +196,16 @@ gve_process_device_options(struct gve_priv *priv,
 	return 0;
 }
 
+static uint8_t
+gve_get_pci_revision_id(struct gve_priv *priv)
+{
+	uint8_t rev_id;
+
+	rte_pci_read_config(priv->pci_dev, &rev_id, GVE_PCI_REV_SIZE,
+			    GVE_PCI_REV_OFFSET);
+	return rev_id;
+}
+
 int gve_adminq_alloc(struct gve_priv *priv)
 {
 	priv->adminq = gve_alloc_dma_mem(&priv->adminq_dma_mem, PAGE_SIZE);
@@ -221,8 +231,19 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 
 	/* Setup Admin queue with the device */
-	iowrite32be(priv->adminq_dma_mem.pa / PAGE_SIZE,
-		    &priv->reg_bar0->adminq_pfn);
+	if (gve_get_pci_revision_id(priv) < 0x1) { /* Use AQ PFN. */
+		iowrite32be(priv->adminq_dma_mem.pa / PAGE_SIZE,
+			    &priv->reg_bar0->adminq_pfn);
+	} else { /* Use full AQ address. */
+		iowrite16be(GVE_ADMINQ_BUFFER_SIZE,
+			    &priv->reg_bar0->adminq_length);
+		iowrite32be(priv->adminq_dma_mem.pa >> 32,
+			    &priv->reg_bar0->adminq_base_address_hi);
+		iowrite32be(priv->adminq_dma_mem.pa,
+			    &priv->reg_bar0->adminq_base_address_lo);
+		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK,
+			    &priv->reg_bar0->driver_status);
+	}
 
 	gve_set_admin_queue_ok(priv);
 	return 0;
@@ -233,16 +254,30 @@ void gve_adminq_release(struct gve_priv *priv)
 	int i = 0;
 
 	/* Tell the device the adminq is leaving */
-	iowrite32be(0x0, &priv->reg_bar0->adminq_pfn);
-	while (ioread32be(&priv->reg_bar0->adminq_pfn)) {
-		/* If this is reached the device is unrecoverable and still
-		 * holding memory. Continue looping to avoid memory corruption,
-		 * but WARN so it is visible what is going on.
-		 */
-		if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
-			PMD_DRV_LOG(WARNING, "Unrecoverable platform error!");
-		i++;
-		msleep(GVE_ADMINQ_SLEEP_LEN);
+	if (gve_get_pci_revision_id(priv) < 0x1) {
+		iowrite32be(0x0, &priv->reg_bar0->adminq_pfn);
+		while (ioread32be(&priv->reg_bar0->adminq_pfn)) {
+			/* If this is reached the device is unrecoverable and still
+			 * holding memory. Continue looping to avoid memory corruption,
+			 * but WARN so it is visible what is going on.
+			 */
+			if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
+				PMD_DRV_LOG(WARNING,
+					    "Unrecoverable platform error!");
+			i++;
+			msleep(GVE_ADMINQ_SLEEP_LEN);
+		}
+	} else {
+		iowrite32be(GVE_DRIVER_STATUS_RESET_MASK,
+			    &priv->reg_bar0->driver_status);
+		while (!(ioread32be(&priv->reg_bar0->device_status)
+			 & GVE_DEVICE_STATUS_DEVICE_IS_RESET)) {
+			if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
+				PMD_DRV_LOG(WARNING,
+					    "Unrecoverable platform error!");
+			i++;
+			msleep(GVE_ADMINQ_SLEEP_LEN);
+		}
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
index d9c82c43e3..5eb33930cd 100644
--- a/drivers/net/gve/base/gve_osdep.h
+++ b/drivers/net/gve/base/gve_osdep.h
@@ -130,18 +130,36 @@ writeb(u8 value, volatile void *addr)
 	rte_write8(value, addr);
 }
 
+static __rte_always_inline void
+writew(u16 value, volatile void *addr)
+{
+	rte_write16(value, addr);
+}
+
 static __rte_always_inline void
 writel(u32 value, volatile void *addr)
 {
 	rte_write32(value, addr);
 }
 
+static __rte_always_inline u16
+ioread16be(const volatile void *addr)
+{
+	return rte_be_to_cpu_16(rte_read16(addr));
+}
+
 static __rte_always_inline u32
 ioread32be(const volatile void *addr)
 {
 	return rte_be_to_cpu_32(rte_read32(addr));
 }
 
+static __rte_always_inline void
+iowrite16be(u16 value, volatile void *addr)
+{
+	writew(rte_cpu_to_be_16(value), addr);
+}
+
 static __rte_always_inline void
 iowrite32be(u32 value, volatile void *addr)
 {
diff --git a/drivers/net/gve/base/gve_register.h b/drivers/net/gve/base/gve_register.h
index c674167f31..d3be475744 100644
--- a/drivers/net/gve/base/gve_register.h
+++ b/drivers/net/gve/base/gve_register.h
@@ -19,11 +19,21 @@ struct gve_registers {
 	__be32	adminq_event_counter;
 	u8	reserved[3];
 	u8	driver_version;
+	__be32	adminq_base_address_hi;
+	__be32	adminq_base_address_lo;
+	__be16	adminq_length;
 };
 
 enum gve_device_status_flags {
 	GVE_DEVICE_STATUS_RESET_MASK		= BIT(1),
 	GVE_DEVICE_STATUS_LINK_STATUS_MASK	= BIT(2),
 	GVE_DEVICE_STATUS_REPORT_STATS_MASK	= BIT(3),
+	GVE_DEVICE_STATUS_DEVICE_IS_RESET	= BIT(4),
 };
+
+enum gve_driver_status_flags {
+	GVE_DRIVER_STATUS_RUN_MASK		= BIT(0),
+	GVE_DRIVER_STATUS_RESET_MASK		= BIT(1),
+};
+
 #endif /* _GVE_REGISTER_H_ */
-- 
2.49.0.604.gff1f9ca942-goog

