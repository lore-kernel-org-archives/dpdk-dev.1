Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4C606A33C
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EBAQ14tb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F8624067D;
	Mon, 26 Oct 2026 17:29:05 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 7CC6A4064F
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:29:03 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so642015ad.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793032142;
 x=1793636942; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PcJdnTOR9oPVG1HJwnlp66rAuJFlVdaPexJudoA2ijM=;
 b=EBAQ14tb1H2txrK5GbiZI0LMcLoasyq0e52WeB3aVd9jwfdnzzaA/z5RlgvrrMH6Js
 9jook8paUwPMaku5yLmLt8PWMtrL1fwxer4kQOAzME+QLX8eIvC1AzBKu2Pglw4RpIiH
 ctC1ADzVJKtEe7K0HFsCiTJNrX17lAwml7sZDla1QKHp5l7tgK6W4S1aOTZbzDzNbka+
 PnPTvyOFWYtmIoPc7smizNH2FoziR/bdRZUc/lHk8s1cF67sgIavEg8rowTM//4hrh9V
 s/mzCVM7U8NLFd/F7V9jEBKWAZ4tvXTiSNuiXoSCvurEmrAI2qDREuWhHEwvrooG6rch
 ALmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032142; x=1793636942;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PcJdnTOR9oPVG1HJwnlp66rAuJFlVdaPexJudoA2ijM=;
 b=sy236AdeWLSxCXSrhoZB5U2kiDwCVNQ/vSHZNUedSi1KWUfW0nbh1mqm2+ud6zKOJK
 DS9bnXPUxbS6Nf5dImrxuyHgiu0yWmB3Kd2gxh1RElSLMdQ04zzhNrtJ6ge5VOApfXsG
 55KoLd4JfzZlUU5pR6JehmOmUe2Z1RuF7PuvVeAppbcaNXnQG5jPgwvjQgFQKdoNmFGv
 KsO+ypp/2agIqcXbe0HZ4ePpi3L3D3JDHIOpg4Tped/nE0ebbhEJWZ9qMs0KH4Xpp6x5
 7IY5xFxEDbsL6QDFRZ6UThM4Ha6Rdf5TVeO/NkYZpYJ7UAuNzbcyzigeh35IUOwKHbyF
 IiUw==
X-Gm-Message-State: AFq9FYJbarErUjNZ5xVg1a/8Z2kSMs1/dJjyoJEq8jwzAVjriN56BH5v
 zambarlm+h2NtS6+gP7hYy+mRsLzPkQCnXtO7z2rs5obzdGKXfBa1lp1Pw1eXIBwit4ouU3Qsgc
 nYTcyw3o=
X-Gm-Gg: AYBFou1KSYeimanJj9E66Ag2lw/NXFpCcJnh+4KIAgwUtSGOFfBZTI6rxnSYHiavUdT
 nEh2+Ape+vH+628bbCVJq0oUjjcHBGkIhFkfqx+DN5Gn3uO7yY/zyMpSH9MxzJklYcBf8lFWg5f
 Re9+2oVk9JpXuNmsH1QUuZVfN/joC7ScIDT64ZsvKwUR6tQkA94qsHxynH0bBqhaWfO7uV/d/tW
 l12O909glUlSBpKiZ4XtY91SZXfRLCWvJsJM9nq+zS3N4+8jtKkkdjccmSdqHI3nvq234ojngql
 M1wGAKcxHTdp5HAvNQkY+2cuyq3/Qir8LM5Xv2a844ravhP0CXAJgOQrqbdA53JJn5qnie7Yhwi
 kMXoXrXK+HTjqI8WQPYm4ER+KdpLJ0v0SjQGKL9qSWdSQt8lE7e3K+tO1qV5bIDGyXWilXDfwHe
 NznOz+eaH+MXgk1AmtsUAMb3yGAmNqo7GH/7N1dYA33Ba+rHuAzaqKF6KJYclDEUNyPkI51ZVZc
 d0wfgOESXOui3OK0histwiqmYUIiRuaWY8jRo8Gwn0RlHCD7zZu9FFC3+cZcS3nD3ykPC+aqMrA
 +m5XEQKlL5yqiXmyGWwcSszj+qkXfWUZ7BDxVRniktKv6HhW4knf4iGcCJrBnFt0o2dlNF7d55O
 mUrW0Gr27J9UkNXl2Uw==
X-Received: by 2002:a17:903:3247:b0:2e6:e9a:eb48 with SMTP id
 d9443c01a7336-2eae3cab58dmr811425ad.41.1793032141665; 
 Mon, 26 Oct 2026 09:29:01 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1210f0sm19886545ad.25.2026.10.26.09.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:29:01 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:28:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 00/17] Wangxun fixes and new features
Message-ID: <20261026092856.23d9d925@phoenix.local>
In-Reply-To: <D4A752590839CFE3+20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <D4A752590839CFE3+20261026122638.9198-1-zaiyuwang@trustnetic.com>
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
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 20:21:46 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v11:
>  - P12: fall back to the default value when an FFE tap does not fit the
>         register field, instead of only logging it.
>  - P13: change the patch from a new feature to a fix:
>         take the transmitter down on AML40 link down. Clearing GPIO bit 1,
>         which holds the module in reset, does not stop the transmitter for
>         every DAC cable and QSFP module. The laser_off devarg and its
>         documentation are dropped; link setup runs again on link-up to
>         restore what link-down disabled.
>  - P17: fix warnings in check-git-log, and add the Cc: stable tag that
>         belongs with the Fixes line.

Better but still has issues.

Subject: Re: [PATCH v11 00/17] net/txgbe: Amber-Lite link fixes

Series applies to main and every commit builds with -Dwerror=true.
Dropping laser_off and the FFE range fallback address the v9 comments.
The 13/16 locking problem from v9 is still there.

Errors
------

Patch 13/17 (net/txgbe: fix Tx laser left on at AML40 link down)

enable_tx_laser() still takes the SWFW semaphore and does an I2C write
on AML40:

		    hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
			hw->phy.write_i2c_eeprom(hw,
				TXGBE_SFF_8636_TX_DISABLE, 0x0);

and txgbe_set_link_to_amlite() still calls enable_tx_laser() on the
TXGBE_ERR_PHY_INIT_NOT_DONE path, under the phy_lock spinlock taken in
txgbe_setup_phy_link_aml40().

It is worse than a long hold. txgbe_dev_setup_link_alarm_handler_aml()
acquires hw->phy.phy_semaphore_mask before calling setup_link(), and
txgbe_read_phy_if() sets that mask to TXGBE_MNGSEM_SWPHY. The nested
acquire therefore cannot succeed. It spins 200 x 5 ms holding
phy_lock, then the timeout path in txgbe_acquire_swfw_sync() clears
the SW bit the outer caller still holds, so the rest of that handler
runs without the semaphore and its final release drops a lock it no
longer owns.

Keep enable/disable_tx_laser() GPIO and PMD_CFG0 only, and do the
SFF-8636 write from the ethdev ops, which hold neither lock:

static void
txgbe_qsfp_tx_disable(struct txgbe_hw *hw, bool off)
{
	if (hw->mac.type != txgbe_mac_aml40 || txgbe_is_dac_cable(hw) ||
	    hw->phy.sfp_type == txgbe_sfp_type_unknown ||
	    hw->phy.sfp_type == txgbe_sfp_type_not_present)
		return;

	if (hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) != 0)
		return;
	hw->phy.write_i2c_eeprom(hw, TXGBE_SFF_8636_TX_DISABLE,
			off ? TXGBE_SFF_8636_TX_DISABLE_ALL_LANES : 0);
	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
}

Call it from txgbe_dev_start/stop() and txgbe_dev_set_link_up/down().

Warnings
--------

Patch 16/17 (net/txgbe: respect manual link-down on Amber-Lite)

Same as v9. hw->dev_start is checked once at the top of
txgbe_dev_setup_link_alarm_handler_aml() and the AN73 watchdog, then
setup_link() runs for seconds on the alarm or txgbe-link thread.
txgbe_dev_set_link_down() does not cancel the alarms or wait for the
link thread, so a link-down that lands in that window is undone when
setup_link() returns.

Do what txgbe_dev_stop() does, before touching the laser:

	hw->dev_start = false;
	if (hw->mac.type == txgbe_mac_aml ||
	    hw->mac.type == txgbe_mac_aml40) {
		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
		txgbe_dev_wait_setup_link_complete(dev, 0);
		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
	}
	hw->mac.disable_tx_laser(hw);

and re-arm txgbe_dev_e56_check_bp_event in txgbe_dev_set_link_up().

Info
----

Patch 5/17: need_restart is still always true past the early return.
Pass true and drop the variable.

Patch 12/17: the *_dflt variables are initialized to 0 and then
unconditionally overwritten. Declare them where they are assigned.

Patch 14/17: still busy-waits up to 200 ms (page exchange) and 400 ms
(CL72) with usec_delay() on the EAL alarm thread.

Patch 15/17: the txgbe_is_40g_fiber_qsfp() branch is still identical
to the final else. Drop the helper.

Patch 17/17: a field rename is not a fix, and 234ce0d1fa9d is not in
25.11, so there is nothing to backport. Drop Fixes: and Cc: stable.

Review-Result: ERROR
