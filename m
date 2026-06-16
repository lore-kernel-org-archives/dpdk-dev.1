Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD41CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51F5D4060C;
	Tue, 16 Jun 2026 11:53:36 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id EFE1840289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:53:34 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9142B1400077;
 Tue, 16 Jun 2026 05:53:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781603614;
 x=1781690014; bh=NUmOHhenM6d4uFZV8nvU6sQCTjnzds3Z1AfxrkLR5ng=; b=
 Dax2h/YSVA9R+Z8s0TRQm34X9RoHYoTJZjQQsPqH3NUSdvQ6xYVxDaNjkffT4t4H
 oEmF1TiHQljH15FO+1ZC19DmAp/goPvLY8nRrJeqPdzCgUu1j3HwtDdAnY5CZO9T
 rjfsotCcuzKYQlXY813QFTlLJekjofTXyj8T6WJ3avlAFd62/615dWODQ0PEgrDC
 Cl3aSfil6/sIOtif2H+KsX4FTTjKFaoFWlPVxhlq1Nge4ZmXNPa6kNq7Y+U+PcqR
 Yh7cRim1wJet74RlCUFJp5CweOKMHcZ4sJ+3cGhDfNETA1JqcfMrhsvct6cMVLJ6
 udP0uh4pbioaba7pAs0FMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781603614; x=
 1781690014; bh=NUmOHhenM6d4uFZV8nvU6sQCTjnzds3Z1AfxrkLR5ng=; b=C
 GKhkJyjjOoIK8Aj/z2HiJ/a4U9y0KxqpkL8qTLopEOKeFC/GrXT1ZpjQiDvGA9Gb
 o8QO+UzU1cQdL6r+t9maysDdpf050jsmCou8kOPRHKOZfDWsA8Q2MpwceuDRrZnY
 UOMcGIBUdR/0PH6DVZ8XAmZCS0J2Mqa6rogRB8t/t8Y6HHOdOElCCYVAE7Svmbmn
 zDlutUsYpUhIcUcc+qGL8YzeLKaLicJg5ModoeT7P/riFHZcHXtaFviAc+On0Ei5
 K6+TvnlrfQsBzDS4qcORV3cI/FK+2ZIAnzQFenO7oGle/p3RSf/MbTBwhU7w4d/L
 XaPHeAjYU1hiae5Xsj7Rw==
X-ME-Sender: <xms:Hh0xatbgjTHBghneon9a1UMr6vyViuqbAgU49OqgewMTkB5N5xhs5w>
 <xme:Hh0xakiAQnXlikx1e2iRcrRwChB0H8pWW67FSq-tfkdtFOpExfM3VXNVG2DUQ1doM
 b2zVZVOqrsCGnw4cBgu25MCcWO41LZ9X1-bFR7UjT-hPJUlrmav8g>
X-ME-Received: <xmr:Hh0xan5YxMxTK4G5pChdC8TWiChhqRPex20ApjsvjhM-0LrppnoJCCMlJTJPEhMr083OrnLRLuA37mdtJu53g5aq5g>
X-ME-Proxy-Cause: dmFkZTGbtvvYAo5paxlgQke1aFue1L3YriIuvqYi8xiZvOjuudwPXW81t3jLx5AGYYfbkE
 PTC+s5Vqz4QVfC9FuFEGwLSn4w1/7Vfnhc2LsPH2r4uc7+awAglaSsSY8KrBZPzk11aKAQ
 JOLOAC8C4RiVro5lhZTk2AM5vui7K2HI64SJjxwsvNJDe/oEElJc6eJk74ViP41SyRAgpx
 H5yf1/UBlQ/ISRGH3/oKVZNYXn2PH5HhWIWO/dpAB2r+ZoUg8T1k29hrgNlYImOxxE74M5
 fPqLJjfBn5UFlWpygBs89vSxPTYFYLkUEy+a6ga4pxzxtZciCTQpRekq3HFR0dSDkJ+CJN
 FdjqqCNM+RVXRV3q+67a5JAtm/yjwZl4fIbCeu8b9vlMLagGFzy0PAS8us5Dgf89/0yQvg
 rEmM1veOF4uGf8Fha7SVDcyCjEO4Hx1I2CysHh9ecajV/obhd301OE9gtl6Kg2IPFKXiwH
 MmD+KrS+wauEoX7mlAj7DWMqlcg4L5/UzD7JY0TeJ2m8+3ZpB4v1+Kflg5Swse3TlOlEY4
 qFWOuKERiyqpWH5KZPLgPxCNKbQBqEOsjlMnrSbod1trGC+Fw3N8+0bxESkqwAuiZd8dGF
 JHTU4ZF/Tnoi4OHbdEexhzf+ZGdXA+2IdMcBDFVhxr61HxiBwjSj20l4MzTQ
X-ME-Proxy: <xmx:Hh0xaj6icdJ3HTtYLHmGKpmvh1AYhRFA9237_KYvAlS_sN8dYJIy4Q>
 <xmx:Hh0xajfWN3ULHCzVn_4ljXhXI06NaDBldO-cX6RmJTuwtuyDiBVdJg>
 <xmx:Hh0xanCtDxlE9MPd6LP13kA54kBiKD95W7vQEMZPeY1iI7BrrZVFEA>
 <xmx:Hh0xam-uAHK_w-S7Pr6KcJoxm3T2ja4eV14tjigU6NqS6qQDaZ4m2A>
 <xmx:Hh0xagEj6m4upFhijD40FbQFYIaTzBnrP233O-t_OTYtlo3MrPTKF7Zp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 05:53:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [PATCH] dts: avoid Scapy MAC resolution in Rx split test
Date: Tue, 16 Jun 2026 11:53:31 +0200
Message-ID: <NL9cREhFRLisrPBqJv34SA@monjalon.net>
In-Reply-To: <20260611115421.12c4e6ee@phoenix.local>
References: <20260610183218.751941-1-thomas@monjalon.net>
 <20260611115421.12c4e6ee@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

11/06/2026 20:54, Stephen Hemminger:
> On Wed, 10 Jun 2026 20:32:18 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > The test gets the Ethernet header length from Scapy with len(Ether()).
> > 
> > When building DTS API documentation, Sphinx imports the test module
> > and shows this warning:
> > WARNING: MAC address to reach destination not found. Using broadcast.
> > 
> > Use a dummy MAC address so Scapy no longer performs
> > destination resolution during import.
> > 
> > Fixes: 01c70544cffd ("dts: add selective Rx tests")
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Thanks, I previously reported this as:
> 
> https://bugs.dpdk.org/show_bug.cgi?id=1951

OK, added the tag in the commit log.

> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied


