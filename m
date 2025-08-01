Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E1C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 21:57:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C77D402EF;
	Fri,  1 Aug 2025 23:57:42 +0200 (CEST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 by mails.dpdk.org (Postfix) with ESMTP id 527FF4028F
 for <dev@dpdk.org>; Fri,  1 Aug 2025 23:57:41 +0200 (CEST)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-e8e1ae319c6so1248562276.0
 for <dev@dpdk.org>; Fri, 01 Aug 2025 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754085460;
 x=1754690260; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ9myo0l6YJEo80DGkvX5IySr06Up75M2moF3NVoc8g=;
 b=aGURxjSINLl6uReyj7bCnwKbBx9uXqqjePhFgHEoLUALgI+Bn7+OGH4elWWHM+/KtL
 jfQqHEolT6qlK9Sq48IrdgUBAbSuV4YY57+ZJZ7nRMEdNauryxhe2cwEGfbb2Ue9fsUm
 JjQ2yfM/Ch6ZDPwVrwl1fIkKfDeMyfDYkJ2vq5wq0J8d/YuXjAm3N7uNOC1WPqAKc5rd
 7pR4LYUCyezQv3aUFYBnVjSz5sr1+OrYiky6S8lyehIgpldacgrSTY+RGm5S3XBsVGy/
 Vq9CmL3AZI5GV/rKMfAY/E58g/aXQELZqZYR0xaBerliyt7ER9FXAVWxKrVqM0fxdRAB
 9mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754085460; x=1754690260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJ9myo0l6YJEo80DGkvX5IySr06Up75M2moF3NVoc8g=;
 b=px6l37geCUTN/chQ0xqyKJrTaAIi4y5tzVTHqgzE2/n3T1CbCZRVEQlXXW0ZDsgRs6
 jegKwx+n4Fkcs+aWLxmuGjphJ4TTOs7rpZuCx/yDGRiYDqApJ2bORr1/7Hc2pq2sPR6p
 gZXRwOQrXXhTlPOG4I2MmfyHxjk0x9wRNON/mSwhO/k/UU2WVk0kDf4GVW3gig1R4A3u
 LOH7v/yzLyfIube//O6rMcrkqpT6sOWY5SCeLobIJW/9j0ckS+zWaZfKslDJHXTvIjbK
 qMpsCztOGMiRY++24X9TxJuxXpnIkzXORo/8yMjpKBTR5KcNV0F7c0w4E0b32Eok/CEo
 eaMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Xzh/E8cV6CYPblOGbukzmOUQrCtgVmi/e0EnIfaiJpoDwXB6QWKuR/uD6gMlRMLlRlg=@dpdk.org
X-Gm-Message-State: AOJu0Yy3yWRfLoLsyjE0z2S2mDnxmarnpc5oZsOIe3FDHLUmLf59QzbH
 8U6yQ85bfJnYcimO9AFh6WopA7iBXjssqPUYeaPqNG4xljJ1I22xRtVyoRE//hIzIb4=
X-Gm-Gg: ASbGncvnNuxHPhTPbY5/fwUmT5OncqBCmLwn+QnyO8HEliY6OILD/Eh1vMix6BHnsB4
 GtxqN5SpLUnWa8tDUnxh+ilZOzALNMnuOGRVcxvAkJD3JqdVhp9/oQu3PL367KeTKJWXVtmHDSL
 ZNifEnum17Ygy8ctEXH3GIP0f0OjuQxZI/hy1xR8KPsyTKtRXlYt5N+ivE2e67S2HG6jBoA652M
 KfQT0POicAdrYbuxz6+83vl2TV5P1mA2cFCUdhqkXsdikd9Un7ZKytrSaKmM/qKTpYnDJU4NiES
 SOw/Y5vDx5QyztsBf1PZjkzGLIc4wg2VCtIzJ5LULiaTArnEw86oTFQ7X5eIofiABWqOhxMR3qP
 GiygM7bU7/5mPwpmkPCnqDDNsU1gppNOmG0L6aYJzEtxFDPOOesBY/P3T/8tL0mmKWlJsGz/tku
 s=
X-Google-Smtp-Source: AGHT+IGiC6cRwJPAvx9hreBiuco3l1bwQyB5oLvxAi8dxMRXfV1rfO0B9wScu7LNhxzGYxE3ED3kyg==
X-Received: by 2002:a05:6902:3486:b0:e8e:77f:ba31 with SMTP id
 3f1490d57ef6-e8fee1b517fmr1424318276.27.1754085460617; 
 Fri, 01 Aug 2025 14:57:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8fd375128fsm1832252276.16.2025.08.01.14.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 14:57:40 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:57:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <dev@dpdk.org>, <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v9 1/8] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Message-ID: <20250801145736.6ad29b64@hermes.local>
In-Reply-To: <20250801093706.3394974-1-tduszynski@marvell.com>
References: <20250723072752.7f6812e3@hermes.local>
 <20250801093706.3394974-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 1 Aug 2025 11:37:06 +0200
Tomasz Duszynski <tduszynski@marvell.com> wrote:

> > > Add a dummy rte_pmu_read() definition for chkincs when
> > > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > > use of experimental APIs in tracepoints.
> > >
> > > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > > ---
> > >  lib/pmu/rte_pmu.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > > index 57b634ecd8..84a5d522d1 100644
> > > --- a/lib/pmu/rte_pmu.h
> > > +++ b/lib/pmu/rte_pmu.h
> > > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> > >
> > >  	return __rte_pmu_read_userpage(group->mmap_pages[index]);
> > >  }
> > > +/* quiesce warnings produced by chkincs */
> > > +#ifndef ALLOW_EXPERIMENTAL_API
> > > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > > +#endif
> > >  
> >
> > Seems like a problem that could be fixed cleaner in chkincs?  
> 
> I don't think there is good solution to this problem. From one angle chinkcs should detect
> violations to experimental api calling conventions and it does that. This library is injected
> into eal tracing so calling experimental api happens hence warnings are showing up.
> 
> On the other hand adding some exception list (or whatever) to chkincs could encourage similar
> cases by making it a) easy b) looking clean. What I have now is at least not very appealing.
> 
> It looks like this library is the only one non-compliant to experimental api calling rules so I'd
> leave that workaround as is hoping that it won't be experimental for too long.

I would rather just make some of the function non-experimental or internal.
