Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB68E63F0B
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AEF340274;
	Sun, 15 Feb 2026 20:11:53 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 2282040269
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:11:52 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 393137A0572;
 Sun, 15 Feb 2026 14:11:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 15 Feb 2026 14:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771182710;
 x=1771269110; bh=DNsU375TNbRcTXp2TJRxlbou0cIZkvCz5HD65iktHPM=; b=
 PQgSa4XwffMi6FtADBbA6kVcPipLpWtk4Su0FR26zxo7suQqQksQHiXM0d+z8LV6
 xHdUcQWLki6Zl+GsehjyVF6H8JEzcJz9eDqSyMEzyLDaYRgWKh4KAtjgvpG0N7p2
 7JoOvV30XgcJNnpx9fSVUfkYDoOxp195ITj+B/C0qpuSRQDUZXp/82c1kX3/e/kQ
 uFJS4al17WBVjBJEKmzxBqApG4xKV9RLKCwxJON9Cldki4+neMvzO8p4fLMb9FKF
 SusffvSyarV3odDgRuo9cOXQbw/pDhcPwzfeiW+tjbm21293nIIuE85TOQr5ZYJY
 eEvTGIBa9it5gswDmfvb3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771182710; x=
 1771269110; bh=DNsU375TNbRcTXp2TJRxlbou0cIZkvCz5HD65iktHPM=; b=D
 8DOtM2xAJ33WA8LoiOdGiGqdsBglm/OuyqB5S89NAlc5XUWZ2wFPiCFkWFC1Zj9O
 LCKJ+aK43+m3mvJSRi8Byw6mR1kL1zJM+0CvfG49Cec6vuaDjw+et9UEunCPWALg
 5YSSyiCPI4T+96SHDRLOhaYbmlPxxevTohN7PWCVVTDEZJ3fsN7JIgeyvvBqZYrO
 /i6tw2hcsYUZZ44E2hlpFRZedkYEfYLvmM3btezqT6xGe7rGwkadmNMJ1p0ZCwLY
 ke7A4wz4wgIRbidr9WAo26hCUJ6t7yyb+rAFIRKLLcXRyGrLFNTfoEcNwNH6I+G6
 9KiDse+1KJDn9uPhUpt4A==
X-ME-Sender: <xms:dRqSaYn5kv90hVk-ArH-2b3OjUngXXNzc9PlT4T8xY_yt_kZMDN1zg>
 <xme:dRqSaX_WosB-FwIM_DnXuqJvsvXQQg4RVfRAum0qeNRXbXTGKdKRkibPKkc2IC-_m
 jFkMIh-RrPanImxmS5JvX6-QRSlSf7wDAGncjIRn8v-ZEcUTxyu>
X-ME-Received: <xmr:dRqSael38p4FmLvWHpO3HxP6yRhAnebNWHqiBsAw13Rg0oyMD9KrsG_QOwaF6qpQH8GEpgAbGy19knBDorJ0BhJuaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudegjeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrrghtrdhkhhgrlhhilhhisehhuh
 grfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehkohhnshhtrghnthhinhdrvhdrrghnrghnhigvvheshigrnhguvgigrdhruhdprhgtph
 htthhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:dhqSac0k84BQc8yAtNj3_-qXEerYr19kkfW16tUPWDVghVHiYsqAAA>
 <xmx:dhqSaRrnfHvEpIq2Hl5lADN8KqttgwMR3EViBghmXuHiL2l0VML4vA>
 <xmx:dhqSaRfQ5zy1yzd7atCQiG6A9-3bP9-hicwc9UPwQR5Z2uH9NGTE2w>
 <xmx:dhqSaYp5HaimywKDpuzU6OFvJznVXZwunq2lPHb1sAzsGgGFjSnYMw>
 <xmx:dhqSac7-yeLIm0Om-X3U8rags-oWUy3JTvZk78ipfPLzEznQjw_kDVF4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Feb 2026 14:11:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org,
 "konstantin.v.ananyev@yandex.ru" <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] maintainers: update for bpf
Date: Sun, 15 Feb 2026 20:11:47 +0100
Message-ID: <4500605.EYuyyVy5Eo@thomas>
In-Reply-To: <45487b5bee4a4fe49088041a2a612f17@huawei.com>
References: <20260205125133.4291-1-marat.khalili@huawei.com>
 <45487b5bee4a4fe49088041a2a612f17@huawei.com>
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

> > Add myself as co-maintainer for BPF.
> > 
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> > ---
> >  BPF
> >  M: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
> > +M: Marat Khalili <marat.khalili@huawei.com>
> >  F: lib/bpf/
> >  F: examples/bpf/
> >  F: app/test/test_bpf.c
> > --
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks for helping.



