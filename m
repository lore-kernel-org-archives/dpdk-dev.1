Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B8DC0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 11:12:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2080142EA9;
	Thu, 13 Feb 2025 12:12:33 +0100 (CET)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 by mails.dpdk.org (Postfix) with ESMTP id B603A42EA9
 for <dev@dpdk.org>; Thu, 13 Feb 2025 12:12:31 +0100 (CET)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso6360025ab.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739445151; x=1740049951; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LNiqs/eIkX5ArXcCw5yfIMNzRtmh0YSGfTy/7Et5rcs=;
 b=CHzkm1p4alN0ffZYoEmjrU8ssoephDH/Uj2nPz8a9zvhfDQeitDRf/hCE88k+N1pVS
 Eb1cvnKafv+3QLjo85nA3aQw2536ds+UIoGmz8XY40TjtlKcQc/amKHHDwBNsMGqpozK
 mmGFD465vZENs4bGut9NIclohfLGmbFuJjPleBqeiZQvduRb5/lImNSgLSRl7VCIZZD8
 v/lY87a7BDNsApJ1OFraqKwsmxW4SaetNWyGPNB6m6K4VQ+d2fl4+yJSPM4ss8axV7Lo
 nezs4wRPaj46Nuzic6alUlszdjipZ98qGs5008zfYIyT2gs1Cr+4C7sA5dR4RIVblnGZ
 CzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739445151; x=1740049951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNiqs/eIkX5ArXcCw5yfIMNzRtmh0YSGfTy/7Et5rcs=;
 b=dygxjx2phWJy4R8rKq1k+5C3h/sclCwBJi3rvptSi5vhVadOwkhQjIrSsVwBqVv4hb
 8u3Afgwhs6GyhJNr5l09K2O5l6pAgIPRbpIFQbOAbQZis80tDMnV9uuvdLlGqPemykCD
 AH5g2+SW2x2gyarymlD599+mIx8iZiMSyPWXJZ+1gClaiMzbF2fw2HRO5Jh15zstnnOu
 qZGgA1hiMOaMR/dDJ0E+3A55lgLddw2TzqRC6Vxu/7ZCfzV6wQwsnYe1yDqzbxEdgbid
 gRBrSWBhZxF5utbnq3mecjkBfkr8s0Etqdp78LMhrVC1B4mIYZBpgD4ByuVmSn2unL4b
 484g==
X-Gm-Message-State: AOJu0YzPKP/TaUp/d0SoZ8X/4vsi5Hx1Qa970c5FDH4SVjdZ4zSTwtas
 3QYVc5XInT0VtSOdDXwnPxhP1s9tXGUYoYGSxOZwOznhCSw3lQ5tvjUOcaELvHS1vISaPQMdVpO
 eqPRaBxdw/scQqsyO8+0N16y8quvulI9WoY4KfA==
X-Gm-Gg: ASbGncuvFKZH/w6Qdq++N841l3PDpRzCdpkQ9LD4HTYTKAM/x4mM8t+Y5p/cvjCA+SC
 G2dUPSXR8+42erDLLMMyHVuOHq8FSI0Mpcr7P0duYBUDCsGsX0pHKUd9BxRa1QerLTIXiS6Q=
X-Google-Smtp-Source: AGHT+IFZ3XdqhlQQDUlQTedbEznNIg978B8YvcM3pyIzpvo+t4Yy0p5TMOFkzZ3wo8ZocJGk7TFO9FDFxvCyg7PsmKY=
X-Received: by 2002:a05:6e02:12c2:b0:3d0:25d0:8507 with SMTP id
 e9e14a558f8ab-3d18c22b0fbmr26473545ab.6.1739445151001; Thu, 13 Feb 2025
 03:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20250112185842.9752-1-otilibil@eurecom.fr>
 <20250113171920.1185214-1-ariel.otilibili@6wind.com>
 <20250113171920.1185214-2-ariel.otilibili@6wind.com>
 <3418821.9LS3J3VOpE@thomas>
In-Reply-To: <3418821.9LS3J3VOpE@thomas>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 13 Feb 2025 12:12:19 +0100
X-Gm-Features: AWEUYZleQgAVtCqWpbVexr1Bb-uWAGstWBsaZ3Wymu6a1-9t6KzXLRfoDZMOXw0
Message-ID: <CAF1zDgYjhau3mKJZHVBpU2Y+OpaURLJAPxH+GRZXUebrm_KzWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] eal/linux: Remove unused values
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 David Marchand <david.marchand@redhat.com>,
 Didier Pallard <didier.pallard@6wind.com>, 
 Edwin Brossette <edwin.brossette@6wind.com>,
 Olivier Matz <olivier.matz@6wind.com>, 
 Thierry Herbelot <thierry.herbelot@6wind.com>, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000551444062e04222a"
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

--000000000000551444062e04222a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, Feb 12, 2025 at 3:00=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:

> Applied, thanks.
>

Thanks for the feedback. Have a good day.
Ariel

--000000000000551444062e04222a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Thomas,<br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Feb 12, 2025 at 3:00=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:th=
omas@monjalon.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Applied, thanks.<br></blockquote><div=
><br></div><div>Thanks for the feedback. Have a good day.<br></div><div>Ari=
el <br></div></div></div>

--000000000000551444062e04222a--
