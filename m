Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DD4C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F52E40156;
	Mon, 31 Mar 2025 11:03:17 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id D74FD40150;
 Mon, 31 Mar 2025 11:03:15 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id EFC31114019A;
 Mon, 31 Mar 2025 05:03:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 31 Mar 2025 05:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743411794;
 x=1743498194; bh=GumTTEDN4zb8n1XFRpj1e+/6KGfcQ8tw3R8trFDBz8A=; b=
 Ijk5wEfzvvVqJfT1nKSt0T2+1WD9uQEeiHOOeKsFZd5GbwRIf8AsIONN+xF6E0B9
 93DASb8VtiD4NQtE6H1GzuTyEUOV3OFuKcKEERRV7GBADhzPvDojiNrX3cbmlZuu
 wKMGOzpRCPwqxDSfnNwuA0yuzGUKHiRjnTCsZBnXHG5h5Vy9mrmE+meXD3EcKWDo
 xeFEBbcMCCpUGYjUt34NiuXK4gdgV2mY/ftCEnvYV8OImWG3pk7BXIrGtbfnyeAk
 wNcT1lLhe8HClre9RwIydH65c7pmujpAbFiMnYv0KlDmjM5GYkHUTLyMYuG4HYx/
 xZsXPjXXfsVF7bR1GmKLNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743411794; x=
 1743498194; bh=GumTTEDN4zb8n1XFRpj1e+/6KGfcQ8tw3R8trFDBz8A=; b=x
 s7VPlX8vnC75aJT5G1f+LYyWjYgUKfFPYil5TsGSyriCZ+ONaanb1iruJpdI0K8o
 dhIsk4o77gJwYJjLry7Dr97zAv41f+tQSD1ls9Pu3yPbU8KyKGYbtcEq9w4M7uHj
 MgHBBC+Cw0t6OTF4YhKbnNWTN6SVr8i0TsWulzF7lT8BZ4tb0Lpiza4Z9QXby/Cc
 Nu2Vw7OwoC0y2ha7TGLSjlCSCF61WXmJSRmAUENPIQRlT/7rSiylqXoAIIQbTG5L
 ba2WkZ8dz4Hx8IuuIUgXY2Db1DgXc9ir+Hql8Lxk7YByuC+bXKxCuiW3C+aNkQwu
 24495SNxJ7tTl3ug8JZiQ==
X-ME-Sender: <xms:UlrqZ4TXpxGSCMQIdNnDj6oWx0UMig2cD0lPcQFuBzf-QvHVnkWOvw>
 <xme:UlrqZ1x3vb2oyO9TN7kgOmb9iy3tgcbT8n7qaRFjOecIhqJwtzCzOICTeRVX4-EVN
 0eZC5zlAydvyxOM4A>
X-ME-Received: <xmr:UlrqZ13SGMseM2r9GN7p8XGse-p3zlfMLaYGv_r0aI9bvfZlaZv0YguDiEZdK2sp7TsKZp07nMDY0DdE93Jh1wML6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelheduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehgvght
 vghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrg
 hrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhr
 tghpthhtohepthgvtghhsghorghrugesughpughkrdhorhhgpdhrtghpthhtohepmhhkrg
 hshhgrnhhisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:UlrqZ8CLMJ_Xlrq99zkguNaxHbZIlKc1bOBcC-8NLzO_JF_nrLEQkA>
 <xmx:UlrqZxjFffY5RHDmTEwGjHNpby94Y91SjGwm2IHduu8Evm_mF-4_Ig>
 <xmx:UlrqZ4oXp_XEsGKI3YRXTUpXhxVFQQbpRi-_S7m_n3Tu9jsucUxaxw>
 <xmx:UlrqZ0iTIImMaREV_1AvN3_csY7BVVnR01Fsv1sCWUOdNOShnGjPPw>
 <xmx:UlrqZ8Ulip55t-WOOYrDQlksahhKqHIoMRqNflXnla57gFN4b9lCs1cj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 05:03:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Etelson, Gregory" <getelson@nvidia.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org,
 techboard@dpdk.org, mkashani@nvidia.com
Subject: Re: DPDK for rust
Date: Mon, 31 Mar 2025 11:03:11 +0200
Message-ID: <9241799.4vTCxPXJkl@thomas>
In-Reply-To: <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
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

27/03/2025 17:17, Bruce Richardson:
> On Thu, Mar 27, 2025 at 11:00:40AM +0200, Etelson, Gregory wrote:
> > Hello Morten,
> > 
> > Thank you for raising these questions !
> > 
> > > 
> > > Do we want the DPDK project itself to support rust?
> > > Or should parts of this be a DPDK hosted project, like grout?
> > 
> > Rust packages management is different.
> > Also DPDK Rust code will eventually provide a different API.
> > At this stage, DPDK hosted project looks like a good idea.
> > 
> 
> For ease of use, that would mean hosting a cargo registry, no?

Please could you explain why it is easier to have a cargo registry?


