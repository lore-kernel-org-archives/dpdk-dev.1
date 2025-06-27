Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1793AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 18:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 289884026D;
	Fri, 27 Jun 2025 20:30:16 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 15586400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 20:30:15 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id B02CFEC024A;
 Fri, 27 Jun 2025 14:30:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 27 Jun 2025 14:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751049014;
 x=1751135414; bh=HJfE47nIUG0zqumk3DIeAnk0oZb9dIqek2I6SB/AWyk=; b=
 ApjhgqZTs3IQCDnAFNmAMYLTeN3+X2vKaXJQ4qNrY2mzgW96rwCjQdP7l278L8t/
 JUMH7JEYuj9bo/8odi41QrN3pwKDza6f6UIX5AwCQivT5ccj8jsjz4XyLOMvcmU/
 uNC07pGJFC3yA3j+9zzefyJpXmhbkjiTj8CLKuWDkPkS2FxxpWVlcpQWNzXET+Wa
 Kunx6s5EE9BQZy2GEH6D8fHKRtXSYU33lTPe6zXVY01Kh9LnZac1HKkqlGcAFzEb
 NlYNJU0wmZhQURX+Qrs9eYQXMKCbe3QpW+UbKKsFfkhbSeXRXhXDKX9f467S4y7r
 K8PDsJDX0Tr0OxLVE9q+TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751049014; x=
 1751135414; bh=HJfE47nIUG0zqumk3DIeAnk0oZb9dIqek2I6SB/AWyk=; b=M
 n/P8VwkVoO/G6XL9LWNNRIsr73LKN6HDq/GzvEJo6YNNZ99u6BaS8i8YIdiyEV1a
 NaRUxbo4rZIUuqUwoT+TJSnTsynZlee08IXq9vxRIPG76x+wNmXobTS5d/BJYjIi
 KiLZwkQBkwJ80MH/QD35ZTdHQfLortMnZ3SIR51a7J8Zp7iKyWECvC+Km8UJZ/Wf
 dlZMLSDA8VuwQZ2yHd+L4QiPq4n7ZXbOXDK/sL3Uw0OksctznKY98I26u7gwZMsN
 rebpyWw2hkWVp1qxwj5/oIT6VR7X2JBuQaoeUvLyb7eNrP3ZpO72AEc6TzhIwwMt
 /0u7vMGGc1REd+Bv8ubjA==
X-ME-Sender: <xms:NuNeaK1viAA-vEHJHt2vEK8UJyPsQIG6xG6M1GkRx1g6IT4i7t8nOA>
 <xme:NuNeaNEW3w9m5oQWMm-zKT3Hr3pFj_pY7Eo2V6O8o2PPm2Au8S9HYD0C8semSrhDW
 hAKz3nJ2sbzfPWIfw>
X-ME-Received: <xmr:NuNeaC7ViG7IrA8dMg_Ij3BUxWPSaiSEmSDMPm0K2Qv6pBOPMQ_yWdloCZfzegYZO5a3zUHuNqIgwiJ3nL1QqlWNCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpefgfeeftdevffffueeiueelhedutefgfefgfeelteehkefgiedvieeugeev
 feffueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhn
 rdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehr
 ohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhope
 grnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghr
 uhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrgi
 himhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhvghn
 sghogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthguuhhsiiihnhhskhhisehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhu
 mhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:NuNeaL2EFa-zWDl7l6No7NXtWkeG3CLbHsHimcF1GNHxEGqJJpGx1Q>
 <xmx:NuNeaNEW62FsknrcorD_wq9iTraznpcqh_n5gfFrxyGwH-ymbDinCw>
 <xmx:NuNeaE8ZK689FQW56UIO8gF72bHVQuPRMcRkr-GJOJQkxsfnclZazw>
 <xmx:NuNeaClSiJfhp34J6ypP9_lh769tUInYkW0BdmjawQdM3QTcjud5dA>
 <xmx:NuNeaDiMQqhkVhgfRRYQz0BbJSNZWoizcehZ_2hkcAi8n-WpWv7I7GH0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 14:30:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Date: Fri, 27 Jun 2025 20:30:11 +0200
Message-ID: <21665758.gIjEHFZm8d@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD53@smartserver.smartshare.dk>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <6180155.ReJHH8Nr61@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD53@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

27/06/2025 19:49, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 27 June 2025 19.35
> >=20
> > 27/06/2025 18:38, Morten Br=C3=B8rup:
> > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > Sent: Friday, 27 June 2025 17.58
> > > >
> > > > 24/06/2025 10:03, Morten Br=C3=B8rup:
> > > > > +		if ((ssize_t)page_size < 0)
> > > > > +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> > > > > +					errno =3D=3D 0 ? "Indeterminate" :
> > > > strerror(errno));
> > > >
> > > > We don't want more rte_panic().
> > > > You could log the problem and return 0 here.
> > > > It will be a problem later, but it may allow the application to
> > cleanup
> > > > instead of abrupting crashing.
> > >
> > > Disagree.
> > > That would be likely to cause crash with division by zero later.
> > > Better to fail early.
> >=20
> > Which division by zero?
>=20
> Functions dividing by page size. E.g.:
> https://elixir.bootlin.com/dpdk/v25.03/source/lib/eal/common/eal_common_m=
emory.c#L313
>=20
> >=20
> > I don't think a library should take this decision on behalf of the app.
>=20
> I expect lots of things to break if sysconf(_SC_PAGESIZE) fails, so the p=
urpose of this patch is to centralize error handling here, and only continu=
e/return with non-failing values.
>=20
> Otherwise, everywhere using rte_mem_page_size() or sysconf(_SC_PAGESIZE) =
should implement error handling (or ignore errors).
> That's a lot of places, so I'm not going to provide a patch doing that.

I understand.

The problem is that we don't have an exception mechanism in this language.


