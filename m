Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83618C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 04:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C00402A2;
	Mon, 14 Sep 2026 06:48:32 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 6137C40288
 for <dev@dpdk.org>; Mon, 14 Sep 2026 06:48:31 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43ac8d1eso8850547b3.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 21:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789361310; cv=none;
 d=google.com; s=arc-20260327;
 b=SSoIhI9F4gY8CKVKACsY0SM59ZqB95V4xmzsyWQWU0QTqpk1YieN8EBwyx3cWaLxFU
 waabrfoXdNaxLX/Ea/MOlGYMHQEWR3QImkNQnvPUJUZuftmJ02PGu4cBvoXLB23UNczI
 oKwjXCxAecHMRZw6uVnoNlSMIlCelDMgB8BVS9SJgTgiNqkRMIbsH6a2tAOwWE3714k6
 rdcS/zlfpYXYSugIn6t1jyKRZ7ySyDtskn7BEK8pgd4pV8dX2HFj9r+HgusVy6o/30f/
 eevJtBvJtk9UJYm9LeGe3FwotxiskAS8Op3EPnIpZw6HOsfwRzuV7TQMaiRC4g816ceM
 hYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WnYlitFOLkmThiVkpLqdFkjYUMIs4iRaJmEwSi/XjxQ=;
 fh=syn91XfAWhJ4sjXwPKNkwkp6lVxRZHS0XVN2QHOm2cs=;
 b=C/+CFfyCWOZKI9PARrAkqFoFZYX+w11ijizVt+YbM+nBsETK2JlRa8fcfS7jwVolyE
 WVJRgKH20A2m6f5PyI8qtAGZu4pGqCUOFbZMBSx+QfuUWugYBXz+VGI2yTJr23tEJJ7Q
 QVJVpSkZpH2SDKgYSH1rznNg8FtUt7fa8ZiXuS+AGuIRSvcWe9ypCvkl798sbGUp66H7
 xTK0zKJCg3FQhGrSggxeUKG+yf9XFru4rt2Kii0aWuNrsNX/+SUCK4o8zXyS0bSbng7f
 Iyv2RCkEWRCBVTzvfwhrKlUaHfn2r6Su4EVbXR4Uzwv1YOQYcnjNkXZf8XqAcEds+LYZ
 bzUA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789361310; x=1789966110; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WnYlitFOLkmThiVkpLqdFkjYUMIs4iRaJmEwSi/XjxQ=;
 b=jCk5k5n6F0IxJ/oca2f24bdhBuieuAT3tyFw4an73muBpd+3+hsCjJM969jVb1o14i
 zHW1bvjQJliyVx1EvRcuSKk/bDO9CZvtL5T3KmuYRqdgEfmytsHB5RnmLuMeF7cVuGXl
 1KQN97DalEE9h4SzDfmUzje3kbOAK8MNZAY0oXDcpHr0pJ+F2y1QY/2iYYMP6IXq2t0Z
 x4BeZjEfYhbhD5zUAig06TIK/aYo3BeGwnX2Y4gdwWmE4DL5rzocfS7F0n4/8Bjta8O2
 ve69Z4FPVTJ823a+z39pb3u8RtoWKaSoEWKDlz+m+BHv/sapDicdhsFX4ZboTRlM/jha
 9hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789361310; x=1789966110;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WnYlitFOLkmThiVkpLqdFkjYUMIs4iRaJmEwSi/XjxQ=;
 b=YjHWe4XGr9zf/Lq0o8+PsV9Oytzh0HG7WhCVuMDtncsOTh/aOzj2nokW1UOCdAaaF0
 XqXpdY05qdV19HQrM21LdXDrrfbmduhEmh9KpdkW/rde5PIeRva0XjNGMT/yGAtZ0PEC
 4dP++P+/34yXTV1cwQe+mgpJghBlBseSl774i4GjTo72brQ9hhuVyTs49Vf3RxY7mH6x
 mhFM7JBIwxPDzlwYQ9kGh6QlJmHT5bqtBHLq+WPDB/6hbKJJcTc+8kpjL9v1cbnyQeJv
 CEsJNTSDydtK3pz/N0lNKZbmySi3IYLh8xsuaVYWES6ySfXx1Y35BwFQfkMq7kCSDj1R
 O4wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4q7c78NS+hvI79lc8SO2RiM/Go9ezuPi5dZx3nDGZx6vVWdbdE+nEYlLscdRPEb1FN6I=@dpdk.org
X-Gm-Message-State: AFuF++nozDerBR3KAQYogYMuiaMC+SfnKchwUJlITVb9vfJ6mG4DySaq
 NQKFZr7ih5MEVzDXW0OUGRE+vmmdVCnSAeMBtfFxNGLMTBm+J2ice7vBPjQWLID7O9ow6QOhMJO
 6xPRbK33e355kZyu9B7jx/EASzcdgCyU=
X-Gm-Gg: AYBFou3xJfKdL4yQ9Ce7dbEPZgXby9eDMXEE+jDl+5LxNHoZbuOjYGTAiy64tKC/Rpx
 m8snTDDZwNTAsH4nIfipTI9h3tMI23aynjUnzF/pFcWGUf3I/OVh5MX1JLCDlfXE/zgg264UK0L
 QUXydiPdhAvMR9vJsnLx22N/MmlXUPrHnDKaiKvXXSrq4c54GQpteBWK5hVaGaghVW2jIHK9Iv6
 nLtpdjPBMCliSGG+P/yF7YmUNZ6VskZ2kTVFmY61hxXm20UgD2b7LIYgrt6JR5PJKazpkGOtLXh
 47lZFiOaN8IQOHZztYofiamWwjoz2y5bbCdy8WJ/PEOgqvxTJZwqj2cvp2NFvpa98/BEnh5uCcd
 7Ytm1XIrWEt1ARZPZB5PIJ4yw54m0+DmQpms8d44ERmccJd7PKRmdkz6BugbyD0QkjocmEdVPkw
 zGILb0uKekSqdhR8LP
X-Received: by 2002:a05:690c:e3e1:b0:884:b55c:258 with SMTP id
 00721157ae682-88d1ea3e0acmr2119297b3.3.1789361310581; Sun, 13 Sep 2026
 21:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260807101718.3571504-1-gakhil@marvell.com>
 <d5fa5e8bfb3a4bb18af355ce5a7152c5@huawei.com>
In-Reply-To: <d5fa5e8bfb3a4bb18af355ce5a7152c5@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 14 Sep 2026 10:18:03 +0530
X-Gm-Features: AcwNN1WLlW_NRAft6j5EFEO2iz9gndJsXE4cYf4mdKbNiRp0f6RbIWtrTuyLGO8
Message-ID: <CALBAE1NLGFmsUhjbxe7G+U4-CR1wQAd3EbCvVAuXy=tZ=LdzSQ@mail.gmail.com>
Subject: Re: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "jpalider@marvell.com" <jpalider@marvell.com>,
 "tduszynski@marvell.com" <tduszynski@marvell.com>, 
 "jerinj@marvell.com" <jerinj@marvell.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000004acb64065b6a2541"
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

--0000000000004acb64065b6a2541
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:48=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com>
wrote:

> > -----Original Message-----
> > From: Akhil Goyal <gakhil@marvell.com>
> > Sent: Friday 7 August 2026 11:17
> > To: dev@dpdk.org
> > Cc: jpalider@marvell.com; tduszynski@marvell.com; jerinj@marvell.com;
> thomas@monjalon.net; Akhil Goyal
> > <gakhil@marvell.com>; stable@dpdk.org; Marat Khalili <
> marat.khalili@huawei.com>
> > Subject: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
> >
> > Documentation build for raw driver cnxk_bphy,
> > if included in `doc/api/doxy-api.conf.in`,
> > fails because of missing dozygen comments.
> > Added comments to fix the doc build.
> >
> > Bugzilla ID: 1962
> > Fixes: 2e8bd307fae3 ("common/cnxk: support switching CPRI/ETH back and
> forth")
> > Fixes: bd2fd34ab86f ("common/cnxk: sync eth mode change command with
> firmware")
> > Cc: stable@dpdk.org
> >
> > Reported-by: Marat Khalili <marat.khalili@huawei.com>
> > Signed-off-by: Akhil Goyal <gakhil@marvell.com>
>
> Thank you for handling this!
>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> Tested-by: Marat Khalili <marat.khalili@huawei.com>
>
>

Applied to dpdk-next-net-mrvl/for-main. Thanks



> > ---
> >  doc/api/doxy-api.conf.in             | 1 +
> >  drivers/raw/cnxk_bphy/rte_pmd_bphy.h | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
> > index bedd944681..94096ee710 100644
> > --- a/doc/api/doxy-api.conf.in
> > +++ b/doc/api/doxy-api.conf.in
> > @@ -24,6 +24,7 @@ INPUT                   =3D @TOPDIR@/doc/api/doxy-api=
-index.md
> \
> >                            @TOPDIR@/drivers/net/intel/ixgbe \
> >                            @TOPDIR@/drivers/net/mlx5 \
> >                            @TOPDIR@/drivers/net/softnic \
> > +                          @TOPDIR@/drivers/raw/cnxk_bphy \
> >                            @TOPDIR@/drivers/raw/dpaa2_cmdif \
> >                            @TOPDIR@/drivers/raw/ifpga \
> >                            @TOPDIR@/lib/eal/include \
> > diff --git a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> > index f668e6ea82..99504dc496 100644
> > --- a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> > +++ b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> > @@ -174,6 +174,7 @@ enum cnxk_bphy_cgx_eth_link_mode {
> >       __CNXK_BPHY_CGX_ETH_LINK_MODE_MAX
> >  };
> >
> > +/** Available CPRI modes */
> >  enum cnxk_bphy_cgx_eth_mode_cpri {
> >       /** 2.4G Lane Rate */
> >       CNXK_BPHY_CGX_ETH_MODE_CPRI_2_4G_BIT,
> > @@ -191,6 +192,7 @@ enum cnxk_bphy_cgx_eth_mode_cpri {
> >       CNXK_BPHY_CGX_ETH_MODE_CPRI_24_3G_BIT,
> >  };
> >
> > +/** Available mode groups */
> >  enum cnxk_bphy_cgx_mode_group {
> >       /** ETH group */
> >       CNXK_BPHY_CGX_MODE_GROUP_ETH,
> > --
> > 2.43.0
> >
>
>

--0000000000004acb64065b6a2541
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24,=
 2026 at 5:48=E2=80=AFPM Marat Khalili &lt;<a href=3D"mailto:marat.khalili@=
huawei.com">marat.khalili@huawei.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">&gt; -----Original Message-----<br>
&gt; From: Akhil Goyal &lt;<a href=3D"mailto:gakhil@marvell.com" target=3D"=
_blank">gakhil@marvell.com</a>&gt;<br>
&gt; Sent: Friday 7 August 2026 11:17<br>
&gt; To: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>=
<br>
&gt; Cc: <a href=3D"mailto:jpalider@marvell.com" target=3D"_blank">jpalider=
@marvell.com</a>; <a href=3D"mailto:tduszynski@marvell.com" target=3D"_blan=
k">tduszynski@marvell.com</a>; <a href=3D"mailto:jerinj@marvell.com" target=
=3D"_blank">jerinj@marvell.com</a>; <a href=3D"mailto:thomas@monjalon.net" =
target=3D"_blank">thomas@monjalon.net</a>; Akhil Goyal<br>
&gt; &lt;<a href=3D"mailto:gakhil@marvell.com" target=3D"_blank">gakhil@mar=
vell.com</a>&gt;; <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stab=
le@dpdk.org</a>; Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.c=
om" target=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
&gt; Subject: [PATCH] raw/cnxk_bphy: fix missing doxygen comments<br>
&gt; <br>
&gt; Documentation build for raw driver cnxk_bphy,<br>
&gt; if included in `doc/api/<a href=3D"http://doxy-api.conf.in" rel=3D"nor=
eferrer" target=3D"_blank">doxy-api.conf.in</a>`,<br>
&gt; fails because of missing dozygen comments.<br>
&gt; Added comments to fix the doc build.<br>
&gt; <br>
&gt; Bugzilla ID: 1962<br>
&gt; Fixes: 2e8bd307fae3 (&quot;common/cnxk: support switching CPRI/ETH bac=
k and forth&quot;)<br>
&gt; Fixes: bd2fd34ab86f (&quot;common/cnxk: sync eth mode change command w=
ith firmware&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.o=
rg</a><br>
&gt; <br>
&gt; Reported-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.=
com" target=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
&gt; Signed-off-by: Akhil Goyal &lt;<a href=3D"mailto:gakhil@marvell.com" t=
arget=3D"_blank">gakhil@marvell.com</a>&gt;<br>
<br>
Thank you for handling this!<br>
<br>
Acked-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com" tar=
get=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
Tested-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com" ta=
rget=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
<br></blockquote><div><br></div><div><br></div><div><span style=3D"backgrou=
nd-color:transparent">Applied to dpdk-next-net-mrvl/for-main. Thanks</span>=
</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt; ---<br>
&gt;=C2=A0 doc/api/<a href=3D"http://doxy-api.conf.in" rel=3D"noreferrer" t=
arget=3D"_blank">doxy-api.conf.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 drivers/raw/cnxk_bphy/rte_pmd_bphy.h | 2 ++<br>
&gt;=C2=A0 2 files changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/doc/api/<a href=3D"http://doxy-api.conf.in" rel=3D"norefe=
rrer" target=3D"_blank">doxy-api.conf.in</a> b/doc/api/<a href=3D"http://do=
xy-api.conf.in" rel=3D"noreferrer" target=3D"_blank">doxy-api.conf.in</a><b=
r>
&gt; index bedd944681..94096ee710 100644<br>
&gt; --- a/doc/api/<a href=3D"http://doxy-api.conf.in" rel=3D"noreferrer" t=
arget=3D"_blank">doxy-api.conf.in</a><br>
&gt; +++ b/doc/api/<a href=3D"http://doxy-api.conf.in" rel=3D"noreferrer" t=
arget=3D"_blank">doxy-api.conf.in</a><br>
&gt; @@ -24,6 +24,7 @@ INPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D @TOPDIR@/doc/api/doxy-api-index.md \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/net/intel/ixgbe \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/net/mlx5 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/net/softnic \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/raw/cnxk_bphy \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/raw/dpaa2_cmdif \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/drivers/raw/ifpga \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @TOPDIR@/lib/eal/include \<br>
&gt; diff --git a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h b/drivers/raw/cnxk_b=
phy/rte_pmd_bphy.h<br>
&gt; index f668e6ea82..99504dc496 100644<br>
&gt; --- a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h<br>
&gt; +++ b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h<br>
&gt; @@ -174,6 +174,7 @@ enum cnxk_bphy_cgx_eth_link_mode {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__CNXK_BPHY_CGX_ETH_LINK_MODE_MAX<br>
&gt;=C2=A0 };<br>
&gt; <br>
&gt; +/** Available CPRI modes */<br>
&gt;=C2=A0 enum cnxk_bphy_cgx_eth_mode_cpri {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** 2.4G Lane Rate */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CNXK_BPHY_CGX_ETH_MODE_CPRI_2_4G_BIT,<br>
&gt; @@ -191,6 +192,7 @@ enum cnxk_bphy_cgx_eth_mode_cpri {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CNXK_BPHY_CGX_ETH_MODE_CPRI_24_3G_BIT,<br>
&gt;=C2=A0 };<br>
&gt; <br>
&gt; +/** Available mode groups */<br>
&gt;=C2=A0 enum cnxk_bphy_cgx_mode_group {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** ETH group */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CNXK_BPHY_CGX_MODE_GROUP_ETH,<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000004acb64065b6a2541--
