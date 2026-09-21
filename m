Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A14C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 14:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A3BB4067D;
	Mon, 21 Sep 2026 16:43:17 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id E90BF4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 16:43:15 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-672b164bdaeso14239d50.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790001795; x=1790606595;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9eAs78/SSBp/r+3gAJmwKahf5OKHBMmHQao8JZMElI=;
 b=Q6CFLg5FAFX3+Gi1BcPHZKW+/43StnhliQjOI5woJRPS9QTOxm+FFjVXCy9hLWlO/0
 Yi188qXhnfhrKEzl1N/kqyP5WHQ0f/ldQDvIBze+f1kx9pDVNOKpSGVGK1OdEfCnvQ8i
 ht1IpMm9zfqsVSFviZW0V2eLGKkDTevfNN0gOzQJo8ovvcLMKQazr2gi2PIn/MWFo9mt
 1dXjYXQBmq95qEY8jDTOSHEyIvSUXcvuTuD40LmJ/8hm7k1t2izEmSR9y+n45WDdQOQM
 eG649iTLPXBFmfbcyKbtKgjh4eNohKyu7iokY3fm1Np+xXEoKzz/Ibf7e50R6fzJAy65
 P1jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBze1pecMsCyAuIO5CP9E7HTcxdKKGOQ6rqcDewy0lKPN+oYI4QyqCps3O5Xm1HGFSqHERw=@dpdk.org
X-Gm-Message-State: AFuF++miEtHoIvWKNJFkKD9Dv0KTdVoStIjdX9YZIvne5VnQrAhbmH7C
 +XkQ1y50pLXlR8NQrnCxQ84YqiulzWPRZdjt/F9UMzF4Czrmp1fw09VbOmgmCKV9U3+MhLxCxik
 Tgy27HR8ksIHW/S1mCaQMd/KEQJnATxxfDN1KqXDUjb6rFBLACy1convSTYw9oql78KAzsGGWjw
 FyYI7FjXPKvd056mogALigDib0L2piNfzcPpCtJVrijpTGactfE3f8kQ2miXON9ksKMedLv4VeK
 y0Apw==
X-Gm-Gg: AYBFou1UgUpEH+sF808l07RuBnMAVHJ0dkBplx2iW5GaKGY1kbvmhK8Mgujc1S0fAdU
 /K8T1Ycq6QDo3byAOOq6fKCSaQrlPgF7EAsB5zYXkHF6vnkoisW1D2iApwFD4JD22NzUT9YOujJ
 I1JBTCS72VzUFAIQpqGjIanj2JpZwa8dr4dpMC7N9autg2gxFDMw36Fykj3ics4DL3SFvcy1of4
 3LUZddGO3BiF2/hT5s+Qs3UnJv+oluHKRJF0rpRLRgoPW8uBQEFWnqq6T2i348geeeCzLjrj8W1
 1ZcSB8o8jvF57ov24gb3gZcJsrkPHI1mrXHej7IiiuN0EqETZuAlPhQfJjFJOQ3+EuMu8dA21RS
 kF9yUYh+bV7RAgylhWHTunB+IgdEomgA6YX4UVs3zuFL+PKKW8jHCTJdY+IoJcEU/kIgtjQabKl
 bgR0A8HkYjidyMlh3YlP1oU/4PRIzo8xpGjehMNZ80Gv4=
X-Received: by 2002:a05:690e:4812:b0:671:1912:2c77 with SMTP id
 956f58d0204a3-6717fcb4af0mr1845980d50.16.1790001795013; 
 Mon, 21 Sep 2026 07:43:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6729902d596sm163230d50.5.2026.09.21.07.43.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:43:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a9a19c8bdbso4982961a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790001793; x=1790606593; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r9eAs78/SSBp/r+3gAJmwKahf5OKHBMmHQao8JZMElI=;
 b=b94BOCXmJ/tXn8De/erWKqYJrCnC7fSlBHGPWyBUtknMDdwHfoEdB4p0LyPE1LyC1a
 gE79l5ijJCa7oATnpk3HvkKk25X9j9tOIPRP1953DPosCxM3wWQz8kdJv4t3quaMnqZq
 t6KjX0FL8pJkSwDCJvWXX885fIZOTY3TAPN28=
X-Forwarded-Encrypted: i=1;
 AKwUvBwnsvz/mAnqFHC5rXjvXOo0r1i2qdyr4hjPDo2liDhRdm0ATDdH5WaS/OcA2QEJuWjMyBA=@dpdk.org
X-Received: by 2002:a05:6402:2386:b0:6a9:8c23:e0c0 with SMTP id
 4fb4d7f45d1cf-6aa36e44e33mr8158188a12.19.1790001793367; 
 Mon, 21 Sep 2026 07:43:13 -0700 (PDT)
X-Received: by 2002:a05:6402:2386:b0:6a9:8c23:e0c0 with SMTP id
 4fb4d7f45d1cf-6aa36e44e33mr8158166a12.19.1790001792876; Mon, 21 Sep 2026
 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260915104005.467027-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915104005.467027-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 10:42:54 -0400
X-Gm-Features: AcwNN1XXR3_YuQB3B88UbFLHh1PDTaJ6JlOJyG2h5Gz4vUecMHaTnqUfST2_cYk
Message-ID: <CA+BST0mxP6NY_ZdyErXXynpyARM0zfJGN5V5u5q1Rf7ee-=Z9g@mail.gmail.com>
Subject: Re: [PATCH] Adding the return values checking
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000000ed511065bff45a8"
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

--0000000000000ed511065bff45a8
Content-Type: multipart/alternative; boundary="0000000000000349af065bff45e8"

--0000000000000349af065bff45e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:40=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> ---
>  drivers/net/bnxt/bnxt_ethdev.c          | 29 +++++++++++++++++--------
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c  |  2 ++
>  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c |  2 +-
>  3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index 8e8ead8f61..c99c375412 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -6395,57 +6395,68 @@ bnxt_parse_dev_args(struct bnxt *bp, struct
> rte_devargs *devargs)
>         if (ret)
>                 goto err;
>
> -err:
>         /*
>          * Handler for "mpc" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,mpc=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
>                            bnxt_parse_devarg_mpc, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "app-id" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,app-id=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
>                            bnxt_parse_devarg_app_id, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "ieee-1588" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,ieee-1588=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
>                            bnxt_parse_devarg_ieee_1588, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "cqe-mode" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,cqe-mode=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
>                            bnxt_parse_devarg_cqe_mode, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "representor" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,representor=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
>                            bnxt_parse_devarg_representor_mode, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "scalar-mode" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,scalar-mode=3D1"
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
>                            bnxt_parse_devarg_scalar_mode, bp);
> +       if (ret)
> +               goto err;
>
>         /*
>          * Handler for "app-instance-id" devarg.
>          * Invoked as for ex: "-a 000:00:0d.0,app-instance-id=3D1"
>          * This argument is required for enabling truflow hot upgrade
> feature.
>          */
> -       rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
> +       ret =3D rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
>                            bnxt_parse_devarg_app_instance_id, bp);
> -
> +err:
>         rte_kvargs_free(kvlist);
>         return ret;
>  }
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> index fa98b2bca9..facce8f125 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> @@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
>                 return;
>
>         rc =3D bnxt_ulp_cntxt_tsid_get(bp->ulp_ctx, &tsid);
> +       if (rc)
> +               return;
>
>         rc =3D bnxt_ulp_cntxt_fid_get(bp->ulp_ctx, &fid);
>         if (rc)
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
> b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
> index f17fb6e3b2..075071620f 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
> @@ -404,7 +404,7 @@ ulp_mapper_tf_em_tbl_process(struct
> bnxt_ulp_mapper_parms *parms,
>                                 BNXT_DRV_DBG(DEBUG,
>                                              "Fail to insert EM, shall ad=
d
> to wc\n");
>                         }
> -                       ulp_regfile_write(parms->regfile, tbl->tbl_operan=
d,
> +                       rc =3D ulp_regfile_write(parms->regfile,
> tbl->tbl_operand,
>                                           tfp_cpu_to_be_64(val));
>
The return code needs to be handled, cannot overload this to rc.

>                 }
>                 if (rc)
> --
> 2.47.3
>
>

--0000000000000349af065bff45e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 6:40=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 29=
 +++++++++++++++++--------<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c=C2=A0 |=C2=A0 2 ++<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c |=C2=A0 2 +-<br>
=C2=A03 files changed, 23 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index 8e8ead8f61..c99c375412 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -6395,57 +6395,68 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_dev=
args *devargs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
<br>
-err:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;mpc&quot; devarg.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,mpc=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
MPC,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_mpc, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;app-id&quot; devarg.<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,app-id=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
APP_ID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_app_id, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;ieee-1588&quot; devar=
g.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,ieee-1588=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_158=
8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
IEEE_1588,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_ieee_1588, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;cqe-mode&quot; devarg=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,cqe-mode=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
CQE_MODE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_cqe_mode, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;representor&quot; dev=
arg.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,representor=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESEN=
TOR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
REPRESENTOR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_representor_mode, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;scalar-mode&quot; dev=
arg.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,scalar-mode=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_M=
ODE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARG_=
SCALAR_MODE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_scalar_mode, bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handler for &quot;app-instance-id&quot;=
 devarg.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invoked as for ex: &quot;-a 000:00:0d.0=
,app-instance-id=3D1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This argument is required for enabling =
truflow hot upgrade feature.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST=
_ID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_kvargs_process(kvlist, BNXT_DEVARD_=
APP_INST_ID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bnxt_parse_devarg_app_instance_id, bp);<br>
-<br>
+err:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_kvargs_free(kvlist);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_u=
lp/bnxt_ulp_tfc.c<br>
index fa98b2bca9..facce8f125 100644<br>
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c<br>
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c<br>
@@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_ulp_cntxt_tsid_get(bp-&gt;ulp_ctx, =
&amp;tsid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_ulp_cntxt_fid_get(bp-&gt;ulp_ctx, &=
amp;fid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_=
ulp/ulp_mapper_tf.c<br>
index f17fb6e3b2..075071620f 100644<br>
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c<br>
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c<br>
@@ -404,7 +404,7 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_par=
ms *parms,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(DEBUG,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;Fail to insert EM, shall add to wc\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ulp_regfile_write(parms-&gt;regfile, tbl-&gt;tbl_operand,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D ulp_regfile_write(parms-&gt;regfile, tbl-&gt;tbl_operand,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
fp_cpu_to_be_64(val));<br></blockquote><div>The return code needs to be han=
dled, cannot overload this to rc.</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--0000000000000349af065bff45e8--

--0000000000000ed511065bff45a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCDaNhP+7z16vt16QYjRuPBnhXb164003eoKooiQX69Z7TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExNDQzMTNaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAO/3TZJY2F
ifFw5konwnearVa6bPSiAIFkf2T7WhLniE7xiTerDQc2Yp1SkREHkvVB3neeBu5JPaoT8IVtEAEl
hYfglA4tfOTMJutFWpMTkfP7M4Z/Ennxykn8T5FuOB3BradUHjNFe3xUxkoyXxFuQYJeDbLHDtPy
5ezjG38Umep+aqyazv5UAhGdIsqDBHeh7wdsI5EOOXfuT7Xqn4QCAjHdpwJ8EuZHvSugrXZYLrlt
SUtmQ0z6idC5zNOzaELzjkiVuYpBzYbSJ9IAdljOBY3RZJy8qyXuHmRCAY/D+j2qOxYPG7Igiv9i
47jVTdZJhXIfPgh1WTmtfgW9Lica
--0000000000000ed511065bff45a8--
