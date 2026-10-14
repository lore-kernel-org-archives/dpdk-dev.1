Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9464BCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 852CF40B9B;
	Wed, 14 Oct 2026 17:09:54 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id CB06740616
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=N80apR6W/CCQk5CcYT1vj74cXNA+sz8oooMY4Z2IoPE=;
 b=M2YQHMjoHOLQLrIRa52o6Bz4zV3D/aqU6Z30zWqydAqhQsZHQqnLiz9nyzX5bN
 gxLXjzJqgeB++f064s0yGUohlPxm9xuzzEYb0LSLPYVkpsYmoWCxo/Xikr6U7gNR
 FBQfJYH5+IWbEHHcGveePU090+crUU2sz1GSDqplRxvYM=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 00/26] net/hinic3: add PMD features and fixes
Date: Wed, 14 Oct 2026 23:08:56 +0800
Message-ID: <20261014150923.838-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1fKr15ZFWrXr1kCFW3KFg_yoWrKryrpF
 WDJ3y3Zr1DKr47Aw1kKw18CF98X3WxGa4UKa4DJa4FvFn8AFy5Z34UGFW8ArW3tr13JF12
 vF4UurZ2kan8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNVkUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxSCjGrPmzQeOQAA3E
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

This series fixes offload capability advertisement, cmdq/compact CQE
configuration, and several defects found during review, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

v2:
- Add five bug fixes (SP230 VF PCI device ID, ethertype flow double
  removal, VXLAN VNI spec/mask, vport enable null dereference, and
  secondary-process ethdev ops setup).
- Split NIC type identification into its own patch and drop the mbox
  count telemetry patch.
- Add hinic3.rst and features/hinic3.ini documentation.
- Drop the tx_free_loop and rx_empty_threshold devargs and the Tx/Rx
  spin loops.
- Use the correct GENEVE/VXLAN-GPE flow item types and reject
  unsupported mask fields; reject IP-in-IP rules on SP620.
- Remove QINQ offload advertisement, split link_status and
  vf_valid_status into separate variables, use memcpy for unaligned mbox
  reads, and drop module parameter reads.
- Split the Tx burst patch into focused, self-contained commits for
  queue depth/state consistency, SP230 VF software statistics, Tx burst
  mode reporting, and Tx queue copied-mbuf statistics.
- Reword commit messages with full Fixes hashes and add
  stable@dpdk.org Cc tags where the defect exists in a released version.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>

Jiacheng Ye (26):
  net/hinic3: fix SP230 VF PCI device ID
  net/hinic3: fix double removal in ethertype flow destroy
  net/hinic3: fix VXLAN VNI spec and mask write
  net/hinic3: fix vport enable null dereference
  net/hinic3: attach ethdev and set ops in secondary process
  net/hinic3: add NIC type identification
  net/hinic3: fix offload and cmdq/compact CQE config
  net/hinic3: add CIR drop statistics and VF LAG support
  net/hinic3: add FEC mode get/set and capability support
  net/hinic3: add mbox message recording and debug dump
  net/hinic3: add COS mask and COS map support
  net/hinic3: add VF link state and promiscuous support
  net/hinic3: convert cmdq ops to static global variables
  net/hinic3: update RSS hash type configuration
  net/hinic3: refactor flow rule parsing
  net/hinic3: add SP560 NIC type identification and handling
  net/hinic3: add device kvargs parameters support
  net/hinic3: add compact CQE Rx path and ptype table
  net/hinic3: expand TSO from 127 to 255 segments
  net/hinic3: split Tx burst function for compact CQE support
  net/hinic3: ensure queue depth and state consistency
  net/hinic3: add SP230 VF software statistics
  net/hinic3: add Tx burst mode get
  net/hinic3: expose Tx queue copied-mbuf statistics
  net/hinic3: add pseudo-header checksum calculation
  net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops

 .mailmap                                      |    1 +
 doc/guides/nics/features/hinic3.ini           |    4 +
 doc/guides/nics/hinic3.rst                    |   22 +-
 doc/guides/rel_notes/release_26_11.rst        |   13 +
 drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
 drivers/net/hinic3/base/hinic3_csr.h          |    8 +-
 drivers/net/hinic3/base/hinic3_eqs.c          |   55 +
 drivers/net/hinic3/base/hinic3_eqs.h          |    2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
 drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
 drivers/net/hinic3/base/hinic3_mbox.c         |   43 +
 drivers/net/hinic3/base/hinic3_mbox.h         |   18 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  193 ++-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
 drivers/net/hinic3/base/hinic3_nic_event.c    |   68 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  715 +++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   55 +-
 drivers/net/hinic3/hinic3_fdir.c              |   65 +-
 drivers/net/hinic3/hinic3_fdir.h              |   14 +-
 drivers/net/hinic3/hinic3_flow.c              |  602 +++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ---
 drivers/net/hinic3/hinic3_nic_io.c            |  156 +--
 drivers/net/hinic3/hinic3_nic_io.h            |  145 ++-
 drivers/net/hinic3/hinic3_rx.c                |  591 ++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  216 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1048 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   59 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   71 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    8 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   75 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3392 insertions(+), 1190 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

