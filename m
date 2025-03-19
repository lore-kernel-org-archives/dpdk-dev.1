Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE585C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 11:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BA4A402C4;
	Wed, 19 Mar 2025 12:48:28 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 0A25E4026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 12:48:27 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F2C6D2540213;
 Wed, 19 Mar 2025 07:48:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 19 Mar 2025 07:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742384905;
 x=1742471305; bh=G4/vJgkJ6SmrTwt0VyEvaE02Kyx/U/U7Ayq8Vpt33hc=; b=
 ivouR/jhSZ+/TzXXtib8vd1yG3hL5LX2gaevvfDGDiXTkhQcCHVgy4mb5yWNhhyd
 vB+q+Uiss1eZy7WXo6FjiEhUbjwrmniy6+NgLc008pavO8sqbMWnPf3n8f5TZVax
 Huq2WyqH4HOUlBkH0k0ihLBkmo9PbQCtYxbSaitARMD4QA20k8O+fkaXUPhbODe1
 uIG5G14bU/MD3h0wd0w+VaS3H31rmTP6W/3n74FAP9TOvQHoRAB/LKWpn/qinSTW
 x5TBM4ycdO3b2VivFy172Ibu5fDBGxTSaLkUKZNH9FOeBo6I4qeEsztYGhNDEDAf
 NqQuvxw28xiSLphJsnR1kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742384905; x=
 1742471305; bh=G4/vJgkJ6SmrTwt0VyEvaE02Kyx/U/U7Ayq8Vpt33hc=; b=6
 62BYloTSyed2oT4VfP2VfPYWd6DoW8pGnw5dbYoL5hS3i56HVDSQzr5mq9SMYauU
 KvGmsKQWGMRGA5lLtSfBm/GFQ1XALl7+WVti2dnDbX/Ej5NUKR/0WtYDUaLXzOaY
 4V2RHgI2BUxUbVGmOrpdCUpKxAZ7OhbZhJyiZg4DGT/w/xyFYsmtt0Ee6zGIxZAT
 Cjtzz9U15rRGY4WED+XdIo96F+jGlHS7+itk3wAa0WOYykFVD0K08CxcudeR2GuN
 T2vDLXcgkUyZ83NtfwnucJu2UE/aJ0xP4ZqhaoVsGVtMUpKh42XTiU+G7sxmTvqd
 +7PlQDH7nkr5ktb2bkvKA==
X-ME-Sender: <xms:Ca_aZ_x2tUwYdnjESC46JihXr2-omfva9tbFHzOMNXwkS9ncqLbmqw>
 <xme:Ca_aZ3QtcDJFwf3H-vb0XmYMwwRmsdff66a7vgdnw49hCwCnTnYC457bSA786MUyQ
 Kc-wjWR_H3S_GcJUg>
X-ME-Received: <xmr:Ca_aZ5Xq6bhBPLJzwLGXFsrR2fdGubTROp2dt5JiOzVod1xQ9-oSKbD13DH3kCzf9orytJhyq-2d9fE5OeXUsH3-Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvg
 htvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgshhgrghgrvhgrthhu
 lhgrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehr
 rghslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopeifrghthhhsrghlrgdrvh
 hithhhrghnrghgvgesrghrmhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgr
 rhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvg
 hllhdrtghomh
X-ME-Proxy: <xmx:Ca_aZ5grmqB4JyMsW1n7WvffBrlAj7i52kg3InyBq35YbE-QA6vM6Q>
 <xmx:Ca_aZxDkMiHwGG4y7eQMnPnA1o3NgePkU2uQp689DLRnF-c5lkAgTw>
 <xmx:Ca_aZyIXOHuLY1Gz0Sj56JXZx0BUbt7itcnK9i6p8v1f9aSlPFUYlQ>
 <xmx:Ca_aZwD3nx3KSa94p3nDlYRhpS3r2-uk-EkA3Cq4--P63uN56XZo1Q>
 <xmx:Ca_aZ12ibCr9xvEUTdyqYHDh7QPjUbbgb0h9lH_tcEqjEJdX6yKhjAHz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 07:48:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "mkashani@nvidia.com" <mkashani@nvidia.com>,
 "rasland@nvidia.com" <rasland@nvidia.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] [PATCH] config/arm: fix meson for native instruction
 set Arm CPUs
Date: Wed, 19 Mar 2025 12:48:22 +0100
Message-ID: <18752085.0ZKypZ73Fx@thomas>
In-Reply-To: <PH0PR18MB4086C3FC869C820807A4FA67DED92@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250319102505.596678-1-getelson@nvidia.com>
 <PH0PR18MB4086559122474B889285A20FDED92@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH0PR18MB4086C3FC869C820807A4FA67DED92@PH0PR18MB4086.namprd18.prod.outlook.com>
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

19/03/2025 12:10, Pavan Nikhilesh Bhagavatula:
> > Hi Gregory,
> > 
> > > Arm meson.build unconditionally relays on the `extra_features`
> > > member of SoC configuration.
> > >
> > > SoC dictionary is populated for Arm CPUs with generic instruction set
> > > only.
> > > For Arm CPUs with native CPU instruction set the SoC dictionary is
> > > empty.
> > >
> > > meson setup failed for the BlueField-3 because it belongs to
> > > the native Arm CPU instruction set.
> > >
> > > The patch adds global definition for extra_features.
> > >
> > > Fixes: 7829776d0abf ("config/arm: add extra -march features")
> > > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> 
> Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied, thanks.


