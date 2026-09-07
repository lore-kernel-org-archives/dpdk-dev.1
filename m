Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD06C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 21:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AAB640655;
	Mon,  7 Sep 2026 23:03:39 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 20270402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 23:03:38 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db1ca06b03so1859045ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788815017;
 x=1789419817; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tlzCaH0uzMqeBE0cp8gieykLGDVEG5w1cHhanoc89AU=;
 b=IrTUxcNuegJoSIBHv7Q1Cd+P7HP/dbdu1dtOaEj7MXvCVW75oxJHt/+gymnD3wythz
 fSgcDu/N+I4UdMJmc7RLm+N+pJu1PZO63LEwkgwiWaDDBBmawVnFNrEpVBrK5OEneG6H
 oSXx1BvrF2Xk4TUGZL9XFYnkWoOhTtbvI7CdvoFZsttwB/Ee9yxlsTUpOVn45u55stQL
 DKqjnTcGsM6rA9HSfcQjmXwexBrwKF79s6wwcZuW8hRjrPL2BQp2+KqfxxvaKR424g5a
 lO2jcFXG/NRuKejncNtPAWPRVdIK8xm03n2vkquekxtaVwpLbamflwOQgUCBe5tz3dJm
 Yb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815017; x=1789419817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tlzCaH0uzMqeBE0cp8gieykLGDVEG5w1cHhanoc89AU=;
 b=Ne82L9T7s5+KhZw7+Sv3quOyutDIzcl3XS7LZWDH+HRvSXEM6Mkm3zj0rLDon/LEfW
 AHg+hyqdCD5UFPXX2uizUByjng+mCpLJymcgTH5ydel82bMzKtFFQtLm8zFJqG2ckpNx
 RByM4j/nRYuLCd0+qq9qTivNvi+kcTcU/DjwpGN8xE+Wa/eDMzDV7q+X5tISrmIJ0RWr
 wQC5ckTGhnS2lRgh/L35UZASSyJIp3IPQUuoCUZOLjorYViA2pGKn5VjlUpoXK7N61bT
 wr8Z3olqbKIB6pYpu7EnygXFKv9OoQVxS97xccaUS6oN0nYAKE6VpBDPUv4pvJkd7HKC
 QAeA==
X-Gm-Message-State: AFuF++kiMh/P137Mtzj5jxSkiEFW7Q7LvViYymuwClGUCvo6ae15NqOD
 mvGRIqyN0fJ47QAuxdy8N07/X66KJhDV/kj55mCYrA86u2ztRZxAjD0IUov/vDneRNs=
X-Gm-Gg: AYBFou16CfoyG+IpXu5ghdcI+j6/J5Ldyxr3dp1aTZyQg3rqH74V0yGPFsM+GScf3Nn
 4W78gmGHEDpynX6jqDt8ibn3jINR0foOaAWjc716UA4UFJvk64X3W4ocYvmvvrk99ZaZ66DXa3V
 QNt6MCbnC0aXWKJ3dg0CPFa2UPeQzHOz4XttQkFYdWDlQvOSuqibQ/7sz4AvNemrIHrcDuCyjUv
 DEjXWogh3GLPAXGDdBI7he5yCunRSGrKtWLeg/DkVtv4+f2/AlZ/sqwPIAxPeVh+gqPU3VXRwCm
 +Urs6TJM0lF1g1coDGdvFt/JKCxWgfEA/Ym9JwLBdnfl38khNmcCMRP+nZLg0O52yjU50jjbxv0
 r00Oy5/CsW8ud+pMcWVB3d9iTD+/FSHaupGJOn4Vzqa2lntkEWDLLwpeZyw5rUWd6D6F5h8qkq4
 R1rUz9vjPM4kOY0YCkBxfILLGWCCSQkXCf/SznjhR5HX51aDsUZVn/ROy/vd4aE/O93tBQBftSw
 +F6hGjBLm0WrCeZLooAlfNWj2s+ww==
X-Received: by 2002:a17:903:2a85:b0:2da:fa62:4aee with SMTP id
 d9443c01a7336-2db6fe6e66dmr29344675ad.1.1788815016720; 
 Mon, 07 Sep 2026 14:03:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1982c63fsm46628305ad.42.2026.09.07.14.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:03:36 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:03:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/45] net/dpaa2: features and fixes for NXP DPAA2 drivers
Message-ID: <20260907140327.2ccb55e6@phoenix.local>
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

And the errors caught by Fable continue in Patch 21-32

DPAA2 series review (bundle 2096), patches 9-20 of 45
Base: upstream main d55ccd4; series applied with git am --3way.

Patch 9: dma/dpaa2: fix array-bounds warning in dequeue path

Warning: The warning this patch fixes does not exist at this point
in the series. At patch 9, qdma_cntx_idx_ring_eq() is still the
per-element loop:

	for (i = 0; i < nb; i++) {
		ring->cntx_idx_ring[ring->tail] = elem[i];

and passing &idx with nb == 1 indexes elem[0] only. The
-Warray-bounds diagnostic comes from the rte_memcpy rewrite in
patch 12, which forms &elem[DPAA2_QDMA_MAX_DESC - ring->tail] on a
one-element object in the wrap-around branch. So this is not a fix
for 388e888dc082 and should not carry Fixes:/Cc: stable; it
belongs with patch 12.

The fix itself is heavy: DPAA2_QDMA_MAX_DESC is
((1 << 13) / 2) = 4096, so

	uint16_t idxs[DPAA2_QDMA_MAX_DESC];

adds 8 KB to every struct qdma_virt_queue and only idxs[0] is ever
written. Handle the single-index case in ring_eq instead, e.g.
compute first = RTE_MIN(nb, DPAA2_QDMA_MAX_DESC - ring->tail),
copy first elements, and only touch elem + first when nb > first,
which also gives the compiler a bound it can prove.

Patch 11: dma/dpaa2: validate IOVA in pre-populate helpers

Error: The new early returns leak the fle_pool element in
non-silent mode. In dpaa2_qdma_copy_sg():

	ret = rte_mempool_get(qdma_vq->fle_pool,
		(void **)&cntx_sg);
	...
	ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
	if (ret)
		return ret;

and in dpaa2_qdma_long_copy():

	ret = rte_mempool_get(qdma_vq->fle_pool,
		(void **)&fle_sdd);
	...
	ret = fle_sdd_pre_populate(fle_sdd,
		&qdma_vq->rbp,
		0, 0, QBMAN_FLE_WORD4_FMT_SBF);
	if (ret)
		return ret;

Neither path returns the context to the pool. Each failed enqueue
permanently consumes one fle_pool element. Add rte_mempool_put()
on the error path when !is_silent (the silent path uses the
pre-allocated cntx_sg[]/cntx_fle_sdd[] arrays and needs no free).

Patch 13: drivers: add dpaa2 DMA bypass memory translation option

Error: RTE_DPAAX_QDMA_BMT_FLAG is only partially honoured.

(a) In the pre-populate SG path the flag is applied once, when the
context is first initialised:

	if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
		ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq,
			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
			QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);

sg_entry_post_populate() never writes ctrl.bmt, so every later job
that picks this context out of fle_pool inherits whatever the first
job asked for, regardless of its own flags.

(b) The long-FD path ignores the flag entirely. Neither
fle_sdd_pre_populate() nor fle_populate() takes a bmt argument and
nothing sets fle->word4.bmt, so on a vchan with
using_short_fd == 0 (dpaa2_qdma_long_copy) the flag has no effect.
The commit message says the flag is propagated to all FD populate
helpers; it is not.

Warning: RTE_DPAAX_QDMA_BMT_FLAG is a new public API in an
installed header (drivers/common/dpaax/meson.build lists
rte_pmd_dpaax_qdma.h in headers) with no Doxygen comment, no
mention in doc/guides/dmadevs/dpaa2.rst, and no release note. It
also occupies bit 7, immediately below the RTE_DPAAX_QDMA index
bits at 8+, and immediately above the generic
RTE_DMA_OP_FLAG_* bits (0-3), so a future generic flag at bit 4-7
collides with it.

Patch 14: mempool/dpaa2: support ops index from primary in
secondary

Error: rte_dpaa2_mpool_get_ops_idx() returns the wrong value on
the first successful IPC round trip in a secondary:

	if (rsp_msg->msg_type == DPAA2_POOL_OPS_IDX_RSP) {
		rte_memcpy(&s_dpaa2_pool_ops_idx, rsp_msg->msg_data,
			sizeof(s_dpaa2_pool_ops_idx));
		ret = 0;
	} ...
	free(mp_reply.msgs);

	return ret;

It returns 0 instead of s_dpaa2_pool_ops_idx. Every caller compares
the result against mb_pool->ops_index (dpaa2_sec enqueue, net Tx),
so the first packet burst in a secondary process gets a false
mismatch and takes the MAX_BPID path. Return
s_dpaa2_pool_ops_idx on success.

Error: mp_req is an uninitialised stack struct:

	struct rte_mp_msg mp_req;
	...
	strlcpy(mp_req.name, DPAA2_POOL_MP_SYNC, sizeof(mp_req.name));
	req_msg->msg_type = DPAA2_POOL_OPS_IDX_REQ;
	...
	ret = rte_mp_request_sync(&mp_req, &mp_reply, &ts);

len_param and num_fds are never set. check_input() in
eal_common_proc.c rejects negative or oversized values, and
send_msg() attaches num_fds entries of fds[] as SCM_RIGHTS, so with
stack garbage the request either fails outright or sends random
descriptors. memset the request to zero and set
mp_req.len_param = sizeof(struct dpaa2_pool_mp_msg) +
sizeof(s_dpaa2_pool_ops_idx). The primary-side reply has the
matching problem: reply is zeroed but reply.len_param stays 0
while param carries the ops index.

Error: Resource leak on the new failure path in
rte_hw_mbuf_create_pool():

	ret = rte_mp_action_register(DPAA2_POOL_MP_SYNC,
		dpaa2_mbuf_pool_mp_primary);
	if (ret && rte_errno != ENOTSUP)
		return ret;

At this point bp_list and bp_info are allocated, the dpbp is
enabled and avail_dpbp is taken; every other failure in this
function uses goto err4. Replace the return with goto err4.
rte_mp_action_register() also returns -1 with the reason in
rte_errno, so the caller sees a bare -1; return -rte_errno.

Warning: rte_memcpy() for a 2-byte copy on the IPC control path
(both in the handler and in the requester); use memcpy().

Patch 16: drivers: optimize dpaa2 Tx queue and channel mapping

Error: The new capping logic is defeated by uint8_t truncation.
priv->nb_rx_queues and priv->nb_tx_queues are uint8_t, and
attr.num_rx_tcs, attr.num_tx_tcs and attr.num_queues are uint8_t:

	priv->nb_rx_queues = attr.num_rx_tcs * attr.num_queues;
	if (priv->nb_rx_queues > MAX_RX_QUEUES) {
	...
	priv->nb_tx_queues = attr.num_tx_tcs * attr.num_queues;
	if (priv->nb_tx_queues > MAX_TX_QUEUES) {

The product is computed as int and truncated to 8 bits on
assignment before the comparison, so a DPNI with 8 TCs and
32 queues per TC (256) yields nb_rx_queues = nb_tx_queues = 0 and
the "Too many" branch never fires. Compute into a uint32_t local,
cap, then assign. The TX side is new in this patch (the old value
was num_tx_tcs * num_channels, which cannot overflow); the RX side
overflowed before too but is rewritten here.

Related: capping the total to 128 rather than the per-TC count
makes tc_index = i / (128 / num_tx_tc) exceed num_tx_tc when
num_tx_tc does not divide 128 (e.g. 3 TCs -> per_tc 42,
i = 126, 127 map to TC 3). Cap num_queue_per_tc instead and derive
the totals from that.

Error: The new early return in dpaa2_dev_rx_queue_setup() breaks
Rx queue reconfiguration:

	if (dpaa2_q->fqid != DPAA2_INVALID_FQ_ID) {
		DPAA2_PMD_WARN("%s: RXQ[%d] has been setup",
			dev->data->name, rx_queue_id);
		dev->data->rx_queues[rx_queue_id] = dpaa2_q;
		return 0;
	}

dpaa2_dev_rx_queue_release() does not reset fqid to
DPAA2_INVALID_FQ_ID, so the stop / reconfigure / rx_queue_setup
sequence that rte_eth_rx_queue_setup() performs (release, then
setup) hits this return and silently keeps the old mb_pool, nb_desc
and offloads. Worse, release cleared the CGID
(priv->cgid_in_use[cgid] = 0; dpaa2_q->cgid = DPAA2_INVALID_CGID)
and the early return skips the block that allocates a new one and
programs taildrop / congestion notification, so the queue runs
without its drop configuration after any reconfigure. Either reset
fqid in rx_queue_release, or drop the early return on the Rx side
(the Tx side had the same pattern before this patch via
DPAA2_INVALID_FLOW_ID, and tx_queue_release should be checked for
the same reason).

Patch 17: net/dpaa2: support larger burst size

Warning: The version gate excludes newer major versions:

	if (priv->dpni_ver_major == 8 && priv->dpni_ver_minor >= 7)

A DPNI API 9.x would fall back to 64 KB. dpaa2_ethdev.h already has
dpaa2_dev_cmp_dpni_ver(priv, major, minor); use
dpaa2_dev_cmp_dpni_ver(priv, 8, 7) >= 0.

Warning: The new header comment and the code disagree on the
non-LX2160A limit. fsl_dpni.h says:

	* @max_burst_size:	Burst size in bytes. Limits depend on the SoC
	*		(0x37FFF for LX2160A, 0xF7FF for all others)

but dpaa2_get_burst_max() returns (64 * 1024) = 0x10000 for
"all others", which is above 0xF7FF. One of the two is wrong.

Patch 18: net/dpaa2: support MPLS and PPPoE flow distribution

Warning: doc/guides/nics/features/dpaa2.ini is not updated; the
[rte_flow items] section needs mpls and pppoes entries for the new
pattern support.

Patch 19: net/dpaa2: support meter and policing

Error: dpaa2_mtr_ops_get() re-initialises the lock on every call:

	int
	dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops)
	{
		struct dpaa2_dev_priv *priv = dev->data->dev_private;

		rte_spinlock_init(&priv->meter_lock);

rte_mtr_ops_get() in lib/ethdev/rte_mtr.c calls
dev->dev_ops->mtr_ops_get() at the start of every rte_mtr_*() API
call, so any concurrent rte_mtr call resets a spinlock that another
thread may currently hold, and the list manipulation it protects
is then unprotected. Initialise the lock once in dpaa2_dev_init()
next to the LIST_HEAD fields.

Warning: dpaa2_mtr_profile_delete() and dpaa2_mtr_policy_delete()
walk priv->meters and silently free every meter that references
the profile/policy:

	if (meter->profile_id == profile_id) {
		...
		LIST_REMOVE(tmp, next);
		rte_free(tmp);

rte_mtr.h documents both operations as failing when at least one
MTR object still uses the profile/policy. Return -EBUSY instead;
otherwise the application keeps a meter id that no longer exists
and any flow created with it (patch 37 wires meters into
dpni_set_rx_tc_policing) is left pointing at a freed object.

Warning: No documentation for the new feature: nothing in
doc/guides/nics/features/dpaa2.ini, doc/guides/nics/dpaa2.rst, or
the 26.11 release notes. (The series as a whole adds nothing under
doc/.)

Info: In dpaa2_mtr_profile_add():

	} else if (profile->packet_mode > DPNI_POLICER_UNIT_FRAMES) {
		dpaa2_profile->policer_unit =
			DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS;

rte_mtr_meter_profile.packet_mode is a 0/1 flag and
DPNI_POLICER_UNIT_FRAMES is 1, so this branch is unreachable.

Info: s_err_msg is a single static buffer shared by every port and
thread, and its address is handed to the caller via
rte_mtr_error_set(); concurrent callers can see each other's
message. dpaa2_mtr_policy_add() returns ENOMEM for "action not
supported" (should be ENOTSUP), and dpaa2_mtr_profile_add() returns
-ENOTSUP without filling in *error. struct dpaa2_dev_meter_policy's
red_drop is an int holding a bool.

Review-Result: ERROR
