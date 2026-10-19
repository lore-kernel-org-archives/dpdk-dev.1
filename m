Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FB60A6F45
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=qEUTPAqX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A361F40297;
	Mon, 19 Oct 2026 17:19:54 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5844028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=6Kt1Hp2SBIqlwc3ACIpC+AdQkNAawmjF5C0EEJsbkd8=;
 b=qEUTPAqXlyXcbbIWW+oQnQc8CFDrMGmay0iarE/izGuEmBiwePxES4zSrWWfxA
 6ycNjFaYvLlPoxMQ2tfFxnOyax8PftaGDSKJOepvid37Wn76STay05rCib8URgTd
 SMUi47vC9evpbTEuSmoXJRysvx6pFJGg0wlqnlyN2RWIs=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 00/27] net/hinic3: add PMD features and fixes
Date: Mon, 19 Oct 2026 23:19:02 +0800
Message-ID: <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4ktr4DJw45Cw15ZFyDtrb_yoW7tw1kpF
 WDJ3y3Zr1DKr47Jwn7Kw48CFn8Xw1xGa45Ka4DJa4FvFn8AFy5Z345KFW0yrWayr13JF12
 vF4UWrZY9an8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNVkUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhWirGrWNRXUkwAA32
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes offload capability advertisement, cmdq/compact CQE
configuration, and several defects found during review, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

v3:
- Move the ethertype-flow TCAM index leak fix out of the flow-refactor
  patch into its own patch with a Fixes tag and a stable Cc tag.
- Set burst function pointers and tx_pkt_prepare for both primary and
  secondary processes, and select the Tx path on its own feature bit.
- Zero the RQ/SQ context buffers and honour dp_intr_en for the STN CEQ
  attribute in compact CQE mode.
- Return the number of Tx packets consumed instead of the doorbell
  count, and guard the Tx prefetch against overreading the array.
- Validate device kvargs and reject values above the hardware field
  width; document the real defaults and units.
- Reject mismatched queue depths and reset saved depths in
  dev_configure(), and size the TSO copy pool per port.
- Report FEC capabilities per supported speed regardless of link state.
- Route the private dump through fprintf() on the provided FILE*.
- Derive the pseudo-header L4 protocol from the offload flags and fail
  shared or indirect mbufs; add Fixes and stable Cc tags.
- Drop stable Cc tags where the Fixes target is not in an LTS release
  and remove dead code and unused definitions.

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

Jiacheng Ye (27):
  net/hinic3: fix SP230 VF PCI device ID
  net/hinic3: fix double removal in ethertype flow destroy
  net/hinic3: fix TCAM index leak on ethertype flow set
  net/hinic3: fix VXLAN VNI spec and mask write
  net/hinic3: fix vport enable null dereference
  net/hinic3: attach ethdev and set ops in secondary process
  net/hinic3: add NIC type identification
  net/hinic3: add SP230 Rx queue interrupt handling
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

 .mailmap                                      |    1 +
 doc/guides/nics/features/hinic3.ini           |    4 +
 doc/guides/nics/hinic3.rst                    |   24 +-
 doc/guides/rel_notes/release_26_11.rst        |   13 +
 drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
 drivers/net/hinic3/base/hinic3_csr.h          |    6 +-
 drivers/net/hinic3/base/hinic3_eqs.c          |   66 +-
 drivers/net/hinic3/base/hinic3_eqs.h          |    6 +-
 drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
 drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
 drivers/net/hinic3/base/hinic3_mbox.c         |   43 +
 drivers/net/hinic3/base/hinic3_mbox.h         |   18 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  191 +++-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
 drivers/net/hinic3/base/hinic3_nic_event.c    |   68 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  755 ++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   54 +-
 drivers/net/hinic3/hinic3_fdir.c              |   39 +-
 drivers/net/hinic3/hinic3_fdir.h              |    8 +-
 drivers/net/hinic3/hinic3_flow.c              |  584 +++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ----
 drivers/net/hinic3/hinic3_nic_io.c            |  150 +--
 drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
 drivers/net/hinic3/hinic3_rx.c                |  621 ++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  215 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1009 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   51 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   69 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3374 insertions(+), 1125 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

