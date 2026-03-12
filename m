Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FAB106ACD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3329402AC;
	Thu, 12 Mar 2026 19:46:02 +0100 (CET)
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com
 [209.85.222.228])
 by mails.dpdk.org (Postfix) with ESMTP id 93AC740275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:46:01 +0100 (CET)
Received: by mail-qk1-f228.google.com with SMTP id
 af79cd13be357-8ca01dc7d40so136853085a.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341161; x=1773945961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9aYU9chrSFarQGMEs2yDeV71Ytomth8fux+sWmd1EA=;
 b=icCtETnKGBn9cbHblznv7FNrFT+y/dN9pzKkNvJvgweuuyYJJ3KiFDMVffh1rl1bx9
 +KFYa1v0CmVxT7JG1huKn/bVfJWRSNj0KLQTS/0wGN0Bt9pDFA7PvvdzSvQhXHbSXOoC
 SU8Evad2WUjLUxs1Ng74/i4EgH4OaOH6m3dunJbfiyoF96hsV37tr0id2zHbBkoC6rQp
 yY2Jh3VoEfD1Q91te2dQWhKxTwrnAQEajzlUZaWTmBjXeOyv77s/pPs9iw9XCHfWVM6O
 9pISnlAHdx9ImCNYFCcfSQlsevg0Vac+nWPslwrS6QMOhE4xctNXJhwQ/MFAv/a5MDub
 vGlg==
X-Gm-Message-State: AOJu0YwRu+TTEj6Y6QV41++wHqzFjbm+P0qpOY5oK0Fdw3ZrdKm/qQjV
 MoNRtKFyjI+Fnc8eef48YUdwRzB5sSNA1ISlyrSMzh0wjHz97bJgaoBCQ1rgqEeVSYdxnGbvnYr
 dn+Xo0EBSm6F4YjjzXKB6rSNh3KBmVu1uNaiiVllrqF6Ru116S6rZHK5rrXgyyTDBJYikDZ7xjm
 Ly7Sex/no+djAw06cLrAYp5f4WpdV2cpPFX3LZaS5Y1v6XQRAQp4nUrS1OkBkHJkOYXGwYx62Lc
 ceo4Q==
X-Gm-Gg: ATEYQzxpZnoImuQ8XK5xnSD13dAvHGElRhN563ntZogd3jkoawgF+R5Mg3vGCZ5z3Un
 ZU590jCQipcabqVAktgqAMrU1uoupOj7jV9lG72Qp0v9AjuFvjUS6/DKM61/iG+9xiwalv6nICN
 ZCvGAKSEFEs+cp44MxqFtkXecYdKrEG/WuZHgPKnN1UojW5fFcwsfQCMtfYD0gfkqRjtXr1FqG7
 wfiojfWs4HNk7807MTsMLBTnSzgds94qYlP0LJLLoe2WCzjtZpFnrwQ7hjp6UML3vKt/LNIgTfC
 8eIMAuwlj4CRZKuQ/13on7a9wE4SIbDLmX1pYjUKTeq23M82VZvzLAhgGSiO3n9RgPo9WB6gNXA
 wRTReK0QQmflTv9GSFYQjj5r1yywCt2H1+L/iv5fxf/rv0PrMnIjxFXsRQV8vLpzJZO090sOgmo
 xPJ7r62xYcuWRvp57w4vDNMG24iKqMudgFh0NKQXJx9x/7ltV5+L9wFJKxkuLEYaed+/w=
X-Received: by 2002:a05:620a:4693:b0:8cd:92e7:718a with SMTP id
 af79cd13be357-8cdb5b25d03mr117650385a.38.1773341160504; 
 Thu, 12 Mar 2026 11:46:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-8cdafea8622sm21612485a.3.2026.03.12.11.46.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Mar 2026 11:46:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a13a659c82so690459e87.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773341159; cv=none;
 d=google.com; s=arc-20240605;
 b=TI/11w5tdis8z3JY1wBNm+OzFVhV6rzOP4eLrWZ/2zG5jMA/CkGa6WYI2POvJ+MBz3
 CpjpIehSlfnfqK6YMpSZA7rTkGxv4dZvSAQ8NNqbPPXQz2I52Lyl9kqNqrcM/erDKd3b
 5W6lZkfSqZ7WqFtYR/le8KUL0zG7fARHFSKz4D2qsmSGvqGQJ1M1XA2DnciBniwozWYG
 ZmrkahElkR8AOLT7hlx/2DxmHDDdgkg5sVcwjr2volCwEl1usM10d3m4o/Vkg2lYDqwc
 7Gaxs5Eu46ZJ/1KryCZR5NNN1ePzt8Eec5o4Twyb2ucn3kEQPLUveVtGkRvSsfdxf8GU
 ed9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e9aYU9chrSFarQGMEs2yDeV71Ytomth8fux+sWmd1EA=;
 fh=Up5PBpN+Amun/pNxCnbM88hKuelPmLjjkmbv9cTOURc=;
 b=aTjP5P+Hul5ugy+llcQN4s9kMmNOZMUE+hhZpkyO0CbRiLKXboolI3TlzH72b6ICzJ
 UXS/Uuxwp/TpyrIZQ6VsJNUW3tQ0iNnrzpjqdSlFRt7p7+OVd2jEA7Y9jjJ0FhlO5Jgy
 SZofjlDDPAtA1rZ2G3R8NU7JJMHaO/jpWtxFcZTD/R/Y0k4Jw4GP32D0xEU8QRYpQ8w9
 NdAmJ0JvKVz2Dp00suKbDTOS+9eEquB5iGetXp/A/b9Z2pIOJ71Lo9CCacxRw+z5NIA8
 dI0y56VObO6GGPcazoIZONRf1z994XYerzFnuC51n7GuiiUCAJH+OOQy7UsoQDp3dwXq
 mJsg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1773341159; x=1773945959; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e9aYU9chrSFarQGMEs2yDeV71Ytomth8fux+sWmd1EA=;
 b=NSA2wpaLP4A8PmEuZZY0CInzicj4gZvDPyK1sOmd1GsPMN8suvPsDSAJa1Nx6HhCB+
 Vv1gH6/sWNlJc8bgD5dsh4+B8dg2TM8GI/ppV0F1wUM0jGUFMRrZ93IFQh7zMiD0EdvG
 yKkjLuglEi60/+w9JR3aYjYBDQQS6x4ryb/xE=
X-Received: by 2002:a05:6512:155a:20b0:5a1:3ee1:2756 with SMTP id
 2adb3069b0e04-5a1626f2ed1mr125791e87.4.1773341158570; 
 Thu, 12 Mar 2026 11:45:58 -0700 (PDT)
X-Received: by 2002:a05:6512:155a:20b0:5a1:3ee1:2756 with SMTP id
 2adb3069b0e04-5a1626f2ed1mr125788e87.4.1773341158106; Thu, 12 Mar 2026
 11:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-3-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-3-ktraynor@redhat.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 12 Mar 2026 14:45:40 -0400
X-Gm-Features: AaiRm51ZhiwR5aykIvJJayTvj5OdjukHW1bLZkrademFPGCU6xUp29llFWPLI3E
Message-ID: <CA+BST0nqwLC5JHyrCq7dAG88z9tG=BD7KPFBrXXv0-c1Y_vxAQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bnxt: fix uninitialized read
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Shuanglin Wang <shuanglin.wang@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Peter Spreadborough <peter.spreadborough@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000d96197064cd829e6"
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

--000000000000d96197064cd829e6
Content-Type: multipart/alternative; boundary="000000000000cb7ae5064cd829e2"

--000000000000cb7ae5064cd829e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:36=E2=80=AFAM Kevin Traynor <ktraynor@redhat.com>=
 wrote:

> batch_info->enabled is read in tfc_mpc_batch_start() before it is
> initialized.
>
> Initialize batch_info to avoid this.
>
> Fixes: 67ad40007cd6 ("net/bnxt/tf_ulp: fix VFR cleanup and stats lockup")
> Cc: stable@dpdk.org
>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
> b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
> index b55366e003..23e1b59ca4 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
> @@ -193,5 +193,5 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
>         struct ulp_sc_tfc_stats_cache_entry *sce;
>         struct ulp_sc_tfc_stats_cache_entry *sce_end;
> -       struct tfc_mpc_batch_info_t batch_info;
> +       struct tfc_mpc_batch_info_t batch_info =3D {0};
>         struct bnxt_ulp_sc_info *ulp_sc_info;
>         struct bnxt_ulp_context *ctxt =3D NULL;
> --
> 2.53.0
>
>

--000000000000cb7ae5064cd829e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 6:36=E2=80=AFAM Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redha=
t.com">ktraynor@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">batch_info-&gt;enabled is read in tfc_mpc_batch_s=
tart() before it is<br>
initialized.<br>
<br>
Initialize batch_info to avoid this.<br>
<br>
Fixes: 67ad40007cd6 (&quot;net/bnxt/tf_ulp: fix VFR cleanup and stats locku=
p&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redhat.com" tar=
get=3D"_blank">ktraynor@redhat.com</a>&gt;<br>
---<br></blockquote><div>Acked-by:=C2=A0=C2=A0Kishore Padmanabha &lt;<a hre=
f=3D"mailto:kishore.padmanabha@broadcom.com">kishore.padmanabha@broadcom.co=
m</a>&gt;</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp=
/ulp_sc_mgr.c<br>
index b55366e003..23e1b59ca4 100644<br>
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c<br>
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c<br>
@@ -193,5 +193,5 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ulp_sc_tfc_stats_cache_entry *sce;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ulp_sc_tfc_stats_cache_entry *sce_end;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tfc_mpc_batch_info_t batch_info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tfc_mpc_batch_info_t batch_info =3D {0};=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bnxt_ulp_sc_info *ulp_sc_info;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bnxt_ulp_context *ctxt =3D NULL;<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--000000000000cb7ae5064cd829e2--

--000000000000d96197064cd829e6
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
oIHHMC8GCSqGSIb3DQEJBDEiBCC6sS9JSWh8VMz5Uz6X5gsdZzWQxtxkxswRaCg2yfsK6DAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMTIxODQ1NTlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAL7TNeme5g
DxVg+SKhbohp6ZZ0HQyVX7g246YL1w6FjtB+4q1s7ONGutgkMPEQJCpZ/e7SBDmDkNFounp8K4ps
7pU/PNlyGoIFfOI1hUvtykGMWsxOsUaZmS4JyKG7GPjo27lVf7qX0KN7SHyzSD9wsQPDwx49K0Ar
ym25XeFGB6xuaPAqg/JEFiDJvsnltdE0eGpXBNn4jqVlKccLzDB3qiDi4DAFTkawyrgWPbxu7gPK
2lIv57Fg5QaFU3MVoe6+j4/8xwEox5zJNCVn7KwzRuVDYR7QVF0HKipTAGc5brlBJPa50Ftra26r
prA/m5Z+BbVIepGyFoHwN20xxd9l
--000000000000d96197064cd829e6--
