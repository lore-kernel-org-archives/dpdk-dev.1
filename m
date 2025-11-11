Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8CCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 12:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BF384026A;
	Tue, 11 Nov 2025 13:25:46 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id D246F40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 13:25:43 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id E86AE1D000CF;
 Tue, 11 Nov 2025 07:25:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 07:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762863942;
 x=1762950342; bh=Fud4fiSxWnyUvXQr+rFGQriJOqWB1NT1KYTapQcbA+U=; b=
 VWMN38SA1KVIWCPiNfjhd6+wATN5Hxno/vgoDjDV4NY0u4AwHBgPBhT6vTPokg5/
 lNRKs7olbhTrpxvuNbdVGQnf4ynIYB3ZXWdIfLWBtC4nFMVWpmTBcoWqjzel2PLT
 wRssaKuQAr6xEisgVdw1/bGNE5UfnOJ2YxHUdclqRWrDt6iNswQNv6kv/HNWMLHU
 Zaa47N1z22p5phMqAV/c08mk/e20E++C54ZbbopKg2O89PVLx2F4c2fcVuaAdn8E
 sdjIpkIRrHPuH0foSRYFEuy9FoL+WPssAbaO2iimwb644NpTudLWzinceMVXlvrI
 OtEmYDHi47yCAEfmNqU0QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762863942; x=
 1762950342; bh=Fud4fiSxWnyUvXQr+rFGQriJOqWB1NT1KYTapQcbA+U=; b=H
 SFFb5Ub6+8sFNeJgE99nDM12jCnlApbpKKWeMsEXD3gG9buu9J2RjqGruIOMIbh2
 +QwYFsNIhD2J+W+m4S7toM+zgM5rD6wdmUoxD8UmX4RIb5Bzwc8KzoRc7gFlAtby
 CYaOrNgF3WENF790Fo9uQdFwDd5wj8lI5onqAQmZBqgVGb8l32y8aof0JAMEgwPT
 4MThsE9taWeFRx4aoMOhl6v8iKqIy68hLw19jBSy/4HBSuA/aGgNd0tv8OkWoNys
 DRpRIaTYkUtm+TiwWaUZvdI+N/L6RfZObcV4lLq8hmshU62Eo6vTRlMnFD6lk0FR
 A3CYAxLmmS6qsvXx0msIQ==
X-ME-Sender: <xms:RSsTaeqxyvnzVXigJhB4SK23AxlhFUSXWlBtKoFEPUYAG8rNP6VJQw>
 <xme:RSsTaVlW2mr-FLAWiJPWkxfiwDDKTdkIbz3x7HgMbKpKwozFYxkdvlEtSWtH-ApZL
 nuRFJIwbXlQoBCKHkzilfQQONEtIVdIrxPorc6XP_Yg8AeBnAct2Q>
X-ME-Received: <xmr:RSsTaewB0Mbvc8fIAkI0wHORDLkRvnwlFQhwnmxk-OO3-aG2Z2zxppjtVydOVm_1dpZ0GrAntOuXq7BM0c39_oXCSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehisghouhhkrhhishesghhmrghilhdrtg
 homhdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgrlhhlihesrghrmhdr
 tghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopeifrghthh
 hsrghlrgdrvhhithhhrghnrghgvgesrghrmhdrtghomhdprhgtphhtthhopehmsgesshhm
 rghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehkohhnshhtrghnth
 hinhdrrghnrghnhigvvheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:RSsTad8aTO28JOSrncOxrjzwJSdThMBEiwg1WFGYBXVOBxxJIhhU6g>
 <xmx:RSsTaaIl49mj2zZxcwVbIQuKtPmWVXQKzz9SU0W8TO4a49rSuUiKZw>
 <xmx:RSsTabcBzOoF27PJ7RVhKlbSDw-TUnb7Rp13NP6wMJ3MIweQL7_CFQ>
 <xmx:RSsTaR_0kO9cCLLe7bspM3QNjnQq33I1leDeT_HycPnA3wGmAVLFAw>
 <xmx:RisTaQG25VzcvcS864nSovb3yWF3KCuEqXvjC6L2TSCbtuZMjZun57-C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:25:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Isaac Boukris <iboukris@gmail.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3] lib/ring: do not allow zero size ring
Date: Tue, 11 Nov 2025 13:25:39 +0100
Message-ID: <4378849.kIdP2CnQM6@thomas>
In-Reply-To: <e7fd8bbd16d94544aaae9507cece72ba@huawei.com>
References: <20251110222827.575488-1-iboukris@gmail.com>
 <20251111062253.578121-1-iboukris@gmail.com>
 <e7fd8bbd16d94544aaae9507cece72ba@huawei.com>
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

11/11/2025 09:24, Konstantin Ananyev:
>=20
> > this might happen when for instance the ring size is read from
> > config, and would cause runtime crash. Do so by using the
> > RTE_IS_POWER_OF_2 macro.
> >=20
> > Signed-off-by: Isaac Boukris <iboukris@gmail.com>
> > Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


