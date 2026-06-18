Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFCCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:39:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B228402D1;
	Thu, 18 Jun 2026 10:39:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 996B440296
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781771968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KjbxsBSzdjpuZgVFAvfoGr3+lGwkoR/H02VOWeodfxQ=;
 b=K3SOcKUsbWyjbgBYth8XNoy3gyt3n4O08wpQpZwJPiggeYhM1uup7Viy68D3+CTka0hiD0
 39fjGjThYs8JIzkSGA5m8UJjOJBKOaoOF7Va4LXqFpWtuUHZAtVmC1St1hX2IAkzojiPDu
 Y3mWyxGiP86dPSWwuMzaJMkAcNRrErc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-TgSCrKw4Mwaof5XRpY4MTA-1; Thu, 18 Jun 2026 04:39:24 -0400
X-MC-Unique: TgSCrKw4Mwaof5XRpY4MTA-1
X-Mimecast-MFC-AGG-ID: TgSCrKw4Mwaof5XRpY4MTA_1781771963
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa68e1b53dso549568e87.3
 for <dev@dpdk.org>; Thu, 18 Jun 2026 01:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781771962; x=1782376762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjbxsBSzdjpuZgVFAvfoGr3+lGwkoR/H02VOWeodfxQ=;
 b=jDa6FKyTAExmLGAOEgH4qXT0f1YDMALcDIAeE0Q9ovFGJBTeYOPMmTIY4LxIVDfLhn
 QlBcOvyM3DI4e/1gOv96kCj+VHp98J5hIEOAx56li8UGZdo4MVcw6K4BqlM32+H1UZY2
 T0uEOW/HZebRBj/KHWbYkJrr/C+uxvC3jVS0XhUrYJiCShcX7kjKWrac2l1ZTLwj6oDR
 4sSlJgblH+E5Z3bq4ARW6N2+uegVe7iXXEDlXZdRH8Fi2h9zOvHGVrGIqb3DfP/+kg+R
 8WALqThhNE5MgdcbnZJBqDoAtS2GF2r3a2jmBvV5a0q49jSLFUEXrvRawLhN01oqLqrx
 39Ng==
X-Gm-Message-State: AOJu0YzqyKaB9o0bktFUP3yn6HVkjYoC7zXEdfQCpwHWM4fN6OPgQ7qQ
 bABgii+8DoMX2ZgoMFDEendjRo5xBsnL0+Pn574J7vgHlW/oQuV605RCT6cFgNPZwXULG+/svn3
 oVqp9G8/w31Zw8tm8rt6M9Qd4tG4AVq2sq6LYYP+QN5qgKdIfNCtmRWOIshCYg0th5shEw+Y7xx
 L0Xlvd0xXPKRxbGHFxnSM=
X-Gm-Gg: AfdE7cmc9BN/0RSYeEaLKCoOdhAB0HODxwtuvk6tVAvNhJpIcWzzYfcYvhvyKqvg95e
 GJ3QraW7/SXTzlT3Ij0Qb61Re31erNmR273kyt7w0jNTDv3cBeOBEYGtPBEXaSILklisUiHUz2i
 2HXeri45j+qG6v+AkoaMCUf18IGtnx+eNbke28N+RYu0Cel5fqmNPX9gRcQpL2GiKKhMh9ZpMNz
 SKpBoFTixvOZFUksKJ4KNU3WVcE3QRv4CTs4g+pqh4zWVB2d6Oi8brqQ7Y=
X-Received: by 2002:ac2:44cd:0:b0:5ad:abf:1e1a with SMTP id
 2adb3069b0e04-5ad47d9b8cbmr1682758e87.5.1781771962470; 
 Thu, 18 Jun 2026 01:39:22 -0700 (PDT)
X-Received: by 2002:ac2:44cd:0:b0:5ad:abf:1e1a with SMTP id
 2adb3069b0e04-5ad47d9b8cbmr1682750e87.5.1781771962011; Thu, 18 Jun 2026
 01:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
 <CAJFAV8z9XmpRfbidbqmrpFtQW_+04V5Qx7GWAP1p9-hY+xu_yw@mail.gmail.com>
 <GV1PR04MB10750ECC2CA25C4BA7B78309389E42@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750ECC2CA25C4BA7B78309389E42@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 18 Jun 2026 10:39:10 +0200
X-Gm-Features: AVVi8Cd-Wiy6s-OrV2rYtnkrCGaO0R5ZR3WWh0iJcZNBXRhLiJWCuegXjHq2hu0
Message-ID: <CAJFAV8yAPFieFh0-kFSQAVOYUcn+qmvN3KfFskh5pZbsBSAb7w@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 Long Li <longli@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7vD_Xq885hCSOGBgqPrb_V-7KMG9vOjH2c19ItlHX4k_1781771963
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

Hello Hemant,

On Wed, 17 Jun 2026 at 11:16, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> > > > > There is a hung on vmbus during device shutdown after applying the
> > > > > series, I'm looking into it.
> > > >
> > > > Turned out to be a test issue. Please see my comments on patch 08, the
> > patch set tested well after that fix.
> > >
> > > Thanks a lot for testing!
> > >
> > > I'll fix this regression in the next revision.
> >
> > Fyi Hemant, this series has a similar regression for dpaa/fslmc bus (interrupt
> > handle allocated too late in the device probing flow).
> > The implications seem greater than fixing vmbus though, as I am now finding
> > bugs on the cleanup side (interrupt eventfd are never closed, for example).
> >
> > I'll think about how to fix it in the next revision, one option may be to leave
> > dpaa/fslmc alone.. ?
> > But in the long run, all bus drivers should behave consistently.
> >
> > I'll get back in this thread once I have a better view of the situation.
> >
>
> HI David,
>         Give me some time to get this tested on the hardware.

Thanks!

If you did not start testing yet, please wait a bit more, I have a v2
that should address my concerns.
I hope I can send it in the next hours.


-- 
David Marchand

