Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C523CD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 16:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8AB4025A;
	Sat, 20 Jun 2026 18:42:26 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 455F040151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 18:42:24 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30bd7f4fdffso2803282eec.1
 for <dev@dpdk.org>; Sat, 20 Jun 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781973743;
 x=1782578543; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf23bysLAE+MJnYEWWXXXNUGj2kcDnNVGRcVpi1YNCw=;
 b=fXmV/V4j+4w80QYM8m3OMWfswbNcCHiT4ac8ccP2qstgCyqvTiTUhmul6E5P759gLp
 vRKBFNOPV9DUE6wEEVeZbB/Ek/IeHd6FdETmZ6+SN6nAbs06UAK1OZuSVppycGvqAECu
 HStYJVg9yd+T6YPujG8u95VgNFQ4hA5WMs1AB4BKxIE12TYZuoDYZTwla110LhTwWAi0
 kGe6teBxFbZmmE9bnmAKZEDkPzy+mYTQcZgfwkUHBslKeueI1shaIsnyBP4BZ3bqQAkE
 FJB9hSUmDDiGmupvUQei7bnftPI6CZEUvX99CCkOi/VXoIaE/KErixCjRYPLhGki1Pab
 OWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781973743; x=1782578543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jf23bysLAE+MJnYEWWXXXNUGj2kcDnNVGRcVpi1YNCw=;
 b=bvvGyPP3ID+va0o+/qPM6leKM0+ZYnZz10gCPMkix9Njr6z1EXl+fmVT9c6/tM4Gls
 Fr7mbtEgdizOKhDtz7Posehr1b8m9O48wdAWAWkIT7yFd16uz1L1Hj5DhKmL9Ctui5Tg
 Go0Bzu1bDqtzbZn9rvDFt+B08wr2Q2ui6TAwtYqptCIVKtIpmkwgem0O5gd7/GW/TurQ
 AOA62r1ZtloJRvTMxP2RR+hc0HYYq7Jr2pYfqQ0E3LuLiUDCk2F+H5zUO9V1UmlQmkoX
 NdUeyyCzmwrIzrYbPX90wya4SSid5GP206jmb5wqcaMnErdtnTcLKCPgmlV1DRpDrDa4
 odIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MNhxqeGV1w9Y8cQCWLAUxHxNmHpCzoR57+bsNwVk63s9CkhJAepN+C8dI9GYaeRINOEo=@dpdk.org
X-Gm-Message-State: AOJu0Yy6cpUC/R4cZ7InAaNm0cc7r/0EQLzHw/DLKJauAKwHa0DydAzM
 +OSv3HaITj/BxJ+S0sM4rDd62qryYtwlOz4BPrFB/NGcVSeEDDDsTuoXB0seZBk1A8k=
X-Gm-Gg: AfdE7clo5GNGADw31EX2DZWmref/OyFYZLiMykPRFgF3Zsr88BQ1Sy79YomBeHoVnrO
 gcLNUwZWpuKxkJMbSanoyuSzE4ylyHmn3WBsf6EfEtQ/1VNObUxWPjfaYPjiAJixjLnyBSXEQda
 V8zbQfXjCuxuySVe5BOk+Vqf9ip1Mo8ViEnnVZvsz6/IoCklfDaK52IRDV6WSxac0Tk1MO1tsbH
 lLkufyDmjS/UbzN0xMf0QL3HCcGJ/dxiDH82VMw9TzLMh5jccYiZUQD2TXdhxfbeUGBDqUtNZMt
 fIB6Tj0n2Gga7sCXahJKG6DOH5eV7acAqJMBoDr0uC4YHPWCTmjVW/fSDeJyyAMZQSZF1wXOae0
 a++THLX0+TGiXD/XR6txrAzagnk/WTbvr19M1YeX4h+/pBf0Pzw5nl3o6TEsaTCxN7PC2uaWuUy
 HoqAZKsjiUPtx9g3TOldZKyQHCzjPsr1M1bCzkv9s0xMv1vTuId0d2xQ==
X-Received: by 2002:a05:7300:4306:b0:30b:f6cd:fdca with SMTP id
 5a478bee46e88-30c06e0c62bmr6387872eec.17.1781973743100; 
 Sat, 20 Jun 2026 09:42:23 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba8ff05sm4136529eec.11.2026.06.20.09.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 09:42:22 -0700 (PDT)
Date: Sat, 20 Jun 2026 09:42:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Huisong Li"
 <lihuisong@huawei.com>, <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Message-ID: <20260620094220.10047bf2@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6592C@smartserver.smartshare.dk>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local>
 <ApV03BBBSN-iQgiffDgXRg@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65929@smartserver.smartshare.dk>
 <20260619083934.510bd2d4@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6592C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 19 Jun 2026 22:11:02 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 19 June 2026 17.40
> >=20
> > On Fri, 19 Jun 2026 09:54:51 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > > The problem with this patch it causes build failures now with abi=
 =20
> > > > diff.
> > > >
> > > > It is probably a bug of an old version of abidiff.
> > > > I recommend updating. =20
> > >
> > > With the #define's the ABI has not changed. It's probably too =20
> > indirect for abidiff to understand. =20
> > > If we absolutely want to please abidiff, we could keep the existing =
=20
> > enums and #define RTE_LCORE_ROLE_RTE ROLE_RTE for now. =20
> > > But I'm in favor of what was done already. =20
> >=20
> > The build failures on github, not in my local builds.
> > https://github.com/ovsrobot/dpdk/actions/runs/27789889172/job/822359650
> > 90
> >=20
> > It makes looking at patchwork dashboard difficult, all patches show up
> > with red mark =20
>=20
> So maybe we can choose the path of pleasing abidiff...
> Keep the existing enums, and #define the new RTE_LCORE_ prefixed variants=
, and use those in the code.
>=20
> Later, with an ABI breaking release, we can swap.
> Or maybe we just wait until an ABI breaking release to fix this.
>=20

Since change is cosmetic, not functional. I think it should be reverted for=
 26.07
to get github CI to pass on all platforms.

It can be added back in 26.11
