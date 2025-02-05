Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7EC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 12:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D5AE402CE;
	Wed,  5 Feb 2025 13:47:33 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 20E5740270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 13:47:32 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 929A513801AF;
 Wed,  5 Feb 2025 07:47:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Feb 2025 07:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738759651;
 x=1738846051; bh=QBuq/WLfpEJeGcf6mVZEiaURnKawcS3Ep3bBIXjiatg=; b=
 D0P+lL7XguPpjRJ8MT5Cypn9JAVisEkPeaLsfTv6MGg5KHJ0EFsOA0D22tGN1W9f
 IhgBy0zPx29xNi/1lfqJUIZ2RfzPQknDWfqxzRHKjJWsGBnn3Pcxe/9dIliAl0nb
 iKqWG3Yive76TV6G6e6VLh5UyIsJ8qH7++AIy2Ex5rnEbfeOlQk2iJjmD96LbOnt
 Us20kIM4iuJXW0UiRb3QOcgQnjPqEjJHHnyISnYGA3UhtF2dfEhPJI4iRnD86nef
 T2m2fsK12ki6C/SXsQeD1LMFNj1mG3s7mbYcBrGHWwkuPo0Wz3wtshOP8gdccqiw
 kN8Pm39oOsy2hrjJj1Eajg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738759651; x=
 1738846051; bh=QBuq/WLfpEJeGcf6mVZEiaURnKawcS3Ep3bBIXjiatg=; b=M
 X70X7v7OHYl0Qf4AzdRYGQn1OaIUf4VgGvyH99oiD0qYxflnYY6SXlbBZCS+GZg5
 hIGiCOEV+Dp6xO/ixCgNdlWaN0fgbPWr12wrpdDkvy40w3HZlPKONCEzkqIlsMGW
 ZT9ftyN7tqAdukLzGrtG9EQ7L1DIMSG1gyu0GDssrlUbVZLXtyt74nY+lJOnXI3s
 mHgJKvggxQaaw8jWAUyc5zaxizIjOpnxQd7FuLr6ekHBfpRpySKWXLdg1tcCKw/K
 /xFbDtsq5irra18WlD+H/oD0d4yHyMAKxm4VNXub8z+4GONsuIqFtuqyPsbVorPI
 oO5t81xFXTpTkyDAfBUBQ==
X-ME-Sender: <xms:4l2jZwwYJiTfoKBVzgd6lqGi1yE9cmLJYMP0nQ3Kg2gd1d9jHwwv1A>
 <xme:4l2jZ0Qh2XhMb8WAbAcbS_mLvQmX7-fAQWAdy3tozMZllMSMZFaB9ESleSYSu_Qwz
 E74X8OEyqa0laQfxw>
X-ME-Received: <xmr:4l2jZyWaZiLqPLtGfuYngSVCaJLYDikji_fcysTIO5KsiuG8puAho3js0s2sDwOSVSQQqZt3AfP351WJp0JGsPkXsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeglecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepfigrnhhg
 rdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhg
X-ME-Proxy: <xmx:4l2jZ-hLLEnGKIWTsSqIG3mPrSgjjiFc1m9Yf6f5s7hQhv5jJ6p2cg>
 <xmx:4l2jZyCGMlo0khADFJqwXPdepN_SrXyqL-PdjfxL2Ea1U847buZOZw>
 <xmx:4l2jZ_J3arI1tMSBv2fhZZFEtlJni_gUBrRP2vckF4oKvAiJEKXckA>
 <xmx:4l2jZ5APzoAtjl0AIwRuy9uyC28kqjl3xl16fbIFaWTB422OY4gD_g>
 <xmx:412jZ9Mp26kULllpZj3DN5Ohx1WATZE6MV9WIBGlyUUnawATZN0W-1TH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 07:47:29 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Junlong Wang <wang.junlong1@zte.com.cn>, dev@dpdk.org
Subject: Re: [PATCH v9 03/15] net/zxdh: port tables init implementations
Date: Wed, 05 Feb 2025 13:47:27 +0100
Message-ID: <12977412.iMDcRRXYNz@thomas>
In-Reply-To: <20250203183500.073abb2e@hermes.local>
References: <20241210055333.782901-2-wang.junlong1@zte.com.cn>
 <20250121034433.3033681-4-wang.junlong1@zte.com.cn>
 <20250203183500.073abb2e@hermes.local>
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

04/02/2025 03:35, Stephen Hemminger:
> On Tue, 21 Jan 2025 11:44:21 +0800
> Junlong Wang <wang.junlong1@zte.com.cn> wrote:
> 
> > insert port tables in host.
> > 
> > Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> > ---
> >  drivers/net/zxdh/meson.build   |   1 +
> >  drivers/net/zxdh/zxdh_ethdev.c |  24 ++
> >  drivers/net/zxdh/zxdh_msg.c    |  65 ++++
> >  drivers/net/zxdh/zxdh_msg.h    |  72 ++++
> >  drivers/net/zxdh/zxdh_np.c     | 648 ++++++++++++++++++++++++++++++++-
> >  drivers/net/zxdh/zxdh_np.h     | 210 +++++++++++
> >  drivers/net/zxdh/zxdh_pci.h    |   2 +
> >  drivers/net/zxdh/zxdh_tables.c | 105 ++++++
> >  drivers/net/zxdh/zxdh_tables.h | 148 ++++++++
> >  9 files changed, 1274 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/zxdh/zxdh_tables.c
> >  create mode 100644 drivers/net/zxdh/zxdh_tables.h
> 
> 
> This patch won't build if RTE_ASSERT's are enabled.
> 
>  $ CC=clang meson setup -Dc_args='-DRTE_ENABLE_ASSERT' build
> 
>  $ ninja -C build
> 
> ../drivers/net/zxdh/zxdh_msg.c:1094:33: error: use of undeclared identifier 'zxdh_msg_reply_info'; did you mean 'zxdh_msg_chan_init'?
>  1094 |                 RTE_ASSERT(reply_len < sizeof(zxdh_msg_reply_info));
>       |                                               ^~~~~~~~~~~~~~~~~~~
>       |                                               zxdh_msg_chan_init

It is just a matter of adding "struct".
I am fixing it while pulling in the main branch.




