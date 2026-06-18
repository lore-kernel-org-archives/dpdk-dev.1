Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF5CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 539DA40616;
	Thu, 18 Jun 2026 10:27:36 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 9168B40296
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:27:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnlunwqzNqY8cLFA--.46372S2;
 Thu, 18 Jun 2026 16:27:30 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Thu, 18 Jun 2026 16:27:03 +0800
Message-ID: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnlunwqzNqY8cLFA--.46372S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy5Kr1fCryDXF1rAw1kXwb_yoWxCr1xpF
 48ZryfZr13JFW3Gw4fJa1fZFyYg3WxJryjkrWa9a4fXFykAFyUCrs0gFy5CwnFyr13JF1F
 vrZIyr1UGan5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

V3:
	Remove the `drv-sw-stats` devarg

Jie Liu (20):
  net/sxe2: support AVX512 vectorized path for Rx and Tx
  net/sxe2: add AVX2 vector data path for Rx and Tx
  drivers: add supported packet types and link state
  net/sxe2: support L2 filtering and MAC config
  drivers: support RSS feature
  net/sxe2: support TM hierarchy and shaping
  net/sxe2: support IPsec inline protocol offload
  net/sxe2: support statistics and multi-process
  drivers: interrupt handling
  net/sxe2: add NEON vec Rx/Tx burst functions
  drivers: add support for VF representors
  net/sxe2: add support for custom UDP tunnel ports
  net/sxe2: support firmware version reading
  net/sxe2: implement get monitor address
  common/sxe2: add shared SFP module definitions
  net/sxe2: support SFP module info and EEPROM access
  net/sxe2: implement private dump info
  net/sxe2: add mbuf validation in Tx debug mode
  drivers: add parameters parsed using rte_kvargs
  net/sxe2: update sxe2 feature matrix docs

 doc/guides/nics/features/sxe2.ini          |   56 +
 doc/guides/nics/sxe2.rst                   |  132 ++
 drivers/common/sxe2/sxe2_common.c          |  156 ++
 drivers/common/sxe2/sxe2_common.h          |    4 +
 drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
 drivers/common/sxe2/sxe2_msg.h             |  118 ++
 drivers/net/sxe2/meson.build               |   54 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            |  523 +++++-
 drivers/net/sxe2/sxe2_dump.c               |  302 +++
 drivers/net/sxe2/sxe2_dump.h               |   12 +
 drivers/net/sxe2/sxe2_ethdev.c             | 1515 ++++++++++++++-
 drivers/net/sxe2/sxe2_ethdev.h             |  110 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
 drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
 drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
 drivers/net/sxe2/sxe2_filter.h             |  100 +
 drivers/net/sxe2/sxe2_flow.c               | 1394 ++++++++++++++
 drivers/net/sxe2/sxe2_flow.h               |   30 +
 drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
 drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
 drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
 drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 +++++++++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
 drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
 drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
 drivers/net/sxe2/sxe2_irq.c                | 1026 ++++++++++
 drivers/net/sxe2/sxe2_irq.h                |   25 +
 drivers/net/sxe2/sxe2_mac.c                |  530 ++++++
 drivers/net/sxe2/sxe2_mac.h                |   84 +
 drivers/net/sxe2/sxe2_mp.c                 |  414 ++++
 drivers/net/sxe2/sxe2_mp.h                 |   67 +
 drivers/net/sxe2/sxe2_queue.c              |   17 +-
 drivers/net/sxe2/sxe2_queue.h              |   15 +-
 drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
 drivers/net/sxe2/sxe2_rss.h                |   81 +
 drivers/net/sxe2/sxe2_rx.c                 |   93 +-
 drivers/net/sxe2/sxe2_rx.h                 |    2 +
 drivers/net/sxe2/sxe2_security.c           |  335 ++++
 drivers/net/sxe2/sxe2_security.h           |   77 +
 drivers/net/sxe2/sxe2_stats.c              |  586 ++++++
 drivers/net/sxe2/sxe2_stats.h              |   39 +
 drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
 drivers/net/sxe2/sxe2_switchdev.h          |   33 +
 drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
 drivers/net/sxe2/sxe2_tm.h                 |   78 +
 drivers/net/sxe2/sxe2_tx.c                 |    7 +
 drivers/net/sxe2/sxe2_txrx.c               | 1969 +++++++++++++++++++-
 drivers/net/sxe2/sxe2_txrx.h               |    8 +
 drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
 drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |  281 ++-
 drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
 drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  748 ++++++++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  868 +++++++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   53 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  691 +++++++
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   29 +-
 drivers/net/sxe2/sxe2_vsi.c                |  146 ++
 drivers/net/sxe2/sxe2_vsi.h                |   12 +-
 drivers/net/sxe2/sxe2vf_regs.h             |   85 +
 67 files changed, 24800 insertions(+), 266 deletions(-)
 create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
 create mode 100644 drivers/common/sxe2/sxe2_msg.h
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
 create mode 100644 drivers/net/sxe2/sxe2_tm.c
 create mode 100644 drivers/net/sxe2/sxe2_tm.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
 create mode 100644 drivers/net/sxe2/sxe2vf_regs.h

-- 
2.31.1

