Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E50606A88F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=XGnFGWCt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EFC840609;
	Tue, 17 Nov 2026 16:57:40 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 13BD44029E
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=08Gy2G72oEQwo1XfBL46ziIdlfFmkkLszCVM1+NTMOs=;
 b=XGnFGWCtxiEMPy0jw2Glx9mcWKQqXnWU9uypbiGyxaTWJT27x16TXAmKkuMqUH
 Wb7OQUQyVgnQjC6D4NkhQ2xLsIrJAIGNpOXKI4NQpQ/e2B3pN8a9lnuo2TLkSfkV
 dV6mU/f49ChqfWIQos5wlSw6O/etMSNaM41pQ9P8ME+zw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 00/29] net/hinic3: add PMD features and fixes
Date: Tue, 17 Nov 2026 23:56:41 +0800
Message-ID: <20261117155711.1048-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgC3S5drefxqC7WJBQ--.4821S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw48uw4kCFWxGFyfuFy7Awb_yoWfGr13pF
 WUGrW3AF1DKrWIyw1kKw4xA3Z8Xw4fGa45K34DJa4Fvrs8CFy5Z34UKFW0qF9Ikw4fJ3W2
 vF4UurWvka1ktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNVkUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNAxTXWr8eWwy4QAA3m
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

net/hinic3: add PMD features and fixes

This series fixes offload capability advertisement, cmdq/compact CQE
configuration, and a handful of driver defects, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

Changes in v7:
- 0008: treat a missing FDIR rule as a successful no-op instead of
  returning -EINVAL, and gate the RQ enable command on NIC_F_HTN_FDIR so
  the HTN-only command is not sent to STN devices.
- 0011: when the application does not request Rx interrupts
  (intr_conf.rxq == 0), name the queue vector in the SP230 RQ context and
  leave that vector disabled, so no interrupt is reported while Rx keeps
  polling the descriptor ring. No event fds, intr_vec or MSI-X attribute
  commands are used on this path. Backends without per-vector support
  (igb_uio, uio_pci_generic) keep the previous behaviour and are left
  untouched.
- 0012: move the Fixes: tags back to the trailer block.
- 0016: use the 12-character commit hash in Fixes:.
- 0017: set admin_down before disabling the vport, and clear it again if
  the disable fails, so a link-up event cannot re-enable the vport in
  between. dev_start() also skips enabling the vport while admin_down is
  set.
- 0019: derive the cached per-queue RSS enablement from rss_state and
  rss_type.val, refresh it from hinic3_rss_hash_update(), and access it
  with relaxed atomics, because the control path writes it while the Rx
  data path reads it. Include rte_stdatomic.h explicitly instead of
  relying on another header to pull it in.
- 0022: treat a device argument list that is present but empty as no
  arguments instead of parsing a NULL string.
- 0023: use the existing rx_free_mbuf_bytes counter in the new htn Rx
  path instead of a non-existent field name.
- 0024: record the expected queue depth only after the queue has been set
  up successfully, so a failed setup does not leave a depth behind that
  the next attempt has to match, and check every configured queue at the
  top of dev_start(), before the Rx interrupt setup dereferences them.
- 0026: stop the Tx burst at the first packet that cannot be enqueued and
  keep that mbuf owned by the application, so the returned count stays a
  consumed prefix as rte_eth_tx_burst() requires. The per-burst packet
  counter that was only ever equal to the loop index is gone, so the
  statistics use the returned count directly.

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
- 0011: advertise OUTER_UDP_CKSUM now that the outer UDP pseudo-header is
  written in the software prepare step. Drop the stale QinQ features.ini
  entry and unused QINQ mbuf flag.
- 0012: select the CIR drop counters by NIC type in calc_num, get_names
  and get.
- 0013: report the needed capability count for a short array, keep the
  GET-side firmware NOT_SET to AUTO mapping, and reject unknown firmware
  values.
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

The series builds with -Dwerror=true.

Jiacheng Ye

Jiacheng Ye (29):
  net/hinic3: fix SP230 VF PCI device ID
  net/hinic3: fix double removal in ethertype flow destroy
  net/hinic3: fix TCAM index leak on ethertype flow set
  net/hinic3: fix VXLAN VNI spec and mask write
  net/hinic3: fix vport enable null dereference
  net/hinic3: clear stale Rx hardware CI on queue reset
  net/hinic3: attach ethdev and set ops in secondary process
  net/hinic3: fix per-queue start/stop on non-HTN devices
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
 drivers/net/hinic3/hinic3_ethdev.c            |  938 ++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   58 +-
 drivers/net/hinic3/hinic3_fdir.c              |   53 +-
 drivers/net/hinic3/hinic3_fdir.h              |    8 +-
 drivers/net/hinic3/hinic3_flow.c              |  590 ++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ---
 drivers/net/hinic3/hinic3_nic_io.c            |  157 +--
 drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
 drivers/net/hinic3/hinic3_rx.c                |  659 ++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  214 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1074 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   53 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   76 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3656 insertions(+), 1189 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

