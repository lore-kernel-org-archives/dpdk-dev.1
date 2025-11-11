Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75179CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 03:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 416654026D;
	Tue, 11 Nov 2025 04:30:42 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 750074026A;
 Tue, 11 Nov 2025 04:30:40 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 999407A01B8;
 Mon, 10 Nov 2025 22:30:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 22:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762831839;
 x=1762918239; bh=7a+NeO5kNYfa2sjSZHfZ67sDv5IEinHYWncW/LG1inI=; b=
 ZEIqrQB83+IG47O+NYnSvfWRWQbjOhVrx58X94XBjtR2zGtNyWU16uUfI2wExoyo
 rl/a+/pPqTF5jhodxhNelSd9aniu2WZfxj5uIDqtfh3/eltmOA6Hm6HAAX3Y55rU
 4jCeNtXfM/L974GNhUt2doUa/cc9sjng03Oqz36hSaQPHXbXMtWdN8t6m82pTUhV
 +Au5tH0zhrgoA7tAEMLNIpeA8YKvTJloiGsTXgSlLdjFL+7dk/rGhVQjACqj6MNu
 Ve96OiXO72puR+Hi9OXiUVa4yqbbA6Ty9qG5UwsmVI8e7Q3kAPhNCVgYgyCqflZJ
 uESGoFri/G3QiMXhDxr0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762831839; x=
 1762918239; bh=7a+NeO5kNYfa2sjSZHfZ67sDv5IEinHYWncW/LG1inI=; b=b
 99OgKK6pOlhmqvMM+MetMYuEquw6Gffpfy8AVccslxNjQ+NUE+bPgNv3KKVB6MQ9
 yxqBjvCLc6Pa86GnWw4mJ+PtzLZSD/BownuUiB3EHCaagTClL5YgY3/VyeBt/vNH
 1vVSoUcFnSd/6AKBNxbABnRpcO3Xlna96b1dgOh2eQE87ZB4FB5zCBJZcmwqoPTF
 h9qnEl7pHhC3hNCt8qfyq/Tk/Xvx5TEclTRt7x0R4AXkNjeD5HS2KJf6ZfJDs/3D
 w/hpy7AN9pla5FTsoUWxRy3LLpahzTYY+0ajI3oJMWJyHGJ3Ns4Zhd6WR9ez9xo1
 2z9jDPu7o3WHYRaCiCUfA==
X-ME-Sender: <xms:3q0SaX4Mb0TxoDtpj8DdPrRH-CYG40ErAE_ta_Svn0sAQd5Jcv9PYw>
 <xme:3q0SaYXTP_-V6HfOxfB8dIZypVVlgLDxQdVTaBUwu8Y68KMubIpIR1iA5yTt6CVBH
 oBiELWOAb2UirgGao5AEZE_8t0zOJ1--Dfe0t7sG-eFzUdnmzx1BQ>
X-ME-Received: <xmr:3q0SaR-hveJ1HNyopHim-ElSHuYoPz8DJO6Zk13qocIZLoc3UwoBiKhIDhL4-KIpbP081PXqQ8nXRsNWQQzKJ9gmZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgrfigvnhifuhesthhruhhsthhnvg
 htihgtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeiirghihihufigrnhhgsehtrh
 hushhtnhgvthhitgdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhk
 phhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:3q0SaclaQG_bTydiPGEOaMqPuTT4opi0KlZCY_SssR2ow6MoXRdG1A>
 <xmx:3q0SaXXQVdLU3ZJUUCU3LxvDqc7zftGx3JtS4qhU46G0NoY3irPyoA>
 <xmx:3q0SaREKUM9eAtVf4TJzAR3Ywl7AMIGvqtWzTZX4Ye7mgtoQ-9NHuw>
 <xmx:3q0SaTdM4Wghq_78TBFpUHNKkCxbUJRMWD3OKPYfOvdA87TszPgbzg>
 <xmx:360SaaLO43aXVyWrt7xip3trDuoOnEacERLKUK0Y6vHCDz7aKwj-Vj9L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 22:30:37 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, zaiyuwang@trustnetic.com,
 'Stephen Hemminger' <stephen@networkplumber.org>
Subject: Re: [PATCH 08/19] net/txgbe: add device arguments for FDIR
Date: Tue, 11 Nov 2025 04:30:36 +0100
Message-ID: <2766798.62m94kTkzf@thomas>
In-Reply-To: <006c01dc52ad$be5c92b0$3b15b810$@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
 <006b01dc52ad$033b4cb0$09b1e610$@trustnetic.com>
 <006c01dc52ad$be5c92b0$3b15b810$@trustnetic.com>
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

11/11/2025 02:51, Jiawen Wu:
> > > > Since FDIR configuration is deprecated in generic ethdev device
> > > > configuration and move it into the device private data, there is no way
> > > > to configure the FDIR parameters.
> > > >
> > > > Two device arguments "pkt-filter-size" and "pkt-filter-drop-queue" are
> > > > added, they just continue to use the previous naming convention.
> > > >
> > > > Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> > > > Cc: stable@dpdk.org
> > > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > > ---
> > > >  drivers/net/txgbe/base/txgbe_type.h |  4 ++++
> > > >  drivers/net/txgbe/txgbe_ethdev.c    | 20 ++++++++++++++++++--
> > > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > >
> > > You forgot to update the documentation.
> > 
> > I'll add it in v2 set, thanks.
> 
> Set v1 has been  merged, I'll separately provide a patch for it.

conclusion for future patches: don't wait for adding doc ;)


