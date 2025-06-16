Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E03C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1871F40292;
	Mon, 16 Jun 2025 09:35:29 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 0EB614027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:35:28 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 41C60254006E;
 Mon, 16 Jun 2025 03:35:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 16 Jun 2025 03:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750059327;
 x=1750145727; bh=3WZsQWfkR8X27RL8ppVU55zsVYTige3AlQLRrZEcECo=; b=
 U+EuIgsUF56j5kcwJEx13kE/xAfkoz2XB2lI2wNa20EEXJydlv08ApVQqR8L7fqO
 7+BzQowI+9F8tx415JJRgJ40Z0lrNBP0X1SsKZdCu+2y+iIpHNUWnIyRnIw3lzKa
 Wn2/f5k19ucmTrNh8CwvV5Lmv/vs8sZnAnnY1nThjOR67pUFMUAVfb4KbyTosau/
 FoNFKWFRNHtYgBUfhWeOrKk2FPqtngcT4lfYfoeaItiCToguGLhLPDqHO9etb5Fy
 +wsMzd6UJ7zU8+T5x2v69nHkhk0K8GJizhCEg2eE3SaOd7WUKcwx93aMNdMUqeKd
 zlh0oq1unruiPY7q5C4Kwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750059327; x=
 1750145727; bh=3WZsQWfkR8X27RL8ppVU55zsVYTige3AlQLRrZEcECo=; b=H
 +TRjCBm+xVfc6pQld0SUWR8cfYL09gygrK02qB3sSS1YhKtkLHJ5M1emi0S29/Wm
 byNipYn2y4nOi09jGYkreIPOry+130VMwFiAKuF+lWveaYRBEbsam30LF077/Zgb
 x7rbj3e/E/pIKAMN0lkhHLnH1P5VuiWi6ZcX6pzWmwU54K+LaVJkchrA5f/UmuhG
 VPjfiPtd98fKwG9gzqhCZ6vtXXNak6g1n0ZGDJDWKP9cGiQbsrvkKCsfPWIpnQLy
 DRwXPbJn+i/vwE/HxwgAtZqZkWFuFg4JnK/QHe/r7+y821/8WHRWYyE/gaqJuHjF
 MJ/0ZZpq7LKY9/W8OOqAQ==
X-ME-Sender: <xms:PslPaN7gmstTX0a7D7IOkg7yZc9tOVEQUjF3yf5NvUcQbbuKRTQ6mA>
 <xme:PslPaK5Ol-9NntNN2Ee-wpq2XbqKVT85qX150Vv7Hax5hgxFLUWQCUmU0oEVZDIPC
 gjy3elwiKwfuO6qww>
X-ME-Received: <xmr:PslPaEcs5Vcj5q8i1Y8gwt-cXdFT_eM37_eWjB4GYtDYUaKccwSU9ZMRFgpv-DYYyW-q4stXp51crE6aIZaHqYTPgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheellecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeffveevjeffleelffelvdelgedv
 tddvieetffdtuddvledtgfegfefhfeehueegnecuffhomhgrihhnpehnvhhiughirgdrtg
 homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeht
 hhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhoug
 gvpehsmhhtphhouhhtpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdp
 rhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtg
 hpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheprghnughrvghmuhgvsehl
 ihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskh
 hisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhi
 ughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtph
 htthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhn
 ghhmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:PslPaGIQs_pQHtgnCahhZ7wjh0tRHdVAH2AHGqZn5_XJfleJPNHDcg>
 <xmx:PslPaBLKkfGlDFjkYI6kPbeWd7JilyUiKW4YjSAyoEeJNGJZedgOuA>
 <xmx:PslPaPzRHTxxX9O3_O55CotFOXvTaM0DRF9qvZLQXVM0vw1nLauHnw>
 <xmx:PslPaNJhSPLuA_U4axnlG69R0Tzt5gN1OJvnPMGc1aYABSQYn2n_sg>
 <xmx:P8lPaG5jrFISMXaglT6RcwP1mXgIZmlhBNYDnwo4aqBpOqWInVkJpgzA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 03:35:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <probb@iol.unh.edu>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 andremue@linux.microsoft.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Tal Shnaiderman <talshn@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Manit Mahajan <mmahajan@iol.unh.edu>
Subject: Re: [PATCH] common/mlx5: fix dependency detection on Windows
Date: Mon, 16 Jun 2025 09:35:23 +0200
Message-ID: <5837335.VQhiAETyHQ@thomas>
In-Reply-To: <CAJvnSUD8aW-y_qdLN_GnRQfUns9H2QZcbKjg3TtauRXJ4Ojx4g@mail.gmail.com>
References: <20250613081018.2790825-1-david.marchand@redhat.com>
 <CAJFAV8ziisXinUmbOSZ7r2EHoioqgEL-KS7Y1dCY=MH2AmnxDQ@mail.gmail.com>
 <CAJvnSUD8aW-y_qdLN_GnRQfUns9H2QZcbKjg3TtauRXJ4Ojx4g@mail.gmail.com>
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

This is the documentation to prepare mlx5 on Windows:
https://docs.nvidia.com/networking/display/winof2v290/devx+interface


13/06/2025 23:48, Patrick Robb:
> Good catch David on this system having a partial install of mlx5dev
> header/library.
>=20
> NVIDIA guys, do any of you have a link to the current install procedure or
> package? If not I can probably find whatever is correct. Thanks.
>=20
> Either way we'll update devx on the Windows system Monday - thanks for yo=
ur
> patience.
>=20
> On Fri, Jun 13, 2025 at 5:42=E2=80=AFAM David Marchand <david.marchand@re=
dhat.com>
> wrote:
>=20
> > On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM David Marchand
> > <david.marchand@redhat.com> wrote:
> > >
> > > Don't *require* mlx5dev library when testing its presence.
> >
> > For the record, this was seen in a UNH env that seems to have
> > partially installed mlx5 dependencies.
> >
> > Has header "mlx5devx.h" : YES
> > drivers\common\mlx5\windows\meson.build:10:0: ERROR: C shared or
> > static library 'mlx5devx' not found
> >
> > >
> > > Fixes: 85c51a4ffab8 ("common/mlx5: get Windows dependency from standa=
rd
> > variables")
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>



