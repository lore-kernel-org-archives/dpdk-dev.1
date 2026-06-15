Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F9FCD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59BFC436CE;
	Mon, 15 Jun 2026 09:58:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B20D43660
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781510293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUqKCAUNE55Lg1DDDwg0EnHNIY03C4um908VHv99bos=;
 b=T06yMgCTRtaawHgjqdeNsXOfuMJjLR7a6LNiBfjvWEdwfhuJZePsJYABgghiLEGE27Pdxz
 a5uP7AM+LLUlbIzVH7t48g6K0XQnS8KIhurTE7ZdoSedfe9VAfKUuKsqz7NEHCmFTA9SoY
 4RIdZbc6RJQ5lwlc/TAmiDc1ChZ2SbM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-aA_YmyMjMKmBMSdcdnucNw-1; Mon, 15 Jun 2026 03:58:11 -0400
X-MC-Unique: aA_YmyMjMKmBMSdcdnucNw-1
X-Mimecast-MFC-AGG-ID: aA_YmyMjMKmBMSdcdnucNw_1781510290
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa5b598829so1686285e87.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 00:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781510290; x=1782115090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUqKCAUNE55Lg1DDDwg0EnHNIY03C4um908VHv99bos=;
 b=oZ2JUIvdtxZSvLFIYAbCzOV3Vqvvw6A42jOz84AUP77QU3z40vp/mKU1YFjR7h8JCv
 Bia811sJT1h1rDC2UeQXOW9FW8f14jxJ2p3qBh+dZcow7S6S+mS89IcVeBOj12zsazWc
 lHfzRITiB9B3XHusFk+Y2g4+bX1Ytu0u1v2KjzCNEz7D3mLLVoBt6OLu5l8kDNSv+E/j
 ZayfK2VaGmKyBG39JR8qFlkAWecoYj29dw0bMetzA2pnPmheNaoLtEXABdaRnc+rZ8s7
 z3IaV00p477tvu6LErS0UBCRegjSj1gguBpzc/rD8HSU+JDxiVSdXtQzj/HNRmmphsIM
 vyXQ==
X-Gm-Message-State: AOJu0YxK7cnWGjvJaWvB0Cj9JMOjgghdDgJ9MYd9jx+XMU/YM4bcPbF8
 dNyI/hhiJQufLPrAKPsDyhgLkNqmdefBp9ynf6vIYRDQIR1MEpLVnNiPsqQtLdgvWIEPaxiJ7ou
 H2yYV9WJebdmD43mRDxtaKMyB8R0UQPweXzVZbkLCV0ZbuLHjLMg5ZyGxs3TtzfH4uF5dJFI2Hz
 vNHikS9evLfMChrmTvK+g=
X-Gm-Gg: Acq92OHswnXhlbTCIeXy17Tw4Am+ooxsF2ZQxN9WNqCAKuyrFe0katlmYYj4IHxrqx1
 NS7RAyfBYtjaJL2PJ8UDqz9LiscFCLIdIPle75XINO2n1dtcVBgKXkQ4zuJIJyDDYU02v8u9IXg
 qjTik7Dr+Weu2fIdZJYad5Z4CVJ/z15lDgPbG1hefvInykax8aREP/w+iJCTYSyGCyXyTbcjQal
 wdRq4nycsDvTcU6yZjKn3VD7S8CGEsGPmnUAdLVseHP81V/z5v/7O6kroEcq3xPxUIwiA==
X-Received: by 2002:a05:6512:800b:10b0:5a8:9511:b906 with SMTP id
 2adb3069b0e04-5ad30dc3327mr1711710e87.33.1781510289658; 
 Mon, 15 Jun 2026 00:58:09 -0700 (PDT)
X-Received: by 2002:a05:6512:800b:10b0:5a8:9511:b906 with SMTP id
 2adb3069b0e04-5ad30dc3327mr1711692e87.33.1781510289077; Mon, 15 Jun 2026
 00:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609142701.163908-1-stephen@networkplumber.org>
 <bfa31475-848f-42af-bfb4-f796433c3073@huawei.com>
 <20260610085749.7bb0a4f3@phoenix.local>
In-Reply-To: <20260610085749.7bb0a4f3@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 15 Jun 2026 09:57:56 +0200
X-Gm-Features: AVVi8CdZQG_PsIh6yzeTLYr2DfA4__gvRU2uJ8-b3bDyAooG6phTOTCXY_3K4IY
Message-ID: <CAJFAV8zVmyfhvDPxqUQYPt8z-4M+3RDbe3tJHaWD-Vu=VdqMuw@mail.gmail.com>
Subject: Re: [PATCH v2] eal: add destructor to unregister tailq on unload
To: Stephen Hemminger <stephen@networkplumber.org>,
 fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Neil Horman <nhorman@tuxdriver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0QuuFS1cTBm66375Fwg9Z3YrjQed7LyCJ6pXfKc2j2w_1781510290
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

On Wed, 10 Jun 2026 at 17:58, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 10 Jun 2026 09:19:42 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>
> > >
> > > +RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)
> >
> > this should be with EXPERIMENTAL
>
> Not possible, this is part of the EAL_REGISTER_TAILQ macro and usage
> is under the covers. So if anything was marked experimental it would
> fail code that did not allow experimental

Indeed.


> > > +void
> > > +rte_eal_tailq_unregister(struct rte_tailq_elem *t)
> > > +{
> > > +   TAILQ_REMOVE(&rte_tailq_elem_head, t, next);
> >
> > We need first make sure it exist the tailq, just like TAILQ_FOREACH rte_eal_tailq_local_register()
>
> Ok cheap scan since not in critical path.

I had excluded this point when looking at the v2 patch, considering
that abort() is called in the constructor on failure, and destructors
are not called after abort().

Is your concern that rte_eal_tailq_unregister could be called
directory by the application with random pointer?
A check would be safer on paper, but it seems strange to protect here.

Am I missing another case?


-- 
David Marchand

