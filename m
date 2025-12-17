Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76770D64080
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 06:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 568614029A;
	Wed, 17 Dec 2025 07:57:37 +0100 (CET)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7B10A40275
 for <dev@dpdk.org>; Wed, 17 Dec 2025 07:57:36 +0100 (CET)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5597330a34fso3867085e0c.2
 for <dev@dpdk.org>; Tue, 16 Dec 2025 22:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765954655;
 x=1766559455; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3cYUjZ0FZDnPSCcvNlkDYYHTGArWySw4QW6UdcKjsTY=;
 b=kMGisVzZ4iyca8OGxF9VjUItdNhzxM+U64nFsib+yX7npmPFyOnWgjJRNf/Pl0RoC4
 gEIUq+UoVsKKp4bBe8cWGy5IKdH2mO+/w2CSaNA0iyzY9aNSZFgGMB0BnGAlgnNEkUc4
 9YIPtlwxgmyTwgDjqUHy9MATX1JU/pRrVocnem4w/Hsixt2F52kes8ZyvwfcdM49q8Pl
 0gKjxarV4WsP88g2CdjmBwFswezW8oTXkL7xH54hPhuvIPjBFKVvRA01FdNpFquVZp5Y
 /TtT+OzS+62CmSQnl9OIK0RWS2Ip+fBUVfLxvjPP1kmgWF1XDEyPRo5EsEnm3mCEx/XW
 MfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765954655; x=1766559455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cYUjZ0FZDnPSCcvNlkDYYHTGArWySw4QW6UdcKjsTY=;
 b=GDImORuvguKonVeRGIqUerVU0R/AZpP02swxMgyhzrKsLErxhuZb/q1a/ImU7Iolbc
 Bzejjo69tRLialWaOcJ94bbaNnAmCcP0D1uA5Ehip6ZClXruJd9l42tAzqxK63iF9yPl
 2EnWb0EveJ4hLlchkCSKCG+P6TQVnW/D6SnnGzjHVOE11Dk9HKZtjX9lGTu/4qGrcp5z
 SCH38FCbVUZIRhlqquj11nx3Z/MYoyr6R/S5ql5dnhKKYqJWTCN6XWXt4geFUDueoWQg
 IUA/9f/8yRWY7GFEqVUqGs8G78Ed72qfUPRv6zQptBfQ6sgcPdFF46Cj0AQ8MLDDh3Rg
 NqcA==
X-Gm-Message-State: AOJu0YxMFYlItvgp6GOHcb13pvoQXeKmBljw9Ti120MyQzdFPTR9p0J0
 Wex0GAtvsGjtoeGSdxjBCs7U3VmbbxSIW8AOCBMIMhBPGX17J6Taxeh2/LoRFD+oZZOwVuQxQdx
 AoWl+DZ7zLpe3yBU8m8fREgyZNoby5KUUKTHD6f7YDg==
X-Gm-Gg: AY/fxX69fNg1Ix/g3ZKSbDO6PL73Yisl8KTVLpyi5c5Mnl1TIpz2l/pxkpzoXI1eRcS
 xIyfN1719LyRtnp1Y7ZBZp5EWegzO0mSEZO+u3y8/AwPeiQ7hE/QvvFcJRXIMP59jG5ZAKN8ES4
 320F2wSHNC4Ipa+ZfgrjZneMVVbVguEkL7zsi39ohICCcTBZrTV/4TzayTVN4q0J8vfZaESmKlw
 /JlgPndFRDj4a3LWrtkm8YRBJY6+4WMZlywUM3BixuldjOqU81CH5fzDhMVZVBEntaY4g==
X-Google-Smtp-Source: AGHT+IFuFP0LtKiV97+eoNslgrHWFrLVvnxFh5P/8LPrkipb2iTVuoPVNlLQ8py+nZzblcSGvtaNuaWAsPfL6Xzf1DE=
X-Received: by 2002:a05:6102:1610:b0:5db:debf:6588 with SMTP id
 ada2fe7eead31-5e827475416mr5235709137.9.1765954655604; Tue, 16 Dec 2025
 22:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
 <CAJvnSUCotBFNK46rNrbTqGDy70DPqz782JQHEHa9wtpLzPFPcw@mail.gmail.com>
In-Reply-To: <CAJvnSUCotBFNK46rNrbTqGDy70DPqz782JQHEHa9wtpLzPFPcw@mail.gmail.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 17 Dec 2025 15:57:26 +0900
X-Gm-Features: AQt7F2pTFKbxnZtOjH7Kdb3svtgQ7hf_XsnGyKk4e99tc68tMeV2E7CWwuhsYyk
Message-ID: <CAOaVG141z0jpjYKk-kfY1g+WajFBhYBC=JCLD76haP6_ToZJDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] lib: fix format overflows
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000efe2420646205b9f"
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

--000000000000efe2420646205b9f
Content-Type: text/plain; charset="UTF-8"

There are a number more fixes needed.
Unfortunately all compilers and arch seem to hit different snags

On Wed, Dec 17, 2025, 08:22 Patrick Robb <probb@iol.unh.edu> wrote:

> Recheck-request: iol-intel-Performance
>

--000000000000efe2420646205b9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">There are a number more fixes needed.<div dir=3D"auto">Un=
fortunately all compilers and arch seem to hit different snags</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Dec 17, 2025, 08:22 Patrick Robb &lt;<a href=3D"mai=
lto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Perfo=
rmance</div>
</blockquote></div>

--000000000000efe2420646205b9f--
