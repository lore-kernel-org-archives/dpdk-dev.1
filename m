Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82BDD116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 19:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8488940275;
	Sat, 29 Nov 2025 20:05:43 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 5F3E6400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 20:05:41 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E70F0140066B;
 Sat, 29 Nov 2025 14:05:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 29 Nov 2025 14:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764443140;
 x=1764529540; bh=lusmpwXM1C3DCb0VE+lFAScVSWTOmCrJtUc4pFvR7NM=; b=
 b72mgigWUp1FyMPP00lMjgVxCFCdAIXc57l0mggomSKC/ZFOwhZ9djICGWLmWWOU
 8GKMa46yN0stgkGaYtxa+iIor6OHqs0mbYxPXswwlCpEXnfRYreKKBhLBpN7p/yV
 sX75P2CsrK2Z22RaTetIl+2JCDpkMkdchtd7P0pFQadX+//6AL9/gwDxYT0o0hf4
 YuXNoBgippz7axyyFJFX51ERLWe594HinPFdQzrBoO9966gLR+mEUkhyl4i6wLz0
 FlHj5CdRGYCfRa5mJVcworCezX38H4OwYq544CPEYztUyB066849conz4ixDpF2d
 bvI4ainhn3mNphzaGw3Y7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764443140; x=
 1764529540; bh=lusmpwXM1C3DCb0VE+lFAScVSWTOmCrJtUc4pFvR7NM=; b=x
 L+gMBOI6dQqbK/71/FOhi+3EcuyQX3ExzKlELdf7aodZkC/574w5Dk9vYHlQbJHo
 qUUhab0mOE0b6F5mOIRa0SQqlxbvIoc01ZBptEUblvRzQf662eDPT/uxRx3JT0Gj
 0KMFXZ3hNqogRE/s522dW8bSqjSJyBCGrfj9ejk80WL1S0L3hG/NIelK/2uyKI4D
 6rYWmuzqEMUJ1SCf2gnazhcRjD9jWQjwGtamq/evmB3OdtYRQTaNg7v0/i2SkN5E
 M4029AD2KPYjBd+RxRhaM4NTHQAYbfEI/9034c0FsQqJPcP56Hr3DkiyhbHdda9p
 my1crBPlD18FgRvFAccBg==
X-ME-Sender: <xms:BEQrafOfLgn1AE6mhwydX80qpi04QBFKuySmzGoMfIZjYLl2DP06uw>
 <xme:BEQraWRZPbzb6v6f0aMRXGzcUvxW21LyYUP1-sPNm0lwS5FeJIgI8xMJQkwgFvX2a
 O17dkyT2zn6KoC1EyyWlEKjwAxbx5H-4BxlFkwFgljW9A3qkwZkXA>
X-ME-Received: <xmr:BEQraRDxnXPWlE1FUR-Q1StQrGT3eOdo4_hR7y9i2s6XxXBBpxuGRYaJyy8Gikii_me75h00lMORamFNi8rkr4Fe1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhirghlnhhusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:BEQraVijJxS8MfBBvh1JZtXLB6s4TBgpLxaSyXvYsTYzsIiuDC8bAQ>
 <xmx:BEQraaOSCktMHDqzPHYR1MnmB1lZ18oBdpTTn9bNTfeds20EU6xfxg>
 <xmx:BEQraW4qXSOcJh_OO0dNOexCzqP_cwjAvDL_810m_0J1b90MWIN7RA>
 <xmx:BEQraY1i-C1NeDO7bCkFNaoSUzp_PthLkZ7sQzLQ9SUuMvkoOVI-YA>
 <xmx:BEQraTNVJkNvit1hZWZCXAIGwa-UDZDphy7OmSVkLGRrmUPt3NUxdyl0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 14:05:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] devtools: check patch from stdin only if nothing else
Date: Sat, 29 Nov 2025 20:05:38 +0100
Message-ID: <7561331.DvuYhMxLoT@thomas>
In-Reply-To: <20251128144127.1552516-1-thomas@monjalon.net>
References: <26063275.kmuVQn2iE0@thomas>
 <20251128144127.1552516-1-thomas@monjalon.net>
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

28/11/2025 15:40, Thomas Monjalon:
> From: Ali Alnubani <alialnu@nvidia.com>
> 
> The checkpatches.sh script was checking if stdin is a terminal before
> honoring the -n flag, causing it to incorrectly attempt to read patches
> from stdin when run without a TTY (e.g., in Jenkins/CI pipelines).
> 
> Reorder the conditionals to check for the -n and -r flags
> before checking stdin state.
> This ensures the -n/-r flags takes precedence
> and the script checks git commits as intended.
> 
> Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



