Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5352DCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84E4D40267;
	Tue, 19 Aug 2025 13:30:53 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 5FF2740144
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:30:52 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id D6AEEEC0824;
 Tue, 19 Aug 2025 07:30:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 07:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755603051;
 x=1755689451; bh=qxp/vAiw4R0PRnS5nzs9VXrF0kI1+iW4Ce+hc6Mb8zY=; b=
 J5ZpUNgsC9X5HOIwmiPfUiO/7CbSW+UAmhVgNQhX6ijLwllaN6NZOqNqK0jlB1hg
 iQBX1RS0t4nDpkHkmKucDuvGlHtibpW2bJQXSzlyczjee+RxugwRaoNTgov1rUTf
 tW/hJCdAmi8PtmA6jizXH4XO1DDpsSSS1zcLsTSNyaokF7GSEaK7MXaJdNaK4RyN
 Izk2IJBthb9COiTrzeJyr0xdwJQW3SlpNh6hD0ZGSThzxk4IkkiqGa3kA7ORAryT
 cPbdFasHTBvfXeXZSuKUDJzF6Kp9g8LgY4VG9rWtYZ8f2DwtUNSuUtiZSA7SPOdZ
 BJbbcJpjn7pbFipvmF3ZoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755603051; x=
 1755689451; bh=qxp/vAiw4R0PRnS5nzs9VXrF0kI1+iW4Ce+hc6Mb8zY=; b=U
 CZZ3Jiztn+4h8xGDlOQWxVCFZQrSIQr/vI/lnfouxH+faj0Vv1Dj3eW8XZzS+6Qi
 lthY4rtA7RNwrQMP4guu/hjptqe0IOc0VOrZCI5DU7xTU8W4mrmQRJ6y5WK+E1NH
 sKJgZMDahNNPMDD7R+60WwL6fXByKdr+VrpnkgQ/O+awgUX7MDaRTqefUCpT1A66
 vsiZY0gGDFHgMxhOoBqZySTyq+CAHKK0VSQud5uUdoGYYVmcMYvoJhQM7N53evBI
 d/mFlXb1SNqq+8TkigGuyF0iIzsxS4BUBz9V255oQWq3EaCz5XxMuz685BGtWtBu
 H0nBfCSwfY0G4y16/wSGw==
X-ME-Sender: <xms:a2CkaBTNYo2JEI7dPmjXQ4w5_1C1x-jpizMy3GTbAWQupZhEaOh8Uw>
 <xme:a2CkaFpTlMt_AD0S53toAmYlytSN2GDmePhDCgy9fo3Rcy14yZtjmz46msGUOWY67
 Awg9E3Urx9bcT6MBQ>
X-ME-Received: <xmr:a2CkaOoZMTdMPAzOCH1P2RcGMQaWrMiSqLa0gYhnYGwJXvc33OfmCdEbaa4LhkiYuZSKcDce_dtsjBjlN1xkguafZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrvhhinhdrsggrthhhihhjrgesug
 gvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 phhrrghvihhnrdhmrdgsrghthhhijhgrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
 htohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:a2CkaHNS0trxn7pulXVewBG6_rJLixUHy6rc1XWvh_MgNRtlTPkefA>
 <xmx:a2CkaPx6xLZ2YhM30TjZuu_sbyS7CExQnVrncSBgpg3RrXOEGvmu4w>
 <xmx:a2CkaAv7t-3HXhE9aVRQ9Omq7ek9hI4qU1xNaNh5qoCmzgu9YV8ddQ>
 <xmx:a2CkaI4TnMmmpcjF82vZOwVGygELgWCRZ9KKCW2D-4dUbVHS-RTucA>
 <xmx:a2CkaG4AIOnBFJM4lUeZGtch1Nw43th2urzabBj-k0tMimMVYdIVy1jw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 07:30:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: dev@dpdk.org, pravin.m.bathija.dev@gmail.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH 1/3] mailmap: add user
Date: Tue, 19 Aug 2025 13:30:49 +0200
Message-ID: <18879065.sWSEgdgrri@thomas>
In-Reply-To: <20250812023358.2400020-2-pravin.bathija@dell.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <20250812023358.2400020-2-pravin.bathija@dell.com>
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

12/08/2025 04:33, Pravin M Bathija:
> add new user to mailmap
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>

This patch can be squashed with the next one.

> --- a/.mailmap
> +++ b/.mailmap
> +Pravin M Bathija <pravin.bathija@dell.com> <pravin.m.bathija.dev@gmail.com>

If you intend to use the first address for your contributions,
no need to fill the gmail one here.
We try to keep only a single address if possible.



