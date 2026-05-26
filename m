Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F179CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E49B4066C;
	Tue, 26 May 2026 10:54:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E56E1406B4
 for <dev@dpdk.org>; Tue, 26 May 2026 10:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779785646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDH81msTmLj8/Yq8B/umnj9iNKLj8Ktyged18jXA4d0=;
 b=ANJWc4c1d0iuuyLy9SqIr9lsO/LhPX5N1BgF1kWaNCd07UtTPqIYzdpXkZyzbJLTB0NeZD
 hKfm+GRCiS7BLBQ0Pn+BevT7r8cx3OILBMIus8zdc76nty4FS/Zt+Xlnh3VdXhF8QGafs5
 QYqBaNCt+Tmq81hynFuvFp6P3mREnbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-SxdywPZCOO2VmIhsxZH5AQ-1; Tue,
 26 May 2026 04:54:02 -0400
X-MC-Unique: SxdywPZCOO2VmIhsxZH5AQ-1
X-Mimecast-MFC-AGG-ID: SxdywPZCOO2VmIhsxZH5AQ_1779785641
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5344019560A5; Tue, 26 May 2026 08:54:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9413930001BB; Tue, 26 May 2026 08:53:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v3 21/25] dma/idxd: remove specific bus type
Date: Tue, 26 May 2026 10:52:51 +0200
Message-ID: <20260526085257.3148516-8-david.marchand@redhat.com>
In-Reply-To: <20260526085257.3148516-1-david.marchand@redhat.com>
References: <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526085257.3148516-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NzIMNDGWK9q1e7zOmkoGuCSR_1p7EMYeMtV8SI6xlW8_1779785641
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

There is nothing that requires a specific bus type.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/dma/idxd/idxd_bus.c | 38 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 1a9c07580e..4810d52f2a 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -41,34 +41,24 @@ struct rte_dsa_device {
 };
 
 /* forward prototypes */
-struct dsa_bus;
 static int dsa_scan(void);
 static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev);
 static int dsa_probe_device(struct rte_driver *drv, struct rte_device *dev);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
 
-/**
- * Structure describing the DSA bus
- */
-struct dsa_bus {
-	struct rte_bus bus;               /**< Inherit the generic class */
-	struct rte_driver driver;         /**< Driver struct for devices to point to */
+struct rte_bus dsa_bus = {
+	.scan = dsa_scan,
+	.probe = rte_bus_generic_probe,
+	.match = dsa_match,
+	.probe_device = dsa_probe_device,
+	.find_device = rte_bus_generic_find_device,
+	.get_iommu_class = dsa_get_iommu_class,
+	.parse = dsa_addr_parse,
 };
 
-struct dsa_bus dsa_bus = {
-	.bus = {
-		.scan = dsa_scan,
-		.probe = rte_bus_generic_probe,
-		.match = dsa_match,
-		.probe_device = dsa_probe_device,
-		.find_device = rte_bus_generic_find_device,
-		.get_iommu_class = dsa_get_iommu_class,
-		.parse = dsa_addr_parse,
-	},
-	.driver = {
-		.name = "dmadev_idxd",
-	},
+struct rte_driver dsa_driver = {
+	.name = "dmadev_idxd",
 };
 
 static inline const char *
@@ -267,7 +257,7 @@ static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev
 {
 	const struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
 
-	if (drv == &dsa_bus.driver) {
+	if (drv == &dsa_driver) {
 		char type[64], name[64];
 
 		if (read_wq_string(dsa_dev, "type", type, sizeof(type)) >= 0 &&
@@ -319,7 +309,7 @@ dsa_scan(void)
 			continue;
 		}
 		strlcpy(dev->wq_name, wq->d_name, sizeof(dev->wq_name));
-		rte_bus_add_device(&dsa_bus.bus, &dev->device);
+		rte_bus_add_device(&dsa_bus, &dev->device);
 		devcount++;
 
 		read_device_int(dev, "numa_node", &numa_node);
@@ -357,8 +347,8 @@ dsa_addr_parse(const char *name, void *addr)
 	return 0;
 }
 
-RTE_REGISTER_BUS(dsa, dsa_bus.bus);
+RTE_REGISTER_BUS(dsa, dsa_bus);
 RTE_INIT(dsa_bus_init)
 {
-	rte_bus_add_driver(&dsa_bus.bus, &dsa_bus.driver);
+	rte_bus_add_driver(&dsa_bus, &dsa_driver);
 }
-- 
2.53.0

