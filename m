Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6471C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA2640ED4;
	Wed, 13 Aug 2025 17:37:41 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 4902740657
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:37:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E0F4314000F1;
 Wed, 13 Aug 2025 11:37:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 13 Aug 2025 11:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755099459;
 x=1755185859; bh=YSZC+DsIpOOER1ZJlaYA/5sxWQUZtCwov1enX7/HrGU=; b=
 N459I+E7UFBjTlmjsdIWWs835XLxik4ILxaeKPRDse82gqvcD6qP5yzFY0HIYj88
 xAnz4rSz7Xa+HEJtLkalcCMht9o/4gmKJPxe3/F38GLgsrqPJgnxWnW/sZTp9Cv7
 0NX4Osbyum/f6o5NJ2khfRRCUWBFw5P28+kB9/XALTefT6GiwdSbK4TCXy07FNRN
 VwvUuphLEmpln7qZLllSw/QsyfMdTWO0g7M8LPU1xXIBYyorxiNoMOER8YXpyt3O
 wJ2bSywqAdx0p1y12wspbPR4IARxq/8L6jULU8XNNIoW4qGovX+3FJ2japvDRTWv
 xd/PJOzIHN5MOMWeWe/jBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755099459; x=
 1755185859; bh=YSZC+DsIpOOER1ZJlaYA/5sxWQUZtCwov1enX7/HrGU=; b=A
 5+bV9pWdAx+taYd+k1M9zm4YC6AjHSM5GR79991hRePF9YjyDek5Ga33okUQHNr/
 YDGMAbteGV4guVwrasavwRmU/1jljjXsKSQSkyUzHYXt28lGVkC5UWPCCjFWKbdY
 tLS96ouzVivh3OxKbM9Wa1fays5Q38ZLVBIpcFBRlZumFT9uxqY0jEJQsh1WPLN2
 0Z4RFScaPGO7yRjUJreRTvF2vD0WJOujpemj0oCm7AtHX2pfthEiIltY1XDCQvyU
 SfvOfaIubpwTzhtgOljSI6qWBOy2tx0Nt65Qh+BVfVUKF7b0+mU47C8+3uMHw6qz
 YR/+L2Sp05T/UeLznu1SA==
X-ME-Sender: <xms:Q7GcaF7bXoxhYfm6y0B8-TkVU-9qa8ZapZx2IFyaXZ-xJZBoEraXLA>
 <xme:Q7GcaA0jWxKGdBHqIcuzyUNL44l7p3Q2uSH9Ybijya0o7zWRKjZPzHyfOYpwP9FOp
 bD50PYP2EEZUWo7Xg>
X-ME-Received: <xmr:Q7GcaOzbuD9J3J2iwNsYr2g4McwdfULghZXAfQMZm9ZISqPlwPM5aSxrdDkswMgPOBxRH-BP3xV_nHLGuvust5NH8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 eprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphht
 thhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtth
 hopegthhgvnhgsohigsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Q7GcaCsGn-XZaJV2qWszZu8Ci2E_Yj9zZQD2znrTwxdYIqLu9XUdpA>
 <xmx:Q7GcaAyy0YFrUToLx3oV34QNhGItlv28a89K_IlY_E8kM7lqzGDjHA>
 <xmx:Q7GcaFBmxZ3I0ohvgDMm-_ftzLal6l56D_TXT5afpF0ZqutUc8qugg>
 <xmx:Q7GcaOeO6McmT3XGtELpKe_NcTl3WbId3jEndHPPGtkmnrR3hhCPWQ>
 <xmx:Q7GcaPSE-A6WU31jGuVEqGkOnkezx1nT3-E7TJawDobPcsGLFHBe9sGz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:37:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
Date: Wed, 13 Aug 2025 17:37:37 +0200
Message-ID: <2269183.1BCLMh4Saa@thomas>
In-Reply-To: <20250813071823.54b6a6ab@hermes.local>
References: <20250812144249.316120-1-thomas@monjalon.net>
 <3325626.aV6nBDHxoP@thomas> <20250813071823.54b6a6ab@hermes.local>
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

13/08/2025 16:18, Stephen Hemminger:
> On Wed, 13 Aug 2025 12:01:53 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > > Looks like will run out of bits in 2040...  
> > 
> > I observe the max speed doubling every 3 years.
> > So I imagine we will run out of bits in 2070,
> > or earlier if we have new intermediate speeds.
> > But in any case we have at least 20 years before it happens,
> > so it looks safe to me.
> 
> That was just my lame attempt a joke.

Sorry for not spotting the joke :)


