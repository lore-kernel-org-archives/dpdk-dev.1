Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB4C0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 22:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32AC40E54;
	Thu, 30 Jan 2025 23:23:11 +0100 (CET)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1CDF740DCE
 for <dev@dpdk.org>; Thu, 30 Jan 2025 23:23:10 +0100 (CET)
Received: by mail-il1-f172.google.com with SMTP id
 e9e14a558f8ab-3d005bc9f4aso5442615ab.1
 for <dev@dpdk.org>; Thu, 30 Jan 2025 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738275789; x=1738880589; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xYwZuN7zwia5Ty/Ef5zh/ig5HRn8R0CM5FzJwz0lhLw=;
 b=bM0ZMH7/WqhKq4wvmTS7U2fnxvoJBYGQJovCV0Wah8C3gYnSHKjQO7S/kkttXsvbe0
 im9eFBZVf/wrl2S67VKrtlmmzTVUHEdAEjis2HRqO5Qj5HdjDiTXyXgMjKuLwsUIsRxk
 Et/u7Dc3PjmEe1uId5BFKYY1gT16BBONmZrc1ATCUAESz8Hxx1Bd/xbV7toTJbk0+7rJ
 V1hSlpFIhEQjWXt8BgHQ1QTZaRUcLsJYaOQCTecrtLxZSxEgzUpDlsXLqCKubuPeoLbq
 twyKmJusj9tVduSYZddR4Z1ovpzRS7vDN1HZYCJU2j4zgSWQHnKAJVjo+e4pJe/TR5pc
 l5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275789; x=1738880589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYwZuN7zwia5Ty/Ef5zh/ig5HRn8R0CM5FzJwz0lhLw=;
 b=Sfs6wpNof2QG0R7TMkHZtXiv0pz0GSyKw1E/k8HSrHYl6SE+kpU8SfAr3hNCb5a/T+
 8+03v9cpdUjsOo1e2pRKHAB+Q7M8n54E/XxR6XVwdMYkKrsEjA2ACSjp7jlEGDbwFEsp
 Ba+jxPtkE35WXssXwT1elBr0/l5LKJEL1Dc0THC9A8YM0n3ORDSz+Og08hsDkhdqlZEi
 pNAQJb02p9L5B20k6iE8W1a0PfixV9xvPI+zvHZ2HYjhmiR5CMhF4qMYmsqakOOTCv2k
 VILzjluraL82GT8Mv24UwkaqMIhX0ODAsKngnhwjG+4nFEaDiqTYBfMpQcLrB1AYe3XW
 49qg==
X-Gm-Message-State: AOJu0YzHV4Xx9ax+k2ozeWMTj3Me2TeY5CGE3p2qqzZgSmdDUJPQOZ64
 XlHS/f0Kdnhwmkv0NFNCVy1n+YG0lxKc+VgOv59J++S1rHG+YSphwxGK67H18YgyhtK4OQeBPxl
 9tf8uXn7ud6M+RWNEd0653218jPyCQCYZsBksVA==
X-Gm-Gg: ASbGncsCN9AmAky9qUS/RjKBsHOjjk1SnM9QzLu9msdIU34OUHTkP30rIpDrF7SCl1P
 6//UMOPHDwjY+cXzcb1EPwRlIF1w/ysDuNa6MLphPaCHu1HHWxejxU6dJjRwy6EH1yEyJ8smGj4
 JjmomoU/bNTyEnOLoMiALJSvteq1Rg
X-Google-Smtp-Source: AGHT+IHucFCCNSbyuXqvIkZF4unlcSyZyKS6Yf2f2KEAecbKhMtb5bEt1sUILk24Br1f/75JY52tUKsuqHKrhuZPBK4=
X-Received: by 2002:a92:c261:0:b0:3d0:1118:f05b with SMTP id
 e9e14a558f8ab-3d01118f2b2mr25524095ab.19.1738275789219; Thu, 30 Jan 2025
 14:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250116195640.68885-2-ariel.otilibili@6wind.com>
 <20250130102407.39578285@hermes.local>
In-Reply-To: <20250130102407.39578285@hermes.local>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 30 Jan 2025 23:22:57 +0100
X-Gm-Features: AWEUYZmq5bJ3PPkW-yZBcZJyQat0gNiR8DtrDKKh-2e3Ltb8VmvHNxR5eu-cGUk
Message-ID: <CAF1zDgb=rxQBszP0gdCas2RY2moh=88Asyy8BJztAB7yxT_5OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/af_xdp: fix use after free in af_xdp_tx_zc()
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f04559062cf3de82"
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

--000000000000f04559062cf3de82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Thu, Jan 30, 2025 at 7:24=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>
Thanks for having looked into the patch; I have ACKed the fourth version by
your name,
https://inbox.dpdk.org/dev/20250130221853.789366-2-ariel.otilibili@6wind.co=
m/

Regards,
Ariel

--000000000000f04559062cf3de82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Stephen,<br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Jan 30, 2025 at 7:24=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mai=
lto:stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Acked-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.or=
g" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br></blockquote><di=
v>Thanks for having looked into the patch; I have ACKed the fourth version =
by your name, <a href=3D"https://inbox.dpdk.org/dev/20250130221853.789366-2=
-ariel.otilibili@6wind.com/">https://inbox.dpdk.org/dev/20250130221853.7893=
66-2-ariel.otilibili@6wind.com/</a></div><div><br></div><div>Regards,</div>=
<div>Ariel<br></div></div></div>

--000000000000f04559062cf3de82--
