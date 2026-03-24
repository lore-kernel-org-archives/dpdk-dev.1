Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89F9F54ADB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69DA402DA;
	Tue, 24 Mar 2026 18:03:26 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5216F4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:03:25 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cd78a4ce8dso532806185a.3
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774371805; cv=none;
 d=google.com; s=arc-20240605;
 b=h0q24u1jxedSm4u7HhBhE82g7nhT9tfUVqyT50Icn1TOs9R3u7Q9LdOR7tsolxJtxj
 nIti/0kcYv/k/vAVHZ24Q5/5lHQRZGEOxko23Aa3dUIeMPJbjtZPOQ+WPuofvca6tiTq
 8dUHHXROCCLcW8X3WviGsFGjCF1KYecfYpiOrtniUwN0tcI6sAzef9is+C89n3b4M6dg
 pY8Zb1rApPAN87qiy7UoVaHpC+1xqY3w1lzaMH5ohcuX3af3+XpNh7OdrzjIf42RNsSd
 7tTgnlp1pW0m1E0wjxl+uK/0VUYFkoMSLma8qkMy4ER4p66p1dnTZL1Y1ueRDLDuXAJt
 Ey7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/HDB/GHqLpwvUO5fXO5thOVPiwQMYccuWtVy1dyH+bA=;
 fh=41iVodsr3xb8e6USruKcK9kkss4LUSGEnSIANacUTsg=;
 b=GfncHkCxojPtzwl9bdCyx7h9U3w7Bpu4aifD75YcrF5Lxu0FGW5ruCn9BBxdHqsxvk
 dv+NVxqf7lmoFCdCXkTap6mFwiVkzUMNSUKAPSCNNkxlnMnxtGu8B9grgVqi2z/TQbeh
 jQB0diMv0qi9ejqlImTzZ0oT/aouORURgJ3ehdZBUCWRFBgSYCzix2ANiroIVrlV1CkM
 NxK2u034wscgv3jogan7Y5gQZkbC9z5lavD8zK5AitgKT/N9GO/GKiMdHkP/OkfENRGF
 vba6cYAC5kahMkdNArlDtlBpeDxA+Sph1QQKWvRy7idZ8pYEcls7gf+jgDpUdsQB+xzF
 KXYA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774371804; x=1774976604; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HDB/GHqLpwvUO5fXO5thOVPiwQMYccuWtVy1dyH+bA=;
 b=qypaSCx+9Seu0FdWC5EO7ngHLc2CnPPqZuIajd5G4aICgclgQUcvArmmp7hCe2lcC1
 fCQYaDiPbtXgZ336mpzKF37jRutX4Wo4Q3bGQnXBoEBEtcAXgEq9A2PHnDtu/0e3h4Wx
 DNsBNln9uX+cZE44wDjDGqWPslFR7lACO5aZrhnjL+ZAUiW8dmPALuqXOspt6NfyJy1V
 jE9G8JTpbsRBcOspy+VYeIyX4kShWj6PzqWd3ftD3IQpMfgiZJ9bu1weuN7fKP9K9uw3
 PIH3JdB2l9ozaEquqoC3VUTkfOLlgx6k2545N688M+cmh99HvAKhfeLyS3zIgbFOb6XL
 z3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371805; x=1774976605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/HDB/GHqLpwvUO5fXO5thOVPiwQMYccuWtVy1dyH+bA=;
 b=daWUI80woBC3nr3yzaXhrIrPLhX3GbDLJIsIJ36SuDnN9KDoHz6vgt/Q+z8SdHdedd
 EmXdngCUlbygvJk4baq8Wk8ySoRb8XlRcU+7oml7F2aOgNEZ+P4V95noOEvYm207Sjhl
 gjSzrB/zsVt+CkKKgFJBfoevCTG34h24FXO9HgAwASPyDWKJyaQgh939+4fKLRxFNo2z
 GIysQYUbaPXfzyaIgogzzf5SMeI7SVHeKzE+hfLwxUSkliAhsruj550zOuFErVj3Ln93
 QHma8kcrgwvIyMFupbG4+JZQTHwor2ekKVU6sOqPqVCX7GZxEFOPpoTZHeXUCBNN7Ccy
 58GQ==
X-Gm-Message-State: AOJu0YybfOdsBfxi85wZ0AJ3Ivdecv1s8SIF4XSoWrmhusNAYEccZLWC
 szKKDsHSdRmJwd/CbW23Fl+UKEKEp60dCK8bKXzKiFVbVkAp6bvBWAI9mhjHQqfscivUt6uXhdn
 yl5HNcwf6viOl/ko3DMRNCQw0gS1WfH8=
X-Gm-Gg: ATEYQzz9IZAkp4+V2f1R17siBJhREZ4DHO9HNpAORgwkkuygfHqoWYKTiDbChYioQ/U
 NXVEE4zIe8RvAm8GLuf1doOXfCYS+Q0+JitP6ApQQRMEwCuXz2WcqEqf0v5mdAqiddlp3tVoT5t
 16fXUax660NhZPj07MhpWH2p5pTYsXZgBFLK5tZ8uAz330AZtdNIBja65mt7yPcN/ct0RKfICer
 1jNZeil1AlM4IVjZ00BxWIIwy85ErvVYVllb2oPkyjG8VybnJrMWwkNFJXxgiHyGXX6cZJH17A0
 mXxOvu6d0s1P3Q==
X-Received: by 2002:a05:6214:4292:b0:89c:78dd:6779 with SMTP id
 6a1803df08f44-89cc49bb0camr6531996d6.13.1774371804371; Tue, 24 Mar 2026
 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260316055057.4174060-1-nkishor@marvell.com>
 <20260316062720.4181631-1-nkishor@marvell.com>
 <DS0PR18MB527043A961B565998B9D139CB24FA@DS0PR18MB5270.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB527043A961B565998B9D139CB24FA@DS0PR18MB5270.namprd18.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 22:32:58 +0530
X-Gm-Features: AaiRm5030xfMWnnBMpXvPEBkBwYZy8_2xBfzaAjOjXmI6NqwjSE0qiWKAxB84ro
Message-ID: <CALBAE1NDU_R+zMO8bw-QNwephd_WOoUB5SrxT9idTRfYOoKNog@mail.gmail.com>
Subject: Re: [PATCH v2] common/cnxk: add NPA diagnostic and performance
 counter apis
To: Nawal Kishor <nkishor@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Ashwin Sekhar T K <asekhar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 19, 2026 at 2:10=E2=80=AFPM Nawal Kishor <nkishor@marvell.com> =
wrote:
>
> Recheck-request: iol-unit-arm64-testing

Applied to dpdk-next-net-mrvl/for-main. Thanks
