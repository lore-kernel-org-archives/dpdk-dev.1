Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7991CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 09:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F80F4025D;
	Mon, 11 Aug 2025 11:20:06 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 8443E400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 11:20:05 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-7074bad03ceso52179056d6.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754904005;
 x=1755508805; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bWie78eqir0jDw5ynGH8dyg4seekvbwkFXAZRYes+LA=;
 b=nOkUFPWvjqxwQFG4AfO73LWCVNixpd4GKu+soQ5yWdeUdkHuGli5PE6RFT+s8ezqG2
 fiBQmBEH0EwtYGzYBBudZ2MVTrbGxFJpwM9eiAqG1e2/UhuZhUxDbP2KwHK2diSQ/uP0
 5IbtHvU2AVHrFbC6hxwkwwx+pG2LORgbJ0iLaOT1eGYMKHJrAtinP/vYBPM8XDkhGI3G
 1r5pwu2Inppv7q2iWOFJ/1XCgtMQv2x3VXhaeA040GxpdsqgmH8yD/RamQK+yFl4sYW+
 1f6O95opTYHEKjFjQGP0hymUyd7T6TSPiI16YBGEvjrZrK9gB9Sqa3dqlb7t6Zr8Q2sA
 N/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754904005; x=1755508805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWie78eqir0jDw5ynGH8dyg4seekvbwkFXAZRYes+LA=;
 b=OrYqjfPr8uN8rHtXpwlx9Z6znZwkVmUJlCxL7AoBmJud4V6qoN8Y1XL+XqMf0qUL1u
 p+L4JVk/Rs3he66QqJVeRuk9muhNFe1925Gm1wDO05z2ASWgRsQ6emBZA0BxjDbpt55q
 YNfgYCQNJ4qp9hvFDEiI4kr0L1EgVcwXe0b/kh2xkX3iItlPqSQ2U4SPCajXMjM3MRh8
 yaHSb62jrPxn4i//Ekag1IUs2ksEPcU/Hf2HOOPq+GamktA3w3+1SEovbMmY4guf9NOH
 7ErDBeeF65mcoHq5K6CcsOkrme19IiH7Ixi4bf7LYvmlOvhh9YXvR1VOYcIZ3jiatc1l
 pSJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXreRvF/3nmy0UuJxImcA1gZVEDilj62FEGU5sY+WjLOUzlq0hKHwknXpIYSzZmuzH2mEE=@dpdk.org
X-Gm-Message-State: AOJu0Yw+pubaQL8dBQCx0EmbbzxYeGhStPvUIKhEt2+Sas7gDuECoz7g
 h1PIsjkXr/z5GD+qjAn+zANj8dyAlR4pTh0auEwd2gYUhovLIRXhbNpgRIVWMiQFP2/Uo4z3FPg
 acNIxmwpekuVMWg6kSBq/Zj5W5jib8Xc/EIvKZ+uHXQ==
X-Gm-Gg: ASbGnctQzAGXiZXy3npk6+EiFFUM86x/m3hGfD4ILb3J4Umoddm4Z4L6LO9bWM9OJOO
 QiRXWzgMAIMgs0TR2NMzKfPxKqlU40nkX6tYiKFEEjJZHT1uPXCLYqRJpDGvUO2fmC9CNH18IkM
 U1Cg9O45sIMFvxMnWBRnU9UyohIUMjK7CWkqADVfxkczGn3UXoigfDORSEy0XCAPsv/TrbtOQ2p
 xGV
X-Google-Smtp-Source: AGHT+IGssvp4ah8Anf6ZMzl56cu3MZPGaSfBa/qEuU4rNWbf8k320GOe2T0ss6eZyPeY7/i0nGBULTinHb7AKV/DqRg=
X-Received: by 2002:a05:6214:248e:b0:707:44d4:2967 with SMTP id
 6a1803df08f44-7099a4bac21mr210672066d6.39.1754904004751; Mon, 11 Aug 2025
 02:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
 <812ed3d3-d52a-405d-45bf-244de8eafca4@arknetworks.am>
 <605ede7c-2842-4c36-bcb4-f9a0e9c1ac1c@huawei.com>
In-Reply-To: <605ede7c-2842-4c36-bcb4-f9a0e9c1ac1c@huawei.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 14:19:53 +0500
X-Gm-Features: Ac12FXwmEbdk1MTciNcEw_WtfMpO6mwy6ILNK4zVUKLSIosXHDdg1z7rSsawzXc
Message-ID: <CA++2-x77urxvqQMJHFd2GWsbo_t05buoxc9nrWLhw3KQR1VKSQ@mail.gmail.com>
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: huangdengdui <huangdengdui@huawei.com>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org,
 andrew.rybchenko@oktetlabs.ru, 
 jasvinder.singh@intel.com, bruce.richardson@intel.com, thomas@monjalon.net, 
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Content-Type: multipart/alternative; boundary="000000000000d18769063c136daa"
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

--000000000000d18769063c136daa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, that is correct. Please ack in case you agree!

On Thu, Aug 7, 2025 at 5:33=E2=80=AFPM huangdengdui <huangdengdui@huawei.co=
m> wrote:

>
>
>  > When processing a tunnel packet, it is preferable for the inner_l2_len
> in rte_net_hdr_lens and the l2_len in the mbuf to have consistent meaning=
s,
> as these two fields are typically used together.
> > Moreover, inner_l2_len should only include the length of the Ethernet
> header.
>
>
Regards,
Khadem

--000000000000d18769063c136daa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes, that=C2=A0is correct. Please ack in case you agr=
ee!=C2=A0=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 7, 2025 at 5:33=E2=80=AFPM=
 huangdengdui &lt;<a href=3D"mailto:huangdengdui@huawei.com">huangdengdui@h=
uawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>=C2=A0&gt; When processing a tunnel packet, it is preferable for the in=
ner_l2_len in rte_net_hdr_lens and the l2_len in the mbuf to have consisten=
t meanings, as these two fields are typically used together.<br>&gt; Moreov=
er, inner_l2_len should only include the length of the Ethernet header.<br>=
<br></blockquote></div><div><br clear=3D"all"></div><div>Regards,</div><div=
>Khadem=C2=A0</div></div>

--000000000000d18769063c136daa--
