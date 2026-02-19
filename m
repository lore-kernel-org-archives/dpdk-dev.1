Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFDE9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9EC7402EA;
	Thu, 19 Feb 2026 17:52:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6A60A402CA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:52:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771519976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDGPGRn2VIefYQ/imN+QVkimiY1miYAUkRrWz+xW8dU=;
 b=hycm8LIauNv9Fj/O7mVtg7PAgsTiS8KLEjpddhAr+rEwE1tJ7F5NFVbR/uWkThZY2ky6D3
 Sc6vLC/3EuHjvirPz6dnvgft2gZ/Jq66WY0pzgFelRE5k+C+c+mt/CtXZhilCDm6BSV50h
 OdIRake5OfuBih7ak2qE3pTsasU0Pa4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Q5fSo16IPduUFEm60gPPWw-1; Thu, 19 Feb 2026 11:52:53 -0500
X-MC-Unique: Q5fSo16IPduUFEm60gPPWw-1
X-Mimecast-MFC-AGG-ID: Q5fSo16IPduUFEm60gPPWw_1771519971
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59e62ac0bfbso1178993e87.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 08:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771519971; x=1772124771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDGPGRn2VIefYQ/imN+QVkimiY1miYAUkRrWz+xW8dU=;
 b=OQPy3IlqSEesr+C9f+5hCDKXcb3V7G3Sd6ePD8PPYrgT+VaEVm4MWc1rwKWk7ADNIC
 Mnc6d+UQ0KkdcqmCQ0Mo2zZvBnkfZN/w7XYbPT778mcWfmzw00iKdZeItRM42a2pJYDv
 zRCOHAbDuXiFd9IKkBbwzBTFhChwTK2crtNTovAzuWNvnFsXkJCNgY5ASZrWbIRtIrIN
 OxBwLgXANOUhQog5RqVeqayh13RlvzdJzECW4PXGiLfpdTz7nqb+dn+K2Gl2BzGqRoPy
 aC+T+zwcbITKak4siDBA99qhzdVDjNEW+nJvHYbzQPp0pgHPiCHpzRZbEJGa/aXHfJy2
 YDjQ==
X-Gm-Message-State: AOJu0Yyw6h6cy54zdm2g2h7mp8/we3NuOeBMfpqPW9Iev+xTc+r7z2W6
 RH9+0zI6TPa+Haaswybi/uLmRod1GyEGJO/r0Z2+3SeI9RAfii8oWerKQC+u03hg/8QhHrU6VBq
 yiaO1JULXPgR+cThQiVBaT4IhGvX/sedWvUcao+bzJ0s2Pm1ajofcPvgl7UZ8QpW3fbNXUdM6wo
 dIn3WZS49cStxKW3JG54k=
X-Gm-Gg: AZuq6aJTWuNHFYAhY5t4eZHMOJMtwD9ZZLBIQuqtiwv2/ljrEpL7bwXPzXZE6rYViNV
 yzizdFHU9Ucx4xmbdw/alChOu5DzaxZwcy8n/i43Rqu31jpHzyMGBTj2FiItpUID/AEiRJ+GpW5
 si1v1/FgegfY0HKr9bEXWlyCizc3hvAG5ZKDOwiHPXvmyF8Qpa0mpl3Bfy/zpOzeEPGLvFX8pIX
 eKbkg6QC12ahq7jxJLAUZ5TBsAOLXVtTUTTLf+qt7nHVowE6jmHIGWYUcFrIyXKfa9RQg==
X-Received: by 2002:a05:6512:b05:b0:59e:597e:7f0 with SMTP id
 2adb3069b0e04-59f028323f7mr7365712e87.48.1771519971380; 
 Thu, 19 Feb 2026 08:52:51 -0800 (PST)
X-Received: by 2002:a05:6512:b05:b0:59e:597e:7f0 with SMTP id
 2adb3069b0e04-59f028323f7mr7365701e87.48.1771519970862; Thu, 19 Feb 2026
 08:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-11-maxime@leroys.fr>
 <CAJFAV8z=CfhvELVRPJMteB+LwTwET7ZdaOuA9eyL3OaVGmPMjQ@mail.gmail.com>
 <CAHHRULXWDg2qpc-WR1pehzZ6+PasdeNx3aqOjVj_0K12Zk-UgQ@mail.gmail.com>
In-Reply-To: <CAHHRULXWDg2qpc-WR1pehzZ6+PasdeNx3aqOjVj_0K12Zk-UgQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Feb 2026 17:52:39 +0100
X-Gm-Features: AaiRm53uqg-BzllzCsVIvfRx5FydHl7qAoiqIQszNtrMGmjhxI_Ayyhi-QEpL0M
Message-ID: <CAJFAV8yxPE9Sf3EY9j32D7GG+Kz7ovNYx9hFW+9dzazprfkqnA@mail.gmail.com>
Subject: Re: [PATCH 10/11] bus/fslmc: fix devargs not propagated on hotplug
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: toN0NfTv6RfPVuv5LbPdsfaXu-GGv5Cgap5-oxGSTF0_1771519971
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

Hello,

On Thu, 19 Feb 2026 at 10:06, Maxime Leroy <maxime@leroys.fr> wrote:
> > > diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
> > > index abdb0ad50d..a539753649 100644
> > > --- a/drivers/bus/fslmc/fslmc_bus.c
> > > +++ b/drivers/bus/fslmc/fslmc_bus.c
> > > @@ -596,6 +596,11 @@ fslmc_bus_plug(struct rte_device *rte_dev)
> > >                         struct rte_dpaa2_device, device);
> > >         struct rte_dpaa2_driver *drv;
> > >
> > > +       /* Refresh devargs from the EAL devargs list, as they may
> > > +        * have been added after the initial bus scan (e.g. hotplug).
> > > +        */
> > > +       dev->device.devargs = fslmc_devargs_lookup(dev);
> > > +
> > >         TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
> > >                 ret = rte_fslmc_match(drv, dev);
> > >                 if (ret)
> >
> > This looks like a strange location for a fix.
> >
> > The hotplug path calls this bus ->scan() which is supposed to refresh
> > the devices.
> > Could you double check if something is wrong on this side?
> >
> Hi David,
>
> rte_fslmc_scan() is guarded by a process_once flag and returns
> immediately after the initial bus scan. During hotplug,
> local_dev_probe() does call bus->scan(), but it is a no-op -
> scan_one_fslmc_device()
> (which calls fslmc_devargs_lookup()) is never reached.
>
> The device already exists in the bus device list from the initial
> scan, so find_device() succeeds, but its devargs pointer is stale
> (NULL).
>
> You are right that insert_in_device_list() does not handle the comp ==
> 0 case (unlike PCI which refreshes the existing object and frees the
> duplicate). Fixing that and removing process_once would allow scan to
> properly refresh devargs on rescan.
>
> However it is a larger change: beyond the dedup fix, device_count
> would need to be kept consistent, and fslmc_vfio_process_group()
> removes infrastructure objects (DPMCP, DPRC, excess DPIO) from the
> device list during the initial probe, so a rescan would re-insert them
> as new entries that would need to be handled as well.
>
> Making the fslmc bus scan re-entrant is a significant rework of a
> critical code path, for a use case (true hotplug of dynamically
> created devices) that is not common on NXP platforms.
> I think this is best left to the NXP maintainers who know this code
> intimately. My use case is grout, which uses the EAL hotplug API to
> late-probe devices that already exist in the DPRC at boot time.

Ok, thanks for the explanations.
I agree, it seems too intrusive for fixing this issue.


>
> That said, you are right that scan is the proper place for this fix.
> Rather than making it fully re-entrant, a simpler approach is to
> refresh devargs on existing devices when scan is called again:
>
>  if (process_once) {
>      DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
>      TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next)
>          dev->device.devargs = fslmc_devargs_lookup(dev);
>      return 0;
>  }
>
> Let me know what you think of this approach.

That seems a good trade off, as it avoids mixing responsibilities in
this bus code.

What do you think Hemant?


-- 
David Marchand

