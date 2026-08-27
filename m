Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B2C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 20:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9268D40150;
	Thu, 27 Aug 2026 22:11:48 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 81C2E4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 22:11:47 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so135837b3a.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787861506;
 x=1788466306; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AvvJDSzAX1lCLfkhRPi4qNR4o2PFeY5lxIPPeUIWFCw=;
 b=GmBnR2B0oKiY1NZw5P1uYKByhiUwQW0iNmm59ySZfIrKcfzz2pFpdjm6OXkcRHoxqg
 V9aRLoNDDNwsWRNNLFFzgwI1WIKCJ1sltxzKBWGK8gdx0KWwslZLChGsNoJBLVNEwssZ
 nBDapFyWYqxE7Rqo5yQFq/9Q7L5+ta/muWA2uJzUGhuucI/N96KI59dffEMSqhGOWjD7
 vKDAcDL04cOGiEm3h6ShItIXgN098YZV6FFeQ2RDx5EHh76QSPmU6F2FDvZITJio66jB
 KbI/Js1fganJ0eXL8oKsq6hBAOETRJzRlC1k5fuEjOYPHk8zc9rmoC38h36kmtEeXqLb
 AQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787861506; x=1788466306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvvJDSzAX1lCLfkhRPi4qNR4o2PFeY5lxIPPeUIWFCw=;
 b=V37GDLian6GeEnZx9kyUf/4VPRj70b6c8IGWk9fcPndO3DNcSPs7u1wPnTWr2Otice
 x74r3Xbj7zzQKgi1qqbRvtpdIWNct18ELCSI/Md4cjblzh/CrKwZnWR8UrX7kwzsU5am
 4goTt+IlU8zTdGHveZazUIvYefF4pIdFOv+K3BBZtEG6TMN06PJtPgzf/QP3ZDUoxHze
 nI4q27v38QsJf3Kxhy4n36qi3i7ncs3se0f0PbtWRldEUKakD/a8r75EBXZSfhlGWJKa
 3LyzSxeJzkLLZ9BeIJC7ZM2eI0uA/dU+UNKtHE7DriPKX9iGNVm0KEI5qUV/zOnO+wcN
 +54A==
X-Gm-Message-State: AFuF++m8N7aggidhDnrea/Aqpdotb0v1k98RE0k0EcqoP1gYudUQ55xs
 k1FA4C9qsiDwIm+j4HnVZE8M4oqYTXcB+8OPa1amWU8Y1Uicpipdsq/RRIdGWyq2PZjYbMJfCEz
 kgF7b
X-Gm-Gg: AR+sD12NeIluKiigMVhvOHZD/WiCLEnOknTfJDr7FLM9T+gFcjgXjx53NqISQlrPEx+
 ecHx/CjLBJidrOQFgoarmnby0WtMAJN9Ymg+sHKThdIarPsTPnislxXK8S5Mhwc6VlCTcmfU9t6
 AVlnkRobAddpsOb2cpDKjwSa12mu0dRPmoenNI09BNWjZE1pGI3LpcghM/aYdFMe+Q8CWheATma
 oGZKAAFjnzm/0V6WmNR5qM3tYU8RDYq2S1m6t4wRvH3r2hTA71Em6V/K4l4mbIDJZi/cGNnZd/P
 7w71MMfWSkZVlZABY45iMyMeq71Kv1T7+6V00BXsPzKYHecpoc78CCUugBKtl4u73UpmLLgmYvG
 S1vwnz5PB9HeZ1MmBgMxeV/rcyBcGo7l4CuthW1upLJtyKCfTkqgfo+nC8fq8SJ9YARfYCK9e3t
 d2y734pwcvxQePWA/buf0VdHMYQsO74I7fCYj0efKsZ1Kk3nUnmtIflfOZIW9djWgNw14MeDe2Q
 K/buEsFRpB0VNw9KXjwqYHwkUs2nA==
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3d267a6b517mr3214927637.10.1787861506274; 
 Thu, 27 Aug 2026 13:11:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283da25c8asm23260731eec.30.2026.08.27.13.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 13:11:46 -0700 (PDT)
Date: Thu, 27 Aug 2026 13:11:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/13] Wangxun fixes and new features
Message-ID: <20260827131137.1daf141c@phoenix.local>
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
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

On Thu, 27 Aug 2026 19:41:52 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G N=
ICs (CR/KR training, hot-plug, 10G link state), and additionally refines UD=
P offload handling.


Using Claude AI review (versus the simpler CI AI review) shows several issu=
es
that need addressing before this can be merged.

Here is my edit of the wordy AI feedbac.

Patch 02: net/txgbe: fix incorrect link state in 10G forced mode

Warning: the new else branch sets link_valid on a PHY init failure.

  ret_status =3D txgbe_set_link_to_amlite(hw, speed);
  if (ret_status =3D=3D TXGBE_ERR_TIMEOUT)
          hw->link_valid =3D false;
  else
          hw->link_valid =3D true;

txgbe_set_link_to_amlite() can also return TXGBE_ERR_PHY_INIT_NOT_DONE
(VR_PCS_DIG_CTRL1 reset never cleared), which now falls into the else
and marks the link valid after the PHY failed to come out of reset.

The 25G sibling in txgbe_aml.c handles that code separately, before
the timeout/else split, precisely so link_valid is left alone:

  if (ret_status =3D=3D TXGBE_ERR_PHY_INIT_NOT_DONE)
          goto out;
  if (ret_status =3D=3D TXGBE_ERR_TIMEOUT) {
          hw->link_valid =3D false;
          ...

Suggest matching the aml.c structure here.


Patch 05: net/txgbe: fix link speed display info for 10G mode

Warning: allowed_speeds is not extended to match.  txgbe_dev_start()
still has

  if (hw->mac.type =3D=3D txgbe_mac_aml40)
          allowed_speeds =3D RTE_ETH_LINK_SPEED_40G;

so an application that explicitly requests RTE_ETH_LINK_SPEED_10G on an
AML40 port is still rejected with "Invalid link setting", even though
the driver now configures and reports 10G links.  Either add
RTE_ETH_LINK_SPEED_10G to allowed_speeds or explain why 10G is
autoneg-only.

See also the Error under patch 13 =E2=80=94 the 40G|10G mask added here bec=
omes
harmful once patch 13 widens the capability mask.


Patch 07: net/txgbe: add offload support for tunnel type UDP

Error: unchecked rte_pktmbuf_read() return, then dereferenced.

  uh =3D rte_pktmbuf_read(mbuf, mbuf->outer_l2_len + mbuf->outer_l3_len,
                        sizeof(udphdr), &udphdr);
  if (uh->dest =3D=3D rte_cpu_to_be_16(6081))

rte_pktmbuf_read() returns NULL when off + len > pkt_len.  outer_l2_len
and outer_l3_len come from the application and are not validated by the
driver, so a short or mis-annotated packet gives a NULL dereference in
the Tx fast path.  Please add a NULL check.

Note the neighbouring GRE and GENEVE cases have the same unchecked
pattern, so this is a pre-existing habit in the function rather than
something the patch invents, but the new code should not extend it.

Warning: txgbe_get_tun_len() rewrites the application's mbuf.

  mbuf->ol_flags &=3D ~RTE_MBUF_F_TX_TUNNEL_UDP;
  ...
  mbuf->ol_flags |=3D RTE_MBUF_F_TX_TUNNEL_GENEVE;   /* or VXLAN */

The Tx burst should not mutate ol_flags of a buffer it does not own.
The application still owns the mbuf and may inspect or re-transmit it
(cloned/multicast paths transmit the same mbuf more than once), and a
second pass then sees VXLAN/GENEVE instead of UDP.

Only the local switch below needs the resolved type, so a local
variable would do:

  uint64_t tun_type =3D mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK;

  if (tun_type =3D=3D RTE_MBUF_F_TX_TUNNEL_UDP) {
          ...
          tun_type =3D (uh->dest =3D=3D rte_cpu_to_be_16(RTE_GENEVE_DEFAULT=
_PORT))
                     ? RTE_MBUF_F_TX_TUNNEL_GENEVE
                     : RTE_MBUF_F_TX_TUNNEL_VXLAN;
  }
  switch (tun_type) {

This also removes an ordering subtlety: txgbe_xmit_pkts() snapshots
ol_flags into tx_ol_req before calling txgbe_get_tun_len(), so
tx_desc_ol_flags_to_ptid() and txgbe_set_xmit_ctx() see the original
TUNNEL_UDP while the mbuf itself has been rewritten.  The two new case
labels are correct today only because of that ordering.

Warning: Cc: stable@dpdk.org with no Fixes: tag.  The commit body
describes a defect (packets sent with a wrong descriptor or dropped),
so a Fixes: tag looks appropriate; otherwise drop the stable Cc.

Info: use RTE_GENEVE_DEFAULT_PORT from <rte_geneve.h> rather than the
literal 6081.


Patch 10: net/txgbe: add backplane FFE and capability devargs

The move of txgbe_parse_devargs() to after txgbe_init_shared_code() is
safe -- init_shared_code() only sets the MAC type, the ops tables,
max_link_up_time and the LAN id, and reads no devarg.  Wiring bp_capa
up is a real fix too: txgbe_e56_bp.c already branched on
hw->phy.bp_capa but nothing ever set it, so it was permanently 0.

Warning: the patch adds two new devargs (ffe_pre2, bp_capa) under a
Fixes: tag with Cc: stable@dpdk.org.  New configuration options are not
backport material.  Suggest splitting the ffe_pre2/bp_capa plumbing out
as a plain feature patch without the stable Cc, and keeping the stable
Cc only for the 40G per-lane FFE replication, which is the actual bug.

Warning: no release notes entry for the new devargs.


Patch 11: net/txgbe: add devarg to turn off Tx laser for 40G NIC

Error: the enable path is not guarded by the devarg.

  void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
  {
          if (hw->mac.type =3D=3D txgbe_mac_aml40) {
                  ...
                  txgbe_acquire_swfw_sync(hw, 1);
                  hw->phy.write_i2c_eeprom(hw, 86, 0x0);
                  txgbe_release_swfw_sync(hw, 1);

laser_off defaults to 0 and is documented as opt-in, but this I2C write
runs for every AML40 port on every enable_tx_laser(), whether or not the
user asked for it.  The disable path deliberately branches on
txgbe_is_dac_cable() / sfp_type before touching I2C; the enable path
does neither, so it also issues an I2C EEPROM write when a DAC cable or
no module is present.

Please guard it with hw->devarg.laser_off and mirror the DAC/QSFP
branch from the disable path.

Warning: with laser_off=3D1 on a DAC cable, disable clears PMD_CFG0 bits
19:16, 15:12 and bit 1.  Bits 19:12 are restored by
txgbe_e56_set_phy_link_mode() and by txgbe_set_link_to_amlite(), but I
could not find anything that restores bit 1 on the xpcs AN path --
only txgbe_set_link_to_amlite() sets it, and that is not called when
txgbe_xpcs_an_enabled() is true (DAC plus auto_neg=3D1, which is exactly
the configuration this devarg targets).  Could you confirm bit 1 is
restored somewhere on the AN path, or clear only what gets restored?

Warning: unchecked return values on the new calls.
txgbe_acquire_swfw_sync() returns TXGBE_ERR_SWFW_SYNC on a semaphore
timeout; on failure the code still performs the I2C write and then
releases a semaphore it does not hold.  write_i2c_eeprom() also returns
s32.  The convention elsewhere in the driver is

  err =3D hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
  if (err !=3D 0)
          return;

Info: several magic numbers.  0x1400 has a define, PMD_CFG0, in the
txgbe_e56.h that this patch now includes; 19:16 has one too,
E56PHY_PMD_CFG_0_RX_EN_CFG.  The semaphore mask 1 should be
TXGBE_MNGSEM_SWPHY (same value, clearer).  Byte 86 / 0xf is the
SFF-8636 Tx disable register and its all-lanes value -- both deserve
names.

Info: no release notes entry for the new devarg.


Patch 12: net/txgbe: fix CR/KR link training and recovery

Error: leftover TODO and a C99 comment (checkpatch ERROR),
txgbe_ethdev.c:3806:

  intr->flags |=3D TXGBE_FLAG_NEED_AN_CONFIG;//aml40-to-do

Error: txgbe_e56_exchange_page() can loop indefinitely.  The loop bound
is reset from inside the loop body:

  for (count =3D 0; count < 50; count++) {
          ...
          if (rdata & BIT(14)) {
                  if (rdata & BIT(15)) {
                          wr32_epcs(hw, 0x70016, 0x2001);
                          next_page =3D 1;
                          count =3D 0; /* reset count to wait next page */
                  }
          }
          ...
          usec_delay(1000);
  }

The reset is not gated on base_page or on any independent budget, so as
long as the link partner keeps asserting next-page at 0x70019 the loop
never terminates.  This runs from txgbe_dev_e56_check_bp_event() in the
interrupt/alarm thread, so a peer that keeps requesting next pages wedges
that thread and blocks every other alarm on the process.

count2 already counts total iterations -- it just is not used as a
bound.  Something like

  if (count2 >=3D MAX_AN_PAGE_ITERATIONS)
          return -ETIMEDOUT;

would cap the total while still allowing count to restart per page.

Info: the "50ms timeout" comment no longer matches the code once count
can be reset; the effective wait is 50 ms per page, unbounded overall.

Info: falling out of the loop into the check_ability label and then
distinguishing the two paths by testing count =3D=3D 50 is hard to follow.
An explicit "goto timeout" would read better.


Patch 13: net/txgbe: align link capabilities and DAC classification

Error: the widened capability mask lets a multi-bit speed reach code
that tests it with =3D=3D, so backplane and multispeed-fiber ports get
configured for 10G instead of 40G.

After this patch, get_link_capabilities_aml40() returns
10GB_FULL | 40GB_FULL for backplane and for multispeed fiber.  Patch 05
made txgbe_dev_start() request 40GB_FULL | 10GB_FULL on autoneg, so
"speed &=3D link_capabilities" in txgbe_setup_phy_link_aml40() now leaves
both bits set, where before patch 13 the mask reduced it to 40G alone.

Both downstream consumers test for equality:

  /* txgbe_set_link_to_amlite() */
  if (speed =3D=3D TXGBE_LINK_SPEED_40GB_FULL) {
          ... 40G config ...
  } else {
          ... 10G config ...     /* taken with both bits set */
  }

  /* txgbe_e56_tx_ffe_cfg() */
  if (speed =3D=3D TXGBE_LINK_SPEED_10GB_FULL) ...
  else if (speed =3D=3D TXGBE_LINK_SPEED_25GB_FULL) ...
  else if (speed =3D=3D TXGBE_LINK_SPEED_40GB_FULL) ...
  /* no branch matches; ffe_main/pre1/pre2/post stay 0 and are
   * written to the PHY as zeros */

Reachable whenever txgbe_xpcs_an_enabled() is false, which is the case
for backplane with auto_neg=3D0 and for multispeed fiber always (it
requires DAC or backplane).  For backplane the FFE path is entered
unconditionally, so both symptoms occur together.

Either resolve the mask to a single speed before calling setup_link, or
have txgbe_set_link_to_amlite()/txgbe_e56_tx_ffe_cfg() select the
highest set bit rather than comparing for equality.

Warning: the commit message and the code disagree about active DACs.
The message says

  "Unify DAC classification on txgbe_is_dac_cable(), so active DACs are
   no longer treated as optical modules."

but txgbe_qsfp_type_40g_active_core0/1 is added to
txgbe_is_40g_fiber_qsfp() and not to txgbe_is_dac_cable().  An active
40G cable therefore still takes the optical path: no DAC FFE values in
txgbe_e56_tx_ffe_cfg(), bypass_ctle left true in
txgbe_e56_rxs_calib_adapt_seq(), tx_ffe_cfg not called at all from
txgbe_setup_phy_link_aml40(), and AN off.

For comparison, the 10G equivalent txgbe_sfp_type_da_act_lmt_core0/1 is
in txgbe_is_dac_cable().  SFF-8636 byte 131 bit 0 is "40G Active Cable
(XLPPI)", which covers active copper as well as AOC.

Please either add the 40g_active types to txgbe_is_dac_cable() or
reword the commit message to say they are handled as optical.

Info: the unification is incomplete.  The 25G branch of
txgbe_e56_tx_ffe_cfg() was converted to txgbe_is_dac_cable(), but the
40G branch a few lines above still open-codes

  if (hw->phy.sfp_type =3D=3D txgbe_qsfp_type_40g_cu_core0 ||
      hw->phy.sfp_type =3D=3D txgbe_qsfp_type_40g_cu_core1 ||
      txgbe_is_backplane(hw))

which will keep missing any type added to txgbe_is_dac_cable() later.

