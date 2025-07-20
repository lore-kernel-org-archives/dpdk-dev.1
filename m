Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B28C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 21:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 559AD402CA;
	Sun, 20 Jul 2025 23:56:59 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 14B894026D
 for <dev@dpdk.org>; Sun, 20 Jul 2025 23:56:57 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id A9ECDEC0108;
 Sun, 20 Jul 2025 17:56:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 20 Jul 2025 17:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753048616;
 x=1753135016; bh=z4KI7rYVX0KC08haLK87KXR/Ae/FfxF0YHS2/KnPTpQ=; b=
 GEZ0v6Ia7lDrnpVOYPKyDVXNWlJP1lnEJDoEPC7qMKGL1mVW64HkAdnQq249PErF
 xISzRkxz9BLo1dEF5URHdRsf/qlLHxBJ1sgBrraZEnimiIRURVCcmt1Nc5QtVztH
 p4lxg7+Rg+reFS+NAOkldufBveRZ92iY34QWCy9nw6J2GigShPJ8VIuvxCN1UpXJ
 Qwhh6G2k94Ix5IUo9vgKecCuYA3VrX+yUYhN22ZaKN/t3V9gvwTXIE4AbfHZKpYH
 dpHirWJsxXWH7cf4dRNSZJiVheMnOGQxrOdqzQA7bc55TrVylQFBuO7+dnVMrueQ
 1y75WNxrgipPViYmh4O2jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753048616; x=
 1753135016; bh=z4KI7rYVX0KC08haLK87KXR/Ae/FfxF0YHS2/KnPTpQ=; b=I
 zORwMl+sKHXIn1kiXcX4I033T3kVVS2JnxYUKqD7fSODrpXBv6KjU7izw4s3xLll
 0T870gsUmUv20VJV03H0+Lv/bimwVdITRdYL+1C0qZDSNW/+DrtjYz6B7neUoPhW
 ZIB3d6HZ5vu1zf8rN5qOaHhsrzp/AM8gpCBSb3cGQP/KC3ODhD0AkPHuSQ+EqojC
 0lfpE261bwk87uV3WIKf5dBsZGM2fT5IAXM0yqNnhH53xO+EWEQFNqLaoZ/PbzeL
 emiFwj7GjaNOWKAr5cs7Unf9h7F5cdOHiixHi4qJVMRQZtWTeu/8GaTsxw2plyRu
 EhRSV8qE3TF+CEJ9yrE9A==
X-ME-Sender: <xms:KGZ9aPqVBeridreXiFKa1xwPXenRA_3PNKqHCc72V5Mx19fw4ovZig>
 <xme:KGZ9aO6Alsbryvr1BdsJdtwE6uCkKDXk7JuqYoi4RYHtzyX6Kr73IEHOz5LBq72ps
 m2YCRRhHI7pZTtzRQ>
X-ME-Received: <xmr:KGZ9aN5Y5t2WHsleHbKLTOL7urIOm2wAid7WBO-ZJ6Ea_aa1zHhqOE9rhKoSTxjN1edmoEMHnUbGE4TjYulaNkUrAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtdeffecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:KGZ9aLFA3BNZUPAUB2_JQSoKVWcV5YXTUxvojlgMC-DFaflOf6Wu5A>
 <xmx:KGZ9aGTa7J9Tsm9nansnZisfBclCJwpNgwU3XPfhHJrlFjEvZlyBUw>
 <xmx:KGZ9aEtSBdoRg4vG4utxaM_GHtdFNA_ppgUXf_--hl-_iHTxw1Duyw>
 <xmx:KGZ9aFxX7yAH8U74vEXd7IC0XPOB_VfOaXlATzGQz3u1T_CpLTziuQ>
 <xmx:KGZ9aIFdt8mlswXt7Lakvl6iodUfl2Vypm_dCx4hg6xIq3lnYZh3FHwz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 17:56:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] cpu0 and memory channels doc update
Date: Sun, 20 Jul 2025 23:56:54 +0200
Message-ID: <5589293.Sb9uPGUboI@thomas>
In-Reply-To: <20250715215718.7388-1-stephen@networkplumber.org>
References: <20240718184326.21375-1-stephen@networkplumber.org>
 <20250715215718.7388-1-stephen@networkplumber.org>
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

15/07/2025 23:56, Stephen Hemminger:
> This is revised version of earlier patches to address
> some guidance about CPU and memory channels in the documentation.
> 
> Stephen Hemminger (2):
>   doc: add note about CPU 0
>   doc: remove use of '-n 4' option in documentation examples

Applied, thanks.



