Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22310CD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAA8402D9;
	Mon, 18 May 2026 15:18:54 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 96A92402B8;
 Mon, 18 May 2026 15:18:53 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2460E14000E6;
 Mon, 18 May 2026 09:18:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 09:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779110333;
 x=1779196733; bh=Rt4FmgmEJgklcQT/i6+Od+g39GAnxV6g1R7S04NV2x0=; b=
 M73i1grq86oFNU49pQ2eEc5Euw57gQiAp3pifcYWvl2UMfIJG1hjD0WfjPddMfJR
 Rpv3Ed5ABwUNi91zZpJRVNhmEhGE8rnoxb+OMzAX1kbRayghWM9iQM3Bx4fW4crF
 qrUSiXGNGTvoF4YKsQLSmTgNUKfZr/Xgr0pe9svyBaHUHtwFZcuIsJEDQn70+V+6
 IqAcNhvlmThNDIJifvD7qR4QYYdWsEQgQdpikztCFu1XeeD7QCZTeG4q5Wge0apZ
 hGZP27G2e+hJiyxAkUipwhdLTkqHzwTw6UKx2zWNnZc/lcm1FYkq3ha3JBkqc35z
 EqY/pnYrY7nPh5d/5TYHJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779110333; x=
 1779196733; bh=Rt4FmgmEJgklcQT/i6+Od+g39GAnxV6g1R7S04NV2x0=; b=b
 O8Q8cAmWpiqLwCQx/g5dwzVRxegO9gLv9PxUSZPNRefvm+VRIJYA6NiKVSTIJ5W/
 jufF0Jcyh9ycsUgHbXbkWEmoYJBoDZqVRJHZIxywM3xtI176dUB+YeeFdtfRQusf
 tJSCdm+Ooxf8wfRkKv6+UZq0Gk+R3gwKs26RudpU0ic98bXdVOmNUUpFWctYqMwQ
 z8YylDE4RZ0UWma+srH9wxWKWL7T78Zkfc1Pv58pxwiB2JHbnctu76KlGVR4yNBe
 SAa94fLkmlHI7VXXqPvLqa7PjYTqehMAnFM9CVRU5A9O6H1Vs4kiIAyelt2omcon
 7BqRF/+sTWZyR/Ci0oT/A==
X-ME-Sender: <xms:vBELatF8xYVetVcqlHjppH-IsQPm3dxG1xkK6PnDwvz0pasD2XytJA>
 <xme:vBELaidsd7xEkua8nb62-W-wXvbQ34CTcUy-tMDfjvXmaDvlwNZpd-SA4jOgLSvVK
 waBJ2zMKzg4rkA2ewe1EuCvpeR9xE_0O5BOUO6F46-F1IsZJOhVY5g>
X-ME-Received: <xmr:vBELanEgy30WI3pzynNHPnVWvg8HFAyQiWv7qdATXCpXmiyQaEDVXgzno__bcBXhkJKrFS3MNBYTK0LJuZB60HMTYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohephhgrihihuhgvrdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgrsg
 hlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:vRELarUW_VcZcllBtLPZSY2PnzzqRAdGBj8_OKCd4jrjfB7goh-zVg>
 <xmx:vRELauJW7yuA_Qb5eS771ffju5xqUobGVieF8-TxEyQm7fbDXKk1jA>
 <xmx:vRELaj8Yb6qq4uSmbuRYYpNB_Bw_jDFmK_0EgrQUVl5Uzq66ba8pEg>
 <xmx:vRELapIiawp07-dgISi3cP9KMQ6OO-ceWfMpgzAL7n3LSoh5TYKF0g>
 <xmx:vRELanA84uLXurDP2uj7KzLGKkq6a-j-0q1IHP-SYzDFbZ088y9woKj9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:18:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Haiyue Wang <haiyue.wang@intel.com>, stable@dpdk.org
Subject: Re: [PATCH] devtools: fix regex matching literal plus in patches
Date: Mon, 18 May 2026 15:18:51 +0200
Message-ID: <cXMyzeCORZWgZ6lu4pPbBA@monjalon.net>
In-Reply-To: <CAJFAV8wKu9SZKi7TmOMwfj1bNS=2QQ7qDP=kWMPbhFYi-EcKVg@mail.gmail.com>
References: <20260505140352.3995590-1-thomas@monjalon.net>
 <CAJFAV8wKu9SZKi7TmOMwfj1bNS=2QQ7qDP=kWMPbhFYi-EcKVg@mail.gmail.com>
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

18/05/2026 13:55, David Marchand:
> On Tue, 5 May 2026 at 16:04, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > In Extended Regular Expressions (ERE) as used in awk,
> > '+' is a quantifier, not a literal character.
> > The pattern /^+/ matches the start of any line
> > instead of only lines beginning with a literal '+'.
> > As a result, check_experimental_tags and check_internal_tags
> > were matching context and removed lines in diffs, causing false positives.
> >
> > Use [+] character class to unambiguously match a literal '+'.
> >
> > Fixes: cfe3aeb170b2 ("remove experimental tags from all symbol definitions")
> > Fixes: fba5af82adc8 ("eal: add internal ABI tag definition")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Reviewed-by: David Marchand <david.marchand@redhat.com>

Applied



