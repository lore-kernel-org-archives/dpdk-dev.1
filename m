Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AE606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=0L6cbnyk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EE77402B0;
	Sat, 24 Oct 2026 01:43:27 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 68E3A4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 01:43:26 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so1173486a91.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792799005;
 x=1793403805; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M0Qcwx+fdMrR0yl0eKUB3jBIi8obMa42XJag91w1Vlc=;
 b=0L6cbnykgRMLpdFeA5jLzx191bsARKRnMHyUdBvQy/i0zQRAwccu4ad4RMzQID0Yu5
 AWvdeSW4ZRx7qFHMwvBWz8O7CWb3nKIhJuIjolVHHVcAPkq063HObrswsPvcV7vxkXmB
 E4meZa9Ki47espt11zv2uU8AX9SPR2Tqtaf9SDML+/FxbdPS/jasH3cI706Zkmxj/zEi
 F/6PO2jRHfBVAHc0vhAR4SHV8f1mdE0Pu1CDRAKUqqvlGu28VGe9+BNqlgS8R9eXsZ7K
 1Xg+ASgIbdbNBTMmciTw7zyW99MmJtM6TmZf0wKDNOJVLftr6ZTMpbyf9KL8N3M+8q9F
 RloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792799005; x=1793403805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M0Qcwx+fdMrR0yl0eKUB3jBIi8obMa42XJag91w1Vlc=;
 b=iBrHhlfDLeL/05yiTKvMqjgmK2ewhYYcsy5c1AobT1F7RS3IhDgQ9s3o+gZqHrnCmh
 DY6rmS+tlEs5D5SteWG0gNoTv6dzTmQV75TwV8kOlLNnj6hTse9P5p2GEFAWGRTjpmDO
 YgBxNBk9t2s8CI2xUUcWlNStSDLMrQY4VpOMxJjQN30paUYRsBbcU3zplDykDIoO/WTU
 OEWcNorloSPUrIWfOvunVSgcokO2vQQJr4pGiK7yqANfNB2SI4GwhSwtIrULT8jS6DVJ
 rva0zOYp+ojQuPTLMUdZsnfIsSMzdUrDCnOJVvwgquJJc6VwBIl5wN7G6VL91+tYenzW
 cZkg==
X-Gm-Message-State: AFq9FYKurwcrODjxchzt7SHeHSCwEEqf9+HXjc1UBXNrayl4B/ByQ1jM
 uKkP5L54bYDrSSJRHxFwz/9dEc40t8T7Vp2BsrthlFD2B3iPPUO7YXWaFR8FUDtdbn0=
X-Gm-Gg: AYBFou2eACnNYg+4XE80DDMc5MXXX11k47rjr6M9ireeinHmxR/Ec9Ve9PbeorWPuP8
 1TWVUgH4acB6NWkwqDfKLT4/BdMRgJIynwN6wZ2hobAPXNvBflHY+uLlkfMr7eKsvDWNZKi7A+8
 Qa70yPGe8yoqalI3Tab5kcJ0BoQs1+aZW/VDPOJniPDOe0I5njTePeFiQAb5X4xFqvukP4HyVgo
 /XSeEsler2/oESgaer/8qSEBjZaUHWNCH17qltirLNDiq4ipjRh9mxn3ItXWa4RT6ZFCZz5CAQj
 OcQxH93u0hnIdb7E/pwyirCtrPIXqkB08jQtsi4vHgrz4PVnouRwoToR/pKwa1Hq62mmb2DT6WX
 dSrqOF34Sr7l7M1CGQGIlpkGxNRQGlqT73wbxvQ/Eb5dHxLRnXItBQZYWACjJVhdPu8GMF23dNe
 mxksbkOoLqrDwc58H1akrWzXrMQBvX0G5M9c5JfjvR71V0fbSbi7OeChqoDQjT/C8TckUy5NWP3
 nzzv9aVxl9U0FHrh1ajP7qlj+1yd2VNgPxNhOlcWv4CSjSU4NYil4V3OuBSsLY7w0fZU0+rjl9e
 N+JGcMQpOsZK8DbiC8NT6hodFCXjJcT71xuE1xsRQbpH
X-Received: by 2002:a17:90a:d00e:b0:3a6:e99b:bbdb with SMTP id
 98e67ed59e1d1-3adeaf9857fmr569060a91.50.1792799004759; 
 Fri, 23 Oct 2026 16:43:24 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebaca7casm759155a91.4.2026.10.23.16.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:43:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 16:43:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4-S3 00/65] net/dpaa2, event/dpaa2 and fslmc rework
Message-ID: <20261023164320.7cd424e6@phoenix.local>
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

On Fri, 23 Oct 2026 19:12:40 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This is the final DPAA2 upstreaming sub-series, applied on top of
> v7-S1 ("dpaa2: bus, DMA and mempool base fixes") and
> v14-S2 ("net/dpaa2 updates").
> 
> The series reworks the DPAA2 datapath, flow steering, metering,
> eventdev integration and fslmc infrastructure. It consolidates
> device configuration handling, improves queue and portal management,
> and adds support for additional DPNI, eventdev and datapath
> capabilities.
> 
> Highlights:
>   - add DMA bypass translation support and table-driven devargs parsing;
>   - optimize Tx queue, channel and dequeue processing paths;
>   - centralize MC version, SoC detection and endpoint handling;
>   - rework RSS, flow steering, QoS and default action programming;
>   - add rte_mtr support and meter rte_flow actions;
>   - improve eventdev scheduling, DPCI support and multi-port operation;
>   - support runtime IEEE1588 timestamping;
>   - rework xstats collection and MAC statistics handling;
>   - unify enqueue/dequeue datapaths across net, crypto and eventdev;
>   - add Tx fast paths and reduce confirmation overhead.
> 
> Every commit builds cleanly with arm64 and -Werror and the
> series remains bisectable.

AI review reports lots and lots of issues here.
I assume you want this in next-net.

The build warnings from AI are suspect since it probably didn't
get correct dependencies but other issues are disconcerting to me.
It is not ready for 26.11 given project timelines.

Subject: Re: [PATCH v4-S3 00/65] dpaa2 driver updates

Reviewed v4-S3 (65 patches) applied on main + S2 v14. S1 is already
in main.

Series-level
------------

Build: does not build against current main.
  - 08/65 adds #include <rte_vfio.h> to fslmc_vfio.h. That header was
    renamed by cf88cd44aa ("vfio: make all functions internal"), and
    fslmc was already decoupled from EAL VFIO by 487098bd8d. Drop
    the include. 08..65 fail to compile as-is.
  - 21/65 fails with -Werror (gcc 13, x86, -O3): array-bounds in
    dpaa2_flow_extract_support(). rte_memcpy() copies a uint8_t
    size into uint8_t mask[64] with no bound. Add
    "if (size > sizeof(mask)) return -EINVAL;" and use memcpy()
    in this control-path code. 21..65 fail.
  - 42/65 and 43/65 fail: dpaa2_hw_dpio.c:476 uses
    rte_atomic16_read() (implicit declaration, and deprecated) on
    an RTE_ATOMIC(uint16_t). 44 fixes it. Use
    rte_atomic_load_explicit() in 42.
  With those three fixed locally, every commit builds (x86, gcc 13,
  -Dwerror=true; fslmc, dpaa2 net/event/crypto/dma/mempool, all
  event PMDs).
  Please rebase onto current main and build every commit with
  -Dwerror=true before resending.

Size: 65 patches mixing fixes, refactors and new vendor API is
too much to review or bisect. Split it:
  - Send standalone fixes first, each with Fixes: and
    Cc: stable@dpdk.org: 42 (create cleanup), 49 (ep_name and
    speed capa were never set), 54 (DQRR held accounting, Fixes:
    7b6edb640b), and the allocator CAS bug below (30/44).
  - 40/65 is a lib/eventdev doc change; send it to the eventdev
    maintainer on its own.
  - 32/65 is not a fix. RTE_EVENT_ETH_TX_ADAPTER_ENQUEUE_SAME_DEST
    is documented as "all packets destined for the same port and
    Tx queue", so reading ev[0] was correct. Reword it as a
    simplification or drop it.

Bisect: several patches introduce a bug and a later patch in the
series fixes it (01->13/51, 08->09, 12->13, 29->31, 43->44,
44->52, 57->59, 61->62). Fold each fix into the patch that
introduced the problem.

Vendor-specific API: this series adds rte_pmd_dpaa2_/rte_dpaa2_
APIs that duplicate generic ethdev, rte_flow and eventdev APIs:
06 rx_get_offset, 21 flow wrappers/group bits, 22 RSS helper,
31 EVENT_PORT_CFG_ATOMIC, 34 scheduler, 38 tx_multi_ports,
50 dev_info/rxq_info/configure_default_action, 53 clean_tx_conf.
I don't want to take PMD-specific API for things the generic API
already does. Implement the generic op (e.g. tx_done_cleanup for
53, rte_flow_group_set_miss_actions for 50) or justify each one.
Any that stay need Doxygen, a release note, the rte_pmd_dpaa2_
prefix and RTE_EXPORT_EXPERIMENTAL_SYMBOL(..., 26.11). Patches 21
and 50 export with 23.11/24.11/25.11.

Patch 12 has no subject line; the first paragraph of the body
became the subject.


Errors
------

[01/65] net/dpaa2: refactor and optimize Rx parser result decode

dpaa2_parser_decode.h / dpaa2_rxtx.c:149
  *packet_type |= RTE_PTYPE_L2_ETHER_VLAN;
  The L2 ptype is an enum, not flags. ETHER(1)|VLAN(6) = 7 = QINQ,
  so every single-tagged frame is reported as QinQ. The same
  happens for VLAN+ARP and MPLS (0xe, invalid) in parse_frc.
  Fix: clear RTE_PTYPE_L2_MASK, then assign.

[02/65] net/dpaa2: generate devargs table and string from one list
[03/65] crypto/dpaa2_sec: use table-driven devargs parsing
[04/65] dma/dpaa2: use table-driven devargs parsing

dpaa2_ethdev.c:3435
  priv->flags = 0;
  dpaax_get_devargs(s_dpaa2_devargs, eth_dev, &priv->flags);
  This now runs before the primary-process check. A secondary
  attaching wipes the primary's live flags in shared dev_private.
  03 (dump_level, en_loose_ordered) and 04 (short_fd,
  fle_pre_populate) have the same problem. Parse into a local and
  write shared state only in the primary.

dpaax_devarg.h:56
  dev_args[arg_idx].handle(dev, pair);
  The handler runs before the pair->value NULL check. A bare key
  ("drv_strict_order") gives value == NULL, and the handlers call
  atoi(pair->value), so probe crashes.
  Fix: if (pair->value == NULL) continue;

dpaa2_sec_dpseci.c:4366 (03/65)
  internals->en_loose_ordered = true;
  This runs after devargs are parsed, so drv_strict_order=1 no
  longer has any effect. Set the default before
  dpaax_get_devargs().

[09/65] bus/fslmc: centralize MC version and SoC detection

fslmc_vfio.c:172
  int x = cpu_id / dpaa2_cluster_size;
  This divides before the !dpaa2_cluster_size check below it.
  Move the check first.

[11/65] net/dpaa2: cache per-rxq DPNI queue cfg and share CGID per TC

dpaa2_ethdev.c (dev_init)
  for (i = 0; i < priv->max_cgs; i++)
          priv->cgid_in_use[i] = 0;
  cgid_in_use[] is now MAX_TCS (8) entries but max_cgs comes from
  MC (uint8_t). This writes past the array into priv.
  Fix: memset(priv->cgid_in_use, 0, sizeof(priv->cgid_in_use));
  and bound every max_cgs loop by MAX_TCS.

dpaa2_ethdev.c:1155 (rx_queue_setup err_quit)
  if (dpaa2_q->napi_dpcon) {
          rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
  With dpcon_allocated removed, the error path frees a DPCON that
  was kept across reconfigure. The FQ stays scheduled to a DPCON
  that is back in the pool. Restore a local "allocated" flag.

dpaa2_ethdev.c (dpaa2_eth_eventq_detach)
  dpaa2_ethq->options &= ~DPNI_QUEUE_OPT_DEST;
  dpni_set_queue() applies the destination only when OPT_DEST is
  set, so DEST_NONE is never written and the FQ stays on the
  eventdev DPCON. Pass options | DPNI_QUEUE_OPT_DEST for this
  call.

[12/65] (no subject) Tx buffer release schemes

dpaa2_rxtx.c:840
  DPAA2_MBUF_TO_CONTIG_FD(mbuf, fd, mempool_to_bpid(mbuf->pool));
  In no-conf mode, mbufs the fast path rejected (refcnt > 1,
  extbuf) are sent with a valid BPID. HW then releases a buffer
  the app still holds, or pushes an external buffer into BMan.
  Use IVP plus a refcnt decrement as before.

dpaa2_rxtx.c:822
  rte_mbuf_refcnt_update(mbuf, -1);
  ...
  mbuf = mi;
  The clone's reference is dropped and the direct mbuf is sent
  without taking one. The FD is also built from mi's data_off/len,
  not the clone's view. Keep the indirect mbuf's iova/off/len with
  IVP.

dpaa2_rxtx.c:775
  sg_mbuf->next = cur_seg;
  When the first segment is a clone, it is freed by
  conf_mbuf_to_sge() while sg_mbuf->next still points at it, which
  is a use-after-free on confirmation. rte_pktmbuf_init() also
  forces refcnt to 1 on a shared clone.

dpaa2_rxtx.c:1697
  num_tx += loop; ... goto send_n_return;
  On retry exhaustion, fd_arr[0..loop) is enqueued a second time,
  so frames are transmitted twice and buffers released twice.

[13/65] net/dpaa2: support runtime IEEE1588 timestamping

dpaa2_rxtx.c:183
  ts = RTE_MBUF_DYNFIELD(m, priv->rx_ts_offset, void *);
  rx_ts_offset is only registered when the RX_OFFLOAD_TIMESTAMP
  offload is set. timesync_enable without it writes word2 at mbuf
  offset 0 (buf_addr). Initialise rx_ts_offset to -1 and check it.

dpaa2_ptp.c:219
  while (txq && rte_atomic_load_explicit(&txq->ts_to_cnfd,
  The counter is updated on tx_conf_queue but read on the Tx
  queue, where it is always 0. tx_timestamp is never cleared, so
  stale values are returned. ts_to_cnfd also goes negative for
  multi-seg or non-PTP TMST frames (rxtx.c:1567).

[17/65] net/dpaa2: rework xstats with page table and MAC support
[19/65] net/dpaa2: reimplement xstats_get() on top of xstats_get_by_id()

dpaa2_ethdev.c:2249
  if (n > stat_cnt) { ... return -EINVAL; }
  if (!xstats) return 0;
  This breaks the xstats_get contract. A NULL/0 size query must
  return the count, and a larger buffer is legal. In 19,
  "n = DPAA2_XSTAT_MAX_NUM" includes the MAC stats, so ports
  without a MAC fail with -EINVAL.
  Fix: if (n < stat_cnt || !xstats) return stat_cnt;

[20/65] net/dpaa2: fetch only requested MAC xstats in one MC call

dpaa2_ethdev.c:2258
  mac_val[mac_num] = &values[i];
  mac_num++;
  Ids are not de-duplicated. With repeated MAC ids, mac_num goes
  past the stack array and the DMA index buffer. Bound mac_num.

[21/65] net/dpaa2: rework flow with per-table profile and group types

dpaa2_flow.c:2872
  new_pattern[num].item.type = RTE_FLOW_ITEM_TYPE_END;
  The count loop does num++ before testing, and the allocation
  has no room for END, so this is a heap overflow on every create.
  Allocate num + 1.

dpaa2_flow.c:2976
  index = pattern[i].type;
  if (!hd[index].name) {
  The table has 64 entries, the enum goes to 70, and private
  types are negative. This reads out of bounds and then calls a
  garbage cb. Range-check the type.

dpaa2_flow.c:2983
  ret = hd[index].tunnel(flow, ...);
  On success it falls through to hd[index].cb as well, adding
  outer extracts with the inner spec. Inner-tunnel rules never
  match. continue after the tunnel cb.

dpaa2_flow.c:3592
  if (items[i - 1].type != RTE_FLOW_ITEM_TYPE_END) {
  items[i-1] is never END, so every RSS flow with a pattern fails.
  An empty pattern reads items[-1].
  Fix: test i == DPKG_MAX_NUM_OF_EXTRACTS + 1.

dpaa2_flow.c:1075
  flow->ip_src = NET_PROT_IPV4;
  This is set for IPv6 too. remove_invalid_extract() then shrinks
  the IP address slots to 4 bytes and corrupts the keys of the
  remaining IPv6 rules.

dpaa2_flow.c:3528
  return update;
  update excludes IP-address extracts, so removing only IP
  extracts skips the table reprogram and the HW key layout goes
  stale.

dpaa2_flow.c:1022
  key_profile->dpkg.extracts[raw_idx].type = DPKG_EXTRACT_FROM_DATA;
  This overwrites the slot in place instead of shifting, so an
  existing IP extract is lost. Use dpaa2_dpkg_insert_extract().

dpaa2_flow.c:1302
  memcpy((flow->key_addr + offset), key, size);
  RAW length can reach 320 bytes into a 256-byte buffer, and
  key_offset is uint8_t. Reject offset + length > DPNI_MAX_KEY_SIZE.

dpaa2_flow.c:1081
  A non-zero fragment_offset mask always installs the "is
  fragment" FAF, so "match non-fragmented" (spec 0, mask 0x3fff)
  is inverted. Only the first byte of the be16 mask is checked.

dpaa2_flow.c:1666
  DPAA2_PARSER_MPLS_ID, ... RTE_FLOW_ITEM_TYPE_PPPOES,
  PPPoE uses the MPLS parser id, so PPPoE matches MPLS. fields_num
  is 1, so session_id is never extracted.

dpaa2_flow.c:4227
  dpaa2_flow_steering_flow_action_update(dev, flow->qos_flow,
  The FS update is passed qos_flow: a NULL dereference for
  FS-only flows, and the wrong entry otherwise. Use fs_flow.

dpaa2_flow.c:4163
  struct rte_flow_action actions_update[DPAA2_MAX_ACTION_PER_FLOW_NUM];
  check_actions_support() writes END with no capacity check, so
  user actions can overflow the stack array. Pass the capacity.

dpaa2_flow.c:3743
  dpaa2_flow_clean(dev, flow->tc_id, DPAA2_FLOW_RSS_TYPE);
  Creating a flow destroys the user's existing flows, whose
  handles the application still holds, so a later destroy is a
  use-after-free. It also happens before the new create is known
  to succeed. Return -EEXIST instead.

dpaa2_flow.c:3975
  ret |= dpaa2_flow_destroy_rss_flow(...);
  The flow is unlinked first. On partial failure it is leaked
  with dangling sub-flow pointers, ORed errnos are meaningless,
  and rte_flow_error is never set.

dpaa2_flow.c:3022
  idx = attr->group * priv->qos_entries_per_tc + attr->priority;
  attr->group still carries the type bits (0x100+), and idx is
  uint16_t so it wraps past the bound check. Lines 2401 and 3884
  also use the converted group. Use the group id and a 32-bit
  idx.

dpaa2_flow.c:4394
  key = flow->qos_flow->key_addr;
  There is no NULL check, so rte_pmd_dpaa2_flow_table_query()
  crashes on FS-only, QoS-only and RSS flows.

dpaa2_flow.c:3747
  if (error && error->type > RTE_FLOW_ERROR_TYPE_ACTION) {
  This reads an uninitialised caller struct. On creation failure,
  extracts already inserted into the shared profile are not
  rolled back, which corrupts other flows' keys.

[22/65] net/dpaa2: reimplement RSS distribution via rte_flow

dpaa2_ethdev.c:565
  rte_flow_actions_update(..., tbl_profile->rss_flow,
  rss_flow is the internal dpaa2_generic_flow, not the rte_flow
  handle. update returns -EINVAL, and rte_flow_destroy() on it at
  line 531 does LIST_REMOVE on the wrong type, corrupting memory.
  Store the handle returned by rte_flow_create().

dpaa2_ethdev.c:2998
  tc_index, priv->dist_queues);
  rss_hash_update uses dist_queues for every TC, which loses the
  last-TC clamp. When no RSS flow exists it returns 0 and does
  nothing.

rte_pmd_dpaa2.h:16
  #include <ethdev_driver.h>
  This is an installed header including a driver-SDK header, so
  applications without the SDK cannot build. The helper also
  discards the rte_flow handle it creates.

[25/65] net/dpaa2: support rte_mtr and METER rte_flow action

dpaa2_flow.c:4061
  } else if (meter_action->type == RTE_FLOW_ACTION_TYPE_METER_MARK) {
  This is the same condition as the first branch, so METER is
  never handled and always returns -EINVAL. Use
  RTE_FLOW_ACTION_TYPE_METER.

dpaa2_flow.c:3078
  policing_cfg.cir = dpaa2_profile->cir;
  rte_mtr is bytes/s (uint64_t) and the MC field is Kbps
  (uint32_t). The rate is 125x too high and truncates above 4G.
  Convert, and reject values that do not fit.

[27/65] net/dpaa2: support DCB Rx mode via rte_flow

dpaa2_ethdev.c:1330
  dcb_rx_conf.dcb_tc[tc_index], tc_index);
  dcb_tc[] is indexed by priority and holds the TC. This treats it
  the other way round and loops only nb_tcs times. Iterate over
  RTE_ETH_DCB_NUM_USER_PRIORITIES.

dpaa2_ethdev.c:596
  priv->dcb_flow[prio] = qos_flow;
  This is never cleared except in close, so a second configure
  with DCB fails with -ENODATA. After flush the pointers dangle.

[29/65] bus/fslmc: support DPCI peer and dynamic queues
[30/65] bus/fslmc: add alloc/free DPIO API for non-affine portals

dpaa2_hw_dpci.c:194, dpaa2_hw_dpio.c:430
  uint16_t expected = 0;
  TAILQ_FOREACH(...)
          rte_atomic_compare_exchange_strong_explicit(..., &expected, 1,
  expected is outside the loop. A failed CAS stores 1 into it, so
  the next busy object is handed out a second time. Two owners on
  one QBMan portal corrupt EQCR/DQRR. From 44 every per-lcore
  portal goes through this allocator. Declare expected inside the
  loop.

dpaa2_eventdev.c:122 (29/65)
  priv->evq_info[queue_id].event_port != dpaa2_portal)) {
  At 29 event_port is never set, so every enqueue fails and jumps
  to send_partial with frames_to_send uninitialised entries. This
  is fixed in 31; fold it into 29.

[31/65] event/dpaa2: rework event port model and DPCI handling

dpaa2_eventdev.c:594
  ret = rte_event_port_unlink(dev->data->dev_id, dpaa2_portal->port_id, NULL, 0);
  if (ret)
          return ret;
  unlink returns a count (> 0), so link on an already-linked port
  returns that count without linking anything. The lib then marks
  queues[0..ret) as linked. link must not unlink.

dpaa2_eventdev.c:607
  if (evq_info->event_port) { ... return -ENODEV;
  A queue can be linked to only one port, and enqueue only accepts
  queues the port owns. Load-balanced workers and pipelines
  (dequeue q0, enqueue q1) no longer work, yet DISTRIBUTED_SCHED
  and MULTIPLE_QUEUE_PORT are still advertised.

dpaa2_eventdev.c:126
  goto send_partial;
  A bad event is never consumed, so the outer while (nb_events)
  retries it forever. Return num_tx and set rte_errno.

dpaa2_eventdev.c:206
  qbman_swp_interrupt_clear_status(DPAA2_PER_LCORE_PORTAL,
  Dequeue uses the port's DPIO, but the wait uses the lcore
  affine DPIO: NULL on a control thread (stop/drain), or the
  wrong portal. Pass dpio_dev.

dpaa2_rxtx.c:1696 (also dpaa2_sec)
  DPAA2_PER_LCORE_DQRR_SIZE--;
  Atomic events are held on the port's DPIO, but ethdev, Tx
  adapter and dpaa2_sec issue the DCA and update held_bufs on the
  lcore DPIO. The DQRR entry is consumed on the wrong portal.
  59 addresses this with dpio-in-seqn, but see 59 below.

dpaa2_ethdev.c:3403
  dpaa2_ethq->ev.queue_id = eth_rx_queue_id;
  This overwrites the event queue id in the Rx-adapter event
  template. flow_id is also forced even with FLOW_ID_VALID set.

[34/65] event/dpaa2: add DPCON based standalone Rx scheduler

dpaa2_scheduler.c:216
  dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts,
  This pulls nb_pkts into storage sized dqrr_size, so QBMan DMAs
  past it. dq_sch_storage++ also carries into the next pull. Pull
  min(nb_pkts, dqrr_size) and reset the pointer per pull.

dpaa2_ethdev.h:933
  priority_step = (RTE_EVENT_DEV_PRIORITY_LOWEST + 1 -
          RTE_EVENT_DEV_PRIORITY_HIGHEST) / dpcon->num_priorities;
  priority_step is uint8_t. With 1 priority, 256 truncates to 0
  and the next line divides by zero. This is reached from every
  Rx adapter queue_add. Use unsigned int.

[35/65] event/dpaa2: add push mode to DPCON Rx scheduler

dpaa2_scheduler.c:590
  return sch_dev->dpcon_dev[0]->num_priorities;
  In push mode dpcon_dev[] is filled lazily per lcore, so this is
  NULL unless lcore 0 has received.

dpaa2_scheduler.c:116
  configured is global, so only the first lcore attaches queues.
  A later add() re-attaches the same DPCI and re-adds the static
  channel from the datapath.

[37/65] event/dpaa2: track and detach attached Rx queues

dpaa2_scheduler.c:616
  dpaa2_scheduler_eventq_detach(sch_dev, attach_num);
  In push mode attach_num counts lcores, not queues. Too few
  queues are detached, or NULL entries are dereferenced.

dpaa2_eventdev.c:525
  if (!eth_dev || rx_queue_id < 0) {
  queue_del(port, -1) detaches every Rx queue of every ethdev.
  Only the given ethdev's queues should go.

dpaa2_eventdev.c:932
  dpaa2_eventdev_dequeue_drain(dev);
  Rx adapter stop drains every port of the device, dropping other
  sources' events, and untracks the queues, while start is a
  no-op. stop then start loses traffic.

dpaa2_ethdev.c:2368
  DPAA2_PMD_WARN("%s's %d rxq(s) are not detached ...
  close only warns, then frees queues that the eventdev still
  references. A later eventdev close is a use-after-free and
  dereferences a NULL priv->hw.

[38/65] net/dpaa2: add multi-port Tx API

dpaa2_rxtx.c:2028
  txq[i] = data->tx_queues[txq_id[i]];
  port_id and txq_id from the caller are not validated, and a
  non-dpaa2 port's queue is cast to struct dpaa2_queue.
  struct dpaa2_queue *txq[nb_pkts] is an unbounded VLA.

[39/65] event/dpaa2: limit attached Rx flows per event queue

dpaa2_eventdev.c:520
  uint8_t i, j, k, found = false;
  dpni_rxq_num is now uint16_t up to 1024, so these loops never
  terminate past 255.

[44/65] bus/fslmc: consolidate DPIO interrupt setup

(the CAS bug from 30 becomes hot here; see above)

[45/65] event/dpaa2: honor configured dequeue timeout

dpaa2_eventdev.c:311
  if (timeout_ticks)
          timeout_ms = timeout_ticks * 1000 / priv->event_hz;
  else
          timeout_ms = priv->dequeue_timeout_ns / (1000 * 1000);
  This is backwards. timeout_ticks == 0 means no wait. Without
  PER_DEQUEUE_TIMEOUT, a non-zero value means use
  dequeue_timeout_ns. Sub-ms values round to 0.

[51/65] net/dpaa2: consolidate dequeue paths

dpaa2_scheduler.c:334
  if (likely(q_storage->active_dqs)) {
  This is inverted. On the first call active_dqs is NULL and
  qbman_check_command_complete(NULL) follows. Use
  unlikely(!active_dqs).

dpaa2_rxtx.c:1300
  dq_storage = dpaa2_q->q_storage[0]->dq_storage[0];
  rx_err_vq is shared by all Rx lcores, and they now all pull into
  storage[0] at once. Use q_storage[rte_lcore_id()].

[53/65] net/dpaa2: add API to clean Tx confirmation queue

dpaa2_ethdev.c:1256
  txq = dev->data->tx_queues[txq_id];
  txq_id is not range-checked and txq is not NULL-checked.

[57/65] net/dpaa2: unify tx burst path

dpaa2_rxtx.c:1810
  dqrr_held[loop] = ~(UINT64_C(1) << dqrr_index);
  This is negated again at 1862, so HELD &= bit clears every other
  held entry. It is fixed in 59; fold it here.

dpaa2_rxtx.c:1871
  *dpaa2_seqn(bufs[i]) = flags[i];
  flags[] is uninitialised for non-DCA slots, so stack garbage
  goes into seqn and can carry DCA/ORP bits. This is still in 65.
  Set flags[loop] = 0 and save the ORP seqn too.

dpaa2_rxtx.c:1813
  *dpaa2_seqn(bufs[loop]) = DPAA2_INVALID_MBUF_SEQN;
  This is cleared before the enqueue is known to succeed. A later
  FD build failure returns the mbuf unsent with its atomic
  context lost.

dpaa2_rxtx.c:1654
  if (nb_pkts > 0 && !ret && !order)
  On retry exhaustion, bufs has already advanced past the unsent
  frames. The next pass skips them and reads past the caller's
  array. ret is uninitialised when order breaks at loop 0.

[58/65] crypto/dpaa2_sec: unify enqueue burst path

dpaa2_sec_dpseci.c:1665
  int32_t ret, order = false;
  ret is read at "if (ret >= 0 && order)" without being set when
  the first op is ordered and the lcore already has a portal.
  Initialise it to 0.

dpaa2_sec_dpseci.c:1602
  DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
  This reintroduces the bug 54 fixes in eventdev: held state is
  consumed before enqueue, and build_sec_fd() failure loses it.

[59/65] bus/fslmc: track atomic DCA context per dequeue dpio

dpaa2_hw_pvt.h:537
  if (*dpaa2_seq_dpio_dq(mbuf) == dpio_eq) { \
  The Tx adapter and crypto pass the lcore DPIO, not the port
  DPIO, so this never matches. The held mbuf[] slot stays, and
  the next dequeue writes seqn into an mbuf already given to HW
  and possibly freed.

[60/65] bus/fslmc: move enqueue response descriptors to per-queue

dpaa2_rxtx.c:1736
  ret = dpaa2_eq_set_order_desc(priv->tx_vq[0], bufs[loop], ...
  Slots are taken from tx_vq[0] but reaped from dpaa2_q[loop], so
  the ring fills and ORP Tx returns -EAGAIN forever. All lcores
  update tx_vq[0]->eq_resp without a lock.

dpaa2_hw_pvt.h:688
  eq_resp->active_t = next;
  The slot is consumed before enqueue. A frame not enqueued leaves
  a slot that never completes, so process() stops there for good.

dpaa2_hw_pvt.h:699
  dpaa2_enq_rsp_process(queue, 1);
  The free loop spins forever on such a slot. Bound it.

dpaa2_sec_dpseci.c:1555
  goto skip_tx;
  On -EAGAIN the FLEs already built for this chunk leak, along
  with their ORP/DCA state. Send the built frames instead.

[65/65] net/dpaa2: add Tx fast path for no-confirmation case

dpaa2_rxtx.c (dpaa2_dev_tx_fast)
  DPAA2_MBUF_TO_CONTIG_FD((*bufs), &fd_arr[loop],
  The fast path ignores RTE_MBUF_F_TX_IEEE1588_TMST, so one-step
  PTP is lost in the default config. Send TMST frames to the slow
  path.


Warnings
--------

01: QinQ sets RX_QINQ without vlan_tci_outer. On LX2, parse_frc
    never sets the GOOD cksum flags and sets IEEE1588_PTP without
    TMST. PTP/UDP-ESP-IKE summaries end up as L4_NONFRAG. The
    by_channel guard on the error-queue drain was dropped (S2
    added it on purpose). FLC hash decode now runs on non-LX2
    SoCs. sp_protocol is never set until 10.
05: dumps log under RTE_LOGTYPE_USER1, not the PMD logtype, with
    one log call per byte.
06: the offsets dynfield is not filled on the eventdev Rx paths.
    The new devarg is undocumented.
07: the Tx queue to TC mapping changed from interleaved to blocked,
    and channels > 0 are not reachable per TC. Neither is in the
    commit message.
08: the MC version check is removed and only restored in 09.
10: every bus scan opens /dev/mem O_RDWR and maps CCSR writable,
    logs ERR when that fails, and hex-dumps at NOTICE. Use
    O_RDONLY/PROT_READ and DEBUG.
11: cgid_in_use is incremented before setup and not decremented
    on error.
12: the FAEAD is written in place into buffers the PMD does not
    own. tm_sw_td handling was removed. The tx_again loop
    condition is inverted. drain never loops. tx_conf storage is
    freed with a VDQ outstanding. The IEEE1588 producers are
    removed until 13.
13: rx_timestamp is overwritten by every packet, not only PTP.
    tx_burst issues a blocking MC command
    (dpni_set_single_step_cfg). read_tx_timestamp dequeues the conf
    FQ from the control thread with q_storage[rte_lcore_id()].
17: imissed/ierrors/rx_nombuf now double count. tc < MAX_TCS is
    always true, so all 8 page-5 queries are issued.
18: 16 PFC counters are added to the MAC request with no MC
    revision gate.
20: the MAC DMA buffers are allocated on every get_by_id, before
    the MAC check.
21: GTPU RSS and IPv6-only RSS always fail. Single-TC ports now
    need a QoS entry (regression). An out-of-range group silently
    becomes 0. validate accepts what create rejects, and item->last
    is ignored. packet_id is advertised but not extracted. Action
    update accumulates tokens. query returns success with no data.
    Miss actions report success on old MC. dev_init returns success
    on table allocation failure (ret still 0). drv_qos_entries_per_tc
    is unchecked and undocumented. The commit message describes
    an env var the code does not have.
25: meter_lock is re-initialised on every mtr_ops_get. packet_mode
    > 1 is overloaded. Duplicate ids are accepted, delete frees
    meters in use, and update does not reprogram. A METER rule with
    a pattern is applied to the whole TC. features/dpaa2.ini and
    the release notes are not updated.
26: miss-action programming errors are logged and dropped in
    configure.
27: get_dcb_info returns the init identity map, not the configured
    one.
29: DPCI rx_queue cb is never cleared, so a used DPCI is -EBUSY
    forever. ORDERED was dropped while ALL_TYPES is still
    advertised.
31: 1024-entry env_pool with a 512 per-lcore cache drains across
    lcores. Releasing a port does not reset held_bufs. close leaks
    port DPIOs (until 37, and still when never started).
34: q_storage[rte_lcore_id()] has no LCORE_ID_ANY check. destroy
    leaks the dq storage and does not detach Rx queues. max_prio
    returns a count, so it is off by one.
35: push-mode DPCONs are never enabled but are disabled on destroy.
36: drain runs before detach, and a VDQ is left outstanding.
40: the new wording ("negative on failure") does not match the
    public rte_event_port_link() contract or most PMDs.
41: relinking an already-linked queue errors instead of updating
    priority, and rte_errno is not set on a short count. unlink
    pos[16] overflows with duplicate queue ids.
42: probe failure does not uninit the vdev eventdev.
    max_event_ports excludes the device's own DPIOs, so a second
    configure fails.
43: the event port DPIO has epoll_fd -1 until 44, so the timeout
    never waits.
44: interrupts are now armed on every ethrx portal (inverted
    condition, reverted in 52). The stash error path leaks the
    epoll fd.
47: each intr_init creates an eventfd that deinit never closes.
    The fast path rewrites IRQ affinity and the cpufreq governor
    using the lcore id as the CPU. A PMD must not change system
    cpufreq policy.
48: the Rx SG walk lost its DPAA2_MAX_SGS bound (the commit
    message says one was added). The sg pool create is unchecked
    and is now created for every fslmc probe, including in
    secondaries.
49: this fixes ep_name and speed capability never being set
    upstream. Say so and add Fixes:/Cc stable.
52: rx-intr sets the governor to performance on the first burst,
    which defeats the purpose. MC subscribe runs on every arm.
    There is a stale comment block.
54: missing Fixes: 7b6edb640b and Cc: stable@dpdk.org.
57: DCA/ORP bursts bypass VLAN insert. A bad packet returns short
    without being freed (tx_burst must free and continue). The
    same applies in 65.
58: ordered ops are counted in err_pkts.
60: qp is allocated with rte_malloc (not zeroed) and stays in
    queue_pairs[] on setup failure.
61: ORDERED is advertised before the DPCI OPR exists (62). The ORP
    flag leaks when forwarding to a non-ordered queue.
    ordered_scheduling is missing from the eventdev ini.
62: the DPAA2_STRICT_ORDERING_ENABLE env var was replaced by a
    devarg; the commit message says it is still honoured.
63: the teardown no longer stops the device after a failed test.
    The commit message is wrong.
64: queue_setup accepts sched types that have no DPCI txq.
    Probe-failure return leaves the eventdev allocated.
65: a 1 KiB fd_arr is zeroed on every fast-path burst.


Info
----

01: flow-extract helpers are added with no caller (move them to
    21). __rte_unused is stale. Use PRIx64, not %lx.
02: the getenv DPAA2_DATA_STASHING_OFF path was removed silently.
    dpaa2.rst documents drv_error_queue, but the key is
    drv_err_queue (pre-existing).
07: DPAA2_INVALID_FLOW_ID is orphaned.
08: fslmc_vfio_core_cluster_sdest is declared before it is
    defined (09).
09: any newer MC major is accepted, and unknown SVRs now fail
    probe. Neither is mentioned in the commit message.
13: timesync_disable leaves single-step enabled in the DPNI.
21: leftovers: DPAA2_FLOW_HDR_HEX_DUMP_SIZE, flow_profile
    mempool[]/bp_idx[], tbl_profile.enabled. The IPv6 SRC/DST
    mapping in dpaa2_extract_ip_convert is wrong (latent). AH is
    logged as "esp". dead NULL check at flow.c:438. jump/geneve
    are missing from features/dpaa2.ini.
25: tc_mtr_profile[] is written but never read.
39: max_event_queue_flows is halved for unrelated bookkeeping.
42: DPAA2_EVENT_MAX_PORTS is unused.
60: MAX_EQ_RESP_ENTRIES is unused.
62: odpid is not masked with DPAA2_EQCR_OPRID_MASK.
63: generate_random_events passes an index as the port id.

Not adding Reviewed-by; there are Errors and Warnings throughout.
Please split, rebase and resend.
