Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4CBCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 744BE402D9;
	Mon, 18 May 2026 15:05:30 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id C2C75402B8;
 Mon, 18 May 2026 15:05:28 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 58959140010D;
 Mon, 18 May 2026 09:05:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 09:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779109528;
 x=1779195928; bh=iqb3fKwiMlYTTdU/c0mpcxC0CCL8dp8LffSJoekhHoE=; b=
 HaWSKFdsrCrx02gMcpYeWEmXR8Gvtp6YnB5aKPRIyjLxtKf0Y4NEBN1IzrBX0X9G
 TWKgZeG8fl6GLQtf2woNS7o5F1QqMHr8/mVptvKnKCBablLOwks/xZ3KSxvicBwA
 KIUtjHu5PjWI9gPNnVwdIE7DPZJ9EVciRJrFabaNdIPbBppoBW4EIXXPm8r8C8Dm
 TcwzKuhfuh7vvut8jkUjI3f9zniA2igs4YOV+KPGXI0TWtmbSIWITcOZwlQda7UW
 tBLB1lkB4OtMpSMTJT9MCyjfAdcoOywp5uZAtJmeNjH4jsT15aem75qekGQKDN/Y
 Fc5zcARKaWfguScVPCepxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779109528; x=
 1779195928; bh=iqb3fKwiMlYTTdU/c0mpcxC0CCL8dp8LffSJoekhHoE=; b=b
 48muOneTobU4fvt0E9THfovCdO172ydGRNXhGIMx5xdK/jPiCiBUdiWcHQTD0eaQ
 isT580TpAJWasFGNQ//6ME3GPe718GTjYZjS+ESZ7t2y0jwB6ik9ykVwKEnLhdI/
 GRZHg49787aPbqeksH9o4uMrBCoWUosXxdMSvG2P78+pw6RwiZypb24FjUuMUkiU
 nb+4oBqOtd74X8F/JUzm0okSLOmK8tnu0W+7Fp8//FGfmMbt3Uce1r+mXuxr5EBS
 SX0cvIeId6ibFEVYh2v3c3/l6bZU/93w1krCoE6MEJXS4m4OXKAkeRSYMgPFf9dj
 RQzFGt0aty1pLFFrgZ95g==
X-ME-Sender: <xms:mA4LauUmA6X6VgMEBiCGrL4cwB7C61tYGP6VZ0irjO8jlPeni4dROg>
 <xme:mA4LaqvO9pI9MqyavJkFq42Gk7miTRPzSsU-n9LvamiTCIMr-BpnC6jOgPSYQ7PkM
 ve4RBJBNJOrSCawPBEPEfjxgvfi7-URugiddwYcRwlImSeURyM_Uw>
X-ME-Received: <xmr:mA4LaqWqOo4HgF1rT7MOtyLTcI3ehLNholzO1hsTKc12ihpzTDiwzmYGGbRQfRzpZg2m3bkl9gSJWgnUk8Z7EsZi7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtoheptghrihhsthhirghnrdguuhhmihhtrhgvshgt
 uhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:mA4LatmmlQ2KW9AjPW0E8ZY0Ma2WgCzGn9adyCiwdPkqnA1CmbQCaw>
 <xmx:mA4LajYOlai3c4WvDQUvfuGC5zRdqb9LP70cS8KDpniEMltnfZxlkg>
 <xmx:mA4LagOfI3l9iYYbEzhuW5N3xpUQLPq1xlTysOozztXw8H9--ijWAw>
 <xmx:mA4LagacDHPbcqMzc3TBUvco-sOCHbOLMVp7Fw6OQ_t9FnKWnrlNwQ>
 <xmx:mA4LagRv97c9bpbUSv1amcKru1jjZ3ANGzNjMDTA1Oucah6X5ufmOOW8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:05:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, stable@dpdk.org
Subject: Re: [PATCH] pipeline: fix build with sanitizers or debug options
Date: Mon, 18 May 2026 15:05:25 +0200
Message-ID: <AcxEvVy7Si2uiC1gDAYFdQ@monjalon.net>
In-Reply-To: <DS0PR11MB74428B95BC221BC7F5FBE7B5EB4CA@DS0PR11MB7442.namprd11.prod.outlook.com>
References: <20260320133309.1015506-1-david.marchand@redhat.com>
 <DS0PR11MB74428B95BC221BC7F5FBE7B5EB4CA@DS0PR11MB7442.namprd11.prod.outlook.com>
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

> > Similar to commit 84f5ac9418ea ("pipeline: fix build with ASan").
> >=20
> > Here we are again. Depending on options (like debug, or ASan, or UBSan),
> > compilation can fail because of dumb construct like CHECK(0, XXX).
> > Dumb, because such an expression macro expands as: if (0) return -XXX;
> >=20
> > ../lib/pipeline/rte_swx_pipeline.c: In function =E2=80=98instr_movh_tra=
nslate=E2=80=99:
> > ../lib/pipeline/rte_swx_pipeline.c:3461:1: error: control reaches end of
> > 	non-void function [-Werror=3Dreturn-type]
> >  3461 | }
> >       | ^
> >=20
> > Remove any such call when at the end of functions, using a regexp:
> > %s/CHECK(0, \(.*\))\(;\n}\)/return -\1\2/
> >=20
> > Cc: stable@dpdk.org
> >=20
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>=20
> Acked-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>

=46ixes: 2f8168eac37a ("pipeline: add instruction for IPv6 address upper ha=
lf")
=46ixes: cdaa937d3eaa ("pipeline: support selector table")
=46ixes: c6b752cdf215 ("pipeline: introduce SWX extern instruction")

Applied, thanks.


Should we remove the other instances of "CHECK(0," ?


