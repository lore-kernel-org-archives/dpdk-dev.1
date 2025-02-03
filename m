Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CEC02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C54406B8;
	Mon,  3 Feb 2025 05:06:54 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B2F6340693
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:47 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F0752203717F; Sun,  2 Feb 2025 20:06:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0752203717F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555606;
 bh=WSSo6JhaKSnx4yuS4g8tYhQR69/ZsP9zc0ySCBXc9CQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eTZJyVvDeLkQsh4pW/B5+9Bh9qroHQNbooUf5XqUt1vaI0Ctw0G1DHMX9Fpdsyl+5
 0ez0igs5/V9h7XeR6ditCX2OKXGXqBQdQsaTLzhsx0+tCd9Dkf476s5W54yhoswGNm
 iiyRjgl1/uk2eEIFG6R5qnuBcis9s0H2xddn21zE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v19 00/27] remove use of VLAs for Windows
Date: Sun,  2 Feb 2025 20:06:03 -0800
Message-Id: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As per guidance technical board meeting 2024/04/17. This series
removes the use of VLAs from code built for Windows for all 3
toolchains. If there are additional opportunities to convert VLAs
to regular C arrays please provide the details for incorporation
into the series.

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

v19:
 * rename no_vla_cflag to no_wvla_cflag
 * add no_wvla_cflag to
     buildtools/chkincs/meson.build
     drivers/crypto/ipsec_mb/meson.build
     drivers/net/mana/meson.build

v18:
 * add no_vla_cflag to examples directories that are not VLA-free
 * add no_vla_cflag to drivers directories that are not VLA-free and
   were missed in v17 due to missing libs

v17:
 * define no_vla_cflag in a top directory (config)
 * add no_vla_cflag to directories that are not VLA-free
 * add -Wvla project-wide (VLAs not allowed by default, except for
   directories using no_vla_cflag)

v16:
  * remove -Wvla from drivers/common/mlx5/meson.build and
    drivers/common/qat/meson.build

v15:
  * inverted some of the logic added during v14:
    add -Wvla to meson build files in app and lib directories, adding
    -Wno-vla to the few subdirectories which are not yet VLA free

v14:
  * add -Wvla to meson build for directories that are VLA free
    under app, lib, drivers. This is to ensure that new VLAs are
    not added to these directories in the future.

v13:
  * increase stack allocated buffer size in
    ipv4_reassembly_interleaved_flows_perf and
    ipv6_reassembly_interleaved_flows_perf to avoid
    STATUS_STACK_BUFFER_OVERRUN on Windows using MSVC

v12:
  * update commit message for patch 06/21 to avoid warning

v11:
  * add include stdlib.h for alloca() declaration on FreeBSD
  * zero-initialize array without code loop
  * increase maximum tuple length

v10:
 * add ifdef to scope gcc's diagnostic error down to gcc only

v9:
 * fix sender's email address
 * fix gcc's diagnostic error string to make clang happy

v8:
 * rebase
 * reduce scope for disabling error "-Warray-bounds=" to only
   the place that needs it
 * remove parentesis around numbers from defines in test_bitset.c

v7:
 * remove use of VLA from new file which sneaked in during review

v6:
 * remove use of VLA from new test code added recently
 * fix title for patch 08/20

v5:
 * add patches for net/ice, net/ixgbe and gro
   from Konstantin Ananyev from
https://patchwork.dpdk.org/project/dpdk/list/?series=31972&archive=both&state=*
 * address debug_autotest ASan failure
 * address array-bound error in bitset_autotest with gcc-13

v4:
 * rebase and adapt for changes made in main since v3 was sent
 * use fixed maximum array size instead of VLA when doable

v3:
 * address checkpatch/check git log warnings (minor typos)

v2:
 * replace patches for ethdev, hash, rcu and include new
   patches for eal from Konstantin Ananyev
   from https://patchwork.dpdk.org/project/dpdk/list/?series=31781

Andre Muezerie (10):
  test: remove use of VLAs for Windows built code in bitset tests
  app/testpmd: remove use of VLAs for Windows built code in
    shared_rxq_fwd
  hash: remove use of VLAs by using standard arrays
  config: define no_wvla_cflag
  app: add no_wvla_cflag to directories that are not VLA-free
  drivers: add no_wvla_cflag to directories that are not VLA-free
  lib: add no_wvla_cflag to directories that are not VLA-free
  examples: add no_wvla_cflag to directories that are not VLA-free
  buildtools: add no_wvla_cflag to directories that are not VLA-free
  config: add -Wvla project-wide

Konstantin Ananyev (10):
  eal/linux: remove use of VLAs
  eal/common: remove use of VLAs
  ethdev: remove use of VLAs for Windows built code
  hash: remove use of VLAs for Windows built code
  hash/thash: remove use of VLAs for Windows built
  rcu: remove use of VLAs for Windows built code
  gro: fix overwrite unprocessed packets
  gro: remove use of VLAs
  net/ixgbe: remove use of VLAs
  net/ice: remove use of VLAs

Tyler Retzlaff (7):
  eal: include header required for alloca
  app/testpmd: remove use of VLAs for Windows built
  test: remove use of VLAs for Windows built code
  common/idpf: remove use of VLAs for Windows built code
  net/i40e: remove use of VLAs for Windows built code
  common/mlx5: remove use of VLAs for Windows built code
  net/mlx5: remove use of VLAs for Windows built code

 app/pdump/meson.build                         |   2 +
 app/proc-info/meson.build                     |   2 +
 app/test-acl/meson.build                      |   2 +
 app/test-bbdev/meson.build                    |   2 +
 app/test-crypto-perf/meson.build              |   2 +
 app/test-dma-perf/meson.build                 |   2 +
 app/test-eventdev/meson.build                 |   2 +
 app/test-flow-perf/meson.build                |   2 +
 app/test-pmd/cmdline.c                        |   2 +-
 app/test-pmd/cmdline_flow.c                   |  15 +-
 app/test-pmd/config.c                         |  16 +-
 app/test-pmd/meson.build                      |  10 +-
 app/test-pmd/shared_rxq_fwd.c                 |   2 +-
 app/test-sad/meson.build                      |   2 +
 app/test/meson.build                          |  17 +-
 app/test/test.c                               |   2 +-
 app/test/test_bitset.c                        |  69 ++++---
 app/test/test_cmdline_string.c                |   2 +-
 app/test/test_cryptodev.c                     |  34 ++--
 app/test/test_cryptodev_blockcipher.c         |   4 +-
 app/test/test_cryptodev_crosscheck.c          |   2 +-
 app/test/test_dmadev.c                        |   9 +-
 app/test/test_hash.c                          |  14 +-
 app/test/test_lcore_var_perf.c                |   2 +-
 app/test/test_mempool.c                       |  25 +--
 app/test/test_reassembly_perf.c               |  22 ++-
 app/test/test_reorder.c                       |  48 ++---
 app/test/test_service_cores.c                 |   9 +-
 app/test/test_soring_stress_impl.h            |  13 +-
 app/test/test_thash.c                         |   7 +-
 buildtools/chkincs/meson.build                |   1 +
 config/meson.build                            |   9 +
 drivers/common/cnxk/meson.build               |   2 +
 drivers/common/idpf/idpf_common_rxtx.c        |   2 +-
 drivers/common/idpf/idpf_common_rxtx_avx512.c |   6 +-
 drivers/common/mlx5/meson.build               |   2 +
 drivers/common/mlx5/mlx5_common.h             |   4 +-
 drivers/common/mlx5/mlx5_devx_cmds.c          |   7 +-
 drivers/common/qat/meson.build                |   2 +
 drivers/crypto/ccp/meson.build                |   2 +
 drivers/crypto/cnxk/meson.build               |   2 +
 drivers/crypto/ipsec_mb/meson.build           |   2 +
 drivers/crypto/octeontx/meson.build           |   2 +
 drivers/crypto/openssl/meson.build            |   1 +
 drivers/crypto/scheduler/meson.build          |   2 +
 drivers/dma/dpaa/meson.build                  |   2 +
 drivers/event/cnxk/meson.build                |   2 +
 drivers/event/dsw/meson.build                 |   1 +
 drivers/event/opdl/meson.build                |   1 +
 drivers/event/sw/meson.build                  |   1 +
 drivers/net/af_xdp/meson.build                |   2 +
 drivers/net/bnxt/meson.build                  |   2 +
 drivers/net/bonding/meson.build               |   2 +
 drivers/net/cnxk/meson.build                  |   2 +
 drivers/net/cxgbe/meson.build                 |   2 +
 drivers/net/dpaa/meson.build                  |   2 +
 drivers/net/dpaa2/meson.build                 |   2 +
 drivers/net/failsafe/meson.build              |   1 +
 drivers/net/gve/meson.build                   |   2 +
 drivers/net/hns3/meson.build                  |   2 +
 drivers/net/intel/i40e/i40e_testpmd.c         |   5 +-
 drivers/net/intel/ice/ice_rxtx.c              |  18 +-
 drivers/net/intel/ice/ice_rxtx.h              |   2 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  21 +-
 drivers/net/mana/meson.build                  |   2 +
 drivers/net/mlx4/meson.build                  |   2 +
 drivers/net/mlx5/linux/meson.build            |   2 +
 drivers/net/mlx5/mlx5.c                       |   5 +-
 drivers/net/mlx5/mlx5_flow.c                  |   6 +-
 drivers/net/netvsc/meson.build                |   2 +
 drivers/net/nfp/meson.build                   |   2 +
 drivers/net/ngbe/base/meson.build             |   1 +
 drivers/net/ntnic/meson.build                 |   2 +
 drivers/net/octeontx/meson.build              |   2 +
 drivers/net/sfc/meson.build                   |   1 +
 drivers/net/softnic/meson.build               |   1 +
 drivers/net/tap/meson.build                   |   1 +
 drivers/net/txgbe/meson.build                 |   2 +
 drivers/net/vdev_netvsc/meson.build           |   2 +
 drivers/net/virtio/meson.build                |   2 +
 drivers/vdpa/mlx5/meson.build                 |   3 +
 examples/fips_validation/meson.build          |   2 +
 examples/ip_fragmentation/meson.build         |   1 +
 examples/ipsec-secgw/meson.build              |   3 +
 examples/l2fwd-crypto/meson.build             |   1 +
 examples/l2fwd-jobstats/meson.build           |   1 +
 examples/l3fwd-power/meson.build              |   1 +
 examples/l3fwd/meson.build                    |   1 +
 examples/pipeline/meson.build                 |   1 +
 examples/qos_sched/meson.build                |   1 +
 examples/vhost/meson.build                    |   1 +
 lib/acl/meson.build                           |   2 +
 lib/bpf/meson.build                           |   2 +
 lib/dispatcher/meson.build                    |   2 +
 lib/eal/common/eal_common_proc.c              |   5 +-
 lib/eal/freebsd/include/rte_os.h              |   1 +
 lib/eal/linux/eal_interrupts.c                |  32 ++-
 lib/eal/linux/include/rte_os.h                |   1 +
 lib/eal/windows/include/rte_os.h              |   1 +
 lib/ethdev/rte_ethdev.c                       | 183 +++++++++++-------
 lib/eventdev/meson.build                      |   2 +
 lib/gro/rte_gro.c                             |  42 ++--
 lib/hash/rte_cuckoo_hash.c                    |   4 +-
 lib/hash/rte_thash.c                          |   2 +-
 lib/hash/rte_thash.h                          |   7 +
 lib/hash/rte_thash_gf2_poly_math.c            |   9 +-
 lib/ipsec/meson.build                         |   2 +
 lib/member/meson.build                        |   2 +
 lib/metrics/meson.build                       |   2 +
 lib/pdcp/meson.build                          |   2 +
 lib/pdump/meson.build                         |   2 +
 lib/pipeline/meson.build                      |   2 +
 lib/power/meson.build                         |   3 +
 lib/rcu/rte_rcu_qsbr.c                        |   7 +-
 lib/rcu/rte_rcu_qsbr.h                        |   5 +
 lib/table/meson.build                         |   2 +
 lib/vhost/meson.build                         |  15 +-
 117 files changed, 563 insertions(+), 287 deletions(-)

--
2.47.2.vfs.0.1

