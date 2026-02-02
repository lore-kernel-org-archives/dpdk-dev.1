Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126EE7DF00
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 16:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4444027D;
	Mon,  2 Feb 2026 17:32:00 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id CE6B84026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 17:31:58 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 46C3D14000B3;
 Mon,  2 Feb 2026 11:31:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 11:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770049918;
 x=1770136318; bh=85V4C7vIuJWqiH52j2ryAzt9j8aYOGPAlu+UqVEabEI=; b=
 EXT5DgLRejLVMndHob+ruKQf5p1Jg2zcS8trxtZ0B0m3RYwMD2P9blxxrIWQCxi/
 Hfo/N0zO1dAlSFJrR8Mfc/U5WxwFS/b613Z5yEAdCdSZvTr4SmlX+D3l6klQM56h
 DAKUuhQB3SYEq9utP7GLryZdsJrP8tjyc4pk1pUXAzDTpGYYz/dHPHVS/9u2Z/7I
 Ai4Q0Dj7DecvMGA+USWbvRMkzNbLHmpnnLY2g5vmeX/affElk5cB19QFJoBG8NnT
 KtVE9KmEDr//z5YO9VdXvcdhtohWsnFHF/XnAjTv9313l6HD9zkNw+2WrKX3enqk
 Oznl8B1elARCWYSYiIA4Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770049918; x=
 1770136318; bh=85V4C7vIuJWqiH52j2ryAzt9j8aYOGPAlu+UqVEabEI=; b=H
 O80lokbFjL/GKJzlxnTvdDobZv3W5dYbMqS1nSTgKEtpQ2k2RoCyxW7tfZzqSTYC
 mXmIlKtBNMxWqwUqt/4eSKrAWaNsZpwYchgph/3utonM8H80NE8iQvApdyx3RWEx
 +ib7UqSjolkPAoxwE31UskwcwbuQ9fTAtoYCLlnF1cQ1hGCPVYK3B28K/626JVSf
 tfNQ6xGjbWqSkuh2xvUblNVO1DRbnDT0wxTb1DYFaXgZcUltlIi+S2YVgT5bRzva
 8D3lNahTwvBH56kHsho9siC1MDeQ2fXJZV3eT6VBtzbX9CKBIm2DW6I/3sN9uplk
 fznJ/z2aB2+MgnJPwzt8Q==
X-ME-Sender: <xms:fdGAaduMJjgyDaM2YS_96war6qn0HoCCMUeqDm4-SMxBi-zfBYz-7g>
 <xme:fdGAaQgbKKFO8zsQC6mNUmcY6PfeJFrEM91ReJXfmhxUA1vmALs5XdYfecHAxICEC
 CEk-cNKtaat3PsOeHs319Z7qVAbTU3nguZmYtp68gmAhasdpasYC60>
X-ME-Received: <xmr:fdGAaQoOl_W4TmGMa70FtWtEp9aIObP7GNYKqGS2Cqe1zGSlZzjm-uAHublCD5v7LGXNQ94ONitJWXKMTyenESDpgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekudefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehivhgrnhdrmhgrlhhovhesrghrkhhnvg
 htfihorhhkshdrrghmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhoseho
 khhtvghtlhgrsghsrdhruhdprhgtphhtthhopegrnhguhidrmhhorhgvthhonhesrghmug
 drtghomhdprhgtphhtthhopehpihgvthgvrhdrjhgrnhhsvghnqdhvrghnqdhvuhhurhgv
 nhesrghmugdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhdrghgrlhgrkhhtih
 honhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrd
 horhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgt
 ohhm
X-ME-Proxy: <xmx:fdGAaVvxjnPWdmEo8lnagJmpmyb-f791Tl9LUN6jTnERmFQgE5bMYg>
 <xmx:fdGAabZDJZ6MycitBLp81EqZt8TkazrqRviXluRJijjP_G1xrkUyZg>
 <xmx:fdGAaUZ2ZIWZaib5MThTB7J1wtNHZGPAR3TxecBqDKkXB-BQgeSeUg>
 <xmx:fdGAaUnOz_LOay91Z4LTFoY38ifEY924udQeub8pvEkrDm-dYqb9Jg>
 <xmx:ftGAaeBqzsurtyVjs-OOdDvRXTvNdjKjFvwOPI9Hm8EWsudFS_Jrjwf4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 11:31:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/9] doc: remove support for AMD Solarflare SFN7xxx family
 boards
Date: Mon, 02 Feb 2026 17:31:54 +0100
Message-ID: <3922762.e9J7NaK4W3@thomas>
In-Reply-To: <ebd63f2d-0a71-7774-d0c1-d2ee3405c4fd@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
 <5939885.GXAFRqVoOG@thomas>
 <ebd63f2d-0a71-7774-d0c1-d2ee3405c4fd@arknetworks.am>
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

02/02/2026 15:05, Ivan Malov:
> Hi Thomas,
> 
> Apologies for being late with response.

No worries.

> On Mon, 2 Feb 2026, Thomas Monjalon wrote:
> 
> > 01/02/2026 21:17, Thomas Monjalon:
> >> 29/12/2025 22:35, Ivan Malov:
> >>> +* **Removed support for AMD Solarflare SFN7xxx family boards.**
> >>> +
> >>> +  7000 series adaptors are out of support in terms of hardware.
> >>
> >> Just to be clear, it is only a doc change?
> >> The code still works for this hardware?
> >
> > Please, may I have an answer?
> > I cannot merge into main that you remove something if it's only in doc.
> > It is blocking, I want a clearer message to merge please.
> 
> The code is still functional. However, the situation is a bit more nuanced.
> In fact, the fix contained in the series is supposed to make the driver
> work properly on late Medford2 adapters, but for early devices, like
> SFN7xxx, this fix might cause issues with flow control. Hence the
> doc message. I think it serves some valid informative purpose.
> 
> Thank you.

OK, thank you.

So instead of "Removed support", I would change to "Ended support".
Or do you prefer "Discontinued support"?


