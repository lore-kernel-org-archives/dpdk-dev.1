Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2C606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgBsVqUJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8598140658;
	Mon, 26 Oct 2026 19:11:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 744B9406A2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVrAB8wzXaqEOQNOJa844mNsBbNyBD8oNIo2g8Xg3X0=;
 b=GgBsVqUJawoMoKH8YgGKBGYvOEj+0WsfW4K4ibfMI+CzHplrhOi7nv7ny3O5FNqtnCemvI
 0OeCdKKtwjeLfrTmI/UuODSS2pR7CXya0g36RHoqGM8UylZu22mAF+q6CRgCGDOr1+/Mn4
 OtoRG1ZLxXsagpjc2iBFxbQzpv+GWd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-IHKLi2AbM_iR45uSudu9yA-1; Mon,
 26 Oct 2026 14:11:08 -0400
X-MC-Unique: IHKLi2AbM_iR45uSudu9yA-1
X-Mimecast-MFC-AGG-ID: IHKLi2AbM_iR45uSudu9yA_1793038268
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 194DF1956064; Mon, 26 Oct 2026 18:11:08 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 311AE1956088; Mon, 26 Oct 2026 18:11:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 10/16] bus/fslmc: simplify device parsing in scan
Date: Mon, 26 Oct 2026 19:10:24 +0100
Message-ID: <20261026181031.304100-11-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xWiT72JqwGKeRmmdt7m53TdvjCzVAca1DCQc2ejRiwY_1793038268
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Refactor string manipulations and avoid unneeded allocation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- declared dev_types as static const,
- restored dev_id parsing for "unknown" devices,

---
 drivers/bus/fslmc/fslmc_bus.c | 87 ++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index b032a64620..0600f1afd5 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -123,18 +123,47 @@ dump_device_list(void)
 static int
 scan_one_fslmc_device(char *dev_name)
 {
-	char *dup_dev_name, *t_ptr;
+	enum rte_dpaa2_dev_type dev_type = DPAA2_UNKNOWN;
 	struct rte_dpaa2_device *dev = NULL;
+	static const struct {
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
+	char *dev_id;
 	int ret = -1;
 
-	if (!dev_name)
+	if (dev_name == NULL)
 		return ret;
 
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
+	}
+
+	if (dev_type == DPAA2_UNKNOWN) {
+		char *ptr = strchr(dev_name, '.');
+
+		if (ptr == NULL) {
+			DPAA2_BUS_ERR("Invalid device found: (%s)", dev_name);
+			ret = 0;
+			goto cleanup;
+		}
+		dev_id = ptr + 1;
 	}
 
 	/* For all other devices, we allocate rte_dpaa2_device.
@@ -145,11 +174,11 @@ scan_one_fslmc_device(char *dev_name)
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
@@ -160,46 +189,12 @@ scan_one_fslmc_device(char *dev_name)
 		goto cleanup;
 	}
 
-	/* Parse the device name and ID */
-	t_ptr = strtok(dup_dev_name, ".");
-	if (!t_ptr) {
-		DPAA2_BUS_ERR("Invalid device found: (%s)", dup_dev_name);
+	if (sscanf(dev_id, "%hu", &dev->object_id) != 1) {
+		DPAA2_BUS_ERR("Failed to parse object ID");
 		ret = -EINVAL;
 		goto cleanup;
 	}
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
-		ret = 0;
-		goto cleanup;
-	}
 
-	sscanf(t_ptr, "%hu", &dev->object_id);
 	if (rte_strscpy(dev->name, dev_name, sizeof(dev->name)) < 0) {
 		DPAA2_BUS_ERR("Unable to copy device name: %s", rte_strerror(rte_errno));
 		ret = -rte_errno;
@@ -211,12 +206,8 @@ scan_one_fslmc_device(char *dev_name)
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

