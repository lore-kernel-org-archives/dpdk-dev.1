Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B038606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e2XpTmgc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3C6402C4;
	Fri, 27 Nov 2026 18:47:29 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 4ED84402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 18:47:27 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cde84cb8803so2343835a12.1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795801645;
 x=1796406445; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ie6r14gI/Vc4SNV1rowd4/3eR5XgzMcaiwdgfDTSLTs=;
 b=e2XpTmgc883SGiIvAvnWTrveg7U0yUr+472xY4uQ8f8boFn5A9PXzoj1fC5jVWgC2o
 MEYKQ1fCL0qwoQMW8bFnwEdAWQwWyC2zbsJUVkT5TXTUGX26Mf3ttLs+4JQtZ5ewfdqq
 /n08MRmk+wD7EoRQQLCxNIT0x8kQJLfD77Jw3W/p6qOlRbVUZiiBnGq9Xntw7rapLn3u
 y6Ey5wFsefJMPslVv21DNpSYr7/1h1NtHJXcmqJGV2P9hoAE3NWgs0ss8AlG/kPCcS4p
 1D0ja9NAyjrDTBrSGKnTsy0S9L/4wNR8+/+1p9zjma1l2qo5q7Gggm9stZPvzM6LkEUO
 E2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795801645; x=1796406445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ie6r14gI/Vc4SNV1rowd4/3eR5XgzMcaiwdgfDTSLTs=;
 b=m8kpoU1tXvKxdKCTd/TnGfeBOAuEWS7Lj8H6ojEwFPqtSxpoda/dCYO31Ds0zwDEQz
 P2TMhF6zgx0rqMUSLl971jZn3AWUWY0Mh/Sf48dTaOlmxX7aTeeTC5X+AGOXxp5ZTSTO
 77a77eGJ4rdu94JFTJDy5QHKOJnjqB0M/yzZYyL5qHUtZf6MWrQ87PR+JfmtZ6DsrMOc
 gkyxZYr5X2jQBI2twhaRv9Qv7cVnl4AzT8WtEuyxuYZn0qUu+BUcx+N1jRyUKD9JokaB
 8Nss5u8GOrSWehLdLpEa6V4Ax+JoIJ0Tk+qOo5KxT8T13FIzdJLREWEk2JstkW1xHNLv
 eKYA==
X-Gm-Message-State: APuU4Z89VS+nS9IEtvu1XCKUN34wxBwVmo0bvUeXi2BBZGqiA7Mcb4KJ
 LIEUk3ns/yqx6GgqxbbW62tGbC/gdlkoGXVLbufUDg4oW2eAFvKxJCJNM206RJgyikTeoeUkQGp
 cziSc8Os=
X-Gm-Gg: AZFdTZeBq99J31WUZmYHQkkkUvm9Umw0Ob/BsyWrLEZEog4BD29nEMEoyuqB/4m6tii
 bK0I0wrJebVPUIJ3OXz9F2+Ma+AV+bD6fLpCOeGwMPdWykRmhim6yToFOj7wdaCD6rl5FM6mFZu
 4f82CdUJKD3Ew8wlwP3zDf+pBfKus7xqLfyXJZ2rFgNXVYfdEpmQvUbPUp6J7L6jZZQ2JWKcfK3
 oTuhazB2MMPlqXcIxQK6ZJCMf4cY/Frj0PFNRxmHdjfsEvM8o6480zJQz+EL1ZZPuqqXyGAmoQw
 WiJ10itXW1OoEYpuag4HDHdqGZbpVBJ8EOo24sOxxOgMqeKw64zlMZ3OwzjdvE2yaqVzr8Ylgee
 7+YvOfoE/XOLPYMZK81CYwhDu73NQVlSm4Tyys1VYgrzS29Ibvg3/8VPQ/8fO6i6XNExj2N+hnl
 R22SC26l3vm1Ejf/hNbVZYF1lLlf1oNX0lYf+vXMta+k0yzTcmTAuRH+M9v9PSDygTYug3y4hri
 3fdg7yZ6udFSKmv6T2EjFDWGkO09XtzJnEYgomKedx4ZhWaaMkkPgc/yE4xXfE90jiyRvAXazrC
 FmrT1z2MNAWzSVx9maBdH+mlwlObpC72CLHIv/ctSbkAahOlFLLyOpq3nL1TghOaRpnxWMA=
X-Received: by 2002:a17:90b:2c86:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3b41c8d5579mr25266680a91.13.1795801645465; 
 Fri, 27 Nov 2026 09:47:25 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b40a878d50sm41820130a91.11.2026.11.27.09.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:47:25 -0800 (PST)
Date: Fri, 27 Nov 2026 09:47:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] ngbe PHY interrupt configuration
Message-ID: <20261127094722.44f08014@phoenix.local>
In-Reply-To: <A3DA76B5B04DDFD1+20261125111142.12226-1-zaiyuwang@trustnetic.com>
References: <A3DA76B5B04DDFD1+20261125111142.12226-1-zaiyuwang@trustnetic.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 19:11:03 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> Two PHYs have interrupt-related configuration issues, each fixed by an
> independent patch in this series.
> 
> Zaiyu Wang (2):
>   net/ngbe: mask unused internal PHY interrupts
>   net/ngbe: fix YT8531S-CA interrupt in combo mode
> 
>  drivers/net/ngbe/base/ngbe_phy_rtl.c |  2 ++
>  drivers/net/ngbe/base/ngbe_phy_yt.c  | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 

AI review spotted some issues here.

Subject: Re: [PATCH 2/2] net/ngbe: fix YT8531S-CA interrupt in combo mode

Series applies to main and builds with -Dwerror=true. Patch 1/2 has
no findings.

[PATCH 2/2] net/ngbe: fix YT8531S-CA interrupt in combo mode

Warning: the new block runs for every YT PHY in every chip mode, not
only YT8531S-CA in UTP_FIBER_TO_RGMII mode.

    ngbe_write_phy_reg_ext_yt(hw, YT_SPEC_CONF, 0,
                              YT_SPEC_CONF_8531SH_CA);
    ...
    ngbe_write_phy_reg_ext_yt(hw, YT_MISC, 0, 0x10d);

ngbe_init_phy_yt() is the init_hw hook for both ngbe_phy_yt8521s and
ngbe_phy_yt8521s_sfi, so UTP-only (mode 0), fiber-to-RGMII (mode 1)
and SGMII (mode 4) boards now get the 8531SH-CA config, and
YT_MISC = 0x10d sets YT_MISC_FIBER_PRIO on UTP-only parts. The
existing YT_SPEC_CONF write in ngbe_setup_phy_link_yt() is limited
to the mode 2 branch. Gate the new code the same way:

    rte_spinlock_lock(&hw->phy_lock);
    ngbe_read_phy_reg_ext_yt(hw, YT_CHIP, 0, &value);
    if ((value & YT_CHIP_MODE_MASK) == YT_CHIP_MODE_SEL(2)) {
            ngbe_write_phy_reg_ext_yt(hw, YT_SPEC_CONF, 0,
                                      YT_SPEC_CONF_8531SH_CA);
            ...
    }
    rte_spinlock_unlock(&hw->phy_lock);

Warning: YT_INTR is not a stable way to identify the part.

    ngbe_read_phy_reg_mdi(hw, YT_INTR, 0, &value);

    if (value != 0x31 && value != 0x32) {

YT_INTR is the interrupt enable register, and this same function
writes YT_INTR_ENA_MASK | YT_SDS_INTR_ENA_MASK (0x0c0c) to it when
hw->lsc is set. ngbe_dev_start() calls phy.init_hw() on every start,
so on a stop/start cycle with LSC enabled the read returns 0x0c0c
unless something resets the PHY in between, and a 0x31/0x32 part
then gets the extra config. If a chip ID or revision register
exists, use it; otherwise decide once at first init and cache the
result in hw.

Also say what 0x31/0x32 identify, and give 0xa071, 0x52, 0x51, 0x57
and the 0x10d value names or at least a comment. As written,
nobody can tell from the code or the commit message which parts are
excluded or why.

Review-Result: WARNING
