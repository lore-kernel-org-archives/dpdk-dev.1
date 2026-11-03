Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70355606D2DC
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B4u5XtTJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D33CE41133;
	Tue,  3 Nov 2026 15:54:29 +0100 (CET)
Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
 by mails.dpdk.org (Postfix) with ESMTPS id 2FB554161A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:28 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Xb5RJZ9KrLqCG2lNakyodyRFxZE8pvaCOQcSmyCDGq8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717667; v=1; x=1794322467;
 b=B4u5XtTJss5BwyqXzFLk2LqUf9SS0G9zIVAQWfbvNBP1HQo3V/i8/eQNBDptg+w2DjgshPtB
 c4x7XlUtd1iWMEuy+al6ufWs5Tfp2QGc6/3Jfmx5Uo51zw+rsZsQz0BEeqs2RXUO5TeYMYDozOf
 1J5+Al1jLB+9voengN/kf7qE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 472b22c288b84254;
 Tue, 03 Nov 2026 14:54:26 +0000
X-Mizu-Trace-ID: 472b22c288b84254
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 009/227] rawdev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:27 +0800
Message-ID: <20261103145306.487255-10-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the exported function rte_rawdev_socket_id() to
rte_rawdev_numa_id(), keeping the old name as a functional
alias to be deprecated once the in-tree migration completes.

Rename the numa_id fields of rte_rawdev and rte_rawdev_info
(was socket_id), keeping socket_id as a deprecated union alias,
and update in-tree users accordingly.

Also rename internal parameters and comments to the NUMA node
terminology.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/raw/ntb/ntb.c       |  8 ++++----
 lib/rawdev/rte_rawdev.c     | 25 ++++++++++++++++---------
 lib/rawdev/rte_rawdev.h     | 37 +++++++++++++++++++++++++++++++++----
 lib/rawdev/rte_rawdev_pmd.h |  8 ++++----
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index fe10782ecf..9f29d409e4 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -190,7 +190,7 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 	rxq = rte_zmalloc_socket("ntb rx queue",
 				 sizeof(struct ntb_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 dev->socket_id);
+				 dev->numa_id);
 	if (!rxq) {
 		NTB_LOG(ERR, "Failed to allocate memory for "
 			    "rx queue data structure.");
@@ -213,7 +213,7 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 				   sizeof(struct ntb_rx_entry) *
 				   rxq->nb_rx_desc,
 				   RTE_CACHE_LINE_SIZE,
-				   dev->socket_id);
+				   dev->numa_id);
 	if (!rxq->sw_ring) {
 		ntb_rxq_release(rxq);
 		rxq = NULL;
@@ -276,7 +276,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 	txq = rte_zmalloc_socket("ntb tx queue",
 				  sizeof(struct ntb_tx_queue),
 				  RTE_CACHE_LINE_SIZE,
-				  dev->socket_id);
+				  dev->numa_id);
 	if (!txq) {
 		NTB_LOG(ERR, "Failed to allocate memory for "
 			    "tx queue structure");
@@ -294,7 +294,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 				   sizeof(struct ntb_tx_entry) *
 				   txq->nb_tx_desc,
 				   RTE_CACHE_LINE_SIZE,
-				   dev->socket_id);
+				   dev->numa_id);
 	if (!txq->sw_ring) {
 		ntb_txq_release(txq);
 		txq = NULL;
diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index d193061842..b1c8db54ca 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -56,16 +56,23 @@ rte_rawdev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_socket_id)
+RTE_EXPORT_SYMBOL(rte_rawdev_numa_id)
 int
-rte_rawdev_socket_id(uint16_t dev_id)
+rte_rawdev_numa_id(uint16_t dev_id)
 {
 	struct rte_rawdev *dev;
 
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	return dev->socket_id;
+	return dev->numa_id;
+}
+
+RTE_EXPORT_SYMBOL(rte_rawdev_socket_id)
+int
+rte_rawdev_socket_id(uint16_t dev_id)
+{
+	return rte_rawdev_numa_id(dev_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_rawdev_info_get)
@@ -92,7 +99,7 @@ rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 
 	dev_info->driver_name = rawdev->driver_name;
 	dev_info->device = rawdev->device;
-	dev_info->socket_id = rawdev->socket_id;
+	dev_info->numa_id = rawdev->numa_id;
 
 	return ret;
 }
@@ -526,7 +533,7 @@ rte_rawdev_find_free_device_index(void)
 
 RTE_EXPORT_SYMBOL(rte_rawdev_pmd_allocate)
 struct rte_rawdev *
-rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
+rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int numa_id)
 {
 	struct rte_rawdev *rawdev;
 	uint16_t dev_id;
@@ -545,10 +552,10 @@ rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 	rawdev = &rte_rawdevs[dev_id];
 
 	if (dev_priv_size > 0) {
-		rawdev->dev_private = rte_zmalloc_socket("rawdev private",
+		rawdev->dev_private = rte_zmalloc_numa("rawdev private",
 				     dev_priv_size,
 				     RTE_CACHE_LINE_SIZE,
-				     socket_id);
+				     numa_id);
 		if (!rawdev->dev_private) {
 			RTE_RDEV_ERR("Unable to allocate memory for rawdev");
 			return NULL;
@@ -556,7 +563,7 @@ rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 	}
 
 	rawdev->dev_id = dev_id;
-	rawdev->socket_id = socket_id;
+	rawdev->numa_id = numa_id;
 	rawdev->started = 0;
 	strlcpy(rawdev->name, name, RTE_RAWDEV_NAME_MAX_LEN);
 
@@ -583,7 +590,7 @@ rte_rawdev_pmd_release(struct rte_rawdev *rawdev)
 	rawdev_globals.nb_devs--;
 
 	rawdev->dev_id = 0;
-	rawdev->socket_id = 0;
+	rawdev->numa_id = 0;
 	rawdev->dev_ops = NULL;
 	if (rawdev->dev_private) {
 		rte_free(rawdev->dev_private);
diff --git a/lib/rawdev/rte_rawdev.h b/lib/rawdev/rte_rawdev.h
index ad849e5bea..0ca7b5e111 100644
--- a/lib/rawdev/rte_rawdev.h
+++ b/lib/rawdev/rte_rawdev.h
@@ -47,9 +47,24 @@ rte_rawdev_count(void);
 int
 rte_rawdev_get_dev_id(const char *name);
 
+/**
+ * Return the NUMA node to which a device is connected.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @return
+ *   The NUMA node ID to which the device is connected or
+ *   a default of zero if the NUMA node could not be determined.
+ *   -(-EINVAL)  dev_id value is out of range.
+ */
+int
+rte_rawdev_numa_id(uint16_t dev_id);
+
 /**
  * Return the NUMA socket to which a device is connected.
  *
+ * This is a legacy alias of rte_rawdev_numa_id().
+ *
  * @param dev_id
  *   The identifier of the device.
  * @return
@@ -280,8 +295,15 @@ rte_rawdev_reset(uint16_t dev_id);
  * related to framework.
  */
 struct __rte_cache_aligned rte_rawdev {
-	/**< Socket ID where memory is allocated */
-	int socket_id;
+	union {
+		/** NUMA node ID where memory is allocated */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	/**< Device ID for this instance */
 	uint16_t dev_id;
 	/**< Functions exported by PMD */
@@ -311,8 +333,15 @@ struct rte_rawdev_info {
 	const char *driver_name;
 	/**< Device encapsulation */
 	struct rte_device *device;
-	/**< Socket ID where memory is allocated */
-	int socket_id;
+	union {
+		/** NUMA node ID where memory is allocated */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	/**< PMD-specific private data */
 	rte_rawdev_obj_t dev_private;
 };
diff --git a/lib/rawdev/rte_rawdev_pmd.h b/lib/rawdev/rte_rawdev_pmd.h
index 02351a2a29..639fa0de87 100644
--- a/lib/rawdev/rte_rawdev_pmd.h
+++ b/lib/rawdev/rte_rawdev_pmd.h
@@ -604,14 +604,14 @@ struct rte_rawdev_ops {
  *   Size of private data memory allocated within rte_rawdev object.
  *   Set to 0 to disable internal memory allocation and allow for
  *   self-allocation.
- * @param socket_id
+ * @param numa_id
  *   Socket to allocate resources on.
  * @return
  *   - Slot in the rte_dev_devices array for a new device;
  */
 struct rte_rawdev *
 rte_rawdev_pmd_allocate(const char *name, size_t dev_private_size,
-			int socket_id);
+			int numa_id);
 
 /**
  * Release the specified rawdev device.
@@ -631,7 +631,7 @@ rte_rawdev_pmd_release(struct rte_rawdev *rawdev);
  *   Pointer to a character array containing name of the device
  * @param dev_private_size
  *   Size of raw PMDs private data
- * @param socket_id
+ * @param numa_id
  *   Socket to allocate resources on.
  *
  * @return
@@ -640,7 +640,7 @@ rte_rawdev_pmd_release(struct rte_rawdev *rawdev);
  */
 struct rte_rawdev *
 rte_rawdev_pmd_init(const char *name, size_t dev_private_size,
-		    int socket_id);
+		    int numa_id);
 
 /**
  * Destroy a raw device
-- 
2.55.0

