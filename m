Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD5C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D8514026D;
	Wed, 26 Aug 2026 10:53:46 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1B607400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:53:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHUD6RqY5qndlMBg--.50555S2;
 Wed, 26 Aug 2026 16:53:38 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 00/51] net/sxe2: add Stars SXE2 net driver with fixes
Date: Wed, 26 Aug 2026 16:53:32 +0800
Message-ID: <20260826085332.989952-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUD6RqY5qndlMBg--.50555S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF15CFWrKFWkAr4UZr48Xrb_yoW7Cw1DpF
 48Xry3Zr1fJF43Gw1rXa1fZFyFgF18JFyjkrW7K34fXFn8AFyUArs0gFyrGa4qyr1fA3W0
 yrW7tr15Ga95Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgJDGDUUUU
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

This series adds the Stars SXE2 (Wuxi Stars Micro System) Ethernet
driver, including the common driver (drivers/common/sxe2), the net
driver (drivers/net/sxe2), and its documentation.

The driver supports:
- Legacy and switchdev modes with VF representors
- Scalar and vectorized (SSE/AVX2/AVX512/NEON) Rx/Tx paths
- FNAV and ACL flow engines with per-flow statistics
- RSS, QinQ, IPsec, Traffic Management and multi-process support

In addition to the driver functionality, the series fixes a number of
correctness issues found during review, including a security context
leak in the device init error path, a NULL dereference in the
vectorized Tx mbuf release path, an out-of-bounds representor ID
access, and a representor LSC loop counter type mismatch. The command
channel log messages and ioctl channel handling are also aligned with
the reference implementation.

This is v3 of the series, incorporating review feedback. All patches
build independently and no ABI changes are introduced.

Jie Liu (51):
  common/sxe2: fix null pointer in class driver remove
  common/sxe2: allow munmap during kernel reset
  net/sxe2: fix VF PCI device ID
  net/sxe2: fix MSIX register width in PF map table
  net/sxe2: restore pf and port index caps assignment
  net/sxe2: fix VSI lifecycle management
  net/sxe2: initialize stats in representor device init
  net/sxe2: use base device name for representor naming
  net/sxe2: propagate LSC event to VF representors
  net/sxe2: validate IPsec key length against maximum limit
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
  net/sxe2: probe all requested PF ports
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
  net/sxe2: align flow meta proc priority handling with V3
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
  net/sxe2: harden ACL flow count resource handling
  net/sxe2: fix device init and representor matching issues
  net/sxe2: use correct loop counter type for representor LSC
  net/sxe2: restore NULL check in vectorized Tx mbuf release
  net/sxe2: simplify Rx queue buffer split fill helper

 doc/guides/nics/sxe2.rst                   |  58 +----
 drivers/common/sxe2/sxe2_common.c          |   6 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  18 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 200 +++++++++++++++--
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
 drivers/net/sxe2/sxe2_drv_cmd.h            |  45 ++--
 drivers/net/sxe2/sxe2_dump.c               |  10 +-
 drivers/net/sxe2/sxe2_ethdev.c             | 202 ++++++++++-------
 drivers/net/sxe2/sxe2_ethdev.h             |  13 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  13 +-
 drivers/net/sxe2/sxe2_flow.c               | 250 +++++++++++++++++----
 drivers/net/sxe2/sxe2_flow.h               |   6 +-
 drivers/net/sxe2/sxe2_flow_define.h        |  15 +-
 drivers/net/sxe2/sxe2_flow_parse_action.c  |  37 ++-
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ----------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   6 -
 drivers/net/sxe2/sxe2_ipsec.c              |   5 +
 drivers/net/sxe2/sxe2_irq.c                |  27 ++-
 drivers/net/sxe2/sxe2_mac.c                |   9 +-
 drivers/net/sxe2/sxe2_mp.c                 |  59 ++---
 drivers/net/sxe2/sxe2_queue.c              |   2 +
 drivers/net/sxe2/sxe2_queue.h              |   7 +-
 drivers/net/sxe2/sxe2_rx.c                 |   3 +-
 drivers/net/sxe2/sxe2_security.c           |   1 +
 drivers/net/sxe2/sxe2_switchdev.c          |  16 +-
 drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
 drivers/net/sxe2/sxe2_tx.h                 |   4 +
 drivers/net/sxe2/sxe2_txrx.c               |  19 +-
 drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c           |  73 +++---
 drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 133 +----------
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   9 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 219 +++++++++++-------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |   8 +-
 37 files changed, 964 insertions(+), 702 deletions(-)

-- 
2.52.0

