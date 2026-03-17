Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8831FED9EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDDEC402B0;
	Tue, 17 Mar 2026 17:15:09 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id AA8DB40270;
 Tue, 17 Mar 2026 17:15:08 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 720E11D00045;
 Tue, 17 Mar 2026 12:15:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 12:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773764107;
 x=1773850507; bh=qwa5Y1lQHRrUvSg/TlHJjletqXqANHypC8EnEYZy7qA=; b=
 Kih6yLFybLz09WMiMobEVvfnCML2If9GkFmu8qwkdkD6C7xC7nMqGOfaGRPDbLUU
 nX/YD0snkdgdPDb8FCr0VvwSTCRDtxHS1J9UBAR9abiDEGeW9hU4ByYJB5z3KKoM
 R7Wrta1IsdPZw1tbeM7OEjLMpNbtLwu1qakHFiJGpWBd5Lo8UQXPifH99D2lIM3m
 oeqGA6Z0uRKVZ86p3QJpmo5Cqg5MCQgZR9SZYgBzA3E/KBPk7/lD2B0ViK/hDycz
 +l4zJYqMBf/8M6CmCif/CdM9jMylkfTQPWgFPqFRCR+EjWeGrwLCVkoH0A0eBIju
 pgYRxBFpkckYlsrc7QPSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773764107; x=
 1773850507; bh=qwa5Y1lQHRrUvSg/TlHJjletqXqANHypC8EnEYZy7qA=; b=t
 FuDn7K0hJ2u6dTJGH1lNUQ2tpv2MZ83VGKNeGypqcQINZpUz2tjAdRnIAu+UZGiI
 RKquQqBqVT9bLVZZRnu8RyVA1/bkw7BveEI9RBOnWFqGOiU5wI/EQAvwK7PiHKk9
 YXQ8Knc1zKEIEVftXJTls+nZttVgo8WXAVgL8RfnN8J1qgWe7qe1C5CQcwOFHA5Y
 A3HXsofmI2junJgXxYVncjPm+9Yu+qO3U8zzRmLEIFYsHPufL8PLJ2ZICr2qKYes
 TaFE9hyDPoo6mEE6EO/fMWXQpCdaQXF8FiJNxGehk/g38HSJigjoaUCvetEEiuuC
 Xwm8pAl5vwj9FU+/GL2Lw==
X-ME-Sender: <xms:Cn65aZY9LRZKwgaU6cBwNCfcV4NSz4hvKafrA_k0BFjSV9WGy2I1bA>
 <xme:Cn65ab1Kdj-iK0R5T6z0061lU7AO6XArWpl98yJdAXB6lWIEe9ACJqMoYVRzxoA2w
 p4plbFgEEmxFJ7yPptyHR8BEVLgrcQKGix0BJfRCCzXYNDO_-Hb0A>
X-ME-Received: <xmr:Cn65afezqqAqx1wEcafkLALdJa-towdk1vDcM2hfV0GpBYx7KpJeraVdPcVqi5ge4MbtTkrL_CvOOyoP95gbOHwjWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopehgrghkhhhilhesmhgrrhhvvghllhdrtg
 homhdprhgtphhtthhopehrrgguuhdrnhhitgholhgruhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Cn65acFwP_v6mB7QTy37smNcVvgZ0WizLUuWo-kI6JtFPcRPIo_p-A>
 <xmx:Cn65aQ37TuwQrQc7kNU5BI0kFN3P6V-ipYQC4aL-YQR2lBCuADiQhA>
 <xmx:Cn65acm8y84YLfsKvBPOHXE6DWi3ZdzMcZ31Q8XAYnc4Zt7iMK5fqA>
 <xmx:Cn65aY-0vaSkgE-SwK_OTgU3VSB9bsqgEX0BGkiEg08EvYY7lh09bQ>
 <xmx:C365aQtSgT7PTJmf_4c26k3ZH7WqTvUXPqIv0RzC8aKmeY42RqMK6NGF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:15:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Akhil Goyal <gakhil@marvell.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: Re: [PATCH] examples/ipsec-secgw: fix discarded-qualifers warnings
Date: Tue, 17 Mar 2026 17:15:04 +0100
Message-ID: <1828480.X513TT2pbd@thomas>
In-Reply-To: <c67fa3ed-a41f-4a92-a39a-1e7ca2a9da1f@intel.com>
References: <20260313103523.1094309-1-ktraynor@redhat.com>
 <c67fa3ed-a41f-4a92-a39a-1e7ca2a9da1f@intel.com>
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

16/03/2026 11:12, Radu Nicolau:
>=20
> On 13-Mar-26 10:35 AM, Kevin Traynor wrote:
> > glibc 2.42 has const-preserving functions.

It is in glibc 2.43.

> >
> > This leads to warnings when there is a const argument
> > and an assignment to a non-const variable.
> >
> > Example with GCC 16.0.1 and glibc 2.43 on Fedora Rawhide (F45).
> >
> > /examples/ipsec-secgw/parser.c: In function =E2=80=98parse_ipv4_addr=E2=
=80=99:
> > ../examples/ipsec-secgw/parser.c:53:13:
> > warning: assignment discards =E2=80=98const=E2=80=99 qualifier from poi=
nter target type
> > [-Wdiscarded-qualifiers]
> >     53 |         pch =3D strchr(token, '/');
> >        |             ^
> >
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> > ---
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>

Applied, thanks.


