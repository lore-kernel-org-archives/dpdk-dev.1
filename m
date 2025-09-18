Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4FCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 08:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43305402C9;
	Thu, 18 Sep 2025 10:38:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1109440288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 10:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758184696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llvdw+kg5t/xkhn6m6ErKb7khv+n3OA10BG+hh35h7g=;
 b=en8WC6rXzSTHFJKCmuFTP5LlTP94i3AOfRH2nowv4J029fBjljShOZ9OnE5erB2ze210c+
 nZHjCNDK+S6OMi1U0TLOQ0oK8XAEXJ6XLGqWjpABGYYPcZjvyyQ3mJh6e1SQNFvpHbjwUU
 pI+O/dy9F/s5CSXfGT+KH0O0eT6JSnw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-wou3v_ruNuSwAPxuSfkT5g-1; Thu, 18 Sep 2025 04:38:14 -0400
X-MC-Unique: wou3v_ruNuSwAPxuSfkT5g-1
X-Mimecast-MFC-AGG-ID: wou3v_ruNuSwAPxuSfkT5g_1758184693
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5790f60ec3eso236704e87.0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 01:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758184693; x=1758789493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llvdw+kg5t/xkhn6m6ErKb7khv+n3OA10BG+hh35h7g=;
 b=hmUyChOtc9iomT65ILZl+3QFv83lMDTzK3JqAs1vVU3RZqoKok+EfGHi4JD6qhMBcH
 lDz4wmFl9SD9XaH9Syt+xpHo+VivUnnLszroa2FMGcQ3lU96v+s092HoDnr8bRDJpa0x
 szj09yC1PwIbQyC0bOPA+l4z1ESz+gMLRCOP7oyY8DEggQ+vEfuuCvunSdqWZlf1MYOg
 bUGaAABFBZzrrh0tCkoxiJHHIp/C7VUYOGIGl3nQ0jYPpKgaLjeYYAMJSDWZlFSrcnxO
 9SC3zMeUPbXKxEjfuUymMDQtZWwsqDqXntBTtJzQqThevq+blYN1hHp3zU547nnQJ7oW
 6/Kw==
X-Gm-Message-State: AOJu0Yy1TIBRZ0EvO3/3KixPMIPJDznwuMESoTfJ9Fm9Y1Jr6qReKPXP
 6UlkrVYYsATVFNcFqItQ4BuyevbD/60XRSMbCiO536I2v6KZt3Z52PV6pkLzoJa8ZPQ1IaMkZ0U
 Vbr7VgfgsjGGgtSeF3gZ5/Pmg8slbiM+2hAanKHddxrJPU+3XLQfpzgUzJ7XBCZwfUnWV7MEcKD
 hEDsfbF1uBrft3NSL7nm4=
X-Gm-Gg: ASbGncsUYDKwb/+A8zyNLQqZLZTIANi8IU8cJoWSZGvVNbPnE43VnL39N6WUJF9Rprb
 gyeRdQr42XBPoq/w1xMHS306eLaYUxYdX8a0VrDN3KM6fpglnxeM/owbHjAosheNolHhNv35GWL
 Td39zlUVRI5Kw6dqEoBbdRXKA=
X-Received: by 2002:a05:6512:1546:10b0:578:c72f:2444 with SMTP id
 2adb3069b0e04-578c72f327emr487348e87.19.1758184692748; 
 Thu, 18 Sep 2025 01:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHNP7cnr1oGMiCoibqcJKMcjI06PxplJA3KK4zOWIlvEfAvBGUxWaBnhFpiz3SHhDshgt2pCyzlauA3Rh9OdM=
X-Received: by 2002:a05:6512:1546:10b0:578:c72f:2444 with SMTP id
 2adb3069b0e04-578c72f327emr487335e87.19.1758184692287; Thu, 18 Sep 2025
 01:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-5-david.marchand@redhat.com>
 <688448ee-3dcd-4bcb-a16c-0446e3936cf1@intel.com>
In-Reply-To: <688448ee-3dcd-4bcb-a16c-0446e3936cf1@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 18 Sep 2025 10:38:00 +0200
X-Gm-Features: AS18NWBST54C_GsLGskjao6j-BbXPrTSuC0pzdNTpYnk-HhQh5b5yaZiyZFCrHI
Message-ID: <CAJFAV8wRLT=YyDOQKN4cUhbQXhxHoBVUBUfLmMGPabzg3vwffA@mail.gmail.com>
Subject: Re: [RFC v2 4/9] vfio: remove public wrappers
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, maxime.coquelin@redhat.com, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yoafQnc-l6klunCxgTAHaQm6NoHgklWl-nucfic_1JE_1758184693
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

Hello Anatoly,

On Tue, 9 Sept 2025 at 17:38, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 9/3/2025 5:17 PM, David Marchand wrote:
> > The public header defines a number of wrappers that can be removed or
> > hidden internally.
> >
> > Either, those concern old Linux kernel versions that are not supported by
> > dpdk anymore (DPDK now requires Linux v5.4 at least), like:
> > - the request notifier feature, present since Linux v4.0,
> > - the noiommu mode, present since Linux v4.5,
> > - the capability support, present since Linux v4.6,
> > - the msix mapping feature, present since Linux v4.16,
> >
> > Or, those wrappers can be made private as only consumed internally.
> > - VFIO_GET_REGION_IDX() has no equivalent in the Linux uapi, but
> >    is only used by the Linux PCI bus code,
> > - VFIO_DEVICE_FEATURE is only used by the CDX bus code,
> > - the various macros around /dev/vfio/ or the noiommu kmod parameter are
> >    only used by eal_vfio.c,
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> <snip>
>
> >       {
> > -             .type_id = RTE_VFIO_NOIOMMU,
> > +             .type_id = VFIO_NOIOMMU_IOMMU,
> >               .name = "No-IOMMU",
> >               .partial_unmap = true,
> >               .dma_map_func = &vfio_noiommu_dma_map,
> > @@ -363,8 +363,7 @@ vfio_open_group_fd(int iommu_group_num)
> >       /* if primary, try to open the group */
> >       if (internal_conf->process_type == RTE_PROC_PRIMARY) {
> >               /* try regular group format */
> > -             snprintf(filename, sizeof(filename),
> > -                              VFIO_GROUP_FMT, iommu_group_num);
> > +             snprintf(filename, sizeof(filename), "/dev/vfio/%u", iommu_group_num);
> >               vfio_group_fd = open(filename, O_RDWR);
> >               if (vfio_group_fd < 0) {
> >                       /* if file not found, it's not an error */
> > @@ -375,9 +374,8 @@ vfio_open_group_fd(int iommu_group_num)
> >                       }
> >
> >                       /* special case: try no-IOMMU path as well */
> > -                     snprintf(filename, sizeof(filename),
> > -                                     VFIO_NOIOMMU_GROUP_FMT,
> > -                                     iommu_group_num);
> > +                     snprintf(filename, sizeof(filename), "/dev/vfio/noiommu-%u",
> > +                             iommu_group_num);
> >                       vfio_group_fd = open(filename, O_RDWR);
> >                       if (vfio_group_fd < 0) {
> >                               if (errno != ENOENT) {
> > @@ -1128,7 +1126,7 @@ rte_vfio_enable(const char *modname)
> >       }
> >
> >       /* VFIO directory might not exist (e.g., unprivileged containers) */
> > -     dir = opendir(VFIO_DIR);
> > +     dir = opendir("/dev/vfio");
>
> This and similar places: I would rather prefer if we used defines rather
> than repeating the same literals over and over in multiple places.

VFIO_DIR is a bad example, since it is only used here.
Code using such macros never changes.

>
> Other than that,
>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

But ok, we can keep those macros.
They'll need to be prefixed, polluting the VFIO_ namespace is dangerous.


-- 
David Marchand

