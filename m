Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3408C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B912D40270;
	Thu, 16 Jul 2026 12:36:42 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id AF6AC400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:36:41 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 1056BEC011A;
 Thu, 16 Jul 2026 06:36:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1784198201; x=
 1784284601; bh=0kWG5MNOvtO9miVMkXw5JsJmYgQlougx48C41gS6f20=; b=W
 /YAR+FOZR5irv5xaZzMH9yp19Wrg0e5XQmJv1TggkjcKsC9SMQ5mEmBtiY6QG0nK
 tuazGHo7e/P/hJCkuCEM7N+S5h1hblfSepq5UNbuSH3KCQkuTWTjL9ydUgE1jpug
 mHQcnHQHbE5v/tF10zZDN89wgxmXnx0zjbkPh6+Jgmd1r1oxCMJ4Nvsy6sUFYyUR
 rqP3X9l+NmbE7kLrO5SzVgiGkU4jZT4RpXwuGDUPPAYJLTvhaZfW3ir40ZGvoIyD
 4PzrrloLpBdIIBr1PsZqNgpqdwtRaEkIjGX0cor64WmoWxK/8X/CN71E7uFvY9aV
 25SRMeKTazt9LPGEl+S/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1784198201; x=1784284601; bh=0kWG5MNOvtO9miVMkXw5JsJmYgQl
 ougx48C41gS6f20=; b=KXVj7+m0Ry+hTy3HfLR8fZjZVX86ZNFbQzzq3sPfaFRe
 mTBeZCLuvvTj4knhFdP3fF8lJMF3KE1vE1aHC8AADclXVztrEdhv9nxcb4rpcQNN
 Ey0bUfWhbqTjQzbHKNEefYv1UC5avdXDzj8OTYIxg5bth7vrlw9ssSoVaW27tMER
 kV0ZJkD6A/EafKdCZQaR9UlhL+RAj9jWDD+mGA8067jmQ7U4dLt5/evqCvTVOmFj
 vy9obMpgqmIZSMbbREYwdZMyHDK0I/E3knFBF0phN0MtFghRQXphSN1i1rbhXp/g
 nqbiEPQK9wyaoMVouZ/bQu4+u/zO0x7LkyeyurqqPQ==
X-ME-Sender: <xms:OLRYardqPWWaQCs3LBMMsCYUdKXFNO5HgcjZQK6FHBFWxUS1KFYnUQ>
 <xme:OLRYanFrWM6Q-h1mfy_POuey9-Vv6_ptNJdcSoII4AGlBqIg3slc16_bqz9aTWffw
 UbC4AfaaxtiAWI8K6WA_sms_mLB2W0X6TaYGmu0uvLkv1zsJehYlA>
X-ME-Received: <xmr:OLRYavkRCl_lLGX_e9yq8DEOgcOG_K6VWcOFp0MxppLAMGaTcXEfG0WZbsTfcG8wc3ZYN0XF6Gx4KqS4emA8wMY>
X-ME-Proxy-Cause: dmFkZTGXnJzwZfFeXtgZrOIHwBzd8BWHY2/OfkUk8SA/GBTiWIlVKU3RJ2U01rD11i8SoW
 xysBCguySZt0z2YgHkZHDoxW+Z4hqqLce23ogdJzkWf6/rJXh+lSl489L56ZtfGPWLUVkX
 nIKUD0zuui6SZoosfgGJZzFaRdvGrI2C+9vvRe5iEAT605OvcJMe7xNLDPGkyGmErkEWcJ
 Et1P5n8dVZ+mTs/rv9a3Lp1Jl4vv4kQIBQDtgXAolsv6lv/7CymOmid6gvR4qGIt3X/qFi
 zZNXG/OLH5HowzoV05wArxTyOkzt0j4NrkZRG3RwavGbLj5CL/T3c4mjxXoLEbxXNjEJm8
 yFBDScR6jYG9czcsNd74nK8MxPo0l9Gkqgw2boZKjZCRvqeBcy4NSffR0XSJnEpAtTQZIW
 w06RfI0Zadx+J6TUIqdic/Eq6qMKrvqIc6r41tfkHof+qI5kd7kg3xZ6K2gokjSoaTsAzu
 c9FmXsPeUEBnVogWlIYC8b3y1rsBmtGN5//B8pslti+8AiRIuInq3F6B/wihXvc2XdDhLr
 NqSYBzSJ7XO5bKSyTi3mFuuB3tuTBiEa3lrq3ApxlUyy8YdVQPH6Udz42Rb86CStrW5JgL
 dIO824wCi1jjiZxWzBitfStVmv16IHWxhyPpJe445K9HuWJZ+iVSr6xdFblQ
X-ME-Proxy: <xmx:OLRYapxxm6mSXWJ-7N03_zpQP-FHwITKY85SINZIDxtAYTPc4Ky7wA>
 <xmx:OLRYarTyM1_GQ0yy7a8BxKgon0Lfjt-GBJGv1_teN0gtIIdJBIK2WA>
 <xmx:OLRYasuPkXPTHCJfxpKxe-AmC9rucQxG0ws5-HKbVh98LAiIIqeLeg>
 <xmx:OLRYatuQczb2MtKoNJGF11hs8D4Eq1GY31IQGYO4645UdGEe23C29w>
 <xmx:ObRYag8qKsupb1J_CLV3dVPCJSFYh9UtcgtRgy2DwM1BjbTr4fEX2PAh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 16 Jul 2026 06:36:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH v3 0/8] doc: clean-up links in guides
Date: Thu, 16 Jul 2026 12:31:18 +0200
Message-ID: <20260716103632.711164-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250527140435.21361-1-nandinipersad361@gmail.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Links and references to other guide sections had multiple issues,
all solved in this series.

The important metric in cleanups is having more deletions than additions:
 278 files changed, 1054 insertions(+), 1700 deletions(-)
meaning it should be easier to maintain.


David Marchand (1):
  doc: remove unused labels from guides

Nandini Persad (1):
  doc: add prefixes to guide labels

Thomas Monjalon (6):
  doc: adjust heading underline lengths
  doc: replace vague references with precise links
  doc: shorten page references in guides
  doc: link whole-guide references to pages
  doc: remove redundant link captions
  doc: avoid numbered guide references

 doc/guides/bbdevs/acc100.rst                  |   8 +-
 doc/guides/bbdevs/fpga_5gnr_fec.rst           |   4 +-
 doc/guides/bbdevs/fpga_lte_fec.rst            |  10 +-
 doc/guides/bbdevs/la12xx.rst                  |   8 +-
 doc/guides/bbdevs/null.rst                    |   2 +-
 doc/guides/bbdevs/overview.rst                |   2 -
 doc/guides/bbdevs/turbo_sw.rst                |   2 -
 doc/guides/bbdevs/vrb1.rst                    |   6 +-
 doc/guides/bbdevs/vrb2.rst                    |   6 +-
 doc/guides/compressdevs/isal.rst              |   2 -
 doc/guides/compressdevs/mlx5.rst              |   2 +-
 doc/guides/compressdevs/overview.rst          |   2 -
 doc/guides/compressdevs/qat_comp.rst          |   2 +-
 doc/guides/compressdevs/uadk.rst              |   4 +-
 doc/guides/compressdevs/zlib.rst              |   2 +-
 doc/guides/compressdevs/zsda.rst              |   2 +-
 doc/guides/contributing/abi_policy.rst        |  54 +++--
 doc/guides/contributing/abi_versioning.rst    |  39 ++--
 doc/guides/contributing/cheatsheet.rst        |   2 -
 doc/guides/contributing/coding_style.rst      |  12 +-
 doc/guides/contributing/design.rst            |   6 +-
 doc/guides/contributing/documentation.rst     |  62 ++----
 doc/guides/contributing/new_driver.rst        |   6 +-
 doc/guides/contributing/patches.rst           |  17 +-
 doc/guides/contributing/stable.rst            |   2 -
 doc/guides/cryptodevs/aesni_gcm.rst           |   2 -
 doc/guides/cryptodevs/aesni_mb.rst            |   2 -
 doc/guides/cryptodevs/caam_jr.rst             |   4 +-
 doc/guides/cryptodevs/cnxk.rst                |   6 +-
 doc/guides/cryptodevs/dpaa2_sec.rst           |   4 +-
 doc/guides/cryptodevs/dpaa_sec.rst            |   6 +-
 doc/guides/cryptodevs/mlx5.rst                |   2 +-
 doc/guides/cryptodevs/octeontx.rst            |   2 +-
 doc/guides/cryptodevs/overview.rst            |  14 +-
 doc/guides/cryptodevs/qat.rst                 |  15 +-
 doc/guides/cryptodevs/snow3g.rst              |   2 -
 doc/guides/cryptodevs/uadk.rst                |   4 +-
 doc/guides/cryptodevs/zuc.rst                 |   2 -
 doc/guides/dmadevs/cnxk.rst                   |   6 +-
 doc/guides/dmadevs/dpaa.rst                   |   4 +-
 doc/guides/dmadevs/dpaa2.rst                  |   4 +-
 doc/guides/dmadevs/hisi_acc.rst               |   4 +-
 doc/guides/dmadevs/idxd.rst                   |  20 +-
 doc/guides/dmadevs/ioat.rst                   |  18 +-
 doc/guides/dmadevs/odm.rst                    |   3 +-
 doc/guides/eventdevs/cnxk.rst                 |   4 +-
 doc/guides/eventdevs/dlb2.rst                 |   3 +-
 doc/guides/eventdevs/dpaa.rst                 |   8 +-
 doc/guides/eventdevs/dpaa2.rst                |   4 +-
 doc/guides/eventdevs/octeontx.rst             |   2 +-
 doc/guides/eventdevs/opdl.rst                 |   2 +-
 doc/guides/eventdevs/overview.rst             |  14 --
 doc/guides/faq/faq.rst                        |   6 +-
 doc/guides/freebsd_gsg/build_dpdk.rst         |   8 +-
 doc/guides/freebsd_gsg/build_sample_apps.rst  |   8 +-
 doc/guides/freebsd_gsg/index.rst              |   2 -
 doc/guides/freebsd_gsg/install_from_ports.rst |  14 +-
 doc/guides/freebsd_gsg/intro.rst              |   2 +-
 doc/guides/howto/af_xdp_dp.rst                |   8 +-
 doc/guides/howto/avx512.rst                   |   5 +-
 doc/guides/howto/flow_bifurcation.rst         |   6 +-
 doc/guides/howto/lm_bond_virtio_sriov.rst     |   9 +-
 doc/guides/howto/lm_virtio_vhost_user.rst     |   6 +-
 doc/guides/howto/openwrt.rst                  |   2 +-
 doc/guides/howto/packet_capture_framework.rst |  13 +-
 doc/guides/howto/pvp_reference_benchmark.rst  |   6 +-
 doc/guides/howto/rte_flow.rst                 |   4 +-
 doc/guides/howto/security.rst                 |  46 ++--
 doc/guides/howto/telemetry.rst                |   2 +-
 doc/guides/howto/vfd.rst                      |   2 -
 .../howto/virtio_user_as_exception_path.rst   |  10 +-
 .../virtio_user_for_container_networking.rst  |  10 +-
 doc/guides/linux_gsg/build_dpdk.rst           |   6 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |  13 +-
 .../linux_gsg/cross_build_dpdk_for_arm64.rst  |  10 +-
 doc/guides/linux_gsg/doc_roadmap.include.rst  |  28 +--
 doc/guides/linux_gsg/enable_func.rst          |   8 +-
 doc/guides/linux_gsg/index.rst                |   2 -
 doc/guides/linux_gsg/linux_drivers.rst        |  20 +-
 .../linux_gsg/nic_perf_intel_platform.rst     |   2 +-
 doc/guides/linux_gsg/sys_reqs.rst             |   9 +-
 doc/guides/mempool/cnxk.rst                   |   4 +-
 doc/guides/mempool/octeontx.rst               |   2 +-
 doc/guides/mempool/ring.rst                   |   2 +-
 doc/guides/mempool/stack.rst                  |   2 +-
 doc/guides/mldevs/cnxk.rst                    |   8 +-
 doc/guides/nics/af_xdp.rst                    |   2 +-
 doc/guides/nics/ark.rst                       |  15 +-
 doc/guides/nics/avp.rst                       |   2 +-
 doc/guides/nics/axgbe.rst                     |   9 +-
 doc/guides/nics/bnx2x.rst                     |   9 +-
 doc/guides/nics/bnxt.rst                      |   2 +-
 doc/guides/nics/build_and_test.rst            |  11 +-
 doc/guides/nics/cnxk.rst                      |  11 +-
 doc/guides/nics/cpfl.rst                      |   4 +-
 doc/guides/nics/cxgbe.rst                     |  32 +--
 doc/guides/nics/dpaa.rst                      |  11 +-
 doc/guides/nics/dpaa2.rst                     |  19 +-
 doc/guides/nics/ena.rst                       |  14 +-
 doc/guides/nics/enetc.rst                     |   4 +-
 doc/guides/nics/enetc4.rst                    |   4 +-
 doc/guides/nics/enic.rst                      |   9 +-
 doc/guides/nics/fail_safe.rst                 |   3 +-
 doc/guides/nics/features.rst                  |   8 +-
 doc/guides/nics/hinic.rst                     |   5 +-
 doc/guides/nics/hinic3.rst                    |   6 +-
 doc/guides/nics/hns3.rst                      |   8 +-
 doc/guides/nics/i40e.rst                      |  29 ++-
 doc/guides/nics/ice.rst                       |  17 +-
 doc/guides/nics/idpf.rst                      |   4 +-
 doc/guides/nics/igc.rst                       |   5 +-
 doc/guides/nics/intel_vf.rst                  |  18 +-
 doc/guides/nics/ionic.rst                     |   5 +-
 doc/guides/nics/ipn3ke.rst                    |   9 +-
 doc/guides/nics/ixgbe.rst                     |   4 +-
 doc/guides/nics/mana.rst                      |   3 +-
 doc/guides/nics/memif.rst                     |   4 +-
 doc/guides/nics/mlx4.rst                      |  12 +-
 doc/guides/nics/mlx5.rst                      |  14 +-
 doc/guides/nics/mvneta.rst                    |   3 +-
 doc/guides/nics/mvpp2.rst                     |  39 ++--
 doc/guides/nics/nbl.rst                       |   3 +-
 doc/guides/nics/netvsc.rst                    |   4 +-
 doc/guides/nics/nfp.rst                       |   3 +-
 doc/guides/nics/ngbe.rst                      |   5 +-
 doc/guides/nics/octeon_ep.rst                 |   2 +-
 doc/guides/nics/octeontx.rst                  |   9 +-
 doc/guides/nics/overview.rst                  |   2 -
 doc/guides/nics/pfe.rst                       |   6 +-
 doc/guides/nics/qede.rst                      |  13 +-
 doc/guides/nics/rnp.rst                       |   2 -
 doc/guides/nics/softnic.rst                   |  11 +-
 doc/guides/nics/thunderx.rst                  |   9 +-
 doc/guides/nics/txgbe.rst                     |   9 +-
 doc/guides/nics/vhost.rst                     |   2 +-
 doc/guides/nics/virtio.rst                    |   4 +-
 doc/guides/nics/vmxnet3.rst                   |  12 +-
 doc/guides/nics/xsc.rst                       |   3 +-
 doc/guides/nics/zxdh.rst                      |   3 +-
 doc/guides/platform/bluefield.rst             |   8 +-
 doc/guides/platform/cnxk.rst                  |  38 ++--
 doc/guides/platform/dpaa.rst                  |  15 +-
 doc/guides/platform/dpaa2.rst                 |  15 +-
 doc/guides/platform/mlx5.rst                  |  14 +-
 doc/guides/platform/octeontx.rst              |  17 +-
 doc/guides/prog_guide/asan.rst                |   2 +-
 doc/guides/prog_guide/bbdev.rst               |  12 +-
 doc/guides/prog_guide/build-sdk-meson.rst     |  18 +-
 doc/guides/prog_guide/build_app.rst           |   2 +-
 doc/guides/prog_guide/cmdline.rst             |   2 +-
 doc/guides/prog_guide/compressdev.rst         |   6 +-
 doc/guides/prog_guide/cryptodev_lib.rst       |   6 +-
 doc/guides/prog_guide/devargs.rst             |   4 +-
 doc/guides/prog_guide/dmadev.rst              |   4 +-
 doc/guides/prog_guide/efd_lib.rst             |  59 +++--
 .../prog_guide/env_abstraction_layer.rst      |  28 ++-
 doc/guides/prog_guide/ethdev/ethdev.rst       |   4 +-
 doc/guides/prog_guide/ethdev/flow_offload.rst | 204 +-----------------
 .../prog_guide/ethdev/qos_framework.rst       | 130 +++++------
 .../ethdev/traffic_metering_and_policing.rst  |   4 +-
 .../prog_guide/eventdev/dispatcher_lib.rst    |   4 +-
 .../eventdev/event_crypto_adapter.rst         |   6 +-
 .../prog_guide/eventdev/event_dma_adapter.rst |   6 +-
 .../eventdev/event_ethernet_rx_adapter.rst    |   2 +-
 .../eventdev/event_ethernet_tx_adapter.rst    |   2 +-
 .../eventdev/event_timer_adapter.rst          |   2 +-
 doc/guides/prog_guide/eventdev/eventdev.rst   |   2 -
 doc/guides/prog_guide/fib_lib.rst             |   6 +-
 .../generic_receive_offload_lib.rst           |   4 +-
 .../generic_segmentation_offload_lib.rst      |   8 +-
 doc/guides/prog_guide/graph_lib.rst           |  58 +++--
 doc/guides/prog_guide/hash_lib.rst            |  10 +-
 doc/guides/prog_guide/index.rst               |   2 +-
 doc/guides/prog_guide/ipsec_lib.rst           |   4 +-
 .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
 doc/guides/prog_guide/mbuf_lib.rst            |   6 +-
 doc/guides/prog_guide/member_lib.rst          |  10 +-
 doc/guides/prog_guide/mempool_lib.rst         |  15 +-
 doc/guides/prog_guide/mldev.rst               |   2 -
 doc/guides/prog_guide/multi_proc_support.rst  |  11 +-
 doc/guides/prog_guide/overview.rst            |   2 -
 .../prog_guide/packet_classif_access_ctrl.rst |   4 +-
 doc/guides/prog_guide/packet_framework.rst    |  91 ++++----
 doc/guides/prog_guide/pdcp_lib.rst            |   2 -
 doc/guides/prog_guide/pdump_lib.rst           |   2 -
 doc/guides/prog_guide/power_man.rst           |  12 +-
 doc/guides/prog_guide/profile_app.rst         |   2 +-
 doc/guides/prog_guide/rcu_lib.rst             |   4 +-
 doc/guides/prog_guide/regexdev.rst            |   2 +-
 doc/guides/prog_guide/reorder_lib.rst         |   8 +-
 doc/guides/prog_guide/rib_lib.rst             |  12 +-
 doc/guides/prog_guide/ring_lib.rst            |  43 ----
 doc/guides/prog_guide/rte_security.rst        |   6 +-
 doc/guides/prog_guide/source_org.rst          |   2 +-
 doc/guides/prog_guide/stack_lib.rst           |   2 +-
 doc/guides/prog_guide/telemetry_lib.rst       |   2 +-
 doc/guides/prog_guide/thread_safety.rst       |   2 +-
 doc/guides/prog_guide/toeplitz_hash_lib.rst   |  14 +-
 doc/guides/prog_guide/trace_lib.rst           |  10 +-
 doc/guides/rawdevs/dpaa2_cmdif.rst            |   4 +-
 doc/guides/rawdevs/ifpga.rst                  |   4 +-
 doc/guides/regexdevs/cn9k.rst                 |   6 +-
 doc/guides/regexdevs/features_overview.rst    |   2 -
 doc/guides/regexdevs/mlx5.rst                 |   4 +-
 doc/guides/rel_notes/deprecation.rst          |   3 +-
 doc/guides/rel_notes/release_17_02.rst        |   4 +-
 doc/guides/rel_notes/release_17_11.rst        |  16 +-
 doc/guides/rel_notes/release_18_02.rst        |   4 +-
 doc/guides/rel_notes/release_18_05.rst        |  14 +-
 doc/guides/rel_notes/release_18_08.rst        |   4 +-
 doc/guides/rel_notes/release_18_11.rst        |  10 +-
 doc/guides/rel_notes/release_19_02.rst        |   6 +-
 doc/guides/rel_notes/release_19_05.rst        |   4 +-
 doc/guides/rel_notes/release_19_08.rst        |   6 +-
 doc/guides/rel_notes/release_19_11.rst        |  14 +-
 doc/guides/rel_notes/release_20_02.rst        |   6 +-
 doc/guides/rel_notes/release_20_05.rst        |   4 +-
 doc/guides/rel_notes/release_20_08.rst        |   4 +-
 doc/guides/rel_notes/release_20_11.rst        |  10 +-
 doc/guides/rel_notes/release_21_02.rst        |   4 +-
 doc/guides/rel_notes/release_21_08.rst        |   4 +-
 doc/guides/rel_notes/release_21_11.rst        |   6 +-
 doc/guides/rel_notes/release_22_03.rst        |   2 +-
 doc/guides/rel_notes/release_22_07.rst        |   2 +-
 doc/guides/rel_notes/release_22_11.rst        |  12 +-
 doc/guides/rel_notes/release_23_03.rst        |   2 +-
 doc/guides/rel_notes/release_23_07.rst        |   4 +-
 doc/guides/rel_notes/release_23_11.rst        |   2 +-
 doc/guides/rel_notes/release_24_07.rst        |   2 +-
 doc/guides/rel_notes/release_25_03.rst        |   2 +-
 doc/guides/rel_notes/release_25_07.rst        |  10 +-
 doc/guides/sample_app_ug/compiling.rst        |   6 +-
 doc/guides/sample_app_ug/dist_app.rst         |   6 +-
 doc/guides/sample_app_ug/dma.rst              |  10 +-
 .../sample_app_ug/eventdev_pipeline.rst       |   9 +-
 doc/guides/sample_app_ug/flow_filtering.rst   |   2 +-
 doc/guides/sample_app_ug/intro.rst            |   4 +-
 doc/guides/sample_app_ug/ip_pipeline.rst      |   4 -
 doc/guides/sample_app_ug/ip_reassembly.rst    |   4 +-
 .../sample_app_ug/l2_forward_crypto.rst       |   2 -
 doc/guides/sample_app_ug/l2_forward_event.rst |  19 +-
 .../sample_app_ug/l2_forward_job_stats.rst    |  14 +-
 .../sample_app_ug/l2_forward_real_virtual.rst |  20 +-
 doc/guides/sample_app_ug/l3_forward.rst       |   4 -
 doc/guides/sample_app_ug/l3_forward_graph.rst |   2 -
 .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
 doc/guides/sample_app_ug/link_status_intr.rst |   4 +-
 doc/guides/sample_app_ug/multi_process.rst    |   4 -
 doc/guides/sample_app_ug/packet_ordering.rst  |   2 +-
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |   2 +-
 doc/guides/sample_app_ug/ptpclient.rst        |   6 +-
 doc/guides/sample_app_ug/qos_metering.rst     |   2 -
 doc/guides/sample_app_ug/qos_scheduler.rst    |   7 +-
 doc/guides/sample_app_ug/server_node_efd.rst  |   7 +-
 doc/guides/sample_app_ug/skeleton.rst         |   4 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |   6 +-
 doc/guides/sample_app_ug/vdpa.rst             |   2 -
 doc/guides/sample_app_ug/vhost.rst            |   7 +-
 doc/guides/sample_app_ug/vhost_blk.rst        |   6 +-
 doc/guides/sample_app_ug/vhost_crypto.rst     |   2 -
 .../sample_app_ug/vm_power_management.rst     |  37 ++--
 .../sample_app_ug/vmdq_dcb_forwarding.rst     |   5 +-
 doc/guides/sample_app_ug/vmdq_forwarding.rst  |   2 +-
 doc/guides/testpmd_app_ug/index.rst           |   2 -
 doc/guides/testpmd_app_ug/run_app.rst         |   6 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  26 +--
 doc/guides/tools/dts.rst                      |  28 ++-
 doc/guides/tools/flow-perf.rst                |   4 +-
 doc/guides/tools/graph.rst                    |  70 +++---
 doc/guides/tools/pdump.rst                    |   2 -
 doc/guides/tools/securityperf.rst             |   4 +-
 doc/guides/tools/testbbdev.rst                |   8 +-
 doc/guides/tools/testeventdev.rst             |  48 +----
 doc/guides/tools/testmldev.rst                |  12 --
 doc/guides/vdpadevs/features_overview.rst     |   2 -
 doc/guides/vdpadevs/mlx5.rst                  |   2 +-
 doc/guides/windows_gsg/index.rst              |   2 -
 doc/guides/windows_gsg/intro.rst              |   2 +-
 278 files changed, 1054 insertions(+), 1700 deletions(-)

-- 
2.54.0

