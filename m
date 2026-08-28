Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9751C61DC4
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75AA640150;
	Fri, 28 Aug 2026 05:23:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4D0C34003C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:23:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAD3AUAZ_5BqjxxwBg--.60656S2;
 Fri, 28 Aug 2026 11:23:05 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 00/45] net/sxe2: add Stars SXE2 net driver with fixes
Date: Fri, 28 Aug 2026 11:23:00 +0800
Message-ID: <20260828032300.2104299-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3AUAZ_5BqjxxwBg--.60656S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GryxXw43GFWUGw15ZFyDtrb_yoWxXFWxpF
 48Xry3Zr1fJF43Ww1fXa1xZFyFgF1rJryjkry7K34SqFn8CryUArs0gF1UCa4qyr1fJ3W0
 yrW7tr15Ga95ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5d5r3UUUUU==
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

This series adds the Stars SXE2 network driver together with a set of
fixes accumulated while validating the driver against the historical
kernel implementation and reviewing the code.

This is the v5 revision. Changes since v4 address the community review
of the v4 series:

- Drop the ineffective IPsec key length check in
  sxe2_security_valid_key() (the same limit is already enforced at the
  top of the function) and keep only the security context pointer
  cleanup, which is now its own commit.
- Make the QinQ and RSS offload capability gating actually effective:
  RTE_ETH_TX_OFFLOAD_QINQ_INSERT is removed from the unconditional
  capability list and only advertised when no port VLAN is configured;
  RTE_ETH_RX_OFFLOAD_RSS_HASH is advertised only when the RSS offload
  capability flag is set.
- Fix switchdev representor matching so the common devarg forms
  (e.g. "representor=vf0", bare-number form) that leave nb_ports == 0
  are treated as "no PF constraint" instead of being rejected.
- Fix the representor VSI teardown: sxe2_vsi_destroy() now unlinks
  SXE2_VSI_T_DPDK_ESW nodes from other_vsi_list before freeing them.
- Restore a scalar Tx fallback on arm64 when NEON is not available so
  tx_pkt_burst is always installed.
- Add the same PF-only guard to the UDP tunnel port delete and clear
  paths that add already has.
- Move sxe2_link_update() out of the command-channel link status query
  into the two callers, keeping the command layer free of ethdev side
  effects and avoiding the dev_data dereference.
- Evaluate the adapter argument exactly once in the command params fill
  macro.
- Remove ineffective nb_rx_queues/nb_tx_queues assignments from device
  info (ethdev overwrites them after the PMD callback) and from the
  representor device info (new commit with a Fixes: tag).
- Fix the ioctl mmap debug log labels and reword the commit messages
  for the security context, command fill macro and command struct
  alignment commits.

Patch 30/44 of the v4 series still bundles unrelated NEON Rx data path
changes into the vectorized Tx commit, and patches 21/22 still leave
the dev_close and dev_init teardown orders slightly different; these
are left for a follow-up.

Jie Liu (45):
  common/sxe2: fix null pointer in class driver remove
  common/sxe2: allow munmap during kernel reset
  net/sxe2: fix VF PCI device ID
  net/sxe2: fix MSIX register width in PF map table
  net/sxe2: restore pf and port index caps assignment
  net/sxe2: fix VSI lifecycle management
  net/sxe2: initialize stats in representor device init
  net/sxe2: use base device name for representor naming
  net/sxe2: propagate LSC event to VF representors
  net/sxe2: clear security context pointer on uninit
  net/sxe2: rename representor VSI ID fields
  net/sxe2: clean up duplicate function declarations
  net/sxe2: fix null VSI dereference in device info
  net/sxe2: fill MAC and queue counts in device info
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
  net/sxe2: guard Rx queue event FD free in unregister
  net/sxe2: refactor primary process MP message handling
  net/sxe2: refactor Tx queue reset operations
  net/sxe2: unify vectorized Tx buffer handling
  net/sxe2: refine vectorized Tx/Rx mode setup
  net/sxe2: fix RSS action attribute validation
  net/sxe2: restore PF-only guard in udp tunnel port add
  net/sxe2: restore link update call in status query
  net/sxe2: validate representor ID against VF count
  net/sxe2: use primary VSI ID for representor VSI
  net/sxe2: wrap command params fill debug log in macro
  net/sxe2: restore Rx queue buffer split fill support
  net/sxe2: skip tunnel config fill on get failure
  net/sxe2: skip flow id assignment on filter add failure
  net/sxe2: fix command channel log messages
  net/sxe2: align command structs with historical kernel layout
  common/sxe2: fix ioctl channel log and close handling
  doc/sxe2: remove drv-sw-stats parameter documentation
  net/sxe2: remove ineffective queue counts in representor info

 doc/guides/nics/sxe2.rst                   |  40 ++--
 drivers/common/sxe2/sxe2_common.c          |   6 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  20 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 199 ++++++++++++++++--
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
 drivers/net/sxe2/sxe2_drv_cmd.h            |  37 +++-
 drivers/net/sxe2/sxe2_dump.c               |  10 +-
 drivers/net/sxe2/sxe2_ethdev.c             | 192 ++++++++++-------
 drivers/net/sxe2/sxe2_ethdev.h             |  13 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  15 +-
 drivers/net/sxe2/sxe2_flow.c               | 234 ++++++++++++++++++---
 drivers/net/sxe2/sxe2_flow.h               |   6 +-
 drivers/net/sxe2/sxe2_flow_define.h        |  15 +-
 drivers/net/sxe2/sxe2_flow_parse_action.c  |  39 +++-
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ----------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   6 -
 drivers/net/sxe2/sxe2_irq.c                |  29 ++-
 drivers/net/sxe2/sxe2_mac.c                |  11 +-
 drivers/net/sxe2/sxe2_mp.c                 |  59 +++---
 drivers/net/sxe2/sxe2_queue.c              |   2 +
 drivers/net/sxe2/sxe2_queue.h              |   7 +-
 drivers/net/sxe2/sxe2_rx.c                 |   3 +-
 drivers/net/sxe2/sxe2_security.c           |   1 +
 drivers/net/sxe2/sxe2_switchdev.c          |  16 +-
 drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
 drivers/net/sxe2/sxe2_tx.h                 |   4 +
 drivers/net/sxe2/sxe2_txrx.c               |  20 +-
 drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c           |  73 +++----
 drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 133 +-----------
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   9 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 219 ++++++++++++-------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |  10 +-
 36 files changed, 948 insertions(+), 673 deletions(-)

-- 
2.52.0

