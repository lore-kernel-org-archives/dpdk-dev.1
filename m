Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C8DCD6E74
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E860402D3;
	Thu,  4 Jun 2026 19:41:51 +0200 (CEST)
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com
 [209.85.217.98]) by mails.dpdk.org (Postfix) with ESMTP id 4A2244028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 19:41:50 +0200 (CEST)
Received: by mail-vs1-f98.google.com with SMTP id
 ada2fe7eead31-6c28e1511adso605515137.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780594909; x=1781199709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ReWKgB/zICeMG5eCmifVGW+lOiMmKhQWM9HtQ+toEY=;
 b=AP6uY45F18Dm2QeNDhpA30PeTNsqqd/T9T6lkXHi2shKXu5DWsbyQH4o1VNNO/dJEw
 3+wSVigDfGEmWKV+8K6x5vcHaAHQN7XHjBGHhvrQih80TPDNlje4tVaqmtN2yGmFTIS4
 lGQNgzLE24ZfZFoxJMepK1nxF6H8urtqRGehde6Y8F/v6ft+Hi3d4KtlKyTCItp0J7js
 sd3fYUMOEMV9wEpRpS8ECuc9eCkkPFdOn7l8l/yXPC7aYAjZJOpGBKz44WmkFK5YKRCm
 5dfIoTpqjklhrzThJo1GSwLQpxLLCbUGfKHON83nMW8jmVdRfqxv3uqXLd1LKl20mRMb
 oroQ==
X-Gm-Message-State: AOJu0YzvJnXhsIrHGvGEsNZTLCbebPw4yzatOKFAfy8UaeHyHuvY9c+N
 9C7x40+atLUvYJwNazdtaS+lzgKh1n4g983SrVkiw8ph6Pwma9c5cLlqq131eG3OqrQQXq7FROt
 pkJkkJ6JlK8T6+40V9PmoAIogTv5e74D9hAqlbV0wQZ6R/Mf+hVUHKl3JoWUw0cqKyevfXZzGxz
 LJqHndNT+50uD8HZ9eah24u1WjPaUVOuSJZdlG92hPNaqbmf/SBrXYbAuGGXV5GhtPzaNDfdXae
 ETAIg==
X-Gm-Gg: Acq92OHVZRD1ETsUBqxeo7vOvNMStnD6D97hcDu/wk83qlOO5bqOgDp0B1nADYTbTpO
 rf/pMDtzUWytFbgg1QHu0NOJmFiYhRe2EBD8trHmdqIDUUnvfQMZwaZVlWCWMcGI2jezpEJvtff
 YmJIZiNzAAuvPzyDVzM4hB3XsJvRoIzlXtVI57tnwPdmR86PXce2QrvVlPZkWU7oftTeVH6iPJs
 3rtcYQzo69PR/370Vi+wfPapHNPWfhzECrKbd2FOq+GmuHIVrEmFYo76u3ltmi+0tSUJigwFoo3
 0giXslZpgCaTY6lx2vzjJCKH6bM+4ITim2l9PWlbrIHa0JG4uCZbPUXmdCFHjtt1dLyAEa91nek
 3r649NqeJmjY16ekqANKGG6KEMyZNqToNhZUSLt8odZKsxq/sV9i00asShlt1ot/WcAZm1cD1vj
 qVotPrQ+iG+pGPWE/hCgyjlMJlCf9io+Wro0wVIowWHVX3NP3VcYPqRwq8s56gcqFvxMKdACewq
 Z4=
X-Received: by 2002:a05:6102:6b09:b0:636:46ee:2f10 with SMTP id
 ada2fe7eead31-6ec57a842bcmr5802662137.9.1780594909316; 
 Thu, 04 Jun 2026 10:41:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6eb662a89e7sm446099137.24.2026.06.04.10.41.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 10:41:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so7123855e9.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780594908; x=1781199708; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ReWKgB/zICeMG5eCmifVGW+lOiMmKhQWM9HtQ+toEY=;
 b=g5NhHJIz5w0qS419rLNrtIuEFsIZcea2ln1B10RFE7XiAd3vRBYt2JS1dvoMbrThr2
 2HYcy5MK9e1RkB3M6CC1O95Log/uBuuI054hCVqBuBQIgG9yWwfS3ukHBHCQPcdKek9P
 HsfSYBl3NvanTiHnLU0t+I70vh7YD7VRufgQ0=
X-Received: by 2002:a05:600c:1d86:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-490b5fe95ebmr147114115e9.19.1780594907932; 
 Thu, 04 Jun 2026 10:41:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-490b5fe95ebmr147113715e9.19.1780594907469; Thu, 04 Jun 2026
 10:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603175137.1990204-3-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260603175137.1990204-3-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 4 Jun 2026 13:41:28 -0400
X-Gm-Features: AVVi8Cd_3K_WTFdx7anX6t9zuBH3V9ceEL7mqovVZhBVAqZcNtzCMwquSjD0Ytg
Message-ID: <CA+BST0mENUPRfSjg=BAYQp_B57q2=VK0N7BN6AYznojMUOTwDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bnxt: fix QP resource count in backing store
 config
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000fe3e2a0653710e49"
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

--000000000000fe3e2a0653710e49
Content-Type: multipart/alternative; boundary="000000000000f2f9cf0653710e16"

--000000000000f2f9cf0653710e16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:49=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Ajit Khaparde <ajit.khaparde@broadcom.com>
>
> The driver is not passing the QP1 count while
> configuring backing store for QP type.
> This can result in a smaller set of entries allocated by the
> driver with the firmware.
>
> The number of entries is provided by the firmware as a
> part of backing store qcaps v2 HWRM command.
>
> Fixes: 5b5d398434f9 ("net/bnxt: add support for backing store v2")
> Cc: stable@dpdk.org
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index b677f9491d..7d70d0f3ec 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -5404,11 +5404,11 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
>                         if (ctxm->type =3D=3D
> HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CQ)
>                                 entries =3D ctxm->cq_l2_entries;
>                         else if (ctxm->type =3D=3D
> HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_QP)
> -                               entries =3D ctxm->qp_l2_entries;
> +                               entries =3D ctxm->qp_l2_entries +
> ctxm->qp_qp1_entries;
>                         else if (ctxm->type =3D=3D
> HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_MRAV)
>                                 entries =3D ctxm->mrav_av_entries;
>                         else if (ctxm->type =3D=3D
> HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_TIM)
> -                               entries =3D ctx2->qp_l2_entries;
> +                               entries =3D ctx2->qp_l2_entries +
> ctx2->qp_qp1_entries;
>                         entries =3D clamp_t(uint32_t, entries,
> ctxm->min_entries,
>                                           ctxm->max_entries);
>                         ctx_pg[i].entries =3D entries;
> --
> 2.47.3
>
>

--000000000000f2f9cf0653710e16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, =
2026 at 1:49=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.com" target=3D"_=
blank">ajit.khaparde@broadcom.com</a>&gt;<br>
<br>
The driver is not passing the QP1 count while<br>
configuring backing store for QP type.<br>
This can result in a smaller set of entries allocated by the<br>
driver with the firmware.<br>
<br>
The number of entries is provided by the firmware as a<br>
part of backing store qcaps v2 HWRM command.<br>
<br>
Fixes: 5b5d398434f9 (&quot;net/bnxt: add support for backing store v2&quot;=
)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
Signed-off-by: Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.c=
om" target=3D"_blank">ajit.khaparde@broadcom.com</a>&gt;<br>
Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab=
.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.=
com</a>&gt;<br></blockquote><div><span style=3D"font-family:Calibri,sans-se=
rif;font-size:11pt">Acked-by:</span><span style=3D"font-family:Calibri,sans=
-serif;font-size:11pt">=C2=A0 </span><span style=3D"font-family:Calibri,san=
s-serif;font-size:11pt">Kishore
Padmanabha &lt;</span><a href=3D"mailto:kishore.padmanabha@broadcom.com" st=
yle=3D"font-family:Calibri,sans-serif;font-size:11pt;color:rgb(5,99,193)">k=
ishore.padmanabha@broadcom.com</a><span style=3D"font-family:Calibri,sans-s=
erif;font-size:11pt">&gt;</span>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index b677f9491d..7d70d0f3ec 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -5404,11 +5404,11 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ctxm-&gt;type =3D=3D HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TY=
PE_CQ)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entries =3D ctxm-&gt;cq_l2_entries;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (ctxm-&gt;type =3D=3D HWRM_FUNC_BACKING_STORE_CFG_V2_INP=
UT_TYPE_QP)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D ctxm-&gt;qp_l2_entries;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D ctxm-&gt;qp_l2_entries + =
ctxm-&gt;qp_qp1_entries;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (ctxm-&gt;type =3D=3D HWRM_FUNC_BACKING_STORE_CFG_V2_INP=
UT_TYPE_MRAV)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entries =3D ctxm-&gt;mrav_av_entries=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (ctxm-&gt;type =3D=3D HWRM_FUNC_BACKING_STORE_CFG_V2_INP=
UT_TYPE_TIM)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D ctx2-&gt;qp_l2_entries;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D ctx2-&gt;qp_l2_entries + =
ctx2-&gt;qp_qp1_entries;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 entries =3D clamp_t(uint32_t, entries, ctxm-&gt;min_entries,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
txm-&gt;max_entries);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ctx_pg[i].entries =3D entries;<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--000000000000f2f9cf0653710e16--

--000000000000fe3e2a0653710e49
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDdnfAXwjszCqD4AiJyzTE9idJd4Jgxiz6C5IHza20gMTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MDQxNzQxNDhaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAvSvc2HHto
hUYSgcG8/kReAs0cg0tYpG85PsclbxknoxZN+PYnb2xyBwVyh6YDD+Z6xIaGY0fMSdnzxlwmt0gC
4sQv/CtHZF4kO+NfPDnoRnpMzel+u+gXNgbluO+iEsZ6as/21U5Ljig9SffPy92MFLIuw+9/9a2t
eqOjxG7ZsjrQwEQEH+PihJVtThCFY8Gr2Xqf9mAuyNNbDICNe4B/88VmqV1x7II6JpeDELAYoweJ
H+ocOo8A//6eogHuFrN2tNHj4w0HfiiNxr65Mph4mpyU5UZ7REiZUgPCep6/nJIi6UO23iKrXFaO
ZI1a6ZCa6SyzuU+zqqkhek1Ia1XC
--000000000000fe3e2a0653710e49--
