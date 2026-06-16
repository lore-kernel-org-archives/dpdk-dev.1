Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA4CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95308402DB;
	Tue, 16 Jun 2026 08:56:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1BFB40289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 08:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781592965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cELfYW9+UXIRBbI+FEzXNvXkdrum4AaWipILtFMdoo=;
 b=MBpZe8qSEAzZD/BzgLUhLnFhiY1YhzSWUX2ispR0oR/ncb4inp8LlGEtYD8uxcfO6eXTSw
 u2xn31xEbtxd960RkIF1IBQG71KAKcEFc+F8nI2GeST1Rkf4Sb5EbEmUCSewfFacJA8xog
 iWuPttRDQidbOI0g/cgA0kwI/pQG3yI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Rd2g_zCoOyWCECDV8ZLH6g-1; Tue, 16 Jun 2026 02:56:02 -0400
X-MC-Unique: Rd2g_zCoOyWCECDV8ZLH6g-1
X-Mimecast-MFC-AGG-ID: Rd2g_zCoOyWCECDV8ZLH6g_1781592961
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa5bff0253so2293930e87.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 23:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781592960; x=1782197760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cELfYW9+UXIRBbI+FEzXNvXkdrum4AaWipILtFMdoo=;
 b=fiSMG0OmrISBM+3p42i9Ro1DLR7JDzGJllU1v579RNg/lZRPIs4wIKSfwQ2Z/WHl0G
 0Qg0JHZa3f3THegGCcffQjMG0uiytBtzTIRNQofocsWrqHA2CUgusYXCBWqhu2/e0WiK
 4qxdGVfnzPzkd9tBppj61ESE/hNhJQcm64apk0IZjSki9MDNPrBfxWK6peyCNtIs09Qs
 VIx0sMRKJn9NyzVFYVHa6zJKZsSXgZH3yV0vRyyyYbt/aFWgKPoaztFXRfU3RFQyLJ7f
 r+vbdULLzIA7g52sLtO01VYVzU7D2Sqd94Z+lGzG4e4ye2OkiyGwLLsGggYRyEkqgIAF
 R4uQ==
X-Gm-Message-State: AOJu0YwAMqep4N38aq2mJVf3Y5NmhskZ0bKQAcY1ZmdYHjNF5PAzmwMV
 a4UB4qcFWftVn0TvR5k6mRRoXQyrhCcRpFuQx/fcbMzvfASQjBCxs3mRRJ5G2oJSx6z5XXOGFbb
 cpXFfcDF3OT7FteVQcdBQVyXYbR7rANsPilmo3hT2/IKO/9Js1JuaBUJKzyYZmSoeFQxgZBseHR
 hEtqsIP2iHDe9AR7CZbFU=
X-Gm-Gg: Acq92OHl5uRoEbBmAV8jGvSGt3XV6vchFZI2bKfbLZSkECT0sIjLYB7vaBRxuEeSEhr
 Qndx0iFLn638ASIbNv04JTzPXZbbMq1U5X7dGCJA3x3NmibzIZBp1wdK9i6rqBlfEFg4Yxt9rCV
 6Zp1viwsXgKjXSt6KWZKnwdaGpklAAzY+WVR/Q1AcyLheloYnhi6RDPd71ODmEaOJtNQrbwXz/s
 5yU8MRlIAOLd+LhIVP0ITAzeMhX6cSq/Y4xQB9gYCQJRhXriTaC7aJwLhDhgAvhY1oXNA==
X-Received: by 2002:a05:6512:234f:b0:5aa:6f43:5bb9 with SMTP id
 2adb3069b0e04-5ad30dcdf7dmr3512313e87.33.1781592960558; 
 Mon, 15 Jun 2026 23:56:00 -0700 (PDT)
X-Received: by 2002:a05:6512:234f:b0:5aa:6f43:5bb9 with SMTP id
 2adb3069b0e04-5ad30dcdf7dmr3512302e87.33.1781592959977; Mon, 15 Jun 2026
 23:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 08:55:48 +0200
X-Gm-Features: AVVi8CdBsQN1DM2IgyNRseEYtseexLZ9DXWUNMjDsQOlx_f-sHkER3JK_L0KqsI
Message-ID: <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3giYPSGoSN1_2xApSWlwtew5HglkWiL68TWN4WGk3wo_1781592961
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

On Tue, 16 Jun 2026 at 01:55, Long Li <longli@microsoft.com> wrote:
>
> >
> > > This series refactors the bus cleanup infrastructure to reduce code
> > > duplication and fix resource leaks in several bus drivers.
> > > It should address the leak Thomas pointed at.
> > >
> > > The first part of the series (patches 1-8) addresses several bugs and
> > > inconsistencies:
> > > - Documentation and log message inconsistencies from earlier bus
> > >   refactoring
> > > - Device list management issues in dma/idxd and bus/vdev
> > > - Resource leaks in PCI and VMBUS bus cleanup (mappings and
> > > interrupts)
> > > - Simplified device freeing in NXP buses (DPAA and FSLMC)
> > > - Deferred interrupt allocation to probe time (NXP buses, VMBUS)
> > >
> > > The core infrastructure changes (patches 9-10) introduce the generic
> > > cleanup
> > > framework:
> > > - Refactors unplug operations to be the counterpart of probe_device
> > > - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> > > - Adds .free_device operation to struct rte_bus
> > > - Adds compile-time verification that rte_device is at offset 0
> > >
> > > The final patches (11-13) convert remaining buses to use the generic
> > > cleanup
> > > helper:
> > > - DPAA bus: add unplug support
> > > - VMBUS bus: switch to embedded device name and add unplug support
> >
> > There is a hung on vmbus during device shutdown after applying the series, I'm
> > looking into it.
>
> Turned out to be a test issue. Please see my comments on patch 08, the patch set tested well after that fix.

Thanks a lot for testing!

I'll fix this regression in the next revision.


-- 
David Marchand

