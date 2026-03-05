Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53EF3D337
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D535F402CC;
	Thu,  5 Mar 2026 18:10:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8BF824029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFcgiy8PeK9GwBlcI76mDKcuhMlvhS4LTOrFwNwDx0Y=;
 b=HcD5qFBDSOkik1AO5ejH61J5jsgbE7mUaymvPq8nPdT4Z1uUKaFiiG4S339PFI3FYTH7tr
 jujXVZJj/xrI/TtkdmlaLl80vqOiB0lZuZKrHpcX5gNySNfoPtLfAJbh0MsWvlL7xyg78s
 TDY26Z+3xT9SxT0fQUMh5BOMsP6gQr8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-HJJ00EnIO1Wj5TtsPxdoSw-1; Thu, 05 Mar 2026 12:10:23 -0500
X-MC-Unique: HJJ00EnIO1Wj5TtsPxdoSw-1
X-Mimecast-MFC-AGG-ID: HJJ00EnIO1Wj5TtsPxdoSw_1772730622
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3870692ea5cso80863561fa.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730622; x=1773335422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFcgiy8PeK9GwBlcI76mDKcuhMlvhS4LTOrFwNwDx0Y=;
 b=YVH+0ArMxVLg3xFEJIM1KzNtg0Wl+bto1R63HY7qdsZQkW9c2CbdzCcx3NIqfz+q9C
 wUu3lGzVu6GkBaQQk/Ui5r0WzMRONxsP9dvF/kaIudDd2QsozUbce8ILbkfP0JnnEt5b
 Me+KzFP7W9vFo/5u23GXuSxah3aFE2yZBFFxngwgom0WWlf28Du+iF5/deIu7C7igICd
 qEBFKdq+P1HErgBG53uy9cml4gBZKrYKLZBvTHTABlK3q37mnRBAQG73PuvmIrhtL7tU
 vm1yLrxX9GGMikd9xU4ql4Q/d4spLbNQKHNZcWAFEkwji0HD6yTtoJsf1lc/cHDt24cW
 XmbQ==
X-Gm-Message-State: AOJu0YyBGOUHAYNiv1mcocm7e4KBWHGo0iiDZBMfM6jMCsYDGWqW6ISf
 Zzt6dkA1Ns+lmYTtNmkiaYoLTjpLXKZ6s3L11NzRpQjwKfDiAioO/UlqdFwoqgRhZ2eb3htjO4S
 e4Wp4ejMSYolSO4YY6FFKFW8K1ceWLyL1NaVlgt5ljtcMmHbxYmTK0qh4ustPCheYiih1GPD5u/
 kS1kwAxfBA1RzyGTK3+tQ=
X-Gm-Gg: ATEYQzyc2jgkYL77rPsDJNRMhNUjqLrDnIZd9M/oFYLOFxg1eJyF/GPkoqqk/mtCWZY
 utljHk81MgJ+ikaPNZq32j4CAlXVBTsdaXQlDXMkKhE+KMdja6N1SwnlSUwmGoWwSwViWn7Yy4G
 2VmqEu/gucL7uFYb+DwmHvqKCbua0pcJ2HgnqPKKli768bIJObZct1t+Oxtrh8UnXO/LgE/suN/
 GJS4g/tpjg3a9SSppJJi+Zl03VOh+ahZNrHsoWqNoj/yWQ+2OSde33XaDEWUBZ9mhSmmg==
X-Received: by 2002:a2e:a903:0:b0:38a:269e:fbe5 with SMTP id
 38308e7fff4ca-38a2c580586mr35152091fa.18.1772730622149; 
 Thu, 05 Mar 2026 09:10:22 -0800 (PST)
X-Received: by 2002:a2e:a903:0:b0:38a:269e:fbe5 with SMTP id
 38308e7fff4ca-38a2c580586mr35151871fa.18.1772730621607; Thu, 05 Mar 2026
 09:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-6-david.marchand@redhat.com>
 <aam4A98jJsuhgTYG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aam4A98jJsuhgTYG@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 18:10:10 +0100
X-Gm-Features: AaiRm51hh2VpNxxBlC3RwuvLuJvYpXuj6WT6W2PmRJ0P3SQR5VPKS786j8mxCnk
Message-ID: <CAJFAV8wOAJiL3b2fSyUKhyUYe6LGQknsF5_ZnEF9FVRyvCHE9g@mail.gmail.com>
Subject: Re: [RFC v3 5/7] bus: factorize devargs lookup
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -NmYFbl3zqgczUk_bYsgCLs5lWHK7UkjNwTjax2jB8c_1772730622
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

On Thu, 5 Mar 2026 at 18:06, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Mar 05, 2026 at 05:45:47PM +0100, David Marchand wrote:
> > Each bus reimplements some similar devargs lookup code.
> >
> > The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> > device names. We can't use the .parse existing handler from outside the
> > bus code itself, as the size of the bus specific device location address
> > is unknown.
> > Introduce a bus specific helper to compare two device names and
> > hide this ugly detail.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Looks generally good. Couple of minor naming suggestions inline below.
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
>
> >  drivers/bus/auxiliary/auxiliary_common.c | 16 ++-------
> >  drivers/bus/cdx/cdx.c                    | 14 +-------
> >  drivers/bus/dpaa/dpaa_bus.c              | 41 +++++++++++++-----------
> >  drivers/bus/fslmc/fslmc_bus.c            | 34 ++++++++++----------
> >  drivers/bus/pci/pci_common.c             | 38 +++++++++++-----------
> >  drivers/bus/platform/platform.c          | 17 ++--------
> >  drivers/bus/uacce/uacce.c                | 19 ++---------
> >  drivers/bus/vmbus/linux/vmbus_bus.c      |  2 +-
> >  drivers/bus/vmbus/private.h              |  3 --
> >  drivers/bus/vmbus/vmbus_common.c         | 30 ++++++++---------
> >  drivers/dma/idxd/idxd_bus.c              | 14 ++------
> >  lib/eal/common/eal_common_bus.c          | 20 ++++++++++++
> >  lib/eal/include/bus_driver.h             | 31 ++++++++++++++++++
> >  13 files changed, 132 insertions(+), 147 deletions(-)
> >
>
> <snip>
>
> > diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
> > index 0a2311a342..863c7418bb 100644
> > --- a/lib/eal/common/eal_common_bus.c
> > +++ b/lib/eal/common/eal_common_bus.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <bus_driver.h>
> >  #include <rte_debug.h>
> > +#include <rte_devargs.h>
> >  #include <rte_string_fns.h>
> >  #include <rte_errno.h>
> >
> > @@ -205,6 +206,25 @@ rte_bus_find_by_name(const char *busname)
> >       return rte_bus_find(NULL, cmp_bus_name, (const void *)busname);
> >  }
> >
> > +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_find_devargs)
> > +struct rte_devargs *
> > +rte_bus_find_devargs(const struct rte_bus *bus, const char *name)
> > +{
> > +     rte_bus_devname_compare_t cmp = bus->devname_compare;
> > +     struct rte_devargs *devargs;
> > +
> > +     if (cmp == NULL)
> > +             cmp = strcmp;
> > +
> > +     RTE_EAL_DEVARGS_FOREACH(rte_bus_name(bus), devargs) {
> > +             if (cmp(name, devargs->name) != 0)
> > +                     continue;
> > +             return devargs;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> >  static int
> >  bus_can_parse(const struct rte_bus *bus, const void *_name)
> >  {
> > diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
> > index 60527b75b6..430906772d 100644
> > --- a/lib/eal/include/bus_driver.h
> > +++ b/lib/eal/include/bus_driver.h
> > @@ -118,6 +118,21 @@ typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
> >   */
> >  typedef int (*rte_bus_parse_t)(const char *name, void *addr);
> >
> > +/**
> > + * Bus specific device name comparison function.
> > + * Bus can normalize the names of devices using an internal representation.
> > + * This helper makes it possible to check whether two names refer to the same device.
> > + *
> > + * @param[in] name1
> > + *   device information location address,
> > + * @param[in] name2
> > + *   device information location address,
> > + *
> > + * @return
> > + *      true or false
> > + */
> > +typedef int (*rte_bus_devname_compare_t)(const char *name1, const char *name2);
> > +
>
> This is a good addition.
>
> >  /**
> >   * Parse bus part of the device arguments.
> >   *
> > @@ -258,6 +273,7 @@ struct rte_bus {
> >       rte_bus_plug_t plug;         /**< Probe single device for drivers */
> >       rte_bus_unplug_t unplug;     /**< Remove single device from driver */
> >       rte_bus_parse_t parse;       /**< Parse a device name */
> > +     rte_bus_devname_compare_t devname_compare; /**< Compare two device names */
> >       rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
> >       rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
> >       rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
> > @@ -281,6 +297,21 @@ struct rte_bus {
> >  __rte_internal
> >  void rte_bus_register(struct rte_bus *bus);
> >
> > +/**
> > + * Find the devargs associated to a device.
> > + *
> > + * @param bus
> > + *   A pointer to a rte_bus structure describing the bus
> > + *   to be unregistered.
> > + * @param dev_name
> > + *   A device name.
> > + *
> > + * @return
> > + *   Pointer to the devargs, or NULL if none found.
> > + */
> > +__rte_internal
> > +struct rte_devargs *rte_bus_find_devargs(const struct rte_bus *bus, const char *name);
> > +
>
> The doxygen says the parameter is dev_name, while the prototype only uses
> name. I'd prefer this to be "dev_name". [I nearly one if the function
> itself should have an extra "_" and be "find_dev_args", as it's finding
> the args for a particular device, rather than finding the "devargs" for the
> bus itself.]

Good catch.

Err well, on doxygen / prototype misalignment.. documentation
generation should fail if it is not aligned.
Strange I did not see this.
Ah.. it is a driver header, so we probably don't generate any doc for this.


-- 
David Marchand

