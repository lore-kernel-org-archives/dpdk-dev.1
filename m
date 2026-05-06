Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02669CD342F
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D834402A7;
	Wed,  6 May 2026 05:31:34 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9F8C44025E
 for <dev@dpdk.org>; Wed,  6 May 2026 05:31:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADnkW0RtvppJvJlDw--.46692S2;
 Wed, 06 May 2026 11:31:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 00/10] Add Linkdata sxe2 driver
Date: Wed,  6 May 2026 11:31:12 +0800
Message-ID: <20260506033123.726997-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506021233.661892-11-liujie5@linkdatatechnology.com>
References: <20260506021233.661892-11-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnkW0RtvppJvJlDw--.46692S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry7Cw4furWxZr13tw1DKFg_yoW7GFyrpF
 48ZryrZF15JFW3Ww4fJayfZFyrK3WfJryjkrW2gas3XFyvyFyUCrs0gFy5Awn7AF15JF1F
 vrZIyr1UGa1rJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeEfOUUUUU
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

V7:
 - Addressed AI comments

V6:
 - Addressed AI comments

Jie Liu (10):
  doc: add sxe2 guide and release notes
  drivers: add sxe2 basic structures
  common/sxe2: add base driver skeleton
  drivers: add base driver probe skeleton
  drivers: support PCI BAR mapping
  common/sxe2: add ioctl interface for DMA map and unmap
  net/sxe2: support queue setup and control
  drivers: add data path for Rx and Tx
  net/sxe2: add vectorized Rx and Tx
  net/sxe2: add AVX2 vector data path for Rx and Tx

 doc/guides/nics/features/sxe2.ini          |  11 +
 doc/guides/nics/index.rst                  |   1 +
 doc/guides/nics/sxe2.rst                   |  23 +
 doc/guides/rel_notes/release_26_07.rst     |   4 +
 drivers/common/sxe2/meson.build            |  15 +
 drivers/common/sxe2/sxe2_common.c          | 683 +++++++++++++++
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
 drivers/net/sxe2/meson.build               |  46 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 319 +++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  33 +
 drivers/net/sxe2/sxe2_drv_cmd.h            | 398 +++++++++
 drivers/net/sxe2/sxe2_ethdev.c             | 971 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h             | 315 +++++++
 drivers/net/sxe2/sxe2_irq.h                |  49 ++
 drivers/net/sxe2/sxe2_queue.c              |  39 +
 drivers/net/sxe2/sxe2_queue.h              | 227 +++++
 drivers/net/sxe2/sxe2_rx.c                 | 579 ++++++++++++
 drivers/net/sxe2/sxe2_rx.h                 |  34 +
 drivers/net/sxe2/sxe2_tx.c                 | 447 ++++++++++
 drivers/net/sxe2/sxe2_tx.h                 |  32 +
 drivers/net/sxe2/sxe2_txrx.c               | 384 ++++++++
 drivers/net/sxe2/sxe2_txrx.h               |  21 +
 drivers/net/sxe2/sxe2_txrx_common.h        | 541 ++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.c          | 966 ++++++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h          |  17 +
 drivers/net/sxe2/sxe2_txrx_vec.c           | 188 ++++
 drivers/net/sxe2/sxe2_txrx_vec.h           |  78 ++
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      | 749 ++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    | 235 +++++
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       | 549 ++++++++++++
 drivers/net/sxe2/sxe2_vsi.c                | 211 +++++
 drivers/net/sxe2/sxe2_vsi.h                | 205 +++++
 44 files changed, 10822 insertions(+)
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
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_common.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_sse.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.h

-- 
2.47.3

