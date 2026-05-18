Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38BCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 09:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D9740649;
	Mon, 18 May 2026 11:14:16 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 19C11402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 11:14:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHVAhi2ApqIPmbEA--.3979S2;
 Mon, 18 May 2026 17:14:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v16 00/11] net/sxe2: fix logic errors and address feedback
Date: Mon, 18 May 2026 17:13:54 +0800
Message-ID: <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516074618.2343883-12-liujie5@linkdatatechnology.com>
References: <20260516074618.2343883-12-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHVAhi2ApqIPmbEA--.3979S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1kAr1kWrWkGF15tr1kZrb_yoW7Ar47pF
 48ZryrZF13JFW3Ww4fJa1fZFyrK3WxJryjkrW2gas3XFyvyFyUCrs0gFy5Awn7AF15JF10
 vr9Iyr1UGa15Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6CJPUUUUU=
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

This patch set addresses the feedback received on the v10 submission
for the sxe2 PMD. The primary focus is on fixing vector path selection,
ensuring memory safety during mbuf initialization, and cleaning up
redundant logic in the configuration functions.

v16 Changes:
- Fixed vector Rx burst function being overwritten by scalar selection.
- Refactored Rx/Tx mode set functions to seed flags from caps first,
  eliminating tautological checks.
- Added memset for mbuf_def in vector init to avoid uninitialized reads.
- Converted pci_map_addr_info to designated initializers.
- Removed dead Windows-only code in meson.build.
- Added NULL checks for mbuf free for driver-wide consistency.
- Updated burst_mode_get to accurately report AVX paths.
- Adjusted SXE2_ETH_OVERHEAD to match actual VLAN capabilities.

Jie Liu (11):
  mailmap: add Jie Liu
  doc: add sxe2 guide and release notes
  common/sxe2: add sxe2 basic structures
  drivers: add base driver skeleton
  drivers: add base driver probe skeleton
  drivers: support PCI BAR mapping
  common/sxe2: add ioctl interface for DMA map and unmap
  net/sxe2: support queue setup and control
  drivers: add data path for Rx and Tx
  net/sxe2: add vectorized Rx and Tx
  net/sxe2: implement Tx done cleanup

 .mailmap                                   |    1 +
 doc/guides/nics/features/sxe2.ini          |   29 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/nics/sxe2.rst                   |   34 +
 doc/guides/rel_notes/release_26_07.rst     |    4 +
 drivers/common/sxe2/meson.build            |   15 +
 drivers/common/sxe2/sxe2_common.c          |  683 +++++++++++++
 drivers/common/sxe2/sxe2_common.h          |   85 ++
 drivers/common/sxe2/sxe2_common_log.h      |   81 ++
 drivers/common/sxe2/sxe2_host_regs.h       |  707 +++++++++++++
 drivers/common/sxe2/sxe2_internal_ver.h    |   33 +
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  325 ++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.h      |  130 +++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   62 ++
 drivers/common/sxe2/sxe2_osal.h            |  153 +++
 drivers/meson.build                        |    1 +
 drivers/net/meson.build                    |    1 +
 drivers/net/sxe2/meson.build               |   32 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           |  323 ++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |   37 +
 drivers/net/sxe2/sxe2_drv_cmd.h            |  388 ++++++++
 drivers/net/sxe2/sxe2_ethdev.c             |  968 ++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h             |  318 ++++++
 drivers/net/sxe2/sxe2_irq.h                |   48 +
 drivers/net/sxe2/sxe2_queue.c              |   66 ++
 drivers/net/sxe2/sxe2_queue.h              |  195 ++++
 drivers/net/sxe2/sxe2_rx.c                 |  559 +++++++++++
 drivers/net/sxe2/sxe2_rx.h                 |   34 +
 drivers/net/sxe2/sxe2_tx.c                 |  420 ++++++++
 drivers/net/sxe2/sxe2_tx.h                 |   32 +
 drivers/net/sxe2/sxe2_txrx.c               |  362 +++++++
 drivers/net/sxe2/sxe2_txrx.h               |   23 +
 drivers/net/sxe2/sxe2_txrx_common.h        |  540 ++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.c          | 1044 ++++++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h          |   20 +
 drivers/net/sxe2/sxe2_txrx_vec.c           |  201 ++++
 drivers/net/sxe2/sxe2_txrx_vec.h           |   73 ++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |  235 +++++
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  549 ++++++++++
 drivers/net/sxe2/sxe2_vsi.c                |  214 ++++
 drivers/net/sxe2/sxe2_vsi.h                |  204 ++++
 41 files changed, 9230 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe2.ini
 create mode 100644 doc/guides/nics/sxe2.rst
 create mode 100644 drivers/common/sxe2/meson.build
 create mode 100644 drivers/common/sxe2/sxe2_common.c
 create mode 100644 drivers/common/sxe2/sxe2_common.h
 create mode 100644 drivers/common/sxe2/sxe2_common_log.h
 create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
 create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h
 create mode 100644 drivers/common/sxe2/sxe2_osal.h
 create mode 100644 drivers/net/sxe2/meson.build
 create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.c
 create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.h
 create mode 100644 drivers/net/sxe2/sxe2_drv_cmd.h
 create mode 100644 drivers/net/sxe2/sxe2_ethdev.c
 create mode 100644 drivers/net/sxe2/sxe2_ethdev.h
 create mode 100644 drivers/net/sxe2/sxe2_irq.h
 create mode 100644 drivers/net/sxe2/sxe2_queue.c
 create mode 100644 drivers/net/sxe2/sxe2_queue.h
 create mode 100644 drivers/net/sxe2/sxe2_rx.c
 create mode 100644 drivers/net/sxe2/sxe2_rx.h
 create mode 100644 drivers/net/sxe2/sxe2_tx.c
 create mode 100644 drivers/net/sxe2/sxe2_tx.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_common.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_common.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_sse.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.h

-- 
2.47.3

