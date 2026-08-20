Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE3C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 16:23:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68223402BA;
	Thu, 20 Aug 2026 18:23:07 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 00D444026D
 for <dev@dpdk.org>; Thu, 20 Aug 2026 18:23:05 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso746797a12.1
 for <dev@dpdk.org>; Thu, 20 Aug 2026 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787242985;
 x=1787847785; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v5odXuNGazYuQLyWPFZP8qBg1/PPcMGXlyL/3yyyaEI=;
 b=BinVzjBjYMwNspDPBKw1c8XPyEgydJ19i/2ZGAnQ4AUjWU9er8tTAE3p+AbXQzjcTP
 X9w2hYFlAfSeklwDEY97n1/2tI8/0ZrhA1lEnhf03VgwcaEacw7oguQ9tvh8Kekejfdy
 5R8oGF6GJ5S4mZZrEstThFZEEpQdNskBDd+K0POeKkMxdBu9M8Yj7zyRB6kos9g2Lb6N
 T6IagSTLWtpZe9WLdyxdaYC2lq/i6UwzmCaVoA5VcgPEfLCq7oJkc4GmGT+JeR35Nkcs
 d8ZdO63yOz6NT2wY193JeUE6oIrfsb4dAMP30/FE9A0f2zJqW233+Cono9cdw0ZG/wHt
 pYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787242985; x=1787847785;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v5odXuNGazYuQLyWPFZP8qBg1/PPcMGXlyL/3yyyaEI=;
 b=FJ4mUA7XYODCGlVoaUQJZU3WLk94S+zuPDCGGOZyv51CPug67rBw2kelis+tD3uo2V
 HupAJ/bVhOHRTwrCEL4J1WmlXJdZxqJRSSF+lBcGen8EiTHYHyaqualelDo26MJoOy82
 B/U2/K/kclXGEDhnAjLwHKCP5kYfQ3NnFJHzW3m9z8/Yda6TCxBOJB3TMOVpTIeJ2E58
 eyTBuAUB+V8TJ7rJuSOt/a+plE5OGOXK0tjewOKqms29GIjKZ4KTfuPMY4YxwQBbF3wx
 3VnGoxCa9TiskrgTtbWbkc9GdOBkXe5ZofVIImPUK/MiI0PPx1tQSssA/cxIwE+oriRz
 u86A==
X-Gm-Message-State: AFuF++nkSWbuM24eUyI8rYCSvRRpD2827+gYkWB54QFPGkgYp5MFSxy8
 3fb3BvqX2G+rGaK1Kn7YalF5GZXEaKCzDFsgvVExb66KSkr7PVIWbFU3aIpdpGoxa34=
X-Gm-Gg: AR+sD13nv5Y3KOfnTodI+ePY8Sk9rtNRZbfSd+PoKimsdLouiEXFuM4qzWghj6tWbxh
 QvVPwArlcSKa7wV9BHB/f3bYiUBIxmCePgXuxseqEzRUtWX2IwAV2hREgFe2u9M92z8CgbEWaUy
 4ctEK6R3LIDZHLzOlDr1FIvXyGLke+S+Be+OTVNoXTivTmkMOlX/Sukw8/3trtRczZNM5cUfbmi
 JhmD+B3Las49S2WJ+IspktSBnVJIWOw3Hcd8nzdCrSpayVH/9DtrngqhW1fLp0v/1qXJTP4PaVc
 2knQUH44hLT3iWVCG+eB10q9rN9g2d42OoujxnsT4VorRvBSi1jS0uCiYsFLjaQJak7g+kIV9Ht
 P6VEIIbLog3V3VpVWLAR/gNqbf0k8chizZ7lxkAE+IYS9t8Po/ZuMtOzp7L6mOEXbY9v4PnKO7C
 MyNTLyTf+KLLD0FoOiUl/PVlKOThUTibY5kjkKe5rMEar82FOpWUfqUSGcniCNJDx/+yfbO6Uh4
 BLP7IxQG7K553T2JcSFCtJ58IHUOw==
X-Received: by 2002:a17:90b:4ccb:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-395a06edd3bmr8333804a91.8.1787242984898; 
 Thu, 20 Aug 2026 09:23:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17f48sm7949132a91.2.2026.08.20.09.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:23:04 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:22:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Marat Khalili" <marat.khalili@huawei.com>, "Jasvinder Singh"
 <jasvinder.singh@intel.com>, "Akhil Goyal" <gakhil@marvell.com>, "Fan
 Zhang" <fanzhang.oss@gmail.com>, "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Abhinandan Gujjar" <abhinandan.gujjar@intel.com>, "Jerin Jacob"
 <jerinj@marvell.com>, "Chas Williams" <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, "Sameh Gobriel" <sameh.gobriel@intel.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>, "Anoob Joseph"
 <anoobj@marvell.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 03/61] test: use memcpy instead of rte_memcpy
Message-ID: <20260820092248.06008fc0@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659FC@smartserver.smartshare.dk>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260820052251.1453273-4-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FC@smartserver.smartshare.dk>
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

On Thu, 20 Aug 2026 08:22:09 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> >=20
> >  static inline void
> >  copy_buf_to_pkt(void *buf, unsigned len, struct rte_mbuf *pkt,
> > unsigned offset)
> >  {
> >  	if (offset + len <=3D pkt->data_len) {
> > -		rte_memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset),
> > buf,
> > +		memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset), buf,
> >  			   (size_t) len); =20
>=20
> It looks like size is not constant in the above instances.
>=20
> Try writing an intermediate wrapper using __rte_constant() to verify at b=
uild time.
> Something like (assuming the return value is unused):
>=20
> #define rte_memcpy_const_size(dst, src, n) \
> do { \
> 	RTE_BUILD_BUG_ON(!__rte_constant(n)); \
> 	memcpy(dst, src, n); \
> } while (0)

The goal of this series is to hit as many places where rte_memcpy
is unnecessary. For tests, this includes all tests except those tests
specifically targeting testing rte_memcpy.
