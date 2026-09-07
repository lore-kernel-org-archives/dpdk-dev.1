Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E99C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 21:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACDBD40655;
	Mon,  7 Sep 2026 23:22:16 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 6282C402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 23:22:15 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso4699160a91.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788816134;
 x=1789420934; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mDGqKXkDPFiF3o3cpH0Ur5nyLAXx3dhaOm9+7qdV4yk=;
 b=QbychKXtZhdgSgsKYIwCBFJhqwItP1JB4Ik/a4C5wAwAHN/0wB2YEQ2u8wSCyj9lp0
 8bvnoEXTl/Phmuh5BCAdXNt7Nw2H2vs9weGCJWzes80HtVhadBVOGywm1fIiKtNnAoA0
 oqHe4/QROV+M44xBln2Ic9YVMGN+D2hw1RGvsgxOfeJcea7xxGccbE00vsUL0bmYkL1T
 RJi5kA0zowsZTGrqcDZXCPvKe4haehRSCy3Y1vz+OuAOLCToo05BDeGgzms8VJVq6+Yt
 8yONy8fdGVG8JusIhqz7CC4+1I7wyAmBxBT5cHwJMp2ZVWuUavqRIJm66jWgE7G65ALx
 OG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788816134; x=1789420934;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mDGqKXkDPFiF3o3cpH0Ur5nyLAXx3dhaOm9+7qdV4yk=;
 b=PNKSdVLBFptNcWDRXWoHvXHrQXY5fJlZdk9Gq3W0MnMLhgwDAhGUdGdg0jZVvdMcU3
 I/4rhnN0GFA/09qj/HxT+vcMNOpjAor2FICkHtebXN/m5ZnG8CAqnXXU/DoqwmflMGaD
 GC1V8S3nlps24032gZNcznUS/TJwYZXgJv+w6qMsoeqs1rCkNfar3o2MwQioezYLy0V/
 MvOydR6MvO7r/HFpNSMlLLoM+Fm8khXhsoWZxi9r1yMZcKNBDIeSKDLomGHS/QCQdOvQ
 tanDNmt/xjk935HyfIvNoibizQVbMFoD6z536YkJbIt+V1OhUAdp9jB1Qo8lfrDhImGr
 K5cg==
X-Gm-Message-State: AFuF++kr/L3RRcwO81U+ALLcqbAeYhYhhSoTlzXetaKTeqf968G3AcaY
 kj0p4sbU/JVSo3qpWl6wsMzkIziBp/15LZVtVfDrM1t4jsrq06MIACNkXsCh6GgBN5E=
X-Gm-Gg: AYBFou2xAgy566sE7nCU2pcxlKxfHxVHpTUas2iTau34LmxhSftM1l0B2SqjgLWfRkM
 T5U8qavyAHC7QiOIsUNw3LUaI8rHy9jQQ/jam17mN4r5aqz5kSV0Dm6vd7vo/OOZtmuTzFWp7Zr
 h7oQBCkD/HBIrL654Jmri2WbUU/wMU85j521pKzHknD1jzj+XUU2gvm6+nmXFqLbMW4xV+QFNge
 LOtbJHfn6J3UTgDIQ4mueD741aotlshHRR0h57x7ODfu7qoxi2+1LG5H5zZflKsKN9l1htt54Fd
 zkwk1tnPZAJyk+uICQYuAHCkqODOCzkWht2Xe59YC/SXqaWDTt9geFlGG+hBop2ZjyFc1PsE+/J
 lSk6auHbR4mERWJZZXnfrVwI9az9Gt2ZD6aN8PBMoTmMWz6DpBCOqzqqSi6qIXbYde4Ib7tjbI+
 sJ9BDw5ZGiNeoLmInd2q2oJEtnLbdorhFgozTxyCq1PBtuJmLHgNsflkNne0YZ+7qMLbw3hIxOO
 wbT7r6AEn5XGBxrl5PNvKIJr1DdkRGlnW1ZTncFQw==
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39b2624c32bmr2848591a91.21.1788816134039; 
 Mon, 07 Sep 2026 14:22:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc090sm28478770a91.4.2026.09.07.14.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:22:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:22:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/45] net/dpaa2: features and fixes for NXP DPAA2 drivers
Message-ID: <20260907142205.6aac2f99@phoenix.local>
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

On Thu,  3 Sep 2026 19:23:08 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series brings the NXP DPAA2 driver stack up to date with the
> functionality carried in the NXP internal tree, together with a number of
> bug fixes. It covers the crypto (dpaa2_sec), net, dma, mempool, event and
> bus/fslmc drivers.
> 
> Fixes first, then features, so the bug fixes can be picked independently of
> the larger reworks.

AI found errors in last set:

DPAA2 series review (bundle 2096), patches 32-45 of 45
Base: upstream main d55ccd4; series applied with git am --3way.
Findings for 32 supersede the partial entry in the 21-32 review.

Patch 32: drivers: rework dpaa2 Tx confirmation

Error: priv->tx_sg_pool is never assigned. The patch adds the field
to struct dpaa2_dev_priv and reads it in dpaa2_dev_tx_mbuf_to_sg_fd():

	sg_mbuf = NULL;
	if (priv->tx_sg_pool)
		sg_mbuf = rte_pktmbuf_alloc(priv->tx_sg_pool);
	if (!sg_mbuf) {
		DPAA2_PMD_DP_DEBUG("No memory to allocate S/G table");
		return -ENOMEM;
	}

but dpaa2_tx_sg_pool_init() only sets the file-scope global
dpaa2_tx_sg_pool, and a grep of the final tree finds no store to the
priv member. priv is zero-allocated, so every multi-segment Tx whose
head mbuf cannot host the SG table in its own headroom (any non-hw-pool
head, any indirect head, or too little headroom) fails with -ENOMEM.
The old code used dpaa2_tx_sg_pool directly.

Error: Per-packet failures free the application's mbuf and then
report it as not sent. In dpaa2_dev_tx_mbuf_to_simple_fd():

	} else {
		copy_mbuf = dpaa2_dev_mbuf_copy_one_seg(mbuf, hw_mp);
		if (!copy_mbuf) {
			ret = -ENOMEM;
			goto quit;
		}
		DPAA2_MBUF_TO_CONTIG_FD(copy_mbuf, fd, mempool_to_bpid(hw_mp));
quit:
		rte_pktmbuf_free(mbuf);
	}

and in dpaa2_dev_tx():

	ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
		dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
	...
	if (ret)
		goto send_n_return;

send_n_return enqueues fd_arr[0..loop-1] and returns that count, so the
packet at index loop is excluded from the return value after the driver
has already freed it; the application retries it and double-frees. The
same happens in dpaa2_dev_tx_multi_txq_ordered() via send_frames. The
cloned-mbuf branch just above it has the same shape: the indirect mbuf
is re-initialised and freed before the copy is attempted. And
dpaa2_dev_tx_no_conf_mbuf_to_sge() can return -ENOMEM part way through
a chain after it has already replaced earlier segments, relinked
prev->next, and decremented refcounts on segments with refcnt > 1;
that mutated chain is then handed back to the application as unsent,
and the sg_mbuf taken from tx_sg_pool in the caller is leaked. A
per-packet failure must either drop the packet (free it, count it in
err_pkts, continue) or leave it untouched and return short; doing both
is a double free.

Error: The DQRR held-buffer bitmap update regresses a 64-bit shift:

	DPAA2_PER_LCORE_DQRR_HELD &= ~(1 << dqrr_index);

The line this replaces was ~(UINT64_C(1) << dqrr_index), and the other
three sites in the file still use UINT64_C(1). dqrr_held is uint64_t
and dqrr_index reaches 31 on LX2160A (DPAA2_LX2_DQRR_RING_SIZE is 32,
and patch 41 raises the event port dequeue depth to that), so
1 << 31 is int, sign-extends, and the ~ clears bits 0..30 of the upper
word as well.

Warning: New devargs drv_tx_dyn_conf and drv_tx_dyn_conf_pre are
added and drv_tx_conf now means "absolute confirmation", but
doc/guides/nics/dpaa2.rst, which documents drv_tx_conf, is untouched.

Warning: dpaa2_eth_fd_to_mbuf() and dpaa2_eth_sg_fd_to_mbuf() are
annotated __rte_internal in dpaa2_ethdev.h. That attribute is for
symbols exported with RTE_EXPORT_INTERNAL_SYMBOL; these are used only
inside the net driver.

Info: dpaa2_dev_tx_conf() releases a head mbuf with refcnt > 1 by
rte_mbuf_refcnt_update(m, -1) instead of rte_pktmbuf_free(m), so the
tail segments of such a chain are never walked. rte_pktmbuf_free()
handles each segment's refcount itself; the special case is not
needed.

Patch 33: net/dpaa2: ptp enhancements

Error: Two exported experimental APIs are deleted without deprecation
and without removing their declarations. The definitions of
rte_pmd_dpaa2_set_one_step_ts() and rte_pmd_dpaa2_get_one_step_ts()
(both RTE_EXPORT_EXPERIMENTAL_SYMBOL, 24.11) are removed from
dpaa2_ethdev.c and not re-added anywhere; the prototypes remain in the
installed header rte_pmd_dpaa2.h, so any consumer now fails at link
time. Either keep the symbols (wrapping the new
dpaa2_timesync_set_one_step()) or remove the prototypes and add a
"Removed Items" release note.

Warning: getenv("DPAA2_IEEE1588_DEBUG_ENABLE") in
dpaa2_timesync_enable(); use a devargs or log level.

Patch 35: net/dpaa2: update MC dpni QoS and flow steering API

Warning: The existing callers are switched to newer MC command
versions with no version gate. DPNI_CMDID_ADD_FS_ENT becomes
DPNI_CMD_V3, DPNI_CMDID_SET_QOS_TBL becomes DPNI_CMD_V3 and
DPNI_CMDID_SET_RX_TC_POLICING becomes DPNI_CMD_V2, and the flow code at
this point still calls dpni_add_fs_entry() and dpni_set_qos_table()
unconditionally, so on an MC that predates those command versions
every existing flow rule fails. The commit message says behaviour is
unchanged. Patch 37 adds the priv->mc_rev gating
(DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV etc.); it belongs in this
patch, next to the version bump.

Patch 36: net/dpaa2: enhance xstat implementation

Error: dpaa2_dev_xstats_get_by_id() does not bound the number of MAC
counters it collects:

	uint64_t *mac_val[DPAA2_MAC_XSTAT_MAX_NUM];
	...
	for (i = 0; i < n; i++) {
		...
		if (id >= DPAA2_MAC_XSTATS_START_ID) {
			values[i] = 0;
			if (dpaa2_dev_mac_xstats_avail(dev)) {
				mac_idx[mac_num] = rte_cpu_to_le_32(id - DPAA2_MAC_XSTATS_START_ID);
				mac_val[mac_num] = &values[i];
				mac_num++;
			}

ids[] is application-supplied and may repeat an id, so n MAC ids
overflow mac_val[] on the stack and the fixed-size
cnt_idx_dma_mem / cnt_values_dma_mem buffers. Check
mac_num < DPAA2_MAC_XSTAT_MAX_NUM before the stores.

Warning: dpaa2_dev_xstats_get_names() returns limit when limit is
smaller than the count:

	if (limit < stat_cnt)
		stat_cnt = limit;

The eth_xstats_get_names_t contract is to return the number of
available xstats when xstats_names is NULL or size is too small, so
the caller can resize. Same in dpaa2_dev_xstats_get() when n is
smaller than the count.

Warning: rte_memcpy() of the string-pointer table
(dpaa2_xstats_strings) on the control path in both get_names
functions; memcpy, or index the struct directly.

Patch 37: net/dpaa2: rework flow engine

Warning: The QoS/FS group-type machinery is unreachable upstream:

	#ifndef RTE_DPAA2_FLOW_GROUP_TYPE_GET
	#define RTE_DPAA2_FLOW_GROUP_TYPE_GET(group) \
		((void)(group), RTE_DPAA2_ONE_LEVEL_GROUP_FLOW)
	#endif

Nothing in the tree defines the real macros, so
RTE_DPAA2_QOS_GROUP_FLOW / RTE_DPAA2_FS_GROUP_FLOW and every branch
keyed on them in dpaa2_flow_create() are dead code kept alive for an
out-of-tree header. Either define the encoding in rte_pmd_dpaa2.h and
document it, or drop the group-type paths.

Warning: getenv("DPAA2_FLOW_CONTROL_LOG") is kept (now read on every
rte_flow_create()); use the log level.

Warning: dpaa2_flow.c goes from 1 to 13 rte_memcpy() calls, all on
the flow-create control path (e.g. rte_memcpy(&local_attr, attr,
sizeof(struct rte_flow_attr))); use memcpy.

Warning: No doc/guides/nics/features/dpaa2.ini update for the new
meter_mark action, and no dpaa2.rst description of the group
encoding, meter flows, or the MC-version-dependent behaviour.

Patch 38: net/dpaa2: support Rx mempool per traffic class

Error: The pool-to-TC association is programmed with the TC index
where the MC expects a bitmask:

	bpool_cfg->pools[bp_idx].priority_mask = tc_id;

fsl_dpni.h documents pools.priority as "Priority mask that indicates
TC's used with this buffer. If set to 0x00 MC will assume value 0xff".
With tc_id: TC0 gets mask 0 (= all TCs), TC1 gets 0x01 (= TC0), TC2
gets 0x02 (= TC1), and so on, so the isolation the commit describes
does not happen and TC0's pool is shared by everyone. Use
RTE_BIT32(tc_id).

Patch 39: drivers: consume dpaa2 DQRR entries in batches

Error: The consume vector cannot represent an LX2160A DQRR. The
patch's own comment says the vector occupies DCAP bits 16..31, i.e.
16 index bits, and the code does:

	s->dqrr.ci_vector |= RTE_BIT32(idx + DQRR_DCAP_CI_VEC_OFFSET);

with ci_vector a uint32_t. DPAA2_LX2_DQRR_RING_SIZE is 32, so idx is
0..31 and idx + 16 is 16..47; for idx >= 16 that is a shift of 32 or
more, undefined behaviour, and the entry is never consumed. Either the
register is wider than the comment says, or vector mode must only be
enabled when dqrr_size <= 16 (with the threshold derived accordingly).

Patch 42: net/dpaa2: read MC version from device private data

Info: This only replaces the DPAA2_DEV_PRIV_TO_DPAA2_DEV() accessor
that patch 37 introduced five patches earlier; fold it into 37.

Patch 44: bus/fslmc: reduce probe-time logging and MC traffic

Info: The duplicated mc_get_soc_version() call this removes was
added by patch 27 in the same series; fold it into 27.

Review-Result: ERROR
