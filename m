Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 21:41:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8DCA40267;
	Fri, 27 Jun 2025 23:41:03 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 566AF400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 23:41:02 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id DE02FEC01AE;
 Fri, 27 Jun 2025 17:41:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 27 Jun 2025 17:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751060461;
 x=1751146861; bh=0zbgxv1d5AUqGOuZCBaPH9L/1PNoDUPtucs7l0AicDE=; b=
 bR2J+eUUM5K0qbaUGI5kpPHz7BdGYRVEm8NVWVebSiEd0RkewEp3pZOJbZZcAXDq
 M70tirHXhVykSFQmECukWGJy4ikcllshrTnx7debfJq+ui0cLOezF9ZKIh2D9Hq0
 DL5ZHaJISJUJzQWHtcYoOwY37xRlBT36FrgcJP6q9gBzbI8clKnItBkJGZmnECzT
 XSB8/KMQaU9WkyNw4ChFaKv4wZa2cnzoDxPLAHWNa+j+WCJtQr+Jp3klGV742CrT
 abuzVegGhi59FYQy8Y/opU8DQpKFpGtJmh3AM9h8wA/sK1rcAd/6R0F7pRC+x/t+
 hfP1hdEMFzN2K3b4cOkp0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751060461; x=
 1751146861; bh=0zbgxv1d5AUqGOuZCBaPH9L/1PNoDUPtucs7l0AicDE=; b=P
 OQBx4aosLq/l03/2WeqF9kJmXN6JUUrBh1nnLRjRIn0qEH2p5sRcOa3m76Vi6ewC
 yadDM6oc+xiRtMIYmh/2EzPTIO5BCWrxF7wVcH4ymMi0laoNYBmmT0o741mO/px3
 mgdIL2RYLobsgcXHILqkGWQpUcXFs22htKwSLAO7B51OD92W9wxLiVoC8I7rAeF6
 q7q5KYaax/JR3INTr6f4MB7gLW6JILDOFPdPn2pE7wbp+SwfzbtO4WGf6lAAl5hN
 gneYaZrwsi/NicAYe7/AOKa1ZnYI9nBQaiFZYYpHcTg+qH3rnAFSSWDxud2KylK6
 T2NRUMuWVwsGDis7rghAg==
X-ME-Sender: <xms:7Q9faC3nwapOO23FwjCwkF2PBb7tWeMN1suNylbaEpWDlZr6de9sGg>
 <xme:7Q9faFH4s1XiuhtS9jgh0FPNfJJOCQcA2gqtC8N30woI-9VlDFRRC1ArL4W8Aqb-2
 5s-T9--87H0FBkpdA>
X-ME-Received: <xmr:7Q9faK7YxU5e7dFNZDiz0yKjbBtWja3d4bAH3sDWmJNCLzay7AWjU3YXMC6sBR2ifERq01V27QGppnLWO1AiFx-BXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguihhmohhnrdiihhgrohesnhgvsghulhgrqd
 hmrghtrhhigidrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehkhihordhlihhusehnvggsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:7Q9faD0CNTTUPpsLUA-B8A1ajk44gpsFZZQP-LUrZ6gR1cggi8g4vA>
 <xmx:7Q9faFGGFA3uHwoClvDkEVCFWRknTe0xzVzlna8rf2IbZwyAVR7-zA>
 <xmx:7Q9faM-S_JPNoooSOgnKNt0aw2QvIrdawLTVcSOjxKO1qWp0ovLNDg>
 <xmx:7Q9faKkN4jm6Y16UpsdPnw91eUT4VQS_IDbnGpVfv1A4H9w5AKJl6A>
 <xmx:7Q9faBlP-Bv51gxZssS-e8sK-ZLcPqoOVUau48oIUFVSRSUrMXvH2tk9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 17:41:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, kyo.liu@nebula-matrix.com, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 00/16] NBL PMD for Nebulamatrix NICs
Date: Fri, 27 Jun 2025 23:40:59 +0200
Message-ID: <15671210.lhuNh5TYOU@thomas>
In-Reply-To: <20250627140752.0220aee5@hermes.local>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250627140752.0220aee5@hermes.local>
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

27/06/2025 23:07, Stephen Hemminger:
> On Thu, 26 Jun 2025 18:40:06 -0700
> "dimon.zhao" <dimon.zhao@nebula-matrix.com> wrote:
> > Dimon Zhao (16):
> >   net/nbl: add doc and minimum nbl build framework
> >   net/nbl: add simple probe/remove and log module
> >   net/nbl: add PHY layer definitions and implementation
> >   net/nbl: add Channel layer definitions and implementation
> >   net/nbl: add Resource layer definitions and implementation
> >   net/nbl: add Dispatch layer definitions and implementation
> >   net/nbl: add Dev layer definitions and implementation
> >   net/nbl: add complete device init and uninit functionality
> >   net/nbl: add UIO and VFIO mode for nbl
> >   net/nbl: add nbl coexistence mode for nbl
> >   net/nbl: add nbl ethdev configuration
> >   net/nbl: add nbl device rxtx queue setup and release ops
> >   net/nbl: add nbl device start and stop ops
> >   net/nbl: add nbl device Tx and Rx burst
> >   net/nbl: add nbl device xstats and stats
> >   net/nbl: nbl device support set MTU and promisc
> 
> This submission is too late to make 25.07 release; but here is first
> pass review, will do more when you follow up.

Please use --in-reply-to to make all subsequent revisions in the same thread.
In general, we recommend that all revisions are a reply to the first one.
It makes review easier in our mail clients.

Thank you


