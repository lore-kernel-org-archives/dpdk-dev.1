Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E81C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56CC3402B2;
	Thu, 20 Feb 2025 17:45:26 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 781E240292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:45:25 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so1930905a91.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069924;
 x=1740674724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cL/F9NBImmbD7AyE/8qJVTwMO6b+Tb1xLwkPMd538Kw=;
 b=wgXgpQj9IfEK3UpD+3Du7PvWJicQJr3Og4KBQbBx7aM17mwygWl7ZUXnzBxJhuAmOb
 czm49DyQIQewwy17gVNxr5T3NIhglzTWNFXq6jzVuB43yOfW4Mmj28RAdj23NDbYcrQr
 w/8x46WtTvP6tDeclVM4VXwEdY498Z6ZdC0ifghEEI03jC7aDSsmPG8FptJb13OGzi8/
 hN0bJ5Oep3us3Exlr4XKU99h2CSlRcYxk6e8BXFytOKJuqMZHKqYO8LkowiCNjX0mW58
 7ebepPszxMXxblOnEgyqYeGJaCecooALliFBCo4SfJacHMQsAnv+l5rd+UrCMRiLEjRp
 kE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069924; x=1740674724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cL/F9NBImmbD7AyE/8qJVTwMO6b+Tb1xLwkPMd538Kw=;
 b=K8ZX1nNaVzM9yRIozN7Nw1jKEErZtsFDGUZ9vZw/6Df0A3L/ktD/6kjyc7c324f2kb
 Eb/+vAgsXaQs8MA5hoIezH6fu4pU7EcitGT5askLZsW6cF+/Gz6FybTnEKl0xRsnzweS
 e3VAJUCSKA9F3LkcnHvzozd3MhwIe7YWa1it2q33/F9wCMN0YP8Jv76UqRF6vflRX+ns
 2Q3aKaB4R9QBHr1rjDjveO9rBCM2nIgB6zCmK3+JlO0NIT9SX6uXUCm4jrTCWqSGfclX
 zpAgD6S3mNTlTKuGty35u7oO3JlHgVMCR4JVxrhshoQJpPIQJkyDwOgHBPom0PMFzVn+
 ao0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Dq4tHqRxC3LBuvgubBHsQzRvqN5PgRdZo7FhfSLiyOmIeUPXZ+LKI4a3vVNNl9J74ho=@dpdk.org
X-Gm-Message-State: AOJu0YxfyBvjlOfsDvAuQ9dHvukk0K0ORSaA42RbuKcA5/EHgJclsT5L
 b1FFkLNfQJrz+ydSWjpFx+OUneZmH9yMZluk0zrMfsj4+Pn07XgbtOccZXy/iMM=
X-Gm-Gg: ASbGncvguBjL6R5KovjVsWk9XN2/dOUA6avHJe35cwSK6rbMsHc6TSzhTOp14sl4h7q
 k65Qp0CPOsJAiSx9+EvUZSnCJ4XPiGgKPEzVp7Uus0MwtnqubHBElalSsDkNEYzPhqjB7GsQYRo
 cvHHwIK5OTGKMcabhgnWmrwLAFmLJc9k2m13H43Z7ckVv6SfLqM0fy5eaEEeG3h70Vku/YbEMSh
 BUfKvJUghgUzfzVTBBv3C5cHCRnEqjTj8s/c1xvmmXWTjcnSRHJwcvxm43RyekBwYKuOw1A0siS
 wK9CZLJwZq9I9qHLCUau73aDVz0zZsRZMZLXBG7Om5P4zPVpeASJiqysD8sFQkWtMu5L
X-Google-Smtp-Source: AGHT+IHARVexlskyt5wDs5RPG+JYIvOFkU1BED5QKyOGo/tBeQAsm/8EfMfXmiKjCMBg0A2PMyXzoQ==
X-Received: by 2002:a17:90b:3b92:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2fc40f1085emr37573725a91.10.1740069924617; 
 Thu, 20 Feb 2025 08:45:24 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf999b5b4sm17812338a91.30.2025.02.20.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:45:24 -0800 (PST)
Date: Thu, 20 Feb 2025 08:45:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "lihuisong (C)" <lihuisong@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "sivaprasad.tummala@amd.com"
 <sivaprasad.tummala@amd.com>, liuyonglong <liuyonglong@huawei.com>
Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
Message-ID: <20250220084522.16c5930a@hermes.local>
In-Reply-To: <295b2b64b39c4a61b76158e4ff474e40@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
 <20250220081158.345f09b0@hermes.local>
 <295b2b64b39c4a61b76158e4ff474e40@huawei.com>
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

On Thu, 20 Feb 2025 16:39:52 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Thursday, February 20, 2025 4:12 PM
> > To: lihuisong (C) <lihuisong@huawei.com>
> > Cc: dev@dpdk.org; thomas@monjalon.net; david.hunt@intel.com; anatoly.burakov@intel.com; sivaprasad.tummala@amd.com;
> > liuyonglong <liuyonglong@huawei.com>
> > Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
> > 
> > On Thu, 20 Feb 2025 17:01:53 +0800
> > "lihuisong (C)" <lihuisong@huawei.com> wrote:
> >   
> > > > The queue_list_entry structure data is used in rx_callback of io path
> > > > when enable PMD Power Management. However its memory is currently from
> > > > normal heap memory. For better performance, use hugepage memory to
> > > > replace it.
> > > >
> > > > Signed-off-by: Huisong Li <lihuisong@huawei.com>  
> > 
> > How is that in a hot path where this could matter?  
> 
> AFAIU - it is used in RX/TX callbacks that power library installs,
> so I presume will get hit on every eth_rx_burst/tx_burst calls.
> 
> > The safety rails in rte_malloc() are much less than regular malloc().
> > I prefer some degree of safety from checkers and malloc library internals.  
> 
> Didn't get your point - what's suddenly wrong with rte_malloc()?

Coverity and Gcc analyzer treat malloc as special case.
With attributes rte_malloc gets similar treatment but not quite as much.
Also internally, malloc and free have more heap pool sanity checks.
In name of performance, those don't exist in rte_malloc().
Lastly hugepages are limited resource, so they should only be used when needed.
