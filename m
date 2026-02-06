Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED97EE6B4C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 19:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5641340276;
	Fri,  6 Feb 2026 20:18:27 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id EF79E4026F
 for <dev@dpdk.org>; Fri,  6 Feb 2026 20:18:25 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so25198735e9.1
 for <dev@dpdk.org>; Fri, 06 Feb 2026 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770405505;
 x=1771010305; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oywU6B8neUpT7xNW68ncnIB4FzmpqfQh9qf/sySWQw=;
 b=YeQTdIXJQWF8oZJV1wPHc988hUrrcat+3R229FDR5Lz/rw9NgY6rbo0gyWRY+TqI4s
 ObITKIox/1hTg5y8HytVqZpG/Tvg7vT/GIrStUx+SuMgSUO05MNfOpwXlaUkmXZpdVVb
 xdlkvivrwgFbLnLSFvBwpkC6zCHPXSUtZuU1huBsOUFbvcRwbWV2+plDsma/vi60Tlr7
 DlipxkcExG3VTUOZnxaJh69eXMvba0sFlx7aTgmZ1MmYpoZsTHldgbDlT/k8Ix2QIF4q
 Tk4VhbwmKJIOVHIXDRCqkl6QhG9Z6rU2kqcn8TBSY8qrILjzXKCEvaFPaODA5jg99H4Y
 uWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770405505; x=1771010305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+oywU6B8neUpT7xNW68ncnIB4FzmpqfQh9qf/sySWQw=;
 b=Ei8kqVp4KDtTrTa7O/TEPmmWcbfRz166Z9CwX5fMVMyUaFGaUmKcSgkRlrLuOvr+3y
 l1DTKGTFzn8w7LsvHgcX1WLIw41cdNl3rk9JppVnazu9EGbWTlDQ6SJ7aj9x8feD8Q3Z
 6O79VrpbzEYV/We7TsSOR2WRxTBS9Y3J+G/9tjBchmCsur3hq4Trwzu3s3H91eUwGiOw
 ez8ESlgWt+1jOhxRjcfuzK0dtP6QWdHeTGGiu0xGFH2Y48SZ+K9tL0uFZpWlWjDpef31
 meHAGoVx7AgHCGXEIh9i1PLYdTBGCSVTInvk5DmbAtiNFrctifA+SID7Qto8KqmCHod6
 Q6nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ3WlRYQ0NmldYgbfQtcqnnSW5uSCLNXDfh5yuv893HCHQjx+6mvvdYkitkgTFGS3u7WE=@dpdk.org
X-Gm-Message-State: AOJu0YzPgkZYVS5iP+K8qCCGvopEVJKULDCw5p9isysGN4FBVyz/BOcX
 p+v0Mlfa7A/NYEqOIIEMiqAUy2NvoeftjOLAksYvIPgNAwsHq5rlbYuj0w0GAeBedbPYC8dtf+A
 k6o7M
X-Gm-Gg: AZuq6aIBWGqSn9CTm4dQfJZNOJYWfe+Ib+ErJlpd2Xyp0zax+hgdxTA/9SFzmh3xfgd
 hLkdlABvMmQnzWKwacTgxD6/YEGUrZCDEVMqvw1jaoLvSeNh+WoxgHBhcSWIkH3I0a6Nl3vMS+p
 KPWjy1OhwAixxEn8YLVE+SzKS9jmbQbBEfEMrBtoXF+pOmNYGUpxGF0XaIGfyLXCZuu8wqOOat2
 Aka+Sm+IS7Qk59SKE3HPNjSBOZmjUHGcO7K/+bqmdFA0aoN/NlWk4/xUIJ0s8nkMSFDsazphXkN
 nxFFIk4/2RPkLheAynXj7RR5GUfCwFxa0n40JIOC7FjfFT1rYmYv+TanIHv5IilCdPMdA+8zjk1
 rp6F69YV1mdtCwf+GSKvOUUYdrNMmwQVV1uMyC3Hy+aLOtIIXx5lpJ38n1s7lUCNi2BPGdZd70V
 1xopJBJ5RHMXm4PiN1tGz1vsagEi1amaxVvCfrP898tRBcibG33NRR
X-Received: by 2002:a05:600c:6612:b0:480:1c53:208b with SMTP id
 5b1f17b1804b1-483202308fcmr62125685e9.36.1770405505059; 
 Fri, 06 Feb 2026 11:18:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320638ff7sm78188045e9.0.2026.02.06.11.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 11:18:24 -0800 (PST)
Date: Fri, 6 Feb 2026 08:11:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <scott.k.mitch1@gmail.com>, <dev@dpdk.org>
Subject: Re: [PATCH v6 0/4] af_packet correctness, performance, cksum
Message-ID: <20260206081120.693af79e@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656F0@smartserver.smartshare.dk>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
 <20260205174901.462eddb1@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F656F0@smartserver.smartshare.dk>
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

On Fri, 6 Feb 2026 15:36:37 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 6 February 2026 02.49
> >=20
> > Why are the header structures marked packed, that is bogus, BSD and
> > Linux don't do it. =20
>=20
> They have been packed since the first public release in 2013 [1].
>=20
> I guess it's because the IP and TCP headers contain 4-byte fields, which =
make those structures 4-byte aligned; but since the IP header follows a 14 =
byte Ethernet header (without the magic 2-byte pre-padding done by the kern=
el), the instances of the IP header are not 4-byte aligned, but 2-byte alig=
ned. Marking them packed is a way of stripping the alignment.
>=20
> BTW, the IPv4 header was bumped (from no alignment) to 2-byte alignment w=
ith patch [2].
>=20
> [1]: https://github.com/DPDK/dpdk/commit/af75078fece3615088e561357c1e9760=
3e43a5fe#diff-620c2b2031359304a7f26328a52035c9f8ddf722b9280f957047dcb814677=
77f
> [2]: https://github.com/DPDK/dpdk/commit/c14fba68edfa4aeba7c0dfb5dbc3b4f2=
3affbb81
>=20
>=20
> > Windows probably does  =20
>=20
> Yes, probably.
> The Microsoft compiler is more pedantic (leading to fewer bugs), and many=
 of those structures should formally be packed (or more correctly: unaligne=
d).
>=20
> > but Windows code seems to love packed even when
> > it is not necessary. =20
>=20
> I guess packing (without thinking about the need for it) has become a bad=
 habit for some Windows programmers.
>=20

Making structure packed (in the past) made code slower on some architecture=
s because
it required generating multiple load/store operations.
