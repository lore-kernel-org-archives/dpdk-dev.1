Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA054CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 10:05:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E47E94029D;
	Sun, 19 Oct 2025 12:05:48 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id DC0C94013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 12:05:47 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id BA5841D000DE;
 Sun, 19 Oct 2025 06:05:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sun, 19 Oct 2025 06:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760868346;
 x=1760954746; bh=KgElTUAbEPvS22v0IJeObEzAY75iA6rsYlD/LSsgvZA=; b=
 esiD7zdP4I+L9qzUWTIAeTcExXiIaOfV20e2EHjZZSmguaOGk5gPwfwjBM63GIxz
 Cm9AlL/YthKoAz8Oy/XjBaTNaRo0KqialqVlCdABzs33uRFGQgavWKfd0yWXB0W9
 bP3sP8YTS3u25dUJl6lpzBd033KVOLfbMrNgSHLltbf4nW313fubiKKvgNpzJiMw
 aTpZDYeOWWy9YLBuEv7u/U+v7zMlXgZHRheCm2tjbHs5OwLeX7lGDtq17n8wV8Kg
 jXmCKjY9tH2O5NtZ6YDpMs+zN+h5vRPXKu8LJNzWSolS7GvIvNrT1BzKUQRerOKT
 sGLkiffFmNYWliEkMVT6lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760868346; x=
 1760954746; bh=KgElTUAbEPvS22v0IJeObEzAY75iA6rsYlD/LSsgvZA=; b=l
 nX8Nrh8xvm0NxPfI/AjEEZjdOPC+HMq2d27Xzte817XsHOSwWK3CLqxA4rLfs63I
 1DRPphu+rw5Au22iYeEka98mZzduB0AZi5c7ly54HUgeFQH+G4+SlGbbCGoNDLBS
 20N91j0JSKvQ8kxjqa2q6Gxq+dVWIP7gOkPcxHls/qsgvZIT/yvTiEQbM3xzGq+P
 qaDohJwC7fIsYSEw+YmojPG3Z7GkecRKl22ull1Vqc5dLdA468goo/DNt/Mfu42e
 e+BGhs/PSmubuMpmWMAaNsUVIVcfvU0CbMrfuIzJMvq/PMXCARhdulUw5mb/bKqR
 j5ar9GITbg4Adjgc0bczA==
X-ME-Sender: <xms:-bf0aAqtIxTXge7df6P_6vuVEU57Qe8y_ywXdZdsph12am-N_vgP_g>
 <xme:-bf0aBnID2Gr64rzRRlz2gsUrxGLJBTqtQiCYS9UXh7AuMM_rswfvpo9SYn0Gov5m
 c-xPzanUNHWh3XNUXisUPI0VA0T-YlnmSNS_3XluwjgjEDpXDSEuA>
X-ME-Received: <xmr:-bf0aEMfk7TF43mg_lJIwJhv1iolDH2XuQSEW-Aeo1-UY5qwhyQgawZ0yvQTGyYFtHZIkVriRSQwY21mXFo9QdC4aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeegieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghtthhunhhurhhusehmrghrvhgvlh
 hlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgv
 nhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsrhhutggvrd
 hrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgrthholhih
 rdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgrrg
 htiiesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdr
 tghomh
X-ME-Proxy: <xmx:-rf0aNOFTPvFABxwDr5SSds8MDQfwIyb0XWd5AIfdG5qmMTQkiZwVQ>
 <xmx:-rf0aNhomAMYYOMoeqK-LzwQEeIhNzqyzimH-hAeWY3DjMLYnKeGwQ>
 <xmx:-rf0aCsi5vsRdS26qlAeeR0ps4sNHedujaGbIb18r3SyTpJ0rYQT4A>
 <xmx:-rf0aLQCCBXBDrKZ-RW6_66YqIDDNK9R7WS9Puc3UFBbvpRk5NNL-g>
 <xmx:-rf0aBvhLdsx-gUaKznRrsK1LjyElbutU-rg9qeoFFVP-rZcdrnsDXZh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 06:05:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for
 inter-domain DMA transfers
Date: Sun, 19 Oct 2025 12:05:43 +0200
Message-ID: <2433631.BzM5BlMlMQ@thomas>
In-Reply-To: <SJ4PPFEA6F74CA2D94960610504A37EF3E1A6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <4681397.3daJWjYHZt@thomas>
 <SJ4PPFEA6F74CA2D94960610504A37EF3E1A6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
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

19/10/2025 11:40, Vamsi Krishna Attunuru:
> From: Thomas Monjalon <thomas@monjalon.net>
> >19/10/2025 10:37, Vamsi Krishna Attunuru:
> >> >I'm not sure about having different API functions for leave and destroy.
> >> >I think the last leaving should automatically call the destroy driver function.
> >>
> >> Thanks Thomas. The leave and destroy operations are invoked from
> >different contexts.
> >> Group joiners call leave to exit the group, whereas group creator
> >> calls destroy to terminate the group after all members have left.
> >
> >I understand that, but why having a different function?
> >You could destroy automatically when all have left.
> >
> 
> Yes, but I think the group creator & joiner's contexts and their lifecycles may not
> be tightly coupled here. If the creator intends to maintain the group for future joiners
> or delayed cleanup, it might lead to premature termination.
> 
> With destroy API, group creator will have explicit control over group termination,
> and not inferred from usage.

OK


