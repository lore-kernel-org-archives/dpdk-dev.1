Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D2CA1005
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 02:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC2040A7F;
	Wed,  3 Sep 2025 04:06:11 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 19145406B4
 for <dev@dpdk.org>; Wed,  3 Sep 2025 04:06:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cGmD32Txjz14MvN;
 Wed,  3 Sep 2025 10:05:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 191A8180B54;
 Wed,  3 Sep 2025 10:05:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 10:05:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v5 1/5] lib: add semicolon when export symbol
Date: Wed, 3 Sep 2025 10:05:43 +0800
Message-ID: <20250903020547.12347-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250903020547.12347-1-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Currently, the RTE_EXPORT_SYMBOL was placed at the beginning of APIs,
but doesn't end with a semicolon. As a result, some IDEs cannot identify
the APIs and cannot quickly jump to the definition.

A semicolon is added to the end of above RTE_EXPORT_SYMBOL in this
commit.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/acl/acl_bld.c                          |   2 +-
 lib/acl/acl_run_scalar.c                   |   2 +-
 lib/acl/rte_acl.c                          |  22 +-
 lib/bbdev/rte_bbdev.c                      |  58 ++---
 lib/bitratestats/rte_bitrate.c             |   8 +-
 lib/bpf/bpf.c                              |   4 +-
 lib/bpf/bpf_convert.c                      |   2 +-
 lib/bpf/bpf_dump.c                         |   2 +-
 lib/bpf/bpf_exec.c                         |   4 +-
 lib/bpf/bpf_load.c                         |   2 +-
 lib/bpf/bpf_load_elf.c                     |   2 +-
 lib/bpf/bpf_pkt.c                          |   8 +-
 lib/bpf/bpf_stub.c                         |   4 +-
 lib/cfgfile/rte_cfgfile.c                  |  34 +--
 lib/cmdline/cmdline.c                      |  18 +-
 lib/cmdline/cmdline_cirbuf.c               |  38 ++--
 lib/cmdline/cmdline_parse.c                |   8 +-
 lib/cmdline/cmdline_parse_etheraddr.c      |   6 +-
 lib/cmdline/cmdline_parse_ipaddr.c         |   6 +-
 lib/cmdline/cmdline_parse_num.c            |   6 +-
 lib/cmdline/cmdline_parse_portlist.c       |   6 +-
 lib/cmdline/cmdline_parse_string.c         |  10 +-
 lib/cmdline/cmdline_rdline.c               |  30 +--
 lib/cmdline/cmdline_socket.c               |   6 +-
 lib/cmdline/cmdline_vt100.c                |   4 +-
 lib/compressdev/rte_comp.c                 |  12 +-
 lib/compressdev/rte_compressdev.c          |  50 ++---
 lib/compressdev/rte_compressdev_pmd.c      |   6 +-
 lib/cryptodev/cryptodev_trace_points.c     |   4 +-
 lib/cryptodev/rte_cryptodev.c              | 136 ++++++------
 lib/distributor/rte_distributor.c          |  18 +-
 lib/dmadev/rte_dmadev.c                    |  30 +--
 lib/eal/arm/rte_cpuflags.c                 |   6 +-
 lib/eal/arm/rte_hypervisor.c               |   2 +-
 lib/eal/arm/rte_power_intrinsics.c         |   8 +-
 lib/eal/common/eal_common_bus.c            |  16 +-
 lib/eal/common/eal_common_class.c          |   8 +-
 lib/eal/common/eal_common_config.c         |  12 +-
 lib/eal/common/eal_common_cpuflags.c       |   2 +-
 lib/eal/common/eal_common_debug.c          |   4 +-
 lib/eal/common/eal_common_dev.c            |  38 ++--
 lib/eal/common/eal_common_devargs.c        |  18 +-
 lib/eal/common/eal_common_errno.c          |   4 +-
 lib/eal/common/eal_common_fbarray.c        |  52 ++---
 lib/eal/common/eal_common_hexdump.c        |   4 +-
 lib/eal/common/eal_common_hypervisor.c     |   2 +-
 lib/eal/common/eal_common_interrupts.c     |  12 +-
 lib/eal/common/eal_common_launch.c         |  10 +-
 lib/eal/common/eal_common_lcore.c          |  34 +--
 lib/eal/common/eal_common_mcfg.c           |  30 +--
 lib/eal/common/eal_common_memory.c         |  58 ++---
 lib/eal/common/eal_common_memzone.c        |  18 +-
 lib/eal/common/eal_common_options.c        |   6 +-
 lib/eal/common/eal_common_proc.c           |  16 +-
 lib/eal/common/eal_common_string_fns.c     |   6 +-
 lib/eal/common/eal_common_tailqs.c         |   6 +-
 lib/eal/common/eal_common_thread.c         |  24 +-
 lib/eal/common/eal_common_timer.c          |   8 +-
 lib/eal/common/eal_common_uuid.c           |   8 +-
 lib/eal/common/rte_keepalive.c             |  12 +-
 lib/eal/common/rte_malloc.c                |  44 ++--
 lib/eal/common/rte_random.c                |   8 +-
 lib/eal/common/rte_reciprocal.c            |   4 +-
 lib/eal/common/rte_service.c               |  62 +++---
 lib/eal/common/rte_version.c               |  14 +-
 lib/eal/freebsd/eal.c                      |  44 ++--
 lib/eal/freebsd/eal_alarm.c                |   4 +-
 lib/eal/freebsd/eal_dev.c                  |   8 +-
 lib/eal/freebsd/eal_interrupts.c           |  22 +-
 lib/eal/freebsd/eal_memory.c               |   6 +-
 lib/eal/freebsd/eal_thread.c               |   4 +-
 lib/eal/freebsd/eal_timer.c                |   2 +-
 lib/eal/linux/eal.c                        |  14 +-
 lib/eal/linux/eal_alarm.c                  |   4 +-
 lib/eal/linux/eal_dev.c                    |   8 +-
 lib/eal/linux/eal_interrupts.c             |  22 +-
 lib/eal/linux/eal_memory.c                 |   6 +-
 lib/eal/linux/eal_thread.c                 |   4 +-
 lib/eal/linux/eal_timer.c                  |   8 +-
 lib/eal/linux/eal_vfio.c                   |  30 +--
 lib/eal/loongarch/rte_cpuflags.c           |   6 +-
 lib/eal/loongarch/rte_hypervisor.c         |   2 +-
 lib/eal/loongarch/rte_power_intrinsics.c   |   8 +-
 lib/eal/ppc/rte_cpuflags.c                 |   6 +-
 lib/eal/ppc/rte_hypervisor.c               |   2 +-
 lib/eal/ppc/rte_power_intrinsics.c         |   8 +-
 lib/eal/riscv/rte_cpuflags.c               |   6 +-
 lib/eal/riscv/rte_hypervisor.c             |   2 +-
 lib/eal/riscv/rte_power_intrinsics.c       |   8 +-
 lib/eal/unix/eal_debug.c                   |   4 +-
 lib/eal/unix/eal_filesystem.c              |   2 +-
 lib/eal/unix/eal_unix_timer.c              |   2 +-
 lib/eal/unix/rte_thread.c                  |  26 +--
 lib/eal/windows/eal.c                      |  10 +-
 lib/eal/windows/eal_alarm.c                |   4 +-
 lib/eal/windows/eal_debug.c                |   2 +-
 lib/eal/windows/eal_dev.c                  |   8 +-
 lib/eal/windows/eal_interrupts.c           |  22 +-
 lib/eal/windows/eal_memory.c               |   6 +-
 lib/eal/windows/eal_mp.c                   |  12 +-
 lib/eal/windows/eal_thread.c               |   2 +-
 lib/eal/windows/eal_timer.c                |   2 +-
 lib/eal/windows/rte_thread.c               |  28 +--
 lib/eal/x86/rte_cpuflags.c                 |   6 +-
 lib/eal/x86/rte_hypervisor.c               |   2 +-
 lib/eal/x86/rte_power_intrinsics.c         |   8 +-
 lib/eal/x86/rte_spinlock.c                 |   2 +-
 lib/efd/rte_efd.c                          |  14 +-
 lib/ethdev/ethdev_private.c                |   4 +-
 lib/ethdev/rte_ethdev.c                    | 246 ++++++++++-----------
 lib/ethdev/rte_flow.c                      |  18 +-
 lib/ethdev/rte_tm.c                        |  60 ++---
 lib/eventdev/eventdev_trace_points.c       |  16 +-
 lib/eventdev/rte_event_crypto_adapter.c    |  24 +-
 lib/eventdev/rte_event_eth_rx_adapter.c    |  36 +--
 lib/eventdev/rte_event_eth_tx_adapter.c    |  28 +--
 lib/eventdev/rte_event_ring.c              |   8 +-
 lib/eventdev/rte_event_timer_adapter.c     |  20 +-
 lib/eventdev/rte_eventdev.c                |  72 +++---
 lib/fib/rte_fib.c                          |  18 +-
 lib/fib/rte_fib6.c                         |  18 +-
 lib/graph/graph.c                          |  32 +--
 lib/graph/graph_debug.c                    |   2 +-
 lib/graph/graph_stats.c                    |   8 +-
 lib/graph/node.c                           |  22 +-
 lib/graph/rte_graph_model_mcore_dispatch.c |   6 +-
 lib/graph/rte_graph_worker.c               |   6 +-
 lib/gro/rte_gro.c                          |  12 +-
 lib/gso/rte_gso.c                          |   2 +-
 lib/hash/rte_cuckoo_hash.c                 |  52 ++---
 lib/hash/rte_fbk_hash.c                    |   6 +-
 lib/hash/rte_hash_crc.c                    |   4 +-
 lib/hash/rte_thash.c                       |  22 +-
 lib/ip_frag/rte_ip_frag_common.c           |  10 +-
 lib/ip_frag/rte_ipv4_fragmentation.c       |   4 +-
 lib/ip_frag/rte_ipv4_reassembly.c          |   2 +-
 lib/ip_frag/rte_ipv6_fragmentation.c       |   2 +-
 lib/ip_frag/rte_ipv6_reassembly.c          |   2 +-
 lib/ipsec/ipsec_sad.c                      |  12 +-
 lib/ipsec/ipsec_telemetry.c                |   4 +-
 lib/ipsec/sa.c                             |   8 +-
 lib/ipsec/ses.c                            |   2 +-
 lib/jobstats/rte_jobstats.c                |  28 +--
 lib/kvargs/rte_kvargs.c                    |  16 +-
 lib/latencystats/rte_latencystats.c        |  10 +-
 lib/log/log.c                              |  34 +--
 lib/lpm/rte_lpm.c                          |  16 +-
 lib/lpm/rte_lpm6.c                         |  20 +-
 lib/mbuf/rte_mbuf.c                        |  34 +--
 lib/mbuf/rte_mbuf_dyn.c                    |  18 +-
 lib/mbuf/rte_mbuf_pool_ops.c               |  10 +-
 lib/mbuf/rte_mbuf_ptype.c                  |  16 +-
 lib/member/rte_member.c                    |  26 +--
 lib/mempool/rte_mempool.c                  |  46 ++--
 lib/mempool/rte_mempool_ops.c              |   8 +-
 lib/mempool/rte_mempool_ops_default.c      |   8 +-
 lib/meter/rte_meter.c                      |  12 +-
 lib/metrics/rte_metrics.c                  |  16 +-
 lib/net/rte_arp.c                          |   2 +-
 lib/net/rte_ether.c                        |   6 +-
 lib/net/rte_net.c                          |   4 +-
 lib/net/rte_net_crc.c                      |   6 +-
 lib/node/ethdev_ctrl.c                     |   2 +-
 lib/node/ip4_lookup.c                      |   2 +-
 lib/node/ip4_rewrite.c                     |   2 +-
 lib/pcapng/rte_pcapng.c                    |  14 +-
 lib/pci/rte_pci.c                          |   6 +-
 lib/pdump/rte_pdump.c                      |  18 +-
 lib/pipeline/rte_pipeline.c                |  46 ++--
 lib/port/rte_port_ethdev.c                 |   6 +-
 lib/port/rte_port_fd.c                     |   6 +-
 lib/port/rte_port_frag.c                   |   4 +-
 lib/port/rte_port_ras.c                    |   4 +-
 lib/port/rte_port_ring.c                   |  12 +-
 lib/port/rte_port_sched.c                  |   4 +-
 lib/port/rte_port_source_sink.c            |   4 +-
 lib/port/rte_port_sym_crypto.c             |   6 +-
 lib/power/rte_power_cpufreq.c              |  34 +--
 lib/power/rte_power_pmd_mgmt.c             |  20 +-
 lib/power/rte_power_uncore.c               |  18 +-
 lib/rawdev/rte_rawdev.c                    |  60 ++---
 lib/rcu/rte_rcu_qsbr.c                     |  22 +-
 lib/reorder/rte_reorder.c                  |  14 +-
 lib/rib/rte_rib.c                          |  28 +--
 lib/rib/rte_rib6.c                         |  28 +--
 lib/ring/rte_ring.c                        |  20 +-
 lib/sched/rte_approx.c                     |   2 +-
 lib/sched/rte_pie.c                        |   4 +-
 lib/sched/rte_red.c                        |  12 +-
 lib/sched/rte_sched.c                      |  30 +--
 lib/security/rte_security.c                |  30 +--
 lib/stack/rte_stack.c                      |   6 +-
 lib/table/rte_table_acl.c                  |   2 +-
 lib/table/rte_table_array.c                |   2 +-
 lib/table/rte_table_hash_cuckoo.c          |   2 +-
 lib/table/rte_table_hash_ext.c             |   2 +-
 lib/table/rte_table_hash_key16.c           |   4 +-
 lib/table/rte_table_hash_key32.c           |   4 +-
 lib/table/rte_table_hash_key8.c            |   4 +-
 lib/table/rte_table_hash_lru.c             |   2 +-
 lib/table/rte_table_lpm.c                  |   2 +-
 lib/table/rte_table_lpm_ipv6.c             |   2 +-
 lib/table/rte_table_stub.c                 |   2 +-
 lib/telemetry/telemetry.c                  |   2 +-
 lib/telemetry/telemetry_data.c             |  30 +--
 lib/timer/rte_timer.c                      |  36 +--
 lib/vhost/socket.c                         |  32 +--
 lib/vhost/vdpa.c                           |  16 +-
 lib/vhost/vhost.c                          |  64 +++---
 lib/vhost/vhost_crypto.c                   |  12 +-
 lib/vhost/vhost_user.c                     |   2 +-
 lib/vhost/virtio_net.c                     |   4 +-
 212 files changed, 1657 insertions(+), 1657 deletions(-)

diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 7056b1c117..5ec1202bd4 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -1622,7 +1622,7 @@ get_first_load_size(const struct rte_acl_config *cfg)
 	return (ofs < max_ofs) ? sizeof(uint32_t) : sizeof(uint8_t);
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_build)
+RTE_EXPORT_SYMBOL(rte_acl_build);
 int
 rte_acl_build(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 {
diff --git a/lib/acl/acl_run_scalar.c b/lib/acl/acl_run_scalar.c
index 32ebe3119b..24d160bf8c 100644
--- a/lib/acl/acl_run_scalar.c
+++ b/lib/acl/acl_run_scalar.c
@@ -108,7 +108,7 @@ scalar_transition(const uint64_t *trans_table, uint64_t transition,
 	return transition;
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_classify_scalar)
+RTE_EXPORT_SYMBOL(rte_acl_classify_scalar);
 int
 rte_acl_classify_scalar(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories)
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 8c0ca29618..60e9d7d336 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -264,7 +264,7 @@ acl_get_best_alg(void)
 	return alg[i];
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
+RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify);
 extern int
 rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
 {
@@ -287,7 +287,7 @@ rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_classify_alg)
+RTE_EXPORT_SYMBOL(rte_acl_classify_alg);
 int
 rte_acl_classify_alg(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories,
@@ -300,7 +300,7 @@ rte_acl_classify_alg(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	return classify_fns[alg](ctx, data, results, num, categories);
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_classify)
+RTE_EXPORT_SYMBOL(rte_acl_classify);
 int
 rte_acl_classify(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories)
@@ -309,7 +309,7 @@ rte_acl_classify(const struct rte_acl_ctx *ctx, const uint8_t **data,
 		ctx->alg);
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_find_existing)
+RTE_EXPORT_SYMBOL(rte_acl_find_existing);
 struct rte_acl_ctx *
 rte_acl_find_existing(const char *name)
 {
@@ -334,7 +334,7 @@ rte_acl_find_existing(const char *name)
 	return ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_free)
+RTE_EXPORT_SYMBOL(rte_acl_free);
 void
 rte_acl_free(struct rte_acl_ctx *ctx)
 {
@@ -367,7 +367,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_create)
+RTE_EXPORT_SYMBOL(rte_acl_create);
 struct rte_acl_ctx *
 rte_acl_create(const struct rte_acl_param *param)
 {
@@ -464,7 +464,7 @@ acl_check_rule(const struct rte_acl_rule_data *rd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_acl_add_rules)
+RTE_EXPORT_SYMBOL(rte_acl_add_rules);
 int
 rte_acl_add_rules(struct rte_acl_ctx *ctx, const struct rte_acl_rule *rules,
 	uint32_t num)
@@ -494,7 +494,7 @@ rte_acl_add_rules(struct rte_acl_ctx *ctx, const struct rte_acl_rule *rules,
  * Reset all rules.
  * Note that RT structures are not affected.
  */
-RTE_EXPORT_SYMBOL(rte_acl_reset_rules)
+RTE_EXPORT_SYMBOL(rte_acl_reset_rules);
 void
 rte_acl_reset_rules(struct rte_acl_ctx *ctx)
 {
@@ -505,7 +505,7 @@ rte_acl_reset_rules(struct rte_acl_ctx *ctx)
 /*
  * Reset all rules and destroys RT structures.
  */
-RTE_EXPORT_SYMBOL(rte_acl_reset)
+RTE_EXPORT_SYMBOL(rte_acl_reset);
 void
 rte_acl_reset(struct rte_acl_ctx *ctx)
 {
@@ -518,7 +518,7 @@ rte_acl_reset(struct rte_acl_ctx *ctx)
 /*
  * Dump ACL context to the stdout.
  */
-RTE_EXPORT_SYMBOL(rte_acl_dump)
+RTE_EXPORT_SYMBOL(rte_acl_dump);
 void
 rte_acl_dump(const struct rte_acl_ctx *ctx)
 {
@@ -538,7 +538,7 @@ rte_acl_dump(const struct rte_acl_ctx *ctx)
 /*
  * Dump all ACL contexts to the stdout.
  */
-RTE_EXPORT_SYMBOL(rte_acl_list_dump)
+RTE_EXPORT_SYMBOL(rte_acl_list_dump);
 void
 rte_acl_list_dump(void)
 {
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..ddcb51c510 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -93,7 +93,7 @@ static rte_spinlock_t rte_bbdev_cb_lock = RTE_SPINLOCK_INITIALIZER;
  * Global array of all devices. This is not static because it's used by the
  * inline enqueue and dequeue functions
  */
-RTE_EXPORT_SYMBOL(rte_bbdev_devices)
+RTE_EXPORT_SYMBOL(rte_bbdev_devices);
 struct rte_bbdev rte_bbdev_devices[RTE_BBDEV_MAX_DEVS];
 
 /* Global array with rte_bbdev_data structures */
@@ -175,7 +175,7 @@ find_free_dev_id(void)
 	return RTE_BBDEV_MAX_DEVS;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_allocate)
+RTE_EXPORT_SYMBOL(rte_bbdev_allocate);
 struct rte_bbdev *
 rte_bbdev_allocate(const char *name)
 {
@@ -235,7 +235,7 @@ rte_bbdev_allocate(const char *name)
 	return bbdev;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_release)
+RTE_EXPORT_SYMBOL(rte_bbdev_release);
 int
 rte_bbdev_release(struct rte_bbdev *bbdev)
 {
@@ -271,7 +271,7 @@ rte_bbdev_release(struct rte_bbdev *bbdev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_get_named_dev)
+RTE_EXPORT_SYMBOL(rte_bbdev_get_named_dev);
 struct rte_bbdev *
 rte_bbdev_get_named_dev(const char *name)
 {
@@ -292,14 +292,14 @@ rte_bbdev_get_named_dev(const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_count)
+RTE_EXPORT_SYMBOL(rte_bbdev_count);
 uint16_t
 rte_bbdev_count(void)
 {
 	return num_devs;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_is_valid)
+RTE_EXPORT_SYMBOL(rte_bbdev_is_valid);
 bool
 rte_bbdev_is_valid(uint16_t dev_id)
 {
@@ -309,7 +309,7 @@ rte_bbdev_is_valid(uint16_t dev_id)
 	return false;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_find_next)
+RTE_EXPORT_SYMBOL(rte_bbdev_find_next);
 uint16_t
 rte_bbdev_find_next(uint16_t dev_id)
 {
@@ -320,7 +320,7 @@ rte_bbdev_find_next(uint16_t dev_id)
 	return dev_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_setup_queues)
+RTE_EXPORT_SYMBOL(rte_bbdev_setup_queues);
 int
 rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 {
@@ -413,7 +413,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_intr_enable)
+RTE_EXPORT_SYMBOL(rte_bbdev_intr_enable);
 int
 rte_bbdev_intr_enable(uint16_t dev_id)
 {
@@ -446,7 +446,7 @@ rte_bbdev_intr_enable(uint16_t dev_id)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_configure)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_configure);
 int
 rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 		const struct rte_bbdev_queue_conf *conf)
@@ -568,7 +568,7 @@ rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_start)
+RTE_EXPORT_SYMBOL(rte_bbdev_start);
 int
 rte_bbdev_start(uint16_t dev_id)
 {
@@ -603,7 +603,7 @@ rte_bbdev_start(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_stop)
+RTE_EXPORT_SYMBOL(rte_bbdev_stop);
 int
 rte_bbdev_stop(uint16_t dev_id)
 {
@@ -627,7 +627,7 @@ rte_bbdev_stop(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_close)
+RTE_EXPORT_SYMBOL(rte_bbdev_close);
 int
 rte_bbdev_close(uint16_t dev_id)
 {
@@ -675,7 +675,7 @@ rte_bbdev_close(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_start)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_start);
 int
 rte_bbdev_queue_start(uint16_t dev_id, uint16_t queue_id)
 {
@@ -708,7 +708,7 @@ rte_bbdev_queue_start(uint16_t dev_id, uint16_t queue_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_stop)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_stop);
 int
 rte_bbdev_queue_stop(uint16_t dev_id, uint16_t queue_id)
 {
@@ -773,7 +773,7 @@ reset_stats_in_queues(struct rte_bbdev *dev)
 	rte_bbdev_log_debug("Reset stats on %u", dev->data->dev_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_stats_get)
+RTE_EXPORT_SYMBOL(rte_bbdev_stats_get);
 int
 rte_bbdev_stats_get(uint16_t dev_id, struct rte_bbdev_stats *stats)
 {
@@ -797,7 +797,7 @@ rte_bbdev_stats_get(uint16_t dev_id, struct rte_bbdev_stats *stats)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_stats_reset)
+RTE_EXPORT_SYMBOL(rte_bbdev_stats_reset);
 int
 rte_bbdev_stats_reset(uint16_t dev_id)
 {
@@ -815,7 +815,7 @@ rte_bbdev_stats_reset(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_info_get)
+RTE_EXPORT_SYMBOL(rte_bbdev_info_get);
 int
 rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
 {
@@ -844,7 +844,7 @@ rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_info_get)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_info_get);
 int
 rte_bbdev_queue_info_get(uint16_t dev_id, uint16_t queue_id,
 		struct rte_bbdev_queue_info *queue_info)
@@ -931,7 +931,7 @@ bbdev_op_init(struct rte_mempool *mempool, void *arg, void *element,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_op_pool_create)
+RTE_EXPORT_SYMBOL(rte_bbdev_op_pool_create);
 struct rte_mempool *
 rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 		unsigned int num_elements, unsigned int cache_size,
@@ -979,7 +979,7 @@ rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 	return mp;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_callback_register)
+RTE_EXPORT_SYMBOL(rte_bbdev_callback_register);
 int
 rte_bbdev_callback_register(uint16_t dev_id, enum rte_bbdev_event_type event,
 		rte_bbdev_cb_fn cb_fn, void *cb_arg)
@@ -1025,7 +1025,7 @@ rte_bbdev_callback_register(uint16_t dev_id, enum rte_bbdev_event_type event,
 	return (user_cb == NULL) ? -ENOMEM : 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_bbdev_callback_unregister);
 int
 rte_bbdev_callback_unregister(uint16_t dev_id, enum rte_bbdev_event_type event,
 		rte_bbdev_cb_fn cb_fn, void *cb_arg)
@@ -1071,7 +1071,7 @@ rte_bbdev_callback_unregister(uint16_t dev_id, enum rte_bbdev_event_type event,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_pmd_callback_process)
+RTE_EXPORT_SYMBOL(rte_bbdev_pmd_callback_process);
 void
 rte_bbdev_pmd_callback_process(struct rte_bbdev *dev,
 	enum rte_bbdev_event_type event, void *ret_param)
@@ -1114,7 +1114,7 @@ rte_bbdev_pmd_callback_process(struct rte_bbdev *dev,
 	rte_spinlock_unlock(&rte_bbdev_cb_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_enable)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_enable);
 int
 rte_bbdev_queue_intr_enable(uint16_t dev_id, uint16_t queue_id)
 {
@@ -1126,7 +1126,7 @@ rte_bbdev_queue_intr_enable(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_intr_enable(dev, queue_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_disable)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_disable);
 int
 rte_bbdev_queue_intr_disable(uint16_t dev_id, uint16_t queue_id)
 {
@@ -1138,7 +1138,7 @@ rte_bbdev_queue_intr_disable(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_intr_disable(dev, queue_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_ctl)
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_ctl);
 int
 rte_bbdev_queue_intr_ctl(uint16_t dev_id, uint16_t queue_id, int epfd, int op,
 		void *data)
@@ -1176,7 +1176,7 @@ rte_bbdev_queue_intr_ctl(uint16_t dev_id, uint16_t queue_id, int epfd, int op,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_bbdev_op_type_str)
+RTE_EXPORT_SYMBOL(rte_bbdev_op_type_str);
 const char *
 rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type)
 {
@@ -1197,7 +1197,7 @@ rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_device_status_str)
+RTE_EXPORT_SYMBOL(rte_bbdev_device_status_str);
 const char *
 rte_bbdev_device_status_str(enum rte_bbdev_device_status status)
 {
@@ -1221,7 +1221,7 @@ rte_bbdev_device_status_str(enum rte_bbdev_device_status status)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_bbdev_enqueue_status_str)
+RTE_EXPORT_SYMBOL(rte_bbdev_enqueue_status_str);
 const char *
 rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status)
 {
diff --git a/lib/bitratestats/rte_bitrate.c b/lib/bitratestats/rte_bitrate.c
index 592e478e06..4fe8ce452c 100644
--- a/lib/bitratestats/rte_bitrate.c
+++ b/lib/bitratestats/rte_bitrate.c
@@ -29,7 +29,7 @@ struct rte_stats_bitrates {
 	uint16_t id_stats_set;
 };
 
-RTE_EXPORT_SYMBOL(rte_stats_bitrate_create)
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_create);
 struct rte_stats_bitrates *
 rte_stats_bitrate_create(void)
 {
@@ -37,14 +37,14 @@ rte_stats_bitrate_create(void)
 		RTE_CACHE_LINE_SIZE);
 }
 
-RTE_EXPORT_SYMBOL(rte_stats_bitrate_free)
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_free);
 void
 rte_stats_bitrate_free(struct rte_stats_bitrates *bitrate_data)
 {
 	rte_free(bitrate_data);
 }
 
-RTE_EXPORT_SYMBOL(rte_stats_bitrate_reg)
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_reg);
 int
 rte_stats_bitrate_reg(struct rte_stats_bitrates *bitrate_data)
 {
@@ -66,7 +66,7 @@ rte_stats_bitrate_reg(struct rte_stats_bitrates *bitrate_data)
 	return return_value;
 }
 
-RTE_EXPORT_SYMBOL(rte_stats_bitrate_calc)
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_calc);
 int
 rte_stats_bitrate_calc(struct rte_stats_bitrates *bitrate_data,
 			uint16_t port_id)
diff --git a/lib/bpf/bpf.c b/lib/bpf/bpf.c
index 5239b3e11e..2a21934a22 100644
--- a/lib/bpf/bpf.c
+++ b/lib/bpf/bpf.c
@@ -11,7 +11,7 @@
 
 #include "bpf_impl.h"
 
-RTE_EXPORT_SYMBOL(rte_bpf_destroy)
+RTE_EXPORT_SYMBOL(rte_bpf_destroy);
 void
 rte_bpf_destroy(struct rte_bpf *bpf)
 {
@@ -22,7 +22,7 @@ rte_bpf_destroy(struct rte_bpf *bpf)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_get_jit)
+RTE_EXPORT_SYMBOL(rte_bpf_get_jit);
 int
 rte_bpf_get_jit(const struct rte_bpf *bpf, struct rte_bpf_jit *jit)
 {
diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index 86e703299d..129457741d 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -518,7 +518,7 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_convert)
+RTE_EXPORT_SYMBOL(rte_bpf_convert);
 struct rte_bpf_prm *
 rte_bpf_convert(const struct bpf_program *prog)
 {
diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index 6ee0e32b43..e2a4f48a2d 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -44,7 +44,7 @@ static const char *const jump_tbl[16] = {
 	[EBPF_CALL >> 4] = "call", [EBPF_EXIT >> 4] = "exit",
 };
 
-RTE_EXPORT_SYMBOL(rte_bpf_dump)
+RTE_EXPORT_SYMBOL(rte_bpf_dump);
 void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 {
 	uint32_t i;
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 4b5ea9f1a4..7090be62e1 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -476,7 +476,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_exec_burst)
+RTE_EXPORT_SYMBOL(rte_bpf_exec_burst);
 uint32_t
 rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	uint32_t num)
@@ -496,7 +496,7 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_exec)
+RTE_EXPORT_SYMBOL(rte_bpf_exec);
 uint64_t
 rte_bpf_exec(const struct rte_bpf *bpf, void *ctx)
 {
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 556e613762..5050cbf34d 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -80,7 +80,7 @@ bpf_check_xsym(const struct rte_bpf_xsym *xsym)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_load)
+RTE_EXPORT_SYMBOL(rte_bpf_load);
 struct rte_bpf *
 rte_bpf_load(const struct rte_bpf_prm *prm)
 {
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 1d30ba17e2..26cf263ba2 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -295,7 +295,7 @@ bpf_load_elf(const struct rte_bpf_prm *prm, int32_t fd, const char *section)
 	return bpf;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
+RTE_EXPORT_SYMBOL(rte_bpf_elf_load);
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 	const char *sname)
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..7167603bf0 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -466,7 +466,7 @@ bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_unload)
+RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_unload);
 void
 rte_bpf_eth_rx_unload(uint16_t port, uint16_t queue)
 {
@@ -478,7 +478,7 @@ rte_bpf_eth_rx_unload(uint16_t port, uint16_t queue)
 	rte_spinlock_unlock(&cbh->lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_unload)
+RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_unload);
 void
 rte_bpf_eth_tx_unload(uint16_t port, uint16_t queue)
 {
@@ -560,7 +560,7 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_elf_load)
+RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_elf_load);
 int
 rte_bpf_eth_rx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
@@ -577,7 +577,7 @@ rte_bpf_eth_rx_elf_load(uint16_t port, uint16_t queue,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_elf_load)
+RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_elf_load);
 int
 rte_bpf_eth_tx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
diff --git a/lib/bpf/bpf_stub.c b/lib/bpf/bpf_stub.c
index dea0d703ca..fdefa70e91 100644
--- a/lib/bpf/bpf_stub.c
+++ b/lib/bpf/bpf_stub.c
@@ -11,7 +11,7 @@
  */
 
 #ifndef RTE_LIBRTE_BPF_ELF
-RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
+RTE_EXPORT_SYMBOL(rte_bpf_elf_load);
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 	const char *sname)
@@ -29,7 +29,7 @@ rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 #endif
 
 #ifndef RTE_HAS_LIBPCAP
-RTE_EXPORT_SYMBOL(rte_bpf_convert)
+RTE_EXPORT_SYMBOL(rte_bpf_convert);
 struct rte_bpf_prm *
 rte_bpf_convert(const struct bpf_program *prog)
 {
diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 9723ec756f..68f788dd0f 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -159,7 +159,7 @@ rte_cfgfile_check_params(const struct rte_cfgfile_parameters *params)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_load)
+RTE_EXPORT_SYMBOL(rte_cfgfile_load);
 struct rte_cfgfile *
 rte_cfgfile_load(const char *filename, int flags)
 {
@@ -167,7 +167,7 @@ rte_cfgfile_load(const char *filename, int flags)
 					    &default_cfgfile_params);
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_load_with_params)
+RTE_EXPORT_SYMBOL(rte_cfgfile_load_with_params);
 struct rte_cfgfile *
 rte_cfgfile_load_with_params(const char *filename, int flags,
 			     const struct rte_cfgfile_parameters *params)
@@ -272,7 +272,7 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_create)
+RTE_EXPORT_SYMBOL(rte_cfgfile_create);
 struct rte_cfgfile *
 rte_cfgfile_create(int flags)
 {
@@ -329,7 +329,7 @@ rte_cfgfile_create(int flags)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_add_section)
+RTE_EXPORT_SYMBOL(rte_cfgfile_add_section);
 int
 rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
@@ -371,7 +371,7 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_add_entry)
+RTE_EXPORT_SYMBOL(rte_cfgfile_add_entry);
 int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
@@ -396,7 +396,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
+RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry);
 int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname, const char *entryvalue)
 {
@@ -425,7 +425,7 @@ int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_save)
+RTE_EXPORT_SYMBOL(rte_cfgfile_save);
 int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 {
 	int i, j;
@@ -450,7 +450,7 @@ int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 	return fclose(f);
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_close)
+RTE_EXPORT_SYMBOL(rte_cfgfile_close);
 int rte_cfgfile_close(struct rte_cfgfile *cfg)
 {
 	int i;
@@ -474,7 +474,7 @@ int rte_cfgfile_close(struct rte_cfgfile *cfg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections)
+RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections);
 int
 rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
 	size_t length)
@@ -492,7 +492,7 @@ rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
 	return num_sections;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_sections)
+RTE_EXPORT_SYMBOL(rte_cfgfile_sections);
 int
 rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 	int max_sections)
@@ -505,14 +505,14 @@ rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_has_section)
+RTE_EXPORT_SYMBOL(rte_cfgfile_has_section);
 int
 rte_cfgfile_has_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
 	return _get_section(cfg, sectionname) != NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries)
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries);
 int
 rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	const char *sectionname)
@@ -523,7 +523,7 @@ rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	return s->num_entries;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries_by_index)
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries_by_index);
 int
 rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	char *sectionname, int index)
@@ -536,7 +536,7 @@ rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	strlcpy(sectionname, sect->name, CFG_NAME_LEN);
 	return sect->num_entries;
 }
-RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries)
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries);
 int
 rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 		struct rte_cfgfile_entry *entries, int max_entries)
@@ -550,7 +550,7 @@ rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries_by_index)
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries_by_index);
 int
 rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 		char *sectionname,
@@ -568,7 +568,7 @@ rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_get_entry)
+RTE_EXPORT_SYMBOL(rte_cfgfile_get_entry);
 const char *
 rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
@@ -584,7 +584,7 @@ rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cfgfile_has_entry)
+RTE_EXPORT_SYMBOL(rte_cfgfile_has_entry);
 int
 rte_cfgfile_has_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
diff --git a/lib/cmdline/cmdline.c b/lib/cmdline/cmdline.c
index d1003f0b8e..eae053b184 100644
--- a/lib/cmdline/cmdline.c
+++ b/lib/cmdline/cmdline.c
@@ -40,7 +40,7 @@ cmdline_complete_buffer(struct rdline *rdl, const char *buf,
 	return cmdline_complete(cl, buf, state, dstbuf, dstsize);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_write_char)
+RTE_EXPORT_SYMBOL(cmdline_write_char);
 int
 cmdline_write_char(struct rdline *rdl, char c)
 {
@@ -59,7 +59,7 @@ cmdline_write_char(struct rdline *rdl, char c)
 }
 
 
-RTE_EXPORT_SYMBOL(cmdline_set_prompt)
+RTE_EXPORT_SYMBOL(cmdline_set_prompt);
 void
 cmdline_set_prompt(struct cmdline *cl, const char *prompt)
 {
@@ -68,7 +68,7 @@ cmdline_set_prompt(struct cmdline *cl, const char *prompt)
 	strlcpy(cl->prompt, prompt, sizeof(cl->prompt));
 }
 
-RTE_EXPORT_SYMBOL(cmdline_new)
+RTE_EXPORT_SYMBOL(cmdline_new);
 struct cmdline *
 cmdline_new(cmdline_parse_ctx_t *ctx, const char *prompt, int s_in, int s_out)
 {
@@ -99,14 +99,14 @@ cmdline_new(cmdline_parse_ctx_t *ctx, const char *prompt, int s_in, int s_out)
 	return cl;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_get_rdline)
+RTE_EXPORT_SYMBOL(cmdline_get_rdline);
 struct rdline*
 cmdline_get_rdline(struct cmdline *cl)
 {
 	return &cl->rdl;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_free)
+RTE_EXPORT_SYMBOL(cmdline_free);
 void
 cmdline_free(struct cmdline *cl)
 {
@@ -122,7 +122,7 @@ cmdline_free(struct cmdline *cl)
 	free(cl);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_printf)
+RTE_EXPORT_SYMBOL(cmdline_printf);
 void
 cmdline_printf(const struct cmdline *cl, const char *fmt, ...)
 {
@@ -138,7 +138,7 @@ cmdline_printf(const struct cmdline *cl, const char *fmt, ...)
 	va_end(ap);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_in)
+RTE_EXPORT_SYMBOL(cmdline_in);
 int
 cmdline_in(struct cmdline *cl, const char *buf, int size)
 {
@@ -176,7 +176,7 @@ cmdline_in(struct cmdline *cl, const char *buf, int size)
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_quit)
+RTE_EXPORT_SYMBOL(cmdline_quit);
 void
 cmdline_quit(struct cmdline *cl)
 {
@@ -186,7 +186,7 @@ cmdline_quit(struct cmdline *cl)
 	rdline_quit(&cl->rdl);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_interact)
+RTE_EXPORT_SYMBOL(cmdline_interact);
 void
 cmdline_interact(struct cmdline *cl)
 {
diff --git a/lib/cmdline/cmdline_cirbuf.c b/lib/cmdline/cmdline_cirbuf.c
index 07d9fc6b90..b74d61bb52 100644
--- a/lib/cmdline/cmdline_cirbuf.c
+++ b/lib/cmdline/cmdline_cirbuf.c
@@ -13,7 +13,7 @@
 #include <eal_export.h>
 
 
-RTE_EXPORT_SYMBOL(cirbuf_init)
+RTE_EXPORT_SYMBOL(cirbuf_init);
 int
 cirbuf_init(struct cirbuf *cbuf, char *buf, unsigned int start, unsigned int maxlen)
 {
@@ -29,7 +29,7 @@ cirbuf_init(struct cirbuf *cbuf, char *buf, unsigned int start, unsigned int max
 
 /* multiple add */
 
-RTE_EXPORT_SYMBOL(cirbuf_add_buf_head)
+RTE_EXPORT_SYMBOL(cirbuf_add_buf_head);
 int
 cirbuf_add_buf_head(struct cirbuf *cbuf, const char *c, unsigned int n)
 {
@@ -61,7 +61,7 @@ cirbuf_add_buf_head(struct cirbuf *cbuf, const char *c, unsigned int n)
 
 /* multiple add */
 
-RTE_EXPORT_SYMBOL(cirbuf_add_buf_tail)
+RTE_EXPORT_SYMBOL(cirbuf_add_buf_tail);
 int
 cirbuf_add_buf_tail(struct cirbuf *cbuf, const char *c, unsigned int n)
 {
@@ -105,7 +105,7 @@ __cirbuf_add_head(struct cirbuf * cbuf, char c)
 	cbuf->len ++;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_add_head_safe)
+RTE_EXPORT_SYMBOL(cirbuf_add_head_safe);
 int
 cirbuf_add_head_safe(struct cirbuf * cbuf, char c)
 {
@@ -116,7 +116,7 @@ cirbuf_add_head_safe(struct cirbuf * cbuf, char c)
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_add_head)
+RTE_EXPORT_SYMBOL(cirbuf_add_head);
 void
 cirbuf_add_head(struct cirbuf * cbuf, char c)
 {
@@ -136,7 +136,7 @@ __cirbuf_add_tail(struct cirbuf * cbuf, char c)
 	cbuf->len ++;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_add_tail_safe)
+RTE_EXPORT_SYMBOL(cirbuf_add_tail_safe);
 int
 cirbuf_add_tail_safe(struct cirbuf * cbuf, char c)
 {
@@ -147,7 +147,7 @@ cirbuf_add_tail_safe(struct cirbuf * cbuf, char c)
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_add_tail)
+RTE_EXPORT_SYMBOL(cirbuf_add_tail);
 void
 cirbuf_add_tail(struct cirbuf * cbuf, char c)
 {
@@ -190,7 +190,7 @@ __cirbuf_shift_right(struct cirbuf *cbuf)
 }
 
 /* XXX we could do a better algorithm here... */
-RTE_EXPORT_SYMBOL(cirbuf_align_left)
+RTE_EXPORT_SYMBOL(cirbuf_align_left);
 int
 cirbuf_align_left(struct cirbuf * cbuf)
 {
@@ -212,7 +212,7 @@ cirbuf_align_left(struct cirbuf * cbuf)
 }
 
 /* XXX we could do a better algorithm here... */
-RTE_EXPORT_SYMBOL(cirbuf_align_right)
+RTE_EXPORT_SYMBOL(cirbuf_align_right);
 int
 cirbuf_align_right(struct cirbuf * cbuf)
 {
@@ -235,7 +235,7 @@ cirbuf_align_right(struct cirbuf * cbuf)
 
 /* buffer del */
 
-RTE_EXPORT_SYMBOL(cirbuf_del_buf_head)
+RTE_EXPORT_SYMBOL(cirbuf_del_buf_head);
 int
 cirbuf_del_buf_head(struct cirbuf *cbuf, unsigned int size)
 {
@@ -256,7 +256,7 @@ cirbuf_del_buf_head(struct cirbuf *cbuf, unsigned int size)
 
 /* buffer del */
 
-RTE_EXPORT_SYMBOL(cirbuf_del_buf_tail)
+RTE_EXPORT_SYMBOL(cirbuf_del_buf_tail);
 int
 cirbuf_del_buf_tail(struct cirbuf *cbuf, unsigned int size)
 {
@@ -287,7 +287,7 @@ __cirbuf_del_head(struct cirbuf * cbuf)
 	}
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_del_head_safe)
+RTE_EXPORT_SYMBOL(cirbuf_del_head_safe);
 int
 cirbuf_del_head_safe(struct cirbuf * cbuf)
 {
@@ -298,7 +298,7 @@ cirbuf_del_head_safe(struct cirbuf * cbuf)
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_del_head)
+RTE_EXPORT_SYMBOL(cirbuf_del_head);
 void
 cirbuf_del_head(struct cirbuf * cbuf)
 {
@@ -317,7 +317,7 @@ __cirbuf_del_tail(struct cirbuf * cbuf)
 	}
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_del_tail_safe)
+RTE_EXPORT_SYMBOL(cirbuf_del_tail_safe);
 int
 cirbuf_del_tail_safe(struct cirbuf * cbuf)
 {
@@ -328,7 +328,7 @@ cirbuf_del_tail_safe(struct cirbuf * cbuf)
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(cirbuf_del_tail)
+RTE_EXPORT_SYMBOL(cirbuf_del_tail);
 void
 cirbuf_del_tail(struct cirbuf * cbuf)
 {
@@ -337,7 +337,7 @@ cirbuf_del_tail(struct cirbuf * cbuf)
 
 /* convert to buffer */
 
-RTE_EXPORT_SYMBOL(cirbuf_get_buf_head)
+RTE_EXPORT_SYMBOL(cirbuf_get_buf_head);
 int
 cirbuf_get_buf_head(struct cirbuf *cbuf, char *c, unsigned int size)
 {
@@ -376,7 +376,7 @@ cirbuf_get_buf_head(struct cirbuf *cbuf, char *c, unsigned int size)
 
 /* convert to buffer */
 
-RTE_EXPORT_SYMBOL(cirbuf_get_buf_tail)
+RTE_EXPORT_SYMBOL(cirbuf_get_buf_tail);
 int
 cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c, unsigned int size)
 {
@@ -416,7 +416,7 @@ cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c, unsigned int size)
 
 /* get head or get tail */
 
-RTE_EXPORT_SYMBOL(cirbuf_get_head)
+RTE_EXPORT_SYMBOL(cirbuf_get_head);
 char
 cirbuf_get_head(struct cirbuf * cbuf)
 {
@@ -425,7 +425,7 @@ cirbuf_get_head(struct cirbuf * cbuf)
 
 /* get head or get tail */
 
-RTE_EXPORT_SYMBOL(cirbuf_get_tail)
+RTE_EXPORT_SYMBOL(cirbuf_get_tail);
 char
 cirbuf_get_tail(struct cirbuf * cbuf)
 {
diff --git a/lib/cmdline/cmdline_parse.c b/lib/cmdline/cmdline_parse.c
index 201fddb8c3..cfaba5f83b 100644
--- a/lib/cmdline/cmdline_parse.c
+++ b/lib/cmdline/cmdline_parse.c
@@ -50,7 +50,7 @@ iscomment(char c)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_isendoftoken)
+RTE_EXPORT_SYMBOL(cmdline_isendoftoken);
 int
 cmdline_isendoftoken(char c)
 {
@@ -298,21 +298,21 @@ __cmdline_parse(struct cmdline *cl, const char *buf, bool call_fn)
 	return linelen;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_parse)
+RTE_EXPORT_SYMBOL(cmdline_parse);
 int
 cmdline_parse(struct cmdline *cl, const char *buf)
 {
 	return __cmdline_parse(cl, buf, true);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_parse_check)
+RTE_EXPORT_SYMBOL(cmdline_parse_check);
 int
 cmdline_parse_check(struct cmdline *cl, const char *buf)
 {
 	return __cmdline_parse(cl, buf, false);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_complete)
+RTE_EXPORT_SYMBOL(cmdline_complete);
 int
 cmdline_complete(struct cmdline *cl, const char *buf, int *state,
 		 char *dst, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_etheraddr.c b/lib/cmdline/cmdline_parse_etheraddr.c
index 7358572ba1..eec5a71b9d 100644
--- a/lib/cmdline/cmdline_parse_etheraddr.c
+++ b/lib/cmdline/cmdline_parse_etheraddr.c
@@ -14,7 +14,7 @@
 #include "cmdline_parse.h"
 #include "cmdline_parse_etheraddr.h"
 
-RTE_EXPORT_SYMBOL(cmdline_token_etheraddr_ops)
+RTE_EXPORT_SYMBOL(cmdline_token_etheraddr_ops);
 struct cmdline_token_ops cmdline_token_etheraddr_ops = {
 	.parse = cmdline_parse_etheraddr,
 	.complete_get_nb = NULL,
@@ -22,7 +22,7 @@ struct cmdline_token_ops cmdline_token_etheraddr_ops = {
 	.get_help = cmdline_get_help_etheraddr,
 };
 
-RTE_EXPORT_SYMBOL(cmdline_parse_etheraddr)
+RTE_EXPORT_SYMBOL(cmdline_parse_etheraddr);
 int
 cmdline_parse_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 	const char *buf, void *res, unsigned ressize)
@@ -54,7 +54,7 @@ cmdline_parse_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 	return token_len;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_get_help_etheraddr)
+RTE_EXPORT_SYMBOL(cmdline_get_help_etheraddr);
 int
 cmdline_get_help_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 			       char *dstbuf, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_ipaddr.c b/lib/cmdline/cmdline_parse_ipaddr.c
index 55522016c8..c44275fd42 100644
--- a/lib/cmdline/cmdline_parse_ipaddr.c
+++ b/lib/cmdline/cmdline_parse_ipaddr.c
@@ -15,7 +15,7 @@
 #include "cmdline_parse.h"
 #include "cmdline_parse_ipaddr.h"
 
-RTE_EXPORT_SYMBOL(cmdline_token_ipaddr_ops)
+RTE_EXPORT_SYMBOL(cmdline_token_ipaddr_ops);
 struct cmdline_token_ops cmdline_token_ipaddr_ops = {
 	.parse = cmdline_parse_ipaddr,
 	.complete_get_nb = NULL,
@@ -26,7 +26,7 @@ struct cmdline_token_ops cmdline_token_ipaddr_ops = {
 #define PREFIXMAX 128
 #define V4PREFIXMAX 32
 
-RTE_EXPORT_SYMBOL(cmdline_parse_ipaddr)
+RTE_EXPORT_SYMBOL(cmdline_parse_ipaddr);
 int
 cmdline_parse_ipaddr(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	unsigned ressize)
@@ -93,7 +93,7 @@ cmdline_parse_ipaddr(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 
 }
 
-RTE_EXPORT_SYMBOL(cmdline_get_help_ipaddr)
+RTE_EXPORT_SYMBOL(cmdline_get_help_ipaddr);
 int cmdline_get_help_ipaddr(cmdline_parse_token_hdr_t *tk, char *dstbuf,
 			    unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index f21796bedb..a4be661ed5 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -21,7 +21,7 @@
 #define debug_printf(...) do {} while (0)
 #endif
 
-RTE_EXPORT_SYMBOL(cmdline_token_num_ops)
+RTE_EXPORT_SYMBOL(cmdline_token_num_ops);
 struct cmdline_token_ops cmdline_token_num_ops = {
 	.parse = cmdline_parse_num,
 	.complete_get_nb = NULL,
@@ -94,7 +94,7 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
 }
 
 /* parse an int */
-RTE_EXPORT_SYMBOL(cmdline_parse_num)
+RTE_EXPORT_SYMBOL(cmdline_parse_num);
 int
 cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 	unsigned ressize)
@@ -316,7 +316,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 
 
 /* parse an int */
-RTE_EXPORT_SYMBOL(cmdline_get_help_num)
+RTE_EXPORT_SYMBOL(cmdline_get_help_num);
 int
 cmdline_get_help_num(cmdline_parse_token_hdr_t *tk, char *dstbuf, unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index 3efe4143e3..b2f634f322 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -16,7 +16,7 @@
 #include "cmdline_parse.h"
 #include "cmdline_parse_portlist.h"
 
-RTE_EXPORT_SYMBOL(cmdline_token_portlist_ops)
+RTE_EXPORT_SYMBOL(cmdline_token_portlist_ops);
 struct cmdline_token_ops cmdline_token_portlist_ops = {
 	.parse = cmdline_parse_portlist,
 	.complete_get_nb = NULL,
@@ -71,7 +71,7 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_parse_portlist)
+RTE_EXPORT_SYMBOL(cmdline_parse_portlist);
 int
 cmdline_parse_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 	const char *buf, void *res, unsigned ressize)
@@ -108,7 +108,7 @@ cmdline_parse_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 	return token_len;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_get_help_portlist)
+RTE_EXPORT_SYMBOL(cmdline_get_help_portlist);
 int
 cmdline_get_help_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 		char *dstbuf, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_string.c b/lib/cmdline/cmdline_parse_string.c
index 731947159f..e6a68656a6 100644
--- a/lib/cmdline/cmdline_parse_string.c
+++ b/lib/cmdline/cmdline_parse_string.c
@@ -12,7 +12,7 @@
 #include "cmdline_parse.h"
 #include "cmdline_parse_string.h"
 
-RTE_EXPORT_SYMBOL(cmdline_token_string_ops)
+RTE_EXPORT_SYMBOL(cmdline_token_string_ops);
 struct cmdline_token_ops cmdline_token_string_ops = {
 	.parse = cmdline_parse_string,
 	.complete_get_nb = cmdline_complete_get_nb_string,
@@ -49,7 +49,7 @@ get_next_token(const char *s)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_parse_string)
+RTE_EXPORT_SYMBOL(cmdline_parse_string);
 int
 cmdline_parse_string(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	unsigned ressize)
@@ -135,7 +135,7 @@ cmdline_parse_string(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	return token_len;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_complete_get_nb_string)
+RTE_EXPORT_SYMBOL(cmdline_complete_get_nb_string);
 int cmdline_complete_get_nb_string(cmdline_parse_token_hdr_t *tk)
 {
 	struct cmdline_token_string *tk2;
@@ -159,7 +159,7 @@ int cmdline_complete_get_nb_string(cmdline_parse_token_hdr_t *tk)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_complete_get_elt_string)
+RTE_EXPORT_SYMBOL(cmdline_complete_get_elt_string);
 int cmdline_complete_get_elt_string(cmdline_parse_token_hdr_t *tk, int idx,
 				    char *dstbuf, unsigned int size)
 {
@@ -192,7 +192,7 @@ int cmdline_complete_get_elt_string(cmdline_parse_token_hdr_t *tk, int idx,
 }
 
 
-RTE_EXPORT_SYMBOL(cmdline_get_help_string)
+RTE_EXPORT_SYMBOL(cmdline_get_help_string);
 int cmdline_get_help_string(cmdline_parse_token_hdr_t *tk, char *dstbuf,
 			    unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 3b8d435e98..f9b9959331 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -54,7 +54,7 @@ rdline_init(struct rdline *rdl,
 	return cirbuf_init(&rdl->history, rdl->history_buf, 0, RDLINE_HISTORY_BUF_SIZE);
 }
 
-RTE_EXPORT_SYMBOL(rdline_new)
+RTE_EXPORT_SYMBOL(rdline_new);
 struct rdline *
 rdline_new(rdline_write_char_t *write_char,
 	   rdline_validate_t *validate,
@@ -71,14 +71,14 @@ rdline_new(rdline_write_char_t *write_char,
 	return rdl;
 }
 
-RTE_EXPORT_SYMBOL(rdline_free)
+RTE_EXPORT_SYMBOL(rdline_free);
 void
 rdline_free(struct rdline *rdl)
 {
 	free(rdl);
 }
 
-RTE_EXPORT_SYMBOL(rdline_newline)
+RTE_EXPORT_SYMBOL(rdline_newline);
 void
 rdline_newline(struct rdline *rdl, const char *prompt)
 {
@@ -103,7 +103,7 @@ rdline_newline(struct rdline *rdl, const char *prompt)
 	rdl->history_cur_line = -1;
 }
 
-RTE_EXPORT_SYMBOL(rdline_stop)
+RTE_EXPORT_SYMBOL(rdline_stop);
 void
 rdline_stop(struct rdline *rdl)
 {
@@ -112,7 +112,7 @@ rdline_stop(struct rdline *rdl)
 	rdl->status = RDLINE_INIT;
 }
 
-RTE_EXPORT_SYMBOL(rdline_quit)
+RTE_EXPORT_SYMBOL(rdline_quit);
 void
 rdline_quit(struct rdline *rdl)
 {
@@ -121,7 +121,7 @@ rdline_quit(struct rdline *rdl)
 	rdl->status = RDLINE_EXITED;
 }
 
-RTE_EXPORT_SYMBOL(rdline_restart)
+RTE_EXPORT_SYMBOL(rdline_restart);
 void
 rdline_restart(struct rdline *rdl)
 {
@@ -130,7 +130,7 @@ rdline_restart(struct rdline *rdl)
 	rdl->status = RDLINE_RUNNING;
 }
 
-RTE_EXPORT_SYMBOL(rdline_reset)
+RTE_EXPORT_SYMBOL(rdline_reset);
 void
 rdline_reset(struct rdline *rdl)
 {
@@ -145,7 +145,7 @@ rdline_reset(struct rdline *rdl)
 	rdl->history_cur_line = -1;
 }
 
-RTE_EXPORT_SYMBOL(rdline_get_buffer)
+RTE_EXPORT_SYMBOL(rdline_get_buffer);
 const char *
 rdline_get_buffer(struct rdline *rdl)
 {
@@ -182,7 +182,7 @@ display_right_buffer(struct rdline *rdl, int force)
 				  CIRBUF_GET_LEN(&rdl->right));
 }
 
-RTE_EXPORT_SYMBOL(rdline_redisplay)
+RTE_EXPORT_SYMBOL(rdline_redisplay);
 void
 rdline_redisplay(struct rdline *rdl)
 {
@@ -201,7 +201,7 @@ rdline_redisplay(struct rdline *rdl)
 	display_right_buffer(rdl, 1);
 }
 
-RTE_EXPORT_SYMBOL(rdline_char_in)
+RTE_EXPORT_SYMBOL(rdline_char_in);
 int
 rdline_char_in(struct rdline *rdl, char c)
 {
@@ -573,7 +573,7 @@ rdline_get_history_size(struct rdline * rdl)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rdline_get_history_item)
+RTE_EXPORT_SYMBOL(rdline_get_history_item);
 char *
 rdline_get_history_item(struct rdline * rdl, unsigned int idx)
 {
@@ -600,21 +600,21 @@ rdline_get_history_item(struct rdline * rdl, unsigned int idx)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rdline_get_history_buffer_size)
+RTE_EXPORT_SYMBOL(rdline_get_history_buffer_size);
 size_t
 rdline_get_history_buffer_size(struct rdline *rdl)
 {
 	return sizeof(rdl->history_buf);
 }
 
-RTE_EXPORT_SYMBOL(rdline_get_opaque)
+RTE_EXPORT_SYMBOL(rdline_get_opaque);
 void *
 rdline_get_opaque(struct rdline *rdl)
 {
 	return rdl != NULL ? rdl->opaque : NULL;
 }
 
-RTE_EXPORT_SYMBOL(rdline_add_history)
+RTE_EXPORT_SYMBOL(rdline_add_history);
 int
 rdline_add_history(struct rdline * rdl, const char * buf)
 {
@@ -644,7 +644,7 @@ rdline_add_history(struct rdline * rdl, const char * buf)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rdline_clear_history)
+RTE_EXPORT_SYMBOL(rdline_clear_history);
 void
 rdline_clear_history(struct rdline * rdl)
 {
diff --git a/lib/cmdline/cmdline_socket.c b/lib/cmdline/cmdline_socket.c
index f3d62acdae..53131e17c8 100644
--- a/lib/cmdline/cmdline_socket.c
+++ b/lib/cmdline/cmdline_socket.c
@@ -14,7 +14,7 @@
 
 #include <eal_export.h>
 
-RTE_EXPORT_SYMBOL(cmdline_file_new)
+RTE_EXPORT_SYMBOL(cmdline_file_new);
 struct cmdline *
 cmdline_file_new(cmdline_parse_ctx_t *ctx, const char *prompt, const char *path)
 {
@@ -32,7 +32,7 @@ cmdline_file_new(cmdline_parse_ctx_t *ctx, const char *prompt, const char *path)
 	return cmdline_new(ctx, prompt, fd, -1);
 }
 
-RTE_EXPORT_SYMBOL(cmdline_stdin_new)
+RTE_EXPORT_SYMBOL(cmdline_stdin_new);
 struct cmdline *
 cmdline_stdin_new(cmdline_parse_ctx_t *ctx, const char *prompt)
 {
@@ -46,7 +46,7 @@ cmdline_stdin_new(cmdline_parse_ctx_t *ctx, const char *prompt)
 	return cl;
 }
 
-RTE_EXPORT_SYMBOL(cmdline_stdin_exit)
+RTE_EXPORT_SYMBOL(cmdline_stdin_exit);
 void
 cmdline_stdin_exit(struct cmdline *cl)
 {
diff --git a/lib/cmdline/cmdline_vt100.c b/lib/cmdline/cmdline_vt100.c
index 272088a0c6..8eaa3efb36 100644
--- a/lib/cmdline/cmdline_vt100.c
+++ b/lib/cmdline/cmdline_vt100.c
@@ -42,7 +42,7 @@ const char *cmdline_vt100_commands[] = {
 	vt100_bs,
 };
 
-RTE_EXPORT_SYMBOL(vt100_init)
+RTE_EXPORT_SYMBOL(vt100_init);
 void
 vt100_init(struct cmdline_vt100 *vt)
 {
@@ -72,7 +72,7 @@ match_command(char *buf, unsigned int size)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(vt100_parser)
+RTE_EXPORT_SYMBOL(vt100_parser);
 int
 vt100_parser(struct cmdline_vt100 *vt, char ch)
 {
diff --git a/lib/compressdev/rte_comp.c b/lib/compressdev/rte_comp.c
index 662691796a..c22e25c762 100644
--- a/lib/compressdev/rte_comp.c
+++ b/lib/compressdev/rte_comp.c
@@ -6,7 +6,7 @@
 #include "rte_comp.h"
 #include "rte_compressdev_internal.h"
 
-RTE_EXPORT_SYMBOL(rte_comp_get_feature_name)
+RTE_EXPORT_SYMBOL(rte_comp_get_feature_name);
 const char *
 rte_comp_get_feature_name(uint64_t flag)
 {
@@ -125,7 +125,7 @@ rte_comp_op_init(struct rte_mempool *mempool,
 	op->mempool = mempool;
 }
 
-RTE_EXPORT_SYMBOL(rte_comp_op_pool_create)
+RTE_EXPORT_SYMBOL(rte_comp_op_pool_create);
 struct rte_mempool *
 rte_comp_op_pool_create(const char *name,
 		unsigned int nb_elts, unsigned int cache_size,
@@ -181,7 +181,7 @@ rte_comp_op_pool_create(const char *name,
 	return mp;
 }
 
-RTE_EXPORT_SYMBOL(rte_comp_op_alloc)
+RTE_EXPORT_SYMBOL(rte_comp_op_alloc);
 struct rte_comp_op *
 rte_comp_op_alloc(struct rte_mempool *mempool)
 {
@@ -197,7 +197,7 @@ rte_comp_op_alloc(struct rte_mempool *mempool)
 	return op;
 }
 
-RTE_EXPORT_SYMBOL(rte_comp_op_bulk_alloc)
+RTE_EXPORT_SYMBOL(rte_comp_op_bulk_alloc);
 int
 rte_comp_op_bulk_alloc(struct rte_mempool *mempool,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -223,7 +223,7 @@ rte_comp_op_bulk_alloc(struct rte_mempool *mempool,
  * @param op
  *   Compress operation
  */
-RTE_EXPORT_SYMBOL(rte_comp_op_free)
+RTE_EXPORT_SYMBOL(rte_comp_op_free);
 void
 rte_comp_op_free(struct rte_comp_op *op)
 {
@@ -231,7 +231,7 @@ rte_comp_op_free(struct rte_comp_op *op)
 		rte_mempool_put(op->mempool, op);
 }
 
-RTE_EXPORT_SYMBOL(rte_comp_op_bulk_free)
+RTE_EXPORT_SYMBOL(rte_comp_op_bulk_free);
 void
 rte_comp_op_bulk_free(struct rte_comp_op **ops, uint16_t nb_ops)
 {
diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index 33de3f511b..cbb7c812f4 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -29,7 +29,7 @@ static struct rte_compressdev_global compressdev_globals = {
 		.max_devs		= RTE_COMPRESS_MAX_DEVS
 };
 
-RTE_EXPORT_SYMBOL(rte_compressdev_capability_get)
+RTE_EXPORT_SYMBOL(rte_compressdev_capability_get);
 const struct rte_compressdev_capabilities *
 rte_compressdev_capability_get(uint8_t dev_id,
 			enum rte_comp_algorithm algo)
@@ -53,7 +53,7 @@ rte_compressdev_capability_get(uint8_t dev_id,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_get_feature_name)
+RTE_EXPORT_SYMBOL(rte_compressdev_get_feature_name);
 const char *
 rte_compressdev_get_feature_name(uint64_t flag)
 {
@@ -83,7 +83,7 @@ rte_compressdev_get_dev(uint8_t dev_id)
 	return &compressdev_globals.devs[dev_id];
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_get_named_dev)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_get_named_dev);
 struct rte_compressdev *
 rte_compressdev_pmd_get_named_dev(const char *name)
 {
@@ -120,7 +120,7 @@ rte_compressdev_is_valid_dev(uint8_t dev_id)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_compressdev_get_dev_id)
+RTE_EXPORT_SYMBOL(rte_compressdev_get_dev_id);
 int
 rte_compressdev_get_dev_id(const char *name)
 {
@@ -139,14 +139,14 @@ rte_compressdev_get_dev_id(const char *name)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_count)
+RTE_EXPORT_SYMBOL(rte_compressdev_count);
 uint8_t
 rte_compressdev_count(void)
 {
 	return compressdev_globals.nb_devs;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_devices_get)
+RTE_EXPORT_SYMBOL(rte_compressdev_devices_get);
 uint8_t
 rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 	uint8_t nb_devices)
@@ -172,7 +172,7 @@ rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_socket_id)
+RTE_EXPORT_SYMBOL(rte_compressdev_socket_id);
 int
 rte_compressdev_socket_id(uint8_t dev_id)
 {
@@ -230,7 +230,7 @@ rte_compressdev_find_free_device_index(void)
 	return RTE_COMPRESS_MAX_DEVS;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_allocate)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_allocate);
 struct rte_compressdev *
 rte_compressdev_pmd_allocate(const char *name, int socket_id)
 {
@@ -277,7 +277,7 @@ rte_compressdev_pmd_allocate(const char *name, int socket_id)
 	return compressdev;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_release_device)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_release_device);
 int
 rte_compressdev_pmd_release_device(struct rte_compressdev *compressdev)
 {
@@ -298,7 +298,7 @@ rte_compressdev_pmd_release_device(struct rte_compressdev *compressdev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_count)
+RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_count);
 uint16_t
 rte_compressdev_queue_pair_count(uint8_t dev_id)
 {
@@ -424,7 +424,7 @@ rte_compressdev_queue_pairs_release(struct rte_compressdev *dev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_configure)
+RTE_EXPORT_SYMBOL(rte_compressdev_configure);
 int
 rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 {
@@ -460,7 +460,7 @@ rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_start)
+RTE_EXPORT_SYMBOL(rte_compressdev_start);
 int
 rte_compressdev_start(uint8_t dev_id)
 {
@@ -494,7 +494,7 @@ rte_compressdev_start(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_stop)
+RTE_EXPORT_SYMBOL(rte_compressdev_stop);
 void
 rte_compressdev_stop(uint8_t dev_id)
 {
@@ -520,7 +520,7 @@ rte_compressdev_stop(uint8_t dev_id)
 	dev->data->dev_started = 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_close)
+RTE_EXPORT_SYMBOL(rte_compressdev_close);
 int
 rte_compressdev_close(uint8_t dev_id)
 {
@@ -557,7 +557,7 @@ rte_compressdev_close(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_setup)
+RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_setup);
 int
 rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		uint32_t max_inflight_ops, int socket_id)
@@ -593,7 +593,7 @@ rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, max_inflight_ops, socket_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_dequeue_burst)
+RTE_EXPORT_SYMBOL(rte_compressdev_dequeue_burst);
 uint16_t
 rte_compressdev_dequeue_burst(uint8_t dev_id, uint16_t qp_id,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -603,7 +603,7 @@ rte_compressdev_dequeue_burst(uint8_t dev_id, uint16_t qp_id,
 	return dev->dequeue_burst(dev->data->queue_pairs[qp_id], ops, nb_ops);
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_enqueue_burst)
+RTE_EXPORT_SYMBOL(rte_compressdev_enqueue_burst);
 uint16_t
 rte_compressdev_enqueue_burst(uint8_t dev_id, uint16_t qp_id,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -613,7 +613,7 @@ rte_compressdev_enqueue_burst(uint8_t dev_id, uint16_t qp_id,
 	return dev->enqueue_burst(dev->data->queue_pairs[qp_id], ops, nb_ops);
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_stats_get)
+RTE_EXPORT_SYMBOL(rte_compressdev_stats_get);
 int
 rte_compressdev_stats_get(uint8_t dev_id, struct rte_compressdev_stats *stats)
 {
@@ -638,7 +638,7 @@ rte_compressdev_stats_get(uint8_t dev_id, struct rte_compressdev_stats *stats)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_stats_reset)
+RTE_EXPORT_SYMBOL(rte_compressdev_stats_reset);
 void
 rte_compressdev_stats_reset(uint8_t dev_id)
 {
@@ -657,7 +657,7 @@ rte_compressdev_stats_reset(uint8_t dev_id)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_compressdev_info_get)
+RTE_EXPORT_SYMBOL(rte_compressdev_info_get);
 void
 rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 {
@@ -679,7 +679,7 @@ rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 	dev_info->driver_name = dev->device->driver->name;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_create)
+RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_create);
 int
 rte_compressdev_private_xform_create(uint8_t dev_id,
 		const struct rte_comp_xform *xform,
@@ -706,7 +706,7 @@ rte_compressdev_private_xform_create(uint8_t dev_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_free)
+RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_free);
 int
 rte_compressdev_private_xform_free(uint8_t dev_id, void *priv_xform)
 {
@@ -731,7 +731,7 @@ rte_compressdev_private_xform_free(uint8_t dev_id, void *priv_xform)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_stream_create)
+RTE_EXPORT_SYMBOL(rte_compressdev_stream_create);
 int
 rte_compressdev_stream_create(uint8_t dev_id,
 		const struct rte_comp_xform *xform,
@@ -759,7 +759,7 @@ rte_compressdev_stream_create(uint8_t dev_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_compressdev_stream_free)
+RTE_EXPORT_SYMBOL(rte_compressdev_stream_free);
 int
 rte_compressdev_stream_free(uint8_t dev_id, void *stream)
 {
@@ -784,7 +784,7 @@ rte_compressdev_stream_free(uint8_t dev_id, void *stream)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_name_get)
+RTE_EXPORT_SYMBOL(rte_compressdev_name_get);
 const char *
 rte_compressdev_name_get(uint8_t dev_id)
 {
diff --git a/lib/compressdev/rte_compressdev_pmd.c b/lib/compressdev/rte_compressdev_pmd.c
index 7e11ad7148..5fad809337 100644
--- a/lib/compressdev/rte_compressdev_pmd.c
+++ b/lib/compressdev/rte_compressdev_pmd.c
@@ -56,7 +56,7 @@ rte_compressdev_pmd_parse_uint_arg(const char *key __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_parse_input_args)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_parse_input_args);
 int
 rte_compressdev_pmd_parse_input_args(
 		struct rte_compressdev_pmd_init_params *params,
@@ -93,7 +93,7 @@ rte_compressdev_pmd_parse_input_args(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_create)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_create);
 struct rte_compressdev *
 rte_compressdev_pmd_create(const char *name,
 		struct rte_device *device,
@@ -143,7 +143,7 @@ rte_compressdev_pmd_create(const char *name,
 	return compressdev;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_pmd_destroy)
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_destroy);
 int
 rte_compressdev_pmd_destroy(struct rte_compressdev *compressdev)
 {
diff --git a/lib/cryptodev/cryptodev_trace_points.c b/lib/cryptodev/cryptodev_trace_points.c
index 69737adcbe..31e7a188f6 100644
--- a/lib/cryptodev/cryptodev_trace_points.c
+++ b/lib/cryptodev/cryptodev_trace_points.c
@@ -43,11 +43,11 @@ RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_sym_session_free,
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_asym_session_free,
 	lib.cryptodev.asym.free)
 
-RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_enqueue_burst)
+RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_enqueue_burst);
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_enqueue_burst,
 	lib.cryptodev.enq.burst)
 
-RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_dequeue_burst)
+RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_dequeue_burst);
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_dequeue_burst,
 	lib.cryptodev.deq.burst)
 
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..64779bbb45 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -46,13 +46,13 @@ static struct rte_cryptodev_global cryptodev_globals = {
 };
 
 /* Public fastpath APIs. */
-RTE_EXPORT_SYMBOL(rte_crypto_fp_ops)
+RTE_EXPORT_SYMBOL(rte_crypto_fp_ops);
 struct rte_crypto_fp_ops rte_crypto_fp_ops[RTE_CRYPTO_MAX_DEVS];
 
 /* spinlock for crypto device callbacks */
 static rte_spinlock_t rte_cryptodev_cb_lock = RTE_SPINLOCK_INITIALIZER;
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_logtype)
+RTE_EXPORT_SYMBOL(rte_cryptodev_logtype);
 RTE_LOG_REGISTER_DEFAULT(rte_cryptodev_logtype, INFO);
 
 /**
@@ -109,7 +109,7 @@ crypto_cipher_algorithm_strings[] = {
  * The crypto cipher operation strings identifiers.
  * It could be used in application command line.
  */
-RTE_EXPORT_SYMBOL(rte_crypto_cipher_operation_strings)
+RTE_EXPORT_SYMBOL(rte_crypto_cipher_operation_strings);
 const char *
 rte_crypto_cipher_operation_strings[] = {
 		[RTE_CRYPTO_CIPHER_OP_ENCRYPT]	= "encrypt",
@@ -182,7 +182,7 @@ crypto_aead_algorithm_strings[] = {
  * The crypto AEAD operation strings identifiers.
  * It could be used in application command line.
  */
-RTE_EXPORT_SYMBOL(rte_crypto_aead_operation_strings)
+RTE_EXPORT_SYMBOL(rte_crypto_aead_operation_strings);
 const char *
 rte_crypto_aead_operation_strings[] = {
 	[RTE_CRYPTO_AEAD_OP_ENCRYPT]	= "encrypt",
@@ -210,7 +210,7 @@ crypto_asym_xform_strings[] = {
 /**
  * Asymmetric crypto operation strings identifiers.
  */
-RTE_EXPORT_SYMBOL(rte_crypto_asym_op_strings)
+RTE_EXPORT_SYMBOL(rte_crypto_asym_op_strings);
 const char *rte_crypto_asym_op_strings[] = {
 	[RTE_CRYPTO_ASYM_OP_ENCRYPT]	= "encrypt",
 	[RTE_CRYPTO_ASYM_OP_DECRYPT]	= "decrypt",
@@ -221,7 +221,7 @@ const char *rte_crypto_asym_op_strings[] = {
 /**
  * Asymmetric crypto key exchange operation strings identifiers.
  */
-RTE_EXPORT_SYMBOL(rte_crypto_asym_ke_strings)
+RTE_EXPORT_SYMBOL(rte_crypto_asym_ke_strings);
 const char *rte_crypto_asym_ke_strings[] = {
 	[RTE_CRYPTO_ASYM_KE_PRIV_KEY_GENERATE] = "priv_key_generate",
 	[RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE] = "pub_key_generate",
@@ -246,7 +246,7 @@ struct rte_cryptodev_asym_session_pool_private_data {
 	/**< Session user data will be placed after sess_private_data */
 };
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_cipher_algo_enum)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_cipher_algo_enum);
 int
 rte_cryptodev_get_cipher_algo_enum(enum rte_crypto_cipher_algorithm *algo_enum,
 		const char *algo_string)
@@ -267,7 +267,7 @@ rte_cryptodev_get_cipher_algo_enum(enum rte_crypto_cipher_algorithm *algo_enum,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_auth_algo_enum)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_auth_algo_enum);
 int
 rte_cryptodev_get_auth_algo_enum(enum rte_crypto_auth_algorithm *algo_enum,
 		const char *algo_string)
@@ -288,7 +288,7 @@ rte_cryptodev_get_auth_algo_enum(enum rte_crypto_auth_algorithm *algo_enum,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_aead_algo_enum)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_aead_algo_enum);
 int
 rte_cryptodev_get_aead_algo_enum(enum rte_crypto_aead_algorithm *algo_enum,
 		const char *algo_string)
@@ -309,7 +309,7 @@ rte_cryptodev_get_aead_algo_enum(enum rte_crypto_aead_algorithm *algo_enum,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_xform_enum)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_xform_enum);
 int
 rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
 		const char *xform_string)
@@ -391,14 +391,14 @@ rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum)
  * The crypto auth operation strings identifiers.
  * It could be used in application command line.
  */
-RTE_EXPORT_SYMBOL(rte_crypto_auth_operation_strings)
+RTE_EXPORT_SYMBOL(rte_crypto_auth_operation_strings);
 const char *
 rte_crypto_auth_operation_strings[] = {
 		[RTE_CRYPTO_AUTH_OP_VERIFY]	= "verify",
 		[RTE_CRYPTO_AUTH_OP_GENERATE]	= "generate"
 };
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_get);
 const struct rte_cryptodev_symmetric_capability *
 rte_cryptodev_sym_capability_get(uint8_t dev_id,
 		const struct rte_cryptodev_sym_capability_idx *idx)
@@ -468,7 +468,7 @@ param_range_check(uint16_t size, const struct rte_crypto_param_range *range)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_capability_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_capability_get);
 const struct rte_cryptodev_asymmetric_xform_capability *
 rte_cryptodev_asym_capability_get(uint8_t dev_id,
 		const struct rte_cryptodev_asym_capability_idx *idx)
@@ -498,7 +498,7 @@ rte_cryptodev_asym_capability_get(uint8_t dev_id,
 	return asym_cap;
 };
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_cipher)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_cipher);
 int
 rte_cryptodev_sym_capability_check_cipher(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -521,7 +521,7 @@ rte_cryptodev_sym_capability_check_cipher(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_auth)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_auth);
 int
 rte_cryptodev_sym_capability_check_auth(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -550,7 +550,7 @@ rte_cryptodev_sym_capability_check_auth(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_aead)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_aead);
 int
 rte_cryptodev_sym_capability_check_aead(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -585,7 +585,7 @@ rte_cryptodev_sym_capability_check_aead(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_optype)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_optype);
 int
 rte_cryptodev_asym_xform_capability_check_optype(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -602,7 +602,7 @@ rte_cryptodev_asym_xform_capability_check_optype(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_modlen)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_modlen);
 int
 rte_cryptodev_asym_xform_capability_check_modlen(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -638,7 +638,7 @@ rte_cryptodev_asym_xform_capability_check_modlen(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_hash)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_hash);
 bool
 rte_cryptodev_asym_xform_capability_check_hash(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -789,7 +789,7 @@ cryptodev_cb_init(struct rte_cryptodev *dev)
 	return -ENOMEM;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_feature_name)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_feature_name);
 const char *
 rte_cryptodev_get_feature_name(uint64_t flag)
 {
@@ -891,7 +891,7 @@ rte_cryptodev_is_valid_device_data(uint8_t dev_id)
 	return 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_is_valid_dev)
+RTE_EXPORT_SYMBOL(rte_cryptodev_is_valid_dev);
 unsigned int
 rte_cryptodev_is_valid_dev(uint8_t dev_id)
 {
@@ -913,7 +913,7 @@ rte_cryptodev_is_valid_dev(uint8_t dev_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_dev_id)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_dev_id);
 int
 rte_cryptodev_get_dev_id(const char *name)
 {
@@ -940,7 +940,7 @@ rte_cryptodev_get_dev_id(const char *name)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_count)
+RTE_EXPORT_SYMBOL(rte_cryptodev_count);
 uint8_t
 rte_cryptodev_count(void)
 {
@@ -949,7 +949,7 @@ rte_cryptodev_count(void)
 	return cryptodev_globals.nb_devs;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_device_count_by_driver)
+RTE_EXPORT_SYMBOL(rte_cryptodev_device_count_by_driver);
 uint8_t
 rte_cryptodev_device_count_by_driver(uint8_t driver_id)
 {
@@ -966,7 +966,7 @@ rte_cryptodev_device_count_by_driver(uint8_t driver_id)
 	return dev_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_devices_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_devices_get);
 uint8_t
 rte_cryptodev_devices_get(const char *driver_name, uint8_t *devices,
 	uint8_t nb_devices)
@@ -995,7 +995,7 @@ rte_cryptodev_devices_get(const char *driver_name, uint8_t *devices,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_sec_ctx)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_sec_ctx);
 void *
 rte_cryptodev_get_sec_ctx(uint8_t dev_id)
 {
@@ -1011,7 +1011,7 @@ rte_cryptodev_get_sec_ctx(uint8_t dev_id)
 	return sec_ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_socket_id)
+RTE_EXPORT_SYMBOL(rte_cryptodev_socket_id);
 int
 rte_cryptodev_socket_id(uint8_t dev_id)
 {
@@ -1196,7 +1196,7 @@ rte_cryptodev_pmd_release_device(struct rte_cryptodev *cryptodev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_count)
+RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_count);
 uint16_t
 rte_cryptodev_queue_pair_count(uint8_t dev_id)
 {
@@ -1304,7 +1304,7 @@ rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_reset(dev, queue_pair_id, qp_conf, socket_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_configure)
+RTE_EXPORT_SYMBOL(rte_cryptodev_configure);
 int
 rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 {
@@ -1352,7 +1352,7 @@ rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_start)
+RTE_EXPORT_SYMBOL(rte_cryptodev_start);
 int
 rte_cryptodev_start(uint8_t dev_id)
 {
@@ -1390,7 +1390,7 @@ rte_cryptodev_start(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_stop)
+RTE_EXPORT_SYMBOL(rte_cryptodev_stop);
 void
 rte_cryptodev_stop(uint8_t dev_id)
 {
@@ -1420,7 +1420,7 @@ rte_cryptodev_stop(uint8_t dev_id)
 	dev->data->dev_started = 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_close)
+RTE_EXPORT_SYMBOL(rte_cryptodev_close);
 int
 rte_cryptodev_close(uint8_t dev_id)
 {
@@ -1463,7 +1463,7 @@ rte_cryptodev_close(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_qp_status)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_qp_status);
 int
 rte_cryptodev_get_qp_status(uint8_t dev_id, uint16_t queue_pair_id)
 {
@@ -1518,7 +1518,7 @@ rte_cryptodev_sym_is_valid_session_pool(struct rte_mempool *mp,
 	return 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_setup)
+RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_setup);
 int
 rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
@@ -1572,7 +1572,7 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_add_enq_callback)
+RTE_EXPORT_SYMBOL(rte_cryptodev_add_enq_callback);
 struct rte_cryptodev_cb *
 rte_cryptodev_add_enq_callback(uint8_t dev_id,
 			       uint16_t qp_id,
@@ -1643,7 +1643,7 @@ rte_cryptodev_add_enq_callback(uint8_t dev_id,
 	return cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_remove_enq_callback)
+RTE_EXPORT_SYMBOL(rte_cryptodev_remove_enq_callback);
 int
 rte_cryptodev_remove_enq_callback(uint8_t dev_id,
 				  uint16_t qp_id,
@@ -1720,7 +1720,7 @@ rte_cryptodev_remove_enq_callback(uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_add_deq_callback)
+RTE_EXPORT_SYMBOL(rte_cryptodev_add_deq_callback);
 struct rte_cryptodev_cb *
 rte_cryptodev_add_deq_callback(uint8_t dev_id,
 			       uint16_t qp_id,
@@ -1792,7 +1792,7 @@ rte_cryptodev_add_deq_callback(uint8_t dev_id,
 	return cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_remove_deq_callback)
+RTE_EXPORT_SYMBOL(rte_cryptodev_remove_deq_callback);
 int
 rte_cryptodev_remove_deq_callback(uint8_t dev_id,
 				  uint16_t qp_id,
@@ -1869,7 +1869,7 @@ rte_cryptodev_remove_deq_callback(uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_stats_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_stats_get);
 int
 rte_cryptodev_stats_get(uint8_t dev_id, struct rte_cryptodev_stats *stats)
 {
@@ -1896,7 +1896,7 @@ rte_cryptodev_stats_get(uint8_t dev_id, struct rte_cryptodev_stats *stats)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_stats_reset)
+RTE_EXPORT_SYMBOL(rte_cryptodev_stats_reset);
 void
 rte_cryptodev_stats_reset(uint8_t dev_id)
 {
@@ -1916,7 +1916,7 @@ rte_cryptodev_stats_reset(uint8_t dev_id)
 	dev->dev_ops->stats_reset(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_info_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_info_get);
 void
 rte_cryptodev_info_get(uint8_t dev_id, struct rte_cryptodev_info *dev_info)
 {
@@ -1942,7 +1942,7 @@ rte_cryptodev_info_get(uint8_t dev_id, struct rte_cryptodev_info *dev_info)
 
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_callback_register)
+RTE_EXPORT_SYMBOL(rte_cryptodev_callback_register);
 int
 rte_cryptodev_callback_register(uint8_t dev_id,
 			enum rte_cryptodev_event_type event,
@@ -1988,7 +1988,7 @@ rte_cryptodev_callback_register(uint8_t dev_id,
 	return (user_cb == NULL) ? -ENOMEM : 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_cryptodev_callback_unregister);
 int
 rte_cryptodev_callback_unregister(uint8_t dev_id,
 			enum rte_cryptodev_event_type event,
@@ -2080,7 +2080,7 @@ rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id)
 	return dev->dev_ops->queue_pair_event_error_query(dev, qp_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_pool_create)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_pool_create);
 struct rte_mempool *
 rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t elt_size, uint32_t cache_size, uint16_t user_data_size,
@@ -2119,7 +2119,7 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	return mp;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_pool_create)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_pool_create);
 struct rte_mempool *
 rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t cache_size, uint16_t user_data_size, int socket_id)
@@ -2170,7 +2170,7 @@ rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
 	return mp;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_create)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_create);
 void *
 rte_cryptodev_sym_session_create(uint8_t dev_id,
 		struct rte_crypto_sym_xform *xforms,
@@ -2238,7 +2238,7 @@ rte_cryptodev_sym_session_create(uint8_t dev_id,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_create)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_create);
 int
 rte_cryptodev_asym_session_create(uint8_t dev_id,
 		struct rte_crypto_asym_xform *xforms, struct rte_mempool *mp,
@@ -2315,7 +2315,7 @@ rte_cryptodev_asym_session_create(uint8_t dev_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_free)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_free);
 int
 rte_cryptodev_sym_session_free(uint8_t dev_id, void *_sess)
 {
@@ -2362,7 +2362,7 @@ rte_cryptodev_sym_session_free(uint8_t dev_id, void *_sess)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_free)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_free);
 int
 rte_cryptodev_asym_session_free(uint8_t dev_id, void *sess)
 {
@@ -2394,14 +2394,14 @@ rte_cryptodev_asym_session_free(uint8_t dev_id, void *sess)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_header_session_size)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_header_session_size);
 unsigned int
 rte_cryptodev_asym_get_header_session_size(void)
 {
 	return sizeof(struct rte_cryptodev_asym_session);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_get_private_session_size)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_get_private_session_size);
 unsigned int
 rte_cryptodev_sym_get_private_session_size(uint8_t dev_id)
 {
@@ -2424,7 +2424,7 @@ rte_cryptodev_sym_get_private_session_size(uint8_t dev_id)
 	return priv_sess_size;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_private_session_size)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_private_session_size);
 unsigned int
 rte_cryptodev_asym_get_private_session_size(uint8_t dev_id)
 {
@@ -2447,7 +2447,7 @@ rte_cryptodev_asym_get_private_session_size(uint8_t dev_id)
 	return priv_sess_size;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_set_user_data)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_set_user_data);
 int
 rte_cryptodev_sym_session_set_user_data(void *_sess, void *data,
 		uint16_t size)
@@ -2467,7 +2467,7 @@ rte_cryptodev_sym_session_set_user_data(void *_sess, void *data,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_get_user_data)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_get_user_data);
 void *
 rte_cryptodev_sym_session_get_user_data(void *_sess)
 {
@@ -2484,7 +2484,7 @@ rte_cryptodev_sym_session_get_user_data(void *_sess)
 	return data;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_set_user_data)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_set_user_data);
 int
 rte_cryptodev_asym_session_set_user_data(void *session, void *data, uint16_t size)
 {
@@ -2504,7 +2504,7 @@ rte_cryptodev_asym_session_set_user_data(void *session, void *data, uint16_t siz
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_get_user_data)
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_get_user_data);
 void *
 rte_cryptodev_asym_session_get_user_data(void *session)
 {
@@ -2529,7 +2529,7 @@ sym_crypto_fill_status(struct rte_crypto_sym_vec *vec, int32_t errnum)
 		vec->status[i] = errnum;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_sym_cpu_crypto_process)
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_cpu_crypto_process);
 uint32_t
 rte_cryptodev_sym_cpu_crypto_process(uint8_t dev_id,
 	void *_sess, union rte_crypto_sym_ofs ofs,
@@ -2556,7 +2556,7 @@ rte_cryptodev_sym_cpu_crypto_process(uint8_t dev_id,
 	return dev->dev_ops->sym_cpu_process(dev, sess, ofs, vec);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_get_raw_dp_ctx_size)
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_raw_dp_ctx_size);
 int
 rte_cryptodev_get_raw_dp_ctx_size(uint8_t dev_id)
 {
@@ -2583,7 +2583,7 @@ rte_cryptodev_get_raw_dp_ctx_size(uint8_t dev_id)
 	return RTE_ALIGN_CEIL((size + priv_size), 8);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_configure_raw_dp_ctx)
+RTE_EXPORT_SYMBOL(rte_cryptodev_configure_raw_dp_ctx);
 int
 rte_cryptodev_configure_raw_dp_ctx(uint8_t dev_id, uint16_t qp_id,
 	struct rte_crypto_raw_dp_ctx *ctx,
@@ -2607,7 +2607,7 @@ rte_cryptodev_configure_raw_dp_ctx(uint8_t dev_id, uint16_t qp_id,
 			sess_type, session_ctx, is_update);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_session_event_mdata_set)
+RTE_EXPORT_SYMBOL(rte_cryptodev_session_event_mdata_set);
 int
 rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 	enum rte_crypto_op_type op_type,
@@ -2651,7 +2651,7 @@ rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 		return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_burst)
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_burst);
 uint32_t
 rte_cryptodev_raw_enqueue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 	struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs ofs,
@@ -2661,7 +2661,7 @@ rte_cryptodev_raw_enqueue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 			ofs, user_data, enqueue_status);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_done)
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_done);
 int
 rte_cryptodev_raw_enqueue_done(struct rte_crypto_raw_dp_ctx *ctx,
 		uint32_t n)
@@ -2669,7 +2669,7 @@ rte_cryptodev_raw_enqueue_done(struct rte_crypto_raw_dp_ctx *ctx,
 	return ctx->enqueue_done(ctx->qp_data, ctx->drv_ctx_data, n);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_burst)
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_burst);
 uint32_t
 rte_cryptodev_raw_dequeue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 	rte_cryptodev_raw_get_dequeue_count_t get_dequeue_count,
@@ -2683,7 +2683,7 @@ rte_cryptodev_raw_dequeue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 		out_user_data, is_user_data_array, n_success_jobs, status);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_done)
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_done);
 int
 rte_cryptodev_raw_dequeue_done(struct rte_crypto_raw_dp_ctx *ctx,
 		uint32_t n)
@@ -2710,7 +2710,7 @@ rte_crypto_op_init(struct rte_mempool *mempool,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_crypto_op_pool_create)
+RTE_EXPORT_SYMBOL(rte_crypto_op_pool_create);
 struct rte_mempool *
 rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 		unsigned nb_elts, unsigned cache_size, uint16_t priv_size,
@@ -2810,7 +2810,7 @@ TAILQ_HEAD(cryptodev_driver_list, cryptodev_driver);
 static struct cryptodev_driver_list cryptodev_driver_list =
 	TAILQ_HEAD_INITIALIZER(cryptodev_driver_list);
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_driver_id_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_driver_id_get);
 int
 rte_cryptodev_driver_id_get(const char *name)
 {
@@ -2836,7 +2836,7 @@ rte_cryptodev_driver_id_get(const char *name)
 	return driver_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_name_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_name_get);
 const char *
 rte_cryptodev_name_get(uint8_t dev_id)
 {
@@ -2856,7 +2856,7 @@ rte_cryptodev_name_get(uint8_t dev_id)
 	return dev->data->name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_driver_name_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_driver_name_get);
 const char *
 rte_cryptodev_driver_name_get(uint8_t driver_id)
 {
diff --git a/lib/distributor/rte_distributor.c b/lib/distributor/rte_distributor.c
index dde7ce2677..ca35ad97d9 100644
--- a/lib/distributor/rte_distributor.c
+++ b/lib/distributor/rte_distributor.c
@@ -32,7 +32,7 @@ EAL_REGISTER_TAILQ(rte_dist_burst_tailq)
 
 /**** Burst Packet APIs called by workers ****/
 
-RTE_EXPORT_SYMBOL(rte_distributor_request_pkt)
+RTE_EXPORT_SYMBOL(rte_distributor_request_pkt);
 void
 rte_distributor_request_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **oldpkt,
@@ -85,7 +85,7 @@ rte_distributor_request_pkt(struct rte_distributor *d,
 			rte_memory_order_release);
 }
 
-RTE_EXPORT_SYMBOL(rte_distributor_poll_pkt)
+RTE_EXPORT_SYMBOL(rte_distributor_poll_pkt);
 int
 rte_distributor_poll_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **pkts)
@@ -130,7 +130,7 @@ rte_distributor_poll_pkt(struct rte_distributor *d,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_distributor_get_pkt)
+RTE_EXPORT_SYMBOL(rte_distributor_get_pkt);
 int
 rte_distributor_get_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **pkts,
@@ -161,7 +161,7 @@ rte_distributor_get_pkt(struct rte_distributor *d,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_distributor_return_pkt)
+RTE_EXPORT_SYMBOL(rte_distributor_return_pkt);
 int
 rte_distributor_return_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **oldpkt, int num)
@@ -444,7 +444,7 @@ release(struct rte_distributor *d, unsigned int wkr)
 
 
 /* process a set of packets to distribute them to workers */
-RTE_EXPORT_SYMBOL(rte_distributor_process)
+RTE_EXPORT_SYMBOL(rte_distributor_process);
 int
 rte_distributor_process(struct rte_distributor *d,
 		struct rte_mbuf **mbufs, unsigned int num_mbufs)
@@ -615,7 +615,7 @@ rte_distributor_process(struct rte_distributor *d,
 }
 
 /* return to the caller, packets returned from workers */
-RTE_EXPORT_SYMBOL(rte_distributor_returned_pkts)
+RTE_EXPORT_SYMBOL(rte_distributor_returned_pkts);
 int
 rte_distributor_returned_pkts(struct rte_distributor *d,
 		struct rte_mbuf **mbufs, unsigned int max_mbufs)
@@ -662,7 +662,7 @@ total_outstanding(const struct rte_distributor *d)
  * Flush the distributor, so that there are no outstanding packets in flight or
  * queued up.
  */
-RTE_EXPORT_SYMBOL(rte_distributor_flush)
+RTE_EXPORT_SYMBOL(rte_distributor_flush);
 int
 rte_distributor_flush(struct rte_distributor *d)
 {
@@ -695,7 +695,7 @@ rte_distributor_flush(struct rte_distributor *d)
 }
 
 /* clears the internal returns array in the distributor */
-RTE_EXPORT_SYMBOL(rte_distributor_clear_returns)
+RTE_EXPORT_SYMBOL(rte_distributor_clear_returns);
 void
 rte_distributor_clear_returns(struct rte_distributor *d)
 {
@@ -717,7 +717,7 @@ rte_distributor_clear_returns(struct rte_distributor *d)
 }
 
 /* creates a distributor instance */
-RTE_EXPORT_SYMBOL(rte_distributor_create)
+RTE_EXPORT_SYMBOL(rte_distributor_create);
 struct rte_distributor *
 rte_distributor_create(const char *name,
 		unsigned int socket_id,
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 17ee0808a9..4472980204 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -39,7 +39,7 @@ RTE_LOG_REGISTER_DEFAULT(rte_dma_logtype, INFO);
 #define RTE_DMA_LOG(level, ...) \
 	RTE_LOG_LINE(level, DMADEV, "" __VA_ARGS__)
 
-RTE_EXPORT_SYMBOL(rte_dma_dev_max)
+RTE_EXPORT_SYMBOL(rte_dma_dev_max);
 int
 rte_dma_dev_max(size_t dev_max)
 {
@@ -57,7 +57,7 @@ rte_dma_dev_max(size_t dev_max)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_next_dev)
+RTE_EXPORT_SYMBOL(rte_dma_next_dev);
 int16_t
 rte_dma_next_dev(int16_t start_dev_id)
 {
@@ -390,7 +390,7 @@ rte_dma_pmd_release(const char *name)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_get_dev_id_by_name)
+RTE_EXPORT_SYMBOL(rte_dma_get_dev_id_by_name);
 int
 rte_dma_get_dev_id_by_name(const char *name)
 {
@@ -406,7 +406,7 @@ rte_dma_get_dev_id_by_name(const char *name)
 	return dev->data->dev_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_is_valid)
+RTE_EXPORT_SYMBOL(rte_dma_is_valid);
 bool
 rte_dma_is_valid(int16_t dev_id)
 {
@@ -425,7 +425,7 @@ rte_dma_pmd_get_dev_by_id(int16_t dev_id)
 	return &rte_dma_devices[dev_id];
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_count_avail)
+RTE_EXPORT_SYMBOL(rte_dma_count_avail);
 uint16_t
 rte_dma_count_avail(void)
 {
@@ -443,7 +443,7 @@ rte_dma_count_avail(void)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_info_get)
+RTE_EXPORT_SYMBOL(rte_dma_info_get);
 int
 rte_dma_info_get(int16_t dev_id, struct rte_dma_info *dev_info)
 {
@@ -475,7 +475,7 @@ rte_dma_info_get(int16_t dev_id, struct rte_dma_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_configure)
+RTE_EXPORT_SYMBOL(rte_dma_configure);
 int
 rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 {
@@ -533,7 +533,7 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_start)
+RTE_EXPORT_SYMBOL(rte_dma_start);
 int
 rte_dma_start(int16_t dev_id)
 {
@@ -567,7 +567,7 @@ rte_dma_start(int16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_stop)
+RTE_EXPORT_SYMBOL(rte_dma_stop);
 int
 rte_dma_stop(int16_t dev_id)
 {
@@ -596,7 +596,7 @@ rte_dma_stop(int16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_close)
+RTE_EXPORT_SYMBOL(rte_dma_close);
 int
 rte_dma_close(int16_t dev_id)
 {
@@ -625,7 +625,7 @@ rte_dma_close(int16_t dev_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_vchan_setup)
+RTE_EXPORT_SYMBOL(rte_dma_vchan_setup);
 int
 rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		    const struct rte_dma_vchan_conf *conf)
@@ -720,7 +720,7 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_stats_get)
+RTE_EXPORT_SYMBOL(rte_dma_stats_get);
 int
 rte_dma_stats_get(int16_t dev_id, uint16_t vchan, struct rte_dma_stats *stats)
 {
@@ -743,7 +743,7 @@ rte_dma_stats_get(int16_t dev_id, uint16_t vchan, struct rte_dma_stats *stats)
 	return dev->dev_ops->stats_get(dev, vchan, stats, sizeof(struct rte_dma_stats));
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_stats_reset)
+RTE_EXPORT_SYMBOL(rte_dma_stats_reset);
 int
 rte_dma_stats_reset(int16_t dev_id, uint16_t vchan)
 {
@@ -769,7 +769,7 @@ rte_dma_stats_reset(int16_t dev_id, uint16_t vchan)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_vchan_status)
+RTE_EXPORT_SYMBOL(rte_dma_vchan_status);
 int
 rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *status)
 {
@@ -837,7 +837,7 @@ dma_dump_capability(FILE *f, uint64_t dev_capa)
 	(void)fprintf(f, "\n");
 }
 
-RTE_EXPORT_SYMBOL(rte_dma_dump)
+RTE_EXPORT_SYMBOL(rte_dma_dump);
 int
 rte_dma_dump(int16_t dev_id, FILE *f)
 {
diff --git a/lib/eal/arm/rte_cpuflags.c b/lib/eal/arm/rte_cpuflags.c
index 32243f293a..2a644d720c 100644
--- a/lib/eal/arm/rte_cpuflags.c
+++ b/lib/eal/arm/rte_cpuflags.c
@@ -136,7 +136,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled);
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -154,7 +154,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name);
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -163,7 +163,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support);
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/arm/rte_hypervisor.c b/lib/eal/arm/rte_hypervisor.c
index 51b224fb94..45e6ef667b 100644
--- a/lib/eal/arm/rte_hypervisor.c
+++ b/lib/eal/arm/rte_hypervisor.c
@@ -5,7 +5,7 @@
 #include <eal_export.h>
 #include "rte_hypervisor.h"
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get);
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/arm/rte_power_intrinsics.c b/lib/eal/arm/rte_power_intrinsics.c
index 4826b370ea..b9c3ab30a6 100644
--- a/lib/eal/arm/rte_power_intrinsics.c
+++ b/lib/eal/arm/rte_power_intrinsics.c
@@ -27,7 +27,7 @@ RTE_INIT(rte_power_intrinsics_init)
  * This function uses WFE/WFET instruction to make lcore suspend
  * execution on ARM.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor)
+RTE_EXPORT_SYMBOL(rte_power_monitor);
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -80,7 +80,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on ARM.
  */
-RTE_EXPORT_SYMBOL(rte_power_pause)
+RTE_EXPORT_SYMBOL(rte_power_pause);
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -94,7 +94,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
  * on ARM.
  * Note that lcore_id is not used here.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup);
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -108,7 +108,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 #endif /* RTE_ARCH_64 */
 }
 
-RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi);
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 0a2311a342..5156ccd8ba 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -17,7 +17,7 @@
 static struct rte_bus_list rte_bus_list =
 	TAILQ_HEAD_INITIALIZER(rte_bus_list);
 
-RTE_EXPORT_SYMBOL(rte_bus_name)
+RTE_EXPORT_SYMBOL(rte_bus_name);
 const char *
 rte_bus_name(const struct rte_bus *bus)
 {
@@ -50,7 +50,7 @@ rte_bus_unregister(struct rte_bus *bus)
 }
 
 /* Scan all the buses for registered devices */
-RTE_EXPORT_SYMBOL(rte_bus_scan)
+RTE_EXPORT_SYMBOL(rte_bus_scan);
 int
 rte_bus_scan(void)
 {
@@ -68,7 +68,7 @@ rte_bus_scan(void)
 }
 
 /* Probe all devices of all buses */
-RTE_EXPORT_SYMBOL(rte_bus_probe)
+RTE_EXPORT_SYMBOL(rte_bus_probe);
 int
 rte_bus_probe(void)
 {
@@ -130,7 +130,7 @@ bus_dump_one(FILE *f, struct rte_bus *bus)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bus_dump)
+RTE_EXPORT_SYMBOL(rte_bus_dump);
 void
 rte_bus_dump(FILE *f)
 {
@@ -147,7 +147,7 @@ rte_bus_dump(FILE *f)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_bus_find)
+RTE_EXPORT_SYMBOL(rte_bus_find);
 struct rte_bus *
 rte_bus_find(const struct rte_bus *start, rte_bus_cmp_t cmp,
 	     const void *data)
@@ -183,7 +183,7 @@ bus_find_device(const struct rte_bus *bus, const void *_dev)
 	return dev == NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_bus_find_by_device)
+RTE_EXPORT_SYMBOL(rte_bus_find_by_device);
 struct rte_bus *
 rte_bus_find_by_device(const struct rte_device *dev)
 {
@@ -198,7 +198,7 @@ cmp_bus_name(const struct rte_bus *bus, const void *_name)
 	return strcmp(rte_bus_name(bus), name);
 }
 
-RTE_EXPORT_SYMBOL(rte_bus_find_by_name)
+RTE_EXPORT_SYMBOL(rte_bus_find_by_name);
 struct rte_bus *
 rte_bus_find_by_name(const char *busname)
 {
@@ -230,7 +230,7 @@ rte_bus_find_by_device_name(const char *str)
 /*
  * Get iommu class of devices on the bus.
  */
-RTE_EXPORT_SYMBOL(rte_bus_get_iommu_class)
+RTE_EXPORT_SYMBOL(rte_bus_get_iommu_class);
 enum rte_iova_mode
 rte_bus_get_iommu_class(void)
 {
diff --git a/lib/eal/common/eal_common_class.c b/lib/eal/common/eal_common_class.c
index 0f10c6894b..787f3d53f5 100644
--- a/lib/eal/common/eal_common_class.c
+++ b/lib/eal/common/eal_common_class.c
@@ -15,7 +15,7 @@
 static struct rte_class_list rte_class_list =
 	TAILQ_HEAD_INITIALIZER(rte_class_list);
 
-RTE_EXPORT_SYMBOL(rte_class_register)
+RTE_EXPORT_SYMBOL(rte_class_register);
 void
 rte_class_register(struct rte_class *class)
 {
@@ -26,7 +26,7 @@ rte_class_register(struct rte_class *class)
 	EAL_LOG(DEBUG, "Registered [%s] device class.", class->name);
 }
 
-RTE_EXPORT_SYMBOL(rte_class_unregister)
+RTE_EXPORT_SYMBOL(rte_class_unregister);
 void
 rte_class_unregister(struct rte_class *class)
 {
@@ -34,7 +34,7 @@ rte_class_unregister(struct rte_class *class)
 	EAL_LOG(DEBUG, "Unregistered [%s] device class.", class->name);
 }
 
-RTE_EXPORT_SYMBOL(rte_class_find)
+RTE_EXPORT_SYMBOL(rte_class_find);
 struct rte_class *
 rte_class_find(const struct rte_class *start, rte_class_cmp_t cmp,
 	       const void *data)
@@ -61,7 +61,7 @@ cmp_class_name(const struct rte_class *class, const void *_name)
 	return strcmp(class->name, name);
 }
 
-RTE_EXPORT_SYMBOL(rte_class_find_by_name)
+RTE_EXPORT_SYMBOL(rte_class_find_by_name);
 struct rte_class *
 rte_class_find_by_name(const char *name)
 {
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 7fc7611a07..47a5ebee5c 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -29,7 +29,7 @@ static char runtime_dir[PATH_MAX];
 /* internal configuration */
 static struct internal_config internal_config;
 
-RTE_EXPORT_SYMBOL(rte_eal_get_runtime_dir)
+RTE_EXPORT_SYMBOL(rte_eal_get_runtime_dir);
 const char *
 rte_eal_get_runtime_dir(void)
 {
@@ -61,7 +61,7 @@ eal_get_internal_configuration(void)
 	return &internal_config;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_iova_mode)
+RTE_EXPORT_SYMBOL(rte_eal_iova_mode);
 enum rte_iova_mode
 rte_eal_iova_mode(void)
 {
@@ -78,7 +78,7 @@ rte_eal_get_baseaddr(void)
 		       eal_get_baseaddr();
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_process_type)
+RTE_EXPORT_SYMBOL(rte_eal_process_type);
 enum rte_proc_type_t
 rte_eal_process_type(void)
 {
@@ -86,7 +86,7 @@ rte_eal_process_type(void)
 }
 
 /* Return user provided mbuf pool ops name */
-RTE_EXPORT_SYMBOL(rte_eal_mbuf_user_pool_ops)
+RTE_EXPORT_SYMBOL(rte_eal_mbuf_user_pool_ops);
 const char *
 rte_eal_mbuf_user_pool_ops(void)
 {
@@ -94,14 +94,14 @@ rte_eal_mbuf_user_pool_ops(void)
 }
 
 /* return non-zero if hugepages are enabled. */
-RTE_EXPORT_SYMBOL(rte_eal_has_hugepages)
+RTE_EXPORT_SYMBOL(rte_eal_has_hugepages);
 int
 rte_eal_has_hugepages(void)
 {
 	return !internal_config.no_hugetlbfs;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_has_pci)
+RTE_EXPORT_SYMBOL(rte_eal_has_pci);
 int
 rte_eal_has_pci(void)
 {
diff --git a/lib/eal/common/eal_common_cpuflags.c b/lib/eal/common/eal_common_cpuflags.c
index cbd49a151b..b86fd01b89 100644
--- a/lib/eal/common/eal_common_cpuflags.c
+++ b/lib/eal/common/eal_common_cpuflags.c
@@ -8,7 +8,7 @@
 #include <rte_common.h>
 #include <rte_cpuflags.h>
 
-RTE_EXPORT_SYMBOL(rte_cpu_is_supported)
+RTE_EXPORT_SYMBOL(rte_cpu_is_supported);
 int
 rte_cpu_is_supported(void)
 {
diff --git a/lib/eal/common/eal_common_debug.c b/lib/eal/common/eal_common_debug.c
index 7a42546da2..af1d7353df 100644
--- a/lib/eal/common/eal_common_debug.c
+++ b/lib/eal/common/eal_common_debug.c
@@ -14,7 +14,7 @@
 #include <eal_export.h>
 #include "eal_private.h"
 
-RTE_EXPORT_SYMBOL(__rte_panic)
+RTE_EXPORT_SYMBOL(__rte_panic);
 void
 __rte_panic(const char *funcname, const char *format, ...)
 {
@@ -32,7 +32,7 @@ __rte_panic(const char *funcname, const char *format, ...)
  * Like rte_panic this terminates the application. However, no traceback is
  * provided and no core-dump is generated.
  */
-RTE_EXPORT_SYMBOL(rte_exit)
+RTE_EXPORT_SYMBOL(rte_exit);
 void
 rte_exit(int exit_code, const char *format, ...)
 {
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 7185de0cb9..5937db32ca 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -21,49 +21,49 @@
 #include "eal_private.h"
 #include "hotplug_mp.h"
 
-RTE_EXPORT_SYMBOL(rte_driver_name)
+RTE_EXPORT_SYMBOL(rte_driver_name);
 const char *
 rte_driver_name(const struct rte_driver *driver)
 {
 	return driver->name;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_bus)
+RTE_EXPORT_SYMBOL(rte_dev_bus);
 const struct rte_bus *
 rte_dev_bus(const struct rte_device *dev)
 {
 	return dev->bus;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_bus_info)
+RTE_EXPORT_SYMBOL(rte_dev_bus_info);
 const char *
 rte_dev_bus_info(const struct rte_device *dev)
 {
 	return dev->bus_info;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_devargs)
+RTE_EXPORT_SYMBOL(rte_dev_devargs);
 const struct rte_devargs *
 rte_dev_devargs(const struct rte_device *dev)
 {
 	return dev->devargs;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_driver)
+RTE_EXPORT_SYMBOL(rte_dev_driver);
 const struct rte_driver *
 rte_dev_driver(const struct rte_device *dev)
 {
 	return dev->driver;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_name)
+RTE_EXPORT_SYMBOL(rte_dev_name);
 const char *
 rte_dev_name(const struct rte_device *dev)
 {
 	return dev->name;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_numa_node)
+RTE_EXPORT_SYMBOL(rte_dev_numa_node);
 int
 rte_dev_numa_node(const struct rte_device *dev)
 {
@@ -122,7 +122,7 @@ static int cmp_dev_name(const struct rte_device *dev, const void *_name)
 	return strcmp(dev->name, name);
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_is_probed)
+RTE_EXPORT_SYMBOL(rte_dev_is_probed);
 int
 rte_dev_is_probed(const struct rte_device *dev)
 {
@@ -155,7 +155,7 @@ build_devargs(const char *busname, const char *devname,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_hotplug_add)
+RTE_EXPORT_SYMBOL(rte_eal_hotplug_add);
 int
 rte_eal_hotplug_add(const char *busname, const char *devname,
 		    const char *drvargs)
@@ -240,7 +240,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_probe)
+RTE_EXPORT_SYMBOL(rte_dev_probe);
 int
 rte_dev_probe(const char *devargs)
 {
@@ -334,7 +334,7 @@ rte_dev_probe(const char *devargs)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_hotplug_remove)
+RTE_EXPORT_SYMBOL(rte_eal_hotplug_remove);
 int
 rte_eal_hotplug_remove(const char *busname, const char *devname)
 {
@@ -378,7 +378,7 @@ local_dev_remove(struct rte_device *dev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_remove)
+RTE_EXPORT_SYMBOL(rte_dev_remove);
 int
 rte_dev_remove(struct rte_device *dev)
 {
@@ -476,7 +476,7 @@ rte_dev_remove(struct rte_device *dev)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_callback_register)
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_register);
 int
 rte_dev_event_callback_register(const char *device_name,
 				rte_dev_event_cb_fn cb_fn,
@@ -545,7 +545,7 @@ rte_dev_event_callback_register(const char *device_name,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_unregister);
 int
 rte_dev_event_callback_unregister(const char *device_name,
 				  rte_dev_event_cb_fn cb_fn,
@@ -599,7 +599,7 @@ rte_dev_event_callback_unregister(const char *device_name,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_callback_process)
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_process);
 void
 rte_dev_event_callback_process(const char *device_name,
 			       enum rte_dev_event_type event)
@@ -626,7 +626,7 @@ rte_dev_event_callback_process(const char *device_name,
 	rte_spinlock_unlock(&dev_event_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_iterator_init)
+RTE_EXPORT_SYMBOL(rte_dev_iterator_init);
 int
 rte_dev_iterator_init(struct rte_dev_iterator *it,
 		      const char *dev_str)
@@ -779,7 +779,7 @@ bus_next_dev_cmp(const struct rte_bus *bus,
 	it->device = dev;
 	return dev == NULL;
 }
-RTE_EXPORT_SYMBOL(rte_dev_iterator_next)
+RTE_EXPORT_SYMBOL(rte_dev_iterator_next);
 struct rte_device *
 rte_dev_iterator_next(struct rte_dev_iterator *it)
 {
@@ -824,7 +824,7 @@ rte_dev_iterator_next(struct rte_dev_iterator *it)
 	return it->device;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_dma_map)
+RTE_EXPORT_SYMBOL(rte_dev_dma_map);
 int
 rte_dev_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
 		size_t len)
@@ -842,7 +842,7 @@ rte_dev_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
 	return dev->bus->dma_map(dev, addr, iova, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_dma_unmap)
+RTE_EXPORT_SYMBOL(rte_dev_dma_unmap);
 int
 rte_dev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 		  size_t len)
diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index c523429d67..c72c60ff4b 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -181,7 +181,7 @@ bus_name_cmp(const struct rte_bus *bus, const void *name)
 	return strncmp(bus->name, name, strlen(bus->name));
 }
 
-RTE_EXPORT_SYMBOL(rte_devargs_parse)
+RTE_EXPORT_SYMBOL(rte_devargs_parse);
 int
 rte_devargs_parse(struct rte_devargs *da, const char *dev)
 {
@@ -248,7 +248,7 @@ rte_devargs_parse(struct rte_devargs *da, const char *dev)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_devargs_parsef)
+RTE_EXPORT_SYMBOL(rte_devargs_parsef);
 int
 rte_devargs_parsef(struct rte_devargs *da, const char *format, ...)
 {
@@ -283,7 +283,7 @@ rte_devargs_parsef(struct rte_devargs *da, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_devargs_reset)
+RTE_EXPORT_SYMBOL(rte_devargs_reset);
 void
 rte_devargs_reset(struct rte_devargs *da)
 {
@@ -293,7 +293,7 @@ rte_devargs_reset(struct rte_devargs *da)
 	da->data = NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_devargs_insert)
+RTE_EXPORT_SYMBOL(rte_devargs_insert);
 int
 rte_devargs_insert(struct rte_devargs **da)
 {
@@ -325,7 +325,7 @@ rte_devargs_insert(struct rte_devargs **da)
 }
 
 /* store in allowed list parameter for later parsing */
-RTE_EXPORT_SYMBOL(rte_devargs_add)
+RTE_EXPORT_SYMBOL(rte_devargs_add);
 int
 rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 {
@@ -362,7 +362,7 @@ rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_devargs_remove)
+RTE_EXPORT_SYMBOL(rte_devargs_remove);
 int
 rte_devargs_remove(struct rte_devargs *devargs)
 {
@@ -385,7 +385,7 @@ rte_devargs_remove(struct rte_devargs *devargs)
 }
 
 /* count the number of devices of a specified type */
-RTE_EXPORT_SYMBOL(rte_devargs_type_count)
+RTE_EXPORT_SYMBOL(rte_devargs_type_count);
 unsigned int
 rte_devargs_type_count(enum rte_devtype devtype)
 {
@@ -401,7 +401,7 @@ rte_devargs_type_count(enum rte_devtype devtype)
 }
 
 /* dump the user devices on the console */
-RTE_EXPORT_SYMBOL(rte_devargs_dump)
+RTE_EXPORT_SYMBOL(rte_devargs_dump);
 void
 rte_devargs_dump(FILE *f)
 {
@@ -416,7 +416,7 @@ rte_devargs_dump(FILE *f)
 }
 
 /* bus-aware rte_devargs iterator. */
-RTE_EXPORT_SYMBOL(rte_devargs_next)
+RTE_EXPORT_SYMBOL(rte_devargs_next);
 struct rte_devargs *
 rte_devargs_next(const char *busname, const struct rte_devargs *start)
 {
diff --git a/lib/eal/common/eal_common_errno.c b/lib/eal/common/eal_common_errno.c
index 3f933c3f7b..256a041789 100644
--- a/lib/eal/common/eal_common_errno.c
+++ b/lib/eal/common/eal_common_errno.c
@@ -17,10 +17,10 @@
 #define strerror_r(errnum, buf, buflen) strerror_s(buf, buflen, errnum)
 #endif
 
-RTE_EXPORT_SYMBOL(per_lcore__rte_errno)
+RTE_EXPORT_SYMBOL(per_lcore__rte_errno);
 RTE_DEFINE_PER_LCORE(int, _rte_errno);
 
-RTE_EXPORT_SYMBOL(rte_strerror)
+RTE_EXPORT_SYMBOL(rte_strerror);
 const char *
 rte_strerror(int errnum)
 {
diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 8bdcefb717..4fe80cee1e 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -686,7 +686,7 @@ fully_validate(const char *name, unsigned int elt_sz, unsigned int len)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_init)
+RTE_EXPORT_SYMBOL(rte_fbarray_init);
 int
 rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 		unsigned int elt_sz)
@@ -813,7 +813,7 @@ rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_attach)
+RTE_EXPORT_SYMBOL(rte_fbarray_attach);
 int
 rte_fbarray_attach(struct rte_fbarray *arr)
 {
@@ -902,7 +902,7 @@ rte_fbarray_attach(struct rte_fbarray *arr)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_detach)
+RTE_EXPORT_SYMBOL(rte_fbarray_detach);
 int
 rte_fbarray_detach(struct rte_fbarray *arr)
 {
@@ -956,7 +956,7 @@ rte_fbarray_detach(struct rte_fbarray *arr)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_destroy)
+RTE_EXPORT_SYMBOL(rte_fbarray_destroy);
 int
 rte_fbarray_destroy(struct rte_fbarray *arr)
 {
@@ -1043,7 +1043,7 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_get)
+RTE_EXPORT_SYMBOL(rte_fbarray_get);
 void *
 rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 {
@@ -1063,21 +1063,21 @@ rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_set_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_set_used);
 int
 rte_fbarray_set_used(struct rte_fbarray *arr, unsigned int idx)
 {
 	return set_used(arr, idx, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_set_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_set_free);
 int
 rte_fbarray_set_free(struct rte_fbarray *arr, unsigned int idx)
 {
 	return set_used(arr, idx, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_is_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_is_used);
 int
 rte_fbarray_is_used(struct rte_fbarray *arr, unsigned int idx)
 {
@@ -1147,28 +1147,28 @@ fbarray_find(struct rte_fbarray *arr, unsigned int start, bool next, bool used)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_next_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_free);
 int
 rte_fbarray_find_next_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, true, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_next_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_used);
 int
 rte_fbarray_find_next_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, true, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_free);
 int
 rte_fbarray_find_prev_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, false, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_used);
 int
 rte_fbarray_find_prev_used(struct rte_fbarray *arr, unsigned int start)
 {
@@ -1227,7 +1227,7 @@ fbarray_find_n(struct rte_fbarray *arr, unsigned int start, unsigned int n,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_free);
 int
 rte_fbarray_find_next_n_free(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1235,7 +1235,7 @@ rte_fbarray_find_next_n_free(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, true, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_used);
 int
 rte_fbarray_find_next_n_used(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1243,7 +1243,7 @@ rte_fbarray_find_next_n_used(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, true, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_free);
 int
 rte_fbarray_find_prev_n_free(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1251,7 +1251,7 @@ rte_fbarray_find_prev_n_free(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, false, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_used);
 int
 rte_fbarray_find_prev_n_used(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1395,28 +1395,28 @@ fbarray_find_biggest(struct rte_fbarray *arr, unsigned int start, bool used,
 	return biggest_idx;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_free);
 int
 rte_fbarray_find_biggest_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, false, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_used);
 int
 rte_fbarray_find_biggest_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, true, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_free);
 int
 rte_fbarray_find_rev_biggest_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, false, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_used);
 int
 rte_fbarray_find_rev_biggest_used(struct rte_fbarray *arr, unsigned int start)
 {
@@ -1424,35 +1424,35 @@ rte_fbarray_find_rev_biggest_used(struct rte_fbarray *arr, unsigned int start)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_free);
 int
 rte_fbarray_find_contig_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, true, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_used);
 int
 rte_fbarray_find_contig_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, true, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_free)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_free);
 int
 rte_fbarray_find_rev_contig_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, false, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_used)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_used);
 int
 rte_fbarray_find_rev_contig_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, false, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_find_idx)
+RTE_EXPORT_SYMBOL(rte_fbarray_find_idx);
 int
 rte_fbarray_find_idx(const struct rte_fbarray *arr, const void *elt)
 {
@@ -1479,7 +1479,7 @@ rte_fbarray_find_idx(const struct rte_fbarray *arr, const void *elt)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fbarray_dump_metadata)
+RTE_EXPORT_SYMBOL(rte_fbarray_dump_metadata);
 void
 rte_fbarray_dump_metadata(struct rte_fbarray *arr, FILE *f)
 {
diff --git a/lib/eal/common/eal_common_hexdump.c b/lib/eal/common/eal_common_hexdump.c
index 28159f298a..e560aad214 100644
--- a/lib/eal/common/eal_common_hexdump.c
+++ b/lib/eal/common/eal_common_hexdump.c
@@ -8,7 +8,7 @@
 
 #define LINE_LEN 128
 
-RTE_EXPORT_SYMBOL(rte_hexdump)
+RTE_EXPORT_SYMBOL(rte_hexdump);
 void
 rte_hexdump(FILE *f, const char *title, const void *buf, unsigned int len)
 {
@@ -47,7 +47,7 @@ rte_hexdump(FILE *f, const char *title, const void *buf, unsigned int len)
 	fflush(f);
 }
 
-RTE_EXPORT_SYMBOL(rte_memdump)
+RTE_EXPORT_SYMBOL(rte_memdump);
 void
 rte_memdump(FILE *f, const char *title, const void *buf, unsigned int len)
 {
diff --git a/lib/eal/common/eal_common_hypervisor.c b/lib/eal/common/eal_common_hypervisor.c
index 7158fd25de..6231294eab 100644
--- a/lib/eal/common/eal_common_hypervisor.c
+++ b/lib/eal/common/eal_common_hypervisor.c
@@ -5,7 +5,7 @@
 #include <eal_export.h>
 #include "rte_hypervisor.h"
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get_name)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get_name);
 const char *
 rte_hypervisor_get_name(enum rte_hypervisor id)
 {
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index b42fa862f3..8eacb2f86b 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -30,7 +30,7 @@
 #define RTE_INTR_INSTANCE_USES_RTE_MEMORY(flags) \
 	(!!(flags & RTE_INTR_INSTANCE_F_SHARED))
 
-RTE_EXPORT_SYMBOL(rte_intr_instance_alloc)
+RTE_EXPORT_SYMBOL(rte_intr_instance_alloc);
 struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 {
 	struct rte_intr_handle *intr_handle;
@@ -175,7 +175,7 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_instance_free)
+RTE_EXPORT_SYMBOL(rte_intr_instance_free);
 void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 {
 	if (intr_handle == NULL)
@@ -191,7 +191,7 @@ void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_fd_set)
+RTE_EXPORT_SYMBOL(rte_intr_fd_set);
 int rte_intr_fd_set(struct rte_intr_handle *intr_handle, int fd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -203,7 +203,7 @@ int rte_intr_fd_set(struct rte_intr_handle *intr_handle, int fd)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_fd_get)
+RTE_EXPORT_SYMBOL(rte_intr_fd_get);
 int rte_intr_fd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -213,7 +213,7 @@ int rte_intr_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_type_set)
+RTE_EXPORT_SYMBOL(rte_intr_type_set);
 int rte_intr_type_set(struct rte_intr_handle *intr_handle,
 	enum rte_intr_handle_type type)
 {
@@ -226,7 +226,7 @@ int rte_intr_type_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_type_get)
+RTE_EXPORT_SYMBOL(rte_intr_type_get);
 enum rte_intr_handle_type rte_intr_type_get(
 	const struct rte_intr_handle *intr_handle)
 {
diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index a7deac6ecd..a408e44bbd 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -16,7 +16,7 @@
 /*
  * Wait until a lcore finished its job.
  */
-RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
+RTE_EXPORT_SYMBOL(rte_eal_wait_lcore);
 int
 rte_eal_wait_lcore(unsigned worker_id)
 {
@@ -32,7 +32,7 @@ rte_eal_wait_lcore(unsigned worker_id)
  * function f with argument arg. Once the execution is done, the
  * remote lcore switches to WAIT state.
  */
-RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
+RTE_EXPORT_SYMBOL(rte_eal_remote_launch);
 int
 rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
@@ -64,7 +64,7 @@ rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
  * rte_eal_remote_launch() for all of them. If call_main is true
  * (set to CALL_MAIN), also call the function on the main lcore.
  */
-RTE_EXPORT_SYMBOL(rte_eal_mp_remote_launch)
+RTE_EXPORT_SYMBOL(rte_eal_mp_remote_launch);
 int
 rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 			 enum rte_rmt_call_main_t call_main)
@@ -94,7 +94,7 @@ rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 /*
  * Return the state of the lcore identified by worker_id.
  */
-RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
+RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state);
 enum rte_lcore_state_t
 rte_eal_get_lcore_state(unsigned lcore_id)
 {
@@ -105,7 +105,7 @@ rte_eal_get_lcore_state(unsigned lcore_id)
  * Do a rte_eal_wait_lcore() for every lcore. The return values are
  * ignored.
  */
-RTE_EXPORT_SYMBOL(rte_eal_mp_wait_lcore)
+RTE_EXPORT_SYMBOL(rte_eal_mp_wait_lcore);
 void
 rte_eal_mp_wait_lcore(void)
 {
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 5c8b0f9aa2..b031c37caf 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -19,19 +19,19 @@
 #include "eal_private.h"
 #include "eal_thread.h"
 
-RTE_EXPORT_SYMBOL(rte_get_main_lcore)
+RTE_EXPORT_SYMBOL(rte_get_main_lcore);
 unsigned int rte_get_main_lcore(void)
 {
 	return rte_eal_get_configuration()->main_lcore;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_count)
+RTE_EXPORT_SYMBOL(rte_lcore_count);
 unsigned int rte_lcore_count(void)
 {
 	return rte_eal_get_configuration()->lcore_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_index)
+RTE_EXPORT_SYMBOL(rte_lcore_index);
 int rte_lcore_index(int lcore_id)
 {
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -47,7 +47,7 @@ int rte_lcore_index(int lcore_id)
 	return lcore_config[lcore_id].core_index;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
+RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id);
 int rte_lcore_to_cpu_id(int lcore_id)
 {
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -63,13 +63,13 @@ int rte_lcore_to_cpu_id(int lcore_id)
 	return lcore_config[lcore_id].core_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_cpuset)
+RTE_EXPORT_SYMBOL(rte_lcore_cpuset);
 rte_cpuset_t rte_lcore_cpuset(unsigned int lcore_id)
 {
 	return lcore_config[lcore_id].cpuset;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_lcore_role)
+RTE_EXPORT_SYMBOL(rte_eal_lcore_role);
 enum rte_lcore_role_t
 rte_eal_lcore_role(unsigned int lcore_id)
 {
@@ -80,7 +80,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 	return cfg->lcore_role[lcore_id];
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_has_role)
+RTE_EXPORT_SYMBOL(rte_lcore_has_role);
 int
 rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 {
@@ -92,7 +92,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	return cfg->lcore_role[lcore_id] == role;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
+RTE_EXPORT_SYMBOL(rte_lcore_is_enabled);
 int rte_lcore_is_enabled(unsigned int lcore_id)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
@@ -102,7 +102,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 	return cfg->lcore_role[lcore_id] == ROLE_RTE;
 }
 
-RTE_EXPORT_SYMBOL(rte_get_next_lcore)
+RTE_EXPORT_SYMBOL(rte_get_next_lcore);
 unsigned int rte_get_next_lcore(unsigned int i, int skip_main, int wrap)
 {
 	i++;
@@ -122,7 +122,7 @@ unsigned int rte_get_next_lcore(unsigned int i, int skip_main, int wrap)
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
+RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id);
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
@@ -231,7 +231,7 @@ rte_eal_cpu_init(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_socket_count)
+RTE_EXPORT_SYMBOL(rte_socket_count);
 unsigned int
 rte_socket_count(void)
 {
@@ -239,7 +239,7 @@ rte_socket_count(void)
 	return config->numa_node_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
+RTE_EXPORT_SYMBOL(rte_socket_id_by_idx);
 int
 rte_socket_id_by_idx(unsigned int idx)
 {
@@ -289,7 +289,7 @@ free_callback(struct lcore_callback *callback)
 	free(callback);
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_callback_register)
+RTE_EXPORT_SYMBOL(rte_lcore_callback_register);
 void *
 rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	rte_lcore_uninit_cb uninit, void *arg)
@@ -340,7 +340,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	return callback;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_lcore_callback_unregister);
 void
 rte_lcore_callback_unregister(void *handle)
 {
@@ -426,7 +426,7 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	rte_rwlock_write_unlock(&lcore_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_iterate)
+RTE_EXPORT_SYMBOL(rte_lcore_iterate);
 int
 rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 {
@@ -463,7 +463,7 @@ lcore_role_str(enum rte_lcore_role_t role)
 
 static rte_lcore_usage_cb lcore_usage_cb;
 
-RTE_EXPORT_SYMBOL(rte_lcore_register_usage_cb)
+RTE_EXPORT_SYMBOL(rte_lcore_register_usage_cb);
 void
 rte_lcore_register_usage_cb(rte_lcore_usage_cb cb)
 {
@@ -510,7 +510,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_lcore_dump)
+RTE_EXPORT_SYMBOL(rte_lcore_dump);
 void
 rte_lcore_dump(FILE *f)
 {
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 84ee3f3959..84f9e1ba3d 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -77,28 +77,28 @@ rte_mcfg_mem_get_lock(void)
 	return &rte_eal_get_configuration()->mem_config->memory_hotplug_lock;
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_lock);
 void
 rte_mcfg_mem_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_mem_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_unlock);
 void
 rte_mcfg_mem_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_mem_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_lock);
 void
 rte_mcfg_mem_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_mem_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_unlock);
 void
 rte_mcfg_mem_write_unlock(void)
 {
@@ -112,28 +112,28 @@ rte_mcfg_tailq_get_lock(void)
 	return &rte_eal_get_configuration()->mem_config->qlock;
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_lock);
 void
 rte_mcfg_tailq_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_tailq_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_unlock);
 void
 rte_mcfg_tailq_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_tailq_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_lock);
 void
 rte_mcfg_tailq_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_tailq_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_unlock);
 void
 rte_mcfg_tailq_write_unlock(void)
 {
@@ -147,28 +147,28 @@ rte_mcfg_mempool_get_lock(void)
 	return &rte_eal_get_configuration()->mem_config->mplock;
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_lock);
 void
 rte_mcfg_mempool_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_mempool_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_unlock);
 void
 rte_mcfg_mempool_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_mempool_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_lock);
 void
 rte_mcfg_mempool_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_mempool_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_unlock);
 void
 rte_mcfg_mempool_write_unlock(void)
 {
@@ -182,14 +182,14 @@ rte_mcfg_timer_get_lock(void)
 	return &rte_eal_get_configuration()->mem_config->tlock;
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_timer_lock)
+RTE_EXPORT_SYMBOL(rte_mcfg_timer_lock);
 void
 rte_mcfg_timer_lock(void)
 {
 	rte_spinlock_lock(rte_mcfg_timer_get_lock());
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_timer_unlock)
+RTE_EXPORT_SYMBOL(rte_mcfg_timer_unlock);
 void
 rte_mcfg_timer_unlock(void)
 {
@@ -203,7 +203,7 @@ rte_mcfg_ethdev_get_lock(void)
 	return &rte_eal_get_configuration()->mem_config->ethdev_lock;
 }
 
-RTE_EXPORT_SYMBOL(rte_mcfg_get_single_file_segments)
+RTE_EXPORT_SYMBOL(rte_mcfg_get_single_file_segments);
 bool
 rte_mcfg_get_single_file_segments(void)
 {
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 38ccc734e8..d7ca4c2490 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -343,7 +343,7 @@ virt2memseg_list(const void *addr)
 	return msl;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_virt2memseg_list)
+RTE_EXPORT_SYMBOL(rte_mem_virt2memseg_list);
 struct rte_memseg_list *
 rte_mem_virt2memseg_list(const void *addr)
 {
@@ -381,7 +381,7 @@ find_virt_legacy(const struct rte_memseg_list *msl __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_iova2virt)
+RTE_EXPORT_SYMBOL(rte_mem_iova2virt);
 void *
 rte_mem_iova2virt(rte_iova_t iova)
 {
@@ -403,7 +403,7 @@ rte_mem_iova2virt(rte_iova_t iova)
 	return vi.virt;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_virt2memseg)
+RTE_EXPORT_SYMBOL(rte_mem_virt2memseg);
 struct rte_memseg *
 rte_mem_virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 {
@@ -425,7 +425,7 @@ physmem_size(const struct rte_memseg_list *msl, void *arg)
 }
 
 /* get the total size of memory */
-RTE_EXPORT_SYMBOL(rte_eal_get_physmem_size)
+RTE_EXPORT_SYMBOL(rte_eal_get_physmem_size);
 uint64_t
 rte_eal_get_physmem_size(void)
 {
@@ -474,7 +474,7 @@ dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
  * Defining here because declared in rte_memory.h, but the actual implementation
  * is in eal_common_memalloc.c, like all other memalloc internals.
  */
-RTE_EXPORT_SYMBOL(rte_mem_event_callback_register)
+RTE_EXPORT_SYMBOL(rte_mem_event_callback_register);
 int
 rte_mem_event_callback_register(const char *name, rte_mem_event_callback_t clb,
 		void *arg)
@@ -491,7 +491,7 @@ rte_mem_event_callback_register(const char *name, rte_mem_event_callback_t clb,
 	return eal_memalloc_mem_event_callback_register(name, clb, arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_event_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_mem_event_callback_unregister);
 int
 rte_mem_event_callback_unregister(const char *name, void *arg)
 {
@@ -507,7 +507,7 @@ rte_mem_event_callback_unregister(const char *name, void *arg)
 	return eal_memalloc_mem_event_callback_unregister(name, arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_register)
+RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_register);
 int
 rte_mem_alloc_validator_register(const char *name,
 		rte_mem_alloc_validator_t clb, int socket_id, size_t limit)
@@ -525,7 +525,7 @@ rte_mem_alloc_validator_register(const char *name,
 			limit);
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_unregister)
+RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_unregister);
 int
 rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 {
@@ -542,7 +542,7 @@ rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 }
 
 /* Dump the physical memory layout on console */
-RTE_EXPORT_SYMBOL(rte_dump_physmem_layout)
+RTE_EXPORT_SYMBOL(rte_dump_physmem_layout);
 void
 rte_dump_physmem_layout(FILE *f)
 {
@@ -614,14 +614,14 @@ check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask)
+RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask);
 int
 rte_mem_check_dma_mask(uint8_t maskbits)
 {
 	return check_dma_mask(maskbits, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask_thread_unsafe);
 int
 rte_mem_check_dma_mask_thread_unsafe(uint8_t maskbits)
 {
@@ -635,7 +635,7 @@ rte_mem_check_dma_mask_thread_unsafe(uint8_t maskbits)
  * initialization. PMDs should use rte_mem_check_dma_mask if addressing
  * limitations by the device.
  */
-RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask)
+RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask);
 void
 rte_mem_set_dma_mask(uint8_t maskbits)
 {
@@ -646,14 +646,14 @@ rte_mem_set_dma_mask(uint8_t maskbits)
 }
 
 /* return the number of memory channels */
-RTE_EXPORT_SYMBOL(rte_memory_get_nchannel)
+RTE_EXPORT_SYMBOL(rte_memory_get_nchannel);
 unsigned rte_memory_get_nchannel(void)
 {
 	return rte_eal_get_configuration()->mem_config->nchannel;
 }
 
 /* return the number of memory rank */
-RTE_EXPORT_SYMBOL(rte_memory_get_nrank)
+RTE_EXPORT_SYMBOL(rte_memory_get_nrank);
 unsigned rte_memory_get_nrank(void)
 {
 	return rte_eal_get_configuration()->mem_config->nrank;
@@ -677,7 +677,7 @@ rte_eal_memdevice_init(void)
 }
 
 /* Lock page in physical memory and prevent from swapping. */
-RTE_EXPORT_SYMBOL(rte_mem_lock_page)
+RTE_EXPORT_SYMBOL(rte_mem_lock_page);
 int
 rte_mem_lock_page(const void *virt)
 {
@@ -687,7 +687,7 @@ rte_mem_lock_page(const void *virt)
 	return rte_mem_lock((void *)aligned, page_size);
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe);
 int
 rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 {
@@ -727,7 +727,7 @@ rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_contig_walk)
+RTE_EXPORT_SYMBOL(rte_memseg_contig_walk);
 int
 rte_memseg_contig_walk(rte_memseg_contig_walk_t func, void *arg)
 {
@@ -741,7 +741,7 @@ rte_memseg_contig_walk(rte_memseg_contig_walk_t func, void *arg)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe);
 int
 rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 {
@@ -770,7 +770,7 @@ rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_walk)
+RTE_EXPORT_SYMBOL(rte_memseg_walk);
 int
 rte_memseg_walk(rte_memseg_walk_t func, void *arg)
 {
@@ -784,7 +784,7 @@ rte_memseg_walk(rte_memseg_walk_t func, void *arg)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe);
 int
 rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 {
@@ -804,7 +804,7 @@ rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_list_walk)
+RTE_EXPORT_SYMBOL(rte_memseg_list_walk);
 int
 rte_memseg_list_walk(rte_memseg_list_walk_t func, void *arg)
 {
@@ -818,7 +818,7 @@ rte_memseg_list_walk(rte_memseg_list_walk_t func, void *arg)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe);
 int
 rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 {
@@ -861,7 +861,7 @@ rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_get_fd)
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd);
 int
 rte_memseg_get_fd(const struct rte_memseg *ms)
 {
@@ -874,7 +874,7 @@ rte_memseg_get_fd(const struct rte_memseg *ms)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset_thread_unsafe)
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset_thread_unsafe);
 int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset)
@@ -918,7 +918,7 @@ rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset)
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset);
 int
 rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 {
@@ -931,7 +931,7 @@ rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_extmem_register)
+RTE_EXPORT_SYMBOL(rte_extmem_register);
 int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
@@ -981,7 +981,7 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_extmem_unregister)
+RTE_EXPORT_SYMBOL(rte_extmem_unregister);
 int
 rte_extmem_unregister(void *va_addr, size_t len)
 {
@@ -1037,14 +1037,14 @@ sync_memory(void *va_addr, size_t len, bool attach)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_extmem_attach)
+RTE_EXPORT_SYMBOL(rte_extmem_attach);
 int
 rte_extmem_attach(void *va_addr, size_t len)
 {
 	return sync_memory(va_addr, len, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_extmem_detach)
+RTE_EXPORT_SYMBOL(rte_extmem_detach);
 int
 rte_extmem_detach(void *va_addr, size_t len)
 {
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index db43af13a8..77ab3a61cc 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -26,7 +26,7 @@
 /* Default count used until rte_memzone_max_set() is called */
 #define DEFAULT_MAX_MEMZONE_COUNT 2560
 
-RTE_EXPORT_SYMBOL(rte_memzone_max_set)
+RTE_EXPORT_SYMBOL(rte_memzone_max_set);
 int
 rte_memzone_max_set(size_t max)
 {
@@ -48,7 +48,7 @@ rte_memzone_max_set(size_t max)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_memzone_max_get)
+RTE_EXPORT_SYMBOL(rte_memzone_max_get);
 size_t
 rte_memzone_max_get(void)
 {
@@ -266,7 +266,7 @@ rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
  * specified alignment and boundary). If the allocation cannot be done,
  * return NULL.
  */
-RTE_EXPORT_SYMBOL(rte_memzone_reserve_bounded)
+RTE_EXPORT_SYMBOL(rte_memzone_reserve_bounded);
 const struct rte_memzone *
 rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
 			    unsigned flags, unsigned align, unsigned bound)
@@ -279,7 +279,7 @@ rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
  * Return a pointer to a correctly filled memzone descriptor (with a
  * specified alignment). If the allocation cannot be done, return NULL.
  */
-RTE_EXPORT_SYMBOL(rte_memzone_reserve_aligned)
+RTE_EXPORT_SYMBOL(rte_memzone_reserve_aligned);
 const struct rte_memzone *
 rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
 			    unsigned flags, unsigned align)
@@ -292,7 +292,7 @@ rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
  * Return a pointer to a correctly filled memzone descriptor. If the
  * allocation cannot be done, return NULL.
  */
-RTE_EXPORT_SYMBOL(rte_memzone_reserve)
+RTE_EXPORT_SYMBOL(rte_memzone_reserve);
 const struct rte_memzone *
 rte_memzone_reserve(const char *name, size_t len, int socket_id,
 		    unsigned flags)
@@ -301,7 +301,7 @@ rte_memzone_reserve(const char *name, size_t len, int socket_id,
 					       flags, RTE_CACHE_LINE_SIZE, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_memzone_free)
+RTE_EXPORT_SYMBOL(rte_memzone_free);
 int
 rte_memzone_free(const struct rte_memzone *mz)
 {
@@ -348,7 +348,7 @@ rte_memzone_free(const struct rte_memzone *mz)
 /*
  * Lookup for the memzone identified by the given name
  */
-RTE_EXPORT_SYMBOL(rte_memzone_lookup)
+RTE_EXPORT_SYMBOL(rte_memzone_lookup);
 const struct rte_memzone *
 rte_memzone_lookup(const char *name)
 {
@@ -425,7 +425,7 @@ dump_memzone(const struct rte_memzone *mz, void *arg)
 }
 
 /* Dump all reserved memory zones on console */
-RTE_EXPORT_SYMBOL(rte_memzone_dump)
+RTE_EXPORT_SYMBOL(rte_memzone_dump);
 void
 rte_memzone_dump(FILE *f)
 {
@@ -467,7 +467,7 @@ rte_eal_memzone_init(void)
 }
 
 /* Walk all reserved memory zones */
-RTE_EXPORT_SYMBOL(rte_memzone_walk)
+RTE_EXPORT_SYMBOL(rte_memzone_walk);
 void rte_memzone_walk(void (*func)(const struct rte_memzone *, void *),
 		      void *arg)
 {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 2f91b96190..1d2e881ad3 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -167,7 +167,7 @@ eal_get_application_usage_hook(void)
 }
 
 /* Set a per-application usage message */
-RTE_EXPORT_SYMBOL(rte_set_application_usage_hook)
+RTE_EXPORT_SYMBOL(rte_set_application_usage_hook);
 rte_usage_hook_t
 rte_set_application_usage_hook(rte_usage_hook_t usage_func)
 {
@@ -2085,7 +2085,7 @@ eal_check_common_options(struct internal_config *internal_cfg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
+RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth);
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
 {
@@ -2094,7 +2094,7 @@ rte_vect_get_max_simd_bitwidth(void)
 	return internal_conf->max_simd_bitwidth.bitwidth;
 }
 
-RTE_EXPORT_SYMBOL(rte_vect_set_max_simd_bitwidth)
+RTE_EXPORT_SYMBOL(rte_vect_set_max_simd_bitwidth);
 int
 rte_vect_set_max_simd_bitwidth(uint16_t bitwidth)
 {
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 0dea787e38..edc1b8bfe9 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -143,7 +143,7 @@ create_socket_path(const char *name, char *buf, int len)
 		strlcpy(buf, prefix, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_primary_proc_alive)
+RTE_EXPORT_SYMBOL(rte_eal_primary_proc_alive);
 int
 rte_eal_primary_proc_alive(const char *config_file_path)
 {
@@ -199,7 +199,7 @@ validate_action_name(const char *name)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_action_register)
+RTE_EXPORT_SYMBOL(rte_mp_action_register);
 int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
@@ -236,7 +236,7 @@ rte_mp_action_register(const char *name, rte_mp_t action)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_action_unregister)
+RTE_EXPORT_SYMBOL(rte_mp_action_unregister);
 void
 rte_mp_action_unregister(const char *name)
 {
@@ -840,7 +840,7 @@ check_input(const struct rte_mp_msg *msg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
+RTE_EXPORT_SYMBOL(rte_mp_sendmsg);
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
@@ -994,7 +994,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_request_sync)
+RTE_EXPORT_SYMBOL(rte_mp_request_sync);
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 		const struct timespec *ts)
@@ -1092,7 +1092,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_request_async)
+RTE_EXPORT_SYMBOL(rte_mp_request_async);
 int
 rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		rte_mp_async_reply_t clb)
@@ -1245,7 +1245,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_reply)
+RTE_EXPORT_SYMBOL(rte_mp_reply);
 int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
@@ -1298,7 +1298,7 @@ set_mp_status(enum mp_status status)
 	return rte_atomic_load_explicit(&mcfg->mp_status, rte_memory_order_relaxed) == desired;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_disable)
+RTE_EXPORT_SYMBOL(rte_mp_disable);
 bool
 rte_mp_disable(void)
 {
diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index fa87831c3a..cf29cc2a3b 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -13,7 +13,7 @@
 #include <rte_errno.h>
 
 /* split string into tokens */
-RTE_EXPORT_SYMBOL(rte_strsplit)
+RTE_EXPORT_SYMBOL(rte_strsplit);
 int
 rte_strsplit(char *string, int stringlen,
 	     char **tokens, int maxtokens, char delim)
@@ -48,7 +48,7 @@ rte_strsplit(char *string, int stringlen,
  * Return negative value and NUL-terminate if dst is too short,
  * Otherwise return number of bytes copied.
  */
-RTE_EXPORT_SYMBOL(rte_strscpy)
+RTE_EXPORT_SYMBOL(rte_strscpy);
 ssize_t
 rte_strscpy(char *dst, const char *src, size_t dsize)
 {
@@ -71,7 +71,7 @@ rte_strscpy(char *dst, const char *src, size_t dsize)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_str_to_size)
+RTE_EXPORT_SYMBOL(rte_str_to_size);
 uint64_t
 rte_str_to_size(const char *str)
 {
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..9f8adaf97f 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -23,7 +23,7 @@ static struct rte_tailq_elem_head rte_tailq_elem_head =
 /* number of tailqs registered, -1 before call to rte_eal_tailqs_init */
 static int rte_tailqs_count = -1;
 
-RTE_EXPORT_SYMBOL(rte_eal_tailq_lookup)
+RTE_EXPORT_SYMBOL(rte_eal_tailq_lookup);
 struct rte_tailq_head *
 rte_eal_tailq_lookup(const char *name)
 {
@@ -42,7 +42,7 @@ rte_eal_tailq_lookup(const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_dump_tailq)
+RTE_EXPORT_SYMBOL(rte_dump_tailq);
 void
 rte_dump_tailq(FILE *f)
 {
@@ -108,7 +108,7 @@ rte_eal_tailq_update(struct rte_tailq_elem *t)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_tailq_register)
+RTE_EXPORT_SYMBOL(rte_eal_tailq_register);
 int
 rte_eal_tailq_register(struct rte_tailq_elem *t)
 {
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index c0622c5c23..e1b53a6161 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -23,15 +23,15 @@
 #include "eal_thread.h"
 #include "eal_trace.h"
 
-RTE_EXPORT_SYMBOL(per_lcore__lcore_id)
+RTE_EXPORT_SYMBOL(per_lcore__lcore_id);
 RTE_DEFINE_PER_LCORE(unsigned int, _lcore_id) = LCORE_ID_ANY;
-RTE_EXPORT_SYMBOL(per_lcore__thread_id)
+RTE_EXPORT_SYMBOL(per_lcore__thread_id);
 RTE_DEFINE_PER_LCORE(int, _thread_id) = -1;
 static RTE_DEFINE_PER_LCORE(unsigned int, _numa_id) =
 	(unsigned int)SOCKET_ID_ANY;
 static RTE_DEFINE_PER_LCORE(rte_cpuset_t, _cpuset);
 
-RTE_EXPORT_SYMBOL(rte_socket_id)
+RTE_EXPORT_SYMBOL(rte_socket_id);
 unsigned rte_socket_id(void)
 {
 	return RTE_PER_LCORE(_numa_id);
@@ -86,7 +86,7 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_affinity)
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity);
 int
 rte_thread_set_affinity(rte_cpuset_t *cpusetp)
 {
@@ -99,7 +99,7 @@ rte_thread_set_affinity(rte_cpuset_t *cpusetp)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_get_affinity)
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity);
 void
 rte_thread_get_affinity(rte_cpuset_t *cpusetp)
 {
@@ -288,7 +288,7 @@ static uint32_t control_thread_start(void *arg)
 	return start_routine(start_arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_create_control)
+RTE_EXPORT_SYMBOL(rte_thread_create_control);
 int
 rte_thread_create_control(rte_thread_t *thread, const char *name,
 		rte_thread_func start_routine, void *arg)
@@ -369,7 +369,7 @@ rte_thread_set_prefixed_name(rte_thread_t id, const char *name)
 	rte_thread_set_name(id, prefixed_name);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_register)
+RTE_EXPORT_SYMBOL(rte_thread_register);
 int
 rte_thread_register(void)
 {
@@ -402,7 +402,7 @@ rte_thread_register(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_unregister)
+RTE_EXPORT_SYMBOL(rte_thread_unregister);
 void
 rte_thread_unregister(void)
 {
@@ -416,7 +416,7 @@ rte_thread_unregister(void)
 			lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_attr_init)
+RTE_EXPORT_SYMBOL(rte_thread_attr_init);
 int
 rte_thread_attr_init(rte_thread_attr_t *attr)
 {
@@ -429,7 +429,7 @@ rte_thread_attr_init(rte_thread_attr_t *attr)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_attr_set_priority)
+RTE_EXPORT_SYMBOL(rte_thread_attr_set_priority);
 int
 rte_thread_attr_set_priority(rte_thread_attr_t *thread_attr,
 		enum rte_thread_priority priority)
@@ -442,7 +442,7 @@ rte_thread_attr_set_priority(rte_thread_attr_t *thread_attr,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_attr_set_affinity)
+RTE_EXPORT_SYMBOL(rte_thread_attr_set_affinity);
 int
 rte_thread_attr_set_affinity(rte_thread_attr_t *thread_attr,
 		rte_cpuset_t *cpuset)
@@ -458,7 +458,7 @@ rte_thread_attr_set_affinity(rte_thread_attr_t *thread_attr,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_attr_get_affinity)
+RTE_EXPORT_SYMBOL(rte_thread_attr_get_affinity);
 int
 rte_thread_attr_get_affinity(rte_thread_attr_t *thread_attr,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index bbf8b8b11b..121b850c27 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -19,10 +19,10 @@
 static uint64_t eal_tsc_resolution_hz;
 
 /* Pointer to user delay function */
-RTE_EXPORT_SYMBOL(rte_delay_us)
+RTE_EXPORT_SYMBOL(rte_delay_us);
 void (*rte_delay_us)(unsigned int) = NULL;
 
-RTE_EXPORT_SYMBOL(rte_delay_us_block)
+RTE_EXPORT_SYMBOL(rte_delay_us_block);
 void
 rte_delay_us_block(unsigned int us)
 {
@@ -32,7 +32,7 @@ rte_delay_us_block(unsigned int us)
 		rte_pause();
 }
 
-RTE_EXPORT_SYMBOL(rte_get_tsc_hz)
+RTE_EXPORT_SYMBOL(rte_get_tsc_hz);
 uint64_t
 rte_get_tsc_hz(void)
 {
@@ -79,7 +79,7 @@ set_tsc_freq(void)
 	mcfg->tsc_hz = freq;
 }
 
-RTE_EXPORT_SYMBOL(rte_delay_us_callback_register)
+RTE_EXPORT_SYMBOL(rte_delay_us_callback_register);
 void rte_delay_us_callback_register(void (*userfunc)(unsigned int))
 {
 	rte_delay_us = userfunc;
diff --git a/lib/eal/common/eal_common_uuid.c b/lib/eal/common/eal_common_uuid.c
index 0e0924d08d..941ae246b8 100644
--- a/lib/eal/common/eal_common_uuid.c
+++ b/lib/eal/common/eal_common_uuid.c
@@ -78,7 +78,7 @@ static void uuid_unpack(const rte_uuid_t in, struct uuid *uu)
 	memcpy(uu->node, ptr, 6);
 }
 
-RTE_EXPORT_SYMBOL(rte_uuid_is_null)
+RTE_EXPORT_SYMBOL(rte_uuid_is_null);
 bool rte_uuid_is_null(const rte_uuid_t uu)
 {
 	const uint8_t *cp = uu;
@@ -93,7 +93,7 @@ bool rte_uuid_is_null(const rte_uuid_t uu)
 /*
  * rte_uuid_compare() - compare two UUIDs.
  */
-RTE_EXPORT_SYMBOL(rte_uuid_compare)
+RTE_EXPORT_SYMBOL(rte_uuid_compare);
 int rte_uuid_compare(const rte_uuid_t uu1, const rte_uuid_t uu2)
 {
 	struct uuid	uuid1, uuid2;
@@ -113,7 +113,7 @@ int rte_uuid_compare(const rte_uuid_t uu1, const rte_uuid_t uu2)
 	return memcmp(uuid1.node, uuid2.node, 6);
 }
 
-RTE_EXPORT_SYMBOL(rte_uuid_parse)
+RTE_EXPORT_SYMBOL(rte_uuid_parse);
 int rte_uuid_parse(const char *in, rte_uuid_t uu)
 {
 	struct uuid	uuid;
@@ -156,7 +156,7 @@ int rte_uuid_parse(const char *in, rte_uuid_t uu)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_uuid_unparse)
+RTE_EXPORT_SYMBOL(rte_uuid_unparse);
 void rte_uuid_unparse(const rte_uuid_t uu, char *out, size_t len)
 {
 	struct uuid uuid;
diff --git a/lib/eal/common/rte_keepalive.c b/lib/eal/common/rte_keepalive.c
index 08a4d595da..f6f2a7a93f 100644
--- a/lib/eal/common/rte_keepalive.c
+++ b/lib/eal/common/rte_keepalive.c
@@ -64,7 +64,7 @@ print_trace(const char *msg, struct rte_keepalive *keepcfg, int idx_core)
 	      );
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_dispatch_pings)
+RTE_EXPORT_SYMBOL(rte_keepalive_dispatch_pings);
 void
 rte_keepalive_dispatch_pings(__rte_unused void *ptr_timer,
 	void *ptr_data)
@@ -119,7 +119,7 @@ rte_keepalive_dispatch_pings(__rte_unused void *ptr_timer,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_create)
+RTE_EXPORT_SYMBOL(rte_keepalive_create);
 struct rte_keepalive *
 rte_keepalive_create(rte_keepalive_failure_callback_t callback,
 	void *data)
@@ -138,7 +138,7 @@ rte_keepalive_create(rte_keepalive_failure_callback_t callback,
 	return keepcfg;
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_register_relay_callback)
+RTE_EXPORT_SYMBOL(rte_keepalive_register_relay_callback);
 void rte_keepalive_register_relay_callback(struct rte_keepalive *keepcfg,
 	rte_keepalive_relay_callback_t callback,
 	void *data)
@@ -147,7 +147,7 @@ void rte_keepalive_register_relay_callback(struct rte_keepalive *keepcfg,
 	keepcfg->relay_callback_data = data;
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_register_core)
+RTE_EXPORT_SYMBOL(rte_keepalive_register_core);
 void
 rte_keepalive_register_core(struct rte_keepalive *keepcfg, const int id_core)
 {
@@ -157,14 +157,14 @@ rte_keepalive_register_core(struct rte_keepalive *keepcfg, const int id_core)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_mark_alive)
+RTE_EXPORT_SYMBOL(rte_keepalive_mark_alive);
 void
 rte_keepalive_mark_alive(struct rte_keepalive *keepcfg)
 {
 	keepcfg->live_data[rte_lcore_id()].core_state = RTE_KA_STATE_ALIVE;
 }
 
-RTE_EXPORT_SYMBOL(rte_keepalive_mark_sleep)
+RTE_EXPORT_SYMBOL(rte_keepalive_mark_sleep);
 void
 rte_keepalive_mark_sleep(struct rte_keepalive *keepcfg)
 {
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3a86c19490..36ee6a0899 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -49,7 +49,7 @@ mem_free(void *addr, const bool trace_ena, bool zero)
 		EAL_LOG(ERR, "Error: Invalid memory");
 }
 
-RTE_EXPORT_SYMBOL(rte_free)
+RTE_EXPORT_SYMBOL(rte_free);
 void
 rte_free(void *addr)
 {
@@ -99,7 +99,7 @@ malloc_socket(const char *type, size_t size, unsigned int align,
 /*
  * Allocate memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_malloc_socket)
+RTE_EXPORT_SYMBOL(rte_malloc_socket);
 void *
 rte_malloc_socket(const char *type, size_t size, unsigned int align,
 		int socket_arg)
@@ -116,7 +116,7 @@ eal_malloc_no_trace(const char *type, size_t size, unsigned int align)
 /*
  * Allocate memory on default heap.
  */
-RTE_EXPORT_SYMBOL(rte_malloc)
+RTE_EXPORT_SYMBOL(rte_malloc);
 void *
 rte_malloc(const char *type, size_t size, unsigned align)
 {
@@ -126,7 +126,7 @@ rte_malloc(const char *type, size_t size, unsigned align)
 /*
  * Allocate zero'd memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_zmalloc_socket)
+RTE_EXPORT_SYMBOL(rte_zmalloc_socket);
 void *
 rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
 {
@@ -156,7 +156,7 @@ rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
 /*
  * Allocate zero'd memory on default heap.
  */
-RTE_EXPORT_SYMBOL(rte_zmalloc)
+RTE_EXPORT_SYMBOL(rte_zmalloc);
 void *
 rte_zmalloc(const char *type, size_t size, unsigned align)
 {
@@ -166,7 +166,7 @@ rte_zmalloc(const char *type, size_t size, unsigned align)
 /*
  * Allocate zero'd memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_calloc_socket)
+RTE_EXPORT_SYMBOL(rte_calloc_socket);
 void *
 rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int socket)
 {
@@ -176,7 +176,7 @@ rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int
 /*
  * Allocate zero'd memory on default heap.
  */
-RTE_EXPORT_SYMBOL(rte_calloc)
+RTE_EXPORT_SYMBOL(rte_calloc);
 void *
 rte_calloc(const char *type, size_t num, size_t size, unsigned align)
 {
@@ -186,7 +186,7 @@ rte_calloc(const char *type, size_t num, size_t size, unsigned align)
 /*
  * Resize allocated memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_realloc_socket)
+RTE_EXPORT_SYMBOL(rte_realloc_socket);
 void *
 rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 {
@@ -238,14 +238,14 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 /*
  * Resize allocated memory.
  */
-RTE_EXPORT_SYMBOL(rte_realloc)
+RTE_EXPORT_SYMBOL(rte_realloc);
 void *
 rte_realloc(void *ptr, size_t size, unsigned int align)
 {
 	return rte_realloc_socket(ptr, size, align, SOCKET_ID_ANY);
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_validate)
+RTE_EXPORT_SYMBOL(rte_malloc_validate);
 int
 rte_malloc_validate(const void *ptr, size_t *size)
 {
@@ -260,7 +260,7 @@ rte_malloc_validate(const void *ptr, size_t *size)
 /*
  * Function to retrieve data for heap on given socket
  */
-RTE_EXPORT_SYMBOL(rte_malloc_get_socket_stats)
+RTE_EXPORT_SYMBOL(rte_malloc_get_socket_stats);
 int
 rte_malloc_get_socket_stats(int socket,
 		struct rte_malloc_socket_stats *socket_stats)
@@ -279,7 +279,7 @@ rte_malloc_get_socket_stats(int socket,
 /*
  * Function to dump contents of all heaps
  */
-RTE_EXPORT_SYMBOL(rte_malloc_dump_heaps)
+RTE_EXPORT_SYMBOL(rte_malloc_dump_heaps);
 void
 rte_malloc_dump_heaps(FILE *f)
 {
@@ -292,7 +292,7 @@ rte_malloc_dump_heaps(FILE *f)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket);
 int
 rte_malloc_heap_get_socket(const char *name)
 {
@@ -329,7 +329,7 @@ rte_malloc_heap_get_socket(const char *name)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external);
 int
 rte_malloc_heap_socket_is_external(int socket_id)
 {
@@ -358,7 +358,7 @@ rte_malloc_heap_socket_is_external(int socket_id)
 /*
  * Print stats on memory type. If type is NULL, info on all types is printed
  */
-RTE_EXPORT_SYMBOL(rte_malloc_dump_stats)
+RTE_EXPORT_SYMBOL(rte_malloc_dump_stats);
 void
 rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 {
@@ -388,7 +388,7 @@ rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 /*
  * Return the IO address of a virtual address obtained through rte_malloc
  */
-RTE_EXPORT_SYMBOL(rte_malloc_virt2iova)
+RTE_EXPORT_SYMBOL(rte_malloc_virt2iova);
 rte_iova_t
 rte_malloc_virt2iova(const void *addr)
 {
@@ -426,7 +426,7 @@ find_named_heap(const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_add)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_add);
 int
 rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 		rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
@@ -482,7 +482,7 @@ rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_remove)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_remove);
 int
 rte_malloc_heap_memory_remove(const char *heap_name, void *va_addr, size_t len)
 {
@@ -598,21 +598,21 @@ sync_memory(const char *heap_name, void *va_addr, size_t len, bool attach)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_attach)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_attach);
 int
 rte_malloc_heap_memory_attach(const char *heap_name, void *va_addr, size_t len)
 {
 	return sync_memory(heap_name, va_addr, len, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_detach)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_detach);
 int
 rte_malloc_heap_memory_detach(const char *heap_name, void *va_addr, size_t len)
 {
 	return sync_memory(heap_name, va_addr, len, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_create)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_create);
 int
 rte_malloc_heap_create(const char *heap_name)
 {
@@ -664,7 +664,7 @@ rte_malloc_heap_create(const char *heap_name)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_destroy)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_destroy);
 int
 rte_malloc_heap_destroy(const char *heap_name)
 {
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 576a32a46c..d995113793 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -83,7 +83,7 @@ __rte_srand_lfsr258(uint64_t seed, struct rte_rand_state *state)
 	state->z5 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 8388608UL);
 }
 
-RTE_EXPORT_SYMBOL(rte_srand)
+RTE_EXPORT_SYMBOL(rte_srand);
 void
 rte_srand(uint64_t seed)
 {
@@ -144,7 +144,7 @@ struct rte_rand_state *__rte_rand_get_state(void)
 	return RTE_LCORE_VAR(rand_state);
 }
 
-RTE_EXPORT_SYMBOL(rte_rand)
+RTE_EXPORT_SYMBOL(rte_rand);
 uint64_t
 rte_rand(void)
 {
@@ -155,7 +155,7 @@ rte_rand(void)
 	return __rte_rand_lfsr258(state);
 }
 
-RTE_EXPORT_SYMBOL(rte_rand_max)
+RTE_EXPORT_SYMBOL(rte_rand_max);
 uint64_t
 rte_rand_max(uint64_t upper_bound)
 {
@@ -195,7 +195,7 @@ rte_rand_max(uint64_t upper_bound)
 	return res;
 }
 
-RTE_EXPORT_SYMBOL(rte_drand)
+RTE_EXPORT_SYMBOL(rte_drand);
 double
 rte_drand(void)
 {
diff --git a/lib/eal/common/rte_reciprocal.c b/lib/eal/common/rte_reciprocal.c
index 99c54df141..12b329484c 100644
--- a/lib/eal/common/rte_reciprocal.c
+++ b/lib/eal/common/rte_reciprocal.c
@@ -13,7 +13,7 @@
 
 #include "rte_reciprocal.h"
 
-RTE_EXPORT_SYMBOL(rte_reciprocal_value)
+RTE_EXPORT_SYMBOL(rte_reciprocal_value);
 struct rte_reciprocal rte_reciprocal_value(uint32_t d)
 {
 	struct rte_reciprocal R;
@@ -101,7 +101,7 @@ divide_128_div_64_to_64(uint64_t u1, uint64_t u0, uint64_t v, uint64_t *r)
 	return q1*b + q0;
 }
 
-RTE_EXPORT_SYMBOL(rte_reciprocal_value_u64)
+RTE_EXPORT_SYMBOL(rte_reciprocal_value_u64);
 struct rte_reciprocal_u64
 rte_reciprocal_value_u64(uint64_t d)
 {
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index d2ac9d3f14..83cf5d3e12 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -121,7 +121,7 @@ rte_service_init(void)
 	return -ENOMEM;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_finalize)
+RTE_EXPORT_SYMBOL(rte_service_finalize);
 void
 rte_service_finalize(void)
 {
@@ -176,7 +176,7 @@ service_mt_safe(struct rte_service_spec_impl *s)
 	return !!(s->spec.capabilities & RTE_SERVICE_CAP_MT_SAFE);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_set_stats_enable)
+RTE_EXPORT_SYMBOL(rte_service_set_stats_enable);
 int32_t
 rte_service_set_stats_enable(uint32_t id, int32_t enabled)
 {
@@ -191,7 +191,7 @@ rte_service_set_stats_enable(uint32_t id, int32_t enabled)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_set_runstate_mapped_check)
+RTE_EXPORT_SYMBOL(rte_service_set_runstate_mapped_check);
 int32_t
 rte_service_set_runstate_mapped_check(uint32_t id, int32_t enabled)
 {
@@ -206,14 +206,14 @@ rte_service_set_runstate_mapped_check(uint32_t id, int32_t enabled)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_get_count)
+RTE_EXPORT_SYMBOL(rte_service_get_count);
 uint32_t
 rte_service_get_count(void)
 {
 	return rte_service_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_get_by_name)
+RTE_EXPORT_SYMBOL(rte_service_get_by_name);
 int32_t
 rte_service_get_by_name(const char *name, uint32_t *service_id)
 {
@@ -232,7 +232,7 @@ rte_service_get_by_name(const char *name, uint32_t *service_id)
 	return -ENODEV;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_get_name)
+RTE_EXPORT_SYMBOL(rte_service_get_name);
 const char *
 rte_service_get_name(uint32_t id)
 {
@@ -241,7 +241,7 @@ rte_service_get_name(uint32_t id)
 	return s->spec.name;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_probe_capability)
+RTE_EXPORT_SYMBOL(rte_service_probe_capability);
 int32_t
 rte_service_probe_capability(uint32_t id, uint32_t capability)
 {
@@ -250,7 +250,7 @@ rte_service_probe_capability(uint32_t id, uint32_t capability)
 	return !!(s->spec.capabilities & capability);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_component_register)
+RTE_EXPORT_SYMBOL(rte_service_component_register);
 int32_t
 rte_service_component_register(const struct rte_service_spec *spec,
 			       uint32_t *id_ptr)
@@ -285,7 +285,7 @@ rte_service_component_register(const struct rte_service_spec *spec,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_component_unregister)
+RTE_EXPORT_SYMBOL(rte_service_component_unregister);
 int32_t
 rte_service_component_unregister(uint32_t id)
 {
@@ -307,7 +307,7 @@ rte_service_component_unregister(uint32_t id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_component_runstate_set)
+RTE_EXPORT_SYMBOL(rte_service_component_runstate_set);
 int32_t
 rte_service_component_runstate_set(uint32_t id, uint32_t runstate)
 {
@@ -328,7 +328,7 @@ rte_service_component_runstate_set(uint32_t id, uint32_t runstate)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_runstate_set)
+RTE_EXPORT_SYMBOL(rte_service_runstate_set);
 int32_t
 rte_service_runstate_set(uint32_t id, uint32_t runstate)
 {
@@ -350,7 +350,7 @@ rte_service_runstate_set(uint32_t id, uint32_t runstate)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_runstate_get)
+RTE_EXPORT_SYMBOL(rte_service_runstate_get);
 int32_t
 rte_service_runstate_get(uint32_t id)
 {
@@ -461,7 +461,7 @@ service_run(uint32_t i, struct core_state *cs, const uint64_t *mapped_services,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_may_be_active)
+RTE_EXPORT_SYMBOL(rte_service_may_be_active);
 int32_t
 rte_service_may_be_active(uint32_t id)
 {
@@ -483,7 +483,7 @@ rte_service_may_be_active(uint32_t id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_run_iter_on_app_lcore)
+RTE_EXPORT_SYMBOL(rte_service_run_iter_on_app_lcore);
 int32_t
 rte_service_run_iter_on_app_lcore(uint32_t id, uint32_t serialize_mt_unsafe)
 {
@@ -543,7 +543,7 @@ service_runner_func(void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_may_be_active)
+RTE_EXPORT_SYMBOL(rte_service_lcore_may_be_active);
 int32_t
 rte_service_lcore_may_be_active(uint32_t lcore)
 {
@@ -559,7 +559,7 @@ rte_service_lcore_may_be_active(uint32_t lcore)
 			       rte_memory_order_acquire);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_count)
+RTE_EXPORT_SYMBOL(rte_service_lcore_count);
 int32_t
 rte_service_lcore_count(void)
 {
@@ -573,7 +573,7 @@ rte_service_lcore_count(void)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_list)
+RTE_EXPORT_SYMBOL(rte_service_lcore_list);
 int32_t
 rte_service_lcore_list(uint32_t array[], uint32_t n)
 {
@@ -598,7 +598,7 @@ rte_service_lcore_list(uint32_t array[], uint32_t n)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_count_services)
+RTE_EXPORT_SYMBOL(rte_service_lcore_count_services);
 int32_t
 rte_service_lcore_count_services(uint32_t lcore)
 {
@@ -612,7 +612,7 @@ rte_service_lcore_count_services(uint32_t lcore)
 	return rte_bitset_count_set(cs->mapped_services, RTE_SERVICE_NUM_MAX);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_start_with_defaults)
+RTE_EXPORT_SYMBOL(rte_service_start_with_defaults);
 int32_t
 rte_service_start_with_defaults(void)
 {
@@ -686,7 +686,7 @@ service_update(uint32_t sid, uint32_t lcore, uint32_t *set, uint32_t *enabled)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_map_lcore_set)
+RTE_EXPORT_SYMBOL(rte_service_map_lcore_set);
 int32_t
 rte_service_map_lcore_set(uint32_t id, uint32_t lcore, uint32_t enabled)
 {
@@ -695,7 +695,7 @@ rte_service_map_lcore_set(uint32_t id, uint32_t lcore, uint32_t enabled)
 	return service_update(id, lcore, &on, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_map_lcore_get)
+RTE_EXPORT_SYMBOL(rte_service_map_lcore_get);
 int32_t
 rte_service_map_lcore_get(uint32_t id, uint32_t lcore)
 {
@@ -723,7 +723,7 @@ set_lcore_state(uint32_t lcore, int32_t state)
 	rte_eal_trace_service_lcore_state_change(lcore, state);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_reset_all)
+RTE_EXPORT_SYMBOL(rte_service_lcore_reset_all);
 int32_t
 rte_service_lcore_reset_all(void)
 {
@@ -750,7 +750,7 @@ rte_service_lcore_reset_all(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_add)
+RTE_EXPORT_SYMBOL(rte_service_lcore_add);
 int32_t
 rte_service_lcore_add(uint32_t lcore)
 {
@@ -774,7 +774,7 @@ rte_service_lcore_add(uint32_t lcore)
 	return rte_eal_wait_lcore(lcore);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_del)
+RTE_EXPORT_SYMBOL(rte_service_lcore_del);
 int32_t
 rte_service_lcore_del(uint32_t lcore)
 {
@@ -799,7 +799,7 @@ rte_service_lcore_del(uint32_t lcore)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_start)
+RTE_EXPORT_SYMBOL(rte_service_lcore_start);
 int32_t
 rte_service_lcore_start(uint32_t lcore)
 {
@@ -833,7 +833,7 @@ rte_service_lcore_start(uint32_t lcore)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_stop)
+RTE_EXPORT_SYMBOL(rte_service_lcore_stop);
 int32_t
 rte_service_lcore_stop(uint32_t lcore)
 {
@@ -974,7 +974,7 @@ attr_get_service_cycles(uint32_t service_id)
 	return attr_get(service_id, lcore_attr_get_service_cycles);
 }
 
-RTE_EXPORT_SYMBOL(rte_service_attr_get)
+RTE_EXPORT_SYMBOL(rte_service_attr_get);
 int32_t
 rte_service_attr_get(uint32_t id, uint32_t attr_id, uint64_t *attr_value)
 {
@@ -1002,7 +1002,7 @@ rte_service_attr_get(uint32_t id, uint32_t attr_id, uint64_t *attr_value)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_attr_get)
+RTE_EXPORT_SYMBOL(rte_service_lcore_attr_get);
 int32_t
 rte_service_lcore_attr_get(uint32_t lcore, uint32_t attr_id,
 			   uint64_t *attr_value)
@@ -1027,7 +1027,7 @@ rte_service_lcore_attr_get(uint32_t lcore, uint32_t attr_id,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_service_attr_reset_all)
+RTE_EXPORT_SYMBOL(rte_service_attr_reset_all);
 int32_t
 rte_service_attr_reset_all(uint32_t id)
 {
@@ -1046,7 +1046,7 @@ rte_service_attr_reset_all(uint32_t id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_service_lcore_attr_reset_all)
+RTE_EXPORT_SYMBOL(rte_service_lcore_attr_reset_all);
 int32_t
 rte_service_lcore_attr_reset_all(uint32_t lcore)
 {
@@ -1100,7 +1100,7 @@ service_dump_calls_per_lcore(FILE *f, uint32_t lcore)
 	fprintf(f, "\n");
 }
 
-RTE_EXPORT_SYMBOL(rte_service_dump)
+RTE_EXPORT_SYMBOL(rte_service_dump);
 int32_t
 rte_service_dump(FILE *f, uint32_t id)
 {
diff --git a/lib/eal/common/rte_version.c b/lib/eal/common/rte_version.c
index 627b89d4a8..529aedfa71 100644
--- a/lib/eal/common/rte_version.c
+++ b/lib/eal/common/rte_version.c
@@ -5,31 +5,31 @@
 #include <eal_export.h>
 #include <rte_version.h>
 
-RTE_EXPORT_SYMBOL(rte_version_prefix)
+RTE_EXPORT_SYMBOL(rte_version_prefix);
 const char *
 rte_version_prefix(void) { return RTE_VER_PREFIX; }
 
-RTE_EXPORT_SYMBOL(rte_version_year)
+RTE_EXPORT_SYMBOL(rte_version_year);
 unsigned int
 rte_version_year(void) { return RTE_VER_YEAR; }
 
-RTE_EXPORT_SYMBOL(rte_version_month)
+RTE_EXPORT_SYMBOL(rte_version_month);
 unsigned int
 rte_version_month(void) { return RTE_VER_MONTH; }
 
-RTE_EXPORT_SYMBOL(rte_version_minor)
+RTE_EXPORT_SYMBOL(rte_version_minor);
 unsigned int
 rte_version_minor(void) { return RTE_VER_MINOR; }
 
-RTE_EXPORT_SYMBOL(rte_version_suffix)
+RTE_EXPORT_SYMBOL(rte_version_suffix);
 const char *
 rte_version_suffix(void) { return RTE_VER_SUFFIX; }
 
-RTE_EXPORT_SYMBOL(rte_version_release)
+RTE_EXPORT_SYMBOL(rte_version_release);
 unsigned int
 rte_version_release(void) { return RTE_VER_RELEASE; }
 
-RTE_EXPORT_SYMBOL(rte_version)
+RTE_EXPORT_SYMBOL(rte_version);
 const char *
 rte_version(void)
 {
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index c1ab8d86d2..7da0e2914c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -74,7 +74,7 @@ static struct flock wr_lock = {
 struct lcore_config lcore_config[RTE_MAX_LCORE];
 
 /* used by rte_rdtsc() */
-RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
+RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map);
 int rte_cycles_vmware_tsc_map;
 
 
@@ -517,7 +517,7 @@ sync_func(__rte_unused void *arg)
 	return 0;
 }
 /* Abstraction for port I/0 privilege */
-RTE_EXPORT_SYMBOL(rte_eal_iopl_init)
+RTE_EXPORT_SYMBOL(rte_eal_iopl_init);
 int
 rte_eal_iopl_init(void)
 {
@@ -538,7 +538,7 @@ static void rte_eal_init_alert(const char *msg)
 }
 
 /* Launch threads, called at application init(). */
-RTE_EXPORT_SYMBOL(rte_eal_init)
+RTE_EXPORT_SYMBOL(rte_eal_init);
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -888,7 +888,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_cleanup)
+RTE_EXPORT_SYMBOL(rte_eal_cleanup);
 int
 rte_eal_cleanup(void)
 {
@@ -917,7 +917,7 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
+RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev);
 int rte_eal_create_uio_dev(void)
 {
 	const struct internal_config *internal_conf =
@@ -925,20 +925,20 @@ int rte_eal_create_uio_dev(void)
 	return internal_conf->create_uio_dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
+RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode);
 enum rte_intr_mode
 rte_eal_vfio_intr_mode(void)
 {
 	return RTE_INTR_MODE_NONE;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token)
+RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token);
 void
 rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
+RTE_EXPORT_SYMBOL(rte_vfio_setup_device);
 int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 		      __rte_unused const char *dev_addr,
 		      __rte_unused int *vfio_dev_fd,
@@ -948,7 +948,7 @@ int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_release_device)
+RTE_EXPORT_SYMBOL(rte_vfio_release_device);
 int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 			__rte_unused const char *dev_addr,
 			__rte_unused int fd)
@@ -957,33 +957,33 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_enable)
+RTE_EXPORT_SYMBOL(rte_vfio_enable);
 int rte_vfio_enable(__rte_unused const char *modname)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_SYMBOL(rte_vfio_is_enabled);
 int rte_vfio_is_enabled(__rte_unused const char *modname)
 {
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
+RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled);
 int rte_vfio_noiommu_is_enabled(void)
 {
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
+RTE_EXPORT_SYMBOL(rte_vfio_clear_group);
 int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_num);
 int
 rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 		       __rte_unused const char *dev_addr,
@@ -993,7 +993,7 @@ rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd);
 int
 rte_vfio_get_container_fd(void)
 {
@@ -1001,7 +1001,7 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd);
 int
 rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 {
@@ -1009,7 +1009,7 @@ rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_SYMBOL(rte_vfio_container_create);
 int
 rte_vfio_container_create(void)
 {
@@ -1017,7 +1017,7 @@ rte_vfio_container_create(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_SYMBOL(rte_vfio_container_destroy);
 int
 rte_vfio_container_destroy(__rte_unused int container_fd)
 {
@@ -1025,7 +1025,7 @@ rte_vfio_container_destroy(__rte_unused int container_fd)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind);
 int
 rte_vfio_container_group_bind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -1034,7 +1034,7 @@ rte_vfio_container_group_bind(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind);
 int
 rte_vfio_container_group_unbind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -1043,7 +1043,7 @@ rte_vfio_container_group_unbind(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map);
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -1054,7 +1054,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap);
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index c03e281e67..ae318313de 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -207,7 +207,7 @@ eal_alarm_callback(void *arg __rte_unused)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set);
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -260,7 +260,7 @@ rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel);
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/freebsd/eal_dev.c b/lib/eal/freebsd/eal_dev.c
index 737d1040ea..ca2b721d09 100644
--- a/lib/eal/freebsd/eal_dev.c
+++ b/lib/eal/freebsd/eal_dev.c
@@ -8,7 +8,7 @@
 #include <eal_export.h>
 #include "eal_private.h"
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start);
 int
 rte_dev_event_monitor_start(void)
 {
@@ -16,7 +16,7 @@ rte_dev_event_monitor_start(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop);
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -24,7 +24,7 @@ rte_dev_event_monitor_stop(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable);
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -32,7 +32,7 @@ rte_dev_hotplug_handle_enable(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable);
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 5c3ab6699e..1b55c8590f 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -81,7 +81,7 @@ intr_source_to_kevent(const struct rte_intr_handle *ih, struct kevent *ke)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_register)
+RTE_EXPORT_SYMBOL(rte_intr_callback_register);
 int
 rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb, void *cb_arg)
@@ -213,7 +213,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending);
 int
 rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 				rte_intr_callback_fn cb_fn, void *cb_arg,
@@ -270,7 +270,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister);
 int
 rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -358,7 +358,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync);
 int
 rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -371,7 +371,7 @@ rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_enable)
+RTE_EXPORT_SYMBOL(rte_intr_enable);
 int
 rte_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -413,7 +413,7 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_disable)
+RTE_EXPORT_SYMBOL(rte_intr_disable);
 int
 rte_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -454,7 +454,7 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_ack)
+RTE_EXPORT_SYMBOL(rte_intr_ack);
 int
 rte_intr_ack(const struct rte_intr_handle *intr_handle)
 {
@@ -711,7 +711,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait)
+RTE_EXPORT_SYMBOL(rte_epoll_wait);
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 		int maxevents, int timeout)
@@ -724,7 +724,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible);
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -737,7 +737,7 @@ rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_ctl)
+RTE_EXPORT_SYMBOL(rte_epoll_ctl);
 int
 rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 {
@@ -763,7 +763,7 @@ rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 	RTE_SET_USED(intr_handle);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_is_intr)
+RTE_EXPORT_SYMBOL(rte_thread_is_intr);
 int rte_thread_is_intr(void)
 {
 	return rte_thread_equal(intr_thread, rte_thread_self());
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 6d3d46a390..37b7852430 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -36,7 +36,7 @@ uint64_t eal_get_baseaddr(void)
 /*
  * Get physical address of any mapped virtual address in the current process.
  */
-RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy);
 phys_addr_t
 rte_mem_virt2phy(const void *virtaddr)
 {
@@ -45,7 +45,7 @@ rte_mem_virt2phy(const void *virtaddr)
 	(void)virtaddr;
 	return RTE_BAD_IOVA;
 }
-RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova);
 rte_iova_t
 rte_mem_virt2iova(const void *virtaddr)
 {
@@ -297,7 +297,7 @@ rte_eal_hugepage_attach(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs);
 int
 rte_eal_using_phys_addrs(void)
 {
diff --git a/lib/eal/freebsd/eal_thread.c b/lib/eal/freebsd/eal_thread.c
index 7ed76ed796..53755f6b54 100644
--- a/lib/eal/freebsd/eal_thread.c
+++ b/lib/eal/freebsd/eal_thread.c
@@ -26,7 +26,7 @@
 #include "eal_thread.h"
 
 /* require calling thread tid by gettid() */
-RTE_EXPORT_SYMBOL(rte_sys_gettid)
+RTE_EXPORT_SYMBOL(rte_sys_gettid);
 int rte_sys_gettid(void)
 {
 	long lwpid;
@@ -34,7 +34,7 @@ int rte_sys_gettid(void)
 	return (int)lwpid;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_name)
+RTE_EXPORT_SYMBOL(rte_thread_set_name);
 void rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
 	char truncated[RTE_THREAD_NAME_SIZE];
diff --git a/lib/eal/freebsd/eal_timer.c b/lib/eal/freebsd/eal_timer.c
index d21ffa2694..46c90e3b03 100644
--- a/lib/eal/freebsd/eal_timer.c
+++ b/lib/eal/freebsd/eal_timer.c
@@ -24,7 +24,7 @@
 #warning HPET is not supported in FreeBSD
 #endif
 
-RTE_EXPORT_SYMBOL(eal_timer_source)
+RTE_EXPORT_SYMBOL(eal_timer_source);
 enum timer_source eal_timer_source = EAL_TIMER_TSC;
 
 uint64_t
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 52efb8626b..e3b3f99830 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -79,7 +79,7 @@ static struct flock wr_lock = {
 struct lcore_config lcore_config[RTE_MAX_LCORE];
 
 /* used by rte_rdtsc() */
-RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
+RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map);
 int rte_cycles_vmware_tsc_map;
 
 
@@ -828,7 +828,7 @@ sync_func(__rte_unused void *arg)
  * iopl() call is mostly for the i386 architecture. For other architectures,
  * return -1 to indicate IO privilege can't be changed in this way.
  */
-RTE_EXPORT_SYMBOL(rte_eal_iopl_init)
+RTE_EXPORT_SYMBOL(rte_eal_iopl_init);
 int
 rte_eal_iopl_init(void)
 {
@@ -924,7 +924,7 @@ eal_worker_thread_create(unsigned int lcore_id)
 }
 
 /* Launch threads, called at application init(). */
-RTE_EXPORT_SYMBOL(rte_eal_init)
+RTE_EXPORT_SYMBOL(rte_eal_init);
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -1305,7 +1305,7 @@ mark_freeable(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_cleanup)
+RTE_EXPORT_SYMBOL(rte_eal_cleanup);
 int
 rte_eal_cleanup(void)
 {
@@ -1348,7 +1348,7 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
+RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev);
 int rte_eal_create_uio_dev(void)
 {
 	const struct internal_config *internal_conf =
@@ -1357,7 +1357,7 @@ int rte_eal_create_uio_dev(void)
 	return internal_conf->create_uio_dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
+RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode);
 enum rte_intr_mode
 rte_eal_vfio_intr_mode(void)
 {
@@ -1367,7 +1367,7 @@ rte_eal_vfio_intr_mode(void)
 	return internal_conf->vfio_intr_mode;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token)
+RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token);
 void
 rte_eal_vfio_get_vf_token(rte_uuid_t vf_token)
 {
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index eb6a21d4f0..4bb5117cdc 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -135,7 +135,7 @@ eal_alarm_callback(void *arg __rte_unused)
 	rte_spinlock_unlock(&alarm_list_lk);
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set);
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -200,7 +200,7 @@ rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel);
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 33b78464d5..c1801cd520 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -304,7 +304,7 @@ dev_uev_handler(__rte_unused void *param)
 	free(uevent.devname);
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start);
 int
 rte_dev_event_monitor_start(void)
 {
@@ -355,7 +355,7 @@ rte_dev_event_monitor_start(void)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop);
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -424,7 +424,7 @@ dev_sigbus_handler_unregister(void)
 	return rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable);
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -440,7 +440,7 @@ rte_dev_hotplug_handle_enable(void)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable);
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4ec78de82c..f2c89ae387 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -483,7 +483,7 @@ uio_intr_enable(const struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_register)
+RTE_EXPORT_SYMBOL(rte_intr_callback_register);
 int
 rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb, void *cb_arg)
@@ -568,7 +568,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending);
 int
 rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 				rte_intr_callback_fn cb_fn, void *cb_arg,
@@ -620,7 +620,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister);
 int
 rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -687,7 +687,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync);
 int
 rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -700,7 +700,7 @@ rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_enable)
+RTE_EXPORT_SYMBOL(rte_intr_enable);
 int
 rte_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -781,7 +781,7 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
  * auto-masked. In fact, for interrupt handle types VFIO_MSIX and VFIO_MSI,
  * this function is no-op.
  */
-RTE_EXPORT_SYMBOL(rte_intr_ack)
+RTE_EXPORT_SYMBOL(rte_intr_ack);
 int
 rte_intr_ack(const struct rte_intr_handle *intr_handle)
 {
@@ -834,7 +834,7 @@ rte_intr_ack(const struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_disable)
+RTE_EXPORT_SYMBOL(rte_intr_disable);
 int
 rte_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -1386,7 +1386,7 @@ eal_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait)
+RTE_EXPORT_SYMBOL(rte_epoll_wait);
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	       int maxevents, int timeout)
@@ -1394,7 +1394,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return eal_epoll_wait(epfd, events, maxevents, timeout, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible);
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -1419,7 +1419,7 @@ eal_epoll_data_safe_free(struct rte_epoll_event *ev)
 	ev->epfd = -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_ctl)
+RTE_EXPORT_SYMBOL(rte_epoll_ctl);
 int
 rte_epoll_ctl(int epfd, int op, int fd,
 	      struct rte_epoll_event *event)
@@ -1640,7 +1640,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_is_intr)
+RTE_EXPORT_SYMBOL(rte_thread_is_intr);
 int rte_thread_is_intr(void)
 {
 	return rte_thread_equal(intr_thread, rte_thread_self());
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index ee964446c7..9936c9ce36 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -86,7 +86,7 @@ uint64_t eal_get_baseaddr(void)
 /*
  * Get physical address of any mapped virtual address in the current process.
  */
-RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy);
 phys_addr_t
 rte_mem_virt2phy(const void *virtaddr)
 {
@@ -144,7 +144,7 @@ rte_mem_virt2phy(const void *virtaddr)
 	return physaddr;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova);
 rte_iova_t
 rte_mem_virt2iova(const void *virtaddr)
 {
@@ -1681,7 +1681,7 @@ rte_eal_hugepage_attach(void)
 			eal_hugepage_attach();
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs);
 int
 rte_eal_using_phys_addrs(void)
 {
diff --git a/lib/eal/linux/eal_thread.c b/lib/eal/linux/eal_thread.c
index c0056f825d..530fb265ba 100644
--- a/lib/eal/linux/eal_thread.c
+++ b/lib/eal/linux/eal_thread.c
@@ -17,13 +17,13 @@
 #include "eal_private.h"
 
 /* require calling thread tid by gettid() */
-RTE_EXPORT_SYMBOL(rte_sys_gettid)
+RTE_EXPORT_SYMBOL(rte_sys_gettid);
 int rte_sys_gettid(void)
 {
 	return (int)syscall(SYS_gettid);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_name)
+RTE_EXPORT_SYMBOL(rte_thread_set_name);
 void rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
 	int ret = ENOSYS;
diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 0e670a0af6..3bb91c682a 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -19,7 +19,7 @@
 #include <eal_export.h>
 #include "eal_private.h"
 
-RTE_EXPORT_SYMBOL(eal_timer_source)
+RTE_EXPORT_SYMBOL(eal_timer_source);
 enum timer_source eal_timer_source = EAL_TIMER_HPET;
 
 #ifdef RTE_LIBEAL_USE_HPET
@@ -95,7 +95,7 @@ hpet_msb_inc(__rte_unused void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_get_hpet_hz)
+RTE_EXPORT_SYMBOL(rte_get_hpet_hz);
 uint64_t
 rte_get_hpet_hz(void)
 {
@@ -108,7 +108,7 @@ rte_get_hpet_hz(void)
 	return eal_hpet_resolution_hz;
 }
 
-RTE_EXPORT_SYMBOL(rte_get_hpet_cycles)
+RTE_EXPORT_SYMBOL(rte_get_hpet_cycles);
 uint64_t
 rte_get_hpet_cycles(void)
 {
@@ -135,7 +135,7 @@ rte_get_hpet_cycles(void)
  * Open and mmap /dev/hpet (high precision event timer) that will
  * provide our time reference.
  */
-RTE_EXPORT_SYMBOL(rte_eal_hpet_init)
+RTE_EXPORT_SYMBOL(rte_eal_hpet_init);
 int
 rte_eal_hpet_init(int make_default)
 {
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 805f0ff92c..46db611147 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -517,7 +517,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd);
 int
 rte_vfio_get_group_fd(int iommu_group_num)
 {
@@ -716,7 +716,7 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
+RTE_EXPORT_SYMBOL(rte_vfio_clear_group);
 int
 rte_vfio_clear_group(int vfio_group_fd)
 {
@@ -740,7 +740,7 @@ rte_vfio_clear_group(int vfio_group_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
+RTE_EXPORT_SYMBOL(rte_vfio_setup_device);
 int
 rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
@@ -994,7 +994,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_release_device)
+RTE_EXPORT_SYMBOL(rte_vfio_release_device);
 int
 rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		    int vfio_dev_fd)
@@ -1083,7 +1083,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_enable)
+RTE_EXPORT_SYMBOL(rte_vfio_enable);
 int
 rte_vfio_enable(const char *modname)
 {
@@ -1160,7 +1160,7 @@ rte_vfio_enable(const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_SYMBOL(rte_vfio_is_enabled);
 int
 rte_vfio_is_enabled(const char *modname)
 {
@@ -1303,7 +1303,7 @@ vfio_has_supported_extensions(int vfio_container_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd);
 int
 rte_vfio_get_container_fd(void)
 {
@@ -1375,7 +1375,7 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_num);
 int
 rte_vfio_get_group_num(const char *sysfs_base,
 		const char *dev_addr, int *iommu_group_num)
@@ -2045,7 +2045,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
+RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled);
 int
 rte_vfio_noiommu_is_enabled(void)
 {
@@ -2078,7 +2078,7 @@ rte_vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_SYMBOL(rte_vfio_container_create);
 int
 rte_vfio_container_create(void)
 {
@@ -2104,7 +2104,7 @@ rte_vfio_container_create(void)
 	return vfio_cfgs[i].vfio_container_fd;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_SYMBOL(rte_vfio_container_destroy);
 int
 rte_vfio_container_destroy(int container_fd)
 {
@@ -2130,7 +2130,7 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind);
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
@@ -2145,7 +2145,7 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind);
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
@@ -2186,7 +2186,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map);
 int
 rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
@@ -2207,7 +2207,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_map(vfio_cfg, vaddr, iova, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap);
 int
 rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
diff --git a/lib/eal/loongarch/rte_cpuflags.c b/lib/eal/loongarch/rte_cpuflags.c
index 19fbf37e3e..9ad981f8fe 100644
--- a/lib/eal/loongarch/rte_cpuflags.c
+++ b/lib/eal/loongarch/rte_cpuflags.c
@@ -62,7 +62,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled);
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -80,7 +80,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name);
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -89,7 +89,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support);
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/loongarch/rte_hypervisor.c b/lib/eal/loongarch/rte_hypervisor.c
index 7dd70fe90c..0a463e98b6 100644
--- a/lib/eal/loongarch/rte_hypervisor.c
+++ b/lib/eal/loongarch/rte_hypervisor.c
@@ -5,7 +5,7 @@
 #include <eal_export.h>
 #include "rte_hypervisor.h"
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get);
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/loongarch/rte_power_intrinsics.c b/lib/eal/loongarch/rte_power_intrinsics.c
index e1a2b2d7ed..6c8e063609 100644
--- a/lib/eal/loongarch/rte_power_intrinsics.c
+++ b/lib/eal/loongarch/rte_power_intrinsics.c
@@ -10,7 +10,7 @@
 /**
  * This function is not supported on LOONGARCH.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor)
+RTE_EXPORT_SYMBOL(rte_power_monitor);
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -24,7 +24,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on LOONGARCH.
  */
-RTE_EXPORT_SYMBOL(rte_power_pause)
+RTE_EXPORT_SYMBOL(rte_power_pause);
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -36,7 +36,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on LOONGARCH.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup);
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -45,7 +45,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi);
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/ppc/rte_cpuflags.c b/lib/eal/ppc/rte_cpuflags.c
index a78a7d1b53..8569fdb3f7 100644
--- a/lib/eal/ppc/rte_cpuflags.c
+++ b/lib/eal/ppc/rte_cpuflags.c
@@ -86,7 +86,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled);
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -104,7 +104,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name);
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -113,7 +113,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support);
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/ppc/rte_hypervisor.c b/lib/eal/ppc/rte_hypervisor.c
index 51b224fb94..45e6ef667b 100644
--- a/lib/eal/ppc/rte_hypervisor.c
+++ b/lib/eal/ppc/rte_hypervisor.c
@@ -5,7 +5,7 @@
 #include <eal_export.h>
 #include "rte_hypervisor.h"
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get);
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/ppc/rte_power_intrinsics.c b/lib/eal/ppc/rte_power_intrinsics.c
index d9d8eb8d51..de1ebaad52 100644
--- a/lib/eal/ppc/rte_power_intrinsics.c
+++ b/lib/eal/ppc/rte_power_intrinsics.c
@@ -10,7 +10,7 @@
 /**
  * This function is not supported on PPC64.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor)
+RTE_EXPORT_SYMBOL(rte_power_monitor);
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -24,7 +24,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on PPC64.
  */
-RTE_EXPORT_SYMBOL(rte_power_pause)
+RTE_EXPORT_SYMBOL(rte_power_pause);
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -36,7 +36,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on PPC64.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup);
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -45,7 +45,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi);
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/riscv/rte_cpuflags.c b/lib/eal/riscv/rte_cpuflags.c
index 4dec491b0d..815028220c 100644
--- a/lib/eal/riscv/rte_cpuflags.c
+++ b/lib/eal/riscv/rte_cpuflags.c
@@ -91,7 +91,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled);
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -109,7 +109,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name);
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -118,7 +118,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support);
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/riscv/rte_hypervisor.c b/lib/eal/riscv/rte_hypervisor.c
index 73020f7753..acc698b8a4 100644
--- a/lib/eal/riscv/rte_hypervisor.c
+++ b/lib/eal/riscv/rte_hypervisor.c
@@ -7,7 +7,7 @@
 #include <eal_export.h>
 #include "rte_hypervisor.h"
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get);
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/riscv/rte_power_intrinsics.c b/lib/eal/riscv/rte_power_intrinsics.c
index 11eff53ff2..9a84447a20 100644
--- a/lib/eal/riscv/rte_power_intrinsics.c
+++ b/lib/eal/riscv/rte_power_intrinsics.c
@@ -12,7 +12,7 @@
 /**
  * This function is not supported on RISC-V 64
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor)
+RTE_EXPORT_SYMBOL(rte_power_monitor);
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		  const uint64_t tsc_timestamp)
@@ -26,7 +26,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on RISC-V 64
  */
-RTE_EXPORT_SYMBOL(rte_power_pause)
+RTE_EXPORT_SYMBOL(rte_power_pause);
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -38,7 +38,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on RISC-V 64
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup);
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -50,7 +50,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 /**
  * This function is not supported on RISC-V 64
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi);
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 			const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/unix/eal_debug.c b/lib/eal/unix/eal_debug.c
index e3689531e4..86e02b9665 100644
--- a/lib/eal/unix/eal_debug.c
+++ b/lib/eal/unix/eal_debug.c
@@ -47,7 +47,7 @@ static char *safe_itoa(long val, char *buf, size_t len, unsigned int radix)
  * Most of libc is therefore not safe, include RTE_LOG (calls syslog);
  * backtrace_symbols (calls malloc), etc.
  */
-RTE_EXPORT_SYMBOL(rte_dump_stack)
+RTE_EXPORT_SYMBOL(rte_dump_stack);
 void rte_dump_stack(void)
 {
 	void *func[BACKTRACE_SIZE];
@@ -124,7 +124,7 @@ void rte_dump_stack(void)
 #else /* !RTE_BACKTRACE */
 
 /* stub if not enabled */
-RTE_EXPORT_SYMBOL(rte_dump_stack)
+RTE_EXPORT_SYMBOL(rte_dump_stack);
 void rte_dump_stack(void) { }
 
 #endif /* RTE_BACKTRACE */
diff --git a/lib/eal/unix/eal_filesystem.c b/lib/eal/unix/eal_filesystem.c
index 6b8451cd3e..b67cfc0b7b 100644
--- a/lib/eal/unix/eal_filesystem.c
+++ b/lib/eal/unix/eal_filesystem.c
@@ -78,7 +78,7 @@ int eal_create_runtime_dir(void)
 }
 
 /* parse a sysfs (or other) file containing one integer value */
-RTE_EXPORT_SYMBOL(eal_parse_sysfs_value)
+RTE_EXPORT_SYMBOL(eal_parse_sysfs_value);
 int eal_parse_sysfs_value(const char *filename, unsigned long *val)
 {
 	FILE *f;
diff --git a/lib/eal/unix/eal_unix_timer.c b/lib/eal/unix/eal_unix_timer.c
index 3dbcf61e90..27679601cf 100644
--- a/lib/eal/unix/eal_unix_timer.c
+++ b/lib/eal/unix/eal_unix_timer.c
@@ -8,7 +8,7 @@
 #include <eal_export.h>
 #include <rte_cycles.h>
 
-RTE_EXPORT_SYMBOL(rte_delay_us_sleep)
+RTE_EXPORT_SYMBOL(rte_delay_us_sleep);
 void
 rte_delay_us_sleep(unsigned int us)
 {
diff --git a/lib/eal/unix/rte_thread.c b/lib/eal/unix/rte_thread.c
index 950c0848ba..c1bb4d7091 100644
--- a/lib/eal/unix/rte_thread.c
+++ b/lib/eal/unix/rte_thread.c
@@ -119,7 +119,7 @@ thread_start_wrapper(void *arg)
 }
 #endif
 
-RTE_EXPORT_SYMBOL(rte_thread_create)
+RTE_EXPORT_SYMBOL(rte_thread_create);
 int
 rte_thread_create(rte_thread_t *thread_id,
 		const rte_thread_attr_t *thread_attr,
@@ -228,7 +228,7 @@ rte_thread_create(rte_thread_t *thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_join)
+RTE_EXPORT_SYMBOL(rte_thread_join);
 int
 rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 {
@@ -251,21 +251,21 @@ rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_detach)
+RTE_EXPORT_SYMBOL(rte_thread_detach);
 int
 rte_thread_detach(rte_thread_t thread_id)
 {
 	return pthread_detach((pthread_t)thread_id.opaque_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_equal)
+RTE_EXPORT_SYMBOL(rte_thread_equal);
 int
 rte_thread_equal(rte_thread_t t1, rte_thread_t t2)
 {
 	return pthread_equal((pthread_t)t1.opaque_id, (pthread_t)t2.opaque_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_self)
+RTE_EXPORT_SYMBOL(rte_thread_self);
 rte_thread_t
 rte_thread_self(void)
 {
@@ -278,7 +278,7 @@ rte_thread_self(void)
 	return thread_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_get_priority)
+RTE_EXPORT_SYMBOL(rte_thread_get_priority);
 int
 rte_thread_get_priority(rte_thread_t thread_id,
 	enum rte_thread_priority *priority)
@@ -301,7 +301,7 @@ rte_thread_get_priority(rte_thread_t thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_priority)
+RTE_EXPORT_SYMBOL(rte_thread_set_priority);
 int
 rte_thread_set_priority(rte_thread_t thread_id,
 	enum rte_thread_priority priority)
@@ -323,7 +323,7 @@ rte_thread_set_priority(rte_thread_t thread_id,
 		&param);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_key_create)
+RTE_EXPORT_SYMBOL(rte_thread_key_create);
 int
 rte_thread_key_create(rte_thread_key *key, void (*destructor)(void *))
 {
@@ -346,7 +346,7 @@ rte_thread_key_create(rte_thread_key *key, void (*destructor)(void *))
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_key_delete)
+RTE_EXPORT_SYMBOL(rte_thread_key_delete);
 int
 rte_thread_key_delete(rte_thread_key key)
 {
@@ -369,7 +369,7 @@ rte_thread_key_delete(rte_thread_key key)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_value_set)
+RTE_EXPORT_SYMBOL(rte_thread_value_set);
 int
 rte_thread_value_set(rte_thread_key key, const void *value)
 {
@@ -390,7 +390,7 @@ rte_thread_value_set(rte_thread_key key, const void *value)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_value_get)
+RTE_EXPORT_SYMBOL(rte_thread_value_get);
 void *
 rte_thread_value_get(rte_thread_key key)
 {
@@ -402,7 +402,7 @@ rte_thread_value_get(rte_thread_key key)
 	return pthread_getspecific(key->thread_index);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id)
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id);
 int
 rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		const rte_cpuset_t *cpuset)
@@ -411,7 +411,7 @@ rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		sizeof(*cpuset), cpuset);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id)
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id);
 int
 rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 4f0a164d9b..8e5d840d91 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -75,7 +75,7 @@ eal_proc_type_detect(void)
 	return ptype;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_disable)
+RTE_EXPORT_SYMBOL(rte_mp_disable);
 bool
 rte_mp_disable(void)
 {
@@ -228,7 +228,7 @@ __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_cleanup)
+RTE_EXPORT_SYMBOL(rte_eal_cleanup);
 int
 rte_eal_cleanup(void)
 {
@@ -246,7 +246,7 @@ rte_eal_cleanup(void)
 }
 
 /* Launch threads, called at application init(). */
-RTE_EXPORT_SYMBOL(rte_eal_init)
+RTE_EXPORT_SYMBOL(rte_eal_init);
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -520,7 +520,7 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map);
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -531,7 +531,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap);
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
diff --git a/lib/eal/windows/eal_alarm.c b/lib/eal/windows/eal_alarm.c
index 0b11d331dc..11d35a7828 100644
--- a/lib/eal/windows/eal_alarm.c
+++ b/lib/eal/windows/eal_alarm.c
@@ -84,7 +84,7 @@ alarm_task_exec(void *arg)
 	task->ret = alarm_set(task->entry, task->deadline);
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set);
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -186,7 +186,7 @@ alarm_matches(const struct alarm_entry *ap,
 	return (ap->cb_fn == cb_fn) && (any_arg || ap->cb_arg == cb_arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel);
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/windows/eal_debug.c b/lib/eal/windows/eal_debug.c
index a4549e1179..7355826cb8 100644
--- a/lib/eal/windows/eal_debug.c
+++ b/lib/eal/windows/eal_debug.c
@@ -15,7 +15,7 @@
 #define BACKTRACE_SIZE 256
 
 /* dump the stack of the calling core */
-RTE_EXPORT_SYMBOL(rte_dump_stack)
+RTE_EXPORT_SYMBOL(rte_dump_stack);
 void
 rte_dump_stack(void)
 {
diff --git a/lib/eal/windows/eal_dev.c b/lib/eal/windows/eal_dev.c
index 9c7463edf2..4c74162ca0 100644
--- a/lib/eal/windows/eal_dev.c
+++ b/lib/eal/windows/eal_dev.c
@@ -7,7 +7,7 @@
 
 #include "eal_private.h"
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start);
 int
 rte_dev_event_monitor_start(void)
 {
@@ -15,7 +15,7 @@ rte_dev_event_monitor_start(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop);
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -23,7 +23,7 @@ rte_dev_event_monitor_stop(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable);
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -31,7 +31,7 @@ rte_dev_hotplug_handle_enable(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable);
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/windows/eal_interrupts.c b/lib/eal/windows/eal_interrupts.c
index 5ff30c7631..f380272219 100644
--- a/lib/eal/windows/eal_interrupts.c
+++ b/lib/eal/windows/eal_interrupts.c
@@ -109,7 +109,7 @@ rte_eal_intr_init(void)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_is_intr)
+RTE_EXPORT_SYMBOL(rte_thread_is_intr);
 int
 rte_thread_is_intr(void)
 {
@@ -150,7 +150,7 @@ eal_intr_thread_cancel(void)
 	WaitForSingleObject(intr_thread_handle, INFINITE);
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_register)
+RTE_EXPORT_SYMBOL(rte_intr_callback_register);
 int
 rte_intr_callback_register(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -159,7 +159,7 @@ rte_intr_callback_register(
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending);
 int
 rte_intr_callback_unregister_pending(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -169,7 +169,7 @@ rte_intr_callback_unregister_pending(
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister);
 int
 rte_intr_callback_unregister(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -178,7 +178,7 @@ rte_intr_callback_unregister(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync);
 int
 rte_intr_callback_unregister_sync(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -187,21 +187,21 @@ rte_intr_callback_unregister_sync(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_enable)
+RTE_EXPORT_SYMBOL(rte_intr_enable);
 int
 rte_intr_enable(__rte_unused const struct rte_intr_handle *intr_handle)
 {
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_ack)
+RTE_EXPORT_SYMBOL(rte_intr_ack);
 int
 rte_intr_ack(__rte_unused const struct rte_intr_handle *intr_handle)
 {
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_intr_disable)
+RTE_EXPORT_SYMBOL(rte_intr_disable);
 int
 rte_intr_disable(__rte_unused const struct rte_intr_handle *intr_handle)
 {
@@ -252,7 +252,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait)
+RTE_EXPORT_SYMBOL(rte_epoll_wait);
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 		int maxevents, int timeout)
@@ -265,7 +265,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible);
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -278,7 +278,7 @@ rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_epoll_ctl)
+RTE_EXPORT_SYMBOL(rte_epoll_ctl);
 int
 rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 {
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 9f85191016..498e108a9e 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -213,7 +213,7 @@ eal_mem_virt2iova_cleanup(void)
 		CloseHandle(virt2phys_device);
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy);
 phys_addr_t
 rte_mem_virt2phy(const void *virt)
 {
@@ -234,7 +234,7 @@ rte_mem_virt2phy(const void *virt)
 	return phys.QuadPart;
 }
 
-RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova);
 rte_iova_t
 rte_mem_virt2iova(const void *virt)
 {
@@ -250,7 +250,7 @@ rte_mem_virt2iova(const void *virt)
 }
 
 /* Always using physical addresses under Windows if they can be obtained. */
-RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs);
 int
 rte_eal_using_phys_addrs(void)
 {
diff --git a/lib/eal/windows/eal_mp.c b/lib/eal/windows/eal_mp.c
index 6703355318..48653ef02a 100644
--- a/lib/eal/windows/eal_mp.c
+++ b/lib/eal/windows/eal_mp.c
@@ -25,7 +25,7 @@ rte_mp_channel_cleanup(void)
 	EAL_LOG_NOT_IMPLEMENTED();
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_action_register)
+RTE_EXPORT_SYMBOL(rte_mp_action_register);
 int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
@@ -35,7 +35,7 @@ rte_mp_action_register(const char *name, rte_mp_t action)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_action_unregister)
+RTE_EXPORT_SYMBOL(rte_mp_action_unregister);
 void
 rte_mp_action_unregister(const char *name)
 {
@@ -43,7 +43,7 @@ rte_mp_action_unregister(const char *name)
 	EAL_LOG_NOT_IMPLEMENTED();
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
+RTE_EXPORT_SYMBOL(rte_mp_sendmsg);
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
@@ -52,7 +52,7 @@ rte_mp_sendmsg(struct rte_mp_msg *msg)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_request_sync)
+RTE_EXPORT_SYMBOL(rte_mp_request_sync);
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	const struct timespec *ts)
@@ -64,7 +64,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_request_async)
+RTE_EXPORT_SYMBOL(rte_mp_request_async);
 int
 rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		rte_mp_async_reply_t clb)
@@ -76,7 +76,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_mp_reply)
+RTE_EXPORT_SYMBOL(rte_mp_reply);
 int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
diff --git a/lib/eal/windows/eal_thread.c b/lib/eal/windows/eal_thread.c
index 3eeb94a589..811ae007ba 100644
--- a/lib/eal/windows/eal_thread.c
+++ b/lib/eal/windows/eal_thread.c
@@ -72,7 +72,7 @@ eal_thread_ack_command(void)
 }
 
 /* get current thread ID */
-RTE_EXPORT_SYMBOL(rte_sys_gettid)
+RTE_EXPORT_SYMBOL(rte_sys_gettid);
 int
 rte_sys_gettid(void)
 {
diff --git a/lib/eal/windows/eal_timer.c b/lib/eal/windows/eal_timer.c
index 33cbac6a03..ccaa743b5b 100644
--- a/lib/eal/windows/eal_timer.c
+++ b/lib/eal/windows/eal_timer.c
@@ -15,7 +15,7 @@
 #define US_PER_SEC 1E6
 #define CYC_PER_100KHZ 1E5
 
-RTE_EXPORT_SYMBOL(rte_delay_us_sleep)
+RTE_EXPORT_SYMBOL(rte_delay_us_sleep);
 void
 rte_delay_us_sleep(unsigned int us)
 {
diff --git a/lib/eal/windows/rte_thread.c b/lib/eal/windows/rte_thread.c
index 85e5a57346..e1bae54ec8 100644
--- a/lib/eal/windows/rte_thread.c
+++ b/lib/eal/windows/rte_thread.c
@@ -182,7 +182,7 @@ thread_func_wrapper(void *arg)
 	return (DWORD)ctx.thread_func(ctx.routine_args);
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_create)
+RTE_EXPORT_SYMBOL(rte_thread_create);
 int
 rte_thread_create(rte_thread_t *thread_id,
 		  const rte_thread_attr_t *thread_attr,
@@ -260,7 +260,7 @@ rte_thread_create(rte_thread_t *thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_join)
+RTE_EXPORT_SYMBOL(rte_thread_join);
 int
 rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 {
@@ -301,7 +301,7 @@ rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_detach)
+RTE_EXPORT_SYMBOL(rte_thread_detach);
 int
 rte_thread_detach(rte_thread_t thread_id)
 {
@@ -311,14 +311,14 @@ rte_thread_detach(rte_thread_t thread_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_equal)
+RTE_EXPORT_SYMBOL(rte_thread_equal);
 int
 rte_thread_equal(rte_thread_t t1, rte_thread_t t2)
 {
 	return t1.opaque_id == t2.opaque_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_self)
+RTE_EXPORT_SYMBOL(rte_thread_self);
 rte_thread_t
 rte_thread_self(void)
 {
@@ -329,7 +329,7 @@ rte_thread_self(void)
 	return thread_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_name)
+RTE_EXPORT_SYMBOL(rte_thread_set_name);
 void
 rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
@@ -371,7 +371,7 @@ rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 		EAL_LOG(DEBUG, "Failed to set thread name");
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_get_priority)
+RTE_EXPORT_SYMBOL(rte_thread_get_priority);
 int
 rte_thread_get_priority(rte_thread_t thread_id,
 	enum rte_thread_priority *priority)
@@ -411,7 +411,7 @@ rte_thread_get_priority(rte_thread_t thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_priority)
+RTE_EXPORT_SYMBOL(rte_thread_set_priority);
 int
 rte_thread_set_priority(rte_thread_t thread_id,
 			enum rte_thread_priority priority)
@@ -450,7 +450,7 @@ rte_thread_set_priority(rte_thread_t thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_key_create)
+RTE_EXPORT_SYMBOL(rte_thread_key_create);
 int
 rte_thread_key_create(rte_thread_key *key,
 		__rte_unused void (*destructor)(void *))
@@ -471,7 +471,7 @@ rte_thread_key_create(rte_thread_key *key,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_key_delete)
+RTE_EXPORT_SYMBOL(rte_thread_key_delete);
 int
 rte_thread_key_delete(rte_thread_key key)
 {
@@ -490,7 +490,7 @@ rte_thread_key_delete(rte_thread_key key)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_value_set)
+RTE_EXPORT_SYMBOL(rte_thread_value_set);
 int
 rte_thread_value_set(rte_thread_key key, const void *value)
 {
@@ -511,7 +511,7 @@ rte_thread_value_set(rte_thread_key key, const void *value)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_value_get)
+RTE_EXPORT_SYMBOL(rte_thread_value_get);
 void *
 rte_thread_value_get(rte_thread_key key)
 {
@@ -531,7 +531,7 @@ rte_thread_value_get(rte_thread_key key)
 	return output;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id)
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id);
 int
 rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		const rte_cpuset_t *cpuset)
@@ -572,7 +572,7 @@ rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id)
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id);
 int
 rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/x86/rte_cpuflags.c b/lib/eal/x86/rte_cpuflags.c
index 5d1f352e04..90495b19a4 100644
--- a/lib/eal/x86/rte_cpuflags.c
+++ b/lib/eal/x86/rte_cpuflags.c
@@ -149,7 +149,7 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(INVTSC, 0x80000007, 0, RTE_REG_EDX,  8)
 };
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled);
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -192,7 +192,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return feat->value;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name);
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -201,7 +201,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
-RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support);
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/x86/rte_hypervisor.c b/lib/eal/x86/rte_hypervisor.c
index 0c649c1d41..6756cd10c0 100644
--- a/lib/eal/x86/rte_hypervisor.c
+++ b/lib/eal/x86/rte_hypervisor.c
@@ -14,7 +14,7 @@
 /* See http://lwn.net/Articles/301888/ */
 #define HYPERVISOR_INFO_LEAF 0x40000000
 
-RTE_EXPORT_SYMBOL(rte_hypervisor_get)
+RTE_EXPORT_SYMBOL(rte_hypervisor_get);
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index 1cb2e908c0..70fe5deb5b 100644
--- a/lib/eal/x86/rte_power_intrinsics.c
+++ b/lib/eal/x86/rte_power_intrinsics.c
@@ -159,7 +159,7 @@ __check_val_size(const uint8_t sz)
  * For more information about usage of these instructions, please refer to
  * Intel(R) 64 and IA-32 Architectures Software Developer's Manual.
  */
-RTE_EXPORT_SYMBOL(rte_power_monitor)
+RTE_EXPORT_SYMBOL(rte_power_monitor);
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -221,7 +221,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
  * information about usage of this instruction, please refer to Intel(R) 64 and
  * IA-32 Architectures Software Developer's Manual.
  */
-RTE_EXPORT_SYMBOL(rte_power_pause)
+RTE_EXPORT_SYMBOL(rte_power_pause);
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -266,7 +266,7 @@ RTE_INIT(rte_power_intrinsics_init) {
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup);
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -316,7 +316,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi);
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/x86/rte_spinlock.c b/lib/eal/x86/rte_spinlock.c
index da783919e5..8f000366aa 100644
--- a/lib/eal/x86/rte_spinlock.c
+++ b/lib/eal/x86/rte_spinlock.c
@@ -7,7 +7,7 @@
 #include <eal_export.h>
 #include "rte_cpuflags.h"
 
-RTE_EXPORT_SYMBOL(rte_rtm_supported)
+RTE_EXPORT_SYMBOL(rte_rtm_supported);
 uint8_t rte_rtm_supported; /* cache the flag to avoid the overhead
 			      of the rte_cpu_get_flag_enabled function */
 
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index b0e44e5c51..066e35ae4b 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -497,7 +497,7 @@ efd_search_hash(struct rte_efd_table * const table,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_create)
+RTE_EXPORT_SYMBOL(rte_efd_create);
 struct rte_efd_table *
 rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 		uint64_t online_cpu_socket_bitmask, uint8_t offline_cpu_socket)
@@ -722,7 +722,7 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_find_existing)
+RTE_EXPORT_SYMBOL(rte_efd_find_existing);
 struct rte_efd_table *
 rte_efd_find_existing(const char *name)
 {
@@ -749,7 +749,7 @@ rte_efd_find_existing(const char *name)
 	return table;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_free)
+RTE_EXPORT_SYMBOL(rte_efd_free);
 void
 rte_efd_free(struct rte_efd_table *table)
 {
@@ -1166,7 +1166,7 @@ efd_compute_update(struct rte_efd_table * const table,
 	return RTE_EFD_UPDATE_FAILED;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_update)
+RTE_EXPORT_SYMBOL(rte_efd_update);
 int
 rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
 		const void *key, const efd_value_t value)
@@ -1190,7 +1190,7 @@ rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
 	return status;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_delete)
+RTE_EXPORT_SYMBOL(rte_efd_delete);
 int
 rte_efd_delete(struct rte_efd_table * const table, const unsigned int socket_id,
 		const void *key, efd_value_t * const prev_value)
@@ -1307,7 +1307,7 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
 	return value;
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_lookup)
+RTE_EXPORT_SYMBOL(rte_efd_lookup);
 efd_value_t
 rte_efd_lookup(const struct rte_efd_table * const table,
 		const unsigned int socket_id, const void *key)
@@ -1329,7 +1329,7 @@ rte_efd_lookup(const struct rte_efd_table * const table,
 			table->lookup_fn);
 }
 
-RTE_EXPORT_SYMBOL(rte_efd_lookup_bulk)
+RTE_EXPORT_SYMBOL(rte_efd_lookup_bulk);
 void rte_efd_lookup_bulk(const struct rte_efd_table * const table,
 		const unsigned int socket_id, const int num_keys,
 		const void **key_list, efd_value_t * const value_list)
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 285d377d91..222b17d8ce 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -286,7 +286,7 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
 	fpo->txq.clbk = (void * __rte_atomic *)(uintptr_t)dev->pre_tx_burst_cbs;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_call_rx_callbacks)
+RTE_EXPORT_SYMBOL(rte_eth_call_rx_callbacks);
 uint16_t
 rte_eth_call_rx_callbacks(uint16_t port_id, uint16_t queue_id,
 	struct rte_mbuf **rx_pkts, uint16_t nb_rx, uint16_t nb_pkts,
@@ -310,7 +310,7 @@ rte_eth_call_rx_callbacks(uint16_t port_id, uint16_t queue_id,
 	return nb_rx;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_call_tx_callbacks)
+RTE_EXPORT_SYMBOL(rte_eth_call_tx_callbacks);
 uint16_t
 rte_eth_call_tx_callbacks(uint16_t port_id, uint16_t queue_id,
 	struct rte_mbuf **tx_pkts, uint16_t nb_pkts, void *opaque)
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..3a884bdd22 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -43,7 +43,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devices)
 struct rte_eth_dev rte_eth_devices[RTE_MAX_ETHPORTS];
 
 /* public fast-path API */
-RTE_EXPORT_SYMBOL(rte_eth_fp_ops)
+RTE_EXPORT_SYMBOL(rte_eth_fp_ops);
 struct rte_eth_fp_ops rte_eth_fp_ops[RTE_MAX_ETHPORTS];
 
 /* spinlock for add/remove Rx callbacks */
@@ -176,7 +176,7 @@ static const struct {
 	{RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ_SORT, "symmetric_toeplitz_sort"},
 };
 
-RTE_EXPORT_SYMBOL(rte_eth_iterator_init)
+RTE_EXPORT_SYMBOL(rte_eth_iterator_init);
 int
 rte_eth_iterator_init(struct rte_dev_iterator *iter, const char *devargs_str)
 {
@@ -293,7 +293,7 @@ rte_eth_iterator_init(struct rte_dev_iterator *iter, const char *devargs_str)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_iterator_next)
+RTE_EXPORT_SYMBOL(rte_eth_iterator_next);
 uint16_t
 rte_eth_iterator_next(struct rte_dev_iterator *iter)
 {
@@ -334,7 +334,7 @@ rte_eth_iterator_next(struct rte_dev_iterator *iter)
 	return RTE_MAX_ETHPORTS;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_iterator_cleanup)
+RTE_EXPORT_SYMBOL(rte_eth_iterator_cleanup);
 void
 rte_eth_iterator_cleanup(struct rte_dev_iterator *iter)
 {
@@ -353,7 +353,7 @@ rte_eth_iterator_cleanup(struct rte_dev_iterator *iter)
 	memset(iter, 0, sizeof(*iter));
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_find_next)
+RTE_EXPORT_SYMBOL(rte_eth_find_next);
 uint16_t
 rte_eth_find_next(uint16_t port_id)
 {
@@ -378,7 +378,7 @@ rte_eth_find_next(uint16_t port_id)
 	     port_id < RTE_MAX_ETHPORTS; \
 	     port_id = rte_eth_find_next(port_id + 1))
 
-RTE_EXPORT_SYMBOL(rte_eth_find_next_of)
+RTE_EXPORT_SYMBOL(rte_eth_find_next_of);
 uint16_t
 rte_eth_find_next_of(uint16_t port_id, const struct rte_device *parent)
 {
@@ -392,7 +392,7 @@ rte_eth_find_next_of(uint16_t port_id, const struct rte_device *parent)
 	return port_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_find_next_sibling)
+RTE_EXPORT_SYMBOL(rte_eth_find_next_sibling);
 uint16_t
 rte_eth_find_next_sibling(uint16_t port_id, uint16_t ref_port_id)
 {
@@ -413,7 +413,7 @@ eth_dev_is_allocated(const struct rte_eth_dev *ethdev)
 	return ethdev->data != NULL && ethdev->data->name[0] != '\0';
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_is_valid_port)
+RTE_EXPORT_SYMBOL(rte_eth_dev_is_valid_port);
 int
 rte_eth_dev_is_valid_port(uint16_t port_id)
 {
@@ -440,7 +440,7 @@ eth_is_valid_owner_id(uint64_t owner_id)
 	return 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_find_next_owned_by)
+RTE_EXPORT_SYMBOL(rte_eth_find_next_owned_by);
 uint64_t
 rte_eth_find_next_owned_by(uint16_t port_id, const uint64_t owner_id)
 {
@@ -454,7 +454,7 @@ rte_eth_find_next_owned_by(uint16_t port_id, const uint64_t owner_id)
 	return port_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_owner_new)
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_new);
 int
 rte_eth_dev_owner_new(uint64_t *owner_id)
 {
@@ -530,7 +530,7 @@ eth_dev_owner_set(const uint16_t port_id, const uint64_t old_owner_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_owner_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_set);
 int
 rte_eth_dev_owner_set(const uint16_t port_id,
 		      const struct rte_eth_dev_owner *owner)
@@ -551,7 +551,7 @@ rte_eth_dev_owner_set(const uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_owner_unset)
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_unset);
 int
 rte_eth_dev_owner_unset(const uint16_t port_id, const uint64_t owner_id)
 {
@@ -573,7 +573,7 @@ rte_eth_dev_owner_unset(const uint16_t port_id, const uint64_t owner_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_owner_delete)
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_delete);
 int
 rte_eth_dev_owner_delete(const uint64_t owner_id)
 {
@@ -611,7 +611,7 @@ rte_eth_dev_owner_delete(const uint64_t owner_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_owner_get)
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_get);
 int
 rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 {
@@ -650,7 +650,7 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_socket_id)
+RTE_EXPORT_SYMBOL(rte_eth_dev_socket_id);
 int
 rte_eth_dev_socket_id(uint16_t port_id)
 {
@@ -676,7 +676,7 @@ rte_eth_dev_socket_id(uint16_t port_id)
 	return socket_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_sec_ctx)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_sec_ctx);
 void *
 rte_eth_dev_get_sec_ctx(uint16_t port_id)
 {
@@ -690,7 +690,7 @@ rte_eth_dev_get_sec_ctx(uint16_t port_id)
 	return ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_count_avail)
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_avail);
 uint16_t
 rte_eth_dev_count_avail(void)
 {
@@ -707,7 +707,7 @@ rte_eth_dev_count_avail(void)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_count_total)
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_total);
 uint16_t
 rte_eth_dev_count_total(void)
 {
@@ -721,7 +721,7 @@ rte_eth_dev_count_total(void)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port);
 int
 rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
 {
@@ -748,7 +748,7 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_port_by_name)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_port_by_name);
 int
 rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id)
 {
@@ -863,7 +863,7 @@ rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 	return eth_dev_validate_tx_queue(dev, queue_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_start)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_start);
 int
 rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
 {
@@ -908,7 +908,7 @@ rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_stop)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_stop);
 int
 rte_eth_dev_rx_queue_stop(uint16_t port_id, uint16_t rx_queue_id)
 {
@@ -946,7 +946,7 @@ rte_eth_dev_rx_queue_stop(uint16_t port_id, uint16_t rx_queue_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_start)
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_start);
 int
 rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
 {
@@ -991,7 +991,7 @@ rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_stop)
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_stop);
 int
 rte_eth_dev_tx_queue_stop(uint16_t port_id, uint16_t tx_queue_id)
 {
@@ -1029,7 +1029,7 @@ rte_eth_dev_tx_queue_stop(uint16_t port_id, uint16_t tx_queue_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_speed_bitflag)
+RTE_EXPORT_SYMBOL(rte_eth_speed_bitflag);
 uint32_t
 rte_eth_speed_bitflag(uint32_t speed, int duplex)
 {
@@ -1087,7 +1087,7 @@ rte_eth_speed_bitflag(uint32_t speed, int duplex)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_offload_name)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_offload_name);
 const char *
 rte_eth_dev_rx_offload_name(uint64_t offload)
 {
@@ -1106,7 +1106,7 @@ rte_eth_dev_rx_offload_name(uint64_t offload)
 	return name;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_tx_offload_name)
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_offload_name);
 const char *
 rte_eth_dev_tx_offload_name(uint64_t offload)
 {
@@ -1318,7 +1318,7 @@ eth_dev_validate_mtu(uint16_t port_id, struct rte_eth_dev_info *dev_info,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_configure)
+RTE_EXPORT_SYMBOL(rte_eth_dev_configure);
 int
 rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		      const struct rte_eth_conf *dev_conf)
@@ -1782,7 +1782,7 @@ eth_dev_config_restore(struct rte_eth_dev *dev,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_start)
+RTE_EXPORT_SYMBOL(rte_eth_dev_start);
 int
 rte_eth_dev_start(uint16_t port_id)
 {
@@ -1857,7 +1857,7 @@ rte_eth_dev_start(uint16_t port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_stop)
+RTE_EXPORT_SYMBOL(rte_eth_dev_stop);
 int
 rte_eth_dev_stop(uint16_t port_id)
 {
@@ -1888,7 +1888,7 @@ rte_eth_dev_stop(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_up)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_up);
 int
 rte_eth_dev_set_link_up(uint16_t port_id)
 {
@@ -1907,7 +1907,7 @@ rte_eth_dev_set_link_up(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_down)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_down);
 int
 rte_eth_dev_set_link_down(uint16_t port_id)
 {
@@ -1981,7 +1981,7 @@ rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 	return eth_err(port_id, dev->dev_ops->speed_lanes_set(dev, speed_lanes_capa));
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_close)
+RTE_EXPORT_SYMBOL(rte_eth_dev_close);
 int
 rte_eth_dev_close(uint16_t port_id)
 {
@@ -2016,7 +2016,7 @@ rte_eth_dev_close(uint16_t port_id)
 	return firsterr;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_reset)
+RTE_EXPORT_SYMBOL(rte_eth_dev_reset);
 int
 rte_eth_dev_reset(uint16_t port_id)
 {
@@ -2042,7 +2042,7 @@ rte_eth_dev_reset(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_is_removed)
+RTE_EXPORT_SYMBOL(rte_eth_dev_is_removed);
 int
 rte_eth_dev_is_removed(uint16_t port_id)
 {
@@ -2270,7 +2270,7 @@ rte_eth_rx_queue_check_mempools(struct rte_mempool **rx_mempools,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_rx_queue_setup)
+RTE_EXPORT_SYMBOL(rte_eth_rx_queue_setup);
 int
 rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		       uint16_t nb_rx_desc, unsigned int socket_id,
@@ -2602,7 +2602,7 @@ rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_queue_setup)
+RTE_EXPORT_SYMBOL(rte_eth_tx_queue_setup);
 int
 rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       uint16_t nb_tx_desc, unsigned int socket_id,
@@ -2909,7 +2909,7 @@ rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_drop_callback)
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_drop_callback);
 void
 rte_eth_tx_buffer_drop_callback(struct rte_mbuf **pkts, uint16_t unsent,
 		void *userdata __rte_unused)
@@ -2919,7 +2919,7 @@ rte_eth_tx_buffer_drop_callback(struct rte_mbuf **pkts, uint16_t unsent,
 	rte_eth_trace_tx_buffer_drop_callback((void **)pkts, unsent);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_count_callback)
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_count_callback);
 void
 rte_eth_tx_buffer_count_callback(struct rte_mbuf **pkts, uint16_t unsent,
 		void *userdata)
@@ -2932,7 +2932,7 @@ rte_eth_tx_buffer_count_callback(struct rte_mbuf **pkts, uint16_t unsent,
 	rte_eth_trace_tx_buffer_count_callback((void **)pkts, unsent, *count);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_set_err_callback)
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_set_err_callback);
 int
 rte_eth_tx_buffer_set_err_callback(struct rte_eth_dev_tx_buffer *buffer,
 		buffer_tx_error_fn cbfn, void *userdata)
@@ -2951,7 +2951,7 @@ rte_eth_tx_buffer_set_err_callback(struct rte_eth_dev_tx_buffer *buffer,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_init)
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_init);
 int
 rte_eth_tx_buffer_init(struct rte_eth_dev_tx_buffer *buffer, uint16_t size)
 {
@@ -2973,7 +2973,7 @@ rte_eth_tx_buffer_init(struct rte_eth_dev_tx_buffer *buffer, uint16_t size)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_done_cleanup)
+RTE_EXPORT_SYMBOL(rte_eth_tx_done_cleanup);
 int
 rte_eth_tx_done_cleanup(uint16_t port_id, uint16_t queue_id, uint32_t free_cnt)
 {
@@ -3001,7 +3001,7 @@ rte_eth_tx_done_cleanup(uint16_t port_id, uint16_t queue_id, uint32_t free_cnt)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_promiscuous_enable)
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_enable);
 int
 rte_eth_promiscuous_enable(uint16_t port_id)
 {
@@ -3028,7 +3028,7 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_promiscuous_disable)
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_disable);
 int
 rte_eth_promiscuous_disable(uint16_t port_id)
 {
@@ -3056,7 +3056,7 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_promiscuous_get)
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_get);
 int
 rte_eth_promiscuous_get(uint16_t port_id)
 {
@@ -3070,7 +3070,7 @@ rte_eth_promiscuous_get(uint16_t port_id)
 	return dev->data->promiscuous;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_allmulticast_enable)
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_enable);
 int
 rte_eth_allmulticast_enable(uint16_t port_id)
 {
@@ -3096,7 +3096,7 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_allmulticast_disable)
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_disable);
 int
 rte_eth_allmulticast_disable(uint16_t port_id)
 {
@@ -3124,7 +3124,7 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_allmulticast_get)
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_get);
 int
 rte_eth_allmulticast_get(uint16_t port_id)
 {
@@ -3138,7 +3138,7 @@ rte_eth_allmulticast_get(uint16_t port_id)
 	return dev->data->all_multicast;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_link_get)
+RTE_EXPORT_SYMBOL(rte_eth_link_get);
 int
 rte_eth_link_get(uint16_t port_id, struct rte_eth_link *eth_link)
 {
@@ -3167,7 +3167,7 @@ rte_eth_link_get(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_link_get_nowait)
+RTE_EXPORT_SYMBOL(rte_eth_link_get_nowait);
 int
 rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 {
@@ -3297,7 +3297,7 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_stats_get)
+RTE_EXPORT_SYMBOL(rte_eth_stats_get);
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 {
@@ -3325,7 +3325,7 @@ rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_stats_reset)
+RTE_EXPORT_SYMBOL(rte_eth_stats_reset);
 int
 rte_eth_stats_reset(uint16_t port_id)
 {
@@ -3387,7 +3387,7 @@ eth_dev_get_xstats_count(uint16_t port_id)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_xstats_get_id_by_name)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_id_by_name);
 int
 rte_eth_xstats_get_id_by_name(uint16_t port_id, const char *xstat_name,
 		uint64_t *id)
@@ -3523,7 +3523,7 @@ eth_xstats_get_by_name_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 
 
 /* retrieve ethdev extended statistics names */
-RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names_by_id)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names_by_id);
 int
 rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	struct rte_eth_xstat_name *xstats_names, unsigned int size,
@@ -3616,7 +3616,7 @@ rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	return size;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names);
 int
 rte_eth_xstats_get_names(uint16_t port_id,
 	struct rte_eth_xstat_name *xstats_names,
@@ -3743,7 +3743,7 @@ eth_xtats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 }
 
 /* retrieve ethdev extended statistics */
-RTE_EXPORT_SYMBOL(rte_eth_xstats_get_by_id)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_by_id);
 int
 rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 			 uint64_t *values, unsigned int size)
@@ -3830,7 +3830,7 @@ rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 	return (i == size) ? (int32_t)size : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_xstats_get)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get);
 int
 rte_eth_xstats_get(uint16_t port_id, struct rte_eth_xstat *xstats,
 	unsigned int n)
@@ -3882,7 +3882,7 @@ rte_eth_xstats_get(uint16_t port_id, struct rte_eth_xstat *xstats,
 }
 
 /* reset ethdev extended statistics */
-RTE_EXPORT_SYMBOL(rte_eth_xstats_reset)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_reset);
 int
 rte_eth_xstats_reset(uint16_t port_id)
 {
@@ -3978,7 +3978,7 @@ eth_dev_set_queue_stats_mapping(uint16_t port_id, uint16_t queue_id,
 	return dev->dev_ops->queue_stats_mapping_set(dev, queue_id, stat_idx, is_rx);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_tx_queue_stats_mapping)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_tx_queue_stats_mapping);
 int
 rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id, uint16_t tx_queue_id,
 		uint8_t stat_idx)
@@ -3995,7 +3995,7 @@ rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_rx_queue_stats_mapping)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_rx_queue_stats_mapping);
 int
 rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id, uint16_t rx_queue_id,
 		uint8_t stat_idx)
@@ -4012,7 +4012,7 @@ rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id, uint16_t rx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_fw_version_get)
+RTE_EXPORT_SYMBOL(rte_eth_dev_fw_version_get);
 int
 rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
 {
@@ -4038,7 +4038,7 @@ rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_info_get)
+RTE_EXPORT_SYMBOL(rte_eth_dev_info_get);
 int
 rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 {
@@ -4126,7 +4126,7 @@ rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_supported_ptypes)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_supported_ptypes);
 int
 rte_eth_dev_get_supported_ptypes(uint16_t port_id, uint32_t ptype_mask,
 				 uint32_t *ptypes, int num)
@@ -4168,7 +4168,7 @@ rte_eth_dev_get_supported_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return j;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_ptypes)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_ptypes);
 int
 rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 				 uint32_t *set_ptypes, unsigned int num)
@@ -4292,7 +4292,7 @@ rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	return num;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_macaddr_get)
+RTE_EXPORT_SYMBOL(rte_eth_macaddr_get);
 int
 rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 {
@@ -4315,7 +4315,7 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_mtu)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_mtu);
 int
 rte_eth_dev_get_mtu(uint16_t port_id, uint16_t *mtu)
 {
@@ -4337,7 +4337,7 @@ rte_eth_dev_get_mtu(uint16_t port_id, uint16_t *mtu)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_mtu)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_mtu);
 int
 rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 {
@@ -4384,7 +4384,7 @@ rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_vlan_filter)
+RTE_EXPORT_SYMBOL(rte_eth_dev_vlan_filter);
 int
 rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 {
@@ -4432,7 +4432,7 @@ rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_strip_on_queue)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_strip_on_queue);
 int
 rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
 				    int on)
@@ -4456,7 +4456,7 @@ rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_ether_type)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_ether_type);
 int
 rte_eth_dev_set_vlan_ether_type(uint16_t port_id,
 				enum rte_vlan_type vlan_type,
@@ -4477,7 +4477,7 @@ rte_eth_dev_set_vlan_ether_type(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_offload)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_offload);
 int
 rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 {
@@ -4574,7 +4574,7 @@ rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_vlan_offload)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_vlan_offload);
 int
 rte_eth_dev_get_vlan_offload(uint16_t port_id)
 {
@@ -4603,7 +4603,7 @@ rte_eth_dev_get_vlan_offload(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_pvid)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_pvid);
 int
 rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on)
 {
@@ -4622,7 +4622,7 @@ rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_get)
+RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_get);
 int
 rte_eth_dev_flow_ctrl_get(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 {
@@ -4649,7 +4649,7 @@ rte_eth_dev_flow_ctrl_get(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_set);
 int
 rte_eth_dev_flow_ctrl_set(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 {
@@ -4680,7 +4680,7 @@ rte_eth_dev_flow_ctrl_set(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_set);
 int
 rte_eth_dev_priority_flow_ctrl_set(uint16_t port_id,
 				   struct rte_eth_pfc_conf *pfc_conf)
@@ -4910,7 +4910,7 @@ eth_check_reta_entry(struct rte_eth_rss_reta_entry64 *reta_conf,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_update)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_update);
 int
 rte_eth_dev_rss_reta_update(uint16_t port_id,
 			    struct rte_eth_rss_reta_entry64 *reta_conf,
@@ -4963,7 +4963,7 @@ rte_eth_dev_rss_reta_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_query)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_query);
 int
 rte_eth_dev_rss_reta_query(uint16_t port_id,
 			   struct rte_eth_rss_reta_entry64 *reta_conf,
@@ -4996,7 +4996,7 @@ rte_eth_dev_rss_reta_query(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_update)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_update);
 int
 rte_eth_dev_rss_hash_update(uint16_t port_id,
 			    struct rte_eth_rss_conf *rss_conf)
@@ -5063,7 +5063,7 @@ rte_eth_dev_rss_hash_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_conf_get)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_conf_get);
 int
 rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 			      struct rte_eth_rss_conf *rss_conf)
@@ -5136,7 +5136,7 @@ rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_add)
+RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_add);
 int
 rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
 				struct rte_eth_udp_tunnel *udp_tunnel)
@@ -5168,7 +5168,7 @@ rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_delete)
+RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_delete);
 int
 rte_eth_dev_udp_tunnel_port_delete(uint16_t port_id,
 				   struct rte_eth_udp_tunnel *udp_tunnel)
@@ -5200,7 +5200,7 @@ rte_eth_dev_udp_tunnel_port_delete(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_led_on)
+RTE_EXPORT_SYMBOL(rte_eth_led_on);
 int
 rte_eth_led_on(uint16_t port_id)
 {
@@ -5219,7 +5219,7 @@ rte_eth_led_on(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_led_off)
+RTE_EXPORT_SYMBOL(rte_eth_led_off);
 int
 rte_eth_led_off(uint16_t port_id)
 {
@@ -5342,7 +5342,7 @@ eth_dev_get_mac_addr_index(uint16_t port_id, const struct rte_ether_addr *addr)
 
 static const struct rte_ether_addr null_mac_addr;
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_add)
+RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_add);
 int
 rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 			uint32_t pool)
@@ -5409,7 +5409,7 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_remove)
+RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_remove);
 int
 rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 {
@@ -5452,7 +5452,7 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_default_mac_addr_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_default_mac_addr_set);
 int
 rte_eth_dev_default_mac_addr_set(uint16_t port_id, struct rte_ether_addr *addr)
 {
@@ -5526,7 +5526,7 @@ eth_dev_get_hash_mac_addr_index(uint16_t port_id,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_uc_hash_table_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_uc_hash_table_set);
 int
 rte_eth_dev_uc_hash_table_set(uint16_t port_id, struct rte_ether_addr *addr,
 				uint8_t on)
@@ -5592,7 +5592,7 @@ rte_eth_dev_uc_hash_table_set(uint16_t port_id, struct rte_ether_addr *addr,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_uc_all_hash_table_set)
+RTE_EXPORT_SYMBOL(rte_eth_dev_uc_all_hash_table_set);
 int
 rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on)
 {
@@ -5611,7 +5611,7 @@ rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_set_queue_rate_limit)
+RTE_EXPORT_SYMBOL(rte_eth_set_queue_rate_limit);
 int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 					uint32_t tx_rate)
 {
@@ -5726,7 +5726,7 @@ RTE_INIT(eth_dev_init_cb_lists)
 		TAILQ_INIT(&rte_eth_devices[i].link_intr_cbs);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_callback_register)
+RTE_EXPORT_SYMBOL(rte_eth_dev_callback_register);
 int
 rte_eth_dev_callback_register(uint16_t port_id,
 			enum rte_eth_event_type event,
@@ -5796,7 +5796,7 @@ rte_eth_dev_callback_register(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_callback_unregister)
+RTE_EXPORT_SYMBOL(rte_eth_dev_callback_unregister);
 int
 rte_eth_dev_callback_unregister(uint16_t port_id,
 			enum rte_eth_event_type event,
@@ -5862,7 +5862,7 @@ rte_eth_dev_callback_unregister(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl);
 int
 rte_eth_dev_rx_intr_ctl(uint16_t port_id, int epfd, int op, void *data)
 {
@@ -5902,7 +5902,7 @@ rte_eth_dev_rx_intr_ctl(uint16_t port_id, int epfd, int op, void *data)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q_get_fd)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q_get_fd);
 int
 rte_eth_dev_rx_intr_ctl_q_get_fd(uint16_t port_id, uint16_t queue_id)
 {
@@ -5941,7 +5941,7 @@ rte_eth_dev_rx_intr_ctl_q_get_fd(uint16_t port_id, uint16_t queue_id)
 	return fd;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q);
 int
 rte_eth_dev_rx_intr_ctl_q(uint16_t port_id, uint16_t queue_id,
 			  int epfd, int op, void *data)
@@ -5985,7 +5985,7 @@ rte_eth_dev_rx_intr_ctl_q(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_enable)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_enable);
 int
 rte_eth_dev_rx_intr_enable(uint16_t port_id,
 			   uint16_t queue_id)
@@ -6009,7 +6009,7 @@ rte_eth_dev_rx_intr_enable(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_disable)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_disable);
 int
 rte_eth_dev_rx_intr_disable(uint16_t port_id,
 			    uint16_t queue_id)
@@ -6034,7 +6034,7 @@ rte_eth_dev_rx_intr_disable(uint16_t port_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_eth_add_rx_callback)
+RTE_EXPORT_SYMBOL(rte_eth_add_rx_callback);
 const struct rte_eth_rxtx_callback *
 rte_eth_add_rx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_rx_callback_fn fn, void *user_param)
@@ -6094,7 +6094,7 @@ rte_eth_add_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_add_first_rx_callback)
+RTE_EXPORT_SYMBOL(rte_eth_add_first_rx_callback);
 const struct rte_eth_rxtx_callback *
 rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_rx_callback_fn fn, void *user_param)
@@ -6137,7 +6137,7 @@ rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_add_tx_callback)
+RTE_EXPORT_SYMBOL(rte_eth_add_tx_callback);
 const struct rte_eth_rxtx_callback *
 rte_eth_add_tx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_tx_callback_fn fn, void *user_param)
@@ -6199,7 +6199,7 @@ rte_eth_add_tx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_remove_rx_callback)
+RTE_EXPORT_SYMBOL(rte_eth_remove_rx_callback);
 int
 rte_eth_remove_rx_callback(uint16_t port_id, uint16_t queue_id,
 		const struct rte_eth_rxtx_callback *user_cb)
@@ -6236,7 +6236,7 @@ rte_eth_remove_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_remove_tx_callback)
+RTE_EXPORT_SYMBOL(rte_eth_remove_tx_callback);
 int
 rte_eth_remove_tx_callback(uint16_t port_id, uint16_t queue_id,
 		const struct rte_eth_rxtx_callback *user_cb)
@@ -6273,7 +6273,7 @@ rte_eth_remove_tx_callback(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_rx_queue_info_get)
+RTE_EXPORT_SYMBOL(rte_eth_rx_queue_info_get);
 int
 rte_eth_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
@@ -6322,7 +6322,7 @@ rte_eth_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_queue_info_get)
+RTE_EXPORT_SYMBOL(rte_eth_tx_queue_info_get);
 int
 rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_txq_info *qinfo)
@@ -6394,7 +6394,7 @@ rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_rx_burst_mode_get)
+RTE_EXPORT_SYMBOL(rte_eth_rx_burst_mode_get);
 int
 rte_eth_rx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 			  struct rte_eth_burst_mode *mode)
@@ -6428,7 +6428,7 @@ rte_eth_rx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_tx_burst_mode_get)
+RTE_EXPORT_SYMBOL(rte_eth_tx_burst_mode_get);
 int
 rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 			  struct rte_eth_burst_mode *mode)
@@ -6495,7 +6495,7 @@ rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_mc_addr_list)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_mc_addr_list);
 int
 rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 			     struct rte_ether_addr *mc_addr_set,
@@ -6518,7 +6518,7 @@ rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_enable)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_enable);
 int
 rte_eth_timesync_enable(uint16_t port_id)
 {
@@ -6537,7 +6537,7 @@ rte_eth_timesync_enable(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_disable)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_disable);
 int
 rte_eth_timesync_disable(uint16_t port_id)
 {
@@ -6556,7 +6556,7 @@ rte_eth_timesync_disable(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_read_rx_timestamp)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_rx_timestamp);
 int
 rte_eth_timesync_read_rx_timestamp(uint16_t port_id, struct timespec *timestamp,
 				   uint32_t flags)
@@ -6585,7 +6585,7 @@ rte_eth_timesync_read_rx_timestamp(uint16_t port_id, struct timespec *timestamp,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_read_tx_timestamp)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_tx_timestamp);
 int
 rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 				   struct timespec *timestamp)
@@ -6614,7 +6614,7 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time);
 int
 rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 {
@@ -6652,7 +6652,7 @@ rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_read_time)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_time);
 int
 rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 {
@@ -6678,7 +6678,7 @@ rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_timesync_write_time)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_write_time);
 int
 rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 {
@@ -6729,7 +6729,7 @@ rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_reg_info)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_reg_info);
 int
 rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -6796,7 +6796,7 @@ rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom_length)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom_length);
 int
 rte_eth_dev_get_eeprom_length(uint16_t port_id)
 {
@@ -6815,7 +6815,7 @@ rte_eth_dev_get_eeprom_length(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom);
 int
 rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 {
@@ -6841,7 +6841,7 @@ rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_eeprom)
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_eeprom);
 int
 rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 {
@@ -6935,7 +6935,7 @@ rte_eth_dev_get_module_eeprom(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info);
 int
 rte_eth_dev_get_dcb_info(uint16_t port_id,
 			     struct rte_eth_dcb_info *dcb_info)
@@ -6983,7 +6983,7 @@ eth_dev_adjust_nb_desc(uint16_t *nb_desc,
 	*nb_desc = (uint16_t)nb_desc_32;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_adjust_nb_rx_tx_desc)
+RTE_EXPORT_SYMBOL(rte_eth_dev_adjust_nb_rx_tx_desc);
 int
 rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 				 uint16_t *nb_rx_desc,
@@ -7037,7 +7037,7 @@ rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_pool_ops_supported)
+RTE_EXPORT_SYMBOL(rte_eth_dev_pool_ops_supported);
 int
 rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 {
@@ -7084,7 +7084,7 @@ rte_eth_representor_info_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_rx_metadata_negotiate)
+RTE_EXPORT_SYMBOL(rte_eth_rx_metadata_negotiate);
 int
 rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 {
@@ -7418,5 +7418,5 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
+RTE_EXPORT_SYMBOL(rte_eth_dev_logtype);
 RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO);
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index fe8f43caff..e443760a06 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -370,7 +370,7 @@ rte_flow_ops_get(uint16_t port_id, struct rte_flow_error *error)
 }
 
 /* Check whether a flow rule can be created on a given port. */
-RTE_EXPORT_SYMBOL(rte_flow_validate)
+RTE_EXPORT_SYMBOL(rte_flow_validate);
 int
 rte_flow_validate(uint16_t port_id,
 		  const struct rte_flow_attr *attr,
@@ -407,7 +407,7 @@ rte_flow_validate(uint16_t port_id,
 }
 
 /* Create a flow rule on a given port. */
-RTE_EXPORT_SYMBOL(rte_flow_create)
+RTE_EXPORT_SYMBOL(rte_flow_create);
 struct rte_flow *
 rte_flow_create(uint16_t port_id,
 		const struct rte_flow_attr *attr,
@@ -438,7 +438,7 @@ rte_flow_create(uint16_t port_id,
 }
 
 /* Destroy a flow rule on a given port. */
-RTE_EXPORT_SYMBOL(rte_flow_destroy)
+RTE_EXPORT_SYMBOL(rte_flow_destroy);
 int
 rte_flow_destroy(uint16_t port_id,
 		 struct rte_flow *flow,
@@ -493,7 +493,7 @@ rte_flow_actions_update(uint16_t port_id,
 }
 
 /* Destroy all flow rules associated with a port. */
-RTE_EXPORT_SYMBOL(rte_flow_flush)
+RTE_EXPORT_SYMBOL(rte_flow_flush);
 int
 rte_flow_flush(uint16_t port_id,
 	       struct rte_flow_error *error)
@@ -520,7 +520,7 @@ rte_flow_flush(uint16_t port_id,
 }
 
 /* Query an existing flow rule. */
-RTE_EXPORT_SYMBOL(rte_flow_query)
+RTE_EXPORT_SYMBOL(rte_flow_query);
 int
 rte_flow_query(uint16_t port_id,
 	       struct rte_flow *flow,
@@ -550,7 +550,7 @@ rte_flow_query(uint16_t port_id,
 }
 
 /* Restrict ingress traffic to the defined flow rules. */
-RTE_EXPORT_SYMBOL(rte_flow_isolate)
+RTE_EXPORT_SYMBOL(rte_flow_isolate);
 int
 rte_flow_isolate(uint16_t port_id,
 		 int set,
@@ -578,7 +578,7 @@ rte_flow_isolate(uint16_t port_id,
 }
 
 /* Initialize flow error structure. */
-RTE_EXPORT_SYMBOL(rte_flow_error_set)
+RTE_EXPORT_SYMBOL(rte_flow_error_set);
 int
 rte_flow_error_set(struct rte_flow_error *error,
 		   int code,
@@ -1186,7 +1186,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 }
 
 /** Store a full rte_flow description. */
-RTE_EXPORT_SYMBOL(rte_flow_copy)
+RTE_EXPORT_SYMBOL(rte_flow_copy);
 size_t
 rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	      const struct rte_flow_attr *attr,
@@ -1593,7 +1593,7 @@ rte_flow_tunnel_item_release(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_SYMBOL(rte_flow_pick_transfer_proxy)
+RTE_EXPORT_SYMBOL(rte_flow_pick_transfer_proxy);
 int
 rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 			     struct rte_flow_error *error)
diff --git a/lib/ethdev/rte_tm.c b/lib/ethdev/rte_tm.c
index 66b8934c3b..f265e8cffa 100644
--- a/lib/ethdev/rte_tm.c
+++ b/lib/ethdev/rte_tm.c
@@ -59,7 +59,7 @@ __extension__ ({					\
 })
 
 /* Get number of leaf nodes */
-RTE_EXPORT_SYMBOL(rte_tm_get_number_of_leaf_nodes)
+RTE_EXPORT_SYMBOL(rte_tm_get_number_of_leaf_nodes);
 int
 rte_tm_get_number_of_leaf_nodes(uint16_t port_id,
 	uint32_t *n_leaf_nodes,
@@ -89,7 +89,7 @@ rte_tm_get_number_of_leaf_nodes(uint16_t port_id,
 }
 
 /* Check node type (leaf or non-leaf) */
-RTE_EXPORT_SYMBOL(rte_tm_node_type_get)
+RTE_EXPORT_SYMBOL(rte_tm_node_type_get);
 int
 rte_tm_node_type_get(uint16_t port_id,
 	uint32_t node_id,
@@ -107,7 +107,7 @@ rte_tm_node_type_get(uint16_t port_id,
 }
 
 /* Get capabilities */
-RTE_EXPORT_SYMBOL(rte_tm_capabilities_get)
+RTE_EXPORT_SYMBOL(rte_tm_capabilities_get);
 int rte_tm_capabilities_get(uint16_t port_id,
 	struct rte_tm_capabilities *cap,
 	struct rte_tm_error *error)
@@ -123,7 +123,7 @@ int rte_tm_capabilities_get(uint16_t port_id,
 }
 
 /* Get level capabilities */
-RTE_EXPORT_SYMBOL(rte_tm_level_capabilities_get)
+RTE_EXPORT_SYMBOL(rte_tm_level_capabilities_get);
 int rte_tm_level_capabilities_get(uint16_t port_id,
 	uint32_t level_id,
 	struct rte_tm_level_capabilities *cap,
@@ -140,7 +140,7 @@ int rte_tm_level_capabilities_get(uint16_t port_id,
 }
 
 /* Get node capabilities */
-RTE_EXPORT_SYMBOL(rte_tm_node_capabilities_get)
+RTE_EXPORT_SYMBOL(rte_tm_node_capabilities_get);
 int rte_tm_node_capabilities_get(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_node_capabilities *cap,
@@ -157,7 +157,7 @@ int rte_tm_node_capabilities_get(uint16_t port_id,
 }
 
 /* Add WRED profile */
-RTE_EXPORT_SYMBOL(rte_tm_wred_profile_add)
+RTE_EXPORT_SYMBOL(rte_tm_wred_profile_add);
 int rte_tm_wred_profile_add(uint16_t port_id,
 	uint32_t wred_profile_id,
 	const struct rte_tm_wred_params *profile,
@@ -174,7 +174,7 @@ int rte_tm_wred_profile_add(uint16_t port_id,
 }
 
 /* Delete WRED profile */
-RTE_EXPORT_SYMBOL(rte_tm_wred_profile_delete)
+RTE_EXPORT_SYMBOL(rte_tm_wred_profile_delete);
 int rte_tm_wred_profile_delete(uint16_t port_id,
 	uint32_t wred_profile_id,
 	struct rte_tm_error *error)
@@ -190,7 +190,7 @@ int rte_tm_wred_profile_delete(uint16_t port_id,
 }
 
 /* Add/update shared WRED context */
-RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_add_update)
+RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_add_update);
 int rte_tm_shared_wred_context_add_update(uint16_t port_id,
 	uint32_t shared_wred_context_id,
 	uint32_t wred_profile_id,
@@ -209,7 +209,7 @@ int rte_tm_shared_wred_context_add_update(uint16_t port_id,
 }
 
 /* Delete shared WRED context */
-RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_delete)
+RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_delete);
 int rte_tm_shared_wred_context_delete(uint16_t port_id,
 	uint32_t shared_wred_context_id,
 	struct rte_tm_error *error)
@@ -226,7 +226,7 @@ int rte_tm_shared_wred_context_delete(uint16_t port_id,
 }
 
 /* Add shaper profile */
-RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_add)
+RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_add);
 int rte_tm_shaper_profile_add(uint16_t port_id,
 	uint32_t shaper_profile_id,
 	const struct rte_tm_shaper_params *profile,
@@ -244,7 +244,7 @@ int rte_tm_shaper_profile_add(uint16_t port_id,
 }
 
 /* Delete WRED profile */
-RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_delete)
+RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_delete);
 int rte_tm_shaper_profile_delete(uint16_t port_id,
 	uint32_t shaper_profile_id,
 	struct rte_tm_error *error)
@@ -260,7 +260,7 @@ int rte_tm_shaper_profile_delete(uint16_t port_id,
 }
 
 /* Add shared shaper */
-RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_add_update)
+RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_add_update);
 int rte_tm_shared_shaper_add_update(uint16_t port_id,
 	uint32_t shared_shaper_id,
 	uint32_t shaper_profile_id,
@@ -278,7 +278,7 @@ int rte_tm_shared_shaper_add_update(uint16_t port_id,
 }
 
 /* Delete shared shaper */
-RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_delete)
+RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_delete);
 int rte_tm_shared_shaper_delete(uint16_t port_id,
 	uint32_t shared_shaper_id,
 	struct rte_tm_error *error)
@@ -294,7 +294,7 @@ int rte_tm_shared_shaper_delete(uint16_t port_id,
 }
 
 /* Add node to port traffic manager hierarchy */
-RTE_EXPORT_SYMBOL(rte_tm_node_add)
+RTE_EXPORT_SYMBOL(rte_tm_node_add);
 int rte_tm_node_add(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t parent_node_id,
@@ -340,7 +340,7 @@ int rte_tm_node_query(uint16_t port_id,
 }
 
 /* Delete node from traffic manager hierarchy */
-RTE_EXPORT_SYMBOL(rte_tm_node_delete)
+RTE_EXPORT_SYMBOL(rte_tm_node_delete);
 int rte_tm_node_delete(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -356,7 +356,7 @@ int rte_tm_node_delete(uint16_t port_id,
 }
 
 /* Suspend node */
-RTE_EXPORT_SYMBOL(rte_tm_node_suspend)
+RTE_EXPORT_SYMBOL(rte_tm_node_suspend);
 int rte_tm_node_suspend(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -372,7 +372,7 @@ int rte_tm_node_suspend(uint16_t port_id,
 }
 
 /* Resume node */
-RTE_EXPORT_SYMBOL(rte_tm_node_resume)
+RTE_EXPORT_SYMBOL(rte_tm_node_resume);
 int rte_tm_node_resume(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -388,7 +388,7 @@ int rte_tm_node_resume(uint16_t port_id,
 }
 
 /* Commit the initial port traffic manager hierarchy */
-RTE_EXPORT_SYMBOL(rte_tm_hierarchy_commit)
+RTE_EXPORT_SYMBOL(rte_tm_hierarchy_commit);
 int rte_tm_hierarchy_commit(uint16_t port_id,
 	int clear_on_fail,
 	struct rte_tm_error *error)
@@ -404,7 +404,7 @@ int rte_tm_hierarchy_commit(uint16_t port_id,
 }
 
 /* Update node parent  */
-RTE_EXPORT_SYMBOL(rte_tm_node_parent_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_parent_update);
 int rte_tm_node_parent_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t parent_node_id,
@@ -424,7 +424,7 @@ int rte_tm_node_parent_update(uint16_t port_id,
 }
 
 /* Update node private shaper */
-RTE_EXPORT_SYMBOL(rte_tm_node_shaper_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_shaper_update);
 int rte_tm_node_shaper_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shaper_profile_id,
@@ -442,7 +442,7 @@ int rte_tm_node_shaper_update(uint16_t port_id,
 }
 
 /* Update node shared shapers */
-RTE_EXPORT_SYMBOL(rte_tm_node_shared_shaper_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_shared_shaper_update);
 int rte_tm_node_shared_shaper_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shared_shaper_id,
@@ -461,7 +461,7 @@ int rte_tm_node_shared_shaper_update(uint16_t port_id,
 }
 
 /* Update node stats */
-RTE_EXPORT_SYMBOL(rte_tm_node_stats_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_stats_update);
 int rte_tm_node_stats_update(uint16_t port_id,
 	uint32_t node_id,
 	uint64_t stats_mask,
@@ -478,7 +478,7 @@ int rte_tm_node_stats_update(uint16_t port_id,
 }
 
 /* Update WFQ weight mode */
-RTE_EXPORT_SYMBOL(rte_tm_node_wfq_weight_mode_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_wfq_weight_mode_update);
 int rte_tm_node_wfq_weight_mode_update(uint16_t port_id,
 	uint32_t node_id,
 	int *wfq_weight_mode,
@@ -498,7 +498,7 @@ int rte_tm_node_wfq_weight_mode_update(uint16_t port_id,
 }
 
 /* Update node congestion management mode */
-RTE_EXPORT_SYMBOL(rte_tm_node_cman_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_cman_update);
 int rte_tm_node_cman_update(uint16_t port_id,
 	uint32_t node_id,
 	enum rte_tm_cman_mode cman,
@@ -515,7 +515,7 @@ int rte_tm_node_cman_update(uint16_t port_id,
 }
 
 /* Update node private WRED context */
-RTE_EXPORT_SYMBOL(rte_tm_node_wred_context_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_wred_context_update);
 int rte_tm_node_wred_context_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t wred_profile_id,
@@ -533,7 +533,7 @@ int rte_tm_node_wred_context_update(uint16_t port_id,
 }
 
 /* Update node shared WRED context */
-RTE_EXPORT_SYMBOL(rte_tm_node_shared_wred_context_update)
+RTE_EXPORT_SYMBOL(rte_tm_node_shared_wred_context_update);
 int rte_tm_node_shared_wred_context_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shared_wred_context_id,
@@ -553,7 +553,7 @@ int rte_tm_node_shared_wred_context_update(uint16_t port_id,
 }
 
 /* Read and/or clear stats counters for specific node */
-RTE_EXPORT_SYMBOL(rte_tm_node_stats_read)
+RTE_EXPORT_SYMBOL(rte_tm_node_stats_read);
 int rte_tm_node_stats_read(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_node_stats *stats,
@@ -573,7 +573,7 @@ int rte_tm_node_stats_read(uint16_t port_id,
 }
 
 /* Packet marking - VLAN DEI */
-RTE_EXPORT_SYMBOL(rte_tm_mark_vlan_dei)
+RTE_EXPORT_SYMBOL(rte_tm_mark_vlan_dei);
 int rte_tm_mark_vlan_dei(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
@@ -592,7 +592,7 @@ int rte_tm_mark_vlan_dei(uint16_t port_id,
 }
 
 /* Packet marking - IPv4/IPv6 ECN */
-RTE_EXPORT_SYMBOL(rte_tm_mark_ip_ecn)
+RTE_EXPORT_SYMBOL(rte_tm_mark_ip_ecn);
 int rte_tm_mark_ip_ecn(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
@@ -611,7 +611,7 @@ int rte_tm_mark_ip_ecn(uint16_t port_id,
 }
 
 /* Packet marking - IPv4/IPv6 DSCP */
-RTE_EXPORT_SYMBOL(rte_tm_mark_ip_dscp)
+RTE_EXPORT_SYMBOL(rte_tm_mark_ip_dscp);
 int rte_tm_mark_ip_dscp(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index ade6723b7b..a1301606d6 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -38,15 +38,15 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_stop,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_close,
 	lib.eventdev.close)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_enq_burst)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_enq_burst);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_enq_burst,
 	lib.eventdev.enq.burst)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_deq_burst)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_deq_burst);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_deq_burst,
 	lib.eventdev.deq.burst)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_maintain)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_maintain);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_maintain,
 	lib.eventdev.maintain)
 
@@ -103,7 +103,7 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_start,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_stop,
 	lib.eventdev.tx.adapter.stop)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_eth_tx_adapter_enqueue)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_eth_tx_adapter_enqueue);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_enqueue,
 	lib.eventdev.tx.adapter.enq)
 
@@ -120,15 +120,15 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_adapter_stop,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_adapter_free,
 	lib.eventdev.timer.free)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_burst)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_burst);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_arm_burst,
 	lib.eventdev.timer.burst)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_tmo_tick_burst)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_tmo_tick_burst);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_arm_tmo_tick_burst,
 	lib.eventdev.timer.tick.burst)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_cancel_burst)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_cancel_burst);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_cancel_burst,
 	lib.eventdev.timer.cancel)
 
@@ -151,7 +151,7 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_start,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_stop,
 	lib.eventdev.crypto.stop)
 
-RTE_EXPORT_SYMBOL(__rte_eventdev_trace_crypto_adapter_enqueue)
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_crypto_adapter_enqueue);
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_enqueue,
 	lib.eventdev.crypto.enq)
 
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index b827a0ffd6..c579e55bf7 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -363,7 +363,7 @@ eca_default_config_cb(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create_ext)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create_ext);
 int
 rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_crypto_adapter_conf_cb conf_cb,
@@ -439,7 +439,7 @@ rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create);
 int
 rte_event_crypto_adapter_create(uint8_t id, uint8_t dev_id,
 				struct rte_event_port_conf *port_config,
@@ -468,7 +468,7 @@ rte_event_crypto_adapter_create(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_free)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_free);
 int
 rte_event_crypto_adapter_free(uint8_t id)
 {
@@ -1040,7 +1040,7 @@ eca_add_queue_pair(struct event_crypto_adapter *adapter, uint8_t cdev_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_add)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_add);
 int
 rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 			uint8_t cdev_id,
@@ -1195,7 +1195,7 @@ rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_del)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_del);
 int
 rte_event_crypto_adapter_queue_pair_del(uint8_t id, uint8_t cdev_id,
 					int32_t queue_pair_id)
@@ -1321,7 +1321,7 @@ eca_adapter_ctrl(uint8_t id, int start)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_start)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_start);
 int
 rte_event_crypto_adapter_start(uint8_t id)
 {
@@ -1336,7 +1336,7 @@ rte_event_crypto_adapter_start(uint8_t id)
 	return eca_adapter_ctrl(id, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stop)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stop);
 int
 rte_event_crypto_adapter_stop(uint8_t id)
 {
@@ -1344,7 +1344,7 @@ rte_event_crypto_adapter_stop(uint8_t id)
 	return eca_adapter_ctrl(id, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_get)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_get);
 int
 rte_event_crypto_adapter_stats_get(uint8_t id,
 				struct rte_event_crypto_adapter_stats *stats)
@@ -1397,7 +1397,7 @@ rte_event_crypto_adapter_stats_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_reset)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_reset);
 int
 rte_event_crypto_adapter_stats_reset(uint8_t id)
 {
@@ -1534,7 +1534,7 @@ rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_service_id_get)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_service_id_get);
 int
 rte_event_crypto_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1554,7 +1554,7 @@ rte_event_crypto_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return adapter->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_event_port_get)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_event_port_get);
 int
 rte_event_crypto_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -1573,7 +1573,7 @@ rte_event_crypto_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_vector_limits_get)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_vector_limits_get);
 int
 rte_event_crypto_adapter_vector_limits_get(
 	uint8_t dev_id, uint16_t cdev_id,
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 994f256322..f33811c60e 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2519,7 +2519,7 @@ rxa_config_params_validate(struct rte_event_eth_rx_adapter_params *rxa_params,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_ext)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_ext);
 int
 rte_event_eth_rx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -2534,7 +2534,7 @@ rte_event_eth_rx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 	return rxa_create(id, dev_id, &rxa_params, conf_cb, conf_arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_with_params)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_with_params);
 int
 rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
 			struct rte_event_port_conf *port_config,
@@ -2584,7 +2584,7 @@ rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 	return rxa_create(id, dev_id, &temp_params, conf_cb, conf_arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create);
 int
 rte_event_eth_rx_adapter_create(uint8_t id, uint8_t dev_id,
 		struct rte_event_port_conf *port_config)
@@ -2610,7 +2610,7 @@ rte_event_eth_rx_adapter_create(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_free)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_free);
 int
 rte_event_eth_rx_adapter_free(uint8_t id)
 {
@@ -2643,7 +2643,7 @@ rte_event_eth_rx_adapter_free(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_add)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_add);
 int
 rte_event_eth_rx_adapter_queue_add(uint8_t id,
 		uint16_t eth_dev_id,
@@ -2969,7 +2969,7 @@ rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limits)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_del)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_del);
 int
 rte_event_eth_rx_adapter_queue_del(uint8_t id, uint16_t eth_dev_id,
 				int32_t rx_queue_id)
@@ -3098,7 +3098,7 @@ rte_event_eth_rx_adapter_queue_del(uint8_t id, uint16_t eth_dev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_vector_limits_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_vector_limits_get);
 int
 rte_event_eth_rx_adapter_vector_limits_get(
 	uint8_t dev_id, uint16_t eth_port_id,
@@ -3140,7 +3140,7 @@ rte_event_eth_rx_adapter_vector_limits_get(
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_start)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_start);
 int
 rte_event_eth_rx_adapter_start(uint8_t id)
 {
@@ -3148,7 +3148,7 @@ rte_event_eth_rx_adapter_start(uint8_t id)
 	return rxa_ctrl(id, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stop)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stop);
 int
 rte_event_eth_rx_adapter_stop(uint8_t id)
 {
@@ -3165,7 +3165,7 @@ rxa_queue_stats_reset(struct eth_rx_queue_info *queue_info)
 	memset(q_stats, 0, sizeof(*q_stats));
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_get);
 int
 rte_event_eth_rx_adapter_stats_get(uint8_t id,
 			       struct rte_event_eth_rx_adapter_stats *stats)
@@ -3240,7 +3240,7 @@ rte_event_eth_rx_adapter_stats_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_get);
 int
 rte_event_eth_rx_adapter_queue_stats_get(uint8_t id,
 		uint16_t eth_dev_id,
@@ -3305,7 +3305,7 @@ rte_event_eth_rx_adapter_queue_stats_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_reset)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_reset);
 int
 rte_event_eth_rx_adapter_stats_reset(uint8_t id)
 {
@@ -3353,7 +3353,7 @@ rte_event_eth_rx_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_reset)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_reset);
 int
 rte_event_eth_rx_adapter_queue_stats_reset(uint8_t id,
 		uint16_t eth_dev_id,
@@ -3408,7 +3408,7 @@ rte_event_eth_rx_adapter_queue_stats_reset(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_service_id_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_service_id_get);
 int
 rte_event_eth_rx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -3431,7 +3431,7 @@ rte_event_eth_rx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return rx_adapter->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_event_port_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_event_port_get);
 int
 rte_event_eth_rx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -3454,7 +3454,7 @@ rte_event_eth_rx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return rx_adapter->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_cb_register)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_cb_register);
 int
 rte_event_eth_rx_adapter_cb_register(uint8_t id,
 					uint16_t eth_dev_id,
@@ -3503,7 +3503,7 @@ rte_event_eth_rx_adapter_cb_register(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_conf_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_conf_get);
 int
 rte_event_eth_rx_adapter_queue_conf_get(uint8_t id,
 			uint16_t eth_dev_id,
@@ -3605,7 +3605,7 @@ rxa_is_queue_added(struct event_eth_rx_adapter *rx_adapter,
 #define rxa_dev_instance_get(rx_adapter) \
 		rxa_evdev((rx_adapter))->dev_ops->eth_rx_adapter_instance_get
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_instance_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_instance_get);
 int
 rte_event_eth_rx_adapter_instance_get(uint16_t eth_dev_id,
 				      uint16_t rx_queue_id,
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 83b6af0955..cc4d0c61a5 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -1039,7 +1039,7 @@ txa_service_stop(uint8_t id)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create);
 int
 rte_event_eth_tx_adapter_create(uint8_t id, uint8_t dev_id,
 				struct rte_event_port_conf *port_conf)
@@ -1084,7 +1084,7 @@ rte_event_eth_tx_adapter_create(uint8_t id, uint8_t dev_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create_ext)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create_ext);
 int
 rte_event_eth_tx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_eth_tx_adapter_conf_cb conf_cb,
@@ -1129,7 +1129,7 @@ rte_event_eth_tx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_event_port_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_event_port_get);
 int
 rte_event_eth_tx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -1140,7 +1140,7 @@ rte_event_eth_tx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return txa_service_event_port_get(id, event_port_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_free)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_free);
 int
 rte_event_eth_tx_adapter_free(uint8_t id)
 {
@@ -1160,7 +1160,7 @@ rte_event_eth_tx_adapter_free(uint8_t id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_add)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_add);
 int
 rte_event_eth_tx_adapter_queue_add(uint8_t id,
 				uint16_t eth_dev_id,
@@ -1194,7 +1194,7 @@ rte_event_eth_tx_adapter_queue_add(uint8_t id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_del)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_del);
 int
 rte_event_eth_tx_adapter_queue_del(uint8_t id,
 				uint16_t eth_dev_id,
@@ -1227,7 +1227,7 @@ rte_event_eth_tx_adapter_queue_del(uint8_t id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_service_id_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_service_id_get);
 int
 rte_event_eth_tx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1236,7 +1236,7 @@ rte_event_eth_tx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return txa_service_id_get(id, service_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_start)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_start);
 int
 rte_event_eth_tx_adapter_start(uint8_t id)
 {
@@ -1251,7 +1251,7 @@ rte_event_eth_tx_adapter_start(uint8_t id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_get);
 int
 rte_event_eth_tx_adapter_stats_get(uint8_t id,
 				struct rte_event_eth_tx_adapter_stats *stats)
@@ -1288,7 +1288,7 @@ rte_event_eth_tx_adapter_stats_get(uint8_t id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_reset)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_reset);
 int
 rte_event_eth_tx_adapter_stats_reset(uint8_t id)
 {
@@ -1397,7 +1397,7 @@ rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stop)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stop);
 int
 rte_event_eth_tx_adapter_stop(uint8_t id)
 {
@@ -1412,7 +1412,7 @@ rte_event_eth_tx_adapter_stop(uint8_t id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_instance_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_instance_get);
 int
 rte_event_eth_tx_adapter_instance_get(uint16_t eth_dev_id,
 				      uint16_t tx_queue_id,
@@ -1546,7 +1546,7 @@ txa_queue_start_state_set(uint16_t eth_dev_id, uint16_t tx_queue_id,
 					    start_state, txa);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_start)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_start);
 int
 rte_event_eth_tx_adapter_queue_start(uint16_t eth_dev_id, uint16_t tx_queue_id)
 {
@@ -1555,7 +1555,7 @@ rte_event_eth_tx_adapter_queue_start(uint16_t eth_dev_id, uint16_t tx_queue_id)
 	return txa_queue_start_state_set(eth_dev_id, tx_queue_id, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_stop)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_stop);
 int
 rte_event_eth_tx_adapter_queue_stop(uint16_t eth_dev_id, uint16_t tx_queue_id)
 {
diff --git a/lib/eventdev/rte_event_ring.c b/lib/eventdev/rte_event_ring.c
index 5718985486..1a0ea149d7 100644
--- a/lib/eventdev/rte_event_ring.c
+++ b/lib/eventdev/rte_event_ring.c
@@ -8,7 +8,7 @@
 #include "rte_event_ring.h"
 #include "eventdev_trace.h"
 
-RTE_EXPORT_SYMBOL(rte_event_ring_init)
+RTE_EXPORT_SYMBOL(rte_event_ring_init);
 int
 rte_event_ring_init(struct rte_event_ring *r, const char *name,
 	unsigned int count, unsigned int flags)
@@ -24,7 +24,7 @@ rte_event_ring_init(struct rte_event_ring *r, const char *name,
 }
 
 /* create the ring */
-RTE_EXPORT_SYMBOL(rte_event_ring_create)
+RTE_EXPORT_SYMBOL(rte_event_ring_create);
 struct rte_event_ring *
 rte_event_ring_create(const char *name, unsigned int count, int socket_id,
 		unsigned int flags)
@@ -37,7 +37,7 @@ rte_event_ring_create(const char *name, unsigned int count, int socket_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_event_ring_lookup)
+RTE_EXPORT_SYMBOL(rte_event_ring_lookup);
 struct rte_event_ring *
 rte_event_ring_lookup(const char *name)
 {
@@ -47,7 +47,7 @@ rte_event_ring_lookup(const char *name)
 }
 
 /* free the ring */
-RTE_EXPORT_SYMBOL(rte_event_ring_free)
+RTE_EXPORT_SYMBOL(rte_event_ring_free);
 void
 rte_event_ring_free(struct rte_event_ring *r)
 {
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index af98b1d9f6..aa1359b7e5 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -133,7 +133,7 @@ default_port_conf_cb(uint16_t id, uint8_t event_dev_id, uint8_t *event_port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create);
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_create(const struct rte_event_timer_adapter_conf *conf)
 {
@@ -141,7 +141,7 @@ rte_event_timer_adapter_create(const struct rte_event_timer_adapter_conf *conf)
 						  NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create_ext)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create_ext);
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_create_ext(
 		const struct rte_event_timer_adapter_conf *conf,
@@ -267,7 +267,7 @@ rte_event_timer_adapter_create_ext(
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_get_info)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_get_info);
 int
 rte_event_timer_adapter_get_info(const struct rte_event_timer_adapter *adapter,
 		struct rte_event_timer_adapter_info *adapter_info)
@@ -288,7 +288,7 @@ rte_event_timer_adapter_get_info(const struct rte_event_timer_adapter *adapter,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_start)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_start);
 int
 rte_event_timer_adapter_start(const struct rte_event_timer_adapter *adapter)
 {
@@ -312,7 +312,7 @@ rte_event_timer_adapter_start(const struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stop)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stop);
 int
 rte_event_timer_adapter_stop(const struct rte_event_timer_adapter *adapter)
 {
@@ -336,7 +336,7 @@ rte_event_timer_adapter_stop(const struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_lookup)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_lookup);
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_lookup(uint16_t adapter_id)
 {
@@ -404,7 +404,7 @@ rte_event_timer_adapter_lookup(uint16_t adapter_id)
 	return adapter;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_free)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_free);
 int
 rte_event_timer_adapter_free(struct rte_event_timer_adapter *adapter)
 {
@@ -446,7 +446,7 @@ rte_event_timer_adapter_free(struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_service_id_get)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_service_id_get);
 int
 rte_event_timer_adapter_service_id_get(struct rte_event_timer_adapter *adapter,
 				       uint32_t *service_id)
@@ -464,7 +464,7 @@ rte_event_timer_adapter_service_id_get(struct rte_event_timer_adapter *adapter,
 	return adapter->data->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_get)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_get);
 int
 rte_event_timer_adapter_stats_get(struct rte_event_timer_adapter *adapter,
 				  struct rte_event_timer_adapter_stats *stats)
@@ -479,7 +479,7 @@ rte_event_timer_adapter_stats_get(struct rte_event_timer_adapter *adapter,
 	return adapter->ops->stats_get(adapter, stats);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_reset)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_reset);
 int
 rte_event_timer_adapter_stats_reset(struct rte_event_timer_adapter *adapter)
 {
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index b921142d7b..742d9d5ec5 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -43,19 +43,19 @@ static struct rte_eventdev_global eventdev_globals = {
 };
 
 /* Public fastpath APIs. */
-RTE_EXPORT_SYMBOL(rte_event_fp_ops)
+RTE_EXPORT_SYMBOL(rte_event_fp_ops);
 struct rte_event_fp_ops rte_event_fp_ops[RTE_EVENT_MAX_DEVS];
 
 /* Event dev north bound API implementation */
 
-RTE_EXPORT_SYMBOL(rte_event_dev_count)
+RTE_EXPORT_SYMBOL(rte_event_dev_count);
 uint8_t
 rte_event_dev_count(void)
 {
 	return eventdev_globals.nb_devs;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_get_dev_id)
+RTE_EXPORT_SYMBOL(rte_event_dev_get_dev_id);
 int
 rte_event_dev_get_dev_id(const char *name)
 {
@@ -80,7 +80,7 @@ rte_event_dev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_socket_id)
+RTE_EXPORT_SYMBOL(rte_event_dev_socket_id);
 int
 rte_event_dev_socket_id(uint8_t dev_id)
 {
@@ -94,7 +94,7 @@ rte_event_dev_socket_id(uint8_t dev_id)
 	return dev->data->socket_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_info_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_info_get);
 int
 rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 {
@@ -123,7 +123,7 @@ rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_caps_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_caps_get);
 int
 rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps)
@@ -150,7 +150,7 @@ rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		: 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_timer_adapter_caps_get)
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_caps_get);
 int
 rte_event_timer_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 {
@@ -176,7 +176,7 @@ rte_event_timer_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 		: 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_caps_get)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_caps_get);
 int
 rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
 				  uint32_t *caps)
@@ -205,7 +205,7 @@ rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
 		dev->dev_ops->crypto_adapter_caps_get(dev, cdev, caps) : 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_caps_get)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_caps_get);
 int
 rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps)
@@ -374,7 +374,7 @@ event_dev_port_config(struct rte_eventdev *dev, uint8_t nb_ports)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_configure)
+RTE_EXPORT_SYMBOL(rte_event_dev_configure);
 int
 rte_event_dev_configure(uint8_t dev_id,
 			const struct rte_event_dev_config *dev_conf)
@@ -577,7 +577,7 @@ is_valid_queue(struct rte_eventdev *dev, uint8_t queue_id)
 		return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_queue_default_conf_get)
+RTE_EXPORT_SYMBOL(rte_event_queue_default_conf_get);
 int
 rte_event_queue_default_conf_get(uint8_t dev_id, uint8_t queue_id,
 				 struct rte_event_queue_conf *queue_conf)
@@ -638,7 +638,7 @@ is_valid_ordered_queue_conf(const struct rte_event_queue_conf *queue_conf)
 }
 
 
-RTE_EXPORT_SYMBOL(rte_event_queue_setup)
+RTE_EXPORT_SYMBOL(rte_event_queue_setup);
 int
 rte_event_queue_setup(uint8_t dev_id, uint8_t queue_id,
 		      const struct rte_event_queue_conf *queue_conf)
@@ -710,7 +710,7 @@ is_valid_port(struct rte_eventdev *dev, uint8_t port_id)
 		return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_default_conf_get)
+RTE_EXPORT_SYMBOL(rte_event_port_default_conf_get);
 int
 rte_event_port_default_conf_get(uint8_t dev_id, uint8_t port_id,
 				 struct rte_event_port_conf *port_conf)
@@ -738,7 +738,7 @@ rte_event_port_default_conf_get(uint8_t dev_id, uint8_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_setup)
+RTE_EXPORT_SYMBOL(rte_event_port_setup);
 int
 rte_event_port_setup(uint8_t dev_id, uint8_t port_id,
 		     const struct rte_event_port_conf *port_conf)
@@ -829,7 +829,7 @@ rte_event_port_setup(uint8_t dev_id, uint8_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_quiesce)
+RTE_EXPORT_SYMBOL(rte_event_port_quiesce);
 void
 rte_event_port_quiesce(uint8_t dev_id, uint8_t port_id,
 		       rte_eventdev_port_flush_t release_cb, void *args)
@@ -850,7 +850,7 @@ rte_event_port_quiesce(uint8_t dev_id, uint8_t port_id,
 		dev->dev_ops->port_quiesce(dev, dev->data->ports[port_id], release_cb, args);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_attr_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_attr_get);
 int
 rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 		       uint32_t *attr_value)
@@ -881,7 +881,7 @@ rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_attr_get)
+RTE_EXPORT_SYMBOL(rte_event_port_attr_get);
 int
 rte_event_port_attr_get(uint8_t dev_id, uint8_t port_id, uint32_t attr_id,
 			uint32_t *attr_value)
@@ -933,7 +933,7 @@ rte_event_port_attr_get(uint8_t dev_id, uint8_t port_id, uint32_t attr_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_queue_attr_get)
+RTE_EXPORT_SYMBOL(rte_event_queue_attr_get);
 int
 rte_event_queue_attr_get(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 			uint32_t *attr_value)
@@ -993,7 +993,7 @@ rte_event_queue_attr_get(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_queue_attr_set)
+RTE_EXPORT_SYMBOL(rte_event_queue_attr_set);
 int
 rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 			 uint64_t attr_value)
@@ -1022,7 +1022,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 	return dev->dev_ops->queue_attr_set(dev, queue_id, attr_id, attr_value);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_link)
+RTE_EXPORT_SYMBOL(rte_event_port_link);
 int
 rte_event_port_link(uint8_t dev_id, uint8_t port_id,
 		    const uint8_t queues[], const uint8_t priorities[],
@@ -1114,7 +1114,7 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_unlink)
+RTE_EXPORT_SYMBOL(rte_event_port_unlink);
 int
 rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
 		      uint8_t queues[], uint16_t nb_unlinks)
@@ -1209,7 +1209,7 @@ rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_unlinks_in_progress)
+RTE_EXPORT_SYMBOL(rte_event_port_unlinks_in_progress);
 int
 rte_event_port_unlinks_in_progress(uint8_t dev_id, uint8_t port_id)
 {
@@ -1234,7 +1234,7 @@ rte_event_port_unlinks_in_progress(uint8_t dev_id, uint8_t port_id)
 	return dev->dev_ops->port_unlinks_in_progress(dev, dev->data->ports[port_id]);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_port_links_get)
+RTE_EXPORT_SYMBOL(rte_event_port_links_get);
 int
 rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
 			 uint8_t queues[], uint8_t priorities[])
@@ -1311,7 +1311,7 @@ rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dequeue_timeout_ticks)
+RTE_EXPORT_SYMBOL(rte_event_dequeue_timeout_ticks);
 int
 rte_event_dequeue_timeout_ticks(uint8_t dev_id, uint64_t ns,
 				 uint64_t *timeout_ticks)
@@ -1331,7 +1331,7 @@ rte_event_dequeue_timeout_ticks(uint8_t dev_id, uint64_t ns,
 	return dev->dev_ops->timeout_ticks(dev, ns, timeout_ticks);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_service_id_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_service_id_get);
 int
 rte_event_dev_service_id_get(uint8_t dev_id, uint32_t *service_id)
 {
@@ -1351,7 +1351,7 @@ rte_event_dev_service_id_get(uint8_t dev_id, uint32_t *service_id)
 	return dev->data->service_inited ? 0 : -ESRCH;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_dump)
+RTE_EXPORT_SYMBOL(rte_event_dev_dump);
 int
 rte_event_dev_dump(uint8_t dev_id, FILE *f)
 {
@@ -1379,7 +1379,7 @@ xstats_get_count(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_xstats_names_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_names_get);
 int
 rte_event_dev_xstats_names_get(uint8_t dev_id,
 		enum rte_event_dev_xstats_mode mode, uint8_t queue_port_id,
@@ -1404,7 +1404,7 @@ rte_event_dev_xstats_names_get(uint8_t dev_id,
 }
 
 /* retrieve eventdev extended statistics */
-RTE_EXPORT_SYMBOL(rte_event_dev_xstats_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_get);
 int
 rte_event_dev_xstats_get(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 		uint8_t queue_port_id, const uint64_t ids[],
@@ -1420,7 +1420,7 @@ rte_event_dev_xstats_get(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_xstats_by_name_get)
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_by_name_get);
 uint64_t
 rte_event_dev_xstats_by_name_get(uint8_t dev_id, const char *name,
 		uint64_t *id)
@@ -1440,7 +1440,7 @@ rte_event_dev_xstats_by_name_get(uint8_t dev_id, const char *name,
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_xstats_reset)
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_reset);
 int rte_event_dev_xstats_reset(uint8_t dev_id,
 		enum rte_event_dev_xstats_mode mode, int16_t queue_port_id,
 		const uint64_t ids[], uint32_t nb_ids)
@@ -1456,7 +1456,7 @@ int rte_event_dev_xstats_reset(uint8_t dev_id,
 RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_selftest_seqn_dynfield_offset)
 int rte_event_pmd_selftest_seqn_dynfield_offset = -1;
 
-RTE_EXPORT_SYMBOL(rte_event_dev_selftest)
+RTE_EXPORT_SYMBOL(rte_event_dev_selftest);
 int rte_event_dev_selftest(uint8_t dev_id)
 {
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
@@ -1477,7 +1477,7 @@ int rte_event_dev_selftest(uint8_t dev_id)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_vector_pool_create)
+RTE_EXPORT_SYMBOL(rte_event_vector_pool_create);
 struct rte_mempool *
 rte_event_vector_pool_create(const char *name, unsigned int n,
 			     unsigned int cache_size, uint16_t nb_elem,
@@ -1523,7 +1523,7 @@ rte_event_vector_pool_create(const char *name, unsigned int n,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_start)
+RTE_EXPORT_SYMBOL(rte_event_dev_start);
 int
 rte_event_dev_start(uint8_t dev_id)
 {
@@ -1555,7 +1555,7 @@ rte_event_dev_start(uint8_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_stop_flush_callback_register)
+RTE_EXPORT_SYMBOL(rte_event_dev_stop_flush_callback_register);
 int
 rte_event_dev_stop_flush_callback_register(uint8_t dev_id,
 					   rte_eventdev_stop_flush_t callback,
@@ -1576,7 +1576,7 @@ rte_event_dev_stop_flush_callback_register(uint8_t dev_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_stop)
+RTE_EXPORT_SYMBOL(rte_event_dev_stop);
 void
 rte_event_dev_stop(uint8_t dev_id)
 {
@@ -1601,7 +1601,7 @@ rte_event_dev_stop(uint8_t dev_id)
 	event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_close)
+RTE_EXPORT_SYMBOL(rte_event_dev_close);
 int
 rte_event_dev_close(uint8_t dev_id)
 {
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..76af3b880d 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -118,7 +118,7 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_add)
+RTE_EXPORT_SYMBOL(rte_fib_add);
 int
 rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 {
@@ -128,7 +128,7 @@ rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 	return fib->modify(fib, ip, depth, next_hop, RTE_FIB_ADD);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_delete)
+RTE_EXPORT_SYMBOL(rte_fib_delete);
 int
 rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 {
@@ -138,7 +138,7 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 	return fib->modify(fib, ip, depth, 0, RTE_FIB_DEL);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_lookup_bulk)
+RTE_EXPORT_SYMBOL(rte_fib_lookup_bulk);
 int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	uint64_t *next_hops, int n)
@@ -150,7 +150,7 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_create)
+RTE_EXPORT_SYMBOL(rte_fib_create);
 struct rte_fib *
 rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 {
@@ -247,7 +247,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_find_existing)
+RTE_EXPORT_SYMBOL(rte_fib_find_existing);
 struct rte_fib *
 rte_fib_find_existing(const char *name)
 {
@@ -286,7 +286,7 @@ free_dataplane(struct rte_fib *fib)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_free)
+RTE_EXPORT_SYMBOL(rte_fib_free);
 void
 rte_fib_free(struct rte_fib *fib)
 {
@@ -316,21 +316,21 @@ rte_fib_free(struct rte_fib *fib)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_get_dp)
+RTE_EXPORT_SYMBOL(rte_fib_get_dp);
 void *
 rte_fib_get_dp(struct rte_fib *fib)
 {
 	return (fib == NULL) ? NULL : fib->dp;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_get_rib)
+RTE_EXPORT_SYMBOL(rte_fib_get_rib);
 struct rte_rib *
 rte_fib_get_rib(struct rte_fib *fib)
 {
 	return (fib == NULL) ? NULL : fib->rib;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib_select_lookup)
+RTE_EXPORT_SYMBOL(rte_fib_select_lookup);
 int
 rte_fib_select_lookup(struct rte_fib *fib,
 	enum rte_fib_lookup_type type)
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 93a1c7197b..0b28dfee98 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -116,7 +116,7 @@ init_dataplane(struct rte_fib6 *fib, __rte_unused int socket_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_add)
+RTE_EXPORT_SYMBOL(rte_fib6_add);
 int
 rte_fib6_add(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop)
@@ -127,7 +127,7 @@ rte_fib6_add(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	return fib->modify(fib, ip, depth, next_hop, RTE_FIB6_ADD);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_delete)
+RTE_EXPORT_SYMBOL(rte_fib6_delete);
 int
 rte_fib6_delete(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth)
@@ -138,7 +138,7 @@ rte_fib6_delete(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	return fib->modify(fib, ip, depth, 0, RTE_FIB6_DEL);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_lookup_bulk)
+RTE_EXPORT_SYMBOL(rte_fib6_lookup_bulk);
 int
 rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	const struct rte_ipv6_addr *ips,
@@ -150,7 +150,7 @@ rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_create)
+RTE_EXPORT_SYMBOL(rte_fib6_create);
 struct rte_fib6 *
 rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 {
@@ -245,7 +245,7 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_find_existing)
+RTE_EXPORT_SYMBOL(rte_fib6_find_existing);
 struct rte_fib6 *
 rte_fib6_find_existing(const char *name)
 {
@@ -284,7 +284,7 @@ free_dataplane(struct rte_fib6 *fib)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_free)
+RTE_EXPORT_SYMBOL(rte_fib6_free);
 void
 rte_fib6_free(struct rte_fib6 *fib)
 {
@@ -314,21 +314,21 @@ rte_fib6_free(struct rte_fib6 *fib)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_get_dp)
+RTE_EXPORT_SYMBOL(rte_fib6_get_dp);
 void *
 rte_fib6_get_dp(struct rte_fib6 *fib)
 {
 	return (fib == NULL) ? NULL : fib->dp;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_get_rib)
+RTE_EXPORT_SYMBOL(rte_fib6_get_rib);
 struct rte_rib6 *
 rte_fib6_get_rib(struct rte_fib6 *fib)
 {
 	return (fib == NULL) ? NULL : fib->rib;
 }
 
-RTE_EXPORT_SYMBOL(rte_fib6_select_lookup)
+RTE_EXPORT_SYMBOL(rte_fib6_select_lookup);
 int
 rte_fib6_select_lookup(struct rte_fib6 *fib,
 	enum rte_fib6_lookup_type type)
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 0975bd8d49..9d62599c41 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -334,7 +334,7 @@ graph_src_node_avail(struct graph *graph)
 	return false;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_bind)
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_bind);
 int
 rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 {
@@ -366,7 +366,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_unbind)
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_unbind);
 void
 rte_graph_model_mcore_dispatch_core_unbind(rte_graph_t id)
 {
@@ -385,7 +385,7 @@ rte_graph_model_mcore_dispatch_core_unbind(rte_graph_t id)
 	return;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_lookup)
+RTE_EXPORT_SYMBOL(rte_graph_lookup);
 struct rte_graph *
 rte_graph_lookup(const char *name)
 {
@@ -399,7 +399,7 @@ rte_graph_lookup(const char *name)
 	return graph_mem_fixup_secondary(rc);
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_create)
+RTE_EXPORT_SYMBOL(rte_graph_create);
 rte_graph_t
 rte_graph_create(const char *name, struct rte_graph_param *prm)
 {
@@ -504,7 +504,7 @@ rte_graph_create(const char *name, struct rte_graph_param *prm)
 	return RTE_GRAPH_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_destroy)
+RTE_EXPORT_SYMBOL(rte_graph_destroy);
 int
 rte_graph_destroy(rte_graph_t id)
 {
@@ -620,7 +620,7 @@ graph_clone(struct graph *parent_graph, const char *name, struct rte_graph_param
 	return RTE_GRAPH_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_clone)
+RTE_EXPORT_SYMBOL(rte_graph_clone);
 rte_graph_t
 rte_graph_clone(rte_graph_t id, const char *name, struct rte_graph_param *prm)
 {
@@ -636,7 +636,7 @@ rte_graph_clone(rte_graph_t id, const char *name, struct rte_graph_param *prm)
 	return RTE_GRAPH_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_from_name)
+RTE_EXPORT_SYMBOL(rte_graph_from_name);
 rte_graph_t
 rte_graph_from_name(const char *name)
 {
@@ -649,7 +649,7 @@ rte_graph_from_name(const char *name)
 	return RTE_GRAPH_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_id_to_name)
+RTE_EXPORT_SYMBOL(rte_graph_id_to_name);
 char *
 rte_graph_id_to_name(rte_graph_t id)
 {
@@ -665,7 +665,7 @@ rte_graph_id_to_name(rte_graph_t id)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_node_get)
+RTE_EXPORT_SYMBOL(rte_graph_node_get);
 struct rte_node *
 rte_graph_node_get(rte_graph_t gid, uint32_t nid)
 {
@@ -689,7 +689,7 @@ rte_graph_node_get(rte_graph_t gid, uint32_t nid)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_node_get_by_name)
+RTE_EXPORT_SYMBOL(rte_graph_node_get_by_name);
 struct rte_node *
 rte_graph_node_get_by_name(const char *graph_name, const char *node_name)
 {
@@ -712,7 +712,7 @@ rte_graph_node_get_by_name(const char *graph_name, const char *node_name)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(__rte_node_stream_alloc)
+RTE_EXPORT_SYMBOL(__rte_node_stream_alloc);
 void __rte_noinline
 __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 {
@@ -728,7 +728,7 @@ __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 	node->realloc_count++;
 }
 
-RTE_EXPORT_SYMBOL(__rte_node_stream_alloc_size)
+RTE_EXPORT_SYMBOL(__rte_node_stream_alloc_size);
 void __rte_noinline
 __rte_node_stream_alloc_size(struct rte_graph *graph, struct rte_node *node,
 			     uint16_t req_size)
@@ -802,7 +802,7 @@ graph_to_dot(FILE *f, struct graph *graph)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_export)
+RTE_EXPORT_SYMBOL(rte_graph_export);
 int
 rte_graph_export(const char *name, FILE *f)
 {
@@ -840,21 +840,21 @@ graph_scan_dump(FILE *f, rte_graph_t id, bool all)
 	return;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_dump)
+RTE_EXPORT_SYMBOL(rte_graph_dump);
 void
 rte_graph_dump(FILE *f, rte_graph_t id)
 {
 	graph_scan_dump(f, id, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_list_dump)
+RTE_EXPORT_SYMBOL(rte_graph_list_dump);
 void
 rte_graph_list_dump(FILE *f)
 {
 	graph_scan_dump(f, 0, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_max_count)
+RTE_EXPORT_SYMBOL(rte_graph_max_count);
 rte_graph_t
 rte_graph_max_count(void)
 {
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index e3b8cccdc1..2d4f07ad80 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -52,7 +52,7 @@ node_dump(FILE *f, struct node *n)
 		fprintf(f, "     edge[%d] <%s>\n", i, n->next_nodes[i]);
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_obj_dump)
+RTE_EXPORT_SYMBOL(rte_graph_obj_dump);
 void
 rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
 {
diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index e0fc8fd25c..70403a6caa 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -394,7 +394,7 @@ expand_pattern_to_cluster(struct cluster *cluster, const char *pattern)
 	return -rte_errno;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_create)
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_create);
 struct rte_graph_cluster_stats *
 rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 {
@@ -454,7 +454,7 @@ rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_destroy)
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_destroy);
 void
 rte_graph_cluster_stats_destroy(struct rte_graph_cluster_stats *stat)
 {
@@ -530,7 +530,7 @@ cluster_node_store_prev_stats(struct cluster_node *cluster)
 	stat->prev_cycles = stat->cycles;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_get)
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_get);
 void
 rte_graph_cluster_stats_get(struct rte_graph_cluster_stats *stat, bool skip_cb)
 {
@@ -552,7 +552,7 @@ rte_graph_cluster_stats_get(struct rte_graph_cluster_stats *stat, bool skip_cb)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_reset)
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_reset);
 void
 rte_graph_cluster_stats_reset(struct rte_graph_cluster_stats *stat)
 {
diff --git a/lib/graph/node.c b/lib/graph/node.c
index cae1c809ed..ee36545b7e 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -102,7 +102,7 @@ node_has_duplicate_entry(const char *name)
 }
 
 /* Public functions */
-RTE_EXPORT_SYMBOL(__rte_node_register)
+RTE_EXPORT_SYMBOL(__rte_node_register);
 rte_node_t
 __rte_node_register(const struct rte_node_register *reg)
 {
@@ -238,7 +238,7 @@ node_clone(struct node *node, const char *name)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_clone)
+RTE_EXPORT_SYMBOL(rte_node_clone);
 rte_node_t
 rte_node_clone(rte_node_t id, const char *name)
 {
@@ -255,7 +255,7 @@ rte_node_clone(rte_node_t id, const char *name)
 	return RTE_NODE_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_from_name)
+RTE_EXPORT_SYMBOL(rte_node_from_name);
 rte_node_t
 rte_node_from_name(const char *name)
 {
@@ -268,7 +268,7 @@ rte_node_from_name(const char *name)
 	return RTE_NODE_ID_INVALID;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_id_to_name)
+RTE_EXPORT_SYMBOL(rte_node_id_to_name);
 char *
 rte_node_id_to_name(rte_node_t id)
 {
@@ -284,7 +284,7 @@ rte_node_id_to_name(rte_node_t id)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_edge_count)
+RTE_EXPORT_SYMBOL(rte_node_edge_count);
 rte_edge_t
 rte_node_edge_count(rte_node_t id)
 {
@@ -354,7 +354,7 @@ edge_update(struct node *node, struct node *prev, rte_edge_t from,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_edge_shrink)
+RTE_EXPORT_SYMBOL(rte_node_edge_shrink);
 rte_edge_t
 rte_node_edge_shrink(rte_node_t id, rte_edge_t size)
 {
@@ -382,7 +382,7 @@ rte_node_edge_shrink(rte_node_t id, rte_edge_t size)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_edge_update)
+RTE_EXPORT_SYMBOL(rte_node_edge_update);
 rte_edge_t
 rte_node_edge_update(rte_node_t id, rte_edge_t from, const char **next_nodes,
 		     uint16_t nb_edges)
@@ -419,7 +419,7 @@ node_copy_edges(struct node *node, char *next_nodes[])
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_edge_get)
+RTE_EXPORT_SYMBOL(rte_node_edge_get);
 rte_node_t
 rte_node_edge_get(rte_node_t id, char *next_nodes[])
 {
@@ -466,21 +466,21 @@ node_scan_dump(FILE *f, rte_node_t id, bool all)
 	return;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_dump)
+RTE_EXPORT_SYMBOL(rte_node_dump);
 void
 rte_node_dump(FILE *f, rte_node_t id)
 {
 	node_scan_dump(f, id, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_node_list_dump)
+RTE_EXPORT_SYMBOL(rte_node_list_dump);
 void
 rte_node_list_dump(FILE *f)
 {
 	node_scan_dump(f, 0, true);
 }
 
-RTE_EXPORT_SYMBOL(rte_node_max_count)
+RTE_EXPORT_SYMBOL(rte_node_max_count);
 rte_node_t
 rte_node_max_count(void)
 {
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index 70f0069bc1..3143b69188 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -114,7 +114,7 @@ __graph_sched_node_enqueue(struct rte_node *node, struct rte_graph *graph)
 	return false;
 }
 
-RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_node_enqueue)
+RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_node_enqueue);
 bool __rte_noinline
 __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
 					      struct rte_graph_rq_head *rq)
@@ -132,7 +132,7 @@ __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
 	return graph != NULL ? __graph_sched_node_enqueue(node, graph) : false;
 }
 
-RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_wq_process)
+RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_wq_process);
 void
 __rte_graph_mcore_dispatch_sched_wq_process(struct rte_graph *graph)
 {
@@ -172,7 +172,7 @@ __rte_graph_mcore_dispatch_sched_wq_process(struct rte_graph *graph)
 	rte_mempool_put_bulk(mp, (void **)wq_nodes, n);
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_node_lcore_affinity_set)
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_node_lcore_affinity_set);
 int
 rte_graph_model_mcore_dispatch_node_lcore_affinity_set(const char *name, unsigned int lcore_id)
 {
diff --git a/lib/graph/rte_graph_worker.c b/lib/graph/rte_graph_worker.c
index 71f8fb44ca..97bc2c2141 100644
--- a/lib/graph/rte_graph_worker.c
+++ b/lib/graph/rte_graph_worker.c
@@ -6,7 +6,7 @@
 #include "rte_graph_worker_common.h"
 #include "graph_private.h"
 
-RTE_EXPORT_SYMBOL(rte_graph_model_is_valid)
+RTE_EXPORT_SYMBOL(rte_graph_model_is_valid);
 bool
 rte_graph_model_is_valid(uint8_t model)
 {
@@ -16,7 +16,7 @@ rte_graph_model_is_valid(uint8_t model)
 	return true;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_worker_model_set)
+RTE_EXPORT_SYMBOL(rte_graph_worker_model_set);
 int
 rte_graph_worker_model_set(uint8_t model)
 {
@@ -32,7 +32,7 @@ rte_graph_worker_model_set(uint8_t model)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_graph_worker_model_get)
+RTE_EXPORT_SYMBOL(rte_graph_worker_model_get);
 uint8_t
 rte_graph_worker_model_get(struct rte_graph *graph)
 {
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..2285bf318e 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -89,7 +89,7 @@ struct gro_ctx {
 	void *tbls[RTE_GRO_TYPE_MAX_NUM];
 };
 
-RTE_EXPORT_SYMBOL(rte_gro_ctx_create)
+RTE_EXPORT_SYMBOL(rte_gro_ctx_create);
 void *
 rte_gro_ctx_create(const struct rte_gro_param *param)
 {
@@ -131,7 +131,7 @@ rte_gro_ctx_create(const struct rte_gro_param *param)
 	return gro_ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_gro_ctx_destroy)
+RTE_EXPORT_SYMBOL(rte_gro_ctx_destroy);
 void
 rte_gro_ctx_destroy(void *ctx)
 {
@@ -151,7 +151,7 @@ rte_gro_ctx_destroy(void *ctx)
 	rte_free(gro_ctx);
 }
 
-RTE_EXPORT_SYMBOL(rte_gro_reassemble_burst)
+RTE_EXPORT_SYMBOL(rte_gro_reassemble_burst);
 uint16_t
 rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 		uint16_t nb_pkts,
@@ -352,7 +352,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 	return nb_after_gro;
 }
 
-RTE_EXPORT_SYMBOL(rte_gro_reassemble)
+RTE_EXPORT_SYMBOL(rte_gro_reassemble);
 uint16_t
 rte_gro_reassemble(struct rte_mbuf **pkts,
 		uint16_t nb_pkts,
@@ -421,7 +421,7 @@ rte_gro_reassemble(struct rte_mbuf **pkts,
 	return unprocess_num;
 }
 
-RTE_EXPORT_SYMBOL(rte_gro_timeout_flush)
+RTE_EXPORT_SYMBOL(rte_gro_timeout_flush);
 uint16_t
 rte_gro_timeout_flush(void *ctx,
 		uint64_t timeout_cycles,
@@ -480,7 +480,7 @@ rte_gro_timeout_flush(void *ctx,
 	return num;
 }
 
-RTE_EXPORT_SYMBOL(rte_gro_get_pkt_count)
+RTE_EXPORT_SYMBOL(rte_gro_get_pkt_count);
 uint64_t
 rte_gro_get_pkt_count(void *ctx)
 {
diff --git a/lib/gso/rte_gso.c b/lib/gso/rte_gso.c
index cbf7365702..712221e3d3 100644
--- a/lib/gso/rte_gso.c
+++ b/lib/gso/rte_gso.c
@@ -25,7 +25,7 @@
 		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO)) == 0) || \
 		(ctx)->gso_size < RTE_GSO_SEG_SIZE_MIN)
 
-RTE_EXPORT_SYMBOL(rte_gso_segment)
+RTE_EXPORT_SYMBOL(rte_gso_segment);
 int
 rte_gso_segment(struct rte_mbuf *pkt,
 		const struct rte_gso_ctx *gso_ctx,
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..94db7d8fa4 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -77,7 +77,7 @@ struct __rte_hash_rcu_dq_entry {
 	uint32_t ext_bkt_idx;
 };
 
-RTE_EXPORT_SYMBOL(rte_hash_find_existing)
+RTE_EXPORT_SYMBOL(rte_hash_find_existing);
 struct rte_hash *
 rte_hash_find_existing(const char *name)
 {
@@ -110,7 +110,7 @@ rte_hash_get_last_bkt(struct rte_hash_bucket *lst_bkt)
 	return lst_bkt;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_set_cmp_func)
+RTE_EXPORT_SYMBOL(rte_hash_set_cmp_func);
 void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
 {
 	h->cmp_jump_table_idx = KEY_CUSTOM;
@@ -156,7 +156,7 @@ get_alt_bucket_index(const struct rte_hash *h,
 	return (cur_bkt_idx ^ sig) & h->bucket_bitmask;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_create)
+RTE_EXPORT_SYMBOL(rte_hash_create);
 struct rte_hash *
 rte_hash_create(const struct rte_hash_parameters *params)
 {
@@ -528,7 +528,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_free)
+RTE_EXPORT_SYMBOL(rte_hash_free);
 void
 rte_hash_free(struct rte_hash *h)
 {
@@ -576,7 +576,7 @@ rte_hash_free(struct rte_hash *h)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_hash)
+RTE_EXPORT_SYMBOL(rte_hash_hash);
 hash_sig_t
 rte_hash_hash(const struct rte_hash *h, const void *key)
 {
@@ -584,7 +584,7 @@ rte_hash_hash(const struct rte_hash *h, const void *key)
 	return h->hash_func(key, h->key_len, h->hash_func_init_val);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_max_key_id)
+RTE_EXPORT_SYMBOL(rte_hash_max_key_id);
 int32_t
 rte_hash_max_key_id(const struct rte_hash *h)
 {
@@ -600,7 +600,7 @@ rte_hash_max_key_id(const struct rte_hash *h)
 		return h->entries;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_count)
+RTE_EXPORT_SYMBOL(rte_hash_count);
 int32_t
 rte_hash_count(const struct rte_hash *h)
 {
@@ -670,7 +670,7 @@ __hash_rw_reader_unlock(const struct rte_hash *h)
 		rte_rwlock_read_unlock(h->readwrite_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_reset)
+RTE_EXPORT_SYMBOL(rte_hash_reset);
 void
 rte_hash_reset(struct rte_hash *h)
 {
@@ -1254,7 +1254,7 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash)
+RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash);
 int32_t
 rte_hash_add_key_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1263,7 +1263,7 @@ rte_hash_add_key_with_hash(const struct rte_hash *h,
 	return __rte_hash_add_key_with_hash(h, key, sig, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_add_key)
+RTE_EXPORT_SYMBOL(rte_hash_add_key);
 int32_t
 rte_hash_add_key(const struct rte_hash *h, const void *key)
 {
@@ -1271,7 +1271,7 @@ rte_hash_add_key(const struct rte_hash *h, const void *key)
 	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash_data)
+RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash_data);
 int
 rte_hash_add_key_with_hash_data(const struct rte_hash *h,
 			const void *key, hash_sig_t sig, void *data)
@@ -1286,7 +1286,7 @@ rte_hash_add_key_with_hash_data(const struct rte_hash *h,
 		return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_add_key_data)
+RTE_EXPORT_SYMBOL(rte_hash_add_key_data);
 int
 rte_hash_add_key_data(const struct rte_hash *h, const void *key, void *data)
 {
@@ -1480,7 +1480,7 @@ __rte_hash_lookup_with_hash(const struct rte_hash *h, const void *key,
 		return __rte_hash_lookup_with_hash_l(h, key, sig, data);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash);
 int32_t
 rte_hash_lookup_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1489,7 +1489,7 @@ rte_hash_lookup_with_hash(const struct rte_hash *h,
 	return __rte_hash_lookup_with_hash(h, key, sig, NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup)
+RTE_EXPORT_SYMBOL(rte_hash_lookup);
 int32_t
 rte_hash_lookup(const struct rte_hash *h, const void *key)
 {
@@ -1497,7 +1497,7 @@ rte_hash_lookup(const struct rte_hash *h, const void *key)
 	return __rte_hash_lookup_with_hash(h, key, rte_hash_hash(h, key), NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_data)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_data);
 int
 rte_hash_lookup_with_hash_data(const struct rte_hash *h,
 			const void *key, hash_sig_t sig, void **data)
@@ -1506,7 +1506,7 @@ rte_hash_lookup_with_hash_data(const struct rte_hash *h,
 	return __rte_hash_lookup_with_hash(h, key, sig, data);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_data)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_data);
 int
 rte_hash_lookup_data(const struct rte_hash *h, const void *key, void **data)
 {
@@ -1574,7 +1574,7 @@ __hash_rcu_qsbr_free_resource(void *p, void *e, unsigned int n)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_rcu_qsbr_add)
+RTE_EXPORT_SYMBOL(rte_hash_rcu_qsbr_add);
 int
 rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 {
@@ -1870,7 +1870,7 @@ __rte_hash_del_key_with_hash(const struct rte_hash *h, const void *key,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_del_key_with_hash)
+RTE_EXPORT_SYMBOL(rte_hash_del_key_with_hash);
 int32_t
 rte_hash_del_key_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1879,7 +1879,7 @@ rte_hash_del_key_with_hash(const struct rte_hash *h,
 	return __rte_hash_del_key_with_hash(h, key, sig);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_del_key)
+RTE_EXPORT_SYMBOL(rte_hash_del_key);
 int32_t
 rte_hash_del_key(const struct rte_hash *h, const void *key)
 {
@@ -1887,7 +1887,7 @@ rte_hash_del_key(const struct rte_hash *h, const void *key)
 	return __rte_hash_del_key_with_hash(h, key, rte_hash_hash(h, key));
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_get_key_with_position)
+RTE_EXPORT_SYMBOL(rte_hash_get_key_with_position);
 int
 rte_hash_get_key_with_position(const struct rte_hash *h, const int32_t position,
 			       void **key)
@@ -1908,7 +1908,7 @@ rte_hash_get_key_with_position(const struct rte_hash *h, const int32_t position,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_free_key_with_position)
+RTE_EXPORT_SYMBOL(rte_hash_free_key_with_position);
 int
 rte_hash_free_key_with_position(const struct rte_hash *h,
 				const int32_t position)
@@ -2421,7 +2421,7 @@ __rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 					 hit_mask, data);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk);
 int
 rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 		      uint32_t num_keys, int32_t *positions)
@@ -2434,7 +2434,7 @@ rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk_data)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk_data);
 int
 rte_hash_lookup_bulk_data(const struct rte_hash *h, const void **keys,
 		      uint32_t num_keys, uint64_t *hit_mask, void *data[])
@@ -2535,7 +2535,7 @@ __rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 				num_keys, positions, hit_mask, data);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk);
 int
 rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 		hash_sig_t *sig, uint32_t num_keys, int32_t *positions)
@@ -2550,7 +2550,7 @@ rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk_data)
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk_data);
 int
 rte_hash_lookup_with_hash_bulk_data(const struct rte_hash *h,
 		const void **keys, hash_sig_t *sig,
@@ -2570,7 +2570,7 @@ rte_hash_lookup_with_hash_bulk_data(const struct rte_hash *h,
 	return rte_popcount64(*hit_mask);
 }
 
-RTE_EXPORT_SYMBOL(rte_hash_iterate)
+RTE_EXPORT_SYMBOL(rte_hash_iterate);
 int32_t
 rte_hash_iterate(const struct rte_hash *h, const void **key, void **data, uint32_t *next)
 {
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 38b15a14d1..c755f29cad 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -42,7 +42,7 @@ EAL_REGISTER_TAILQ(rte_fbk_hash_tailq)
  * @return
  *   pointer to hash table structure or NULL on error.
  */
-RTE_EXPORT_SYMBOL(rte_fbk_hash_find_existing)
+RTE_EXPORT_SYMBOL(rte_fbk_hash_find_existing);
 struct rte_fbk_hash_table *
 rte_fbk_hash_find_existing(const char *name)
 {
@@ -77,7 +77,7 @@ rte_fbk_hash_find_existing(const char *name)
  *   Pointer to hash table structure that is used in future hash table
  *   operations, or NULL on error.
  */
-RTE_EXPORT_SYMBOL(rte_fbk_hash_create)
+RTE_EXPORT_SYMBOL(rte_fbk_hash_create);
 struct rte_fbk_hash_table *
 rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 {
@@ -180,7 +180,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
  * @param ht
  *   Hash table to deallocate.
  */
-RTE_EXPORT_SYMBOL(rte_fbk_hash_free)
+RTE_EXPORT_SYMBOL(rte_fbk_hash_free);
 void
 rte_fbk_hash_free(struct rte_fbk_hash_table *ht)
 {
diff --git a/lib/hash/rte_hash_crc.c b/lib/hash/rte_hash_crc.c
index 9fe90d6425..21535e8916 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -13,7 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_crc_logtype, crc, INFO);
 #define HASH_CRC_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH_CRC, "" __VA_ARGS__)
 
-RTE_EXPORT_SYMBOL(rte_hash_crc32_alg)
+RTE_EXPORT_SYMBOL(rte_hash_crc32_alg);
 uint8_t rte_hash_crc32_alg = CRC32_SW;
 
 /**
@@ -28,7 +28,7 @@ uint8_t rte_hash_crc32_alg = CRC32_SW;
  *   - (CRC32_ARM64) Use ARMv8 CRC intrinsic if available (default ARMv8)
  *
  */
-RTE_EXPORT_SYMBOL(rte_hash_crc_set_alg)
+RTE_EXPORT_SYMBOL(rte_hash_crc_set_alg);
 void
 rte_hash_crc_set_alg(uint8_t alg)
 {
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 0f9ed20d0d..a033196341 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -71,7 +71,7 @@ struct rte_thash_ctx {
 	uint8_t		hash_key[];
 };
 
-RTE_EXPORT_SYMBOL(rte_thash_gfni_supported)
+RTE_EXPORT_SYMBOL(rte_thash_gfni_supported);
 int
 rte_thash_gfni_supported(void)
 {
@@ -85,7 +85,7 @@ rte_thash_gfni_supported(void)
 	return 0;
 };
 
-RTE_EXPORT_SYMBOL(rte_thash_complete_matrix)
+RTE_EXPORT_SYMBOL(rte_thash_complete_matrix);
 void
 rte_thash_complete_matrix(uint64_t *matrixes, const uint8_t *rss_key, int size)
 {
@@ -206,7 +206,7 @@ free_lfsr(struct thash_lfsr *lfsr)
 		rte_free(lfsr);
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_init_ctx)
+RTE_EXPORT_SYMBOL(rte_thash_init_ctx);
 struct rte_thash_ctx *
 rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	uint8_t *key, uint32_t flags)
@@ -297,7 +297,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_find_existing)
+RTE_EXPORT_SYMBOL(rte_thash_find_existing);
 struct rte_thash_ctx *
 rte_thash_find_existing(const char *name)
 {
@@ -324,7 +324,7 @@ rte_thash_find_existing(const char *name)
 	return ctx;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_free_ctx)
+RTE_EXPORT_SYMBOL(rte_thash_free_ctx);
 void
 rte_thash_free_ctx(struct rte_thash_ctx *ctx)
 {
@@ -546,7 +546,7 @@ insert_after(struct rte_thash_ctx *ctx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_add_helper)
+RTE_EXPORT_SYMBOL(rte_thash_add_helper);
 int
 rte_thash_add_helper(struct rte_thash_ctx *ctx, const char *name, uint32_t len,
 	uint32_t offset)
@@ -637,7 +637,7 @@ rte_thash_add_helper(struct rte_thash_ctx *ctx, const char *name, uint32_t len,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_get_helper)
+RTE_EXPORT_SYMBOL(rte_thash_get_helper);
 struct rte_thash_subtuple_helper *
 rte_thash_get_helper(struct rte_thash_ctx *ctx, const char *name)
 {
@@ -654,7 +654,7 @@ rte_thash_get_helper(struct rte_thash_ctx *ctx, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_get_complement)
+RTE_EXPORT_SYMBOL(rte_thash_get_complement);
 uint32_t
 rte_thash_get_complement(struct rte_thash_subtuple_helper *h,
 	uint32_t hash, uint32_t desired_hash)
@@ -662,14 +662,14 @@ rte_thash_get_complement(struct rte_thash_subtuple_helper *h,
 	return h->compl_table[(hash ^ desired_hash) & h->lsb_msk];
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_get_key)
+RTE_EXPORT_SYMBOL(rte_thash_get_key);
 const uint8_t *
 rte_thash_get_key(struct rte_thash_ctx *ctx)
 {
 	return ctx->hash_key;
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_get_gfni_matrices)
+RTE_EXPORT_SYMBOL(rte_thash_get_gfni_matrices);
 const uint64_t *
 rte_thash_get_gfni_matrices(struct rte_thash_ctx *ctx)
 {
@@ -765,7 +765,7 @@ write_unaligned_bits(uint8_t *ptr, int len, int offset, uint32_t val)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_thash_adjust_tuple)
+RTE_EXPORT_SYMBOL(rte_thash_adjust_tuple);
 int
 rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	struct rte_thash_subtuple_helper *h,
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index ee9aa93027..b004302468 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -15,7 +15,7 @@ RTE_LOG_REGISTER_DEFAULT(ipfrag_logtype, INFO);
 #define	IP_FRAG_HASH_FNUM	2
 
 /* free mbufs from death row */
-RTE_EXPORT_SYMBOL(rte_ip_frag_free_death_row)
+RTE_EXPORT_SYMBOL(rte_ip_frag_free_death_row);
 void
 rte_ip_frag_free_death_row(struct rte_ip_frag_death_row *dr,
 		uint32_t prefetch)
@@ -40,7 +40,7 @@ rte_ip_frag_free_death_row(struct rte_ip_frag_death_row *dr,
 }
 
 /* create fragmentation table */
-RTE_EXPORT_SYMBOL(rte_ip_frag_table_create)
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_create);
 struct rte_ip_frag_tbl *
 rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 	uint32_t max_entries, uint64_t max_cycles, int socket_id)
@@ -85,7 +85,7 @@ rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 }
 
 /* delete fragmentation table */
-RTE_EXPORT_SYMBOL(rte_ip_frag_table_destroy)
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_destroy);
 void
 rte_ip_frag_table_destroy(struct rte_ip_frag_tbl *tbl)
 {
@@ -99,7 +99,7 @@ rte_ip_frag_table_destroy(struct rte_ip_frag_tbl *tbl)
 }
 
 /* dump frag table statistics to file */
-RTE_EXPORT_SYMBOL(rte_ip_frag_table_statistics_dump)
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_statistics_dump);
 void
 rte_ip_frag_table_statistics_dump(FILE *f, const struct rte_ip_frag_tbl *tbl)
 {
@@ -129,7 +129,7 @@ rte_ip_frag_table_statistics_dump(FILE *f, const struct rte_ip_frag_tbl *tbl)
 }
 
 /* Delete expired fragments */
-RTE_EXPORT_SYMBOL(rte_ip_frag_table_del_expired_entries)
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_del_expired_entries);
 void
 rte_ip_frag_table_del_expired_entries(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, uint64_t tms)
diff --git a/lib/ip_frag/rte_ipv4_fragmentation.c b/lib/ip_frag/rte_ipv4_fragmentation.c
index 435a6e13bb..065e49780f 100644
--- a/lib/ip_frag/rte_ipv4_fragmentation.c
+++ b/lib/ip_frag/rte_ipv4_fragmentation.c
@@ -105,7 +105,7 @@ static inline uint16_t __create_ipopt_frag_hdr(uint8_t *iph,
  *   in the pkts_out array.
  *   Otherwise - (-1) * <errno>.
  */
-RTE_EXPORT_SYMBOL(rte_ipv4_fragment_packet)
+RTE_EXPORT_SYMBOL(rte_ipv4_fragment_packet);
 int32_t
 rte_ipv4_fragment_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
@@ -288,7 +288,7 @@ rte_ipv4_fragment_packet(struct rte_mbuf *pkt_in,
  *   in the pkts_out array.
  *   Otherwise - (-1) * errno.
  */
-RTE_EXPORT_SYMBOL(rte_ipv4_fragment_copy_nonseg_packet)
+RTE_EXPORT_SYMBOL(rte_ipv4_fragment_copy_nonseg_packet);
 int32_t
 rte_ipv4_fragment_copy_nonseg_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_reassembly.c
index 3c8ae113ba..fca05ddc9e 100644
--- a/lib/ip_frag/rte_ipv4_reassembly.c
+++ b/lib/ip_frag/rte_ipv4_reassembly.c
@@ -95,7 +95,7 @@ ipv4_frag_reassemble(struct ip_frag_pkt *fp)
  *   - an error occurred.
  *   - not all fragments of the packet are collected yet.
  */
-RTE_EXPORT_SYMBOL(rte_ipv4_frag_reassemble_packet)
+RTE_EXPORT_SYMBOL(rte_ipv4_frag_reassemble_packet);
 struct rte_mbuf *
 rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, struct rte_mbuf *mb, uint64_t tms,
diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index c81f2402e3..573732f596 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -64,7 +64,7 @@ __free_fragments(struct rte_mbuf *mb[], uint32_t num)
  *   in the pkts_out array.
  *   Otherwise - (-1) * <errno>.
  */
-RTE_EXPORT_SYMBOL(rte_ipv6_fragment_packet)
+RTE_EXPORT_SYMBOL(rte_ipv6_fragment_packet);
 int32_t
 rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 0e809a01e5..ca37d03dee 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -133,7 +133,7 @@ ipv6_frag_reassemble(struct ip_frag_pkt *fp)
  */
 #define MORE_FRAGS(x) (((x) & 0x100) >> 8)
 #define FRAG_OFFSET(x) (rte_cpu_to_be_16(x) >> 3)
-RTE_EXPORT_SYMBOL(rte_ipv6_frag_reassemble_packet)
+RTE_EXPORT_SYMBOL(rte_ipv6_frag_reassemble_packet);
 struct rte_mbuf *
 rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, struct rte_mbuf *mb, uint64_t tms,
diff --git a/lib/ipsec/ipsec_sad.c b/lib/ipsec/ipsec_sad.c
index 15ea868f77..fe5d25a94f 100644
--- a/lib/ipsec/ipsec_sad.c
+++ b/lib/ipsec/ipsec_sad.c
@@ -114,7 +114,7 @@ add_specific(struct rte_ipsec_sad *sad, const void *key,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_add)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_add);
 int
 rte_ipsec_sad_add(struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *key,
@@ -214,7 +214,7 @@ del_specific(struct rte_ipsec_sad *sad, const void *key, int key_type)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_del)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_del);
 int
 rte_ipsec_sad_del(struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *key,
@@ -254,7 +254,7 @@ rte_ipsec_sad_del(struct rte_ipsec_sad *sad,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_create)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_create);
 struct rte_ipsec_sad *
 rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 {
@@ -384,7 +384,7 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 	return sad;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_find_existing)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_find_existing);
 struct rte_ipsec_sad *
 rte_ipsec_sad_find_existing(const char *name)
 {
@@ -419,7 +419,7 @@ rte_ipsec_sad_find_existing(const char *name)
 	return sad;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_destroy)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_destroy);
 void
 rte_ipsec_sad_destroy(struct rte_ipsec_sad *sad)
 {
@@ -542,7 +542,7 @@ __ipsec_sad_lookup(const struct rte_ipsec_sad *sad,
 	return found;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sad_lookup)
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_lookup);
 int
 rte_ipsec_sad_lookup(const struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *keys[], void *sa[], uint32_t n)
diff --git a/lib/ipsec/ipsec_telemetry.c b/lib/ipsec/ipsec_telemetry.c
index a9b6f05270..4cff0e2438 100644
--- a/lib/ipsec/ipsec_telemetry.c
+++ b/lib/ipsec/ipsec_telemetry.c
@@ -205,7 +205,7 @@ handle_telemetry_cmd_ipsec_sa_details(const char *cmd __rte_unused,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_add)
+RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_add);
 int
 rte_ipsec_telemetry_sa_add(const struct rte_ipsec_sa *sa)
 {
@@ -218,7 +218,7 @@ rte_ipsec_telemetry_sa_add(const struct rte_ipsec_sa *sa)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_del)
+RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_del);
 void
 rte_ipsec_telemetry_sa_del(const struct rte_ipsec_sa *sa)
 {
diff --git a/lib/ipsec/sa.c b/lib/ipsec/sa.c
index 4f589f3f3f..a03e106bb1 100644
--- a/lib/ipsec/sa.c
+++ b/lib/ipsec/sa.c
@@ -85,7 +85,7 @@ fill_crypto_xform(struct crypto_xform *xform, uint64_t type,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sa_type)
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_type);
 uint64_t
 rte_ipsec_sa_type(const struct rte_ipsec_sa *sa)
 {
@@ -158,7 +158,7 @@ ipsec_sa_size(uint64_t type, uint32_t *wnd_sz, uint32_t *nb_bucket)
 	return sz;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sa_fini)
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_fini);
 void
 rte_ipsec_sa_fini(struct rte_ipsec_sa *sa)
 {
@@ -528,7 +528,7 @@ fill_sa_replay(struct rte_ipsec_sa *sa, uint32_t wnd_sz, uint32_t nb_bucket,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sa_size)
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_size);
 int
 rte_ipsec_sa_size(const struct rte_ipsec_sa_prm *prm)
 {
@@ -549,7 +549,7 @@ rte_ipsec_sa_size(const struct rte_ipsec_sa_prm *prm)
 	return ipsec_sa_size(type, &wsz, &nb);
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_sa_init)
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_init);
 int
 rte_ipsec_sa_init(struct rte_ipsec_sa *sa, const struct rte_ipsec_sa_prm *prm,
 	uint32_t size)
diff --git a/lib/ipsec/ses.c b/lib/ipsec/ses.c
index 224e752d05..7b137ca9b6 100644
--- a/lib/ipsec/ses.c
+++ b/lib/ipsec/ses.c
@@ -29,7 +29,7 @@ session_check(struct rte_ipsec_session *ss)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ipsec_session_prepare)
+RTE_EXPORT_SYMBOL(rte_ipsec_session_prepare);
 int
 rte_ipsec_session_prepare(struct rte_ipsec_session *ss)
 {
diff --git a/lib/jobstats/rte_jobstats.c b/lib/jobstats/rte_jobstats.c
index 20a4f1391a..4729316e08 100644
--- a/lib/jobstats/rte_jobstats.c
+++ b/lib/jobstats/rte_jobstats.c
@@ -64,7 +64,7 @@ default_update_function(struct rte_jobstats *job, int64_t result)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_context_init)
+RTE_EXPORT_SYMBOL(rte_jobstats_context_init);
 int
 rte_jobstats_context_init(struct rte_jobstats_context *ctx)
 {
@@ -79,7 +79,7 @@ rte_jobstats_context_init(struct rte_jobstats_context *ctx)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_context_start)
+RTE_EXPORT_SYMBOL(rte_jobstats_context_start);
 void
 rte_jobstats_context_start(struct rte_jobstats_context *ctx)
 {
@@ -92,7 +92,7 @@ rte_jobstats_context_start(struct rte_jobstats_context *ctx)
 	ctx->state_time = now;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_context_finish)
+RTE_EXPORT_SYMBOL(rte_jobstats_context_finish);
 void
 rte_jobstats_context_finish(struct rte_jobstats_context *ctx)
 {
@@ -106,7 +106,7 @@ rte_jobstats_context_finish(struct rte_jobstats_context *ctx)
 	ctx->state_time = now;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_context_reset)
+RTE_EXPORT_SYMBOL(rte_jobstats_context_reset);
 void
 rte_jobstats_context_reset(struct rte_jobstats_context *ctx)
 {
@@ -118,14 +118,14 @@ rte_jobstats_context_reset(struct rte_jobstats_context *ctx)
 	ctx->loop_cnt = 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_set_target)
+RTE_EXPORT_SYMBOL(rte_jobstats_set_target);
 void
 rte_jobstats_set_target(struct rte_jobstats *job, int64_t target)
 {
 	job->target = target;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_start)
+RTE_EXPORT_SYMBOL(rte_jobstats_start);
 int
 rte_jobstats_start(struct rte_jobstats_context *ctx, struct rte_jobstats *job)
 {
@@ -145,7 +145,7 @@ rte_jobstats_start(struct rte_jobstats_context *ctx, struct rte_jobstats *job)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_abort)
+RTE_EXPORT_SYMBOL(rte_jobstats_abort);
 int
 rte_jobstats_abort(struct rte_jobstats *job)
 {
@@ -166,7 +166,7 @@ rte_jobstats_abort(struct rte_jobstats *job)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_finish)
+RTE_EXPORT_SYMBOL(rte_jobstats_finish);
 int
 rte_jobstats_finish(struct rte_jobstats *job, int64_t job_value)
 {
@@ -203,7 +203,7 @@ rte_jobstats_finish(struct rte_jobstats *job, int64_t job_value)
 	return need_update;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_set_period)
+RTE_EXPORT_SYMBOL(rte_jobstats_set_period);
 void
 rte_jobstats_set_period(struct rte_jobstats *job, uint64_t period,
 		uint8_t saturate)
@@ -218,7 +218,7 @@ rte_jobstats_set_period(struct rte_jobstats *job, uint64_t period,
 	job->period = period;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_set_min)
+RTE_EXPORT_SYMBOL(rte_jobstats_set_min);
 void
 rte_jobstats_set_min(struct rte_jobstats *job, uint64_t period)
 {
@@ -227,7 +227,7 @@ rte_jobstats_set_min(struct rte_jobstats *job, uint64_t period)
 		job->period = period;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_set_max)
+RTE_EXPORT_SYMBOL(rte_jobstats_set_max);
 void
 rte_jobstats_set_max(struct rte_jobstats *job, uint64_t period)
 {
@@ -236,7 +236,7 @@ rte_jobstats_set_max(struct rte_jobstats *job, uint64_t period)
 		job->period = period;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_init)
+RTE_EXPORT_SYMBOL(rte_jobstats_init);
 int
 rte_jobstats_init(struct rte_jobstats *job, const char *name,
 		uint64_t min_period, uint64_t max_period, uint64_t initial_period,
@@ -257,7 +257,7 @@ rte_jobstats_init(struct rte_jobstats *job, const char *name,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_set_update_period_function)
+RTE_EXPORT_SYMBOL(rte_jobstats_set_update_period_function);
 void
 rte_jobstats_set_update_period_function(struct rte_jobstats *job,
 		rte_job_update_period_cb_t update_period_cb)
@@ -268,7 +268,7 @@ rte_jobstats_set_update_period_function(struct rte_jobstats *job,
 	job->update_period_cb = update_period_cb;
 }
 
-RTE_EXPORT_SYMBOL(rte_jobstats_reset)
+RTE_EXPORT_SYMBOL(rte_jobstats_reset);
 void
 rte_jobstats_reset(struct rte_jobstats *job)
 {
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 4e3198b33f..d1aa30b96f 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -152,7 +152,7 @@ check_for_valid_keys(struct rte_kvargs *kvlist,
  * E.g. given a list = { rx = 0, rx = 1, tx = 2 } the number of args for
  * arg "rx" will be 2.
  */
-RTE_EXPORT_SYMBOL(rte_kvargs_count)
+RTE_EXPORT_SYMBOL(rte_kvargs_count);
 unsigned
 rte_kvargs_count(const struct rte_kvargs *kvlist, const char *key_match)
 {
@@ -195,7 +195,7 @@ kvargs_process_common(const struct rte_kvargs *kvlist, const char *key_match,
 /*
  * For each matching key in key=value, call the given handler function.
  */
-RTE_EXPORT_SYMBOL(rte_kvargs_process)
+RTE_EXPORT_SYMBOL(rte_kvargs_process);
 int
 rte_kvargs_process(const struct rte_kvargs *kvlist, const char *key_match, arg_handler_t handler,
 		   void *opaque_arg)
@@ -206,7 +206,7 @@ rte_kvargs_process(const struct rte_kvargs *kvlist, const char *key_match, arg_h
 /*
  * For each matching key in key=value or only-key, call the given handler function.
  */
-RTE_EXPORT_SYMBOL(rte_kvargs_process_opt)
+RTE_EXPORT_SYMBOL(rte_kvargs_process_opt);
 int
 rte_kvargs_process_opt(const struct rte_kvargs *kvlist, const char *key_match,
 		       arg_handler_t handler, void *opaque_arg)
@@ -215,7 +215,7 @@ rte_kvargs_process_opt(const struct rte_kvargs *kvlist, const char *key_match,
 }
 
 /* free the rte_kvargs structure */
-RTE_EXPORT_SYMBOL(rte_kvargs_free)
+RTE_EXPORT_SYMBOL(rte_kvargs_free);
 void
 rte_kvargs_free(struct rte_kvargs *kvlist)
 {
@@ -227,7 +227,7 @@ rte_kvargs_free(struct rte_kvargs *kvlist)
 }
 
 /* Lookup a value in an rte_kvargs list by its key and value. */
-RTE_EXPORT_SYMBOL(rte_kvargs_get_with_value)
+RTE_EXPORT_SYMBOL(rte_kvargs_get_with_value);
 const char *
 rte_kvargs_get_with_value(const struct rte_kvargs *kvlist, const char *key,
 			  const char *value)
@@ -247,7 +247,7 @@ rte_kvargs_get_with_value(const struct rte_kvargs *kvlist, const char *key,
 }
 
 /* Lookup a value in an rte_kvargs list by its key. */
-RTE_EXPORT_SYMBOL(rte_kvargs_get)
+RTE_EXPORT_SYMBOL(rte_kvargs_get);
 const char *
 rte_kvargs_get(const struct rte_kvargs *kvlist, const char *key)
 {
@@ -261,7 +261,7 @@ rte_kvargs_get(const struct rte_kvargs *kvlist, const char *key)
  * an allocated structure that contains a key/value list. Also
  * check if only valid keys were used.
  */
-RTE_EXPORT_SYMBOL(rte_kvargs_parse)
+RTE_EXPORT_SYMBOL(rte_kvargs_parse);
 struct rte_kvargs *
 rte_kvargs_parse(const char *args, const char * const valid_keys[])
 {
@@ -285,7 +285,7 @@ rte_kvargs_parse(const char *args, const char * const valid_keys[])
 	return kvlist;
 }
 
-RTE_EXPORT_SYMBOL(rte_kvargs_parse_delim)
+RTE_EXPORT_SYMBOL(rte_kvargs_parse_delim);
 struct rte_kvargs *
 rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
 		       const char *valid_ends)
diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..5437258219 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -116,7 +116,7 @@ latencystats_collect(uint64_t values[])
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_latencystats_update)
+RTE_EXPORT_SYMBOL(rte_latencystats_update);
 int32_t
 rte_latencystats_update(void)
 {
@@ -256,7 +256,7 @@ calc_latency(uint16_t pid __rte_unused,
 	return nb_pkts;
 }
 
-RTE_EXPORT_SYMBOL(rte_latencystats_init)
+RTE_EXPORT_SYMBOL(rte_latencystats_init);
 int
 rte_latencystats_init(uint64_t app_samp_intvl,
 		rte_latency_stats_flow_type_fn user_cb)
@@ -349,7 +349,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_latencystats_uninit)
+RTE_EXPORT_SYMBOL(rte_latencystats_uninit);
 int
 rte_latencystats_uninit(void)
 {
@@ -396,7 +396,7 @@ rte_latencystats_uninit(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_latencystats_get_names)
+RTE_EXPORT_SYMBOL(rte_latencystats_get_names);
 int
 rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 {
@@ -412,7 +412,7 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 	return NUM_LATENCY_STATS;
 }
 
-RTE_EXPORT_SYMBOL(rte_latencystats_get)
+RTE_EXPORT_SYMBOL(rte_latencystats_get);
 int
 rte_latencystats_get(struct rte_metric_value *values, uint16_t size)
 {
diff --git a/lib/log/log.c b/lib/log/log.c
index 8ad5250a13..6909bc7f9e 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -79,7 +79,7 @@ struct log_cur_msg {
 static RTE_DEFINE_PER_LCORE(struct log_cur_msg, log_cur_msg);
 
 /* Change the stream that will be used by logging system */
-RTE_EXPORT_SYMBOL(rte_openlog_stream)
+RTE_EXPORT_SYMBOL(rte_openlog_stream);
 int
 rte_openlog_stream(FILE *f)
 {
@@ -91,7 +91,7 @@ rte_openlog_stream(FILE *f)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_log_get_stream)
+RTE_EXPORT_SYMBOL(rte_log_get_stream);
 FILE *
 rte_log_get_stream(void)
 {
@@ -101,7 +101,7 @@ rte_log_get_stream(void)
 }
 
 /* Set global log level */
-RTE_EXPORT_SYMBOL(rte_log_set_global_level)
+RTE_EXPORT_SYMBOL(rte_log_set_global_level);
 void
 rte_log_set_global_level(uint32_t level)
 {
@@ -109,14 +109,14 @@ rte_log_set_global_level(uint32_t level)
 }
 
 /* Get global log level */
-RTE_EXPORT_SYMBOL(rte_log_get_global_level)
+RTE_EXPORT_SYMBOL(rte_log_get_global_level);
 uint32_t
 rte_log_get_global_level(void)
 {
 	return rte_logs.level;
 }
 
-RTE_EXPORT_SYMBOL(rte_log_get_level)
+RTE_EXPORT_SYMBOL(rte_log_get_level);
 int
 rte_log_get_level(uint32_t type)
 {
@@ -126,7 +126,7 @@ rte_log_get_level(uint32_t type)
 	return rte_logs.dynamic_types[type].loglevel;
 }
 
-RTE_EXPORT_SYMBOL(rte_log_can_log)
+RTE_EXPORT_SYMBOL(rte_log_can_log);
 bool
 rte_log_can_log(uint32_t logtype, uint32_t level)
 {
@@ -160,7 +160,7 @@ logtype_set_level(uint32_t type, uint32_t level)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_log_set_level)
+RTE_EXPORT_SYMBOL(rte_log_set_level);
 int
 rte_log_set_level(uint32_t type, uint32_t level)
 {
@@ -175,7 +175,7 @@ rte_log_set_level(uint32_t type, uint32_t level)
 }
 
 /* set log level by regular expression */
-RTE_EXPORT_SYMBOL(rte_log_set_level_regexp)
+RTE_EXPORT_SYMBOL(rte_log_set_level_regexp);
 int
 rte_log_set_level_regexp(const char *regex, uint32_t level)
 {
@@ -242,7 +242,7 @@ eal_log_save_regexp(const char *regex, uint32_t level)
 }
 
 /* set log level based on globbing pattern */
-RTE_EXPORT_SYMBOL(rte_log_set_level_pattern)
+RTE_EXPORT_SYMBOL(rte_log_set_level_pattern);
 int
 rte_log_set_level_pattern(const char *pattern, uint32_t level)
 {
@@ -270,14 +270,14 @@ eal_log_save_pattern(const char *pattern, uint32_t level)
 }
 
 /* get the current loglevel for the message being processed */
-RTE_EXPORT_SYMBOL(rte_log_cur_msg_loglevel)
+RTE_EXPORT_SYMBOL(rte_log_cur_msg_loglevel);
 int rte_log_cur_msg_loglevel(void)
 {
 	return RTE_PER_LCORE(log_cur_msg).loglevel;
 }
 
 /* get the current logtype for the message being processed */
-RTE_EXPORT_SYMBOL(rte_log_cur_msg_logtype)
+RTE_EXPORT_SYMBOL(rte_log_cur_msg_logtype);
 int rte_log_cur_msg_logtype(void)
 {
 	return RTE_PER_LCORE(log_cur_msg).logtype;
@@ -329,7 +329,7 @@ log_register(const char *name, uint32_t level)
 }
 
 /* register an extended log type */
-RTE_EXPORT_SYMBOL(rte_log_register)
+RTE_EXPORT_SYMBOL(rte_log_register);
 int
 rte_log_register(const char *name)
 {
@@ -337,7 +337,7 @@ rte_log_register(const char *name)
 }
 
 /* Register an extended log type and try to pick its level from EAL options */
-RTE_EXPORT_SYMBOL(rte_log_register_type_and_pick_level)
+RTE_EXPORT_SYMBOL(rte_log_register_type_and_pick_level);
 int
 rte_log_register_type_and_pick_level(const char *name, uint32_t level_def)
 {
@@ -434,7 +434,7 @@ log_type_compare(const void *a, const void *b)
 }
 
 /* Dump name of each logtype, one per line. */
-RTE_EXPORT_SYMBOL(rte_log_list_types)
+RTE_EXPORT_SYMBOL(rte_log_list_types);
 void
 rte_log_list_types(FILE *out, const char *prefix)
 {
@@ -464,7 +464,7 @@ rte_log_list_types(FILE *out, const char *prefix)
 }
 
 /* dump global level and registered log types */
-RTE_EXPORT_SYMBOL(rte_log_dump)
+RTE_EXPORT_SYMBOL(rte_log_dump);
 void
 rte_log_dump(FILE *f)
 {
@@ -486,7 +486,7 @@ rte_log_dump(FILE *f)
  * Generates a log message The message will be sent in the stream
  * defined by the previous call to rte_openlog_stream().
  */
-RTE_EXPORT_SYMBOL(rte_vlog)
+RTE_EXPORT_SYMBOL(rte_vlog);
 int
 rte_vlog(uint32_t level, uint32_t logtype, const char *format, va_list ap)
 {
@@ -512,7 +512,7 @@ rte_vlog(uint32_t level, uint32_t logtype, const char *format, va_list ap)
  * defined by the previous call to rte_openlog_stream().
  * No need to check level here, done by rte_vlog().
  */
-RTE_EXPORT_SYMBOL(rte_log)
+RTE_EXPORT_SYMBOL(rte_log);
 int
 rte_log(uint32_t level, uint32_t logtype, const char *format, ...)
 {
diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..440deebe7d 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -118,7 +118,7 @@ depth_to_range(uint8_t depth)
 /*
  * Find an existing lpm table and return a pointer to it.
  */
-RTE_EXPORT_SYMBOL(rte_lpm_find_existing)
+RTE_EXPORT_SYMBOL(rte_lpm_find_existing);
 struct rte_lpm *
 rte_lpm_find_existing(const char *name)
 {
@@ -147,7 +147,7 @@ rte_lpm_find_existing(const char *name)
 /*
  * Allocates memory for LPM object
  */
-RTE_EXPORT_SYMBOL(rte_lpm_create)
+RTE_EXPORT_SYMBOL(rte_lpm_create);
 struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
 		const struct rte_lpm_config *config)
@@ -254,7 +254,7 @@ rte_lpm_create(const char *name, int socket_id,
 /*
  * Deallocates memory for given LPM table.
  */
-RTE_EXPORT_SYMBOL(rte_lpm_free)
+RTE_EXPORT_SYMBOL(rte_lpm_free);
 void
 rte_lpm_free(struct rte_lpm *lpm)
 {
@@ -304,7 +304,7 @@ __lpm_rcu_qsbr_free_resource(void *p, void *data, unsigned int n)
 
 /* Associate QSBR variable with an LPM object.
  */
-RTE_EXPORT_SYMBOL(rte_lpm_rcu_qsbr_add)
+RTE_EXPORT_SYMBOL(rte_lpm_rcu_qsbr_add);
 int
 rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 {
@@ -823,7 +823,7 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 /*
  * Add a route
  */
-RTE_EXPORT_SYMBOL(rte_lpm_add)
+RTE_EXPORT_SYMBOL(rte_lpm_add);
 int
 rte_lpm_add(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 		uint32_t next_hop)
@@ -875,7 +875,7 @@ rte_lpm_add(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 /*
  * Look for a rule in the high-level rules table
  */
-RTE_EXPORT_SYMBOL(rte_lpm_is_rule_present)
+RTE_EXPORT_SYMBOL(rte_lpm_is_rule_present);
 int
 rte_lpm_is_rule_present(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 uint32_t *next_hop)
@@ -1181,7 +1181,7 @@ delete_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 /*
  * Deletes a rule
  */
-RTE_EXPORT_SYMBOL(rte_lpm_delete)
+RTE_EXPORT_SYMBOL(rte_lpm_delete);
 int
 rte_lpm_delete(struct rte_lpm *lpm, uint32_t ip, uint8_t depth)
 {
@@ -1240,7 +1240,7 @@ rte_lpm_delete(struct rte_lpm *lpm, uint32_t ip, uint8_t depth)
 /*
  * Delete all rules from the LPM table.
  */
-RTE_EXPORT_SYMBOL(rte_lpm_delete_all)
+RTE_EXPORT_SYMBOL(rte_lpm_delete_all);
 void
 rte_lpm_delete_all(struct rte_lpm *lpm)
 {
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..38e8247067 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -208,7 +208,7 @@ rebuild_lpm(struct rte_lpm6 *lpm)
 /*
  * Allocates memory for LPM object
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_create)
+RTE_EXPORT_SYMBOL(rte_lpm6_create);
 struct rte_lpm6 *
 rte_lpm6_create(const char *name, int socket_id,
 		const struct rte_lpm6_config *config)
@@ -349,7 +349,7 @@ rte_lpm6_create(const char *name, int socket_id,
 /*
  * Find an existing lpm table and return a pointer to it.
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_find_existing)
+RTE_EXPORT_SYMBOL(rte_lpm6_find_existing);
 struct rte_lpm6 *
 rte_lpm6_find_existing(const char *name)
 {
@@ -378,7 +378,7 @@ rte_lpm6_find_existing(const char *name)
 /*
  * Deallocates memory for given LPM table.
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_free)
+RTE_EXPORT_SYMBOL(rte_lpm6_free);
 void
 rte_lpm6_free(struct rte_lpm6 *lpm)
 {
@@ -823,7 +823,7 @@ simulate_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *masked_ip, uint8_
 /*
  * Add a route
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_add)
+RTE_EXPORT_SYMBOL(rte_lpm6_add);
 int
 rte_lpm6_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
 	     uint32_t next_hop)
@@ -913,7 +913,7 @@ lookup_step(const struct rte_lpm6 *lpm, const struct rte_lpm6_tbl_entry *tbl,
 /*
  * Looks up an IP
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_lookup)
+RTE_EXPORT_SYMBOL(rte_lpm6_lookup);
 int
 rte_lpm6_lookup(const struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip,
 		uint32_t *next_hop)
@@ -946,7 +946,7 @@ rte_lpm6_lookup(const struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip,
 /*
  * Looks up a group of IP addresses
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_lookup_bulk_func)
+RTE_EXPORT_SYMBOL(rte_lpm6_lookup_bulk_func);
 int
 rte_lpm6_lookup_bulk_func(const struct rte_lpm6 *lpm,
 		struct rte_ipv6_addr *ips,
@@ -992,7 +992,7 @@ rte_lpm6_lookup_bulk_func(const struct rte_lpm6 *lpm,
 /*
  * Look for a rule in the high-level rules table
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_is_rule_present)
+RTE_EXPORT_SYMBOL(rte_lpm6_is_rule_present);
 int
 rte_lpm6_is_rule_present(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
 			 uint32_t *next_hop)
@@ -1042,7 +1042,7 @@ rule_delete(struct rte_lpm6 *lpm, struct rte_ipv6_addr *ip, uint8_t depth)
  * rather than doing incremental updates like
  * the regular delete function
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_delete_bulk_func)
+RTE_EXPORT_SYMBOL(rte_lpm6_delete_bulk_func);
 int
 rte_lpm6_delete_bulk_func(struct rte_lpm6 *lpm,
 		struct rte_ipv6_addr *ips, uint8_t *depths,
@@ -1082,7 +1082,7 @@ rte_lpm6_delete_bulk_func(struct rte_lpm6 *lpm,
 /*
  * Delete all rules from the LPM table.
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_delete_all)
+RTE_EXPORT_SYMBOL(rte_lpm6_delete_all);
 void
 rte_lpm6_delete_all(struct rte_lpm6 *lpm)
 {
@@ -1267,7 +1267,7 @@ remove_tbl(struct rte_lpm6 *lpm, struct rte_lpm_tbl8_hdr *tbl_hdr,
 /*
  * Deletes a rule
  */
-RTE_EXPORT_SYMBOL(rte_lpm6_delete)
+RTE_EXPORT_SYMBOL(rte_lpm6_delete);
 int
 rte_lpm6_delete(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth)
 {
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 9e7731a8a2..cce4d023a7 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -30,7 +30,7 @@ RTE_LOG_REGISTER_DEFAULT(mbuf_logtype, INFO);
  * rte_mempool_create(), or called directly if using
  * rte_mempool_create_empty()/rte_mempool_populate()
  */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_init)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_init);
 void
 rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
 {
@@ -71,7 +71,7 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
  * rte_mempool_obj_iter() or rte_mempool_create().
  * Set the fields of a packet mbuf to their default values.
  */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_init)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_init);
 void
 rte_pktmbuf_init(struct rte_mempool *mp,
 		 __rte_unused void *opaque_arg,
@@ -222,7 +222,7 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
 }
 
 /* Helper to create a mbuf pool with given mempool ops name*/
-RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_by_ops)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_by_ops);
 struct rte_mempool *
 rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
@@ -275,7 +275,7 @@ rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 }
 
 /* helper to create a mbuf pool */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create);
 struct rte_mempool *
 rte_pktmbuf_pool_create(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
@@ -286,7 +286,7 @@ rte_pktmbuf_pool_create(const char *name, unsigned int n,
 }
 
 /* Helper to create a mbuf pool with pinned external data buffers. */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_extbuf)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_extbuf);
 struct rte_mempool *
 rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size,
@@ -374,7 +374,7 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 }
 
 /* do some sanity checks on a mbuf: panic if it fails */
-RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check)
+RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check);
 void
 rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
 {
@@ -384,7 +384,7 @@ rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
 		rte_panic("%s\n", reason);
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_check)
+RTE_EXPORT_SYMBOL(rte_mbuf_check);
 int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
 		   const char **reason)
 {
@@ -494,7 +494,7 @@ __rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
 #define RTE_PKTMBUF_FREE_PENDING_SZ 64
 
 /* Free a bulk of packet mbufs back into their original mempools. */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk);
 void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 {
 	struct rte_mbuf *m, *m_next, *pending[RTE_PKTMBUF_FREE_PENDING_SZ];
@@ -521,7 +521,7 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 }
 
 /* Creates a shallow copy of mbuf */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_clone)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_clone);
 struct rte_mbuf *
 rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_mempool *mp)
 {
@@ -561,7 +561,7 @@ rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_mempool *mp)
 }
 
 /* convert multi-segment mbuf to single mbuf */
-RTE_EXPORT_SYMBOL(__rte_pktmbuf_linearize)
+RTE_EXPORT_SYMBOL(__rte_pktmbuf_linearize);
 int
 __rte_pktmbuf_linearize(struct rte_mbuf *mbuf)
 {
@@ -599,7 +599,7 @@ __rte_pktmbuf_linearize(struct rte_mbuf *mbuf)
 }
 
 /* Create a deep copy of mbuf */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_copy)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_copy);
 struct rte_mbuf *
 rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 		 uint32_t off, uint32_t len)
@@ -677,7 +677,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 }
 
 /* dump a mbuf on console */
-RTE_EXPORT_SYMBOL(rte_pktmbuf_dump)
+RTE_EXPORT_SYMBOL(rte_pktmbuf_dump);
 void
 rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 {
@@ -720,7 +720,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 }
 
 /* read len data bytes in a mbuf at specified offset (internal) */
-RTE_EXPORT_SYMBOL(__rte_pktmbuf_read)
+RTE_EXPORT_SYMBOL(__rte_pktmbuf_read);
 const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
 	uint32_t len, void *buf)
 {
@@ -758,7 +758,7 @@ const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
  * Get the name of a RX offload flag. Must be kept synchronized with flag
  * definitions in rte_mbuf.h.
  */
-RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_name)
+RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_name);
 const char *rte_get_rx_ol_flag_name(uint64_t mask)
 {
 	switch (mask) {
@@ -798,7 +798,7 @@ struct flag_mask {
 };
 
 /* write the list of rx ol flags in buffer buf */
-RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_list)
+RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_list);
 int
 rte_get_rx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
 {
@@ -865,7 +865,7 @@ rte_get_rx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
  * Get the name of a TX offload flag. Must be kept synchronized with flag
  * definitions in rte_mbuf.h.
  */
-RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_name)
+RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_name);
 const char *rte_get_tx_ol_flag_name(uint64_t mask)
 {
 	switch (mask) {
@@ -900,7 +900,7 @@ const char *rte_get_tx_ol_flag_name(uint64_t mask)
 }
 
 /* write the list of tx ol flags in buffer buf */
-RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_list)
+RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_list);
 int
 rte_get_tx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
 {
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..f6dd7cd556 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -190,7 +190,7 @@ __mbuf_dynfield_lookup(const char *name)
 	return mbuf_dynfield;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_lookup)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_lookup);
 int
 rte_mbuf_dynfield_lookup(const char *name, struct rte_mbuf_dynfield *params)
 {
@@ -327,7 +327,7 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 	return offset;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register_offset)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register_offset);
 int
 rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 				size_t req)
@@ -354,7 +354,7 @@ rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register);
 int
 rte_mbuf_dynfield_register(const struct rte_mbuf_dynfield *params)
 {
@@ -387,7 +387,7 @@ __mbuf_dynflag_lookup(const char *name)
 	return mbuf_dynflag;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_lookup)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_lookup);
 int
 rte_mbuf_dynflag_lookup(const char *name,
 			struct rte_mbuf_dynflag *params)
@@ -503,7 +503,7 @@ __rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 	return bitnum;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register_bitnum)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register_bitnum);
 int
 rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 				unsigned int req)
@@ -527,14 +527,14 @@ rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register)
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register);
 int
 rte_mbuf_dynflag_register(const struct rte_mbuf_dynflag *params)
 {
 	return rte_mbuf_dynflag_register_bitnum(params, UINT_MAX);
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dyn_dump)
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_dump);
 void rte_mbuf_dyn_dump(FILE *out)
 {
 	struct mbuf_dynfield_list *mbuf_dynfield_list;
@@ -622,7 +622,7 @@ rte_mbuf_dyn_timestamp_register(int *field_offset, uint64_t *flag,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dyn_rx_timestamp_register)
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_rx_timestamp_register);
 int
 rte_mbuf_dyn_rx_timestamp_register(int *field_offset, uint64_t *rx_flag)
 {
@@ -630,7 +630,7 @@ rte_mbuf_dyn_rx_timestamp_register(int *field_offset, uint64_t *rx_flag)
 			"Rx", RTE_MBUF_DYNFLAG_RX_TIMESTAMP_NAME);
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_dyn_tx_timestamp_register)
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_tx_timestamp_register);
 int
 rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag)
 {
diff --git a/lib/mbuf/rte_mbuf_pool_ops.c b/lib/mbuf/rte_mbuf_pool_ops.c
index 219b364803..3ef59826ef 100644
--- a/lib/mbuf/rte_mbuf_pool_ops.c
+++ b/lib/mbuf/rte_mbuf_pool_ops.c
@@ -11,7 +11,7 @@
 
 #include "mbuf_log.h"
 
-RTE_EXPORT_SYMBOL(rte_mbuf_set_platform_mempool_ops)
+RTE_EXPORT_SYMBOL(rte_mbuf_set_platform_mempool_ops);
 int
 rte_mbuf_set_platform_mempool_ops(const char *ops_name)
 {
@@ -41,7 +41,7 @@ rte_mbuf_set_platform_mempool_ops(const char *ops_name)
 	return -EEXIST;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_platform_mempool_ops)
+RTE_EXPORT_SYMBOL(rte_mbuf_platform_mempool_ops);
 const char *
 rte_mbuf_platform_mempool_ops(void)
 {
@@ -53,7 +53,7 @@ rte_mbuf_platform_mempool_ops(void)
 	return mz->addr;
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_set_user_mempool_ops)
+RTE_EXPORT_SYMBOL(rte_mbuf_set_user_mempool_ops);
 int
 rte_mbuf_set_user_mempool_ops(const char *ops_name)
 {
@@ -78,7 +78,7 @@ rte_mbuf_set_user_mempool_ops(const char *ops_name)
 
 }
 
-RTE_EXPORT_SYMBOL(rte_mbuf_user_mempool_ops)
+RTE_EXPORT_SYMBOL(rte_mbuf_user_mempool_ops);
 const char *
 rte_mbuf_user_mempool_ops(void)
 {
@@ -91,7 +91,7 @@ rte_mbuf_user_mempool_ops(void)
 }
 
 /* Return mbuf pool ops name */
-RTE_EXPORT_SYMBOL(rte_mbuf_best_mempool_ops)
+RTE_EXPORT_SYMBOL(rte_mbuf_best_mempool_ops);
 const char *
 rte_mbuf_best_mempool_ops(void)
 {
diff --git a/lib/mbuf/rte_mbuf_ptype.c b/lib/mbuf/rte_mbuf_ptype.c
index 2c80294498..715c6c1700 100644
--- a/lib/mbuf/rte_mbuf_ptype.c
+++ b/lib/mbuf/rte_mbuf_ptype.c
@@ -9,7 +9,7 @@
 #include <rte_mbuf_ptype.h>
 
 /* get the name of the l2 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_l2_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_l2_name);
 const char *rte_get_ptype_l2_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L2_MASK) {
@@ -28,7 +28,7 @@ const char *rte_get_ptype_l2_name(uint32_t ptype)
 }
 
 /* get the name of the l3 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_l3_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_l3_name);
 const char *rte_get_ptype_l3_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L3_MASK) {
@@ -43,7 +43,7 @@ const char *rte_get_ptype_l3_name(uint32_t ptype)
 }
 
 /* get the name of the l4 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_l4_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_l4_name);
 const char *rte_get_ptype_l4_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L4_MASK) {
@@ -60,7 +60,7 @@ const char *rte_get_ptype_l4_name(uint32_t ptype)
 }
 
 /* get the name of the tunnel packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_tunnel_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_tunnel_name);
 const char *rte_get_ptype_tunnel_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_TUNNEL_MASK) {
@@ -82,7 +82,7 @@ const char *rte_get_ptype_tunnel_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l2 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l2_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l2_name);
 const char *rte_get_ptype_inner_l2_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L2_MASK) {
@@ -94,7 +94,7 @@ const char *rte_get_ptype_inner_l2_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l3 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l3_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l3_name);
 const char *rte_get_ptype_inner_l3_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L3_MASK) {
@@ -111,7 +111,7 @@ const char *rte_get_ptype_inner_l3_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l4 packet type */
-RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l4_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l4_name);
 const char *rte_get_ptype_inner_l4_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L4_MASK) {
@@ -127,7 +127,7 @@ const char *rte_get_ptype_inner_l4_name(uint32_t ptype)
 }
 
 /* write the packet type name into the buffer */
-RTE_EXPORT_SYMBOL(rte_get_ptype_name)
+RTE_EXPORT_SYMBOL(rte_get_ptype_name);
 int rte_get_ptype_name(uint32_t ptype, char *buf, size_t buflen)
 {
 	int ret;
diff --git a/lib/member/rte_member.c b/lib/member/rte_member.c
index 5ff32f1e45..505b80aa33 100644
--- a/lib/member/rte_member.c
+++ b/lib/member/rte_member.c
@@ -24,7 +24,7 @@ static struct rte_tailq_elem rte_member_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_member_tailq)
 
-RTE_EXPORT_SYMBOL(rte_member_find_existing)
+RTE_EXPORT_SYMBOL(rte_member_find_existing);
 struct rte_member_setsum *
 rte_member_find_existing(const char *name)
 {
@@ -49,7 +49,7 @@ rte_member_find_existing(const char *name)
 	return setsum;
 }
 
-RTE_EXPORT_SYMBOL(rte_member_free)
+RTE_EXPORT_SYMBOL(rte_member_free);
 void
 rte_member_free(struct rte_member_setsum *setsum)
 {
@@ -88,7 +88,7 @@ rte_member_free(struct rte_member_setsum *setsum)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_member_create)
+RTE_EXPORT_SYMBOL(rte_member_create);
 struct rte_member_setsum *
 rte_member_create(const struct rte_member_parameters *params)
 {
@@ -192,7 +192,7 @@ rte_member_create(const struct rte_member_parameters *params)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_member_add)
+RTE_EXPORT_SYMBOL(rte_member_add);
 int
 rte_member_add(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t set_id)
@@ -212,7 +212,7 @@ rte_member_add(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_add_byte_count)
+RTE_EXPORT_SYMBOL(rte_member_add_byte_count);
 int
 rte_member_add_byte_count(const struct rte_member_setsum *setsum,
 			  const void *key, uint32_t byte_count)
@@ -228,7 +228,7 @@ rte_member_add_byte_count(const struct rte_member_setsum *setsum,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_lookup)
+RTE_EXPORT_SYMBOL(rte_member_lookup);
 int
 rte_member_lookup(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t *set_id)
@@ -248,7 +248,7 @@ rte_member_lookup(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_lookup_bulk)
+RTE_EXPORT_SYMBOL(rte_member_lookup_bulk);
 int
 rte_member_lookup_bulk(const struct rte_member_setsum *setsum,
 				const void **keys, uint32_t num_keys,
@@ -269,7 +269,7 @@ rte_member_lookup_bulk(const struct rte_member_setsum *setsum,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_lookup_multi)
+RTE_EXPORT_SYMBOL(rte_member_lookup_multi);
 int
 rte_member_lookup_multi(const struct rte_member_setsum *setsum, const void *key,
 				uint32_t match_per_key, member_set_t *set_id)
@@ -289,7 +289,7 @@ rte_member_lookup_multi(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_lookup_multi_bulk)
+RTE_EXPORT_SYMBOL(rte_member_lookup_multi_bulk);
 int
 rte_member_lookup_multi_bulk(const struct rte_member_setsum *setsum,
 			const void **keys, uint32_t num_keys,
@@ -312,7 +312,7 @@ rte_member_lookup_multi_bulk(const struct rte_member_setsum *setsum,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_query_count)
+RTE_EXPORT_SYMBOL(rte_member_query_count);
 int
 rte_member_query_count(const struct rte_member_setsum *setsum,
 		       const void *key, uint64_t *output)
@@ -328,7 +328,7 @@ rte_member_query_count(const struct rte_member_setsum *setsum,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_report_heavyhitter)
+RTE_EXPORT_SYMBOL(rte_member_report_heavyhitter);
 int
 rte_member_report_heavyhitter(const struct rte_member_setsum *setsum,
 				void **key, uint64_t *count)
@@ -344,7 +344,7 @@ rte_member_report_heavyhitter(const struct rte_member_setsum *setsum,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_delete)
+RTE_EXPORT_SYMBOL(rte_member_delete);
 int
 rte_member_delete(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t set_id)
@@ -364,7 +364,7 @@ rte_member_delete(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_member_reset)
+RTE_EXPORT_SYMBOL(rte_member_reset);
 void
 rte_member_reset(const struct rte_member_setsum *setsum)
 {
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..00ff71a209 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -32,7 +32,7 @@
 #include "mempool_trace.h"
 #include "rte_mempool.h"
 
-RTE_EXPORT_SYMBOL(rte_mempool_logtype)
+RTE_EXPORT_SYMBOL(rte_mempool_logtype);
 RTE_LOG_REGISTER_DEFAULT(rte_mempool_logtype, INFO);
 
 TAILQ_HEAD(rte_mempool_list, rte_tailq_entry);
@@ -181,7 +181,7 @@ mempool_add_elem(struct rte_mempool *mp, __rte_unused void *opaque,
 }
 
 /* call obj_cb() for each mempool element */
-RTE_EXPORT_SYMBOL(rte_mempool_obj_iter)
+RTE_EXPORT_SYMBOL(rte_mempool_obj_iter);
 uint32_t
 rte_mempool_obj_iter(struct rte_mempool *mp,
 	rte_mempool_obj_cb_t *obj_cb, void *obj_cb_arg)
@@ -200,7 +200,7 @@ rte_mempool_obj_iter(struct rte_mempool *mp,
 }
 
 /* call mem_cb() for each mempool memory chunk */
-RTE_EXPORT_SYMBOL(rte_mempool_mem_iter)
+RTE_EXPORT_SYMBOL(rte_mempool_mem_iter);
 uint32_t
 rte_mempool_mem_iter(struct rte_mempool *mp,
 	rte_mempool_mem_cb_t *mem_cb, void *mem_cb_arg)
@@ -217,7 +217,7 @@ rte_mempool_mem_iter(struct rte_mempool *mp,
 }
 
 /* get the header, trailer and total size of a mempool element. */
-RTE_EXPORT_SYMBOL(rte_mempool_calc_obj_size)
+RTE_EXPORT_SYMBOL(rte_mempool_calc_obj_size);
 uint32_t
 rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 	struct rte_mempool_objsz *sz)
@@ -318,7 +318,7 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
  * zone. Return the number of objects added, or a negative value
  * on error.
  */
-RTE_EXPORT_SYMBOL(rte_mempool_populate_iova)
+RTE_EXPORT_SYMBOL(rte_mempool_populate_iova);
 int
 rte_mempool_populate_iova(struct rte_mempool *mp, char *vaddr,
 	rte_iova_t iova, size_t len, rte_mempool_memchunk_free_cb_t *free_cb,
@@ -404,7 +404,7 @@ get_iova(void *addr)
 /* Populate the mempool with a virtual area. Return the number of
  * objects added, or a negative value on error.
  */
-RTE_EXPORT_SYMBOL(rte_mempool_populate_virt)
+RTE_EXPORT_SYMBOL(rte_mempool_populate_virt);
 int
 rte_mempool_populate_virt(struct rte_mempool *mp, char *addr,
 	size_t len, size_t pg_sz, rte_mempool_memchunk_free_cb_t *free_cb,
@@ -459,7 +459,7 @@ rte_mempool_populate_virt(struct rte_mempool *mp, char *addr,
 }
 
 /* Get the minimal page size used in a mempool before populating it. */
-RTE_EXPORT_SYMBOL(rte_mempool_get_page_size)
+RTE_EXPORT_SYMBOL(rte_mempool_get_page_size);
 int
 rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
 {
@@ -489,7 +489,7 @@ rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
  * and populate them. Return the number of objects added, or a negative
  * value on error.
  */
-RTE_EXPORT_SYMBOL(rte_mempool_populate_default)
+RTE_EXPORT_SYMBOL(rte_mempool_populate_default);
 int
 rte_mempool_populate_default(struct rte_mempool *mp)
 {
@@ -668,7 +668,7 @@ rte_mempool_memchunk_anon_free(struct rte_mempool_memhdr *memhdr,
 }
 
 /* populate the mempool with an anonymous mapping */
-RTE_EXPORT_SYMBOL(rte_mempool_populate_anon)
+RTE_EXPORT_SYMBOL(rte_mempool_populate_anon);
 int
 rte_mempool_populate_anon(struct rte_mempool *mp)
 {
@@ -723,7 +723,7 @@ rte_mempool_populate_anon(struct rte_mempool *mp)
 }
 
 /* free a mempool */
-RTE_EXPORT_SYMBOL(rte_mempool_free)
+RTE_EXPORT_SYMBOL(rte_mempool_free);
 void
 rte_mempool_free(struct rte_mempool *mp)
 {
@@ -772,7 +772,7 @@ mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
  * returned to an underlying mempool. This structure is identical to the
  * local_cache[lcore_id] pointed to by the mempool structure.
  */
-RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
+RTE_EXPORT_SYMBOL(rte_mempool_cache_create);
 struct rte_mempool_cache *
 rte_mempool_cache_create(uint32_t size, int socket_id)
 {
@@ -802,7 +802,7 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
  * remaining objects in the cache are flushed to the corresponding
  * mempool.
  */
-RTE_EXPORT_SYMBOL(rte_mempool_cache_free)
+RTE_EXPORT_SYMBOL(rte_mempool_cache_free);
 void
 rte_mempool_cache_free(struct rte_mempool_cache *cache)
 {
@@ -811,7 +811,7 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache)
 }
 
 /* create an empty mempool */
-RTE_EXPORT_SYMBOL(rte_mempool_create_empty)
+RTE_EXPORT_SYMBOL(rte_mempool_create_empty);
 struct rte_mempool *
 rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	unsigned cache_size, unsigned private_data_size,
@@ -980,7 +980,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 }
 
 /* create the mempool */
-RTE_EXPORT_SYMBOL(rte_mempool_create)
+RTE_EXPORT_SYMBOL(rte_mempool_create);
 struct rte_mempool *
 rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 	unsigned cache_size, unsigned private_data_size,
@@ -1017,7 +1017,7 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 }
 
 /* Return the number of entries in the mempool */
-RTE_EXPORT_SYMBOL(rte_mempool_avail_count)
+RTE_EXPORT_SYMBOL(rte_mempool_avail_count);
 unsigned int
 rte_mempool_avail_count(const struct rte_mempool *mp)
 {
@@ -1042,7 +1042,7 @@ rte_mempool_avail_count(const struct rte_mempool *mp)
 }
 
 /* return the number of entries allocated from the mempool */
-RTE_EXPORT_SYMBOL(rte_mempool_in_use_count)
+RTE_EXPORT_SYMBOL(rte_mempool_in_use_count);
 unsigned int
 rte_mempool_in_use_count(const struct rte_mempool *mp)
 {
@@ -1074,7 +1074,7 @@ rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 }
 
 /* check and update cookies or panic (internal) */
-RTE_EXPORT_SYMBOL(rte_mempool_check_cookies)
+RTE_EXPORT_SYMBOL(rte_mempool_check_cookies);
 void rte_mempool_check_cookies(const struct rte_mempool *mp,
 	void * const *obj_table_const, unsigned n, int free)
 {
@@ -1143,7 +1143,7 @@ void rte_mempool_check_cookies(const struct rte_mempool *mp,
 #endif
 }
 
-RTE_EXPORT_SYMBOL(rte_mempool_contig_blocks_check_cookies)
+RTE_EXPORT_SYMBOL(rte_mempool_contig_blocks_check_cookies);
 void
 rte_mempool_contig_blocks_check_cookies(const struct rte_mempool *mp,
 	void * const *first_obj_table_const, unsigned int n, int free)
@@ -1220,7 +1220,7 @@ mempool_audit_cache(const struct rte_mempool *mp)
 }
 
 /* check the consistency of mempool (size, cookies, ...) */
-RTE_EXPORT_SYMBOL(rte_mempool_audit)
+RTE_EXPORT_SYMBOL(rte_mempool_audit);
 void
 rte_mempool_audit(struct rte_mempool *mp)
 {
@@ -1232,7 +1232,7 @@ rte_mempool_audit(struct rte_mempool *mp)
 }
 
 /* dump the status of the mempool on the console */
-RTE_EXPORT_SYMBOL(rte_mempool_dump)
+RTE_EXPORT_SYMBOL(rte_mempool_dump);
 void
 rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 {
@@ -1337,7 +1337,7 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 }
 
 /* dump the status of all mempools on the console */
-RTE_EXPORT_SYMBOL(rte_mempool_list_dump)
+RTE_EXPORT_SYMBOL(rte_mempool_list_dump);
 void
 rte_mempool_list_dump(FILE *f)
 {
@@ -1358,7 +1358,7 @@ rte_mempool_list_dump(FILE *f)
 }
 
 /* search a mempool from its name */
-RTE_EXPORT_SYMBOL(rte_mempool_lookup)
+RTE_EXPORT_SYMBOL(rte_mempool_lookup);
 struct rte_mempool *
 rte_mempool_lookup(const char *name)
 {
@@ -1386,7 +1386,7 @@ rte_mempool_lookup(const char *name)
 	return mp;
 }
 
-RTE_EXPORT_SYMBOL(rte_mempool_walk)
+RTE_EXPORT_SYMBOL(rte_mempool_walk);
 void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 		      void *arg)
 {
diff --git a/lib/mempool/rte_mempool_ops.c b/lib/mempool/rte_mempool_ops.c
index 066bec36fc..8dcb9161bf 100644
--- a/lib/mempool/rte_mempool_ops.c
+++ b/lib/mempool/rte_mempool_ops.c
@@ -15,14 +15,14 @@
 #include "mempool_trace.h"
 
 /* indirect jump table to support external memory pools. */
-RTE_EXPORT_SYMBOL(rte_mempool_ops_table)
+RTE_EXPORT_SYMBOL(rte_mempool_ops_table);
 struct rte_mempool_ops_table rte_mempool_ops_table = {
 	.sl =  RTE_SPINLOCK_INITIALIZER,
 	.num_ops = 0
 };
 
 /* add a new ops struct in rte_mempool_ops_table, return its index. */
-RTE_EXPORT_SYMBOL(rte_mempool_register_ops)
+RTE_EXPORT_SYMBOL(rte_mempool_register_ops);
 int
 rte_mempool_register_ops(const struct rte_mempool_ops *h)
 {
@@ -149,7 +149,7 @@ rte_mempool_ops_populate(struct rte_mempool *mp, unsigned int max_objs,
 }
 
 /* wrapper to get additional mempool info */
-RTE_EXPORT_SYMBOL(rte_mempool_ops_get_info)
+RTE_EXPORT_SYMBOL(rte_mempool_ops_get_info);
 int
 rte_mempool_ops_get_info(const struct rte_mempool *mp,
 			 struct rte_mempool_info *info)
@@ -165,7 +165,7 @@ rte_mempool_ops_get_info(const struct rte_mempool *mp,
 
 
 /* sets mempool ops previously registered by rte_mempool_register_ops. */
-RTE_EXPORT_SYMBOL(rte_mempool_set_ops_byname)
+RTE_EXPORT_SYMBOL(rte_mempool_set_ops_byname);
 int
 rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
 	void *pool_config)
diff --git a/lib/mempool/rte_mempool_ops_default.c b/lib/mempool/rte_mempool_ops_default.c
index d27d6fc473..3ece87ca26 100644
--- a/lib/mempool/rte_mempool_ops_default.c
+++ b/lib/mempool/rte_mempool_ops_default.c
@@ -7,7 +7,7 @@
 #include <eal_export.h>
 #include <rte_mempool.h>
 
-RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_helper)
+RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_helper);
 ssize_t
 rte_mempool_op_calc_mem_size_helper(const struct rte_mempool *mp,
 				uint32_t obj_num, uint32_t pg_shift,
@@ -67,7 +67,7 @@ rte_mempool_op_calc_mem_size_helper(const struct rte_mempool *mp,
 	return mem_size;
 }
 
-RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_default)
+RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_default);
 ssize_t
 rte_mempool_op_calc_mem_size_default(const struct rte_mempool *mp,
 				uint32_t obj_num, uint32_t pg_shift,
@@ -90,7 +90,7 @@ check_obj_bounds(char *obj, size_t pg_sz, size_t elt_sz)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_mempool_op_populate_helper)
+RTE_EXPORT_SYMBOL(rte_mempool_op_populate_helper);
 int
 rte_mempool_op_populate_helper(struct rte_mempool *mp, unsigned int flags,
 			unsigned int max_objs, void *vaddr, rte_iova_t iova,
@@ -138,7 +138,7 @@ rte_mempool_op_populate_helper(struct rte_mempool *mp, unsigned int flags,
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_mempool_op_populate_default)
+RTE_EXPORT_SYMBOL(rte_mempool_op_populate_default);
 int
 rte_mempool_op_populate_default(struct rte_mempool *mp, unsigned int max_objs,
 				void *vaddr, rte_iova_t iova, size_t len,
diff --git a/lib/meter/rte_meter.c b/lib/meter/rte_meter.c
index ec76bec4cb..b78c2abe34 100644
--- a/lib/meter/rte_meter.c
+++ b/lib/meter/rte_meter.c
@@ -37,7 +37,7 @@ rte_meter_get_tb_params(uint64_t hz, uint64_t rate, uint64_t *tb_period, uint64_
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_srtcm_profile_config)
+RTE_EXPORT_SYMBOL(rte_meter_srtcm_profile_config);
 int
 rte_meter_srtcm_profile_config(struct rte_meter_srtcm_profile *p,
 	struct rte_meter_srtcm_params *params)
@@ -60,7 +60,7 @@ rte_meter_srtcm_profile_config(struct rte_meter_srtcm_profile *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_srtcm_config)
+RTE_EXPORT_SYMBOL(rte_meter_srtcm_config);
 int
 rte_meter_srtcm_config(struct rte_meter_srtcm *m,
 	struct rte_meter_srtcm_profile *p)
@@ -77,7 +77,7 @@ rte_meter_srtcm_config(struct rte_meter_srtcm *m,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_trtcm_profile_config)
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_profile_config);
 int
 rte_meter_trtcm_profile_config(struct rte_meter_trtcm_profile *p,
 	struct rte_meter_trtcm_params *params)
@@ -105,7 +105,7 @@ rte_meter_trtcm_profile_config(struct rte_meter_trtcm_profile *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_trtcm_config)
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_config);
 int
 rte_meter_trtcm_config(struct rte_meter_trtcm *m,
 	struct rte_meter_trtcm_profile *p)
@@ -122,7 +122,7 @@ rte_meter_trtcm_config(struct rte_meter_trtcm *m,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_profile_config)
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_profile_config);
 int
 rte_meter_trtcm_rfc4115_profile_config(
 	struct rte_meter_trtcm_rfc4115_profile *p,
@@ -148,7 +148,7 @@ rte_meter_trtcm_rfc4115_profile_config(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_config)
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_config);
 int
 rte_meter_trtcm_rfc4115_config(
 	struct rte_meter_trtcm_rfc4115 *m,
diff --git a/lib/metrics/rte_metrics.c b/lib/metrics/rte_metrics.c
index 4cd4623b7a..5065a7d4af 100644
--- a/lib/metrics/rte_metrics.c
+++ b/lib/metrics/rte_metrics.c
@@ -56,7 +56,7 @@ struct rte_metrics_data_s {
 	rte_spinlock_t lock;
 };
 
-RTE_EXPORT_SYMBOL(rte_metrics_init)
+RTE_EXPORT_SYMBOL(rte_metrics_init);
 int
 rte_metrics_init(int socket_id)
 {
@@ -82,7 +82,7 @@ rte_metrics_init(int socket_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_deinit)
+RTE_EXPORT_SYMBOL(rte_metrics_deinit);
 int
 rte_metrics_deinit(void)
 {
@@ -106,7 +106,7 @@ rte_metrics_deinit(void)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_reg_name)
+RTE_EXPORT_SYMBOL(rte_metrics_reg_name);
 int
 rte_metrics_reg_name(const char *name)
 {
@@ -115,7 +115,7 @@ rte_metrics_reg_name(const char *name)
 	return rte_metrics_reg_names(list_names, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_reg_names)
+RTE_EXPORT_SYMBOL(rte_metrics_reg_names);
 int
 rte_metrics_reg_names(const char * const *names, uint16_t cnt_names)
 {
@@ -162,14 +162,14 @@ rte_metrics_reg_names(const char * const *names, uint16_t cnt_names)
 	return idx_base;
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_update_value)
+RTE_EXPORT_SYMBOL(rte_metrics_update_value);
 int
 rte_metrics_update_value(int port_id, uint16_t key, const uint64_t value)
 {
 	return rte_metrics_update_values(port_id, key, &value, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_update_values)
+RTE_EXPORT_SYMBOL(rte_metrics_update_values);
 int
 rte_metrics_update_values(int port_id,
 	uint16_t key,
@@ -232,7 +232,7 @@ rte_metrics_update_values(int port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_get_names)
+RTE_EXPORT_SYMBOL(rte_metrics_get_names);
 int
 rte_metrics_get_names(struct rte_metric_name *names,
 	uint16_t capacity)
@@ -264,7 +264,7 @@ rte_metrics_get_names(struct rte_metric_name *names,
 	return return_value;
 }
 
-RTE_EXPORT_SYMBOL(rte_metrics_get_values)
+RTE_EXPORT_SYMBOL(rte_metrics_get_values);
 int
 rte_metrics_get_values(int port_id,
 	struct rte_metric_value *values,
diff --git a/lib/net/rte_arp.c b/lib/net/rte_arp.c
index 3f8c69f69d..e2d78217e5 100644
--- a/lib/net/rte_arp.c
+++ b/lib/net/rte_arp.c
@@ -6,7 +6,7 @@
 #include <rte_arp.h>
 
 #define RARP_PKT_SIZE	64
-RTE_EXPORT_SYMBOL(rte_net_make_rarp_packet)
+RTE_EXPORT_SYMBOL(rte_net_make_rarp_packet);
 struct rte_mbuf *
 rte_net_make_rarp_packet(struct rte_mempool *mpool,
 		const struct rte_ether_addr *mac)
diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index 6703145fc5..68369edd3d 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -8,7 +8,7 @@
 #include <rte_ether.h>
 #include <rte_errno.h>
 
-RTE_EXPORT_SYMBOL(rte_eth_random_addr)
+RTE_EXPORT_SYMBOL(rte_eth_random_addr);
 void
 rte_eth_random_addr(uint8_t *addr)
 {
@@ -20,7 +20,7 @@ rte_eth_random_addr(uint8_t *addr)
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
 
-RTE_EXPORT_SYMBOL(rte_ether_format_addr)
+RTE_EXPORT_SYMBOL(rte_ether_format_addr);
 void
 rte_ether_format_addr(char *buf, uint16_t size,
 		      const struct rte_ether_addr *eth_addr)
@@ -133,7 +133,7 @@ static unsigned int get_ether_sep(const char *s, char *sep)
  *  - Windows format six groups separated by hyphen
  *  - two groups hexadecimal digits
  */
-RTE_EXPORT_SYMBOL(rte_ether_unformat_addr)
+RTE_EXPORT_SYMBOL(rte_ether_unformat_addr);
 int
 rte_ether_unformat_addr(const char *s, struct rte_ether_addr *ea)
 {
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..a328d1f3cf 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -274,7 +274,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 }
 
 /* parse ipv6 extended headers, update offset and return next proto */
-RTE_EXPORT_SYMBOL(rte_net_skip_ip6_ext)
+RTE_EXPORT_SYMBOL(rte_net_skip_ip6_ext);
 int
 rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 	int *frag)
@@ -321,7 +321,7 @@ rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 }
 
 /* parse mbuf data to get packet type */
-RTE_EXPORT_SYMBOL(rte_net_get_ptype)
+RTE_EXPORT_SYMBOL(rte_net_get_ptype);
 uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	struct rte_net_hdr_lens *hdr_lens, uint32_t layers)
 {
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 3a589bdd6d..c21955d2d5 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -216,7 +216,7 @@ handlers_init(enum rte_net_crc_alg alg)
 
 /* Public API */
 
-RTE_EXPORT_SYMBOL(rte_net_crc_set_alg)
+RTE_EXPORT_SYMBOL(rte_net_crc_set_alg);
 struct rte_net_crc *rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_crc_type type)
 {
 	uint16_t max_simd_bitwidth;
@@ -256,13 +256,13 @@ struct rte_net_crc *rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_c
 	return crc;
 }
 
-RTE_EXPORT_SYMBOL(rte_net_crc_free)
+RTE_EXPORT_SYMBOL(rte_net_crc_free);
 void rte_net_crc_free(struct rte_net_crc *crc)
 {
 	rte_free(crc);
 }
 
-RTE_EXPORT_SYMBOL(rte_net_crc_calc)
+RTE_EXPORT_SYMBOL(rte_net_crc_calc);
 uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx, const void *data, const uint32_t data_len)
 {
 	return handlers[ctx->alg].f[ctx->type](data, data_len);
diff --git a/lib/node/ethdev_ctrl.c b/lib/node/ethdev_ctrl.c
index f717903731..19d2670d89 100644
--- a/lib/node/ethdev_ctrl.c
+++ b/lib/node/ethdev_ctrl.c
@@ -22,7 +22,7 @@ static struct ethdev_ctrl {
 	uint16_t nb_graphs;
 } ctrl;
 
-RTE_EXPORT_SYMBOL(rte_node_eth_config)
+RTE_EXPORT_SYMBOL(rte_node_eth_config);
 int
 rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 		    uint16_t nb_graphs)
diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index f6db3219f0..dc6f7060b3 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -118,7 +118,7 @@ ip4_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	return nb_objs;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_ip4_route_add)
+RTE_EXPORT_SYMBOL(rte_node_ip4_route_add);
 int
 rte_node_ip4_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 		       enum rte_node_ip4_lookup_next next_node)
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index 37bc3a511f..1e1eaa10b3 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -548,7 +548,7 @@ ip4_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_node_ip4_rewrite_add)
+RTE_EXPORT_SYMBOL(rte_node_ip4_rewrite_add);
 int
 rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2a07b4c1f5..0df40185d2 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -200,7 +200,7 @@ pcapng_section_block(rte_pcapng_t *self,
 }
 
 /* Write an interface block for a DPDK port */
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
+RTE_EXPORT_SYMBOL(rte_pcapng_add_interface);
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 			 const char *ifname, const char *ifdescr,
@@ -322,7 +322,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 /*
  * Write an Interface statistics block at the end of capture.
  */
-RTE_EXPORT_SYMBOL(rte_pcapng_write_stats)
+RTE_EXPORT_SYMBOL(rte_pcapng_write_stats);
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		       uint64_t ifrecv, uint64_t ifdrop,
@@ -388,7 +388,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	return write(self->outfd, buf, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
+RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size);
 uint32_t
 rte_pcapng_mbuf_size(uint32_t length)
 {
@@ -470,7 +470,7 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
  */
 
 /* Make a copy of original mbuf with pcapng header and options */
-RTE_EXPORT_SYMBOL(rte_pcapng_copy)
+RTE_EXPORT_SYMBOL(rte_pcapng_copy);
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *md,
@@ -612,7 +612,7 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 }
 
 /* Write pre-formatted packets to file. */
-RTE_EXPORT_SYMBOL(rte_pcapng_write_packets)
+RTE_EXPORT_SYMBOL(rte_pcapng_write_packets);
 ssize_t
 rte_pcapng_write_packets(rte_pcapng_t *self,
 			 struct rte_mbuf *pkts[], uint16_t nb_pkts)
@@ -682,7 +682,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 }
 
 /* Create new pcapng writer handle */
-RTE_EXPORT_SYMBOL(rte_pcapng_fdopen)
+RTE_EXPORT_SYMBOL(rte_pcapng_fdopen);
 rte_pcapng_t *
 rte_pcapng_fdopen(int fd,
 		  const char *osname, const char *hardware,
@@ -720,7 +720,7 @@ rte_pcapng_fdopen(int fd,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_pcapng_close)
+RTE_EXPORT_SYMBOL(rte_pcapng_close);
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
diff --git a/lib/pci/rte_pci.c b/lib/pci/rte_pci.c
index e2f89a7f21..1bbdce250c 100644
--- a/lib/pci/rte_pci.c
+++ b/lib/pci/rte_pci.c
@@ -93,7 +93,7 @@ pci_dbdf_parse(const char *input, struct rte_pci_addr *dev_addr)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_device_name)
+RTE_EXPORT_SYMBOL(rte_pci_device_name);
 void
 rte_pci_device_name(const struct rte_pci_addr *addr,
 		char *output, size_t size)
@@ -104,7 +104,7 @@ rte_pci_device_name(const struct rte_pci_addr *addr,
 			    addr->devid, addr->function) >= 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_addr_cmp)
+RTE_EXPORT_SYMBOL(rte_pci_addr_cmp);
 int
 rte_pci_addr_cmp(const struct rte_pci_addr *addr,
 	     const struct rte_pci_addr *addr2)
@@ -127,7 +127,7 @@ rte_pci_addr_cmp(const struct rte_pci_addr *addr,
 		return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_addr_parse)
+RTE_EXPORT_SYMBOL(rte_pci_addr_parse);
 int
 rte_pci_addr_parse(const char *str, struct rte_pci_addr *addr)
 {
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ba75b828f2..5559d7f7b9 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -418,7 +418,7 @@ pdump_server(const struct rte_mp_msg *mp_msg, const void *peer)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_init)
+RTE_EXPORT_SYMBOL(rte_pdump_init);
 int
 rte_pdump_init(void)
 {
@@ -441,7 +441,7 @@ rte_pdump_init(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_uninit)
+RTE_EXPORT_SYMBOL(rte_pdump_uninit);
 int
 rte_pdump_uninit(void)
 {
@@ -612,7 +612,7 @@ pdump_enable(uint16_t port, uint16_t queue,
 					    ENABLE, ring, mp, prm);
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_enable)
+RTE_EXPORT_SYMBOL(rte_pdump_enable);
 int
 rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
 		 struct rte_ring *ring,
@@ -623,7 +623,7 @@ rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
 			    ring, mp, NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf)
+RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf);
 int
 rte_pdump_enable_bpf(uint16_t port, uint16_t queue,
 		     uint32_t flags, uint32_t snaplen,
@@ -658,7 +658,7 @@ pdump_enable_by_deviceid(const char *device_id, uint16_t queue,
 					    ENABLE, ring, mp, prm);
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_enable_by_deviceid)
+RTE_EXPORT_SYMBOL(rte_pdump_enable_by_deviceid);
 int
 rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
 			     uint32_t flags,
@@ -670,7 +670,7 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
 					ring, mp, NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf_by_deviceid)
+RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf_by_deviceid);
 int
 rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
 				 uint32_t flags, uint32_t snaplen,
@@ -682,7 +682,7 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
 					ring, mp, prm);
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_disable)
+RTE_EXPORT_SYMBOL(rte_pdump_disable);
 int
 rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags)
 {
@@ -702,7 +702,7 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_disable_by_deviceid)
+RTE_EXPORT_SYMBOL(rte_pdump_disable_by_deviceid);
 int
 rte_pdump_disable_by_deviceid(char *device_id, uint16_t queue,
 				uint32_t flags)
@@ -739,7 +739,7 @@ pdump_sum_stats(uint16_t port, uint16_t nq,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pdump_stats)
+RTE_EXPORT_SYMBOL(rte_pdump_stats);
 int
 rte_pdump_stats(uint16_t port, struct rte_pdump_stats *stats)
 {
diff --git a/lib/pipeline/rte_pipeline.c b/lib/pipeline/rte_pipeline.c
index fa3c8b77ee..a77efa47d4 100644
--- a/lib/pipeline/rte_pipeline.c
+++ b/lib/pipeline/rte_pipeline.c
@@ -190,7 +190,7 @@ rte_pipeline_check_params(struct rte_pipeline_params *params)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_create)
+RTE_EXPORT_SYMBOL(rte_pipeline_create);
 struct rte_pipeline *
 rte_pipeline_create(struct rte_pipeline_params *params)
 {
@@ -233,7 +233,7 @@ rte_pipeline_create(struct rte_pipeline_params *params)
 	return p;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_free)
+RTE_EXPORT_SYMBOL(rte_pipeline_free);
 int
 rte_pipeline_free(struct rte_pipeline *p)
 {
@@ -327,7 +327,7 @@ rte_table_check_params(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_create)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_create);
 int
 rte_pipeline_table_create(struct rte_pipeline *p,
 		struct rte_pipeline_table_params *params,
@@ -399,7 +399,7 @@ rte_pipeline_table_free(struct rte_table *table)
 	rte_free(table->default_entry);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_add)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_add);
 int
 rte_pipeline_table_default_entry_add(struct rte_pipeline *p,
 	uint32_t table_id,
@@ -450,7 +450,7 @@ rte_pipeline_table_default_entry_add(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_delete)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_delete);
 int
 rte_pipeline_table_default_entry_delete(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -484,7 +484,7 @@ rte_pipeline_table_default_entry_delete(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add);
 int
 rte_pipeline_table_entry_add(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -546,7 +546,7 @@ rte_pipeline_table_entry_add(struct rte_pipeline *p,
 		key_found, (void **) entry_ptr);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete);
 int
 rte_pipeline_table_entry_delete(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -586,7 +586,7 @@ rte_pipeline_table_entry_delete(struct rte_pipeline *p,
 	return (table->ops.f_delete)(table->h_table, key, key_found, entry);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add_bulk)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add_bulk);
 int rte_pipeline_table_entry_add_bulk(struct rte_pipeline *p,
 	uint32_t table_id,
 	void **keys,
@@ -653,7 +653,7 @@ int rte_pipeline_table_entry_add_bulk(struct rte_pipeline *p,
 		n_keys, key_found, (void **) entries_ptr);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete_bulk)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete_bulk);
 int rte_pipeline_table_entry_delete_bulk(struct rte_pipeline *p,
 	uint32_t table_id,
 	void **keys,
@@ -811,7 +811,7 @@ rte_pipeline_port_out_check_params(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_in_create)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_create);
 int
 rte_pipeline_port_in_create(struct rte_pipeline *p,
 		struct rte_pipeline_port_in_params *params,
@@ -862,7 +862,7 @@ rte_pipeline_port_in_free(struct rte_port_in *port)
 		port->ops.f_free(port->h_port);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_out_create)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_create);
 int
 rte_pipeline_port_out_create(struct rte_pipeline *p,
 		struct rte_pipeline_port_out_params *params,
@@ -910,7 +910,7 @@ rte_pipeline_port_out_free(struct rte_port_out *port)
 		port->ops.f_free(port->h_port);
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_in_connect_to_table)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_connect_to_table);
 int
 rte_pipeline_port_in_connect_to_table(struct rte_pipeline *p,
 		uint32_t port_id,
@@ -945,7 +945,7 @@ rte_pipeline_port_in_connect_to_table(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_in_enable)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_enable);
 int
 rte_pipeline_port_in_enable(struct rte_pipeline *p, uint32_t port_id)
 {
@@ -993,7 +993,7 @@ rte_pipeline_port_in_enable(struct rte_pipeline *p, uint32_t port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_in_disable)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_disable);
 int
 rte_pipeline_port_in_disable(struct rte_pipeline *p, uint32_t port_id)
 {
@@ -1049,7 +1049,7 @@ rte_pipeline_port_in_disable(struct rte_pipeline *p, uint32_t port_id)
 /*
  * Pipeline run-time
  */
-RTE_EXPORT_SYMBOL(rte_pipeline_check)
+RTE_EXPORT_SYMBOL(rte_pipeline_check);
 int
 rte_pipeline_check(struct rte_pipeline *p)
 {
@@ -1323,7 +1323,7 @@ rte_pipeline_action_handler_drop(struct rte_pipeline *p, uint64_t pkts_mask)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_run)
+RTE_EXPORT_SYMBOL(rte_pipeline_run);
 int
 rte_pipeline_run(struct rte_pipeline *p)
 {
@@ -1463,7 +1463,7 @@ rte_pipeline_run(struct rte_pipeline *p)
 	return (int) n_pkts;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_flush)
+RTE_EXPORT_SYMBOL(rte_pipeline_flush);
 int
 rte_pipeline_flush(struct rte_pipeline *p)
 {
@@ -1486,7 +1486,7 @@ rte_pipeline_flush(struct rte_pipeline *p)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_out_packet_insert)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_packet_insert);
 int
 rte_pipeline_port_out_packet_insert(struct rte_pipeline *p,
 	uint32_t port_id, struct rte_mbuf *pkt)
@@ -1498,7 +1498,7 @@ rte_pipeline_port_out_packet_insert(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_hijack)
+RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_hijack);
 int rte_pipeline_ah_packet_hijack(struct rte_pipeline *p,
 	uint64_t pkts_mask)
 {
@@ -1508,7 +1508,7 @@ int rte_pipeline_ah_packet_hijack(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_drop)
+RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_drop);
 int rte_pipeline_ah_packet_drop(struct rte_pipeline *p,
 	uint64_t pkts_mask)
 {
@@ -1520,7 +1520,7 @@ int rte_pipeline_ah_packet_drop(struct rte_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_in_stats_read)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_stats_read);
 int rte_pipeline_port_in_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	struct rte_pipeline_port_in_stats *stats, int clear)
 {
@@ -1558,7 +1558,7 @@ int rte_pipeline_port_in_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_port_out_stats_read)
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_stats_read);
 int rte_pipeline_port_out_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	struct rte_pipeline_port_out_stats *stats, int clear)
 {
@@ -1593,7 +1593,7 @@ int rte_pipeline_port_out_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pipeline_table_stats_read)
+RTE_EXPORT_SYMBOL(rte_pipeline_table_stats_read);
 int rte_pipeline_table_stats_read(struct rte_pipeline *p, uint32_t table_id,
 	struct rte_pipeline_table_stats *stats, int clear)
 {
diff --git a/lib/port/rte_port_ethdev.c b/lib/port/rte_port_ethdev.c
index bdab2fbf6c..970214b17b 100644
--- a/lib/port/rte_port_ethdev.c
+++ b/lib/port/rte_port_ethdev.c
@@ -501,7 +501,7 @@ static int rte_port_ethdev_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_ethdev_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_ethdev_reader_ops);
 struct rte_port_in_ops rte_port_ethdev_reader_ops = {
 	.f_create = rte_port_ethdev_reader_create,
 	.f_free = rte_port_ethdev_reader_free,
@@ -509,7 +509,7 @@ struct rte_port_in_ops rte_port_ethdev_reader_ops = {
 	.f_stats = rte_port_ethdev_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_ops);
 struct rte_port_out_ops rte_port_ethdev_writer_ops = {
 	.f_create = rte_port_ethdev_writer_create,
 	.f_free = rte_port_ethdev_writer_free,
@@ -519,7 +519,7 @@ struct rte_port_out_ops rte_port_ethdev_writer_ops = {
 	.f_stats = rte_port_ethdev_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_nodrop_ops)
+RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_nodrop_ops);
 struct rte_port_out_ops rte_port_ethdev_writer_nodrop_ops = {
 	.f_create = rte_port_ethdev_writer_nodrop_create,
 	.f_free = rte_port_ethdev_writer_nodrop_free,
diff --git a/lib/port/rte_port_fd.c b/lib/port/rte_port_fd.c
index dbc9efef1b..1f210986bd 100644
--- a/lib/port/rte_port_fd.c
+++ b/lib/port/rte_port_fd.c
@@ -495,7 +495,7 @@ static int rte_port_fd_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_fd_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_fd_reader_ops);
 struct rte_port_in_ops rte_port_fd_reader_ops = {
 	.f_create = rte_port_fd_reader_create,
 	.f_free = rte_port_fd_reader_free,
@@ -503,7 +503,7 @@ struct rte_port_in_ops rte_port_fd_reader_ops = {
 	.f_stats = rte_port_fd_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_fd_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_fd_writer_ops);
 struct rte_port_out_ops rte_port_fd_writer_ops = {
 	.f_create = rte_port_fd_writer_create,
 	.f_free = rte_port_fd_writer_free,
@@ -513,7 +513,7 @@ struct rte_port_out_ops rte_port_fd_writer_ops = {
 	.f_stats = rte_port_fd_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_fd_writer_nodrop_ops)
+RTE_EXPORT_SYMBOL(rte_port_fd_writer_nodrop_ops);
 struct rte_port_out_ops rte_port_fd_writer_nodrop_ops = {
 	.f_create = rte_port_fd_writer_nodrop_create,
 	.f_free = rte_port_fd_writer_nodrop_free,
diff --git a/lib/port/rte_port_frag.c b/lib/port/rte_port_frag.c
index 9444f5939c..914b276031 100644
--- a/lib/port/rte_port_frag.c
+++ b/lib/port/rte_port_frag.c
@@ -263,7 +263,7 @@ rte_port_frag_reader_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv4_frag_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv4_frag_ops);
 struct rte_port_in_ops rte_port_ring_reader_ipv4_frag_ops = {
 	.f_create = rte_port_ring_reader_ipv4_frag_create,
 	.f_free = rte_port_ring_reader_frag_free,
@@ -271,7 +271,7 @@ struct rte_port_in_ops rte_port_ring_reader_ipv4_frag_ops = {
 	.f_stats = rte_port_frag_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv6_frag_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv6_frag_ops);
 struct rte_port_in_ops rte_port_ring_reader_ipv6_frag_ops = {
 	.f_create = rte_port_ring_reader_ipv6_frag_create,
 	.f_free = rte_port_ring_reader_frag_free,
diff --git a/lib/port/rte_port_ras.c b/lib/port/rte_port_ras.c
index 58ab7a1c5b..1bffbce8ee 100644
--- a/lib/port/rte_port_ras.c
+++ b/lib/port/rte_port_ras.c
@@ -315,7 +315,7 @@ rte_port_ras_writer_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv4_ras_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv4_ras_ops);
 struct rte_port_out_ops rte_port_ring_writer_ipv4_ras_ops = {
 	.f_create = rte_port_ring_writer_ipv4_ras_create,
 	.f_free = rte_port_ring_writer_ras_free,
@@ -325,7 +325,7 @@ struct rte_port_out_ops rte_port_ring_writer_ipv4_ras_ops = {
 	.f_stats = rte_port_ras_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv6_ras_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv6_ras_ops);
 struct rte_port_out_ops rte_port_ring_writer_ipv6_ras_ops = {
 	.f_create = rte_port_ring_writer_ipv6_ras_create,
 	.f_free = rte_port_ring_writer_ras_free,
diff --git a/lib/port/rte_port_ring.c b/lib/port/rte_port_ring.c
index 307a576d65..dc61b20aa6 100644
--- a/lib/port/rte_port_ring.c
+++ b/lib/port/rte_port_ring.c
@@ -739,7 +739,7 @@ rte_port_ring_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_ring_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ops);
 struct rte_port_in_ops rte_port_ring_reader_ops = {
 	.f_create = rte_port_ring_reader_create,
 	.f_free = rte_port_ring_reader_free,
@@ -747,7 +747,7 @@ struct rte_port_in_ops rte_port_ring_reader_ops = {
 	.f_stats = rte_port_ring_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ops);
 struct rte_port_out_ops rte_port_ring_writer_ops = {
 	.f_create = rte_port_ring_writer_create,
 	.f_free = rte_port_ring_writer_free,
@@ -757,7 +757,7 @@ struct rte_port_out_ops rte_port_ring_writer_ops = {
 	.f_stats = rte_port_ring_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_writer_nodrop_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_nodrop_ops);
 struct rte_port_out_ops rte_port_ring_writer_nodrop_ops = {
 	.f_create = rte_port_ring_writer_nodrop_create,
 	.f_free = rte_port_ring_writer_nodrop_free,
@@ -767,7 +767,7 @@ struct rte_port_out_ops rte_port_ring_writer_nodrop_ops = {
 	.f_stats = rte_port_ring_writer_nodrop_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_multi_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_reader_ops);
 struct rte_port_in_ops rte_port_ring_multi_reader_ops = {
 	.f_create = rte_port_ring_multi_reader_create,
 	.f_free = rte_port_ring_reader_free,
@@ -775,7 +775,7 @@ struct rte_port_in_ops rte_port_ring_multi_reader_ops = {
 	.f_stats = rte_port_ring_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_ops);
 struct rte_port_out_ops rte_port_ring_multi_writer_ops = {
 	.f_create = rte_port_ring_multi_writer_create,
 	.f_free = rte_port_ring_writer_free,
@@ -785,7 +785,7 @@ struct rte_port_out_ops rte_port_ring_multi_writer_ops = {
 	.f_stats = rte_port_ring_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_nodrop_ops)
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_nodrop_ops);
 struct rte_port_out_ops rte_port_ring_multi_writer_nodrop_ops = {
 	.f_create = rte_port_ring_multi_writer_nodrop_create,
 	.f_free = rte_port_ring_writer_nodrop_free,
diff --git a/lib/port/rte_port_sched.c b/lib/port/rte_port_sched.c
index 3091078aa1..ab46e8dec6 100644
--- a/lib/port/rte_port_sched.c
+++ b/lib/port/rte_port_sched.c
@@ -279,7 +279,7 @@ rte_port_sched_writer_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_sched_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_sched_reader_ops);
 struct rte_port_in_ops rte_port_sched_reader_ops = {
 	.f_create = rte_port_sched_reader_create,
 	.f_free = rte_port_sched_reader_free,
@@ -287,7 +287,7 @@ struct rte_port_in_ops rte_port_sched_reader_ops = {
 	.f_stats = rte_port_sched_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_sched_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_sched_writer_ops);
 struct rte_port_out_ops rte_port_sched_writer_ops = {
 	.f_create = rte_port_sched_writer_create,
 	.f_free = rte_port_sched_writer_free,
diff --git a/lib/port/rte_port_source_sink.c b/lib/port/rte_port_source_sink.c
index 0557e12506..a492fa55ec 100644
--- a/lib/port/rte_port_source_sink.c
+++ b/lib/port/rte_port_source_sink.c
@@ -597,7 +597,7 @@ rte_port_sink_stats_read(void *port, struct rte_port_out_stats *stats,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_source_ops)
+RTE_EXPORT_SYMBOL(rte_port_source_ops);
 struct rte_port_in_ops rte_port_source_ops = {
 	.f_create = rte_port_source_create,
 	.f_free = rte_port_source_free,
@@ -605,7 +605,7 @@ struct rte_port_in_ops rte_port_source_ops = {
 	.f_stats = rte_port_source_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_sink_ops)
+RTE_EXPORT_SYMBOL(rte_port_sink_ops);
 struct rte_port_out_ops rte_port_sink_ops = {
 	.f_create = rte_port_sink_create,
 	.f_free = rte_port_sink_free,
diff --git a/lib/port/rte_port_sym_crypto.c b/lib/port/rte_port_sym_crypto.c
index 30c9d1283e..bfd6a82b56 100644
--- a/lib/port/rte_port_sym_crypto.c
+++ b/lib/port/rte_port_sym_crypto.c
@@ -529,7 +529,7 @@ static int rte_port_sym_crypto_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
-RTE_EXPORT_SYMBOL(rte_port_sym_crypto_reader_ops)
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_reader_ops);
 struct rte_port_in_ops rte_port_sym_crypto_reader_ops = {
 	.f_create = rte_port_sym_crypto_reader_create,
 	.f_free = rte_port_sym_crypto_reader_free,
@@ -537,7 +537,7 @@ struct rte_port_in_ops rte_port_sym_crypto_reader_ops = {
 	.f_stats = rte_port_sym_crypto_reader_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_ops)
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_ops);
 struct rte_port_out_ops rte_port_sym_crypto_writer_ops = {
 	.f_create = rte_port_sym_crypto_writer_create,
 	.f_free = rte_port_sym_crypto_writer_free,
@@ -547,7 +547,7 @@ struct rte_port_out_ops rte_port_sym_crypto_writer_ops = {
 	.f_stats = rte_port_sym_crypto_writer_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_nodrop_ops)
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_nodrop_ops);
 struct rte_port_out_ops rte_port_sym_crypto_writer_nodrop_ops = {
 	.f_create = rte_port_sym_crypto_writer_nodrop_create,
 	.f_free = rte_port_sym_crypto_writer_nodrop_free,
diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index d4db03a4e5..635ed72a6d 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -46,7 +46,7 @@ rte_power_register_cpufreq_ops(struct rte_power_cpufreq_ops *driver_ops)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_check_env_supported)
+RTE_EXPORT_SYMBOL(rte_power_check_env_supported);
 int
 rte_power_check_env_supported(enum power_management_env env)
 {
@@ -63,7 +63,7 @@ rte_power_check_env_supported(enum power_management_env env)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_set_env)
+RTE_EXPORT_SYMBOL(rte_power_set_env);
 int
 rte_power_set_env(enum power_management_env env)
 {
@@ -93,7 +93,7 @@ rte_power_set_env(enum power_management_env env)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_unset_env)
+RTE_EXPORT_SYMBOL(rte_power_unset_env);
 void
 rte_power_unset_env(void)
 {
@@ -103,13 +103,13 @@ rte_power_unset_env(void)
 	rte_spinlock_unlock(&global_env_cfg_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_get_env)
+RTE_EXPORT_SYMBOL(rte_power_get_env);
 enum power_management_env
 rte_power_get_env(void) {
 	return global_default_env;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_init)
+RTE_EXPORT_SYMBOL(rte_power_init);
 int
 rte_power_init(unsigned int lcore_id)
 {
@@ -143,7 +143,7 @@ rte_power_init(unsigned int lcore_id)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_exit)
+RTE_EXPORT_SYMBOL(rte_power_exit);
 int
 rte_power_exit(unsigned int lcore_id)
 {
@@ -156,7 +156,7 @@ rte_power_exit(unsigned int lcore_id)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freqs)
+RTE_EXPORT_SYMBOL(rte_power_freqs);
 uint32_t
 rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 {
@@ -164,7 +164,7 @@ rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 	return global_cpufreq_ops->get_avail_freqs(lcore_id, freqs, n);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_get_freq)
+RTE_EXPORT_SYMBOL(rte_power_get_freq);
 uint32_t
 rte_power_get_freq(unsigned int lcore_id)
 {
@@ -172,7 +172,7 @@ rte_power_get_freq(unsigned int lcore_id)
 	return global_cpufreq_ops->get_freq(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_set_freq)
+RTE_EXPORT_SYMBOL(rte_power_set_freq);
 uint32_t
 rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 {
@@ -180,7 +180,7 @@ rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 	return global_cpufreq_ops->set_freq(lcore_id, index);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_up)
+RTE_EXPORT_SYMBOL(rte_power_freq_up);
 int
 rte_power_freq_up(unsigned int lcore_id)
 {
@@ -188,7 +188,7 @@ rte_power_freq_up(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_up(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_down)
+RTE_EXPORT_SYMBOL(rte_power_freq_down);
 int
 rte_power_freq_down(unsigned int lcore_id)
 {
@@ -196,7 +196,7 @@ rte_power_freq_down(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_down(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_max)
+RTE_EXPORT_SYMBOL(rte_power_freq_max);
 int
 rte_power_freq_max(unsigned int lcore_id)
 {
@@ -204,7 +204,7 @@ rte_power_freq_max(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_max(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_min)
+RTE_EXPORT_SYMBOL(rte_power_freq_min);
 int
 rte_power_freq_min(unsigned int lcore_id)
 {
@@ -212,7 +212,7 @@ rte_power_freq_min(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_min(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_turbo_status)
+RTE_EXPORT_SYMBOL(rte_power_turbo_status);
 int
 rte_power_turbo_status(unsigned int lcore_id)
 {
@@ -220,7 +220,7 @@ rte_power_turbo_status(unsigned int lcore_id)
 	return global_cpufreq_ops->turbo_status(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_enable_turbo)
+RTE_EXPORT_SYMBOL(rte_power_freq_enable_turbo);
 int
 rte_power_freq_enable_turbo(unsigned int lcore_id)
 {
@@ -228,7 +228,7 @@ rte_power_freq_enable_turbo(unsigned int lcore_id)
 	return global_cpufreq_ops->enable_turbo(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_freq_disable_turbo)
+RTE_EXPORT_SYMBOL(rte_power_freq_disable_turbo);
 int
 rte_power_freq_disable_turbo(unsigned int lcore_id)
 {
@@ -236,7 +236,7 @@ rte_power_freq_disable_turbo(unsigned int lcore_id)
 	return global_cpufreq_ops->disable_turbo(lcore_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_get_capabilities)
+RTE_EXPORT_SYMBOL(rte_power_get_capabilities);
 int
 rte_power_get_capabilities(unsigned int lcore_id,
 		struct rte_power_core_capabilities *caps)
diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index 6cacc562c2..77b940f493 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -497,7 +497,7 @@ get_monitor_callback(void)
 		clb_multiwait : clb_umwait;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_enable)
+RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_enable);
 int
 rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 		uint16_t queue_id, enum rte_power_pmd_mgmt_type mode)
@@ -615,7 +615,7 @@ rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_disable)
+RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_disable);
 int
 rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 		uint16_t port_id, uint16_t queue_id)
@@ -691,21 +691,21 @@ rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_emptypoll_max)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_emptypoll_max);
 void
 rte_power_pmd_mgmt_set_emptypoll_max(unsigned int max)
 {
 	emptypoll_max = max;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_emptypoll_max)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_emptypoll_max);
 unsigned int
 rte_power_pmd_mgmt_get_emptypoll_max(void)
 {
 	return emptypoll_max;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_pause_duration)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_pause_duration);
 int
 rte_power_pmd_mgmt_set_pause_duration(unsigned int duration)
 {
@@ -718,14 +718,14 @@ rte_power_pmd_mgmt_set_pause_duration(unsigned int duration)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_pause_duration)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_pause_duration);
 unsigned int
 rte_power_pmd_mgmt_get_pause_duration(void)
 {
 	return pause_duration;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_min)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_min);
 int
 rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 {
@@ -743,7 +743,7 @@ rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_max)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_max);
 int
 rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 {
@@ -765,7 +765,7 @@ rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_min)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_min);
 int
 rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 {
@@ -780,7 +780,7 @@ rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 	return scale_freq_min[lcore];
 }
 
-RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_max)
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_max);
 int
 rte_power_pmd_mgmt_get_scaling_freq_max(unsigned int lcore)
 {
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 30cd374127..24870fc7c3 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -102,7 +102,7 @@ rte_power_get_uncore_env(void)
 	return global_uncore_env;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_init)
+RTE_EXPORT_SYMBOL(rte_power_uncore_init);
 int
 rte_power_uncore_init(unsigned int pkg, unsigned int die)
 {
@@ -134,7 +134,7 @@ rte_power_uncore_init(unsigned int pkg, unsigned int die)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_exit)
+RTE_EXPORT_SYMBOL(rte_power_uncore_exit);
 int
 rte_power_uncore_exit(unsigned int pkg, unsigned int die)
 {
@@ -148,7 +148,7 @@ rte_power_uncore_exit(unsigned int pkg, unsigned int die)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_get_uncore_freq)
+RTE_EXPORT_SYMBOL(rte_power_get_uncore_freq);
 uint32_t
 rte_power_get_uncore_freq(unsigned int pkg, unsigned int die)
 {
@@ -156,7 +156,7 @@ rte_power_get_uncore_freq(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->get_freq(pkg, die);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_set_uncore_freq)
+RTE_EXPORT_SYMBOL(rte_power_set_uncore_freq);
 int
 rte_power_set_uncore_freq(unsigned int pkg, unsigned int die, uint32_t index)
 {
@@ -164,7 +164,7 @@ rte_power_set_uncore_freq(unsigned int pkg, unsigned int die, uint32_t index)
 	return global_uncore_ops->set_freq(pkg, die, index);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_freq_max)
+RTE_EXPORT_SYMBOL(rte_power_uncore_freq_max);
 int
 rte_power_uncore_freq_max(unsigned int pkg, unsigned int die)
 {
@@ -172,7 +172,7 @@ rte_power_uncore_freq_max(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->freq_max(pkg, die);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_freq_min)
+RTE_EXPORT_SYMBOL(rte_power_uncore_freq_min);
 int
 rte_power_uncore_freq_min(unsigned int pkg, unsigned int die)
 {
@@ -189,7 +189,7 @@ rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 	return global_uncore_ops->get_avail_freqs(pkg, die, freqs, num);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_freqs)
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_freqs);
 int
 rte_power_uncore_get_num_freqs(unsigned int pkg, unsigned int die)
 {
@@ -197,7 +197,7 @@ rte_power_uncore_get_num_freqs(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->get_num_freqs(pkg, die);
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_pkgs)
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_pkgs);
 unsigned int
 rte_power_uncore_get_num_pkgs(void)
 {
@@ -205,7 +205,7 @@ rte_power_uncore_get_num_pkgs(void)
 	return global_uncore_ops->get_num_pkgs();
 }
 
-RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_dies)
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_dies);
 unsigned int
 rte_power_uncore_get_num_dies(unsigned int pkg)
 {
diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index 4da7956d5a..e1ea7667dc 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -23,7 +23,7 @@
 
 static struct rte_rawdev rte_rawdevices[RTE_RAWDEV_MAX_DEVS];
 
-RTE_EXPORT_SYMBOL(rte_rawdevs)
+RTE_EXPORT_SYMBOL(rte_rawdevs);
 struct rte_rawdev *rte_rawdevs = rte_rawdevices;
 
 static struct rte_rawdev_global rawdev_globals = {
@@ -31,14 +31,14 @@ static struct rte_rawdev_global rawdev_globals = {
 };
 
 /* Raw device, northbound API implementation */
-RTE_EXPORT_SYMBOL(rte_rawdev_count)
+RTE_EXPORT_SYMBOL(rte_rawdev_count);
 uint8_t
 rte_rawdev_count(void)
 {
 	return rawdev_globals.nb_devs;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_get_dev_id)
+RTE_EXPORT_SYMBOL(rte_rawdev_get_dev_id);
 uint16_t
 rte_rawdev_get_dev_id(const char *name)
 {
@@ -56,7 +56,7 @@ rte_rawdev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_socket_id)
+RTE_EXPORT_SYMBOL(rte_rawdev_socket_id);
 int
 rte_rawdev_socket_id(uint16_t dev_id)
 {
@@ -68,7 +68,7 @@ rte_rawdev_socket_id(uint16_t dev_id)
 	return dev->socket_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_info_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_info_get);
 int
 rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 		size_t dev_private_size)
@@ -97,7 +97,7 @@ rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_configure)
+RTE_EXPORT_SYMBOL(rte_rawdev_configure);
 int
 rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 		size_t dev_private_size)
@@ -130,7 +130,7 @@ rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 	return diag;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_queue_conf_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_conf_get);
 int
 rte_rawdev_queue_conf_get(uint16_t dev_id,
 			  uint16_t queue_id,
@@ -147,7 +147,7 @@ rte_rawdev_queue_conf_get(uint16_t dev_id,
 	return dev->dev_ops->queue_def_conf(dev, queue_id, queue_conf, queue_conf_size);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_queue_setup)
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_setup);
 int
 rte_rawdev_queue_setup(uint16_t dev_id,
 		       uint16_t queue_id,
@@ -164,7 +164,7 @@ rte_rawdev_queue_setup(uint16_t dev_id,
 	return dev->dev_ops->queue_setup(dev, queue_id, queue_conf, queue_conf_size);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_queue_release)
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_release);
 int
 rte_rawdev_queue_release(uint16_t dev_id, uint16_t queue_id)
 {
@@ -178,7 +178,7 @@ rte_rawdev_queue_release(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_release(dev, queue_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_queue_count)
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_count);
 uint16_t
 rte_rawdev_queue_count(uint16_t dev_id)
 {
@@ -192,7 +192,7 @@ rte_rawdev_queue_count(uint16_t dev_id)
 	return dev->dev_ops->queue_count(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_get_attr)
+RTE_EXPORT_SYMBOL(rte_rawdev_get_attr);
 int
 rte_rawdev_get_attr(uint16_t dev_id,
 		    const char *attr_name,
@@ -208,7 +208,7 @@ rte_rawdev_get_attr(uint16_t dev_id,
 	return dev->dev_ops->attr_get(dev, attr_name, attr_value);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_set_attr)
+RTE_EXPORT_SYMBOL(rte_rawdev_set_attr);
 int
 rte_rawdev_set_attr(uint16_t dev_id,
 		    const char *attr_name,
@@ -224,7 +224,7 @@ rte_rawdev_set_attr(uint16_t dev_id,
 	return dev->dev_ops->attr_set(dev, attr_name, attr_value);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_enqueue_buffers)
+RTE_EXPORT_SYMBOL(rte_rawdev_enqueue_buffers);
 int
 rte_rawdev_enqueue_buffers(uint16_t dev_id,
 			   struct rte_rawdev_buf **buffers,
@@ -241,7 +241,7 @@ rte_rawdev_enqueue_buffers(uint16_t dev_id,
 	return dev->dev_ops->enqueue_bufs(dev, buffers, count, context);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_dequeue_buffers)
+RTE_EXPORT_SYMBOL(rte_rawdev_dequeue_buffers);
 int
 rte_rawdev_dequeue_buffers(uint16_t dev_id,
 			   struct rte_rawdev_buf **buffers,
@@ -258,7 +258,7 @@ rte_rawdev_dequeue_buffers(uint16_t dev_id,
 	return dev->dev_ops->dequeue_bufs(dev, buffers, count, context);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_dump)
+RTE_EXPORT_SYMBOL(rte_rawdev_dump);
 int
 rte_rawdev_dump(uint16_t dev_id, FILE *f)
 {
@@ -282,7 +282,7 @@ xstats_get_count(uint16_t dev_id)
 	return dev->dev_ops->xstats_get_names(dev, NULL, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_xstats_names_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_names_get);
 int
 rte_rawdev_xstats_names_get(uint16_t dev_id,
 		struct rte_rawdev_xstats_name *xstats_names,
@@ -307,7 +307,7 @@ rte_rawdev_xstats_names_get(uint16_t dev_id,
 }
 
 /* retrieve rawdev extended statistics */
-RTE_EXPORT_SYMBOL(rte_rawdev_xstats_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_get);
 int
 rte_rawdev_xstats_get(uint16_t dev_id,
 		      const unsigned int ids[],
@@ -322,7 +322,7 @@ rte_rawdev_xstats_get(uint16_t dev_id,
 	return dev->dev_ops->xstats_get(dev, ids, values, n);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_xstats_by_name_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_by_name_get);
 uint64_t
 rte_rawdev_xstats_by_name_get(uint16_t dev_id,
 			      const char *name,
@@ -343,7 +343,7 @@ rte_rawdev_xstats_by_name_get(uint16_t dev_id,
 	return dev->dev_ops->xstats_get_by_name(dev, name, id);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_xstats_reset)
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_reset);
 int
 rte_rawdev_xstats_reset(uint16_t dev_id,
 			const uint32_t ids[], uint32_t nb_ids)
@@ -356,7 +356,7 @@ rte_rawdev_xstats_reset(uint16_t dev_id,
 	return dev->dev_ops->xstats_reset(dev, ids, nb_ids);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_firmware_status_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_status_get);
 int
 rte_rawdev_firmware_status_get(uint16_t dev_id, rte_rawdev_obj_t status_info)
 {
@@ -368,7 +368,7 @@ rte_rawdev_firmware_status_get(uint16_t dev_id, rte_rawdev_obj_t status_info)
 	return dev->dev_ops->firmware_status_get(dev, status_info);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_firmware_version_get)
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_version_get);
 int
 rte_rawdev_firmware_version_get(uint16_t dev_id, rte_rawdev_obj_t version_info)
 {
@@ -380,7 +380,7 @@ rte_rawdev_firmware_version_get(uint16_t dev_id, rte_rawdev_obj_t version_info)
 	return dev->dev_ops->firmware_version_get(dev, version_info);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_firmware_load)
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_load);
 int
 rte_rawdev_firmware_load(uint16_t dev_id, rte_rawdev_obj_t firmware_image)
 {
@@ -395,7 +395,7 @@ rte_rawdev_firmware_load(uint16_t dev_id, rte_rawdev_obj_t firmware_image)
 	return dev->dev_ops->firmware_load(dev, firmware_image);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_firmware_unload)
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_unload);
 int
 rte_rawdev_firmware_unload(uint16_t dev_id)
 {
@@ -407,7 +407,7 @@ rte_rawdev_firmware_unload(uint16_t dev_id)
 	return dev->dev_ops->firmware_unload(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_selftest)
+RTE_EXPORT_SYMBOL(rte_rawdev_selftest);
 int
 rte_rawdev_selftest(uint16_t dev_id)
 {
@@ -419,7 +419,7 @@ rte_rawdev_selftest(uint16_t dev_id)
 	return dev->dev_ops->dev_selftest(dev_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_start)
+RTE_EXPORT_SYMBOL(rte_rawdev_start);
 int
 rte_rawdev_start(uint16_t dev_id)
 {
@@ -448,7 +448,7 @@ rte_rawdev_start(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_stop)
+RTE_EXPORT_SYMBOL(rte_rawdev_stop);
 void
 rte_rawdev_stop(uint16_t dev_id)
 {
@@ -474,7 +474,7 @@ rte_rawdev_stop(uint16_t dev_id)
 	dev->started = 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_close)
+RTE_EXPORT_SYMBOL(rte_rawdev_close);
 int
 rte_rawdev_close(uint16_t dev_id)
 {
@@ -495,7 +495,7 @@ rte_rawdev_close(uint16_t dev_id)
 	return dev->dev_ops->dev_close(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_reset)
+RTE_EXPORT_SYMBOL(rte_rawdev_reset);
 int
 rte_rawdev_reset(uint16_t dev_id)
 {
@@ -524,7 +524,7 @@ rte_rawdev_find_free_device_index(void)
 	return RTE_RAWDEV_MAX_DEVS;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_pmd_allocate)
+RTE_EXPORT_SYMBOL(rte_rawdev_pmd_allocate);
 struct rte_rawdev *
 rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 {
@@ -566,7 +566,7 @@ rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 	return rawdev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rawdev_pmd_release)
+RTE_EXPORT_SYMBOL(rte_rawdev_pmd_release);
 int
 rte_rawdev_pmd_release(struct rte_rawdev *rawdev)
 {
diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index ac6d464b7f..b9c4e8b2e1 100644
--- a/lib/rcu/rte_rcu_qsbr.c
+++ b/lib/rcu/rte_rcu_qsbr.c
@@ -24,7 +24,7 @@
 	RTE_LOG_LINE_PREFIX(level, RCU, "%s(): ", __func__, __VA_ARGS__)
 
 /* Get the memory size of QSBR variable */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_get_memsize)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_get_memsize);
 size_t
 rte_rcu_qsbr_get_memsize(uint32_t max_threads)
 {
@@ -49,7 +49,7 @@ rte_rcu_qsbr_get_memsize(uint32_t max_threads)
 }
 
 /* Initialize a quiescent state variable */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_init)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_init);
 int
 rte_rcu_qsbr_init(struct rte_rcu_qsbr *v, uint32_t max_threads)
 {
@@ -81,7 +81,7 @@ rte_rcu_qsbr_init(struct rte_rcu_qsbr *v, uint32_t max_threads)
 /* Register a reader thread to report its quiescent state
  * on a QS variable.
  */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_register)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_register);
 int
 rte_rcu_qsbr_thread_register(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -117,7 +117,7 @@ rte_rcu_qsbr_thread_register(struct rte_rcu_qsbr *v, unsigned int thread_id)
 /* Remove a reader thread, from the list of threads reporting their
  * quiescent state on a QS variable.
  */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_unregister)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_unregister);
 int
 rte_rcu_qsbr_thread_unregister(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -154,7 +154,7 @@ rte_rcu_qsbr_thread_unregister(struct rte_rcu_qsbr *v, unsigned int thread_id)
 }
 
 /* Wait till the reader threads have entered quiescent state. */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_synchronize)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_synchronize);
 void
 rte_rcu_qsbr_synchronize(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -175,7 +175,7 @@ rte_rcu_qsbr_synchronize(struct rte_rcu_qsbr *v, unsigned int thread_id)
 }
 
 /* Dump the details of a single quiescent state variable to a file. */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dump)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dump);
 int
 rte_rcu_qsbr_dump(FILE *f, struct rte_rcu_qsbr *v)
 {
@@ -242,7 +242,7 @@ rte_rcu_qsbr_dump(FILE *f, struct rte_rcu_qsbr *v)
 /* Create a queue used to store the data structure elements that can
  * be freed later. This queue is referred to as 'defer queue'.
  */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_create)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_create);
 struct rte_rcu_qsbr_dq *
 rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 {
@@ -319,7 +319,7 @@ rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 /* Enqueue one resource to the defer queue to free after the grace
  * period is over.
  */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_enqueue)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_enqueue);
 int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 {
 	__rte_rcu_qsbr_dq_elem_t *dq_elem;
@@ -378,7 +378,7 @@ int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 }
 
 /* Reclaim resources from the defer queue. */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_reclaim)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_reclaim);
 int
 rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 			unsigned int *freed, unsigned int *pending,
@@ -428,7 +428,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 }
 
 /* Delete a defer queue. */
-RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_delete)
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_delete);
 int
 rte_rcu_qsbr_dq_delete(struct rte_rcu_qsbr_dq *dq)
 {
@@ -454,5 +454,5 @@ rte_rcu_qsbr_dq_delete(struct rte_rcu_qsbr_dq *dq)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rcu_log_type)
+RTE_EXPORT_SYMBOL(rte_rcu_log_type);
 RTE_LOG_REGISTER_DEFAULT(rte_rcu_log_type, ERR);
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index be06530860..583d365d55 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -68,7 +68,7 @@ rte_reorder_memory_footprint_get(unsigned int size)
 	return sizeof(struct rte_reorder_buffer) + (2 * size * sizeof(struct rte_mbuf *));
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_init)
+RTE_EXPORT_SYMBOL(rte_reorder_init);
 struct rte_reorder_buffer *
 rte_reorder_init(struct rte_reorder_buffer *b, unsigned int bufsize,
 		const char *name, unsigned int size)
@@ -158,7 +158,7 @@ rte_reorder_entry_insert(struct rte_tailq_entry *new_te)
 	return te;
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_create)
+RTE_EXPORT_SYMBOL(rte_reorder_create);
 struct rte_reorder_buffer*
 rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
 {
@@ -215,7 +215,7 @@ rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
 	return b;
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_reset)
+RTE_EXPORT_SYMBOL(rte_reorder_reset);
 void
 rte_reorder_reset(struct rte_reorder_buffer *b)
 {
@@ -239,7 +239,7 @@ rte_reorder_free_mbufs(struct rte_reorder_buffer *b)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_free)
+RTE_EXPORT_SYMBOL(rte_reorder_free);
 void
 rte_reorder_free(struct rte_reorder_buffer *b)
 {
@@ -274,7 +274,7 @@ rte_reorder_free(struct rte_reorder_buffer *b)
 	rte_free(te);
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_find_existing)
+RTE_EXPORT_SYMBOL(rte_reorder_find_existing);
 struct rte_reorder_buffer *
 rte_reorder_find_existing(const char *name)
 {
@@ -356,7 +356,7 @@ rte_reorder_fill_overflow(struct rte_reorder_buffer *b, unsigned n)
 	return order_head_adv;
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_insert)
+RTE_EXPORT_SYMBOL(rte_reorder_insert);
 int
 rte_reorder_insert(struct rte_reorder_buffer *b, struct rte_mbuf *mbuf)
 {
@@ -423,7 +423,7 @@ rte_reorder_insert(struct rte_reorder_buffer *b, struct rte_mbuf *mbuf)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_reorder_drain)
+RTE_EXPORT_SYMBOL(rte_reorder_drain);
 unsigned int
 rte_reorder_drain(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		unsigned max_mbufs)
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..216ac4180c 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -102,7 +102,7 @@ node_free(struct rte_rib *rib, struct rte_rib_node *ent)
 	rte_mempool_put(rib->node_pool, ent);
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_lookup)
+RTE_EXPORT_SYMBOL(rte_rib_lookup);
 struct rte_rib_node *
 rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
 {
@@ -122,7 +122,7 @@ rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
 	return prev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_lookup_parent)
+RTE_EXPORT_SYMBOL(rte_rib_lookup_parent);
 struct rte_rib_node *
 rte_rib_lookup_parent(struct rte_rib_node *ent)
 {
@@ -154,7 +154,7 @@ __rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_lookup_exact)
+RTE_EXPORT_SYMBOL(rte_rib_lookup_exact);
 struct rte_rib_node *
 rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -172,7 +172,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
  *  for a given in args ip/depth prefix
  *  last = NULL means the first invocation
  */
-RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
+RTE_EXPORT_SYMBOL(rte_rib_get_nxt);
 struct rte_rib_node *
 rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	uint8_t depth, struct rte_rib_node *last, int flag)
@@ -213,7 +213,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	return prev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_remove)
+RTE_EXPORT_SYMBOL(rte_rib_remove);
 void
 rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -246,7 +246,7 @@ rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_insert)
+RTE_EXPORT_SYMBOL(rte_rib_insert);
 struct rte_rib_node *
 rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -353,7 +353,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return new_node;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_get_ip)
+RTE_EXPORT_SYMBOL(rte_rib_get_ip);
 int
 rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
 {
@@ -365,7 +365,7 @@ rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_get_depth)
+RTE_EXPORT_SYMBOL(rte_rib_get_depth);
 int
 rte_rib_get_depth(const struct rte_rib_node *node, uint8_t *depth)
 {
@@ -377,14 +377,14 @@ rte_rib_get_depth(const struct rte_rib_node *node, uint8_t *depth)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_get_ext)
+RTE_EXPORT_SYMBOL(rte_rib_get_ext);
 void *
 rte_rib_get_ext(struct rte_rib_node *node)
 {
 	return (node == NULL) ? NULL : &node->ext[0];
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_get_nh)
+RTE_EXPORT_SYMBOL(rte_rib_get_nh);
 int
 rte_rib_get_nh(const struct rte_rib_node *node, uint64_t *nh)
 {
@@ -396,7 +396,7 @@ rte_rib_get_nh(const struct rte_rib_node *node, uint64_t *nh)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_set_nh)
+RTE_EXPORT_SYMBOL(rte_rib_set_nh);
 int
 rte_rib_set_nh(struct rte_rib_node *node, uint64_t nh)
 {
@@ -408,7 +408,7 @@ rte_rib_set_nh(struct rte_rib_node *node, uint64_t nh)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_create)
+RTE_EXPORT_SYMBOL(rte_rib_create);
 struct rte_rib *
 rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 {
@@ -490,7 +490,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_find_existing)
+RTE_EXPORT_SYMBOL(rte_rib_find_existing);
 struct rte_rib *
 rte_rib_find_existing(const char *name)
 {
@@ -516,7 +516,7 @@ rte_rib_find_existing(const char *name)
 	return rib;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_free)
+RTE_EXPORT_SYMBOL(rte_rib_free);
 void
 rte_rib_free(struct rte_rib *rib)
 {
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ec8ff68e87..8a752ffc29 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -115,7 +115,7 @@ node_free(struct rte_rib6 *rib, struct rte_rib6_node *ent)
 	rte_mempool_put(rib->node_pool, ent);
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_lookup)
+RTE_EXPORT_SYMBOL(rte_rib6_lookup);
 struct rte_rib6_node *
 rte_rib6_lookup(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip)
@@ -137,7 +137,7 @@ rte_rib6_lookup(struct rte_rib6 *rib,
 	return prev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_lookup_parent)
+RTE_EXPORT_SYMBOL(rte_rib6_lookup_parent);
 struct rte_rib6_node *
 rte_rib6_lookup_parent(struct rte_rib6_node *ent)
 {
@@ -153,7 +153,7 @@ rte_rib6_lookup_parent(struct rte_rib6_node *ent)
 	return tmp;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_lookup_exact)
+RTE_EXPORT_SYMBOL(rte_rib6_lookup_exact);
 struct rte_rib6_node *
 rte_rib6_lookup_exact(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -191,7 +191,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *  for a given in args ip/depth prefix
  *  last = NULL means the first invocation
  */
-RTE_EXPORT_SYMBOL(rte_rib6_get_nxt)
+RTE_EXPORT_SYMBOL(rte_rib6_get_nxt);
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
@@ -237,7 +237,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 	return prev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_remove)
+RTE_EXPORT_SYMBOL(rte_rib6_remove);
 void
 rte_rib6_remove(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -271,7 +271,7 @@ rte_rib6_remove(struct rte_rib6 *rib,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_insert)
+RTE_EXPORT_SYMBOL(rte_rib6_insert);
 struct rte_rib6_node *
 rte_rib6_insert(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -399,7 +399,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 	return new_node;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_get_ip)
+RTE_EXPORT_SYMBOL(rte_rib6_get_ip);
 int
 rte_rib6_get_ip(const struct rte_rib6_node *node,
 		struct rte_ipv6_addr *ip)
@@ -412,7 +412,7 @@ rte_rib6_get_ip(const struct rte_rib6_node *node,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_get_depth)
+RTE_EXPORT_SYMBOL(rte_rib6_get_depth);
 int
 rte_rib6_get_depth(const struct rte_rib6_node *node, uint8_t *depth)
 {
@@ -424,14 +424,14 @@ rte_rib6_get_depth(const struct rte_rib6_node *node, uint8_t *depth)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_get_ext)
+RTE_EXPORT_SYMBOL(rte_rib6_get_ext);
 void *
 rte_rib6_get_ext(struct rte_rib6_node *node)
 {
 	return (node == NULL) ? NULL : &node->ext[0];
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_get_nh)
+RTE_EXPORT_SYMBOL(rte_rib6_get_nh);
 int
 rte_rib6_get_nh(const struct rte_rib6_node *node, uint64_t *nh)
 {
@@ -443,7 +443,7 @@ rte_rib6_get_nh(const struct rte_rib6_node *node, uint64_t *nh)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_set_nh)
+RTE_EXPORT_SYMBOL(rte_rib6_set_nh);
 int
 rte_rib6_set_nh(struct rte_rib6_node *node, uint64_t nh)
 {
@@ -455,7 +455,7 @@ rte_rib6_set_nh(struct rte_rib6_node *node, uint64_t nh)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_create)
+RTE_EXPORT_SYMBOL(rte_rib6_create);
 struct rte_rib6 *
 rte_rib6_create(const char *name, int socket_id,
 		const struct rte_rib6_conf *conf)
@@ -539,7 +539,7 @@ rte_rib6_create(const char *name, int socket_id,
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_find_existing)
+RTE_EXPORT_SYMBOL(rte_rib6_find_existing);
 struct rte_rib6 *
 rte_rib6_find_existing(const char *name)
 {
@@ -570,7 +570,7 @@ rte_rib6_find_existing(const char *name)
 	return rib;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib6_free)
+RTE_EXPORT_SYMBOL(rte_rib6_free);
 void
 rte_rib6_free(struct rte_rib6 *rib)
 {
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index edd63aa535..8ad51b4ab0 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -53,7 +53,7 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
 #define HTD_MAX_DEF	8
 
 /* return the size of memory occupied by a ring */
-RTE_EXPORT_SYMBOL(rte_ring_get_memsize_elem)
+RTE_EXPORT_SYMBOL(rte_ring_get_memsize_elem);
 ssize_t
 rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 {
@@ -81,7 +81,7 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 }
 
 /* return the size of memory occupied by a ring */
-RTE_EXPORT_SYMBOL(rte_ring_get_memsize)
+RTE_EXPORT_SYMBOL(rte_ring_get_memsize);
 ssize_t
 rte_ring_get_memsize(unsigned int count)
 {
@@ -121,7 +121,7 @@ reset_headtail(void *p)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_ring_reset)
+RTE_EXPORT_SYMBOL(rte_ring_reset);
 void
 rte_ring_reset(struct rte_ring *r)
 {
@@ -180,7 +180,7 @@ get_sync_type(uint32_t flags, enum rte_ring_sync_type *prod_st,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_ring_init)
+RTE_EXPORT_SYMBOL(rte_ring_init);
 int
 rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 	unsigned int flags)
@@ -248,7 +248,7 @@ rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 }
 
 /* create the ring for a given element size */
-RTE_EXPORT_SYMBOL(rte_ring_create_elem)
+RTE_EXPORT_SYMBOL(rte_ring_create_elem);
 struct rte_ring *
 rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 		int socket_id, unsigned int flags)
@@ -318,7 +318,7 @@ rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 }
 
 /* create the ring */
-RTE_EXPORT_SYMBOL(rte_ring_create)
+RTE_EXPORT_SYMBOL(rte_ring_create);
 struct rte_ring *
 rte_ring_create(const char *name, unsigned int count, int socket_id,
 		unsigned int flags)
@@ -328,7 +328,7 @@ rte_ring_create(const char *name, unsigned int count, int socket_id,
 }
 
 /* free the ring */
-RTE_EXPORT_SYMBOL(rte_ring_free)
+RTE_EXPORT_SYMBOL(rte_ring_free);
 void
 rte_ring_free(struct rte_ring *r)
 {
@@ -451,7 +451,7 @@ rte_ring_headtail_dump(FILE *f, const char *prefix,
 }
 
 /* dump the status of the ring on the console */
-RTE_EXPORT_SYMBOL(rte_ring_dump)
+RTE_EXPORT_SYMBOL(rte_ring_dump);
 void
 rte_ring_dump(FILE *f, const struct rte_ring *r)
 {
@@ -470,7 +470,7 @@ rte_ring_dump(FILE *f, const struct rte_ring *r)
 }
 
 /* dump the status of all rings on the console */
-RTE_EXPORT_SYMBOL(rte_ring_list_dump)
+RTE_EXPORT_SYMBOL(rte_ring_list_dump);
 void
 rte_ring_list_dump(FILE *f)
 {
@@ -489,7 +489,7 @@ rte_ring_list_dump(FILE *f)
 }
 
 /* search a ring from its name */
-RTE_EXPORT_SYMBOL(rte_ring_lookup)
+RTE_EXPORT_SYMBOL(rte_ring_lookup);
 struct rte_ring *
 rte_ring_lookup(const char *name)
 {
diff --git a/lib/sched/rte_approx.c b/lib/sched/rte_approx.c
index 86c7d1d3fb..bd935a7e36 100644
--- a/lib/sched/rte_approx.c
+++ b/lib/sched/rte_approx.c
@@ -140,7 +140,7 @@ find_best_rational_approximation(uint32_t alpha_num, uint32_t d_num, uint32_t de
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_approx)
+RTE_EXPORT_SYMBOL(rte_approx);
 int rte_approx(double alpha, double d, uint32_t *p, uint32_t *q)
 {
 	uint32_t alpha_num, d_num, denum;
diff --git a/lib/sched/rte_pie.c b/lib/sched/rte_pie.c
index b5d8988894..f483797907 100644
--- a/lib/sched/rte_pie.c
+++ b/lib/sched/rte_pie.c
@@ -10,7 +10,7 @@
 #include "rte_sched_log.h"
 #include "rte_pie.h"
 
-RTE_EXPORT_SYMBOL(rte_pie_rt_data_init)
+RTE_EXPORT_SYMBOL(rte_pie_rt_data_init);
 int
 rte_pie_rt_data_init(struct rte_pie *pie)
 {
@@ -24,7 +24,7 @@ rte_pie_rt_data_init(struct rte_pie *pie)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pie_config_init)
+RTE_EXPORT_SYMBOL(rte_pie_config_init);
 int
 rte_pie_config_init(struct rte_pie_config *pie_cfg,
 	const uint16_t qdelay_ref,
diff --git a/lib/sched/rte_red.c b/lib/sched/rte_red.c
index d7534d0bee..f8d1074695 100644
--- a/lib/sched/rte_red.c
+++ b/lib/sched/rte_red.c
@@ -9,22 +9,22 @@
 #include <rte_common.h>
 
 static int rte_red_init_done = 0;     /**< Flag to indicate that global initialisation is done */
-RTE_EXPORT_SYMBOL(rte_red_rand_val)
+RTE_EXPORT_SYMBOL(rte_red_rand_val);
 uint32_t rte_red_rand_val = 0;        /**< Random value cache */
-RTE_EXPORT_SYMBOL(rte_red_rand_seed)
+RTE_EXPORT_SYMBOL(rte_red_rand_seed);
 uint32_t rte_red_rand_seed = 0;       /**< Seed for random number generation */
 
 /**
  * table[i] = log2(1-Wq) * Scale * -1
  *       Wq = 1/(2^i)
  */
-RTE_EXPORT_SYMBOL(rte_red_log2_1_minus_Wq)
+RTE_EXPORT_SYMBOL(rte_red_log2_1_minus_Wq);
 uint16_t rte_red_log2_1_minus_Wq[RTE_RED_WQ_LOG2_NUM];
 
 /**
  * table[i] = 2^(i/16) * Scale
  */
-RTE_EXPORT_SYMBOL(rte_red_pow2_frac_inv)
+RTE_EXPORT_SYMBOL(rte_red_pow2_frac_inv);
 uint16_t rte_red_pow2_frac_inv[16];
 
 /**
@@ -69,7 +69,7 @@ __rte_red_init_tables(void)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_red_rt_data_init)
+RTE_EXPORT_SYMBOL(rte_red_rt_data_init);
 int
 rte_red_rt_data_init(struct rte_red *red)
 {
@@ -82,7 +82,7 @@ rte_red_rt_data_init(struct rte_red *red)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_red_config_init)
+RTE_EXPORT_SYMBOL(rte_red_config_init);
 int
 rte_red_config_init(struct rte_red_config *red_cfg,
 	const uint16_t wq_log2,
diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index 453f935ac8..9f53bed557 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -884,7 +884,7 @@ rte_sched_subport_check_params(struct rte_sched_subport_params *params,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_get_memory_footprint)
+RTE_EXPORT_SYMBOL(rte_sched_port_get_memory_footprint);
 uint32_t
 rte_sched_port_get_memory_footprint(struct rte_sched_port_params *port_params,
 	struct rte_sched_subport_params **subport_params)
@@ -928,7 +928,7 @@ rte_sched_port_get_memory_footprint(struct rte_sched_port_params *port_params,
 	return size0 + size1;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_config)
+RTE_EXPORT_SYMBOL(rte_sched_port_config);
 struct rte_sched_port *
 rte_sched_port_config(struct rte_sched_port_params *params)
 {
@@ -1049,7 +1049,7 @@ rte_sched_subport_free(struct rte_sched_port *port,
 	rte_free(subport);
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_free)
+RTE_EXPORT_SYMBOL(rte_sched_port_free);
 void
 rte_sched_port_free(struct rte_sched_port *port)
 {
@@ -1163,7 +1163,7 @@ rte_sched_cman_config(struct rte_sched_port *port,
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_subport_tc_ov_config)
+RTE_EXPORT_SYMBOL(rte_sched_subport_tc_ov_config);
 int
 rte_sched_subport_tc_ov_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1189,7 +1189,7 @@ rte_sched_subport_tc_ov_config(struct rte_sched_port *port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_subport_config)
+RTE_EXPORT_SYMBOL(rte_sched_subport_config);
 int
 rte_sched_subport_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1383,7 +1383,7 @@ rte_sched_subport_config(struct rte_sched_port *port,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_pipe_config)
+RTE_EXPORT_SYMBOL(rte_sched_pipe_config);
 int
 rte_sched_pipe_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1508,7 +1508,7 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_subport_pipe_profile_add)
+RTE_EXPORT_SYMBOL(rte_sched_subport_pipe_profile_add);
 int
 rte_sched_subport_pipe_profile_add(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1574,7 +1574,7 @@ rte_sched_subport_pipe_profile_add(struct rte_sched_port *port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_subport_profile_add)
+RTE_EXPORT_SYMBOL(rte_sched_port_subport_profile_add);
 int
 rte_sched_port_subport_profile_add(struct rte_sched_port *port,
 	struct rte_sched_subport_profile_params *params,
@@ -1656,7 +1656,7 @@ rte_sched_port_qindex(struct rte_sched_port *port,
 		(RTE_SCHED_QUEUES_PER_PIPE - 1));
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_pkt_write)
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_write);
 void
 rte_sched_port_pkt_write(struct rte_sched_port *port,
 			 struct rte_mbuf *pkt,
@@ -1670,7 +1670,7 @@ rte_sched_port_pkt_write(struct rte_sched_port *port,
 	rte_mbuf_sched_set(pkt, queue_id, traffic_class, (uint8_t)color);
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_tree_path)
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_tree_path);
 void
 rte_sched_port_pkt_read_tree_path(struct rte_sched_port *port,
 				  const struct rte_mbuf *pkt,
@@ -1686,14 +1686,14 @@ rte_sched_port_pkt_read_tree_path(struct rte_sched_port *port,
 	*queue = rte_sched_port_tc_queue(port, queue_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_color)
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_color);
 enum rte_color
 rte_sched_port_pkt_read_color(const struct rte_mbuf *pkt)
 {
 	return (enum rte_color)rte_mbuf_sched_color_get(pkt);
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_subport_read_stats)
+RTE_EXPORT_SYMBOL(rte_sched_subport_read_stats);
 int
 rte_sched_subport_read_stats(struct rte_sched_port *port,
 			     uint32_t subport_id,
@@ -1739,7 +1739,7 @@ rte_sched_subport_read_stats(struct rte_sched_port *port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_queue_read_stats)
+RTE_EXPORT_SYMBOL(rte_sched_queue_read_stats);
 int
 rte_sched_queue_read_stats(struct rte_sched_port *port,
 	uint32_t queue_id,
@@ -2055,7 +2055,7 @@ rte_sched_port_enqueue_qwa(struct rte_sched_port *port,
  * ----->|_______|----->|_______|----->|_______|----->|_______|----->
  *   p01            p11            p21            p31
  */
-RTE_EXPORT_SYMBOL(rte_sched_port_enqueue)
+RTE_EXPORT_SYMBOL(rte_sched_port_enqueue);
 int
 rte_sched_port_enqueue(struct rte_sched_port *port, struct rte_mbuf **pkts,
 		       uint32_t n_pkts)
@@ -2967,7 +2967,7 @@ rte_sched_port_exceptions(struct rte_sched_subport *subport, int second_pass)
 	return exceptions;
 }
 
-RTE_EXPORT_SYMBOL(rte_sched_port_dequeue)
+RTE_EXPORT_SYMBOL(rte_sched_port_dequeue);
 int
 rte_sched_port_dequeue(struct rte_sched_port *port, struct rte_mbuf **pkts, uint32_t n_pkts)
 {
diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index c47fe44da0..75a73bf941 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -31,7 +31,7 @@
 #define RTE_SECURITY_DYNFIELD_NAME "rte_security_dynfield_metadata"
 #define RTE_SECURITY_OOP_DYNFIELD_NAME "rte_security_oop_dynfield_metadata"
 
-RTE_EXPORT_SYMBOL(rte_security_dynfield_offset)
+RTE_EXPORT_SYMBOL(rte_security_dynfield_offset);
 int rte_security_dynfield_offset = -1;
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_oop_dynfield_offset, 23.11)
 int rte_security_oop_dynfield_offset = -1;
@@ -65,7 +65,7 @@ rte_security_oop_dynfield_register(void)
 	return rte_security_oop_dynfield_offset;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_session_create)
+RTE_EXPORT_SYMBOL(rte_security_session_create);
 void *
 rte_security_session_create(void *ctx,
 			    struct rte_security_session_conf *conf,
@@ -100,7 +100,7 @@ rte_security_session_create(void *ctx,
 	return (void *)sess;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_session_update)
+RTE_EXPORT_SYMBOL(rte_security_session_update);
 int
 rte_security_session_update(void *ctx, void *sess, struct rte_security_session_conf *conf)
 {
@@ -114,7 +114,7 @@ rte_security_session_update(void *ctx, void *sess, struct rte_security_session_c
 	return instance->ops->session_update(instance->device, sess, conf);
 }
 
-RTE_EXPORT_SYMBOL(rte_security_session_get_size)
+RTE_EXPORT_SYMBOL(rte_security_session_get_size);
 unsigned int
 rte_security_session_get_size(void *ctx)
 {
@@ -126,7 +126,7 @@ rte_security_session_get_size(void *ctx)
 			instance->ops->session_get_size(instance->device));
 }
 
-RTE_EXPORT_SYMBOL(rte_security_session_stats_get)
+RTE_EXPORT_SYMBOL(rte_security_session_stats_get);
 int
 rte_security_session_stats_get(void *ctx, void *sess, struct rte_security_stats *stats)
 {
@@ -140,7 +140,7 @@ rte_security_session_stats_get(void *ctx, void *sess, struct rte_security_stats
 	return instance->ops->session_stats_get(instance->device, sess, stats);
 }
 
-RTE_EXPORT_SYMBOL(rte_security_session_destroy)
+RTE_EXPORT_SYMBOL(rte_security_session_destroy);
 int
 rte_security_session_destroy(void *ctx, void *sess)
 {
@@ -163,7 +163,7 @@ rte_security_session_destroy(void *ctx, void *sess)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sc_create)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_create);
 int
 rte_security_macsec_sc_create(void *ctx, struct rte_security_macsec_sc *conf)
 {
@@ -180,7 +180,7 @@ rte_security_macsec_sc_create(void *ctx, struct rte_security_macsec_sc *conf)
 	return sc_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sa_create)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_create);
 int
 rte_security_macsec_sa_create(void *ctx, struct rte_security_macsec_sa *conf)
 {
@@ -197,7 +197,7 @@ rte_security_macsec_sa_create(void *ctx, struct rte_security_macsec_sa *conf)
 	return sa_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sc_destroy)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_destroy);
 int
 rte_security_macsec_sc_destroy(void *ctx, uint16_t sc_id,
 			       enum rte_security_macsec_direction dir)
@@ -217,7 +217,7 @@ rte_security_macsec_sc_destroy(void *ctx, uint16_t sc_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sa_destroy)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_destroy);
 int
 rte_security_macsec_sa_destroy(void *ctx, uint16_t sa_id,
 			       enum rte_security_macsec_direction dir)
@@ -237,7 +237,7 @@ rte_security_macsec_sa_destroy(void *ctx, uint16_t sa_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sc_stats_get)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_stats_get);
 int
 rte_security_macsec_sc_stats_get(void *ctx, uint16_t sc_id,
 				 enum rte_security_macsec_direction dir,
@@ -251,7 +251,7 @@ rte_security_macsec_sc_stats_get(void *ctx, uint16_t sc_id,
 	return instance->ops->macsec_sc_stats_get(instance->device, sc_id, dir, stats);
 }
 
-RTE_EXPORT_SYMBOL(rte_security_macsec_sa_stats_get)
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_stats_get);
 int
 rte_security_macsec_sa_stats_get(void *ctx, uint16_t sa_id,
 				 enum rte_security_macsec_direction dir,
@@ -265,7 +265,7 @@ rte_security_macsec_sa_stats_get(void *ctx, uint16_t sa_id,
 	return instance->ops->macsec_sa_stats_get(instance->device, sa_id, dir, stats);
 }
 
-RTE_EXPORT_SYMBOL(__rte_security_set_pkt_metadata)
+RTE_EXPORT_SYMBOL(__rte_security_set_pkt_metadata);
 int
 __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void *params)
 {
@@ -280,7 +280,7 @@ __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void
 	return instance->ops->set_pkt_metadata(instance->device, sess, m, params);
 }
 
-RTE_EXPORT_SYMBOL(rte_security_capabilities_get)
+RTE_EXPORT_SYMBOL(rte_security_capabilities_get);
 const struct rte_security_capability *
 rte_security_capabilities_get(void *ctx)
 {
@@ -291,7 +291,7 @@ rte_security_capabilities_get(void *ctx)
 	return instance->ops->capabilities_get(instance->device);
 }
 
-RTE_EXPORT_SYMBOL(rte_security_capability_get)
+RTE_EXPORT_SYMBOL(rte_security_capability_get);
 const struct rte_security_capability *
 rte_security_capability_get(void *ctx, struct rte_security_capability_idx *idx)
 {
diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index 4c78fe4b4b..2fcfd57204 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -45,7 +45,7 @@ rte_stack_get_memsize(unsigned int count, uint32_t flags)
 		return rte_stack_std_get_memsize(count);
 }
 
-RTE_EXPORT_SYMBOL(rte_stack_create)
+RTE_EXPORT_SYMBOL(rte_stack_create);
 struct rte_stack *
 rte_stack_create(const char *name, unsigned int count, int socket_id,
 		 uint32_t flags)
@@ -131,7 +131,7 @@ rte_stack_create(const char *name, unsigned int count, int socket_id,
 	return s;
 }
 
-RTE_EXPORT_SYMBOL(rte_stack_free)
+RTE_EXPORT_SYMBOL(rte_stack_free);
 void
 rte_stack_free(struct rte_stack *s)
 {
@@ -164,7 +164,7 @@ rte_stack_free(struct rte_stack *s)
 	rte_memzone_free(s->memzone);
 }
 
-RTE_EXPORT_SYMBOL(rte_stack_lookup)
+RTE_EXPORT_SYMBOL(rte_stack_lookup);
 struct rte_stack *
 rte_stack_lookup(const char *name)
 {
diff --git a/lib/table/rte_table_acl.c b/lib/table/rte_table_acl.c
index 74fa0145d8..24601a35ca 100644
--- a/lib/table/rte_table_acl.c
+++ b/lib/table/rte_table_acl.c
@@ -782,7 +782,7 @@ rte_table_acl_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_acl_ops)
+RTE_EXPORT_SYMBOL(rte_table_acl_ops);
 struct rte_table_ops rte_table_acl_ops = {
 	.f_create = rte_table_acl_create,
 	.f_free = rte_table_acl_free,
diff --git a/lib/table/rte_table_array.c b/lib/table/rte_table_array.c
index 55356e5999..08646bc103 100644
--- a/lib/table/rte_table_array.c
+++ b/lib/table/rte_table_array.c
@@ -197,7 +197,7 @@ rte_table_array_stats_read(void *table, struct rte_table_stats *stats, int clear
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_array_ops)
+RTE_EXPORT_SYMBOL(rte_table_array_ops);
 struct rte_table_ops rte_table_array_ops = {
 	.f_create = rte_table_array_create,
 	.f_free = rte_table_array_free,
diff --git a/lib/table/rte_table_hash_cuckoo.c b/lib/table/rte_table_hash_cuckoo.c
index a2b920fa92..5b55754cbe 100644
--- a/lib/table/rte_table_hash_cuckoo.c
+++ b/lib/table/rte_table_hash_cuckoo.c
@@ -314,7 +314,7 @@ rte_table_hash_cuckoo_stats_read(void *table, struct rte_table_stats *stats,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_cuckoo_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_cuckoo_ops);
 struct rte_table_ops rte_table_hash_cuckoo_ops = {
 	.f_create = rte_table_hash_cuckoo_create,
 	.f_free = rte_table_hash_cuckoo_free,
diff --git a/lib/table/rte_table_hash_ext.c b/lib/table/rte_table_hash_ext.c
index 86e8eeb4c8..6c220ad971 100644
--- a/lib/table/rte_table_hash_ext.c
+++ b/lib/table/rte_table_hash_ext.c
@@ -998,7 +998,7 @@ rte_table_hash_ext_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_ext_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_ext_ops);
 struct rte_table_ops rte_table_hash_ext_ops	 = {
 	.f_create = rte_table_hash_ext_create,
 	.f_free = rte_table_hash_ext_free,
diff --git a/lib/table/rte_table_hash_key16.c b/lib/table/rte_table_hash_key16.c
index da24a7985d..e05d7bf99a 100644
--- a/lib/table/rte_table_hash_key16.c
+++ b/lib/table/rte_table_hash_key16.c
@@ -1167,7 +1167,7 @@ rte_table_hash_key16_stats_read(void *table, struct rte_table_stats *stats, int
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key16_lru_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key16_lru_ops);
 struct rte_table_ops rte_table_hash_key16_lru_ops = {
 	.f_create = rte_table_hash_create_key16_lru,
 	.f_free = rte_table_hash_free_key16_lru,
@@ -1179,7 +1179,7 @@ struct rte_table_ops rte_table_hash_key16_lru_ops = {
 	.f_stats = rte_table_hash_key16_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key16_ext_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key16_ext_ops);
 struct rte_table_ops rte_table_hash_key16_ext_ops = {
 	.f_create = rte_table_hash_create_key16_ext,
 	.f_free = rte_table_hash_free_key16_ext,
diff --git a/lib/table/rte_table_hash_key32.c b/lib/table/rte_table_hash_key32.c
index 297931a2a5..c2200c09b0 100644
--- a/lib/table/rte_table_hash_key32.c
+++ b/lib/table/rte_table_hash_key32.c
@@ -1200,7 +1200,7 @@ rte_table_hash_key32_stats_read(void *table, struct rte_table_stats *stats, int
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key32_lru_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key32_lru_ops);
 struct rte_table_ops rte_table_hash_key32_lru_ops = {
 	.f_create = rte_table_hash_create_key32_lru,
 	.f_free = rte_table_hash_free_key32_lru,
@@ -1212,7 +1212,7 @@ struct rte_table_ops rte_table_hash_key32_lru_ops = {
 	.f_stats = rte_table_hash_key32_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key32_ext_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key32_ext_ops);
 struct rte_table_ops rte_table_hash_key32_ext_ops = {
 	.f_create = rte_table_hash_create_key32_ext,
 	.f_free = rte_table_hash_free_key32_ext,
diff --git a/lib/table/rte_table_hash_key8.c b/lib/table/rte_table_hash_key8.c
index 746863082f..08d3e53743 100644
--- a/lib/table/rte_table_hash_key8.c
+++ b/lib/table/rte_table_hash_key8.c
@@ -1134,7 +1134,7 @@ rte_table_hash_key8_stats_read(void *table, struct rte_table_stats *stats, int c
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key8_lru_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key8_lru_ops);
 struct rte_table_ops rte_table_hash_key8_lru_ops = {
 	.f_create = rte_table_hash_create_key8_lru,
 	.f_free = rte_table_hash_free_key8_lru,
@@ -1146,7 +1146,7 @@ struct rte_table_ops rte_table_hash_key8_lru_ops = {
 	.f_stats = rte_table_hash_key8_stats_read,
 };
 
-RTE_EXPORT_SYMBOL(rte_table_hash_key8_ext_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_key8_ext_ops);
 struct rte_table_ops rte_table_hash_key8_ext_ops = {
 	.f_create = rte_table_hash_create_key8_ext,
 	.f_free = rte_table_hash_free_key8_ext,
diff --git a/lib/table/rte_table_hash_lru.c b/lib/table/rte_table_hash_lru.c
index 548f5eebf2..d6cd928a96 100644
--- a/lib/table/rte_table_hash_lru.c
+++ b/lib/table/rte_table_hash_lru.c
@@ -946,7 +946,7 @@ rte_table_hash_lru_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_hash_lru_ops)
+RTE_EXPORT_SYMBOL(rte_table_hash_lru_ops);
 struct rte_table_ops rte_table_hash_lru_ops = {
 	.f_create = rte_table_hash_lru_create,
 	.f_free = rte_table_hash_lru_free,
diff --git a/lib/table/rte_table_lpm.c b/lib/table/rte_table_lpm.c
index 6fd0c30f85..3afa1b4c95 100644
--- a/lib/table/rte_table_lpm.c
+++ b/lib/table/rte_table_lpm.c
@@ -356,7 +356,7 @@ rte_table_lpm_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_lpm_ops)
+RTE_EXPORT_SYMBOL(rte_table_lpm_ops);
 struct rte_table_ops rte_table_lpm_ops = {
 	.f_create = rte_table_lpm_create,
 	.f_free = rte_table_lpm_free,
diff --git a/lib/table/rte_table_lpm_ipv6.c b/lib/table/rte_table_lpm_ipv6.c
index 9159784dfa..a81195e88b 100644
--- a/lib/table/rte_table_lpm_ipv6.c
+++ b/lib/table/rte_table_lpm_ipv6.c
@@ -357,7 +357,7 @@ rte_table_lpm_ipv6_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_lpm_ipv6_ops)
+RTE_EXPORT_SYMBOL(rte_table_lpm_ipv6_ops);
 struct rte_table_ops rte_table_lpm_ipv6_ops = {
 	.f_create = rte_table_lpm_ipv6_create,
 	.f_free = rte_table_lpm_ipv6_free,
diff --git a/lib/table/rte_table_stub.c b/lib/table/rte_table_stub.c
index 3d2ac55c49..2d70e0761f 100644
--- a/lib/table/rte_table_stub.c
+++ b/lib/table/rte_table_stub.c
@@ -82,7 +82,7 @@ rte_table_stub_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_table_stub_ops)
+RTE_EXPORT_SYMBOL(rte_table_stub_ops);
 struct rte_table_ops rte_table_stub_ops = {
 	.f_create = rte_table_stub_create,
 	.f_free = NULL,
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index 1cbbffbf3f..5e9fd5acad 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -115,7 +115,7 @@ register_cmd(const char *cmd, const char *help,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd)
+RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd);
 int
 rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
 {
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index c120600622..93e9c93c9d 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -17,7 +17,7 @@
 
 #define RTE_TEL_UINT_HEX_STR_BUF_LEN 64
 
-RTE_EXPORT_SYMBOL(rte_tel_data_start_array)
+RTE_EXPORT_SYMBOL(rte_tel_data_start_array);
 int
 rte_tel_data_start_array(struct rte_tel_data *d, enum rte_tel_value_type type)
 {
@@ -32,7 +32,7 @@ rte_tel_data_start_array(struct rte_tel_data *d, enum rte_tel_value_type type)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_start_dict)
+RTE_EXPORT_SYMBOL(rte_tel_data_start_dict);
 int
 rte_tel_data_start_dict(struct rte_tel_data *d)
 {
@@ -41,7 +41,7 @@ rte_tel_data_start_dict(struct rte_tel_data *d)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_string)
+RTE_EXPORT_SYMBOL(rte_tel_data_string);
 int
 rte_tel_data_string(struct rte_tel_data *d, const char *str)
 {
@@ -54,7 +54,7 @@ rte_tel_data_string(struct rte_tel_data *d, const char *str)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_string)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_string);
 int
 rte_tel_data_add_array_string(struct rte_tel_data *d, const char *str)
 {
@@ -67,7 +67,7 @@ rte_tel_data_add_array_string(struct rte_tel_data *d, const char *str)
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_int)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_int);
 int
 rte_tel_data_add_array_int(struct rte_tel_data *d, int64_t x)
 {
@@ -79,7 +79,7 @@ rte_tel_data_add_array_int(struct rte_tel_data *d, int64_t x)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_uint)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_uint);
 int
 rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x)
 {
@@ -91,14 +91,14 @@ rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_u64)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_u64);
 int
 rte_tel_data_add_array_u64(struct rte_tel_data *d, uint64_t x)
 {
 	return rte_tel_data_add_array_uint(d, x);
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_container)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_container);
 int
 rte_tel_data_add_array_container(struct rte_tel_data *d,
 		struct rte_tel_data *val, int keep)
@@ -162,7 +162,7 @@ valid_name(const char *name)
 	return true;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_string)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_string);
 int
 rte_tel_data_add_dict_string(struct rte_tel_data *d, const char *name,
 		const char *val)
@@ -188,7 +188,7 @@ rte_tel_data_add_dict_string(struct rte_tel_data *d, const char *name,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_int)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_int);
 int
 rte_tel_data_add_dict_int(struct rte_tel_data *d, const char *name, int64_t val)
 {
@@ -208,7 +208,7 @@ rte_tel_data_add_dict_int(struct rte_tel_data *d, const char *name, int64_t val)
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_uint)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_uint);
 int
 rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 		const char *name, uint64_t val)
@@ -229,14 +229,14 @@ rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_u64)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_u64);
 int
 rte_tel_data_add_dict_u64(struct rte_tel_data *d, const char *name, uint64_t val)
 {
 	return rte_tel_data_add_dict_uint(d, name, val);
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_container)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_container);
 int
 rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
 		struct rte_tel_data *val, int keep)
@@ -279,14 +279,14 @@ rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 	return rte_tel_data_add_dict_string(d, name, hex_str);
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_alloc)
+RTE_EXPORT_SYMBOL(rte_tel_data_alloc);
 struct rte_tel_data *
 rte_tel_data_alloc(void)
 {
 	return malloc(sizeof(struct rte_tel_data));
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_free)
+RTE_EXPORT_SYMBOL(rte_tel_data_free);
 void
 rte_tel_data_free(struct rte_tel_data *data)
 {
diff --git a/lib/timer/rte_timer.c b/lib/timer/rte_timer.c
index b349c2abbc..f76079e8ce 100644
--- a/lib/timer/rte_timer.c
+++ b/lib/timer/rte_timer.c
@@ -85,7 +85,7 @@ timer_data_valid(uint32_t id)
 	timer_data = &rte_timer_data_arr[id];				\
 } while (0)
 
-RTE_EXPORT_SYMBOL(rte_timer_data_alloc)
+RTE_EXPORT_SYMBOL(rte_timer_data_alloc);
 int
 rte_timer_data_alloc(uint32_t *id_ptr)
 {
@@ -110,7 +110,7 @@ rte_timer_data_alloc(uint32_t *id_ptr)
 	return -ENOSPC;
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_data_dealloc)
+RTE_EXPORT_SYMBOL(rte_timer_data_dealloc);
 int
 rte_timer_data_dealloc(uint32_t id)
 {
@@ -128,7 +128,7 @@ rte_timer_data_dealloc(uint32_t id)
  * secondary processes should be empty, the zeroth entry can be shared by
  * multiple processes.
  */
-RTE_EXPORT_SYMBOL(rte_timer_subsystem_init)
+RTE_EXPORT_SYMBOL(rte_timer_subsystem_init);
 int
 rte_timer_subsystem_init(void)
 {
@@ -188,7 +188,7 @@ rte_timer_subsystem_init(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_subsystem_finalize)
+RTE_EXPORT_SYMBOL(rte_timer_subsystem_finalize);
 void
 rte_timer_subsystem_finalize(void)
 {
@@ -208,7 +208,7 @@ rte_timer_subsystem_finalize(void)
 }
 
 /* Initialize the timer handle tim for use */
-RTE_EXPORT_SYMBOL(rte_timer_init)
+RTE_EXPORT_SYMBOL(rte_timer_init);
 void
 rte_timer_init(struct rte_timer *tim)
 {
@@ -545,7 +545,7 @@ __rte_timer_reset(struct rte_timer *tim, uint64_t expire,
 }
 
 /* Reset and start the timer associated with the timer handle tim */
-RTE_EXPORT_SYMBOL(rte_timer_reset)
+RTE_EXPORT_SYMBOL(rte_timer_reset);
 int
 rte_timer_reset(struct rte_timer *tim, uint64_t ticks,
 		      enum rte_timer_type type, unsigned int tim_lcore,
@@ -555,7 +555,7 @@ rte_timer_reset(struct rte_timer *tim, uint64_t ticks,
 				   tim_lcore, fct, arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_alt_reset)
+RTE_EXPORT_SYMBOL(rte_timer_alt_reset);
 int
 rte_timer_alt_reset(uint32_t timer_data_id, struct rte_timer *tim,
 		    uint64_t ticks, enum rte_timer_type type,
@@ -577,7 +577,7 @@ rte_timer_alt_reset(uint32_t timer_data_id, struct rte_timer *tim,
 }
 
 /* loop until rte_timer_reset() succeed */
-RTE_EXPORT_SYMBOL(rte_timer_reset_sync)
+RTE_EXPORT_SYMBOL(rte_timer_reset_sync);
 void
 rte_timer_reset_sync(struct rte_timer *tim, uint64_t ticks,
 		     enum rte_timer_type type, unsigned tim_lcore,
@@ -627,14 +627,14 @@ __rte_timer_stop(struct rte_timer *tim,
 }
 
 /* Stop the timer associated with the timer handle tim */
-RTE_EXPORT_SYMBOL(rte_timer_stop)
+RTE_EXPORT_SYMBOL(rte_timer_stop);
 int
 rte_timer_stop(struct rte_timer *tim)
 {
 	return rte_timer_alt_stop(default_data_id, tim);
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_alt_stop)
+RTE_EXPORT_SYMBOL(rte_timer_alt_stop);
 int
 rte_timer_alt_stop(uint32_t timer_data_id, struct rte_timer *tim)
 {
@@ -646,7 +646,7 @@ rte_timer_alt_stop(uint32_t timer_data_id, struct rte_timer *tim)
 }
 
 /* loop until rte_timer_stop() succeed */
-RTE_EXPORT_SYMBOL(rte_timer_stop_sync)
+RTE_EXPORT_SYMBOL(rte_timer_stop_sync);
 void
 rte_timer_stop_sync(struct rte_timer *tim)
 {
@@ -655,7 +655,7 @@ rte_timer_stop_sync(struct rte_timer *tim)
 }
 
 /* Test the PENDING status of the timer handle tim */
-RTE_EXPORT_SYMBOL(rte_timer_pending)
+RTE_EXPORT_SYMBOL(rte_timer_pending);
 int
 rte_timer_pending(struct rte_timer *tim)
 {
@@ -790,7 +790,7 @@ __rte_timer_manage(struct rte_timer_data *timer_data)
 	priv_timer[lcore_id].running_tim = NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_manage)
+RTE_EXPORT_SYMBOL(rte_timer_manage);
 int
 rte_timer_manage(void)
 {
@@ -803,7 +803,7 @@ rte_timer_manage(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_alt_manage)
+RTE_EXPORT_SYMBOL(rte_timer_alt_manage);
 int
 rte_timer_alt_manage(uint32_t timer_data_id,
 		     unsigned int *poll_lcores,
@@ -985,7 +985,7 @@ rte_timer_alt_manage(uint32_t timer_data_id,
 }
 
 /* Walk pending lists, stopping timers and calling user-specified function */
-RTE_EXPORT_SYMBOL(rte_timer_stop_all)
+RTE_EXPORT_SYMBOL(rte_timer_stop_all);
 int
 rte_timer_stop_all(uint32_t timer_data_id, unsigned int *walk_lcores,
 		   int nb_walk_lcores,
@@ -1018,7 +1018,7 @@ rte_timer_stop_all(uint32_t timer_data_id, unsigned int *walk_lcores,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_next_ticks)
+RTE_EXPORT_SYMBOL(rte_timer_next_ticks);
 int64_t
 rte_timer_next_ticks(void)
 {
@@ -1072,14 +1072,14 @@ __rte_timer_dump_stats(struct rte_timer_data *timer_data __rte_unused, FILE *f)
 #endif
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_dump_stats)
+RTE_EXPORT_SYMBOL(rte_timer_dump_stats);
 int
 rte_timer_dump_stats(FILE *f)
 {
 	return rte_timer_alt_dump_stats(default_data_id, f);
 }
 
-RTE_EXPORT_SYMBOL(rte_timer_alt_dump_stats)
+RTE_EXPORT_SYMBOL(rte_timer_alt_dump_stats);
 int
 rte_timer_alt_dump_stats(uint32_t timer_data_id __rte_unused, FILE *f)
 {
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..1111ecbe0b 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -572,7 +572,7 @@ find_vhost_user_socket(const char *path)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_attach_vdpa_device)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_attach_vdpa_device);
 int
 rte_vhost_driver_attach_vdpa_device(const char *path,
 		struct rte_vdpa_device *dev)
@@ -591,7 +591,7 @@ rte_vhost_driver_attach_vdpa_device(const char *path,
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_detach_vdpa_device)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_detach_vdpa_device);
 int
 rte_vhost_driver_detach_vdpa_device(const char *path)
 {
@@ -606,7 +606,7 @@ rte_vhost_driver_detach_vdpa_device(const char *path)
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_device)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_device);
 struct rte_vdpa_device *
 rte_vhost_driver_get_vdpa_device(const char *path)
 {
@@ -622,7 +622,7 @@ rte_vhost_driver_get_vdpa_device(const char *path)
 	return dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_dev_type)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_dev_type);
 int
 rte_vhost_driver_get_vdpa_dev_type(const char *path, uint32_t *type)
 {
@@ -651,7 +651,7 @@ rte_vhost_driver_get_vdpa_dev_type(const char *path, uint32_t *type)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_disable_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_disable_features);
 int
 rte_vhost_driver_disable_features(const char *path, uint64_t features)
 {
@@ -672,7 +672,7 @@ rte_vhost_driver_disable_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_enable_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_enable_features);
 int
 rte_vhost_driver_enable_features(const char *path, uint64_t features)
 {
@@ -696,7 +696,7 @@ rte_vhost_driver_enable_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_set_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_features);
 int
 rte_vhost_driver_set_features(const char *path, uint64_t features)
 {
@@ -718,7 +718,7 @@ rte_vhost_driver_set_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_get_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_features);
 int
 rte_vhost_driver_get_features(const char *path, uint64_t *features)
 {
@@ -754,7 +754,7 @@ rte_vhost_driver_get_features(const char *path, uint64_t *features)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_set_protocol_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_protocol_features);
 int
 rte_vhost_driver_set_protocol_features(const char *path,
 		uint64_t protocol_features)
@@ -769,7 +769,7 @@ rte_vhost_driver_set_protocol_features(const char *path,
 	return vsocket ? 0 : -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_get_protocol_features)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_protocol_features);
 int
 rte_vhost_driver_get_protocol_features(const char *path,
 		uint64_t *protocol_features)
@@ -808,7 +808,7 @@ rte_vhost_driver_get_protocol_features(const char *path,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_get_queue_num)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_queue_num);
 int
 rte_vhost_driver_get_queue_num(const char *path, uint32_t *queue_num)
 {
@@ -844,7 +844,7 @@ rte_vhost_driver_get_queue_num(const char *path, uint32_t *queue_num)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_set_max_queue_num)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_max_queue_num);
 int
 rte_vhost_driver_set_max_queue_num(const char *path, uint32_t max_queue_pairs)
 {
@@ -902,7 +902,7 @@ vhost_user_socket_mem_free(struct vhost_user_socket *vsocket)
  * (the default case), or client (when RTE_VHOST_USER_CLIENT) flag
  * is set.
  */
-RTE_EXPORT_SYMBOL(rte_vhost_driver_register)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_register);
 int
 rte_vhost_driver_register(const char *path, uint64_t flags)
 {
@@ -1068,7 +1068,7 @@ vhost_user_remove_reconnect(struct vhost_user_socket *vsocket)
 /**
  * Unregister the specified vhost socket
  */
-RTE_EXPORT_SYMBOL(rte_vhost_driver_unregister)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_unregister);
 int
 rte_vhost_driver_unregister(const char *path)
 {
@@ -1152,7 +1152,7 @@ rte_vhost_driver_unregister(const char *path)
 /*
  * Register ops so that we can add/remove device to data core.
  */
-RTE_EXPORT_SYMBOL(rte_vhost_driver_callback_register)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_callback_register);
 int
 rte_vhost_driver_callback_register(const char *path,
 	struct rte_vhost_device_ops const * const ops)
@@ -1180,7 +1180,7 @@ vhost_driver_callback_get(const char *path)
 	return vsocket ? vsocket->notify_ops : NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_driver_start)
+RTE_EXPORT_SYMBOL(rte_vhost_driver_start);
 int
 rte_vhost_driver_start(const char *path)
 {
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index bc2dd8d2e1..7d28427460 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -50,7 +50,7 @@ __vdpa_find_device_by_name(const char *name)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_find_device_by_name)
+RTE_EXPORT_SYMBOL(rte_vdpa_find_device_by_name);
 struct rte_vdpa_device *
 rte_vdpa_find_device_by_name(const char *name)
 {
@@ -63,7 +63,7 @@ rte_vdpa_find_device_by_name(const char *name)
 	return dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_rte_device)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_rte_device);
 struct rte_device *
 rte_vdpa_get_rte_device(struct rte_vdpa_device *vdpa_dev)
 {
@@ -263,7 +263,7 @@ rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_queue_num)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_queue_num);
 int
 rte_vdpa_get_queue_num(struct rte_vdpa_device *dev, uint32_t *queue_num)
 {
@@ -273,7 +273,7 @@ rte_vdpa_get_queue_num(struct rte_vdpa_device *dev, uint32_t *queue_num)
 	return dev->ops->get_queue_num(dev, queue_num);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_features)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_features);
 int
 rte_vdpa_get_features(struct rte_vdpa_device *dev, uint64_t *features)
 {
@@ -283,7 +283,7 @@ rte_vdpa_get_features(struct rte_vdpa_device *dev, uint64_t *features)
 	return dev->ops->get_features(dev, features);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_protocol_features)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_protocol_features);
 int
 rte_vdpa_get_protocol_features(struct rte_vdpa_device *dev, uint64_t *features)
 {
@@ -294,7 +294,7 @@ rte_vdpa_get_protocol_features(struct rte_vdpa_device *dev, uint64_t *features)
 	return dev->ops->get_protocol_features(dev, features);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_stats_names)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_stats_names);
 int
 rte_vdpa_get_stats_names(struct rte_vdpa_device *dev,
 		struct rte_vdpa_stat_name *stats_names,
@@ -309,7 +309,7 @@ rte_vdpa_get_stats_names(struct rte_vdpa_device *dev,
 	return dev->ops->get_stats_names(dev, stats_names, size);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_get_stats)
+RTE_EXPORT_SYMBOL(rte_vdpa_get_stats);
 int
 rte_vdpa_get_stats(struct rte_vdpa_device *dev, uint16_t qid,
 		struct rte_vdpa_stat *stats, unsigned int n)
@@ -323,7 +323,7 @@ rte_vdpa_get_stats(struct rte_vdpa_device *dev, uint16_t qid,
 	return dev->ops->get_stats(dev, qid, stats, n);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdpa_reset_stats)
+RTE_EXPORT_SYMBOL(rte_vdpa_reset_stats);
 int
 rte_vdpa_reset_stats(struct rte_vdpa_device *dev, uint16_t qid)
 {
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 416f082dca..1288836236 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -845,7 +845,7 @@ vhost_enable_linearbuf(int vid)
 	dev->linearbuf = 1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_mtu)
+RTE_EXPORT_SYMBOL(rte_vhost_get_mtu);
 int
 rte_vhost_get_mtu(int vid, uint16_t *mtu)
 {
@@ -865,7 +865,7 @@ rte_vhost_get_mtu(int vid, uint16_t *mtu)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_numa_node)
+RTE_EXPORT_SYMBOL(rte_vhost_get_numa_node);
 int
 rte_vhost_get_numa_node(int vid)
 {
@@ -892,7 +892,7 @@ rte_vhost_get_numa_node(int vid)
 #endif
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vring_num)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_num);
 uint16_t
 rte_vhost_get_vring_num(int vid)
 {
@@ -904,7 +904,7 @@ rte_vhost_get_vring_num(int vid)
 	return dev->nr_vring;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_ifname)
+RTE_EXPORT_SYMBOL(rte_vhost_get_ifname);
 int
 rte_vhost_get_ifname(int vid, char *buf, size_t len)
 {
@@ -921,7 +921,7 @@ rte_vhost_get_ifname(int vid, char *buf, size_t len)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_features)
+RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_features);
 int
 rte_vhost_get_negotiated_features(int vid, uint64_t *features)
 {
@@ -935,7 +935,7 @@ rte_vhost_get_negotiated_features(int vid, uint64_t *features)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_protocol_features)
+RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_protocol_features);
 int
 rte_vhost_get_negotiated_protocol_features(int vid,
 					   uint64_t *protocol_features)
@@ -950,7 +950,7 @@ rte_vhost_get_negotiated_protocol_features(int vid,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_mem_table)
+RTE_EXPORT_SYMBOL(rte_vhost_get_mem_table);
 int
 rte_vhost_get_mem_table(int vid, struct rte_vhost_memory **mem)
 {
@@ -974,7 +974,7 @@ rte_vhost_get_mem_table(int vid, struct rte_vhost_memory **mem)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_vring)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_vring);
 int
 rte_vhost_get_vhost_vring(int vid, uint16_t vring_idx,
 			  struct rte_vhost_vring *vring)
@@ -1011,7 +1011,7 @@ rte_vhost_get_vhost_vring(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_ring_inflight)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_ring_inflight);
 int
 rte_vhost_get_vhost_ring_inflight(int vid, uint16_t vring_idx,
 				  struct rte_vhost_ring_inflight *vring)
@@ -1047,7 +1047,7 @@ rte_vhost_get_vhost_ring_inflight(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_split)
+RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_split);
 int
 rte_vhost_set_inflight_desc_split(int vid, uint16_t vring_idx,
 				  uint16_t idx)
@@ -1084,7 +1084,7 @@ rte_vhost_set_inflight_desc_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_packed)
+RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_packed);
 int
 rte_vhost_set_inflight_desc_packed(int vid, uint16_t vring_idx,
 				   uint16_t head, uint16_t last,
@@ -1153,7 +1153,7 @@ rte_vhost_set_inflight_desc_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_split)
+RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_split);
 int
 rte_vhost_clr_inflight_desc_split(int vid, uint16_t vring_idx,
 				  uint16_t last_used_idx, uint16_t idx)
@@ -1195,7 +1195,7 @@ rte_vhost_clr_inflight_desc_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_packed)
+RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_packed);
 int
 rte_vhost_clr_inflight_desc_packed(int vid, uint16_t vring_idx,
 				   uint16_t head)
@@ -1242,7 +1242,7 @@ rte_vhost_clr_inflight_desc_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_split)
+RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_split);
 int
 rte_vhost_set_last_inflight_io_split(int vid, uint16_t vring_idx,
 				     uint16_t idx)
@@ -1278,7 +1278,7 @@ rte_vhost_set_last_inflight_io_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_packed)
+RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_packed);
 int
 rte_vhost_set_last_inflight_io_packed(int vid, uint16_t vring_idx,
 				      uint16_t head)
@@ -1329,7 +1329,7 @@ rte_vhost_set_last_inflight_io_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_vring_call)
+RTE_EXPORT_SYMBOL(rte_vhost_vring_call);
 int
 rte_vhost_vring_call(int vid, uint16_t vring_idx)
 {
@@ -1366,7 +1366,7 @@ rte_vhost_vring_call(int vid, uint16_t vring_idx)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_vring_call_nonblock)
+RTE_EXPORT_SYMBOL(rte_vhost_vring_call_nonblock);
 int
 rte_vhost_vring_call_nonblock(int vid, uint16_t vring_idx)
 {
@@ -1404,7 +1404,7 @@ rte_vhost_vring_call_nonblock(int vid, uint16_t vring_idx)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_avail_entries)
+RTE_EXPORT_SYMBOL(rte_vhost_avail_entries);
 uint16_t
 rte_vhost_avail_entries(int vid, uint16_t queue_id)
 {
@@ -1501,7 +1501,7 @@ vhost_enable_guest_notification(struct virtio_net *dev,
 		return vhost_enable_notify_split(dev, vq, enable);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_enable_guest_notification)
+RTE_EXPORT_SYMBOL(rte_vhost_enable_guest_notification);
 int
 rte_vhost_enable_guest_notification(int vid, uint16_t queue_id, int enable)
 {
@@ -1572,7 +1572,7 @@ rte_vhost_notify_guest(int vid, uint16_t queue_id)
 	rte_rwlock_read_unlock(&vq->access_lock);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_log_write)
+RTE_EXPORT_SYMBOL(rte_vhost_log_write);
 void
 rte_vhost_log_write(int vid, uint64_t addr, uint64_t len)
 {
@@ -1584,7 +1584,7 @@ rte_vhost_log_write(int vid, uint64_t addr, uint64_t len)
 	vhost_log_write(dev, addr, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_log_used_vring)
+RTE_EXPORT_SYMBOL(rte_vhost_log_used_vring);
 void
 rte_vhost_log_used_vring(int vid, uint16_t vring_idx,
 			 uint64_t offset, uint64_t len)
@@ -1605,7 +1605,7 @@ rte_vhost_log_used_vring(int vid, uint16_t vring_idx,
 	vhost_log_used_vring(dev, vq, offset, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_rx_queue_count)
+RTE_EXPORT_SYMBOL(rte_vhost_rx_queue_count);
 uint32_t
 rte_vhost_rx_queue_count(int vid, uint16_t qid)
 {
@@ -1643,7 +1643,7 @@ rte_vhost_rx_queue_count(int vid, uint16_t qid)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vdpa_device)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vdpa_device);
 struct rte_vdpa_device *
 rte_vhost_get_vdpa_device(int vid)
 {
@@ -1655,7 +1655,7 @@ rte_vhost_get_vdpa_device(int vid)
 	return dev->vdpa_dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_log_base)
+RTE_EXPORT_SYMBOL(rte_vhost_get_log_base);
 int
 rte_vhost_get_log_base(int vid, uint64_t *log_base,
 		uint64_t *log_size)
@@ -1671,7 +1671,7 @@ rte_vhost_get_log_base(int vid, uint64_t *log_base,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base);
 int
 rte_vhost_get_vring_base(int vid, uint16_t queue_id,
 		uint16_t *last_avail_idx, uint16_t *last_used_idx)
@@ -1702,7 +1702,7 @@ rte_vhost_get_vring_base(int vid, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_set_vring_base)
+RTE_EXPORT_SYMBOL(rte_vhost_set_vring_base);
 int
 rte_vhost_set_vring_base(int vid, uint16_t queue_id,
 		uint16_t last_avail_idx, uint16_t last_used_idx)
@@ -1735,7 +1735,7 @@ rte_vhost_set_vring_base(int vid, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base_from_inflight)
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base_from_inflight);
 int
 rte_vhost_get_vring_base_from_inflight(int vid,
 				       uint16_t queue_id,
@@ -1770,7 +1770,7 @@ rte_vhost_get_vring_base_from_inflight(int vid,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_extern_callback_register)
+RTE_EXPORT_SYMBOL(rte_vhost_extern_callback_register);
 int
 rte_vhost_extern_callback_register(int vid,
 		struct rte_vhost_user_extern_ops const * const ops, void *ctx)
@@ -2142,7 +2142,7 @@ rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_get_monitor_addr)
+RTE_EXPORT_SYMBOL(rte_vhost_get_monitor_addr);
 int
 rte_vhost_get_monitor_addr(int vid, uint16_t queue_id,
 		struct rte_vhost_power_monitor_cond *pmc)
@@ -2193,7 +2193,7 @@ rte_vhost_get_monitor_addr(int vid, uint16_t queue_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get_names)
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get_names);
 int
 rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 		struct rte_vhost_stat_name *name, unsigned int size)
@@ -2221,7 +2221,7 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 	return VHOST_NB_VQ_STATS;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get)
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get);
 int
 rte_vhost_vring_stats_get(int vid, uint16_t queue_id,
 		struct rte_vhost_stat *stats, unsigned int n)
@@ -2268,7 +2268,7 @@ rte_vhost_vring_stats_get(int vid, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_reset)
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_reset);
 int rte_vhost_vring_stats_reset(int vid, uint16_t queue_id)
 {
 	struct virtio_net *dev = get_device(vid);
diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 648e2d731b..ed5b164846 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1782,7 +1782,7 @@ vhost_crypto_complete_one_vm_requests(struct rte_crypto_op **ops,
 	return processed;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_driver_start)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_driver_start);
 int
 rte_vhost_crypto_driver_start(const char *path)
 {
@@ -1804,7 +1804,7 @@ rte_vhost_crypto_driver_start(const char *path)
 	return rte_vhost_driver_start(path);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_create)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_create);
 int
 rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 		struct rte_mempool *sess_pool,
@@ -1888,7 +1888,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_free)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_free);
 int
 rte_vhost_crypto_free(int vid)
 {
@@ -1918,7 +1918,7 @@ rte_vhost_crypto_free(int vid)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_set_zero_copy)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_set_zero_copy);
 int
 rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 {
@@ -1974,7 +1974,7 @@ rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_fetch_requests)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_fetch_requests);
 uint16_t
 rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		struct rte_crypto_op **ops, uint16_t nb_ops)
@@ -2104,7 +2104,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 	return i;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_crypto_finalize_requests)
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_finalize_requests);
 uint16_t
 rte_vhost_crypto_finalize_requests(struct rte_crypto_op **ops,
 		uint16_t nb_ops, int *callfds, uint16_t *nb_callfds)
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..ceed74ea64 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3353,7 +3353,7 @@ vhost_user_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_backend_config_change)
+RTE_EXPORT_SYMBOL(rte_vhost_backend_config_change);
 int
 rte_vhost_backend_config_change(int vid, bool need_reply)
 {
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 77545d0a4d..e2454f01a3 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -1740,7 +1740,7 @@ virtio_dev_rx(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nb_tx;
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_enqueue_burst)
+RTE_EXPORT_SYMBOL(rte_vhost_enqueue_burst);
 uint16_t
 rte_vhost_enqueue_burst(int vid, uint16_t queue_id,
 	struct rte_mbuf **__rte_restrict pkts, uint16_t count)
@@ -3594,7 +3594,7 @@ virtio_dev_tx_packed_compliant(struct virtio_net *dev,
 	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, false);
 }
 
-RTE_EXPORT_SYMBOL(rte_vhost_dequeue_burst)
+RTE_EXPORT_SYMBOL(rte_vhost_dequeue_burst);
 uint16_t
 rte_vhost_dequeue_burst(int vid, uint16_t queue_id,
 	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count)
-- 
2.17.1

