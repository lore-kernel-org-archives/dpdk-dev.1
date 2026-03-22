Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A50D58CA3
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 23:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD9F40268;
	Mon, 23 Mar 2026 00:29:55 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id E374A4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 00:29:53 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c107ef474fso4232334eec.0
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774222193; cv=none;
 d=google.com; s=arc-20240605;
 b=Pqamqb9hU0I/mT/XP+QTP1HPev2CHSHr0hDu4huA3jaybW8rP2K8g/Vx9o9nyzbvjc
 ohRrqhl2eG3wT1b1BUbWcOWow/gVi9I1ErJ/RUzIml1hwv72ldN9sNr+BPD99pDXPAxd
 2AqqROLApBeU1tBl5ZBWYUu635UgDf8I+pTYKig1K5VN/MCgOqGvJIgN2yWidlqZ5kc/
 FslmjQQqTNB8H0EG5DQGZF1m0WcWzR/wm8h5cPXWEEu/oN4dj7cM7i4jO+hhFrZxR2Fu
 wFqa90h9A24iphBI9N91F9VLcStbihzyI8dWn1xx/NyIrNMlqbVNERrISogw/C4A+bQJ
 ko0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gmIZ/mOL1xhNRmHjmgN6EaPTFDoOYNDBPnrCDXelOEI=;
 fh=sS3EmNnEVHcwm9r6CnYQg9YIbdwdpPEpTJVDK31esqc=;
 b=P1WxGkBXYvkbdw9dP/tyQnFDK6AZAE0HQP81wfpOsZ6pF3m6VY7fCA0R7W2E9+5Ih3
 i9koZt65KjKm1DOLnXWoPbq0zF7wYDIjVRCQcuY37/XscIdpwK0Btw6Mkbzdq0qEsY8S
 04t6kWOa1cO1EoaN0q6QezP/KGf8FYzfN4NbmI/LfvZByR+ZwQpPaJa8cGaHlL3qGjop
 nNgTsaamdZ1SACxVUKusdFPmjh464s+l7HdXmcX4m9hfiCuJOq7WlaNy1lJDGBye9G6V
 ou8j77yT1t4azlGeV7t8duqLXMwTQTNYGVHGiRg9TC0xbVBtNLWcZW+2AiMhh3vAhYOB
 yInQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774222193; x=1774826993; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gmIZ/mOL1xhNRmHjmgN6EaPTFDoOYNDBPnrCDXelOEI=;
 b=HzoRg+fNQBMbEgFOEJaRNE4qvvIfc0aWuMCfHMygaK3HfTR2s8rtLXVywXgSVCKQWa
 WYf/Ah1WNJZsIGAPSUjcX2OOUvl9Wz7ikRwRxjM+DhjuMkKJW2acrTAAfnwYrihqEIXA
 rD4w2NWVv8v9NkOM9sUQ7c4iYvv08Ao7QToo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774222193; x=1774826993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmIZ/mOL1xhNRmHjmgN6EaPTFDoOYNDBPnrCDXelOEI=;
 b=ZQtwkMAl9/mnwUaA238Njp/VchzfuHg28WvU4HwD8XZg49O8C0Qne+ugRiTUIjlRIl
 SU7nRXQ6J7ihsEhbs5Nqd71PdLLlS1A2pl0sDRN2AEq4g2DDEm7BE+dc7P6uGnyFs4aS
 aIDHKm9dw7Gsbhp3/bGE9ugpwh9PwZU1viVqfVjv80BGdTLdiF+rV+ArvRiieFO+3Kjm
 b1YU0dZKmG+ebzFCPVlpXSIgWm4NSgG/ouJ5EApwTK9jdQlY7QTuHkT21rCX6kvUgxot
 9yyJXfqmNvHycvwfHxYSbjtdfZ6lK4u7ToUizJs208vSNyuQFho97E5Ah70wy42N52Rr
 Dkdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSWixMzqNzQevjCB72+TakB5qDNaSdF3u7v0zs/lOUDxNN/KoOdfkdNbYzMDNUvN5G5Sc=@dpdk.org
X-Gm-Message-State: AOJu0Yzvf0igvPQgAcgTwbjEt1LIBc0YgoaGrz4+4j/e+RJKNrgGNguu
 kRKx2QNQADs7y5VRswb9KnT75KIQm8BjK2FurcdaqDq0wYEqbkpMksMzi59U/8LQEr/Zpd+7yNl
 BWVTdP496ETM9N5P+c5xwCJtMrAmC/sGPmSeD5K23GQ==
X-Gm-Gg: ATEYQzz9mZsig8GQJGBsdQvnGe01SuB1gm/jp9+NR5Q6ysAyNw+I42hHHU+zIZcpF47
 t91x3B2Mf3iuge4T1Y/Y/CPtOi0j9IZJzJ24+VWoFQAM8mfupDwLA3esf3LDUjJaDZJbC2KAIN0
 TK2fB7k+dNCZiGbFaEvRqdMGWNspk8d31Q23XVXmRgk97FhXIlBlG3sDzpnGMu8CY2BUIibdCp3
 +DP3f2c8uZ8ugYH8rGxRJETkVYvN+tqzQPoz4lUukKNLVpRiATfqRj43WayVIF0+6KZXuxuzVN4
 ebI+w8AYNbwHTUW3BRMvkvahyngP6UTP1n5sjbxKtk1baqrrjlmnKS4=
X-Received: by 2002:a05:7022:68a3:b0:128:d714:3ca6 with SMTP id
 a92af1059eb24-12a72665399mr5011888c88.12.1774222192772; Sun, 22 Mar 2026
 16:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260319145525.294352-1-abailey@iol.unh.edu>
In-Reply-To: <20260319145525.294352-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 22 Mar 2026 19:26:39 -0400
X-Gm-Features: AaiRm50xGgN2hiclRREVoDGHPu3Bu_yyROzpJf6ohBAPSuo4Jp9Vsj7Iw-dU3MU
Message-ID: <CAJvnSUD_ZsounftuwnSjRN2mYbCTsfBAF94T8G7AK7OaWdZA7A@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add missing crypto drivers
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000008d9719064da54bae"
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

--0000000000008d9719064da54bae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

I will apply to next-dts with a little commit reword.

On Thu, Mar 19, 2026 at 10:55=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu=
> wrote:

> The recently added crypto throughput test suite was missing a number
> of crypto device types. This patch adds these missing drivers.
>
> Fixes: 76e3fdd7b5c6 ("dts: add cryptodev package to DTS")
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/cryptodev/config.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
> index ff4ce25c93..69ff7aa59a 100644
> --- a/dts/api/cryptodev/config.py
> +++ b/dts/api/cryptodev/config.py
> @@ -38,18 +38,27 @@ class DeviceType(StrEnum):
>      crypto_aesni_gcm =3D auto()
>      crypto_aesni_mb =3D auto()
>      crypto_armv8 =3D auto()
> +    crypto_bcmfs =3D auto()
> +    crypto_caam_jr =3D auto()
> +    crypto_ccp =3D auto()
> +    crypto_chacha20_poly1305 =3D auto()
>      crypto_cn10k =3D auto()
>      crypto_cn9k =3D auto()
>      crypto_dpaa_sec =3D auto()
>      crypto_dpaa2_sec =3D auto()
> +    crypto_ionic =3D auto()
>      crypto_kasumi =3D auto()
> +    crypto_mlx5 =3D auto()
>      crypto_mvsam =3D auto()
> +    crypto_nitrox =3D auto()
>      crypto_null =3D auto()
>      crypto_octeontx =3D auto()
>      crypto_openssl =3D auto()
>      crypto_qat =3D auto()
>      crypto_scheduler =3D auto()
>      crypto_snow3g =3D auto()
> +    crypto_uadk =3D auto()
> +    crypto_virtio =3D auto()
>      crypto_zuc =3D auto()
>
>
> --
> 2.50.1
>
>

--0000000000008d9719064da54bae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.=
unh.edu">probb@iol.unh.edu</a>&gt;<div><br></div><div>I will apply to next-=
dts with a little commit reword.</div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 19,=
 2026 at 10:55=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.u=
nh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The recently added crypto throughput test suite =
was missing a number<br>
of crypto device types. This patch adds these missing drivers.<br>
<br>
Fixes: 76e3fdd7b5c6 (&quot;dts: add cryptodev package to DTS&quot;)<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/cryptodev/config.py | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py<br>
index ff4ce25c93..69ff7aa59a 100644<br>
--- a/dts/api/cryptodev/config.py<br>
+++ b/dts/api/cryptodev/config.py<br>
@@ -38,18 +38,27 @@ class DeviceType(StrEnum):<br>
=C2=A0 =C2=A0 =C2=A0crypto_aesni_gcm =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_aesni_mb =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_armv8 =3D auto()<br>
+=C2=A0 =C2=A0 crypto_bcmfs =3D auto()<br>
+=C2=A0 =C2=A0 crypto_caam_jr =3D auto()<br>
+=C2=A0 =C2=A0 crypto_ccp =3D auto()<br>
+=C2=A0 =C2=A0 crypto_chacha20_poly1305 =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_cn10k =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_cn9k =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_dpaa_sec =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_dpaa2_sec =3D auto()<br>
+=C2=A0 =C2=A0 crypto_ionic =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_kasumi =3D auto()<br>
+=C2=A0 =C2=A0 crypto_mlx5 =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_mvsam =3D auto()<br>
+=C2=A0 =C2=A0 crypto_nitrox =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_null =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_octeontx =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_openssl =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_qat =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_scheduler =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_snow3g =3D auto()<br>
+=C2=A0 =C2=A0 crypto_uadk =3D auto()<br>
+=C2=A0 =C2=A0 crypto_virtio =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0crypto_zuc =3D auto()<br>
<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--0000000000008d9719064da54bae--
