Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD88606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=nF7P/dhY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91230402B2;
	Wed, 25 Nov 2026 18:05:51 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FCC6402B2
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Vd3hteWoHwOvcCiCs6OypzIsphTfJ41AaZSbDs3Q0i0=;
 b=nF7P/dhYcNAor8KV+mLhbAT7exz4GZYOUquQKsYXiflYQYDF4nXFG9+0p1hXC1
 2dGFIWRtn7XLBmAovioDLohkxkTCRpVCZZWrulvmqeXBFurMMjKuqGAm4YyJ3Mrz
 uemOqzOt7StIgBdri0YBTHbScf1zsTepiuMb8JyiyFWm8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/30] net/hinic3: add PMD features and fixes
Date: Thu, 26 Nov 2026 01:03:54 +0800
Message-ID: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3tF4DKw4UZFW7XrWUGF48Zwb_yoW8Jr18Wo
 WfJrn3XF18tw4rCw1qkw4kGFnIqrykurs5Xws8trnxW3W0qF43XFZ8Jw4fGFy3Zw4Durnr
 Aa4xJrWFkws7t3Z8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc5rcDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMgf6BWsHFWcaHAAA3S
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
configuration, and a handful of driver defects, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

This version supersedes v8. v8 was applied to next-net; please drop it
and use v9 instead.

Changes in v9:
- 0005: split the wildcard IPv4 and ICMP/UDP fixes out of the flow rule
  parsing refactor (0021), so they can be reviewed and backported on
  their own: eth / ipv4 / udp is accepted as a wildcard, and
  eth / ipv4 / icmp no longer needs an explicit ipv4 proto 1 to match
  ICMP, because the ICMP item is translated into the IPv4 protocol key.
  Masks that select fields the TCAM cannot match are rejected with
  -EINVAL instead of being silently ignored: the ICMP type, code,
  checksum, identifier or sequence number, and the UDP length or
  checksum.
- 0009/0010: split the per-queue start/stop fix into two commits. The
  first one (return success when there is no TCAM rule) fixes
  commit efa3b9b36fc7 ("net/hinic3: add flow control and filters"), the
  uninitialized return of which is still present in 25.11, and
  commit b247199927a1 ("net/hinic3: fix return value of FDIR enabling"),
  which added the -EINVAL in main; it carries Cc: stable for 25.11. The
  second one (gate RQ enable on HTN FDIR) fixes
  commit b20dc78b286a ("net/hinic3: support Compact CQE in Rx"), which
  is not in 25.11. This series has 30 patches, so from 0009 onward the
  v8 number is two lower.
- 0012: if the Rx queue count does not fit in the MSI-X vector table,
  keep the old polling behaviour on SP230 instead of failing dev_start;
  only fail when the application explicitly requested Rx interrupts.
- 0013: drop the stale QinQ entries from features/hinic3.ini and the
  Features list in hinic3.rst, since the PMD does not advertise QinQ.
- 0015: return -EIO, not -EINVAL, when the FEC get/set mailbox command
  does not reach the firmware, and keep -EINVAL for a firmware status
  error or an empty response, like the other mailbox commands in the
  file. Also return -EINVAL for NOT_SET (0) instead of mapping it to
  AUTO, as it has no DPDK equivalent.
- 0018: keep the cached PF link state when the firmware link query fails.
  hinic3_link_update() used to store the synthesized LINK_DOWN into
  hwdev->link_status, which hinic3_vf_link_status() ANDs with the vport
  state, so on a VF a failed query made the port report DOWN, and
  dev_set_link_up() read that stale DOWN, until the next successful query
  or PF link event. The current call still reports DOWN, but the cache is
  only updated when the query succeeds.
- 0019: select the cmdq ops by the NIC_F_HTN_CMDQ capability bit rather
  than by a NIC-type table, like every other per-tile selection in the
  driver. The bit agrees with the removed table: the SP230 reports HTN,
  the SP620 reports STN.
- 0021: reject a Geneve mask that selects the reserved bits (rsvd1), like
  the other Geneve fields the TCAM cannot match, instead of ignoring it
  and letting the rule match every Geneve packet.
- 0022: report the speed actually applied, in Mbps, instead of the table
  index in the invalid-speed warning.
- 0024: allocate the ptype table with rte_zmalloc_socket() on the device
  socket, like the other per-port allocations, instead of rte_zmalloc().
  Also drop the commit message paragraph about the inner IPv4 fragment,
  ICMP and ESP ptype branches: the table is new in this patch, so there
  is nothing to drop.
- 0026: correct the copy pool comment: one copied TSO packet pins up to
  227 mbufs, so the pool can still run out at a queue depth of 256, not
  only above it.
- 0027: in hinic3.rst, describe the Tx WQE task format selection, in
  place of the compact CQE paragraph that the Tx burst split added. That
  paragraph duplicates the existing compact CQE description.
- Beyond the items above, v9 also cleans up code consistency and
  documentation across the series: unified error handling and log
  wording, and corrections to stale or duplicated text in the driver
  documentation.

Changes in v8:
- 0009: fold the v7 "add NIC type identification" patch into the
  pseudo-header checksum fix that follows it, which is the only user of
  the new HINIC3_IS_SP230_NIC() helper, and name the NIC type in that
  commit's subject as well. The merged commit carries the Cc: stable tag.
  The series is 28 patches from here on and the later numbering is one
  lower than in v7. The shared-mbuf rejection covers only the writes the
  software performs: TCP/UDP checksum, TSO and outer UDP checksum; the
  SCTP checksum is computed by the hardware and writes nothing back.
- 0006: drop the rte_atomic_thread_fence(); the cleared index is only
  consumed when the ring is re-armed and the RQ context is sent to the
  device at start, so no explicit barrier is required.
- 0007: drop the dead null check on the secondary process path.
- 0010: reject a queue count that does not fit in the MSI-X vector table,
  on both the intr_conf.rxq and the SP230 RQ-context paths, and document
  the new -EINVAL.
- 0014: stop printing the unused mbox slots in the debug dump.
- 0016: restore admin_down when dev_set_link_up() fails, as
  dev_set_link_down() already does.
- 0019: spell out in the commit message that the TCAM does not support
  VLAN matching, so the vlan_flag mask/value pairs were meaningless and are
  removed, and a rule now hits tagged and untagged packets alike.
- 0021/0022: turn the Runtime Configuration section into a definition
  list, with the compact-CQE switch documented in the compact CQE patch.
- 0022: when an application asks for the separate Rx mode on a NIC that
  reports the SW compact CQE bit, clear that bit as well, so the Rx
  burst, the RQ context, the CEQ attributes and the vport flag agree.
  The HW compact CQE bit is never cleared, and nothing is cleared when
  the compact mode is requested.
- 0022: clear the compact CQE info before each packet, so the LRO, VLAN
  and data-offset fields of a previous 16-byte CQE cannot leak into the
  next packet.
- 0024: reword the copy pool comment: the 256 mbufs per queue cap is
  deliberate, and a burst stops at the packet that cannot be copied.
- 0025: rename the Tx compact-task helpers from *_compact_cqe to
  *_compact_task, report "compact task" in the burst mode string, drop
  the dead !sq_wqe branch, and document that the scalar path no longer
  sets TCPUDP_CS.

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

The series builds with -Dwerror=true.

Jiacheng Ye (30):
  net/hinic3: fix SP230 VF PCI device ID
  net/hinic3: fix double removal in ethertype flow destroy
  net/hinic3: fix TCAM index leak on ethertype flow set
  net/hinic3: fix VXLAN VNI spec and mask write
  net/hinic3: fix wildcard IPv4, ICMP and UDP flow items
  net/hinic3: fix vport enable null dereference
  net/hinic3: clear stale Rx hardware CI on queue reset
  net/hinic3: attach ethdev and set ops in secondary process
  net/hinic3: return success when no FDIR rule to update
  net/hinic3: gate RQ enable on HTN FDIR
  net/hinic3: fix pseudo-header checksum and identify NIC type
  net/hinic3: add SP230 Rx queue interrupt handling
  net/hinic3: fix offload and cmdq/compact CQE config
  net/hinic3: add vport statistics and VF LAG support
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
  net/hinic3: split Tx burst function for compact task support
  net/hinic3: add SP230 VF software statistics
  net/hinic3: add Tx burst mode get
  net/hinic3: expose Tx queue copied-mbuf statistics

 .mailmap                                      |    1 +
 doc/guides/nics/features/hinic3.ini           |    5 +-
 doc/guides/nics/hinic3.rst                    |   45 +-
 doc/guides/rel_notes/release_26_11.rst        |   19 +
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
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  203 +++-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
 drivers/net/hinic3/base/hinic3_nic_event.c    |   72 +-
 drivers/net/hinic3/hinic3_ethdev.c            | 1017 ++++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   58 +-
 drivers/net/hinic3/hinic3_fdir.c              |   53 +-
 drivers/net/hinic3/hinic3_fdir.h              |    8 +-
 drivers/net/hinic3/hinic3_flow.c              |  633 +++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ---
 drivers/net/hinic3/hinic3_nic_io.c            |  157 +--
 drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
 drivers/net/hinic3/hinic3_rx.c                |  672 +++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  214 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1068 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   63 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   76 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3817 insertions(+), 1194 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

