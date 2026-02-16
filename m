Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9BE63F15
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:23:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23B5D40662;
	Mon, 16 Feb 2026 18:23:59 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id C4BFA402D1;
 Mon, 16 Feb 2026 18:23:57 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id F175C1D00468;
 Mon, 16 Feb 2026 12:23:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 16 Feb 2026 12:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771262636;
 x=1771349036; bh=YJipmgwQpD39VtDZdEcq1bduuaW88hQZie4QY87uOfA=; b=
 V/rmnBM6l59JSWA/7Rs65TdGyYi/k6Wb9ghZrv4pLRYLXKmXsj7KoUbrNgGOu0cU
 d+Uu6Yg/cxxPnN2dhEr55zPFH4KYoi7jcmrLfnZECfkUMFvW5LJAbZe4fnV2dIu4
 9MnBBG+0gY0nTIMtgs3j5bgQ9GoyPtiLfXPPVNet4kWJEM9JZMiXXiTyMRDd2dUN
 FqJCKA5oeLxSKYdnfxnSJgBdBa7szzofgTu4s+MzcSsh1lLGzeTT8dV8gaEhFKAI
 E76kN1h4fBNU/pkvQXcn5xlQCzqCAHMTzHhbGJPK2AOofAz0AkG//VGASssH7Q9I
 Z0ixYajfYNB4mPWIdQ3jVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771262636; x=
 1771349036; bh=YJipmgwQpD39VtDZdEcq1bduuaW88hQZie4QY87uOfA=; b=C
 rmaTWHpXOGjfmszAf6QXGYtI6Vjo2AZD0BDqZaAYawj94Hu8EVgyMrCNQpL1jPRf
 RpRxDv9PSwBGEC6t38cVfKWIABC9pZc8VZVO3reTIFtYGlaxe1qwDOVOkvE82+xX
 /qbU1OJOOPVMQdLoLNE+HlF0hTh0/PNcoPrWjOGiviJZwlmsd+AlDLVz/5fkDHkp
 the/nXLKdAUB8EsG4L85Jfcp1Qhrvu9CICU1SImOU8MvYo7iaYyCCQsSKir8RIrx
 BTXAF9MgE9Nmi+/sfopgKDOSXvSuluphVqWv/vgpbKpwRaZ76Jubrxanal6Mo6mO
 tcgdY3nbXgApeMlFYQjBw==
X-ME-Sender: <xms:rFKTadAm8D3BUuzOHhFWG91Wa5G6xIyULc_HrQ8buozReUh85P0CTQ>
 <xme:rFKTaf1Rd-eikcjOwv2RZweB-s7k26Js1o_Uie2GMvs5-e94xvEqWKwScMFYzEpY2
 x4Uxt2SovCXXIPW7F3IBRbdWElv3UdemVpDI5uPwe5SoaxuSLz0lQ>
X-ME-Received: <xmr:rFKTaXvpR5ggEM589jYK9YgLziW-WetEtB4mfHMOKchDDQ4_2IQzFGxZClMqDai02qnSDiO1bzeJw637kjRGZjoq6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvlhgrughimhhirhdrmhgvughvvggukh
 hinhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:rFKTaf7imAvsoChHfsin_7b3ClNe1T4JBWT-lhJjP8ol7iY0mGBLjw>
 <xmx:rFKTaYLirgbi502wPUzCuXExt-t2_KtnNA1DnCsNXqkPvAs2iZ6BNg>
 <xmx:rFKTaf7AmWwpxytffXkV6GsVjV-Z-6v3y-YomY_ag-w0aumQr2qeqA>
 <xmx:rFKTabzbZPkTuJ0g0_gcwnjOFrvxWiGyzOw-3hPe1EEsONfcfNGH8w>
 <xmx:rFKTadmiebj_1KwJ0NHjCu9wGsIiklcBsKLm0Xi1LnEyUjMRlsE5-IaP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 12:23:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] fib: fix incorrect prefix addition handling
Date: Mon, 16 Feb 2026 18:23:53 +0100
Message-ID: <5912479.hOb7EpEr3i@thomas>
In-Reply-To: <20260121175701.41102-1-vladimir.medvedkin@intel.com>
References: <20260121175701.41102-1-vladimir.medvedkin@intel.com>
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

21/01/2026 18:57, Vladimir Medvedkin:
> When adding a prefix longer than /24 in FIB/FIB6 as a first prefix within
> its corresponding /24 supernet with the same next hop as its parent, the
> code would incorrectly skip incrementing the number of reserved TBL8 due
> to an early return statement. This could lead to integer overflow in
> 'dp->rsvd_tbl8s'. This commit corrects the logic to ensure that the
> reserved TBL8 count is properly incremented in such scenarios.
> 
> Bugzilla ID: 1731
> Fixes: 7dc7868b200d ("fib: add DIR24-8 dataplane algorithm")
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.



