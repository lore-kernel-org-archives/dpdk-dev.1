Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A760A2611
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QzbGS64k
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D065D40274;
	Mon,  2 Nov 2026 08:48:45 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 4ECD44003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:48:44 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2794441f8f.2
 for <dev@dpdk.org>; Sun, 01 Nov 2026 23:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793605724;
 x=1794210524; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a5Xzsy6QiIw8SnSvTdsJvPa2ARmot+gr1curetNosSU=;
 b=QzbGS64kmh4iV2RPsT7UJNI0W3FgXoRlW+3HyH+5Z2O+qSOo2oCZrNavjZf/m7YMN+
 Z9itwdFJvWjhjNr2rXretMw+f2Wh4di/216XY9+Am0p6TkDaGUaF6w9njlYVl4Xyi8fh
 ytl+Dz5tpAFstY2812ogng6battOlXjz4BJfpCXtUTzd1qbBxasOn8f14EtLzK5V3AKs
 TpLR9P4GMpuM2rvqv4WZkfAXoqOF0mb2MHNdlMhgZCblpruUG+ZD7w+fAwgJN7gEvW34
 Ly0Xb/STJRcVFTAQQVho1n/P0WDGGHlZQhTHlN/BWcnnO2FQ7Kl2kJjpRS1vR0cDc0IY
 C8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793605724; x=1794210524;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a5Xzsy6QiIw8SnSvTdsJvPa2ARmot+gr1curetNosSU=;
 b=bkoBwnsZO0l1TkzO3jgaba6sf/kG0KZdMrKRnmwTi+IeEK8mT7xx0zA3SMUNLNYuYd
 YfAyTem3WLTgjguV+UbdTNlwHbwHjJxsqgm0jX0EGjuptBVFOJxJsvVkXp4H1a95LK2a
 ZjUTrq7j9UUhvjAx7mrUZESzFi+vRfXLwamXVhDgauAAMdFgNNveLQQIE/aivJPvASWp
 LG45xARsXZ8bFzt9+NG4W20AU5ZDkjVaab0AtWW9y33HQwYNtsdBYUGTyV6KDIlyyvRc
 g9HrVq/Qr9RoseQgT6v+Gsh0Oi0J+5RKz9QgUTkrkggqQAIfcx7URyVgEODsQdChmdH3
 g2Dw==
X-Gm-Message-State: AFq9FYL79xADIszRJ4JFs3CPIUv4Y3jsxB0jR6QsTrjRc0iAT0XLa6Lg
 iallA9bBTMZjuVQ6pfj1ZiwAmFNTBHAWAcy2L+m6StrlJoGvdtUN3ZoXP1XQw0A03jA=
X-Gm-Gg: AYBFou0Xh97UG0a4g1iwhsP5hAMfs487OCnJ4qt4sWdY3S39Gf2L2hyUYqZO68aeMqP
 sjo7MIaNLFZ8qnXZz2gNX4NCszkAlNZ3wsCZV2bpHZPMMlJry2EsEFHofS9ODjeDopbAslbnMZr
 9NtpVu4UhMZLvhz1wmR2ODt09tP5aXeckUIARunyrE5zrqFS0O/1oIQTX5mWm7wlMo1sNnQsv/h
 rf8L+G3v+vf3vL4JMuVtrusZwGoMwHj+78b2GrNsSOrtrJYPZD8rVWnmbW/KqIIIc3QhmuKKsCv
 mkhZcLpiuv5+LoBvQl8nYj16U5yY8Zz2ERNnZDFDl9L9vJVfGmvphAXX/zG7V4U/4ENmE+Hpho+
 wsuhSnEUzriqneaKfdU7YVBt/wCjRDkE3+Ea5y4NtZ6be8Xvy+sXsbSWNPc/FOwRoo24+OW4+LI
 esxiN5m010lECcyznlIuguFIMvXd3qiysLMigvQlzdtNqYGEx7K3dF1/EavxQoVQnrTV6qZfl21
 pzHdjp6V3IkXp/rbwWHySUJ+v/UyYrZv+FYvlhka8l2LzdugwCcRukuRQrsoYLNg4btfu7AIKO2
 QFiycj5nLUVvf3NvPqh7QOEK7y9tBoT+EW29bh/dmkO6eC3Jxo7LVFMZDwEuEs+ErBuC57AJMXZ
 RnhuwvaxGVhuXs6qP/AGC+zu20OD7UnxTvGCV
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4ac182dc0a1mr227397435e9.16.1793605723671; 
 Sun, 01 Nov 2026 23:48:43 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a1dsm17594559f8f.24.2026.11.01.23.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:48:43 -0800 (PST)
Date: Mon, 2 Nov 2026 08:48:41 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v5 00/28] net/hinic3: add PMD features and fixes
Message-ID: <20261102084841.0389bef8@stephen-xps.local>
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 22:47:04 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> Thanks to Stephen Hemminger for the review. The review comments are addressed
> in this version, and the changes are listed below.
> 
> v5:

Lots of open items from AI review

Subject: Re: [PATCH v5 00/28] net/hinic3: fixes and new features

Applies to main (release notes conflict aside) and every commit builds
with -Dwerror=true. The v4 items are addressed: tx_pkt_prepare is
installed in 09, and the SP560 CEQ EN bit is explained.

There is still no cover letter or changelog. Please add one; at 28
patches it is hard to see what changed between versions.


Errors
======

[PATCH 18/28] net/hinic3: update RSS hash type configuration

nic_dev->rss_type is set, but never cleared:

	cqe_info->rss_type = (rxq->nic_dev->rss_type.val != 0) ? 1 : 0;

hinic3_remove_rxtx_configure() sets rss_state to DISABLE and leaves
rss_type alone, and so does the init_rss_fail path. After stop and
reconfigure without RSS (mq_mode NONE, or a single queue), the compact
CQE path still sets RTE_MBUF_F_RX_RSS_HASH on every mbuf, with a
garbage hash. Clear rss_type.val wherever rss_state goes to DISABLE.
Better, cache an rss_en flag in struct hinic3_rxq at queue start, so
the fast path does not dereference nic_dev for every packet.


[PATCH 19/28] net/hinic3: refactor flow rule parsing

The new IP-in-IP pattern accepts an outer IPv6 with an inner L3:

	case RTE_FLOW_ITEM_TYPE_IPV4:
	case RTE_FLOW_ITEM_TYPE_IPV6:
		/* Ip-in-ip: a second L3 with an optional L4 (or ANY). */
		hinic3_flow_take(item, next);

The parser then sets outer_ip_type = IPV6 and ip_type = IPV4/IPV6.
hinic3_fdir_tcam_ipv6_vxlan_init() programs addresses only when
ip_type == HINIC3_FDIR_IP_TYPE_ANY, so the rule is accepted with no
address match and steers all IPv6 IP-in-IP traffic. classify_inner()
already rejects outer IPv6 plus inner L3 for this reason. Do the same
here:

	case RTE_FLOW_ITEM_TYPE_IPV4:
	case RTE_FLOW_ITEM_TYPE_IPV6:
		if (ip_type == RTE_FLOW_ITEM_TYPE_IPV6)
			return HINIC3_FLOW_KIND_INVALID;
		hinic3_flow_take(item, next);


[PATCH 24/28] net/hinic3: expand TSO from 127 to 255 segments

A Tx WQEBB is 16 bytes, one per SGE, so a 255-SGE TSO packet needs
wqebb_cnt = sge_cnt + 1 = 256. hinic3_get_sq_free_wqebbs() never
returns more than q_depth - 1, and setup accepts depths 128 and 256.
On those rings the packet never fits: the burst hits

	if (wqe_info.wqebb_cnt > free_wqebb_cnt) {
		txq->txq_stats.tx_busy += (nb_pkts - nb_tx);
		goto end;

every time, and the queue stalls at that packet forever. Before this
patch only depth 128 was affected. In hinic3_get_tx_offload(), reject
(free and count) a packet whose WQEBB count exceeds q_depth - 1, or
raise the Tx minimum depth to 512 in both setup and tx_desc_lim. Also
set tx_desc_lim.nb_seg_max and nb_mtu_seg_max.


Warnings
========

[PATCH 03/28] net/hinic3: fix TCAM index leak on ethertype flow set

Wrong Fixes tag. efa3b9b36fc7 has no TCAM allocation in
hinic3_set_fdir_ethertype_filter(); that came with b2d4933b80ec,
which first shipped in 26.03. Not in 25.11, so drop Cc: stable.

	Fixes: b2d4933b80ec ("net/hinic3: support htn FDIR for new SPx series NIC")


[PATCH 05/28] net/hinic3: fix vport enable null dereference

Same problem. The nic_dev dereference in hinic3_set_vport_enable() was
added by 9204b6b7bb1a (26.03), not de490215f74a. Drop Cc: stable.

	Fixes: 9204b6b7bb1a ("net/hinic3: split new/old command queue operations")

The new check cannot fire: hinic3_func_init() sets hwdev->dev_handle
right after allocating hwdev, before any vport command.

	nic_dev = hwdev->dev_handle;
	if (!nic_dev)
		return -EINVAL;

The real fix is moving the dereference below the hwdev check. Drop
the nic_dev check and fix the commit message.


[PATCH 09/28] net/hinic3: fix pseudo-header checksum calculation

hinic3_prep_pkts() writes headers through rte_pktmbuf_mtod_offset()
without checking that they are in the first segment. A multi-segment
mbuf with split headers gets an out-of-bounds write. Do what
rte_net_intel_cksum_flags_prepare() does:

	if (unlikely(rte_pktmbuf_data_len(mbuf) <
		     inner_l3_offset + mbuf->l3_len + mbuf->l4_len)) {
		rte_errno = ENOTSUP;
		return i;
	}

The shared mbuf check is too broad:

	if (unlikely(rte_mbuf_refcnt_read(mbuf) > 1 || RTE_MBUF_CLONED(mbuf))) {

HINIC3_TX_OFFLOAD_MASK includes VLAN and IP checksum, which write
nothing. A cloned mbuf asking only for VLAN insert now fails
tx_prepare on SP620, which breaks flooding and multicast. Do the check
only when ol_flags has HINIC3_PKT_TX_L4_MASK, HINIC3_PKT_TX_TCP_SEG or
HINIC3_PKT_TX_OUTER_UDP_CKSUM.

The patch also starts advertising RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM.
That is a new capability in a stable-tagged fix, and the commit
message does not mention it. Move it to its own patch and add "Outer
L3 checksum" and "Outer L4 checksum" to hinic3.ini.


[PATCH 10/28] net/hinic3: add SP230 Rx queue interrupt handling

The comment and commit message say the SP230 vectors are masked:

	if (HINIC3_IS_SP230_NIC(nic_dev))
		return hinic3_sp230_mask_rxq_msix(dev);

hinic3_sp230_mask_rxq_msix() only calls hinic3_init_rxq_msix_attr(),
which sets pending limit, coalesce timer and resend timer. Nothing
calls hinic3_set_msix_state(..., HINIC3_MSIX_DISABLE) or sets the
auto-mask state. Either mask the vectors, or rename the function and
fix the text to say coalescing only.


[PATCH 13/28] net/hinic3: add FEC mode get/set and capability support

	if (num < HINIC3_FEC_CAPA_NUM_PER_SPEED) {
		...
		return -EINVAL;

rte_eth_fec_get_capability() requires a too-small array to return the
needed count, not an error. Return HINIC3_FEC_CAPA_NUM_PER_SPEED.

When firmware reports HINIC3_PORT_FEC_NOT_SET, fec_get returns 0,
which is not a valid mode mask. Since set rejects AUTO, once a mode is
forced the user can't go back to the default. Map NOT_SET to and from
RTE_ETH_FEC_MODE_CAPA_MASK(AUTO), and accept AUTO in
hinic3_fec_param_valid().

The get/set helpers do not check out_size, unlike the rest of the mgmt
helpers in that file:

	if (fec_msg.head.status != 0 || err) {

Use "if (err || !out_size || fec_msg.head.status)".


[PATCH 14/28] net/hinic3: add mbox message recording and debug dump

eth_dev_priv_dump is also registered for secondary processes, for
example dpdk-proc-info --show-port-private, but the dump does

	pci_dev = hwdev->pci_dev;

hwdev is in shared memory, but pci_dev points into the primary's heap,
so a secondary reads a bad pointer. Pass RTE_ETH_DEV_TO_PCI(dev) down
from hinic3_eth_dev_priv_dump().


[PATCH 15/28] net/hinic3: add COS mask and COS map support

The patch drops the existing COS clamps, and the commit message does
not say so:

	-	*cos_id = vf_dcb.state.default_cos % HINIC3_COS_NUM_MAX_HTN;
	+	*cos_id = vf_dcb.state.default_cos;

The PF HTN limit of 4 is removed as well. cos_map is only applied on
SP230, so SP620 VFs can now get COS 4-7. Keep the clamp on paths that
don't use cos_map, or explain in the commit message why it is safe.


[PATCH 16/28] net/hinic3: add VF link state and promiscuous support

dev_set_link_down only disables the vport. The next PF link-up event
goes through hinic3_set_vport_state(), which re-enables the vport
whenever HINIC3_DEV_START is set:

	if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status))
		err = hinic3_set_vport_enable(hwdev, true);

That sets vf_valid_status back to 1 and reports the link up again, so
an administrative link down does not stick. Keep a separate admin-down
flag, set only by set_link_up/down, and check it in
hinic3_set_vport_state() and in the link status calculation.


[PATCH 19/28] net/hinic3: refactor flow rule parsing

The commit message says IPv4 and VXLAN keys no longer set the
vlan_flag mask. The lines removed were duplicates.
hinic3_fdir_tcam_notunnel_init() and
hinic3_fdir_tcam_vxlan_geneve_init() still do

	tcam_key->key_mask.vlan_flag = 1;

so those rules still match only untagged packets. Fix the commit
message, or the code if the change was intended.


[PATCH 20/28] net/hinic3: add SP560 NIC type identification and
  handling

The new HTN ops change the SP230 queue context values. Before this
patch, SP230 used the common values: drop OFF 0, prefetch 1/6/256, no
PFH_TH. Now it gets:

	#define HINIC3_DEFAULT_DROP_THD_OFF	0xFFFF
	#define SQ_PREFETCH_MAX			5
	#define SQ_PREFETCH_MIN			4
	#define SQ_PREFETCH_THRESHOLD		48
	...
	#define RQ_PFH_TH			7

The commit message only talks about SP560. Either keep the old SP230
values, or put the change in a separate patch with the reason.


[PATCH 23/28] net/hinic3: ensure queue depth and state consistency

The depth cache is cleared only in dev_configure:

	nic_dev->rxq_depth = 0;
	nic_dev->txq_depth = 0;

ethdev allows queue setup again while stopped, without reconfigure.
testpmd "port config all rxd 2048" does this. Queue 0 then fails with
-EINVAL against the stale depth. Instead of the cache, compare against
q_depth of the other non-NULL dev->data->{rx,tx}_queues[].

dev_stop marks queues STOPPED in ethdev but leaves txq->status at
START. A deferred-start queue started at runtime keeps transmitting
after stop/start, and rte_eth_dev_tx_queue_stop() then returns early
without calling the driver. Call HINIC3_SET_TXQ_STOPPED() in the same
loop.


[PATCH 24/28], [PATCH 25/28] Tx path logging

These are new per-packet logs in the Tx path, at WARNING and ERR:

	PMD_DRV_LOG(WARNING, "illegal pkt, payload offset (%u) > data len (%u).",
	PMD_DRV_LOG(WARNING, "TSO payload over hardware limit.");
	PMD_DRV_LOG(ERR, "IPinIP not support TSO");
	PMD_DRV_LOG(ERR, "VXLAN_GPE not support TSO");

A bad packet stream floods the log, and the drops are already counted
in offload_errors. Remove them, or use a rate-limited data path log.


[PATCH 25/28] net/hinic3: split Tx burst function for compact CQE
  support

hinic3_mbuf_dma_map_sge() is shared by both bursts and does this for
every segment:

	if (txq->nic_dev->nic_type == NIC_SP620)
		wqe_desc->queue_info = 0;

In the compact burst, a single-WQEBB WQE keeps its task in
hdr->queue_info, and hinic3_set_tx_offload_compact_cqe() has already
written it. On an SP620 that reports NIC_F_TX_WQE_COMPACT_TASK, the
checksum and VLAN offload are wiped. The commit message says the burst
is chosen by feature bit, not NIC model, so this check is inconsistent.
Do the zeroing in hinic3_xmit_pkts() only, for SQ_WQE_COMPACT_TYPE,
once per packet.

The compact burst declares wqe_info once per burst:

	struct hinic3_wqe_info wqe_info = { 0 };

hinic3_set_tx_offload_compact_cqe() sets vlan_valid, tso, mss and
payload_offset but never clears them. A VLAN or TSO packet leaks
those values into later packets in the same burst, for example a
plain checksum packet sent as TSO with a stale MSS. The old combined
burst had the same bug, and the normal path is fixed here, but the new
compact path copies it. Clear wqe_info.offload_info and
wqe_info.queue_info for each packet.


[PATCH 27/28] net/hinic3: add Tx burst mode get

	(nic_dev->config.rx_cqe_compact_en == HINIC3_RX_CQE_COMPACT_EN) ?
		"compact CQE" : "scalar",

Tx burst selection uses HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(), not the
Rx compact CQE setting, so this can name the wrong function. Use

	dev->tx_pkt_burst == hinic3_xmit_pkts_compact_cqe


Info
====

[PATCH 09/28] Tunnel type is an enumerated field, not a bitmask:

	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) == HINIC3_PKT_TX_TUNNEL_IPIP) {

This also matches GTP (0x7) and other values. Use
(ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) == HINIC3_PKT_TX_TUNNEL_IPIP.
The VXLAN and GENEVE support tests have the same problem.

[PATCH 11/28] The tunnel TSO gating fixed here came from c1537bf6c033
("net/hinic3: support Compact CQE in init"). Add a second Fixes tag.

[PATCH 12/28] rx_discard_phy is counted and named on every NIC type
but only filled in on SP620, so SP230/SP560 show a counter that is
always 0. Use the same HINIC3_IS_SP620_NIC() condition in calc_num,
get_names and get.

[PATCH 21/28] rx_cqe_coalesce_num and rx_cqe_timer_loop only take
effect with HW compact CQE. hinic3.rst should say so.

[PATCH 22/28] HINIC3_RX_COMPACT_L3_L4_CSUM_ERROR goes to the default
case and keeps value 1, which is HINIC3_RX_CSUM_IP_CSUM_ERR. A bad
L4 checksum is then reported as RTE_MBUF_F_RX_IP_CKSUM_BAD. Also,
the ptype table produces RTE_PTYPE_INNER_L4_FRAG, _ICMP and _ESP,
which are missing from dev_supported_ptypes_get.

[PATCH 25/28] rte_prefetch0(tx_pkts[0]) runs before the loop, so with
nb_pkts == 0 it reads past the array.

Pre-existing, not introduced by this series:
- hinic3_dev_stats_get() does
	dev->data->rx_mbuf_alloc_failed += rxq->rxq_stats.rx_nombuf;
  on every call, so rx_nombuf grows each time stats are read.
- hinic3_start_rq()/hinic3_stop_rq() call hinic3_set_vport_enable(),
  a blocking mgmt message, while holding the queue_list_lock spinlock.
