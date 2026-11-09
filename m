Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EAD606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=iqFLioKR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6DB40616;
	Mon,  9 Nov 2026 17:20:56 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id E3BD640270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=6H46fznwFdsH0ATAl8V/a3oAbudVf7/ILUNvvcR2Bzw=;
 b=iqFLioKRvCVIPokFAABX7vA179s8SyoMGBDM9mNfsiRcwD+SfOS+QQoEj8uvwm
 vqq757/vZihMWkouniCZ+0aRuamP6kvfDvY87r7grG7E1CJuojvVrBwIqU7xZtXW
 S6WuzJ4p12ZHhaqRcEEgAEzBINAxEIZb2UsB8nuzg9RtY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 00/28] net/hinic3: add PMD features and fixes
Date: Tue, 10 Nov 2026 00:20:04 +0800
Message-ID: <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4ktryrKFWfZr4DCF15Jwb_yoW3tF17pF
 WUJrW3Zr4DKrW2yr1kKw4xAFn5Xw4fGa45K34DJa4Fvrn8CFy5Z34UKFW8Xr9Ikr4fJa42
 vF4UurZY93WktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNVkUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMgIMFmrx8uIIlgAA3-
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes offload capability advertisement, cmdq/compact CQE
configuration, and several defects found during review, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

Changes in v6:
- Rebase on current main and address the v5 review comments.
- 0003/0005: correct the Fixes: tags, drop the Cc: stable request for
  fixes to code that has never been in a stable release, and remove the
  dead null check in the vport enable fix.
- 0006: clear the stale hardware consumer index on Rx queue reset.
- 0009: reject a packet whose first segment is shorter than the
  pseudo-header, narrow the shared-mbuf check to the L4/TSO flags,
  compare the tunnel type as a whole enum, and compute the outer and inner
  pseudo-header checksums.
- 0010: arm the SP230 per-queue vectors when Rx interrupts are disabled,
  so vfio masks them after the first assertion, and keep the
  coalescing-only fallback for igb_uio/uio_pci_generic.
- 0011: advertise OUTER_UDP_CKSUM now that the outer UDP pseudo-header is
  written in the software prepare step. Drop the stale QinQ features.ini
  entry and unused QINQ mbuf flag.
- 0012: select the CIR drop counters by NIC type in calc_num, get_names
  and get.
- 0013: report the needed capability count for a short array, mask
  AUTO out of the reported capabilities, keep the GET-side firmware
  NOT_SET to AUTO mapping, and reject unknown firmware values.
- 0014: take the PCI device from the ethdev in priv_dump so a secondary
  process does not dereference a stale pointer.
- 0016: keep a separate admin-down flag so a PF link up event cannot
  override dev_set_link_down().
- 0018: cache RSS enablement per queue and clear rss_type when RSS is
  disabled.
- 0019: reject outer IPv6 with an inner L3, and stop setting the VLAN
  flag mask in the TCAM keys.
- 0021: document that the coalescing tunables only take effect with
  HW compact CQE.
- 0022: report the combined compact-CQE checksum error as an unknown
  result instead of blaming the IP or the L4 layer, and keep the ptype
  table in sync with the advertised ptype set.
- 0023: reject a queue depth that differs from the first queue instead
  of coercing it, reset the expected depth in dev_configure() and
  dev_stop(), validate it in dev_start(), and mark Tx queues stopped in
  dev_stop().
- 0024: reject TSO packets that need more SGEs than the ring can hold,
  reject a tso_segsz that does not fit the 14-bit MSS field, and report
  nb_seg_max/nb_mtu_seg_max.
- 0025: clear queue_info in the scalar burst for compact WQEs like
  hinic3_master, clear the per-packet offload state, guard the prefetch
  against an empty burst, and remove the per-packet data path logs.
  Per-packet unsupported-type messages are lowered to DEBUG.
  Tunnel packets are accepted by type instead of by feature bit;
  VXLAN_GPE TSO and IPIP TSO on SP620 stay rejected.
  SP230 does not get the software pseudo-header writes because its
  hardware derives the inner checksums and TSO headers itself.
- 0027: report the Tx burst mode of the function that is installed.

Changes in v5:
- Register hinic3_prep_pkts() in the pseudo-header checksum patch instead
  of the compact CQE Rx patch.
- Mention only SP620 in that commit message.
- Document the RQ CEQ EN bit and the INTR field for SW compact CQE.
- Drop the per-packet ERR log for a zero tso_segsz.
- Keep log and error messages on a single line.
- Check the non-TSO packet length before the early SGE-count return.
- Scale the coalescing parameters by their unit in the log.
- Clear the stale Rx hardware CI write-back memory on queue reset.

Changes in v4:
- Reordered the queue-depth, TSO and pseudo-header patches to keep the
  series bisectable; sized the copy pool from the Tx queue depth, kept the
  copy chain consistent and rejected a zero tso_segsz.
- Fixed the pseudo-header L4 protocol and dropped the IPv6 extension-header
  walk; split the SP230 MSI-X handling; validated the VXLAN-GPE mask and
  the device kvargs.

Changes in v3:
- Moved the TCAM leak fix into its own patch; set the burst pointers and
  tx_pkt_prepare for secondary processes; zeroed the RQ/SQ contexts.
- Fixed the Tx burst return count and prefetch guard; validated kvargs;
  reset the queue depths in dev_configure(); reported FEC per speed;
  routed priv_dump through fprintf(); derived the pseudo-header protocol
  from the offload flags.

Changes in v2:
- Added the five bug fixes (SP230 VF ID, ethertype double removal, VXLAN
  VNI mask, vport NULL deref, secondary ops); split the NIC type
  identification; added hinic3.rst/features.ini.
- Dropped the unused devargs and Tx/Rx spin loops; corrected the
  GENEVE/VXLAN-GPE/SP620 IP-in-IP rule handling.

Changes in v1:
- Initial posting.

Every commit builds with -Dwerror=true.

Jiacheng Ye (28):
  net/hinic3: fix SP230 VF PCI device ID
  net/hinic3: fix double removal in ethertype flow destroy
  net/hinic3: fix TCAM index leak on ethertype flow set
  net/hinic3: fix VXLAN VNI spec and mask write
  net/hinic3: fix vport enable null dereference
  net/hinic3: clear stale Rx hardware CI on queue reset
  net/hinic3: attach ethdev and set ops in secondary process
  net/hinic3: add NIC type identification
  net/hinic3: fix pseudo-header checksum calculation
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
  net/hinic3: ensure queue depth and state consistency
  net/hinic3: expand TSO from 127 to 255 segments
  net/hinic3: split Tx burst function for compact CQE support
  net/hinic3: add SP230 VF software statistics
  net/hinic3: add Tx burst mode get
  net/hinic3: expose Tx queue copied-mbuf statistics

 .mailmap                                      |    1 +
 doc/guides/nics/features/hinic3.ini           |    5 +-
 doc/guides/nics/hinic3.rst                    |   27 +-
 doc/guides/rel_notes/release_26_11.rst        |   13 +
 drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
 drivers/net/hinic3/base/hinic3_csr.h          |    6 +-
 drivers/net/hinic3/base/hinic3_eqs.c          |   64 +-
 drivers/net/hinic3/base/hinic3_eqs.h          |    9 +-
 drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
 drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
 drivers/net/hinic3/base/hinic3_mbox.c         |   45 +
 drivers/net/hinic3/base/hinic3_mbox.h         |   19 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  201 ++-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
 drivers/net/hinic3/base/hinic3_nic_event.c    |   71 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  904 ++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   58 +-
 drivers/net/hinic3/hinic3_fdir.c              |   51 +-
 drivers/net/hinic3/hinic3_fdir.h              |    8 +-
 drivers/net/hinic3/hinic3_flow.c              |  590 ++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ---
 drivers/net/hinic3/hinic3_nic_io.c            |  184 +--
 drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
 drivers/net/hinic3/hinic3_rx.c                |  633 ++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  206 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1098 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   53 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   76 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3641 insertions(+), 1185 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

