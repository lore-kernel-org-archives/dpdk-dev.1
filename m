Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE4CA6011
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7339B40294;
	Thu,  8 Oct 2026 19:25:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D8B24067A
 for <dev@dpdk.org>; Thu,  8 Oct 2026 19:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791480315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahH7a5uuf7nftzS2WnG6qGjYJdou2Vai0HDecppjTNc=;
 b=Vx3KFpHG5tVlrDCOEkcINjWbHklRsVybYxHrVnOJWNDlb8nqAbbqYDwG0KGaimj6IenARY
 j5Izh4r2rRaP0uvTq28rG58i2PdGZjDNfF3Jr01gYDmXlu95WUJplWnKQkKKsqPX31rckx
 wQbi4ufX2AF8vDQ3VLPE9uxZu5wP4D0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-os_RO8mMPT2P14SD_lVk8A-1; Thu, 8 Oct 2026 17:25:12 +0000
X-MC-Unique: os_RO8mMPT2P14SD_lVk8A-1
X-Mimecast-MFC-AGG-ID: os_RO8mMPT2P14SD_lVk8A_1791480310
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5ba4284e23eso3673385e87.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 10:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480310; x=1792085110;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ahH7a5uuf7nftzS2WnG6qGjYJdou2Vai0HDecppjTNc=;
 b=sOiMWUSv0wme/sXr9BAHpPS61EaQ/fhb9I4Ov66IRVmnT4E1Gl0/mLHtTMKdlJR2yZ
 7zV4TyAxfzcsAWjyG4z6SdTbQ8SPrNkou8GXo8ZcGDXMPsb2Xu4kMd5EbEYD9vcovVd6
 JkVBdN3hQtMqUbpLRce1O8BAC4KsUqiGpnmAdzbq2R9f/1QVXITXumuqd+pJdPHANhKW
 dTO83VgS8rvg2JyYDnJGuHbblVcLc8lnuly6UN/u5iXTxVQsD7/h5fG6XNv4i3T6Tcne
 0lOquRlVpDXAkz8HsXcEfXpLt+pwJfyMIQ+0NscL1+Q1fiBjiEOIfJ4nX0T3MHNoOTQm
 G+IA==
X-Gm-Message-State: AFq9FYKzsfnMS3C/RSSVkQbaO75VCNdlANc5zY+/oDh5TY2qEJMVzYau
 3ZSmiurjDL9WVWo0UkvS452z74DlaKfDSb4LjA5pN2cYhHGtw/BCRFN6DXyvSaTjssCixjpzBy8
 Y3yVHmSnelCVhGePmWVvKox4PFYrGqDiJer9rHUzjgf995tcim3tuU54v06/SxafEIHzS3OtGW7
 q+wgqqDT4NgPH75UtO+tw=
X-Gm-Gg: AYBFou2lM0OoiLx3fIzpm585TAzdcuygo9Yq0BUDeJ2haRjLkcS6PhE02Nm4b45eBgm
 UQwmTwd4W0gTy+5GVVuxTnfwoLIC6EkC2omiH8rvf/0m9Z88TY0MEeLpif92KGUoNY5Y8xz8RAW
 osSAIlP73m6SEqIQjoWw0H6VdA29WKIagLu+k96Vmrt4WEr0lJorsZuMcVkRDNfn2szBTJFJswk
 PW1zy0EfLXWrEi5oLhXhaLaXRZPFnCs15lEwFxzLaVKpCry
X-Received: by 2002:a05:6512:b26:b0:5ba:cdbb:41af with SMTP id
 2adb3069b0e04-5bcd05dc758mr2570774e87.0.1791480310428; 
 Thu, 08 Oct 2026 10:25:10 -0700 (PDT)
X-Received: by 2002:a05:6512:b26:b0:5ba:cdbb:41af with SMTP id
 2adb3069b0e04-5bcd05dc758mr2570763e87.0.1791480309984; Thu, 08 Oct 2026
 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <20260812092929.563973-2-g.singh@nxp.com>
In-Reply-To: <20260812092929.563973-2-g.singh@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Oct 2026 19:24:55 +0200
X-Gm-Features: AclHuK-tcz2P70jdgEcAi8YC9AMk6quJwSwX5ItWx8ceI4SqSsmSJXH9rVF7s6k
Message-ID: <CAJFAV8zOOvdFpwmCvJbV8Qj3TDmM4zR-CRcVupC1bovAyv0AwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] bus/platform: match device by devicetree
 compatible string
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Tomasz Duszynski <tduszynski@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gExbDPSZad2fauMMRlwez36cexCJqm3_Gp20cjhi9Xw_1791480310
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

On Wed, 12 Aug 2026 at 11:30, Gagandeep Singh <g.singh@nxp.com> wrote:
> diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
> index e4dcbacf5e..607fd0bd1d 100644
> --- a/drivers/bus/platform/bus_platform_driver.h
> +++ b/drivers/bus/platform/bus_platform_driver.h
> @@ -121,12 +121,19 @@ static const char *pdrvinit_ ## nm ## _alias; \
>  RTE_INIT(pdrvinitfn_ ##nm) \
>  { \
>         (platform_drv).driver.name = RTE_STR(nm); \
> -       (platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
> +       if (pdrvinit_ ## nm ## _alias != NULL) \
> +               (platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
>         rte_platform_register(&(platform_drv)); \

This alias stuff in the platform bus header looks wrong in the first place.
We have a conflict between vdev and platform bus both defining
RTE_PMD_REGISTER_ALIAS.

You could simply declare:

RTE_PMD_REGISTER_PLATFORM(dma_imx_edma5, imx_edma5_pmd_drv);
static const char *pdrvinit_dma_imx_edma5_alias = IMX_EDMA5_COMPAT;

But, since we have no in-tree platform driver using the alias stuff so
far, I am for removing the RTE_PMD_REGISTER_ALIAS macro from
bus/platform (plus the pdrvinit_ ## nm ## _alias variable), and let
the driver value be the reference.

>  } \
>  RTE_PMD_EXPORT_NAME(nm)
>
> -/** Helper for setting platform driver alias. */
> +/**
> + * Helper for setting platform driver alias.
> + *
> + * Note: this macro uses RTE_STR() to stringify the alias argument, so it
> + * cannot express strings that contain a comma. For such aliases,
> + * set .driver.alias directly in the rte_platform_driver initializer instead.
> + */
>  #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
>  static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)
>


-- 
David Marchand

