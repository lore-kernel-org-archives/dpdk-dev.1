Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BDC61DD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 01:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88099402F0;
	Wed,  2 Sep 2026 03:57:05 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 52B66402EA
 for <dev@dpdk.org>; Wed,  2 Sep 2026 03:57:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACXa+9rgpdqM44HBw--.17257S2;
 Wed, 02 Sep 2026 09:57:00 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v9 00/48] net/sxe2: re-align with reference and fix review
 findings
Date: Wed,  2 Sep 2026 09:56:49 +0800
Message-ID: <20260902015649.74716-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXa+9rgpdqM44HBw--.17257S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UArWfKr4ftw4xWr1rZwb_yoW7Jw1rpF
 48Xry3Zr1fJF43Ww1rJa1fZFyFgF1rJFyjkrW7tw1fWF1DAFyUArs0gF1UG34DAr1xA3W0
 yrW7Jr15Ga95Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6CJPUUUUU=
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

From: Jie Liu <liujie5@linkdatatechnology.com>

This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
its common library (drivers/common/sxe2), fixing issues found in the
previous version and re-aligning the driver with the reference
implementation.

Changes since v8:
- drop the dead dev_ops/dev_close NULL check in the representor
  teardown: dev_ops points at the driver's static ops struct, so
  dev_close is always present for a stored representor.  The init
  path stores the representor pointer in vf_rep_eth_dev[] only
  after sxe2_repr_dev_init() succeeds (which sets dev_ops), so a
  stored representor never has a NULL dev_ops.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Jie Liu (48):
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
  net/sxe2: fix duplicated cleanup in dev close
  net/sxe2: align dev init and cleanup order
  net/sxe2: simplify switchdev representor matching
  net/sxe2: rename fnav cid manager symbols to flow
  net/sxe2: move tunnel port helpers into flow module
  net/sxe2: add ACL engine event statistics support
  net/sxe2: enable FDIR on all Rx queues
  net/sxe2: refactor primary process MP message handling
  net/sxe2: refactor Tx queue reset operations
  net/sxe2: unify vectorized Tx buffer handling
  net/sxe2: optimize NEON Tx descriptor fill
  net/sxe2: fix NEON Rx ptype mapping and memory ordering
  net/sxe2: refine vectorized Tx/Rx mode setup
  net/sxe2: fix RSS action attribute validation
  net/sxe2: restore PF-only guard in UDP tunnel port add
  net/sxe2: refresh link state on link change events
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
  net/sxe2: fix devargs parse error check for representors

 doc/guides/nics/sxe2.rst                   |  40 ++--
 drivers/common/sxe2/sxe2_common.c          |   6 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  21 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 199 +++++++++++++++--
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
 drivers/net/sxe2/sxe2_drv_cmd.h            |  33 +--
 drivers/net/sxe2/sxe2_dump.c               |  10 +-
 drivers/net/sxe2/sxe2_ethdev.c             | 188 ++++++++++-------
 drivers/net/sxe2/sxe2_ethdev.h             |  13 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  20 +-
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
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 223 ++++++++++++-------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |  31 +--
 35 files changed, 946 insertions(+), 710 deletions(-)

-- 
2.52.0

