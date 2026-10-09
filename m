Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64395CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 07:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C084026D;
	Fri,  9 Oct 2026 09:31:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F2C214021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 09:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791531084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72mBC4pl+qvXOxscia1uVD535oOrZZgLfx2Wcy0qJq0=;
 b=B/8gfoJpiqyAEFFVjk0WIjABf2B755SCMaj8RYmr+oN2NclN9SgM+qcPxXIvTHyKRWzNr7
 DHd+DbuEUUiTWkxmoihA4e4n9hKKNQYtalQbfIf85vLkwxOS/Lrj+SqtxcmyQEmDNsKsPI
 Qd8UM8WQC7C8p+5iNf6h75rKDiuLSYg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-JiG3JRC8OLCjGqHbv-kDmQ-1; Fri, 9 Oct 2026 07:31:23 +0000
X-MC-Unique: JiG3JRC8OLCjGqHbv-kDmQ-1
X-Mimecast-MFC-AGG-ID: JiG3JRC8OLCjGqHbv-kDmQ_1791531082
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a58fef21b3so30184491fa.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791531081; x=1792135881;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=72mBC4pl+qvXOxscia1uVD535oOrZZgLfx2Wcy0qJq0=;
 b=oRCCB8GoOeTo4C+jjHcnTwSdWiei+LzxF/FTlaVFXGSB2/pRfAaz0YdLfIWEmmfdLU
 vPt5xzfFjKAQi8+fvBTSRBBtO+A1pNfPmchVu0HeoWb4qcfqrJs2Tu1mX/AHWe23Rgnv
 sun7YnlENvhRWXcucyXfLfw7dLrCVFT90KfYTCJpE3HJLUT4uHw6W/fHyP+2XaF1bVLX
 StmjriS6n6OUbNVzKloR34W1WbEfTOxO5gpaiyGyoVV+c5NjnEsYFdEHuxYsG8n4/uI0
 iEuDOJB7mChyWf5OQa2mmt1T6Omeaj0dp/ph0nw9Yhj1lqAxQDZ8FS9jsKur0KvswS5f
 xoPw==
X-Gm-Message-State: AFq9FYLGvAMpqRpBQYRXa0lMImJ1IjoYH1b6ST+jXMeb293M2hde35Yr
 bzuAkbl7/nzoFPbz46rhpZGQ/G6sFRThIc4KHa9kGa4kj8nhQrKFszVkKjdIhM9nRtPLLoVOArM
 Si+2HO3yF9UIZJC7/gbbarvscEVnvq3wkLBTT1xBvVEjJu37N/QQdKv6bS8m8zpLuizssC4YcgE
 LtAj4TWSf85FFAeVOiCkk=
X-Gm-Gg: AYBFou03CSzLI7TCQSlywf1ZNOx+UDf97uu5ePjgtkuzmsU5SWFRSSio7Nj2Of06REM
 My2tfOmuUbQLBPvsYTcqs2LMqb5A5BiypNFuZAi9ZC1TLrf4NXSHln4fw7eEMllIP8aWS8zBIrD
 89Ro4E+QgiyWumutZFtDeIlqMIdyOb2d+YGdlOEHNnjHPZirR/OQODnhQ0/2v/V/XMu80hETFlh
 Qx3bKeh4OBvedMfhhBVcKYXqqvP+Kny7DsIwoFxZuP2oh0/
X-Received: by 2002:a05:651c:220e:b0:3a7:733d:a303 with SMTP id
 38308e7fff4ca-3a9c539d7ffmr2332461fa.22.1791531081558; 
 Fri, 09 Oct 2026 00:31:21 -0700 (PDT)
X-Received: by 2002:a05:651c:220e:b0:3a7:733d:a303 with SMTP id
 38308e7fff4ca-3a9c539d7ffmr2332401fa.22.1791531081054; Fri, 09 Oct 2026
 00:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <20260812092929.563973-2-g.singh@nxp.com>
 <CAJFAV8zOOvdFpwmCvJbV8Qj3TDmM4zR-CRcVupC1bovAyv0AwA@mail.gmail.com>
In-Reply-To: <CAJFAV8zOOvdFpwmCvJbV8Qj3TDmM4zR-CRcVupC1bovAyv0AwA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 9 Oct 2026 09:31:07 +0200
X-Gm-Features: AclHuK88BTYU0fjTlRvyvh2965ZmwPwxcRtxuP7-UuPP7gZ-IBcw-rPcqaPniKc
Message-ID: <CAJFAV8z9c94-C39rrDHLeHTEd9pOG1n_HSkDEbpkOHDkNdcrxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] bus/platform: match device by devicetree
 compatible string
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Tomasz Duszynski <tduszynski@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SucIFc_yCbQMjfLYGwVH-bQr3dAVGSyxw0J4FNO5LDw_1791531082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 8 Oct 2026 at 19:24, David Marchand <david.marchand@redhat.com> wrote:
>
> On Wed, 12 Aug 2026 at 11:30, Gagandeep Singh <g.singh@nxp.com> wrote:
> > diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
> > index e4dcbacf5e..607fd0bd1d 100644
> > --- a/drivers/bus/platform/bus_platform_driver.h
> > +++ b/drivers/bus/platform/bus_platform_driver.h
> > @@ -121,12 +121,19 @@ static const char *pdrvinit_ ## nm ## _alias; \
> >  RTE_INIT(pdrvinitfn_ ##nm) \
> >  { \
> >         (platform_drv).driver.name = RTE_STR(nm); \
> > -       (platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
> > +       if (pdrvinit_ ## nm ## _alias != NULL) \
> > +               (platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
> >         rte_platform_register(&(platform_drv)); \
>
> This alias stuff in the platform bus header looks wrong in the first place.
> We have a conflict between vdev and platform bus both defining
> RTE_PMD_REGISTER_ALIAS.
>
> You could simply declare:
>
> RTE_PMD_REGISTER_PLATFORM(dma_imx_edma5, imx_edma5_pmd_drv);
> static const char *pdrvinit_dma_imx_edma5_alias = IMX_EDMA5_COMPAT;
>
> But, since we have no in-tree platform driver using the alias stuff so
> far, I am for removing the RTE_PMD_REGISTER_ALIAS macro from
> bus/platform (plus the pdrvinit_ ## nm ## _alias variable), and let
> the driver value be the reference.
>
> >  } \
> >  RTE_PMD_EXPORT_NAME(nm)
> >
> > -/** Helper for setting platform driver alias. */
> > +/**
> > + * Helper for setting platform driver alias.
> > + *
> > + * Note: this macro uses RTE_STR() to stringify the alias argument, so it
> > + * cannot express strings that contain a comma. For such aliases,
> > + * set .driver.alias directly in the rte_platform_driver initializer instead.
> > + */
> >  #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
> >  static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)

I just sent a patch on this topic.
Have a look please.

https://patchwork.dpdk.org/project/dpdk/patch/20261009072535.3039944-1-david.marchand@redhat.com/


-- 
David Marchand

