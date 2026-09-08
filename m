Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF12C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD4A140691;
	Tue,  8 Sep 2026 16:21:12 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id DA1FF402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:21:10 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so4882546a12.3
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788877270;
 x=1789482070; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+AQiIuGvvS92rYxNncCuhWTJbCIjcNhMEqtZBJ3ZVw=;
 b=Fpe9O2cAOpR/PVQb48geHShRQdieXfN6l1mop6fp+tzu9ZbjOH59flH+cDjeR8oe6X
 eX5id1UXqaJsaLw733b7iC2uRU6iNnJNmrY6Zc34T5q1j0RgnpTw4HbD34dozBgnwn8J
 qB7waQPjNYVKBlf9vpgnkhHNszk81IyjQIN7I39WhRaXkAZjBgTJG63DU9yG1iv+YORe
 Va+KLhZYO+hUjHJOFAdz+cHxgVzzyOGLXfxqgknm2AhZjC/Xj1mpiqnOt5KOUL44pcQM
 MYQC6iw0Fu98eClJp6heuoIRdG+ZdMD59ZK2a4cJunEDQA33WHyXvN8p0L9wok3H9OJl
 oELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877270; x=1789482070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+AQiIuGvvS92rYxNncCuhWTJbCIjcNhMEqtZBJ3ZVw=;
 b=RK4t6ZQUHYevHEUzZMeLwe9ZQklI+PEmnJOD7xj4uqxqEHT9ycuyj9XYY9D4YweU2F
 9KNQrH6ubkiqeU3uHJdlt+q5tgn1GO8+HEK3O1gyC7/L8jNMioKrDWooBXKn8L+d9//t
 fCpCj0k+8nwHfct0CZlhj+4QyIigEtwARMdSlXp+mK4YPXwky8D5VwZJ0RrHJ2UEAXM7
 Nedp9gGDxD4NjeOwkdlw1NpuOlO5IJOqVokPBpMkJawBzyApbAhIMMT94nY2QdoqxJvM
 5qZDZ2DyuS/4zzlB7OAh0Edf0T+mk1Mk4IEn4ZV2j/QNmTGOAMglPRSVUUZ/00x8okI6
 jrSA==
X-Gm-Message-State: AFuF++mgNKt0/vOVXQpiFc34917vijDI2cNq5yZ8054NNk8zDJqE1f3M
 csyAR/8Zl0Gpat4g9NSk5hlA2/5JO2X1osbfjmdSpUbgGVMe6ImJbxzExavOpOp6YfuIERWlxhM
 OK7vi
X-Gm-Gg: AYBFou28uRGo/SYGW3uD0E7cROus+VFLUn4aPTCSCHToq08uoCsxE3zXarJGB6uikjT
 lVvxBz6dG0ct4D+8DP79zZV1eSiNAFWhYnyrqr1dqPOa8joc7cMzNU7+RP0aQ3okN2SaKkzuNt/
 2EbsD547wU+5hIdisZWGHdMbiGzXC1VDJBR+fo9V3S84kSDL1i3wAV8Abizx48oy0nKkZxJGPWJ
 ftWpDmw52ga8XFuQiua6JXS9qhtcqLVVOxgdwHmL31q6tDWFV1EdFMshb8imk6Upm3hM5hKSxBJ
 OQ4oWAxBnkbbkghRvkVb5lnagDNl6u7f+WMZSJ9mHWykCw2eF7ILhF6W3loGkbMVa1I//OZVVQu
 Xlx7KQFpgAKeiJbCjg2WvVtVUduHk6/JkPEN5dKqENFB4NWBS5hlwRroM62GKLtYs8OohnQKiwn
 +uK6Hym46D5DvoXWjytNq4B8mh+mOvRiLR3vlIRySYdnMCDImtTTC7D5JfgCaZxHXEisrh0dfO6
 wvCRvHmvd6LPkdL2UPUwMzSs0+YeQ==
X-Received: by 2002:a17:90a:da8f:b0:398:b71e:60c1 with SMTP id
 98e67ed59e1d1-39b26208e7amr41176453a91.12.1788877269374; 
 Tue, 08 Sep 2026 07:21:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc090sm32540799a91.4.2026.09.08.07.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:21:08 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:20:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/15] Wangxun fixes and new features
Message-ID: <20260908072059.1e60a71c@phoenix.local>
In-Reply-To: <7A2945F19DE3AC03+20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <7A2945F19DE3AC03+20260908132742.2661-1-zaiyuwang@trustnetic.com>
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

On Tue,  8 Sep 2026 21:25:45 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
> (CR/KR training, hot-plug, 10G link state), and additionally refines UDP
> offload handling.
> 
> ---
> v2:
>  - add a new commit to handle 10G config on dual-speed DAC
>  - P02: handle TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave link_valid untouched.
>  - P07: resolve the inner tunnel type in a local variable instead of rewriting mbuf->ol_flags.
>         check the rte_pktmbuf_read() result for short or mis-annotated packets.
>         use RTE_GENEVE_DEFAULT_PORT instead of the literal 6081.
>         add a Fixes: tag pointing to the commit that introduced the tunnel offload handling.
>  - P10: split into a bug-fix commit and a feature commit.
>         document both devargs in the NIC guide and the release notes.
>  - P11: check the acquire_swfw_sync() result and only touch I2C while the semaphore is held.
>         replace the magic numbers with named constants.
>         add the release notes entry.
>  - P12: drop the stray C99 comment on the AN-config flag assignment that checkpatch rejects.
>  - P13: reword the message to state that 40G active cables are handled through the optical path.
>         use txgbe_is_dac_cable() in the 40G FFE selection to match the 25G path.
> ---
> 
> ---
> Not changed in this revision:
> 
>  - P11: enable_tx_laser() is not gated by laser_off. laser_off only
>    controls whether the Tx laser is brought down on port stop, while
>    enable_tx_laser() is unconditionally called from dev_start() and
>    dev_set_link_up() and must always bring the laser up, otherwise the
>    default (laser_off=0) configuration would never bring the link up.
> 
>  - P11: no extra restore of PMD_CFG0 bit 1 on the DAC path. Bits 19:12
>    are restored by txgbe_e56_set_phy_link_mode() and
>    txgbe_set_link_to_amlite(); bit 1 (PMD enable) is also restored by
>    txgbe_e56_set_phy_link_mode(), which the xpcs AN path calls on link
>    up, so no additional write is required.
> 
>  - P12: no total iteration bound was added to txgbe_e56_exchange_page().
>    The loop is bounded per page and exits when the AN FSM reaches 0x8,
>    so it does not hang in a normal Clause 73 flow. As this is hardware
>    related configuration, we leave the current behaviour unchanged for
>    now.
> ---
> 
> Zaiyu Wang (15):
>   net/txgbe: fix failure to configure 10G on dual-speed DAC
>   net/txgbe: fix e56 PHY configuration error
>   net/txgbe: fix incorrect link state in 10G forced mode
>   net/txgbe: do not force reconfig on link retry
>   net/txgbe: set i2c sda hold time
>   net/txgbe: fix link speed display info for 10G mode
>   net/txgbe: remove stale outer UDP checksum offload flag
>   net/txgbe: add offload support for tunnel type UDP
>   net/txgbe: fix SFP hot-plug when auto-negotiation is on
>   net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
>   net/txgbe: fix 40G FFE tuning applied to first lane only
>   net/txgbe: add pre2 and backplane capability devargs
>   net/txgbe: add devarg to turn off Tx laser for 40G NIC
>   net/txgbe: fix CR/KR link training and recovery
>   net/txgbe: align link capabilities and DAC classification
> 
>  doc/guides/nics/txgbe.rst              |  18 +++
>  doc/guides/rel_notes/release_26_11.rst |  11 ++
>  drivers/net/txgbe/base/txgbe_aml.c     |   3 +-
>  drivers/net/txgbe/base/txgbe_aml40.c   | 100 +++++++++++++--
>  drivers/net/txgbe/base/txgbe_e56.c     |  14 +--
>  drivers/net/txgbe/base/txgbe_e56.h     |   6 +
>  drivers/net/txgbe/base/txgbe_e56_bp.c  | 161 +++++++++++++++----------
>  drivers/net/txgbe/base/txgbe_e56_bp.h  |   2 +
>  drivers/net/txgbe/base/txgbe_hw.c      |  29 +++++
>  drivers/net/txgbe/base/txgbe_phy.c     |  13 ++
>  drivers/net/txgbe/base/txgbe_phy.h     |   7 ++
>  drivers/net/txgbe/base/txgbe_regs.h    |   3 +
>  drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
>  drivers/net/txgbe/txgbe_ethdev.c       | 120 ++++++++++++++++--
>  drivers/net/txgbe/txgbe_rxtx.c         |  29 ++++-
>  15 files changed, 432 insertions(+), 101 deletions(-)


Looks good, but there are still some leftover items to address.

AI is good at picking out detail but can be wrong. So dont trust it.




Review of "[PATCH v3 00/15] net/txgbe: Amber-Lite link fixes, devargs"

Applied cleanly on d55ccd4 ("pci: remove deprecated catch-all flag").
Reviewed against the post-apply tree.  Build and checkpatch were not
run for this revision.

Closed since the previous revision:

 - The multi-bit speed mask reaching txgbe_set_link_to_amlite() and
   txgbe_e56_tx_ffe_cfg(), which compare with ==.  Patch 01 widens
   allowed_speeds and adds the highest-set-bit reduction ahead of both
   consumers.
 - link_valid set true after TXGBE_ERR_PHY_INIT_NOT_DONE (patch 03).
 - Unchecked rte_pktmbuf_read() and the ol_flags rewrite in
   txgbe_get_tun_len() (patch 08); RTE_GENEVE_DEFAULT_PORT is used and
   the two new TUNNEL_UDP case labels are the right consequence of no
   longer mutating the mbuf.
 - The //aml40-to-do C99 comment.
 - Incomplete txgbe_is_dac_cable() unification (patch 15 converts the
   40G branch of tx_ffe_cfg, rxs_calib_adapt_seq and the aml.c
   capability function as well).
 - Release notes, txgbe.rst entries, named constants for the SFF-8636
   Tx disable byte and PMD_CFG0, and the acquire_swfw_sync return
   checks on the disable path (patches 12 and 13).


Patch 13/15: net/txgbe: add devarg to turn off Tx laser for 40G NIC

Error: the enable path is still not guarded by the devarg.  This was
raised on the previous revision and is unchanged:

  void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
  {
      ...
      if (hw->mac.type == txgbe_mac_aml40) {
          wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
          esdp_reg |= TXGBE_GPIOBIT_1;
          if (hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
              hw->phy.write_i2c_eeprom(hw,
                      TXGBE_SFF_8636_TX_DISABLE, 0x0);

laser_off defaults to 0 and is documented as opt-in, but this I2C
EEPROM write runs on every enable_tx_laser() for every AML40 port
whether or not the user asked for it.

The disable path deliberately branches before touching I2C:

          if (hw->devarg.laser_off) {
                  if (txgbe_is_dac_cable(hw) ||
                      hw->phy.sfp_type == txgbe_sfp_type_unknown) {
                          ... clear PMD_CFG0 19:16, 15:12, bit 1 ...
                  } else if (hw->mac.acquire_swfw_sync(...) == 0) {
                          ... SFF-8636 Tx disable ...

so with laser_off=1 on a DAC cable, down clears those PMD_CFG0 fields
and up writes I2C to a cable that has no EEPROM Tx-disable byte to
write.  Please gate the enable path on hw->devarg.laser_off and mirror
the DAC/QSFP branch.

Warning: the disable path's "no module" case tests

          hw->phy.sfp_type == txgbe_sfp_type_unknown

but patches 09 and 10 in this same series set

          hw->phy.sfp_type = txgbe_sfp_type_not_present;

on module removal.  Those are different enumerators (0 versus 0xFFFE),
so after a pull the disable path falls into the else and issues an I2C
write to an absent module instead of taking the PCS branch.  Test both,
or use one enumerator consistently for "no module".


Patch 14/15: net/txgbe: fix CR/KR link training and recovery

Error: txgbe_e56_exchange_page() can still loop indefinitely.  count2
was added and is incremented on every iteration, but it is only used
in a log message:

          BP_LOG("AN exchange page done in %d ms\n", count2);

The loop bound is still reset from inside the loop body:

          if (rdata & BIT(15)) {
                  wr32_epcs(hw, 0x70016, 0x2001);
                  ...
                  next_page = 1;
                  count = 0; /* reset count to wait next page */
          }

so a link partner that keeps asserting next-page at 0x70019 keeps
resetting count and the loop never terminates.  This revision also
moves the call out of txgbe_handle_e56_bkp_an73_flow() and into
txgbe_dev_e56_check_bp_event(), so it now runs directly in the
interrupt/alarm thread and a wedge there blocks every other alarm in
the process.

count2 is the budget that is needed; it just needs to be enforced:

          if (count2 >= MAX_AN_PAGE_ITERATIONS)
                  return -ETIMEDOUT;

at the top of the loop body would cap the total while still allowing
count to restart per page.

Info (pre-existing, not introduced by this patch): three results in
txgbe_e56_cl72_training() are stored and discarded.  All three lines
are diff context here, so they predate the patch, but the function is
being reworked so they are cheap to fix in passing:

  status = txgbe_set_phy_link_mode(hw, bylinkmode);  /* never read */
  ...
  status = txgbe_e56_get_temp(hw, &temp_data);       /* overwritten */
  ...
  status = txgbe_e56_rxs_adc_adapt_seq(hw, bypass_ctle);

The last one is neither ORed into ret nor returned, so an adc
adaptation failure is silently dropped.

The removal of the early return after txgbe_e56_cl72_training() in
txgbe_handle_e56_bkp_an73_flow() is fine: status is not reassigned
before the return, so a training failure is still propagated and the
idle-detect thresholds are now programmed either way.


Patch 10/15: net/txgbe: fix DAC hot-plug on 40G NIC with autoneg

Warning: the new rearm re-arms without cancelling first, so the poll
chain can be duplicated:

  rearm:
      if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw) &&
          dev->data->dev_started)
          rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);

txgbe_dev_detect_sfp() is also scheduled independently by
txgbe_dev_sfp_event() -- unconditionally on TXGBE_GPIOBIT_2, and again
on TXGBE_GPIOBIT_4 for aml40.  That invocation falls through to rearm
as well and starts a second self-perpetuating 2-second chain, and each
subsequent GPIO event adds another.  Patch 09 handles exactly this for
the other alarm, with the comment "so that only one instance of it is
running at a time":

          rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
          rte_eal_alarm_set(hw->bp_event_interval,
                            txgbe_dev_e56_check_bp_event, dev);

The same cancel is needed before the rearm set.

(The dev_stop path is fine -- rte_eal_alarm_cancel() re-walks the list
in a do/while until nothing matching is executing, so a re-arm issued
by the executing callback is picked up on the next pass.)


Patch 15/15: net/txgbe: align link capabilities and DAC classification

Warning: the *autoneg the patch computes is never read.  All six call
sites of mac.get_link_capabilities pass a local that is not examined
afterwards: txgbe_setup_phy_link_aml40(), txgbe_dev_start(), the two
link alarm handlers in txgbe_ethdev.c, and both FEC ops.  So the new
DAC branch has no effect:

          if (hw->phy.fiber_suppport_speed ==
              TXGBE_LINK_SPEED_10GB_FULL &&
              hw->devarg.auto_neg == 0) {
                  *autoneg = false;
          } else {
                  *autoneg = hw->devarg.auto_neg;
          }

It is also a no-op on its own terms: the guard already requires
hw->devarg.auto_neg == 0, so the else arm yields false anyway and the
whole construct reduces to *autoneg = hw->devarg.auto_neg.

The 25G sibling that this is modelled on writes the field that is
actually consulted:

          if (hw->phy.fiber_suppport_speed ==
              TXGBE_LINK_SPEED_10GB_FULL) {
                  hw->devarg.auto_neg = false;
                  *autoneg = false;

hw->devarg.auto_neg is what txgbe_xpcs_an_enabled() reads.  If the
intent is to force AN off for 10G-only DAC cables on AML40, the aml40
version needs that assignment too; otherwise the comment about the
legacy AUTO=0/1 default does not describe what the code does.

Info: the multispeed_fiber arm is unreachable on this MAC type.
hw->phy.multispeed_fiber is only assigned in
txgbe_identify_sfp_module(), and only under txgbe_mac_aml or the SP
else-branch; txgbe_identify_qsfp_module() never touches it.  So

          } else if (hw->phy.multispeed_fiber) {

never runs on aml40 and the "multispeed fiber must come before
single-sfp/qsfp fiber" ordering comment has nothing to order.


Patch 01/15: net/txgbe: fix failure to configure 10G on dual-speed DAC

Info: the third item in the commit message does not hold.  The message
lists as a blocker that setup_phy_link_aml40() "passed a hardcoded 40
to txgbe_e56_set_phy_link_mode(), ignoring the caller speed", but that
function discards the argument:

  int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
                               u8 bp_link_mode, u32 need_restart)
  {
          ...
          UNREFERENCED_PARAMETER(bp_link_mode);

so replacing 40 with speed changes nothing.  Worth also noting that
the new argument is a bitmask -- TXGBE_LINK_SPEED_40GB_FULL is 0x0040
-- passed into a u8 whose other users in txgbe_e56_bp.c compare it
against 10, 25 and 40.  If the parameter is ever wired up, the value
handed in here will be wrong.  Either drop the hunk and the third
bullet, or convert the speed to a link mode at the call site.


Patch 09/15: net/txgbe: fix SFP hot-plug when auto-negotiation is on

Info: the new module-present sampling is not gated on
!txgbe_is_backplane(hw):

  else if (hw->mac.type == txgbe_mac_aml40)
      value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_PRST_LS;

  if (value != 0 && hw->phy.sfp_type != txgbe_sfp_type_not_present) {
      PMD_DRV_LOG(INFO, "SFP module removed, stop AN73 watchdog.");

On a backplane AML40 port there is no module, so this reports a removal
that never happened and clears sfp_type.  It is harmless for the AN
gate -- txgbe_xpcs_an_enabled() returns true for backplane regardless
of sfp_type -- but the log is misleading.  Patch 10 adds exactly the
!txgbe_is_backplane(hw) guard for its own alarm; the same guard fits
here.


No Reviewed-by on this revision -- the two Errors above are both
carried over unchanged from the previous revision.

Review-Result: ERROR
