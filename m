Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7689CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 06:38:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F69E402D5;
	Fri, 26 Jun 2026 08:38:15 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6751140264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:38:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAD3Bc1MHj5q5tzmFQ--.32406S2;
 Fri, 26 Jun 2026 14:38:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v9 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Fri, 26 Jun 2026 14:38:00 +0800
Message-ID: <20260626063800.359448-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3Bc1MHj5q5tzmFQ--.32406S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1kXFyDAFyxXr1fKw47twb_yoWxuw4fpF
 48ZryfZr13JFW3Gw4fJa1fZFyYg3WxJryjkrWa9a4fXFykAFyUCrs0gFy5CwnFyr13JF1S
 vrZIyr1UGan5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeEfOUUUUU
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

This patch set implements core functionality for the SXE2 PMD,
including basic driver framework, data path setup, and advanced
offload features (VLAN, RSS,TM, PTP etc.).

v9
	Clarify the behavior of the flow-duplicate-pattern parameter

*** BLURB HERE ***

Jie Liu (23):
  net/sxe2: remove software statistics devargs
  net/sxe2: add Rx framework and packet types callback
  net/sxe2: support AVX512 vectorized path for Rx and Tx
  net/sxe2: add AVX2 vector data path for Rx and Tx
  net/sxe2: add link update callback
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
  net/sxe2: add mbuf validation in Tx debug mode
  common/sxe2: add callback for memory event handling
  net/sxe2: add private devargs parsing
  net/sxe2: implement private dump info
  net/sxe2: update sxe2 feature matrix docs

 doc/guides/nics/features/sxe2.ini          |   56 +
 doc/guides/nics/sxe2.rst                   |  186 ++
 drivers/common/sxe2/sxe2_common.c          |  156 ++
 drivers/common/sxe2/sxe2_common.h          |    4 +
 drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
 drivers/common/sxe2/sxe2_msg.h             |  118 ++
 drivers/net/sxe2/meson.build               |   52 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            |  523 +++++-
 drivers/net/sxe2/sxe2_dump.c               |  287 +++
 drivers/net/sxe2/sxe2_dump.h               |   12 +
 drivers/net/sxe2/sxe2_ethdev.c             | 1496 ++++++++++++++-
 drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
 drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
 drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
 drivers/net/sxe2/sxe2_filter.h             |  100 +
 drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
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
 drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
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
 drivers/net/sxe2/sxe2_tm.c                 | 1151 ++++++++++++
 drivers/net/sxe2/sxe2_tm.h                 |   76 +
 drivers/net/sxe2/sxe2_tx.c                 |    7 +
 drivers/net/sxe2/sxe2_txrx.c               | 1958 +++++++++++++++++++-
 drivers/net/sxe2/sxe2_txrx.h               |    8 +
 drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
 drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |  284 ++-
 drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
 drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  747 ++++++++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  867 +++++++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   54 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  689 +++++++
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   38 +-
 drivers/net/sxe2/sxe2_vsi.c                |  146 ++
 drivers/net/sxe2/sxe2_vsi.h                |   12 +-
 drivers/net/sxe2/sxe2vf_regs.h             |   85 +
 67 files changed, 24787 insertions(+), 273 deletions(-)
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
2.52.0

