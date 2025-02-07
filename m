Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DDFC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:54:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58E4542E90;
	Fri,  7 Feb 2025 18:54:11 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC8B40A7A
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:54:10 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso38442045ad.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738950849;
 x=1739555649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQQlkgYPM1ygG24AlhaM+YrmO75ZjLMrPF1RK01I3po=;
 b=TebnXWbPgLpyaf8sruO4SVN0KloDcKU7h1261zY7cOD0MK6PqpBfg+WpN3BRcL/BGC
 1mO7wI0dfwYJL4zg+SLC/BWoIdW/pk785ojFe+pOGT24rI6CCpJCYi2oRShvML2xzlNU
 tRQlowX2dSfxRm5fGAAu3NEgs94/REDDvTdaxdt+IzTptFDHqVRpsC6UhodA9nykOTZS
 FZ5o5yeJEDSpt0dxm0IMUv9vor/JhRD3oYUjfcHWTz45HYdGt62GhWPkCIKwqAB3REiB
 pIpv7xwZKuP2ioRQj9yJug562CdO0bh55RXUab3V5lILZYbz9ylo2Rs4oVNdv9+8J5lb
 kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738950849; x=1739555649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQQlkgYPM1ygG24AlhaM+YrmO75ZjLMrPF1RK01I3po=;
 b=evgyCujHEQUac2FBDNVD4QAbZEUmlSML32qLe2EM4xBtBgIUKQQ1nV7sXIJkHNJ3Cx
 Az9lGNl79Nsl5+N9z6l+44TL8pX0Pr8tuytFgrU/UEsqmjXMcOaJbTGtFDY+DP3v2Fvx
 /X9et9dSzU2HJCbm91nemPfPTCUHSVcDA0JdLJhxGiBgMq4BZdtWTm5oyoO/MnGkTetz
 QNrOTWONpafQo10n98F/rOYH7xEcq9nZ0aRqKeR/P0n/QHJbwSZuBoo+9fqzn3PtAQXS
 ptQF61Wj5rK27niRyX+sbrT6Nri6/hXvZVNcKgPU2OY+HBVS/amQcOze0jkZkjyd0CVe
 ZhWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5bhZPaYNxKqAvz6B2id//sDYa9nHM2/l3gwf9u1m4zFVTeBbeW0iQo9xAm2UPfS/HqxI=@dpdk.org
X-Gm-Message-State: AOJu0YwjinwFHKaYs+Kz8EV3ps4uQAsnaHYhOH/Cl/zB/5Mpu0kd0SUm
 qzMjAf4fiLMczUsCRC3qM1qgoXcyPTREyzpoi3ZMpvePVYSYPymuhfjFWj3isiGpaHYH9FYJQKT
 9
X-Gm-Gg: ASbGnctRsdVMYRhSb+9pn4uSxJKlpUnpIjSNzXQHpbmZ9eO+2V3Q4LnPAzcbKnkWl51
 /ot1/WJWtw1OkGdlNxjhv8DaLqrt3TUE2dF0snJYJCsaiifjDIG9Snak9XBGNJFrOzoLJ/UI8yW
 tcIv23ZCShcYBRbR8yjH3rJx8Lb5JQjo2MKVZLSzIhoKVlC14g3IHVYGvBllKfgwZnsMjBGd2Zj
 4uCMHszueqdOvPGYmb1O7vWdQBNhhFIG5nP8oE4GV4RIQkI79KgT5mgwFd8u59sdjMlG+FhQGLU
 Z+ECy9zc54adS2cwDS64gx4U6wlxwO40qQ9oNMDnjbd5LNepw3wp9i7hBSW0+axjwEdm
X-Google-Smtp-Source: AGHT+IG0A1714esBQIlDHli73MYYwFHcKA6Hq6QZxXsIw/r2QHtSe/NChyWNXWUo6sCw1M3XiZLjtw==
X-Received: by 2002:a17:903:2b0c:b0:215:7287:67bb with SMTP id
 d9443c01a7336-21f4eff38cdmr70667425ad.0.1738950849342; 
 Fri, 07 Feb 2025 09:54:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c746sm33583785ad.180.2025.02.07.09.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:54:09 -0800 (PST)
Date: Fri, 7 Feb 2025 09:54:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Denis  Davidoglu" <denis.davidoglu@b-ulltech.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>,
 Volkan =?UTF-8?B?QXRsxLE=?= <volkan.atli@b-ulltech.com>
Subject: Re: [PATCH] net: support Arista L2 headers
Message-ID: <20250207095406.2512f18d@hermes.local>
In-Reply-To: <GV1P190MB20415A820BF2090AE8151B2BA1F12@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
References: <GV1P190MB20413FBFFA4FC719AC6E982EA1F42@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
 <4092617.3daJWjYHZt@thomas>
 <GV1P190MB20415A820BF2090AE8151B2BA1F12@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
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

On Fri, 7 Feb 2025 09:07:57 +0000
"Denis  Davidoglu" <denis.davidoglu@b-ulltech.com> wrote:

> From: Thomas Monjalon <thomas@monjalon.net>
> > I'm not familiar with these headers.
> > Are they standardized?
> > Is there a RFC? =20
>=20
> Arista Vendor Specific Protocol is not publicly disclosed yet. However, W=
ireshark already includes a dissector implementetation and its source code =
can serve for now as a reference:
> https://gitlab.com/wireshark/wireshark/-/blob/master/epan/dissectors/pack=
et-avsp.c
>=20
> > I'm not sure about adding vendor specific protocols.
> > What should be the policy here? =20
>=20
> Given the large number of registered EtherType=E2=84=A2 assignments relat=
ed to IEEE 802.3=E2=84=A2 (ISO/IEC 8802-3) standard, supporting vendor-spec=
ific protocols should be considered. Though probably not in the way I organ=
ized it, mixing RFC-standardized and proprietary protocols in the same file=
s. ./lib/net can have a new subdirectory for keeping them separate.=20
>=20
> Arista timestamp is particularly valuable for stock exchanges due to effi=
ciency. The timestamp extension is already in use at German Eurex Exchange =
and it needs to undergo PoC trials at Borsa =C4=B0stanbul, which utilizes N=
asdaq infrastructure. Some parts of it rely on DPDK and this patch will be =
especially useful.


The rte_net_ptype() is intended to provide a software equivalent for the pa=
cket type
matching done in many smart NIC's. It is not meant to be a general purpose =
L2 packet
parser.

If a user needs to do this kind of packet processing, it belongs in the app=
lication
and all the data and metadata is exposed to do this.
