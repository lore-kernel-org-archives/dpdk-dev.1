Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB0FEFB54
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21F08402C5;
	Fri, 27 Feb 2026 15:17:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0DA154027F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 15:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772201863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEaqFxkTJtGJPvALytC8ryIspRLSZ4U4xcCAa6lX2YM=;
 b=eio0DIynkRYbPbQ6jGPS1loBEPnBtgiDuEWbzJ4b9NFx/jzcZJtJO0OqctjJtgRemzIA4U
 KpxsDh8bbSz19bvJQ3wIlyNGM2G8/tL1zzQmh3OllTLIlZtSUBReii6L7COmXa3FJeYtgg
 PWel2gYcUQpFnezMGlCM4ccAvGY9udo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Yc8mKByQM0ClNtODW-wuRw-1; Fri, 27 Feb 2026 09:17:42 -0500
X-MC-Unique: Yc8mKByQM0ClNtODW-wuRw-1
X-Mimecast-MFC-AGG-ID: Yc8mKByQM0ClNtODW-wuRw_1772201861
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-389e1a6dd67so16213111fa.2
 for <dev@dpdk.org>; Fri, 27 Feb 2026 06:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772201860; x=1772806660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEaqFxkTJtGJPvALytC8ryIspRLSZ4U4xcCAa6lX2YM=;
 b=dYLWeFXNaCy8Knx50E0m+AGs4TbEaqdh7v3urw043w1xCIdb1pIErdSAyj95tOlzTG
 HcAJZ7O85IX7l1ciqoeL6qh+XDEoulNK32ZFsLTtKJg+uXBBuS99fgC7RlM9P/y3aINz
 zXnCFGu8IBWdHRVsS5DsrXHoMeF6QE64Yi7pvo19zbd9cwS84sm3WtzAPgOq8wI/LYla
 jY9am11xcN/EIjffaNubrElAYUXhjejPPEDBnR+RmTLflZ/UGtnauyU2twDUVTKZN4oQ
 nzwN47PH9vbMZ5CwnbYDRTnuFalO5ha585sLnZZMDqvV6FnX754p89HEwlChuBf6DtuM
 5Tkg==
X-Gm-Message-State: AOJu0Yz177+4Mpp10QOtA7WnMViSvh0ihYzol0DB0NEYpS8Yh8W1TlNB
 N5EnpOBV60uVKv/ryncLpXWUf/zjU3obAv0kV7P9awHhstI0pXhoBafPdw5is30Zg5VuZqW0iwx
 XftTrN7qTqVEa+OgEaZN3QEwz0KfQt7qkH8/cTrwV0CYS7eJaW/ta71g1nC2D8Le5eHSaPuLij6
 eIsA4JLPRkAwrzRVthqms=
X-Gm-Gg: ATEYQzzMxNpnPq/BxlxRS3eZpQF52eDCybC5Goz4GqRIynjaH6EgzaeIA4aoZF/W280
 lr+Q0KmM1/PinTYYwcceJhjfLAPl1qJif+64dsrVdk2X3unDJXAeHb6lvm1kVIfrrSCTccRTy5A
 JYaXtUmwvclVr3DJLq21iFBp9dUrtbn/Gb3ecVhsXzMIIJCXCBbgDC9qy4ZxdhOjmg7HNM3JBCG
 uUMjz4KevNzvykR5+yC7GK+Xx2OsR4s5tq1nV/B/M8Pr/StrQqGZDrW8jXDucXHSRstEA==
X-Received: by 2002:a2e:a991:0:b0:385:bb24:d0eb with SMTP id
 38308e7fff4ca-389ff36c5dbmr21038431fa.34.1772201860520; 
 Fri, 27 Feb 2026 06:17:40 -0800 (PST)
X-Received: by 2002:a2e:a991:0:b0:385:bb24:d0eb with SMTP id
 38308e7fff4ca-389ff36c5dbmr21038061fa.34.1772201860033; Fri, 27 Feb 2026
 06:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-5-david.marchand@redhat.com>
 <aaB1dz2s2adE8ZCO@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aaB1dz2s2adE8ZCO@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Feb 2026 15:17:27 +0100
X-Gm-Features: AaiRm53e_BPUal_2B1X1K_iPb_tfUQOtw-mh2AttLpm7XnOe8apDBdFi0N60BM0
Message-ID: <CAJFAV8ymk6hScCT8x+sPC7o=3AdFxCXN7BywjvkPiprs_BjM2Q@mail.gmail.com>
Subject: Re: [RFC v2 4/5] bus: factorize device selection
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dLaTLYEVfo3EU_68QXxQ44vs6MCYiAxh9pLU1LfYDbQ_1772201861
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

On Thu, 26 Feb 2026 at 17:32, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
> > +bool
> > +rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs)
> > +{
> > +     switch (bus->conf.scan_mode) {
> > +     case RTE_BUS_SCAN_ALLOWLIST:
> > +             if (devargs && devargs->policy == RTE_DEV_ALLOWED)
> > +                     return false;
> > +             break;
> > +     case RTE_BUS_SCAN_UNDEFINED:
> > +     case RTE_BUS_SCAN_BLOCKLIST:
> > +             if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
> > +                     return false;
> > +             break;
> > +     }
> > +     return true;
> > +}
>
> I think this could do with more comments. Am I right in thinking that
> devargs is NULL on input if the device in question is not referenced by any
> devargs passed to the app? This seems a little obscure form of input
> parameter, so I definitely think it needs documenting.

Yes the handling of a NULL devargs is implicit, I can add a comment.


> Is there any way the search for the device name that returns the devargs
> null/non-null pointer can be similarly generalized?

I also wondered about that and it would be better, but I stopped
quickly when I looked at the bus specific devargs_lookup functions,
preparing the v2.

For example with the pci bus, names for pci devices can take various
forms, so the pci bus uses its device specific representation for
identifying the devargs.
        rte_pci_device_name(&dev->addr,
                        dev->name, sizeof(dev->name));
        devargs = pci_devargs_lookup(&dev->addr);

And:
        RTE_EAL_DEVARGS_FOREACH("pci", devargs) {
                devargs->bus->parse(devargs->name, &addr);
                if (!rte_pci_addr_cmp(pci_addr, &addr))
                        return devargs;
        }

I suspect vmbus is the same, with this uuid stuff.

And others bus need investigation too.
I could try to normalize the devargs names for this lookup.. ?


-- 
David Marchand

