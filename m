Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B3606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pt26ZIJT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0CB84028F;
	Mon,  9 Nov 2026 18:30:09 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 92AD840270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:30:08 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e9d1114320so8726965ad.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794245407;
 x=1794850207; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Gut61P2X6xFkrMVnymAI1nTOnnVvlvyOqV+kFwzkCg=;
 b=pt26ZIJTls7SA/M08yGKXBbUBxwCLe8YVPZMZSIojTfeEcKqhkZdiaDhnf6rx9h8Xy
 /kORutAAJll/k9aOeZ8E+/f+blD9rJf+P/njv0MfgTkQB+e5EHuVv+eSpdbXtFmBF4QM
 aoU9q+Y10bV6HRbHmoXRRoJ1C4vE4Deeet89nlz7uWUu1YNFKfS2xoCnNZkydrDMb8OQ
 KgLJtH/Xo1Yy/Jhk3DlNvSck3qrWM94a6K9OzCaBxeDvyEh8YDYLspSfuX7f0/or8LjE
 U0UVssmU93ehtHVY+M7K8L6Q8O/E9JxEsGjWAHRfmaRnEKBt21h7iBU4QgNFPBIzYfxi
 H2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245407; x=1794850207;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Gut61P2X6xFkrMVnymAI1nTOnnVvlvyOqV+kFwzkCg=;
 b=as4LwIGLNNSauEJzVhB6BHuL/Z/9lRq1EeBT+k67/DeKLIXhECaDSX3lQDzXw+Byej
 lIWfOf99gtMrJMTTNidrgdvKmxeYpzR53JR+AopFO4/rfl6Y47M3SbKbjvjt+BbIdlZR
 5creR7jC9HY6S6k1sp1plti5KFoCQ+BxtsL5QtBfBYg7L4pS8IQcRDAUsNTY+JSKjkb1
 Eo5r6GBt7gTylq89++pfXvWHZZa+faLvm+UkE3zk7+8KbVkRRyIriP7F9uBs0QlWDJ8e
 B4vLp/10hAAIBig7ZuZ+5xXDzxGOt52YW0ku8MrSzaKqythGn8EPMtnHBq1ZdXqoJ6ia
 57nA==
X-Gm-Message-State: APuU4Z8R/dj7QfcA4S9nzEL8TsFViP92kyfWetyC7JH76Gr0xWzOON7d
 1zvO/EnefV/R3pcmFDcGmL5U+UYYoDfN4bj4/PcuxQY5+xt64wIpPabrtwRSTgwjmxvE0LMrLIH
 g+CTGGH0=
X-Gm-Gg: AYBFou2LiYG58poYCHvvOZDup/0jCZh4Sl5lWvdqdrC+z6YEmBRt7EINygDOEbVjwVD
 3w2/WFoV5/L5P5noo08WaGrPjvrpyiocx8eeAcBIsKJh3rmk9Be6ryzLqw9Gw6rkDLeN8r9EG4e
 FP01PnPzqEfhqfA6Gz1DLjngLEecpAilYQ1CZHMhqj3QQJXNaw0Jehb4Eght24V5/ZQH6wrMCpE
 RdzVfW0L2eAenkmfHPgyI/zQBwy6Hu6yoBEbB3Wq79Xi+rF+X1o5Z9muOZI+WCtBxY8FOAs+2Ec
 G6ea78tYtNTrmGhpOjmD9J/qB4OEYS69m3sCqzzM93yDB/Ug6iVh78BKGzf8gZVpKxAFq68g0yi
 tjNvxIGhvlpfwOWsbfRF4XSu/+FSgohQbogebJJDbA0PJ83HUgc0p8hU7UD7Ws6YjBFPxIgO1gu
 3TH+yvCxJ1+DAtcOyO1S7QNvX5bLC7RfGHgg6TacenWLz+RaVR1XsEiAiBpp79pykG8raZ7vVZJ
 nDk01C1npAMgac7iG7wl+raD4HiJpYV8Mg/dTudmvkRzENP3jLcYzAfAlDa4BUXYB11+mD6SQIt
 vap1iLGfQFvospJ2UkO5pGwywyNPlF2oo7TOtR7pldLTqIMUNGRDSS0UIQCQ8SunXcb3ZPYy
X-Received: by 2002:a17:90b:3b4a:b0:3ac:3588:b548 with SMTP id
 98e67ed59e1d1-3b166f69f40mr289444a91.13.1794245406915; 
 Mon, 09 Nov 2026 09:30:06 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a43768sm721685ad.6.2026.11.09.09.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:30:06 -0800 (PST)
Date: Mon, 9 Nov 2026 09:30:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 00/28] net/hinic3: add PMD features and fixes
Message-ID: <20261109093004.49d1914b@phoenix.local>
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 00:20:04 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> Changes in v6:
> - Rebase on current main and address the v5 review comments.
> - 0003/0005: correct the Fixes: tags, drop the Cc: stable request for
>   fixes to code that has never been in a stable release, and remove the
>   dead null check in the vport enable fix.
> - 0006: clear the stale hardware consumer index on Rx queue reset.
> - 0009: reject a packet whose first segment is shorter than the
>   pseudo-header, narrow the shared-mbuf check to the L4/TSO flags,
>   compare the tunnel type as a whole enum, and compute the outer and inner
>   pseudo-header checksums.
> - 0010: arm the SP230 per-queue vectors when Rx interrupts are disabled,
>   so vfio masks them after the first assertion, and keep the
>   coalescing-only fallback for igb_uio/uio_pci_generic.
> - 0011: advertise OUTER_UDP_CKSUM now that the outer UDP pseudo-header is
>   written in the software prepare step. Drop the stale QinQ features.ini
>   entry and unused QINQ mbuf flag.
> - 0012: select the CIR drop counters by NIC type in calc_num, get_names
>   and get.
> - 0013: report the needed capability count for a short array, mask
>   AUTO out of the reported capabilities, keep the GET-side firmware
>   NOT_SET to AUTO mapping, and reject unknown firmware values.
> - 0014: take the PCI device from the ethdev in priv_dump so a secondary
>   process does not dereference a stale pointer.
> - 0016: keep a separate admin-down flag so a PF link up event cannot
>   override dev_set_link_down().
> - 0018: cache RSS enablement per queue and clear rss_type when RSS is
>   disabled.
> - 0019: reject outer IPv6 with an inner L3, and stop setting the VLAN
>   flag mask in the TCAM keys.
> - 0021: document that the coalescing tunables only take effect with
>   HW compact CQE.
> - 0022: report the combined compact-CQE checksum error as an unknown
>   result instead of blaming the IP or the L4 layer, and keep the ptype
>   table in sync with the advertised ptype set.
> - 0023: reject a queue depth that differs from the first queue instead
>   of coercing it, reset the expected depth in dev_configure() and
>   dev_stop(), validate it in dev_start(), and mark Tx queues stopped in
>   dev_stop().
> - 0024: reject TSO packets that need more SGEs than the ring can hold,
>   reject a tso_segsz that does not fit the 14-bit MSS field, and report
>   nb_seg_max/nb_mtu_seg_max.
> - 0025: clear queue_info in the scalar burst for compact WQEs like
>   hinic3_master, clear the per-packet offload state, guard the prefetch
>   against an empty burst, and remove the per-packet data path logs.
>   Per-packet unsupported-type messages are lowered to DEBUG.
>   Tunnel packets are accepted by type instead of by feature bit;
>   VXLAN_GPE TSO and IPIP TSO on SP620 stay rejected.
>   SP230 does not get the software pseudo-header writes because its
>   hardware derives the inner checksums and TSO headers itself.
> - 0027: report the Tx burst mode of the function that is installed.
> 
> Changes in v5:
> - Register hinic3_prep_pkts() in the pseudo-header checksum patch instead
>   of the compact CQE Rx patch.
> - Mention only SP620 in that commit message.
> - Document the RQ CEQ EN bit and the INTR field for SW compact CQE.
> - Drop the per-packet ERR log for a zero tso_segsz.
> - Keep log and error messages on a single line.
> - Check the non-TSO packet length before the early SGE-count return.
> - Scale the coalescing parameters by their unit in the log.
> - Clear the stale Rx hardware CI write-back memory on queue reset.
> 
> Changes in v4:
> - Reordered the queue-depth, TSO and pseudo-header patches to keep the
>   series bisectable; sized the copy pool from the Tx queue depth, kept the
>   copy chain consistent and rejected a zero tso_segsz.
> - Fixed the pseudo-header L4 protocol and dropped the IPv6 extension-header
>   walk; split the SP230 MSI-X handling; validated the VXLAN-GPE mask and
>   the device kvargs.
> 
> Changes in v3:
> - Moved the TCAM leak fix into its own patch; set the burst pointers and
>   tx_pkt_prepare for secondary processes; zeroed the RQ/SQ contexts.
> - Fixed the Tx burst return count and prefetch guard; validated kvargs;
>   reset the queue depths in dev_configure(); reported FEC per speed;
>   routed priv_dump through fprintf(); derived the pseudo-header protocol
>   from the offload flags.
> 
> Changes in v2:
> - Added the five bug fixes (SP230 VF ID, ethertype double removal, VXLAN
>   VNI mask, vport NULL deref, secondary ops); split the NIC type
>   identification; added hinic3.rst/features.ini.
> - Dropped the unused devargs and Tx/Rx spin loops; corrected the
>   GENEVE/VXLAN-GPE/SP620 IP-in-IP rule handling.
> 
> Changes in v1:
> - Initial posting.
> 
> Every commit builds with -Dwerror=true.
> 
> Jiacheng Ye (28):
>   net/hinic3: fix SP230 VF PCI device ID
>   net/hinic3: fix double removal in ethertype flow destroy
>   net/hinic3: fix TCAM index leak on ethertype flow set
>   net/hinic3: fix VXLAN VNI spec and mask write
>   net/hinic3: fix vport enable null dereference
>   net/hinic3: clear stale Rx hardware CI on queue reset
>   net/hinic3: attach ethdev and set ops in secondary process
>   net/hinic3: add NIC type identification
>   net/hinic3: fix pseudo-header checksum calculation
>   net/hinic3: add SP230 Rx queue interrupt handling
>   net/hinic3: fix offload and cmdq/compact CQE config
>   net/hinic3: add CIR drop statistics and VF LAG support
>   net/hinic3: add FEC mode get/set and capability support
>   net/hinic3: add mbox message recording and debug dump
>   net/hinic3: add COS mask and COS map support
>   net/hinic3: add VF link state and promiscuous support
>   net/hinic3: convert cmdq ops to static global variables
>   net/hinic3: update RSS hash type configuration
>   net/hinic3: refactor flow rule parsing
>   net/hinic3: add SP560 NIC type identification and handling
>   net/hinic3: add device kvargs parameters support
>   net/hinic3: add compact CQE Rx path and ptype table
>   net/hinic3: ensure queue depth and state consistency
>   net/hinic3: expand TSO from 127 to 255 segments
>   net/hinic3: split Tx burst function for compact CQE support
>   net/hinic3: add SP230 VF software statistics
>   net/hinic3: add Tx burst mode get
>   net/hinic3: expose Tx queue copied-mbuf statistics
> 
>  .mailmap                                      |    1 +
>  doc/guides/nics/features/hinic3.ini           |    5 +-
>  doc/guides/nics/hinic3.rst                    |   27 +-
>  doc/guides/rel_notes/release_26_11.rst        |   13 +
>  drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
>  drivers/net/hinic3/base/hinic3_csr.h          |    6 +-
>  drivers/net/hinic3/base/hinic3_eqs.c          |   64 +-
>  drivers/net/hinic3/base/hinic3_eqs.h          |    9 +-
>  drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
>  drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
>  drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
>  drivers/net/hinic3/base/hinic3_mbox.c         |   45 +
>  drivers/net/hinic3/base/hinic3_mbox.h         |   19 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c      |  201 ++-
>  drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
>  drivers/net/hinic3/base/hinic3_nic_event.c    |   71 +-
>  drivers/net/hinic3/hinic3_ethdev.c            |  904 ++++++++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            |   58 +-
>  drivers/net/hinic3/hinic3_fdir.c              |   51 +-
>  drivers/net/hinic3/hinic3_fdir.h              |    8 +-
>  drivers/net/hinic3/hinic3_flow.c              |  590 ++++++---
>  drivers/net/hinic3/hinic3_flow.h              |  196 ---
>  drivers/net/hinic3/hinic3_nic_io.c            |  184 +--
>  drivers/net/hinic3/hinic3_nic_io.h            |   98 ++
>  drivers/net/hinic3/hinic3_rx.c                |  633 ++++++++--
>  drivers/net/hinic3/hinic3_rx.h                |  206 ++--
>  drivers/net/hinic3/hinic3_tx.c                | 1098 +++++++++++++----
>  drivers/net/hinic3/hinic3_tx.h                |   53 +-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   65 +-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    6 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   76 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
>  34 files changed, 3641 insertions(+), 1185 deletions(-)
>  delete mode 100644 drivers/net/hinic3/hinic3_flow.h
> 

AI review feedback. This was followon to earlier review and I fed in
your response as well. I see two warnings that still need to be
addressed.

-----------------------------------------------------------------


Subject: Re: [PATCH v6 00/28] net/hinic3: fixes and new features

Applies to main and every commit builds with -Dwerror=true. The three
v5 errors are fixed: stale rss_type, the IPv6-outer IP-in-IP rule, and
the 255-segment TSO stall. So are most of the v5 warnings.

On your hinic3.ini question: no new rows are needed. features.rst
maps OUTER_IPV4_CKSUM to "Inner L3 checksum" and OUTER_UDP_CKSUM to
"Inner L4 checksum" (the names are confusing). hinic3.ini already
lists both, so v6 is correct as is. I was wrong to ask for "Outer"
rows in v5.


Warnings
========

[PATCH 10/28] net/hinic3: add SP230 Rx queue interrupt handling

The new rationale is wrong. vfio-pci auto-masks INTx only. For MSI-X
its handler signals the eventfd and returns, so nothing masks the
vector after it fires. The fall-through also makes things worse,
because it runs the full Rx interrupt setup:

		/* Fall through to the per-queue MSI-X setup. */
	...
		rxq->dp_intr_en = 1;

dp_intr_en = 1 clears intr_disable in the RQ context
(hinic3_nic_io.c), so with intr_conf.rxq == 0 the queues now raise
interrupts that nobody waits on. The host still takes every one of
them.

To keep the vectors quiet, program coalescing and then disable each
vector, as hinic3_disable_queue_intr() already does:

	for (i = 0; i < dev->data->nb_rx_queues; i++) {
		uint16_t vec = i + HINIC3_RX_VEC_START;

		err = hinic3_init_rxq_msix_attr(nic_dev->hwdev, vec);
		if (err)
			return err;
		hinic3_set_msix_state(nic_dev->hwdev, vec,
				      HINIC3_MSIX_DISABLE);
	}
	return 0;

This works with any interrupt backend: no eventfds, no intr_vec, and
dp_intr_en stays 0. Fix the commit message to match.


[PATCH 16/28] net/hinic3: add VF link state and promiscuous support

admin_down survives stop/start, but dev_start enables the vport
unconditionally:

	err = hinic3_set_vport_enable(nic_dev->hwdev, true);

So after set_link_down, stop and start, the vport passes traffic while
hinic3_vf_link_status() reports the link down. On the PF, the next
link-up event leaves the vport disabled. Either clear admin_down in
dev_start, or skip the vport enable there while it is set.

admin_down is also set before hinic3_set_vport_enable() is called and
is not restored when that call fails. Set it after the call succeeds.


Info
====

[PATCH 11/28] The Fixes: tags sit in the middle of the body, before
the hinic3.ini paragraph. Move that paragraph above the tags so they
are trailers again.

[PATCH 15/28] "Fixes: 9204b6b7bb" needs the 12-character hash:
9204b6b7bb1a.

[PATCH 18/28] rxq->rss_en only follows rss_state.
hinic3_rss_hash_update() with rss_hf == 0 on a port with RSS enabled
sets rss_type to 0 but leaves rss_state at ENABLE. The compact CQE
path then keeps setting RTE_MBUF_F_RX_RSS_HASH. v5 avoided this by
testing rss_type.val. Either reject rss_hf == 0 there, or include
rss_type.val != 0 when setting rss_en.
