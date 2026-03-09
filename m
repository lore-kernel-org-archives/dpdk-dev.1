Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FCEFCD73
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 09:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EA7A402C1;
	Mon,  9 Mar 2026 10:50:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 90F0C40281
 for <dev@dpdk.org>; Mon,  9 Mar 2026 10:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773049836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvHUJxNfNCwgVRXcSpJDzrjtAgl/CO6NgHaJGP01KaM=;
 b=dWyouoM2BPcQc1qRwE3+ptfKJ0FoRICZKAS9JuUKa3b2JHewG+FMg+6uE9XqH3A4P/YicK
 Zuc6a1ArAVF33aI0LvwVK/LwRauGn1+bUB7PghdLkyAapvRs0jZCIHqscHhNzYShkq3MS3
 jIOsKMaNx5lxmt2oereYx9eLhkPHYxY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-SRO1QdgGPzioGoDrP8u8vQ-1; Mon, 09 Mar 2026 05:50:36 -0400
X-MC-Unique: SRO1QdgGPzioGoDrP8u8vQ-1
X-Mimecast-MFC-AGG-ID: SRO1QdgGPzioGoDrP8u8vQ_1773049834
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38a439f9a9aso14290311fa.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049834; x=1773654634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvHUJxNfNCwgVRXcSpJDzrjtAgl/CO6NgHaJGP01KaM=;
 b=rC6+yDfJDQ5wealZEgXfw/if2aiX0RQMbtHDmA6O9NK/NT0FWmCt7UbPhWCLvVBZRN
 PDai4BJa/YGsIWojSiMSxUul3Bg9T9raUod7LRtQyQyGbJ11bW/pOuPxPWp2jRDNuSKS
 1hWQ7dNXfbJNdAZo1IiHsmaF5/tsypoVAo7Hd22iF4F6lWmYi3zaKIWY7BhaSpPIwyi9
 0lFQ2c7kuVUw2MU/H2YXHrcfxg798ufdEi9kR2NG0FxoX+YOgdylgeUZo6frwx1HQaMj
 Po9l2XGz3bmJgl5Ls0z4G0sdwqUcqQBIhvK3DlNMetOIn8Mdt8IT3NoqzOkxuxl98tfu
 eg1g==
X-Gm-Message-State: AOJu0Yxhp306GEsPQTgaxWl2c8WTqlNazF5dwLN+r8uUZTRAY1iSQtqr
 2Cj4ms/0jxG/h0IJ/Z1OCS+nxaTtzOZzRyvGyM6DLqO/cZUVt8B+3RIb+C+1TC+RfK0PimhyfO+
 yRwQOoCK5mXlStb49o/ibv3kig6KUy/pxaSaTBhso6vdD4X/4+kVueqFNDMA9B5WgOYBGUr99jk
 njvDhZqqNMw+JXup9FjmY=
X-Gm-Gg: ATEYQzy6NxK07jqDdiUjbnLLJiaOIoweDbcRKHZyoMD8n8vsuOfwOwfeDUv+vr+UQ8n
 GazvV90Pm0pl6qxk3uQb/WgdLdzmHRWLmE94FvsvolXSACY5ERlzfMiKd0a1F8XNn+AnRD9fIm3
 mDu9YXriwLi+JhkgQdzbbEIDuZhbMsh+xVpqEMzLVK+kx+D80IdiEeFuetHt8m5V8ifIaFR0cg/
 TMvJCt1qDkAzriAyA1dLzRpv+5Q1eBrRov6iBkQpaKjGkhpKALGuEmv2ynpmSAt6coxKQ==
X-Received: by 2002:a05:651c:210a:b0:37f:a216:e473 with SMTP id
 38308e7fff4ca-38a408b26f8mr29434821fa.0.1773049833901; 
 Mon, 09 Mar 2026 02:50:33 -0700 (PDT)
X-Received: by 2002:a05:651c:210a:b0:37f:a216:e473 with SMTP id
 38308e7fff4ca-38a408b26f8mr29434571fa.0.1773049833276; Mon, 09 Mar 2026
 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-7-david.marchand@redhat.com>
 <aam9oV1lwwhiQj7H@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aam9oV1lwwhiQj7H@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 9 Mar 2026 10:50:21 +0100
X-Gm-Features: AaiRm52sP9I5NA1_KwDQ_09Wnjv2soAlqvwvw6A4524aueczCuJt5gVkdkniSMQ
Message-ID: <CAJFAV8z5so9oCUD7vQ_bST9tjuo_HbD1BNWV-+ebpkYXq1UvFQ@mail.gmail.com>
Subject: Re: [RFC v3 6/7] bus: factorize device selection
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>,
 Gaetan Rivet <grive@u256.net>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gpzeslJd8s2b3JTxQ03VYDm7vI0Gcvr3vZcBQnveDgU_1773049834
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

Hello Bruce,

On Thu, 5 Mar 2026 at 18:30, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Mar 05, 2026 at 05:45:48PM +0100, David Marchand wrote:
> > All buses (thankfully) implement the same logic when it comes to
> > selecting the devices to probe based on -a/-b options.
> > As we want to adjust how devices are selected, provide a common helper
> > in EAL and use it in the buses.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> I was going to suggest that we avoid having a per-bus scan mode, but then I
> realised after looking that the final patch in this series that that won't
> work for vdev bus which can't use auto-probing.

I also think we don't need the per-bus mode.
I don't understand why it was added in the first place.

The vdev bus does not consider the bus scan mode, so the current
behavior would not be broken if we removed it.

From a user pov (even before this series), -a/-b are mutually
exclusive and --vdev lives in parallel.

I'll see if it is as easy as I think and I have a try for the non RFC
series for 26.07.


-- 
David Marchand

