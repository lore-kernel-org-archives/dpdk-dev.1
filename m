Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED89FEFB7C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B601D402E7;
	Fri, 27 Feb 2026 20:18:25 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 94624402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:18:23 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-65c0d2f5fe1so4949968a12.3
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772219903; cv=none;
 d=google.com; s=arc-20240605;
 b=Lz4BUhSPLJytDSOlaIVhm0F9IOn2BbKwYdyZnew4WKptz4PeQF8mEsjxkn0gT1p2tJ
 eVYNnWzFeo6iBY/1S4aSJ+ZpnzPBX++B61NqO4B9ihGAfhssCj8P4FR4RgEe8Rwl9PN2
 Xfq8zl24FWxtcn6E26sVFjHt6W1CW8icSqG0oJ+oBVd0gqJSnqBF3eAtv/TAJHKUIbga
 QcGONY7Jzj6ZFJ4c+jhMLZTmufwT2lKciW5UeKaustsezEEZmjVPR47Woef+QDuBuaus
 Ytr4qwTuvmFl6VHKD+SoLaI341eem6VhXensiyiXaJYyUFdE+xHStl28hh3Kmp/41wUU
 Vp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DgToaoDHWXKMXCJNJqw9xbmQUa/fg4tvYe1Q75ND0mY=;
 fh=ODzzjCetwo0Jol/iq6nP6LutWjTdm2mB3Why6xZx2Ug=;
 b=kNYs4YklGTVRO/OWG9ETkUx4EMzJ71a4oZ43zVk2y6Dwu9ATyyYPcTPcfj9PnIJJ9b
 2ljbxkH4VXWnVik+sHj+d88h+ZdrPK0M2MxQ2Izx2kX1K6eH1uwyC5T9Yi3C5KVJaTgk
 HXByxNZnHkQPxI3sMCUpLWTXp3DKAsZKFi6WAQ3FUR835EM7f6j6O0CbtGRY1h2NoGE5
 oYkLIfUZkcDeQ+hfwI0G/LmMeafiDGWaXMz8pQJ4on99BCoXxwBbsQFkZW2rp7o1C1zu
 zZc63qLBVnbKbrEedOdoQI2RL1ZicPgwiahsss/V+ya7BwlCO2ZSxUaZscvbYfFbop1w
 rUuA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772219903; x=1772824703; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DgToaoDHWXKMXCJNJqw9xbmQUa/fg4tvYe1Q75ND0mY=;
 b=KnbJLhwrOU31AYmGuN3MkuBeQ+JyKPSMNfO2q80wdVLmojrTg3HdUYMjfGtVQ+WqVX
 4W/ppNUxNuft4OTU7+Y3dOZ5yugcdFFA6xRHT8T6jVQ1R9twngO8mDtaajn7L8xqr7EU
 uDn49bvOz93LZGEQ3+wwTVRq03uqJe7TomkGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772219903; x=1772824703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgToaoDHWXKMXCJNJqw9xbmQUa/fg4tvYe1Q75ND0mY=;
 b=OLWWfS6KwECjnjhQOO80QsowPJUmp9eCO8tCPwoWUs3G3oZJwjzQhP9n8K3cx/Xjca
 QDe0AQmNLUJs97RB1HCorsiHtVONIMw680McO4P7aFW9vIhKil1ejGZ81pL8kWWfSfAQ
 HmKmxMKlKgtw903HkRmZJfgqM8y6G3ueSfjzeqtiIMvPmJkrfACPbE9E5Qz/08K40Jso
 idhYfLWK1Oye9sVAbt71t+FsQF4tD0zjRqA4/bYwduiEket0//+qUNianYiEt3NrYcxF
 l/GaZrTr7/6arxOhT/zKPvBz5mOOEUdxsVjK7b5bxYRhfbN6jogqQ/hLV7yHL//UrvQD
 L2/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUC2Y/O4QSb6uZNu5xA29wCKaR9j6HrlMf5pp3epkFiVhXC51CMCXeJv1TaZQs8QfSOHY=@dpdk.org
X-Gm-Message-State: AOJu0YzOsgEKyP2YAtm+bIWBhN7jRXmteVXJLH5vaF+VGsxwuGWFS5c5
 dKrkn9tRQRcYV1eqRlpfD3RzqmJ1/NPYWSVmDG5eRHYFa80kfw0BZPH/l+jorPSnHU2QWX0xL9Q
 pnF1puBX/ndLSSphc1RqeiO00FPtJldW8zxAhD53nkA==
X-Gm-Gg: ATEYQzxDu4kyml5GLCXDjtsG+849hNftXG308bKUB6iqpfaiYWjt53stUpk/NADYUYW
 P3kURwPddvc2AWe91bbXEXgZmGcBlgy2idSG/Tr6OXAXo4QgKGvYqtzH34mRdLpjLA7wQ0Kvw6z
 TU5zOONf5/yDjcwAkC3JeLS7kBmrVeTBepS2gAYYQB70qA8+qge3eL+vwffKTtCc0STFZ2hf4fI
 rKhx9XdeiYrRdxkONS2i0HU3EWPX0Si82Ku3WT/xSL5fvMgUJDR+P6y+ToKNOcPjt5HM1+Dhdte
 6Sv1iwkfTPt7tkOB6Jhx5o35JnEDlcWkbUZlOoiH
X-Received: by 2002:a17:907:97c6:b0:b93:31d0:a865 with SMTP id
 a640c23a62f3a-b93765c781amr303205566b.58.1772219903038; Fri, 27 Feb 2026
 11:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-5-abailey@iol.unh.edu>
 <CAJvnSUCG39GRuw_==7B_Atd91h21ZOyr-rqtGoYskOsxUdBauQ@mail.gmail.com>
In-Reply-To: <CAJvnSUCG39GRuw_==7B_Atd91h21ZOyr-rqtGoYskOsxUdBauQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 27 Feb 2026 14:18:09 -0500
X-Gm-Features: AaiRm52NfbOq1ugNFdi2PmOpxVTGl7GSfAG8Zxj9hqIcd0WzMtThpSTatUxurKI
Message-ID: <CABJ3N2WQ45834P7Kqu8O+L3c6T8WGSRwA-ACXQe=aKOqbGjyDg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dts: add crypto test decorator
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c8e4c8064bd31939"
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

--000000000000c8e4c8064bd31939
Content-Type: text/plain; charset="UTF-8"

>
>
> Have you tested this by running an execution that includes both
> cryptodev tests and ethdev tests (both func and perf)?
>
> Yes, this has been tested and runs cryptodev tests alongside perf/func
tests
with no issues. I will submit a ticket documenting this concern.

--000000000000c8e4c8064bd31939
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
Have you tested this by running an execution that includes both<br>
cryptodev tests and ethdev tests (both func and perf)?<br><br></blockquote>=
<div>Yes, this has been tested and runs cryptodev tests alongside perf/func=
 tests<br>with no issues. I will submit a ticket documenting this concern.<=
/div><div>=C2=A0</div></div></div>

--000000000000c8e4c8064bd31939--
