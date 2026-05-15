Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBBCD4F25
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 14:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0345840269;
	Fri, 15 May 2026 16:04:35 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id F3605400EF
 for <dev@dpdk.org>; Fri, 15 May 2026 16:04:33 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6D6D41400043;
 Fri, 15 May 2026 10:04:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1778853873;
 x=1778940273; bh=G8Qc/VDTWtSInOlq3yCbGAEtKQb0y1pA5dlSDsIS5/I=; b=
 mEXhvqRjtH94GGCuMS//uf31HWvn+k5cigLrphLIMcIV1vkaQLocjlRAGMx+KCUN
 9iRddMeEObHYvw0fVtbKzqDOk9EbDZZELazyTLnFPHfAGPDbbcIciB+jutaemScV
 pbDvsXQNQAED8Efy7+j/CQ1aAfRP8q6Hdg3sedsxpkMjFsMWLdlzgLsKuqi0VRo+
 iH2NSu9K+g7vA96D0MdLqwBnCFBjhWp/6qs4M1/01GoZ5PlUEDQuo0qwHsAcaJi2
 HyvHJ1wpeHnuYOR8JX9ySF95vIYKCSXqScjUaxI3Ipwzw15JuERXPtbAqUvGKjVg
 oxhBztPqubR1on3l6ajU+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778853873; x=
 1778940273; bh=G8Qc/VDTWtSInOlq3yCbGAEtKQb0y1pA5dlSDsIS5/I=; b=p
 tjudATf8ZIf0VGIqtZOSfoxnL9qkoyD0Z+IQ/ZQ9CTQZdfWp1oCyzgsouZFOtmIG
 gaLAbC88UO1uQtlMssgOuKeQ4wRugowXqtK7aHZYWXD3Am1SY5hF9AOi/RVMnRcr
 EQC8p9uTex/3oOrrNuSX21+cWz0tjlnTg9bvhrApR5w7GZh/r9zVV2VfrpThV4+O
 H2HtkSpdK3Z6WrPET+TtWH3uGFP+iVnOWJvrYyTDYOvXI0Llo2p9X5YN7FkM8Mvm
 WSluJyS8lItolopJ8XYynj1nRFJPYUzUi3Y+wC6HjNXeOSgkTAOLgbhZYH1dkMpe
 UltDrbQzuApuUDDgpOK7Q==
X-ME-Sender: <xms:8CcHaiMFL4y4JB0-pG37Nf4R5RaiGkTNXjCVP3grj5ImA5TjF51Xng>
 <xme:8CcHasbvfFN36P8MVY8j7MhiLTP21SrR6OPu0GydM8UUv6Q7j8Almf4u8v7xTh0QA
 llV5hUD1pao1esjaZX4wH_5VoIR3nKxY_e2HQSO-g5r9fvAUToR>
X-ME-Received: <xmr:8CcHaswOERKndvohAw2eEboQ0aIoDCPut7QJhSZDLa80nonLhstcbKTa3KeKfZ990ArYFiVOKzpzB7pnkOwJxEdWsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtheelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifuhiiohhnghihuhdusehhuhgrfigvih
 drtghomhdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgtohhm
 pdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgrnhhghhgroh
 duudeshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuhhlohhnghhfrghngheshhhu
 rgifvghirdgtohhm
X-ME-Proxy: <xmx:8CcHanJ7y6uEDp8TnWlPWBxY3LAxE3sQvNg7DiH36HUu6AGixBQ5HA>
 <xmx:8CcHamqOtkIbMDm8M7jGVkThPNHznWi5vALT0sJwvlSUmbe84hxKdw>
 <xmx:8CcHamIJByd6SbZTzrrsEPz8CNck0QgzKnbdVl9dryqEyUocZTkpdA>
 <xmx:8CcHarTH2sd7Iha8WG8sGcgADisWC6qXeMNkhaJchbifcrUI4cut3w>
 <xmx:8ScHakWzKJaNMcAD2T7VSgLgAkss0mwX4jHMVmUSJPMKrQ0yMR4E8x8Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 10:04:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: ZongYu Wu <wuzongyu1@huawei.com>, fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, fanghao11@huawei.com, liulongfang@huawei.com
Subject: Re: [PATCH] maintainers: update for compress/uadk and crypto/uadk
 driver
Date: Fri, 15 May 2026 16:04:30 +0200
Message-ID: <TX4cwzuuTSm-QPIC3VWqbw@monjalon.net>
In-Reply-To: <3c80e9fb-c285-4928-ade2-15a2bc1da914@huawei.com>
References: <20260514124049.3133884-1-wuzongyu1@huawei.com>
 <3c80e9fb-c285-4928-ade2-15a2bc1da914@huawei.com>
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

15/05/2026 02:06, fengchengwen:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> Please
> 1\ For commitlog, each line contain a maximum of 72 characters.
> 2\ Add you name in .mailmap
> 
> On 5/14/2026 8:40 PM, ZongYu Wu wrote:
> > From: Zongyu Wu <wuzongyu1@huawei.com>
> > 
> > Zongyu Wu replaces Zhangfei Gao as the maintainer of compress/uadk and crypto/uadk.
> > 
> > Signed-off-by: Zongyu Wu <wuzongyu1@huawei.com>

Applied with mailmap addition, thanks.



