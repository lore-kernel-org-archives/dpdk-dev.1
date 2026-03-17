Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3906F3383D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 14:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 459C64060C;
	Tue, 17 Mar 2026 15:52:16 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id B4E2240270;
 Tue, 17 Mar 2026 15:52:14 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7485C7A0105;
 Tue, 17 Mar 2026 10:52:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 10:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773759133;
 x=1773845533; bh=160MzndHnW90gsAwcBX4rIkHaH/p+qg9o01A/V5/e7E=; b=
 TrMa8LUQzOJy1VXxsqxJ5kvyMcC9OAv8lju1ywjlB1mPf5WdjqIcRUkO8V6UsEdj
 eQXcTDZMIR/iQKIVJNkIdXJ6ZQmtf0UlGKgyDySeWlulFfVMap0f6UOJPSNUsiyC
 +fzvfrXdo8c69uzYoiLnA3t9P1Mzy5zcn6UD3o6rZt8O9aVmjf2ygrqz1FA28FtV
 1Tiq7Azj2OqqugEI/T1Z+WBYzTETTPkHbNxUzOPJwwmU+ciHVtpxGCeJYqGwK8Qv
 l1L/7U3/7wIZFWqWMj7EpPWdUE0COmupMTafYjMrjBfuwsVhjIo1NporQ2KTFsqq
 5joVo278lVvCTXvDIfmwIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773759133; x=
 1773845533; bh=160MzndHnW90gsAwcBX4rIkHaH/p+qg9o01A/V5/e7E=; b=T
 eyIhxrhQZbiApGVSyLmScfU0wDzVtbF6tSoXrGv8L0F2wid2cTD6JAfkBEWtg8jU
 CkZHo3hATATsMc2NQQZV4TgaAWfYhxqb8gv4XW4tP3she0wWTmNTC68VevIi70Jm
 cCQwGq11ez0i7IKDaP/4qVNN13H1/kRr+lEqzjvpGQhojLGcVn9p4zgeTK0y6eRX
 WTVpdqWCZWUaC5j4Nf03Laki4QIuK5DUDbH38al8TJduIORHOWUMqyFJyFdr/tv1
 PDNd6ut14RVdBzr/5xA5sCH3CuVnwpVFYG4trNfD/wgBSjXZhPhf3JkI4WZ4z2Ew
 J9j8ir0USOiRPAN2Bhb8w==
X-ME-Sender: <xms:nGq5adc5aTI4RvR_bT6mZnh7NC-HShq0OON_PK2Y0h4wcgKOoPbZaA>
 <xme:nGq5aUIk9ciT-UQQPUH4JX48UqZwk_Q8YT_sSDWpBH8c2BGIzTidKaxWugu54lBFS
 iSPPTTo5z7ujOEiA8CdIU5uFq886EbByeAbMszq_QgQq12SX0Ix_w>
X-ME-Received: <xmr:nGq5aSEEBc7pFQARM_JlU34gWXacqC-8w0uLg0MVmTytdNRYDUUCvAyIpbpLA9PKVD3KEiveakcRB2VyKthl211Z7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhpihhnrdhvrghrghhhvghsvgesrg
 hmugdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehh
 ohhnvghsthdrjhhirghnghesfhhogihmrghilhdrtghomhdprhgtphhtthhopehsthgrsg
 hlvgesughpughkrdhorhhgpdhrtghpthhtoheptghhvghnghdurdhjihgrnhhgsehinhht
 vghlrdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtg
 homh
X-ME-Proxy: <xmx:nGq5aXCptZ2uFcKfULlTZh_rLl7dioslT_H7f92d183Wuz3eNfejzw>
 <xmx:nWq5aV8fl_j44kk9JL5sIEn3x1Bu74YaJIupfhdHAHCqwnfaDTGoPg>
 <xmx:nWq5aTAlCdCgZNYgJtZbBGZxBGr6ozpzY5TW1PkNHRE3VPpQ7SHKvQ>
 <xmx:nWq5aaTEAxpfAjZiBJlwHMUzOpDsPcs9xYE-fiDnObhntoZz1ZoYTw>
 <xmx:nWq5acodUJxvzZ4ipO4VeevurdcZ5ptFajUxIBA6Tqq10g8fm8_t9WEA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 10:52:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vipin Varghese <vipin.varghese@amd.com>
Cc: dev@dpdk.org, honest.jiang@foxmail.com, stable@dpdk.org,
 cheng1.jiang@intel.com, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH] app/dma-perf: fixes buffer overflow error
Date: Tue, 17 Mar 2026 15:52:10 +0100
Message-ID: <4447252.mogB4TqSGs@thomas>
In-Reply-To: <f8149a16-f017-4d01-87d3-6e38b945877d@huawei.com>
References: <20260225114120.2036-1-vipin.varghese@amd.com>
 <f8149a16-f017-4d01-87d3-6e38b945877d@huawei.com>
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

26/02/2026 03:08, fengchengwen:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 2/25/2026 7:41 PM, Vipin Varghese wrote:
> > test-dma-perf limits the number of worker thread to 128.
> > The current change accomadates to RTE_MAX_LCORES. This allows
> > high core density platforms to run the test on `(RTE_MAX_LCORE - 1)`
> > 
> > Without the change we encounter `buffer overflow detected, terminated`.
> > 
> > Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> > Cc: cheng1.jiang@intel.com
> > Cc: stable@dpdk.org
> > Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>

Applied, thanks.



