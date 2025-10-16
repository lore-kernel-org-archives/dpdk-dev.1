Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B09CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F082C42796;
	Thu, 16 Oct 2025 18:39:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9A1FF4026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760632764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VLn/eg/wZsUQ0s+Ewra9wCUGgTyDEcs02BB6p14BOs=;
 b=MnFyQtzWryCexQpkvBfx7puOBePn7OAF8LT6mxG8jEnfgBWowwBPK/PmYw40yudlHSI9oa
 ZzDCvDyO5CPjzmXMOsJyg/YBa9fV0tYEQlBZ1uB95oBfxOwYJzy4FgilQZFP2DMkGgyOFR
 pLTG2P7Ua4ng5bClhKbAGclJwshKVxM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-EJruwAPbOmKfHm85L9R7Xg-1; Thu, 16 Oct 2025 12:39:22 -0400
X-MC-Unique: EJruwAPbOmKfHm85L9R7Xg-1
X-Mimecast-MFC-AGG-ID: EJruwAPbOmKfHm85L9R7Xg_1760632761
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57893a7d7b6so932098e87.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760632761; x=1761237561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VLn/eg/wZsUQ0s+Ewra9wCUGgTyDEcs02BB6p14BOs=;
 b=JfWIbS/odkHYEZfFax688Wdf8eMIA6B9OBArH8p3ML1u6n5SNKHuvmVcGxE+WX3MzU
 x6h7JzDAGXbJ0H6PGzcG2vsg6YcLf18r/ptMFezPQmppWgm31Sv79A2LcjXd46AALyyG
 xp6gxU4XYT90H0bzc4QCA5n3hHscCKBx5ID77kQ3pfnc4CKoEGgDuGY43sRyzxyrOHDT
 nOMYE32vcEf44rxNShV0SAn4H9hNUZfgyEFHwa3qm1NdWyz618Bg19b6QcLRo1ZFLZoV
 WzFjn17cLV/g37WHVMtSVuzcuA0xXrAvvFUtUuRuXKR/PJBQ5SPEd8Z7YHnm7hKPSf+r
 fh3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVROkdARShV2rYeWmDtSOoEL1fbblCuZ7pNAXELCGaJa6WRVt+VQr8j6+YRQTZNO/ZWdeE=@dpdk.org
X-Gm-Message-State: AOJu0YwU2xF/GkkNvS+BQ/CwvvKTRYa+tqhObXkk4BiQjzvhC/XRuPpA
 gMBHxaRRUIcT4XLdBBp3qPFfZTiEV+tMY2R13UqOjxNbBf7kYMbcDyK9T6kRxiUy+MWe7IJyV8/
 XqQT1Agm9GRyjubz1lm641vXgoqNvv7f++WbJYJSHnmCVyUsPsP9vWd9u6gbw5eMWGWCVEWUeKk
 sCVj5RLlJCroxPFPggYJI=
X-Gm-Gg: ASbGncteUFt+wTxEfJXKzm4+kCEzJiNPXO7Hjh5yBCIjln+WipEuPnr3f4AkCGurHUY
 lR7O/FxMX6CtxerfhGEbDSltb76tRwgfC2TsZWN4MBD3H2FKqc15UvRdchxvEEdDPbKr3L9cLoQ
 pl5rhQAy4d/0VfoeAnl0s8pKqdAjHz5e0CWqM/+jBMzg1H4hoITpTpHg==
X-Received: by 2002:a05:6512:3f1d:b0:590:651b:10d8 with SMTP id
 2adb3069b0e04-591d850c3e9mr235193e87.20.1760632761012; 
 Thu, 16 Oct 2025 09:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF+38zI1uS/qlN/wgTx1gjabzpSY1gia4GmYI2Sh/hu0kJZEz0gkBQ1UljLkTUcIXjZDZV6pQC2DSn2cT03FE=
X-Received: by 2002:a05:6512:3f1d:b0:590:651b:10d8 with SMTP id
 2adb3069b0e04-591d850c3e9mr235169e87.20.1760632760554; Thu, 16 Oct 2025
 09:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250826194324.95284-1-nicolas.chautru@intel.com>
 <edc47274-feee-4177-b973-704ce84d11e2@oss.nxp.com>
In-Reply-To: <edc47274-feee-4177-b973-704ce84d11e2@oss.nxp.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Thu, 16 Oct 2025 18:39:09 +0200
X-Gm-Features: AS18NWDGcpWww-z8qMT9hfLlbQXoyV13nsLWXwYkKoXJn6RkVUdT5iZ3h-LvsHQ
Message-ID: <CAO55csxSAgO-R9djGcqJ-uegzV3cCQahR5qJ5Z6a6_+MFnAmXg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] doc: bbdev clarifications
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: Nicolas Chautru <nicolas.chautru@intel.com>, dev@dpdk.org,
 maxime.coquelin@redhat.com, 
 hemant.agrawal@nxp.com, hernan.vargas@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Swowru8-CwuM0zoFFiW2zaWE_HD1cawmuoTigzpP0vM_1760632761
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

On Fri, Aug 29, 2025 at 7:08=E2=80=AFAM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
> Series-
>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
>
> On 27-08-2025 01:13, Nicolas Chautru wrote:
> > Hi,
> > Some minor clarifications to document based on
> > feedback from users.
> > Thanks
> > Nic
> >
> > Nicolas Chautru (2):
> >    doc: clarify CB vs TB level device support
> >    doc: clarify the window index usage in bbdev
> >
> >   doc/guides/bbdevs/acc100.rst        | 1 +
> >   doc/guides/bbdevs/fpga_5gnr_fec.rst | 1 +
> >   doc/guides/bbdevs/fpga_lte_fec.rst  | 1 +
> >   doc/guides/bbdevs/vrb1.rst          | 1 +
> >   doc/guides/bbdevs/vrb2.rst          | 2 ++
> >   doc/guides/prog_guide/bbdev.rst     | 7 +++++--
> >   6 files changed, 11 insertions(+), 2 deletions(-)
> >
>

Applied to next-baseband/for-main

Thanks,
Maxime

