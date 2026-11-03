Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5B6071A12
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Gt5/nvIT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B8DD42DA7;
	Tue,  3 Nov 2026 16:18:43 +0100 (CET)
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
 by mails.dpdk.org (Postfix) with ESMTPS id 269184060F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:18:41 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ZTufDni+QS5ETdkZfeDbgxl/KMHhRd42NFL4hB+Hlek=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719120; v=1; x=1794323920;
 b=Gt5/nvITHltm2CiGVBTiAwEWkmzP5ieAD0xi+5SWKmIUp5euQovmQ5VMnXBlSUoh+uT7OdQc
 3iaCl0w2Jropeg8IvPoBK1Qy6w6CIGfk2MRV1ifnRdz6xjg5u79I4i5DJS1jn2bX2N8+Kkijx7y
 UeHe5fUp67vwcwclsh44OCJg=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id a83e131731f68f32;
 Tue, 03 Nov 2026 15:18:40 +0000
X-Mizu-Trace-ID: a83e131731f68f32
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 162/227] raw/ifpga: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:00 +0800
Message-ID: <20261103145306.487255-163-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/raw/ifpga/afu_pmd_core.c       | 14 +++++++-------
 drivers/raw/ifpga/base/ifpga_defines.h |  2 +-
 drivers/raw/ifpga/base/ifpga_fme.c     |  4 ++--
 drivers/raw/ifpga/base/ifpga_hw.h      |  2 +-
 drivers/raw/ifpga/ifpga_rawdev.c       | 10 +++++-----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/raw/ifpga/afu_pmd_core.c b/drivers/raw/ifpga/afu_pmd_core.c
index ca14ebf52f..62c2beefe6 100644
--- a/drivers/raw/ifpga/afu_pmd_core.c
+++ b/drivers/raw/ifpga/afu_pmd_core.c
@@ -214,7 +214,7 @@ static const struct rte_rawdev_ops afu_rawdev_ops = {
 };
 
 static int afu_shared_data_alloc(const char *name,
-	struct afu_shared_data **data, int socket_id)
+	struct afu_shared_data **data, int numa_id)
 {
 	const struct rte_memzone *mz;
 	char mz_name[RTE_MEMZONE_NAMESIZE];
@@ -230,7 +230,7 @@ static int afu_shared_data_alloc(const char *name,
 	mz = rte_memzone_lookup(mz_name);
 	if (!mz) {
 		mz = rte_memzone_reserve(mz_name, sizeof(struct afu_shared_data),
-				socket_id, 0);
+				numa_id, 0);
 		init_mz = 1;
 	}
 
@@ -283,7 +283,7 @@ static struct afu_ops *afu_ops_get(struct rte_afu_uuid *afu_id)
 	return drv ? drv->ops : NULL;
 }
 
-static int afu_rawdev_create(struct rte_afu_device *afu_dev, int socket_id)
+static int afu_rawdev_create(struct rte_afu_device *afu_dev, int numa_id)
 {
 	struct rte_rawdev *rawdev = NULL;
 	struct afu_rawdev *dev = NULL;
@@ -298,11 +298,11 @@ static int afu_rawdev_create(struct rte_afu_device *afu_dev, int socket_id)
 		return ret;
 
 	IFPGA_RAWDEV_PMD_INFO("Create raw device %s on NUMA node %d",
-		name, socket_id);
+		name, numa_id);
 
 	/* Allocate device structure */
 	rawdev = rte_rawdev_pmd_allocate(name, sizeof(struct afu_rawdev),
-				socket_id);
+				numa_id);
 	if (!rawdev) {
 		IFPGA_RAWDEV_PMD_ERR("Unable to allocate raw device");
 		return -ENOMEM;
@@ -333,7 +333,7 @@ static int afu_rawdev_create(struct rte_afu_device *afu_dev, int socket_id)
 		}
 	}
 
-	ret = afu_shared_data_alloc(name, &dev->sd, socket_id);
+	ret = afu_shared_data_alloc(name, &dev->sd, numa_id);
 	if (ret)
 		goto cleanup;
 
@@ -376,7 +376,7 @@ static int afu_rawdev_destroy(struct rte_afu_device *afu_dev)
 static int afu_rawdev_probe(struct rte_afu_device *afu_dev)
 {
 	IFPGA_RAWDEV_PMD_FUNC_TRACE();
-	return afu_rawdev_create(afu_dev, rte_socket_id());
+	return afu_rawdev_create(afu_dev, rte_numa_id());
 }
 
 static int afu_rawdev_remove(struct rte_afu_device *afu_dev)
diff --git a/drivers/raw/ifpga/base/ifpga_defines.h b/drivers/raw/ifpga/base/ifpga_defines.h
index 7c8fa89aeb..5d7da761de 100644
--- a/drivers/raw/ifpga/base/ifpga_defines.h
+++ b/drivers/raw/ifpga/base/ifpga_defines.h
@@ -151,7 +151,7 @@ struct feature_fme_capability {
 		u64 csr;
 		struct {
 			u8  fabric_verid;	/* Fabric version ID */
-			u8  socket_id:1;	/* Socket id */
+			u8  numa_id:1;	/* Socket id */
 			u8  rsvd1:3;		/* Reserved */
 			/* pci0 link available yes /no */
 			u8  pci0_link_avile:1;
diff --git a/drivers/raw/ifpga/base/ifpga_fme.c b/drivers/raw/ifpga/base/ifpga_fme.c
index b6dd4ce58c..587d47661b 100644
--- a/drivers/raw/ifpga/base/ifpga_fme.c
+++ b/drivers/raw/ifpga/base/ifpga_fme.c
@@ -143,14 +143,14 @@ static int fme_hdr_get_version(struct ifpga_fme_hw *fme, u64 *version)
 	return 0;
 }
 
-static int fme_hdr_get_socket_id(struct ifpga_fme_hw *fme, u64 *socket_id)
+static int fme_hdr_get_socket_id(struct ifpga_fme_hw *fme, u64 *numa_id)
 {
 	struct feature_fme_header *fme_hdr
 		= get_fme_feature_ioaddr_by_index(fme, FME_FEATURE_ID_HEADER);
 	struct feature_fme_capability fme_capability;
 
 	fme_capability.csr = readq(&fme_hdr->capability);
-	*socket_id = fme_capability.socket_id;
+	*numa_id = fme_capability.numa_id;
 
 	return 0;
 }
diff --git a/drivers/raw/ifpga/base/ifpga_hw.h b/drivers/raw/ifpga/base/ifpga_hw.h
index 4d56deb1b9..06f4e7331b 100644
--- a/drivers/raw/ifpga/base/ifpga_hw.h
+++ b/drivers/raw/ifpga/base/ifpga_hw.h
@@ -78,7 +78,7 @@ struct ifpga_fme_hw {
 	struct uuid bitstream_id;
 	u64 bitstream_md;
 	size_t pr_bandwidth;
-	u32 socket_id;
+	u32 numa_id;
 	u32 fabric_version_id;
 	u32 cache_size;
 
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index d44141824f..ae10e8afdb 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1531,7 +1531,7 @@ ifpga_register_msix_irq(struct ifpga_rawdev *dev, int port_id,
 
 static int
 ifpga_rawdev_create(struct rte_pci_device *pci_dev,
-			int socket_id)
+			int numa_id)
 {
 	int ret = 0;
 	struct rte_rawdev *rawdev = NULL;
@@ -1552,11 +1552,11 @@ ifpga_rawdev_create(struct rte_pci_device *pci_dev,
 	snprintf(name, RTE_RAWDEV_NAME_MAX_LEN, IFPGA_RAWDEV_NAME_FMT,
 		pci_dev->addr.bus, pci_dev->addr.devid, pci_dev->addr.function);
 
-	IFPGA_RAWDEV_PMD_INFO("Init %s on NUMA node %d", name, rte_socket_id());
+	IFPGA_RAWDEV_PMD_INFO("Init %s on NUMA node %d", name, rte_numa_id());
 
 	/* Allocate device structure */
 	rawdev = rte_rawdev_pmd_allocate(name, sizeof(struct opae_adapter),
-					 socket_id);
+					 numa_id);
 	if (rawdev == NULL) {
 		IFPGA_RAWDEV_PMD_ERR("Unable to allocate rawdevice");
 		ret = -EINVAL;
@@ -1651,7 +1651,7 @@ ifpga_rawdev_destroy(struct rte_pci_device *pci_dev)
 		pci_dev->addr.bus, pci_dev->addr.devid, pci_dev->addr.function);
 
 	IFPGA_RAWDEV_PMD_INFO("Closing %s on NUMA node %d",
-		name, rte_socket_id());
+		name, rte_numa_id());
 
 	rawdev = rte_rawdev_pmd_get_named_dev(name);
 	if (!rawdev) {
@@ -1672,7 +1672,7 @@ ifpga_rawdev_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	struct rte_pci_device *pci_dev)
 {
 	IFPGA_RAWDEV_PMD_FUNC_TRACE();
-	return ifpga_rawdev_create(pci_dev, rte_socket_id());
+	return ifpga_rawdev_create(pci_dev, rte_numa_id());
 }
 
 static int
-- 
2.55.0

