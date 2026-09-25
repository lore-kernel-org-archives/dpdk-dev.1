Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A73C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D16124328B;
	Fri, 25 Sep 2026 12:22:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55C6D43278
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790331753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Thf+OnZOyuX8vow5q3MQQg7Zbt30Hmwm4j5iInewj0=;
 b=gT8oxOi1lDqanxTXl19wtuDSM/qM1CH8GAkieTvQ+DNub7gcLKCjK/X89k6G88OYuHKun2
 8KiFuKLbmPQ1LGzQ0A1uJc0/TQ5oyD16w/mfbgbkNnXNVuDSmBZQ/yG6rzNvBZNECIAUmC
 nRKH5tSEd33VcECB7c9HtlQa3QXUN88=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-ew6irp2VOYioBhWQRsACfA-1; Fri, 25 Sep 2026 06:22:32 -0400
X-MC-Unique: ew6irp2VOYioBhWQRsACfA-1
X-Mimecast-MFC-AGG-ID: ew6irp2VOYioBhWQRsACfA_1790331752
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66988049306so931522d50.1
 for <dev@dpdk.org>; Fri, 25 Sep 2026 03:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331752; x=1790936552;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Thf+OnZOyuX8vow5q3MQQg7Zbt30Hmwm4j5iInewj0=;
 b=V/JIUbvJNRxa9i0EZ4WFNwbA4oL9rBkAegwm/DiQx9qvNMvAjV9Pr4vL6wIEr+eXkJ
 J5SyugDiouJxvgAcZJK2GuVNO8aYj/D6/3+nSTU1Hhn25UdcBZ4/6aXUUL//eaHWJu8z
 sXBLswH5rCTo33AP8j0Widg0Zhw6P06JhPTuk2ERnkKpuFYjs8hRki3pCt5VIcwkJi3A
 ZmRoZPUpbaDvTH2pLy+9uHOHnZ8oBjO1/yLIm7qwFbc7eMM6pfIUYaqU/H+qcdsMO+Ie
 l0I0XZJgY+IWNSglyi+HGJ5SS18dOHJdrV/S0/Gcl5WYGFRx9Pb3Dy5mHquRJk1QemnK
 yQ4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0dSdcwP2ozHBhcuW7J4+CFtuxFHBr+O5hgiNDsOw+LMpxAqhmtm8qi8kzwj102SBQ5zk=@dpdk.org
X-Gm-Message-State: AFuF++nlLfcdgb2keXIWvPPrzVSPw5pnSydWDq7kFse8eh5UHLF4eFHh
 qvAsqgFl5JCcUr8+uB5BMzsN3bbGcdOkxB0gcJCmerliuSKpk97WjZoiNYijSDlRG8873I0v52d
 wHScif5tD5sUA0RG2RVJWTNb0GcGDWOGFrQeC7cYNs60b3mjRk2q1+FJdJwZDY2jDuO/235MSnv
 tMXX9/gkH2KVHjEmFeSqI=
X-Gm-Gg: AYBFou0k0CTy5WaG11BDgokAVB4Yj5UgqX0CfFfhmbmRlWnevET5uYV14U0ElGb4p5R
 ipw6mLDFdO8dDnRcDOrsLgA3X9Xox8EIx7j4HdTb9SWIft+lyyBNfrfuZW2kmrzxY8sJ5WJvZzQ
 mlmW7XwPPZguNEDNi1/stRtZ/99f3CUT2aVdnR+VoyDKgrxI52KK3okeVctbva0u/oBrZghi9bs
 kygOD1NImCCmVnHl1JlwAEKyDmEVTsoe6Ijz98CkioUQqXCF7hiqa7Gov0=
X-Received: by 2002:a05:690e:a4f:b0:672:eefe:5e08 with SMTP id
 956f58d0204a3-672eefe5f6cmr1869771d50.15.1790331751934; 
 Fri, 25 Sep 2026 03:22:31 -0700 (PDT)
X-Received: by 2002:a05:690e:a4f:b0:672:eefe:5e08 with SMTP id
 956f58d0204a3-672eefe5f6cmr1869762d50.15.1790331751497; Fri, 25 Sep 2026
 03:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
 <CAJaqyWc9F=kVhFFoJzMZSQDw30qsdi932S1TaDbkqSH-tmdo=w@mail.gmail.com>
 <CAJFAV8w+cau6y0dqdDP7iNHsdjSBNvj6B6m6iy2JCnVf5nLNng@mail.gmail.com>
In-Reply-To: <CAJFAV8w+cau6y0dqdDP7iNHsdjSBNvj6B6m6iy2JCnVf5nLNng@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 25 Sep 2026 12:21:54 +0200
X-Gm-Features: AclHuK-fpCoYOYQSl_3nw2FgpK7znUY_FBYgKLORdOjNxQuATmPdr20w8AD_dBo
Message-ID: <CAJaqyWdOW45=8qO3STfS74CDqQ5uQaDVETW0uZ5VYR6q=H4GOQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
To: David Marchand <david.marchand@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 chenbox@nvidia.com, 
 Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jcxm_Nf3RzclT4rCJGw0HGFaLG2VZeREBUGQzToyY4A_1790331752
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 24, 2026 at 4:00=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Thu, 24 Sept 2026 at 14:33, Eugenio Perez Martin <eperezma@redhat.com>=
 wrote:
> > > diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux=
/vfio.h
> > > index 79bf8c0cc5e4..c85dcbfe302b 100644
> > > --- a/kernel/linux/uapi/linux/vfio.h
> > > +++ b/kernel/linux/uapi/linux/vfio.h
>
> [...]
>
> > > @@ -1468,6 +1497,64 @@ struct vfio_device_feature_bus_master {
> > >  };
> > >  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
> > >
> > > +/**
> > > + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
> > > + * regions selected.
> > > + *
> > > + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_=
CLOEXEC,
> > > + * etc. offset/length specify a slice of the region to create the dm=
abuf from.
> > > + * nr_ranges is the total number of (P2P DMA) ranges that comprise t=
he dmabuf.
> > > + *
> > > + * flags should be 0.
> > > + *
> > > + * Return: The fd number on success, -1 and errno is set on failure.
> > > + */
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
> > > +
> > > +struct vfio_region_dma_range {
> > > +       __u64 offset;
> > > +       __u64 length;
> > > +};
> > > +
> > > +struct vfio_device_feature_dma_buf {
> > > +       __u32   region_index;
> > > +       __u32   open_flags;
> > > +       __u32   flags;
> > > +       __u32   nr_ranges;
> > > +       struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ran=
ges);
> >
> > Not all gcc versions of CI like the __counted_by argument. Should I
> > not import this header?
> >
>
> We import and update all uapi headers or none in DPDK, for a given
> kernel version.
> And the CI checks that the imported headers are aligned with the
> announced kernel version (meaning that we can't update our local copy
> of the header).
>
> We could import linux/stddef.h but it may become a problem in the future.
> Or pass a -D'__counted_by(a)=3D' option in the DPDK project CFLAGS if
> the compiler does not support __counted_by...

I guess this one is the most straightforward. I'll try to make the
needed changes in meson and send a v2.

Thanks!

> Or another option would be to update all users of linux/vfio.h in DPDK...=
 :-(
>
> Other ideas?
>
> --
> David Marchand
>

