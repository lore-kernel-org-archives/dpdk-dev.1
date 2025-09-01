Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9FACA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 10:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4C540658;
	Mon,  1 Sep 2025 12:46:36 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 49BDA402A2
 for <dev@dpdk.org>; Mon,  1 Sep 2025 12:46:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cFlnY3rgjz13NPv;
 Mon,  1 Sep 2025 18:42:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5743C1402DB;
 Mon,  1 Sep 2025 18:46:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 18:46:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v4 3/5] lib: add semicolon when export internal symbol
Date: Mon, 1 Sep 2025 18:46:26 +0800
Message-ID: <20250901104628.50622-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250901104628.50622-1-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250901104628.50622-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Currently, the RTE_EXPORT_INTERNAL_SYMBOL was placed at the beginning of
APIs, but doesn't end with a semicolon. As a result, some IDEs cannot
identify the APIs and cannot quickly jump to the definition.

A semicolon is added to the end of above RTE_EXPORT_INTERNAL_SYMBOL in
this commit.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/cryptodev/cryptodev_pmd.c          | 14 ++++----
 lib/cryptodev/rte_cryptodev.c          | 16 ++++-----
 lib/dmadev/rte_dmadev.c                |  8 ++---
 lib/eal/common/eal_common_bus.c        |  4 +--
 lib/eal/common/eal_common_config.c     |  2 +-
 lib/eal/common/eal_common_interrupts.c | 42 +++++++++++-----------
 lib/eal/common/eal_common_mcfg.c       | 10 +++---
 lib/eal/common/eal_common_options.c    |  2 +-
 lib/eal/common/eal_common_thread.c     |  4 +--
 lib/eal/freebsd/eal_interrupts.c       | 16 ++++-----
 lib/eal/linux/eal_interrupts.c         | 16 ++++-----
 lib/eal/unix/eal_firmware.c            |  2 +-
 lib/eal/unix/eal_unix_memory.c         |  8 ++---
 lib/eal/windows/eal.c                  |  2 +-
 lib/eal/windows/eal_interrupts.c       | 16 ++++-----
 lib/eal/windows/eal_memory.c           |  8 ++---
 lib/ethdev/ethdev_driver.c             | 48 +++++++++++++-------------
 lib/ethdev/ethdev_linux_ethtool.c      |  6 ++--
 lib/ethdev/rte_ethdev.c                |  2 +-
 lib/ethdev/rte_flow.c                  |  2 +-
 lib/eventdev/eventdev_private.c        |  4 +--
 lib/eventdev/rte_eventdev.c            | 12 +++----
 lib/gpudev/gpudev.c                    | 12 +++----
 lib/hash/rte_thash_gf2_poly_math.c     |  2 +-
 lib/hash/rte_thash_gfni.c              |  4 +--
 lib/log/log.c                          | 10 +++---
 lib/log/log_color.c                    |  2 +-
 lib/log/log_syslog.c                   |  2 +-
 lib/log/log_timestamp.c                |  2 +-
 lib/mempool/rte_mempool.c              |  4 +--
 lib/mldev/mldev_utils.c                |  4 +--
 lib/mldev/rte_mldev.c                  |  8 ++---
 lib/mldev/rte_mldev_pmd.c              |  4 +--
 lib/pmu/pmu.c                          |  2 +-
 lib/power/power_common.c               | 16 ++++-----
 lib/power/rte_power_cpufreq.c          |  2 +-
 lib/power/rte_power_uncore.c           |  2 +-
 lib/regexdev/rte_regexdev.c            |  6 ++--
 lib/security/rte_security.c            |  4 +--
 lib/telemetry/telemetry.c              |  2 +-
 lib/telemetry/telemetry_legacy.c       |  2 +-
 lib/vhost/vdpa.c                       |  6 ++--
 lib/vhost/vhost_user.c                 |  2 +-
 43 files changed, 171 insertions(+), 171 deletions(-)

diff --git a/lib/cryptodev/cryptodev_pmd.c b/lib/cryptodev/cryptodev_pmd.c
index d79d561bf6..ce43a9fde7 100644
--- a/lib/cryptodev/cryptodev_pmd.c
+++ b/lib/cryptodev/cryptodev_pmd.c
@@ -56,7 +56,7 @@ rte_cryptodev_pmd_parse_uint_arg(const char *key __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_parse_input_args)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_parse_input_args);
 int
 rte_cryptodev_pmd_parse_input_args(
 		struct rte_cryptodev_pmd_init_params *params,
@@ -100,7 +100,7 @@ rte_cryptodev_pmd_parse_input_args(
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create);
 struct rte_cryptodev *
 rte_cryptodev_pmd_create(const char *name,
 		struct rte_device *device,
@@ -151,7 +151,7 @@ rte_cryptodev_pmd_create(const char *name,
 	return cryptodev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_destroy);
 int
 rte_cryptodev_pmd_destroy(struct rte_cryptodev *cryptodev)
 {
@@ -175,7 +175,7 @@ rte_cryptodev_pmd_destroy(struct rte_cryptodev *cryptodev)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_probing_finish)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_probing_finish);
 void
 rte_cryptodev_pmd_probing_finish(struct rte_cryptodev *cryptodev)
 {
@@ -214,7 +214,7 @@ dummy_crypto_dequeue_burst(__rte_unused void *qp,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_reset);
 void
 cryptodev_fp_ops_reset(struct rte_crypto_fp_ops *fp_ops)
 {
@@ -233,7 +233,7 @@ cryptodev_fp_ops_reset(struct rte_crypto_fp_ops *fp_ops)
 	*fp_ops = dummy;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_set)
+RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_set);
 void
 cryptodev_fp_ops_set(struct rte_crypto_fp_ops *fp_ops,
 		     const struct rte_cryptodev *dev)
@@ -246,7 +246,7 @@ cryptodev_fp_ops_set(struct rte_crypto_fp_ops *fp_ops,
 	fp_ops->qp_depth_used = dev->qp_depth_used;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_session_event_mdata_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_session_event_mdata_get);
 void *
 rte_cryptodev_session_event_mdata_get(struct rte_crypto_op *op)
 {
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index e72513d593..8e45370391 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -36,7 +36,7 @@ static uint8_t nb_drivers;
 
 static struct rte_cryptodev rte_crypto_devices[RTE_CRYPTO_MAX_DEVS];
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodevs)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodevs);
 struct rte_cryptodev *rte_cryptodevs = rte_crypto_devices;
 
 static struct rte_cryptodev_global cryptodev_globals = {
@@ -853,14 +853,14 @@ rte_cryptodev_get_feature_name(uint64_t flag)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_dev);
 struct rte_cryptodev *
 rte_cryptodev_pmd_get_dev(uint8_t dev_id)
 {
 	return &cryptodev_globals.devs[dev_id];
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_named_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_named_dev);
 struct rte_cryptodev *
 rte_cryptodev_pmd_get_named_dev(const char *name)
 {
@@ -1106,7 +1106,7 @@ rte_cryptodev_find_free_device_index(void)
 	return RTE_CRYPTO_MAX_DEVS;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate);
 struct rte_cryptodev *
 rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 {
@@ -1166,7 +1166,7 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 	return cryptodev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_release_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_release_device);
 int
 rte_cryptodev_pmd_release_device(struct rte_cryptodev *cryptodev)
 {
@@ -2037,7 +2037,7 @@ rte_cryptodev_callback_unregister(uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_callback_process)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_callback_process);
 void
 rte_cryptodev_pmd_callback_process(struct rte_cryptodev *dev,
 	enum rte_cryptodev_event_type event)
@@ -2780,7 +2780,7 @@ rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 	return mp;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create_dev_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create_dev_name);
 int
 rte_cryptodev_pmd_create_dev_name(char *name, const char *dev_name_prefix)
 {
@@ -2872,7 +2872,7 @@ rte_cryptodev_driver_name_get(uint8_t driver_id)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_allocate_driver)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_allocate_driver);
 uint8_t
 rte_cryptodev_allocate_driver(struct cryptodev_driver *crypto_drv,
 		const struct rte_driver *drv)
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 4472980204..65cb34d3e1 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -22,7 +22,7 @@
 
 static int16_t dma_devices_max;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_fp_objs)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_fp_objs);
 struct rte_dma_fp_object *rte_dma_fp_objs;
 static struct rte_dma_dev *rte_dma_devices;
 static struct {
@@ -352,7 +352,7 @@ dma_release(struct rte_dma_dev *dev)
 	memset(dev, 0, sizeof(struct rte_dma_dev));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_allocate);
 struct rte_dma_dev *
 rte_dma_pmd_allocate(const char *name, int numa_node, size_t private_data_size)
 {
@@ -370,7 +370,7 @@ rte_dma_pmd_allocate(const char *name, int numa_node, size_t private_data_size)
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_release)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_release);
 int
 rte_dma_pmd_release(const char *name)
 {
@@ -415,7 +415,7 @@ rte_dma_is_valid(int16_t dev_id)
 		rte_dma_devices[dev_id].state != RTE_DMA_DEV_UNUSED;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_get_dev_by_id)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_get_dev_by_id);
 struct rte_dma_dev *
 rte_dma_pmd_get_dev_by_id(int16_t dev_id)
 {
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 5156ccd8ba..6df7a6ab4d 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -24,7 +24,7 @@ rte_bus_name(const struct rte_bus *bus)
 	return bus->name;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_register);
 void
 rte_bus_register(struct rte_bus *bus)
 {
@@ -41,7 +41,7 @@ rte_bus_register(struct rte_bus *bus)
 	EAL_LOG(DEBUG, "Registered [%s] bus.", rte_bus_name(bus));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_unregister);
 void
 rte_bus_unregister(struct rte_bus *bus)
 {
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 47a5ebee5c..8804b9f171 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -69,7 +69,7 @@ rte_eal_iova_mode(void)
 }
 
 /* Get the EAL base address */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_get_baseaddr)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_get_baseaddr);
 uint64_t
 rte_eal_get_baseaddr(void)
 {
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 8eacb2f86b..4775d894c3 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -98,7 +98,7 @@ struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_dup)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_dup);
 struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 {
 	struct rte_intr_handle *intr_handle;
@@ -124,7 +124,7 @@ struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 	return intr_handle;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_event_list_update)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_event_list_update);
 int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 {
 	struct rte_epoll_event *tmp_elist;
@@ -237,7 +237,7 @@ enum rte_intr_handle_type rte_intr_type_get(
 	return RTE_INTR_HANDLE_UNKNOWN;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_set);
 int rte_intr_dev_fd_set(struct rte_intr_handle *intr_handle, int fd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -249,7 +249,7 @@ int rte_intr_dev_fd_set(struct rte_intr_handle *intr_handle, int fd)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_get);
 int rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -259,7 +259,7 @@ int rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_set);
 int rte_intr_max_intr_set(struct rte_intr_handle *intr_handle,
 				 int max_intr)
 {
@@ -280,7 +280,7 @@ int rte_intr_max_intr_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_get);
 int rte_intr_max_intr_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -290,7 +290,7 @@ int rte_intr_max_intr_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_set);
 int rte_intr_nb_efd_set(struct rte_intr_handle *intr_handle, int nb_efd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -302,7 +302,7 @@ int rte_intr_nb_efd_set(struct rte_intr_handle *intr_handle, int nb_efd)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_get);
 int rte_intr_nb_efd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -312,7 +312,7 @@ int rte_intr_nb_efd_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_intr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_intr_get);
 int rte_intr_nb_intr_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -322,7 +322,7 @@ int rte_intr_nb_intr_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_set);
 int rte_intr_efd_counter_size_set(struct rte_intr_handle *intr_handle,
 	uint8_t efd_counter_size)
 {
@@ -335,7 +335,7 @@ int rte_intr_efd_counter_size_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_get);
 int rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -345,7 +345,7 @@ int rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_get);
 int rte_intr_efds_index_get(const struct rte_intr_handle *intr_handle,
 	int index)
 {
@@ -363,7 +363,7 @@ int rte_intr_efds_index_get(const struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_set);
 int rte_intr_efds_index_set(struct rte_intr_handle *intr_handle,
 	int index, int fd)
 {
@@ -383,7 +383,7 @@ int rte_intr_efds_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_get);
 struct rte_epoll_event *rte_intr_elist_index_get(
 	struct rte_intr_handle *intr_handle, int index)
 {
@@ -401,7 +401,7 @@ struct rte_epoll_event *rte_intr_elist_index_get(
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_set);
 int rte_intr_elist_index_set(struct rte_intr_handle *intr_handle,
 	int index, struct rte_epoll_event elist)
 {
@@ -421,7 +421,7 @@ int rte_intr_elist_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_alloc);
 int rte_intr_vec_list_alloc(struct rte_intr_handle *intr_handle,
 	const char *name, int size)
 {
@@ -455,7 +455,7 @@ int rte_intr_vec_list_alloc(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_get);
 int rte_intr_vec_list_index_get(const struct rte_intr_handle *intr_handle,
 				int index)
 {
@@ -473,7 +473,7 @@ int rte_intr_vec_list_index_get(const struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_set);
 int rte_intr_vec_list_index_set(struct rte_intr_handle *intr_handle,
 				int index, int vec)
 {
@@ -493,7 +493,7 @@ int rte_intr_vec_list_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_free)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_free);
 void rte_intr_vec_list_free(struct rte_intr_handle *intr_handle)
 {
 	if (intr_handle == NULL)
@@ -506,7 +506,7 @@ void rte_intr_vec_list_free(struct rte_intr_handle *intr_handle)
 	intr_handle->vec_list_size = 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_get);
 void *rte_intr_instance_windows_handle_get(struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -516,7 +516,7 @@ void *rte_intr_instance_windows_handle_get(struct rte_intr_handle *intr_handle)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_set);
 int rte_intr_instance_windows_handle_set(struct rte_intr_handle *intr_handle,
 	void *windows_handle)
 {
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 84f9e1ba3d..f82aca83b5 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -70,7 +70,7 @@ eal_mcfg_update_from_internal(void)
 	mcfg->version = RTE_VERSION;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mem_get_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mem_get_lock);
 rte_rwlock_t *
 rte_mcfg_mem_get_lock(void)
 {
@@ -105,7 +105,7 @@ rte_mcfg_mem_write_unlock(void)
 	rte_rwlock_write_unlock(rte_mcfg_mem_get_lock());
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_tailq_get_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_tailq_get_lock);
 rte_rwlock_t *
 rte_mcfg_tailq_get_lock(void)
 {
@@ -140,7 +140,7 @@ rte_mcfg_tailq_write_unlock(void)
 	rte_rwlock_write_unlock(rte_mcfg_tailq_get_lock());
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mempool_get_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mempool_get_lock);
 rte_rwlock_t *
 rte_mcfg_mempool_get_lock(void)
 {
@@ -175,7 +175,7 @@ rte_mcfg_mempool_write_unlock(void)
 	rte_rwlock_write_unlock(rte_mcfg_mempool_get_lock());
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_timer_get_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_timer_get_lock);
 rte_spinlock_t *
 rte_mcfg_timer_get_lock(void)
 {
@@ -196,7 +196,7 @@ rte_mcfg_timer_unlock(void)
 	rte_spinlock_unlock(rte_mcfg_timer_get_lock());
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_ethdev_get_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_ethdev_get_lock);
 rte_spinlock_t *
 rte_mcfg_ethdev_get_lock(void)
 {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 1d2e881ad3..1fca0296c2 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -772,7 +772,7 @@ check_core_list(int *lcores, unsigned int count)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_parse_coremask)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_parse_coremask);
 int
 rte_eal_parse_coremask(const char *coremask, int *cores)
 {
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index e1b53a6161..3e37ab1742 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -348,7 +348,7 @@ add_internal_prefix(char *prefixed_name, const char *name, size_t size)
 	strlcpy(prefixed_name + prefixlen, name, size - prefixlen);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_create_internal_control)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_create_internal_control);
 int
 rte_thread_create_internal_control(rte_thread_t *id, const char *name,
 		rte_thread_func func, void *arg)
@@ -359,7 +359,7 @@ rte_thread_create_internal_control(rte_thread_t *id, const char *name,
 	return rte_thread_create_control(id, prefixed_name, func, arg);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_set_prefixed_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_set_prefixed_name);
 void
 rte_thread_set_prefixed_name(rte_thread_t id, const char *name)
 {
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 1b55c8590f..72865b7be5 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -656,7 +656,7 @@ rte_eal_intr_init(void)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl);
 int
 rte_intr_rx_ctl(struct rte_intr_handle *intr_handle,
 		int epfd, int op, unsigned int vec, void *data)
@@ -670,7 +670,7 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable);
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -680,14 +680,14 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable);
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en);
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
@@ -695,7 +695,7 @@ rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others);
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -703,7 +703,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple);
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
@@ -749,14 +749,14 @@ rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd);
 int
 rte_intr_tls_epfd(void)
 {
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd);
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index f2c89ae387..c705b2617e 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1313,7 +1313,7 @@ eal_init_tls_epfd(void)
 	return pfd;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd);
 int
 rte_intr_tls_epfd(void)
 {
@@ -1461,7 +1461,7 @@ rte_epoll_ctl(int epfd, int op, int fd,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl);
 int
 rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 		int op, unsigned int vec, void *data)
@@ -1527,7 +1527,7 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 	return rc;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd);
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
@@ -1546,7 +1546,7 @@ rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable);
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -1594,7 +1594,7 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable);
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
@@ -1609,14 +1609,14 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 	rte_intr_max_intr_set(intr_handle, 0);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en);
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
 	return !(!rte_intr_nb_efd_get(intr_handle));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others);
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -1627,7 +1627,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 				rte_intr_nb_efd_get(intr_handle));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple);
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
diff --git a/lib/eal/unix/eal_firmware.c b/lib/eal/unix/eal_firmware.c
index f2c16fb8a7..1627e62de9 100644
--- a/lib/eal/unix/eal_firmware.c
+++ b/lib/eal/unix/eal_firmware.c
@@ -147,7 +147,7 @@ firmware_read(const char *name, void **buf, size_t *bufsz)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read);
 int
 rte_firmware_read(const char *name, void **buf, size_t *bufsz)
 {
diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index 55b647c736..4ba28b714d 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -110,7 +110,7 @@ mem_rte_to_sys_prot(int prot)
 	return sys_prot;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map);
 void *
 rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	int fd, uint64_t offset)
@@ -134,14 +134,14 @@ rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	return mem_map(requested_addr, size, sys_prot, sys_flags, fd, offset);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap);
 int
 rte_mem_unmap(void *virt, size_t size)
 {
 	return mem_unmap(virt, size);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size);
 size_t
 rte_mem_page_size(void)
 {
@@ -165,7 +165,7 @@ rte_mem_page_size(void)
 	return page_size;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock);
 int
 rte_mem_lock(const void *virt, size_t size)
 {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 16498b9382..a38c69ddfd 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -542,7 +542,7 @@ rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read);
 int
 rte_firmware_read(__rte_unused const char *name,
 			__rte_unused void **buf,
diff --git a/lib/eal/windows/eal_interrupts.c b/lib/eal/windows/eal_interrupts.c
index f380272219..14b0cfeee8 100644
--- a/lib/eal/windows/eal_interrupts.c
+++ b/lib/eal/windows/eal_interrupts.c
@@ -116,7 +116,7 @@ rte_thread_is_intr(void)
 	return rte_thread_equal(intr_thread, rte_thread_self());
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl);
 int
 rte_intr_rx_ctl(__rte_unused struct rte_intr_handle *intr_handle,
 		__rte_unused int epfd, __rte_unused int op,
@@ -208,7 +208,7 @@ rte_intr_disable(__rte_unused const struct rte_intr_handle *intr_handle)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable);
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -218,14 +218,14 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable);
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en);
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
@@ -234,7 +234,7 @@ rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others);
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -243,7 +243,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple);
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
@@ -290,14 +290,14 @@ rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd);
 int
 rte_intr_tls_epfd(void)
 {
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd);
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 498e108a9e..4bc251598e 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -522,7 +522,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map);
 void *
 rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	int fd, uint64_t offset)
@@ -606,7 +606,7 @@ rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	return virt;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap);
 int
 rte_mem_unmap(void *virt, size_t size)
 {
@@ -630,7 +630,7 @@ eal_get_baseaddr(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size);
 size_t
 rte_mem_page_size(void)
 {
@@ -642,7 +642,7 @@ rte_mem_page_size(void)
 	return info.dwPageSize;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock);
 int
 rte_mem_lock(const void *virt, size_t size)
 {
diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..47a02da4a7 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -75,7 +75,7 @@ eth_dev_get(uint16_t port_id)
 	return eth_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate);
 struct rte_eth_dev *
 rte_eth_dev_allocate(const char *name)
 {
@@ -130,7 +130,7 @@ rte_eth_dev_allocate(const char *name)
 	return eth_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocated)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocated);
 struct rte_eth_dev *
 rte_eth_dev_allocated(const char *name)
 {
@@ -153,7 +153,7 @@ rte_eth_dev_allocated(const char *name)
  * makes sure that the same device would have the same port ID both
  * in the primary and secondary process.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_attach_secondary)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_attach_secondary);
 struct rte_eth_dev *
 rte_eth_dev_attach_secondary(const char *name)
 {
@@ -184,7 +184,7 @@ rte_eth_dev_attach_secondary(const char *name)
 	return eth_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_callback_process)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_callback_process);
 int
 rte_eth_dev_callback_process(struct rte_eth_dev *dev,
 	enum rte_eth_event_type event, void *ret_param)
@@ -212,7 +212,7 @@ rte_eth_dev_callback_process(struct rte_eth_dev *dev,
 	return rc;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_probing_finish)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_probing_finish);
 void
 rte_eth_dev_probing_finish(struct rte_eth_dev *dev)
 {
@@ -232,7 +232,7 @@ rte_eth_dev_probing_finish(struct rte_eth_dev *dev)
 	dev->state = RTE_ETH_DEV_ATTACHED;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_release_port)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_release_port);
 int
 rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 {
@@ -291,7 +291,7 @@ rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_create)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_create);
 int
 rte_eth_dev_create(struct rte_device *device, const char *name,
 	size_t priv_data_size,
@@ -367,7 +367,7 @@ rte_eth_dev_create(struct rte_device *device, const char *name,
 	return retval;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_destroy);
 int
 rte_eth_dev_destroy(struct rte_eth_dev *ethdev,
 	ethdev_uninit_t ethdev_uninit)
@@ -388,7 +388,7 @@ rte_eth_dev_destroy(struct rte_eth_dev *ethdev,
 	return rte_eth_dev_release_port(ethdev);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_get_by_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_get_by_name);
 struct rte_eth_dev *
 rte_eth_dev_get_by_name(const char *name)
 {
@@ -400,7 +400,7 @@ rte_eth_dev_get_by_name(const char *name)
 	return &rte_eth_devices[pid];
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_rx_hairpin_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_rx_hairpin_queue);
 int
 rte_eth_dev_is_rx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
@@ -409,7 +409,7 @@ rte_eth_dev_is_rx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_tx_hairpin_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_tx_hairpin_queue);
 int
 rte_eth_dev_is_tx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
@@ -418,7 +418,7 @@ rte_eth_dev_is_tx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_internal_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_internal_reset);
 void
 rte_eth_dev_internal_reset(struct rte_eth_dev *dev)
 {
@@ -629,7 +629,7 @@ eth_dev_tokenise_representor_list(char *p_val, struct rte_eth_devargs *eth_devar
 	return result;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devargs_parse)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devargs_parse);
 int
 rte_eth_devargs_parse(const char *dargs, struct rte_eth_devargs *eth_devargs,
 		      unsigned int nb_da)
@@ -692,7 +692,7 @@ eth_dev_dma_mzone_name(char *name, size_t len, uint16_t port_id, uint16_t queue_
 			port_id, queue_id, ring_name);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_free)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_free);
 int
 rte_eth_dma_zone_free(const struct rte_eth_dev *dev, const char *ring_name,
 		uint16_t queue_id)
@@ -717,7 +717,7 @@ rte_eth_dma_zone_free(const struct rte_eth_dev *dev, const char *ring_name,
 	return rc;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_reserve)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_reserve);
 const struct rte_memzone *
 rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 			 uint16_t queue_id, size_t size, unsigned int align,
@@ -753,7 +753,7 @@ rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_bind);
 int
 rte_eth_hairpin_queue_peer_bind(uint16_t cur_port, uint16_t cur_queue,
 				struct rte_hairpin_peer_info *peer_info,
@@ -772,7 +772,7 @@ rte_eth_hairpin_queue_peer_bind(uint16_t cur_port, uint16_t cur_queue,
 	return dev->dev_ops->hairpin_queue_peer_bind(dev, cur_queue, peer_info, direction);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_unbind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_unbind);
 int
 rte_eth_hairpin_queue_peer_unbind(uint16_t cur_port, uint16_t cur_queue,
 				  uint32_t direction)
@@ -787,7 +787,7 @@ rte_eth_hairpin_queue_peer_unbind(uint16_t cur_port, uint16_t cur_queue,
 	return dev->dev_ops->hairpin_queue_peer_unbind(dev, cur_queue, direction);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_update)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_update);
 int
 rte_eth_hairpin_queue_peer_update(uint16_t peer_port, uint16_t peer_queue,
 				  struct rte_hairpin_peer_info *cur_info,
@@ -809,7 +809,7 @@ rte_eth_hairpin_queue_peer_update(uint16_t peer_port, uint16_t peer_queue,
 						       cur_info, peer_info, direction);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_ip_reassembly_dynfield_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_ip_reassembly_dynfield_register);
 int
 rte_eth_ip_reassembly_dynfield_register(int *field_offset, int *flag_offset)
 {
@@ -838,7 +838,7 @@ rte_eth_ip_reassembly_dynfield_register(int *field_offset, int *flag_offset)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_pkt_burst_dummy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_pkt_burst_dummy);
 uint16_t
 rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 		struct rte_mbuf **pkts __rte_unused,
@@ -847,7 +847,7 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get);
 int
 rte_eth_representor_id_get(uint16_t port_id,
 			   enum rte_eth_representor_type type,
@@ -943,7 +943,7 @@ rte_eth_representor_id_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_alloc);
 int
 rte_eth_switch_domain_alloc(uint16_t *domain_id)
 {
@@ -964,7 +964,7 @@ rte_eth_switch_domain_alloc(uint16_t *domain_id)
 	return -ENOSPC;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_free)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_free);
 int
 rte_eth_switch_domain_free(uint16_t domain_id)
 {
@@ -981,7 +981,7 @@ rte_eth_switch_domain_free(uint16_t domain_id)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_get_restore_flags)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_get_restore_flags);
 uint64_t
 rte_eth_get_restore_flags(struct rte_eth_dev *dev, enum rte_eth_dev_operation op)
 {
diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index 5eddda1da3..0205181e80 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -133,7 +133,7 @@ static const uint32_t link_modes[] = {
 	[120] =  800000, /* ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT */
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_ethtool)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_ethtool);
 uint32_t
 rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
 {
@@ -157,7 +157,7 @@ rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
 	return rte_eth_speed_bitflag(speed, duplex);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_glink)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_glink);
 uint32_t
 rte_eth_link_speed_glink(const uint32_t *bitmap, int8_t nwords)
 {
@@ -178,7 +178,7 @@ rte_eth_link_speed_glink(const uint32_t *bitmap, int8_t nwords)
 	return ethdev_bitmap;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_gset)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_gset);
 uint32_t
 rte_eth_link_speed_gset(uint32_t legacy_bitmap)
 {
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 780904ec09..92ba1e9b28 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -39,7 +39,7 @@
 
 #define ETH_XSTATS_ITER_NUM	0x100
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devices)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devices);
 struct rte_eth_dev rte_eth_devices[RTE_MAX_ETHPORTS];
 
 /* public fast-path API */
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 72f2450238..25801717a7 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -3032,7 +3032,7 @@ rte_flow_dummy_async_action_list_handle_query_update(
 				  rte_strerror(ENOSYS));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_flow_fp_default_ops)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_flow_fp_default_ops);
 struct rte_flow_fp_ops rte_flow_fp_default_ops = {
 	.async_create = rte_flow_dummy_async_create,
 	.async_create_by_index = rte_flow_dummy_async_create_by_index,
diff --git a/lib/eventdev/eventdev_private.c b/lib/eventdev/eventdev_private.c
index dffd2c71d0..10fb0bf1c7 100644
--- a/lib/eventdev/eventdev_private.c
+++ b/lib/eventdev/eventdev_private.c
@@ -107,7 +107,7 @@ dummy_event_port_preschedule_hint(__rte_unused void *port,
 {
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_reset);
 void
 event_dev_fp_ops_reset(struct rte_event_fp_ops *fp_op)
 {
@@ -131,7 +131,7 @@ event_dev_fp_ops_reset(struct rte_event_fp_ops *fp_op)
 	*fp_op = dummy;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_set)
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_set);
 void
 event_dev_fp_ops_set(struct rte_event_fp_ops *fp_op,
 		     const struct rte_eventdev *dev)
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 6ef434228d..9325d5880d 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -30,12 +30,12 @@
 #include "eventdev_pmd.h"
 #include "eventdev_trace.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_event_logtype)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_logtype);
 RTE_LOG_REGISTER_DEFAULT(rte_event_logtype, INFO);
 
 static struct rte_eventdev rte_event_devices[RTE_EVENT_MAX_DEVS];
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eventdevs)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eventdevs);
 struct rte_eventdev *rte_eventdevs = rte_event_devices;
 
 static struct rte_eventdev_global eventdev_globals = {
@@ -1453,7 +1453,7 @@ int rte_event_dev_xstats_reset(uint8_t dev_id,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_selftest_seqn_dynfield_offset)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_selftest_seqn_dynfield_offset);
 int rte_event_pmd_selftest_seqn_dynfield_offset = -1;
 
 RTE_EXPORT_SYMBOL(rte_event_dev_selftest);
@@ -1672,7 +1672,7 @@ eventdev_find_free_device_index(void)
 	return RTE_EVENT_MAX_DEVS;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_allocate);
 struct rte_eventdev *
 rte_event_pmd_allocate(const char *name, int socket_id)
 {
@@ -1721,7 +1721,7 @@ rte_event_pmd_allocate(const char *name, int socket_id)
 	return eventdev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_release)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_release);
 int
 rte_event_pmd_release(struct rte_eventdev *eventdev)
 {
@@ -1758,7 +1758,7 @@ rte_event_pmd_release(struct rte_eventdev *eventdev)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(event_dev_probing_finish)
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_probing_finish);
 void
 event_dev_probing_finish(struct rte_eventdev *eventdev)
 {
diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 5c16edda06..58c9bd702b 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -139,7 +139,7 @@ gpu_get_by_id(int16_t dev_id)
 	return &gpus[dev_id];
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_get_by_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_get_by_name);
 struct rte_gpu *
 rte_gpu_get_by_name(const char *name)
 {
@@ -182,7 +182,7 @@ gpu_shared_mem_init(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_allocate);
 struct rte_gpu *
 rte_gpu_allocate(const char *name)
 {
@@ -244,7 +244,7 @@ rte_gpu_allocate(const char *name)
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_attach);
 struct rte_gpu *
 rte_gpu_attach(const char *name)
 {
@@ -317,7 +317,7 @@ rte_gpu_add_child(const char *name, int16_t parent, uint64_t child_context)
 	return dev->mpshared->info.dev_id;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_complete_new)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_complete_new);
 void
 rte_gpu_complete_new(struct rte_gpu *dev)
 {
@@ -328,7 +328,7 @@ rte_gpu_complete_new(struct rte_gpu *dev)
 	rte_gpu_notify(dev, RTE_GPU_EVENT_NEW);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_release)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_release);
 int
 rte_gpu_release(struct rte_gpu *dev)
 {
@@ -505,7 +505,7 @@ gpu_free_callbacks(struct rte_gpu *dev)
 	rte_rwlock_write_unlock(&gpu_callback_lock);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_notify)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_notify);
 void
 rte_gpu_notify(struct rte_gpu *dev, enum rte_gpu_event event)
 {
diff --git a/lib/hash/rte_thash_gf2_poly_math.c b/lib/hash/rte_thash_gf2_poly_math.c
index ddf4dd863b..05cd0d5f37 100644
--- a/lib/hash/rte_thash_gf2_poly_math.c
+++ b/lib/hash/rte_thash_gf2_poly_math.c
@@ -242,7 +242,7 @@ thash_test_poly_order(uint32_t poly, int degree)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(thash_get_rand_poly)
+RTE_EXPORT_INTERNAL_SYMBOL(thash_get_rand_poly);
 uint32_t
 thash_get_rand_poly(uint32_t poly_degree)
 {
diff --git a/lib/hash/rte_thash_gfni.c b/lib/hash/rte_thash_gfni.c
index 2003c7b3db..b82b9bba63 100644
--- a/lib/hash/rte_thash_gfni.c
+++ b/lib/hash/rte_thash_gfni.c
@@ -13,7 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_gfni_logtype, gfni, INFO);
 #define HASH_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub);
 uint32_t
 rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	const uint8_t *key __rte_unused, int len __rte_unused)
@@ -29,7 +29,7 @@ rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub);
 void
 rte_thash_gfni_bulk_stub(const uint64_t *mtrx __rte_unused,
 	int len __rte_unused, uint8_t *tuple[] __rte_unused,
diff --git a/lib/log/log.c b/lib/log/log.c
index 6909bc7f9e..1e8e98944f 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -234,7 +234,7 @@ log_save_level(uint32_t priority, const char *regex, const char *pattern)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_regexp)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_regexp);
 int
 eal_log_save_regexp(const char *regex, uint32_t level)
 {
@@ -262,7 +262,7 @@ rte_log_set_level_pattern(const char *pattern, uint32_t level)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_pattern)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_pattern);
 int
 eal_log_save_pattern(const char *pattern, uint32_t level)
 {
@@ -400,7 +400,7 @@ RTE_INIT_PRIO(log_init, LOG)
 	rte_logs.dynamic_types_len = RTE_LOGTYPE_FIRST_EXT_ID;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_level2str)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_level2str);
 const char *
 eal_log_level2str(uint32_t level)
 {
@@ -528,7 +528,7 @@ rte_log(uint32_t level, uint32_t logtype, const char *format, ...)
 /*
  * Called by rte_eal_init
  */
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_init)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_init);
 void
 eal_log_init(const char *id)
 {
@@ -574,7 +574,7 @@ eal_log_init(const char *id)
 /*
  * Called by eal_cleanup
  */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_log_cleanup)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_log_cleanup);
 void
 rte_eal_log_cleanup(void)
 {
diff --git a/lib/log/log_color.c b/lib/log/log_color.c
index 690a27f96e..cf1af6483f 100644
--- a/lib/log/log_color.c
+++ b/lib/log/log_color.c
@@ -100,7 +100,7 @@ color_snprintf(char *buf, size_t len, enum log_field field,
  *   auto - enable if stderr is a terminal
  *   never - color output is disabled.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_color)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_color);
 int
 eal_log_color(const char *mode)
 {
diff --git a/lib/log/log_syslog.c b/lib/log/log_syslog.c
index 99d4132a55..121ebafe69 100644
--- a/lib/log/log_syslog.c
+++ b/lib/log/log_syslog.c
@@ -46,7 +46,7 @@ static const struct {
 	{ "local7", LOG_LOCAL7 },
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_syslog)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_syslog);
 int
 eal_log_syslog(const char *name)
 {
diff --git a/lib/log/log_timestamp.c b/lib/log/log_timestamp.c
index 47b6f7cfc4..d08e27d18c 100644
--- a/lib/log/log_timestamp.c
+++ b/lib/log/log_timestamp.c
@@ -41,7 +41,7 @@ static struct {
 } log_time;
 
 /* Set the log timestamp format */
-RTE_EXPORT_INTERNAL_SYMBOL(eal_log_timestamp)
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_timestamp);
 int
 eal_log_timestamp(const char *str)
 {
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index ac8ff70ece..41a0d8c35c 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1474,7 +1474,7 @@ mempool_event_callback_invoke(enum rte_mempool_event event,
 	rte_mcfg_tailq_read_unlock();
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_register);
 int
 rte_mempool_event_callback_register(rte_mempool_event_callback *func,
 				    void *user_data)
@@ -1513,7 +1513,7 @@ rte_mempool_event_callback_register(rte_mempool_event_callback *func,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_unregister);
 int
 rte_mempool_event_callback_unregister(rte_mempool_event_callback *func,
 				      void *user_data)
diff --git a/lib/mldev/mldev_utils.c b/lib/mldev/mldev_utils.c
index b15f825158..dc60af306e 100644
--- a/lib/mldev/mldev_utils.c
+++ b/lib/mldev/mldev_utils.c
@@ -15,7 +15,7 @@
  * This file implements Machine Learning utility routines, except type conversion routines.
  */
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_size_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_size_get);
 int
 rte_ml_io_type_size_get(enum rte_ml_io_type type)
 {
@@ -51,7 +51,7 @@ rte_ml_io_type_size_get(enum rte_ml_io_type type)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_to_str)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_to_str);
 void
 rte_ml_io_type_to_str(enum rte_ml_io_type type, char *str, int len)
 {
diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index 4455831db5..e1abb52e90 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -24,14 +24,14 @@ struct rte_ml_op_pool_private {
 	/*< Size of private user data with each operation. */
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_dev);
 struct rte_ml_dev *
 rte_ml_dev_pmd_get_dev(int16_t dev_id)
 {
 	return &ml_dev_globals.devs[dev_id];
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_named_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_named_dev);
 struct rte_ml_dev *
 rte_ml_dev_pmd_get_named_dev(const char *name)
 {
@@ -50,7 +50,7 @@ rte_ml_dev_pmd_get_named_dev(const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_allocate)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_allocate);
 struct rte_ml_dev *
 rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 {
@@ -124,7 +124,7 @@ rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_release)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_release);
 int
 rte_ml_dev_pmd_release(struct rte_ml_dev *dev)
 {
diff --git a/lib/mldev/rte_mldev_pmd.c b/lib/mldev/rte_mldev_pmd.c
index 434360f2d3..53129a05d7 100644
--- a/lib/mldev/rte_mldev_pmd.c
+++ b/lib/mldev/rte_mldev_pmd.c
@@ -9,7 +9,7 @@
 
 #include "rte_mldev_pmd.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_create)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_create);
 struct rte_ml_dev *
 rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 		      struct rte_ml_dev_pmd_init_params *params)
@@ -44,7 +44,7 @@ rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_destroy);
 int
 rte_ml_dev_pmd_destroy(struct rte_ml_dev *dev)
 {
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 70ea3e7a07..b169e957ec 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -37,7 +37,7 @@ struct rte_pmu_event {
 	TAILQ_ENTRY(rte_pmu_event) next;
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmu)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmu);
 struct rte_pmu rte_pmu;
 
 /* Stubs for arch-specific functions */
diff --git a/lib/power/power_common.c b/lib/power/power_common.c
index 2da034e9d0..3fae203e69 100644
--- a/lib/power/power_common.c
+++ b/lib/power/power_common.c
@@ -14,7 +14,7 @@
 
 #include "power_common.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_power_logtype)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_logtype);
 RTE_LOG_REGISTER_DEFAULT(rte_power_logtype, INFO);
 
 #define POWER_SYSFILE_SCALING_DRIVER   \
@@ -23,7 +23,7 @@ RTE_LOG_REGISTER_DEFAULT(rte_power_logtype, INFO);
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_governor"
 #define POWER_CONVERT_TO_DECIMAL 10
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpufreq_check_scaling_driver)
+RTE_EXPORT_INTERNAL_SYMBOL(cpufreq_check_scaling_driver);
 int
 cpufreq_check_scaling_driver(const char *driver_name)
 {
@@ -69,7 +69,7 @@ cpufreq_check_scaling_driver(const char *driver_name)
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(open_core_sysfs_file)
+RTE_EXPORT_INTERNAL_SYMBOL(open_core_sysfs_file);
 int
 open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 {
@@ -88,7 +88,7 @@ open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_u32)
+RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_u32);
 int
 read_core_sysfs_u32(FILE *f, uint32_t *val)
 {
@@ -114,7 +114,7 @@ read_core_sysfs_u32(FILE *f, uint32_t *val)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_s)
+RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_s);
 int
 read_core_sysfs_s(FILE *f, char *buf, unsigned int len)
 {
@@ -133,7 +133,7 @@ read_core_sysfs_s(FILE *f, char *buf, unsigned int len)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(write_core_sysfs_s)
+RTE_EXPORT_INTERNAL_SYMBOL(write_core_sysfs_s);
 int
 write_core_sysfs_s(FILE *f, const char *str)
 {
@@ -160,7 +160,7 @@ write_core_sysfs_s(FILE *f, const char *str)
  * set it into 'performance' if it is not by writing the sys file. The original
  * governor will be saved for rolling back.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(power_set_governor)
+RTE_EXPORT_INTERNAL_SYMBOL(power_set_governor);
 int
 power_set_governor(unsigned int lcore_id, const char *new_governor,
 		char *orig_governor, size_t orig_governor_len)
@@ -214,7 +214,7 @@ power_set_governor(unsigned int lcore_id, const char *new_governor,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(power_get_lcore_mapped_cpu_id)
+RTE_EXPORT_INTERNAL_SYMBOL(power_get_lcore_mapped_cpu_id);
 int power_get_lcore_mapped_cpu_id(uint32_t lcore_id, uint32_t *cpu_id)
 {
 	rte_cpuset_t lcore_cpus;
diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index 635ed72a6d..c5964ee0e6 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -26,7 +26,7 @@ const char *power_env_str[] = {
 };
 
 /* register the ops struct in rte_power_cpufreq_ops, return 0 on success. */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_cpufreq_ops)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_cpufreq_ops);
 int
 rte_power_register_cpufreq_ops(struct rte_power_cpufreq_ops *driver_ops)
 {
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index be2785a7fa..c827d8bada 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -25,7 +25,7 @@ const char *uncore_env_str[] = {
 };
 
 /* register the ops struct in rte_power_uncore_ops, return 0 on success. */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_uncore_ops)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_uncore_ops);
 int
 rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 {
diff --git a/lib/regexdev/rte_regexdev.c b/lib/regexdev/rte_regexdev.c
index bbaa10a37e..d824c381b0 100644
--- a/lib/regexdev/rte_regexdev.c
+++ b/lib/regexdev/rte_regexdev.c
@@ -92,7 +92,7 @@ regexdev_check_name(const char *name)
 
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_register);
 struct rte_regexdev *
 rte_regexdev_register(const char *name)
 {
@@ -130,14 +130,14 @@ rte_regexdev_register(const char *name)
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_unregister);
 void
 rte_regexdev_unregister(struct rte_regexdev *dev)
 {
 	dev->state = RTE_REGEXDEV_UNUSED;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_get_device_by_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_get_device_by_name);
 struct rte_regexdev *
 rte_regexdev_get_device_by_name(const char *name)
 {
diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index 909c5afc2f..dbb6773758 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -36,7 +36,7 @@ int rte_security_dynfield_offset = -1;
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_oop_dynfield_offset, 23.11);
 int rte_security_oop_dynfield_offset = -1;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_security_dynfield_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_security_dynfield_register);
 int
 rte_security_dynfield_register(void)
 {
@@ -50,7 +50,7 @@ rte_security_dynfield_register(void)
 	return rte_security_dynfield_offset;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_security_oop_dynfield_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_security_oop_dynfield_register);
 int
 rte_security_oop_dynfield_register(void)
 {
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index b4b790c044..d40057e197 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -655,7 +655,7 @@ telemetry_v2_init(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_init)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_init);
 int32_t
 rte_telemetry_init(const char *runtime_dir, const char *rte_version, rte_cpuset_t *cpuset)
 {
diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..f832bd9ac5 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -53,7 +53,7 @@ struct json_command callbacks[TELEMETRY_LEGACY_MAX_CALLBACKS] = {
 int num_legacy_callbacks = 1;
 static rte_spinlock_t callback_sl = RTE_SPINLOCK_INITIALIZER;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_legacy_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_legacy_register);
 int
 rte_telemetry_legacy_register(const char *cmd,
 		enum rte_telemetry_legacy_data_req data_req,
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index 7d28427460..2ddcc49a35 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -73,7 +73,7 @@ rte_vdpa_get_rte_device(struct rte_vdpa_device *vdpa_dev)
 	return vdpa_dev->device;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_register_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_register_device);
 struct rte_vdpa_device *
 rte_vdpa_register_device(struct rte_device *rte_dev,
 		struct rte_vdpa_dev_ops *ops)
@@ -129,7 +129,7 @@ rte_vdpa_register_device(struct rte_device *rte_dev,
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_unregister_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_unregister_device);
 int
 rte_vdpa_unregister_device(struct rte_vdpa_device *dev)
 {
@@ -151,7 +151,7 @@ rte_vdpa_unregister_device(struct rte_vdpa_device *dev)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_relay_vring_used)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_relay_vring_used);
 int
 rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 {
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index ceed74ea64..50542351e7 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3416,7 +3416,7 @@ static int vhost_user_backend_set_vring_host_notifier(struct virtio_net *dev,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vhost_host_notifier_ctrl)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vhost_host_notifier_ctrl);
 int rte_vhost_host_notifier_ctrl(int vid, uint16_t qid, bool enable)
 {
 	struct virtio_net *dev;
-- 
2.17.1

