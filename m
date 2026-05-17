Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378ECD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 20:26:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA4540264;
	Sun, 17 May 2026 22:26:45 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DC4F340261;
 Sun, 17 May 2026 22:26:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3D0C214000E0;
 Sun, 17 May 2026 16:26:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 17 May 2026 16:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779049603;
 x=1779136003; bh=uIUVEG3cH6l7MLqZ/dGfmixHDZ9LR1VGZ/6W5yIfk8M=; b=
 IHRREav3rlWjEzA+hdOl2QFdtm+/AWnoicLE7cKxUsHQTr/cFn/xSd1/W/C1jmWf
 Cued8rHs2l9hdHLlJ4LgxNFaMW+wVlUwOQL8lYhkD5kdQiiUFJfXe3w3Q17SToy5
 HrKpgn0U2zmeRkdhHzOTz0jtWRF7XUkUH1cqL9LX+tZb5sB/4+cEmquPVPy9fY6R
 /K/ASqbeA8D1ONfeYUnQqpXo6VvrVrGyJgsA5itDaMa9RP4uJJ5wo+OrErGRkyz6
 OvEfsR8MdMq/6Rg5XrJ0fmOyzzo+Zgdl3X1z3iVg8JK9ULtK7WxscQYeWtGpvJA/
 kxnwoxuobZlJUOn2cj/gnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779049603; x=
 1779136003; bh=uIUVEG3cH6l7MLqZ/dGfmixHDZ9LR1VGZ/6W5yIfk8M=; b=O
 igsFuWDSkesCIXFMtTOHe6ENG+tQ5lQLEvSFGh0JaHHSMBu7iLlzwM1OQDPQL6uc
 Rs98Qu8CsDHy1Ta0OlX31MFg/cVlBuu6DXKGGqXK0JQJDoqp/WhiVuyCehVdVudZ
 /1adf3zsVmH2ry5MHPWwSlrcQrXJs//3ZtfSO73ADh9R+ncAWQaKqTVQ+5cyiYnl
 nF0hfNFoyHh+zPfhWnN2bhCFzmGkptJwPH+VC74Wp7mtW1Ss8KfmZx5TCfutT1XU
 wx2pIC1bHppcSRWPFDpZgYja19nOyFAOnuGOlpbk//5pTBTmNNpPirn7a4QODSrU
 B+g6J/IVIlGtEq3Ixt4dQ==
X-ME-Sender: <xms:giQKaux8w4ryN0JPS-MMEgJHjdY5lvdas1zqQ54o2OkGphmN-r2VgA>
 <xme:giQKajOSBI0_SRKeWtFKPfAqCOSkpG2P0rcKC5TztHmuTPkWnNdiSGVBmJHAd9_IL
 OTzXPTwRE2pd349_6joYNTnFwchaTKKZpeZpVoRnFHHPabaU7Bs7Q>
X-ME-Received: <xmr:giQKar5ZiX255tGZeW9-rAhV5i92CIETzu6UdnfdtFMgAqQOytHDrWrPY9iOkEeisAIVyuJPM5yYPKc_uLKave-mJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeileefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrrghtrdhkhhgrlhhilhhisehhuh
 grfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthh
 grnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgu
 shhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfigrlh
 esnhigphdrtghomh
X-ME-Proxy: <xmx:giQKakkrtVCsOZ1XpWON3OwRSSt5R09LhLDakCD1pzVi0BMygvQjAQ>
 <xmx:giQKasReFqAWEqQAMrdb_VMCS3mhAhAc-kz95tRRgotH31fgQzsi3g>
 <xmx:giQKajHhR3u6nR-yXE8oe-QWK3l78_u-dRcStieTK6r_HIfKbqOyDQ>
 <xmx:giQKahG3jo9YTJL0U5jLgtoS649uap5UK0jp2N5-FVnXil7qBoVjAg>
 <xmx:gyQKamKdClrIsI8NTk3G7mZb6ei37Va9TlZSzaFvToDocnbvLkp36PHd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 16:26:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2] devtools: fix SPDX tag check
Date: Sun, 17 May 2026 22:26:39 +0200
Message-ID: <zC0dUUeIRY-fAcGJGXpVcA@monjalon.net>
In-Reply-To: <67049e0367f2462bade5c2fe837e8173@huawei.com>
References: <20260429130935.3681177-1-thomas@monjalon.net>
 <15732573.JCcGWNJJiE@thomas>
 <67049e0367f2462bade5c2fe837e8173@huawei.com>
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

01/05/2026 11:55, Marat Khalili:
> > Sorry I don't understand the need for a sentinel.
> > The script is working fine with an empty files_without_spdx.
> 
> It may filter out everything instead of nothing in that case.

OK you're right.
So it becomes complex.
The first solution with sed looks better.


