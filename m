Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C6BCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:30:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD4D402CE;
	Fri, 24 Oct 2025 08:30:08 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id A7D1240276
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:30:06 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id DCEBD1D00101;
 Fri, 24 Oct 2025 02:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 02:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761287405;
 x=1761373805; bh=uXrm9u6vb//SwBQ3fUDWFCj2u6q1u71TbGwXa6D60Z0=; b=
 hyJmAv5cTla6wXNr0bemePvmJWEGLZd5Y7w+6KNqqQP6N4Oj2/+GegHJu4oRN4sh
 dI7cwS0PiYvDgcPUYigdPSaI9OI6jjPvFi7fhHPhEtBBonnKhFVKswdLsryh9pCW
 uOYj+e5h2QG3SOUz+B5mz5AwaARtKxrkPIQLxstVmG3nMZUU9ZKLFvIMSntT+Hv4
 Hofcpt2oIlJ9b91FkvsdbFu3xfbaKZvkl89Nt28yt4AmBsZQ7e7sM8x4c811SNk9
 qKFtL60Ig+J4YlDLuYbMScZe5xk+Nh0UBX/eMYK0hjf5ZkHbRXR9OAv8EAb+Yz9T
 nkKKrIiIyBuX6nSq6BnVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761287405; x=
 1761373805; bh=uXrm9u6vb//SwBQ3fUDWFCj2u6q1u71TbGwXa6D60Z0=; b=N
 Q4+ObWf0w1y7rMuKloYcacAdy/LgN7P1OHGAv1/cnrZAerWPeX53y1uL7Wt4bNxs
 jFlZ7RCMzcM8NRJdmcl7ZfuOS5WDPNhe0R/6E4/nB5jOF9OsVKzqLfl8IIuBbvY2
 dK1h8SNmbztP2Xz4OklZzk8XiIQ0jBJdD2ueTUbML+ibheNnm0bD4U6jnoOWGWFL
 sBqo79dFYbaW2A26Mhq1n4VBqOXUmOfn+CqxGP8ZVqSFO6FZIwKj3i/1gIyD6upp
 wrORlZmBaOTFTxWy5X/hRntbWUCcruuFImN2D3ZH/G1aDFJeNsR0fzkLEBQKWABK
 0v92+mHfIprd4KYAn1EeQ==
X-ME-Sender: <xms:7Rz7aK0nhIFrCrjaQaQUAmPITLv4fkMJJdSeCqDMFTxPNMsV_-f3aQ>
 <xme:7Rz7aJY_ETyt5um_Bjr32LvjxvKO2Eo1XOPpZRET9OReP8-6E1gvUhra9HroTh8Cv
 YPnrgJleqsGD01Hbfh9HaYUI5yvrHYTfRFrNa6Cz8pVXS0SJg5M3w>
X-ME-Received: <xmr:7Rz7aFrgv9P8nFvEyKjw-y_tpeis4W6zTzCxW4hjT5wJsbp6PRMLXlgNHQ0vpMyZ4o_YJEmXsv0hBL8NhYICHxmWaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekiedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:7Rz7aNoBz0NbmAKiF7UaKwYzEDLr58BVagTSH8taGtNiJl4cn_qovQ>
 <xmx:7Rz7aP2bDtB3Z6Rii_T_kwSvvJu5DfA_LllsoKnwKJ4QVYoi0XCyig>
 <xmx:7Rz7aMABdBF97fZEHt8a-0YeDCz6rz1gUdmBWr4NjEY5ZlBzTuZqhg>
 <xmx:7Rz7aHe8va7p2qVkvQPykGt2Zw1p5nxap2_SVlnXzvV2r3ZV21ae1g>
 <xmx:7Rz7aBWKE1v8AoNtnw4UQDHPG4a53aKr5yoD4cd6NKszWCd2_MrRsgEY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:30:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/8] avoid unnecessary use of comma operator
Date: Fri, 24 Oct 2025 08:30:02 +0200
Message-ID: <12519733.RiKt1P0BV1@thomas>
In-Reply-To: <20251023164902.1b8abb7d@phoenix>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <3190671.o2A3GueYyp@thomas> <20251023164902.1b8abb7d@phoenix>
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

24/10/2025 01:49, Stephen Hemminger:
> On Thu, 23 Oct 2025 22:05:46 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 17/10/2025 17:02, Stephen Hemminger:
> > > Clang has ability to detect suspicious use of comma operator
> > > where a semicolon would have the same effect.
> > > Easy enough to fix in DPDK code.
> > > 
> > > Stephen Hemminger (8):
> > >   eal: replace unnecessary comma operator
> > >   ipsec: replace unnecessary comma operator
> > >   test: replace unnecessary comma operators
> > >   app/testpmd: replace comma operator with bracket
> > >   examples: remove unnecessary use of comma operator
> > >   net/bnx2x: remove unnecessary comma operator
> > >   net/bnxt: remove unnecessary use of comma operator
> > >   config: enable comma warnings  
> > 
> > Applied, thanks.
> > 
> > Please could you open bugs for drivers having such commas?
> 
> Ok done. The bugs are grouped into Intel, Mlx, and bnxt.

Thank you.


