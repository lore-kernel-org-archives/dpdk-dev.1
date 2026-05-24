Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31177CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE04402E0;
	Sun, 24 May 2026 11:33:09 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id CF4A040041
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S2;
 Sun, 24 May 2026 17:33:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 00/23] add net/sxe2 support for flow control
Date: Sun, 24 May 2026 17:32:36 +0800
Message-ID: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aryfur48GF1xKF4xXw1fJFb_yoWxKFWDpF
 48ZryrZF13JFW3Gw4fJa1fZFyYg3WxJryjkrWa9a4fXFykAFyUCrs0gFy5CwnFyr13JF1F
 vrZIyr1UGa1rAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
 4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRVbDUUUUU==
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

v1:
-- add support for flow control
-- add support for flow control status interrupt notification
-- add support for ipsec inline protocol offload

Jie Liu (23):
  net/sxe2: support AVX512 vectorized path for Rx and Tx
  net/sxe2: add AVX2 vector data path for Rx and Tx
  drivers: add supported packet types get callback
  net/sxe2: support L2 filtering and MAC config
  drivers: support RSS feature
  net/sxe2: support TM hierarchy and shaping
  net/sxe2: support IPsec inline protocol offload
  net/sxe2: support statistics and multi-process
  drivers: interrupt handling
  net/sxe2: add NEON vec Rx/Tx burst functions
  net/sxe2: add support for VF representors
  net/sxe2: add support for custom UDP tunnel ports
  net/sxe2: support firmware version reading
  net/sxe2: implement get monitor address
  common/sxe2: add shared SFP module definitions
  net/sxe2: support SFP module info and EEPROM access
  net/sxe2: implement private dump info
  net/sxe2: add mbuf validation in Tx debug mode
  net/sxe2: add testpmd commands for private features
  net/sxe2: add private devargs parsing
  net/sxe2: support flow control status interrupt notification
  net/sxe2: update sxe2 feature matrix docs
  common/sxe2: add memseg walk callback

 doc/guides/nics/features/sxe2.ini          |   66 +
 drivers/common/sxe2/sxe2_common.c          |  156 ++
 drivers/common/sxe2/sxe2_common.h          |    4 +
 drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  179 +-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
 drivers/common/sxe2/sxe2_msg.h             |  117 ++
 drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
 drivers/net/sxe2/meson.build               |   56 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 1588 +++++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            |  439 ++++-
 drivers/net/sxe2/sxe2_dump.c               |  304 +++
 drivers/net/sxe2/sxe2_dump.h               |   12 +
 drivers/net/sxe2/sxe2_ethdev.c             | 1526 ++++++++++++++-
 drivers/net/sxe2/sxe2_ethdev.h             |  113 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
 drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
 drivers/net/sxe2/sxe2_filter.c             |  897 +++++++++
 drivers/net/sxe2/sxe2_filter.h             |  100 +
 drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
 drivers/net/sxe2/sxe2_flow.h               |   30 +
 drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
 drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
 drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
 drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
 drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
 drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
 drivers/net/sxe2/sxe2_irq.c                | 1024 +++++++++++
 drivers/net/sxe2/sxe2_irq.h                |   25 +
 drivers/net/sxe2/sxe2_mac.c                |  535 ++++++
 drivers/net/sxe2/sxe2_mac.h                |   84 +
 drivers/net/sxe2/sxe2_mp.c                 |  413 +++++
 drivers/net/sxe2/sxe2_mp.h                 |   73 +
 drivers/net/sxe2/sxe2_queue.c              |   17 +-
 drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
 drivers/net/sxe2/sxe2_rss.h                |   81 +
 drivers/net/sxe2/sxe2_rx.c                 |   38 +
 drivers/net/sxe2/sxe2_rx.h                 |    2 +
 drivers/net/sxe2/sxe2_security.c           |  335 ++++
 drivers/net/sxe2/sxe2_security.h           |   77 +
 drivers/net/sxe2/sxe2_stats.c              |  591 ++++++
 drivers/net/sxe2/sxe2_stats.h              |   39 +
 drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
 drivers/net/sxe2/sxe2_switchdev.h          |   33 +
 drivers/net/sxe2/sxe2_testpmd.c            |  733 ++++++++
 drivers/net/sxe2/sxe2_testpmd_lib.c        |  969 ++++++++++
 drivers/net/sxe2/sxe2_testpmd_lib.h        |  142 ++
 drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
 drivers/net/sxe2/sxe2_tm.h                 |   78 +
 drivers/net/sxe2/sxe2_tx.c                 |    7 +
 drivers/net/sxe2/sxe2_txrx.c               |  174 +-
 drivers/net/sxe2/sxe2_txrx.h               |    4 +
 drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
 drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |  243 ++-
 drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
 drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  777 ++++++++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 -
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  707 +++++++
 drivers/net/sxe2/sxe2_vsi.c                |  146 ++
 drivers/net/sxe2/sxe2_vsi.h                |   12 +-
 drivers/net/sxe2/sxe2vf_regs.h             |   82 +
 68 files changed, 26531 insertions(+), 81 deletions(-)
 create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
 create mode 100644 drivers/common/sxe2/sxe2_msg.h
 create mode 100644 drivers/common/sxe2/sxe2_ptype.h
 create mode 100644 drivers/net/sxe2/sxe2_dump.c
 create mode 100644 drivers/net/sxe2/sxe2_dump.h
 create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c
 create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h
 create mode 100644 drivers/net/sxe2/sxe2_filter.c
 create mode 100644 drivers/net/sxe2/sxe2_filter.h
 create mode 100644 drivers/net/sxe2/sxe2_flow.c
 create mode 100644 drivers/net/sxe2/sxe2_flow.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_define.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h
 create mode 100644 drivers/net/sxe2/sxe2_ipsec.c
 create mode 100644 drivers/net/sxe2/sxe2_ipsec.h
 create mode 100644 drivers/net/sxe2/sxe2_irq.c
 create mode 100644 drivers/net/sxe2/sxe2_mac.c
 create mode 100644 drivers/net/sxe2/sxe2_mac.h
 create mode 100644 drivers/net/sxe2/sxe2_mp.c
 create mode 100644 drivers/net/sxe2/sxe2_mp.h
 create mode 100644 drivers/net/sxe2/sxe2_rss.c
 create mode 100644 drivers/net/sxe2/sxe2_rss.h
 create mode 100644 drivers/net/sxe2/sxe2_security.c
 create mode 100644 drivers/net/sxe2/sxe2_security.h
 create mode 100644 drivers/net/sxe2/sxe2_stats.c
 create mode 100644 drivers/net/sxe2/sxe2_stats.h
 create mode 100644 drivers/net/sxe2/sxe2_switchdev.c
 create mode 100644 drivers/net/sxe2/sxe2_switchdev.h
 create mode 100644 drivers/net/sxe2/sxe2_testpmd.c
 create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.c
 create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.h
 create mode 100644 drivers/net/sxe2/sxe2_tm.c
 create mode 100644 drivers/net/sxe2/sxe2_tm.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
 create mode 100644 drivers/net/sxe2/sxe2vf_regs.h

-- 
2.47.3

