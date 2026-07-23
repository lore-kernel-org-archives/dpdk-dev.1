Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064BC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C515540B92;
	Thu, 23 Jul 2026 15:54:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1E7E74068E
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMVz1S0LZmTRwWEMy1A/f9SC4kdr5HOsnPl9Zx5jtrg=;
 b=ezGwr78vMeGYTqO3/TCp8QdUi7YCB/SYFNMEwSlTUSg8J13DEEW8dAJvoFvUfytf2Cd2aG
 3cDPewxTVMFeaOErfBDVxJj6OJ3Bdq471BU6PSyV5pUO/resa1EFw+0WOJ0B5knjv5Mrkv
 QVOEW3Ht0RgoaLtAkO2QRNr9rNwqkok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-3Q8n2SkROq2_oBhs9kN-cQ-1; Thu,
 23 Jul 2026 09:54:35 -0400
X-MC-Unique: 3Q8n2SkROq2_oBhs9kN-cQ-1
X-Mimecast-MFC-AGG-ID: 3Q8n2SkROq2_oBhs9kN-cQ_1784814873
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BF018009EA; Thu, 23 Jul 2026 13:54:33 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16B221956054; Thu, 23 Jul 2026 13:54:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 06/11] bus/fslmc: simplify device parsing in scan
Date: Thu, 23 Jul 2026 15:53:54 +0200
Message-ID: <20260723135400.3621271-7-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wIp0Ax0ObYKYukb0C8HlFBgL9aV0p97ZLre9ksDF-Kw_1784814873
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

Refactor string manipulations and avoid unneeded allocation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 78 +++++++++++++----------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a7ac59173f..4f6e0bf387 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -116,18 +116,33 @@ dump_device_list(void)
 static int
 scan_one_fslmc_device(char *dev_name)
 {
-	char *dup_dev_name, *t_ptr;
+	enum rte_dpaa2_dev_type dev_type = DPAA2_UNKNOWN;
 	struct rte_dpaa2_device *dev = NULL;
+	struct {
+		const char *prefix;
+		enum rte_dpaa2_dev_type type;
+	} dev_types[] = {
+		{ "dpni.", DPAA2_ETH },
+		{ "dpseci.", DPAA2_CRYPTO },
+		{ "dpcon.", DPAA2_CON },
+		{ "dpbp.", DPAA2_BPOOL },
+		{ "dpio.", DPAA2_IO },
+		{ "dpci.", DPAA2_CI },
+		{ "dpmcp.", DPAA2_MPORTAL },
+		{ "dpdmai.", DPAA2_QDMA },
+		{ "dpdmux.", DPAA2_MUX },
+		{ "dprtc.", DPAA2_DPRTC },
+		{ "dprc.", DPAA2_DPRC },
+	};
+	char *dev_id = NULL;
 	int ret = -1;
 
-	if (!dev_name)
-		return ret;
-
-	/* Creating a temporary copy to perform cut-parse over string */
-	dup_dev_name = strdup(dev_name);
-	if (!dup_dev_name) {
-		DPAA2_BUS_ERR("Unable to allocate device name memory");
-		return -ENOMEM;
+	for (unsigned int i = 0; i < RTE_DIM(dev_types); i++) {
+		if (strncmp(dev_types[i].prefix, dev_name, strlen(dev_types[i].prefix)) != 0)
+			continue;
+		dev_id = dev_name + strlen(dev_types[i].prefix);
+		dev_type = dev_types[i].type;
+		break;
 	}
 
 	/* For all other devices, we allocate rte_dpaa2_device.
@@ -138,11 +153,11 @@ scan_one_fslmc_device(char *dev_name)
 	dev = calloc(1, sizeof(struct rte_dpaa2_device));
 	if (!dev) {
 		DPAA2_BUS_ERR("Unable to allocate device object");
-		free(dup_dev_name);
 		return -ENOMEM;
 	}
 
 	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->dev_type = dev_type;
 
 	/* Allocate interrupt instance */
 	dev->intr_handle =
@@ -153,46 +168,13 @@ scan_one_fslmc_device(char *dev_name)
 		goto cleanup;
 	}
 
-	/* Parse the device name and ID */
-	t_ptr = strtok(dup_dev_name, ".");
-	if (!t_ptr) {
-		DPAA2_BUS_ERR("Invalid device found: (%s)", dup_dev_name);
-		ret = -EINVAL;
-		goto cleanup;
-	}
-	if (!strncmp("dpni", t_ptr, 4))
-		dev->dev_type = DPAA2_ETH;
-	else if (!strncmp("dpseci", t_ptr, 6))
-		dev->dev_type = DPAA2_CRYPTO;
-	else if (!strncmp("dpcon", t_ptr, 5))
-		dev->dev_type = DPAA2_CON;
-	else if (!strncmp("dpbp", t_ptr, 4))
-		dev->dev_type = DPAA2_BPOOL;
-	else if (!strncmp("dpio", t_ptr, 4))
-		dev->dev_type = DPAA2_IO;
-	else if (!strncmp("dpci", t_ptr, 4))
-		dev->dev_type = DPAA2_CI;
-	else if (!strncmp("dpmcp", t_ptr, 5))
-		dev->dev_type = DPAA2_MPORTAL;
-	else if (!strncmp("dpdmai", t_ptr, 6))
-		dev->dev_type = DPAA2_QDMA;
-	else if (!strncmp("dpdmux", t_ptr, 6))
-		dev->dev_type = DPAA2_MUX;
-	else if (!strncmp("dprtc", t_ptr, 5))
-		dev->dev_type = DPAA2_DPRTC;
-	else if (!strncmp("dprc", t_ptr, 4))
-		dev->dev_type = DPAA2_DPRC;
-	else
-		dev->dev_type = DPAA2_UNKNOWN;
-
-	t_ptr = strtok(NULL, ".");
-	if (!t_ptr) {
-		DPAA2_BUS_ERR("Skipping invalid device (%s)", dup_dev_name);
+	if (dev_id == NULL) {
+		DPAA2_BUS_ERR("Skipping invalid device (%s)", dev_name);
 		ret = 0;
 		goto cleanup;
 	}
 
-	sscanf(t_ptr, "%hu", &dev->object_id);
+	sscanf(dev_id, "%hu", &dev->object_id);
 	dev->device.name = strdup(dev_name);
 	if (!dev->device.name) {
 		DPAA2_BUS_ERR("Unable to clone device name. Out of memory");
@@ -204,12 +186,8 @@ scan_one_fslmc_device(char *dev_name)
 	/* Add device in the fslmc device list */
 	insert_in_device_list(dev);
 
-	/* Don't need the duplicated device filesystem entry anymore */
-	free(dup_dev_name);
-
 	return 0;
 cleanup:
-	free(dup_dev_name);
 	if (dev) {
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
-- 
2.54.0

