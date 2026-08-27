Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B671C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8CD040150;
	Thu, 27 Aug 2026 17:14:21 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 8AF704003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:14:20 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-396b3d0df94so70187a91.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787843659;
 x=1788448459; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E75WPD84Qhe3i0RV/k7hWr0OpRerHGOzIjUJzC0b0g0=;
 b=vCMsRKHN/YCXe/tEPiwjjrIs5mJVk7Cl+7td340EphE++YZgyWEjF0vYv9ezVZVq3W
 AVMVt5vB35w5PVVvFZlepQuogHT9ZeI5L9iyPf2cIX0AlPsjM0efO1DOIk9xwtGEU0dx
 pm/z4BbT4fHZwNrfQ7wBeEn3iIurZvZEmhLBYIw82NChDR+eOTNY8qt+EdtNXgmM9JKi
 UQlD9B17GwuesycRVhpDlRLIxAa6pubUpKlJmn2jYKdIine73mLO50TcJfVPwu1LBi9t
 PEtPF96IaIJe25Kf9mixFXzyAobCq4RqMP+UZMMgqQqKXP6oQ3sHVIzszbw5PFP9pegD
 JiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787843659; x=1788448459;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E75WPD84Qhe3i0RV/k7hWr0OpRerHGOzIjUJzC0b0g0=;
 b=rb+uiaiALl5U9b6ABvwznWfr/ym7UTLV5Wh0sZJ88teO4qToEQmWWDF+bW7VK0dua6
 lU96fqAF1ryaQgMKaWMdLnxS7FqbQ0qYYK8347AKdNZb4GEhMvofFyFmKcTYdin+STne
 PKieh/CIWDIvTBMl/970W9ObMVB2t9UOoZxtEhlGk5n8p7BNqIy4rh+xvmEc6ZOL5D1s
 smwG/9m+slNIWtHpVspWeQQUcIwc0LpPbElWAu8CEtCG3zc5TS0TA62ZVMmAQQiMi3DS
 aH4RXMp3Q4HidBBTAftL5a2R2A8ECIECU+l8ajFZnYyULLM99X2fyntfj8CxcBUfRw7G
 YtkA==
X-Gm-Message-State: AFuF++n3E312QLqJSLHtt2e6nyMC6rPzycW83T68HlaV2u+Glwi8OuIJ
 Te9u/dOQiMm3u/I7+lK/Yd26zl/rdXxcyn82d1MdYoayxhsgAs5yR0Cb3nZHUbdf5FOF8ZeAIpd
 50bto
X-Gm-Gg: AR+sD11nV26DkR7NMPRsoly8CBSEvw0mlY2mQmUulV0ilxg5K7b3SnY5zCrGIekalQT
 KYJ1uzteILn2jBwgHqtTVLFZatkylr2WF/moIEukYqHssoRM5nAVEiyfc8lq33Ow+6Y1KRrQzFr
 +Jcs6Sk4maeOGgl+o6qx8Xo4EKVXOzZoEwsBYOucVZYUY2n8R67yquenACgu8fQ0OFx1jeEHaEQ
 9VX8HG4KaKFHDcn501y443wizLZvLAUlgs8xd0yXde0iwcnk4N3MGA0aLxyzPIgD/LwfwC0IAhm
 CNikPxuZtR3EoQfbGFFWFgfU1UJj0EzLopV87uaNzacM5sfriwyhA3AVdu3tRJg/kNOPrmZ+kuT
 ztjRChNV+C0lZFMKZZWtVcRDdD4XaHsUCjiG8BqaUR3Hbe8ie2fiQE9u3gOol0z++5sk0tQpR8v
 Drr7oguix32mq9FW2CmPVKNU2jN4La+64gNyxKDcfis3fakn0iZvMY354JprGW8pbwUn9EDd8zI
 ITwR9H8fDJf9NrBpOuLVArw0qbhW7syF3rifSuUAQ==
X-Received: by 2002:a17:90b:54cb:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-3966d5b7c62mr34270441a91.7.1787843659239; 
 Thu, 27 Aug 2026 08:14:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60b539sm18651470eec.1.2026.08.27.08.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 08:14:18 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:14:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/44] net/sxe2: add Stars SXE2 net driver with fixes
Message-ID: <20260827081410.0ea4d543@phoenix.local>
In-Reply-To: <20260827023618.1429644-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
 <20260827023618.1429644-1-liujie5@linkdatatechnology.com>
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

On Thu, 27 Aug 2026 10:36:18 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series adds the Stars SXE2 network driver together with a set of
> fixes accumulated while validating the driver against the historical
> kernel implementation and reviewing the code.
> 
> This is the v4 revision.

This is in much closer to being ready, AI still has some useful
feedback. You don't have to address all of it but it is informative
and helpful.

Review of [PATCH v4 00/44] net/sxe2 fixes and improvements

Reviewed against the series applied with git am on top of
d55ccd4 ("pci: remove deprecated catch-all flag").  Findings are
against the post-apply tree, not the diffs in isolation.  Patches
with no findings are omitted.


Patch 06/44 - net/sxe2: fix VSI lifecycle management

Warning: the patch fixes the dangling main_vsi pointer but leaves the
same problem on other_vsi_list.  sxe2_vsi_destroy() frees list members
with a bare rte_free() and never unlinks them.  The unlink lives in
sxe2_vsi_node_free(), which only fires for SXE2_VSI_T_ESW:

	if (vsi->vsi_type == SXE2_VSI_T_ESW)
		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);

but sxe2_other_vsi_create() inserts nodes as SXE2_VSI_T_DPDK_ESW, and
SXE2_VSI_T_ESW is never assigned anywhere in the driver.  So the
removal never happens, and after sxe2_vsi_uninit() the list head still
points at freed memory.  sxe2_switchdev_repr_private_data_init() reads
that head via TAILQ_FIRST().

Either add TAILQ_REMOVE() to sxe2_vsi_destroy() for list members, or
fix the type test in sxe2_vsi_node_free() to SXE2_VSI_T_DPDK_ESW.


Patch 10/44 - net/sxe2: validate IPsec key length against maximum limit

Error: the added check is dead code.  sxe2_security_valid_key() already
tests the same condition as its first statement in the base tree:

	static bool sxe2_security_valid_key(uint16_t src_key, ...)
	{
		bool is_valid = false;

		if (src_key > SXE2_IPSEC_MAX_KEY_LEN) {   <-- pre-existing
			is_valid = false;
			goto l_end;
		}
		...

The new copy is placed after the increment check, where src_key has
already been proven <= SXE2_IPSEC_MAX_KEY_LEN, so the branch can never
be taken.  The patch is a no-op and the buffer-overflow protection it
describes is already present.  Drop the patch.


Patch 14/44 - net/sxe2: fill MAC and queue counts in device info

Info: nb_rx_queues and nb_tx_queues are overwritten by ethdev
immediately after the PMD callback returns:

	lib/ethdev/rte_ethdev.c:4146
		dev_info->nb_rx_queues = dev->data->nb_rx_queues;
		dev_info->nb_tx_queues = dev->data->nb_tx_queues;

Those two lines have no effect.  max_mac_addrs is the useful part of
the patch; consider dropping the queue-count hunk and adjusting the
commit message.


Patch 15/44 - net/sxe2: fix QinQ and RSS offload capability report

Error: neither capability the patch claims to gate is actually gated.

RTE_ETH_TX_OFFLOAD_QINQ_INSERT is still in the unconditional
tx_offload_capa initialiser and is OR'd in again inside the port-VLAN
branch, so it is always advertised:

	dev_info->tx_offload_capa =
		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |     <-- still here
		...
	if (!sxe2_dev_port_vlan_check(dev)) {
		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;

RTE_ETH_RX_OFFLOAD_RSS_HASH is added unconditionally to the base list
and is still set under the capability test, which now cannot make any
difference:

	dev_info->rx_offload_capa = ... | RTE_ETH_RX_OFFLOAD_RSS_HASH;
	...
	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_RSS_HASH;

Advertising RSS_HASH when SXE2_DEV_CAPS_OFFLOAD_RSS is clear tells the
application the PMD can deliver an RSS hash on a device that has no RSS
capability.  Remove QINQ_INSERT from the base tx list, and pick one
place for RSS_HASH.

The RTE_ETH_RX_OFFLOAD_QINQ_STRIP hunk is correct - it is removed from
the base list and only added under the guard.


Patches 21/44 and 22/44 - dev close / dev init ordering

Warning: after both patches the two teardown paths still disagree on
switchdev, and dev_close does not follow reverse-init order for
fc_state.

	sxe2_dev_init() error unwind:
		sw_uninit -> eth_uinit -> switchdev_uninit -> vsi_uninit
	sxe2_dev_close():
		switchdev_uninit -> sw_uninit -> eth_uinit -> vsi_uninit

sxe2_fc_state_init() runs before sxe2_sched_init() in dev_init, so
reverse order puts sxe2_fc_state_uinit() right after sxe2_sched_uinit()
in close; it is currently the last call in the function.

Since 21/44 is specifically "align dev init and cleanup order", it
would be good to finish the job so the two paths are identical.


Patch 23/44 - net/sxe2: simplify switchdev representor matching

Error: this breaks the common representor devarg form.  The new PF
match loop is:

	for (port_idx = 0; port_idx < req_eth_da->nb_ports; ++port_idx)
		if (adapter->switchdev_info.pf_num ==
		    req_eth_da->ports[port_idx])
			break;
	if (port_idx == req_eth_da->nb_ports) {
		rte_errno = EBUSY;
		return false;
	}

rte_eth_devargs_parse_representor_ports() only fills eth_da->ports and
nb_ports when the devarg carries a "pf#" prefix (see
lib/ethdev/ethdev_private.c).  For "representor=vf0",
"representor=[0-3]" and the legacy bare-number form, nb_ports stays 0.
The loop body then never executes, port_idx == 0 == nb_ports, and the
function returns false.  sxe2_eth_pmd_probe_pf() turns that into
-ENOTSUP and no representor is ever created.

The old code read ports[0] (zero when unset), so it happened to work.
The fix needs to treat nb_ports == 0 as "no PF constraint given" and
skip the check.

Warning: the RTE_ETH_REPRESENTOR_PF case now falls through to the same
loop that matches representor_ports[] against repr_vf_id[i].func_id.
For a PF representor those entries are PF indices, not VF function IDs,
so the comparison is against the wrong table.  The driver only ever
creates VF representors (sxe2_switchdev_repr_devs_init() formats names
as "..._representor_vf%u"), so it may be simpler to reject
RTE_ETH_REPRESENTOR_PF outright.

Info: dead store.

	uint16_t port_idx = UINT16_MAX;

is unconditionally overwritten by the for loop initialiser on the next
use.  Drop the initialiser.


Patch 26/44 - net/sxe2: add ACL engine event statistics support

Warning: two unrelated changes are bundled in.

First, the act_count NULL guard is applied to the existing FNAV path,
not just the new ACL path:

	act_count = action->conf;
	flow->action.count.user_id = (act_count == NULL) ? 0 : act_count->id;

That is a NULL-dereference fix for RTE_FLOW_ACTION_TYPE_COUNT with a
NULL conf, and it belongs in its own patch with a Fixes: tag and
Cc: stable@dpdk.org.

Second, the sxe2_queue.c hunk

	if (adapter->flow_ctxt.fnav_inited)
		rxq->fnav_enable = true;

has nothing to do with ACL statistics and is not mentioned in the
commit message.

Info: widening sxe2_flow_cid_mgr.stat_index from uint16_t to uint32_t
fixes a real truncation on the existing FNAV path, since
sxe2_drv_flow_fnav_get_stat_id() returns a uint32_t stat id.  Worth
calling out in the commit message (or splitting out) rather than
folding it in silently.

Info: sxe2_drv_acl_query_stat_req and sxe2_drv_acl_query_stat_resp are
byte-for-byte identical to the existing
sxe2_drv_flow_fnav_query_stat_req and
sxe2_drv_flow_fnav_query_stat_resp.  Reuse the existing types, or
give them a neutral name shared by both engines.

Info: the FNAV and ACL arms in sxe2_flow_parse_action() are ten-line
copies of each other differing only in fnav_hw_res vs acl_hw_res.
Select the resource pointer first and share the body.


Patch 30/44 - net/sxe2: unify vectorized Tx buffer handling

Warning: the subject and commit message describe Tx buffer handling
only, but the patch also rewrites a large part of the NEON Rx data
path:

  - sxe2_rx_desc_ptype_fill_neon() changes signature, input vector and
    packet-to-lane mapping
  - the staterr construction changes from vzip2q_u32 on 32-bit lanes to
    vzip2q_u16 on 16-bit lanes
  - the DD count changes from rte_popcount64() of the DD bits to
    rte_ctz64() of the inverted mask, which changes the result when DD
    bits are not contiguous
  - the eop, umbcast and rxe shuffle masks and constants all change
  - three rte_atomic_thread_fence(rte_memory_order_acquire) calls
    between the descriptor loads are removed
  - the #ifndef SXE2_TEST guard around the whole AVX512 file is dropped

Several of these look like genuine fixes, and dropping the fences does
match what ixgbe's NEON path does, but none of it is described and none
of it can be reviewed as part of a Tx patch.  Please split the NEON Rx
work into its own patch (or patches) with its own rationale, especially
the fence removal and the DD-count change.

Info: sxe2_tx_desc_fill_4_neon_simple() uses vst1q_u64_x4(), which is
not used anywhere else in DPDK.  It is aarch64-only and needs a
reasonably recent toolchain; worth confirming against the oldest
supported ARM compilers.

Info:

	*(uint32_t *)umbcast_flags =
		vgetq_lane_u32(vreinterpretq_u32_u8(umbcast_bits), 0);

replaces vst1q_lane_u32().  The plain store through a cast pointer
assumes umbcast_flags is 4-byte aligned; the NEON store did not.  If
the alignment is not guaranteed, keep vst1q_lane_u32().


Patch 31/44 - net/sxe2: refine vectorized Tx/Rx mode setup

Warning: on arm64 the reworked NEON branch can leave tx_pkt_burst
unset.  sxe2_tx_vec_support_check() unconditionally sets

	*vec_flags = SXE2_TX_MODE_VEC_SIMPLE;

on success, and SXE2_TX_MODE_VEC_SIMPLE is part of
SXE2_TX_MODE_VEC_SET_MASK.  So tx_mode_flags can satisfy

	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)

without SXE2_TX_MODE_VEC_NEON being set, because NEON is only OR'd in
when rte_cpu_get_flag_enabled(RTE_CPUFLAG_NEON) == 1.  Before the
patch the else arm caught that case and installed
sxe2_tx_pkts_vec_neon_simple(); now the whole block is skipped,
tx_pkt_prepare is set to the dummy, and tx_pkt_burst keeps whatever it
had.  Restore a fallback for the non-NEON case, or make the x86 style
"else" explicit.

Info: the rx_free_thresh change is a separate bug fix.  With
rx_free_thresh == 0, sxe2_rx_queue_init() computes

	rxq->batch_alloc_trigger = rxq->rx_free_thresh - 1;

which underflows to 65535.  That deserves its own patch with a Fixes:
tag rather than being folded into a mode-setup patch.

Info: tx_mode_flags and rx_mode_flags are uint32_t, so "0x%016x" prints
a 32-bit value zero-padded to 16 digits.  "%#x" or "0x%08x" would be
clearer.


Patch 33/44 - net/sxe2: restore PF-only guard in udp tunnel port add

Warning: the guard is asymmetric.  sxe2_udp_tunnel_port_del_common()
and sxe2_udp_tunnel_port_clear() have no equivalent check, so a VF or
representor can still reach sxe2_drv_udp_tunnel_del() through
.udp_tunnel_port_del and through sxe2_dev_close().  Either add the same
guard there, or hoist it into the sxe2_udp_tunnel_port_add() /
sxe2_udp_tunnel_port_del() dev_ops wrappers where both paths pass
through.


Patch 34/44 - net/sxe2: restore link update call in status query

Warning: layering.  sxe2_drv_mac_link_status_get() is a command-channel
function in sxe2_cmd_chnl.c; it now indexes the global rte_eth_devices
array and calls the ethdev-level sxe2_link_update():

	struct rte_eth_dev *dev =
		&rte_eth_devices[adapter->dev_info.dev_data->port_id];
	...
	(void)sxe2_link_update(dev, 0);

The underlying problem is real - the LSC handler updates link_ctxt but
never pushes it into rte_eth_link, so callbacks fire with a stale
link - but the fix reads better in the two callers.  Calling
sxe2_link_update() from sxe2_event_irq_common_handler() (which already
has the rte_eth_dev) and from sxe2_link_update_init() keeps the command
layer free of ethdev side effects and avoids the global lookup.

Note also that the unconditional dereference of
adapter->dev_info.dev_data at the top of the function is reachable
after sxe2_dev_pci_map_uinit() sets that pointer to NULL (patch 19/44).

Info: the patch removes two unrelated blank lines in
sxe2_link_update_init().  Unnecessary churn in a fix patch.


Patch 37/44 - net/sxe2: wrap command params fill debug log in macro

Info: the commit message says "the debug log is executed
unconditionally on every command fill", implying the change avoids
that.  It does not - PMD_DEV_LOG_DEBUG is level-gated either way, and
moving it into the macro leaves the call frequency unchanged.  The
actual effect is that #opc is stringized at the call site and the
helper loses a parameter.  Please reword.

Info: adapter is now evaluated twice by the macro (once in the log,
once in the call).  All current callers pass a plain variable, so this
is latent, but it is worth a comment or an inline helper.


Patch 42/44 - net/sxe2: align command structs with historical kernel
               layout

Warning: sxe2_tm_res changes size from 4 to 2 bytes, and it is used as
both request and response buffer with sizeof():

	struct sxe2_tm_res tm_resp;
	sxe2_drv_cmd_params_fill(adapter, &param,
				 SXE2_DRV_CMD_SCHED_ROOT_TREE_ALLOC,
				 NULL, 0, &tm_resp, sizeof(tm_resp));

out_len for ROOT_TREE_ALLOC and for SCHED_TM_ADD_MID_NODE /
SCHED_TM_ADD_QUEUE_NODE drops from 4 to 2.  If the firmware still
writes the historical 4 bytes this overruns a stack object.  Please
confirm against the firmware side and say so in the commit message,
since this is the one hunk in the patch that changes anything
observable.

Note that tm_resp in sxe2_drv_root_tree_alloc() is the only one of the
four sxe2_tm_res objects left uninitialized; the other three use
"= {0}".  Worth making consistent while touching this.

Warning: the commit message lists

	- sxe2_tm_add_mid_msg: drop packed attribute
	- sxe2_tm_add_queue_msg: drop packed attribute

but the patch does not touch either struct.  Both still carry
__rte_aligned(4) __rte_packed_begin / __rte_packed_end in the applied
tree.  Drop those two bullets, or make the change.

Info: the sxe2_drv_link_info_resp, sxe2_tm_info, sxe2_drv_sfp_req and
sxe2_drv_sfp_resp hunks do not change any member offset or any struct
size.  For sxe2_drv_link_info_resp the retained __rte_aligned(4) pads
the size back to 8 after rsv[3] is removed; for the other three the
packed and unpacked layouts are already identical because every member
is naturally aligned.  Saying this in the commit message would make
clear that sxe2_tm_res is the only hunk that needs testing.


Patch 43/44 - common/sxe2: fix ioctl channel log and close handling

Info: the cmd_fd/bar_idx swap is fixed, but the remaining two
conversions are still mislabelled - "src=" prints the raw offset and
"offset=" prints SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset):

	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=%"PRIu64
		", src=0x%"PRIx64", offset=0x%"PRIx64"",
		cmd_fd, bar_idx, len, offset,
		SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));

"offset=" and "pci_offset=" would read correctly.


Patches with no findings: 01, 02, 03, 04, 05, 07, 08, 09, 11, 12, 13,
16, 17, 18, 19, 20, 24, 25, 27, 28, 29, 32, 35, 36, 38, 39, 40, 41, 44.
