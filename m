Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1799FCD98F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B344140616;
	Thu, 18 Jun 2026 17:28:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA60E40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pEcH6beWREt8vWV0Fw/0tUcYVx1abbvsA9MK9GdXQSQ=;
 b=iKN63+04xbjQ8dXGGX+WCL6VYbUr2HCojRdYGvd0oVkU3K5e9jANh5zRld/wQBq+8MHLpx
 Q+q+42NnzgJ9OM9EWx83k155VQG0uCm6eESNjTKANuez4xijj8J3pO6V2h96ON2U6S7jtz
 Xsv6I4Kwfea6w3YQr8pa6Bfeg0EAVfE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-PAfcL7yZOmOjS0Lr8PZEKw-1; Thu, 18 Jun 2026 11:28:34 -0400
X-MC-Unique: PAfcL7yZOmOjS0Lr8PZEKw-1
X-Mimecast-MFC-AGG-ID: PAfcL7yZOmOjS0Lr8PZEKw_1781796513
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa6250009eso753000e87.3
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796513; x=1782401313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEcH6beWREt8vWV0Fw/0tUcYVx1abbvsA9MK9GdXQSQ=;
 b=PdYIuheC4h3JaQsVKVUoNC7h8sQxwsYHNyMWZRgrGkK9QYfyPq3Gcg2Z1tlZZTuUx9
 cHQPaqSZSe+QHCVBmtfnf9y3wLdPTewxSevo7KoSD7w89MaN8hcuT6c/H9XajHnsV2FV
 4z1bhO7pgdexTKfx7KKtwj8WbI5yozffgI/e8hG1gQ/7h47rQ2c7hrFjw0KE8LwhTYmA
 MJM2w1mBwUfiDizPlOuIW5vZ/BxFr95SqWCjsLD7+hPgbiLwzI/Fvp1n8R2Zgb9ALdt7
 Gc/V7wqh4Hq3KM1iIY09K5qTWzGWtkSDtMYyy3gnqZnimEJpqoo8ThCMToHtnxFC/3vr
 tY9Q==
X-Gm-Message-State: AOJu0YzIjoEEYwpNedZPkuoayALiTTDGRz5rNOQeS49r75LtRL4BRrEW
 mNwRQ9fNqwm/aVqCHeQ5CATgoxnIyruQoHcgvoOsFjbg94AKGyjsp9F9VjEZW2whza45awXqix5
 3GUx0h7FkQZUaRbqYPTnV7URk2HmDeq+/4po4TcyKgHdcBMOBJ8wxe+u+/DBedpo0dIEe5ezNeh
 05uA5dDfTvRD628SkcHeA=
X-Gm-Gg: AfdE7clnkt59zzL+Flb7Nk0h3CKL3Xrm+3H+3XyYGP6j57O+WUGKIACKUvY/UrShVVK
 6DQg6brfiB/IehlLfJffzf56xkUPKIWvmp7v291b0/V75ydPaRQBtWaW5XtWS6uk8ehjHJnhNls
 5p+kZM+p9RZYNLIS4OMa/miOuEZjPRutEUclUpIZGRLRIJESPccoYaiPtd489GAaTp3tXwPOeWi
 fjyLouTWjlqN9j15CW73xqZalvDOvszGd4Vsv3gaovpEHGogK5xTstLvVk=
X-Received: by 2002:a05:6512:440a:b0:5ad:3035:c2be with SMTP id
 2adb3069b0e04-5ad5630d870mr10512e87.51.1781796513044; 
 Thu, 18 Jun 2026 08:28:33 -0700 (PDT)
X-Received: by 2002:a05:6512:440a:b0:5ad:3035:c2be with SMTP id
 2adb3069b0e04-5ad5630d870mr10505e87.51.1781796512519; Thu, 18 Jun 2026
 08:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
 <CAJFAV8z9XmpRfbidbqmrpFtQW_+04V5Qx7GWAP1p9-hY+xu_yw@mail.gmail.com>
 <GV1PR04MB10750ECC2CA25C4BA7B78309389E42@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <CAJFAV8yAPFieFh0-kFSQAVOYUcn+qmvN3KfFskh5pZbsBSAb7w@mail.gmail.com>
In-Reply-To: <CAJFAV8yAPFieFh0-kFSQAVOYUcn+qmvN3KfFskh5pZbsBSAb7w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 18 Jun 2026 17:28:20 +0200
X-Gm-Features: AVVi8CfN_85MaqFCvuba1iJRCICqY68mbuOnH6uNbuScGsKOTy3co6XE7MzKW4k
Message-ID: <CAJFAV8xtgqVG+dPKRfixSd5XWHr4ju7n5eqTXZHtyGVxozJJ9g@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 Long Li <longli@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MijJrFNQx_kCE-F-JYx_PrKW7z5-SHCc__jpoXaOEIU_1781796513
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

On Thu, 18 Jun 2026 at 10:39, David Marchand <david.marchand@redhat.com> wrote:
>
> Hello Hemant,
>
> On Wed, 17 Jun 2026 at 11:16, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> > > > > > There is a hung on vmbus during device shutdown after applying the
> > > > > > series, I'm looking into it.
> > > > >
> > > > > Turned out to be a test issue. Please see my comments on patch 08, the
> > > patch set tested well after that fix.
> > > >
> > > > Thanks a lot for testing!
> > > >
> > > > I'll fix this regression in the next revision.
> > >
> > > Fyi Hemant, this series has a similar regression for dpaa/fslmc bus (interrupt
> > > handle allocated too late in the device probing flow).
> > > The implications seem greater than fixing vmbus though, as I am now finding
> > > bugs on the cleanup side (interrupt eventfd are never closed, for example).
> > >
> > > I'll think about how to fix it in the next revision, one option may be to leave
> > > dpaa/fslmc alone.. ?
> > > But in the long run, all bus drivers should behave consistently.
> > >
> > > I'll get back in this thread once I have a better view of the situation.
> > >
> >
> > HI David,
> >         Give me some time to get this tested on the hardware.
>
> Thanks!
>
> If you did not start testing yet, please wait a bit more, I have a v2
> that should address my concerns.
> I hope I can send it in the next hours.

There are more complications and I am running out of time for this release.
I dropped all changes on dpaa and fslmc bus drivers for now.
v2, incoming.


-- 
David Marchand

