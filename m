Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666FC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A31F40BA4;
	Mon, 31 Aug 2026 04:35:41 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4B72840612
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:35:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S2;
 Mon, 31 Aug 2026 10:35:04 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 00/47] net/sxe2: re-align with reference and fix review
 findings
Date: Mon, 31 Aug 2026 10:34:13 +0800
Message-ID: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWDZr45Cw45KF1DGw1DGFg_yoW7WF45pF
 48Xry3Zr1fJF43Ww1rXa1SvFyFgF1rJryjkrW7t3sagF1DAFyUArs0gF1UG34UAr1xA3WF
 yrW7Jr15Ga95Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
 4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
 xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
its common library (drivers/common/sxe2), fixing issues found in the
previous version and re-aligning the driver with the reference
implementation.

Changes since v6:
- drop the now-trivial sxe2_vsi_node_free() helper and inline
  rte_free() at its call sites
- unify the duplicated FNAV/ACL COUNT action arms in the flow parser
- use a file-scope static const ops table for the vectorized Tx path
  and fail sxe2_tx_queues_vec_prepare() on a NULL txq
- split "unify vectorized Tx buffer handling" into three commits:
  the buffer_ring union fix, the NEON Tx 4-wide descriptor fill, and
  the NEON Rx ptype/memory-ordering fixes
- use the primary VSI id directly for representors (the kernel
  guarantees it is always valid)
- drop the packed/aligned attributes from the TM command message
  structs to match the historical kernel layout
- fix VEC mode selection in the Tx/Rx mode set functions
- clean up commit messages (headline case/length, missing Fixes tags)

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Jie Liu (47):
  common/sxe2: fix null pointer in class driver remove
  common/sxe2: allow munmap during kernel reset
  net/sxe2: fix VF PCI device ID
  net/sxe2: fix MSIX register width in PF map table
  net/sxe2: restore PF and port index caps assignment
  net/sxe2: fix VSI lifecycle management
  net/sxe2: initialize stats in representor device init
  net/sxe2: use base device name for representor naming
  net/sxe2: propagate LSC event to VF representors
  net/sxe2: clear security context pointer on uninit
  net/sxe2: rename representor VSI ID fields
  net/sxe2: clean up duplicate function declarations
  net/sxe2: fix null VSI dereference in device info
  net/sxe2: fill MAC addresses in device info
  net/sxe2: fix QinQ and RSS offload capability report
  net/sxe2: use regular write for mapped registers
  net/sxe2: move PCI register read macro to common header
  net/sxe2: validate PCI map resource type
  net/sxe2: guard PCI BAR unmap when not initialized
  net/sxe2: fix null dereference in dev uninit
  net/sxe2: fix duplicated cleanup in dev close
  net/sxe2: align dev init and cleanup order
  net/sxe2: simplify switchdev representor matching
  net/sxe2: rename fnav cid manager symbols to flow
  net/sxe2: move tunnel port helpers into flow module
  net/sxe2: add ACL engine event statistics support
  net/sxe2: refactor primary process MP message handling
  net/sxe2: refactor Tx queue reset operations
  net/sxe2: unify vectorized Tx buffer handling
  net/sxe2: optimize NEON Tx descriptor fill
  net/sxe2: fix NEON Rx ptype mapping and memory ordering
  net/sxe2: refine vectorized Tx/Rx mode setup
  net/sxe2: fix RSS action attribute validation
  net/sxe2: restore PF-only guard in UDP tunnel port add
  net/sxe2: restore link update call in status query
  net/sxe2: validate representor ID against VF count
  net/sxe2: use primary VSI ID for representor VSI
  net/sxe2: wrap command params fill debug log in macro
  net/sxe2: restore Rx queue buffer split fill support
  net/sxe2: skip tunnel config fill on get failure
  net/sxe2: skip flow ID assignment on filter add failure
  net/sxe2: correct command channel log messages
  net/sxe2: align command structs with kernel layout
  common/sxe2: fix ioctl channel log and close handling
  doc/sxe2: remove drv-SW-stats parameter documentation
  net/sxe2: remove ineffective representor queue counts
  net/sxe2: fix VEC mode selection in mode set functions

 doc/guides/nics/sxe2.rst                   |  40 ++--
 drivers/common/sxe2/sxe2_common.c          |   6 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  21 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 199 +++++++++++++++--
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
 drivers/net/sxe2/sxe2_drv_cmd.h            |  33 +--
 drivers/net/sxe2/sxe2_dump.c               |  10 +-
 drivers/net/sxe2/sxe2_ethdev.c             | 192 ++++++++++-------
 drivers/net/sxe2/sxe2_ethdev.h             |  13 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  17 +-
 drivers/net/sxe2/sxe2_flow.c               | 235 ++++++++++++++++++---
 drivers/net/sxe2/sxe2_flow.h               |   6 +-
 drivers/net/sxe2/sxe2_flow_define.h        |  15 +-
 drivers/net/sxe2/sxe2_flow_parse_action.c  |  42 ++--
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ----------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   6 -
 drivers/net/sxe2/sxe2_irq.c                |  24 ++-
 drivers/net/sxe2/sxe2_mac.c                |  11 +-
 drivers/net/sxe2/sxe2_mp.c                 |  59 +++---
 drivers/net/sxe2/sxe2_queue.c              |   2 +
 drivers/net/sxe2/sxe2_queue.h              |   7 +-
 drivers/net/sxe2/sxe2_rx.c                 |   3 +-
 drivers/net/sxe2/sxe2_security.c           |   1 +
 drivers/net/sxe2/sxe2_switchdev.c          |  15 +-
 drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
 drivers/net/sxe2/sxe2_tx.h                 |   4 +
 drivers/net/sxe2/sxe2_txrx.c               |  34 +--
 drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c           |  74 +++----
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 133 +-----------
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   9 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 219 ++++++++++++-------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |  31 +--
 35 files changed, 946 insertions(+), 707 deletions(-)

-- 
2.52.0

