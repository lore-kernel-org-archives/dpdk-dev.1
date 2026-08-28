Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C83C61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 16:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E0EF4025A;
	Fri, 28 Aug 2026 18:49:45 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id DC93A40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 18:49:43 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso1135541a12.1
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787935783;
 x=1788540583; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SFGviVhUrrvXmwDVfhq6a9tO218mPivRxH1pnACFqJI=;
 b=ifOOxjsTnQG+eKWifYiNMJVUfZde2jZMTjlQ4TA3ci7VaMHE0huKxoRhUnfoM/gnmT
 Y19nODGO2RprbbRzmCcmWEqcmtLtVpNwpsBIfqoHl9p2+H6vhYX+EIlQ4ccqawuYMBcq
 QHxkMtFmfiJfDix7GYM9bVmzbHhza73MiTJyZ2oXmPZr5NZdT7QLlW8YnTuZq5awIy8+
 iVtoR6tv8UFkickDJVzqkNYRXUn+6DEkmvlF8U+/tg2Z1ek8zuG5GEg2iPSuvBn8Igv0
 Pi3JvBHnAA5m7TMfFq+afVfY2asoSrAnYLCcXxKgbepGgMow4WCiA1A6YNQcYNql9HUc
 NkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787935783; x=1788540583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SFGviVhUrrvXmwDVfhq6a9tO218mPivRxH1pnACFqJI=;
 b=apCJ1RF/Loq9Gx6RuZ7TBQcRzlXzjOvBJvx7t8B2Q1dMs4Ml6cVlxzImvEdFVTQ7QG
 ensdNa1/hlCrv8G5eKU6DBvF/draeGIF+5cZNUOMyCbYJZKr9O48w+PRgPwoUai7G0vg
 m7DoXXhH0bBTPAZ9zv/xCd+ohJYnwtgvajoWvj1Mesqq/CoD3H15u//KlSzck3eJOeZh
 65qEIWY88GYkt9lb3ksdKWsRjligvBp7Nt/T90ehuJeCRddmP5jm/PnFuyt0Z5q/BHh5
 tdazT3LCPp2FNdPJNkgdC4hfGINqI2Osl2JTo8FSXC2K2pOITUbx8RNikZ7WYIIQlbBi
 5e6w==
X-Gm-Message-State: AFuF++nFm8iGPCjotuSHnDPtOdcdboxn+iXumrXyBZ//Dfvd29gwwsQ+
 4Jsh3wh+C0trxv6hnhUWCUy7D9T4cASr7kyhVRI0qbecieUzVy8ePc8MCsg4nbkkJTOmoO+0VFQ
 gx7Wn
X-Gm-Gg: AR+sD12A2Up9G585mQHDUJKY2j6Txg2sOayLMelnnu51hNFQz/sVWXaVm2DSfJeNiD3
 RJnnH8WqTtBTKOUhJerBDAThmVjxU7JeofRNzFmhjgE/Uvsis953Egf9DIB6HWCRxdjDngKhAh2
 /afoEEynqthXLH3BJM6Zu68ugAOvHwZAiulOtjkf9i9EcyzdcqNidUxGsyJnVzQnH1gv0+tcaty
 DjLrBjLVQU64GVx4q2CxXYjSqVcF35NSXfwtA2kIsmDC+t5iJAaNmHX8lftGgFTG4VFC8ny28xj
 yRYfW+qai7vuCTgR68qTFseVnLPZL3sTT6EWgdl/hgnT9FYcWDwCDn0Bz0sOVEkGh+ZxoA+JH2N
 vRSbIRID6/FHd7b3cE7Z4c2rj8NGRQ7RiECc5JZ20k93EOZ11oAwZovwkaXaHdoTWxSL62Qh746
 isRWym2gzwyn2kbrkM4uR7AVPi9J87N3CYJnu3ZruhplkPhJn48C2Dpah5P+B5//oHKvLunN8sd
 +eoYVGrMBts+ILV10Vivyue0qHSBg==
X-Received: by 2002:a17:90b:164b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-396d0e27d7amr15762017a91.2.1787935782334; 
 Fri, 28 Aug 2026 09:49:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b19927a1sm8417979a91.14.2026.08.28.09.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 09:49:42 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:49:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/45] net/sxe2: update SXE2 poll mode driver
Message-ID: <20260828094934.732c2524@phoenix.local>
In-Reply-To: <20260828073633.2247387-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
 <20260828073633.2247387-1-liujie5@linkdatatechnology.com>
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

On Fri, 28 Aug 2026 15:36:33 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous versions and re-aligning the driver with the reference
> implementation.

Looking good, AI review is mostly happy (with Claude Opus).
But still a couple of nits worth resolving in commit messages.


Review of v6 sxe2 series (45 patches)
=====================================

Series applies cleanly on current main.  All findings below were
verified against the post-apply tree rather than the diffs alone.

All v5 findings are resolved in code: the dead IPsec key-length
hunk is gone (10/45), the representor nb_ports==0 case is handled
(23/45), sxe2_vsi_destroy() now unlinks DPDK_ESW nodes (6/45), the
ineffective queue-count assignments are dropped (14/45), and the
duplicate unconditional RSS_HASH is gone (15/45).  Two of those
patches still carry commit messages describing the old code; see
below.


Patch 14/45: fill MAC and queue counts in device info
-----------------------------------------------------

Warning: the commit message no longer matches the patch.  It says
"Fill max_mac_addrs, nb_rx_queues and nb_tx_queues ... so
applications can query the maximum number of MAC addresses and the
queue counts", but the diff now adds only max_mac_addrs.  Please
retitle and rewrite the body to describe just that.


Patch 15/45: fix QinQ and RSS offload capability report
--------------------------------------------------------

Warning: same problem.  The body still says "Advertise
RTE_ETH_RX_OFFLOAD_RSS_HASH unconditionally", but the code keeps
the capability-gated form:

	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_RSS_HASH;

which is the correct behaviour.  Drop that sentence.


Patch 6/45: fix VSI lifecycle management
-----------------------------------------

Info: with sxe2_vsi_destroy() now doing the unlink, the test left
in sxe2_vsi_node_free() is dead:

	if (vsi->vsi_type == SXE2_VSI_T_ESW)
		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);

Both sites that insert into other_vsi_list use SXE2_VSI_T_DPDK_ESW
(sxe2_vsi.c:193 and :218), so SXE2_VSI_T_ESW never appears on that
list.  Every caller of sxe2_vsi_node_free() passes a node that is
not linked.  Because this now sits next to the almost-identical
DPDK_ESW test in sxe2_vsi_destroy(), a reader will take it for the
list-removal path and the two can drift.  Suggest deleting it.


Patch 26/45: add ACL engine event statistics support
-----------------------------------------------------

Warning: the two new command structures are byte-for-byte copies of
the existing fnav ones:

	struct sxe2_drv_acl_query_stat_req
		{ stat_id, stat_ctrl, is_clear }
	struct sxe2_drv_flow_fnav_query_stat_req
		{ stat_id, stat_ctrl, is_clear }

and likewise for _resp.  The same patch already reuses
sxe2_drv_flow_fnav_get_stat_id_req and
sxe2_drv_flow_fnav_free_stat_id_req for the ACL alloc and free
commands, so the query path is the odd one out.  Either reuse the
fnav structs throughout or add ACL variants throughout; as written
it adds command-ABI surface for no benefit.

Info: sxe2_flow_get_filter_cid() silently succeeds on an unknown
engine type.  The new prologue does

	} else {
		goto l_end;
	}

with ret still 0, jumping past the SXE2_FLOW_ACTION_COUNT block.  A
flow carrying a COUNT action then returns success without
stat_index ever being set.  sxe2_flow_free_mgr() and
sxe2_flow_query_mgr() both return -ENOTSUP in the same situation;
this one should too.

Info: the FNAV and ACL arms added to RTE_FLOW_ACTION_TYPE_COUNT in
sxe2_flow_parse_action() are identical apart from which
hw_res.global_index is incremented.  Picking the resource struct
first and sharing one body would halve it.


Patch 27/45: guard Rx queue event FD free in unregister
--------------------------------------------------------

Warning: this does not fix a bug.  rte_free(NULL) is a documented
no-op, so the pre-patch code was already safe when
rxq_event_fd was NULL; moving the call inside the existing
"if (irq_ctxt->rxq_event_fd)" guard changes nothing observable.
The commit message claims "the buffer is only released when it was
allocated", which was already true.  Please drop the Fixes: and
Cc: stable@dpdk.org tags, or drop the patch.


Patch 29/45: refactor Tx queue reset operations
------------------------------------------------

Info: sxe2_tx_vec_ops_get() builds and returns a three-pointer
struct by value on every call.  The scalar side already uses the
simpler form:

	const struct sxe2_txq_ops sxe2_default_txq_ops = { ... };

A file-scope "static const struct sxe2_txq_ops sxe2_tx_vec_ops"
plus "txq->ops = sxe2_tx_vec_ops;" would match it and keep the
table in .rodata.

Info: sxe2_tx_queues_vec_prepare() still returns 0 on every path,
so the caller's

	ret = sxe2_tx_queues_vec_prepare(dev);
	if (ret != 0)
		tx_mode_flags &= ~SXE2_TX_MODE_VEC_SET_MASK;

is dead.  Either make the NULL-txq case an error or make the
function void.


Patch 30/45: unify vectorized Tx buffer handling
--------------------------------------------------

The core fix is real and worth having: the old
sxe2_tx_queue_mbufs_release_vec() left "buffer" unassigned on the
AVX512 branch and then dereferenced it in the trailing loop, and it
also contained a duplicated "buffer = txq->buffer_ring;".  Both go
away with the union.

Warning: the patch is far wider than its commit message, and all of
it is going to stable.  Beyond the buffer_ring/buffer_ring_vec
unification it also:

  - deletes sxe2_tx_bufs_free_vec_avx512(), which implemented the
    RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE bulk path with
    _mm512_loadu_si512 into the mempool cache.  AVX512 Tx now uses
    the generic sxe2_tx_bufs_free_vec().  That is a performance
    regression, not a fix.
  - adds sxe2_tx_desc_fill_4_neon_simple(), a new four-wide
    descriptor fill using vst1q_u64_x4 and uint64x2x4_t.  This is a
    new optimisation.  (The descriptor words it produces do match
    sxe2_tx_desc_fill_one_neon() with with_offloads=false, and the
    "i + 3 < n" bounds are correct.)
  - changes the Rx packet_type lane mapping in
    sxe2_rx_desc_ptype_fill_neon() from
    pkt0/1/2/3 <- lane 5/1/7/3 to lane 1/3/5/7, and switches the
    input from staterr to desc_lo with a different mask.
  - removes three of the four rte_atomic_thread_fence(acquire)
    calls between descriptor loads in
    sxe2_rx_pkts_common_vec_neon().

The last two are Rx correctness and memory-ordering changes in the
fast path and are not mentioned anywhere in the commit message.
Please split: the union fix (with the Fixes:/stable tags) in one
patch, the NEON Tx optimisation in another, and the NEON Rx ptype
and fence changes in a third with their own justification.  If the
AVX512 fast-free removal is intentional, say so and why.


Patch 36/45: use primary VSI ID for representor VSI
-----------------------------------------------------

Error: this drops the guard against an invalid kernel VSI.

	-	repr_priv_data->repr_vf_vsi_id =
	-		...kernel_vsi_id != SXE2_INVALID_VSI_ID ?
	-		...kernel_vsi_id : ...dpdk_vsi_id;
	+	repr_priv_data->repr_vf_vsi_id =
	+		repr_priv_data->repr_vf_primary_vsi_id;

repr_vf_primary_vsi_id is kernel_vsi_id, so repr_vf_vsi_id can now
hold SXE2_INVALID_VSI_ID.  No consumer tests for it:

  sxe2_txrx_poll.c:506  (repr_vf_vsi_id & 0x3FFULL) is written
                        straight into a Tx descriptor field
  sxe2_flow.c:317       flow->meta.flow_src_vsi = repr_vf_vsi_id
  sxe2_flow_parse_action.c:240
                        *vsi_index = repr_vf_vsi_id

kernel_vsi_id is genuinely optional -- sxe2_vsi_uninit() tests
"kernel_vsi_id != SXE2_INVALID_VSI_ID" before using it -- and the
ternary being removed is direct evidence the author expected the
invalid case.  repr_vf_backup_vsi_id (the dpdk_vsi_id) is still
stored and still used at sxe2_flow.c:383, so the backup ID has not
become redundant.

"Matching the V3 implementation" is not sufficient justification
here.  Either keep the fallback, or explain why kernel_vsi_id is
guaranteed valid for a representor and drop repr_vf_backup_vsi_id
too.


Patch 37/45: wrap command params fill debug log in macro
----------------------------------------------------------

Warning: __adapter is a reserved identifier.  C11 7.1.3 reserves
all identifiers beginning with two underscores for the
implementation, in every scope.  Rename it, e.g.

	do { \
		struct sxe2_adapter *_ad = (adapter); \
		PMD_DEV_LOG_DEBUG(_ad, DRV, "cmd opcode:%s", #opc); \
		__sxe2_drv_cmd_params_fill(_ad, cmd, opc, ...); \
	} while (0)


Patch 41/45: fix command channel log messages
-----------------------------------------------

Info: one of the replacements is less accurate than what it
replaces.  sxe2_drv_queue_info_get_update() issues
SXE2_DRV_CMD_TX_RX_MAP_GET and fills both q_ipackets/q_ibytes and
q_opackets/q_obytes, but the message became

	PMD_LOG_ERR(DRV, "rx queue mapping failed, ret=%d", ret);

The old "get queue info map failed" covered both directions.
Something like "tx/rx queue map get failed" would be better.

Warning: this is a pure log-wording patch tagged Fixes: and
Cc: stable@dpdk.org.  Log text corrections do not warrant a stable
backport; please drop those tags.


Patch 42/45: align command structs with historical kernel layout
-----------------------------------------------------------------

Error: sxe2_tm_res changes size, which changes the payload length
of four live firmware commands.  I compiled the before and after
definitions to be sure:

	sxe2_drv_link_info_resp    8 -> 8    (unchanged)
	sxe2_tm_res                4 -> 2    (CHANGED)
	sxe2_tm_info              12 -> 12   (unchanged)
	sxe2_tm_add_mid_msg       16 -> 16   (info still at offset 3)
	sxe2_tm_add_queue_msg     20 -> 20   (info still at offset 5)

sizeof(struct sxe2_tm_res) is passed directly as the command in/out
length at four call sites in sxe2_cmd_chnl.c:

	1226  SCHED_ROOT_TREE_ALLOC          out_len 4 -> 2
	1250  SCHED_ROOT_TREE_RELEASE        in_len  4 -> 2
	1292  (sxe2_drv_tm_commit_node)
	1354  SCHED_ROOT_CHILDREN_DELETE     in_len  4 -> 2

The commit message says "Keep the structure members as-is so the
command ABI is compatible with the historical kernel driver", which
contradicts what the patch does to this one structure.  Either the
message is wrong and the length change is the intended fix -- in
which case say so explicitly, since it is the only behavioural
change in the patch -- or sxe2_tm_res should keep its rsv[2] and
__rte_aligned(4).

For the record, the other four structures are genuinely no-ops.
Removing rsv[3] from sxe2_drv_link_info_resp does not shrink it,
because __rte_aligned(4) still rounds 5 bytes up to 8; the padding
is merely implicit now, which for a wire format is a readability
step backwards.  The sfp structures keep the same offsets and sizes
without the packed attribute.

Positive note: dropping __rte_aligned(4) from sxe2_tm_info removes
two -Wpacked-not-aligned warnings, since info sits at offset 3 and
5 inside the packed message structures.  That is worth mentioning
in the commit message, as it is the clearest benefit of the patch.


Verified clean
--------------

1-5, 7-13, 16-25, 28, 31-35, 38-40, 43-45.

Some of these I checked specifically rather than by inspection:

  31/45  rte_eth_tx_pkt_prepare_dummy is in ethdev_driver.h and is
         the right thing for a PMD to install;
         SXE2_DEFAULT_RX_FREE_THRESH (32) matches the
         default_rxconf advertised in dev_info.  The ARM64 fallback
         fix is correct -- the old else branch installed
         sxe2_tx_pkts_vec_neon_simple when NEON was not detected.
  33/45  sxe2_udp_tunnel_port_clear() returning -ENOTSUP for
         representors is harmless; its only caller discards the
         result with a (void) cast.
  35/45  the bounds check is placed before the first
         repr_vf_id[repr_id] dereference.
  44/45  drv-sw-stats is genuinely absent from the code -- not in
         RTE_PMD_REGISTER_PARAM_STRING, no parse callback -- and
         the sw_stats counters really are updated on every packet,
         so the reworded xstats section matches the code.

Things I checked and found not to be problems, in case they come up
again: the memset in sxe2_tx_queue_reset_vec() is in bounds, since
the buffer ring is always allocated at the larger
sizeof(struct sxe2_tx_buffer) stride regardless of mode;
mbuf_free_arr[64] cannot overflow because sxe2_tx_vec_support_check()
rejects rs_thresh > SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC before vector
mode is selected; and sxe2_tx_queues_vec_prepare() is reached only
on the RTE_PROC_PRIMARY path from sxe2_dev_start(), after
sxe2_queues_init() and before the queues are started, so the new
queue_reset() call cannot disturb a running datapath.

