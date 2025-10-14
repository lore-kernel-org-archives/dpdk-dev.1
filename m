Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B88CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD03040698;
	Tue, 14 Oct 2025 15:19:57 +0200 (CEST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5A83E40698
 for <dev@dpdk.org>; Tue, 14 Oct 2025 15:19:56 +0200 (CEST)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-554e726e5cfso936677e0c.3
 for <dev@dpdk.org>; Tue, 14 Oct 2025 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760447996;
 x=1761052796; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dXQWGWToGZapplPdgf6HfhrswTn44q2JeAE4nHeEMA=;
 b=TkB3MJxyWHkhrSK2u8kd+ZHmTXfhgTrfavRTr1/4RqzyRXMsqYkrEhRX8KZJrKS02t
 zkZdDq08ziEG8QhQyb/rbpKoMI8Q13Fz31zYXz4RniVC83+8voqUbk/SfT7mUGYsydqg
 HsIGO1XDMVZiqJ2os52o45PQrK7kh9F96ntsvqPVHI545q3jiuAz7ix7Wt5mL6LGcpCQ
 knzkGyCaReBXGEY4qNL5r+toUsiye0K0QgQVqGVA7kG9GtUCtIb8nyTFM+j3wuaSSoNa
 gY3LnWnJ4CuG/EPHSoNsJDlLCKnif6mc/K6LpUl6YwW6DpOQcnw7JKrUN/4XNoud8s6b
 cMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760447996; x=1761052796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dXQWGWToGZapplPdgf6HfhrswTn44q2JeAE4nHeEMA=;
 b=q9qROvC+UN2ZDKMGkvKfKjtUdSrmxucW6bx4CQEANd6JcyBgzCYcKVhNHvwLZPgiiW
 gOiO0PgF8qTRl0NS80U2Jb8EvP3rj0/DgZnCTshEB4z8kXZepTAXinyZDOBZ4kas8pV6
 upXhlbOYocgjeSqdnVUWdNb4NpjDJ9tee99WBUsgv8GCBIdsTiCmRJjekFKrAwivxyDr
 7an0X4pzB+R6cIxL2Ew/haP7LEUyuRsKhuvu8UcDuaqHjDDvcLGBKxhRHG419PdDvYsU
 aWbXUJbopN5KEMGQ5crqS+R3dUnOKEVVWgjDvsr1BkvwEnOKla+kBa8dzynuezNmgQqa
 O69Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUShWeb7BFmQR4KBbp0iXng7ZGcg7KaC35AoSpRqvbgf/lWfDBw8HqX34wVJSqSb7v8Cu8=@dpdk.org
X-Gm-Message-State: AOJu0YyYFpfql8JEHiHYFPGVBtoATxPdY8Q3hrlFFCT17E6xQqgsM5Ch
 0vS5sh2YKghlkQe6OpeHB5J1zxT93muYYOPF4Ur6R9UpENygpye6Z5Kc+GwBkWjGdSBtUCZvjV6
 jEo9meoN6dlW0CHlctT9WwuINoye/H45MfMZwuGGf7A==
X-Gm-Gg: ASbGncsNowI+T/czGrRRRkpEJHcsDqEW0AZMcYQHGT6IRr1CdpewsLRNbw9lmjNcXbL
 3le9nZsfEcZyd+i9GTykCSG1HyvGZ2cDvQbEmS3+RcKrPebtG+g824+rTtPpPz8EvAO8GM01QJA
 LzDMgGU7mUUqW7TZ64CDL5sC4bVOymbwWeKFghY6qwebOXssPj0w3o149iNBXhxP9Tfj0blASu2
 NgvqDZiExvd/1y61w6ewsWMelCpdlZR1qw8og==
X-Google-Smtp-Source: AGHT+IEvzZb3UIitURUbL61gQFhhbL8PgBGT1gfsTUrywLnN0E9sMZg4gUxn+9PXEf82iY4zQ69B/TKC5Caq+XoxiYE=
X-Received: by 2002:a05:6122:8c10:b0:54a:87d3:2f09 with SMTP id
 71dfb90a1353d-554b8b1706amr8061146e0c.2.1760447995563; Tue, 14 Oct 2025
 06:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250926012806.127837-1-zhang.tianhao2@zte.com.cn>
 <20251014122814.1071534-1-zhang.tianhao2@zte.com.cn>
In-Reply-To: <20251014122814.1071534-1-zhang.tianhao2@zte.com.cn>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 14 Oct 2025 15:19:45 +0200
X-Gm-Features: AS18NWAGNdgzq5NL2DzE0ttxMIiRepQaArKpAWXjABO-oKFIe52AUcDwsBoqecU
Message-ID: <CAOaVG14PswBxiLv8Q63RAAG1RKvKMAo=9K6Y7QWaT4BQ3rnpjQ@mail.gmail.com>
Subject: Re: [v2] net/zxdh: support multiple PF process flow table
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: Junlong Wang <wang.junlong1@zte.com.cn>, yang.yonggang@zte.com.cn,
 dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000006be59706411e3db1"
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

--0000000000006be59706411e3db1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have been on vacation

On Tue, Oct 14, 2025, 14:43 Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote=
:

> Hi Stephen,
>
>
> Regarding your valuable review comments on the first version of the patch=
 I submitted, I have made the corresponding revisions and submitted the sec=
ond version on September 26. However, I have been waiting for three weeks w=
ithout receiving your review feedback yet. I would appreciate it if you cou=
ld review the second version of the patch I submitted.
>
> Thank you for your time and consideration.
>
> Best regards,
> Zhang Tianhao

--0000000000006be59706411e3db1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I have been on vacation=C2=A0</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Oct 14, 2025, 14:43 Tianhao Zhang &lt;<a href=3D"mailto:zhang.tianhao2@zt=
e.com.cn">zhang.tianhao2@zte.com.cn</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi=C2=A0Stephen,<br>
<br>Regarding=C2=A0your=C2=A0valuable=C2=A0review=C2=A0comments=C2=A0on=C2=
=A0the=C2=A0first=C2=A0version=C2=A0of=C2=A0the=C2=A0patch=C2=A0I=C2=A0subm=
itted,=C2=A0I=C2=A0have=C2=A0made=C2=A0the=C2=A0corresponding=C2=A0revision=
s=C2=A0and=C2=A0submitted=C2=A0the=C2=A0second=C2=A0version=C2=A0on=C2=A0Se=
ptember=C2=A026.=C2=A0However,=C2=A0I=C2=A0have=C2=A0been=C2=A0waiting=C2=
=A0for=C2=A0three=C2=A0weeks=C2=A0without=C2=A0receiving=C2=A0your=C2=A0rev=
iew=C2=A0feedback=C2=A0yet.=C2=A0I=C2=A0would=C2=A0appreciate=C2=A0it=C2=A0=
if=C2=A0you=C2=A0could=C2=A0review=C2=A0the=C2=A0second=C2=A0version=C2=A0o=
f=C2=A0the=C2=A0patch=C2=A0I=C2=A0submitted.<br>
<br>Thank=C2=A0you=C2=A0for=C2=A0your=C2=A0time=C2=A0and=C2=A0consideration=
.<br>
<br>Best=C2=A0regards,<br>Zhang=C2=A0Tianhao</blockquote></div>

--0000000000006be59706411e3db1--
