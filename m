Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E0C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C0AD41156;
	Mon, 21 Sep 2026 18:37:30 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 0324140E50
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:37:27 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so4570a12.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008647; x=1790613447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tmIUOQc7vzTvWqFIbDHSOrGGKTdJ+jpXgGshUHxi78=;
 b=jv9hNAA3RWxgi4HWQQzZYsZQFFqUe0szsqOvOCoCKnCHngjoV2GUfCgalHKY6+BeCi
 ac4rOAc2JYr/EIBTheaSVnj1f2d+2IHAibvqUj9BYfOsU+StZhXQnYehARgz8XhFvmID
 I9F2U7W0SvWzEmMYzq/2SMUVv7LGSZ1qjlKf7FVyoD1lwk5/vC2GO8wlnEt9JwanwwGH
 g7wtP3HXS80NO0rMAFFCOZBNzmAw6D44UkWiQX65BTAOY8M2vheYL9koKA23esNKYIZT
 4/ktnhnlHUlr4EZe3/9DsGQ+X7VO43QSD1m+PAF5SCxMMAJmA4WfxbPr3L1V9cXjN0jO
 7dDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxpplXjqiGaK/3OTVd4GVvmKI4Z5MKdDNEOT9dGX54zbpDk1zx2Fb4UcJn1UDnvPv710k=@dpdk.org
X-Gm-Message-State: AFuF++n+kBHwdi9fkEfm7X0zv7Nxcz++wPm/t0ZfGptB7Zepwnr5tttb
 wR69v34HxpPCQA6HREp1b623szIMIsD0OKhULPeBAb8CMAk4eGdaSNK6ybTEe5zWv4kjMj1kDv7
 2eFjDARHMZ8MnQTrjzr2P05uYayib1MAAPpwm/2Bfypg3MyGxBa1qoAsO7nYeGUbt6pyV5vArBK
 /BST3lfH/TNUSUg28UiYD5rsl+dvqsdPOES46ZdXTxuZiJA2kpqMeBawdMO1x6tG3VJrJo/KKdz
 AQcIA==
X-Gm-Gg: AYBFou0XpHomZ08D+OetvVvAjYphrsuqAmUOOtrTsX+cnq6RVf8DYhfJg+pAl2BZn8v
 So/Xf5ERfLvfTlZ9DBUzshfzFhxXPbcXz7iB7YePzG9IXlyJcZxdNs8wDkMGa6bgAmzfFfaIAcu
 x6ifJMQME6/gFwF1QeZYt8Wr4XwWrsauV1WYEijwtkSZEzdlWPFyy1DfrXn41OCX9FNm+TvbvNe
 yT1fPkL/mpYUq2MRyT0iVSI0lKQaA9YUxzMxIBsTlM9+8qEixdatAOC+heIenTUj20IW5VPz1Dx
 C02cnFfAH7XT50QQx6YgFjt2I4kF6VOI0VyK0XYsnZEfAO6nvtnzG1tEy/B3m+6abel6kB9kVxA
 jFLDMpVbIL/+UEKvp2WVs/Ivt071CitMEg079lLIjFckT6qd1/9hmEg0YxHfym/KnOE26hI23Gg
 02Z7snEp1RE15K0VioPHnz5IlPd8PIPlkqfrPAdkV61o0=
X-Received: by 2002:a05:6a21:6e92:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3dd8c151addmr17678480637.0.1790008646466; 
 Mon, 21 Sep 2026 09:37:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72aea3ca8sm3943016a12.4.2026.09.21.09.37.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 09:37:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a91d818528so3799523a12.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790008644; x=1790613444; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8tmIUOQc7vzTvWqFIbDHSOrGGKTdJ+jpXgGshUHxi78=;
 b=YncR5oZnf1Mp12XH1lTs9o5BdIcj0Aa4XhuIjRGSyTZjphlnQykqqFFNkHVyFwIJoK
 fEC9LdTs/o5oq8Va6+usv3a0ivR5teQnYQRUFHEJtOusk1xKq4MyFGOPNfpuEGK/ALOp
 tlMdxIfp/IF+gkZGIVYuLmBa7fobF6TrpcPEI=
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ11nqa9ZBde+w8HrbQAYpaaHjsaS4ErKqvhDUbtrZl9U5EFj/6i4KcyafDF/zGvXRcqU=@dpdk.org
X-Received: by 2002:a05:6402:455c:b0:6a7:f25b:d281 with SMTP id
 4fb4d7f45d1cf-6aa564eb522mr7903249a12.13.1790008644584; 
 Mon, 21 Sep 2026 09:37:24 -0700 (PDT)
X-Received: by 2002:a05:6402:455c:b0:6a7:f25b:d281 with SMTP id
 4fb4d7f45d1cf-6aa564eb522mr7903228a12.13.1790008644078; Mon, 21 Sep 2026
 09:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260915084850.430813-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915084850.430813-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 12:37:06 -0400
X-Gm-Features: AcwNN1W6IsBphhbRxO_a29pFTXLdrMJ5F1a_2nVpcQZX619PhD6zwcvTt5AShnc
Message-ID: <CA+BST0kA6V0jyK2SoaabbPeBM3y12r70-Rie42nSjTu-hhfGsw@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: fix channel disable bitmap handling
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>, Farah Smith <farah.smith@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Peter Spreadborough <peter.spreadborough@broadcom.com>, dev@dpdk.org,
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000006bce03065c00ddc0"
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

--0000000000006bce03065c00ddc0
Content-Type: multipart/alternative; boundary="0000000000006034b9065c00dd07"

--0000000000006034b9065c00dd07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:48=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> The MPC channel enable bitmap is cleared before it is used to build
> the channel mask. As a result, no channels are selected for disable.
>
> Preserve the bitmap before clearing it and use the saved value when
> building the channel mask.
>
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.or=
g)
> with SVACE.
>
> Fixes: 80317ff6adf ("net/bnxt/tf_core: support Thor2")
> Cc: stable@dpdk.org
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>


>  drivers/net/bnxt/bnxt_mpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
> index d77f9dd308..1398321ca7 100644
> --- a/drivers/net/bnxt/bnxt_mpc.c
> +++ b/drivers/net/bnxt/bnxt_mpc.c
> @@ -48,18 +48,20 @@ static int bnxt_mpc_chnls_enable(struct bnxt *bp)
>  static int bnxt_mpc_chnls_disable(struct bnxt *bp)
>  {
>         struct bnxt_mpc *mpc =3D bp->mpc;
> +       uint8_t mpc_chnl_flg;
>         uint8_t mpc_chnl_msk =3D 0;
>         int i, rc;
>
>         if (!mpc)
>                 return -EINVAL;
> +       mpc_chnl_flg =3D mpc->mpc_chnls_en;
>         mpc->mpc_chnls_en =3D 0;
>
>         if (!BNXT_PF(bp))
>                 return 0;
>
>         for (i =3D 0; i < BNXT_MPC_CHNL_MAX; i++) {
> -               if (!(mpc->mpc_chnls_en & (1 << i)))
> +               if (!(mpc_chnl_flg & (1 << i)))
>                         continue;
>                 mpc_chnl_msk |=3D (1 << i);
>         }
> --
> 2.30.2
>
>

--0000000000006034b9065c00dd07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 4:48=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov@inf=
otecs.ru</a>&gt;<br>
<br>
The MPC channel enable bitmap is cleared before it is used to build<br>
the channel mask. As a result, no channels are selected for disable.<br>
<br>
Preserve the bitmap before clearing it and use the saved value when<br>
building the channel mask.<br>
<br>
Found by InfoTeCS on behalf of Linux Verification Center (<a href=3D"http:/=
/linuxtesting.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a=
>) with SVACE.<br>
<br>
Fixes: 80317ff6adf (&quot;net/bnxt/tf_core: support Thor2&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
---<br></blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;=
background-color:transparent">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
=C2=A0drivers/net/bnxt/bnxt_mpc.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c<br>
index d77f9dd308..1398321ca7 100644<br>
--- a/drivers/net/bnxt/bnxt_mpc.c<br>
+++ b/drivers/net/bnxt/bnxt_mpc.c<br>
@@ -48,18 +48,20 @@ static int bnxt_mpc_chnls_enable(struct bnxt *bp)<br>
=C2=A0static int bnxt_mpc_chnls_disable(struct bnxt *bp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bnxt_mpc *mpc =3D bp-&gt;mpc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t mpc_chnl_flg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t mpc_chnl_msk =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, rc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mpc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mpc_chnl_flg =3D mpc-&gt;mpc_chnls_en;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mpc-&gt;mpc_chnls_en =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!BNXT_PF(bp))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; BNXT_MPC_CHNL_MAX; i++) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(mpc-&gt;mpc_c=
hnls_en &amp; (1 &lt;&lt; i)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(mpc_chnl_flg =
&amp; (1 &lt;&lt; i)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mpc_chnl_msk |=3D (=
1 &lt;&lt; i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div></div>

--0000000000006034b9065c00dd07--

--0000000000006bce03065c00ddc0
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDF9KafjddI/zzHdQQ3Avwtid6m2K7oI0JhIuVQ7dbohDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExNjM3MjRaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBcWZHV2dx4
fe6TR0sK9+u7UGPqfbjycn6lfzUPEcVQaXkI9xfgzqt1R1EGvE6U/aSVzmv/WRsWJ238auHd5RPr
mOEBru3tEWumwhPKxF8N+xd3d5/sYtiohSBzT0IN6K3+GNqMKfd4izhtbvjtAUAah5RMRxBJuwsF
nMRJcTOI7HC+IyJ94mWPp1UrRaxLJN7k6XxmoKevOk44Ifj+bZAzeTET/X2TehMki6k6SDjWJBo7
MFvKw2ej/xFIKF1l2HqRP+Eov2im8QtJGdXX6U7kmlF37q3G2leXoFX+7vZuR9JHkxy/DIX1QEyj
UqSORGfGzCNl86dZdgEAUJMgmGDO
--0000000000006bce03065c00ddc0--
