Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9BC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB5F640616;
	Fri, 27 Jun 2025 11:38:49 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id A16C84025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 11:38:48 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1B50E7A0292;
 Fri, 27 Jun 2025 05:38:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 05:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751017127;
 x=1751103527; bh=JSstzS4dWC9kN5Zjk8Y4Dz9PQJRlbsO5i/2ZKH2WzLc=; b=
 rY7sOotLGe3Tz6rVwOa7EQ5LE6xm+Jc88pc/LLUqZwdLXizetUDp9vQ1mfXyC3f9
 hKP0971ZarQRykdaEbglGmtMdE8jFdbjfw4jlr5noOlqpMcofvASz++8HSGegMQE
 jWHp3u1Ytns6D9CV1vaHbxJPC8UZWigwIDYZfJuyT7AtUlc8UBsJwApytsg/mUEn
 GExrnvzd0EJObJeegpmh4NSsCfTAg7XcyhR1+qhNlm3fxN8dlmCFAI6CoykKysnn
 Krjb1IejN6N1ZgifVhe4YVxhKfuGvGOZekTo4bm91RzPkfCUifgA2rIsFYpXELv2
 /ooqRMqAdYwjD4my7TYFuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751017127; x=
 1751103527; bh=JSstzS4dWC9kN5Zjk8Y4Dz9PQJRlbsO5i/2ZKH2WzLc=; b=b
 AU7wG841YGYu5gAF2yG5opCdj7oJbsAwqsdBJLtrMP+FnYTAK1xk9zAAl0zXbA5Z
 Hz4oDeT9W4V7WmcKivhKpaOMO8F4iIOVH9wEHtt8T2mvWWmo2o63JCdI1a87aVtb
 2EqWcrReg64eyyfWFxuCucQuVHb/ZgpCrQqFO96PfRltEhx59lLOJEbw4f7WZGEL
 5viokZQ+TaWcUhRbBAF8k9de3WqEw0CMBfqoL6QanNch2i2E0/ea0LHdetr85hvb
 hYNL/V5vVv/9MpeOmZobW8WTPH+woxEtmlJr639g/vo0+AX2b+RpCLIMkTeyDK1Z
 CaNnVPc3+qfLjhpWfq9Zg==
X-ME-Sender: <xms:p2ZeaGt7lx5uD5PpAd5d8nr76Ihy2tLF_ljfL8rRfsnjmYMKByvkoA>
 <xme:p2ZeaLfK-_cdD95QjaNGN6G24zuqbVvAuloDK-C7jd7M1_Ucf2SiTaNx33aRDdSb8
 6P9vb3bmKBUMA4feg>
X-ME-Received: <xmr:p2ZeaBwSaliLGlfLdntMdE7O8DiurJDglBiGkGDhStq5OwFJAdeClKAXkbrvTSLqOdn7wNjSUnzv_3vtqSouGdcgXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:p2ZeaBNKIjBAKBvwbDC-_kSnunBODkQRpCNMFLNvEUbu2NI_NOaZNg>
 <xmx:p2ZeaG9g7kzF-gw_rFv65BGd1zs9MSnEkjGa3zUY0PrLciuJL37rYw>
 <xmx:p2ZeaJVlXZXpn3Qpv4fWXkUPf9QVGlIBObBz7pCL8oMXF3r-I4tl4Q>
 <xmx:p2ZeaPevAdCMB96K1a7fWQtlIAm_u5CTgZ4AmcOEvSrNoyTels60Eg>
 <xmx:p2ZeaC9i57eDlyhYPfMUlpeIgYk0yOBhCtMQsBC2BmNllEZuNLE85YGz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 05:38:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v2] doc/linux_gsg: update recommended compiler versions
Date: Fri, 27 Jun 2025 11:38:45 +0200
Message-ID: <5669658.ZzFAyJQhcr@thomas>
In-Reply-To: <20250610093351.1321520-1-bruce.richardson@intel.com>
References: <20250408171835.2833766-1-bruce.richardson@intel.com>
 <20250610093351.1321520-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

10/06/2025 11:33, Bruce Richardson:
> Rather than specifying a minimum compiler version, update the docs to
> recommend a particular compiler version. In other words, earlier
> versions may work, but are not officially supported, or may give reduced
> functionality.
>=20
> Since we don't require that many version-specific features, recommend
> the compiler verions included in our oldest officially-supported distro.
> Those versions (GCC 8 & Clang 7) provide all needed functionality.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



