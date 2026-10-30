Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEB606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=ZN/WVhJR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0393440B94;
	Fri, 30 Oct 2026 15:48:02 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 20BE840289
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=r3dHAz3vOlT8gIpR6iQgGsZgC/nyKpwMzQBbiLlYkks=;
 b=ZN/WVhJRpKjYyQ7v0qO6ASFDmqReP0EaxtNDqb4NgkRqPlx/TVtRb153UCzFZt
 0dT4LWTaL8JHVPNfCNHJxq7o7i44qtTFE0LmNdYaPFuxVmHjf+q2cjXccE9SDtfr
 d9IG7w1/xo9cmLdNzAl3ObTFiGQq+SkHKgg3BJX1hTFg4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 00/28] net/hinic3: add PMD features and fixes
Date: Fri, 30 Oct 2026 22:47:04 +0800
Message-ID: <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3CF47ZF4UtrW8KFW3Gw47CFg_yoWDAw4UpF
 WUG3y5Zr1Dtw47Awn7Kw48CFn8Zw4fGay3Ga4DJa40vFn8uFy5Z345KFWFyFyakr13J3W2
 vF4UWrZa9an8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNVkUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhWEjmrkrhVgbgAA3S
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes offload capability advertisement, cmdq/compact CQE
configuration, and several defects found during review, and adds NIC
type identification, FEC, CIR drop statistics, VF LAG/link state, COS
mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
kvargs tunables.

Thanks to Stephen Hemminger for the review. The review comments are addressed
in this version, and the changes are listed below.

v5:
- Register hinic3_prep_pkts() in the pseudo-header checksum patch
  instead of the compact CQE Rx patch, so the checksum fix is not dead
  code in the patches in between or in a stable backport of it.
- Mention only SP620 in that commit message, since SP560 support is
  introduced later in the series.
- Document that the RQ CEQ EN bit enables the compact CEQ context when
  SW compact CQE is active and that interrupt delivery is controlled by
  the INTR field, so the feature table and the code agree.
- Drop the per-packet ERR log for a zero tso_segsz; the drop is already
  counted in offload_errors.
- Keep log and error messages on a single line instead of splitting the
  format strings across lines.
- Check the non-TSO packet length before the early return for an
  already-valid SGE count, so a packet longer than the port maximum is
  rejected instead of being sent as is.
- Scale the coalescing parameters by their unit when printing them, so
  the log reports packet counts instead of the raw parameter values.

- Clear the stale Rx hardware CI write-back memory on queue reset to
  fix a pre-existing bug: after a port stop/start the driver took the
  whole ring as completed when the next packet arrived.

v4:
- Move the queue depth and state consistency patch ahead of the TSO
  expansion, so the copy pool is sized from a queue depth that is
  already validated, and keep resetting the cached depth in
  dev_configure().
- Validate the queue depth range before caching it as the first queue
  depth, so an out-of-range nb_desc cannot poison the saved depth and
  make a later valid setup fail the equality check.
- Reorder the series so the pseudo-header checksum fix follows the NIC
  type identification patch it depends on, repairing the bisect break
  in the later Tx/TSO patches.
- Size the TSO copy pool from the cached Tx queue depth and cap each
  queue at 256 mbufs, and start each segment copy at the remaining
  length via rte_pktmbuf_mtod_offset() so a segment spanning several
  copy mbufs is not copied twice.
- Keep the copy mbuf chain consistent: update nb_segs and pkt_len while
  the chain is built, and clear pkt_len on each newly allocated copy
  mbuf rather than on the original one.
- Drop the segment-count check from the transmit path together with the
  HINIC3_TSO_SEG_NUM_INVALID macro: 255 is the WQE buffer descriptor
  limit, not an input segment limit, and segments beyond the non-copy
  window are already compressed into copy mbufs.
- Reject TSO packets whose tso_segsz is zero instead of dividing by it.
- Fix the pseudo-header L4 protocol selection: pass IPPROTO_UDP or
  IPPROTO_TCP directly at each call site instead of testing the TCP
  offload bit, which also matched UDP packets because the UDP flag
  value shares that bit, and use rte_cpu_to_be_32() so the IPv6
  next-header value is placed correctly regardless of host endianness.
- Drop the IPv6 extension-header walk from the pseudo-header
  calculation as requested in review: rte_net_get_ptype() already
  accounts for the extension headers in mbuf->l3_len, so the walk was
  redundant.
- Split the SP230 Rx MSI-X masking out of the interrupt setup so
  dev_start keeps working on igb_uio/uio_pci_generic when Rx interrupts
  are disabled, and advertise full Rx interrupt support in hinic3.ini.
- Validate the VXLAN-GPE mask the same way as GENEVE, rejecting rules
  that match the flags, reserved bits or the next-protocol field, which
  cannot be programmed into the TCAM.
- Validate device kvargs against the accepted key list and parse their
  integer values in base 10, so a leading zero is not taken as an octal
  prefix.
- Program the TX completion index coalescing parameters into the SQ
  context tables: they were accepted as device arguments but the driver
  still programmed the built-in constants.
- Introduce rx_cqe_compact_en in the compact CQE Rx patch rather than in
  the kvargs patch, so every patch that accepts a parameter also makes
  it take effect.
- Remove unused Rx CQE packet-type enumerators, fix the DEAULT/DEFAULT
  typo, drop a duplicated "failed" in two log messages, use { 0 } for
  zero initialization, split over-long lines and repair alignment
  warnings reported by checkpatch.

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
 doc/guides/nics/features/hinic3.ini           |    4 +
 doc/guides/nics/hinic3.rst                    |   24 +-
 doc/guides/rel_notes/release_26_11.rst        |   13 +
 drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
 drivers/net/hinic3/base/hinic3_csr.h          |    6 +-
 drivers/net/hinic3/base/hinic3_eqs.c          |   65 +-
 drivers/net/hinic3/base/hinic3_eqs.h          |    6 +-
 drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
 drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
 drivers/net/hinic3/base/hinic3_mbox.c         |   45 +
 drivers/net/hinic3/base/hinic3_mbox.h         |   19 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  191 ++-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
 drivers/net/hinic3/base/hinic3_nic_event.c    |   68 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  816 +++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h            |   55 +-
 drivers/net/hinic3/hinic3_fdir.c              |   39 +-
 drivers/net/hinic3/hinic3_fdir.h              |    8 +-
 drivers/net/hinic3/hinic3_flow.c              |  585 +++++++---
 drivers/net/hinic3/hinic3_flow.h              |  196 ----
 drivers/net/hinic3/hinic3_nic_io.c            |  157 +--
 drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
 drivers/net/hinic3/hinic3_rx.c                |  619 ++++++++--
 drivers/net/hinic3/hinic3_rx.h                |  203 ++--
 drivers/net/hinic3/hinic3_tx.c                | 1020 +++++++++++++----
 drivers/net/hinic3/hinic3_tx.h                |   53 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   76 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
 34 files changed, 3434 insertions(+), 1143 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

-- 
2.33.0

