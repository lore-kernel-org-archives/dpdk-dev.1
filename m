Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BF606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHW7lIqd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1226440693;
	Mon, 26 Oct 2026 19:10:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 30FB84068E
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oP6c0YglF09Sin4q06QITxLT5UiOI3G8SiK1mhaPrg=;
 b=UHW7lIqdfjXoyZ71xuTcaRkgmqQcTWTQh+fECpfcA8pYOV6JvCzZbu9AqStIvaKW0y+lqH
 JZQ8lAmY8uGl01z3/q9Z7r5PWn6tYmOBcND9E61YNssfj+JPs9zNfuh1CV8zm4IRTxQ7z5
 UL1jOBFrptdiYyj2WntU/J1+dVuCb1g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-Hh6wuI0KOLCkmDJcqnGY-Q-1; Mon,
 26 Oct 2026 14:10:52 -0400
X-MC-Unique: Hh6wuI0KOLCkmDJcqnGY-Q-1
X-Mimecast-MFC-AGG-ID: Hh6wuI0KOLCkmDJcqnGY-Q_1793038251
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E4DE1955BD3; Mon, 26 Oct 2026 18:10:51 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2C021956087; Mon, 26 Oct 2026 18:10:50 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 05/16] bus/fslmc: fix device name leak
Date: Mon, 26 Oct 2026 19:10:19 +0100
Message-ID: <20261026181031.304100-6-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fgqad8oDwdc3yggYHS_bSTM4qFhE88HehOys8pnQgUc_1793038251
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

The device name allocated during scan was never freed.
Store it to the (unused) name field in the rte_dpaa2_device.

This simplifies the device freeing to a simple free() call later.

Fixes: 828d51d8fc3e ("bus/fslmc: refactor scan and probe functions")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 4 +---
 drivers/bus/fslmc/fslmc_bus.c        | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 44f81cf662..ead9d6613c 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -39,8 +39,6 @@ extern "C" {
 
 struct vfio_device_info;
 
-#define FSLMC_OBJECT_MAX_LEN 32   /**< Length of each device on bus */
-
 #define DPAA2_INVALID_MBUF_SEQN        0
 
 typedef uint32_t dpaa2_seqn_t;
@@ -101,7 +99,7 @@ struct rte_dpaa2_device {
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
-	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
+	char name[RTE_DEV_NAME_MAX_LEN];
 };
 
 typedef int (*rte_dpaa2_obj_create_t)(int vdev_fd,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 98bd898acb..632142d128 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -179,12 +179,12 @@ scan_one_fslmc_device(char *dev_name)
 	}
 
 	sscanf(t_ptr, "%hu", &dev->object_id);
-	dev->device.name = strdup(dev_name);
-	if (!dev->device.name) {
-		DPAA2_BUS_ERR("Unable to clone device name. Out of memory");
-		ret = -ENOMEM;
+	if (rte_strscpy(dev->name, dev_name, sizeof(dev->name)) < 0) {
+		DPAA2_BUS_ERR("Unable to copy device name: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
 		goto cleanup;
 	}
+	dev->device.name = dev->name;
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
 	/* Update the device found into the device_count table */
-- 
2.54.0

