Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FBC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:13:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D74402A4;
	Wed, 14 Oct 2026 19:13:19 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 86C744013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:13:18 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so426746b3a.2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791997997;
 x=1792602797; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z8sYM7AtXqRZG7lD5zJ+ffCInG1PGXc/KjLGW7hbjiE=;
 b=KnZvcMcsL1MgMfhi4uh4uGjP+TxuaRneKFM3YaveCsgex0FdD5i1r4oUeXAVCvqQKR
 0ue2Z5aFp9zBXrL9maoIHMr0Rb1eQJURM3jmpynuqzxCDi+2B40ptDDiMB226Fm4wgBX
 t1DsRaR6sf43PDZ3sX39/DsLG6RTR4jDBw9iaz0Irgv3672IUvVsTgP4YQMLbrHMBXfg
 CodIx4mWG8CBOxjRx6lrKN0i+sFU2WcrWe1MjisNGS9rV08CR6XGB7dmkrtrA09WuNBZ
 ITzKZmTOdaXuUUx6skpx1tr2uvrclMgazcgEFOdxkTLJdHTuyIldRD0CDcIapW3XmvlD
 WXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997997; x=1792602797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z8sYM7AtXqRZG7lD5zJ+ffCInG1PGXc/KjLGW7hbjiE=;
 b=eOzARKACECTwQ8BHjPh/yb7+Oh/Sz+UB+4X8fWZY1W6hB49cVvepx+WQ+07ZGBqkvJ
 5Sx+2Chv0FBFLzP9y5HzOIpj/5trQvBDu4VK6gd3USGGGaVh7JHGtsixCLTXGGCz4qLe
 3uVU7yfkVPiE8EDrLq7C9NDMSdaS0c3vcpHwrUbpqLeiFU0oFPXCyLiFLIYXNwDZKtEe
 aJaD2oP6fI5Hom96w/kZfxiZ6hhBcAt++a5N01HHXs7ECkC8JhtP1oODSMxoyb/2xRnT
 3L2PTjzLguOpG1x4ePwD9yPRiehgq8y452YutCkSqp/ulG5gwUiTqfkXOZlqkj7TxesH
 XVyg==
X-Gm-Message-State: AFq9FYLMTF9/SXAaiItNnYR6VIqKHqMIRwvBmMLmSCcbrYSOIFdF/cZO
 7KQXrNQOq376o0D0OxJvAfi4EEETcNBI1+cWE1yZaL/oTbYmlhw4ZA3KCQKP72+24bg=
X-Gm-Gg: AYBFou2IAwG6f7QlLUkjqtPMONelRFzKHgsmdCkWM9WA9tspX3cED4dqce6fSlT71HW
 bJv2jas60Z62m7/Q+VjirCcwG/8/TT1zZTMy7wK5p9YW0lkJvJAscCxCasfuOmqN69XrVXoWzud
 Hq0XPzHZlQJADHlkm439w+Gl2YtE+/45vYb2dWwQ82lG6vVAT31EQA9IVqKosPj1ACWGFlL+ubr
 5cBGf/d+Ygq7XEMhYJN+tmR1cg49rWGK5HV7g4sXphjnTAptUwyvRe/ly0i5gK/2fFnGwieKJVq
 CUm2BGca5tz3KawhxMhOHfYc3QCfqSB2/ICnPSRbjeVZpjRziAkKoSko58DwsakTu3wpepKh+Fh
 qKrWFDpdZ9XLYozgraoURKPHpG6/BowFx645JNWRTyo3o8MWUG5C5Y/+DsS350dasQskFaOi2b9
 fbid+QD+ulPp2oojT/GZrN9uxTi1Hoo8FxkW+Y5TqncwEZUHGuyj4OR1RYxwSEGV2NQ22Mcu+Po
 nrpo3fLX335ksK/Iij7Z4pEb51PyAPEGCBGQk/L
X-Received: by 2002:a05:6a00:4007:b0:857:7317:cff5 with SMTP id
 d2e1a72fcca58-897c6a2ed21mr12668855b3a.22.1791997997437; 
 Wed, 14 Oct 2026 10:13:17 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d7f51f592sm1426072b3a.7.2026.10.14.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:13:17 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:13:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 00/26] net/hinic3: add PMD features and fixes
Message-ID: <20261014101314.2262376c@phoenix.local>
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 14 Oct 2026 23:08:56 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> v2:
> - Add five bug fixes (SP230 VF PCI device ID, ethertype flow double
>   removal, VXLAN VNI spec/mask, vport enable null dereference, and
>   secondary-process ethdev ops setup).
> - Split NIC type identification into its own patch and drop the mbox
>   count telemetry patch.
> - Add hinic3.rst and features/hinic3.ini documentation.
> - Drop the tx_free_loop and rx_empty_threshold devargs and the Tx/Rx
>   spin loops.
> - Use the correct GENEVE/VXLAN-GPE flow item types and reject
>   unsupported mask fields; reject IP-in-IP rules on SP620.
> - Remove QINQ offload advertisement, split link_status and
>   vf_valid_status into separate variables, use memcpy for unaligned mbox
>   reads, and drop module parameter reads.
> - Split the Tx burst patch into focused, self-contained commits for
>   queue depth/state consistency, SP230 VF software statistics, Tx burst
>   mode reporting, and Tx queue copied-mbuf statistics.
> - Reword commit messages with full Fixes hashes and add
>   stable@dpdk.org Cc tags where the defect exists in a released version.
> 
> Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
> 
> Jiacheng Ye (26):
>   net/hinic3: fix SP230 VF PCI device ID
>   net/hinic3: fix double removal in ethertype flow destroy
>   net/hinic3: fix VXLAN VNI spec and mask write
>   net/hinic3: fix vport enable null dereference
>   net/hinic3: attach ethdev and set ops in secondary process
>   net/hinic3: add NIC type identification
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
>   net/hinic3: expand TSO from 127 to 255 segments
>   net/hinic3: split Tx burst function for compact CQE support
>   net/hinic3: ensure queue depth and state consistency
>   net/hinic3: add SP230 VF software statistics
>   net/hinic3: add Tx burst mode get
>   net/hinic3: expose Tx queue copied-mbuf statistics
>   net/hinic3: add pseudo-header checksum calculation
>   net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops
> 
>  .mailmap                                      |    1 +
>  doc/guides/nics/features/hinic3.ini           |    4 +
>  doc/guides/nics/hinic3.rst                    |   22 +-
>  doc/guides/rel_notes/release_26_11.rst        |   13 +
>  drivers/net/hinic3/base/hinic3_cmd.h          |    2 +
>  drivers/net/hinic3/base/hinic3_csr.h          |    8 +-
>  drivers/net/hinic3/base/hinic3_eqs.c          |   55 +
>  drivers/net/hinic3/base/hinic3_eqs.h          |    2 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c       |    2 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.h       |    8 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.c      |    9 +-
>  drivers/net/hinic3/base/hinic3_hwdev.h        |    3 +-
>  drivers/net/hinic3/base/hinic3_hwif.c         |    4 +-
>  drivers/net/hinic3/base/hinic3_mbox.c         |   43 +
>  drivers/net/hinic3/base/hinic3_mbox.h         |   18 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c      |  193 ++-
>  drivers/net/hinic3/base/hinic3_nic_cfg.h      |  105 +-
>  drivers/net/hinic3/base/hinic3_nic_event.c    |   68 +-
>  drivers/net/hinic3/hinic3_ethdev.c            |  715 +++++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            |   55 +-
>  drivers/net/hinic3/hinic3_fdir.c              |   65 +-
>  drivers/net/hinic3/hinic3_fdir.h              |   14 +-
>  drivers/net/hinic3/hinic3_flow.c              |  602 +++++++---
>  drivers/net/hinic3/hinic3_flow.h              |  196 ---
>  drivers/net/hinic3/hinic3_nic_io.c            |  156 +--
>  drivers/net/hinic3/hinic3_nic_io.h            |  145 ++-
>  drivers/net/hinic3/hinic3_rx.c                |  591 ++++++++--
>  drivers/net/hinic3/hinic3_rx.h                |  216 ++--
>  drivers/net/hinic3/hinic3_tx.c                | 1048 +++++++++++++----
>  drivers/net/hinic3/hinic3_tx.h                |   59 +-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |   71 +-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |    8 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   75 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |    6 +-
>  34 files changed, 3392 insertions(+), 1190 deletions(-)
>  delete mode 100644 drivers/net/hinic3/hinic3_flow.h
> 

Semi-automated AI review finds some errors.

Note: AI review of tx burst functions is not perfect at this point.
Have tried to teach it about mbuf ownership on transmit and error handling
and it gets it mostly right, and flags lots of buggy drivers.
But it is not perfect.

Subject: Re: [PATCH v2 00/26] net/hinic3: fixes and new features

Series applies to main, and every commit builds with -Dwerror=true.

Series-level:

The first five patches are proper fixes. Several later "feature" or
"refactor" patches also carry bug fixes that are not called out
(13, 15, 25). Those need their own commit message lines and Fixes:
tags so stable can find them.

Cc: stable is not needed on 01 and 07. 8843a7a6bca5 and aa31be38544e
first appear in v26.03, which is not an LTS.


Errors
======

[PATCH 18/26] net/hinic3: add compact CQE Rx path and ptype table

Secondary process gets no Rx/Tx burst functions. Burst pointers are
per-process, but rx_pkt_burst/tx_pkt_burst (and tx_pkt_prepare from
25/26) are now only set inside the primary-only block of
hinic3_dev_init(). Patch 17 still set them for both processes; this
patch moved them. That undoes 05/26. config and ptype_tbl live in
shared memory, so the selection can run in both processes:

	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
		nic_dev->config = config;
		hinic3_nic_feature_init(nic_dev);
		err = hinic3_init_rx_ptype_table(eth_dev);
		...
	}

	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
	if (nic_dev->config.rx_cqe_compact_en) {
		eth_dev->rx_pkt_burst = hinic3_recv_pkts_compact_cqe;
		eth_dev->tx_pkt_burst = hinic3_xmit_pkts_compact_cqe;
	} else {
		eth_dev->rx_pkt_burst = hinic3_recv_pkts;
		eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
	}


[PATCH 17/26] net/hinic3: add device kvargs parameters support

Invalid devargs are silently accepted. rte_kvargs_process() returns
-1 when the handler fails and does not set rte_errno, so

	ret = -rte_errno;

yields 0 (or a stale value). The probe succeeds with whatever was
parsed before the bad key. Use:

	if (ret < 0)
		ret = -EINVAL;

and drop strerror(rte_errno) from the caller's log.


[PATCH 20/26] net/hinic3: split Tx burst function for compact CQE
  support

Both hinic3_xmit_pkts() and hinic3_xmit_pkts_compact_cqe() free a
bad packet and continue (correct), but then return nb_pkt, the count
of queued packets. The caller owns tx_pkts[ret..nb_pkts-1]. After any
freed packet the return is short, so the application re-sends or
frees a packet the driver already queued: double free or
use-after-free. Return the number consumed; keep nb_pkt for the
doorbell and stats:

	end:
		if (nb_pkt) {
			hinic3_write_db(...);
			...
		}
		return nb_tx;

hinic3_xmit_pkts() also does rte_prefetch0(*tx_pkts) after
tx_pkts++, which reads tx_pkts[nb_pkts] on the last iteration, past
the caller's array:

	if (nb_tx + 1 < nb_pkts)
		rte_prefetch0(tx_pkts[nb_tx + 1]);


[PATCH 26/26] net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops

RQ context is built in a command buffer from rte_pktmbuf_alloc(),
which is not zeroed, and hinic3_rq_prepare_ctxt() does not clear it.

- SP230 in compact CQE mode: the generic code now skips pi_paddr_hi/lo
  for compact WQE, and the HTN op does not write them. Before this
  patch they were pi_dma_addr; now firmware gets stale buffer data.
- SP620/SP560 compact: "cqe_sge_len |= RQ_CTXT_CQE_LEN_SET(...)" ORs
  into a field that is never initialized for HINIC3_COMPACT_RQ_WQE.

Zero the context and let the per-tile op override last:

	memset(rq_ctxt, 0, sizeof(*rq_ctxt));
	...
	rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
	rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
	...
	/* last, so the tile can override pi_paddr/cqe_sge_len */
	hinic3_cmdq_get_ops(rq->nic_dev)->
		prepare_rq_ctxt_ceq_and_prefetch(rq, rq_ctxt);

Same memset for hinic3_sq_prepare_ctxt().


Warnings
========

[PATCH 09/26] net/hinic3: add FEC mode get/set and capability support

hinic3_fec_capability_get() returns -ENOTSUP while link is down,
since it reports only dev_link.link_speed. "show port N fec
capabilities" fails until link comes up. Report capability per
supported speed, independent of current link state.

hinic3_fec_param_valid() rejects AUTO, but the conversion table maps
HINIC3_PORT_FEC_AUTO, so capability can advertise AUTO that fec_set
refuses. Accept AUTO or mask it out of the reported capa.


[PATCH 10/26] net/hinic3: add mbox message recording and debug dump

eth_dev_priv_dump gets a FILE *, but hinic3_dump_aeq_info() and
hinic3_dump_aeq_mbox_info() print through PMD_DRV_LOG at ERR level.
A user query should not log errors. Pass the FILE * down and use
fprintf().


[PATCH 15/26] net/hinic3: refactor flow rule parsing

Not a pure refactor. Behaviour changes not in the commit message:

- IPv4/VXLAN TCAM keys no longer set vlan_flag mask, so rules now
  match tagged packets too
- STN dynamic TCAM limit 1024 -> 2048
- RTE_ETHER_TYPE_CNM and RTE_ETHER_TYPE_ECP accepted
- TCAM index freed on ethertype set failure (a leak fix; Fixes:)
- multiple actions now rejected

Describe them, and put the leak fix in its own patch with Fixes:.


[PATCH 16/26] net/hinic3: add SP560 NIC type identification and handling

DEFAULT_DRV_FEATURE gains bit 27 (NIC_F_RX_SW_COMPACT_CQE). Nothing
uses it until 18/26 and the commit message does not mention it. Move
it to 18 and say why.


[PATCH 17/26] net/hinic3: add device kvargs parameters support

Documented defaults do not match the code. The handler divides user
input by 8 (pending limit, coalesce num) or 5 (time), but the default
macros are already in hardware units. Your own log line prints
tx_pending_limit default as 16 pkt; hinic3.rst says 2. Likewise
tx_coalescing_time 10 us vs 2, rx_cqe_coalesce_num 56 vs 7,
rx_cqe_timer_loop 40 us vs 8. Document units and real defaults, or
keep defaults in user units.

No upper bound. The hardware fields (sq_attr.pending_limit,
coalescing_time, cqe_ctx.threshold_cqe_num) are uint8_t, so large
values truncate silently. Reject anything above UINT8_MAX * unit.

Defaults change without explanation: RQ CQE coalesce 63 -> 7, timer
15 -> 8, Tx CI pending limit 3 -> 2, coalescing time 16 -> 2 (applied
in 26/26). Say why in the commit message.

Intermediate state: vport enable now sends config.rx_cqe_compact_en
(default 1) to firmware, but masking against NIC capability does not
arrive until hinic3_nic_feature_init() in 18/26. At this commit, NICs
without compact CQE have it enabled in firmware while Rx queues still
use non-compact WQE. Move the capability masking into this patch.


[PATCH 18/26] and [PATCH 21/26] queue depth

A mismatched nb_desc is silently replaced with the first queue's
depth. The application sized its mempool for what it asked for.
Return -EINVAL instead.

rxq_depth/txq_depth are reset in dev_stop(), but configured queues
survive stop. After stop, setting up one queue again accepts any
depth and mismatches the others. Reset in dev_configure(), or compare
against an existing queue's q_depth.


[PATCH 19/26] net/hinic3: expand TSO from 127 to 255 segments

The copy pool is one global 1024-entry pool of 4 KB mbufs, created
on the calling lcore's socket and shared by all ports. One TSO packet
can now hold up to 227 of them until Tx completion, so a few large
in-flight packets drain it and the rest drop as offload_errors. Size
the pool per port from txq depth, or bound copies per packet.


[PATCH 20/26] net/hinic3: split Tx burst function for compact CQE
  support

Tx burst is selected by rx_cqe_compact_en. The Tx WQE task format
used to follow NIC_F_TX_WQE_COMPACT_TASK. With rx_cqe_compact_en=0
on SP230, hinic3_xmit_pkts() builds normal task sections regardless
of what the Tx side supports. Select the Tx path on its own feature
bit.


[PATCH 23/26] net/hinic3: add Tx burst mode get

	uint16_t tx_offloads = dev->data->dev_conf.txmode.offloads;

truncates a uint64_t. It works only because every flag tested is
below bit 16. Use uint64_t.


[PATCH 25/26] net/hinic3: add pseudo-header checksum calculation

The IPv6 pseudo-header length and protocol come from re-walking
extension headers in the packet, while the L4 header is located with
mbuf->l3_len. The two can disagree, and the walk has no bound against
data_len. Use mbuf->l3_len as the application-supplied header length
and take the protocol from ol_flags (TCP_CKSUM/TCP_SEG -> IPPROTO_TCP,
UDP_CKSUM -> IPPROTO_UDP); drop hinic3_get_ipv6_len_proto().

Packets with refcnt > 1 or indirect mbufs are skipped, so they leave
with a wrong L4 checksum and nothing reports it. Fail them instead:

	if (unlikely(rte_mbuf_refcnt_read(mbuf) > 1 ||
		     RTE_MBUF_CLONED(mbuf))) {
		rte_errno = EINVAL;
		return i;
	}


[PATCH 26/26] net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops

The STN op forces EN=1 in compact mode. EN is the interrupt-disable
bit (EN = dp_intr_en ? 0 : 1), so Rx interrupt mode silently stops
working on SP620/SP560 with compact CQE, while hinic3.ini still says
"Rx interrupt = Y". Honour dp_intr_en, or reject intr_conf.rxq when
compact CQE is on.


Info
====

[PATCH 05/26] hinic3_dev_close() gains a secondary-process early
return placed before "int ret;" (declaration after statement), and
the commit message does not mention it.

[PATCH 07/26] Reformatting rx/tx_offload_capa inside a stable fix
only makes backport harder. Drop the churn.

[PATCH 11/26] HINIC3_COS_NUM_MAX_HTN is no longer used.

[PATCH 13/26] Ops selection moves from the NIC_F_HTN_CMDQ capability
to PCI device ID, with unknown IDs falling back to STN. Say so. The
old code also leaked cmdq_ops and rte_free()'d the static ops pointer
on the init error path; this patch fixes that and should say so.

[PATCH 18/26] hinic3_get_l4_ptype(IGMP) << 16 gives 0x07000000, which
is not a defined inner L4 ptype. Typo: HINIC3_L4_PYTPE_SHIFT.

[PATCH 19/26] wqe_info->last_cpy_mbuf_usable is only ever set to 0;
the truncation block in hinic3_copy_tx_mbuf_multi() is dead.

[PATCH 22/26] The SP230 VF branch still queries firmware vport stats
and discards them, and repeats the per-queue loops above (adding NULL
checks those loops lack). Accumulate in the existing loops and skip
the firmware call for this case.

[PATCH 25/26] If SP620/SP560 hardware needs the pseudo-header, L4
checksum and TSO offload have been wrong since the driver was added.
That makes this a fix: Fixes: and Cc: stable. HINIC3_TX_OFFLOAD_MASK
now includes HINIC3_PKT_TX_IPV6, so plain IPv6 packets with no
offload requested take the offload path and an extra WQEBB; explain
or drop it.
