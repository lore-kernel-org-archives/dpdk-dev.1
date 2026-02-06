Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF6AEB28FA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81BBF4029A;
	Fri,  6 Feb 2026 10:37:35 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 64B5D40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:37:34 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 4957C1D00090;
 Fri,  6 Feb 2026 04:37:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 04:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770370653;
 x=1770457053; bh=ttUC9MmPbNEfNMZPUCXN2QLnq62L0AxuEWgkqaIkyfI=; b=
 jK2zJw/YU2Al8AykvYLMPv1yZGN5oxmBPP1CcfUgePd0hncOfLuK7CW14DC4Left
 //TeJqJ/LqpAvE/9xaQhqBayln6od9GO2cwN1CXmnl6+cYQ/FB7LI1XWJYshkDWn
 jEHKFgYHmNwNnRQPwS8T9FQhzBCWgMIwA44enVddTdnMybrTeznH0aiJ4bWt4rEj
 lXZbqR8i5i1Edaip+mJayuoR14CNRdorY2a/hfeek2DJ3YUmybv0g8okAqabMNkk
 N2toIMbsGwtS3XCEHQ5g7sw+Dqjllkcu2ExFSZgpnDOwT1YMTMuMc+IaJQ3Wx0/W
 FdpPD9/ClAIfFChQmGzV6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770370653; x=
 1770457053; bh=ttUC9MmPbNEfNMZPUCXN2QLnq62L0AxuEWgkqaIkyfI=; b=X
 FYzlUnAvN2KENg3xtcRSzmIBq7Y8N9evR5bnO3tPYOSQ0qhjHMWIBNhS1xdc0Ruh
 AeVF4BJ1Wz4KbHSSo1chC734T1Swtoy/LxTeLfH/H5eLTwYfBSKhf8M0BVlEc2vW
 B9wdMh25QWDtypXGaprcOKaoKMx65GKtIfnZVk90fFPDt1SIKYpRD0hdkE2okmju
 POoZ8Efstj2M4vJW2vb0pP0W6GDFQxLz7TwutaLAzGOWS1v9MpjYnhs6WyWrxyja
 oM4LV9IqUVy/e/dNW2GbsX6eQnf5GkfAjqDiQYjjzcmiBLQeXWLVjS3UQSol9vp6
 OdV3oMheFaxop5XzbkgbQ==
X-ME-Sender: <xms:XLaFaVW0zXvWoqX5QPBylH1WxEpl392WU3K5siIfISycEftiuBeeTQ>
 <xme:XLaFaR4ToTxk8Jjw1HhZFpGY4durISbDU47RPYGGA48GdBs2sg2FT9ASGMv2A8-jQ
 hC6cZN1kKLsca2oWtXmTLnsEwzp14l67Fv2P7nSJ07XeXsDbkxqaA>
X-ME-Received: <xmr:XLaFaUIhaToAmf_O2fagjFFqnsg_o_zW0fntbZUchZFM5-iDpjvZ8TcaDkfuLK69OuFYyD56CCXVhyfhpp0wusii4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:XLaFaaIUEBAtKxIMGMytW5FR0Mgxusq08s-V24qCcwMCsZYGCalV0w>
 <xmx:XLaFaSVLA_8pjT0YTeYw8BD6RKwwOkjAXF2aqIdOEIHUvDkCYq2Jng>
 <xmx:XLaFaciF4A00tjSCd2wByCYhe6RW2ISiJxMHylY7VmkLylxFzdW9ZQ>
 <xmx:XLaFad8j8U77cV8cRbQzCi3Xe1Ej1apUpnVvsOWlnetHunaqzrdn4g>
 <xmx:XbaFaaqCaTTfxSRiMmGz0-DTfnf1B1SGbMgTuaZli08K18J4EgxKiCSp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 04:37:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: fix indent in SPDX check
Date: Fri, 06 Feb 2026 10:37:30 +0100
Message-ID: <3359303.NG923GbCHz@thomas>
In-Reply-To: <20260206083649.2625478-1-david.marchand@redhat.com>
References: <20260206083649.2625478-1-david.marchand@redhat.com>
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

06/02/2026 09:36, David Marchand:
> We have a mix of tabs and spaces.
> Clean this up.

Most shell scripts in devtools are indented with tabs.
So replacing spaces with tabs makes more sense here.
And of course, if someone asks, vim is better than emacs ;)



