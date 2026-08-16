Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E12C5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 03:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B0E940431;
	Sun, 16 Aug 2026 05:27:33 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id A5FB040144
 for <dev@dpdk.org>; Sun, 16 Aug 2026 05:27:32 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso2359806a91.1
 for <dev@dpdk.org>; Sat, 15 Aug 2026 20:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786850851;
 x=1787455651; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gkQmaBfvmt5ViYPiKwg0RTVtOKE8cJMH3m17m99WpHQ=;
 b=I9Ma4ypX2dv+DGOvNwh8dDX763uTv+1ZplJt1ui2x197XKBxFeIY0wyuI25DGKRKd5
 XJRHrpWVD1NY4W7f6z2gqgdNmqB7GI8LJgWTRPn4YKUHS7D+IYcYbeEANkGsdo9sdt/H
 mAHchM1M26u5M6clq3PXDNj84aJpgLYXJJwEqB1dBwe+9BpYQoGQ8JEW6qxi+BcxDh/X
 F7puV9iCElNLEQkRBbAR6AgU/tTTKInYwSTvBVcQx8wNYGuOUqmpAlZGNcz3hy8oAcXc
 hBANgU9uHtM6rRMN2Fy9BlrwRuDV/+7UXUvA4C/QaeEfbfOdiCMfNCEyib+SoPvW3HHM
 v7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786850851; x=1787455651;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkQmaBfvmt5ViYPiKwg0RTVtOKE8cJMH3m17m99WpHQ=;
 b=hLyjBfIjq+vb+rJoUn6xODUovAPfJURKQon6aOqxMoCHctWm9N2VK9kBe1HhOJwuQ5
 ShfwQIhbqgFYS0K0BwW2i5gMV3zkLU3rUAi1iwunoSBK1hkKwjoRA8T5HfmbcSMCcOaI
 8R7V3/CWzwf9FIKctWXxJo4OYXZ0z/OoeZ2YyzWxqTpWDBW/cCTLueQoHGCbJTnxulvt
 CDA4vO98vohBIrknZUoDSpyH5zDw80xylzH1uuj8GvXlR/MH4Nk6UtyrVVxF1lWxGAJp
 S9b0Yok1oHZIXfNhduAJs53HI1IqanF3MEVUtoNzSnudW8U3l7IULFAMDNkBLhAuDdvS
 494g==
X-Gm-Message-State: AOJu0YzobngJlCUZhJeN1cC8/s1PLR02KUCUidonwcfagAauZTzWIbwB
 eg+TsYVFdzLp2zHDKkpgnuPfqDgu3pAnT9vH9QLNoicmbpvgNANM6Z1B3xP2KGpo+As=
X-Gm-Gg: AR+sD11igjB536H0WOMnGsv+RGuh16f0GSwR8F9u1dnzXiLJNRg+5nop2Gxig62SXbY
 UJYzpZ/+DIQUFGV7+C8s1A61ZH2UTZvIbjK86Dcr+8xxpfa/aRms8Mjw1LT1uk3avjv358D7bLK
 ljM8YFba1LCZRiBfTxaoYO1Qw2JpzwUtgPjRm9Jlb/JaVqi9HZRADnmRe6EkSmIdthszx0k6wGy
 Rl5a499FmwKxtnJNr6zYZCUhIgmEYUXMhYvTxSib/NTBv70rtpT1VBzimiOvssCWvf1xaM1WVLQ
 cQ0QzXjVR8nx0valgk3zE/oiBPkBk2IiEmK8aLbkQhU8rcznJIrhqlhXkLeyJPR9XeItmqKbhT2
 g4jcpsWu/zV5g52t7sJRw14QNPf28Hye2pjqQ83ngKcqLGVQ9wVshW23fNqVaKbDLj5mi6o7Yd+
 JWAlmYgcH3+by3WqYp6VlKGlKygxIwA8WjlEmOb0cBLaYtoCjNU20nCd6+pS6uEAlX9PPDAqa3x
 VBPZAI0fsCGTH6LvJA9Jrx5zVu97w==
X-Received: by 2002:a17:90b:4a11:b0:38f:57f3:4dc6 with SMTP id
 98e67ed59e1d1-3933bcd866bmr17423793a91.21.1786850851434; 
 Sat, 15 Aug 2026 20:27:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1414c38af42sm1255350c88.13.2026.08.15.20.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 20:27:31 -0700 (PDT)
Date: Sat, 15 Aug 2026 20:27:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 0/6] common/sfc_efx/base: add Medford4 VF support
Message-ID: <20260815202722.1abe35ed@phoenix.local>
In-Reply-To: <20260812171103.8553-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260812171103.8553-1-ivan.malov@arknetworks.am>
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

On Wed, 12 Aug 2026 21:10:57 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series enables DPDK to use the sfc driver
> on a Medford4 VF alongside the PF.
> 
> The first patch wires EVB switch operations into the Medford4
> libefx implementation, allowing the PF to manage VFs.
> 
> Starting with MCFW 1.4.0.8, VFs may use the netport MCDI for basic port
> configuration, though several operations remain restricted. The
> remaining four patches address each restriction: dummy fixed
> port properties, suppressed event subscription, denied FCS
> and flow control, and ENOTSUP for periodic MAC stats DMA.
> 
> This series depends on the VADAPTER statistics series.

I decided to hold off on this part, need to look at these AI nits.

Reviewed v3 applied on top of series-38976 plus the net/sfc bugfix
series. check-git-log passes. Two issues below; no Reviewed-by yet.

1. Patch 2/6: PERM derived from the current advertisement

	epp->ep_phy_cap_mask = epp->ep_adv_cap_mask;

ep_adv_cap_mask comes from LINK_STATE_OUT_ADVERTISED_ABILITIES, so
EFX_PHY_CAP_PERM now tracks what the port happens to advertise at
probe rather than what it can support. If that mask has no speed bit
-- no module, or link down at probe -- then in net/sfc

	port->phy_adv_cap_mask = PERM;                 (sfc_port.c:450)
	phy_adv_cap = caps_from_link_speeds(speeds) & phy_adv_cap_mask;
	if ((phy_adv_cap & ~(1 << EFX_PHY_CAP_AN)) == 0)
		return EINVAL;                        (sfc.c:164)

and rte_eth_dev_configure() fails with "No link speeds from mask ...
are supported". The VF stays unusable until it is re-probed with the
link up. A PF is not exposed to this because its PERM comes from
GET_FIXED_PORT_PROPERTIES, which does not vary with link state. The
snapshot is also never refreshed, so a later PF-side advertisement
change leaves the VF's PERM stale.

The comment says link state gives a clue to "which link speed is de
facto active", but the code reads the advertised mask, not
ls.enls_speed / LINK_TECHNOLOGY.

Since medford4_phy_reconfigure() returns early on a VF (no LINK or
ADMIN privilege, so efx_np_link_ctrl() is unreachable), nothing on a
VF can program the PHY anyway and a permissive PERM costs nothing.
Seeding it from the speeds efx_np_cap_map_tech can express would avoid
both problems.

2. Patch 6/6: VF restrictions undocumented

The bare "SR-IOV VF" bullet documents none of what 2/6 to 5/6 encode:

 - flow_ctrl_set with autoneg=0 returns -ENOTSUP (4/6)
 - RTE_ETH_RX_OFFLOAD_KEEP_CRC returns -ENOTSUP (4/6)
 - link status change events are never delivered (3/6)
 - periodic MAC stats DMA unavailable; one-shot uploads instead (5/6)
 - no PHY configuration at all: link_speeds, FEC mode and lane count
   are accepted and silently ignored

The last is the one I would most want written down -- a fixed link
speed on a VF gets no error and no effect. sfc_efx.rst:137 already has
a Limitations section, which looks like the right home, along with the
MCFW 1.4.0.8 floor from 2/6's commit message (older firmware just
fails to probe).

Minor

2/6: efx_np_get_fixed_port_props() now returns 0 without writing
sup_cap_rawp, sup_cap_maskp or loopback_cap_maskp, which are still
__out_bcount_opt / __out_opt. Harmless today, but it is the same
pattern 07/14 of the annotation series changes to __inout. Either make
these __inout_opt or zero them on the VF path.

3/6: the call site comment still reads "Subscribe to link change
events." with no hint it is a no-op for VFs.

5/6: base returns ENOTSUP, net/sfc tests EOPNOTSUPP (sfc_port.c:322).
Equal on Linux and FreeBSD, so fine, just worth knowing.

No findings on 1/6 or 4/6. 4/6's fail label renumbering is correct
(encounter order, chain reaches fail1 from every entry), fcntl is
assigned before the new test, and the net/sfc defaults
(flow_ctrl_autoneg B_TRUE, KEEP_CRC off) trip neither denial.

Not built on my side.
