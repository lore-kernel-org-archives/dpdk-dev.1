Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C215CC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 18:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E471A406BB;
	Thu, 27 Mar 2025 19:21:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1707640654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 19:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743099712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEek+fBuDtHDf3ID9BHsZhO2iDc2hgf20yUaX9Dc/cU=;
 b=M2Z2tgthG42sGW1038R4gqdxG0EKL7+Y6fOx6pHSfEBetruiQFNKBOROXckCtqtmRBcfTL
 SedYhX/T9tDyDbKfCgDvBnlUiAfmOHt8g63N6TKkIjGtlKQLDc8+0dgS8dj/YZK36K8Faj
 jFJAsehYSfxJp+EGioDfoyspIYfrNZg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-aULyPZ5uOp2yWam2vnqb8g-1; Thu, 27 Mar 2025 14:21:51 -0400
X-MC-Unique: aULyPZ5uOp2yWam2vnqb8g-1
X-Mimecast-MFC-AGG-ID: aULyPZ5uOp2yWam2vnqb8g_1743099710
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-549927ec579so704355e87.3
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743099709; x=1743704509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEek+fBuDtHDf3ID9BHsZhO2iDc2hgf20yUaX9Dc/cU=;
 b=OX5caXjlYCPEJ6TWBZKBbiOK3bzyYQYHr4CmcPl/z1yba2oRmgUGt6j+6SaR7vR9Om
 8Ebq3pxcKahlz6FaBarI1jM+J0hwnqWxLq8+zhtkb7XcLT/p+ctLL89slGpbbfJAiJar
 EHNfJkRt6+E/W4w3D3keuHF09y5KDSeQf1HXv3RxhQCM3O4bdqJEvBnXDOY0bOfeJlxo
 NcCRiBU6xsY5TOMNa5A0p7HMe96XfYvJXYSWpBJ97a7UmR/R16REhSKg/+FLPhZm/ZFj
 KWAzduHclXDzXGycuCfyZaMLJi1Hb8SFzkIeXy9Npc6CK5P4kPRYNq8KTvrzRxle2w70
 3Hag==
X-Gm-Message-State: AOJu0Yz6ZtPUSRaI59xTcgNR5H45An3D7TJ0RlUO9DptQST1IX9Wa8XG
 XOWPPz0ZLzlUZ1GQ8m2SGMkGIN6TQ/dAwTT4Cowhod6HgUfsYEjQ8XNfRXC+k8IvLMPORmA8KSz
 u0kYJK/n4zDCchqGHC0J2qV1pn7IYBNdbiYiySBB+rZvOygtXAicwL3+ZpLSexkh1MDLoq5s0Jh
 /LljyuNroqJ4fz8vPNheVAyX0=
X-Gm-Gg: ASbGncvkqGtxz+GXwiQujPwMJE++IjcR9CGn4Ea2gT0PhVtWIZ/MJzeLkANqQLUHrHr
 S99MZrJjBoFrCdIkJn3uukAskR797v2lP0fMMiIseY7zFuG0KN0c2iHtWwkd3driPKmFwvEdeuY
 o=
X-Received: by 2002:a05:6512:a92:b0:54a:f7a7:6800 with SMTP id
 2adb3069b0e04-54b0124827cmr2002113e87.41.1743099709130; 
 Thu, 27 Mar 2025 11:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/XlW82B5Gk5xNZoGAQm//T7E1EIR0JFDdBLOA5EJpdA6Qp2gx27hhoIfLDH1UELHKcSok+Yi+DBMIRwX3Lv8=
X-Received: by 2002:a05:6512:a92:b0:54a:f7a7:6800 with SMTP id
 2adb3069b0e04-54b0124827cmr2002077e87.41.1743099708612; Thu, 27 Mar 2025
 11:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
 <20250327133638.2983276-6-david.marchand@redhat.com>
In-Reply-To: <20250327133638.2983276-6-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 19:21:36 +0100
X-Gm-Features: AQ5f1JrnKQQ7GRcs1yKpxUsP9j4No-3N4CVIJFXb37-eM4cw9nGSSzjdL7S6-IM
Message-ID: <CAJFAV8wtbO2kcSWjvDQeENxYTkjKGYAXAJztiwyS3CCt+eB84g@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] build: mark exported symbols
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com, Nicolas Chautru <nicolas.chautru@intel.com>, 
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Andrew Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
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
X-Mimecast-MFC-PROC-ID: 4qt1fK-P1IFVAR1Wy-5MZ1bnk05HGuk-h8pR5ChwjzM_1743099710
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

On Thu, Mar 27, 2025 at 2:50=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> Annotate symbols with newly introduced export macros.
>
> For code not compiled via drivers/meson.build (think base drivers code),
> the exported symbols are added in some new .c listed in the sources so th=
ey
> get caught by drivers/meson.build.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v4:
> - rebased and fixed mlx5 new export,

I missed exporting this symbol in the windows implementation.


--=20
David Marchand

