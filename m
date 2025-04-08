Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B896C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60BFD40E4C;
	Tue,  8 Apr 2025 10:18:08 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 4C96440A89
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:18:07 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7D283254012C;
 Tue,  8 Apr 2025 04:18:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 08 Apr 2025 04:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1744100286;
 x=1744186686; bh=ZRuvuK3Fg7TK8VeWYoxeIjBtAF5nFp0MeWPfIIjl0aM=; b=
 QUp3NZPRpQ9vF0gvh5fFQl/Xbo/S2zzNG4C0+aRQlAeDzhuZF5XrUTjI8M3WQPw/
 qWJxMSceuNqKKLawu4CL1/r9gJveV3G/rQD0NAYQEPTsm1z/NSDRYOIQewq0/jRW
 WD5sMMKb4odrmvz6TucCOT65NnIRniJ2s8E80DaJDGgV0bNz/6aeNT9NZW7Mv76Q
 xHNJYDXVZroF6oCartBucA3CdlS8vlPkBEygtfzOuri0I7PEWM+FoH6UtVlWdVtE
 u5hguqYeEqLf3rE9c+bt8qPPXt30cwAjfLuRU2yRcFmMfN/BGCYZ2kTm+/dC2pZt
 vGKUU32nZmz3x4Eyz1pn5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744100286; x=
 1744186686; bh=ZRuvuK3Fg7TK8VeWYoxeIjBtAF5nFp0MeWPfIIjl0aM=; b=h
 aD5VBc3BcBQ+NQiw6zMNSUj9eplmX9RfhRaD154AEmmrgr31xzsmMyHBos8kOPY1
 n4ZNdVuFQNLrgVVjZgJiqCbd/dtzEH6Bz2MWwNOeRrWKHy5QjwoOymZpDOdnaLZt
 WbNii62pMm7JZircAsCIz7zyrBCjVDN3Q17Vc3PfTJ3LCvMnSHetiEUPyTZKpFXz
 qPnwHoyqSl6GcgBYksYjJjOEUnPI+NyIiWBtddqjsA3kC46ybLMml+/N/OFvQ+Y5
 9kzGdVXPEKAxR/vGEDAHnpeDtQNsDf2xnuROO78hMuMLWZQiUNBuVrcpyr+f+lZc
 xmvqNsHsEgQ+MZjn38IDQ==
X-ME-Sender: <xms:vtv0Z9biaRPH7bhVtbo1nLmxaXn1I-3dqig7mr2WPtqmZplEiyL9Dg>
 <xme:vtv0Z0b1H1_U674td07BNtqRfwEcvnEf6V36COay5jDEoUkxnCtU2oAaciziuNyGG
 WYWZq7FX9-sM2fhOw>
X-ME-Received: <xmr:vtv0Z_-q4P7wX3px1ruZ40CoiMK-zjsuFDYT_-Q0L1hfQybpbT5V_bOcvqC3JdltEIFbyWrryjga1iNK7LOvg7W4kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvheekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
 hirghlnhhusehnvhhiughirgdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghh
 rghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthho
 pehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhngh
 iisehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtth
 hopehmrghtrghnsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:vtv0Z7pUQWknBlb8xwopX24u6JeuKJrciIonOnS1_FwCdkWvFwW2zA>
 <xmx:vtv0Z4rzqyYp4dU0MXrGxK-NEcAR0xC8i1dMcgM609cIrYxeaQXaoA>
 <xmx:vtv0ZxRKI6SN7bL1FbvkBTah0CIy_LQZA_TT-ZU8PMNETj1XZJrY4w>
 <xmx:vtv0ZwoUoqxXetoPcxH99MgBpHH5jcUlCbENLIoWeXAeXBdryTcfZw>
 <xmx:vtv0Z3_a6ww7jC9_SLdCo6PnF_8N57DENcKXpgLsXaXHHcVoCGz5E5Ko>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 04:18:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ali Alnubani <alialnu@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] common/mlx5: fix build on Linux in dlopen link mode
Date: Tue, 08 Apr 2025 10:18:03 +0200
Message-ID: <4677053.GUh0CODmnK@thomas>
In-Reply-To: <CAJFAV8z0dMFK0Vh8A=xxvQZnSJoJLz8e75bnsemwNwQoQUh9ZQ@mail.gmail.com>
References: <20250408074718.1322823-1-thomas@monjalon.net>
 <CAJFAV8z0dMFK0Vh8A=xxvQZnSJoJLz8e75bnsemwNwQoQUh9ZQ@mail.gmail.com>
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

08/04/2025 09:57, David Marchand:
> On Tue, Apr 8, 2025 at 9:47=E2=80=AFAM Thomas Monjalon <thomas@monjalon.n=
et> wrote:
> >
> > When using the Meson option "ibverbs_link=3Ddlopen",
> > a glue library is built.
> >
> > After the recent change requiring eal_export.h,
> > the build stopped because the internal EAL include directory
> > was unknown to this glue library:
> >
> >         drivers/common/mlx5/linux/mlx5_glue.c:19:10: fatal error:
> >         eal_export.h: No such file or directory
> >
> > Fixes: c7020bb20fc7 ("build: mark exported symbols")
> >
> > Reported-by: Ali Alnubani <alialnu@nvidia.com>
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>=20
> lgtm.
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied quickly to fix the build.



