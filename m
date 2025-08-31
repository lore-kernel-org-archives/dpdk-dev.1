Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83271CA0FE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 15:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D8A40262;
	Sun, 31 Aug 2025 17:01:38 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id DE04F4021E
 for <dev@dpdk.org>; Sun, 31 Aug 2025 17:01:37 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-61d143aa4acso2390589a12.2
 for <dev@dpdk.org>; Sun, 31 Aug 2025 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756652497; x=1757257297; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4bizIPtubVVl9lhLo2BHvuWIxQihQnP5kEvVGGrmbrc=;
 b=ZG1FUT+rpZzbsU6FdXExTxmqAi5Zi84LBcoKJBClRL6ul0B3hCOK+DIIxdfRsgqjU6
 0kd/IgyCbP2/rA1ZPV/W4ViacA1sqSPsQr3YU9BSJAAi/eGvMva9Qcv6burF04P6FGdv
 UZ1cgZwq5WLSFPcEDAwH7F0KgaxFZZT/ktNuGXFdcYXyc7vdtHG4ChodFI9Bt2+BXkX4
 YltxV885ovkqjN0v2KKbZK+fBDkmjaasLx2vyIrtlMVNvogF4cf2YCwEUqzZ3tRF4f/7
 qO4SXYQ7X93DSrmVr4P0vhZ0Qv1HFt4iJka9eLL2jTl3WppDBRkF1B3KoyRjCUGmHGhk
 M8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756652497; x=1757257297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bizIPtubVVl9lhLo2BHvuWIxQihQnP5kEvVGGrmbrc=;
 b=Rvx2s6tN8Bee/wbZf0TMa07QLxusS7GB7gjS0aj6sXdUpIC/UqLT4xQZXv/1zL5F7X
 MVlTEe4gXjYcHbPpPjQ+FPFcgvFg9n/49VY0hgSh9ByHEahVMBbA24zzCTsE0cImyI2H
 UJBzRbRVTsejK8StyVu452Z4BkU+Ps34RoiPnNqu9L2mNQmkMJ9B32jjP5qODkFD8KaR
 WdntglnHyOjZazmc7bhrdTqQj8KkyO+n/4T/F/YsC/WH8TPXIcyjgXxWWyJhzy2C48Rs
 NPnloPiJq55As+mgN+37tsEH5ERqasMGAABkHd5vRUatjJsSkpB0Kjdxo/g+FGG4Y2JJ
 NivA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo9LM6+Jn3LesHtXODSbRJN5Y8GfC8nEReOaMpeqGNmGTslG68taYdwHEkpXsLy5gx//k=@dpdk.org
X-Gm-Message-State: AOJu0Yxidt6JHn74ic/9ptf40glceNkyf4abw4r/guBERU2OYN41YIGP
 D675swyj1POImpKIbBM1Zq0Ofy0gkJLlyr43PdW7ZG2ZTYFL34rJo0ilIeOH6OCnqkIGFne9r2c
 HapOG8I5oTVnLy6UyKJrkdmJXmEo85y4=
X-Gm-Gg: ASbGncvI0wV7npWgbvBy23sucaasMiGhhNJGGgzP1SWWyDFOVBZ0reEzdM5OX3A4dRa
 542VSFtEDdAXagmG3/6rr0xyqyYlgWKjLk3K3XKBk6EwAqNovSrs7tbq/Y9U1SKAQhKdOublcXg
 B4VqZiq5mcr7OUDSWNtg8F3/Rd3Zepupm3J2Lr7d8svOZ36g64y0KtP1FRH33q+VV1YKMj+yRDi
 rnwpCqf9H49/YA=
X-Google-Smtp-Source: AGHT+IHIzn8S+yWFO3TRbmYx1yfXgAbrrxjHjijdwmWcwgAJ5QqTsCij+PTZ2af/kesrA6nmuis0gq48TTDLydKcY/s=
X-Received: by 2002:a05:6402:5216:b0:61d:1074:96af with SMTP id
 4fb4d7f45d1cf-61d270f21bcmr3852221a12.38.1756652497338; Sun, 31 Aug 2025
 08:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-2-vladimir.medvedkin@intel.com>
 <3727304d-4ee7-43e9-a5c5-caeb4ccc9b10@arknetworks.am>
In-Reply-To: <3727304d-4ee7-43e9-a5c5-caeb4ccc9b10@arknetworks.am>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sun, 31 Aug 2025 16:01:26 +0100
X-Gm-Features: Ac12FXzXXb5DL3Td9l5DSh53Qe6AV8sEALt9G1Vn2Z9QOF5M48jcysPD0mmCix8
Message-ID: <CANDrEHnJA2H2p25JDu-AsCgjf-FD3zGHqycf2AxAkyAp7Gi=_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ethdev: extend and refactor DCB configuration
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, 
 anatoly.burakov@intel.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="000000000000190e1c063daa883a"
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

--000000000000190e1c063daa883a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replied in a previous email

=D1=81=D0=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 20:57, Iva=
n Malov <ivan.malov@arknetworks.am>:

> On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:
>
> > +     /** Traffic class each UP mapped to.
> > +      *  Rx packets VLAN UP for Rx configuration
> > +      *  Rx PFC Pause frames UP for Tx configuration
>
> Is this confined to VLAN? Can the UP come from other headers of the packe=
t?
> I apologise in case my question is wrong.
>
> Thank you.
>


--=20
Regards,
Vladimir

--000000000000190e1c063daa883a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Replied in a previous email</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=
=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 20:57, Ivan Malov &=
lt;<a href=3D"mailto:ivan.malov@arknetworks.am">ivan.malov@arknetworks.am</=
a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat, =
30 Aug 2025, Vladimir Medvedkin wrote:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Traffic class each UP mapped to.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 Rx packets VLAN UP for Rx configuration<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 Rx PFC Pause frames UP for Tx configurat=
ion<br>
<br>
Is this confined to VLAN? Can the UP come from other headers of the packet?=
<br>
I apologise in case my question is wrong.<br>
<br>
Thank you.<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div>

--000000000000190e1c063daa883a--
