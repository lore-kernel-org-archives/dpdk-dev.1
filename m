Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD9606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cnN5odx2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F60441157;
	Tue,  3 Nov 2026 15:54:14 +0100 (CET)
Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
 by mails.dpdk.org (Postfix) with ESMTPS id 545DA4111B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:13 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=PayNnsJQKgu/aqpvWqUDVsqP5DbkoWDSvnQTgEoFlaY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717652; v=1; x=1794322452;
 b=cnN5odx2KqnKIBrY5BOV23i/tKcvccH4vXgZLng7TjiuosNtoiQb3qHMpWtaQy4m1kezy/Os
 WV4/4oEJRI/T4Z6yL7TUi3f651xsi2RvKysh5Q4e9QmSo3RwXiFmkMOX6S5rKFkguI8zJ/ysnLR
 yWRibw0zh+FX6a+90Od3AOp4=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 3558cb458b1f8363;
 Tue, 03 Nov 2026 14:54:12 +0000
X-Mizu-Trace-ID: 3558cb458b1f8363
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 007/227] cryptodev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:25 +0800
Message-ID: <20261103145306.487255-8-chengwen.feng@linux.dev>
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

Rename the exported function rte_cryptodev_socket_id() to
rte_cryptodev_numa_id(), keeping the old name as a functional
alias to be deprecated once the in-tree migration completes.

Rename the numa_id field of rte_cryptodev_config (was socket_id),
keeping socket_id as a deprecated union alias, and update in-tree
users accordingly.

Also rename internal parameters, the device data field, trace
points and comments to the NUMA node terminology. The legacy
devarg key value is kept unchanged for CLI compatibility.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_cryptodev.c                     |  4 +-
 app/test/test_cryptodev_asym.c                |  4 +-
 app/test/test_cryptodev_crosscheck.c          |  2 +-
 drivers/crypto/bcmfs/bcmfs_sym_pmd.c          |  2 +-
 drivers/crypto/ccp/rte_ccp_pmd.c              |  2 +-
 drivers/crypto/cnxk/cn10k_cryptodev.c         |  2 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c         |  2 +-
 drivers/crypto/cnxk/cn9k_cryptodev.c          |  2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  2 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |  2 +-
 drivers/crypto/ipsec_mb/ipsec_mb_private.c    |  2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |  2 +-
 drivers/crypto/mlx5/mlx5_crypto_xts.c         |  2 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c           |  4 +-
 drivers/crypto/nitrox/nitrox_sym.c            |  2 +-
 drivers/crypto/scheduler/scheduler_pmd.c      |  2 +-
 drivers/crypto/virtio/virtio_cryptodev.c      |  2 +-
 drivers/crypto/virtio/virtio_user_cryptodev.c |  2 +-
 drivers/crypto/zsda/zsda_crypto_pmd.c         |  2 +-
 lib/cryptodev/cryptodev_pmd.c                 | 14 ++---
 lib/cryptodev/cryptodev_pmd.h                 | 24 +++----
 lib/cryptodev/cryptodev_trace.h               | 18 +++---
 lib/cryptodev/cryptodev_trace_points.c        |  4 +-
 lib/cryptodev/rte_crypto.h                    |  4 +-
 lib/cryptodev/rte_cryptodev.c                 | 63 ++++++++++---------
 lib/cryptodev/rte_cryptodev.h                 | 55 +++++++++++-----
 26 files changed, 128 insertions(+), 98 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..aa689b297a 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -716,7 +716,7 @@ testsuite_setup(void)
 	rte_cryptodev_info_get(dev_id, &info);
 
 	ts_params->conf.nb_queue_pairs = info.max_nb_queue_pairs;
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = SOCKET_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 
 	unsigned int session_size =
@@ -1512,7 +1512,7 @@ dev_configure_and_start(uint64_t ff_disable)
 	memset(ut_params, 0, sizeof(*ut_params));
 
 	/* Reconfigure device to default parameters */
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = SOCKET_ID_ANY;
 	ts_params->conf.ff_disable = ff_disable;
 	ts_params->qp_conf.nb_descriptors = MAX_NUM_OPS_INFLIGHT;
 	ts_params->qp_conf.mp_session = ts_params->session_mpool;
diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index d9807f34e0..d68fe84cde 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -1185,7 +1185,7 @@ testsuite_setup(void)
 
 	/* configure device with num qp */
 	ts_params->conf.nb_queue_pairs = info.max_nb_queue_pairs;
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY |
 			RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO;
 	TEST_ASSERT_SUCCESS(rte_cryptodev_configure(dev_id,
@@ -1251,7 +1251,7 @@ ut_setup_asym(void)
 	);
 
 	/* Reconfigure device to default parameters */
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_configure(ts_params->valid_devs[0],
 			&ts_params->conf),
diff --git a/app/test/test_cryptodev_crosscheck.c b/app/test/test_cryptodev_crosscheck.c
index bb21c3bc50..d0ff3e0b35 100644
--- a/app/test/test_cryptodev_crosscheck.c
+++ b/app/test/test_cryptodev_crosscheck.c
@@ -425,7 +425,7 @@ crosscheck_init(void)
 
 	/* Setup queue pair conf params */
 	ts_params->conf.nb_queue_pairs = nb_queue_pairs;
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = SOCKET_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 	ts_params->qp_conf.nb_descriptors = MAX_NUM_OPS_INFLIGHT;
 	ts_params->qp_conf.mp_session = ts_params->session_mpool;
diff --git a/drivers/crypto/bcmfs/bcmfs_sym_pmd.c b/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
index d3b1e25d57..3f2ff40cd8 100644
--- a/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
+++ b/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
@@ -355,7 +355,7 @@ bcmfs_sym_dev_create(struct bcmfs_device *fsdev)
 {
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.private_data_size = sizeof(struct bcmfs_sym_dev_private)
 	};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/crypto/ccp/rte_ccp_pmd.c b/drivers/crypto/ccp/rte_ccp_pmd.c
index 700e141667..ab19f8fd9c 100644
--- a/drivers/crypto/ccp/rte_ccp_pmd.c
+++ b/drivers/crypto/ccp/rte_ccp_pmd.c
@@ -288,7 +288,7 @@ cryptodev_ccp_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	init_params.def_p.max_nb_queue_pairs = CCP_PMD_MAX_QUEUE_PAIRS;
 
 	CCP_LOG_INFO("Initialising %s on NUMA node %d", name,
-		init_params.def_p.socket_id);
+		init_params.def_p.numa_id);
 	CCP_LOG_INFO("Max number of queue pairs = %d",
 		init_params.def_p.max_nb_queue_pairs);
 	CCP_LOG_INFO("Authentication offload to %s",
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev.c b/drivers/crypto/cnxk/cn10k_cryptodev.c
index 598def51a5..1c1478ad80 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev.c
@@ -34,7 +34,7 @@ cn10k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 {
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.private_data_size = sizeof(struct cnxk_cpt_vf)
 	};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index 7b8293cc05..36f2a615dd 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -31,7 +31,7 @@ static int
 cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_device *pci_dev)
 {
 	struct rte_cryptodev_pmd_init_params init_params = {.name = "",
-							    .socket_id = rte_socket_id(),
+							    .numa_id = rte_numa_id(),
 							    .private_data_size =
 								    sizeof(struct cnxk_cpt_vf)};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev.c b/drivers/crypto/cnxk/cn9k_cryptodev.c
index 818458bd6f..bb5c837b0a 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev.c
@@ -39,7 +39,7 @@ cn9k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 {
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.private_data_size = sizeof(struct cnxk_cpt_vf)
 	};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index d83698f1ad..7bcb472838 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4551,7 +4551,7 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
 		.private_data_size = sizeof(struct dpaa2_sec_dev_private),
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.max_nb_queue_pairs =
 			RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS,
 			/* setting default, will be updated in init. */
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index f03efb316d..65b3573a1a 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3777,7 +3777,7 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
 		.private_data_size = sizeof(struct dpaa_sec_dev_private),
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.max_nb_queue_pairs =
 			RTE_DPAA_MAX_NB_SEC_QPS,
 	};
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.c b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
index 468d77fead..23ec99004b 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
@@ -101,7 +101,7 @@ ipsec_mb_create(struct rte_vdev_device *vdev,
 		pmd_data->internals_priv_size;
 	init_params.max_nb_queue_pairs =
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS;
-	init_params.socket_id = rte_socket_id();
+	init_params.numa_id = rte_socket_id();
 
 	name = rte_vdev_device_name(vdev);
 	if (name == NULL)
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 1a2600655a..d0f01dab4a 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -342,7 +342,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	qp->priv = priv;
 	qp->entries_n = entries;
 	if (mlx5_mr_ctrl_init(&qp->mr_ctrl, &priv->cdev->mr_scache.dev_gen,
-				  priv->dev_config.socket_id)) {
+				  priv->dev_config.numa_id)) {
 		DRV_LOG(ERR, "Cannot allocate MR Btree for qp %u.",
 			(uint32_t)qp_id);
 		rte_errno = ENOMEM;
diff --git a/drivers/crypto/mlx5/mlx5_crypto_xts.c b/drivers/crypto/mlx5/mlx5_crypto_xts.c
index 1c914caa85..badde267a7 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_xts.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_xts.c
@@ -515,7 +515,7 @@ mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto error;
 	}
 	if (mlx5_mr_ctrl_init(&qp->mr_ctrl, &priv->cdev->mr_scache.dev_gen,
-			      priv->dev_config.socket_id) != 0) {
+			      priv->dev_config.numa_id) != 0) {
 		DRV_LOG(ERR, "Cannot allocate MR Btree for qp %u.",
 			(uint32_t)qp_id);
 		rte_errno = ENOMEM;
diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index 65a63c9d62..c69f526c52 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1178,7 +1178,7 @@ mrvl_pmd_parse_input_args(struct mrvl_pmd_init_params *params,
 		ret = rte_kvargs_process(kvlist,
 					 RTE_CRYPTODEV_PMD_SOCKET_ID_ARG,
 					 &parse_integer_arg,
-					 &params->common.socket_id);
+					 &params->common.numa_id);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1219,7 +1219,7 @@ cryptodev_mrvl_crypto_init(struct rte_vdev_device *vdev)
 				sizeof(struct mrvl_crypto_private),
 			.max_nb_queue_pairs =
 				sam_get_num_inst() * sam_get_num_cios(0),
-			.socket_id = rte_socket_id()
+			.numa_id = rte_numa_id()
 		},
 		.max_nb_sessions = MRVL_PMD_DEFAULT_MAX_NB_SESSIONS
 	};
diff --git a/drivers/crypto/nitrox/nitrox_sym.c b/drivers/crypto/nitrox/nitrox_sym.c
index 7c2dc98a4b..510d6059b1 100644
--- a/drivers/crypto/nitrox/nitrox_sym.c
+++ b/drivers/crypto/nitrox/nitrox_sym.c
@@ -749,7 +749,7 @@ nitrox_sym_pmd_create(struct nitrox_device *ndev)
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	struct rte_cryptodev_pmd_init_params init_params = {
 			.name = "",
-			.socket_id = ndev->pdev->device.numa_node,
+			.numa_id = ndev->pdev->device.numa_node,
 			.private_data_size = sizeof(struct nitrox_sym_device)
 	};
 	struct rte_cryptodev *cdev;
diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/scheduler/scheduler_pmd.c
index ceaefa329b..8ca09ba3d0 100644
--- a/drivers/crypto/scheduler/scheduler_pmd.c
+++ b/drivers/crypto/scheduler/scheduler_pmd.c
@@ -533,7 +533,7 @@ scheduler_parse_init_params(struct scheduler_init_params *params,
 
 		ret = rte_kvargs_process(kvlist, RTE_CRYPTODEV_VDEV_SOCKET_ID,
 				&parse_integer_arg,
-				&params->def_p.socket_id);
+				&params->def_p.numa_id);
 		if (ret < 0)
 			goto free_kvlist;
 
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index d70651646e..d0fe21947c 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -1691,7 +1691,7 @@ crypto_virtio_pci_probe(
 {
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = pci_dev->device.numa_node,
+		.numa_id = pci_dev->device.numa_node,
 		.private_data_size = sizeof(struct virtio_crypto_hw)
 	};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/crypto/virtio/virtio_user_cryptodev.c b/drivers/crypto/virtio/virtio_user_cryptodev.c
index 4daa188e1d..4cddb964e2 100644
--- a/drivers/crypto/virtio/virtio_user_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_user_cryptodev.c
@@ -374,7 +374,7 @@ virtio_user_cryptodev_alloc(struct rte_vdev_device *vdev)
 	struct virtio_user_dev *dev;
 	struct virtio_crypto_hw *hw;
 
-	init_params.socket_id = vdev->device.numa_node;
+	init_params.numa_id = vdev->device.numa_node;
 	init_params.private_data_size = sizeof(struct virtio_user_dev);
 	cryptodev = rte_cryptodev_pmd_create(vdev->device.name, &vdev->device, &init_params);
 	if (cryptodev == NULL) {
diff --git a/drivers/crypto/zsda/zsda_crypto_pmd.c b/drivers/crypto/zsda/zsda_crypto_pmd.c
index 181e19f9f2..d1cdfcce0b 100644
--- a/drivers/crypto/zsda/zsda_crypto_pmd.c
+++ b/drivers/crypto/zsda/zsda_crypto_pmd.c
@@ -260,7 +260,7 @@ zsda_crypto_dev_create(struct zsda_pci_device *zsda_pci_dev)
 
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = (int)rte_socket_id(),
+		.numa_id = (int)rte_numa_id(),
 		.private_data_size = sizeof(struct zsda_crypto_dev_private)
 	};
 
diff --git a/lib/cryptodev/cryptodev_pmd.c b/lib/cryptodev/cryptodev_pmd.c
index d79d561bf6..d82128ce26 100644
--- a/lib/cryptodev/cryptodev_pmd.c
+++ b/lib/cryptodev/cryptodev_pmd.c
@@ -81,9 +81,9 @@ rte_cryptodev_pmd_parse_input_args(
 			goto free_kvlist;
 
 		ret = rte_kvargs_process(kvlist,
-				RTE_CRYPTODEV_PMD_SOCKET_ID_ARG,
+				RTE_CRYPTODEV_PMD_NUMA_ID_ARG,
 				&rte_cryptodev_pmd_parse_uint_arg,
-				&params->socket_id);
+				&params->numa_id);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -116,11 +116,11 @@ rte_cryptodev_pmd_create(const char *name,
 	CDEV_LOG_INFO("Creating cryptodev %s", name);
 
 	CDEV_LOG_INFO("Initialisation parameters - name: %s,"
-			"socket id: %d, max queue pairs: %u",
-			name, params->socket_id, params->max_nb_queue_pairs);
+			"NUMA node id: %d, max queue pairs: %u",
+			name, params->numa_id, params->max_nb_queue_pairs);
 
 	/* allocate device structure */
-	cryptodev = rte_cryptodev_pmd_allocate(name, params->socket_id);
+	cryptodev = rte_cryptodev_pmd_allocate(name, params->numa_id);
 	if (cryptodev == NULL) {
 		CDEV_LOG_ERR("Failed to allocate crypto device for %s", name);
 		return NULL;
@@ -129,10 +129,10 @@ rte_cryptodev_pmd_create(const char *name,
 	/* allocate private device structure */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		cryptodev->data->dev_private =
-				rte_zmalloc_socket("cryptodev device private",
+				rte_zmalloc_numa("cryptodev device private",
 						params->private_data_size,
 						RTE_CACHE_LINE_SIZE,
-						params->socket_id);
+						params->numa_id);
 
 		if (cryptodev->data->dev_private == NULL) {
 			CDEV_LOG_ERR("Cannot allocate memory for cryptodev %s"
diff --git a/lib/cryptodev/cryptodev_pmd.h b/lib/cryptodev/cryptodev_pmd.h
index 929c6defe9..1677fbf3c2 100644
--- a/lib/cryptodev/cryptodev_pmd.h
+++ b/lib/cryptodev/cryptodev_pmd.h
@@ -33,13 +33,13 @@ extern "C" {
 
 #define RTE_CRYPTODEV_PMD_NAME_ARG			("name")
 #define RTE_CRYPTODEV_PMD_MAX_NB_QP_ARG			("max_nb_queue_pairs")
-#define RTE_CRYPTODEV_PMD_SOCKET_ID_ARG			("socket_id")
+#define RTE_CRYPTODEV_PMD_NUMA_ID_ARG			("numa_id")
 
 
 static const char * const cryptodev_pmd_valid_params[] = {
 	RTE_CRYPTODEV_PMD_NAME_ARG,
 	RTE_CRYPTODEV_PMD_MAX_NB_QP_ARG,
-	RTE_CRYPTODEV_PMD_SOCKET_ID_ARG,
+	RTE_CRYPTODEV_PMD_NUMA_ID_ARG,
 	NULL
 };
 
@@ -50,7 +50,7 @@ static const char * const cryptodev_pmd_valid_params[] = {
 struct rte_cryptodev_pmd_init_params {
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	size_t private_data_size;
-	int socket_id;
+	int numa_id;
 	unsigned int max_nb_queue_pairs;
 };
 
@@ -65,7 +65,7 @@ struct __rte_cache_aligned rte_cryptodev_data {
 	/** Device ID for this instance */
 	uint8_t dev_id;
 	/** Socket ID where memory is allocated */
-	int socket_id;
+	int numa_id;
 	/** Unique identifier name */
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
 
@@ -269,13 +269,13 @@ typedef void (*cryptodev_info_get_t)(struct rte_cryptodev *dev,
  * @param	dev		Crypto device pointer
  * @param	qp_id		Queue Pair Index
  * @param	qp_conf		Queue configuration structure
- * @param	socket_id	Socket Index
+ * @param	numa_id	Socket Index
  *
  * @return	Returns 0 on success.
  */
 typedef int (*cryptodev_queue_pair_setup_t)(struct rte_cryptodev *dev,
 		uint16_t qp_id,	const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id);
+		int numa_id);
 
 /**
  * Release memory resources allocated by given queue pair.
@@ -296,7 +296,7 @@ typedef int (*cryptodev_queue_pair_release_t)(struct rte_cryptodev *dev,
  * @param	dev		Crypto device pointer
  * @param	qp_id		Queue pair index
  * @param	qp_conf		Queue configuration structure
- * @param	socket_id	Socket index
+ * @param	numa_id	Socket index
  *
  * @return
  *  - 0: on success.
@@ -304,7 +304,7 @@ typedef int (*cryptodev_queue_pair_release_t)(struct rte_cryptodev *dev,
  */
 typedef int (*cryptodev_queue_pair_reset_t)(struct rte_cryptodev *dev,
 		uint16_t qp_id,	const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id);
+		int numa_id);
 
 /**
  * Create a session mempool to allocate sessions from
@@ -312,7 +312,7 @@ typedef int (*cryptodev_queue_pair_reset_t)(struct rte_cryptodev *dev,
  * @param	dev		Crypto device pointer
  * @param	nb_objs		number of sessions objects in mempool
  * @param	obj_cache_size	l-core object cache size, see *rte_ring_create*
- * @param	socket_id	Socket Id to allocate  mempool on.
+ * @param	numa_id	Socket Id to allocate  mempool on.
  *
  * @return
  * - On success returns a pointer to a rte_mempool
@@ -320,7 +320,7 @@ typedef int (*cryptodev_queue_pair_reset_t)(struct rte_cryptodev *dev,
  */
 typedef int (*cryptodev_sym_create_session_pool_t)(
 		struct rte_cryptodev *dev, unsigned nb_objs,
-		unsigned obj_cache_size, int socket_id);
+		unsigned int obj_cache_size, int numa_id);
 
 
 /**
@@ -534,13 +534,13 @@ struct rte_cryptodev_ops {
  * to that slot for the driver to use.
  *
  * @param	name		Unique identifier name for each device
- * @param	socket_id	Socket to allocate resources on.
+ * @param	numa_id	Socket to allocate resources on.
  * @return
  *   - Slot in the rte_dev_devices array for a new device;
  */
 __rte_internal
 struct rte_cryptodev *
-rte_cryptodev_pmd_allocate(const char *name, int socket_id);
+rte_cryptodev_pmd_allocate(const char *name, int numa_id);
 
 /**
  * Function for internal use by dummy drivers primarily, e.g. ring-based
diff --git a/lib/cryptodev/cryptodev_trace.h b/lib/cryptodev/cryptodev_trace.h
index 788790432a..0a16c5a824 100644
--- a/lib/cryptodev/cryptodev_trace.h
+++ b/lib/cryptodev/cryptodev_trace.h
@@ -61,11 +61,11 @@ RTE_TRACE_POINT(
 RTE_TRACE_POINT(
 	rte_cryptodev_trace_queue_pair_reset,
 	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t queue_pair_id,
-		const struct rte_cryptodev_qp_conf *conf, int socket_id),
+		const struct rte_cryptodev_qp_conf *conf, int numa_id),
 	rte_trace_point_emit_u8(dev_id);
 	rte_trace_point_emit_u16(queue_pair_id);
 	rte_trace_point_emit_u32(conf->nb_descriptors);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 )
 
 RTE_TRACE_POINT(
@@ -267,20 +267,20 @@ RTE_TRACE_POINT(
 RTE_TRACE_POINT(
 	rte_cryptodev_trace_queue_pair_count,
 	RTE_TRACE_POINT_ARGS(const void *dev, const char *name,
-		uint8_t socket_id, uint8_t dev_id, uint16_t nb_queue_pairs),
+		uint8_t numa_id, uint8_t dev_id, uint16_t nb_queue_pairs),
 	rte_trace_point_emit_ptr(dev);
 	rte_trace_point_emit_string(name);
-	rte_trace_point_emit_u8(socket_id);
+	rte_trace_point_emit_u8(numa_id);
 	rte_trace_point_emit_u8(dev_id);
 	rte_trace_point_emit_u16(nb_queue_pairs);
 )
 
 RTE_TRACE_POINT(
-	rte_cryptodev_trace_socket_id,
-	RTE_TRACE_POINT_ARGS(uint8_t dev_id, const char *name, int socket_id),
+	rte_cryptodev_trace_numa_id,
+	RTE_TRACE_POINT_ARGS(uint8_t dev_id, const char *name, int numa_id),
 	rte_trace_point_emit_u8(dev_id);
 	rte_trace_point_emit_string(name);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 )
 
 RTE_TRACE_POINT(
@@ -512,10 +512,10 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT(
 	rte_cryptodev_trace_op_pool_create,
-	RTE_TRACE_POINT_ARGS(const char *name, int socket_id, int type,
+	RTE_TRACE_POINT_ARGS(const char *name, int numa_id, int type,
 		uint32_t nb_elts, const void *mp),
 	rte_trace_point_emit_string(name);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_int(type);
 	rte_trace_point_emit_u32(nb_elts);
 	rte_trace_point_emit_ptr(mp);
diff --git a/lib/cryptodev/cryptodev_trace_points.c b/lib/cryptodev/cryptodev_trace_points.c
index 69737adcbe..cecd203634 100644
--- a/lib/cryptodev/cryptodev_trace_points.c
+++ b/lib/cryptodev/cryptodev_trace_points.c
@@ -108,8 +108,8 @@ RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_name_get,
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_queue_pair_count,
 	lib.cryptodev.queue.pair.count)
 
-RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_socket_id,
-	lib.cryptodev.socket.id)
+RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_numa_id,
+	lib.cryptodev.numa_id)
 
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_stats_get,
 	lib.cryptodev.stats.get)
diff --git a/lib/cryptodev/rte_crypto.h b/lib/cryptodev/rte_crypto.h
index dcf4a36fb2..fced5d99cf 100644
--- a/lib/cryptodev/rte_crypto.h
+++ b/lib/cryptodev/rte_crypto.h
@@ -254,7 +254,7 @@ __rte_crypto_op_get_priv_data_size(struct rte_mempool *mempool)
  *				cache size
  * @param	priv_size	Size of private data to allocate with each
  *				operation
- * @param	socket_id	Socket to allocate memory on
+ * @param	numa_id	Socket to allocate memory on
  *
  * @return
  *  - On success pointer to mempool
@@ -263,7 +263,7 @@ __rte_crypto_op_get_priv_data_size(struct rte_mempool *mempool)
 struct rte_mempool *
 rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 		unsigned nb_elts, unsigned cache_size, uint16_t priv_size,
-		int socket_id);
+		int numa_id);
 
 /**
  * Bulk allocate raw element from mempool and return as crypto operations
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 829a5d0846..2362d72dec 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -1088,9 +1088,9 @@ rte_cryptodev_get_sec_ctx(uint8_t dev_id)
 	return sec_ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_socket_id)
+RTE_EXPORT_SYMBOL(rte_cryptodev_numa_id)
 int
-rte_cryptodev_socket_id(uint8_t dev_id)
+rte_cryptodev_numa_id(uint8_t dev_id)
 {
 	struct rte_cryptodev *dev;
 
@@ -1099,14 +1099,21 @@ rte_cryptodev_socket_id(uint8_t dev_id)
 
 	dev = rte_cryptodev_pmd_get_dev(dev_id);
 
-	rte_cryptodev_trace_socket_id(dev_id, dev->data->name,
-		dev->data->socket_id);
-	return dev->data->socket_id;
+	rte_cryptodev_trace_numa_id(dev_id, dev->data->name,
+		dev->data->numa_id);
+	return dev->data->numa_id;
+}
+
+RTE_EXPORT_SYMBOL(rte_cryptodev_socket_id)
+int
+rte_cryptodev_socket_id(uint8_t dev_id)
+{
+	return rte_cryptodev_numa_id(dev_id);
 }
 
 static inline int
 rte_cryptodev_data_alloc(uint8_t dev_id, struct rte_cryptodev_data **data,
-		int socket_id)
+		int numa_id)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -1120,7 +1127,7 @@ rte_cryptodev_data_alloc(uint8_t dev_id, struct rte_cryptodev_data **data,
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(mz_name,
 				sizeof(struct rte_cryptodev_data),
-				socket_id, 0);
+				numa_id, 0);
 		CDEV_LOG_DEBUG("PRIMARY:reserved memzone for %s (%p)",
 				mz_name, mz);
 	} else {
@@ -1206,7 +1213,7 @@ rte_cryptodev_find_device_by_name(const char *name)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
 struct rte_cryptodev *
-rte_cryptodev_pmd_allocate(const char *name, int socket_id)
+rte_cryptodev_pmd_allocate(const char *name, int numa_id)
 {
 	struct rte_cryptodev *cryptodev;
 	uint8_t dev_id;
@@ -1238,7 +1245,7 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 				&cryptodev_globals.data[dev_id];
 
 		int retval = rte_cryptodev_data_alloc(dev_id, cryptodev_data,
-				socket_id);
+				numa_id);
 
 		if (retval < 0 || *cryptodev_data == NULL)
 			return NULL;
@@ -1250,7 +1257,7 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 				RTE_CRYPTODEV_NAME_MAX_LEN);
 
 			cryptodev->data->dev_id = dev_id;
-			cryptodev->data->socket_id = socket_id;
+			cryptodev->data->numa_id = numa_id;
 			cryptodev->data->dev_started = 0;
 			CDEV_LOG_DEBUG("PRIMARY:init data");
 		}
@@ -1258,7 +1265,7 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 		CDEV_LOG_DEBUG("Data for %s: dev_id %d, socket %d, started %d",
 				cryptodev->data->name,
 				cryptodev->data->dev_id,
-				cryptodev->data->socket_id,
+				cryptodev->data->numa_id,
 				cryptodev->data->dev_started);
 
 		/* init user callbacks */
@@ -1315,7 +1322,7 @@ rte_cryptodev_queue_pair_count(uint8_t dev_id)
 
 	dev = &rte_crypto_devices[dev_id];
 	rte_cryptodev_trace_queue_pair_count(dev, dev->data->name,
-		dev->data->socket_id, dev->data->dev_id,
+		dev->data->numa_id, dev->data->dev_id,
 		dev->data->nb_queue_pairs);
 
 	return dev->data->nb_queue_pairs;
@@ -1323,7 +1330,7 @@ rte_cryptodev_queue_pair_count(uint8_t dev_id)
 
 static int
 rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
-		int socket_id)
+		int numa_id)
 {
 	struct rte_cryptodev_info dev_info;
 	void **qp;
@@ -1351,11 +1358,11 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 	}
 
 	if (dev->data->queue_pairs == NULL) { /* first time configuration */
-		dev->data->queue_pairs = rte_zmalloc_socket(
+		dev->data->queue_pairs = rte_zmalloc_numa(
 				"cryptodev->queue_pairs",
 				sizeof(dev->data->queue_pairs[0]) *
 				dev_info.max_nb_queue_pairs,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 
 		if (dev->data->queue_pairs == NULL) {
 			dev->data->nb_queue_pairs = 0;
@@ -1388,7 +1395,7 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_reset, 24.11)
 int
 rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
-		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
+		const struct rte_cryptodev_qp_conf *qp_conf, int numa_id)
 {
 	struct rte_cryptodev *dev;
 
@@ -1406,8 +1413,8 @@ rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 	if (dev->dev_ops->queue_pair_reset == NULL)
 		return -ENOTSUP;
 
-	rte_cryptodev_trace_queue_pair_reset(dev_id, queue_pair_id, qp_conf, socket_id);
-	return dev->dev_ops->queue_pair_reset(dev, queue_pair_id, qp_conf, socket_id);
+	rte_cryptodev_trace_queue_pair_reset(dev_id, queue_pair_id, qp_conf, numa_id);
+	return dev->dev_ops->queue_pair_reset(dev, queue_pair_id, qp_conf, numa_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_cryptodev_configure)
@@ -1439,7 +1446,7 @@ rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 
 	/* Setup new number of queue pairs and reconfigure device. */
 	diag = rte_cryptodev_queue_pairs_config(dev, config->nb_queue_pairs,
-			config->socket_id);
+			config->numa_id);
 	if (diag != 0) {
 		CDEV_LOG_ERR("dev%d rte_crypto_dev_queue_pairs_config = %d",
 				dev_id, diag);
@@ -1627,7 +1634,7 @@ rte_cryptodev_sym_is_valid_session_pool(struct rte_mempool *mp,
 RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_setup)
 int
 rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
-		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
+		const struct rte_cryptodev_qp_conf *qp_conf, int numa_id)
 
 {
 	struct rte_cryptodev *dev;
@@ -1675,7 +1682,7 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		return -ENOTSUP;
 
 	rte_cryptodev_trace_queue_pair_setup(dev_id, queue_pair_id, qp_conf);
-	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
+	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, qp_conf, numa_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_cryptodev_add_enq_callback)
@@ -2190,7 +2197,7 @@ RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_pool_create)
 struct rte_mempool *
 rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t elt_size, uint32_t cache_size, uint16_t user_data_size,
-	int socket_id)
+	int numa_id)
 {
 	struct rte_mempool *mp;
 	struct rte_cryptodev_sym_session_pool_private_data *pool_priv;
@@ -2202,7 +2209,7 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	mp = rte_mempool_create(name, nb_elts, obj_sz, cache_size,
 			(uint32_t)(sizeof(*pool_priv)), NULL, NULL,
 			NULL, NULL,
-			socket_id, 0);
+			numa_id, 0);
 	if (mp == NULL) {
 		CDEV_LOG_ERR("%s(name=%s) failed, rte_errno=%d",
 			__func__, name, rte_errno);
@@ -2228,7 +2235,7 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_pool_create)
 struct rte_mempool *
 rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
-	uint32_t cache_size, uint16_t user_data_size, int socket_id)
+	uint32_t cache_size, uint16_t user_data_size, int numa_id)
 {
 	struct rte_mempool *mp;
 	struct rte_cryptodev_asym_session_pool_private_data *pool_priv;
@@ -2254,7 +2261,7 @@ rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
 	mp = rte_mempool_create(name, nb_elts, obj_sz_aligned, cache_size,
 			(uint32_t)(sizeof(*pool_priv)),
 			NULL, NULL, NULL, NULL,
-			socket_id, 0);
+			numa_id, 0);
 	if (mp == NULL) {
 		CDEV_LOG_ERR("%s(name=%s) failed, rte_errno=%d",
 			__func__, name, rte_errno);
@@ -2820,7 +2827,7 @@ RTE_EXPORT_SYMBOL(rte_crypto_op_pool_create)
 struct rte_mempool *
 rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 		unsigned nb_elts, unsigned cache_size, uint16_t priv_size,
-		int socket_id)
+		int numa_id)
 {
 	struct rte_crypto_op_pool_private *priv;
 
@@ -2868,7 +2875,7 @@ rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 			NULL,
 			rte_crypto_op_init,
 			&type,
-			socket_id,
+			numa_id,
 			0);
 
 	if (mp == NULL) {
@@ -2882,7 +2889,7 @@ rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 	priv->priv_size = priv_size;
 	priv->type = type;
 
-	rte_cryptodev_trace_op_pool_create(name, socket_id, type, nb_elts, mp);
+	rte_cryptodev_trace_op_pool_create(name, numa_id, type, nb_elts, mp);
 	return mp;
 }
 
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index bdbd11ace5..a1afb7e927 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -833,8 +833,23 @@ uint8_t
 rte_cryptodev_devices_get(const char *driver_name, uint8_t *devices,
 		uint8_t nb_devices);
 /*
+ * Return the NUMA node to which a device is connected
+ *
+ * @param dev_id
+ *   The identifier of the device
+ * @return
+ *   The NUMA node ID to which the device is connected or
+ *   a default of zero if the NUMA node could not be determined.
+ *   -1 if returned is the dev_id value is out of range.
+ */
+int
+rte_cryptodev_numa_id(uint8_t dev_id);
+
+/**
  * Return the NUMA socket to which a device is connected
  *
+ * This is a legacy alias of rte_cryptodev_numa_id().
+ *
  * @param dev_id
  *   The identifier of the device
  * @return
@@ -848,7 +863,15 @@ rte_cryptodev_socket_id(uint8_t dev_id);
 /** Crypto device configuration structure */
 /* Structure rte_cryptodev_config 8< */
 struct rte_cryptodev_config {
-	int socket_id;			/**< Socket to allocate resources on */
+	union {
+		/** NUMA node to allocate resources on */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint16_t nb_queue_pairs;
 	/**< Number of queue pairs to configure on device */
 	uint64_t ff_disable;
@@ -928,9 +951,9 @@ rte_cryptodev_close(uint8_t dev_id);
  *				rte_cryptodev_configure().
  * @param	qp_conf		The pointer to the configuration data to be
  *				used for the queue pair.
- * @param	socket_id	The *socket_id* argument is the socket
- *				identifier in case of NUMA. The value can be
- *				*SOCKET_ID_ANY* if there is no NUMA constraint
+ * @param	numa_id	The *numa_id* argument is the NUMA node
+ *				ID in case of NUMA. The value can be
+ *				*RTE_NUMA_ID_ANY* if there is no NUMA constraint
  *				for the DMA memory allocated for the receive
  *				queue pair.
  *
@@ -940,7 +963,7 @@ rte_cryptodev_close(uint8_t dev_id);
  */
 int
 rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
-		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id);
+		const struct rte_cryptodev_qp_conf *qp_conf, int numa_id);
 
 /**
  * @warning
@@ -957,8 +980,8 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
  *				rte_cryptodev_configure().
  * @param	qp_conf		The pointer to configuration data to be used for the queue pair.
  *				It should be NULL, if the API is called from an interrupt context.
- * @param	socket_id	The *socket_id* argument is the socket identifier in case of NUMA.
- *				The value can be *SOCKET_ID_ANY* if there is no NUMA constraint
+ * @param	numa_id	The *numa_id* argument is the NUMA node ID in case of NUMA.
+ *				The value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint
  *				for the DMA memory allocated for the queue pair.
  *
  * @return
@@ -969,7 +992,7 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 __rte_experimental
 int
 rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
-		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id);
+		const struct rte_cryptodev_qp_conf *qp_conf, int numa_id);
 
 /**
  * Get the status of queue pairs setup on a specific crypto device
@@ -1153,9 +1176,9 @@ rte_cryptodev_get_sec_ctx(uint8_t dev_id);
  *   The number of per-lcore cache elements
  * @param priv_size
  *   The private data size of each session.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in the case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in the case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  *
  * @return
@@ -1165,7 +1188,7 @@ rte_cryptodev_get_sec_ctx(uint8_t dev_id);
 struct rte_mempool *
 rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t elt_size, uint32_t cache_size, uint16_t priv_size,
-	int socket_id);
+	int numa_id);
 
 
 /**
@@ -1179,9 +1202,9 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
  *   The number of per-lcore cache elements
  * @param user_data_size
  *   The size of user data to be placed after session private data.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in the case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in the case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  *
  * @return
@@ -1190,7 +1213,7 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
  */
 struct rte_mempool *
 rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
-	uint32_t cache_size, uint16_t user_data_size, int socket_id);
+	uint32_t cache_size, uint16_t user_data_size, int numa_id);
 
 /**
  * Create symmetric crypto session and fill out private data for the device id,
-- 
2.55.0

