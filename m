Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C2DC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:35:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44718402C8;
	Tue, 22 Sep 2026 15:35:23 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 878C1402B0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:35:22 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso3268074b3a.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790084121;
 x=1790688921; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tDhTLg2FXEwR0omgLD0Uo8fx6g33ARKE5sDiFOCyUAc=;
 b=QbNrk38waW/OmKKREWwGqJKWWCW2Wt0vYYXdVlrWF3QgZTjLo7JpEbtcdrXtsn0C9A
 wdwyQcO/kdl6+zMeS5hoPShI++ZxAejJOvi5c9EtLH7tN1WWsFeDsNGdbTYdMLRb6xdX
 9+pooVEB8W5amHxIemmxhey0bMlU6+4qAx4D4QAp8vxHsTsJPF1tLVM9FbCzAcsEBBLv
 KV6yaylgYcAK6EKLHYmyqSrCVjfGd/qVXiNAhkJAVWINk24yPEug6aQDCMSmZmC/Uvkn
 mzVirgoAOoeI8cL7tBbt7U0Rti2UEBNcKa/l6qIl3ZicNYh0jhRZzHmXlf1i++xIw0tY
 ER8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084121; x=1790688921;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tDhTLg2FXEwR0omgLD0Uo8fx6g33ARKE5sDiFOCyUAc=;
 b=GiXPgX5H2XRcsqFgIP08CAOfRCBSfH8zCWIKSweitFMGiUmlUQ1hBJgAQW71YDIsn8
 S2+6DxjYoe+3Vy7xUIj08lvuKtpXFKdn4ez32wVO2Qyc16iPaOidtHex+kB7noyyG/EB
 3m5F6pqhoFgxMgbPheu1XsgVx7lMOkDiduXc9znXgRRgOSVk7RJqYyYx472tVp+3ZDwp
 3TWbZQ+2Dtl89kTNjNXQdOSTpjUK+vdIjzCJRRtInQfdruin6sPEOX8yc49BD32dwhfk
 W0UDawRBsqBwhfRNQw+0Qsymxe1wA0Xy9qGa7vDBtCLtBUdkckf0ZWgTdYbLsE94n76t
 hfwA==
X-Gm-Message-State: AFuF++lSi/37o0WEGuuZ0U/QYCdfd/r5vRMxXso6qxYr2EjSKPaq00mM
 n9kCaaIu3OSvl8zQRfBdqnA/oGYjc/T/+TojPNLptbOtQiE7MritNfFeRwNm0xT4N+0=
X-Gm-Gg: AYBFou0wYij6G0KhcO2TiQtTLBF9D4QVShZQuW/hKb6j1or0j4pcEBRjf4YO/an4xVV
 j77oBQedc32Vc2KYR248unGiM5tpPJC69PXACK6OQzI1ZtF334E3kh4MGxL4pl1NAwC0Y4WMY3c
 XpkyJsE73WGUDKZvDrLpZBMhQpeRXmaMP4VRr2NJKwP5jQrJj7iSFA/aibrVH8B0tWyO9cnjc3t
 GO9JsGInVagW3J+6LEwLt3OMJHp2A18J/WXJJTUSXLfGIa18JmoQeNfxGWQHuCvu66im6FMx/v8
 DzEydn/yMBtDpsu2iC4Ej45iAtmMPyYsYwaylv/bnL7OSJ2ag4I+EKlOOgv6Uw6KfLnuzZ4eUtX
 Li3E5CRTIsOptbG80g3S9vU5Vxs2HLueIaPsDZ0R95cvtY7ZsZVnsxNnv3wrXgVPJSMyRM7RUe3
 uhlAKOjksg94cO++AUgaOEgFENkIAZ9jj89XKn82aMq20louFG2Rc1YKzsi2xZWgL2XmIbAqbSC
 nVmWW11+AbIWHK0tfXk9xUNP6h4nw3zOQq7dHHq
X-Received: by 2002:a05:6a00:21c5:b0:860:507d:503e with SMTP id
 d2e1a72fcca58-87c8269a510mr1314223b3a.20.1790084121379; 
 Tue, 22 Sep 2026 06:35:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87c2fb54c55sm894929b3a.1.2026.09.22.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:35:21 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:35:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/16] Wangxun fixes and new features
Message-ID: <20260922063519.6cebed39@phoenix.local>
In-Reply-To: <D88DBAEE6DF34BF1+20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <D88DBAEE6DF34BF1+20260922125414.3638-1-zaiyuwang@trustnetic.com>
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

On Tue, 22 Sep 2026 20:37:33 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
> (CR/KR training, hot-plug, 10G link state), and additionally refines UDP
> offload handling.
> 
> ---

These AI comments look like the need addressing

Review: [PATCH v4 00/16] net/txgbe: Amber-Lite link and offload fixes
Author: Zaiyu Wang <zaiyuwang@trustnetic.com>

Series applies to main; every commit builds with -Dwerror=true.
Fixes: hashes resolve except the one noted in 13/16.


Patch 10/16: net/txgbe: fix SFP hot-plug when auto-negotiation is on

Warning: AN73 watchdog can be re-armed after dev_stop

  txgbe_dev_detect_sfp() now calls rte_eal_alarm_set() for
  txgbe_dev_e56_check_bp_event with no started check. dev_stop
  cancels check_bp_event first (txgbe_ethdev.c ~2121) and
  detect_sfp second (~2126). A detect_sfp instance running in the
  alarm thread between the two cancels, or one armed by a GPIO
  interrupt before txgbe_disable_intr(), re-arms the watchdog on a
  stopped port. check_bp_event re-arms itself unconditionally at
  "out:", so it keeps running, and after dev_close it dereferences
  freed port data.

  Patch 11 gates its own re-arm on dev->data->dev_started, but that
  flag is only cleared after dev_stop returns, so it does not close
  this window either. Cancel txgbe_dev_detect_sfp before
  txgbe_dev_e56_check_bp_event in dev_stop, and skip the re-arm in
  detect_sfp when hw->adapter_stopped is set.


Patch 09/16: net/txgbe: add offload support for tunnel type UDP

Warning: RTE_MBUF_F_TX_TUNNEL_UDP resolved by destination port

  The generic UDP tunnel flag is defined for tunnels that are not
  VXLAN or GENEVE. txgbe_get_tun_len() maps port 6081 to GENEVE and
  everything else to VXLAN, i.e. a fixed 16 byte UDP+VXLAN header.
  Any other UDP encapsulation gets a wrong tunnel length, so the
  inner checksum and TSO offsets are wrong, and GENEVE on a
  non-default port loses its options length. Since the driver
  advertises RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO, either reject tunnels
  it cannot size in txgbe_prep_pkts() or stop advertising the
  capability.

Info: the new rte_pktmbuf_read() NULL check is right, but the GRE
  and GENEVE cases in the same switch still dereference grh and gh
  without one. Same fix, same function.


Patch 13/16: net/txgbe: fix unset pre2 FFE tap and backplane capability

Warning: Fixes: 6104fd11089d does not exist. The 25G commit is
  6104fd11086e, as used in 05/16 and 12/16.

Warning: this is a feature, not a fix

  The recommended pre2 values are S25G_TX_FFE_CFG_DAC_PRE2 = 0x0 and
  S40G_TX_FFE_CFG_PRE2 = 0x0, so programming ffe_pre2 = 0 was never
  wrong. bp_capa = 0 is the existing KR4+CR4 behaviour. What remains
  is two new devargs, which do not belong in stable. Drop the Fixes
  tags and Cc: stable.

  The patch also changes the ffe_main/pre/post defaults on the 25G
  MAC from 27/8/44 to 0x2a/0x03/0x11. Neither the commit message nor
  txgbe.rst mentions this; the guide still documents 27, 8 and 44.

Info: bp_capa is not range checked. Any value above 2 advertises no
  40G ability at all on the 40G backplane.


Patch 16/16: net/txgbe: align link capabilities and DAC classification

Warning: get_link_capabilities_aml40() clears hw->devarg.auto_neg

  For a DAC whose fiber_suppport_speed is 10G only, the new DAC
  branch writes hw->devarg.auto_neg = false. Nothing sets it back.
  With the hot-plug support in 10/16 and 11/16, replacing that
  module with a 40G QSFP DAC leaves txgbe_xpcs_an_enabled() false,
  so AN73 never runs until the port is re-probed. The aml function
  has the same pattern, but hot-plug now makes it reachable on
  aml40. Return *autoneg = false without touching the devarg.

Info: PMD_DRV_LOG in base/txgbe_aml40.c; base code uses DEBUGOUT.
  txgbe_is_40g_fiber_qsfp() and txgbe_is_10g_fiber_sfp() return int
  with true/false; make them bool.


Patch 02/16: net/txgbe: use the requested speed in E56 AN setup

Info: default AN advertisement changes. With dev_start passing
  10G|25G (aml) or 10G|40G (aml40 after 07/16), the backplane
  branch now advertises 10GBASE-KR on the 25G and 40G parts, where
  previously it advertised only 25G or only 40G. Say so in the
  commit message.


Patch 07/16: net/txgbe: fix link speed display info for 10G mode

Info: adding 10G to the aml40 autoneg speed mask is not needed for
  the reported speed; that comes from the new PORTSTAT check. It
  changes what is advertised (see 02/16) and belongs with 01/16.


Patch 15/16: net/txgbe: fix CR/KR link training and recovery

Info: the CL72 poll (400 x 1 ms) and the page exchange (up to
  200 x 1 ms) busy-wait inside txgbe_dev_e56_check_bp_event(), which
  runs on the EAL interrupt thread. This stalls interrupt and alarm
  handling for all ports.

Info: BP_LOG expands to RTE_LOG, so its arguments are evaluated even
  when the log type is disabled. txgbe_e56_get_txffe() and the new
  "an_int" arguments do a dozen PHY reads per call only for logging.
  The BP_LOG("%s %d\n", __func__, __LINE__) in check_bp_event is a
  leftover debug line.
