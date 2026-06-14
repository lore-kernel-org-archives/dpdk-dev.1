Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E805CD98C5
	for <dpdk-dev@archiver.kernel.org>; Sun, 14 Jun 2026 09:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F49043667;
	Sun, 14 Jun 2026 11:23:40 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E7065400D7
 for <dev@dpdk.org>; Sun, 14 Jun 2026 11:23:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABXrtEQcy5qVi9yEw--.28230S4;
 Sun, 14 Jun 2026 17:23:32 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Sun, 14 Jun 2026 17:23:04 +0800
Message-ID: <20260614092328.201826-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260614092328.201826-1-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
 <20260614092328.201826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXrtEQcy5qVi9yEw--.28230S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1DJw4xCr4UJr43uFyDJrb_yoW3JFy5pF
 48ZryfZr13JFW3Ww4fXa1fZFyYg3WxJryjkrWa9as3XFykAFyUCrs0gFy5CwnrAr13JF1S
 vrZIyr1UGa1rAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04k20x
 vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
 3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIx
 AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
 cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
 IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUUU==
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

V2:
Defensive ULONG_MAX checks after strtoul() in devarg parsers
Move testpmd commands out of driver library; remove 14 RTE_EXPORT_EXPERIMENTAL_SYMBOL
Implement rte_flow_dev_dump op; remove "sxe2 flow rule dump" command
Remove "sxe2 udp_tunnel_port add|rm" command (redundant)
Complete xstats coverage; remove "sxe2 show stats" command
Remove ipsec SA management testpmd commands
Retain 7 devargs with full documentation and rationale in sxe2.rst
Add RTE_PMD_REGISTER_PARAM_STRING for all devargs

Jie Liu (20):
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
 drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
 drivers/net/sxe2/meson.build               |   54 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            |  521 +++++-
 drivers/net/sxe2/sxe2_dump.c               |  304 +++
 drivers/net/sxe2/sxe2_dump.h               |   12 +
 drivers/net/sxe2/sxe2_ethdev.c             | 1532 +++++++++++++++-
 drivers/net/sxe2/sxe2_ethdev.h             |  107 +-
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
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
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
 drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
 drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
 drivers/net/sxe2/sxe2_irq.c                | 1026 +++++++++++
 drivers/net/sxe2/sxe2_irq.h                |   25 +
 drivers/net/sxe2/sxe2_mac.c                |  535 ++++++
 drivers/net/sxe2/sxe2_mac.h                |   84 +
 drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
 drivers/net/sxe2/sxe2_mp.h                 |   67 +
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
 drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
 drivers/net/sxe2/sxe2_tm.h                 |   78 +
 drivers/net/sxe2/sxe2_tx.c                 |    7 +
 drivers/net/sxe2/sxe2_txrx.c               |  176 +-
 drivers/net/sxe2/sxe2_txrx.h               |    4 +
 drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
 drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |  243 ++-
 drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
 drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  776 ++++++++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 +
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  721 ++++++++
 drivers/net/sxe2/sxe2_vsi.c                |  146 ++
 drivers/net/sxe2/sxe2_vsi.h                |   12 +-
 drivers/net/sxe2/sxe2vf_regs.h             |   85 +
 66 files changed, 24852 insertions(+), 133 deletions(-)
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

