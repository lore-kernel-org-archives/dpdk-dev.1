Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421AF3381E
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C664064A;
	Tue, 17 Mar 2026 09:58:00 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id E791C40270;
 Tue, 17 Mar 2026 09:57:58 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 950D3EC00E3;
 Tue, 17 Mar 2026 04:57:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 04:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773737878;
 x=1773824278; bh=UGI7ST/hOxw04I/zH1SJ+kp6xkioUv5htBpvcLJveC8=; b=
 XcXNBfrPOtIsYLO5/8QDAmANl/qzJLh3HI+Fyt9K12oW/LQQTA2vAqAGeTmnI+ap
 uM/80FwVBEahEM7lbKoq+kc8IbaTr3eZBkpGEMhJS4Xbj3h6LVYSkiIyfNvccqlG
 aBQs6Zug0kMhaQwf3EUPh2UihbtFB9NY1GvYMD+BZOSRwJ4QEIWJ6QboKvXbUgGN
 925bzCFeo/ZxcPCr8rePAtt9RQsWmy5fvSI4alGfyIHbgNsBQa7KfzCotpSrUz9s
 o0hCbMp+gzqJnuohyRnd5lQsP8zmVGDkMKtbDtslGSiU5Wsv99X5I2HrjHbQPBv4
 lC896PB4mr0IxabHhiKN7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773737878; x=
 1773824278; bh=UGI7ST/hOxw04I/zH1SJ+kp6xkioUv5htBpvcLJveC8=; b=A
 G+DR+29HHCPNJQpSbP7OrSOpY/ImEoSuVegKrvxAfs7ER7DzD2vwi44XfNBbo6Gw
 2L9FQ22M2ywqTyZmsyJULHcK0CeMA/yuX9Dft8IHQLryCpMO7xlvA4s1cjJXnSl6
 ccmrmpz5UPF4vW8iWiWNvUHhWviigg6uMeVExm4jMVOKn69k71PWxSu5xbKU0jNK
 4+7m3OhcQxsZgpsNrnDpVn9QdqlgoKA6qkNrJHJO6QVjaY/h/1M4EtYwtw0SAJ1U
 IGvDazgIR/B5sVQfVBMBKegL/l/qi4S9PTSu3xtwRA14ILnKl+MgUszxidG1/kZ0
 Fc4FxoiEeo0hXeu8HyDsQ==
X-ME-Sender: <xms:lhe5ad4_5uBo-DofmXVg8pqg4jUUYSCud6_xXw0RzPufNGcWOIjJGw>
 <xme:lhe5aU8FYFYmnNeKSCu332wZtNON4nzse-evHMdAYg-Utkqo6xBrLH1gZI3ju6YlU
 RHm0NxWFAl5kwLpHjTOwPg0yNWXdYSQZTWw4K823YKlOOdQj5th7g>
X-ME-Received: <xmr:lhe5aUWYVebM3tmskA4FLF-MiSZrysbWlBdrL0_dhaicBA1j2xlJO29KLNv91lrMWK_EwCccRYewPLRSmRqrZp-nnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegthhgrihhtrghnhigrsggrsghugidrthgr
 lhhluhhrihesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnh
 eshhhurgifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htoheprghmrghnrdguvggvphdrshhinhhghhesihhnthgvlhdrtghomhdprhgtphhtthho
 pehshhgrihhqrdifrghnihesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:lhe5aXrORL0kmZuuBDDO6kiwPKes5v6QBeOmFnZ4X5HXRi7t1lOnow>
 <xmx:lhe5aelD0h_kOcicEWGgWUOqrKaX_LfOkYet0TVhcDwVA3kDVti4Mw>
 <xmx:lhe5af1dP5MxJsJsV8yhCCLhAROXyHLN7vqWKDASKKa6wreGbuQP6w>
 <xmx:lhe5aTTh5tOlC_JoXKkeQWBwlKAUhxryNSjJLbI6DVMndwcRkeW64Q>
 <xmx:lhe5aaTJj7h26o8LYtf_lXXTNrXob2BS6DtfTOQtew-t30S4tXo7IDr_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:57:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: stephen@networkplumber.org,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: fix DCB forwarding TC mask and queue guard
Date: Tue, 17 Mar 2026 09:57:55 +0100
Message-ID: <5157955.0VBMTVartN@thomas>
In-Reply-To: <20260316062118.1508009-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260316062118.1508009-1-chaitanyababux.talluri@intel.com>
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

16/03/2026 07:21, Talluri Chaitanyababu:
> Update forwarding TC mask based on configured traffic classes to properly
> handle both 4 TC and 8 TC modes. The bitmask calculation (1u << nb_tcs) - 1
> correctly creates masks for all available traffic classes (0xF for 4 TCs,
> 0xFF for 8 TCs).

I don't know why this patch was merged in next-net without any review.
It has been pulled in main yesterday, sorry for that.
You'll need to make another patch to fix after the complete review.

Stephen, please don't merge too fast if no review.


