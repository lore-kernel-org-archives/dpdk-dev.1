Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CB106F304
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B306402F1;
	Thu, 26 Mar 2026 09:48:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69BC9402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 09:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774514937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2ZsGEg2p6OEL4W0ti53VYOeZvQyitimN3HoIMAtSoA=;
 b=ANhYn5tWapJxJempR3VksIaLs/B29eqE1MqC2VBEJuGoPCll6YqH2Hd04YVzaipn3AaNvf
 /3OP7hJs72IHumzllHum6SNjbXUY39uU1OhaUH2MiYqdl92W4Mg9gNIEUPd7ROZKObZ0KF
 2+PZSD2oYp6rDkqKMqrNS3N5rnYHNpY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-PJgSZVgvNVCuvcxJHatfoA-1; Thu, 26 Mar 2026 04:48:55 -0400
X-MC-Unique: PJgSZVgvNVCuvcxJHatfoA-1
X-Mimecast-MFC-AGG-ID: PJgSZVgvNVCuvcxJHatfoA_1774514934
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a28516ac31so978495e87.3
 for <dev@dpdk.org>; Thu, 26 Mar 2026 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514934; x=1775119734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2ZsGEg2p6OEL4W0ti53VYOeZvQyitimN3HoIMAtSoA=;
 b=jNbGjoujgwKiCec4bnkTC4aAXLBY6eRAcjocYSXsE4Gc9M9kq/CSaqZolhnwIxbzab
 hUYQ32MbPe6+/LmaMWA6smt3UnUIDQVkB6oRHzEGCfqlHmJaWpqAjAXK3rh9Tup7jvl6
 z5KjEVyDD8VE5+u1rhTyNJMMdsIKFSF3pbhm2N3QNcZLpIA5osn80Wc9rBcepssQA56O
 RWJk7iWzQT95/Nm0p9ax3hAvWPvkWbPuolx4mcPoXcxObsnHrmjV59Ckl+1pjq2FJHvG
 Xs5Xb7tH93o59rV96W18VZhFXKGc8VFnIVHpzOtOLwLxwaFrNSbYfoX3GUTYoWZIk26W
 qCKg==
X-Gm-Message-State: AOJu0YzdB2wOqXj9e/sQxyj+gBPsoQFjYfJ0wrDHM7jigFPy1Lut/KAB
 IrHD5uXzIO63H+a+789wqU3LSefL+QsB3etyHYlQhaW48kjyog6RrTs2+BLhCstqVizRZOubsFo
 aLn8O9ttilpeTibXzHqmYiuxV8CDa7hIEk/w/MfldiUduJYh1/NBoIkaRk0ckVdvhNfUo19urTd
 CMrmAekcDCX49DYZc62mo=
X-Gm-Gg: ATEYQzxwiyLDQdSXnGYlqKt9AMmALSvCtKhvliMhy3ft5aNeJHmbYNxmJJX/fNJLiSM
 3Uj484HhLNL65rySetRQp6huqv+WTYYrY3XbsXguf4l0T5OaqKnGCMzmPQr9yTGjh8tEPSWnU4V
 3Zz8jwFDDhUT1bmdHTlJ+j0BcHLY6dKdPdeS6iotLPpIbG+S1RsDmHeCh0gVJMeL1W1ouVW18Ns
 pnM19Q4JQLMDkcsbJxQ66HGG/taJn03iNWgkJp7CP7FMJPCj4BjT+iRCQYPRHtb9bgkag==
X-Received: by 2002:a05:6512:33d1:b0:5a2:7e82:d9c0 with SMTP id
 2adb3069b0e04-5a29b97d713mr2763217e87.9.1774514934263; 
 Thu, 26 Mar 2026 01:48:54 -0700 (PDT)
X-Received: by 2002:a05:6512:33d1:b0:5a2:7e82:d9c0 with SMTP id
 2adb3069b0e04-5a29b97d713mr2763208e87.9.1774514933770; Thu, 26 Mar 2026
 01:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-7-david.marchand@redhat.com>
 <9ea328f9-08b8-4973-8c4d-7cab3a4fcb69@redhat.com>
In-Reply-To: <9ea328f9-08b8-4973-8c4d-7cab3a4fcb69@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Mar 2026 09:48:42 +0100
X-Gm-Features: AQROBzBt4QXh3SjqvidaaivOS_hwQNOQc4P7yFrxAoXqTqyg-Oe5WvEtAROFqpA
Message-ID: <CAJFAV8zCYp0D4OWf2B+TSZ3iaV8K=QeYE1_Dd4ata0Y3LemeuQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] bus: factorize device selection
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Robin Jarry <rjarry@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SMgXRBZfTJ4tTplK3xvPih1vt1KLB_0CQWi8fr4v-Mk_1774514934
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

On Tue, 24 Mar 2026 at 15:15, Kevin Traynor <ktraynor@redhat.com> wrote:
> > diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
> > index 136ac511ef..00e7e7315c 100644
> > --- a/drivers/dma/idxd/idxd_bus.c
> > +++ b/drivers/dma/idxd/idxd_bus.c
> > @@ -263,12 +263,8 @@ is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
> >       if (strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')
> >               retval = 1;
> >
> > -     if (retval && dsa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_UNDEFINED) {
> > -             if (dsa_bus.bus.conf.scan_mode == RTE_BUS_SCAN_ALLOWLIST)
> > -                     retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) != NULL;
> > -             else
> > -                     retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) == NULL;
> > -     }
> > +     if (retval && !rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name))
> > +             retval = 1;
>
> hmm, should this be
>
> if (retval && rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name))
>         retval = 0;
>
> >
> >       return retval;
> >  }

Indeed, something is wrong with my change.
I will go with a if (retval) retval =
!rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name);


-- 
David Marchand

