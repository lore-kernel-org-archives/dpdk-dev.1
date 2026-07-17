Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A1C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 335DD40BA2;
	Fri, 17 Jul 2026 14:56:13 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id D823E402D4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:56:11 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 49334EC011B;
 Fri, 17 Jul 2026 08:56:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 17 Jul 2026 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784292971;
 x=1784379371; bh=M1V1FmVZjDvPCe6vWUr/hbZDhpTqFIe7dw/6KycnayA=; b=
 jh9DyEYSOOpTacrrhFjq+o/eGDg8PwQEEGNijmkEsBoSdQzAlWyVssB78promIwr
 +ZAYPdSm/lXazADJ6DypORB807kr8T+GaTfxKNZfODTxIuK16iv3538UTTbff9/L
 tu1M/kpazijbTcdrP4mZQFDVW9bKk1AleN3+RQvAGgSVA3Ade2aMyRhiaAgOS+25
 IHt//cv7wtM/UOKQ+G1xFcefe4iIWqhibTK/r7jfP1qZgFQprIjMuPt0qu7/AzI8
 GhCFJztnYVSYg5wQvT+mj+oV5CBCCfHNsnxswsfG1snf6LqS0Bf8bsFDAFQl9Pje
 +x+VgPHV4NCua4/sAY0DBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784292971; x=
 1784379371; bh=M1V1FmVZjDvPCe6vWUr/hbZDhpTqFIe7dw/6KycnayA=; b=Q
 6hugXSYFsabLPLuZOOkpg8U2l4ypD5QTr/B9p5sbgNuZf3H35YOqqXeFmlXdy/u1
 ePjZaexATDZgNRAn2CcfAD9qaDZD222Q24i+pUajbApjqTSJwhLveIcOiu1LOz6Z
 lJ3F2rbiGLI+Huia2LxoIc1GLkX+hr7JmW9mdoEmHYm/DLOQsWNyduBHGtUIyAYr
 M049KYiCIN90jTroPiLtzYUg7Cc60sWpL3bHmJGKZoP5Tnt7rm4ZcM2Wpy83/MIB
 eNnjgYEQOOfucS5YaksFB0r4QxuAIVZaqqVLSjXTmcezVcOAQ9sw5zI8v4AmMoCB
 D1Ow6fdG8E4uXOh89XXtg==
X-ME-Sender: <xms:ayZaapSnozziW740cE-f4CRJLfUjOzWtxg-MuWdUw1B-wiX7budhDA>
 <xme:ayZaai7TPrmW4Zq4ZlgMHm_hmg3gn0_R_hCElg4M0t0QKgwxbM0bOsSt0m3cAiVNX
 f6uhekZxNntaFOn5ubNFTmo40vfE0kzs8Q1kOB3e3nXKWIMh7ux2w>
X-ME-Received: <xmr:ayZaamxItlGCkT9TPcoCQvY0urFLLsVZWsj6ZIwsrdqSZUITwt_0HtunH7BxpR5Egh8E6UjyCjs7HWWr-g>
X-ME-Proxy-Cause: dmFkZTFv0/Y0PyXKfcr++RAleJeyqBaBGM1TBxTVO40nyQyWo1g1Ih7CX4qVcU/YZTnIrJ
 xalcO1iGdWyw7kwxjyILJ6tWksAUjI89gbFw77EN8WM58Ez3tGhola1H6r7XANwlxXN2Ij
 fOJzF/eUiGZM1QBmnteTyNuJskfPBWBA5NUU4vedCaTXE9CWinuddL4D/PHb4qTMLAm0lP
 PmBQWh/vg5u25+HRxNhxxIl964xbOTXYOGQxdxLnVPTw5aFcEm9827Y9xY00PA7fl2tXdG
 JqLXBvV2W79CtbsIU9aaDqcF18XYI60IzpkhEk+YuHEHExt5L/zjMYVby3S6jID9tiN/OP
 OG/bLD1eolkoasOP4xBScTeDVaWNsOGwlyZi5PfSKS8SFhdNG1Gk0Ou7Dr9lmedddnuk1d
 H1oItcCE2+mTw0TInPCmltP57smttSdG6EmY+n2rJCpA9EZP7Ang/L1BY+1S5nkHGy5H9h
 DmRvd/QIl0ys3OTr+1NSFrL4r/+c6Wi0kUsweHPEB/xCog7TVJjZodtMYoklIdxtMY+cel
 JYvkskQjkCkxfdDSclyDc1viTe74ipCo+pujSvqwNLha8uGtvpyMU+m9xir3rRYLw27zle
 d6GXTw1nvuGjbZhFSYCy0fimcXFXviJvK/VfAHVnO/XKegVpeJJiZ+Iq+WCw
X-ME-Proxy: <xmx:ayZaapSebF69FiNeEPl3sVThqIgyf9Fg4rnsGz_AdFmcjqePB9uF6A>
 <xmx:ayZaatWKEsEeWN8T_R0K5YiQu7Dy27Q__bHyBFgOxqfgtX0N9Fr4GA>
 <xmx:ayZaaraIHGlqih5sCQRv7QWMHHVSm0N_fL7dLSWGtqy6T2ui60AhvA>
 <xmx:ayZaaj3vAu2scj8VC4FJaE6awFAJsMV17vPcQqt2S2tlqM9y7O71RQ>
 <xmx:ayZaar3ayjLgandRkBx0egUglwMrEhEEg_R5qkJG9S37h0-HiDXXVAgC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 08:56:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 "Xueming(Steven) Li" <xuemingl@nvidia.com>, dev@dpdk.org
Subject: Re: [PATCH 06/10] test/devargs: check driver presence with public API
Date: Fri, 17 Jul 2026 14:56:08 +0200
Message-ID: <a4aCxIgGT12A1zShAOydIQ@monjalon.net>
In-Reply-To: <CAJFAV8yr_4Wttt7sDUVzqYnAsMYxoTRg3FcNbZefpYzs1v9e0A@mail.gmail.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <aloAfU6IdpZOMAlQ@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yr_4Wttt7sDUVzqYnAsMYxoTRg3FcNbZefpYzs1v9e0A@mail.gmail.com>
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

17/07/2026 14:34, David Marchand:
> On Fri, 17 Jul 2026 at 12:15, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Jul 17, 2026 at 12:08:01PM +0200, David Marchand wrote:
> > > On Fri, 17 Jul 2026 at 11:56, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Fri, Jul 17, 2026 at 11:30:01AM +0200, David Marchand wrote:
> > > > > Let's avoid calling internal drivers API.
> > > > >
> > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > > ---
> > > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > > >
> > > > One suggestion inline below.
> > > >
> > > > >  app/test/test_devargs.c | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
> > > > > index 0bd14c24ec..6c194ecfc6 100644
> > > > > --- a/app/test/test_devargs.c
> > > > > +++ b/app/test/test_devargs.c
> > > > > @@ -10,7 +10,7 @@
> > > > >  #include <rte_common.h>
> > > > >  #include <rte_devargs.h>
> > > > >  #include <rte_kvargs.h>
> > > > > -#include <bus_driver.h>
> > > > > +#include <rte_bus.h>
> > > > >  #include <rte_class.h>
> > > > >
> > > > >  #include "test.h"
> > > > > @@ -167,14 +167,18 @@ test_valid_devargs(void)
> > > > >               { "net_ring0,iface=3Dtest,path=3D/class/bus/,queues=
=3D1",
> > > > >                 0, 0, 3, "vdev", "net_ring0", NULL },
> > > > >       };
> > > > > -     struct rte_bus *vdev_bus =3D rte_bus_find_by_name("vdev");
> > > > > +     struct rte_devargs da;
> > > > >       int ret;
> > > > >
> > > > >       ret =3D test_valid_devargs_cases(list, RTE_DIM(list));
> > > > > -     if (vdev_bus !=3D NULL && vdev_bus->parse("net_ring0", NULL=
) =3D=3D 0)
> > > > > +
> > > > > +     memset(&da, 0, sizeof(da));
> > > > > +     if (rte_devargs_parse(&da, "net_ring0") =3D=3D 0)
> > > >
> > > > From what I/AI can see, there is nothing in this test case that req=
uires
> > >
> > > (you could write it as "From what A?I can see")
> > >
> > > > the ring PMD specifically. I think it would be good if it were upda=
ted to
> > > > use net/null, so that we standardize on our basic unit tests only r=
elying
> > > > upon that PMD, rather than requiring a variety of drivers. WDYT?
> > >
> > > There may be a hidden (capillotract=C3=A9) reason.
> > > Passing path=3D/class/bus/ seems to be intended at catching errors in
> > > devargs parsing.
> > > No argument in net/null could accept such string.
> > >
> > Not a path string, no, though it can take other parameters. Do we
> > specifically want/need it to take a path string?
>=20
> This is some special case tested for "legacy".
> I prefer asking Xueming and Thomas what the intention was.

I have no idea about the original intent.
If it's unclear, it means it can be removed :-)



