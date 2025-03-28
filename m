Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C521C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:48:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A041402CD;
	Fri, 28 Mar 2025 12:48:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27A2F402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 12:48:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743162502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpscF4GHdeFSe6vw4R2oi1VqpyvXN4YksUDuTQMuUU8=;
 b=jEVnPk357Y1Qmj0D8ChkTrh9Vrr8iOm6K7FsTPeoprMO1Fy5lW4TuHkh1vMV+jgjSRCEgB
 SCev8nvb6Ae6WvHeb28GL51/0GMufpMTIdc5d/RvRcArDSGrgi7ZAcqQsb7fX3GU/sJgXg
 lrouIxvilDGQOELxVbUFNgP9lAmd5c0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-QvnAJ9GQP5aC5qA_XxXIcg-1; Fri, 28 Mar 2025 07:48:21 -0400
X-MC-Unique: QvnAJ9GQP5aC5qA_XxXIcg-1
X-Mimecast-MFC-AGG-ID: QvnAJ9GQP5aC5qA_XxXIcg_1743162500
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5428d385b93so1440256e87.3
 for <dev@dpdk.org>; Fri, 28 Mar 2025 04:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743162500; x=1743767300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpscF4GHdeFSe6vw4R2oi1VqpyvXN4YksUDuTQMuUU8=;
 b=BuiPLxTD9BQ4KmxLUEkWMB2TgrNk41y6nHCEx681U9v2EhhfgYBW9dALGyj0xlj05l
 NiGJ/e1jdvcF8oyxieIw6iPI2Ufkf1uJbhSEsC450K425Fe0dL9h/nsdV+6GGLA+3lqD
 1NX840SsRKKHe7AKAhsjZ/435CaI0PFQqY0tOVj4wvB7giAIJOHgGU24n1v1uwqeNqhg
 2iFwE91TXL3SlmrPsUjAafPl+AD1YQdSVOBfoV8g3P5vzw5pHg3LYj/8gu82tYIx0gFM
 63f/ZtsNMf7klzZgYgPvJZSv9S3MNI73IyL4RWN/x8sO7msdmEBMD6QlFdFa9TbSLUae
 cKQw==
X-Gm-Message-State: AOJu0Yxp3DqMAP3L64YqhiYPLV8Iha8QBMSuDqUIgxOP/pXz5yeKgaZF
 XcB0EwH35gll681oAQTEeSG6998QGLVoNZAAtz07EfunSmhyTNY0ZmL3HWq4O5qbMIW6kCLVMnV
 QgDTQMvwbC6L5Wjjl9KUbNpYVwsoER1sqKbcZmNltx4IxeoImOmSrxunK544HKEIkLc6NAFXcAd
 aJDXlJSZEVNsjGYMQ=
X-Gm-Gg: ASbGnctDG+xDRVTyxtZmR20zu0jtwFB4wmygJaCXV54bw5fSSZjwQjK8r5EOZd3RFUg
 3SUtNrTn21gjBJhnVdzanQ+4EB4VMSa/lfAoG7nh5ErICgABRob6mLjw+7WvGUnTFu6gvOmy1n0
 8=
X-Received: by 2002:a05:6512:3ba3:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54b01222080mr2952971e87.37.1743162499800; 
 Fri, 28 Mar 2025 04:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvPOD5dHIiOMdM5Fy2lJ+t/VdSeH1n4oUZAQB8l6/FCRCTujVF+uc0I3MuhpKPamPv1mF1P93i++/LeCu6+CQ=
X-Received: by 2002:a05:6512:3ba3:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54b01222080mr2952961e87.37.1743162499405; Fri, 28 Mar 2025
 04:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
 <20250327145202.2220153-6-bruce.richardson@intel.com>
 <CAJFAV8w8YT=2DVbxrXef=60AquicaU8xehG2fvdHye_9dMi98Q@mail.gmail.com>
 <Z-Z9ZPs8k_lQERpT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-Z9ZPs8k_lQERpT@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Mar 2025 12:48:08 +0100
X-Gm-Features: AQ5f1Jp91gHO3OXGZd2g1RUqbQezIXlhgVRuDj7H7sboJmcrhKJSw2hxSSK4EL4
Message-ID: <CAJFAV8zEbLALLNzP5Znfn0yygHRg=0tpNXo5qhiDP1k5B-TOiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] net/ixgbe/base: fix lock checker errors
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 17Zx1Kv7SU989SDql9RCW-WIgeO-2PQlqjqhagy4_HQ_1743162500
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

On Fri, Mar 28, 2025 at 11:44=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Mar 28, 2025 at 09:20:16AM +0100, David Marchand wrote:
> > On Thu, Mar 27, 2025 at 3:53=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > When building on FreeBSD, errors are reported in the base code by the
> > > lock checker (-Wthread-safety). For example:
> > >
> > > ../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'loc=
k->mutex' is still held at the end of function [-Werror,-Wthread-safety-ana=
lysis]
> > >    42 | }
> > >       | ^
> > >
> > > These errors are due to the checker not recognising the lock wrapper
> > > functions. We can avoid these errors by converting these functions in=
to
> > > macros.
> > >
> > > Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > This is the best solution, given that FreeBSD pthread is instrumented
> > with clang thread safety annotations.
> >
> > As a sidenote, I don't see much value with the remaining
> > malloc/calloc/free wrappers in this osdep.c file.
> > I suspect this makes some other annotations non working.
> >
> Yes, I would tend to agree. Question is whether it is better to convert
> them to macros or just move them to the header file as static inlines. I'=
d
> tend towards the latter, because otherwise we'd need to use "," syntax to
> avoid potentially introducing other warnings for unused "hw" variable.
>
> Here are two option examples, WDYT of each?
>
> static inline void *
> ixgbe_malloc(struct ixgbe_hw __rte_unused *hw, size_t s) { return malloc(=
s); }
>
> or
>
> #define ixgbe_malloc(hw, s) ((void)hw, malloc(s))

I think we don't have much choice but to use macros, as attributes on
a symbol won't get inherited by an inline wrapper.


--=20
David Marchand

