Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C2C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 16:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49EDA4013F;
	Thu, 17 Jul 2025 18:58:41 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 21576400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 18:58:40 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ab8e2c85d7so16244891cf.2
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752771519;
 x=1753376319; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nXzsfYSY4BhyiyNKwpr/KIhjNzDnJ9o0N1AfCN4OLg=;
 b=jpCs1NpHY+9a3EQrqzlIe94kjTdcqsIXwDEHi7HiTpiOHWHvBbA8Yq/v8V46B4NoaQ
 PRGHaOzlTQj/Wh4EE3s17439cYzy17klzIOPZb2Vv9jiJTSLg4x0Uoq+4AiW+qAJ8rFn
 sMw4r4AE8B8h1K2EXbzkJMORkOecdpxUATu955IDiP/NsorseOk18CXSOQ3XBVGRH5mC
 o8s0uWFmJ9feQ/D6E26oJFfD7yrJ76t9+HPV2eNXZfTLKHy7qUTX/aNU4wfRSe6x77p6
 rSlOEQ1QqyFu4d3cInyq8rwtXdCLev0ns92U52MO1QpXnELcAflnmf5YrixLlmG6v5Ow
 sQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771519; x=1753376319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nXzsfYSY4BhyiyNKwpr/KIhjNzDnJ9o0N1AfCN4OLg=;
 b=U6y4YV0zBuqbCQr4CZa8uJ5Wi7jkN77JWyEIV87HfIVg4vq+s6oLlq0lMi5ezPz+FO
 ZUPlFCbLlBSD2PlhnzJS4zhT7EslNtRK9gLSD5lCjW170krdhJ5bQ+IiPKzARqvUIeEc
 dnyAkvZjmvR3u8z9ovkTbG18XGUvERHwu27CbPDG7N+AnJfbnjzmRZHnmVKiI4cPKiKE
 AfCv4JOjpOH+a3gzEhBIhmqTILdy8WyyRCGLldpAkkTNr9ZXq6dIKqluQEf8wLl5ofuY
 PQdQN8nRJk5cLieQCVeZGF2v9RV4aP03gqHnf/FT7KRtbE3moih0YWXNFuIG2Wi2PusZ
 61wg==
X-Gm-Message-State: AOJu0Yybb/hk6dsp6kApwopu4pCQDH8pVcXgmJOdz2gSnHizfsslysNO
 LwaVjiM2POOP1UMndfUgW5GB/tdpwGDg4P34PAdFF8jUT3a90AM3YziJVNBdToGz4ejIVtQlki3
 KAD8v
X-Gm-Gg: ASbGncsjzOz8hYEoYMCrGNpEeIAPgwXf0zMbKofJflfljX6cQRZjoTwUQfhvyDcttdQ
 LffucioTP1wchybX+d1JRl7Ao9RdhWae0Iz6arCdWR5imfXygkretyLPlT5uWi6+5gqxjmovFNY
 CsdWNX9PsXKB6BdXEUyjZvPZSktG/PlWICiaK37PCQWXxJiFLjrP2tLzIvrSVWr1sZE2iOuDzX1
 a3SgE66BJHhVgFo6DJ8Ie7m5r3nUcfzKTWsulwlBLf7ijEOGZQjnrWwbZCI7LgNedDEgv+xkOs6
 R4gy2W8sSCCvd1XzFz2k+h+W9+mDUAGA07mbNiX4G7lvd6tza+14GADDiNI2cGKwxuaqMXoMSwy
 A4KCmFWiNZhGUfGGS/Mp4VGcJY+bHGOvmufPBPF5K1erFBycIKnbUJ4hkYWt4OwkyHPhMjVZyOm
 g=
X-Google-Smtp-Source: AGHT+IE5JPWFMj4ROfwdX+n6wHXcl6nBafkHAfzdcNxhJjFPU3PzA5JRE2Dsi2scBJBsZLt0UQENTg==
X-Received: by 2002:a05:6214:76e:b0:704:9526:6e54 with SMTP id
 6a1803df08f44-704f6ac7f6emr104412246d6.3.1752771519356; 
 Thu, 17 Jul 2025 09:58:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979e2324sm86040206d6.39.2025.07.17.09.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:58:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:58:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Message-ID: <20250717095836.503111f9@hermes.local>
In-Reply-To: <AS8PR04MB81984927114BE947589A905EE146A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250629102535.154ea015@hermes.local>
 <AS8PR04MB81984927114BE947589A905EE146A@AS8PR04MB8198.eurprd04.prod.outlook.com>
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

Too late for 25.07 now. But will put in next-net for 25.11

I notice if shadow declaration warning is enabled, lots of
warning occur.


In file included from ../drivers/net/dpaa2/dpaa2_ethdev.c:26:
../drivers/net/dpaa2/dpaa2_ethdev.c: In function =E2=80=98dpaa2_alloc_rx_tx=
_queues=E2=80=99:
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:13: warning: declaration of =
=E2=80=98ret=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |             ^~~
../drivers/net/dpaa2/dpaa2_ethdev.c:393:23: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  393 |                 ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:16: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |                ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:22: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |                      ^
../drivers/net/dpaa2/dpaa2_ethdev.c:393:23: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  393 |                 ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:13: warning: declaration of =
=E2=80=98ret=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |             ^~~
../drivers/net/dpaa2/dpaa2_ethdev.c:408:23: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  408 |                 ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:16: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |                ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:22: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |                      ^
../drivers/net/dpaa2/dpaa2_ethdev.c:408:23: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  408 |                 ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:13: warning: declaration of =
=E2=80=98ret=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |             ^~~
../drivers/net/dpaa2/dpaa2_ethdev.c:435:31: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  435 |                         ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:16: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |                ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:22: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |                      ^
../drivers/net/dpaa2/dpaa2_ethdev.c:435:31: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_alloc=E2=80=99
  435 |                         ret =3D dpaa2_queue_storage_alloc(dpaa2_q,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c:455:17: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_free=E2=80=99
  455 |                 dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c:472:17: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_free=E2=80=99
  472 |                 dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c:478:17: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_free=E2=80=99
  478 |                 dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:372:13: note: shadowed declaration is h=
ere
  372 |         int i, ret =3D 0;
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c: In function =E2=80=98dpaa2_free_rx_tx_=
queues=E2=80=99:
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c:499:25: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_free=E2=80=99
  499 |                         dpaa2_queue_storage_free(dpaa2_q,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:490:13: note: shadowed declaration is h=
ere
  490 |         int i;
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99 shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/net/dpaa2/dpaa2_ethdev.c:511:33: note: in expansion of macro =E2=
=80=98dpaa2_queue_storage_free=E2=80=99
  511 |                                 dpaa2_queue_storage_free(dpaa2_q,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dpaa2/dpaa2_ethdev.c:490:13: note: shadowed declaration is h=
ere
  490 |         int i;
      |             ^
[50/168] Compiling C object drivers/li...net_dpaa2.a.p/net_dpaa2_dpaa2_rxtx=
.c.o
../drivers/net/dpaa2/dpaa2_rxtx.c: In function =E2=80=98dpaa2_dev_tx=E2=80=
=99:
../drivers/net/dpaa2/dpaa2_rxtx.c:1393:37: warning: declaration of =E2=80=
=98ret=E2=80=99 shadows a previous local [-Wshadow]
 1393 |                                 int ret =3D rte_vlan_insert(bufs);
      |                                     ^~~
../drivers/net/dpaa2/dpaa2_rxtx.c:1250:17: note: shadowed declaration is he=
re
 1250 |         int32_t ret;
