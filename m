Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6540606A32C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m1kmyrEW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F440402EA;
	Thu, 19 Nov 2026 17:34:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 14953400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 17:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795106075; x=1826642075;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0LjYnc20DaXGzJriLedBnPC5nUAthETKGuLjMkMVcns=;
 b=m1kmyrEWUewTT/ia5vfacCNDVvkxhZF2evxJUzGKAf420N2GMwjaDeuF
 z4QjzATHLOZFA/AETtN3oRLQ7L1UJ6OfYz1Xdcsyb1f+fANoWQqcgXzQt
 39Vr8DNjhylPI+am9TwDFlegXvXCBBth3CyllbxLCElUWWoG5qD5BIa0N
 B8otxxSe41+EESj8KPz7JmCkGNjGTUBuGgy+yp5r8C39UulQTIPcHkIBv
 V8/ONL1bRYisYB1zg6L44AxYJDCq7XJMBxuq/A8FE5l6LBvkdP6jpuzlN
 y/a1mdmetisGLyYc2c92s143gd/x7ywfPTyPrv9KhMTXlJ2bvmTvDjhyg w==;
X-CSE-ConnectionGUID: WaOfoIvTQQ6TYhXyxneG1g==
X-CSE-MsgGUID: O2tJqw4aTSW+fS3l/MvK3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3883003"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3883003"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:34:35 -0800
X-CSE-ConnectionGUID: UdbmBOYeRUCebR06h94+gg==
X-CSE-MsgGUID: zONfllhlRCuUWS02I2leTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10807968"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 19 Nov 2026 08:34:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/2] net/virtio: initialize device once per configuration
Date: Thu, 19 Nov 2026 16:34:29 +0000
Message-ID: <d762a64405f7f805afcf7141998f272886fcf52d.1795106045.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5742c809e0515dbe0373788c1e9fff09b7cc1b46.1795106045.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Calculate the requested virtio features before initializing the device,
and combine the interrupt, feature-change, and missing-queue conditions
into a single initialization. This avoids resetting and rebuilding the
device twice when Rx interrupts and feature changes are requested together.
Also reinitialize when Rx interrupt resources are still allocated but
Rx interrupts are no longer requested, so that they are released.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/virtio/virtio_ethdev.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index c595b8edcb2..0d726dc8497 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1444,6 +1444,14 @@ virtio_queues_unbind_intr(struct rte_eth_dev *dev)
 					     VIRTIO_MSI_NO_VECTOR);
 }
 
+static bool
+virtio_vfio_intr_enabled(const struct rte_eth_dev *dev)
+{
+	return dev->intr_handle != NULL &&
+			rte_intr_type_get(dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
+			rte_intr_nb_efd_get(dev->intr_handle) > 0;
+}
+
 static int
 virtio_configure_intr(struct rte_eth_dev *dev)
 {
@@ -1865,9 +1873,7 @@ virtio_init_device(struct rte_eth_dev *eth_dev, uint64_t req_features)
 	int ret;
 
 	/* Release Rx interrupt resources left by a previous initialization. */
-	if (eth_dev->intr_handle != NULL &&
-			rte_intr_type_get(eth_dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
-			rte_intr_nb_efd_get(eth_dev->intr_handle) > 0) {
+	if (virtio_vfio_intr_enabled(eth_dev)) {
 		virtio_intr_disable(eth_dev);
 		rte_intr_efd_disable(eth_dev->intr_handle);
 		rte_intr_vec_list_free(eth_dev->intr_handle);
@@ -2250,12 +2256,6 @@ virtio_dev_configure(struct rte_eth_dev *dev)
 	PMD_INIT_LOG(DEBUG, "configure");
 	req_features = VIRTIO_PMD_DEFAULT_GUEST_FEATURES;
 
-	if (dev->data->dev_conf.intr_conf.rxq) {
-		ret = virtio_init_device(dev, hw->req_guest_features);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (rxmode->mq_mode == RTE_ETH_MQ_RX_RSS)
 		req_features |= (1ULL << VIRTIO_NET_F_RSS);
 
@@ -2286,20 +2286,13 @@ virtio_dev_configure(struct rte_eth_dev *dev)
 			(1ULL << VIRTIO_NET_F_HOST_TSO4) |
 			(1ULL << VIRTIO_NET_F_HOST_TSO6);
 
-	/* if request features changed, reinit the device */
-	if (req_features != hw->req_guest_features) {
+	if (dev->data->dev_conf.intr_conf.rxq || virtio_vfio_intr_enabled(dev) ||
+			req_features != hw->req_guest_features || hw->vqs == NULL) {
 		ret = virtio_init_device(dev, req_features);
 		if (ret < 0)
 			return ret;
 	}
 
-	/* if queues are not allocated, reinit the device */
-	if (hw->vqs == NULL) {
-		ret = virtio_init_device(dev, hw->req_guest_features);
-		if (ret < 0)
-			return ret;
-	}
-
 	if ((rxmode->mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) &&
 			!virtio_with_feature(hw, VIRTIO_NET_F_RSS)) {
 		PMD_DRV_LOG(ERR, "RSS support requested but not supported by the device");
-- 
2.52.0

