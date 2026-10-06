Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A64CA6001
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B683640262;
	Tue,  6 Oct 2026 16:16:54 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 9B64C4025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 16:16:53 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3a813079a55so399753a91.0
 for <dev@dpdk.org>; Tue, 06 Oct 2026 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791296212;
 x=1791901012; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NjDsFPfSvYOeNBcUez3kY1wkNI+TOyMV0LWnSw2wpXs=;
 b=sOWla1yzAuOX9LqawZrExiE8/4tMfFGF3mJ2RUxrqfSnQlEVgOHV2wFRjHEfDuXA3/
 0RfvLMNb1uWiAcopc0NF6aD+KdY/KLbNk38c2+aF3RwyMftpNq/G6SldNzJdSu60Fbdu
 8/O/0MdeChFHOP+MiAoDXILvHd+hLeTFY7sZyzrbaKLEg/U0rYT8FUwMCmCe8YQLbO/h
 vFv/DzpB6RtP7VImgi1u5oAAIXhwme2wWKiI2HJsZpNTot98p0M9mOu2nPgUJHpx6kZN
 r+xr1WzGzyDYLKSVd3mP8f2y2Ecf10H88jXC8wYkmcJDVaojdz9hmmUDxVYmET6rmHwb
 UTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296212; x=1791901012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NjDsFPfSvYOeNBcUez3kY1wkNI+TOyMV0LWnSw2wpXs=;
 b=pki4PEISeaGGZ/2l5/32jQx9ANnJVEP8grL8Bb9iunsBi4fpvgdkPF3JxEQGDkwzhy
 Cd3rK1Akj0a3m0adrzaSmdGENdJHXIe1DM2g0AGn2WT0HqDUbYQSXRwRc97xRk0bCotu
 HIAbEe5Am2JUhW5O+AtkpKm3mjTZSAydck92hdj/ah9lH/fxjgvGK3zsm47BHILCtsMw
 IZ9/nnXSEPjPrU9ejvoPaGj0g1UyFNOjwknhfPgas3LHWqPXRDeyKFz030QcqgrFWMA5
 jwp0UAQCuuoZR7Di0EUCHX5PDa4QLdj8x1DcS6b8adZ9ihSU9YjDau2wwA+Xp8QfrC6b
 kRhQ==
X-Gm-Message-State: AFq9FYKFilJ1AxHSdOGeRPSKz5JJW4rfNIIG6UX7atTmsHX56eGeV2kQ
 umF8wADO5jM/OvO9rxXaZ8lOlx6HrUfcbUS4njMPy0DAs1wmNT2OIrt8zXqzifJPPxo=
X-Gm-Gg: AYBFou1sLvqOOo549dCnBEpr0DbQniu1gYfE5FyRy7yrwnPkYfeK+aFTWLrYznQvg35
 COoQtaVmLLbSqwecOekWV4DDaROzUnOrQLOEiEhc3JY/efhY6JWVsAPS1BkJeCCe0PWh8N22utm
 YuM20wSeoDcAqyNwtIaMeXzs8uQ5qaxVvHc/OXmc6P/AwG7/6Qrh6Ai8LGPSR7tSSHsKw1Qq9J6
 HuQ4BGFRyPLgmAVc6FUVc5wRd7pYaRV7yTXjcjRcJ8i8JyofPghJssVbSxsMdhImH3GtU8lc/ov
 3eWBV6n8K4m16fnjYw1iT2WxbRUx88ADDvVi0wpkIEsoKKesCbHjk/AQuaNmwjNJNBllPGF3si3
 cz3cf+w4IyLvPEIe0ZxWdsAZx0aWg4JwXeOGFosHLmrBbHTkDgyYQmbMqQ6QLLO51rSXt2yZImR
 7Y4sy4ZG3cR7ERXrDF1Ho8XcLimBQv8PU8kCWZ3qgnySKM/eW0GJckxF8uayn+3Lgbwyyj1OBfh
 +cjOjFZg8lv9Rw8B2nCgUiTKY/rUClm3K4z7Gmi
X-Received: by 2002:a17:90a:2ce5:b0:3a8:786a:cfed with SMTP id
 98e67ed59e1d1-3a8786ad5cbmr408973a91.37.1791296211991; 
 Tue, 06 Oct 2026 07:16:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853e662a5sm5202061a91.4.2026.10.06.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:16:51 -0700 (PDT)
Date: Tue, 6 Oct 2026 07:16:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <andrew.rybchenko@oktetlabs.ru>, <aman.deep.singh@intel.com>
Subject: Re: [RFC PATCH v5 0/5] ethdev: add Tx timestamp slot APIs
Message-ID: <20261006071648.4bb37e4f@phoenix.local>
In-Reply-To: <7624cfc9-c624-43e2-a046-250d332abe7e@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
 <11be03b9-2f3c-4665-9a89-3fce0dabeb33@intel.com>
 <7624cfc9-c624-43e2-a046-250d332abe7e@intel.com>
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

On Tue, 6 Oct 2026 15:58:29 +0530
"Kumar, Rajesh" <rajesh3.kumar@intel.com> wrote:

> Hi Stephen,
> I wanted to quickly check if you have any further comments or feedback 
> on this v5 series?
> If you are satisfied with the current changes, we can move forward to 
> the next steps for this patch.
> 
> Regards,
> 
> Rajesh
> 
> On 21-09-2026

Lots of open issues from AI review.
The biggest issue is that this overlaps with existing metering API
and seems  specific to Intel NIC's. I strongly discourage API's that
can only be used on one vendor NIC.


Series: [RFC PATCH v5 0/5] ethdev: add Tx timestamp slot APIs

Applied to main 49bb9a5 (release_26_11.rst conflict only). Each
commit builds with -Dwerror=true (net/intel/ice, test-pmd); no bisect
issues.

Series-level:

The main problem is in the ice implementation. Slot state is never
cleaned up before a slot is handed out, so the read path can return
a timestamp that belongs to an earlier packet as if it were the
current one (patch 4, Error).

The legacy static index and the slot allocator also overlap on ice.

On the API side, the caller has to set two separate mbuf flags for
one action. The caps query returns -ENOTSUP on every PMD except ice,
so it cannot be used to choose a mechanism as the doc says.

The patch 1 commit message and the cover letter describe an
unregister / "process-local reset" API that is not in this version.


Patch 1/5 ethdev: add Tx timestamp slot management APIs

Warning:

- The commit message says "Add APIs to register and unregister the
  mbuf dynamic field", and the cover letter lists "process-local
  reset". Only rte_eth_timesync_tx_slot_dynfield_register() exists.

- rte_eth_timesync_tx_slot_dynfield_register() falls back to
  rte_mbuf_dynfield_lookup() / rte_mbuf_dynflag_lookup() after a
  registration failure. Register already returns the existing offset
  when the name and params match, including in a secondary process.
  The only extra case the lookup covers is EEXIST with different
  params, and there it accepts a field of the wrong size or
  alignment. It also returns -ENOTSUP for every failure, losing
  rte_errno (ENOMEM, EEXIST). Drop both lookups and return
  -rte_errno.

- The register doc says "Must be called before the first
  rte_pktmbuf_pool_create()". rte_mbuf_dyn.h says "The registration
  can be done at any moment"; pool creation has no bearing on it.
  The same wrong claim appears in the patch 3 note.

- rte_eth_timesync_tx_slot_caps() returns -ENOTSUP for every in-tree
  PMD except ice, including all PMDs that implement
  timesync_read_tx_timestamp. Nothing ever reports
  RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG, so "Applications use this to
  select the mechanism supported by the port" does not hold. Either
  have ethdev report SINGLE_REG when timesync_tx_slot_get_caps is
  NULL and timesync_read_tx_timestamp is set, or drop SINGLE_REG.

- rte_eth_timesync_tx_slot_stamp() sets the dynflag but not
  RTE_MBUF_F_TX_IEEE1588_TMST. The patch 3 example has to set TMST
  separately. If the application forgets it, ice takes the
  "else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)" path, no
  timestamp is requested, and the slot read returns -EAGAIN forever.
  stamp() should set both flags.

- The release note says the new APIs "support both shared-register
  and slot-bank usage models through the rte_eth_timesync_tx_slot_*
  interface family". The shared-register model is still served only
  by rte_eth_timesync_read_tx_timestamp().

- There is no functional test. dynfield_register() and stamp() are
  pure software and can be tested in app/test without hardware.

Info:

- The read and release doxygen says "is undefined behaviour - PMDs
  should return -EINVAL"; pick one. Those two lines (rte_ethdev.h
  5448, 5472) also use non-ASCII em-dashes. The release doc still
  refers to "stamp_mbuf", the old function name.

- Drop "This function does not make the PMD hardware lifecycle safe
  by itself." It gives the reader nothing to act on (also in
  patch 2).

- The new wrappers have no trace points. The existing timesync calls
  do, e.g. rte_eth_trace_timesync_read_tx_timestamp().

- Unrelated changes: a blank line removed before
  rte_eth_add_rx_callback, and the log text reworded in
  rte_eth_timesync_read_tx_timestamp().

- The definitions of alloc, release, dynfield_register and stamp put
  the return type on the same line as the name. caps and read in the
  same patch follow DPDK style.

- Nothing in the series sets raw_ns or
  RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_RAW_VALID. Consider leaving
  them out until a PMD produces them.

- The dynfield name "rte_eth_timesync_tx_slot" does not follow the
  rte_<libname>_dynfield_<name> convention in rte_mbuf_dyn.h.


Patch 2/5 doc: describe ethdev timesync clock and Rx timestamp API

Info:

- The commit message says the patch documents existing behaviour
  only. The "must ensure no Tx timestamp operations are in flight
  before disabling" requirement is new in patch 1; move it to
  patch 3.

- The flags argument of rte_eth_timesync_read_rx_timestamp() is not
  explained. ice uses it as the Rx queue index.


Patch 3/5 doc: describe ethdev Tx timestamp slot API

Warning:

- "* **Single Shared Register** (...):" and "* **Adjusted Domain**"
  are term/description bullet lists. Use RST definition lists. The
  same applies to the numbered "1. **Clock Control & Adjustment**:"
  list in patch 2.

Info:

- Indentation is inconsistent in the step 1 and step 4 code
  examples.

- Document how late a slot read may happen. ice extends a 32-bit ns
  value against the current PHC time, so the result is only correct
  within about 2.1 s of capture (see patch 4).


Patch 4/5 net/ice: support per-packet Tx timestamp slots

Error:

- Stale timestamps are returned as valid.

  E810 has no ready register: ice_get_phy_tx_tstamp_ready_e810()
  does "*tstamp_ready = 0xFFFFFFFFFFFFFFFF;". In
  ice_ptp_read_tx_dual_timestamp() the ready-bit test therefore
  never fires, and "if (ret || tstamp == 0)" is the only readiness
  check.

  Nothing clears a slot before it is handed out.
  ice_ptp_alloc_tx_slot() only sets the bitmap bit.
  ice_timesync_enable() does not reset the PHY timestamp memory.
  ice_timesync_disable() clears index 0 only:
  "ice_clear_phy_tstamp(hw, lport, 0);".

  So a slot can still hold a value from a process that exited
  without releasing it, or one the hardware wrote after the
  application timed out and released the slot. The next owner reads
  that value as its own, before its packet is even sent.

  On E822 and ETH56G, release does not touch the PHY at all
  ("if (hw->phy_model == ICE_PHY_E810)"). A timestamp that arrives
  after a timeout leaves the ready bit set for the next owner.

  Fix: in timesync_enable, reset this PF's slot range in PHY memory
  and clear ts_slot_bitmap. In alloc, discard any entry already
  present in the chosen slot.

Warning:

- The legacy index overlaps the allocator. ice_ptp_init_info() sets
  "ad->ptp_tx_index = 0;" on E810, E830 and ETH56G, and base_slot on
  E822. "slot = (uint8_t)rte_ctz64(free_in_range);" therefore hands
  out the legacy slot first.

  A TMST packet without the dynflag uses ad->ptp_tx_index and lands
  in that same slot. On E810, ice_timesync_read_tx_timestamp() now
  also clears that slot after reading it. Reserve the legacy bit in
  ts_slot_bitmap at init.

- "caps->max_slots = 64;" is unconditional, but the allocator limits
  E822 to "64 / ppq" slots per PF. The debug log "all 64 timestamp
  slots busy" is wrong on E822 for the same reason. Compute the
  range once, store it in the adapter, and use it for caps, alloc,
  read and release.

- Read and release only check "slot_id > 63".

  Releasing an unallocated or already-released slot clears a bit
  that another thread may now own, and on E810 zeroes its PHY entry.
  The ethdev header asks PMDs to return -EINVAL in that case.

  On E822, reading a slot outside this PF's range reads another PF's
  quad entry. Per the ice_clear_phy_tstamp_e822() comment, that read
  auto-clears the entry, so this PF steals the other PF's timestamp.

  Check the slot against the PF range and the bitmap.
  rte_atomic_fetch_and_explicit() returns the old value for the
  ownership test.

- "if (ret) return -EAGAIN;" after ice_get_phy_tx_tstamp_ready() and
  ice_read_phy_tstamp() turns sideband and register failures into
  "retry". The caller then polls forever. Return -EIO.

- ice_timesync_tx_slot_alloc() does not check ad->ptp_ena. With
  timesync disabled, or with txpp_ena set (ice_timesync_enable()
  returns 0 without enabling), alloc succeeds and read returns
  -EAGAIN forever.

- The E810 ice_clear_phy_tstamp() call added to the timeout branch
  of ice_timesync_read_tx_timestamp() is unreachable. tstamp_ready
  is all ones on E810, so
  "!(tstamp_ready & BIT_ULL(ad->ptp_tx_index))" is never true. The
  "clear ... after ... a timeout" fix claimed in the commit message
  does not happen.

- No release note entry under "Updated Intel ice driver".

- ice_timesync_tx_slot_alloc() -> ice_get_next_tx_desc_idx() ->
  ice_ptp_alloc_tx_slot() repeats the dev, slot_id and dual NULL
  checks at every level, after ethdev has already validated them.
  ice_get_next_tx_desc_idx is also misnamed; it allocates a slot,
  not a descriptor index. Collapse the layers.

Info:

- get_context_desc() evaluates
  "if (ol_flags & rte_eth_timesync_tx_slot_dynflag)" for every
  packet in the scalar path, before the ice_calc_context_desc() == 0
  early return. That is an exported-variable load (via the GOT in a
  shared build) per packet. Move the lookup into the TMST branch.

- Pre-existing: TSYN is in the "else if" after TSO, so TMST is
  ignored on TSO packets. With slots, the allocated slot then stays
  at -EAGAIN.

- Pre-existing: the vector Tx paths, including the AVX2 and AVX512
  ctx offload paths, never set CI_TX_CTX_DESC_TSYN.

  Tx path selection does not consider ptp_ena, while Rx does
  (ice_set_rx_function). caps still reports PER_PACKET, so a stamped
  packet on a vector path never gets a timestamp.

- Pre-existing: ice_tstamp_convert_32b_64b(hw, ad, 1, ...) writes the
  shared ad->time_hw without synchronization. The slot read adds a
  concurrent writer alongside the Rx path.

- On E810 the legacy read now hits "Failed to read phy timestamp" at
  ERR on every poll until the hardware writes the slot. ptpclient
  and ieee1588fwd both poll in loops, so this floods the log. Log at
  DEBUG and return -EAGAIN.

- "(uint32_t)(uint16_t)idx" double cast. Magic 64 and 63 should be a
  define. Missing space in "RTE_ATOMIC(uint64_t)ts_slot_bitmap;".


Patch 5/5 app/testpmd: add Tx timestamp capabilities command

Warning:

- The "show" command calls rte_eth_timesync_tx_slot_alloc() and
  release(). A show command should not change device state; on E810
  the release zeroes a PHY entry. If a forwarding engine holds every
  slot, the output is "Alloc test: failed (-28)". Drop the
  round-trip.

- testpmd_funcs.rst and the testpmd help text are not updated.

- stamp, read and dynfield_register cannot be reached from testpmd.
  ieee1588fwd is the natural place to use the slot API when the port
  reports PER_PACKET.

Info:

- There is no port_id_is_invalid(res->port_id, ENABLED_WARN) check.
  Print errors with strerror(-ret).
