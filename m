Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D732D216A5
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 15:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 049194021F;
	Thu,  4 Dec 2025 16:42:47 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id C23C840144
 for <dev@dpdk.org>; Thu,  4 Dec 2025 16:42:44 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4D05B14001DE;
 Thu,  4 Dec 2025 10:42:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 04 Dec 2025 10:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764862964;
 x=1764949364; bh=2tKf/wzu7ftseOsv3xOCgr2QUD0m6N9HFbnjhiqgpr0=; b=
 WA6ZM4Rqp+8S1PfClfHbbGifdxfi0lut1SsLMp4gjQgewkpLpyynZ2w362HHbj5P
 gc2KGh3uFRECTwYK959uYarvkQWeW5gqSiEQJD6hb4zvznz63b78KR7HTZLrQAT7
 wJZNC9V0uHhlognmcfUUpYe2HvGptMZAl9Fst9UU0QQfMEZPPobmbqzpyG1FB+qq
 J+Sy0Cc5Mkaq5CCCNDlwL6BZFXBnKia53nP7RbcNYpZZoobseX93yRtABknlqICT
 F9CPqxlKL3mZUgkeqOthchqxo5xZZ7Enw1LH+W1lp5M+qQAwB8/Jcv+0s1Lz7bk8
 vzCTKPO7Vk+jamyFkbJN1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764862964; x=
 1764949364; bh=2tKf/wzu7ftseOsv3xOCgr2QUD0m6N9HFbnjhiqgpr0=; b=Z
 5VeCEV1qTx1WivNpMTOWFSWwUJyGm3dD+aeUUZxHbwC8R68/oeLpKxCxT1pQsyRv
 eDGZ06VUIEHKvjx5QLFsHcWLtueh5KcDMscN1ZZPLYvgBmCV9kAL1fjDA1+bV2Z9
 ZqbHtH7qvQqPOXClBLulUtTwV1kvzuApLG8XJ3a2T86H5yia0nYqAzkrWZc+n8ak
 YHLRi/psvknR2SidMkWa+Sp4Bv3Cz1upmcJ2wDtbhEwGaPlgi4+ynam20KmVmsnp
 eGmO4p9Jwh/YhmIQGJfaDLODsPNWTYdgw8CEpADGSYHnH87UnyCcbV5nkPvxlBjz
 p3hzMywsm9rm48ZAgqpuQ==
X-ME-Sender: <xms:86sxaWZyImfdAuahPAHAAD1P0iGGaPIagkb05fl38mIRlrZX_o4xXQ>
 <xme:86sxaSWzdsoSm9Oov3z8eMPAuxlgCJnMjILDxMhkbEqD5x29dm99PhAFDbk1YV1SF
 et-8PBUvyr6P3jHcHUxaE1Whwzx_R2IU0x5bc351tM9hpWTcW0d>
X-ME-Received: <xmr:86sxacjM0mupBKpfDPdPTKPjFJDm0Fr0MpUzk7Tpy_Q-1VvqGpgykTBb43iClEa5mekgK8Hq8yz_fBDFOdRHSMSS7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguihhmohhnrdiihhgrohesnhgvsghulhgrqd
 hmrghtrhhigidrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhl
 uhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehkhihordhlihhusehnvggsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghpthhtohep
 lhgvohhnrdihuhesnhgvsghulhgrqdhmrghtrhhigidrtghomhdprhgtphhtthhopehsrg
 hmrdgthhgvnhesnhgvsghulhgrqdhmrghtrhhigidrtghomh
X-ME-Proxy: <xmx:86sxaYsijny79Cs1_lSpkK8UzqnI4oaG-_IFC8pIVVUOVu6V1OwXkg>
 <xmx:86sxad7xdGYxDzHh-LG9C4B2xGpXNXDGPJzYzKrq41Ck5qILZO8EQw>
 <xmx:86sxaUPfrREGrQXIM2OKsHOHF9w2FDCBZjr29Dt3KqKDsAH9Y_Wfrg>
 <xmx:86sxabsQ2A-MiQGbFLAStP2puV4aUl1Xd5BO9xhSVJY-F3SMGPrJfw>
 <xmx:9KsxaRNMQtaF3OdkEVG1QBF8t9nxU9zwXQ2iea7Bo7eB08iM4kp3Dleb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 10:42:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix issues reported by Coverity
Date: Thu, 04 Dec 2025 16:42:40 +0100
Message-ID: <4726803.LvFx2qVVIh@thomas>
In-Reply-To: <20251111063141.4611949d@phoenix>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
 <20251111063141.4611949d@phoenix>
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

11/11/2025 15:31, Stephen Hemminger:
> On Wed, 29 Oct 2025 20:36:19 -0700
> Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> 
> > Coverity issue: 490942
> > Coverity issue: 490943
> > Coverity issue: 490946
> > Coverity issue: 490947
> > Coverity issue: 490949
> > Coverity issue: 490950
> > Coverity issue: 490951
> > Coverity issue: 490952
> > Coverity issue: 490953
> > Coverity issue: 490954
> > Coverity issue: 490955
> > Coverity issue: 490957
> > Coverity issue: 490958
> > Coverity issue: 490959
> > Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> > Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> > Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> > 
> > Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> > ---
> 
> Queued to next-net

Looks like this patch has been missed in next-net,
and it does not appear in 25.11.


