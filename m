Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D1CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13E3340279;
	Mon, 12 Oct 2026 23:41:10 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id B77BB40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:41:08 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e87c66e556so9335855ad.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791841268;
 x=1792446068; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBvk++G//pi9b8/hXmPpG/MJMBQoZOBSlHIlA3rLKwg=;
 b=dwqZd93HiGM+kn3Y0H9yP496goJPNnybFKmUyg4AmrNde8jUISEhhf+1ZcIdQg2UmU
 6VMZi3xQf0N5Y2/rNkUguk0Pxu/bDVPgt3ocrvtSDRs6eWmuYAPxRRoBObuo6iAVRIPR
 jlJrkRdmypBMkRHddsNm0SfoO2AzxLEi+JTVjPsICZt8UMKmoSEsO+ajNZlvXYtq65sc
 HQsVQmQpXVCaxb1w4qnGDdu6OOSe5Z9BY8KmRC9TOiOt/U6NVKgRGvcb+zR5tz4U0jI9
 Njizq217t7PWL3Cw9jNiU3d3gBWpafHoLdIV1MUYok1S8QKrrzzLrJ/VyIplhd0GgJR0
 c2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841268; x=1792446068;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBvk++G//pi9b8/hXmPpG/MJMBQoZOBSlHIlA3rLKwg=;
 b=Hp0UMQIfz8nVBJSeTUGl0ydXSKoqnAjlyQU9A0ju/K9uxdtqCJhZWi1RnfZkcNiUsW
 VdWCrnKfrpeJPOiQUG0BtmfaYnHJKBvXEcvfcX8PSt7WPES50x+J71B/axIEZhJmX6Ne
 3/5PayGDcHtjbkmYVLKCN94gXUmDSNLiute9M/mgQCBI2R4ne+FcLCqHrZeeD5pvt8bf
 IOVT0uBy5LAIAMzsY0AHu914Dr4rbaCsKuEgSz/LGuFqXMLk3DHGGLtALAAnXo8Nt3q4
 yEQDMlQGoPI9j2/X4oB6mlCIBgBey3RYoIySrrqlKIzspuM5Hn5hnZZ3Bs7QaphKDYx9
 042w==
X-Gm-Message-State: AFq9FYLwovZ1nMDjGFtk9D0LOXL/gNehKfvzhBA6FovWSf5b4N8OzV2x
 w7OHTfuHz5X9jhwMaaNoKQRHWRJq6HeWq+3xVWgbnfeRjeQ9Kah1IQgKQLNxFoTI8fDT7XIyFFq
 eZKDaSCw=
X-Gm-Gg: AYBFou3FMXSDYsF44SJjy/FTAsl2BIZB6r2oIiIcfjosUkg5dQ3n+jwQKvIgLnoOjhs
 nymJ6ltJB/rgem5K+OSwHbjFC9x2eyc0XMi9GqB9cTYzksUzRst6KjrdV2drcXdlI0S7pYx85Yn
 o37o6agyNV3CYSaTpva4oQlilE0gDUME61/2H5pWPS+7m/k60AUebstYFmxDmR/pjxisQv4NyjI
 wSnZ+3iRbxflJnMS94jyRkBRKA/KuGp8HIY2YixyPSTUtCWMvhekJDiCaKQcXUZ2q1tAsDvQYFw
 +e4NH1wafrJHGt5+P7+vSBVky9zP5Zp9x+pXcytkwpcXGLfxz+0h+pDYHagxuX98sUIw+NtmGL5
 jxrGyGqADJGRAo7AhKRcw0Oe0DT4c4v59Hfw2qRTOZ2+ERr5flMmu/l6zlaNzkqiCaWd5KUMCay
 qwEw8HtMXAvFDayVQ0FYVpt9z7RbTt3GorCFNnOuwRecygn1vG/NaSwUCSMFqgl+fcJAVcuZtC0
 jff/Q3cdTnoBODkz1X+ItoajsAGAjLtirSxvQYh
X-Received: by 2002:a17:902:f78f:b0:2e2:c94f:25f7 with SMTP id
 d9443c01a7336-2e8403c3d92mr68480125ad.5.1791841267481; 
 Mon, 12 Oct 2026 14:41:07 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421af46asm47390515ad.39.2026.10.12.14.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:41:06 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:41:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 00/16] Wangxun fixes and new features
Message-ID: <20261012144104.5ea78646@phoenix.local>
In-Reply-To: <AD092E591B8D145D+20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <AD092E591B8D145D+20261012110518.1911-1-zaiyuwang@trustnetic.com>
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

On Mon, 12 Oct 2026 18:56:17 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v8:
>  - P05: keep a retry from reconfiguring an established AN73 link, while
>         still restarting PHY configuration when the link is down or AN is
>         incomplete.
>  - P10: on AML40, mark unsupported and unclassifiable QSFP modules as
>         unknown so the module poll does not repeatedly identify them or
>         rerun module and link setup.
>  - P12: place the txgbe release-note entries between the Solarflare and
>         ZTE driver entries.
>  - P13: rerun complete AML40 link setup on set_link_up() with laser_off
>         enabled, restoring the DAC configuration without adding a separate
>         state flag.
>  - P14: correct the AN FSM condition described in the commit message
>         and remove the stray line after the Signed-off-by trailer.
>  - P15: assign the detected 10G speed for passive and active-limiting
>         DACs, and remove the unreachable AML40 10G SFP capability branch.
>  - P16: add a new patch to keep Amber-Lite ports administratively down
>         by preventing the AN73 watchdog and setup-link retry paths from
>         configuring PHY while hw->dev_start is cleared.
> ---

Still lots of issues shown from running Claude AI review from web.

Subject: Re: [PATCH v8 00/16] net/txgbe: Amber-Lite link fixes

Series applies cleanly to main and every commit builds with
-Dwerror=true. All Fixes: hashes resolve.

Two errors: patch 16 can leave the link permanently down after a
set_link_down/set_link_up cycle, and patch 13 adds a driver-specific
devarg that changes set_link_down semantics.


Errors
------

[PATCH v8 16/16] net/txgbe: respect manual link-down on Amber-Lite

The early return in txgbe_dev_setup_link_alarm_handler_aml() skips
clearing TXGBE_FLAG_NEED_LINK_CONFIG.

On 25G SFP (media_type fiber) with LSC enabled, set_link_down()
calls txgbe_dev_link_update(); link is down, so link_update_share()
sets NEED_LINK_CONFIG and spawns the link thread. The thread calls
the AML handler, which now returns because dev_start is false, and
the flag stays set. After that, every txgbe_dev_link_update_share()
returns link down at the NEED_LINK_CONFIG check before calling
check_link or starting a new thread, including the call from
set_link_up(). Nothing else clears the flag, so the port reports
link down until the application restarts the process.

Clear the flag before returning:

	struct rte_eth_dev *dev = hw->dev_back;
	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
	...
	if (!hw->dev_start) {
		intr->flags &= ~TXGBE_FLAG_NEED_LINK_CONFIG;
		return;
	}


[PATCH v8 13/16] net/txgbe: add devarg to turn off Tx laser for 40G NIC

NAK on the devarg. rte_eth_dev_set_link_down() is supposed to take
the link down, and the peer seeing loss of signal is the point of
it. Whether that happens should not depend on a per-driver knob.
Make it the unconditional behaviour on AML40 when link is set down,
and run link setup unconditionally in set_link_up().

The commit message already shows the cost of the knob: the enable
path has to stay ungated because a previous run with laser_off=1
can leave the module transmitter disabled. Without the devarg that
case goes away.


Warnings
--------

[PATCH v8 03/16] net/txgbe: fix e56 PHY configuration error

Commit message says the wrong field degrades both 40G and 10G, but
only txgbe_e56_cfg_40g() is changed. txgbe_e56_cfg_10g() still has
the same write:

	addr = E56PHY_RXS_RINGO_0_ADDR;
	rdata = rd32_ephy(hw, addr);
	set_fields_e56(&rdata, 9, 4, 0x366);

cfg_25g and the e56_bp.c copies already use (21, 12). Either fix
cfg_10g in this patch or reword the message to say 40G only.


[PATCH v8 12/16] net/txgbe: add pre2 FFE tap and backplane capability devargs

bp_capa is not range checked. Any value other than 0..2 leaves the
40G block in txgbe_e56_set_phy_link_mode() advertising nothing for
40G. Validate it in txgbe_parse_devargs():

	if (bp_capa > 2) {
		PMD_INIT_LOG(WARNING, "invalid bp_capa %u, using 0",
			     bp_capa);
		bp_capa = 0;
	}

Also, why is KR4 vs CR4 a user setting at all? This is a property
of the board; derive it from the subsystem id if possible.


Info
----

[PATCH v8 02/16] net/txgbe: use the requested speed in E56 AN setup

The three ifs building autoneg_advertised reduce to:

	hw->phy.autoneg_advertised = speed &
		(TXGBE_LINK_SPEED_10GB_FULL |
		 TXGBE_LINK_SPEED_25GB_FULL |
		 TXGBE_LINK_SPEED_40GB_FULL);

Drop "as the base layer of the out-of-tree driver does" from the
commit message; the change stands on its own.


[PATCH v8 10/16] net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation

With no module plugged in, every 2 s poll goes to the NOT_PRESENT
branch, logs "SFP not present." and cancels the watchdog again. Act
only on the transition:

	} else if (err == TXGBE_ERR_SFP_NOT_PRESENT) {
		if (hw->phy.sfp_type != txgbe_sfp_type_not_present) {
			PMD_DRV_LOG(INFO, "SFP not present.");
			hw->phy.sfp_type = txgbe_sfp_type_not_present;
			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event,
					     dev);
		}
	}


[PATCH v8 11/16] net/txgbe: fix 40G FFE tuning applied to first lane only

On AML40 a user ffe_* value above 0xFF is silently truncated by
S40G_TX_FFE_4LANE(). Reject or warn instead.


[PATCH v8 12/16] and [PATCH v8 13/16]

12 adds a stray blank line in release_26_11.rst and 13 removes it.
Drop the hunk from 12.


[PATCH v8 15/16] net/txgbe: align link capabilities and DAC classification

The comment "mirroring the temporary workaround in the previous
version" describes patch history, not the code. Suggest:

	/* Unknown module: report 40G so setup_mac_link() does not
	 * fail with TXGBE_ERR_LINK_SETUP.
	 */

The DEBUGOUT added at the top of txgbe_get_link_capabilities_aml40()
now runs on every watchdog tick, since txgbe_xpcs_an_enabled() calls
get_link_capabilities(). Remove it.

The bullet "Remove the AML40 10G SFP capability branch" describes a
branch that is not in the tree this patch applies to. Drop it.
