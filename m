Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F1FD9E12
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 21:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777EC402B2;
	Thu, 26 Feb 2026 22:17:02 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 741DD4026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 22:17:01 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bdbe434b47so2901860eec.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772140620;
 x=1772745420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7N5e/t1YT3HjX6pKgRwpkhRwHli7Ba3vKkAv1158HrY=;
 b=dva9fKfSJDVyFgjNvmyAnSYGN1mwxEwxNMk135+trgWJ2sHwOlDSD7VfK1u3+YlpJ0
 PzWMaPixJa8NgWvaiVKlbCgA/SZPKDrrodl3L8oxIhpDP0cRIyb7n7c+8gU1xuqiAoZN
 tpGce2/I0yBMe2359l8MBtHlWvXUkp1ddHMSyMmuHgj5WQui9cXPwi+e1de8+JIKWGqt
 zG670t/tuK5+rYxqxw71AFtujwGr3REXJipdhSaOfDBMAAXfRBILqZy9W7rC8Kbwt1Kg
 hbqD2/f1WslyrL9+XBp70J2xZHU4xLvjRwOf6sInkFKheM0WbDDeHBA/SY5cYk1X7K1I
 xCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772140620; x=1772745420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7N5e/t1YT3HjX6pKgRwpkhRwHli7Ba3vKkAv1158HrY=;
 b=DlO2zoGX4aqxw6PCFgkA6VrSmq+Vn6eOBxm7EDS20+lqfjAEncxX+2Lrw4by/G8BdW
 2BzMXG+t6oQ6C49ABdeBD8pEBz4NEhuBPYeaZQbZCzziC6U4YmZWgMkaaBKiK/UPmuFp
 iQgd4VZ9MnyLbCXGxb7o6a+dYkC/NnpC6eOtQlW/X8akieuPuyTDEIeTeWWtqiyr4efw
 Ji0J+jSYCwttyWj3uQqoAoCH9+YvU4fVR9vKNFpGIyZW/9QcFSrmxtzunfrs6uCqTv2b
 5bPp00omC19XB7rrrdSG17UztqLErDDuMW1HMik9Hr3Vuv434yY8fUyCoKEYkIFjSxgD
 YlHg==
X-Gm-Message-State: AOJu0Yw/zfPAQLBHxig+G5fmwaSGh9dfvri5AFZR8Dwrm/2WEoCjwhOq
 aAlaTBZOS+Y/JM/Vc1mokH4ImFmI2J0Gu6qyeAFoi6cFUszt0m3lBed/QXbTIARTUNg=
X-Gm-Gg: ATEYQzwyrbD7nmjiltzwMD8ltkbm0DK2s1i8WHe9CMAN2sqLkcANVq2LAVEFgjsTSXu
 irogDNjDGTAZQnwz+yMwPHTUAyMcpXxk2xBl6oZyUbO9A793FvkcS2r1pqjw+mYtQf4Xv/STjfx
 3So1BzaiOF0+2FY24ssmzzUNuU4gi/0aF4rC6kIfU49QeJQCQ1OYkqIRrS3/0OwS5o14aJXpKKt
 VKc2DWn0BjpeIXe1rGYbr99fffevY/FK67nXh81/CxoFIYu9Trri3+R2LZd/lavcP/h7vV+JPKW
 9xV3rUm/YWdHDP2HJqKGLhIr+7Vttc1l847TWZ49cy/w3auC52uJ+RTJR5UPCtzrbi1Iids6O3L
 DJq4JPNGDHYxeWmV9W6a2SUgxeLQI1jHJe+OHarrB2neohWKg697AsAoPp8GjP2fgTsJ7WZVkv2
 QW3pzweNyMWnb7Iku0VBj0Ql541lKZsWCnvOGD0QCDhQ7C5kaT8nXiT+Xij41s6Wop
X-Received: by 2002:a05:7300:8cac:b0:2ba:956e:d26a with SMTP id
 5a478bee46e88-2bde1d6e182mr197100eec.36.1772140620166; 
 Thu, 26 Feb 2026 13:17:00 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c01sm2738757eec.16.2026.02.26.13.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 13:16:59 -0800 (PST)
Date: Thu, 26 Feb 2026 13:16:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Message-ID: <20260226131656.455bc76f@phoenix.local>
In-Reply-To: <PH0PR18MB40866F9E996747CAF9CA5443DE72A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225094338.5f0641a5@phoenix.local>
 <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225142004.07954fd2@phoenix.local>
 <PH0PR18MB40866F9E996747CAF9CA5443DE72A@PH0PR18MB4086.namprd18.prod.outlook.com>
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

On Thu, 26 Feb 2026 04:50:01 +0000
Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:

> >> >Good idea, but fails miserably. =20
> >>
> >> My bad, here is the full fix, verified on our arm64 machine with
> >> meson setup build -Dplatform=3Dgeneric =20
> >
> >
> >Ok but other than getting more build coverage, is there any point in
> >building this code on a generic platform? =20
>=20
> The driver can be used with distro packages, though it won=E2=80=99t be o=
ptimized for performance.


With some defuzzing of the diff, got it to build.
The old build time was 11 minutes, now down to 2:33.

Here is what was needed to get rid of uninit warnings:


 drivers/event/cnxk/meson.build |  5 +++++
 drivers/net/cnxk/cn10k_tx.h    | 34 +++++++++++++++++-----------------
 drivers/net/cnxk/cn9k_tx.h     |  6 +++---
 drivers/net/cnxk/meson.build   |  5 +++++
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 24b48d045f..c21e01c930 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -36,6 +36,11 @@ if meson.version().version_compare('>=3D1.1.0')
         endif
 endif
=20
+if soc_type =3D=3D 'all'
+    disable_template =3D true
+    cflags +=3D '-DCNXK_DIS_TMPLT_FUNC'
+endif
+
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
 sources +=3D files(
         'cn9k_eventdev.c',
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index be9e020ac5..05a82cfe7d 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -1445,7 +1445,7 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, str=
uct rte_mbuf **tx_pkts,
 {
 	struct cn10k_eth_txq *txq =3D tx_queue;
 	const rte_iova_t io_addr =3D txq->io_addr;
-	uint8_t lnum, c_lnum, c_shft, c_loff;
+	uint8_t lnum, c_lnum =3D 0, c_shft =3D 0, c_loff =3D 0;
 	uintptr_t pa, lbase =3D txq->lmt_base;
 	uint16_t lmt_id, burst, left, i;
 	struct rte_mbuf *extm =3D NULL;
@@ -1453,9 +1453,9 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, str=
uct rte_mbuf **tx_pkts,
 	uint64_t lso_tun_fmt =3D 0;
 	uint64_t mark_fmt =3D 0;
 	uint8_t mark_flag =3D 0;
-	rte_iova_t c_io_addr;
-	uint16_t c_lmt_id;
-	uint64_t sa_base;
+	rte_iova_t c_io_addr =3D 0;
+	uint16_t c_lmt_id =3D 0;
+	uint64_t sa_base =3D 0;
 	uintptr_t laddr;
 	uint64_t data;
 	bool sec;
@@ -1599,17 +1599,17 @@ cn10k_nix_xmit_pkts_mseg(void *tx_queue, uint64_t *=
ws,
 	const rte_iova_t io_addr =3D txq->io_addr;
 	uint16_t segdw, lmt_id, burst, left, i;
 	struct rte_mbuf *extm =3D NULL;
-	uint8_t lnum, c_lnum, c_loff;
+	uint8_t lnum, c_lnum =3D 0, c_loff =3D 0;
 	uintptr_t c_lbase =3D lbase;
 	uint64_t lso_tun_fmt =3D 0;
 	uint64_t mark_fmt =3D 0;
 	uint8_t mark_flag =3D 0;
 	uint64_t data0, data1;
 	rte_iova_t c_io_addr;
-	uint8_t shft, c_shft;
+	uint8_t shft, c_shft =3D 0;
 	__uint128_t data128;
 	uint16_t c_lmt_id;
-	uint64_t sa_base;
+	uint64_t sa_base =3D 0;
 	uintptr_t laddr;
 	bool sec;
=20
@@ -2166,14 +2166,14 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t=
 *ws,
 	uint64x2_t len_olflags0, len_olflags1, len_olflags2, len_olflags3;
 	uint64x2_t cmd0[NIX_DESCS_PER_LOOP], cmd1[NIX_DESCS_PER_LOOP],
 		cmd2[NIX_DESCS_PER_LOOP], cmd3[NIX_DESCS_PER_LOOP];
-	uint16_t left, scalar, burst, i, lmt_id, c_lmt_id;
+	uint16_t left, scalar, burst, i, lmt_id, c_lmt_id =3D 0;
 	uint64_t *mbuf0, *mbuf1, *mbuf2, *mbuf3, pa;
-	uint64x2_t senddesc01_w0, senddesc23_w0;
-	uint64x2_t senddesc01_w1, senddesc23_w1;
-	uint64x2_t sendext01_w0, sendext23_w0;
-	uint64x2_t sendext01_w1, sendext23_w1;
-	uint64x2_t sendmem01_w0, sendmem23_w0;
-	uint64x2_t sendmem01_w1, sendmem23_w1;
+	uint64x2_t senddesc01_w0 =3D {0}, senddesc23_w0 =3D {0};
+	uint64x2_t senddesc01_w1 =3D {0}, senddesc23_w1 =3D {0};
+	uint64x2_t sendext01_w0 =3D {0}, sendext23_w0 =3D {0};
+	uint64x2_t sendext01_w1 =3D {0}, sendext23_w1 =3D {0};
+	uint64x2_t sendmem01_w0 =3D {0}, sendmem23_w0 =3D {0};
+	uint64x2_t sendmem01_w1 =3D {0}, sendmem23_w1;
 	uint8_t segdw[NIX_DESCS_PER_LOOP + 1];
 	uint64x2_t sgdesc01_w0, sgdesc23_w0;
 	uint64x2_t sgdesc01_w1, sgdesc23_w1;
@@ -2181,13 +2181,13 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t=
 *ws,
 	rte_iova_t io_addr =3D txq->io_addr;
 	uint8_t lnum, shift =3D 0, loff =3D 0;
 	uintptr_t laddr =3D txq->lmt_base;
-	uint8_t c_lnum, c_shft, c_loff;
+	uint8_t c_lnum =3D 0, c_shft =3D 0, c_loff =3D 0;
 	uint64x2_t ltypes01, ltypes23;
 	uint64x2_t xtmp128, ytmp128;
 	uint64x2_t xmask01, xmask23;
 	uintptr_t c_laddr =3D laddr;
-	rte_iova_t c_io_addr;
-	uint64_t sa_base;
+	rte_iova_t c_io_addr =3D 0;
+	uint64_t sa_base =3D 0;
 	union wdata {
 		__uint128_t data128;
 		uint64_t data[2];
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 14594b6311..8c9e84f64b 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -1185,10 +1185,10 @@ cn9k_nix_xmit_pkts_vector(void *tx_queue, struct rt=
e_mbuf **tx_pkts,
 	uint64_t *mbuf0, *mbuf1, *mbuf2, *mbuf3;
 	uint64x2_t senddesc01_w0, senddesc23_w0;
 	uint64x2_t senddesc01_w1, senddesc23_w1;
-	uint64x2_t sendext01_w0, sendext23_w0;
-	uint64x2_t sendext01_w1, sendext23_w1;
+	uint64x2_t sendext01_w0 =3D {0}, sendext23_w0 =3D {0};
+	uint64x2_t sendext01_w1 =3D {0}, sendext23_w1 =3D {0};
 	uint64x2_t sendmem01_w0, sendmem23_w0;
-	uint64x2_t sendmem01_w1, sendmem23_w1;
+	uint64x2_t sendmem01_w1 =3D {0}, sendmem23_w1;
 	uint64x2_t sgdesc01_w0, sgdesc23_w0;
 	uint64x2_t sgdesc01_w1, sgdesc23_w1;
 	struct cn9k_eth_txq *txq =3D tx_queue;
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 53caa6c171..a0d9849595 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -52,6 +52,11 @@ if meson.version().version_compare('>=3D1.1.0')
         endif
 endif
=20
+if soc_type =3D=3D 'all'
+    disable_template =3D true
+    cflags +=3D '-DCNXK_DIS_TMPLT_FUNC'
+endif
+
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
 # CN9K
 sources +=3D files(
--=20
2.39.5

