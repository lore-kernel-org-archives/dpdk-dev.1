Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11464CA1002
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 10:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056B240668;
	Mon,  1 Sep 2025 12:46:38 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 8BB2C402E9
 for <dev@dpdk.org>; Mon,  1 Sep 2025 12:46:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFlmn6Js6zdck4;
 Mon,  1 Sep 2025 18:42:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 42A4F1402CF;
 Mon,  1 Sep 2025 18:46:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 18:46:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v4 2/5] lib: add semicolon when export experimental symbol
Date: Mon, 1 Sep 2025 18:46:25 +0800
Message-ID: <20250901104628.50622-3-fengchengwen@huawei.com>
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

Currently, the RTE_EXPORT_EXPERIMENTAL_SYMBOL was placed at the
beginning of APIs, but doesn't end with a semicolon. As a result, some
IDEs cannot identify the APIs and cannot quickly jump to the definition.

A semicolon is added to the end of above RTE_EXPORT_EXPERIMENTAL_SYMBOL
in this commit.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/argparse/rte_argparse.c              |   4 +-
 lib/bbdev/bbdev_trace_points.c           |   4 +-
 lib/bbdev/rte_bbdev.c                    |   4 +-
 lib/cmdline/cmdline_parse_bool.c         |   2 +-
 lib/cryptodev/cryptodev_trace_points.c   |   2 +-
 lib/cryptodev/rte_cryptodev.c            |  14 +--
 lib/dispatcher/rte_dispatcher.c          |  26 ++--
 lib/dmadev/rte_dmadev_trace_points.c     |  14 +--
 lib/eal/common/eal_common_lcore_var.c    |   2 +-
 lib/eal/common/eal_common_memory.c       |   2 +-
 lib/eal/common/eal_common_string_fns.c   |   2 +-
 lib/eal/common/eal_common_trace.c        |  30 ++---
 lib/eal/common/eal_common_trace_ctf.c    |   2 +-
 lib/eal/common/eal_common_trace_points.c |  36 +++---
 lib/eal/common/eal_common_trace_utils.c  |   2 +-
 lib/eal/common/rte_bitset.c              |   2 +-
 lib/eal/common/rte_malloc.c              |   2 +-
 lib/eal/linux/eal_vfio.c                 |   2 +-
 lib/eal/windows/eal.c                    |  10 +-
 lib/ethdev/ethdev_trace_points.c         |  12 +-
 lib/ethdev/rte_ethdev.c                  |  88 +++++++-------
 lib/ethdev/rte_ethdev_cman.c             |   8 +-
 lib/ethdev/rte_flow.c                    | 108 ++++++++---------
 lib/ethdev/rte_mtr.c                     |  42 +++----
 lib/ethdev/rte_tm.c                      |   2 +-
 lib/eventdev/eventdev_trace_points.c     |   6 +-
 lib/eventdev/rte_event_crypto_adapter.c  |   6 +-
 lib/eventdev/rte_event_dma_adapter.c     |  30 ++---
 lib/eventdev/rte_event_eth_rx_adapter.c  |  10 +-
 lib/eventdev/rte_event_eth_tx_adapter.c  |   6 +-
 lib/eventdev/rte_event_timer_adapter.c   |   2 +-
 lib/eventdev/rte_event_vector_adapter.c  |  20 ++--
 lib/eventdev/rte_eventdev.c              |  10 +-
 lib/fib/rte_fib.c                        |   2 +-
 lib/gpudev/gpudev.c                      |  52 ++++----
 lib/graph/graph_feature_arc.c            |  34 +++---
 lib/graph/node.c                         |   2 +-
 lib/hash/rte_cuckoo_hash.c               |   2 +-
 lib/hash/rte_thash.c                     |   2 +-
 lib/mempool/mempool_trace_points.c       |  20 ++--
 lib/mempool/rte_mempool.c                |   4 +-
 lib/metrics/rte_metrics_telemetry.c      |  22 ++--
 lib/mldev/mldev_utils_neon.c             |  36 +++---
 lib/mldev/mldev_utils_neon_bfloat16.c    |   4 +-
 lib/mldev/mldev_utils_scalar.c           |  36 +++---
 lib/mldev/mldev_utils_scalar_bfloat16.c  |   4 +-
 lib/mldev/rte_mldev.c                    |  66 +++++-----
 lib/node/ethdev_ctrl.c                   |   2 +-
 lib/node/ip4_lookup_fib.c                |   4 +-
 lib/node/ip4_reassembly.c                |   2 +-
 lib/node/ip6_lookup.c                    |   2 +-
 lib/node/ip6_lookup_fib.c                |   4 +-
 lib/node/ip6_rewrite.c                   |   2 +-
 lib/node/udp4_input.c                    |   4 +-
 lib/pdcp/rte_pdcp.c                      |  10 +-
 lib/pipeline/rte_port_in_action.c        |  16 +--
 lib/pipeline/rte_swx_ctl.c               |  34 +++---
 lib/pipeline/rte_swx_ipsec.c             |  14 +--
 lib/pipeline/rte_swx_pipeline.c          | 146 +++++++++++------------
 lib/pipeline/rte_table_action.c          |  32 ++---
 lib/pmu/pmu.c                            |   8 +-
 lib/port/rte_port_eventdev.c             |   6 +-
 lib/port/rte_swx_port_ethdev.c           |   4 +-
 lib/port/rte_swx_port_fd.c               |   4 +-
 lib/port/rte_swx_port_ring.c             |   4 +-
 lib/port/rte_swx_port_source_sink.c      |   6 +-
 lib/power/rte_power_qos.c                |   4 +-
 lib/power/rte_power_uncore.c             |   8 +-
 lib/regexdev/rte_regexdev.c              |  46 +++----
 lib/reorder/rte_reorder.c                |   8 +-
 lib/ring/rte_ring.c                      |   2 +-
 lib/ring/rte_soring.c                    |   6 +-
 lib/ring/soring.c                        |  32 ++---
 lib/security/rte_security.c              |   6 +-
 lib/table/rte_swx_table_em.c             |   4 +-
 lib/table/rte_swx_table_learner.c        |  20 ++--
 lib/table/rte_swx_table_selector.c       |  12 +-
 lib/table/rte_swx_table_wm.c             |   2 +-
 lib/telemetry/telemetry.c                |   2 +-
 lib/telemetry/telemetry_data.c           |   4 +-
 lib/vhost/vhost.c                        |  18 +--
 lib/vhost/virtio_net.c                   |  10 +-
 82 files changed, 643 insertions(+), 643 deletions(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 331f05f01d..1ddec956e9 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -793,7 +793,7 @@ show_args_help(const struct rte_argparse *obj)
 		printf("\n");
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03);
 int
 rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 {
@@ -832,7 +832,7 @@ rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse_type, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse_type, 24.03);
 int
 rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val)
 {
diff --git a/lib/bbdev/bbdev_trace_points.c b/lib/bbdev/bbdev_trace_points.c
index 942c7be819..ac7ab2d553 100644
--- a/lib/bbdev/bbdev_trace_points.c
+++ b/lib/bbdev/bbdev_trace_points.c
@@ -22,9 +22,9 @@ RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_start,
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_stop,
 	lib.bbdev.queue.stop)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_enqueue, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_enqueue, 25.03);
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_enqueue,
 	lib.bbdev.enq)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_dequeue, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_dequeue, 25.03);
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_dequeue,
 	lib.bbdev.deq)
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ddcb51c510..eecaae2396 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1241,7 +1241,7 @@ rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status)
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_queue_ops_dump, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_queue_ops_dump, 24.11);
 int
 rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 {
@@ -1281,7 +1281,7 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 	return dev->dev_ops->queue_ops_dump(dev, queue_id, f);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_param_string, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_param_string, 24.11);
 char *
 rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, char *str, uint32_t len)
 {
diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
index e03cc3d545..4ef6b8ac68 100644
--- a/lib/cmdline/cmdline_parse_bool.c
+++ b/lib/cmdline/cmdline_parse_bool.c
@@ -14,7 +14,7 @@
 #include "cmdline_parse_bool.h"
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03);
 struct cmdline_token_ops cmdline_token_bool_ops = {
 	.parse = cmdline_parse_bool,
 	.complete_get_nb = NULL,
diff --git a/lib/cryptodev/cryptodev_trace_points.c b/lib/cryptodev/cryptodev_trace_points.c
index 31e7a188f6..e890026e69 100644
--- a/lib/cryptodev/cryptodev_trace_points.c
+++ b/lib/cryptodev/cryptodev_trace_points.c
@@ -201,6 +201,6 @@ RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_op_pool_create,
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_count,
 	lib.cryptodev.count)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_cryptodev_trace_qp_depth_used, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_cryptodev_trace_qp_depth_used, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_qp_depth_used,
 	lib.cryptodev.qp_depth_used)
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 64779bbb45..e72513d593 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -331,7 +331,7 @@ rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_cipher_algo_string, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_cipher_algo_string, 23.03);
 const char *
 rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 {
@@ -345,7 +345,7 @@ rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_auth_algo_string, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_auth_algo_string, 23.03);
 const char *
 rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 {
@@ -359,7 +359,7 @@ rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_aead_algo_string, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_aead_algo_string, 23.03);
 const char *
 rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 {
@@ -373,7 +373,7 @@ rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 	return alg_str;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_get_xform_string, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_get_xform_string, 23.03);
 const char *
 rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum)
 {
@@ -655,7 +655,7 @@ rte_cryptodev_asym_xform_capability_check_hash(
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_xform_capability_check_opcap, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_xform_capability_check_opcap, 24.11);
 int
 rte_cryptodev_asym_xform_capability_check_opcap(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -1279,7 +1279,7 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_reset, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_reset, 24.11);
 int
 rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
@@ -2060,7 +2060,7 @@ rte_cryptodev_pmd_callback_process(struct rte_cryptodev *dev,
 	rte_spinlock_unlock(&rte_cryptodev_cb_lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_event_error_query, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_event_error_query, 23.03);
 int
 rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id)
 {
diff --git a/lib/dispatcher/rte_dispatcher.c b/lib/dispatcher/rte_dispatcher.c
index a35967f7b7..10374d8d72 100644
--- a/lib/dispatcher/rte_dispatcher.c
+++ b/lib/dispatcher/rte_dispatcher.c
@@ -267,7 +267,7 @@ evd_service_unregister(struct rte_dispatcher *dispatcher)
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_create, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_create, 23.11);
 struct rte_dispatcher *
 rte_dispatcher_create(uint8_t event_dev_id)
 {
@@ -302,7 +302,7 @@ rte_dispatcher_create(uint8_t event_dev_id)
 	return dispatcher;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_free, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_free, 23.11);
 int
 rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 {
@@ -320,7 +320,7 @@ rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_service_id_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_service_id_get, 23.11);
 uint32_t
 rte_dispatcher_service_id_get(const struct rte_dispatcher *dispatcher)
 {
@@ -344,7 +344,7 @@ lcore_port_index(struct rte_dispatcher_lcore *lcore,
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_bind_port_to_lcore, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_bind_port_to_lcore, 23.11);
 int
 rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, uint16_t batch_size, uint64_t timeout,
@@ -374,7 +374,7 @@ rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unbind_port_from_lcore, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unbind_port_from_lcore, 23.11);
 int
 rte_dispatcher_unbind_port_from_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, unsigned int lcore_id)
@@ -457,7 +457,7 @@ evd_install_handler(struct rte_dispatcher *dispatcher,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_register, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_register, 23.11);
 int
 rte_dispatcher_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_match_t match_fun, void *match_data,
@@ -529,7 +529,7 @@ evd_uninstall_handler(struct rte_dispatcher *dispatcher, int handler_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unregister, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unregister, 23.11);
 int
 rte_dispatcher_unregister(struct rte_dispatcher *dispatcher, int handler_id)
 {
@@ -583,7 +583,7 @@ evd_alloc_finalizer(struct rte_dispatcher *dispatcher)
 	return finalizer;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_register, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_register, 23.11);
 int
 rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_finalize_t finalize_fun, void *finalize_data)
@@ -601,7 +601,7 @@ rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	return finalizer->id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_unregister, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_unregister, 23.11);
 int
 rte_dispatcher_finalize_unregister(struct rte_dispatcher *dispatcher,
 	int finalizer_id)
@@ -653,14 +653,14 @@ evd_set_service_runstate(struct rte_dispatcher *dispatcher, int state)
 	RTE_VERIFY(rc == 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_start, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_start, 23.11);
 void
 rte_dispatcher_start(struct rte_dispatcher *dispatcher)
 {
 	evd_set_service_runstate(dispatcher, 1);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stop, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stop, 23.11);
 void
 rte_dispatcher_stop(struct rte_dispatcher *dispatcher)
 {
@@ -677,7 +677,7 @@ evd_aggregate_stats(struct rte_dispatcher_stats *result,
 	result->ev_drop_count += part->ev_drop_count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_get, 23.11);
 void
 rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	struct rte_dispatcher_stats *stats)
@@ -694,7 +694,7 @@ rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_reset, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_reset, 23.11);
 void
 rte_dispatcher_stats_reset(struct rte_dispatcher *dispatcher)
 {
diff --git a/lib/dmadev/rte_dmadev_trace_points.c b/lib/dmadev/rte_dmadev_trace_points.c
index 1c8998fb98..f5103d27da 100644
--- a/lib/dmadev/rte_dmadev_trace_points.c
+++ b/lib/dmadev/rte_dmadev_trace_points.c
@@ -37,30 +37,30 @@ RTE_TRACE_POINT_REGISTER(rte_dma_trace_vchan_status,
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_dump,
 	lib.dmadev.dump)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_copy,
 	lib.dmadev.copy)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy_sg, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy_sg, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_copy_sg,
 	lib.dmadev.copy_sg)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_fill, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_fill, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_fill,
 	lib.dmadev.fill)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_submit, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_submit, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_submit,
 	lib.dmadev.submit)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed,
 	lib.dmadev.completed)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed_status, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed_status, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed_status,
 	lib.dmadev.completed_status)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_burst_capacity, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_burst_capacity, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_burst_capacity,
 	lib.dmadev.burst_capacity)
diff --git a/lib/eal/common/eal_common_lcore_var.c b/lib/eal/common/eal_common_lcore_var.c
index 8a7920ed0f..bcf88ac661 100644
--- a/lib/eal/common/eal_common_lcore_var.c
+++ b/lib/eal/common/eal_common_lcore_var.c
@@ -76,7 +76,7 @@ lcore_var_alloc(size_t size, size_t align)
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_var_alloc, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_var_alloc, 24.11);
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
 {
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index d7ca4c2490..1e55c75570 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1702,7 +1702,7 @@ RTE_INIT(memory_telemetry)
 
 #endif /* telemetry !RTE_EXEC_ENV_WINDOWS */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memzero_explicit, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memzero_explicit, 25.07);
 void
 rte_memzero_explicit(void *dst, size_t sz)
 {
diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index cf29cc2a3b..0b4f814951 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -110,7 +110,7 @@ rte_str_to_size(const char *str)
 	return size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_size_to_str, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_size_to_str, 25.07);
 char *
 rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit)
 {
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be1f78a68d..d5e8aaedfa 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -17,9 +17,9 @@
 #include <eal_export.h>
 #include "eal_trace.h"
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05);
 RTE_DEFINE_PER_LCORE(volatile int, trace_point_sz);
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05);
 RTE_DEFINE_PER_LCORE(void *, trace_mem);
 static RTE_DEFINE_PER_LCORE(char *, ctf_field);
 
@@ -97,7 +97,7 @@ eal_trace_fini(void)
 	eal_trace_args_free();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_is_enabled, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_is_enabled, 20.05);
 bool
 rte_trace_is_enabled(void)
 {
@@ -115,7 +115,7 @@ trace_mode_set(rte_trace_point_t *t, enum rte_trace_mode mode)
 			rte_memory_order_release);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_set, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_set, 20.05);
 void
 rte_trace_mode_set(enum rte_trace_mode mode)
 {
@@ -127,7 +127,7 @@ rte_trace_mode_set(enum rte_trace_mode mode)
 	trace.mode = mode;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_get, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_get, 20.05);
 enum
 rte_trace_mode rte_trace_mode_get(void)
 {
@@ -140,7 +140,7 @@ trace_point_is_invalid(rte_trace_point_t *t)
 	return (t == NULL) || (trace_id_get(t) >= trace.nb_trace_points);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_is_enabled, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_is_enabled, 20.05);
 bool
 rte_trace_point_is_enabled(rte_trace_point_t *t)
 {
@@ -153,7 +153,7 @@ rte_trace_point_is_enabled(rte_trace_point_t *t)
 	return (val & __RTE_TRACE_FIELD_ENABLE_MASK) != 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_enable, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_enable, 20.05);
 int
 rte_trace_point_enable(rte_trace_point_t *t)
 {
@@ -169,7 +169,7 @@ rte_trace_point_enable(rte_trace_point_t *t)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_disable, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_disable, 20.05);
 int
 rte_trace_point_disable(rte_trace_point_t *t)
 {
@@ -185,7 +185,7 @@ rte_trace_point_disable(rte_trace_point_t *t)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_pattern, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_pattern, 20.05);
 int
 rte_trace_pattern(const char *pattern, bool enable)
 {
@@ -210,7 +210,7 @@ rte_trace_pattern(const char *pattern, bool enable)
 	return rc | found;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_regexp, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_regexp, 20.05);
 int
 rte_trace_regexp(const char *regex, bool enable)
 {
@@ -240,7 +240,7 @@ rte_trace_regexp(const char *regex, bool enable)
 	return rc | found;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_lookup, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_lookup, 20.05);
 rte_trace_point_t *
 rte_trace_point_lookup(const char *name)
 {
@@ -291,7 +291,7 @@ trace_lcore_mem_dump(FILE *f)
 	rte_spinlock_unlock(&trace->lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_dump, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_dump, 20.05);
 void
 rte_trace_dump(FILE *f)
 {
@@ -327,7 +327,7 @@ thread_get_name(rte_thread_t id, char *name, size_t len)
 	RTE_SET_USED(len);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05);
 void
 __rte_trace_mem_per_thread_alloc(void)
 {
@@ -449,7 +449,7 @@ trace_mem_free(void)
 	rte_spinlock_unlock(&trace->lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05);
 void
 __rte_trace_point_emit_field(size_t sz, const char *in, const char *datatype)
 {
@@ -476,7 +476,7 @@ __rte_trace_point_emit_field(size_t sz, const char *in, const char *datatype)
 	RTE_PER_LCORE(ctf_field) = field;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05);
 int
 __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 		void (*register_fn)(void))
diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index aa60a705d1..72177e097c 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -357,7 +357,7 @@ meta_fixup(struct trace *trace, char *meta)
 	meta_fix_freq_offset(trace, meta);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_metadata_dump, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_metadata_dump, 20.05);
 int
 rte_trace_metadata_dump(FILE *f)
 {
diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/eal_common_trace_points.c
index 0903f3c639..790df83098 100644
--- a/lib/eal/common/eal_common_trace_points.c
+++ b/lib/eal/common/eal_common_trace_points.c
@@ -9,58 +9,58 @@
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_void, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_void, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_void,
 	lib.eal.generic.void)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u64, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u64, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u64,
 	lib.eal.generic.u64)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u32, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u32, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u32,
 	lib.eal.generic.u32)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u16, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u16, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u16,
 	lib.eal.generic.u16)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u8, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u8, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u8,
 	lib.eal.generic.u8)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i64, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i64, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i64,
 	lib.eal.generic.i64)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i32, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i32, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i32,
 	lib.eal.generic.i32)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i16, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i16, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i16,
 	lib.eal.generic.i16)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i8, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i8, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i8,
 	lib.eal.generic.i8)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_int, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_int, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_int,
 	lib.eal.generic.int)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_long, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_long, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_long,
 	lib.eal.generic.long)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_float, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_float, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_float,
 	lib.eal.generic.float)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_double, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_double, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_double,
 	lib.eal.generic.double)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_ptr, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_ptr, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_ptr,
 	lib.eal.generic.ptr)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_str, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_str, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_str,
 	lib.eal.generic.string)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_size_t, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_size_t, 20.11);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_size_t,
 	lib.eal.generic.size_t)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_func, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_func, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_func,
 	lib.eal.generic.func)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_blob, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_blob, 23.03);
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_blob,
 	lib.eal.generic.blob)
 
diff --git a/lib/eal/common/eal_common_trace_utils.c b/lib/eal/common/eal_common_trace_utils.c
index e1996433b7..bde8111af2 100644
--- a/lib/eal/common/eal_common_trace_utils.c
+++ b/lib/eal/common/eal_common_trace_utils.c
@@ -410,7 +410,7 @@ trace_mem_save(struct trace *trace, struct __rte_trace_header *hdr,
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_save, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_save, 20.05);
 int
 rte_trace_save(void)
 {
diff --git a/lib/eal/common/rte_bitset.c b/lib/eal/common/rte_bitset.c
index 78001b1ee8..4fe0a1b61a 100644
--- a/lib/eal/common/rte_bitset.c
+++ b/lib/eal/common/rte_bitset.c
@@ -10,7 +10,7 @@
 #include <eal_export.h>
 #include "rte_bitset.h"
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bitset_to_str, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bitset_to_str, 24.11);
 ssize_t
 rte_bitset_to_str(const uint64_t *bitset, size_t num_bits, char *buf, size_t capacity)
 {
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 36ee6a0899..297604f6b6 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -56,7 +56,7 @@ rte_free(void *addr)
 	mem_free(addr, true, false);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_free_sensitive, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_free_sensitive, 25.07);
 void
 rte_free_sensitive(void *addr)
 {
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 46db611147..1cd6914bb2 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1243,7 +1243,7 @@ vfio_set_iommu_type(int vfio_container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 24.03);
 int
 rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 8e5d840d91..16498b9382 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -191,12 +191,12 @@ rte_eal_init_alert(const char *msg)
  * until eal_common_trace.c can be compiled.
  */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05);
 RTE_DEFINE_PER_LCORE(volatile int, trace_point_sz);
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05);
 RTE_DEFINE_PER_LCORE(void *, trace_mem);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05);
 void
 __rte_trace_mem_per_thread_alloc(void)
 {
@@ -207,7 +207,7 @@ trace_mem_per_thread_free(void)
 {
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05);
 void
 __rte_trace_point_emit_field(size_t sz, const char *field,
 	const char *type)
@@ -217,7 +217,7 @@ __rte_trace_point_emit_field(size_t sz, const char *field,
 	RTE_SET_USED(type);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05);
 int
 __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 	void (*register_fn)(void))
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..444f82a723 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -26,30 +26,30 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_stop,
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_close,
 	lib.ethdev.close)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_empty, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_empty, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_rx_burst_empty,
 	lib.ethdev.rx.burst.empty)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_nonempty, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_nonempty, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_rx_burst_nonempty,
 	lib.ethdev.rx.burst.nonempty)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_tx_burst, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_tx_burst, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_tx_burst,
 	lib.ethdev.tx.burst)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_empty, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_empty, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_rx_callbacks_empty,
 	lib.ethdev.call_rx_callbacks.empty)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_nonempty, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_nonempty, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_rx_callbacks_nonempty,
 	lib.ethdev.call_rx_callbacks.nonempty)
 
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_tx_callbacks,
 	lib.ethdev.call_tx_callbacks)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_tx_queue_count, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_tx_queue_count, 24.03);
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_tx_queue_count,
 	lib.ethdev.tx_queue_count)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 3a884bdd22..780904ec09 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -839,7 +839,7 @@ eth_dev_validate_tx_queue(const struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_queue_is_valid, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_queue_is_valid, 23.07);
 int
 rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -851,7 +851,7 @@ rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 	return eth_dev_validate_rx_queue(dev, queue_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_queue_is_valid, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_queue_is_valid, 23.07);
 int
 rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -1168,7 +1168,7 @@ eth_dev_offload_names(uint64_t bitmask, char *buf, size_t size,
 	return buf;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_capability_name, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_capability_name, 21.11);
 const char *
 rte_eth_dev_capability_name(uint64_t capability)
 {
@@ -1926,7 +1926,7 @@ rte_eth_dev_set_link_down(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get, 24.11);
 int
 rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 {
@@ -1940,7 +1940,7 @@ rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 	return eth_err(port_id, dev->dev_ops->speed_lanes_get(dev, lane));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get_capability, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get_capability, 24.11);
 int
 rte_eth_speed_lanes_get_capability(uint16_t port_id,
 				   struct rte_eth_speed_lanes_capa *speed_lanes_capa,
@@ -1967,7 +1967,7 @@ rte_eth_speed_lanes_get_capability(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_set, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_set, 24.11);
 int
 rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 {
@@ -2496,7 +2496,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return eth_err(port_id, ret);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_hairpin_queue_setup, 19.11);
 int
 rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			       uint16_t nb_rx_desc,
@@ -2714,7 +2714,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_hairpin_queue_setup, 19.11);
 int
 rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 			       uint16_t nb_tx_desc,
@@ -2814,7 +2814,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_bind, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_bind, 20.11);
 int
 rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2842,7 +2842,7 @@ rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_unbind, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_unbind, 20.11);
 int
 rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2870,7 +2870,7 @@ rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_get_peer_ports, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_get_peer_ports, 20.11);
 int
 rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 			       size_t len, uint32_t direction)
@@ -3196,7 +3196,7 @@ rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_speed_to_str, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_speed_to_str, 20.11);
 const char *
 rte_eth_link_speed_to_str(uint32_t link_speed)
 {
@@ -3260,7 +3260,7 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_to_str, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_to_str, 20.11);
 int
 rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 {
@@ -3904,7 +3904,7 @@ rte_eth_xstats_reset(uint16_t port_id)
 	return rte_eth_stats_reset(port_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_set_counter, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_set_counter, 25.03);
 int
 rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 {
@@ -3934,7 +3934,7 @@ rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_query_state, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_query_state, 25.03);
 int
 rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
 {
@@ -4103,7 +4103,7 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_conf_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_conf_get, 21.11);
 int
 rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 {
@@ -4264,7 +4264,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_macaddrs_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_macaddrs_get, 21.11);
 int
 rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num)
@@ -4763,7 +4763,7 @@ validate_tx_pause_config(struct rte_eth_dev_info *dev_info, uint8_t tc_max,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get, 22.03);
 int
 rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		struct rte_eth_pfc_queue_info *pfc_queue_info)
@@ -4791,7 +4791,7 @@ rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure, 22.03);
 int
 rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf)
@@ -5105,7 +5105,7 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_rss_algo_name, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_rss_algo_name, 23.11);
 const char *
 rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 {
@@ -5120,7 +5120,7 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 	return name;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_find_rss_algo, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_find_rss_algo, 24.03);
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 {
@@ -5238,7 +5238,7 @@ rte_eth_led_off(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get_capability, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get_capability, 20.11);
 int
 rte_eth_fec_get_capability(uint16_t port_id,
 			   struct rte_eth_fec_capa *speed_fec_capa,
@@ -5266,7 +5266,7 @@ rte_eth_fec_get_capability(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get, 20.11);
 int
 rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 {
@@ -5292,7 +5292,7 @@ rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_set, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_set, 20.11);
 int
 rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa)
 {
@@ -5652,7 +5652,7 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07);
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
 {
@@ -5685,7 +5685,7 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_query, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_query, 22.07);
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh)
 {
@@ -6371,7 +6371,7 @@ rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_recycle_rx_queue_info_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_recycle_rx_queue_info_get, 23.11);
 int
 rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -6462,7 +6462,7 @@ rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_monitor_addr, 21.02)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_monitor_addr, 21.02);
 int
 rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc)
@@ -6633,7 +6633,7 @@ rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_adjust_freq, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_adjust_freq, 24.11);
 int
 rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 {
@@ -6704,7 +6704,7 @@ rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_read_clock, 19.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_read_clock, 19.08);
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 {
@@ -6760,7 +6760,7 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_reg_info_ext, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_reg_info_ext, 24.11);
 int
 rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -6867,7 +6867,7 @@ rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_info, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_info, 18.05);
 int
 rte_eth_dev_get_module_info(uint16_t port_id,
 			    struct rte_eth_dev_module_info *modinfo)
@@ -6894,7 +6894,7 @@ rte_eth_dev_get_module_info(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_eeprom, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_eeprom, 18.05);
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id,
 			      struct rte_dev_eeprom_info *info)
@@ -7009,7 +7009,7 @@ rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_hairpin_capability_get, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_hairpin_capability_get, 19.11);
 int
 rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				   struct rte_eth_hairpin_cap *cap)
@@ -7064,7 +7064,7 @@ rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_representor_info_get, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_representor_info_get, 21.05);
 int
 rte_eth_representor_info_get(uint16_t port_id,
 			     struct rte_eth_representor_info *info)
@@ -7120,7 +7120,7 @@ rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_capability_get, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_capability_get, 22.03);
 int
 rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *reassembly_capa)
@@ -7156,7 +7156,7 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_get, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_get, 22.03);
 int
 rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *conf)
@@ -7190,7 +7190,7 @@ rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_set, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_set, 22.03);
 int
 rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf)
@@ -7231,7 +7231,7 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03);
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 {
@@ -7250,7 +7250,7 @@ rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 	return eth_err(port_id, dev->dev_ops->eth_dev_priv_dump(dev, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_descriptor_dump, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_descriptor_dump, 22.11);
 int
 rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7277,7 +7277,7 @@ rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_rx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_descriptor_dump, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_descriptor_dump, 22.11);
 int
 rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7304,7 +7304,7 @@ rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_tx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes, 22.11);
 int
 rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 {
@@ -7344,7 +7344,7 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 	return j;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03);
 int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 {
 	struct rte_eth_dev *dev;
@@ -7362,7 +7362,7 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_map_aggr_tx_affinity, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_map_aggr_tx_affinity, 23.03);
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity)
 {
diff --git a/lib/ethdev/rte_ethdev_cman.c b/lib/ethdev/rte_ethdev_cman.c
index a8460e6977..413db0acd9 100644
--- a/lib/ethdev/rte_ethdev_cman.c
+++ b/lib/ethdev/rte_ethdev_cman.c
@@ -12,7 +12,7 @@
 #include "ethdev_trace.h"
 
 /* Get congestion management information for a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_info_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_info_get, 22.11);
 int
 rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 {
@@ -41,7 +41,7 @@ rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 }
 
 /* Initialize congestion management structure with default values */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_init, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_init, 22.11);
 int
 rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 {
@@ -70,7 +70,7 @@ rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 }
 
 /* Configure congestion management on a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_set, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_set, 22.11);
 int
 rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config)
 {
@@ -98,7 +98,7 @@ rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *conf
 }
 
 /* Retrieve congestion management configuration of a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_get, 22.11);
 int
 rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config)
 {
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index e443760a06..72f2450238 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11);
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11);
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -281,7 +281,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_register, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_register, 19.11);
 int
 rte_flow_dynf_metadata_register(void)
 {
@@ -465,7 +465,7 @@ rte_flow_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOSYS));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_update, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_update, 23.07);
 int
 rte_flow_actions_update(uint16_t port_id,
 			struct rte_flow *flow,
@@ -1114,7 +1114,7 @@ rte_flow_conv_name(int is_action,
 }
 
 /** Helper function to convert flow API objects. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_conv, 18.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_conv, 18.11);
 int
 rte_flow_conv(enum rte_flow_conv_op op,
 	      void *dst,
@@ -1241,7 +1241,7 @@ rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dev_dump, 20.02)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dev_dump, 20.02);
 int
 rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 			FILE *file, struct rte_flow_error *error)
@@ -1263,7 +1263,7 @@ rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 				  NULL, rte_strerror(ENOSYS));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_aged_flows, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_aged_flows, 20.05);
 int
 rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 		    uint32_t nb_contexts, struct rte_flow_error *error)
@@ -1289,7 +1289,7 @@ rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_q_aged_flows, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_q_aged_flows, 22.11);
 int
 rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 			  uint32_t nb_contexts, struct rte_flow_error *error)
@@ -1317,7 +1317,7 @@ rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_create, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_create, 21.05);
 struct rte_flow_action_handle *
 rte_flow_action_handle_create(uint16_t port_id,
 			      const struct rte_flow_indir_action_conf *conf,
@@ -1345,7 +1345,7 @@ rte_flow_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_destroy, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_destroy, 21.05);
 int
 rte_flow_action_handle_destroy(uint16_t port_id,
 			       struct rte_flow_action_handle *handle,
@@ -1369,7 +1369,7 @@ rte_flow_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_update, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_update, 21.05);
 int
 rte_flow_action_handle_update(uint16_t port_id,
 			      struct rte_flow_action_handle *handle,
@@ -1394,7 +1394,7 @@ rte_flow_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query, 21.05);
 int
 rte_flow_action_handle_query(uint16_t port_id,
 			     const struct rte_flow_action_handle *handle,
@@ -1419,7 +1419,7 @@ rte_flow_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_decap_set, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_decap_set, 20.11);
 int
 rte_flow_tunnel_decap_set(uint16_t port_id,
 			  struct rte_flow_tunnel *tunnel,
@@ -1449,7 +1449,7 @@ rte_flow_tunnel_decap_set(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_match, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_match, 20.11);
 int
 rte_flow_tunnel_match(uint16_t port_id,
 		      struct rte_flow_tunnel *tunnel,
@@ -1479,7 +1479,7 @@ rte_flow_tunnel_match(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_restore_info, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_restore_info, 20.11);
 int
 rte_flow_get_restore_info(uint16_t port_id,
 			  struct rte_mbuf *m,
@@ -1514,7 +1514,7 @@ static struct {
 	.desc = { .name = "RTE_MBUF_F_RX_RESTORE_INFO", },
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_restore_info_dynflag, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_restore_info_dynflag, 23.07);
 uint64_t
 rte_flow_restore_info_dynflag(void)
 {
@@ -1535,7 +1535,7 @@ rte_flow_restore_info_dynflag_register(void)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_action_decap_release, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_action_decap_release, 20.11);
 int
 rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				     struct rte_flow_action *actions,
@@ -1565,7 +1565,7 @@ rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_item_release, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_item_release, 20.11);
 int
 rte_flow_tunnel_item_release(uint16_t port_id,
 			     struct rte_flow_item *items,
@@ -1621,7 +1621,7 @@ rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_create, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_create, 21.11);
 struct rte_flow_item_flex_handle *
 rte_flow_flex_item_create(uint16_t port_id,
 			  const struct rte_flow_item_flex_conf *conf,
@@ -1648,7 +1648,7 @@ rte_flow_flex_item_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_release, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_release, 21.11);
 int
 rte_flow_flex_item_release(uint16_t port_id,
 			   const struct rte_flow_item_flex_handle *handle,
@@ -1670,7 +1670,7 @@ rte_flow_flex_item_release(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_info_get, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_info_get, 22.03);
 int
 rte_flow_info_get(uint16_t port_id,
 		  struct rte_flow_port_info *port_info,
@@ -1707,7 +1707,7 @@ rte_flow_info_get(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_configure, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_configure, 22.03);
 int
 rte_flow_configure(uint16_t port_id,
 		   const struct rte_flow_port_attr *port_attr,
@@ -1766,7 +1766,7 @@ rte_flow_configure(uint16_t port_id,
 				  NULL, rte_strerror(EINVAL));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_create, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_create, 22.03);
 struct rte_flow_pattern_template *
 rte_flow_pattern_template_create(uint16_t port_id,
 		const struct rte_flow_pattern_template_attr *template_attr,
@@ -1823,7 +1823,7 @@ rte_flow_pattern_template_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_destroy, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_destroy, 22.03);
 int
 rte_flow_pattern_template_destroy(uint16_t port_id,
 		struct rte_flow_pattern_template *pattern_template,
@@ -1854,7 +1854,7 @@ rte_flow_pattern_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_create, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_create, 22.03);
 struct rte_flow_actions_template *
 rte_flow_actions_template_create(uint16_t port_id,
 			const struct rte_flow_actions_template_attr *template_attr,
@@ -1921,7 +1921,7 @@ rte_flow_actions_template_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_destroy, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_destroy, 22.03);
 int
 rte_flow_actions_template_destroy(uint16_t port_id,
 			struct rte_flow_actions_template *actions_template,
@@ -1952,7 +1952,7 @@ rte_flow_actions_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_create, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_create, 22.03);
 struct rte_flow_template_table *
 rte_flow_template_table_create(uint16_t port_id,
 			const struct rte_flow_template_table_attr *table_attr,
@@ -2026,7 +2026,7 @@ rte_flow_template_table_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_destroy, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_destroy, 22.03);
 int
 rte_flow_template_table_destroy(uint16_t port_id,
 				struct rte_flow_template_table *template_table,
@@ -2057,7 +2057,7 @@ rte_flow_template_table_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_group_set_miss_actions, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_group_set_miss_actions, 23.11);
 int
 rte_flow_group_set_miss_actions(uint16_t port_id,
 				uint32_t group_id,
@@ -2080,7 +2080,7 @@ rte_flow_group_set_miss_actions(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create, 22.03);
 struct rte_flow *
 rte_flow_async_create(uint16_t port_id,
 		      uint32_t queue_id,
@@ -2122,7 +2122,7 @@ rte_flow_async_create(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index, 23.03);
 struct rte_flow *
 rte_flow_async_create_by_index(uint16_t port_id,
 			       uint32_t queue_id,
@@ -2161,7 +2161,7 @@ rte_flow_async_create_by_index(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index_with_pattern, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index_with_pattern, 24.11);
 struct rte_flow *
 rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 					    uint32_t queue_id,
@@ -2206,7 +2206,7 @@ rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_destroy, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_destroy, 22.03);
 int
 rte_flow_async_destroy(uint16_t port_id,
 		       uint32_t queue_id,
@@ -2237,7 +2237,7 @@ rte_flow_async_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_actions_update, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_actions_update, 23.07);
 int
 rte_flow_async_actions_update(uint16_t port_id,
 			      uint32_t queue_id,
@@ -2272,7 +2272,7 @@ rte_flow_async_actions_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_push, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_push, 22.03);
 int
 rte_flow_push(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2297,7 +2297,7 @@ rte_flow_push(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pull, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pull, 22.03);
 int
 rte_flow_pull(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2324,7 +2324,7 @@ rte_flow_pull(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_create, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_create, 22.03);
 struct rte_flow_action_handle *
 rte_flow_async_action_handle_create(uint16_t port_id,
 		uint32_t queue_id,
@@ -2361,7 +2361,7 @@ rte_flow_async_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_destroy, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_destroy, 22.03);
 int
 rte_flow_async_action_handle_destroy(uint16_t port_id,
 		uint32_t queue_id,
@@ -2391,7 +2391,7 @@ rte_flow_async_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_update, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_update, 22.03);
 int
 rte_flow_async_action_handle_update(uint16_t port_id,
 		uint32_t queue_id,
@@ -2423,7 +2423,7 @@ rte_flow_async_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query, 22.11);
 int
 rte_flow_async_action_handle_query(uint16_t port_id,
 		uint32_t queue_id,
@@ -2455,7 +2455,7 @@ rte_flow_async_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query_update, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query_update, 23.03);
 int
 rte_flow_action_handle_query_update(uint16_t port_id,
 				    struct rte_flow_action_handle *handle,
@@ -2481,7 +2481,7 @@ rte_flow_action_handle_query_update(uint16_t port_id,
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query_update, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query_update, 23.03);
 int
 rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 					  const struct rte_flow_op_attr *attr,
@@ -2508,7 +2508,7 @@ rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 								  user_data, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_create, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_create, 23.07);
 struct rte_flow_action_list_handle *
 rte_flow_action_list_handle_create(uint16_t port_id,
 				   const
@@ -2536,7 +2536,7 @@ rte_flow_action_list_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_destroy, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_destroy, 23.07);
 int
 rte_flow_action_list_handle_destroy(uint16_t port_id,
 				    struct rte_flow_action_list_handle *handle,
@@ -2559,7 +2559,7 @@ rte_flow_action_list_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_create, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_create, 23.07);
 struct rte_flow_action_list_handle *
 rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 					 const struct rte_flow_op_attr *attr,
@@ -2596,7 +2596,7 @@ rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_destroy, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_destroy, 23.07);
 int
 rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 				 const struct rte_flow_op_attr *op_attr,
@@ -2624,7 +2624,7 @@ rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_query_update, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_query_update, 23.07);
 int
 rte_flow_action_list_handle_query_update(uint16_t port_id,
 			 const struct rte_flow_action_list_handle *handle,
@@ -2651,7 +2651,7 @@ rte_flow_action_list_handle_query_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_query_update, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_query_update, 23.07);
 int
 rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_id,
 			 const struct rte_flow_op_attr *attr,
@@ -2686,7 +2686,7 @@ rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_table_hash, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_table_hash, 23.11);
 int
 rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table *table,
 			 const struct rte_flow_item pattern[], uint8_t pattern_template_index,
@@ -2708,7 +2708,7 @@ rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_encap_hash, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_encap_hash, 24.03);
 int
 rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 			 enum rte_flow_encap_hash_field dest_field, uint8_t hash_len,
@@ -2738,7 +2738,7 @@ rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resizable, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resizable, 24.03);
 bool
 rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 				  const struct rte_flow_template_table_attr *tbl_attr)
@@ -2747,7 +2747,7 @@ rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 		RTE_FLOW_TABLE_SPECIALIZE_RESIZABLE) != 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize, 24.03);
 int
 rte_flow_template_table_resize(uint16_t port_id,
 			       struct rte_flow_template_table *table,
@@ -2771,7 +2771,7 @@ rte_flow_template_table_resize(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_update_resized, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_update_resized, 24.03);
 int
 rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 			      const struct rte_flow_op_attr *attr,
@@ -2796,7 +2796,7 @@ rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize_complete, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize_complete, 24.03);
 int
 rte_flow_template_table_resize_complete(uint16_t port_id,
 					struct rte_flow_template_table *table,
diff --git a/lib/ethdev/rte_mtr.c b/lib/ethdev/rte_mtr.c
index c6f0698ed3..e4bd02c73b 100644
--- a/lib/ethdev/rte_mtr.c
+++ b/lib/ethdev/rte_mtr.c
@@ -78,7 +78,7 @@ __extension__ ({					\
 })
 
 /* MTR capabilities get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_capabilities_get, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_capabilities_get, 17.11);
 int
 rte_mtr_capabilities_get(uint16_t port_id,
 	struct rte_mtr_capabilities *cap,
@@ -95,7 +95,7 @@ rte_mtr_capabilities_get(uint16_t port_id,
 }
 
 /* MTR meter profile add */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_add, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_add, 17.11);
 int
 rte_mtr_meter_profile_add(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -114,7 +114,7 @@ rte_mtr_meter_profile_add(uint16_t port_id,
 }
 
 /** MTR meter profile delete */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_delete, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_delete, 17.11);
 int
 rte_mtr_meter_profile_delete(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -131,7 +131,7 @@ rte_mtr_meter_profile_delete(uint16_t port_id,
 }
 
 /** MTR meter profile get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_get, 22.11);
 struct rte_flow_meter_profile *
 rte_mtr_meter_profile_get(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -148,7 +148,7 @@ rte_mtr_meter_profile_get(uint16_t port_id,
 }
 
 /* MTR meter policy validate */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_validate, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_validate, 21.05);
 int
 rte_mtr_meter_policy_validate(uint16_t port_id,
 	struct rte_mtr_meter_policy_params *policy,
@@ -165,7 +165,7 @@ rte_mtr_meter_policy_validate(uint16_t port_id,
 }
 
 /* MTR meter policy add */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_add, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_add, 21.05);
 int
 rte_mtr_meter_policy_add(uint16_t port_id,
 	uint32_t policy_id,
@@ -183,7 +183,7 @@ rte_mtr_meter_policy_add(uint16_t port_id,
 }
 
 /** MTR meter policy delete */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_delete, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_delete, 21.05);
 int
 rte_mtr_meter_policy_delete(uint16_t port_id,
 	uint32_t policy_id,
@@ -200,7 +200,7 @@ rte_mtr_meter_policy_delete(uint16_t port_id,
 }
 
 /** MTR meter policy get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_get, 22.11);
 struct rte_flow_meter_policy *
 rte_mtr_meter_policy_get(uint16_t port_id,
 	uint32_t policy_id,
@@ -217,7 +217,7 @@ rte_mtr_meter_policy_get(uint16_t port_id,
 }
 
 /** MTR object create */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_create, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_create, 17.11);
 int
 rte_mtr_create(uint16_t port_id,
 	uint32_t mtr_id,
@@ -236,7 +236,7 @@ rte_mtr_create(uint16_t port_id,
 }
 
 /** MTR object destroy */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_destroy, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_destroy, 17.11);
 int
 rte_mtr_destroy(uint16_t port_id,
 	uint32_t mtr_id,
@@ -253,7 +253,7 @@ rte_mtr_destroy(uint16_t port_id,
 }
 
 /** MTR object meter enable */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_enable, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_enable, 17.11);
 int
 rte_mtr_meter_enable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -270,7 +270,7 @@ rte_mtr_meter_enable(uint16_t port_id,
 }
 
 /** MTR object meter disable */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_disable, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_disable, 17.11);
 int
 rte_mtr_meter_disable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -287,7 +287,7 @@ rte_mtr_meter_disable(uint16_t port_id,
 }
 
 /** MTR object meter profile update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_update, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_update, 17.11);
 int
 rte_mtr_meter_profile_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -305,7 +305,7 @@ rte_mtr_meter_profile_update(uint16_t port_id,
 }
 
 /** MTR object meter policy update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_update, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_update, 21.05);
 int
 rte_mtr_meter_policy_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -323,7 +323,7 @@ rte_mtr_meter_policy_update(uint16_t port_id,
 }
 
 /** MTR object meter DSCP table update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_dscp_table_update, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_dscp_table_update, 17.11);
 int
 rte_mtr_meter_dscp_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -341,7 +341,7 @@ rte_mtr_meter_dscp_table_update(uint16_t port_id,
 }
 
 /** MTR object meter VLAN table update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_vlan_table_update, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_vlan_table_update, 22.07);
 int
 rte_mtr_meter_vlan_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -359,7 +359,7 @@ rte_mtr_meter_vlan_table_update(uint16_t port_id,
 }
 
 /** Set the input color protocol on MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_set, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_set, 22.07);
 int
 rte_mtr_color_in_protocol_set(uint16_t port_id,
 	uint32_t mtr_id,
@@ -378,7 +378,7 @@ rte_mtr_color_in_protocol_set(uint16_t port_id,
 }
 
 /** Get input color protocols of MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_get, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_get, 22.07);
 int
 rte_mtr_color_in_protocol_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -396,7 +396,7 @@ rte_mtr_color_in_protocol_get(uint16_t port_id,
 }
 
 /** Get input color protocol priority of MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_priority_get, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_priority_get, 22.07);
 int
 rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -415,7 +415,7 @@ rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 }
 
 /** MTR object enabled stats update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_update, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_update, 17.11);
 int
 rte_mtr_stats_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -433,7 +433,7 @@ rte_mtr_stats_update(uint16_t port_id,
 }
 
 /** MTR object stats read */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_read, 17.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_read, 17.11);
 int
 rte_mtr_stats_read(uint16_t port_id,
 	uint32_t mtr_id,
diff --git a/lib/ethdev/rte_tm.c b/lib/ethdev/rte_tm.c
index f265e8cffa..cb858deff9 100644
--- a/lib/ethdev/rte_tm.c
+++ b/lib/ethdev/rte_tm.c
@@ -316,7 +316,7 @@ int rte_tm_node_add(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tm_node_query, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tm_node_query, 24.11);
 int rte_tm_node_query(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t *parent_node_id,
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index a1301606d6..5cfd23221a 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -50,15 +50,15 @@ RTE_EXPORT_SYMBOL(__rte_eventdev_trace_maintain);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_maintain,
 	lib.eventdev.maintain)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_profile_switch, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_profile_switch, 23.11);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_profile_switch,
 	lib.eventdev.port.profile.switch)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule_modify, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule_modify, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_preschedule_modify,
 	lib.eventdev.port.preschedule.modify)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule, 24.11);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_preschedule,
 	lib.eventdev.port.preschedule)
 
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index c579e55bf7..aadf992570 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -1430,7 +1430,7 @@ rte_event_crypto_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_init, 23.03);
 int
 rte_event_crypto_adapter_runtime_params_init(
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1469,7 +1469,7 @@ crypto_adapter_cap_check(struct event_crypto_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_set, 23.03);
 int
 rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1502,7 +1502,7 @@ rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_get, 23.03);
 int
 rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index cb799f3410..b8b1fa88d5 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -341,7 +341,7 @@ edma_default_config_cb(uint8_t id, uint8_t evdev_id, struct rte_event_dma_adapte
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create_ext, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create_ext, 23.11);
 int
 rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 				 rte_event_dma_adapter_conf_cb conf_cb,
@@ -435,7 +435,7 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create, 23.11);
 int
 rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port_conf *port_config,
 			    enum rte_event_dma_adapter_mode mode)
@@ -460,7 +460,7 @@ rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_free, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_free, 23.11);
 int
 rte_event_dma_adapter_free(uint8_t id)
 {
@@ -481,7 +481,7 @@ rte_event_dma_adapter_free(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_event_port_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_event_port_get, 23.11);
 int
 rte_event_dma_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -988,7 +988,7 @@ edma_add_vchan(struct event_dma_adapter *adapter, int16_t dma_dev_id, uint16_t v
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_add, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_add, 23.11);
 int
 rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 				const struct rte_event *event)
@@ -1103,7 +1103,7 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_del, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_del, 23.11);
 int
 rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 {
@@ -1170,7 +1170,7 @@ rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_service_id_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_service_id_get, 23.11);
 int
 rte_event_dma_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1230,7 +1230,7 @@ edma_adapter_ctrl(uint8_t id, int start)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_start, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_start, 23.11);
 int
 rte_event_dma_adapter_start(uint8_t id)
 {
@@ -1245,7 +1245,7 @@ rte_event_dma_adapter_start(uint8_t id)
 	return edma_adapter_ctrl(id, 1);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stop, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stop, 23.11);
 int
 rte_event_dma_adapter_stop(uint8_t id)
 {
@@ -1254,7 +1254,7 @@ rte_event_dma_adapter_stop(uint8_t id)
 
 #define DEFAULT_MAX_NB 128
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_init, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_init, 23.11);
 int
 rte_event_dma_adapter_runtime_params_init(struct rte_event_dma_adapter_runtime_params *params)
 {
@@ -1290,7 +1290,7 @@ dma_adapter_cap_check(struct event_dma_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_set, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_set, 23.11);
 int
 rte_event_dma_adapter_runtime_params_set(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1320,7 +1320,7 @@ rte_event_dma_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_get, 23.11);
 int
 rte_event_dma_adapter_runtime_params_get(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1348,7 +1348,7 @@ rte_event_dma_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_get, 23.11);
 int
 rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *stats)
 {
@@ -1394,7 +1394,7 @@ rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_reset, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_reset, 23.11);
 int
 rte_event_dma_adapter_stats_reset(uint8_t id)
 {
@@ -1427,7 +1427,7 @@ rte_event_dma_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_enqueue, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_enqueue, 23.11);
 uint16_t
 rte_event_dma_adapter_enqueue(uint8_t dev_id, uint8_t port_id, struct rte_event ev[],
 			      uint16_t nb_events)
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index f33811c60e..cffc28b71d 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2567,7 +2567,7 @@ rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_create_ext_with_params, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_create_ext_with_params, 23.11);
 int
 rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 			rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -2797,7 +2797,7 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_queues_add, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_queues_add, 25.03);
 int
 rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32_t rx_queue_id[],
 				    const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
@@ -3684,7 +3684,7 @@ rxa_caps_check(struct event_eth_rx_adapter *rxa)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_init, 23.03);
 int
 rte_event_eth_rx_adapter_runtime_params_init(
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3698,7 +3698,7 @@ rte_event_eth_rx_adapter_runtime_params_init(
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_set, 23.03);
 int
 rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3727,7 +3727,7 @@ rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_get, 23.03);
 int
 rte_event_eth_rx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index cc4d0c61a5..bcc573c155 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -1306,7 +1306,7 @@ rte_event_eth_tx_adapter_stats_reset(uint8_t id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_init, 23.03);
 int
 rte_event_eth_tx_adapter_runtime_params_init(
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1333,7 +1333,7 @@ txa_caps_check(struct txa_service_data *txa)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_set, 23.03);
 int
 rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1365,7 +1365,7 @@ rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_get, 23.03);
 int
 rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index aa1359b7e5..1365a50d33 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -490,7 +490,7 @@ rte_event_timer_adapter_stats_reset(struct rte_event_timer_adapter *adapter)
 	return adapter->ops->stats_reset(adapter);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_timer_remaining_ticks_get, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_timer_remaining_ticks_get, 23.03);
 int
 rte_event_timer_remaining_ticks_get(
 			const struct rte_event_timer_adapter *adapter,
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index ad764e2882..24a7a063ce 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -151,14 +151,14 @@ default_port_conf_cb(uint8_t event_dev_id, uint8_t *event_port_id, void *conf_ar
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create, 25.07);
 struct rte_event_vector_adapter *
 rte_event_vector_adapter_create(const struct rte_event_vector_adapter_conf *conf)
 {
 	return rte_event_vector_adapter_create_ext(conf, default_port_conf_cb, NULL);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create_ext, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_create_ext, 25.07);
 struct rte_event_vector_adapter *
 rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *conf,
 				    rte_event_vector_adapter_port_conf_cb_t conf_cb, void *conf_arg)
@@ -304,7 +304,7 @@ rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_lookup, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_lookup, 25.07);
 struct rte_event_vector_adapter *
 rte_event_vector_adapter_lookup(uint32_t adapter_id)
 {
@@ -372,7 +372,7 @@ rte_event_vector_adapter_lookup(uint32_t adapter_id)
 	return adapter;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_service_id_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_service_id_get, 25.07);
 int
 rte_event_vector_adapter_service_id_get(struct rte_event_vector_adapter *adapter,
 					uint32_t *service_id)
@@ -385,7 +385,7 @@ rte_event_vector_adapter_service_id_get(struct rte_event_vector_adapter *adapter
 	return adapter->data->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_destroy, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_destroy, 25.07);
 int
 rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
 {
@@ -414,7 +414,7 @@ rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_info_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_info_get, 25.07);
 int
 rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event_vector_adapter_info *info)
 {
@@ -429,7 +429,7 @@ rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event_vector_
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_conf_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_conf_get, 25.07);
 int
 rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapter,
 				  struct rte_event_vector_adapter_conf *conf)
@@ -441,7 +441,7 @@ rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapter,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_remaining, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_remaining, 25.07);
 uint8_t
 rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_queue_id)
 {
@@ -461,7 +461,7 @@ rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_queue_id)
 	return remaining;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_get, 25.07);
 int
 rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adapter,
 				   struct rte_event_vector_adapter_stats *stats)
@@ -476,7 +476,7 @@ rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adapter,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_reset, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_stats_reset, 25.07);
 int
 rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *adapter)
 {
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 742d9d5ec5..6ef434228d 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -234,7 +234,7 @@ rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		: 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_caps_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_caps_get, 23.11);
 int
 rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *caps)
 {
@@ -257,7 +257,7 @@ rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *cap
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_caps_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_vector_adapter_caps_get, 25.07);
 int
 rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 {
@@ -1031,7 +1031,7 @@ rte_event_port_link(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_links_set(dev_id, port_id, queues, priorities, nb_links, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_set, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_set, 23.11);
 int
 rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t queues[],
 				 const uint8_t priorities[], uint16_t nb_links, uint8_t profile_id)
@@ -1122,7 +1122,7 @@ rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_unlink(dev_id, port_id, queues, nb_unlinks, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_unlink, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_unlink, 23.11);
 int
 rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 			      uint16_t nb_unlinks, uint8_t profile_id)
@@ -1267,7 +1267,7 @@ rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
 	return count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_get, 23.11);
 int
 rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 				 uint8_t priorities[], uint8_t profile_id)
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 76af3b880d..065ac7cd63 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -350,7 +350,7 @@ rte_fib_select_lookup(struct rte_fib *fib,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_rcu_qsbr_add, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_rcu_qsbr_add, 24.11);
 int
 rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 {
diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 0473d9ffb3..5c16edda06 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -50,7 +50,7 @@ struct rte_gpu_callback {
 static rte_rwlock_t gpu_callback_lock = RTE_RWLOCK_INITIALIZER;
 static void gpu_free_callbacks(struct rte_gpu *dev);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_init, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_init, 21.11);
 int
 rte_gpu_init(size_t dev_max)
 {
@@ -78,14 +78,14 @@ rte_gpu_init(size_t dev_max)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_count_avail, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_count_avail, 21.11);
 uint16_t
 rte_gpu_count_avail(void)
 {
 	return gpu_count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_is_valid, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_is_valid, 21.11);
 bool
 rte_gpu_is_valid(int16_t dev_id)
 {
@@ -103,7 +103,7 @@ gpu_match_parent(int16_t dev_id, int16_t parent)
 	return gpus[dev_id].mpshared->info.parent == parent;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_find_next, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_find_next, 21.11);
 int16_t
 rte_gpu_find_next(int16_t dev_id, int16_t parent)
 {
@@ -294,7 +294,7 @@ rte_gpu_attach(const char *name)
 	return dev;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_add_child, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_add_child, 21.11);
 int16_t
 rte_gpu_add_child(const char *name, int16_t parent, uint64_t child_context)
 {
@@ -358,7 +358,7 @@ rte_gpu_release(struct rte_gpu *dev)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_close, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_close, 21.11);
 int
 rte_gpu_close(int16_t dev_id)
 {
@@ -385,7 +385,7 @@ rte_gpu_close(int16_t dev_id)
 	return firsterr;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_register, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_register, 21.11);
 int
 rte_gpu_callback_register(int16_t dev_id, enum rte_gpu_event event,
 		rte_gpu_callback_t *function, void *user_data)
@@ -445,7 +445,7 @@ rte_gpu_callback_register(int16_t dev_id, enum rte_gpu_event event,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_unregister, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_unregister, 21.11);
 int
 rte_gpu_callback_unregister(int16_t dev_id, enum rte_gpu_event event,
 		rte_gpu_callback_t *function, void *user_data)
@@ -522,7 +522,7 @@ rte_gpu_notify(struct rte_gpu *dev, enum rte_gpu_event event)
 	rte_rwlock_read_unlock(&gpu_callback_lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_info_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_info_get, 21.11);
 int
 rte_gpu_info_get(int16_t dev_id, struct rte_gpu_info *info)
 {
@@ -547,7 +547,7 @@ rte_gpu_info_get(int16_t dev_id, struct rte_gpu_info *info)
 	return GPU_DRV_RET(dev->ops.dev_info_get(dev, info));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_alloc, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_alloc, 21.11);
 void *
 rte_gpu_mem_alloc(int16_t dev_id, size_t size, unsigned int align)
 {
@@ -592,7 +592,7 @@ rte_gpu_mem_alloc(int16_t dev_id, size_t size, unsigned int align)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_free, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_free, 21.11);
 int
 rte_gpu_mem_free(int16_t dev_id, void *ptr)
 {
@@ -616,7 +616,7 @@ rte_gpu_mem_free(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_free(dev, ptr));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_register, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_register, 21.11);
 int
 rte_gpu_mem_register(int16_t dev_id, size_t size, void *ptr)
 {
@@ -641,7 +641,7 @@ rte_gpu_mem_register(int16_t dev_id, size_t size, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_register(dev, size, ptr));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_unregister, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_unregister, 21.11);
 int
 rte_gpu_mem_unregister(int16_t dev_id, void *ptr)
 {
@@ -665,7 +665,7 @@ rte_gpu_mem_unregister(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_unregister(dev, ptr));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_map, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_map, 21.11);
 void *
 rte_gpu_mem_cpu_map(int16_t dev_id, size_t size, void *ptr)
 {
@@ -704,7 +704,7 @@ rte_gpu_mem_cpu_map(int16_t dev_id, size_t size, void *ptr)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_unmap, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_unmap, 21.11);
 int
 rte_gpu_mem_cpu_unmap(int16_t dev_id, void *ptr)
 {
@@ -728,7 +728,7 @@ rte_gpu_mem_cpu_unmap(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_cpu_unmap(dev, ptr));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_wmb, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_wmb, 21.11);
 int
 rte_gpu_wmb(int16_t dev_id)
 {
@@ -748,7 +748,7 @@ rte_gpu_wmb(int16_t dev_id)
 	return GPU_DRV_RET(dev->ops.wmb(dev));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_flag, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_flag, 21.11);
 int
 rte_gpu_comm_create_flag(uint16_t dev_id, struct rte_gpu_comm_flag *devflag,
 		enum rte_gpu_comm_flag_type mtype)
@@ -785,7 +785,7 @@ rte_gpu_comm_create_flag(uint16_t dev_id, struct rte_gpu_comm_flag *devflag,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_flag, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_flag, 21.11);
 int
 rte_gpu_comm_destroy_flag(struct rte_gpu_comm_flag *devflag)
 {
@@ -807,7 +807,7 @@ rte_gpu_comm_destroy_flag(struct rte_gpu_comm_flag *devflag)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_flag, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_flag, 21.11);
 int
 rte_gpu_comm_set_flag(struct rte_gpu_comm_flag *devflag, uint32_t val)
 {
@@ -826,7 +826,7 @@ rte_gpu_comm_set_flag(struct rte_gpu_comm_flag *devflag, uint32_t val)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_flag_value, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_flag_value, 21.11);
 int
 rte_gpu_comm_get_flag_value(struct rte_gpu_comm_flag *devflag, uint32_t *val)
 {
@@ -844,7 +844,7 @@ rte_gpu_comm_get_flag_value(struct rte_gpu_comm_flag *devflag, uint32_t *val)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_list, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_list, 21.11);
 struct rte_gpu_comm_list *
 rte_gpu_comm_create_list(uint16_t dev_id,
 		uint32_t num_comm_items)
@@ -968,7 +968,7 @@ rte_gpu_comm_create_list(uint16_t dev_id,
 	return comm_list;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_list, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_list, 21.11);
 int
 rte_gpu_comm_destroy_list(struct rte_gpu_comm_list *comm_list,
 		uint32_t num_comm_items)
@@ -1014,7 +1014,7 @@ rte_gpu_comm_destroy_list(struct rte_gpu_comm_list *comm_list,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_populate_list_pkts, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_populate_list_pkts, 21.11);
 int
 rte_gpu_comm_populate_list_pkts(struct rte_gpu_comm_list *comm_list_item,
 		struct rte_mbuf **mbufs, uint32_t num_mbufs)
@@ -1053,7 +1053,7 @@ rte_gpu_comm_populate_list_pkts(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_status, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_status, 21.11);
 int
 rte_gpu_comm_set_status(struct rte_gpu_comm_list *comm_list_item,
 		enum rte_gpu_comm_list_status status)
@@ -1068,7 +1068,7 @@ rte_gpu_comm_set_status(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_status, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_status, 21.11);
 int
 rte_gpu_comm_get_status(struct rte_gpu_comm_list *comm_list_item,
 		enum rte_gpu_comm_list_status *status)
@@ -1083,7 +1083,7 @@ rte_gpu_comm_get_status(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_cleanup_list, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_cleanup_list, 21.11);
 int
 rte_gpu_comm_cleanup_list(struct rte_gpu_comm_list *comm_list_item)
 {
diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
index 823aad3e73..c7641ea619 100644
--- a/lib/graph/graph_feature_arc.c
+++ b/lib/graph/graph_feature_arc.c
@@ -53,7 +53,7 @@ static struct rte_mbuf_dynfield rte_graph_feature_arc_mbuf_desc = {
 	.align = alignof(struct rte_graph_feature_arc_mbuf_dynfields),
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_main, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_main, 25.07);
 rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
 
 /* global feature arc list */
@@ -1062,7 +1062,7 @@ refill_fastpath_data(struct rte_graph_feature_arc *arc, uint32_t feature_bit,
 }
 
 /* feature arc initialization, public API */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07);
 int
 rte_graph_feature_arc_init(uint16_t num_feature_arcs)
 {
@@ -1193,7 +1193,7 @@ rte_graph_feature_arc_init(uint16_t num_feature_arcs)
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_create, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_create, 25.07);
 int
 rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
 			     rte_graph_feature_arc_t *_arc)
@@ -1335,7 +1335,7 @@ rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_add, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_add, 25.07);
 int
 rte_graph_feature_add(struct rte_graph_feature_register *freg)
 {
@@ -1583,7 +1583,7 @@ rte_graph_feature_add(struct rte_graph_feature_register *freg)
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_lookup, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_lookup, 25.07);
 int
 rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char *feature_name,
 			 rte_graph_feature_t *feat)
@@ -1603,7 +1603,7 @@ rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char *feature_name,
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_enable, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_enable, 25.07);
 int
 rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t index,
 			 const char *feature_name, uint16_t app_cookie,
@@ -1678,7 +1678,7 @@ rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t index,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_disable, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_disable, 25.07);
 int
 rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t index, const char *feature_name,
 			  struct rte_rcu_qsbr *qsbr)
@@ -1796,7 +1796,7 @@ rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t index, const ch
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy, 25.07);
 int
 rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
 {
@@ -1861,7 +1861,7 @@ rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_cleanup, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_cleanup, 25.07);
 int
 rte_graph_feature_arc_cleanup(void)
 {
@@ -1886,7 +1886,7 @@ rte_graph_feature_arc_cleanup(void)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_lookup_by_name, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_lookup_by_name, 25.07);
 int
 rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature_arc_t *_arc)
 {
@@ -1924,7 +1924,7 @@ rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature_arc
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_enabled_features, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_enabled_features, 25.07);
 uint32_t
 rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t _arc)
 {
@@ -1938,7 +1938,7 @@ rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t _arc)
 	return arc->runtime_enabled_features;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_features, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_features, 25.07);
 uint32_t
 rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
 {
@@ -1957,7 +1957,7 @@ rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
 	return count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_name, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_name, 25.07);
 char *
 rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t _arc, rte_graph_feature_t feat)
 {
@@ -1978,7 +1978,7 @@ rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t _arc, rte_graph_fe
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_node, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_node, 25.07);
 int
 rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc, rte_graph_feature_t feat,
 				      rte_node_t *node)
@@ -2005,7 +2005,7 @@ rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc, rte_graph_fe
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register, 25.07);
 void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_register *reg,
 				      const char *caller_name, int lineno)
 {
@@ -2015,7 +2015,7 @@ void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_register *reg
 	STAILQ_INSERT_TAIL(&feature_arc_list, reg, next_arc);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07);
 void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
 				  const char *caller_name, int lineno)
 {
@@ -2026,7 +2026,7 @@ void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
 	STAILQ_INSERT_TAIL(&feature_list, reg, next_feature);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_names_get, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_names_get, 25.07);
 uint32_t
 rte_graph_feature_arc_names_get(char *arc_names[])
 {
diff --git a/lib/graph/node.c b/lib/graph/node.c
index ee36545b7e..76953a6e75 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -517,7 +517,7 @@ node_override_process_func(rte_node_t id, rte_node_process_t process)
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_free, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_free, 25.07);
 int
 rte_node_free(rte_node_t id)
 {
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 94db7d8fa4..f565874e28 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -1645,7 +1645,7 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_rcu_qsbr_dq_reclaim, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_rcu_qsbr_dq_reclaim, 24.07);
 int rte_hash_rcu_qsbr_dq_reclaim(struct rte_hash *h, unsigned int *freed, unsigned int *pending,
 				 unsigned int *available)
 {
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index a033196341..9dba2de0c4 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -835,7 +835,7 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_thash_gen_key, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_thash_gen_key, 24.11);
 int
 rte_thash_gen_key(uint8_t *key, size_t key_len, size_t reta_sz_log,
 	uint32_t entropy_start, size_t entropy_sz)
diff --git a/lib/mempool/mempool_trace_points.c b/lib/mempool/mempool_trace_points.c
index ec465780f4..fa15c55994 100644
--- a/lib/mempool/mempool_trace_points.c
+++ b/lib/mempool/mempool_trace_points.c
@@ -7,35 +7,35 @@
 
 #include "mempool_trace.h"
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_bulk, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_bulk, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_dequeue_bulk,
 	lib.mempool.ops.deq.bulk)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_contig_blocks, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_contig_blocks, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_dequeue_contig_blocks,
 	lib.mempool.ops.deq.contig)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_enqueue_bulk, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_enqueue_bulk, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_enqueue_bulk,
 	lib.mempool.ops.enq.bulk)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_put, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_put, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_generic_put,
 	lib.mempool.generic.put)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_put_bulk, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_put_bulk, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_put_bulk,
 	lib.mempool.put.bulk)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_get, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_get, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_generic_get,
 	lib.mempool.generic.get)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_bulk, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_bulk, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_bulk,
 	lib.mempool.get.bulk)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_contig_blocks, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_contig_blocks, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_contig_blocks,
 	lib.mempool.get.blocks)
 
@@ -66,14 +66,14 @@ RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_create,
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_free,
 	lib.mempool.cache.free)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_default_cache, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_default_cache, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_default_cache,
 	lib.mempool.default.cache)
 
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_page_size,
 	lib.mempool.get.page.size)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_cache_flush, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_cache_flush, 20.05);
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_flush,
 	lib.mempool.cache.flush)
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 00ff71a209..ac8ff70ece 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1405,7 +1405,7 @@ void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 	rte_mcfg_mempool_read_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_mem_range, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_mem_range, 24.07);
 int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 		struct rte_mempool_mem_range_info *mem_range)
 {
@@ -1440,7 +1440,7 @@ int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_obj_alignment, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_obj_alignment, 24.07);
 size_t rte_mempool_get_obj_alignment(const struct rte_mempool *mp)
 {
 	if (mp == NULL)
diff --git a/lib/metrics/rte_metrics_telemetry.c b/lib/metrics/rte_metrics_telemetry.c
index f9ec556595..3061d6d15f 100644
--- a/lib/metrics/rte_metrics_telemetry.c
+++ b/lib/metrics/rte_metrics_telemetry.c
@@ -72,7 +72,7 @@ rte_metrics_tel_reg_port_ethdev_to_metrics(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05);
 int32_t
 rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 {
@@ -227,7 +227,7 @@ rte_metrics_tel_format_port(uint32_t pid, json_t *ports,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05);
 int32_t
 rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 		char **json_buffer)
@@ -281,7 +281,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05);
 int32_t
 rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 		int *reg_index, char **json_buffer)
@@ -312,7 +312,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05);
 int32_t
 rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 {
@@ -379,7 +379,7 @@ rte_metrics_tel_stat_names_to_ids(const char * const *stat_names,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05);
 int32_t
 rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 {
@@ -550,7 +550,7 @@ RTE_INIT(metrics_ctor)
 
 #else /* !RTE_HAS_JANSSON */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05);
 int32_t
 rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 {
@@ -560,7 +560,7 @@ rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05);
 int32_t
 rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	char **json_buffer)
@@ -571,7 +571,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05);
 int32_t
 rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	int *reg_index, char **json_buffer)
@@ -583,7 +583,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05);
 int32_t
 rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 {
@@ -592,7 +592,7 @@ rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05);
 int32_t
 rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 {
@@ -602,7 +602,7 @@ rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_global_stats, 20.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_global_stats, 20.05);
 int32_t
 rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep)
 {
diff --git a/lib/mldev/mldev_utils_neon.c b/lib/mldev/mldev_utils_neon.c
index 0222bd7e15..03c9236b3a 100644
--- a/lib/mldev/mldev_utils_neon.c
+++ b/lib/mldev/mldev_utils_neon.c
@@ -77,7 +77,7 @@ __float32_to_int8_neon_s8x1(const float *input, int8_t *output, float scale, int
 	*output = vqmovnh_s16(s16);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11);
 int
 rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -152,7 +152,7 @@ __int8_to_float32_neon_f32x1(const int8_t *input, float *output, float scale, in
 	*output = scale * (vcvts_f32_s32((int32_t)*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11);
 int
 rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -246,7 +246,7 @@ __float32_to_uint8_neon_u8x1(const float *input, uint8_t *output, float scale, u
 	*output = vqmovnh_u16(u16);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11);
 int
 rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -321,7 +321,7 @@ __uint8_to_float32_neon_f32x1(const uint8_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_u32((uint32_t)*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11);
 int
 rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -401,7 +401,7 @@ __float32_to_int16_neon_s16x1(const float *input, int16_t *output, float scale,
 	*output = vqmovns_s32(vget_lane_s32(s32x2, 0));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11);
 int
 rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -470,7 +470,7 @@ __int16_to_float32_neon_f32x1(const int16_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_s32((int32_t)*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11);
 int
 rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -547,7 +547,7 @@ __float32_to_uint16_neon_u16x1(const float *input, uint16_t *output, float scale
 	*output = vqmovns_u32(u32) + zero_point;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11);
 int
 rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint16_t zero_point)
@@ -618,7 +618,7 @@ __uint16_to_float32_neon_f32x1(const uint16_t *input, float *output, float scale
 	*output = scale * (vcvts_f32_u32((uint32_t)*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11);
 int
 rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint16_t zero_point)
@@ -697,7 +697,7 @@ __float32_to_int32_neon_s32x1(const float *input, int32_t *output, float scale,
 	vst1_lane_s32(output, s32x2, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11);
 int
 rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -762,7 +762,7 @@ __int32_to_float32_neon_f32x1(const int32_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_s32(*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11);
 int
 rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -830,7 +830,7 @@ __float32_to_uint32_neon_u32x1(const float *input, uint32_t *output, float scale
 	*output = vcvtas_u32_f32((*input) / scale + (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11);
 int
 rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint32_t zero_point)
@@ -897,7 +897,7 @@ __uint32_to_float32_neon_f32x1(const uint32_t *input, float *output, float scale
 	*output = scale * (vcvts_f32_u32(*input) - (float)zero_point);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11);
 int
 rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint32_t zero_point)
@@ -992,7 +992,7 @@ __float32_to_int64_neon_s64x1(const float *input, int64_t *output, float scale,
 	*output = s64;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11);
 int
 rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -1081,7 +1081,7 @@ __int64_to_float32_neon_f32x1(const int64_t *input, float *output, float scale,
 	vst1_lane_f32(output, f32x2, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11);
 int
 rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -1172,7 +1172,7 @@ __float32_to_uint64_neon_u64x1(const float *input, uint64_t *output, float scale
 	vst1q_lane_u64(output, u64x2, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11);
 int
 rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint64_t zero_point)
@@ -1263,7 +1263,7 @@ __uint64_to_float32_neon_f32x1(const uint64_t *input, float *output, float scale
 	vst1_lane_f32(output, f32x2, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11);
 int
 rte_ml_io_uint64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint64_t zero_point)
@@ -1332,7 +1332,7 @@ __float32_to_float16_neon_f16x1(const float32_t *input, float16_t *output)
 	vst1_lane_f16(output, f16x4, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11);
 int
 rte_ml_io_float32_to_float16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -1400,7 +1400,7 @@ __float16_to_float32_neon_f32x1(const float16_t *input, float32_t *output)
 	vst1q_lane_f32(output, f32x4, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11);
 int
 rte_ml_io_float16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_neon_bfloat16.c b/lib/mldev/mldev_utils_neon_bfloat16.c
index 65cd73f880..0456528514 100644
--- a/lib/mldev/mldev_utils_neon_bfloat16.c
+++ b/lib/mldev/mldev_utils_neon_bfloat16.c
@@ -51,7 +51,7 @@ __float32_to_bfloat16_neon_f16x1(const float32_t *input, bfloat16_t *output)
 	vst1_lane_bf16(output, bf16x4, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11);
 int
 rte_ml_io_float32_to_bfloat16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -119,7 +119,7 @@ __bfloat16_to_float32_neon_f32x1(const bfloat16_t *input, float32_t *output)
 	vst1q_lane_f32(output, f32x4, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11);
 int
 rte_ml_io_bfloat16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_scalar.c b/lib/mldev/mldev_utils_scalar.c
index a3aac3f92e..db01e5f68b 100644
--- a/lib/mldev/mldev_utils_scalar.c
+++ b/lib/mldev/mldev_utils_scalar.c
@@ -11,7 +11,7 @@
  * types from higher precision to lower precision and vice-versa, except bfloat16.
  */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11);
 int
 rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -45,7 +45,7 @@ rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11);
 int
 rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -70,7 +70,7 @@ rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11);
 int
 rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -104,7 +104,7 @@ rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11);
 int
 rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -129,7 +129,7 @@ rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11);
 int
 rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -163,7 +163,7 @@ rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11);
 int
 rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -188,7 +188,7 @@ rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11);
 int
 rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint16_t zero_point)
@@ -222,7 +222,7 @@ rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11);
 int
 rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint16_t zero_point)
@@ -247,7 +247,7 @@ rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11);
 int
 rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -272,7 +272,7 @@ rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11);
 int
 rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -297,7 +297,7 @@ rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11);
 int
 rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint32_t zero_point)
@@ -328,7 +328,7 @@ rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11);
 int
 rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint32_t zero_point)
@@ -353,7 +353,7 @@ rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11);
 int
 rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -378,7 +378,7 @@ rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11);
 int
 rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -403,7 +403,7 @@ rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11);
 int
 rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint64_t zero_point)
@@ -434,7 +434,7 @@ rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11);
 int
 rte_ml_io_uint64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint64_t zero_point)
@@ -581,7 +581,7 @@ __float32_to_float16_scalar_rtn(float x)
 	return u16;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11);
 int
 rte_ml_io_float32_to_float16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -666,7 +666,7 @@ __float16_to_float32_scalar_rtx(uint16_t f16)
 	return f32.f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11);
 int
 rte_ml_io_float16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_scalar_bfloat16.c b/lib/mldev/mldev_utils_scalar_bfloat16.c
index a098d31526..757d92b963 100644
--- a/lib/mldev/mldev_utils_scalar_bfloat16.c
+++ b/lib/mldev/mldev_utils_scalar_bfloat16.c
@@ -93,7 +93,7 @@ __float32_to_bfloat16_scalar_rtn(float x)
 	return u16;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11);
 int
 rte_ml_io_float32_to_bfloat16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -176,7 +176,7 @@ __bfloat16_to_float32_scalar_rtx(uint16_t f16)
 	return f32.f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11);
 int
 rte_ml_io_bfloat16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index b61e4be45c..4455831db5 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -160,7 +160,7 @@ rte_ml_dev_pmd_release(struct rte_ml_dev *dev)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_init, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_init, 22.11);
 int
 rte_ml_dev_init(size_t dev_max)
 {
@@ -196,14 +196,14 @@ rte_ml_dev_init(size_t dev_max)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_count, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_count, 22.11);
 uint16_t
 rte_ml_dev_count(void)
 {
 	return ml_dev_globals.nb_devs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_is_valid_dev, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_is_valid_dev, 22.11);
 int
 rte_ml_dev_is_valid_dev(int16_t dev_id)
 {
@@ -219,7 +219,7 @@ rte_ml_dev_is_valid_dev(int16_t dev_id)
 		return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_socket_id, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_socket_id, 22.11);
 int
 rte_ml_dev_socket_id(int16_t dev_id)
 {
@@ -235,7 +235,7 @@ rte_ml_dev_socket_id(int16_t dev_id)
 	return dev->data->socket_id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_info_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_info_get, 22.11);
 int
 rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 {
@@ -259,7 +259,7 @@ rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 	return dev->dev_ops->dev_info_get(dev, dev_info);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_configure, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_configure, 22.11);
 int
 rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 {
@@ -299,7 +299,7 @@ rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_close, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_close, 22.11);
 int
 rte_ml_dev_close(int16_t dev_id)
 {
@@ -323,7 +323,7 @@ rte_ml_dev_close(int16_t dev_id)
 	return dev->dev_ops->dev_close(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_start, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_start, 22.11);
 int
 rte_ml_dev_start(int16_t dev_id)
 {
@@ -351,7 +351,7 @@ rte_ml_dev_start(int16_t dev_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stop, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stop, 22.11);
 int
 rte_ml_dev_stop(int16_t dev_id)
 {
@@ -379,7 +379,7 @@ rte_ml_dev_stop(int16_t dev_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_count, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_count, 22.11);
 uint16_t
 rte_ml_dev_queue_pair_count(int16_t dev_id)
 {
@@ -395,7 +395,7 @@ rte_ml_dev_queue_pair_count(int16_t dev_id)
 	return dev->data->nb_queue_pairs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_setup, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_setup, 22.11);
 int
 rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 			    const struct rte_ml_dev_qp_conf *qp_conf, int socket_id)
@@ -429,7 +429,7 @@ rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->dev_queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_get, 22.11);
 int
 rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 {
@@ -453,7 +453,7 @@ rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 	return dev->dev_ops->dev_stats_get(dev, stats);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_reset, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_reset, 22.11);
 void
 rte_ml_dev_stats_reset(int16_t dev_id)
 {
@@ -471,7 +471,7 @@ rte_ml_dev_stats_reset(int16_t dev_id)
 	dev->dev_ops->dev_stats_reset(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_names_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_names_get, 22.11);
 int
 rte_ml_dev_xstats_names_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 			    struct rte_ml_dev_xstats_map *xstats_map, uint32_t size)
@@ -490,7 +490,7 @@ rte_ml_dev_xstats_names_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, in
 	return dev->dev_ops->dev_xstats_names_get(dev, mode, model_id, xstats_map, size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_by_name_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_by_name_get, 22.11);
 int
 rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_id, uint64_t *value)
 {
@@ -518,7 +518,7 @@ rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_i
 	return dev->dev_ops->dev_xstats_by_name_get(dev, name, stat_id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_get, 22.11);
 int
 rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 		      const uint16_t stat_ids[], uint64_t values[], uint16_t nb_ids)
@@ -547,7 +547,7 @@ rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t
 	return dev->dev_ops->dev_xstats_get(dev, mode, model_id, stat_ids, values, nb_ids);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_reset, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_reset, 22.11);
 int
 rte_ml_dev_xstats_reset(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 			const uint16_t stat_ids[], uint16_t nb_ids)
@@ -566,7 +566,7 @@ rte_ml_dev_xstats_reset(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_
 	return dev->dev_ops->dev_xstats_reset(dev, mode, model_id, stat_ids, nb_ids);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_dump, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_dump, 22.11);
 int
 rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 {
@@ -589,7 +589,7 @@ rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 	return dev->dev_ops->dev_dump(dev, fd);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_selftest, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_selftest, 22.11);
 int
 rte_ml_dev_selftest(int16_t dev_id)
 {
@@ -607,7 +607,7 @@ rte_ml_dev_selftest(int16_t dev_id)
 	return dev->dev_ops->dev_selftest(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_load, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_load, 22.11);
 int
 rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *model_id)
 {
@@ -635,7 +635,7 @@ rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *
 	return dev->dev_ops->model_load(dev, params, model_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_unload, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_unload, 22.11);
 int
 rte_ml_model_unload(int16_t dev_id, uint16_t model_id)
 {
@@ -653,7 +653,7 @@ rte_ml_model_unload(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_unload(dev, model_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_start, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_start, 22.11);
 int
 rte_ml_model_start(int16_t dev_id, uint16_t model_id)
 {
@@ -671,7 +671,7 @@ rte_ml_model_start(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_start(dev, model_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_stop, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_stop, 22.11);
 int
 rte_ml_model_stop(int16_t dev_id, uint16_t model_id)
 {
@@ -689,7 +689,7 @@ rte_ml_model_stop(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_stop(dev, model_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_info_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_info_get, 22.11);
 int
 rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_info *model_info)
 {
@@ -713,7 +713,7 @@ rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_inf
 	return dev->dev_ops->model_info_get(dev, model_id, model_info);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_params_update, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_params_update, 22.11);
 int
 rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 {
@@ -736,7 +736,7 @@ rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 	return dev->dev_ops->model_params_update(dev, model_id, buffer);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_quantize, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_quantize, 22.11);
 int
 rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **dbuffer,
 		   struct rte_ml_buff_seg **qbuffer)
@@ -765,7 +765,7 @@ rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **d
 	return dev->dev_ops->io_quantize(dev, model_id, dbuffer, qbuffer);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_dequantize, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_dequantize, 22.11);
 int
 rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **qbuffer,
 		     struct rte_ml_buff_seg **dbuffer)
@@ -806,7 +806,7 @@ ml_op_init(struct rte_mempool *mempool, __rte_unused void *opaque_arg, void *_op
 	op->mempool = mempool;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_create, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_create, 22.11);
 struct rte_mempool *
 rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache_size,
 		      uint16_t user_size, int socket_id)
@@ -846,14 +846,14 @@ rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache
 	return mp;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_free, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_free, 22.11);
 void
 rte_ml_op_pool_free(struct rte_mempool *mempool)
 {
 	rte_mempool_free(mempool);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_enqueue_burst, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_enqueue_burst, 22.11);
 uint16_t
 rte_ml_enqueue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uint16_t nb_ops)
 {
@@ -890,7 +890,7 @@ rte_ml_enqueue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uin
 	return dev->enqueue_burst(dev, qp_id, ops, nb_ops);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dequeue_burst, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dequeue_burst, 22.11);
 uint16_t
 rte_ml_dequeue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uint16_t nb_ops)
 {
@@ -927,7 +927,7 @@ rte_ml_dequeue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uin
 	return dev->dequeue_burst(dev, qp_id, ops, nb_ops);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_error_get, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_error_get, 22.11);
 int
 rte_ml_op_error_get(int16_t dev_id, struct rte_ml_op *op, struct rte_ml_op_error *error)
 {
@@ -959,5 +959,5 @@ rte_ml_op_error_get(int16_t dev_id, struct rte_ml_op *op, struct rte_ml_op_error
 	return dev->op_error_get(dev, op, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_logtype, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_logtype, 22.11);
 RTE_LOG_REGISTER_DEFAULT(rte_ml_dev_logtype, INFO);
diff --git a/lib/node/ethdev_ctrl.c b/lib/node/ethdev_ctrl.c
index 19d2670d89..92207b74fb 100644
--- a/lib/node/ethdev_ctrl.c
+++ b/lib/node/ethdev_ctrl.c
@@ -141,7 +141,7 @@ rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ethdev_rx_next_update, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ethdev_rx_next_update, 24.03);
 int
 rte_node_ethdev_rx_next_update(rte_node_t id, const char *edge_name)
 {
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..6b2a60dabc 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -193,7 +193,7 @@ ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_create, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_create, 25.07);
 int
 rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 {
@@ -213,7 +213,7 @@ rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07);
 int
 rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 			   enum rte_node_ip4_lookup_next next_node)
diff --git a/lib/node/ip4_reassembly.c b/lib/node/ip4_reassembly.c
index b61ddfd7d1..cc61eb3ada 100644
--- a/lib/node/ip4_reassembly.c
+++ b/lib/node/ip4_reassembly.c
@@ -128,7 +128,7 @@ ip4_reassembly_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return idx;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_reassembly_configure, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_reassembly_configure, 23.11);
 int
 rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt)
 {
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 83c0500c76..29eb2d6d12 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -258,7 +258,7 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_route_add, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_route_add, 23.07);
 int
 rte_node_ip6_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 		       enum rte_node_ip6_lookup_next next_node)
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..2d990b6ec1 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -187,7 +187,7 @@ ip6_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_create, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_create, 25.07);
 int
 rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 {
@@ -207,7 +207,7 @@ rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_route_add, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_route_add, 25.07);
 int
 rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 			   enum rte_node_ip6_lookup_next next_node)
diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index d5488e7fa3..fd7501a803 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -273,7 +273,7 @@ ip6_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_rewrite_add, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_rewrite_add, 23.07);
 int
 rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..c13934489c 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -56,7 +56,7 @@ static struct rte_hash_parameters udp4_params = {
 	.socket_id = 0,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_dst_port_add, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_dst_port_add, 23.11);
 int
 rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 {
@@ -78,7 +78,7 @@ rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_usr_node_add, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_usr_node_add, 23.11);
 int
 rte_node_udp4_usr_node_add(const char *usr_node)
 {
diff --git a/lib/pdcp/rte_pdcp.c b/lib/pdcp/rte_pdcp.c
index d21df8ab43..614b3f65c7 100644
--- a/lib/pdcp/rte_pdcp.c
+++ b/lib/pdcp/rte_pdcp.c
@@ -98,7 +98,7 @@ pdcp_dl_establish(struct rte_pdcp_entity *entity, const struct rte_pdcp_entity_c
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_establish, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_establish, 23.07);
 struct rte_pdcp_entity *
 rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf)
 {
@@ -199,7 +199,7 @@ pdcp_dl_release(struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_release, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_release, 23.07);
 int
 rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *out_mb[])
 {
@@ -222,7 +222,7 @@ rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *ou
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_suspend, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_suspend, 23.07);
 int
 rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 			struct rte_mbuf *out_mb[])
@@ -250,7 +250,7 @@ rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_control_pdu_create, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_control_pdu_create, 23.07);
 struct rte_mbuf *
 rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 			    enum rte_pdcp_ctrl_pdu_type type)
@@ -291,7 +291,7 @@ rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 	return m;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_t_reordering_expiry_handle, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_t_reordering_expiry_handle, 23.07);
 uint16_t
 rte_pdcp_t_reordering_expiry_handle(const struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 {
diff --git a/lib/pipeline/rte_port_in_action.c b/lib/pipeline/rte_port_in_action.c
index 2378e64de9..e52b0f24d1 100644
--- a/lib/pipeline/rte_port_in_action.c
+++ b/lib/pipeline/rte_port_in_action.c
@@ -201,7 +201,7 @@ struct rte_port_in_action_profile {
 	int frozen;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_create, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_create, 18.05);
 struct rte_port_in_action_profile *
 rte_port_in_action_profile_create(uint32_t socket_id)
 {
@@ -218,7 +218,7 @@ rte_port_in_action_profile_create(uint32_t socket_id)
 	return ap;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_action_register, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_action_register, 18.05);
 int
 rte_port_in_action_profile_action_register(struct rte_port_in_action_profile *profile,
 	enum rte_port_in_action_type type,
@@ -258,7 +258,7 @@ rte_port_in_action_profile_action_register(struct rte_port_in_action_profile *pr
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_freeze, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_freeze, 18.05);
 int
 rte_port_in_action_profile_freeze(struct rte_port_in_action_profile *profile)
 {
@@ -271,7 +271,7 @@ rte_port_in_action_profile_freeze(struct rte_port_in_action_profile *profile)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_free, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_free, 18.05);
 int
 rte_port_in_action_profile_free(struct rte_port_in_action_profile *profile)
 {
@@ -320,7 +320,7 @@ action_data_init(struct rte_port_in_action *action,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_create, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_create, 18.05);
 struct rte_port_in_action *
 rte_port_in_action_create(struct rte_port_in_action_profile *profile,
 	uint32_t socket_id)
@@ -357,7 +357,7 @@ rte_port_in_action_create(struct rte_port_in_action_profile *profile,
 	return action;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_apply, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_apply, 18.05);
 int
 rte_port_in_action_apply(struct rte_port_in_action *action,
 	enum rte_port_in_action_type type,
@@ -505,7 +505,7 @@ ah_selector(struct rte_port_in_action *action)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_params_get, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_params_get, 18.05);
 int
 rte_port_in_action_params_get(struct rte_port_in_action *action,
 	struct rte_pipeline_port_in_params *params)
@@ -526,7 +526,7 @@ rte_port_in_action_params_get(struct rte_port_in_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_free, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_free, 18.05);
 int
 rte_port_in_action_free(struct rte_port_in_action *action)
 {
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index 4e9bb842a1..ea969e61a9 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -1171,7 +1171,7 @@ static struct rte_tailq_elem rte_swx_ctl_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ctl_pipeline_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_find, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_find, 22.11);
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_find(const char *name)
 {
@@ -1251,7 +1251,7 @@ ctl_unregister(struct rte_swx_ctl_pipeline *ctl)
 	rte_mcfg_tailq_write_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_free, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_free, 20.11);
 void
 rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -1274,7 +1274,7 @@ rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 	free(ctl);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_create, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_create, 20.11);
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 {
@@ -1553,7 +1553,7 @@ rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_add, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_add, 20.11);
 int
 rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 				     const char *table_name,
@@ -1668,7 +1668,7 @@ rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_delete, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_delete, 20.11);
 int
 rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 					const char *table_name,
@@ -1759,7 +1759,7 @@ rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_default_entry_add, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_default_entry_add, 20.11);
 int
 rte_swx_ctl_pipeline_table_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					     const char *table_name,
@@ -2097,7 +2097,7 @@ table_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t table_id)
 	table_pending_default_free(table);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_add, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_add, 21.08);
 int
 rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 					const char *selector_name,
@@ -2125,7 +2125,7 @@ rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 	return -ENOSPC;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_delete, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_delete, 21.08);
 int
 rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 					   const char *selector_name,
@@ -2177,7 +2177,7 @@ rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_add, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_add, 21.08);
 int
 rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *selector_name,
@@ -2237,7 +2237,7 @@ rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_delete, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_delete, 21.08);
 int
 rte_swx_ctl_pipeline_selector_group_member_delete(struct rte_swx_ctl_pipeline *ctl,
 						  const char *selector_name,
@@ -2491,7 +2491,7 @@ learner_default_entry_duplicate(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_add, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_add, 21.11);
 int
 rte_swx_ctl_pipeline_learner_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *learner_name,
@@ -2565,7 +2565,7 @@ learner_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t learner_id)
 	learner_pending_default_free(l);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_commit, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_commit, 20.11);
 int
 rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 {
@@ -2652,7 +2652,7 @@ rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_abort, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_abort, 20.11);
 void
 rte_swx_ctl_pipeline_abort(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -2987,7 +2987,7 @@ token_is_comment(const char *token)
 
 #define RTE_SWX_CTL_ENTRY_TOKENS_MAX 256
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_read, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_read, 20.11);
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 				      const char *table_name,
@@ -3187,7 +3187,7 @@ rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_read, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_read, 21.11);
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_learner_default_entry_read(struct rte_swx_ctl_pipeline *ctl,
 						const char *learner_name,
@@ -3340,7 +3340,7 @@ table_entry_printf(FILE *f,
 	fprintf(f, "\n");
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_fprintf, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_fprintf, 20.11);
 int
 rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 				   struct rte_swx_ctl_pipeline *ctl,
@@ -3391,7 +3391,7 @@ rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_fprintf, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_fprintf, 21.08);
 int
 rte_swx_ctl_pipeline_selector_fprintf(FILE *f,
 				      struct rte_swx_ctl_pipeline *ctl,
diff --git a/lib/pipeline/rte_swx_ipsec.c b/lib/pipeline/rte_swx_ipsec.c
index 553056fad2..2b7d767105 100644
--- a/lib/pipeline/rte_swx_ipsec.c
+++ b/lib/pipeline/rte_swx_ipsec.c
@@ -178,7 +178,7 @@ static struct rte_tailq_elem rte_swx_ipsec_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ipsec_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_find, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_find, 23.03);
 struct rte_swx_ipsec *
 rte_swx_ipsec_find(const char *name)
 {
@@ -263,7 +263,7 @@ ipsec_unregister(struct rte_swx_ipsec *ipsec)
 static void
 ipsec_session_free(struct rte_swx_ipsec *ipsec, struct rte_ipsec_session *s);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_free, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_free, 23.03);
 void
 rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 {
@@ -294,7 +294,7 @@ rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 	env_free(ipsec, ipsec->total_size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_create, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_create, 23.03);
 int
 rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec_out,
 		     const char *name,
@@ -722,7 +722,7 @@ rte_swx_ipsec_post_crypto(struct rte_swx_ipsec *ipsec)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_run, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_run, 23.03);
 void
 rte_swx_ipsec_run(struct rte_swx_ipsec *ipsec)
 {
@@ -1134,7 +1134,7 @@ do {                                   \
 	}                              \
 } while (0)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_read, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_read, 23.03);
 struct rte_swx_ipsec_sa_params *
 rte_swx_ipsec_sa_read(struct rte_swx_ipsec *ipsec __rte_unused,
 		      const char *string,
@@ -1768,7 +1768,7 @@ ipsec_session_free(struct rte_swx_ipsec *ipsec,
 	memset(s, 0, sizeof(*s));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_add, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_add, 23.03);
 int
 rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 		     struct rte_swx_ipsec_sa_params *sa_params,
@@ -1808,7 +1808,7 @@ rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_delete, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_delete, 23.03);
 void
 rte_swx_ipsec_sa_delete(struct rte_swx_ipsec *ipsec,
 			uint32_t sa_id)
diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index 2193bc4ebf..d2d8730d2e 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -122,7 +122,7 @@ struct_type_field_find(struct struct_type *st, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_struct_type_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_struct_type_register, 20.11);
 int
 rte_swx_pipeline_struct_type_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -254,7 +254,7 @@ port_in_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_type_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_type_register, 20.11);
 int
 rte_swx_pipeline_port_in_type_register(struct rte_swx_pipeline *p,
 				       const char *name,
@@ -298,7 +298,7 @@ port_in_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_config, 20.11);
 int
 rte_swx_pipeline_port_in_config(struct rte_swx_pipeline *p,
 				uint32_t port_id,
@@ -417,7 +417,7 @@ port_out_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_type_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_type_register, 20.11);
 int
 rte_swx_pipeline_port_out_type_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -463,7 +463,7 @@ port_out_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_config, 20.11);
 int
 rte_swx_pipeline_port_out_config(struct rte_swx_pipeline *p,
 				 uint32_t port_id,
@@ -570,7 +570,7 @@ port_out_free(struct rte_swx_pipeline *p)
 /*
  * Packet mirroring.
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_mirroring_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_mirroring_config, 20.11);
 int
 rte_swx_pipeline_mirroring_config(struct rte_swx_pipeline *p,
 				  struct rte_swx_pipeline_mirroring_params *params)
@@ -767,7 +767,7 @@ extern_obj_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_register, 20.11);
 int
 rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	const char *name,
@@ -808,7 +808,7 @@ rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_member_func_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_member_func_register, 20.11);
 int
 rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	const char *extern_type_name,
@@ -846,7 +846,7 @@ rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_object_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_object_config, 20.11);
 int
 rte_swx_pipeline_extern_object_config(struct rte_swx_pipeline *p,
 				      const char *extern_type_name,
@@ -1063,7 +1063,7 @@ extern_func_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_func_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_func_register, 20.11);
 int
 rte_swx_pipeline_extern_func_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -1192,7 +1192,7 @@ hash_func_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_hash_func_register, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_hash_func_register, 22.07);
 int
 rte_swx_pipeline_hash_func_register(struct rte_swx_pipeline *p,
 				    const char *name,
@@ -1293,7 +1293,7 @@ rss_find_by_id(struct rte_swx_pipeline *p, uint32_t rss_obj_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_rss_config, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_rss_config, 23.03);
 int
 rte_swx_pipeline_rss_config(struct rte_swx_pipeline *p, const char *name)
 {
@@ -1471,7 +1471,7 @@ header_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_header_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_header_register, 20.11);
 int
 rte_swx_pipeline_packet_header_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -1610,7 +1610,7 @@ metadata_field_parse(struct rte_swx_pipeline *p, const char *name)
 	return struct_type_field_find(p->metadata_st, &name[2]);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_metadata_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_metadata_register, 20.11);
 int
 rte_swx_pipeline_packet_metadata_register(struct rte_swx_pipeline *p,
 					  const char *struct_type_name)
@@ -7870,7 +7870,7 @@ action_does_learning(struct action *a)
 	return 0; /* FALSE */
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_action_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_action_config, 20.11);
 int
 rte_swx_pipeline_action_config(struct rte_swx_pipeline *p,
 			       const char *name,
@@ -8235,7 +8235,7 @@ table_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_type_register, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_type_register, 20.11);
 int
 rte_swx_pipeline_table_type_register(struct rte_swx_pipeline *p,
 				     const char *name,
@@ -8405,7 +8405,7 @@ table_match_fields_check(struct rte_swx_pipeline *p,
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_config, 20.11);
 int
 rte_swx_pipeline_table_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -8909,7 +8909,7 @@ selector_fields_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_selector_config, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_selector_config, 21.08);
 int
 rte_swx_pipeline_selector_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -9382,7 +9382,7 @@ learner_action_learning_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_learner_config, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_learner_config, 21.11);
 int
 rte_swx_pipeline_learner_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -9956,7 +9956,7 @@ regarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_regarray_config, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_regarray_config, 21.05);
 int
 rte_swx_pipeline_regarray_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -10095,7 +10095,7 @@ metarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_metarray_config, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_metarray_config, 21.05);
 int
 rte_swx_pipeline_metarray_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -10246,7 +10246,7 @@ static struct rte_tailq_elem rte_swx_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_pipeline_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_find, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_find, 22.11);
 struct rte_swx_pipeline *
 rte_swx_pipeline_find(const char *name)
 {
@@ -10326,7 +10326,7 @@ pipeline_unregister(struct rte_swx_pipeline *p)
 	rte_mcfg_tailq_write_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_free, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_free, 20.11);
 void
 rte_swx_pipeline_free(struct rte_swx_pipeline *p)
 {
@@ -10472,7 +10472,7 @@ hash_funcs_register(struct rte_swx_pipeline *p)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_config, 20.11);
 int
 rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_node)
 {
@@ -10549,7 +10549,7 @@ rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_instructions_config, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_instructions_config, 20.11);
 int
 rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 				     const char **instructions,
@@ -10572,7 +10572,7 @@ rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build, 20.11);
 int
 rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 {
@@ -10691,7 +10691,7 @@ rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_run, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_run, 20.11);
 void
 rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 {
@@ -10701,7 +10701,7 @@ rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 		instr_exec(p);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_flush, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_flush, 20.11);
 void
 rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 {
@@ -10718,7 +10718,7 @@ rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 /*
  * Control.
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_info_get, 20.11);
 int
 rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 			      struct rte_swx_ctl_pipeline_info *pipeline)
@@ -10752,7 +10752,7 @@ rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_numa_node_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_numa_node_get, 20.11);
 int
 rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 {
@@ -10763,7 +10763,7 @@ rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_info_get, 20.11);
 int
 rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 			    uint32_t action_id,
@@ -10783,7 +10783,7 @@ rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_arg_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_arg_info_get, 20.11);
 int
 rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 				uint32_t action_id,
@@ -10808,7 +10808,7 @@ rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_info_get, 20.11);
 int
 rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 			   uint32_t table_id,
@@ -10833,7 +10833,7 @@ rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_match_field_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_match_field_info_get, 20.11);
 int
 rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10859,7 +10859,7 @@ rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_action_info_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_action_info_get, 20.11);
 int
 rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10883,7 +10883,7 @@ rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_ops_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_ops_get, 20.11);
 int
 rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 			  uint32_t table_id,
@@ -10910,7 +10910,7 @@ rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_info_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_info_get, 21.08);
 int
 rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 			      uint32_t selector_id,
@@ -10934,7 +10934,7 @@ rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_group_id_field_info_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_group_id_field_info_get, 21.08);
 int
 rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10957,7 +10957,7 @@ rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_field_info_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_field_info_get, 21.08);
 int
 rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10983,7 +10983,7 @@ rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_member_id_field_info_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_member_id_field_info_get, 21.08);
 int
 rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -11006,7 +11006,7 @@ rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_info_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_info_get, 21.11);
 int
 rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 			     uint32_t learner_id,
@@ -11032,7 +11032,7 @@ rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_match_field_info_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_match_field_info_get, 21.11);
 int
 rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11058,7 +11058,7 @@ rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_action_info_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_action_info_get, 21.11);
 int
 rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 				    uint32_t learner_id,
@@ -11085,7 +11085,7 @@ rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_get, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_get, 22.07);
 int
 rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11105,7 +11105,7 @@ rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_set, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_set, 22.07);
 int
 rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11137,7 +11137,7 @@ rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_get, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_get, 20.11);
 int
 rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state **table_state)
@@ -11149,7 +11149,7 @@ rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_set, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_set, 20.11);
 int
 rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state *table_state)
@@ -11161,7 +11161,7 @@ rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_in_stats_read, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_in_stats_read, 20.11);
 int
 rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 					uint32_t port_id,
@@ -11180,7 +11180,7 @@ rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_out_stats_read, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_out_stats_read, 20.11);
 int
 rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 					 uint32_t port_id,
@@ -11199,7 +11199,7 @@ rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_stats_read, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_stats_read, 21.05);
 int
 rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 				      const char *table_name,
@@ -11227,7 +11227,7 @@ rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_stats_read, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_stats_read, 21.08);
 int
 rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	const char *selector_name,
@@ -11247,7 +11247,7 @@ rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_stats_read, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_stats_read, 21.11);
 int
 rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 					const char *learner_name,
@@ -11281,7 +11281,7 @@ rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_regarray_info_get, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_regarray_info_get, 21.05);
 int
 rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t regarray_id,
@@ -11301,7 +11301,7 @@ rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read, 21.05);
 int
 rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11323,7 +11323,7 @@ rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write, 21.05);
 int
 rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11345,7 +11345,7 @@ rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_metarray_info_get, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_metarray_info_get, 21.05);
 int
 rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t metarray_id,
@@ -11365,7 +11365,7 @@ rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_add, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_add, 21.05);
 int
 rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -11398,7 +11398,7 @@ rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_delete, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_delete, 21.05);
 int
 rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 				 const char *name)
@@ -11419,7 +11419,7 @@ rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset, 21.05);
 int
 rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 			const char *metarray_name,
@@ -11448,7 +11448,7 @@ rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set, 21.05);
 int
 rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 		      const char *metarray_name,
@@ -11485,7 +11485,7 @@ rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read, 21.05);
 int
 rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 			     const char *metarray_name,
@@ -11514,7 +11514,7 @@ rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_mirroring_session_set, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_mirroring_session_set, 20.11);
 int
 rte_swx_ctl_pipeline_mirroring_session_set(struct rte_swx_pipeline *p,
 					   uint32_t session_id,
@@ -11721,7 +11721,7 @@ rte_swx_ctl_pipeline_table_entry_id_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read_with_key, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read_with_key, 22.11);
 int
 rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 					    const char *regarray_name,
@@ -11739,7 +11739,7 @@ rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_read(p, regarray_name, entry_id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write_with_key, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write_with_key, 22.11);
 int
 rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 					     const char *regarray_name,
@@ -11757,7 +11757,7 @@ rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_write(p, regarray_name, entry_id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset_with_key, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset_with_key, 22.11);
 int
 rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 				 const char *metarray_name,
@@ -11774,7 +11774,7 @@ rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_reset(p, metarray_name, entry_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set_with_key, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set_with_key, 22.11);
 int
 rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 			       const char *metarray_name,
@@ -11792,7 +11792,7 @@ rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_set(p, metarray_name, entry_id, profile_name);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read_with_key, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read_with_key, 22.11);
 int
 rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 				      const char *metarray_name,
@@ -11810,7 +11810,7 @@ rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_stats_read(p, metarray_name, entry_id, stats);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_rss_info_get, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_rss_info_get, 23.03);
 int
 rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 			 uint32_t rss_obj_id,
@@ -11831,7 +11831,7 @@ rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_size_read, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_size_read, 23.03);
 int
 rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 				       const char *rss_name,
@@ -11856,7 +11856,7 @@ rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_read, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_read, 23.03);
 int
 rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 				  const char *rss_name,
@@ -11881,7 +11881,7 @@ rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_write, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_write, 23.03);
 int
 rte_swx_ctl_pipeline_rss_key_write(struct rte_swx_pipeline *p,
 				   const char *rss_name,
@@ -14584,7 +14584,7 @@ pipeline_adjust(struct rte_swx_pipeline *p, struct instruction_group_list *igl)
 	instr_jmp_resolve(p->instructions, p->instruction_data, p->n_instructions);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_codegen, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_codegen, 22.11);
 int
 rte_swx_pipeline_codegen(FILE *spec_file,
 			 FILE *code_file,
@@ -14678,7 +14678,7 @@ rte_swx_pipeline_codegen(FILE *spec_file,
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build_from_lib, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build_from_lib, 22.11);
 int
 rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **pipeline,
 				const char *name,
diff --git a/lib/pipeline/rte_table_action.c b/lib/pipeline/rte_table_action.c
index c990d7eb56..f05e046c46 100644
--- a/lib/pipeline/rte_table_action.c
+++ b/lib/pipeline/rte_table_action.c
@@ -2363,7 +2363,7 @@ struct rte_table_action_profile {
 	int frozen;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_create, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_create, 18.05);
 struct rte_table_action_profile *
 rte_table_action_profile_create(struct rte_table_action_common_config *common)
 {
@@ -2385,7 +2385,7 @@ rte_table_action_profile_create(struct rte_table_action_common_config *common)
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_action_register, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_action_register, 18.05);
 int
 rte_table_action_profile_action_register(struct rte_table_action_profile *profile,
 	enum rte_table_action_type type,
@@ -2449,7 +2449,7 @@ rte_table_action_profile_action_register(struct rte_table_action_profile *profil
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_freeze, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_freeze, 18.05);
 int
 rte_table_action_profile_freeze(struct rte_table_action_profile *profile)
 {
@@ -2463,7 +2463,7 @@ rte_table_action_profile_freeze(struct rte_table_action_profile *profile)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_free, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_free, 18.05);
 int
 rte_table_action_profile_free(struct rte_table_action_profile *profile)
 {
@@ -2486,7 +2486,7 @@ struct rte_table_action {
 	struct meter_profile_data mp[METER_PROFILES_MAX];
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_create, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_create, 18.05);
 struct rte_table_action *
 rte_table_action_create(struct rte_table_action_profile *profile,
 	uint32_t socket_id)
@@ -2524,7 +2524,7 @@ action_data_get(void *data,
 	return &data_bytes[offset];
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_apply, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_apply, 18.05);
 int
 rte_table_action_apply(struct rte_table_action *action,
 	void *data,
@@ -2606,7 +2606,7 @@ rte_table_action_apply(struct rte_table_action *action,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_dscp_table_update, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_dscp_table_update, 18.05);
 int
 rte_table_action_dscp_table_update(struct rte_table_action *action,
 	uint64_t dscp_mask,
@@ -2639,7 +2639,7 @@ rte_table_action_dscp_table_update(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_add, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_add, 18.05);
 int
 rte_table_action_meter_profile_add(struct rte_table_action *action,
 	uint32_t meter_profile_id,
@@ -2680,7 +2680,7 @@ rte_table_action_meter_profile_add(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_delete, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_delete, 18.05);
 int
 rte_table_action_meter_profile_delete(struct rte_table_action *action,
 	uint32_t meter_profile_id)
@@ -2704,7 +2704,7 @@ rte_table_action_meter_profile_delete(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_read, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_read, 18.05);
 int
 rte_table_action_meter_read(struct rte_table_action *action,
 	void *data,
@@ -2767,7 +2767,7 @@ rte_table_action_meter_read(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_ttl_read, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_ttl_read, 18.05);
 int
 rte_table_action_ttl_read(struct rte_table_action *action,
 	void *data,
@@ -2796,7 +2796,7 @@ rte_table_action_ttl_read(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_stats_read, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_stats_read, 18.05);
 int
 rte_table_action_stats_read(struct rte_table_action *action,
 	void *data,
@@ -2832,7 +2832,7 @@ rte_table_action_stats_read(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_time_read, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_time_read, 18.05);
 int
 rte_table_action_time_read(struct rte_table_action *action,
 	void *data,
@@ -2856,7 +2856,7 @@ rte_table_action_time_read(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_crypto_sym_session_get, 18.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_crypto_sym_session_get, 18.11);
 struct rte_cryptodev_sym_session *
 rte_table_action_crypto_sym_session_get(struct rte_table_action *action,
 	void *data)
@@ -3444,7 +3444,7 @@ ah_selector(struct rte_table_action *action)
 	return ah_default;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_table_params_get, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_table_params_get, 18.05);
 int
 rte_table_action_table_params_get(struct rte_table_action *action,
 	struct rte_pipeline_table_params *params)
@@ -3470,7 +3470,7 @@ rte_table_action_table_params_get(struct rte_table_action *action,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_free, 18.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_free, 18.05);
 int
 rte_table_action_free(struct rte_table_action *action)
 {
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 4c7271522a..70ea3e7a07 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -291,7 +291,7 @@ cleanup_events(struct rte_pmu_event_group *group)
 	group->enabled = false;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_enable_group, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_enable_group, 25.07);
 int
 __rte_pmu_enable_group(struct rte_pmu_event_group *group)
 {
@@ -393,7 +393,7 @@ free_event(struct rte_pmu_event *event)
 	free(event);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_add_event, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_add_event, 25.07);
 int
 rte_pmu_add_event(const char *name)
 {
@@ -436,7 +436,7 @@ rte_pmu_add_event(const char *name)
 	return event->index;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_init, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_init, 25.07);
 int
 rte_pmu_init(void)
 {
@@ -468,7 +468,7 @@ rte_pmu_init(void)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_fini, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmu_fini, 25.07);
 void
 rte_pmu_fini(void)
 {
diff --git a/lib/port/rte_port_eventdev.c b/lib/port/rte_port_eventdev.c
index c3a287b834..fac71da321 100644
--- a/lib/port/rte_port_eventdev.c
+++ b/lib/port/rte_port_eventdev.c
@@ -561,7 +561,7 @@ static int rte_port_eventdev_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_reader_ops, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_reader_ops, 19.11);
 struct rte_port_in_ops rte_port_eventdev_reader_ops = {
 	.f_create = rte_port_eventdev_reader_create,
 	.f_free = rte_port_eventdev_reader_free,
@@ -569,7 +569,7 @@ struct rte_port_in_ops rte_port_eventdev_reader_ops = {
 	.f_stats = rte_port_eventdev_reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_ops, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_ops, 19.11);
 struct rte_port_out_ops rte_port_eventdev_writer_ops = {
 	.f_create = rte_port_eventdev_writer_create,
 	.f_free = rte_port_eventdev_writer_free,
@@ -579,7 +579,7 @@ struct rte_port_out_ops rte_port_eventdev_writer_ops = {
 	.f_stats = rte_port_eventdev_writer_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_nodrop_ops, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_nodrop_ops, 19.11);
 struct rte_port_out_ops rte_port_eventdev_writer_nodrop_ops = {
 	.f_create = rte_port_eventdev_writer_nodrop_create,
 	.f_free = rte_port_eventdev_writer_nodrop_free,
diff --git a/lib/port/rte_swx_port_ethdev.c b/lib/port/rte_swx_port_ethdev.c
index de6d0e5bb3..8c26794aa3 100644
--- a/lib/port/rte_swx_port_ethdev.c
+++ b/lib/port/rte_swx_port_ethdev.c
@@ -402,7 +402,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_reader_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_reader_ops, 20.11);
 struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -410,7 +410,7 @@ struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_writer_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_writer_ops, 20.11);
 struct rte_swx_port_out_ops rte_swx_port_ethdev_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_fd.c b/lib/port/rte_swx_port_fd.c
index 72783d2b0f..dfddf69ccc 100644
--- a/lib/port/rte_swx_port_fd.c
+++ b/lib/port/rte_swx_port_fd.c
@@ -345,7 +345,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_reader_ops, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_reader_ops, 21.05);
 struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -353,7 +353,7 @@ struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_writer_ops, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_writer_ops, 21.05);
 struct rte_swx_port_out_ops rte_swx_port_fd_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_ring.c b/lib/port/rte_swx_port_ring.c
index 3ac652ac09..f8d6b77e48 100644
--- a/lib/port/rte_swx_port_ring.c
+++ b/lib/port/rte_swx_port_ring.c
@@ -407,7 +407,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_reader_ops, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_reader_ops, 21.05);
 struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -415,7 +415,7 @@ struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_writer_ops, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_writer_ops, 21.05);
 struct rte_swx_port_out_ops rte_swx_port_ring_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_source_sink.c b/lib/port/rte_swx_port_source_sink.c
index af8b9ec68d..bcfcb8091e 100644
--- a/lib/port/rte_swx_port_source_sink.c
+++ b/lib/port/rte_swx_port_source_sink.c
@@ -202,7 +202,7 @@ source_stats_read(void *port, struct rte_swx_port_in_stats *stats)
 	memcpy(stats, &p->stats, sizeof(p->stats));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11);
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = source_create,
 	.free = source_free,
@@ -212,7 +212,7 @@ struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 
 #else
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11);
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = NULL,
 	.free = NULL,
@@ -383,7 +383,7 @@ sink_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_sink_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_sink_ops, 20.11);
 struct rte_swx_port_out_ops rte_swx_port_sink_ops = {
 	.create = sink_create,
 	.free = sink_free,
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index be230d1c50..f7cd085819 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -18,7 +18,7 @@
 
 #define PM_QOS_CPU_RESUME_LATENCY_BUF_LEN	32
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_set_cpu_resume_latency, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_set_cpu_resume_latency, 24.11);
 int
 rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 {
@@ -72,7 +72,7 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_get_cpu_resume_latency, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_get_cpu_resume_latency, 24.11);
 int
 rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 {
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 24870fc7c3..be2785a7fa 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -46,7 +46,7 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11);
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 {
@@ -86,7 +86,7 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_unset_uncore_env, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_unset_uncore_env, 23.11);
 void
 rte_power_unset_uncore_env(void)
 {
@@ -95,7 +95,7 @@ rte_power_unset_uncore_env(void)
 	rte_spinlock_unlock(&global_env_cfg_lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_get_uncore_env, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_get_uncore_env, 23.11);
 enum rte_uncore_power_mgmt_env
 rte_power_get_uncore_env(void)
 {
@@ -180,7 +180,7 @@ rte_power_uncore_freq_min(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->freq_min(pkg, die);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_freqs, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_freqs, 23.11);
 int
 rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 			uint32_t *freqs, uint32_t num)
diff --git a/lib/regexdev/rte_regexdev.c b/lib/regexdev/rte_regexdev.c
index 8ba797b278..bbaa10a37e 100644
--- a/lib/regexdev/rte_regexdev.c
+++ b/lib/regexdev/rte_regexdev.c
@@ -14,14 +14,14 @@
 #include "rte_regexdev_driver.h"
 
 static const char *MZ_RTE_REGEXDEV_DATA = "rte_regexdev_data";
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regex_devices, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regex_devices, 22.03);
 struct rte_regexdev rte_regex_devices[RTE_MAX_REGEXDEV_DEVS];
 /* Shared memory between primary and secondary processes. */
 static struct {
 	struct rte_regexdev_data data[RTE_MAX_REGEXDEV_DEVS];
 } *rte_regexdev_shared_data;
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_logtype, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_logtype, 22.03);
 RTE_LOG_REGISTER_DEFAULT(rte_regexdev_logtype, INFO);
 
 static uint16_t
@@ -146,7 +146,7 @@ rte_regexdev_get_device_by_name(const char *name)
 	return regexdev_allocated(name);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_count, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_count, 20.08);
 uint8_t
 rte_regexdev_count(void)
 {
@@ -160,7 +160,7 @@ rte_regexdev_count(void)
 	return count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_get_dev_id, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_get_dev_id, 20.08);
 int
 rte_regexdev_get_dev_id(const char *name)
 {
@@ -179,7 +179,7 @@ rte_regexdev_get_dev_id(const char *name)
 	return id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_is_valid_dev, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_is_valid_dev, 22.03);
 int
 rte_regexdev_is_valid_dev(uint16_t dev_id)
 {
@@ -204,14 +204,14 @@ regexdev_info_get(uint8_t dev_id, struct rte_regexdev_info *dev_info)
 
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_info_get, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_info_get, 20.08);
 int
 rte_regexdev_info_get(uint8_t dev_id, struct rte_regexdev_info *dev_info)
 {
 	return regexdev_info_get(dev_id, dev_info);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_configure, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_configure, 20.08);
 int
 rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 {
@@ -306,7 +306,7 @@ rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_queue_pair_setup, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_queue_pair_setup, 20.08);
 int
 rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 			   const struct rte_regexdev_qp_conf *qp_conf)
@@ -339,7 +339,7 @@ rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->dev_qp_setup(dev, queue_pair_id, qp_conf);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_start, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_start, 20.08);
 int
 rte_regexdev_start(uint8_t dev_id)
 {
@@ -356,7 +356,7 @@ rte_regexdev_start(uint8_t dev_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_stop, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_stop, 20.08);
 int
 rte_regexdev_stop(uint8_t dev_id)
 {
@@ -371,7 +371,7 @@ rte_regexdev_stop(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_close, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_close, 20.08);
 int
 rte_regexdev_close(uint8_t dev_id)
 {
@@ -387,7 +387,7 @@ rte_regexdev_close(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_get, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_get, 20.08);
 int
 rte_regexdev_attr_get(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 		      void *attr_value)
@@ -406,7 +406,7 @@ rte_regexdev_attr_get(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 	return dev->dev_ops->dev_attr_get(dev, attr_id, attr_value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_set, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_set, 20.08);
 int
 rte_regexdev_attr_set(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 		      const void *attr_value)
@@ -425,7 +425,7 @@ rte_regexdev_attr_set(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 	return dev->dev_ops->dev_attr_set(dev, attr_id, attr_value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_update, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_update, 20.08);
 int
 rte_regexdev_rule_db_update(uint8_t dev_id,
 			    const struct rte_regexdev_rule *rules,
@@ -445,7 +445,7 @@ rte_regexdev_rule_db_update(uint8_t dev_id,
 	return dev->dev_ops->dev_rule_db_update(dev, rules, nb_rules);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_compile_activate, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_compile_activate, 20.08);
 int
 rte_regexdev_rule_db_compile_activate(uint8_t dev_id)
 {
@@ -458,7 +458,7 @@ rte_regexdev_rule_db_compile_activate(uint8_t dev_id)
 	return dev->dev_ops->dev_rule_db_compile_activate(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_import, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_import, 20.08);
 int
 rte_regexdev_rule_db_import(uint8_t dev_id, const char *rule_db,
 			    uint32_t rule_db_len)
@@ -477,7 +477,7 @@ rte_regexdev_rule_db_import(uint8_t dev_id, const char *rule_db,
 	return dev->dev_ops->dev_db_import(dev, rule_db, rule_db_len);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_export, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_export, 20.08);
 int
 rte_regexdev_rule_db_export(uint8_t dev_id, char *rule_db)
 {
@@ -490,7 +490,7 @@ rte_regexdev_rule_db_export(uint8_t dev_id, char *rule_db)
 	return dev->dev_ops->dev_db_export(dev, rule_db);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_names_get, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_names_get, 20.08);
 int
 rte_regexdev_xstats_names_get(uint8_t dev_id,
 			      struct rte_regexdev_xstats_map *xstats_map)
@@ -509,7 +509,7 @@ rte_regexdev_xstats_names_get(uint8_t dev_id,
 	return dev->dev_ops->dev_xstats_names_get(dev, xstats_map);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_get, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_get, 20.08);
 int
 rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 			uint64_t *values, uint16_t n)
@@ -531,7 +531,7 @@ rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 	return dev->dev_ops->dev_xstats_get(dev, ids, values, n);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_by_name_get, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_by_name_get, 20.08);
 int
 rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 				uint16_t *id, uint64_t *value)
@@ -557,7 +557,7 @@ rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 	return dev->dev_ops->dev_xstats_by_name_get(dev, name, id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_reset, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_reset, 20.08);
 int
 rte_regexdev_xstats_reset(uint8_t dev_id, const uint16_t *ids,
 			  uint16_t nb_ids)
@@ -575,7 +575,7 @@ rte_regexdev_xstats_reset(uint8_t dev_id, const uint16_t *ids,
 	return dev->dev_ops->dev_xstats_reset(dev, ids, nb_ids);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_selftest, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_selftest, 20.08);
 int
 rte_regexdev_selftest(uint8_t dev_id)
 {
@@ -588,7 +588,7 @@ rte_regexdev_selftest(uint8_t dev_id)
 	return dev->dev_ops->dev_selftest(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_dump, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_dump, 20.08);
 int
 rte_regexdev_dump(uint8_t dev_id, FILE *f)
 {
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index 583d365d55..e2d8114c2f 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -35,7 +35,7 @@ EAL_REGISTER_TAILQ(rte_reorder_tailq)
 #define RTE_REORDER_NAMESIZE 32
 
 #define RTE_REORDER_SEQN_DYNFIELD_NAME "rte_reorder_seqn_dynfield"
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_seqn_dynfield_offset, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_seqn_dynfield_offset, 20.11);
 int rte_reorder_seqn_dynfield_offset = -1;
 
 /* A generic circular buffer */
@@ -61,7 +61,7 @@ struct __rte_cache_aligned rte_reorder_buffer {
 static void
 rte_reorder_free_mbufs(struct rte_reorder_buffer *b);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_memory_footprint_get, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_memory_footprint_get, 23.07);
 unsigned int
 rte_reorder_memory_footprint_get(unsigned int size)
 {
@@ -482,7 +482,7 @@ ready_buffer_seqn_find(const struct cir_buffer *ready_buf, const uint32_t seqn)
 	return low;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_drain_up_to_seqn, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_drain_up_to_seqn, 23.03);
 unsigned int
 rte_reorder_drain_up_to_seqn(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		const unsigned int max_mbufs, const rte_reorder_seqn_t seqn)
@@ -553,7 +553,7 @@ rte_reorder_is_empty(const struct rte_reorder_buffer *b)
 	return true;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_min_seqn_set, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_min_seqn_set, 23.03);
 unsigned int
 rte_reorder_min_seqn_set(struct rte_reorder_buffer *b, rte_reorder_seqn_t min_seqn)
 {
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index 8ad51b4ab0..548ba059fa 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -422,7 +422,7 @@ ring_dump_hts_headtail(FILE *f, const char *prefix,
 	fprintf(f, "%stail=%"PRIu32"\n", prefix, hts->ht.pos.tail);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ring_headtail_dump, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ring_headtail_dump, 25.03);
 void
 rte_ring_headtail_dump(FILE *f, const char *prefix,
 		const struct rte_ring_headtail *r)
diff --git a/lib/ring/rte_soring.c b/lib/ring/rte_soring.c
index 0d8abba69c..88dc808362 100644
--- a/lib/ring/rte_soring.c
+++ b/lib/ring/rte_soring.c
@@ -92,7 +92,7 @@ soring_dump_stage_headtail(FILE *f, const char *prefix,
 	fprintf(f, "%shead=%"PRIu32"\n", prefix, st->sht.head);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dump, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dump, 25.03);
 void
 rte_soring_dump(FILE *f, const struct rte_soring *r)
 {
@@ -120,7 +120,7 @@ rte_soring_dump(FILE *f, const struct rte_soring *r)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_get_memsize, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_get_memsize, 25.03);
 ssize_t
 rte_soring_get_memsize(const struct rte_soring_param *prm)
 {
@@ -154,7 +154,7 @@ soring_compilation_checks(void)
 		offsetof(struct soring_stage_headtail, unused));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_init, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_init, 25.03);
 int
 rte_soring_init(struct rte_soring *r, const struct rte_soring_param *prm)
 {
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 797484d6bf..f8a901c3e9 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -491,7 +491,7 @@ soring_release(struct rte_soring *r, const void *objs,
  * Public functions (data-path) start here.
  */
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_release, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_release, 25.03);
 void
 rte_soring_release(struct rte_soring *r, const void *objs,
 	uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -500,7 +500,7 @@ rte_soring_release(struct rte_soring *r, const void *objs,
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_releasx, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_releasx, 25.03);
 void
 rte_soring_releasx(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -508,7 +508,7 @@ rte_soring_releasx(struct rte_soring *r, const void *objs,
 	soring_release(r, objs, meta, stage, n, ftoken);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk, 25.03);
 uint32_t
 rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -517,7 +517,7 @@ rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_bulk, 25.03);
 uint32_t
 rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -526,7 +526,7 @@ rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst, 25.03);
 uint32_t
 rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -535,7 +535,7 @@ rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_burst, 25.03);
 uint32_t
 rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -544,7 +544,7 @@ rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk, 25.03);
 uint32_t
 rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -553,7 +553,7 @@ rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk, 25.03);
 uint32_t
 rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -562,7 +562,7 @@ rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst, 25.03);
 uint32_t
 rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -571,7 +571,7 @@ rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst, 25.03);
 uint32_t
 rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -580,7 +580,7 @@ rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_bulk, 25.03);
 uint32_t
 rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -589,7 +589,7 @@ rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_bulk, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_bulk, 25.03);
 uint32_t
 rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -598,7 +598,7 @@ rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_burst, 25.03);
 uint32_t
 rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -607,7 +607,7 @@ rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_burst, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_burst, 25.03);
 uint32_t
 rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -616,7 +616,7 @@ rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_count, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_count, 25.03);
 unsigned int
 rte_soring_count(const struct rte_soring *r)
 {
@@ -626,7 +626,7 @@ rte_soring_count(const struct rte_soring *r)
 	return (count > r->capacity) ? r->capacity : count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_free_count, 25.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_free_count, 25.03);
 unsigned int
 rte_soring_free_count(const struct rte_soring *r)
 {
diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index 75a73bf941..909c5afc2f 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -33,7 +33,7 @@
 
 RTE_EXPORT_SYMBOL(rte_security_dynfield_offset);
 int rte_security_dynfield_offset = -1;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_oop_dynfield_offset, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_oop_dynfield_offset, 23.11);
 int rte_security_oop_dynfield_offset = -1;
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_security_dynfield_register)
@@ -344,7 +344,7 @@ rte_security_capability_get(void *ctx, struct rte_security_capability_idx *idx)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_rx_inject_configure, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_rx_inject_configure, 23.11);
 int
 rte_security_rx_inject_configure(void *ctx, uint16_t port_id, bool enable)
 {
@@ -357,7 +357,7 @@ rte_security_rx_inject_configure(void *ctx, uint16_t port_id, bool enable)
 	return instance->ops->rx_inject_configure(instance->device, port_id, enable);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_inb_pkt_rx_inject, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_inb_pkt_rx_inject, 23.11);
 uint16_t
 rte_security_inb_pkt_rx_inject(void *ctx, struct rte_mbuf **pkts, void **sess,
 			       uint16_t nb_pkts)
diff --git a/lib/table/rte_swx_table_em.c b/lib/table/rte_swx_table_em.c
index 4ec54cb635..a8a5ee1b75 100644
--- a/lib/table/rte_swx_table_em.c
+++ b/lib/table/rte_swx_table_em.c
@@ -648,7 +648,7 @@ table_footprint(struct rte_swx_table_params *params,
 	return memory_footprint;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_unoptimized_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_unoptimized_ops, 20.11);
 struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get_unoptimized,
@@ -659,7 +659,7 @@ struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.free = table_free,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_ops, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_ops, 20.11);
 struct rte_swx_table_ops rte_swx_table_exact_match_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get,
diff --git a/lib/table/rte_swx_table_learner.c b/lib/table/rte_swx_table_learner.c
index 2d61bceeaf..03ba4173a4 100644
--- a/lib/table/rte_swx_table_learner.c
+++ b/lib/table/rte_swx_table_learner.c
@@ -273,7 +273,7 @@ table_entry_id_get(struct table *t, struct table_bucket *b, size_t bucket_key_po
 	return (bucket_id << TABLE_KEYS_PER_BUCKET_LOG2) + bucket_key_pos;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_footprint_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_footprint_get, 21.11);
 uint64_t
 rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 {
@@ -285,7 +285,7 @@ rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 	return status ? 0 : p.total_size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_create, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_create, 21.11);
 void *
 rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int numa_node)
 {
@@ -309,7 +309,7 @@ rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int nu
 	return t;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_free, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_free, 21.11);
 void
 rte_swx_table_learner_free(void *table)
 {
@@ -321,7 +321,7 @@ rte_swx_table_learner_free(void *table)
 	env_free(t, t->params.total_size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_timeout_update, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_timeout_update, 22.07);
 int
 rte_swx_table_learner_timeout_update(void *table,
 				     uint32_t key_timeout_id,
@@ -359,14 +359,14 @@ struct mailbox {
 	int state;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_mailbox_size_get, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_mailbox_size_get, 21.11);
 uint64_t
 rte_swx_table_learner_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_lookup, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_lookup, 21.11);
 int
 rte_swx_table_learner_lookup(void *table,
 			     void *mailbox,
@@ -453,7 +453,7 @@ rte_swx_table_learner_lookup(void *table,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm, 22.07);
 void
 rte_swx_table_learner_rearm(void *table,
 			    void *mailbox,
@@ -477,7 +477,7 @@ rte_swx_table_learner_rearm(void *table,
 	b->time[bucket_key_pos] = (input_time + key_timeout) >> 32;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm_new, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm_new, 22.07);
 void
 rte_swx_table_learner_rearm_new(void *table,
 				void *mailbox,
@@ -502,7 +502,7 @@ rte_swx_table_learner_rearm_new(void *table,
 	b->key_timeout_id[bucket_key_pos] = (uint8_t)key_timeout_id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_add, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_add, 21.11);
 uint32_t
 rte_swx_table_learner_add(void *table,
 			  void *mailbox,
@@ -579,7 +579,7 @@ rte_swx_table_learner_add(void *table,
 	return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_delete, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_delete, 21.11);
 void
 rte_swx_table_learner_delete(void *table __rte_unused,
 			     void *mailbox)
diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index d42f67f157..060ee4a4b6 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -171,7 +171,7 @@ struct table {
 	uint32_t n_members_per_group_max_log2;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_footprint_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_footprint_get, 21.08);
 uint64_t
 rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_per_group_max)
 {
@@ -184,7 +184,7 @@ rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_p
 	return sizeof(struct table) + group_table_size + members_size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_free, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_free, 21.08);
 void
 rte_swx_table_selector_free(void *table)
 {
@@ -262,7 +262,7 @@ group_set(struct table *t,
 	  uint32_t group_id,
 	  struct rte_swx_table_selector_group *group);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_create, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_create, 21.08);
 void *
 rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
 			      struct rte_swx_table_selector_group **groups,
@@ -532,7 +532,7 @@ group_set(struct table *t,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_group_set, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_group_set, 21.08);
 int
 rte_swx_table_selector_group_set(void *table,
 				 uint32_t group_id,
@@ -547,14 +547,14 @@ struct mailbox {
 
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_mailbox_size_get, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_mailbox_size_get, 21.08);
 uint64_t
 rte_swx_table_selector_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_select, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_select, 21.08);
 int
 rte_swx_table_selector_select(void *table,
 			      void *mailbox __rte_unused,
diff --git a/lib/table/rte_swx_table_wm.c b/lib/table/rte_swx_table_wm.c
index c57738dda3..1b7fa514f5 100644
--- a/lib/table/rte_swx_table_wm.c
+++ b/lib/table/rte_swx_table_wm.c
@@ -458,7 +458,7 @@ table_lookup(void *table,
 	return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_wildcard_match_ops, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_wildcard_match_ops, 21.05);
 struct rte_swx_table_ops rte_swx_table_wildcard_match_ops = {
 	.footprint_get = NULL,
 	.mailbox_size_get = table_mailbox_size_get,
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index 5e9fd5acad..b4b790c044 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -122,7 +122,7 @@ rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
 	return register_cmd(cmd, help, fn, NULL, NULL);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11);
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help)
 {
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 93e9c93c9d..fb014fe389 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -131,7 +131,7 @@ rte_tel_uint_to_hex_encoded_str(char *buf, size_t buf_len, uint64_t val,
 	return len < (int)buf_len ? 0 : -EINVAL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_array_uint_hex, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_array_uint_hex, 23.03);
 int
 rte_tel_data_add_array_uint_hex(struct rte_tel_data *d, uint64_t val,
 				uint8_t display_bitwidth)
@@ -262,7 +262,7 @@ rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_dict_uint_hex, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_dict_uint_hex, 23.03);
 int
 rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 			       uint64_t val, uint8_t display_bitwidth)
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 1288836236..c76fa19cf8 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -1535,7 +1535,7 @@ rte_vhost_enable_guest_notification(int vid, uint16_t queue_id, int enable)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_notify_guest, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_notify_guest, 23.07);
 void
 rte_vhost_notify_guest(int vid, uint16_t queue_id)
 {
@@ -1858,7 +1858,7 @@ async_channel_register(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register, 20.08);
 int
 rte_vhost_async_channel_register(int vid, uint16_t queue_id)
 {
@@ -1892,7 +1892,7 @@ rte_vhost_async_channel_register(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register_thread_unsafe, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register_thread_unsafe, 21.08);
 int
 rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -1915,7 +1915,7 @@ rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id)
 	return async_channel_register(dev, vq);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister, 20.08);
 int
 rte_vhost_async_channel_unregister(int vid, uint16_t queue_id)
 {
@@ -1962,7 +1962,7 @@ rte_vhost_async_channel_unregister(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister_thread_unsafe, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister_thread_unsafe, 21.08);
 int
 rte_vhost_async_channel_unregister_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -1997,7 +1997,7 @@ rte_vhost_async_channel_unregister_thread_unsafe(int vid, uint16_t queue_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_configure, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_configure, 22.03);
 int
 rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
 {
@@ -2074,7 +2074,7 @@ rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight, 21.08);
 int
 rte_vhost_async_get_inflight(int vid, uint16_t queue_id)
 {
@@ -2113,7 +2113,7 @@ rte_vhost_async_get_inflight(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight_thread_unsafe, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight_thread_unsafe, 22.07);
 int
 rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -2304,7 +2304,7 @@ int rte_vhost_vring_stats_reset(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_unconfigure, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_unconfigure, 22.11);
 int
 rte_vhost_async_dma_unconfigure(int16_t dma_id, uint16_t vchan_id)
 {
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index e2454f01a3..699bac781b 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -2342,7 +2342,7 @@ vhost_poll_enqueue_completed(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nr_cpl_pkts;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_poll_enqueue_completed, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_poll_enqueue_completed, 20.08);
 uint16_t
 rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -2398,7 +2398,7 @@ rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
 	return n_pkts_cpl;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue_thread_unsafe, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue_thread_unsafe, 21.08);
 uint16_t
 rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -2456,7 +2456,7 @@ rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
 	return n_pkts_cpl;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue, 22.07);
 uint16_t
 rte_vhost_clear_queue(int vid, uint16_t queue_id, struct rte_mbuf **pkts,
 		uint16_t count, int16_t dma_id, uint16_t vchan_id)
@@ -2572,7 +2572,7 @@ virtio_dev_rx_async_submit(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nb_tx;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_submit_enqueue_burst, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_submit_enqueue_burst, 20.08);
 uint16_t
 rte_vhost_submit_enqueue_burst(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -4204,7 +4204,7 @@ virtio_dev_tx_async_packed_compliant(struct virtio_net *dev, struct vhost_virtqu
 				pkts, count, dma_id, vchan_id, false);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_try_dequeue_burst, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_try_dequeue_burst, 22.07);
 uint16_t
 rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
 	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-- 
2.17.1

