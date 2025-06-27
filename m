Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ABBC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 07:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B5B402DC;
	Fri, 27 Jun 2025 09:25:10 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B72AD4026C;
 Fri, 27 Jun 2025 09:25:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id CABC21D00214;
 Fri, 27 Jun 2025 03:25:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 03:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751009107;
 x=1751095507; bh=OVujw1wzOYjmy1unLkQtfrIPJzMsNVwHytv67mAwJ+8=; b=
 fBkY/Ela+So4cfXFhpGzlglDYamjpEPRHmahHwEg+ay6Q2hIHEkG3L9Vp3aLaWKP
 XXVh105i4znCwu2V+4RqarQ38LSrM7xPOD4362fHr20hhBXy1W9yAnFOVUr+AtwL
 6CO8qGATWeGXTl+elbXzWPAnBiFwIDa5Pd7YKvQHDOEbpZFZUZZ6aQX+ydd6r1pg
 bJSbDjtwCAlmwBQQbrHCgeHhiehotFh+iFTWaL7aC7Q0DCgVGqKkSfFb1J0FYNwX
 TogsxYoHKc39Gmll0DEg+n7nnzPyHdVVyIjNtFTWFR2WdeRXlEpu/hLzy8/1SuQ9
 THFG237+KEAdUnaaSftw7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751009107; x=
 1751095507; bh=OVujw1wzOYjmy1unLkQtfrIPJzMsNVwHytv67mAwJ+8=; b=I
 l1rqFkwFI+hK7kCFRszJVjkXyNVTGN0jdrvG4KHJGD0K1FvxodrALxweE+joCkiQ
 2Cm4FMxzwSoTHA9BNoY04z8qM9ZlNNwzSZxMOX7eGgfLJdQFetVcc1p/My9lufaG
 R23n7R1e9qqTtTUWDhKBQ5dWErWH5b3rEEa5pndeByYY+HP7kyXtA9mMKjjAfE/Q
 v2+DI7T3ziain8puvWBkzhdGsOx9QM02R/fkkKDiqBwEYKxsUKEbKWcnj9+IwKzq
 iD/1fapDlaF4uasmyT7jWjnerXGff19INbCMhsUY+CZs/2WuK+rCa1OxMOnylOzy
 2xld2NMhxXToZLH5Az/XQ==
X-ME-Sender: <xms:UkdeaAxz8SYxilumSvgyMJqYX8nk8qwW6NQJuJlVs_wmULgB3yb9BQ>
 <xme:UkdeaETgMEEiuXq_q9KkqAIbbLS8QvM4Zn_qYGAMtnqUA4-slWJr8RNsDK2_bhUz0
 1qZSpa9xJPWFQBpNg>
X-ME-Received: <xmr:UkdeaCXtXFl4l-IAgTENacZTC7EcTqTCX-V9lV8v8DbsKrEVnQX9LtQZSxS8-pKIGM4cQF4QSW3i5NsyiEcBc7tvfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepudegphiftghsvgduvddvgeesuhgvthhpvg
 hshhgrfigrrhdrvgguuhdrphhkpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhr
 tghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrg
 gslhgvseguphgukhdrohhrghdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhi
 ughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtph
 htthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhn
 ghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtg
 homh
X-ME-Proxy: <xmx:UkdeaOiin4KiYxdqSXx08MtGSxvUYvuUPtexvNJWQTeQuZluaXLeCA>
 <xmx:UkdeaCCReKS3HGWCD9xmmkkaFb7JWMH3_bXUMPiIQiVOs5NaeEYLeA>
 <xmx:UkdeaPImH2TeMkb8KIejl15ayOwB7pLirzftMmWNNtrsgo-B47BVrg>
 <xmx:UkdeaJCS9tN2RQrQti1r_z2yS5KdPy_GGo8OBMo52OqSTPf9RgY37w>
 <xmx:U0deaOPj81IlmcpE7g0VaTI6J-GLJBF6QM4q_nWQC0bjPMb88NLRQFLx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 03:25:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com, 
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: fix segfault on indirect action age query
 with conntrack
Date: Fri, 27 Jun 2025 09:25:02 +0200
Message-ID: <10060217.iedYuu7f5S@thomas>
In-Reply-To: <20250626133251.cfa7hd5tbclo3xjo@ds-vm-debian.local>
References: <20250626130702.3921887-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250626133251.cfa7hd5tbclo3xjo@ds-vm-debian.local>
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

26/06/2025 15:32, Dariusz Sosnowski:
> Thank you very much for changes and detailed descriptions.
> It helped a lot during review.
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> On Thu, Jun 26, 2025 at 09:07:02AM -0400, Khadem Ullah wrote:
> > v2:
> >  - Added missing check for AGE + CT conflict in flow_dv_query().
> >  - Removed unnecessary null check from flow_aso_age_get_by_idx().
> >  - Added Fixes tag for LTS tracking.
> >  - Ensured .mailmap and Signed-off-by addresses match.

Applied, thanks.


