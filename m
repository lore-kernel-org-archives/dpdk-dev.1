Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC56C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 14:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E24F40144;
	Thu, 24 Sep 2026 16:00:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 788BC400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 16:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790258435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WRkDhDU/rh7KEFPn7RcfZ3+QnZcbkFB9FdWPzGWJdKU=;
 b=EWe5IaCDcIFDhANocn9wYWsVx7aIxqumeRQkx1N5iQs0NZW87Cwr/ZIjSbpBZcERbe+Hus
 y6Jm/l8CEb0fzmIxQGMZ5x5jFjErhDVTqQlEnrXvw2HEKUCtVkHlAFo+jTM+XldVsGp2Oy
 K5sFM9ZaxqUK69CnMKs2+ziKfrAqpuI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-QduaIR8RNQ-ZJ_UexJY0FQ-1; Thu, 24 Sep 2026 10:00:34 -0400
X-MC-Unique: QduaIR8RNQ-ZJ_UexJY0FQ-1
X-Mimecast-MFC-AGG-ID: QduaIR8RNQ-ZJ_UexJY0FQ_1790258433
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b4fe10d092so1525050e87.0
 for <dev@dpdk.org>; Thu, 24 Sep 2026 07:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258433; x=1790863233;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WRkDhDU/rh7KEFPn7RcfZ3+QnZcbkFB9FdWPzGWJdKU=;
 b=TKcIPxczBHnStUo8ChO+aCo1ijWsks6RXukJQhWBzB7GeyDSIC6FdoQGl9UpH00hWJ
 mrjypIt6cTWWXg4oqT4wrSZDXcDZyQk8wFcByerYuitUghaiGe0FqmKgixIdhffVtEWf
 TMpzTcDTJCSoIt/0kIQgRZMTfzT1FFGhmWW1xTqQj0KcNQ7P93vsX3rn5RrqTnQdH585
 wjQMmNYYqaFD422YQznAO2G2RZ+rKr4SLXPXCzhCMJRZv0Qr16utoyXn56C0QRDVe+9s
 Z1o/I6FgR5aPx6RZ7AAH0ohRLfnY/+RdspcGWlzfzA6dPbtHjvgj1kp7R537UT/ihh8v
 zHjg==
X-Gm-Message-State: AFuF++m+kYD0Zhye5jGPu0S67bnHG+Br8H2icWw+njvybkYMr+rHD3Sa
 8dkQjBt07yuY5nCX/PRezJGXAGc9qJbzHQx5f3tyaB+clvVxWQQ5BIi1q1uyklixqE4jq3utOtK
 yeVbJ31eptcwIxoIRXpmDZKM6EOYnio5eoMoseMow+4lrR/ZpsS/a/i5OjnS5QS9cDoM6YQuAmB
 1SccyIcuSBXii/fAValIk=
X-Gm-Gg: AYBFou3vHuF/w2zOTmptC+EhuAhqH92Nu0WPyab2zcNF58IT2l3yg+K42TY4rqHFsL7
 VZUF8L/NFtFEiYKjhXritvZ1eehYcDv5SasF3ovIPIhEyL9oWEGsvOztWhaJUyEn89qXJnwsChl
 6eQn+jUBQ5ngDCtysOVwIaF/UPgO4Y2x0FdDwvyDpDy0zFJ2HTscIK7thHB8RFK2PMMslSXJZmF
 vDI/AV7ZiTs3B8wb1P47mt8YFeLXJ0e3KedbK3L2uiJpay4
X-Received: by 2002:a05:6512:3f01:b0:5b8:c5a4:8c9d with SMTP id
 2adb3069b0e04-5b8df07ac87mr1056075e87.31.1790258432705; 
 Thu, 24 Sep 2026 07:00:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3f01:b0:5b8:c5a4:8c9d with SMTP id
 2adb3069b0e04-5b8df07ac87mr1056060e87.31.1790258432223; Thu, 24 Sep 2026
 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
 <CAJaqyWc9F=kVhFFoJzMZSQDw30qsdi932S1TaDbkqSH-tmdo=w@mail.gmail.com>
In-Reply-To: <CAJaqyWc9F=kVhFFoJzMZSQDw30qsdi932S1TaDbkqSH-tmdo=w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 24 Sep 2026 16:00:19 +0200
X-Gm-Features: AclHuK8JIz2Lb8Sn1GbcEBQu5LosgOxuhyup6qX-VcNgUDJSq_8XFzc-gL94rA8
Message-ID: <CAJFAV8w+cau6y0dqdDP7iNHsdjSBNvj6B6m6iy2JCnVf5nLNng@mail.gmail.com>
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, Yongji Xie <xieyongji@bytedance.com>, 
 mst@redhat.com, jasowangio@gmail.com, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: btI_ZUUQVz5GrSI-58TyJtbaXseVjBofhF6C4dMba70_1790258433
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

On Thu, 24 Sept 2026 at 14:33, Eugenio Perez Martin <eperezma@redhat.com> wrote:
> > diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/vfio.h
> > index 79bf8c0cc5e4..c85dcbfe302b 100644
> > --- a/kernel/linux/uapi/linux/vfio.h
> > +++ b/kernel/linux/uapi/linux/vfio.h

[...]

> > @@ -1468,6 +1497,64 @@ struct vfio_device_feature_bus_master {
> >  };
> >  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
> > + * regions selected.
> > + *
> > + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
> > + * etc. offset/length specify a slice of the region to create the dmabuf from.
> > + * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
> > + *
> > + * flags should be 0.
> > + *
> > + * Return: The fd number on success, -1 and errno is set on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
> > +
> > +struct vfio_region_dma_range {
> > +       __u64 offset;
> > +       __u64 length;
> > +};
> > +
> > +struct vfio_device_feature_dma_buf {
> > +       __u32   region_index;
> > +       __u32   open_flags;
> > +       __u32   flags;
> > +       __u32   nr_ranges;
> > +       struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>
> Not all gcc versions of CI like the __counted_by argument. Should I
> not import this header?
>

We import and update all uapi headers or none in DPDK, for a given
kernel version.
And the CI checks that the imported headers are aligned with the
announced kernel version (meaning that we can't update our local copy
of the header).

We could import linux/stddef.h but it may become a problem in the future.
Or pass a -D'__counted_by(a)=' option in the DPDK project CFLAGS if
the compiler does not support __counted_by...
Or another option would be to update all users of linux/vfio.h in DPDK... :-(

Other ideas?

-- 
David Marchand

