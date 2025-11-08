Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F8CCFA13
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 15:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F27340612;
	Sat,  8 Nov 2025 16:32:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE2B40608
 for <dev@dpdk.org>; Sat,  8 Nov 2025 16:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762615959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqhsfnrbYdZiAglGRFaf6PpKl5HLgp6ZZz6UzwkEF8c=;
 b=CXbxF1uUsryy9c4I6FO/QIz+rFz7hiUnbw1mhY+rc5P/ElLs0JXLkUUKY0UOeuY3BvIv7P
 hMLgxulbsntj6UJTnf5Zq0ueL1IMQuJFNbfj4YgrthNnwzov/6AVzIh+NPETwEu36ek3Wk
 JZ1hA0Xx6XL9TahFRKj+fw0H4IbyrPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-nGsC-jcsN2yK3xzxTfx52Q-1; Sat,
 08 Nov 2025 10:32:34 -0500
X-MC-Unique: nGsC-jcsN2yK3xzxTfx52Q-1
X-Mimecast-MFC-AGG-ID: nGsC-jcsN2yK3xzxTfx52Q_1762615952
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 553AC195608F; Sat,  8 Nov 2025 15:32:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7551A1955BE3; Sat,  8 Nov 2025 15:32:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 4/5] net/dpaa2: remove ethdev device in bus device
Date: Sat,  8 Nov 2025 16:32:05 +0100
Message-ID: <20251108153207.1512863-5-david.marchand@redhat.com>
In-Reply-To: <20251108153207.1512863-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ArrqUQBmaEjjzjRAWFk_tIUIvh4FPDawJklBAdYSpE_1762615952
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Calling rte_eth_dev_allocated() is enough to retrieve the
ethdev device object.

This leaves no user of the ethdev field in the fslmc device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
 drivers/net/dpaa2/dpaa2_ethdev.c     | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index efa88754a7..094f885f59 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -98,7 +98,6 @@ struct rte_dpaa2_device {
 	TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device. */
 	struct rte_device device;           /**< Inherit core device */
 	union {
-		struct rte_eth_dev *eth_dev;        /**< ethernet device */
 		struct rte_rawdev *rawdev;          /**< Raw Device */
 	};
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..2a26a02cb4 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3320,7 +3320,6 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
 
 	eth_dev->device = &dpaa2_dev->device;
 
-	dpaa2_dev->eth_dev = eth_dev;
 	eth_dev->data->rx_mbuf_alloc_failed = 0;
 
 	if (dpaa2_drv->drv_flags & RTE_DPAA2_DRV_INTR_LSC)
@@ -3349,7 +3348,10 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 	struct rte_eth_dev *eth_dev;
 	int ret;
 
-	eth_dev = dpaa2_dev->eth_dev;
+	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
+	if (!eth_dev)
+		return 0;
+
 	dpaa2_dev_close(eth_dev);
 	dpaa2_valid_dev--;
 	if (!dpaa2_valid_dev)
-- 
2.51.0

