Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A50FCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 11:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC8A4066A;
	Fri, 12 Sep 2025 13:15:27 +0200 (CEST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8F6704065A
 for <dev@dpdk.org>; Fri, 12 Sep 2025 13:15:25 +0200 (CEST)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-351f5cec42dso3508391fa.2
 for <dev@dpdk.org>; Fri, 12 Sep 2025 04:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1757675725;
 x=1758280525; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7+R6PDofcUXxl5mupmoasTNO6Pt7o00MsMUOw9ehJYE=;
 b=B/HKaPn5S7r1O1ygky8lrCYChSGZ4OoL1gxObZqxuJwWKuEnVv9iPGFDkZrD9dinYB
 gXzOhmbap3DH4LCwes2cn/LGMefZ6ySh8BiygvIhCRqsA/yW+DCXAOkd6G2TzbPIngzr
 NJX8fEmVbSbQS0xNTFejH63J+OG2Z7NZsZAvP4qlHXnP1Tw+ezyHqvgHPvaed1g/NuOn
 AnflCYdQPRbwqHDDrJ8olFiDdvQn0WWyr6csNoGStVzxlCD0tpGGMm16T/WMZ0QpDIvI
 lSrf6wB8wMSEyoYcB7jxWHXEmyX94J2U57FFQS3hzFMOuKrZPV6Br43FgFXYwx4gRmBH
 E6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757675725; x=1758280525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+R6PDofcUXxl5mupmoasTNO6Pt7o00MsMUOw9ehJYE=;
 b=oGirLRvDl7YCFX3HXB0+XQ8aOS+BYVJZTU+Cudf6IHKv3YyvLlEf4osUbMkYtQmgKc
 SWLXV8O/0x4rA3Rxg3gxBlt1DVZPBvnSNPdVgw//qy110RsxdlkaKmpJMyKDbqYzapzW
 r9KwIA4hELiwGQR55k9Wb00eKqKMHO6RFFTJ80bZSg/bEi7kpdPR+GgsXaU6WSIgec0C
 fzO8FO5Z7O/jYLATZDulOuzQ+eNCddcUTNfkjpTPe8tPLSpDG92phdS2n52BhkozWuVt
 6fZLOgf+1eYsRNkzbaBmf5taKb6rn2C8wWe8J9fvKXD22naLEwwu4owK3z+WZCkrSvek
 qnMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJG3cDb9G/7cmwoSGXowQzebQIOHwIVOR8HjYd5pzuTn37PUsn3mglPCiCsQ9KBn7pcBo=@dpdk.org
X-Gm-Message-State: AOJu0YyzilTRDSgp4Tfs7GNCNMnLgNP4WCYLUK4hgn0VhAsYWTpyL6hN
 wyR4Fw+IRMuL8rzKVnWP8wMaHb4xC2plrVUfPuXr6nlI+D6sGiYLStm6poi1mL+OWTnHs+IQld/
 QZA92hbYGoIp+uoq3PHS3ajT6p8b/O4QeCFcanYCx2mTfK6x6DnHD0vSyZ9LtjtAiR802gXH43g
 sN5wJF4VrUgoIP68ULp+AJHhs=
X-Gm-Gg: ASbGnctJB7iDgqHXsDaSZSwdMb05qq4ylpNk3xBwM0GhKBCcWE0iNHU0WTQPSaCiHT2
 /8TPwRpMhLXrODgOcZJe2zrVRuP4g0yzXyD/9vKgAPfMaWibhzUEZ9zBFPiPJGSSz4eGHxSJnmc
 CG0ql9z1QA2GcIWWVD1CXV+KfZTZFQ34ZNEg2GfV781EVRYkbSDCfliBgvnMOKFjz/y8s/7Fj5T
 IqjqeiRWw==
X-Google-Smtp-Source: AGHT+IEj9mUZ3Gf4M+imk2lBdIHyROtn3JxHj+/WfAB6kvSpbRIgKIFt+UEAAl5Ri0HO57BEGM2WH28nNEJBzCdvg0Y=
X-Received: by 2002:a2e:a54b:0:b0:351:786c:e52e with SMTP id
 38308e7fff4ca-351787c2b85mr6280221fa.6.1757675724803; Fri, 12 Sep 2025
 04:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
 <3299441.5fSG56mABF@thomas>
In-Reply-To: <3299441.5fSG56mABF@thomas>
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
Date: Fri, 12 Sep 2025 14:14:48 +0300
X-Gm-Features: Ac12FXyT8t2st_VXbPgMCoqUaKdPnJY6Znbo9-l7HqQ60IXofVjA1aOErjuJ4_4
Message-ID: <CAHqJCA=Nh=AoH-8kx-omnxD81FE8QUkQJmh0v_U+Ha=_7kZrDQ@mail.gmail.com>
Subject: Re: [PATCH] net/af_packet: fix crash in secondary process
To: Thomas Monjalon <thomas@monjalon.net>
Cc: linville@tuxdriver.com, dev@dpdk.org, stephen@networkplumber.org, 
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000352691063e98c5f8"
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

--000000000000352691063e98c5f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Probably no need to go on the next line, you are allowed to go to 100
characters per line.
> If a second line is needed, only 2 tabs are required.
>
> Why zmalloc? Probably no need to zero it.

I figured since it was only IFNAMSIZ bytes it wouldn't matter because
this will run once at startup. I can use rte_malloc instead.

> We can use a string-specialized function, like strlcpy.

I used memcpy because it was used before this line for the same exact job.

Will post another patch with rte_malloc and strlcpy.

--=20
Yasal Uyar=C4=B1:=C2=A0*Bu elektronik posta bu linki kullanarak ula=C5=9Fab=
ilece=C4=9Finiz=20
ko=C5=9Fullara tabidir:**=C2=A0**https://i2i-systems.com/email-disclaimer/=
=20
<http://i2i-systems.com/about-us/email-disclaimer/>*

--000000000000352691063e98c5f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div></div>&gt; Probably=
 no need to go on the next line, you are allowed to go to 100 characters pe=
r line.<br>&gt; If a second line is needed, only 2 tabs are required.<br>&g=
t; <br>&gt; Why zmalloc? Probably no need to zero it.<br><br>I figured sinc=
e it was only IFNAMSIZ bytes it wouldn&#39;t matter because<br>this will ru=
n once at startup. I can use rte_malloc instead.<br><br>&gt; We can use a s=
tring-specialized function, like strlcpy.<br><br>I used memcpy because it w=
as used before this line for the same exact job.<br><br>Will post another p=
atch with rte_malloc and strlcpy.<br></div></div>
</div>

<br>
<div><font size=3D"1"><font color=3D"#808080"><strong style=3D"font-family:=
&quot;Times New Roman&quot;,serif"><span style=3D"font-family:&quot;Trebuch=
et MS&quot;,sans-serif">Yasal Uyar=C4=B1:=C2=A0</span></strong><b style=3D"=
font-family:Arial,Helvetica,sans-serif"><strong style=3D"font-family:&quot;=
Trebuchet MS&quot;,sans-serif">Bu elektronik posta bu linki kullanarak ula=
=C5=9Fabilece=C4=9Finiz ko=C5=9Fullara tabidir:</strong></b></font><b><span=
 style=3D"font-weight:500;color:gray;font-family:&quot;Trebuchet MS&quot;,s=
ans-serif">=C2=A0</span></b><b><font color=3D"#0066cc" face=3D"Arial, sans-=
serif"><a href=3D"http://i2i-systems.com/about-us/email-disclaimer/" target=
=3D"_blank">https://i2i-systems.c<span></span><span></span><wbr>om/email-di=
sclaimer/</a></font></b></font></div>
--000000000000352691063e98c5f8--
