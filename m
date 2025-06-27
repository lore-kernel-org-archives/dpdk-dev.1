Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39F7C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 20:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E1A84026D;
	Fri, 27 Jun 2025 22:09:00 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE7B400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 22:08:59 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 96DC9EC027C;
 Fri, 27 Jun 2025 16:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 27 Jun 2025 16:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751054938;
 x=1751141338; bh=CDQmZM8LBB5WLg9AFKO03tZIZqevVAed+R7FqcBxcKk=; b=
 R2jVWsZBZLnYQ43nx/9n44JDKnvjZpuQ96tstKLsQGzjMSo4eQzV6/QPMMyAb72i
 co0A+CiBgo/sdBwmrncpSt4GFUBphBq9x3IpxBUuWbQ0Khex8C/W7b7OAqaDcOVf
 ywYnG3ZOhPqFMY74ufTuXEMxcVHvlyHXLNupB4NXVA9VBqSVKlhdO/vXRoYu78M6
 enMGaJHA9/OSE1TZ29E8iqR9PYVK3rg1mNE/YnbP+K0d4SvmUC75sFx481JNvl+V
 yoDwxtXkWIPgxA2H59CvT3rU0bT9n7svh4v41HkQ59zTLlSt1kAOUKIR6VhIOP7D
 w806G71S3uQCSLxHblleVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751054938; x=
 1751141338; bh=CDQmZM8LBB5WLg9AFKO03tZIZqevVAed+R7FqcBxcKk=; b=W
 k/65sBXWNkY3GJeO4HnDmfEomdOb2I0antGjBuZ2hE5XoccitF4dtHbuPnNZIg9M
 ehJjVX5ikhRlv6hHmaVSxCGFpl0Lsh9f07PgaBMwl6Q3FIwnsI5S3RknUm8DTg3+
 xDqEINiXkWhBLdRk3cBGbBWkMQc2T7F+1hIEgkatU9pplOu8MgHcEU9r6vWXjfOk
 JoCRF7gSTEtHvgWgz1j5iWvlyyNm4XQ2q+WVX1cBF7lHY5bOeah1NScQShKgAUOI
 qQy8102N7z4xqT6KPTfIeoRxHUEIv23t6rjG90uitctofpwB+QjRZDmmsx2ZvdH+
 cbVH4SAMelsZHc2NehMnA==
X-ME-Sender: <xms:WfpeaNyioTtBWHM-6CDmYnYnOe5wqR_UwYOmHjbLlgokAa7LiaRB7w>
 <xme:WfpeaNQb6s55a0SJF5B5sUj0KicbJUwoysop5aoUTySRHFsPZDUi0zhpE_WLcukAr
 wDwZk3c01zY8YR_1w>
X-ME-Received: <xmr:WfpeaHWpfuWkJxZMNISeFB6myq27x0GtEh7SH__Xw1lR5qNEVAMW-flu475qZJ1Hr0rONh5HChKWENXakKOnFD9FZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehprhhiihhkohhnvgesihhkihdrfhhipdhrtg
 hpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheptghhvghnsghogiesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtghomh
X-ME-Proxy: <xmx:WfpeaPiw7HUFSpnXlbxYOl8r_waxjJuH4-_lJr6UEgirseCamHAYYA>
 <xmx:WfpeaPDtqU2A2FTmZrUELKH-UpaAXwcJPgj28jD7ySHE_F89ng-jAw>
 <xmx:WfpeaIKLRrc0Aj4UOTDdMYsyNzqyEc8iLUonMSdxYB5SaII0982Fmw>
 <xmx:WfpeaODD1TQx_T_ZdQn9PHWgcx-estoqf9r-2IamIOyd6i_V_z-bXg>
 <xmx:WvpeaAk5LYtvE3MR5kiZHx0YAnJQaKr_IODq2-bwog6NtTEWtigqty_g>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 16:08:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pekka Riikonen <priikone@iki.fi>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH] bus/pci: fix automatic interrupt type selection
Date: Fri, 27 Jun 2025 22:08:54 +0200
Message-ID: <4268105.sGnKIMrFRI@thomas>
In-Reply-To: <cdbd9d284dd174f99601f032ca6ee8fa@iki.fi>
References: <8f5b22d3bedef793bf489c230b52b145@iki.fi>
 <7218036.9CP3fYhb5E@thomas>
 <cdbd9d284dd174f99601f032ca6ee8fa@iki.fi>
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

27/06/2025 21:33, Pekka Riikonen:
> On 2025-06-27 19:00, Thomas Monjalon wrote:
> > 20/06/2025 13:47, priikone@iki.fi:
> >> Check if kernel returns 0 interrupt vectors and try another interrupt
> >> type in that case.  Failing to check the vector count can select an
> >> interrupt type that's unusable.
> >> 
> >> Signed-off-by: Pekka Riikonen <priikone@iki.fi>
> > 
> > Please could you be explicit about the use case you are trying to fix?
> 
> This particular case was with e1000em that only supported INTx, but the 
> function selected MSI-X simply because it's the first one attempted, 
> even though it got 0 vectors.  Enabling interrupts then failed.  If the 
> function had checked the vector count it would have correctly selected 
> INTx.  Now, my setup might have been quite old but it doesn't change 
> that it selected wrong interrupt type.

OK thank you, it helps for the review, and could be added to the commit log.

Adding PCI bus maintainers for review.


