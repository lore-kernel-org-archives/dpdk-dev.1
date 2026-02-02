Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A8CE7DF0A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8E5A402A2;
	Mon,  2 Feb 2026 18:06:43 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 71ABB4027D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:06:43 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id E6964EC00D1;
 Mon,  2 Feb 2026 12:06:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 02 Feb 2026 12:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770052002;
 x=1770138402; bh=ZRvFvkErBRm7QwJyIADaj2bGeraJnxkyuhsaUQHEq2Q=; b=
 aULHUkyvwEzRMjlre5qWqwPaQ1wpLhzdR9MDdIe1gI3ytO5qUgAqQ9QbZegX6wIO
 xEH09sxpIi/CaPrFTIzf3LYrNU4pKqJQO/b+EUkzanv+AeIb+mWm9DLObf9JJ8in
 Xk+w99jNySXQTbALcIP9aJBSc3QzWWf7uoJ8IRF9xLdXkvBR3UQFSls/ArIspUZa
 p7G711FqaNVWh+ioYnKhs/4KHfv6Z0h+LEjSjuspg0xhrN7ujxa4LT25p2e+G6Eb
 smQHiZ5YjtK1K/uADcK/9BHiCnNo6XlFYi+iETISn/lHKt8oDwkIrFmcW4cBH4P3
 wJM9bMppn/Uir23xYrbsnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770052002; x=
 1770138402; bh=ZRvFvkErBRm7QwJyIADaj2bGeraJnxkyuhsaUQHEq2Q=; b=k
 f8R3eFsOEJcNQHcqX4smMNpbZJh32E8TuSk+JZbcZtwcJFkpv4jjxwju4iY9guce
 lf6Lvh1GeaLYZk691vpiQ597I56tE+7jC7+buDJsGtTEh76X4Jmv63oXJZgN4dBu
 berIBlxlStM11vNblARtQr8e860B3ZedMFf96NRhSJfZR5q5jFp3IIitavQp7PCL
 D8Xh2Ecnmu3l/TfiTQ4lv26oP0lsByjQd4oqXJjWKRzJJ24QEg9huU9l8fYJZnqH
 K+n70L7ebpUKRfpGtHZZpctROa+v2YQR5eCg3d6nnMomjOZQoF0YxK7n1eR7Sv1W
 K2FZP+g5tfzGJ/Bg1RWOQ==
X-ME-Sender: <xms:otmAaUPzT6W7MfgUBaI-pRlwwrvFzzClOPtLtkgKFXnLI30pXBKMjw>
 <xme:otmAaVAlquVzcVuTKDq1HgXlE4YjmXZV3xNc5FJk8gI60nzYknouv6D6LBLugM97P
 21iJjTWe0T7hdK3evluIH7jSUj1W_0lbURYMh4FoxUopjXcA9Y7AQ>
X-ME-Received: <xmr:otmAabIekuDH-tlAPuwMs2UoLRNtjXYsR_0b1YdIEDLCkDlb0KeBNbNQuPzh2hGRSIaDVfzVgz7dxaMPn6UlGxINNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekvddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:otmAaeP4Sxz-0VXjU-dqERk8ey5GioWWnSnoM_HqK_vTr2uuT-oX6Q>
 <xmx:otmAaZ6oxSxN-w2nsJzJU29I0ME5FSvKZ3l_Q7IQtLYWY4GTzGa0LA>
 <xmx:otmAaQ7dN5C48h51P72rtcEq_f5QamAk8tGGoUToVWtFZueAr6lXCw>
 <xmx:otmAaXFBiq3ykKB7J0uslNNS2hrbDMikLtahwaw6K2vUhnZCQJOcpA>
 <xmx:otmAaYjEMRO7IkRCyrNbsTlk77m8qy8puRB2X0h71Bcq8ldScMAS0VYL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 12:06:40 -0500 (EST)
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
Date: Mon, 02 Feb 2026 18:06:39 +0100
Message-ID: <4294448.44csPzL39Z@thomas>
In-Reply-To: <3923fccf-fac4-69b3-d5e6-dab3463292dc@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
 <3922762.e9J7NaK4W3@thomas>
 <3923fccf-fac4-69b3-d5e6-dab3463292dc@arknetworks.am>
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

02/02/2026 17:38, Ivan Malov:
> On Mon, 2 Feb 2026, Thomas Monjalon wrote:
> 
> > 02/02/2026 15:05, Ivan Malov:
> >> Hi Thomas,
> >>
> >> Apologies for being late with response.
> >
> > No worries.
> >
> >> On Mon, 2 Feb 2026, Thomas Monjalon wrote:
> >>
> >>> 01/02/2026 21:17, Thomas Monjalon:
> >>>> 29/12/2025 22:35, Ivan Malov:
> >>>>> +* **Removed support for AMD Solarflare SFN7xxx family boards.**
> >>>>> +
> >>>>> +  7000 series adaptors are out of support in terms of hardware.
> >>>>
> >>>> Just to be clear, it is only a doc change?
> >>>> The code still works for this hardware?
> >>>
> >>> Please, may I have an answer?
> >>> I cannot merge into main that you remove something if it's only in doc.
> >>> It is blocking, I want a clearer message to merge please.
> >>
> >> The code is still functional. However, the situation is a bit more nuanced.
> >> In fact, the fix contained in the series is supposed to make the driver
> >> work properly on late Medford2 adapters, but for early devices, like
> >> SFN7xxx, this fix might cause issues with flow control. Hence the
> >> doc message. I think it serves some valid informative purpose.
> >>
> >> Thank you.
> >
> > OK, thank you.
> >
> > So instead of "Removed support", I would change to "Ended support".
> > Or do you prefer "Discontinued support"?
> 
> Technically, the patch does 'remove' the corresponding lines from documentation,
> but if that sounds off, perhaps, 'Discontinued' is a better choice. Thank you.

True in the documentation context.
But in the release notes it sounds like code is removed.
I changed to "Discontinued" in the release notes while merging in main.
Thanks


