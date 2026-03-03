Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F78EC0462
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 09:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E4F40ED1;
	Tue,  3 Mar 2026 10:11:08 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id A582D40E2D
 for <dev@dpdk.org>; Tue,  3 Mar 2026 10:11:01 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowAC3Ym6ipaZpYi4sCQ--.16406S2;
 Tue, 03 Mar 2026 17:10:58 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v18 00/13] net/sxe: added Linkdata sxe ethernet driver
Date: Tue,  3 Mar 2026 17:10:44 +0800
Message-Id: <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260209012458.506200-13-liujie5@linkdatatechnology.com>
References: <20260209012458.506200-13-liujie5@linkdatatechnology.com>
X-CM-TRANSID: qwCowAC3Ym6ipaZpYi4sCQ--.16406S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KFW3Ww43ur4DAw15tryrZwb_yoWDXFy5pF
 48AryxZr13JFWYqayrJF48uFy5J3ZrWry5K34a93s3XF92yFy7Jrs0gFyUC393ZFy7Jw1I
 vrnIyr17Gr1fAaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUB214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
 6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
 CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
 M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1miiDUUUU
X-Originating-IP: [221.238.36.162]
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

This patch set implements core functionality for the SXE PMD,
including basic driver framework, data path setup, and advanced
offload features (VLAN, RSS, DCB, PTP etc.).

v18:
 - Addressed AI comments

Jie Liu (13):
  net/sxe: add base driver directory and doc
  net/sxe: add ethdev probe and remove
  net/sxe: add tx rx setup and data path
  net/sxe: add link and mac layer operations
  net/sxe: support vlan filter
  net/sxe: add filter function
  net/sxe: support rss offload
  net/sxe: add dcb function
  net/sxe: support ptp
  net/sxe: add xstats function
  net/sxe: add custom cmd led ctrl
  net/sxe: add simd function
  net/sxe: add virtual function

 MAINTAINERS                                |    6 +
 doc/guides/nics/features/sxe.ini           |   55 +
 doc/guides/nics/features/sxe_vf.ini        |   37 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/nics/sxe.rst                    |   71 +
 doc/guides/rel_notes/release_26_03.rst     |    6 +
 drivers/net/meson.build                    |    1 +
 drivers/net/sxe/base/sxe_common.c          |   66 +
 drivers/net/sxe/base/sxe_common.h          |   15 +
 drivers/net/sxe/base/sxe_compat_platform.h |  124 +
 drivers/net/sxe/base/sxe_compat_version.h  |   34 +
 drivers/net/sxe/base/sxe_errno.h           |   61 +
 drivers/net/sxe/base/sxe_hw.c              | 3306 ++++++++++++++++++++
 drivers/net/sxe/base/sxe_hw.h              | 1040 ++++++
 drivers/net/sxe/base/sxe_logs.h            |  105 +
 drivers/net/sxe/base/sxe_offload_common.c  |   54 +
 drivers/net/sxe/base/sxe_offload_common.h  |   14 +
 drivers/net/sxe/base/sxe_queue_common.c    |  450 +++
 drivers/net/sxe/base/sxe_queue_common.h    |  240 ++
 drivers/net/sxe/base/sxe_rx_common.c       |  358 +++
 drivers/net/sxe/base/sxe_rx_common.h       |   17 +
 drivers/net/sxe/base/sxe_tx_common.c       |   40 +
 drivers/net/sxe/base/sxe_tx_common.h       |   12 +
 drivers/net/sxe/base/sxe_types.h           |   40 +
 drivers/net/sxe/base/sxevf_hw.c            |  950 ++++++
 drivers/net/sxe/base/sxevf_hw.h            |  349 +++
 drivers/net/sxe/base/sxevf_regs.h          |  119 +
 drivers/net/sxe/include/drv_msg.h          |   18 +
 drivers/net/sxe/include/sxe/sxe_cli.h      |  218 ++
 drivers/net/sxe/include/sxe/sxe_hdc.h      |   42 +
 drivers/net/sxe/include/sxe/sxe_ioctl.h    |   21 +
 drivers/net/sxe/include/sxe/sxe_msg.h      |  135 +
 drivers/net/sxe/include/sxe/sxe_regs.h     | 1270 ++++++++
 drivers/net/sxe/include/sxe_type.h         |  795 +++++
 drivers/net/sxe/include/sxe_version.h      |   29 +
 drivers/net/sxe/meson.build                |   66 +
 drivers/net/sxe/pf/rte_pmd_sxe.h           |   19 +
 drivers/net/sxe/pf/sxe.h                   |   93 +
 drivers/net/sxe/pf/sxe_dcb.c               |  945 ++++++
 drivers/net/sxe/pf/sxe_dcb.h               |   99 +
 drivers/net/sxe/pf/sxe_ethdev.c            |  931 ++++++
 drivers/net/sxe/pf/sxe_ethdev.h            |   28 +
 drivers/net/sxe/pf/sxe_filter.c            |  923 ++++++
 drivers/net/sxe/pf/sxe_filter.h            |  109 +
 drivers/net/sxe/pf/sxe_flow_ctrl.c         |   98 +
 drivers/net/sxe/pf/sxe_flow_ctrl.h         |   16 +
 drivers/net/sxe/pf/sxe_irq.c               |  516 +++
 drivers/net/sxe/pf/sxe_irq.h               |   48 +
 drivers/net/sxe/pf/sxe_main.c              |  198 ++
 drivers/net/sxe/pf/sxe_offload.c           |  336 ++
 drivers/net/sxe/pf/sxe_offload.h           |   51 +
 drivers/net/sxe/pf/sxe_phy.c               |  953 ++++++
 drivers/net/sxe/pf/sxe_phy.h               |  117 +
 drivers/net/sxe/pf/sxe_pmd_hdc.c           |  666 ++++
 drivers/net/sxe/pf/sxe_pmd_hdc.h           |   44 +
 drivers/net/sxe/pf/sxe_ptp.c               |  209 ++
 drivers/net/sxe/pf/sxe_ptp.h               |   26 +
 drivers/net/sxe/pf/sxe_queue.c             |  774 +++++
 drivers/net/sxe/pf/sxe_queue.h             |  132 +
 drivers/net/sxe/pf/sxe_rx.c                | 1459 +++++++++
 drivers/net/sxe/pf/sxe_rx.h                |  188 ++
 drivers/net/sxe/pf/sxe_stats.c             |  586 ++++
 drivers/net/sxe/pf/sxe_stats.h             |   69 +
 drivers/net/sxe/pf/sxe_tx.c                | 1051 +++++++
 drivers/net/sxe/pf/sxe_tx.h                |   50 +
 drivers/net/sxe/pf/sxe_vec_common.h        |  321 ++
 drivers/net/sxe/pf/sxe_vec_neon.c          |  600 ++++
 drivers/net/sxe/pf/sxe_vec_sse.c           |  622 ++++
 drivers/net/sxe/pf/sxe_vf.c                | 1199 +++++++
 drivers/net/sxe/pf/sxe_vf.h                |  200 ++
 drivers/net/sxe/sxe_drv_type.h             |   15 +
 drivers/net/sxe/sxe_testpmd.c              |  196 ++
 drivers/net/sxe/vf/sxevf.h                 |   42 +
 drivers/net/sxe/vf/sxevf_ethdev.c          |  752 +++++
 drivers/net/sxe/vf/sxevf_ethdev.h          |   16 +
 drivers/net/sxe/vf/sxevf_filter.c          |  493 +++
 drivers/net/sxe/vf/sxevf_filter.h          |   70 +
 drivers/net/sxe/vf/sxevf_irq.c             |  432 +++
 drivers/net/sxe/vf/sxevf_irq.h             |   34 +
 drivers/net/sxe/vf/sxevf_main.c            |   82 +
 drivers/net/sxe/vf/sxevf_msg.c             |  624 ++++
 drivers/net/sxe/vf/sxevf_msg.h             |  201 ++
 drivers/net/sxe/vf/sxevf_offload.c         |   30 +
 drivers/net/sxe/vf/sxevf_offload.h         |   16 +
 drivers/net/sxe/vf/sxevf_queue.c           |  208 ++
 drivers/net/sxe/vf/sxevf_queue.h           |   69 +
 drivers/net/sxe/vf/sxevf_rx.c              |  162 +
 drivers/net/sxe/vf/sxevf_rx.h              |   18 +
 drivers/net/sxe/vf/sxevf_stats.c           |  162 +
 drivers/net/sxe/vf/sxevf_stats.h           |   31 +
 drivers/net/sxe/vf/sxevf_tx.c              |   46 +
 drivers/net/sxe/vf/sxevf_tx.h              |   14 +
 92 files changed, 27554 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe.ini
 create mode 100644 doc/guides/nics/features/sxe_vf.ini
 create mode 100644 doc/guides/nics/sxe.rst
 create mode 100644 drivers/net/sxe/base/sxe_common.c
 create mode 100644 drivers/net/sxe/base/sxe_common.h
 create mode 100644 drivers/net/sxe/base/sxe_compat_platform.h
 create mode 100644 drivers/net/sxe/base/sxe_compat_version.h
 create mode 100644 drivers/net/sxe/base/sxe_errno.h
 create mode 100644 drivers/net/sxe/base/sxe_hw.c
 create mode 100644 drivers/net/sxe/base/sxe_hw.h
 create mode 100644 drivers/net/sxe/base/sxe_logs.h
 create mode 100644 drivers/net/sxe/base/sxe_offload_common.c
 create mode 100644 drivers/net/sxe/base/sxe_offload_common.h
 create mode 100644 drivers/net/sxe/base/sxe_queue_common.c
 create mode 100644 drivers/net/sxe/base/sxe_queue_common.h
 create mode 100644 drivers/net/sxe/base/sxe_rx_common.c
 create mode 100644 drivers/net/sxe/base/sxe_rx_common.h
 create mode 100644 drivers/net/sxe/base/sxe_tx_common.c
 create mode 100644 drivers/net/sxe/base/sxe_tx_common.h
 create mode 100644 drivers/net/sxe/base/sxe_types.h
 create mode 100644 drivers/net/sxe/base/sxevf_hw.c
 create mode 100644 drivers/net/sxe/base/sxevf_hw.h
 create mode 100644 drivers/net/sxe/base/sxevf_regs.h
 create mode 100644 drivers/net/sxe/include/drv_msg.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_cli.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_hdc.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_ioctl.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_msg.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_regs.h
 create mode 100644 drivers/net/sxe/include/sxe_type.h
 create mode 100644 drivers/net/sxe/include/sxe_version.h
 create mode 100644 drivers/net/sxe/meson.build
 create mode 100644 drivers/net/sxe/pf/rte_pmd_sxe.h
 create mode 100644 drivers/net/sxe/pf/sxe.h
 create mode 100644 drivers/net/sxe/pf/sxe_dcb.c
 create mode 100644 drivers/net/sxe/pf/sxe_dcb.h
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h
 create mode 100644 drivers/net/sxe/pf/sxe_filter.c
 create mode 100644 drivers/net/sxe/pf/sxe_filter.h
 create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.c
 create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.h
 create mode 100644 drivers/net/sxe/pf/sxe_irq.c
 create mode 100644 drivers/net/sxe/pf/sxe_irq.h
 create mode 100644 drivers/net/sxe/pf/sxe_main.c
 create mode 100644 drivers/net/sxe/pf/sxe_offload.c
 create mode 100644 drivers/net/sxe/pf/sxe_offload.h
 create mode 100644 drivers/net/sxe/pf/sxe_phy.c
 create mode 100644 drivers/net/sxe/pf/sxe_phy.h
 create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.c
 create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.h
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.c
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.h
 create mode 100644 drivers/net/sxe/pf/sxe_queue.c
 create mode 100644 drivers/net/sxe/pf/sxe_queue.h
 create mode 100644 drivers/net/sxe/pf/sxe_rx.c
 create mode 100644 drivers/net/sxe/pf/sxe_rx.h
 create mode 100644 drivers/net/sxe/pf/sxe_stats.c
 create mode 100644 drivers/net/sxe/pf/sxe_stats.h
 create mode 100644 drivers/net/sxe/pf/sxe_tx.c
 create mode 100644 drivers/net/sxe/pf/sxe_tx.h
 create mode 100644 drivers/net/sxe/pf/sxe_vec_common.h
 create mode 100644 drivers/net/sxe/pf/sxe_vec_neon.c
 create mode 100644 drivers/net/sxe/pf/sxe_vec_sse.c
 create mode 100644 drivers/net/sxe/pf/sxe_vf.c
 create mode 100644 drivers/net/sxe/pf/sxe_vf.h
 create mode 100644 drivers/net/sxe/sxe_drv_type.h
 create mode 100644 drivers/net/sxe/sxe_testpmd.c
 create mode 100644 drivers/net/sxe/vf/sxevf.h
 create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.c
 create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.h
 create mode 100644 drivers/net/sxe/vf/sxevf_filter.c
 create mode 100644 drivers/net/sxe/vf/sxevf_filter.h
 create mode 100644 drivers/net/sxe/vf/sxevf_irq.c
 create mode 100644 drivers/net/sxe/vf/sxevf_irq.h
 create mode 100644 drivers/net/sxe/vf/sxevf_main.c
 create mode 100644 drivers/net/sxe/vf/sxevf_msg.c
 create mode 100644 drivers/net/sxe/vf/sxevf_msg.h
 create mode 100644 drivers/net/sxe/vf/sxevf_offload.c
 create mode 100644 drivers/net/sxe/vf/sxevf_offload.h
 create mode 100644 drivers/net/sxe/vf/sxevf_queue.c
 create mode 100644 drivers/net/sxe/vf/sxevf_queue.h
 create mode 100644 drivers/net/sxe/vf/sxevf_rx.c
 create mode 100644 drivers/net/sxe/vf/sxevf_rx.h
 create mode 100644 drivers/net/sxe/vf/sxevf_stats.c
 create mode 100644 drivers/net/sxe/vf/sxevf_stats.h
 create mode 100644 drivers/net/sxe/vf/sxevf_tx.c
 create mode 100644 drivers/net/sxe/vf/sxevf_tx.h

-- 
2.18.2

