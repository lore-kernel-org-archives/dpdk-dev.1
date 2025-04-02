Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED88C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 09:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72DAC402B5;
	Wed,  2 Apr 2025 11:23:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DFF9A40275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 11:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743585831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXox06yLbglajwJlHCgdtNyGYQbKNbBwLQ352YNPrdU=;
 b=R9mqBv4zLf60x6CBiP6QYOeI9rzouUCtQaserLYxhe0yevU6NW9vtGzYszb9VqdKsDLKbt
 7K+oXUtOELWcaL6pHEIkz+feAOO0lz9S+wTbD6VoNIfY/AMyUISgAOkFSBUvHUN06Y0M3N
 QEBnQyOjGyG4LWcDI31SmeHTQeL25RI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-V_mQJP3WNaKq90K7XiyGzg-1; Wed, 02 Apr 2025 05:23:50 -0400
X-MC-Unique: V_mQJP3WNaKq90K7XiyGzg-1
X-Mimecast-MFC-AGG-ID: V_mQJP3WNaKq90K7XiyGzg_1743585829
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5498963ebc3so3011135e87.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 02:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743585828; x=1744190628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXox06yLbglajwJlHCgdtNyGYQbKNbBwLQ352YNPrdU=;
 b=ad4ppDMJ0E0Hc8FjYC2dmVFpWotevkPz5h4b2QVfAEofY4DWeP2otAbB83k4M/D9dR
 9Ojy9LsjP+jDd3HvfEGvxZwqzVirngTJJO3lcBcMu/cG57YK//sXoZ7T24xpHtbmCIQM
 s4QRPQuO3XIV/d8GX6geutDbH3PzGDR+mmU39wdmI4Ctb63N5r16WDYNljqJCxubRX21
 v2Fqy2Nw2GAYp1rVOfeCuKqoISh1zukKRN+xjHN8xbahHKVGO9rCZ4RbHNtyAgon3muR
 eiX/6i1qCqs8fw9CxzQcw8FIUfTRgh/D9hdJ89184UjQLZMwLTF/cEy2DKBJGIfcw6I6
 tpZA==
X-Gm-Message-State: AOJu0Yz56cBJVtk9Npi2NLUJHfEYyajmm0NHVWRGLu0+hcIDrxSxdFNn
 jMy14jtBA+k8UIiwXVGgDGqdsojKvGcRy8g0Z2i+Jm6cQg6vSBa7Ekp9EBuDGmsNhua3ub1RVnH
 3qTPV0jYhHIcx9/QCDEU2FCNQLciLcvlpPUIxyz+x2xIp1118Pvxg3qJDoUtNZcp2ewXOl/NIFd
 lE1aw9MN3ocgTdQ2E=
X-Gm-Gg: ASbGnctJDQiFHnTD2aDrtbpUR5L45LM+AqFw/lh3I6mRcpCqNhJg+lHWHNdLgY10bYa
 AQ3rqNzqdLQvZY0S+LZjUv1smjod+VqL5n4aV0+LwrxT89+92q7hP83wxGJjrnDcOqmZMrI14qY
 o=
X-Received: by 2002:a05:6512:1247:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-54b11139421mr4499015e87.46.1743585828545; 
 Wed, 02 Apr 2025 02:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Co8QFfAunUQ61lXtJx741b9mOzLidtesoIKB0He5ASoc69hqMl4dkoHDfnWv3dGu752ULlSIhTBVrpL9PhI=
X-Received: by 2002:a05:6512:1247:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-54b11139421mr4498951e87.46.1743585828048; Wed, 02 Apr 2025
 02:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-6-david.marchand@redhat.com>
 <4410598.IobQ9Gjlxr@thomas>
In-Reply-To: <4410598.IobQ9Gjlxr@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 11:23:36 +0200
X-Gm-Features: AQ5f1Jpr5bp8SflsIQpdMlTCEd6G_e_uXgLtu3NJCmFJLvQnuxu7T8UsXT3_T2w
Message-ID: <CAJFAV8ygq6pxW3dThVur2KYL4USCq5urpYdYGPuybrtXb43Dpw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] build: mark exported symbols
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com, 
 Nicolas Chautru <nicolas.chautru@intel.com>, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Andrew Boyer <andrew.boyer@amd.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Liron Himi <lironh@marvell.com>, 
 Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>, 
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ankur Dwivedi <adwivedi@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, 
 Gagandeep Singh <g.singh@nxp.com>, Kai Ji <kai.ji@intel.com>, 
 Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>, Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashish.gupta@marvell.com>, 
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou <zhoumin@loongson.cn>, 
 David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, 
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, 
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, 
 Gaetan Rivet <grive@u256.net>, Volodymyr Fialko <vfialko@marvell.com>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UrB3zKCxAuUDvhSrn6oM1vDrCBHbg4Be1_UH7QDfZEk_1743585829
X-Mimecast-Originator: redhat.com
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

On Wed, Apr 2, 2025 at 11:02=E2=80=AFAM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > --- /dev/null
> > +++ b/drivers/bus/dpaa/dpaa_bus_symbols.c
>
> This is a special case for base drivers,
> so we should mention "base" in the filename.
>
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright (c) 2025 Red Hat, Inc.
> > + */
> > +
> > +#include <eal_symbol_exports.h>
> > +
>
> Please add a comment here to explain this long list of exports:
> /* Symbols from the base driver are exported separately below. */

Ack.


--=20
David Marchand

