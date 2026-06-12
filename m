Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ABECD4F2C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 08:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D5D943475;
	Fri, 12 Jun 2026 10:42:48 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E1CAE40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 10:42:46 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcCgn67vwzJ46F8
 for <dev@dpdk.org>; Fri, 12 Jun 2026 16:42:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BDF540571
 for <dev@dpdk.org>; Fri, 12 Jun 2026 16:42:46 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 10:42:46 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH v5 00/11] bpf: introduce extensible load API
Date: Fri, 12 Jun 2026 09:42:07 +0100
Message-ID: <20260612084219.38399-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520124922.42445-1-marat.khalili@huawei.com>
References: <20260520124922.42445-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
 frapema500003.china.huawei.com (7.182.19.114)
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

This patchset introduces an extensible load API for the BPF library in
DPDK, addressing current limitations regarding ABI stability and feature
constraints.

Currently, `rte_bpf_load` relies on a fixed `struct rte_bpf_prm`, which
makes it difficult to add new loading options or parameters without
breaking the ABI.

To resolve these issues, this series introduces `rte_bpf_load_ex` taking
`struct rte_bpf_prm_ex`. The new parameter structure includes a `sz`
field for backward compatibility, allowing future extensions.

Taking advantage of the new extensible API, this patchset also adds
several new features:
* Support for loading and executing BPF programs with up to 5 arguments.
* Support for loading classic BPF (cBPF) directly.
* Support for loading ELF files directly from memory buffers.
* New API functions (`rte_bpf_eth_rx_install` and `rte_bpf_eth_tx_install`)
  to install an already loaded BPF program as a port callback, decoupling
  the loading phase from the installation phase.


v5:
* Fixed compilation between commits broken in v4 while addressing AI
  comments.
* Rebased on fresh main, addressing conflicts in release notes.

v4:
* Restored missing NULL checks in wrapper functions `rte_bpf_load` and
  `rte_bpf_elf_load`.
* Fixed the burst execution functions (`rte_bpf_exec_burst*`) to return
  `0` and set `rte_errno = EINVAL` on failure, preventing `-EINVAL`
  being reinterpreted as a large `uint32_t` value. Initialized `rc`
  properly in scalar execution wrappers for this case.
* Swapped the Doxygen comments in `rte_bpf_ethdev.h` for RX and TX functions.
* Added diagnostic dump on failure path in `test_bpf_filter`.
* Fixed memory leak of the BPF handle in `bpf_rx_test` upon install failure.
* Added tests for NULL parameter rejection, mismatched execution arguments,
  unsupported execution flags, and the libpcap-less `rte_bpf_convert` stub.

v3:
* Appended Acked-by tags to all individual commits to align with
  patchwork requirements.

v2:
* Fixed a potential segmentation fault in `exec_vm_burst_ex` by deferring
  the dereference of `ctx[i].arg` until it is confirmed that `nb_prog_arg > 0`.
* Clarified documentation and code comments for `RTE_BPF_EXEC_FLAG_JIT`
  requirements and fast-path expectations.


Marat Khalili (11):
  bpf: make logging prefixes more consistent
  bpf: introduce extensible load API
  bpf: support up to 5 arguments
  bpf: add cBPF origin to rte_bpf_load_ex
  bpf: support rte_bpf_prm_ex with port callbacks
  bpf: support loading ELF files from memory
  test/bpf: test loading cBPF directly
  test/bpf: test loading ELF file from memory
  doc: add release notes for new extensible BPF API
  doc: add load API to BPF programmer's guide
  test/bpf: add tests for error handling contracts

 app/test/test_bpf.c                    | 455 +++++++++++++++++--------
 doc/guides/prog_guide/bpf_lib.rst      |  75 +++-
 doc/guides/rel_notes/release_26_07.rst |  20 ++
 lib/bpf/bpf.c                          |  32 +-
 lib/bpf/bpf_convert.c                  |  99 +++++-
 lib/bpf/bpf_exec.c                     | 134 +++++++-
 lib/bpf/bpf_impl.h                     |  53 ++-
 lib/bpf/bpf_jit_arm64.c                |  18 +-
 lib/bpf/bpf_jit_x86.c                  |  10 +-
 lib/bpf/bpf_load.c                     | 213 ++++++++++--
 lib/bpf/bpf_load_elf.c                 | 189 ++++++----
 lib/bpf/bpf_pkt.c                      |  65 +++-
 lib/bpf/bpf_stub.c                     |  46 ---
 lib/bpf/bpf_validate.c                 |  94 +++--
 lib/bpf/meson.build                    |  15 +-
 lib/bpf/rte_bpf.h                      | 199 ++++++++++-
 lib/bpf/rte_bpf_ethdev.h               |  54 +++
 17 files changed, 1400 insertions(+), 371 deletions(-)
 delete mode 100644 lib/bpf/bpf_stub.c

-- 
2.43.0

