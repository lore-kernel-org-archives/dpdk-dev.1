Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B3CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 599CA4066E;
	Thu,  4 Jun 2026 19:42:31 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id A483040654
 for <dev@dpdk.org>; Thu,  4 Jun 2026 19:42:29 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso7741975ad.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780594949; x=1781199749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shIhm3p+zPze67J5D55S+rSZkMAXm84UvX8Ijh8FuSo=;
 b=sWd9EjPr4dtDTl/XCv3bdocTWKz6N1ArcfSG2pOCIPoJaj1UCZ+aGjmv+bXPKVuYd8
 98WuB2mPCYiP/VmjN84ELY/ra1j1+yMGjCdUui6k46YwXFL8umMnQK1CF05frhrIlL+6
 axIKVm6zW7WHXs6Jz4PL/yBA5Azqa1Bqa64EZNYt6FVRfg1OdnPtz16IaLbrz9PhU6N5
 yVLUlS2J/JeyB9+bni/zSK8444KQUIegjj+lejiwp50rZFnqe/Ju2CUPTs+ahwHIxAcF
 m0U/HlTi2GOdZXcvOrBXWHsIP3+kMtNglnJsBnVHkAd6wGbLADTcjY8yxzvRqNDQipkS
 LVJQ==
X-Gm-Message-State: AOJu0Yx5qKXTF4jiWJpJ8XxjbXGO7Viv5bzyctSCS4cAOSpbgAwfW10u
 qgdAKjFb52KE2iN+BhhQIzgjOvPZKAO62fDiCikrKqvdZoM2G8UxTUexBztboHos/N5li2GMk0J
 KxOk3s2ZiwTpj+TZj8QVeiiB5ejox8yk/Bh4TlU2W6bV+kiH/uQ3UemR1b6jBRcho3M1ZqOpPNn
 u8MtPtAmZXkYxZ/YDLOjtPNuR7E+kSrEA5HoNCQG1yFvYKiuYj3541+Bz9NRu2W0ccOM+IO20vw
 xc7YA==
X-Gm-Gg: Acq92OHr6GXgMCeU+cfOodx7EdyD4vFFGowjtFJayC3Cu+yEkXFQsWfEzE/Ib618/2n
 B64rtVmJCEuY44mFXd/83QaDaO+eG+8G1vj02GCU6CdZ+1ag4G36+MafCrEIpDNupzyaKH27VV7
 3SG66G/tQFoBh+yfvV6nmNF4NI3nX1WaMoNFfatLEd9RjUPjOhO357gEStk0RTMFnXg0uNFMglL
 /wuLXzP+MdIxYYB9KgX+/EE3zH90zvWoDv0Wx2S2s73mNSb+aWF/TMtd4/giQ7VOE0SaKQ6nUyZ
 ag3k2d0mxIDQ5R4FSBYlIjeSZgkfr4znwjYTkPrSL0Eh4RhSSkON18/A+a6WZBrbFkgPFO621A0
 HVrFdLOkf8ab8XcPAc0HIAccddaIsET3tLChUDLXG7JFk/PoJiuevVjNpVOvUVRxaL+3TsZEGJ7
 SenBNGQ5WDyoQ6E+ynhhPZ0hswZBMf9Jv7IQH6ZAC8KJ89neGyGLxRT7s92CHaasjGFI08QxCNk
 CM=
X-Received: by 2002:a17:902:fc8e:b0:2bf:2188:a915 with SMTP id
 d9443c01a7336-2c1644d5a42mr101345855ad.39.1780594948506; 
 Thu, 04 Jun 2026 10:42:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c165f9fe79sm5959075ad.26.2026.06.04.10.42.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 10:42:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ab3f6e55so6084785e9.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780594946; x=1781199746; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=shIhm3p+zPze67J5D55S+rSZkMAXm84UvX8Ijh8FuSo=;
 b=I1E8iLHb2VAPO37BoJ9xayoSK6CPkmfvGDA9xjyM788Jg6/Hmb3UhyZiyN9I9ZhHSc
 bd/R39ZRhBqrVJlBor3nSJ0QOtGLv+kY1hdHzh2VPs37uv5AD+LKroTDkfoXcAytqnnl
 wyjT4WDdfIud0S2YT5kmF1ojXNJNoMvxIASQs=
X-Received: by 2002:a05:600c:4410:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-490b5ec4263mr97365145e9.25.1780594946585; 
 Thu, 04 Jun 2026 10:42:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4410:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-490b5ec4263mr97364965e9.25.1780594946236; Thu, 04 Jun 2026
 10:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603175137.1990204-5-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260603175137.1990204-5-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 4 Jun 2026 13:42:10 -0400
X-Gm-Features: AVVi8Ce_U0lheuRvfA7CYJAI5vOjkGlLt_I9YzPG1-sBIHq9Ezs1zrOdhpvlQoE
Message-ID: <CA+BST0kPG_uvyv3H9gkTU66Oy6PZKk8W6nmy3d9bZ2sgLc55KA@mail.gmail.com>
Subject: Re: [PATCH 4/4] net/bnxt: fix RSS hash mode configuration for VFs
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000004cef900653711198"
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

--0000000000004cef900653711198
Content-Type: multipart/alternative; boundary="000000000000427c910653711143"

--000000000000427c910653711143
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:50=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> Fixed VFs attempting global RSS configuration which is not
> permitted by firmware. VFs (including trusted VFs) must use
> per-VNIC RSS configuration with actual vnic_id and rss_ctx_idx
> values.
>
> Cc: stable@dpdk.org
> Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_hwrm.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
> index 0c82935de9..afc948ac29 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/bnxt/bnxt_hwrm.c
> @@ -2970,8 +2970,22 @@ bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(struct bnxt
> *bp, struct bnxt_vnic_info *vnic
>                 req.hash_mode_flags =3D BNXT_HASH_MODE_INNERMOST;
>         else
>                 req.hash_mode_flags =3D vnic->hash_mode;
> -       req.vnic_id =3D rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
> -       req.rss_ctx_idx =3D rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
> +
> +       /* VFs must use actual vnic_id for per-VNIC configuration.
> +        * PFs can use INVALID vnic_id for global configuration.
> +        * This is because VFs don't have permission to configure
> +        * global hash mode, even if they're trusted.
> +        */
> +       if (BNXT_VF(bp)) {
> +               req.vnic_id =3D rte_cpu_to_le_16(vnic->fw_vnic_id);
> +               req.rss_ctx_idx =3D rte_cpu_to_le_16(vnic->fw_grp_ids[0])=
;
> +               PMD_DRV_LOG_LINE(DEBUG, "VF using per-VNIC RSS config
> (vnic_id=3D%u)",
> +                               vnic->fw_vnic_id);
> +       } else {
> +               req.vnic_id =3D rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALI=
D);
> +               req.rss_ctx_idx =3D
> rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
> +               PMD_DRV_LOG_LINE(DEBUG, "PF using global RSS config");
> +       }
>
>         PMD_DRV_LOG_LINE(DEBUG, "RSS CFG: Hash level %d",
> req.hash_mode_flags);
>         rc =3D bnxt_hwrm_send_message(bp, &req, sizeof(req),
> --
> 2.47.3
>
>

--000000000000427c910653711143
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, =
2026 at 1:50=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broad=
com.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt;<br>
<br>
Fixed VFs attempting global RSS configuration which is not<br>
permitted by firmware. VFs (including trusted VFs) must use<br>
per-VNIC RSS configuration with actual vnic_id and rss_ctx_idx<br>
values.<br>
<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab=
.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.=
com</a>&gt;<br>
</blockquote><div><span style=3D"font-family:Calibri,sans-serif;font-size:1=
1pt">Acked-by:</span><span style=3D"font-family:Calibri,sans-serif;font-siz=
e:11pt">=C2=A0 </span><span style=3D"font-family:Calibri,sans-serif;font-si=
ze:11pt">Kishore
Padmanabha &lt;</span><a href=3D"mailto:kishore.padmanabha@broadcom.com" st=
yle=3D"font-family:Calibri,sans-serif;font-size:11pt;color:rgb(5,99,193)">k=
ishore.padmanabha@broadcom.com</a><span style=3D"font-family:Calibri,sans-s=
erif;font-size:11pt">&gt;</span>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">---<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c | 18 ++++++++++++++++--<br>
=C2=A01 file changed, 16 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c<br=
>
index 0c82935de9..afc948ac29 100644<br>
--- a/drivers/net/bnxt/bnxt_hwrm.c<br>
+++ b/drivers/net/bnxt/bnxt_hwrm.c<br>
@@ -2970,8 +2970,22 @@ bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(struct bnxt *bp,=
 struct bnxt_vnic_info *vnic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req.hash_mode_flags=
 =3D BNXT_HASH_MODE_INNERMOST;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req.hash_mode_flags=
 =3D vnic-&gt;hash_mode;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0req.vnic_id =3D rte_cpu_to_le_16(BNXT_DFLT_VNIC=
_ID_INVALID);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0req.rss_ctx_idx =3D rte_cpu_to_le_16(BNXT_RSS_C=
TX_IDX_INVALID);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* VFs must use actual vnic_id for per-VNIC con=
figuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * PFs can use INVALID vnic_id for global confi=
guration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This is because VFs don&#39;t have permissio=
n to configure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * global hash mode, even if they&#39;re truste=
d.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (BNXT_VF(bp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req.vnic_id =3D rte=
_cpu_to_le_16(vnic-&gt;fw_vnic_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req.rss_ctx_idx =3D=
 rte_cpu_to_le_16(vnic-&gt;fw_grp_ids[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG_LINE(DE=
BUG, &quot;VF using per-VNIC RSS config (vnic_id=3D%u)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnic-&gt;fw_vnic_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req.vnic_id =3D rte=
_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req.rss_ctx_idx =3D=
 rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG_LINE(DE=
BUG, &quot;PF using global RSS config&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PMD_DRV_LOG_LINE(DEBUG, &quot;RSS CFG: Hash lev=
el %d&quot;, req.hash_mode_flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_hwrm_send_message(bp, &amp;req, siz=
eof(req),<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--000000000000427c910653711143--

--0000000000004cef900653711198
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
oIHHMC8GCSqGSIb3DQEJBDEiBCB0kRdMi255BcJoQe6y4uuorwB2omK5VnayziDv58bRuTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MDQxNzQyMjZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1Dvb/1iCO
h09fP9PnPY9XEqZbWHOF9nzT1ZTWQvJa9JsEIBz0lWY7X6vTbwveLMXzks/wMhxYm45kz0M0fU1/
4MdmUZLowq1hgx6GO26HLp5iuAFn/vIVWWUtIsskZn2Yae4CWFWbXC3Lmj7brE1uCyjEl0R5NETG
ZWE9fbZXm5pDICnRRxeUH4gbhLD0bZOKlZQaAiUVTcLR71GTasvX38H140f491W3KgGWogpNti0b
XIvKmWKEdNg1Mepb4XqVFXGPPj1fqp7/zne6RIV4LzZHCE1udAHRPMwtJzCH4BmJXtY5uZGe9scA
zElmEDW4QnjEPLhJzDjUjzM62PRo
--0000000000004cef900653711198--
