Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB0CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 15:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54996402A7;
	Fri, 15 Aug 2025 17:28:19 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 759D9400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 17:28:18 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b4716f46a2eso1436805a12.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755271697; x=1755876497; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NCsLUdCwP+4ph+PkADqzH2toHR3rqryex6Niv0Hbf3M=;
 b=ZKS2p8K9U55apLHNzo6wMsWEP6d6MMwUiKZ+iBXgoWtcDu9TZZuDnRqJoqKZuhxQoU
 wzd/tnRH+rmb5zrWCElh9AFEfP8oN48JdIu4Hm7aakKw5p3DlhtuABo5UBMKRMMyPc7W
 4G5Np6/KlTVsXHs72/7KCsLktUY7LhZGkddaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755271697; x=1755876497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCsLUdCwP+4ph+PkADqzH2toHR3rqryex6Niv0Hbf3M=;
 b=K9om+MeQY9vv2uV5Z6fJ5/uh88PZazlX1xX/dxhCBZrq5oy5jXPd1S/MM/vhJ3BK48
 x3uC+sn/l+UP+J8yy7hcnC7fDIoONrHsJZkUli0I4i8J2mK5U5caNz4XC0XzE74fpG9s
 guWIoIFpRgYnobpLUTHKExTxzMeiRRPS3A4wwyhnuSUH26pBlSkfK1S6q/tlHMW9dNds
 zk6OzbcxKmHBRHc1aN/7bDruiCwaJr5xWYTENDN7bCOCoVOlMPk8H4e+KzrPPJpFvx7E
 XH+c5AmCyYTJxrNwhaGbzMmqTUvzyDwqfMFL7mcJ5QuO0rvoEhC+Qroojxps9aZdL8es
 bbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV+TeJUy5KNZIezfrIe3OES/MMgHzZyIupH101ZYTmZZtlQbgMH0XI1NDtq64ZCakggT8=@dpdk.org
X-Gm-Message-State: AOJu0YwjXIuhwsDCETDOcm20LKOSiVpiKMHP1/CEe8V6DIJQOdEj4Auf
 uwy3EW3KetgJ5fNbjp4OsM9grshb+MvJQP3s+TzQzJzxeh9bZx7lHlTagVbSSj8I53P/b3j7fCP
 ef9VVsSbgQnBOrsC+QDsgB9eV62G4ov3pqujNZkHZug==
X-Gm-Gg: ASbGncvtZsyFwtiXRGNQ/ADVZBOPhqzpN0ONZa1Buj1L223s0UV+4vbAzey1llRorxN
 danwmeB4pXfoQOoE3EgiE/Ac9jp1+gNNQr4Lah3/iWC4MyhuBXOmshSWjeGHmnoj6+GqEIJdQQ6
 UaAh9Zt7Qf4a/ICyv3PPAuEiAztP6l1Nn5QyD5kRhtg8AqX7Nn32l4lOr9LpdgXVkpf8K4Uymhb
 qUCDQgwMzjQvJXqfLyYNpWkdl6BaH+bnZ6v/JoruscKcoTFwGQ=
X-Google-Smtp-Source: AGHT+IGj8kb/va8yispeujYwiwEo0iuI5aAkSpysZkFbeKWol3vv52K12Uu4ka38Snu0Om1jEOMWMSwGKdPfwK0EW6s=
X-Received: by 2002:a17:902:d2c9:b0:242:461b:7d4 with SMTP id
 d9443c01a7336-2446d71ed3amr39611685ad.15.1755271697344; Fri, 15 Aug 2025
 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250814132002.799724-1-dsosnowski@nvidia.com>
In-Reply-To: <20250814132002.799724-1-dsosnowski@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 15 Aug 2025 11:21:51 -0400
X-Gm-Features: Ac12FXy0B7XU7TT0PtArb_QeXhisXak75mRRmjJpIMxyklRYAov1xVKV2Y6vVfc
Message-ID: <CAJvnSUDdAZ4w8BtoVnz_ZbSdBh96s7TWCsx+KjAS_OywHf3tHg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5/hws: fix TIR action support in FDB
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, 
 Erez Shitrit <erezsh@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000141a2063c690ac8"
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

--0000000000000141a2063c690ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sending a CI testing retest for this series because of a suspected false
failure on the packet capture testsuite.

On Thu, Aug 14, 2025 at 9:22=E2=80=AFAM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

> TIR action was not added as an allowed action in FDB domain.
> This prevented the usage of RSS flow action in transfer flow rules
> with HW Steering flow engine.
>
> Fixes: 1f8fc88d4d31 ("net/mlx5/hws: allow jump to TIR over FDB")
> Cc: valex@nvidia.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Suanming Mou <suanmingm@nvidia.com>
> ---
>  drivers/net/mlx5/hws/mlx5dr_action.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c
> b/drivers/net/mlx5/hws/mlx5dr_action.c
> index c1c6d28ac4..d765d57a8f 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.c
> @@ -94,6 +94,7 @@ static const uint32_t
> action_order_arr[MLX5DR_TABLE_TYPE_MAX][MLX5DR_ACTION_TYP_
>                 BIT(MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L3),
>                 BIT(MLX5DR_ACTION_TYP_TBL) |
>                 BIT(MLX5DR_ACTION_TYP_MISS) |
> +               BIT(MLX5DR_ACTION_TYP_TIR) |
>                 BIT(MLX5DR_ACTION_TYP_VPORT) |
>                 BIT(MLX5DR_ACTION_TYP_DROP) |
>                 BIT(MLX5DR_ACTION_TYP_DEST_ROOT) |
> --
> 2.39.5
>
>

--0000000000000141a2063c690ac8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sending a CI testing retest for this series because of a s=
uspected false failure on the packet capture testsuite.</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Aug 14, 2025 at 9:22=E2=80=AFAM Dariusz Sosnowski &lt;<a href=3D"=
mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">TIR action was not added=
 as an allowed action in FDB domain.<br>
This prevented the usage of RSS flow action in transfer flow rules<br>
with HW Steering flow engine.<br>
<br>
Fixes: 1f8fc88d4d31 (&quot;net/mlx5/hws: allow jump to TIR over FDB&quot;)<=
br>
Cc: <a href=3D"mailto:valex@nvidia.com" target=3D"_blank">valex@nvidia.com<=
/a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Dariusz Sosnowski &lt;<a href=3D"mailto:dsosnowski@nvidia.co=
m" target=3D"_blank">dsosnowski@nvidia.com</a>&gt;<br>
Acked-by: Bing Zhao &lt;<a href=3D"mailto:bingz@nvidia.com" target=3D"_blan=
k">bingz@nvidia.com</a>&gt;<br>
Acked-by: Suanming Mou &lt;<a href=3D"mailto:suanmingm@nvidia.com" target=
=3D"_blank">suanmingm@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/mlx5/hws/mlx5dr_action.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/ml=
x5dr_action.c<br>
index c1c6d28ac4..d765d57a8f 100644<br>
--- a/drivers/net/mlx5/hws/mlx5dr_action.c<br>
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c<br>
@@ -94,6 +94,7 @@ static const uint32_t action_order_arr[MLX5DR_TABLE_TYPE_=
MAX][MLX5DR_ACTION_TYP_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_REFORMAT_L2_TO_TNL_L3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_TBL) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_MISS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(MLX5DR_ACTION_T=
YP_TIR) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_VPORT) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_DROP) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(MLX5DR_ACTION_T=
YP_DEST_ROOT) |<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div>

--0000000000000141a2063c690ac8--
