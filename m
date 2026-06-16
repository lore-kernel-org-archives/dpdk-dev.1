Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F6CD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 07:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83136402DB;
	Tue, 16 Jun 2026 09:47:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2913340289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 09:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781596039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfAhO9eys4YJUZ4I9pJc8d8jd5TyqsahyPIz513jVOQ=;
 b=OgmaML/jNhVHXGbYrZaA9ojGIdaUOG6HDY59LnbS2B1N+3Jw3OweYEalT1xJPFeMhbrEXl
 ZPVSXaHfj1XFe+ElR+oKzhd5vLM2O9DM+6A29c6gg/FOpaJIlsQenGfsTsSuV3o4uC+Joa
 5ji31wuCksAX/cILmwJvxQ+9kE8x74Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Tazf_mJYM3-MawOyq9EXZQ-1; Tue, 16 Jun 2026 03:47:16 -0400
X-MC-Unique: Tazf_mJYM3-MawOyq9EXZQ-1
X-Mimecast-MFC-AGG-ID: Tazf_mJYM3-MawOyq9EXZQ_1781596034
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa6129f7b1so1850939e87.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 00:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781596034; x=1782200834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfAhO9eys4YJUZ4I9pJc8d8jd5TyqsahyPIz513jVOQ=;
 b=gPczf15XeRHTWh1McT9HRmAEuxNcaJpB36VaDaE2ITb7myNKkM/boog0dbs2PBXeq+
 4BCB1/GR01iPyTgGhpkvnqfgN5SVCCyOQP3m69bFPHC0ThyInLeLDYZkONN/WWVo7afv
 g5GFhEL1vGyEvaduCRbHf6WoJQbg4+Who0M8+U6yd0/YQZ0ip/ZlkDmFWWmZjxbUnDcR
 I+BO5x3RevL+EvlTgDLe37jJFBr6NKuT9fw+FoYG9mwUUz9ShCYFtXkh7EM3aTZ/6MQf
 9m+Jo5/8cyZeK/mNC0op349qOsrhdr+EVukqNntenVHN1cZxnFci6eRefjT3ZhfNqb7v
 H8EA==
X-Gm-Message-State: AOJu0Yw43Yq90vQZw+2lDuYHUL9+NOSjts/8m+ZG4+GdRKHNKD97s1E3
 bSpaYPUE3GrASQuSMSHYqixBVR73JM/LL+Rts32BcA0V8MrjUqhJLU1gwYwRCKURuKRX3jn+Osn
 H/W3dhaaZo3F4lL1a/+4I0gR/VgBd9SOlYefs63nuZDSjuyzigV1q68KeYlEAYMPNvq9OhQLmHf
 tMbSF0pSZgY+AzL5zDrnw=
X-Gm-Gg: Acq92OFKsUXkFhowP0jP/XY8D4fhWA/KURtaNT0jIZO2S6dVKwl7buXItPOlge1Rui0
 DKX4e8lIURNNA2R+MGzSHgysQQ41zplwHox/i1zKOMb6mGDQlS6xVAQGTOinprE0dXWie4Oj3gd
 ceMKTA5yIUxR6moHzz8amAVwmfkFJeSDE3E8Y3UQ/xV0rri0mTibhLgm/EUDA79rlX+vhnjWcv0
 ADcsZB+/UQR0qKXhOnIo4fMaaI+238IaghvIEX/wl9zEFU0OTmvNnIbippjZ9U9lYxAig==
X-Received: by 2002:a05:6512:1152:b0:5aa:6395:15fd with SMTP id
 2adb3069b0e04-5ad2db3f5ddmr5427322e87.18.1781596034255; 
 Tue, 16 Jun 2026 00:47:14 -0700 (PDT)
X-Received: by 2002:a05:6512:1152:b0:5aa:6395:15fd with SMTP id
 2adb3069b0e04-5ad2db3f5ddmr5427304e87.18.1781596033600; Tue, 16 Jun 2026
 00:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
In-Reply-To: <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 09:47:02 +0200
X-Gm-Features: AVVi8CcUMrZt2TUDzW_fjMxB5xQQDm7Ss6mRVw_M-j-6_7AY3dcPgqdE3pp_iuc
Message-ID: <CAJFAV8z9XmpRfbidbqmrpFtQW_+04V5Qx7GWAP1p9-hY+xu_yw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 Long Li <longli@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J3oAdb4QRIwkvgHomzyO0Srj2Un9XkWoNz9yXML7tu4_1781596034
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

On Tue, 16 Jun 2026 at 08:55, David Marchand <david.marchand@redhat.com> wrote:
>
> On Tue, 16 Jun 2026 at 01:55, Long Li <longli@microsoft.com> wrote:
> >
> > >
> > > > This series refactors the bus cleanup infrastructure to reduce code
> > > > duplication and fix resource leaks in several bus drivers.
> > > > It should address the leak Thomas pointed at.
> > > >
> > > > The first part of the series (patches 1-8) addresses several bugs and
> > > > inconsistencies:
> > > > - Documentation and log message inconsistencies from earlier bus
> > > >   refactoring
> > > > - Device list management issues in dma/idxd and bus/vdev
> > > > - Resource leaks in PCI and VMBUS bus cleanup (mappings and
> > > > interrupts)
> > > > - Simplified device freeing in NXP buses (DPAA and FSLMC)
> > > > - Deferred interrupt allocation to probe time (NXP buses, VMBUS)
> > > >
> > > > The core infrastructure changes (patches 9-10) introduce the generic
> > > > cleanup
> > > > framework:
> > > > - Refactors unplug operations to be the counterpart of probe_device
> > > > - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> > > > - Adds .free_device operation to struct rte_bus
> > > > - Adds compile-time verification that rte_device is at offset 0
> > > >
> > > > The final patches (11-13) convert remaining buses to use the generic
> > > > cleanup
> > > > helper:
> > > > - DPAA bus: add unplug support
> > > > - VMBUS bus: switch to embedded device name and add unplug support
> > >
> > > There is a hung on vmbus during device shutdown after applying the series, I'm
> > > looking into it.
> >
> > Turned out to be a test issue. Please see my comments on patch 08, the patch set tested well after that fix.
>
> Thanks a lot for testing!
>
> I'll fix this regression in the next revision.

Fyi Hemant, this series has a similar regression for dpaa/fslmc bus
(interrupt handle allocated too late in the device probing flow).
The implications seem greater than fixing vmbus though, as I am now
finding bugs on the cleanup side (interrupt eventfd are never closed,
for example).

I'll think about how to fix it in the next revision, one option may be
to leave dpaa/fslmc alone.. ?
But in the long run, all bus drivers should behave consistently.

I'll get back in this thread once I have a better view of the situation.


-- 
David Marchand

