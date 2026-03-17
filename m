Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA8FED9EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 17:01:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85AF5402B0;
	Tue, 17 Mar 2026 18:01:21 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 18D3E40270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 18:01:20 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 385E31D001AD;
 Tue, 17 Mar 2026 13:01:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 17 Mar 2026 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773766878;
 x=1773853278; bh=6krQC3BPyseTriF5nSImXTLZhqdsJEa+aWCfx0Kkn8s=; b=
 I588IqdEyhSG9sdKn+3n6KydnmW0lz8OD32MFjDuzEEnrG62N3bYy8YwPXMW6QRd
 gAJiw/G9rjm6gTIt07lTMXtvabr4O/HXItsrCWM65+J8RyotULQqbZ9oUApQAEZz
 zYTrKllC4SAoPNFrn8YORi92qmA3oWSw6hrvzJ091mJlwdYeiy+UoQO36fU8tlZy
 KGtsdj3wCO6GwALuxGl1cboTiljBXQJXWCPsBB4C6SpCTo6jqi7/zWfSJe5hF9u0
 T2dMnvKWU3h4j8PwRCxiYq7wH8BSwbPUbm4tmHWCKIgk9jcCXpKSxq4ICzKXJxcH
 Fk8bVC68Olg4E9mW1i4BWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773766878; x=
 1773853278; bh=6krQC3BPyseTriF5nSImXTLZhqdsJEa+aWCfx0Kkn8s=; b=q
 mZoG2e5x8XbiPwp8Eas4+XgnDV3lh9WIgdM4Ki7kgstFQ3TBmkdKCzk5v8BAewrc
 2vbimDDyyos/agX6bVNGRT3Dd1M/KsF/TWyLhSKwlZ7FjTgFjebFkHS7+EbcChrL
 KJ+I3eb1GYaSNyfbSovr3FB9nu6RJdtT+dO1rsSU7+wrM7L1nwOuI3IIvKTkzj5U
 KOJ/Xczm1zRSn3UsXy1/DSRg3aoQx2RN7CqNL7qZKXK071j+vNbRO+yQa5KtOhRe
 vU96O7pTXKfmBKHMbwfAIlpyDueaoo+B7XSu7O1gJjYVcky6rlonKQkJrOUd9mh3
 O4hZ8n51UJiYvQH1SEPXA==
X-ME-Sender: <xms:3oi5aVW_9xzFH3JvWB6ZLRvv6qgKWnSkEbmnncnb5mIgH2-uEvJtwg>
 <xme:3oi5aVtWUA6OooWGxBPGl5B1h9AAp2xleLAzG3mP667CmWO0lKZE8pr2I6tUl7vYj
 zvuL9FGwruzOYkyuJqCVPtlpGPcgqWSQ7KZCcqnp90uhbVl5El_iw>
X-ME-Received: <xmr:3oi5aZWQgTkh2SVIBdkFoZcnf939RDojm5PRSmsv7f9CQvp02yYPe9GPyfnNZ40kfp_bveddhuYTe2OjPx5UgfAYQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddukedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeeiffevleeggfefffduhffhvddvueeugfdvffdufeefieehiedv
 ueeivdfhgeenucffohhmrghinhepohhpvghnshhushgvrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghp
 thhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghluhgtrgesuggvsghirg
 hnrdhorhhgpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:3oi5aQkum8Y8karz-ZODfjZ5q2rMAZSy1MJihFuyyq8Xv8nEsvkjog>
 <xmx:3oi5aaa9pKc8-tYY_ycOwoGNmOXWr3Et6OJ4N-z3ESRxBFvxL7PK2Q>
 <xmx:3oi5abPxrwWmOeuOvtoHXxecBitQCXQ_doUW1a1VzRJyW23nK7M3zA>
 <xmx:3oi5afbwVTd_ZxRGmducTU4HwlagxHBADBa_JFczpBdLOcKsSu4zpg>
 <xmx:3oi5acxGQnGbOi5L1K98r_b608h8daVa2I9CquZYcEsHt9LkEx5yX0ZW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 13:01:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Luca Boccassi <bluca@debian.org>,
 "Ji, Kai" <kai.ji@intel.com>
Subject: Re: [PATCH] test/memcpy: reduce alignment offset coverage to fix
 timeout
Date: Tue, 17 Mar 2026 18:01:16 +0100
Message-ID: <3426001.VqM8IeB0Os@thomas>
In-Reply-To: <DS0PR11MB74580F7BC395E2044587F9628146A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260226164843.183959-1-stephen@networkplumber.org>
 <DS0PR11MB74580F7BC395E2044587F9628146A@DS0PR11MB7458.namprd11.prod.outlook.com>
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

> > The memcpy test sweeps all 32x32 src/dst alignment offset pairs which
> > causes it to timeout on slow emulated 32-bit build environments [1].
> > 
> > Replace with a curated set of 7 offsets {0, 1, 7, 15, 16, 17, 31}
> > that cover the interesting alignment boundaries. This reduces the
> > iterations from 38912 to 1862 while covering the same code paths.
> > 
> > [1]
> > https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/De
> > bian_Testing/i586
> > 
> > Reported-by: Luca Boccassi <bluca@debian.org>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> 10/03/2026 18:04, Ji, Kai:
> LGTM,
> 
> I'm not AVX-512 expert, but I think AVX-512 might expect  64-bytes alignment,.
> As the original  ALIGNMENT_UNIT is 32, so I think the selection of offsets is no problem.
> Maybe remove AVX-512 from the comments ?

Applied with AVX512 removed from the comment, thanks.


