Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0345CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D78A402E9;
	Sat, 10 Oct 2026 20:30:07 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 7134540274
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:30:05 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso500670a91.3
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791657004;
 x=1792261804; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BU5UmaJhpi6ckAIJpABADa/Or/gqjxDesthhCN4PrpA=;
 b=iqzbtvaCbcr3ThQCt7rjJgEoQ5Uhuzfxci4C6uf2VQnCchbr69QHaGNCLp6oNSkwsT
 SNC9RPGKzsCNOZntpknh0SDCwPq6Y6nNTfj1m1imMIBJ9ti1bwtDDy2s4vKlddoQIMeE
 BXM3SfvKhr23+cgrpv5UhFnPQF/Forp4PR9J3kZIz6EwmJ6DEwlB2WB5iRd9nOmeQey2
 SmzNev1NvHDkEwWLOHc7mpgwbUVyXVMu2YjAV2SPSbU2WmKo53QSFZvwSEsjpHQrZ7Ek
 XyP5Rw2OnuN+fxFl0RyZpCKbZ/sCwFhn+GY7RFjafg/RpvMiDvFO7r8XcfRFA7pw1aNL
 B44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791657004; x=1792261804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BU5UmaJhpi6ckAIJpABADa/Or/gqjxDesthhCN4PrpA=;
 b=gzZZCYDz6FdCZf7gmgvgzwWl4bCMAo8zlMgvyQeCiSOF6N5Y7fj7aa2CwRP1dbVBgF
 ufSBLuIeHxjq8h2xXtGt3HalySPhH89+8JS1zy2UiHZRVeMYFuezy7G/bJrd2lodwI0a
 vctPjeewl8jiKQbiyam+73lMzfCMkObfvPaasYiImEGCLZgGxyj12f/ZZDyRf9Xw9ehS
 DkRlpx6azOv4exdh5Cn5nQS0S5ARAIx4GZBIZ2gSVRS+X8nKlBNYTdHaOSq056agyYbC
 2ssOaCRF0GumKZzKoFmfQJz8qKEQEPVaG9/+kE6YrbclyWaV7GWRJCAEWvFwlr9T27vm
 vm1g==
X-Gm-Message-State: AFq9FYLXzRxxmRjLqLrxkLPQmMzb6cRyKDjwLov1v78lR8gix4mtZGLG
 rISWtJvYA1VBbvqHFcfa/WyIwaXtjGq0mRvnOp57FI1108CNyt9Jm8hKMMMqlr1VZl8=
X-Gm-Gg: AYBFou3tCXadhDZjtGou5T9ALswZoWgInXRurmJXekMvJKtTwmgIA3ipJGrugeQuPhz
 GdGpF4JFWgZea81K8vuZ/iWk64AHXVPORGh9tlbNs7qYtYx1mbexsuUpFqAGUMwuzzd5Py03weM
 X5hpyzU5PFMA7bid4ZXFX9TwHW5Aj0qzT2Yoi/9RVngwrlhNgWsP+WKJCU1iVOPN7VIJ54HCHhq
 iaI2hdzgOVq5nL49H/JONsknjKnZW2B2Q9g7+Mt1TMQXHYj7giMoh1uR+pBI3YPnmXjLEaeDovT
 5TXgiRwHt9fsDc9E/omRJE8EE91UWhP9Va5SV3rq58tM+pNEVsdG3Vw+LWWj8T8LlJSqco8jkF6
 Z6z4O5JXbqqRjry3TymOF2VI8Y+G5hhLc5IYRnTFefjZ9MjlkOKrUtWDCyIMd4AcrJ9Iho9mpGt
 YgDTEnB0ss0oxmFLmweuC8dMhR3HnPFZ56nuiAAPsDCRog7epn8gYhn+F4Dhve2yS3KiTHj0sym
 4EOrYfpPiDP+B3qD/kXrv2MH8+YPCU9enEDBFXB
X-Received: by 2002:a17:90b:1dd1:b0:3a8:bb56:f1ed with SMTP id
 98e67ed59e1d1-3ab3acf313fmr4665146a91.50.1791657004111; 
 Sat, 10 Oct 2026 11:30:04 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e26ddfsm2375566a12.17.2026.10.10.11.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:30:03 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:30:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v1 00/17] net/hinic3: add PMD features and fixes
Message-ID: <20261010113000.270060dc@phoenix.local>
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 10 Oct 2026 22:44:51 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement and cmdq/compact CQE
> configuration, and adds FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording and telemetry, RSS hash configuration, compact C=
QE
> Rx/Tx paths, TSO segment expansion, pseudo-header checksum, per-tile cmdq
> ops, SP560 NIC support, and device kvargs tunables.
>=20
> Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>


Large patch series, the partial and not complete list of problems identified
by AI review are:

Review: [PATCH v1 00/17] net/hinic3 updates (Jiacheng Ye)

Applied to main (d129414) with git am --3way, all 17 apply cleanly.
Per-commit build with -Dwerror=3Dtrue passes for every patch.

Series summary
--------------

This mixes bug fixes, new hardware (SP560), new features, and a
rewrite of both data paths. Several real fixes are buried inside
feature patches and need to move to the front with Fixes tags:

  - duplicate TAILQ_REMOVE in hinic3_flow_destroy() (09)
  - VXLAN VNI spec written into key_mask (09)
  - NULL deref of hwdev->dev_handle in set_vport_enable (06)
  - secondary process never got dev_ops (14)
  - HINIC3_DEV_ID_VF_SP230 changed 0x3750 -> 0x022a (10)

No documentation beyond release notes. hinic3.rst needs SP560 and
the new devargs; features/hinic3.ini needs FEC, Burst mode info and
the new rte_flow items (geneve, vxlan_gpe).

Patch 09 uses nic_type (HINIC3_IS_SP230_NIC) but nic_type is only
set in patch 10. Put the NIC type detection first.

Several new tunables (rx_empty_loop, tx_free_loop) make the burst
functions spin. rx_burst/tx_burst must return immediately; spinning
on empty CQ or full SQ is the application's choice, not the PMD's.

Errors
------

[01/17] net/hinic3: fix offload and cmdq/compact CQE config

QINQ_STRIP and QINQ_INSERT are advertised but not implemented.
Nothing in hinic3_tx.c reads vlan_tci_outer and nothing in Rx sets
RTE_MBUF_F_RX_QINQ_STRIPPED. Adding HINIC3_PKT_TX_QINQ_PKT to
HINIC3_TX_OFFLOAD_MASK only routes the packet down the offload path;
the outer tag is never inserted. Drop both capabilities.

VXLAN_TNL_TSO is now advertised unconditionally, but
hinic3_tx_offload_pkt_prepare() returns -EINVAL for VXLAN packets
when !HINIC3_SUPPORT_VXLAN_OFFLOAD(). Gate it like the others:

  if (HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev))
      info->tx_offload_capa |=3D RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO;

in hinic3_dev_tnl_tso_support().

[02/17] net/hinic3: add CIR drop statistics and VF LAG support

hinic3_cmd_vf_lag() returns uint8_t but computes
  bitmap[func_id / 32] & (1ULL << (func_id % 32))
Bits 8..31 are truncated to 0, and the caller compares "=3D=3D 1", so
only func_id % 32 =3D=3D 0 ever matches. Return a bool:

  return !!(vf_lag_info.vf_lag_bitmap.vf_bit_map[func_id / 32] &
            RTE_BIT32(func_id % 32));

and test the result as a boolean in hinic3_tx_queue_setup().

get_port_cir_drop() never sets xstats[i].id.

hinic3_xstats_calc_num() now adds HINIC3_PHYPORT_XSTATS_NUM for VF,
but hinic3_dev_xstats_get() and _get_names() still return before the
phy port stats for VF. Count and returned entries disagree. Remove
HINIC3_PHYPORT_XSTATS_NUM from the VF branch.

[09/17] net/hinic3: refactor flow rule parsing

On SP620, HINIC3_FLOW_KIND_IPINIP is parsed by
hinic3_flow_parse_fdir_filter(). That parser has no tunnel state:
the inner IPV4/IPV6 item overwrites the outer key and tunnel_type
stays NORMAL. The installed rule matches the inner addresses against
the outer header of non-tunnel traffic. Reject IPIP on SP620 until
it is parsed by the tunnel parser.

hinic3_flow_parse_action() now uses the last non-VOID action and
ignores the rest. MARK/QUEUE, COUNT/QUEUE or DROP/QUEUE are accepted
and silently become QUEUE. Require exactly one action:

  for (act =3D actions; act->type !=3D END; act++) {
      if (act->type =3D=3D VOID)
          continue;
      if (found) return rte_flow_error_set(..., "Only one action");
      found =3D act;
  }

[10/17] net/hinic3: add SP560 NIC type identification and handling

hinic3_func_init() reads rq_wqe_type from
/sys/module/hinic{3,5}/parameters and fails probe with -EINVAL if
it is not there. With the device bound to vfio-pci the kernel driver
is normally not loaded, so probe fails. A PMD must not take device
configuration from another driver's module parameter. Use firmware
feature bits (RX_HW/SW_COMPACT_CQE are already there) and the
rx_cqe_compact_en devarg from patch 11; drop hinic3_read_module_param.

hinic3_cmdq_get_ops() caches the result in a function static. The
first probed device decides the ops for every device in the process;
SP230 (HTN) plus SP620 in one system gets the wrong command format.
Remove the cache:

  return cmdq_ops[nic_dev->nic_type];

[11/17] net/hinic3: add device kvargs parameters support

hinic3_nic_common_config_get() runs after hinic3_func_init(). On a
parse error hinic3_dev_init() returns without undoing func_init, so
hwdev, interrupts and queues leak. Parse devargs first, before any
allocation.

[12/17] net/hinic3: add compact CQE Rx path and ptype table

hinic3_init_rx_ptype_table() is called from hinic3_func_init(),
before hinic3_dev_init() parses devargs and calls
hinic3_nic_feature_init(). config.rx_cqe_compact_en is still 0, so
the normal-CQE table is always built and
hinic3_recv_pkts_compact_cqe() indexes it with compact ptype values.
Build the table after hinic3_nic_feature_init().

A table allocation failure is only logged; both Rx paths then
dereference a NULL ptype_tbl. Fail probe instead.

[13/17] net/hinic3: expand TSO from 127 to 255 segments

wqe_info->last_cpy_mbuf_usable is set only in the overflow branch of
hinic3_is_tso_sge_valid() and never cleared. wqe_info is declared
once per burst, so every later packet that goes through the copy path
has its last copy mbuf truncated. Clear it with sge_cnt and
cpy_mbuf_cnt in hinic3_get_tx_offload():

  wqe_info->last_cpy_mbuf_usable =3D 0;

When the payload after the first 28 segments exceeds 227 * 4K, the
copy path cuts the last copy mbuf to header + N * MSS and reports the
packet as sent. The tail of the TCP payload is lost without any
error. Treat this as invalid (return false) and count it.

[16/17] net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops

STN prepare_rq_ctxt_ceq_and_prefetch() sets pi_paddr_hi/lo to
rq_ci_paddr for compact RQs, then hinic3_rq_prepare_ctxt()
unconditionally overwrites both with pi_dma_addr after the call.
Either the assignment is needed and compact RQ context is wrong, or
it is dead code. Skip the pi_dma_addr assignment for
HINIC3_COMPACT_RQ_WQE, or call the op last.

[17/17] net/hinic3: add mbox count telemetry support

hinic3_telemetry_info() walks every valid ethdev port and casts its
dev_private to struct hinic3_nic_dev. Any other PMD in the process
gets its private data dereferenced as hinic3. Check the driver
before touching dev_private.

struct mbox_cnt_info is (32 + 16) * 4112, about 197KB, on the stack
of the telemetry thread. Do not build an array at all; add each
port to the dict as it is visited.

Better: drop the private telemetry endpoint and report the mbox
counters as xstats, or implement eth_dev_ops.eth_dev_priv_dump
(rte_eth_dev_priv_dump) which exists for this; the mbox history dump
from patch 04 belongs there too.

Warnings
--------

[03/17] "Fec param is valid, failed to set fec param." should say
invalid. nic_dev->fec_mode is written and never read.
hwdev->speed is only updated on link up, so fec_get_capability
reports a stale speed after link down.

[04/17] "mbox_header =3D *((uint64_t *)data)" is an unaligned,
aliasing read of a uint8_t array. Use memcpy().

[05/17] cos_mask comes from firmware (uint8_t) and indexes
cos_map[HINIC3_COS_NUM_MAX]. Bound it:
  txq->cos =3D nic_dev->cos_map[txq->cos & (HINIC3_COS_NUM_MAX - 1)
                              & nic_dev->cos_mask];
The removal of the HTN cos limit and of "% HINIC3_COS_NUM_MAX_HTN"
for VF is not explained in the commit message.

[06/17] link_status and vf_valid_status are now bitfields in one
byte. link_status is written by the LSC interrupt thread and
vf_valid_status by the control thread; the read-modify-write loses
updates. Use two plain uint8_t.

hinic3_dev_set_link_up() on VF returns -EAGAIN when the PF carrier
is down. set_link_up is the admin state; carrier down is reported
through link_update, not as an error.

[09/17] Patch 09 depends on nic_type from patch 10; at this commit
SP230 gets the STN TCAM limit (2048). Reorder.

GENEVE and VXLAN_GPE specs are cast to rte_flow_item_vxlan. The VNI
offset happens to match, but masks on the other fields (geneve
protocol and option length, gpe protocol) are silently ignored.
Use the proper item types and reject unsupported mask fields.

hinic3_flow_query() returns 0 without filling hits/bytes and does
not check the action is COUNT; it only logs the rule at INFO. Remove
.query until COUNT is supported.

[10/17] The SP230 VF device ID change (0x3750 -> 0x022a) drops
support for the old ID. Separate fix patch with an explanation.

[11/17] No RTE_PMD_REGISTER_PARAM_STRING() for the new devargs and
no documentation. strtol() result is not checked for trailing
garbage and negative values go into unsigned fields.

Defaults change without mention: Rx CQE coalesce 63 -> 7, timer
15 -> 8, Tx CI pending limit 3 -> 2, coalescing time 16 -> 2.

In a secondary process hinic3_dev_init() re-parses devargs into the
shared nic_dev->config, overwriting the primary's settings. Skip it
when not primary.

At this commit rx_cqe_compact_en defaults to 1 with no capability
check (added in patch 12), so vport enable requests compact CQE on
hardware without support.

[12/17] rx_empty_loop makes hinic3_recv_pkts() spin re-reading the
same CQE. Drop the devarg.

Non-ASCII characters in C comments ("VXLAN =E3=80=81NVGRE ..."). Use ASCII.

[14/17] Many unrelated changes: secondary process dev_ops, SP230 VF
software stats, CIR drop SP620 gating, cos_map SP230 gating,
DEFAULT_DRV_FEATURE bit 27 (RX_SW_COMPACT_CQE), queue state reset in
dev_stop, txq depth check, tx_burst_mode_get, new xstats. Split.

tx_free_loop (default 1000) makes both xmit functions spin on a full
SQ. Reclaim once and return the short count.

Both xmit functions break out of the burst when
hinic3_get_tx_offload() fails. A bad packet then blocks the queue
forever since the application retries it. Free it, count it, and
continue.

[15/17] Pseudo-header checksums are computed inside tx_burst by
writing into packet headers. That is what .tx_pkt_prepare is for
(rte_net_intel_cksum_prepare() plus the IPv6 extension walk). As
written it modifies data of shared/indirect mbufs and assumes all
headers are in the first segment.

Outer IPv4 UDP checksum is only written if the application left it
nonzero. RTE_MBUF_F_TX_OUTER_UDP_CKSUM means compute it.

Info
----

[03/17] HINIC3_FEC_MODE_* equal RTE_ETH_FEC_MODE_CAPA_MASK() values;
use the ethdev macros. Pass NULL, not 0, for the unused pointer.
Typo "covert".

[04/17] Storing the constant PCI address in every mbox record is
redundant. Dumping all AEQ entries at ERR on each timeout floods
the log.

[08/17] rss_type is saved even when hinic3_set_rss_type() fails.
Compact CQE sets the RSS hash flag on every packet whenever any RSS
type is configured.

[09/17] vlan_flag is no longer set in the TCAM key, so rules now
match tagged traffic as well. Mention it in the commit message.

[12/17] On SP230 the Rx interrupt vectors are set up even when
intr_conf.rxq is 0; not explained. dev_supported_ptypes_get misses
L2_ETHER, L4_FRAG, L4_ICMP that the table produces.

[13/17] Comment says "SP230 is 9600, SP560/620 is 4K"; the code
uses 65536 for SP230 and 9600 otherwise.

[14/17] tx_burst_mode_get stores txmode.offloads in uint16_t and does
not say which Tx function (compact or normal) is active, which is
the useful part. rte_eth_dev_attach_secondary() in func_init is
redundant; probe already attached. "rte_prefetch0(++tx_pkts)"
prefetches the array slot, not the mbuf.

Leftovers:
  is_sp230_pci_dev() declared, never defined
  HINIC3_MAX_QUEUE_DEPTH defined in both hinic3_ethdev.h and .c
  HINIC3_QUEUE_STAT_CNTRS, HINIC3_RSS_QUEUE_BUF, IPV4_VERSION,
  IPV6_VERSION unused
  struct hinic3_tx_offload_info unused
  txq->tx_free_loop set, never read
  service_cap.port_cos_valid_bitmap unused
  hinic3_ethertype_filter.flags never set
