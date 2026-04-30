Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FCCCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7904940615;
	Thu, 30 Apr 2026 12:18:34 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 33B684021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:18:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACnUW11LPNplJjRDg--.60427S2;
 Thu, 30 Apr 2026 18:18:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 0/9] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Thu, 30 Apr 2026 18:18:08 +0800
Message-ID: <20260430101819.4094628-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430092231.4068642-10-liujie5@linkdatatechnology.com>
References: <20260430092231.4068642-10-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnUW11LPNplJjRDg--.60427S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15Cry3JrW3JFW3CFW7urg_yoWrZw1kpF
 48ZryrZF15JFW3Ww4fJayfZFyFg3WfJryjkrW2gas3XFyvyFyUCrs0gFy3Awn7AF15JF1F
 vrZIyr1UGa1rAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6CJPUUUUU=
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

This patch set implements core functionality for the SXE PMD, 
which is a Linkdata sxe2 ethernet driver.

V3: Addressed AI comments

Jie Liu (9):
  mailmap: add Jie Liu
  doc: add sxe2 guide and release notes
  drivers: add sxe2 basic structures
  common/sxe2: add base driver skeleton
  drivers: add base driver probe skeleton
  drivers: support PCI BAR mapping
  common/sxe2: add ioctl interface for DMA map and unmap
  net/sxe2: support queue setup and control
  net/sxe2: add data path for Rx and Tx

 .mailmap                                   |   1 +
 doc/guides/nics/features/sxe2.ini          |  11 +
 doc/guides/nics/index.rst                  |   1 +
 doc/guides/nics/sxe2.rst                   |  23 +
 doc/guides/rel_notes/release_26_07.rst     |   3 +
 drivers/common/sxe2/meson.build            |  15 +
 drivers/common/sxe2/sxe2_common.c          | 684 +++++++++++++++
 drivers/common/sxe2/sxe2_common.h          |  86 ++
 drivers/common/sxe2/sxe2_common_log.c      |  75 ++
 drivers/common/sxe2/sxe2_common_log.h      | 263 ++++++
 drivers/common/sxe2/sxe2_errno.h           | 110 +++
 drivers/common/sxe2/sxe2_host_regs.h       | 707 +++++++++++++++
 drivers/common/sxe2/sxe2_internal_ver.h    |  33 +
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 326 +++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.h      | 141 +++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  63 ++
 drivers/common/sxe2/sxe2_osal.h            | 582 ++++++++++++
 drivers/common/sxe2/sxe2_type.h            |  64 ++
 drivers/meson.build                        |   1 +
 drivers/net/meson.build                    |   1 +
 drivers/net/sxe2/meson.build               |  26 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 319 +++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  33 +
 drivers/net/sxe2/sxe2_drv_cmd.h            | 398 +++++++++
 drivers/net/sxe2/sxe2_ethdev.c             | 975 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h             | 316 +++++++
 drivers/net/sxe2/sxe2_irq.h                |  49 ++
 drivers/net/sxe2/sxe2_queue.c              |  39 +
 drivers/net/sxe2/sxe2_queue.h              | 227 +++++
 drivers/net/sxe2/sxe2_rx.c                 | 579 ++++++++++++
 drivers/net/sxe2/sxe2_rx.h                 |  34 +
 drivers/net/sxe2/sxe2_tx.c                 | 447 ++++++++++
 drivers/net/sxe2/sxe2_tx.h                 |  32 +
 drivers/net/sxe2/sxe2_txrx.c               | 249 ++++++
 drivers/net/sxe2/sxe2_txrx.h               |  21 +
 drivers/net/sxe2/sxe2_txrx_common.h        | 541 ++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.c          | 782 +++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h          |  16 +
 drivers/net/sxe2/sxe2_vsi.c                | 211 +++++
 drivers/net/sxe2/sxe2_vsi.h                | 205 +++++
 40 files changed, 8689 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe2.ini
 create mode 100644 doc/guides/nics/sxe2.rst
 create mode 100644 drivers/common/sxe2/meson.build
 create mode 100644 drivers/common/sxe2/sxe2_common.c
 create mode 100644 drivers/common/sxe2/sxe2_common.h
 create mode 100644 drivers/common/sxe2/sxe2_common_log.c
 create mode 100644 drivers/common/sxe2/sxe2_common_log.h
 create mode 100644 drivers/common/sxe2/sxe2_errno.h
 create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
 create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h
 create mode 100644 drivers/common/sxe2/sxe2_osal.h
 create mode 100644 drivers/common/sxe2/sxe2_type.h
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
 create mode 100644 drivers/net/sxe2/sxe2_vsi.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.h

-- 
2.47.3

