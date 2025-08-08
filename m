Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566AC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A70402AB;
	Fri,  8 Aug 2025 18:49:09 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 848494028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:49:08 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso16393765e9.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754671748;
 x=1755276548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=680Eu1DfEDQiorT969k+uqlTrgsuqlXNdFl2iCTzv90=;
 b=qjRBbaXj0wcM8kJz1Nhy5ed6fQQCcofCuOOwzrKoaUdzH6+rzDWIRucsLvZuyQnJrA
 ZBuaagigyjKxV3ZiaHw3ey9MW6xXBui5tjlMAq/YZV4OEd8YWooTUP+TuZ8JSdXPFXGc
 2b2nwkg+zHHRGjUOYWQGQ9aiLujsMG0oebeVl+vlkJTWBwnQdKrbZfQRjt6zdkDwS+eJ
 WrijAOapokoGZFrpB4eitZnMz4PYzMMhYfAtslazyw5dZUH7ecpxPJwuqas9z5sPirc9
 XaDqX4k1qHNOsl7ik1qIkBPqwXX9cll4Ci9LHS5/weyCjYaT7/VBVElZo77ddho0SuET
 xnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671748; x=1755276548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=680Eu1DfEDQiorT969k+uqlTrgsuqlXNdFl2iCTzv90=;
 b=tzaaDxysOZ7VOWhygv7JQe4UFzamw7f9XsU97Q/cp0HpXBQbh64Chc6dLTEoQGyHQY
 W8K1q75WTSw7QHmtvfsHLgiTcQx9HikbhSNcOd9IGFVeg9ZKe4Gf66hGpmwoVHlSmNWO
 30klujQ9bo8Hr+Qa7kfxO06FMBPjZD+i2PMn/lX4YcTllMKZdsvoR5CwPO+pg5le/hfo
 desSxIkekPrlBFYMrVgbLqebvtaSNdJNv0xLSHd+yte5HdR2skLB59rCEw5W33C3+gtR
 FvFWhYvMaWyFepp1/PDpMUAmsczAKqohRRTDOOCUkysRyP9KAhVaoYOXxZ0owwAsaWvP
 tWkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKWIs7vPJziiv1WDBDOGwyP2kArEkVtLVlBDGtzTGPVIJGneRuT6ufhrbYbd6xjpfTcOM=@dpdk.org
X-Gm-Message-State: AOJu0Ywh/FNjeTL+93VmOFY1Jv0lFK8lvGU+gOdZdXIX3KmKwWOwK85V
 +oiFqxcqOpdExCN55mTp8AHsU2b4CWPjyalvq2FY/UJZvdpW/v8RuU7GYxK58eSrqBU=
X-Gm-Gg: ASbGncuTLlnVDADvBVrOXh6M8mQFYnY6WuLrv5bGOvoMar8f5PcYuUIx3Ua3npG5Qvr
 KPmPe9N6EwwtkYsugqFJjOUayRF0UCPIc4DhbuICS3KMyoojcgsmZkSl03c3/DtJjVFEbZnTN5Q
 C9JzTgZDSKZroqaOlq+syMmwu+6srUxKeLyDv+cA1N8q5kiioG8/t5ky3AnM28gDBv6YYYEh0z/
 dnXm9zf2kXytNfd/w6QSTSYSyUVIj2E5oII9J/9mCncrxWn7Yh65ojr3dx05OUok3oCpiJEVmSN
 puz0HwgYR/c7HM4wxclNMl0TBb5HjanoV/lRdxaROIToZml23IY8QG/RmvcxdCy43hZfYBnqJWC
 91K8D6HlGezrRAYV1RrbnoauRYcR6jo/rCAgyHQ5p+iaA5LhxskVMJQzkMcOl5rDA3LBC1WC73X
 g=
X-Google-Smtp-Source: AGHT+IFqy65Wn+/Yr5U2ra9f0RvQoIZAj3cQ0lB9UCTpu/vb7OmyN31ZapCvYSyVJjdrxI3AHDug4w==
X-Received: by 2002:a05:600c:1c9a:b0:456:285b:db3c with SMTP id
 5b1f17b1804b1-459fb5dcabfmr7597625e9.3.1754671748014; 
 Fri, 08 Aug 2025 09:49:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5862fd9sm154314035e9.16.2025.08.08.09.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:49:07 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:49:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Vipin.Varghese@amd.com, thomas@monjalon.net, Ferruh.Yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Message-ID: <20250808094900.5027f034@hermes.local>
In-Reply-To: <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Fri,  8 Aug 2025 07:49:09 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> The crashes are on 22.11, 23.03, 24.11, it is on all dpdk stable versions=
 and 25.07 as well.=20
> Please first close primary testpmd before secondary testpmd application=20
> and try to close secondary or execute any of the following commands,=20
>=20
> "show device info all
> show port stats all=20
> show port xstats all=20
> set fwd rxonly=20
> set fwd txonly=20
> start
> etc"
>=20
> We are all agree that these crashes exists. First we were tried=20
> to prevent the crashes at PMD level, but it was not possible to=20
> add checks in each PMD. Then we tried to add safety checks=20
> in ethdev layer, and it was not suitable as with primary closing
> all reference to device information (pointers) would lead crashes.
>=20
> Then we agreed on secondary process monitoring for primary process exitin=
g.=20
> and it is now resolved on application level, i.e. on testpmd.=20
>=20
> Now, this solution is working perfectly. We can add eal_cleanup for=20
> gracefull exit.=20
>=20
> Best Regards,=20
> Khadem=20

Maybe this quick picture would help explain the data structures

                               =E2=94=82                                   =
             =20
                               =E2=94=82            Huge pages (shared)    =
                                =20
                               =E2=94=82                                   =
             =20
            rte_eth_devices[]  =E2=94=82                                   =
             =20
                               =E2=94=82                                   =
             =20
             =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90        =E2=94=82                            =
                    =20
Primary      =E2=94=82        =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=90                                            =20
Process      =E2=94=82        =E2=94=82        =E2=94=82   =E2=94=82       =
                                     =20
             =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90        =E2=94=82   =E2=94=82                =
                            =20
             =E2=94=82        =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90   =E2=94=82   =E2=94=82                                          =
  =20
             =E2=94=82        =E2=94=82    =E2=94=82   =E2=94=82   =E2=94=
=82              rte_eth_dev_data              =20
             =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82   =E2=94=82   =E2=94=82        =
    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90             =20
                           =E2=94=82   =E2=94=82   =E2=94=82            =E2=
=94=82                 =E2=94=82             =20
                           =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=96=BA=E2=94=82                 =E2=94=82             =20
                           =E2=94=82   =E2=94=82                =E2=94=82  =
            =E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=BA
                           =E2=94=82   =E2=94=82        =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA            =
     =E2=94=82             =20
                           =E2=94=82   =E2=94=82        =E2=94=82       =E2=
=94=82                 =E2=94=82             =20
                           =E2=94=82   =E2=94=82        =E2=94=82       =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98             =20
                           =E2=94=82   =E2=94=82        =E2=94=82          =
                             =20
                           =E2=94=82   =E2=94=82        =E2=94=82       =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90             =20
                           =E2=94=82   =E2=94=82        =E2=94=82       =E2=
=94=82                 =E2=94=82             =20
                           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=
                 =E2=94=82             =20
                               =E2=94=82        =E2=94=82       =E2=94=82  =
          =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=BA=20
            rte_eth_devices    =E2=94=82        =E2=94=82  =E2=94=8C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA                 =E2=94=82          =
   =20
  Secondary =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90         =E2=94=82        =E2=94=82  =E2=94=82  =
  =E2=94=82                 =E2=94=82             =20
  Process   =E2=94=82        =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=82    =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98             =20
            =E2=94=82        =E2=94=82         =E2=94=82           =E2=94=
=82                                    =20
            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90         =E2=94=82           =E2=94=82          =
                          =20
            =E2=94=82        =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98                                    =20
            =E2=94=82        =E2=94=82         =E2=94=82                   =
                             =20
            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98         =E2=94=82                              =
                  =20
                               =E2=94=82                                   =
             =20
                                                                        =20
