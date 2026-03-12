Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC84106ACE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CE52402AC;
	Thu, 12 Mar 2026 21:27:05 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id D358E40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:27:03 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 669F91400285;
 Thu, 12 Mar 2026 16:27:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 16:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773347223;
 x=1773433623; bh=FFzJiYMEaR1+XGqrcr5yKmvHH8m2hNtNmSItDfPYamY=; b=
 HVRGXsrgDpRywTT+sSWPbgtBb1nQkZNI3gsrXai+iwmXw+OGpft8Ufb715WZ0itf
 T7p+e/aTS1HTr8fQMH7YETtpiwNx0tPzCMAgvZmHFfnym/Rk9/usAb0IF58zims2
 FrIdVcidmmx2lsbdix6cQbrZ0ACGY5dWHEI/2lpqprIZ58V/q8gWXktNLhSStvHc
 n2WB+uhi2fWDKNCGdewDwgcW6tKo6F2bK315yrdnlDijTC+6s9n16tfcSG/zO9jd
 gon196LRtKz9Q2/ft8Vy9u4MKxghdiFTQF17s0/R3zUnoB/TIquss2EWC8OZee35
 VWpTBg8TaqFlk2h9obAEXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773347223; x=
 1773433623; bh=FFzJiYMEaR1+XGqrcr5yKmvHH8m2hNtNmSItDfPYamY=; b=k
 UFjei59CaLVN32BclclI7XxteByAEo/wzWy2FSpL2Cjxk+P4UxwTFAKIxc2kruCh
 PMgYTr9J+gcimrErd5r1fzE949tr/PFtY1wzXNQ3g6xfyxs+l9eDr0DuRwuYZHf0
 KX5cr5xYv/jAZzxtZm6nizDPM2ci6ND6llGkMoQAOduEJwYLLv0GzxC80IMmPx6d
 JSYqkcQf7w1NJUFrp5uf1a4F71HShMO8ckMbh2v1cOPkXeurMh3ko+L1AfZylnDC
 ztuLJWwTokgkFCCFDsBMFvkCcONlucoLrJEg5/9YY8VCVPJY9eLljlpV6RK2IiSk
 Lx5dgSJoWWMesInKYjIhg==
X-ME-Sender: <xms:lyGzaeh1Fw6OxLgb-T2DSPy4FAt9ti0VIKE1VAGOdaj_IvhjozMByw>
 <xme:lyGzabWQdrcai5PJNHgAEddy3Z_cD48m3phCZiCgEAsfJAf9Gm7iXq1b4ZSFiYLdh
 GQkZJaWYSUkqynNn_GF5LqWnV1W7gb2-fE-9EfXgC3goz1rCTJu>
X-ME-Received: <xmr:lyGzaY1EWQ-6UJmu6i5uUM1aNDWgqCHzapsyK-Uxg3HQOwIDoBoeI_oe1ZFQaCNBuxTtayzzGEvym-viaoVWOjcUIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:lyGzaZF9KA3aH5KmmI_9j1QUe8yT-Fcs1NbFmZFV51a2L648WhUezw>
 <xmx:lyGzaeiyAq9Wf8MBFqhi2k0BmcsY4gm4R7E-vIDzcUpbBqLKRAktAQ>
 <xmx:lyGzac_lnDajSNmgDjPyhi1aUDwyeZmYfDxrCypOzK6vAX7IaM254w>
 <xmx:lyGzadpQ4H02e0RYqej3yuSm0d4uYJ64lZEx0AoPVHD9Cv7qsjC_0A>
 <xmx:lyGzaejRu22UZTNIvnvcfAHBO9yIGNJVNQMcJfjU2HevuTabdwv9frgv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:27:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: add Co-developed-by to commit log check
Date: Thu, 12 Mar 2026 21:27:01 +0100
Message-ID: <3328846.5fSG56mABF@thomas>
In-Reply-To: <20260312131039.6ec4ddf3@phoenix.local>
References: <20260312185403.1051832-1-stephen@networkplumber.org>
 <23032153.EfDdHjke4D@thomas> <20260312131039.6ec4ddf3@phoenix.local>
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

12/03/2026 21:10, Stephen Hemminger:
> On Thu, 12 Mar 2026 19:56:25 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 12/03/2026 19:54, Stephen Hemminger:
> > > Add Co-developed-by to the recognized tag pattern and tag
> > > sequence order in check-git-log.sh.  
> > 
> > Why using such tag? Signed-off-by is not enough?
> 
> 
> The tags were inherited from the kernel development process.
> 
> Signed-off-by is the DCO (Developer Certificate of Origin) attestation. 
> It says "I certify that I have the right to submit this code under the project's license.
> 
> Co-developed-by explicitly marks someone as a co-author of the patch. 
> Without it, there's only one author recorded in the git metadata.
> 
> I just wanted check-git-log.sh to be quiet if it was used.
> 
> The Co-developed-by is new, and probably came about because some people
> need/want to have their contributions recorded in the git statistics.
> Silly corporate overlords count contributions and it matters to them...
> 
> PS: If DPDK was exactly following the kernel process, every time a patch was merged into a sub-tree
> it would get a Signed-off-by from a maintainer. Because the maintainer is validating that
> the submitter had the correct rights.

True, but in DPDK we use SoB as an author or co-author mark
and it is well in line with the DCO.

I know that we had some exceptions asking for Co-developed-by
because of a corporate ask, and I am on the side of being flexible.
But making it a part of our official process could make things confused
I think.


