Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A606C87F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=svAkr50p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F1C40430;
	Tue,  3 Nov 2026 15:53:14 +0100 (CET)
Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
 by mails.dpdk.org (Postfix) with ESMTPS id 59C764042F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:13 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=eAxUeG1sSpXBqFxD0HDvxnPS9h/tIVlQ7Etvjbf4944=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717593; v=1; x=1794322393;
 b=svAkr50p+uETmb2EUAckNcSpqNERJbui3IGxKpO52m67MSFcc2J/v8cONcTuHBjayIaSZAIj
 D85twIYSxOEMZrp379XDOYPSbq7H4R7QKueikuuQ6f2caRwdlPEjz0nNIXu7O2aVywnEeQ5h77h
 xzJzJfRN5+FEkQaSM5GlCU94=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id ddc0c68d77500102;
 Tue, 03 Nov 2026 14:53:12 +0000
X-Mizu-Trace-ID: ddc0c68d77500102
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 000/227] use NUMA node terminology across the tree
Date: Tue,  3 Nov 2026 22:49:18 +0800
Message-ID: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

The DPDK tree conflates CPU sockets with NUMA memory nodes: public
APIs, structure fields and macros are named after "socket" although
they actually identify a NUMA node (e.g. rte_socket_id(), the
socket_id field of rte_memzone, SOCKET_ID_ANY). This naming misleads
application developers and pollutes vendor code that targets NUMA
topologies.

This series renames the terminology tree-wide:

Foundation (EAL):
- New NUMA-aware functions are added: rte_numa_id(),
  rte_numa_count(), rte_numa_id_by_idx(), rte_lcore_to_numa_id(),
  rte_malloc_heap_numa_is_external(), and friends.
- SOCKET_ID_ANY becomes RTE_NUMA_ID_ANY; SOCKET_ID_ANY is kept as a
  deprecated macro alias.
- The socket_id fields of the public structures are renamed to
  numa_id, keeping socket_id as a deprecated union alias (so field
  offsets, and therefore ABI layout, are unchanged). Affected
  structures include rte_memzone, rte_memseg, rte_memseg_list,
  rte_mempool, rte_hash_parameters, rte_graph, rte_service_spec,
  rte_acl_param, rte_gro_param, rte_ipsec_sad_conf, rte_member_*,
  rte_bbdev_*, rte_cryptodev_config, rte_compressdev_config,
  rte_event_*, rte_ml_dev_config, rte_rawdev* -- see
  doc/guides/rel_notes/deprecation.rst for the full list.

Libraries:
- Library-specific APIs follow the same pattern: ethdev, cryptodev,
  compressdev, rawdev, mldev, bbdev and eventdev gain NUMA-named
  device APIs (e.g. rte_event_dev_numa_id()) with the socket
  variants kept as deprecated aliases.

Drivers, applications, examples and documentation:
- One commit per unit; in-tree users are updated in the same commit
  as the unit they belong to, moving from libs to drivers and then
  to app/examples.
- The programming guides and API docs are updated to the new names.

Compatibility notes:
- The deprecated aliases preserve source compatibility for external
  applications for one release; they will be removed in a future
  release, as recorded in deprecation.rst.
- No ABI break: the deprecated union alias keeps the layout
  identical.
- Device arguments and command-line options that literally use the
  "socket" name (e.g. --socket-mem, --socket-limit, the
  socket_id= parameter of the bbdev/compressdev vdevs) are
  intentionally NOT renamed to avoid breaking user scripts; their
  documentation still describes the existing parameter names.
  Feedback on whether/how to migrate these user-facing names is
  welcome.

This series is based on v26.11-rc2 and developped by AI.

Chengwen Feng (227):
  eal: add NUMA-aware APIs
  mempool: use NUMA node terminology
  ring: use NUMA node terminology
  hash: use NUMA node terminology
  member: use NUMA node terminology
  ethdev: rename device socket API to NUMA node API
  cryptodev: rename device socket API to NUMA node API
  compressdev: rename device socket API to NUMA node API
  rawdev: rename device socket API to NUMA node API
  mldev: rename device socket API to NUMA node API
  bbdev: rename device socket API to NUMA node API
  eventdev: rename device socket API to NUMA node API
  acl: use NUMA node terminology
  ipsec: use NUMA node terminology
  graph: use NUMA node terminology
  gro: use NUMA node terminology
  fib: use NUMA node terminology
  rib: use NUMA node terminology
  lpm: use NUMA node terminology
  efd: use NUMA node terminology
  ip_frag: use NUMA node terminology
  node: use NUMA node terminology
  distributor: use NUMA node terminology
  reorder: use NUMA node terminology
  stack: use NUMA node terminology
  regexdev: use NUMA node terminology
  metrics: use NUMA node terminology
  mbuf: use NUMA node terminology
  timer: use NUMA node terminology
  table: use NUMA node terminology
  rcu: use NUMA node terminology
  pdump: use NUMA node terminology
  pdcp: use NUMA node terminology
  latencystats: use NUMA node terminology
  gpudev: use NUMA node terminology
  dmadev: use NUMA node terminology
  dispatcher: use NUMA node terminology
  vhost: use NUMA node terminology
  baseband/acc: use NUMA node terminology
  baseband/fpga_5gnr_fec: use NUMA node terminology
  baseband/fpga_lte_fec: use NUMA node terminology
  baseband/null: use NUMA node terminology
  baseband/turbo_sw: use NUMA node terminology
  bus/auxiliary: use NUMA node terminology
  bus/dpaa: use NUMA node terminology
  bus/fslmc: use NUMA node terminology
  bus/ifpga: use NUMA node terminology
  bus/pci: use NUMA node terminology
  bus/platform: use NUMA node terminology
  bus/vdev: use NUMA node terminology
  bus/vmbus: use NUMA node terminology
  common/cnxk: use NUMA node terminology
  common/nitrox: use NUMA node terminology
  common/zsda: use NUMA node terminology
  compress/isal: use NUMA node terminology
  compress/mlx5: use NUMA node terminology
  compress/nitrox: use NUMA node terminology
  compress/octeontx: use NUMA node terminology
  compress/uadk: use NUMA node terminology
  compress/zlib: use NUMA node terminology
  compress/zsda: use NUMA node terminology
  crypto/armv8: use NUMA node terminology
  crypto/bcmfs: use NUMA node terminology
  crypto/caam_jr: use NUMA node terminology
  crypto/ccp: use NUMA node terminology
  crypto/cnxk: use NUMA node terminology
  crypto/dpaa2_sec: use NUMA node terminology
  crypto/dpaa_sec: use NUMA node terminology
  crypto/ionic: use NUMA node terminology
  crypto/ipsec_mb: use NUMA node terminology
  crypto/mlx5: use NUMA node terminology
  crypto/mvsam: use NUMA node terminology
  crypto/nitrox: use NUMA node terminology
  crypto/null: use NUMA node terminology
  crypto/octeontx: use NUMA node terminology
  crypto/openssl: use NUMA node terminology
  crypto/scheduler: use NUMA node terminology
  crypto/uadk: use NUMA node terminology
  crypto/virtio: use NUMA node terminology
  crypto/zsda: use NUMA node terminology
  dma/ae4dma: use NUMA node terminology
  dma/cnxk: use NUMA node terminology
  dma/dpaa: use NUMA node terminology
  dma/dpaa2: use NUMA node terminology
  dma/hisi_acc: use NUMA node terminology
  dma/idxd: use NUMA node terminology
  dma/imx_edma5: use NUMA node terminology
  dma/odm: use NUMA node terminology
  dma/skeleton: use NUMA node terminology
  event/cnxk: use NUMA node terminology
  event/dlb2: use NUMA node terminology
  event/dpaa: use NUMA node terminology
  event/dpaa2: use NUMA node terminology
  event/dsw: use NUMA node terminology
  event/octeontx: use NUMA node terminology
  event/opdl: use NUMA node terminology
  event/skeleton: use NUMA node terminology
  event/sw: use NUMA node terminology
  mempool/bucket: use NUMA node terminology
  mempool/cnxk: use NUMA node terminology
  ml/cnxk: use NUMA node terminology
  net/af_packet: use NUMA node terminology
  net/af_xdp: use NUMA node terminology
  net/ark: use NUMA node terminology
  net/atlantic: use NUMA node terminology
  net/avp: use NUMA node terminology
  net/axgbe: use NUMA node terminology
  net/bnx2x: use NUMA node terminology
  net/bnxt: use NUMA node terminology
  net/bonding: use NUMA node terminology
  net/cnxk: use NUMA node terminology
  net/cxgbe: use NUMA node terminology
  net/dpaa: use NUMA node terminology
  net/dpaa2: use NUMA node terminology
  net/ena: use NUMA node terminology
  net/enetc: use NUMA node terminology
  net/enetfec: use NUMA node terminology
  net/enic: use NUMA node terminology
  net/failsafe: use NUMA node terminology
  net/gve: use NUMA node terminology
  net/hinic: use NUMA node terminology
  net/hinic3: use NUMA node terminology
  net/hns3: use NUMA node terminology
  net/intel: use NUMA node terminology
  net/ionic: use NUMA node terminology
  net/mana: use NUMA node terminology
  net/memif: use NUMA node terminology
  net/mlx4: use NUMA node terminology
  net/mvneta: use NUMA node terminology
  net/mvpp2: use NUMA node terminology
  net/nbl: use NUMA node terminology
  net/netvsc: use NUMA node terminology
  net/nfb: use NUMA node terminology
  net/nfp: use NUMA node terminology
  net/ngbe: use NUMA node terminology
  net/ntnic: use NUMA node terminology
  net/null: use NUMA node terminology
  net/octeon_ep: use NUMA node terminology
  net/octeontx: use NUMA node terminology
  net/pcap: use NUMA node terminology
  net/pfe: use NUMA node terminology
  net/qede: use NUMA node terminology
  net/r8169: use NUMA node terminology
  net/ring: use NUMA node terminology
  net/rnp: use NUMA node terminology
  net/sfc: use NUMA node terminology
  net/softnic: use NUMA node terminology
  net/sxe2: use NUMA node terminology
  net/tap: use NUMA node terminology
  net/thunderx: use NUMA node terminology
  net/txgbe: use NUMA node terminology
  net/vhost: use NUMA node terminology
  net/virtio: use NUMA node terminology
  net/vmxnet3: use NUMA node terminology
  net/xsc: use NUMA node terminology
  net/zxdh: use NUMA node terminology
  raw/cnxk_bphy: use NUMA node terminology
  raw/cnxk_gpio: use NUMA node terminology
  raw/cnxk_rvu_lf: use NUMA node terminology
  raw/dpaa2_cmdif: use NUMA node terminology
  raw/gdtc: use NUMA node terminology
  raw/ifpga: use NUMA node terminology
  raw/ntb: use NUMA node terminology
  raw/skeleton: use NUMA node terminology
  regex/cn9k: use NUMA node terminology
  regex/mlx5: use NUMA node terminology
  vdpa/mlx5: use NUMA node terminology
  drivers: use NUMA node terminology
  drivers: use NUMA node terminology
  test: use NUMA node terminology
  app/testpmd: use NUMA node terminology
  app/proc-info: use NUMA node terminology
  app/graph: use NUMA node terminology
  app/pdump: use NUMA node terminology
  app/dumpcap: use NUMA node terminology
  app/test-mldev: use NUMA node terminology
  app/test-eventdev: use NUMA node terminology
  app/test-compress-perf: use NUMA node terminology
  app/test-crypto-perf: use NUMA node terminology
  app/test-bbdev: use NUMA node terminology
  app/test-security-perf: use NUMA node terminology
  app/test-regex: use NUMA node terminology
  app/test-flow-perf: use NUMA node terminology
  examples/bbdev_app: use NUMA node terminology
  examples/bond: use NUMA node terminology
  examples/distributor: use NUMA node terminology
  examples/dma: use NUMA node terminology
  examples/ethtool: use NUMA node terminology
  examples/eventdev_pipeline: use NUMA node terminology
  examples/fips_validation: use NUMA node terminology
  examples/flow_filtering: use NUMA node terminology
  examples/ip_fragmentation: use NUMA node terminology
  examples/ip_reassembly: use NUMA node terminology
  examples/ipsec-secgw: use NUMA node terminology
  examples/ipv4_multicast: use NUMA node terminology
  examples/l2fwd: use NUMA node terminology
  examples/l2fwd-cat: use NUMA node terminology
  examples/l2fwd-crypto: use NUMA node terminology
  examples/l2fwd-event: use NUMA node terminology
  examples/l2fwd-jobstats: use NUMA node terminology
  examples/l2fwd-keepalive: use NUMA node terminology
  examples/l2fwd-macsec: use NUMA node terminology
  examples/l3fwd: use NUMA node terminology
  examples/l3fwd-graph: use NUMA node terminology
  examples/l3fwd-power: use NUMA node terminology
  examples/link_status_interrupt: use NUMA node terminology
  examples/multi_process: use NUMA node terminology
  examples/ntb: use NUMA node terminology
  examples/packet_ordering: use NUMA node terminology
  examples/pipeline: use NUMA node terminology
  examples/ptpclient: use NUMA node terminology
  examples/ptp_tap_relay_sw: use NUMA node terminology
  examples/qos_meter: use NUMA node terminology
  examples/qos_sched: use NUMA node terminology
  examples/rxtx_callbacks: use NUMA node terminology
  examples/server_node_efd: use NUMA node terminology
  examples/skeleton: use NUMA node terminology
  examples/vhost: use NUMA node terminology
  examples/vhost_crypto: use NUMA node terminology
  examples/vm_power_manager: use NUMA node terminology
  examples/vmdq: use NUMA node terminology
  examples/vmdq_dcb: use NUMA node terminology
  eal: deprecate legacy socket API aliases
  doc: use NUMA node terminology
  test-dma-perf: use NUMA node terminology
  test/memzone: fix NUMA node terminology rename
  examples: fix NUMA node terminology residue

 app/dumpcap/main.c                            |   4 +-
 app/graph/ethdev.c                            |   4 +-
 app/graph/graph.c                             |   4 +-
 app/graph/l2fwd.c                             |   2 +-
 app/graph/l3fwd.c                             |  10 +-
 app/pdump/main.c                              |  12 +-
 app/proc-info/main.c                          |  10 +-
 app/test-acl/main.c                           |   6 +-
 app/test-bbdev/test_bbdev.c                   |  38 ++--
 app/test-bbdev/test_bbdev_perf.c              |  96 ++++----
 .../comp_perf_test_common.c                   |  44 ++--
 .../comp_perf_test_cyclecount.c               |   6 +-
 .../comp_perf_test_throughput.c               |   6 +-
 .../comp_perf_test_verify.c                   |   4 +-
 app/test-compress-perf/main.c                 |  22 +-
 app/test-crypto-perf/cperf_test_common.c      |   6 +-
 app/test-crypto-perf/main.c                   |  54 ++---
 app/test-dma-perf/benchmark.c                 |   8 +-
 app/test-eventdev/evt_common.h                |   2 +-
 app/test-eventdev/evt_options.c               |   8 +-
 app/test-eventdev/evt_options.h               |   2 +-
 app/test-eventdev/test_order_common.c         |  14 +-
 app/test-eventdev/test_perf_common.c          |  36 +--
 app/test-eventdev/test_pipeline_common.c      |  14 +-
 app/test-flow-perf/main.c                     |  10 +-
 app/test-mldev/ml_options.c                   |  14 +-
 app/test-mldev/ml_options.h                   |   4 +-
 app/test-mldev/test_common.c                  |  10 +-
 app/test-mldev/test_device_ops.c              |  10 +-
 app/test-mldev/test_inference_common.c        |  26 +--
 app/test-mldev/test_model_ops.c               |   4 +-
 app/test-pmd/cmdline.c                        |  26 +--
 app/test-pmd/config.c                         |  10 +-
 app/test-pmd/noisy_vnf.c                      |   2 +-
 app/test-pmd/parameters.c                     |  46 ++--
 app/test-pmd/testpmd.c                        | 122 +++++-----
 app/test-pmd/testpmd.h                        |  20 +-
 app/test-regex/main.c                         |   6 +-
 app/test-sad/main.c                           |   2 +-
 app/test-security-perf/test_security_perf.c   |  10 +-
 app/test/sample_packet_forward.c              |  10 +-
 app/test/test_acl.c                           |   8 +-
 app/test/test_bitratestats.c                  |   2 +-
 app/test/test_bpf.c                           |   8 +-
 app/test/test_cksum.c                         |   2 +-
 app/test/test_compressdev.c                   |  22 +-
 app/test/test_cryptodev.c                     |  50 ++---
 app/test/test_cryptodev_asym.c                |  12 +-
 app/test/test_cryptodev_crosscheck.c          |  10 +-
 app/test/test_distributor.c                   |  14 +-
 app/test/test_distributor_perf.c              |   6 +-
 app/test/test_dmadev.c                        |   4 +-
 app/test/test_efd.c                           |  64 +++---
 app/test/test_efd_perf.c                      |  22 +-
 app/test/test_ethdev_api.c                    |   6 +-
 app/test/test_event_crypto_adapter.c          |  14 +-
 app/test/test_event_dma_adapter.c             |   6 +-
 app/test/test_event_eth_rx_adapter.c          |   8 +-
 app/test/test_event_eth_tx_adapter.c          |   6 +-
 app/test/test_event_ring.c                    |  14 +-
 app/test/test_event_timer_adapter.c           |   6 +-
 app/test/test_event_vector_adapter.c          |   8 +-
 app/test/test_eventdev.c                      |  16 +-
 app/test/test_external_mem.c                  |  18 +-
 app/test/test_fib.c                           |  48 ++--
 app/test/test_fib6.c                          |  66 +++---
 app/test/test_fib6_perf.c                     |   2 +-
 app/test/test_fib_perf.c                      |   2 +-
 app/test/test_func_reentrancy.c               |  16 +-
 app/test/test_graph.c                         |   6 +-
 app/test/test_graph_feature_arc.c             |   2 +-
 app/test/test_graph_perf.c                    |   6 +-
 app/test/test_hash.c                          |  72 +++---
 app/test/test_hash_multiwriter.c              |   2 +-
 app/test/test_hash_perf.c                     |   4 +-
 app/test/test_hash_readwrite.c                |   2 +-
 app/test/test_hash_readwrite_lf_perf.c        |   2 +-
 app/test/test_ipfrag.c                        |   6 +-
 app/test/test_ipsec.c                         |  12 +-
 app/test/test_ipsec_perf.c                    |  12 +-
 app/test/test_ipsec_sad.c                     |  24 +-
 app/test/test_latencystats.c                  |   2 +-
 app/test/test_link_bonding.c                  |  22 +-
 app/test/test_link_bonding_mode4.c            |  16 +-
 app/test/test_link_bonding_rssconf.c          |   8 +-
 app/test/test_lpm.c                           |  64 +++---
 app/test/test_lpm6.c                          |  70 +++---
 app/test/test_lpm6_perf.c                     |   2 +-
 app/test/test_lpm_perf.c                      |   4 +-
 app/test/test_malloc.c                        | 152 ++++++-------
 app/test/test_malloc_perf.c                   |   2 +-
 app/test/test_mbuf.c                          |  18 +-
 app/test/test_member.c                        |   6 +-
 app/test/test_member_perf.c                   |   6 +-
 app/test/test_mempool.c                       |  40 ++--
 app/test/test_mempool_perf.c                  |  10 +-
 app/test/test_memzone.c                       | 121 +++++-----
 app/test/test_metrics.c                       |   2 +-
 app/test/test_mp_secondary.c                  |   8 +-
 app/test/test_net_ether.c                     |   2 +-
 app/test/test_pcapng.c                        |   2 +-
 app/test/test_pdcp.c                          |  14 +-
 app/test/test_pdump.c                         |   2 +-
 app/test/test_per_lcore.c                     |   4 +-
 app/test/test_pmd_af_packet.c                 |  10 +-
 app/test/test_pmd_memif.c                     |   2 +-
 app/test/test_pmd_pcap.c                      |   6 +-
 app/test/test_pmd_perf.c                      |  72 +++---
 app/test/test_pmd_ring.c                      |   2 +-
 app/test/test_pmd_ring_perf.c                 |   2 +-
 app/test/test_pmd_tap.c                       |   6 +-
 app/test/test_rcu_qsbr.c                      |   2 +-
 app/test/test_rcu_qsbr_perf.c                 |   2 +-
 app/test/test_reassembly.c                    |   4 +-
 app/test/test_reassembly_perf.c               |   4 +-
 app/test/test_reorder.c                       |  20 +-
 app/test/test_rib.c                           |  20 +-
 app/test/test_rib6.c                          |  20 +-
 app/test/test_ring.c                          |  28 +--
 app/test/test_ring.h                          |   6 +-
 app/test/test_ring_perf.c                     |  20 +-
 app/test/test_security.c                      |   2 +-
 app/test/test_security_inline_macsec.c        |   8 +-
 app/test/test_security_inline_proto.c         |  12 +-
 app/test/test_stack.c                         |  10 +-
 app/test/test_stack_perf.c                    |  14 +-
 app/test/test_timer_secondary.c               |   4 +-
 app/test/virtual_pmd.c                        |  32 +--
 app/test/virtual_pmd.h                        |   2 +-
 doc/api/doxy-api.conf.in                      |   1 +
 doc/guides/prog_guide/bbdev.rst               |  14 +-
 doc/guides/prog_guide/compressdev.rst         |   4 +-
 .../prog_guide/env_abstraction_layer.rst      |  32 +--
 .../eventdev/event_timer_adapter.rst          |   2 +-
 .../eventdev/event_vector_adapter.rst         |   2 +-
 doc/guides/prog_guide/eventdev/eventdev.rst   |   2 +-
 doc/guides/prog_guide/gpudev.rst              |   2 +-
 doc/guides/prog_guide/ptr_compress_lib.rst    |   2 +-
 doc/guides/rel_notes/deprecation.rst          |  27 +++
 doc/guides/rel_notes/release_26_11.rst        |  25 ++-
 drivers/baseband/acc/acc_common.h             |   4 +-
 drivers/baseband/acc/rte_acc100_pmd.c         |  44 ++--
 drivers/baseband/acc/rte_vrb_pmd.c            |  46 ++--
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |  24 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  24 +-
 drivers/baseband/la12xx/bbdev_la12xx.c        |   2 +-
 drivers/baseband/null/bbdev_null.c            |  26 +--
 .../baseband/turbo_sw/bbdev_turbo_software.c  |  54 ++---
 drivers/bus/auxiliary/auxiliary_common.c      |   2 +-
 drivers/bus/auxiliary/linux/auxiliary.c       |   2 +-
 drivers/bus/dpaa/dpaa_bus.c                   |   2 +-
 drivers/bus/fslmc/fslmc_bus.c                 |   2 +-
 drivers/bus/ifpga/ifpga_bus.c                 |   2 +-
 drivers/bus/pci/bsd/pci.c                     |   2 +-
 drivers/bus/pci/linux/pci.c                   |   2 +-
 drivers/bus/pci/pci_common.c                  |   2 +-
 drivers/bus/pci/windows/pci.c                 |   2 +-
 drivers/bus/platform/platform.c               |   2 +-
 drivers/bus/vdev/vdev.c                       |   4 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           |   2 +-
 drivers/bus/vmbus/vmbus_channel.c             |   2 +-
 drivers/bus/vmbus/vmbus_common.c              |   2 +-
 drivers/common/cnxk/roc_platform.c            |   2 +-
 drivers/common/cnxk/roc_platform.h            |   2 +-
 .../common/mlx5/linux/mlx5_common_auxiliary.c |   6 +-
 drivers/common/mlx5/linux/mlx5_nl.c           |   4 +-
 drivers/common/mlx5/mlx5_common.c             |   4 +-
 drivers/common/mlx5/mlx5_common_mr.c          |  16 +-
 drivers/common/mlx5/mlx5_common_mr.h          |   2 +-
 drivers/common/mlx5/mlx5_common_utils.c       |   6 +-
 drivers/common/mlx5/mlx5_devx_cmds.c          |  50 ++---
 drivers/common/mlx5/mlx5_malloc.c             |  10 +-
 drivers/common/mlx5/mlx5_malloc.h             |   4 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   4 +-
 drivers/common/nitrox/nitrox_device.c         |   2 +-
 drivers/common/nitrox/nitrox_qp.c             |  16 +-
 drivers/common/nitrox/nitrox_qp.h             |   2 +-
 drivers/common/qat/qat_device.c               |   2 +-
 drivers/common/qat/qat_qp.c                   |  22 +-
 drivers/common/qat/qat_qp.h                   |   2 +-
 drivers/common/zsda/zsda_device.c             |   4 +-
 drivers/common/zsda/zsda_qp.c                 |  18 +-
 drivers/common/zsda/zsda_qp.h                 |   4 +-
 drivers/compress/isal/isal_compress_pmd.c     |   4 +-
 drivers/compress/isal/isal_compress_pmd_ops.c |  26 +--
 drivers/compress/mlx5/mlx5_compress.c         |  22 +-
 drivers/compress/nitrox/nitrox_comp.c         |  22 +-
 drivers/compress/nitrox/nitrox_comp_reqmgr.c  |  22 +-
 drivers/compress/nitrox/nitrox_comp_reqmgr.h  |   2 +-
 drivers/compress/octeontx/otx_zip_pmd.c       |  18 +-
 drivers/compress/qat/qat_comp.c               |  14 +-
 drivers/compress/qat/qat_comp.h               |   2 +-
 drivers/compress/qat/qat_comp_pmd.c           |  36 +--
 drivers/compress/qat/qat_comp_pmd.h           |   2 +-
 drivers/compress/uadk/uadk_compress_pmd.c     |  14 +-
 drivers/compress/zlib/zlib_pmd.c              |   2 +-
 drivers/compress/zlib/zlib_pmd_ops.c          |  16 +-
 drivers/compress/zsda/zsda_comp_pmd.c         |  14 +-
 drivers/crypto/armv8/rte_armv8_pmd.c          |   6 +-
 drivers/crypto/armv8/rte_armv8_pmd_ops.c      |  12 +-
 drivers/crypto/bcmfs/bcmfs_qp.c               |  16 +-
 drivers/crypto/bcmfs/bcmfs_qp.h               |   2 +-
 drivers/crypto/bcmfs/bcmfs_sym_pmd.c          |  12 +-
 drivers/crypto/caam_jr/caam_jr.c              |   8 +-
 drivers/crypto/ccp/ccp_dev.c                  |  14 +-
 drivers/crypto/ccp/ccp_pmd_ops.c              |  14 +-
 drivers/crypto/ccp/rte_ccp_pmd.c              |  10 +-
 drivers/crypto/cnxk/cn10k_cryptodev.c         |   2 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c         |   2 +-
 drivers/crypto/cnxk/cn9k_cryptodev.c          |   2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  12 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   4 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |   8 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |   8 +-
 drivers/crypto/ionic/ionic_crypto.h           |   6 +-
 drivers/crypto/ionic/ionic_crypto_main.c      |  42 ++--
 drivers/crypto/ionic/ionic_crypto_ops.c       |   8 +-
 drivers/crypto/ionic/ionic_crypto_vdev.c      |   2 +-
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c        |  22 +-
 drivers/crypto/ipsec_mb/ipsec_mb_private.c    |   2 +-
 drivers/crypto/ipsec_mb/ipsec_mb_private.h    |   4 +-
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c       |   6 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c        |   2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c          |   2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c             |   2 +-
 drivers/crypto/mlx5/mlx5_crypto.c             |   2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |  18 +-
 drivers/crypto/mlx5/mlx5_crypto_xts.c         |  12 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c           |   8 +-
 drivers/crypto/mvsam/rte_mrvl_pmd_ops.c       |   8 +-
 drivers/crypto/nitrox/nitrox_sym.c            |  12 +-
 drivers/crypto/nitrox/nitrox_sym_reqmgr.c     |   4 +-
 drivers/crypto/nitrox/nitrox_sym_reqmgr.h     |   2 +-
 drivers/crypto/null/null_crypto_pmd.c         |   4 +-
 drivers/crypto/null/null_crypto_pmd_ops.c     |  12 +-
 drivers/crypto/octeontx/otx_cryptodev.c       |   2 +-
 .../crypto/octeontx/otx_cryptodev_hw_access.c |   2 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |   6 +-
 drivers/crypto/openssl/rte_openssl_pmd.c      |   4 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  12 +-
 drivers/crypto/qat/asym/qat_asym.c            |   2 +-
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c    |   2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c  |   6 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |   2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |   4 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c  |   2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c  |   2 +-
 .../crypto/qat/dev/qat_crypto_pmd_gen_lce.c   |   2 +-
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c     |   2 +-
 drivers/crypto/qat/qat_crypto.c               |   4 +-
 drivers/crypto/qat/qat_crypto.h               |   2 +-
 drivers/crypto/qat/qat_sym.c                  |   2 +-
 .../scheduler/rte_cryptodev_scheduler.c       |  16 +-
 drivers/crypto/scheduler/scheduler_failover.c |   4 +-
 .../crypto/scheduler/scheduler_multicore.c    |  12 +-
 .../scheduler/scheduler_pkt_size_distr.c      |   8 +-
 drivers/crypto/scheduler/scheduler_pmd.c      |  24 +-
 drivers/crypto/scheduler/scheduler_pmd_ops.c  |  10 +-
 .../crypto/scheduler/scheduler_roundrobin.c   |   4 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         |  12 +-
 drivers/crypto/virtio/virtio_cryptodev.c      |  14 +-
 drivers/crypto/virtio/virtio_cryptodev.h      |   2 +-
 drivers/crypto/virtio/virtio_user_cryptodev.c |   2 +-
 drivers/crypto/virtio/virtqueue.c             |   2 +-
 drivers/crypto/zsda/zsda_crypto_pmd.c         |  12 +-
 drivers/dma/ae4dma/ae4dma_dmadev.c            |   6 +-
 drivers/dma/cnxk/cnxk_dmadev.c                |   2 +-
 drivers/dma/dpaa/dpaa_qdma.c                  |   2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   4 +-
 drivers/dma/hisi_acc/hisi_acc_dmadev.c        |   2 +-
 drivers/dma/idxd/idxd_bus.c                   |   2 +-
 drivers/dma/idxd/idxd_common.c                |   2 +-
 drivers/dma/imx_edma5/imx_edma5_dmadev.c      |   8 +-
 drivers/dma/odm/odm.c                         |   4 +-
 drivers/dma/skeleton/skeleton_dmadev.c        |  26 +--
 drivers/dma/skeleton/skeleton_dmadev.h        |   2 +-
 drivers/event/cnxk/cn10k_eventdev.c           |   4 +-
 drivers/event/cnxk/cn20k_eventdev.c           |   4 +-
 drivers/event/cnxk/cn9k_eventdev.c            |   8 +-
 drivers/event/cnxk/cnxk_eventdev.c            |   2 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c      |   2 +-
 drivers/event/cnxk/cnxk_eventdev_selftest.c   |   2 +-
 drivers/event/cnxk/cnxk_tim_evdev.c           |   4 +-
 drivers/event/dlb2/dlb2.c                     |   8 +-
 drivers/event/dlb2/dlb2_priv.h                |   4 +-
 drivers/event/dlb2/dlb2_selftest.c            |   2 +-
 drivers/event/dlb2/dlb2_xstats.c              |   8 +-
 drivers/event/dlb2/pf/dlb2_pf.c               |  14 +-
 drivers/event/dpaa/dpaa_eventdev.c            |   2 +-
 drivers/event/dpaa2/dpaa2_eventdev.c          |   2 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   2 +-
 drivers/event/dsw/dsw_evdev.c                 |   6 +-
 drivers/event/octeontx/ssovf_evdev.c          |   6 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |   2 +-
 drivers/event/octeontx/ssovf_worker.c         |   2 +-
 drivers/event/octeontx/timvf_evdev.c          |   2 +-
 drivers/event/opdl/opdl_evdev.c               |  16 +-
 drivers/event/opdl/opdl_ring.c                |   6 +-
 drivers/event/opdl/opdl_ring.h                |   2 +-
 drivers/event/opdl/opdl_test.c                |   2 +-
 drivers/event/skeleton/skeleton_eventdev.c    |  18 +-
 drivers/event/sw/event_ring.h                 |   4 +-
 drivers/event/sw/sw_evdev.c                   |  32 +--
 drivers/event/sw/sw_evdev_selftest.c          |   2 +-
 drivers/event/sw/sw_evdev_xstats.c            |   4 +-
 drivers/mempool/bucket/rte_mempool_bucket.c   |  14 +-
 drivers/mempool/cnxk/cn10k_mempool_ops.c      |   2 +-
 drivers/mempool/cnxk/cnxk_mempool.c           |   2 +-
 .../mempool/octeontx/rte_mempool_octeontx.c   |   4 +-
 drivers/mempool/ring/rte_mempool_ring.c       |   2 +-
 drivers/mempool/stack/rte_mempool_stack.c     |   2 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                |   2 +-
 drivers/ml/cnxk/cnxk_ml_ops.c                 |  12 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c                |   2 +-
 drivers/net/af_packet/rte_eth_af_packet.c     |  22 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  34 +--
 drivers/net/ark/ark_ethdev.c                  |   4 +-
 drivers/net/ark/ark_ethdev_rx.c               |  14 +-
 drivers/net/ark/ark_ethdev_rx.h               |   2 +-
 drivers/net/ark/ark_ethdev_tx.c               |  14 +-
 drivers/net/ark/ark_ethdev_tx.h               |   2 +-
 drivers/net/atlantic/atl_ethdev.h             |   4 +-
 drivers/net/atlantic/atl_rxtx.c               |  24 +-
 drivers/net/avp/avp_ethdev.c                  |  16 +-
 drivers/net/axgbe/axgbe_rxtx.c                |  16 +-
 drivers/net/axgbe/axgbe_rxtx.h                |   4 +-
 drivers/net/bnx2x/bnx2x.c                     |   2 +-
 drivers/net/bnx2x/bnx2x_rxtx.c                |  22 +-
 drivers/net/bnx2x/bnx2x_rxtx.h                |   4 +-
 drivers/net/bnxt/bnxt_ethdev.c                |   6 +-
 drivers/net/bnxt/bnxt_mpc.c                   |  38 ++--
 drivers/net/bnxt/bnxt_reps.c                  |  32 +--
 drivers/net/bnxt/bnxt_reps.h                  |   4 +-
 drivers/net/bnxt/bnxt_ring.c                  |  12 +-
 drivers/net/bnxt/bnxt_ring.h                  |   2 +-
 drivers/net/bnxt/bnxt_rxq.c                   |  10 +-
 drivers/net/bnxt/bnxt_rxq.h                   |   2 +-
 drivers/net/bnxt/bnxt_rxr.c                   |  22 +-
 drivers/net/bnxt/bnxt_rxr.h                   |   2 +-
 drivers/net/bnxt/bnxt_txq.c                   |  14 +-
 drivers/net/bnxt/bnxt_txq.h                   |   2 +-
 drivers/net/bnxt/bnxt_txr.c                   |  18 +-
 drivers/net/bnxt/bnxt_txr.h                   |   2 +-
 drivers/net/bnxt/bnxt_vnic.c                  |   2 +-
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   2 +-
 drivers/net/bnxt/tf_ulp/ulp_matcher.c         |   4 +-
 drivers/net/bonding/eth_bond_private.h        |   2 +-
 drivers/net/bonding/rte_eth_bond.h            |   4 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  14 +-
 drivers/net/bonding/rte_eth_bond_alb.c        |   4 +-
 drivers/net/bonding/rte_eth_bond_api.c        |   4 +-
 drivers/net/bonding/rte_eth_bond_args.c       |  14 +-
 drivers/net/bonding/rte_eth_bond_flow.c       |   2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  36 +--
 drivers/net/cnxk/cnxk_eswitch.c               |   2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |   6 +-
 drivers/net/cnxk/cnxk_lookup.c                |   2 +-
 drivers/net/cnxk/cnxk_rep.h                   |   4 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |   8 +-
 drivers/net/cxgbe/base/adapter.h              |   6 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |  16 +-
 drivers/net/cxgbe/cxgbe_main.c                |  18 +-
 drivers/net/cxgbe/cxgbe_pfvf.h                |   4 +-
 drivers/net/cxgbe/cxgbevf_main.c              |   4 +-
 drivers/net/cxgbe/sge.c                       |  28 +--
 drivers/net/dpaa/dpaa_ethdev.c                |   6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |   6 +-
 drivers/net/dpaa2/dpaa2_tm.c                  |   6 +-
 drivers/net/ena/base/ena_plat_dpdk.h          |   6 +-
 drivers/net/ena/ena_ethdev.c                  |  42 ++--
 drivers/net/ena/ena_ethdev.h                  |   2 +-
 drivers/net/enetc/enetc.h                     |   4 +-
 drivers/net/enetc/enetc4_ethdev.c             |   4 +-
 drivers/net/enetc/enetc_ethdev.c              |   4 +-
 drivers/net/enetfec/enet_ethdev.c             |   4 +-
 drivers/net/enic/base/vnic_cq.c               |   8 +-
 drivers/net/enic/base/vnic_cq.h               |   4 +-
 drivers/net/enic/base/vnic_dev.c              |   4 +-
 drivers/net/enic/base/vnic_dev.h              |   2 +-
 drivers/net/enic/base/vnic_rq.c               |   6 +-
 drivers/net/enic/base/vnic_rq.h               |   2 +-
 drivers/net/enic/base/vnic_wq.c               |   8 +-
 drivers/net/enic/base/vnic_wq.h               |   2 +-
 drivers/net/enic/enic.h                       |   4 +-
 drivers/net/enic/enic_ethdev.c                |   8 +-
 drivers/net/enic/enic_fm_flow.c               |   2 +-
 drivers/net/enic/enic_main.c                  |  32 +--
 drivers/net/enic/enic_sriov.c                 |  10 +-
 drivers/net/enic/enic_vf_representor.c        |   8 +-
 drivers/net/failsafe/failsafe.c               |   6 +-
 drivers/net/failsafe/failsafe_ether.c         |   4 +-
 drivers/net/failsafe/failsafe_intr.c          |   2 +-
 drivers/net/failsafe/failsafe_ops.c           |  12 +-
 drivers/net/failsafe/failsafe_private.h       |   4 +-
 drivers/net/gve/base/gve_osdep.h              |   2 +-
 drivers/net/gve/gve_ethdev.c                  |  14 +-
 drivers/net/gve/gve_ethdev.h                  |   8 +-
 drivers/net/gve/gve_rx.c                      |  16 +-
 drivers/net/gve/gve_rx_dqo.c                  |  24 +-
 drivers/net/gve/gve_tx.c                      |  18 +-
 drivers/net/gve/gve_tx_dqo.c                  |  16 +-
 drivers/net/hinic/base/hinic_compat.h         |   6 +-
 drivers/net/hinic/base/hinic_pmd_api_cmd.c    |   6 +-
 drivers/net/hinic/base/hinic_pmd_eqs.c        |   2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c      |  20 +-
 drivers/net/hinic/base/hinic_pmd_mbox.c       |   2 +-
 drivers/net/hinic/base/hinic_pmd_wq.c         |  10 +-
 drivers/net/hinic/base/hinic_pmd_wq.h         |   2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  26 +--
 drivers/net/hinic/hinic_pmd_rx.c              |  16 +-
 drivers/net/hinic/hinic_pmd_rx.h              |   4 +-
 drivers/net/hinic/hinic_pmd_tx.c              |   8 +-
 drivers/net/hinic/hinic_pmd_tx.h              |   4 +-
 drivers/net/hinic3/base/hinic3_cmdq.c         |   2 +-
 drivers/net/hinic3/base/hinic3_eqs.c          |   2 +-
 drivers/net/hinic3/base/hinic3_hwdev.c        |   4 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |   2 +-
 drivers/net/hinic3/base/hinic3_mbox.c         |   4 +-
 drivers/net/hinic3/base/hinic3_wq.c           |   2 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  38 ++--
 drivers/net/hns3/hns3_cmd.c                   |   2 +-
 drivers/net/hns3/hns3_fdir.c                  |   2 +-
 drivers/net/hns3/hns3_rxtx.c                  |  44 ++--
 drivers/net/hns3/hns3_rxtx.h                  |   6 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   4 +-
 drivers/net/intel/cpfl/cpfl_representor.c     |   4 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  74 +++----
 drivers/net/intel/cpfl/cpfl_rxtx.h            |   4 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |   8 +-
 drivers/net/intel/e1000/em_rxtx.c             |   8 +-
 drivers/net/intel/e1000/igb_rxtx.c            |   8 +-
 drivers/net/intel/e1000/igc_txrx.c            |   8 +-
 drivers/net/intel/e1000/igc_txrx.h            |   4 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  28 +--
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   2 +-
 drivers/net/intel/i40e/i40e_fdir.c            |   8 +-
 drivers/net/intel/i40e/i40e_flow_ethertype.c  |   2 +-
 drivers/net/intel/i40e/i40e_rxtx.c            |  44 ++--
 drivers/net/intel/i40e/i40e_rxtx.h            |   4 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |   4 +-
 drivers/net/intel/iavf/iavf_osdep.c           |   2 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |  32 +--
 drivers/net/intel/iavf/iavf_rxtx.h            |   4 +-
 .../net/intel/ice/ice_dcf_vf_representor.c    |   4 +-
 drivers/net/intel/ice/ice_fdir_filter.c       |   8 +-
 drivers/net/intel/ice/ice_osdep.h             |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              |  46 ++--
 drivers/net/intel/ice/ice_rxtx.h              |   4 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   6 +-
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   2 +-
 drivers/net/intel/idpf/idpf_osdep.h           |   2 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  60 ++---
 drivers/net/intel/idpf/idpf_rxtx.h            |   4 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |   2 +-
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |   4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |  32 +--
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |   4 +-
 drivers/net/ionic/ionic_lif.c                 |  38 ++--
 drivers/net/ionic/ionic_lif.h                 |   4 +-
 drivers/net/ionic/ionic_main.c                |   6 +-
 drivers/net/ionic/ionic_rxtx.c                |  12 +-
 drivers/net/ionic/ionic_rxtx.h                |   4 +-
 drivers/net/mana/mana.c                       |  54 ++---
 drivers/net/mana/mr.c                         |   4 +-
 drivers/net/memif/memif_socket.c              |   2 +-
 drivers/net/memif/rte_eth_memif.c             |   4 +-
 drivers/net/mlx4/mlx4.c                       |   8 +-
 drivers/net/mlx4/mlx4_mr.c                    |  14 +-
 drivers/net/mlx4/mlx4_utils.c                 |  14 +-
 drivers/net/mlx5/hws/mlx5dr_internal.h        |   4 +-
 drivers/net/mlx5/linux/mlx5_ethdev_os.c       |   8 +-
 drivers/net/mlx5/linux/mlx5_os.c              |  14 +-
 drivers/net/mlx5/linux/mlx5_verbs.c           |   6 +-
 drivers/net/mlx5/linux/mlx5_vlan_os.c         |   2 +-
 drivers/net/mlx5/mlx5.c                       |  16 +-
 drivers/net/mlx5/mlx5_devx.c                  |  12 +-
 drivers/net/mlx5/mlx5_ethdev.c                |   6 +-
 drivers/net/mlx5/mlx5_flow.c                  |  29 +--
 drivers/net/mlx5/mlx5_flow_aso.c              |   8 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |  32 +--
 drivers/net/mlx5/mlx5_flow_flex.c             |   4 +-
 drivers/net/mlx5/mlx5_flow_geneve.c           |   2 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  48 ++--
 drivers/net/mlx5/mlx5_flow_meter.c            |  14 +-
 drivers/net/mlx5/mlx5_flow_quota.c            |   6 +-
 drivers/net/mlx5/mlx5_flow_verbs.c            |   2 +-
 drivers/net/mlx5/mlx5_hws_cnt.c               |  30 +--
 drivers/net/mlx5/mlx5_nta_sample.c            |  16 +-
 drivers/net/mlx5/mlx5_nta_split.c             |   2 +-
 drivers/net/mlx5/mlx5_rss.c                   |   4 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  24 +-
 drivers/net/mlx5/mlx5_stats.c                 |   2 +-
 drivers/net/mlx5/mlx5_trigger.c               |   2 +-
 drivers/net/mlx5/mlx5_tx.c                    |   2 +-
 drivers/net/mlx5/mlx5_txq.c                   |  13 +-
 drivers/net/mlx5/mlx5_utils.c                 |  30 +--
 drivers/net/mlx5/windows/mlx5_flow_os.c       |   4 +-
 drivers/net/mlx5/windows/mlx5_os.c            |   8 +-
 drivers/net/mvneta/mvneta_ethdev.c            |   2 +-
 drivers/net/mvneta/mvneta_rxtx.c              |   4 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |   6 +-
 drivers/net/mvpp2/mrvl_flow.c                 |   8 +-
 drivers/net/mvpp2/mrvl_mtr.c                  |   4 +-
 drivers/net/mvpp2/mrvl_qos.c                  |   4 +-
 drivers/net/mvpp2/mrvl_tm.c                   |   6 +-
 drivers/net/nbl/nbl_common/nbl_common.c       |   2 +-
 drivers/net/nbl/nbl_dev/nbl_dev.c             |   8 +-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   4 +-
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  14 +-
 drivers/net/nbl/nbl_include/nbl_include.h     |   4 +-
 drivers/net/netvsc/hn_ethdev.c                |   6 +-
 drivers/net/netvsc/hn_rxtx.c                  |  30 +--
 drivers/net/netvsc/hn_var.h                   |  10 +-
 drivers/net/netvsc/hn_vf.c                    |   8 +-
 drivers/net/nfb/nfb_ethdev.c                  |   2 +-
 drivers/net/nfb/nfb_rx.c                      |   8 +-
 drivers/net/nfb/nfb_rx.h                      |   2 +-
 drivers/net/nfb/nfb_tx.c                      |   8 +-
 drivers/net/nfb/nfb_tx.h                      |   2 +-
 drivers/net/nfp/flower/nfp_conntrack.c        |   2 +-
 drivers/net/nfp/flower/nfp_flower.c           |  16 +-
 drivers/net/nfp/flower/nfp_flower_flow.c      |  10 +-
 .../net/nfp/flower/nfp_flower_representor.c   |  20 +-
 drivers/net/nfp/nfd3/nfp_nfd3.h               |   2 +-
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c            |  12 +-
 drivers/net/nfp/nfdk/nfp_nfdk.h               |   2 +-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c            |  12 +-
 drivers/net/nfp/nfp_net_common.c              |   2 +-
 drivers/net/nfp/nfp_net_flow.c                |   2 +-
 drivers/net/nfp/nfp_rxtx.c                    |  18 +-
 drivers/net/nfp/nfp_rxtx.h                    |   4 +-
 drivers/net/nfp/nfpcore/nfp_sync.c            |   2 +-
 drivers/net/ngbe/ngbe_ethdev.c                |   2 +-
 drivers/net/ngbe/ngbe_ethdev.h                |   4 +-
 drivers/net/ngbe/ngbe_rxtx.c                  |  28 +--
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |   4 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |   2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |   2 +-
 .../flow_api/profile_inline/flm_age_queue.c   |   2 +-
 .../flow_api/profile_inline/flm_evt_queue.c   |   2 +-
 .../flow_api/profile_inline/flm_lrn_queue.c   |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  24 +-
 drivers/net/ntnic/ntutil/nt_util.c            |   4 +-
 drivers/net/null/rte_eth_null.c               |  14 +-
 drivers/net/octeon_ep/otx_ep_common.h         |   4 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  12 +-
 drivers/net/octeon_ep/otx_ep_rxtx.c           |  32 +--
 drivers/net/octeontx/octeontx_ethdev.c        |  40 ++--
 drivers/net/pcap/pcap_ethdev.c                |  14 +-
 drivers/net/pfe/pfe_ethdev.c                  |   4 +-
 drivers/net/qede/base/bcm_osal.c              |  12 +-
 drivers/net/qede/qede_filter.c                |   2 +-
 drivers/net/qede/qede_rxtx.c                  |  54 ++---
 drivers/net/qede/qede_rxtx.h                  |   4 +-
 drivers/net/r8169/r8169_ethdev.h              |   4 +-
 drivers/net/r8169/r8169_hw.c                  |   2 +-
 drivers/net/r8169/r8169_rxtx.c                |  16 +-
 drivers/net/ring/rte_eth_ring.c               |  20 +-
 drivers/net/rnp/base/rnp_osdep.h              |   2 +-
 drivers/net/rnp/rnp_ethdev.c                  |   4 +-
 drivers/net/rnp/rnp_rxtx.c                    |  40 ++--
 drivers/net/rnp/rnp_rxtx.h                    |   4 +-
 drivers/net/sfc/sfc.c                         |  20 +-
 drivers/net/sfc/sfc.h                         |   4 +-
 drivers/net/sfc/sfc_dp_rx.h                   |   4 +-
 drivers/net/sfc/sfc_dp_tx.h                   |   4 +-
 drivers/net/sfc/sfc_ef100_rx.c                |  10 +-
 drivers/net/sfc/sfc_ef100_tx.c                |  10 +-
 drivers/net/sfc/sfc_ef10_essb_rx.c            |  10 +-
 drivers/net/sfc/sfc_ef10_rx.c                 |  10 +-
 drivers/net/sfc/sfc_ef10_tx.c                 |  14 +-
 drivers/net/sfc/sfc_ethdev.c                  |  16 +-
 drivers/net/sfc/sfc_ev.c                      |  10 +-
 drivers/net/sfc/sfc_ev.h                      |   2 +-
 drivers/net/sfc/sfc_mae.c                     |   2 +-
 drivers/net/sfc/sfc_mae_counter.c             |  26 +--
 drivers/net/sfc/sfc_mcdi.c                    |   2 +-
 drivers/net/sfc/sfc_port.c                    |  10 +-
 drivers/net/sfc/sfc_repr.c                    |  20 +-
 drivers/net/sfc/sfc_repr_proxy.c              |  18 +-
 drivers/net/sfc/sfc_rx.c                      |  26 +--
 drivers/net/sfc/sfc_rx.h                      |   2 +-
 drivers/net/sfc/sfc_service.c                 |  22 +-
 drivers/net/sfc/sfc_service.h                 |   2 +-
 drivers/net/sfc/sfc_sw_stats.c                |   4 +-
 drivers/net/sfc/sfc_tbl_meta_cache.c          |   2 +-
 drivers/net/sfc/sfc_tso.c                     |   6 +-
 drivers/net/sfc/sfc_tx.c                      |  28 +--
 drivers/net/sfc/sfc_tx.h                      |   4 +-
 drivers/net/softnic/rte_eth_softnic.c         |   6 +-
 drivers/net/softnic/rte_eth_softnic_thread.c  |   4 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c           |   2 +-
 drivers/net/sxe2/sxe2_mp.c                    |   2 +-
 drivers/net/sxe2/sxe2_rx.c                    |  16 +-
 drivers/net/sxe2/sxe2_rx.h                    |   2 +-
 drivers/net/sxe2/sxe2_tx.c                    |  16 +-
 drivers/net/sxe2/sxe2_tx.h                    |   2 +-
 drivers/net/tap/rte_eth_tap.c                 |  22 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  24 +-
 drivers/net/txgbe/txgbe_ethdev.c              |   6 +-
 drivers/net/txgbe/txgbe_ethdev.h              |   4 +-
 drivers/net/txgbe/txgbe_rxtx.c                |  34 +--
 drivers/net/vhost/rte_eth_vhost.c             |  28 +--
 drivers/net/virtio/virtio_ethdev.c            |   4 +-
 drivers/net/virtio/virtio_ethdev.h            |   4 +-
 drivers/net/virtio/virtio_rxtx.c              |   6 +-
 .../net/virtio/virtio_user/virtio_user_dev.c  |   2 +-
 drivers/net/virtio/virtqueue.c                |   6 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  14 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.h          |   4 +-
 drivers/net/vmxnet3/vmxnet3_rxtx.c            |   8 +-
 drivers/net/xsc/xsc_ethdev.c                  |   4 +-
 drivers/net/xsc/xsc_rx.c                      |   2 +-
 drivers/net/xsc/xsc_rxtx.h                    |   6 +-
 drivers/net/xsc/xsc_tx.c                      |   4 +-
 drivers/net/xsc/xsc_vfio.c                    |  18 +-
 drivers/net/xsc/xsc_vfio_mbox.c               |   6 +-
 drivers/net/zxdh/zxdh_ethdev.c                |  18 +-
 drivers/net/zxdh/zxdh_queue.c                 |   4 +-
 drivers/net/zxdh/zxdh_queue.h                 |   4 +-
 drivers/raw/cnxk_bphy/cnxk_bphy.c             |   2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c         |   2 +-
 drivers/raw/cnxk_gpio/cnxk_gpio.c             |   4 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |   2 +-
 drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c         |  10 +-
 drivers/raw/gdtc/gdtc_rawdev.c                |   6 +-
 drivers/raw/ifpga/afu_pmd_core.c              |  14 +-
 drivers/raw/ifpga/base/ifpga_defines.h        |   2 +-
 drivers/raw/ifpga/base/ifpga_fme.c            |   4 +-
 drivers/raw/ifpga/base/ifpga_hw.h             |   2 +-
 drivers/raw/ifpga/ifpga_rawdev.c              |  10 +-
 drivers/raw/ntb/ntb.c                         |  26 +--
 drivers/raw/skeleton/skeleton_rawdev.c        |  10 +-
 drivers/raw/skeleton/skeleton_rawdev_test.c   |  14 +-
 drivers/regex/cn9k/cn9k_regexdev.c            |   6 +-
 drivers/regex/mlx5/mlx5_regex_control.c       |   6 +-
 drivers/vdpa/mlx5/mlx5_vdpa_cthread.c         |   2 +-
 drivers/vdpa/mlx5/mlx5_vdpa_event.c           |   4 +-
 examples/bbdev_app/main.c                     |  18 +-
 examples/bond/main.c                          |  12 +-
 examples/distributor/main.c                   |  30 +--
 examples/dma/dmafwd.c                         |   8 +-
 examples/ethtool/ethtool-app/main.c           |   6 +-
 examples/ethtool/lib/rte_ethtool.c            |   4 +-
 .../pipeline_worker_generic.c                 |   6 +-
 .../eventdev_pipeline/pipeline_worker_tx.c    |   6 +-
 examples/fips_validation/fips_dev_self_test.c |  10 +-
 examples/fips_validation/main.c               |  14 +-
 examples/flow_filtering/main.c                |   6 +-
 examples/ip_fragmentation/main.c              |  10 +-
 examples/ip_reassembly/main.c                 |  18 +-
 examples/ipsec-secgw/event_helper.c           |  14 +-
 examples/ipsec-secgw/ipsec-secgw.c            | 132 +++++------
 examples/ipsec-secgw/ipsec-secgw.h            |   2 +-
 examples/ipsec-secgw/ipsec.h                  |  10 +-
 examples/ipsec-secgw/ipsec_worker.c           |  56 ++---
 examples/ipsec-secgw/rt.c                     |  22 +-
 examples/ipsec-secgw/sa.c                     |  30 +--
 examples/ipsec-secgw/sad.c                    |  12 +-
 examples/ipsec-secgw/sad.h                    |   2 +-
 examples/ipsec-secgw/sp4.c                    |  12 +-
 examples/ipsec-secgw/sp6.c                    |  12 +-
 examples/ipv4_multicast/main.c                |  14 +-
 examples/l2fwd-cat/l2fwd-cat.c                |  12 +-
 examples/l2fwd-crypto/main.c                  |  38 ++--
 examples/l2fwd-event/l2fwd_common.c           |   4 +-
 examples/l2fwd-event/l2fwd_poll.c             |   4 +-
 examples/l2fwd-event/main.c                   |   4 +-
 examples/l2fwd-jobstats/main.c                |  10 +-
 examples/l2fwd-keepalive/main.c               |  10 +-
 examples/l2fwd-macsec/main.c                  |  12 +-
 examples/l2fwd/main.c                         |  10 +-
 examples/l3fwd-graph/main.c                   |  24 +-
 examples/l3fwd-power/main.c                   |  32 +--
 examples/l3fwd/l3fwd.h                        |   2 +-
 examples/l3fwd/l3fwd_acl.c                    |  26 +--
 examples/l3fwd/l3fwd_em.c                     |   8 +-
 examples/l3fwd/l3fwd_event.h                  |   2 +-
 examples/l3fwd/l3fwd_fib.c                    |   4 +-
 examples/l3fwd/l3fwd_lpm.c                    |   4 +-
 examples/l3fwd/main.c                         |  16 +-
 examples/link_status_interrupt/main.c         |  10 +-
 .../client_server_mp/mp_client/client.c       |   4 +-
 .../client_server_mp/mp_server/init.c         |  14 +-
 examples/multi_process/simple_mp/main.c       |   6 +-
 examples/multi_process/symmetric_mp/main.c    |   6 +-
 examples/ntb/ntb_fwd.c                        |  14 +-
 examples/packet_ordering/main.c               |  16 +-
 examples/pipeline/obj.c                       |  12 +-
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  |   6 +-
 examples/ptpclient/ptpclient.c                |   6 +-
 examples/qos_meter/main.c                     |  14 +-
 examples/qos_sched/args.c                     |   4 +-
 examples/qos_sched/init.c                     |   8 +-
 examples/rxtx_callbacks/main.c                |  12 +-
 examples/server_node_efd/efd_node/node.c      |   6 +-
 examples/server_node_efd/efd_server/init.c    |  22 +-
 examples/server_node_efd/efd_server/main.c    |   8 +-
 examples/skeleton/basicfwd.c                  |  12 +-
 examples/vhost/main.c                         |   6 +-
 examples/vhost_crypto/main.c                  |  26 +--
 examples/vm_power_manager/main.c              |   6 +-
 examples/vmdq/main.c                          |   6 +-
 examples/vmdq_dcb/main.c                      |   6 +-
 lib/acl/acl.h                                 |   4 +-
 lib/acl/acl_gen.c                             |  10 +-
 lib/acl/rte_acl.c                             |  14 +-
 lib/acl/rte_acl.h                             |  14 +-
 lib/bbdev/bbdev_trace.h                       |   4 +-
 lib/bbdev/rte_bbdev.c                         |  26 +--
 lib/bbdev/rte_bbdev.h                         |  36 ++-
 lib/bbdev/rte_bbdev_op.h                      |   6 +-
 lib/bbdev/rte_bbdev_pmd.h                     |   2 +-
 lib/compressdev/rte_comp.c                    |   4 +-
 lib/compressdev/rte_comp.h                    |   4 +-
 lib/compressdev/rte_compressdev.c             |  35 +--
 lib/compressdev/rte_compressdev.h             |  35 ++-
 lib/compressdev/rte_compressdev_internal.h    |   2 +-
 lib/compressdev/rte_compressdev_pmd.c         |  10 +-
 lib/compressdev/rte_compressdev_pmd.h         |  12 +-
 lib/cryptodev/cryptodev_pmd.c                 |  14 +-
 lib/cryptodev/cryptodev_pmd.h                 |  24 +-
 lib/cryptodev/cryptodev_trace.h               |  18 +-
 lib/cryptodev/cryptodev_trace_points.c        |   4 +-
 lib/cryptodev/rte_crypto.h                    |   4 +-
 lib/cryptodev/rte_cryptodev.c                 |  63 +++---
 lib/cryptodev/rte_cryptodev.h                 |  56 +++--
 lib/dispatcher/rte_dispatcher.c               |  12 +-
 lib/distributor/rte_distributor.c             |   6 +-
 lib/distributor/rte_distributor.h             |   4 +-
 lib/distributor/rte_distributor_single.c      |   4 +-
 lib/distributor/rte_distributor_single.h      |   4 +-
 lib/dmadev/rte_dmadev.c                       |   4 +-
 lib/eal/common/eal_common_dynmem.c            | 174 +++++++--------
 lib/eal/common/eal_common_lcore.c             |  85 ++++---
 lib/eal/common/eal_common_memalloc.c          |  38 ++--
 lib/eal/common/eal_common_memory.c            |  52 ++---
 lib/eal/common/eal_common_memzone.c           |  38 ++--
 lib/eal/common/eal_common_options.c           |  12 +-
 lib/eal/common/eal_common_thread.c            |  34 +--
 lib/eal/common/eal_hugepages.h                |   2 +-
 lib/eal/common/eal_internal_cfg.h             |   2 +-
 lib/eal/common/eal_memalloc.h                 |  10 +-
 lib/eal/common/eal_memcfg.h                   |   2 +-
 lib/eal/common/eal_private.h                  |  12 +-
 lib/eal/common/eal_thread.h                   |   6 +-
 lib/eal/common/malloc_heap.c                  | 204 +++++++++--------
 lib/eal/common/malloc_heap.h                  |  12 +-
 lib/eal/common/malloc_mp.c                    |  10 +-
 lib/eal/common/malloc_mp.h                    |   4 +-
 lib/eal/common/rte_malloc.c                   | 156 ++++++++-----
 lib/eal/freebsd/eal.c                         |  12 +-
 lib/eal/freebsd/eal_lcore.c                   |   2 +-
 lib/eal/freebsd/eal_memalloc.c                |   4 +-
 lib/eal/freebsd/eal_memory.c                  |   2 +-
 lib/eal/include/eal_trace_internal.h          |  16 +-
 lib/eal/include/rte_lcore.h                   |  71 +++++-
 lib/eal/include/rte_malloc.h                  | 208 ++++++++++++++++--
 lib/eal/include/rte_memory.h                  |  30 ++-
 lib/eal/include/rte_memzone.h                 |  22 +-
 lib/eal/include/rte_service_component.h       |  12 +-
 lib/eal/linux/eal.c                           |  16 +-
 lib/eal/linux/eal_hugepage_info.c             |  40 ++--
 lib/eal/linux/eal_lcore.c                     |   2 +-
 lib/eal/linux/eal_memalloc.c                  |  40 ++--
 lib/eal/linux/eal_memory.c                    |  78 +++----
 lib/eal/windows/eal_hugepages.c               |  12 +-
 lib/eal/windows/eal_lcore.c                   |  42 ++--
 lib/eal/windows/eal_memalloc.c                |  40 ++--
 lib/eal/windows/eal_memory.c                  |  10 +-
 lib/eal/windows/eal_windows.h                 |  18 +-
 lib/efd/rte_efd.c                             | 104 ++++-----
 lib/efd/rte_efd.h                             |  38 ++--
 lib/ethdev/ethdev_driver.c                    |  10 +-
 lib/ethdev/ethdev_driver.h                    |  10 +-
 lib/ethdev/ethdev_pci.h                       |   8 +-
 lib/ethdev/ethdev_private.c                   |   2 +-
 lib/ethdev/ethdev_trace.h                     |   6 +-
 lib/ethdev/ethdev_trace_points.c              |   4 +-
 lib/ethdev/ethdev_vdev.h                      |   2 +-
 lib/ethdev/rte_ethdev.c                       |  31 ++-
 lib/ethdev/rte_ethdev.h                       |  39 +++-
 lib/ethdev/rte_ethdev_telemetry.c             |   2 +-
 lib/eventdev/event_timer_adapter_pmd.h        |   4 +-
 lib/eventdev/event_vector_adapter_pmd.h       |   4 +-
 lib/eventdev/eventdev_pmd.h                   |  10 +-
 lib/eventdev/eventdev_pmd_pci.h               |   4 +-
 lib/eventdev/eventdev_pmd_vdev.h              |  12 +-
 lib/eventdev/eventdev_trace.h                 |  14 +-
 lib/eventdev/eventdev_trace_points.c          |   4 +-
 lib/eventdev/rte_event_crypto_adapter.c       |  30 +--
 lib/eventdev/rte_event_dma_adapter.c          |  38 ++--
 lib/eventdev/rte_event_eth_rx_adapter.c       |  68 +++---
 lib/eventdev/rte_event_eth_tx_adapter.c       |  30 +--
 lib/eventdev/rte_event_ring.c                 |   6 +-
 lib/eventdev/rte_event_ring.h                 |   8 +-
 lib/eventdev/rte_event_timer_adapter.c        |  16 +-
 lib/eventdev/rte_event_timer_adapter.h        |  11 +-
 lib/eventdev/rte_event_vector_adapter.c       |  12 +-
 lib/eventdev/rte_event_vector_adapter.h       |  11 +-
 lib/eventdev/rte_eventdev.c                   |  33 +--
 lib/eventdev/rte_eventdev.h                   |  25 ++-
 lib/fib/dir24_8.c                             |  14 +-
 lib/fib/dir24_8.h                             |   2 +-
 lib/fib/rte_fib.c                             |  14 +-
 lib/fib/rte_fib.h                             |   6 +-
 lib/fib/rte_fib6.c                            |  14 +-
 lib/fib/rte_fib6.h                            |   6 +-
 lib/fib/trie.c                                |  14 +-
 lib/fib/trie.h                                |   2 +-
 lib/gpudev/gpudev.c                           |   2 +-
 lib/graph/graph.c                             |  14 +-
 lib/graph/graph_debug.c                       |   2 +-
 lib/graph/graph_feature_arc.c                 |   4 +-
 lib/graph/graph_pcap.c                        |   2 +-
 lib/graph/graph_populate.c                    |   4 +-
 lib/graph/graph_private.h                     |   4 +-
 lib/graph/graph_stats.c                       |  18 +-
 lib/graph/rte_graph.h                         |  21 +-
 lib/graph/rte_graph_model_mcore_dispatch.c    |   4 +-
 lib/graph/rte_graph_worker_common.h           |  10 +-
 lib/gro/gro_tcp4.c                            |  14 +-
 lib/gro/gro_tcp4.h                            |   6 +-
 lib/gro/gro_tcp6.c                            |  14 +-
 lib/gro/gro_tcp6.h                            |   6 +-
 lib/gro/gro_udp4.c                            |  14 +-
 lib/gro/gro_udp4.h                            |   6 +-
 lib/gro/gro_vxlan_tcp4.c                      |  14 +-
 lib/gro/gro_vxlan_tcp4.h                      |   6 +-
 lib/gro/gro_vxlan_udp4.c                      |  14 +-
 lib/gro/gro_vxlan_udp4.h                      |   6 +-
 lib/gro/rte_gro.c                             |   8 +-
 lib/gro/rte_gro.h                             |  17 +-
 lib/hash/rte_cuckoo_hash.c                    |  28 +--
 lib/hash/rte_fbk_hash.c                       |   2 +-
 lib/hash/rte_fbk_hash.h                       |  10 +-
 lib/hash/rte_hash.h                           |  10 +-
 lib/ip_frag/rte_ip_frag.h                     |   8 +-
 lib/ip_frag/rte_ip_frag_common.c              |  12 +-
 lib/ipsec/ipsec_sad.c                         |   6 +-
 lib/ipsec/rte_ipsec_sad.h                     |  11 +-
 lib/latencystats/rte_latencystats.c           |   2 +-
 lib/lpm/rte_lpm.c                             |  16 +-
 lib/lpm/rte_lpm.h                             |   6 +-
 lib/lpm/rte_lpm6.c                            |  10 +-
 lib/lpm/rte_lpm6.h                            |   6 +-
 lib/mbuf/rte_mbuf.c                           |  12 +-
 lib/mbuf/rte_mbuf.h                           |  18 +-
 lib/mbuf/rte_mbuf_dyn.c                       |   2 +-
 lib/mbuf/rte_mbuf_pool_ops.c                  |   4 +-
 lib/member/rte_member.c                       |   8 +-
 lib/member/rte_member.h                       |  20 +-
 lib/member/rte_member_heap.h                  |  18 +-
 lib/member/rte_member_ht.c                    |   4 +-
 lib/member/rte_member_sketch.c                |  24 +-
 lib/member/rte_member_vbf.c                   |   4 +-
 lib/mempool/mempool_trace.h                   |   4 +-
 lib/mempool/rte_mempool.c                     |  60 ++---
 lib/mempool/rte_mempool.h                     |  38 ++--
 lib/metrics/rte_metrics.c                     |   4 +-
 lib/metrics/rte_metrics.h                     |   4 +-
 lib/metrics/rte_metrics_telemetry.c           |   4 +-
 lib/mldev/rte_mldev.c                         |  24 +-
 lib/mldev/rte_mldev.h                         |  33 +--
 lib/mldev/rte_mldev_core.h                    |  10 +-
 lib/mldev/rte_mldev_pmd.c                     |  10 +-
 lib/mldev/rte_mldev_pmd.h                     |  10 +-
 lib/node/ip4_lookup.c                         |   4 +-
 lib/node/ip4_lookup_fib.c                     |  10 +-
 lib/node/ip6_lookup.c                         |   4 +-
 lib/node/ip6_lookup_fib.c                     |  10 +-
 lib/node/kernel_rx.c                          |   4 +-
 lib/node/node_mbuf_dynfield.c                 |   2 +-
 lib/node/udp4_input.c                         |   8 +-
 lib/pdcp/rte_pdcp.c                           |   4 +-
 lib/pdump/rte_pdump.c                         |   2 +-
 lib/rawdev/rte_rawdev.c                       |  25 ++-
 lib/rawdev/rte_rawdev.h                       |  38 +++-
 lib/rawdev/rte_rawdev_pmd.h                   |   8 +-
 lib/rcu/rte_rcu_qsbr.c                        |   2 +-
 lib/regexdev/rte_regexdev.c                   |   2 +-
 lib/reorder/rte_reorder.c                     |   4 +-
 lib/reorder/rte_reorder.h                     |   4 +-
 lib/rib/rte_rib.c                             |   8 +-
 lib/rib/rte_rib.h                             |   6 +-
 lib/rib/rte_rib6.c                            |   8 +-
 lib/rib/rte_rib6.h                            |   6 +-
 lib/ring/rte_ring.c                           |  12 +-
 lib/ring/rte_ring.h                           |   8 +-
 lib/ring/rte_ring_elem.h                      |   8 +-
 lib/stack/rte_stack.c                         |   4 +-
 lib/stack/rte_stack.h                         |   8 +-
 lib/table/rte_swx_table_em.c                  |   2 +-
 lib/table/rte_swx_table_learner.c             |   2 +-
 lib/table/rte_swx_table_selector.c            |   2 +-
 lib/table/rte_swx_table_wm.c                  |   4 +-
 lib/timer/rte_timer.c                         |   2 +-
 lib/vhost/iotlb.c                             |   2 +-
 lib/vhost/rte_vhost_crypto.h                  |   4 +-
 lib/vhost/vhost.c                             |   4 +-
 lib/vhost/vhost_crypto.c                      |  16 +-
 lib/vhost/vhost_user.c                        |  22 +-
 905 files changed, 6113 insertions(+), 5439 deletions(-)

-- 
2.55.0

