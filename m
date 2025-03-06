Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8C7C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:36:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD3F40A75;
	Thu,  6 Mar 2025 17:36:46 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id D2C33406B6;
 Thu,  6 Mar 2025 17:36:44 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3F0021140158;
 Thu,  6 Mar 2025 11:36:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 06 Mar 2025 11:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741279004;
 x=1741365404; bh=1KsKgWP3GTFG6oCtj4eVfifK4TwBKPMQ/atoZcTwH/c=; b=
 X53lQeJ9xrpc9NuWl/S2V5xzD1Og3EwBWtAj7GTyi3Xo2DcRHhEdTIwDqwv/JXYd
 XW2qY8eKcs7uUdpW8gWdDUHstOVDixHhd7ulxrmYzKzE+P97NXZMIfhxIifauGXH
 pX7yi+veYd4RZ96Cb8a0lnqV9z51+a1NCHsP8meTnni8w5kY9SC5XWmSZJToRCAr
 NEs4oGWxAbnDT/ktlt7/EFzU00UfXzAMs83qd6D/sli7hu27IaIEFhCBRMTfwgpL
 tkSAqJXWYRXBCiEx9u1p8by69csl8w7+QXLClfSS5F2xEl3NPfHOsIJUSgdGSmjA
 GZ+GJ42ucV+HQ582j3VCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741279004; x=
 1741365404; bh=1KsKgWP3GTFG6oCtj4eVfifK4TwBKPMQ/atoZcTwH/c=; b=y
 0HMIwW8GJ0DJvAK7kPbp3DcKAY7urDf/0l0xs3SnqA9UklUCBk/BtUrwBM23ylby
 MvtxzTnQ2sO5QY4yx5ABcXuP15I1DBkZJvDzGrgjCeZ3RQnM+LgPB9okpsTg6v1i
 mS+/HhPZJXLX4Jfgf5PKNPdkaR2AIY2vcQOTo5sVTFwXFi74sVkE9N5Xxp6jA8L3
 M2xgoslzEgm28SIkmc2wY+g5IR8MTlPwpFnG0w+XuogEj8q3yhsM9RKpmfXz7nah
 LMdJ+YptjNYb+h1KIuzBH7JPlbz7gQKOI4wV+LwOlgJsw9dqgEwyyBDNJTS2d+ps
 OmVRBufpNuXzqqcCRNwDg==
X-ME-Sender: <xms:G8_JZ277uDetKhLBCugjUD8DIva4iBHxIdMiBFqlyAdaK7FyJ5aszw>
 <xme:G8_JZ_79BWGoemy2A7yzRkfMDGCgRnYmoSpevQDCsy5xF-hiCRUD1CIdRwKgwtWO3
 hOgrc9afSdNmIA6sg>
X-ME-Received: <xmr:G8_JZ1exRxO7iiOuhleBjQOZzOn-vS9P5z6DMGUIyRnsjxcgMfMzVnPBzovrbNwIM7R-oUGAM9tCn9oCRDaygmyB-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehthhhi
 vghrrhihrdhhvghrsggvlhhothesieifihhnugdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:G8_JZzIY8tEwV2wXWO-cC-y2JTzUBnwrhbVF4KpJtcSZAmQOGggTNw>
 <xmx:G8_JZ6L9LMxqjeGXBRruIAgTiT6q1mVMuE4Kcq4yhqNXzMs33GtWgw>
 <xmx:G8_JZ0wmRikUqECPUnhEHcG2aJfURA2tlLa9qAb4_mtTiqBBPcpK1A>
 <xmx:G8_JZ-In9EGN05PwrQcObzNciC04LXoMULb7PTfpKB97sybPFlrWew>
 <xmx:HM_JZ_EQ2ps8ENia-GqlcV7rG5ft2IFoRXMfHJvwgia4-3ScorbXsS2_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:36:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH] ethdev: fix get_reg_info
Date: Thu, 06 Mar 2025 17:36:41 +0100
Message-ID: <4403443.KRxA6XjA2N@thomas>
In-Reply-To: <20250219104555.0bc2e0ff@hermes.local>
References: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
 <20250219104555.0bc2e0ff@hermes.local>
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

19/02/2025 19:45, Stephen Hemminger:
> On Tue, 18 Feb 2025 12:58:28 +0100
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> 
> > 'width' and 'offset' are input parameters when dumping the register
> > info of an Ethernet device. They should be copied in the new request
> > before calling the device callback function.
> > 
> > Fixes: 083db2ed9e9 ('ethdev: add report of register names and filter')
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> 
> Why does the ethdev code create an on stack temporary variable.
> Looks like it only wants to make sure that names element is NULL.
> 
> Really should be one function and when extended fields were added
> should have used API versioning.
> Probably too late now, although rte_eth_dev_get_reg_info_ext()
> is an experimental API.

If it is experimental, the function can be dropped in favour of a better versioned function.


