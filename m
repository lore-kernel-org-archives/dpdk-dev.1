Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E63AC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 11:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A71D940430;
	Wed,  5 Mar 2025 12:00:26 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id B622340275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 12:00:25 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1A991254015B;
 Wed,  5 Mar 2025 06:00:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 05 Mar 2025 06:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741172424;
 x=1741258824; bh=BkVOM41Zo04vdP8e8ZJuJP0zeJvsfdOP07v1nwqOuuk=; b=
 lLuMDuy2zUhBHpP5aQGIcydHmI/Bv4KCMxRmPoKwy6stdNwjMLvjnd0OPR7wsSIQ
 3+JcMfDwc4rzoyCaFO95wOlGYomsxHX7f7qWdYlJEWS6BgOYZnZrvoVESRudZ1a8
 ZaGYkfXxP0Y6Kt5sqLqceUOhemGidIDxrA0ChuLUswo0z574m3NsS6BEzqdGdYEb
 ezjDdzpFKujSOk4oHlAjD52KA42QhjzJDbHymVwhrVC9qAC6BvQc4n4pVfzN+gMB
 yHAoSDqIZWN71L3FVfV5MyR5y6emNF4knwbYnVBVePYWbNBI2gndQFVOcRGI2XIa
 Y6fwDMdroAb44dwQ3F5Spg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741172424; x=
 1741258824; bh=BkVOM41Zo04vdP8e8ZJuJP0zeJvsfdOP07v1nwqOuuk=; b=N
 ST9FZAa2fW47qiLHVQRX8gB94YH7V0AC29Q17xHamhweMXkTgvHX2fQjBl7Z+2WN
 4AvqY3wV5dz4KB4O8ff7RG4iQnjHjPEZSegAZu+JGya0wwarYpMAw1mXlc2wH/Q6
 IZSDTaT4Yja9oHf1AiYO5iYTJB1gk7OBDyY1f3jmlQaLb7ST8VpIeAiYZ8ql6n1+
 oHbGODEqW3Z3bXGUs6TbDfYLhE/T4oGcJSyxyGXKPQTycg1R6JuZmIkalLcskf7r
 SAyG8d32MVAh1yUqAgXY2vv17JRPpd/pPuXkd4lNiLRSwfHGJavuH+ITqB/+FEjk
 n0lq34lE08F7DPfx3mYOQ==
X-ME-Sender: <xms:yC7IZ88CTXxeb8VyEFb6RU7cLr427-gsDzu_KNt5qg5LBhS9tyRD0A>
 <xme:yC7IZ0tIGn7N1Cfd-4bHGyLN2uScww_UBoOY-8GhWT00NTmjIjMSzZLSn_9tfrjS3
 0iZQ4BR8ls8_Dt06w>
X-ME-Received: <xmr:yC7IZyCCqPQgdAipAz-y7MX38sUdNWGh9VCi6qY4RvwxVnQ6PdZSlsNCyayHidvjnF_8p-iV4wvkaeMxzIQ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeefteejieekffdvteevudelfffg
 ueefvddthfehgeevtdefieejgfdtleegiedtkeenucffohhmrghinhepqhhinhhvrdgurg
 htrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeht
 hhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvg
 epshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughh
 rghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheptg
 hhvghnsghogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghgrkhhhihhlsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepghhmuhhthhhukhhrihhshhhnsehmrghrvhgvlh
 hlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrght
 rdgtohhm
X-ME-Proxy: <xmx:yC7IZ8eTC4vbStZIlygbvNVMcjvjRspTQG-rwNaMBaEqSIA6NJhASQ>
 <xmx:yC7IZxN6aqQz_udcJrS3XcWLXciSmRjNHus32X0_Rt8VKAyQCOmTcg>
 <xmx:yC7IZ2mobS8OBpaX1BHuTQ8cN8pH3GqZnsSeTYyFigJ_1VxCgt9YZw>
 <xmx:yC7IZzucaHjc2lT5HCUSicUr5R9C7DMNLO_V_qq4bL-6mTdOmkUg1A>
 <xmx:yC7IZ9C5zLpq59lhUvghGXzHEyok9W1_NqU3Gt31N0XuY2pvnkFB78Qw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 06:00:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost/crypto: fix build with asserts
Date: Wed, 05 Mar 2025 12:00:21 +0100
Message-ID: <3718319.PIDvDuAF1L@thomas>
In-Reply-To: <1353fc1e-588d-4faf-b5b7-548cf83b98f5@redhat.com>
References: <20250305094323.598983-1-david.marchand@redhat.com>
 <1353fc1e-588d-4faf-b5b7-548cf83b98f5@redhat.com>
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

05/03/2025 10:48, Maxime Coquelin:
>=20
> On 3/5/25 10:43 AM, David Marchand wrote:
> > ../lib/vhost/vhost_crypto.c: In function =E2=80=98virtio_crypto_asym_rs=
a_der_to_xform=E2=80=99:
> > ../lib/vhost/vhost_crypto.c:538:42: warning: comparison of integer expr=
essions
> > 	of different signedness: =E2=80=98long int=E2=80=99 and =E2=80=98size_=
t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99}
> > 	[-Wsign-compare]
> >    538 |         RTE_ASSERT((tlv + len - &der[0]) =3D=3D der_len);
> >        |                                          ^~
> > ../lib/eal/include/rte_branch_prediction.h:43:45: note: in definition o=
f macro
> > 	=E2=80=98unlikely=E2=80=99
> >     43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
> >        |                                             ^
> > ../lib/eal/include/rte_debug.h:47:25: note: in expansion of macro =E2=
=80=98RTE_VERIFY=E2=80=99
> >     47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
> >        |                         ^~~~~~~~~~
> > ../lib/vhost/vhost_crypto.c:538:9: note: in expansion of macro =E2=80=
=98RTE_ASSERT=E2=80=99
> >    538 |         RTE_ASSERT((tlv + len - &der[0]) =3D=3D der_len);
> >        |         ^~~~~~~~~~
> >=20
> > Fixes: d1b484bf1876 ("vhost/crypto: support asymmetric RSA")
> >=20
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >   lib/vhost/vhost_crypto.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
> > index 8dd1806a39..3c6c5dc114 100644
> > --- a/lib/vhost/vhost_crypto.c
> > +++ b/lib/vhost/vhost_crypto.c
> > @@ -535,7 +535,7 @@ virtio_crypto_asym_rsa_der_to_xform(uint8_t *der, s=
ize_t der_len,
> >   	xform->rsa.qt.qInv.data =3D qinv;
> >   	xform->rsa.qt.qInv.length =3D qinvlen;
> >  =20
> > -	RTE_ASSERT((tlv + len - &der[0]) =3D=3D der_len);
> > +	RTE_ASSERT(tlv + len =3D=3D der + der_len);
> >   	return 0;
> >   }
> >  =20
>=20
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Applied, thanks.



