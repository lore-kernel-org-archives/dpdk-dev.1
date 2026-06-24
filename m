Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7708CDB470
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 06:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62FB24025E;
	Wed, 24 Jun 2026 08:51:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5A6C040150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 08:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782283886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bb4oB/s3UDhCzS2kj+TNT4Dli+hOQFKWzoXUwAhkSsI=;
 b=UYPSLv6ErLZ62GoRgrURdEUrd63TPNqcmVriLnY7EuMYgxqhPvvIYB+7fKQqcNdaVRd/d8
 KC/OYgwEuaRzpRZ4LL1vry08a5f/6Ug9+jGnj3gV5eXj0+LUfKRyQ+Y+yGuQsKwcddREjO
 z0+1+DMzPDkpFY6xXX3zQwRZ/s/bqQc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-8UCw_tMRNI-cdst7sIZRsg-1; Wed, 24 Jun 2026 02:51:24 -0400
X-MC-Unique: 8UCw_tMRNI-cdst7sIZRsg-1
X-Mimecast-MFC-AGG-ID: 8UCw_tMRNI-cdst7sIZRsg_1782283883
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39695d8ceaaso2607291fa.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 23:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782283883; x=1782888683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bb4oB/s3UDhCzS2kj+TNT4Dli+hOQFKWzoXUwAhkSsI=;
 b=OyZHxYC3jhkszfZTlhaEle35z+YEmfrYMfxLSTQ+5NnG9a7Lf6ttFiNp0bz4guH1Wg
 ogZwa8rMgm0PSzUF2piOMpSXrV4ke82chKPNQD6zs83wxsBGJStGvCnfTuQEbu+E82JG
 eFABD+R4f6VrLu5TITnbGE6xMf1ZMticCb8gwZT8akUEW3Y7IKacC6ZD7fiN4tyQiihN
 +WsLiM6Q4lIsdlKd1lDADpQZ36SAw2NKLTwfdpePJFuNhWhPT9u2NnXNquW0G3ccMVsw
 OUDCcMml02qshlzM8ezJraDmxAgaunNzq7xDbTnZXds+PjKBFb2tn3aFYzcCBQjWVXDz
 poPA==
X-Gm-Message-State: AOJu0YzA9IHNSjFdaJGBw0pMz4fh2IiqzBo5IQimLH4IwEFBNJhoqZ7s
 yt3sapBTxmFhu4xoX+QZJtB26oSkkYADjyZKzSrBYK2r/3Ljcb8VUzIcJJV2eR0Ne9zb8jDnx3m
 5X+JIKfikQYxuzlcHDuWdvVWLbqy0bjQ1yMEeBBLzjg/3+EHpT59dMCSj472GAFJUeoM1cH6kNG
 2N3OLHN1H4toJC6SxCvNY=
X-Gm-Gg: AfdE7ckPb1RhCL2IqgeWskG/OnM+kxCxwlI6paGWZQkVLDuzE8gPWoqpFsysgIANuVP
 C6TwakcBioz2gHftOyo0gB0zYjvy37WTkTh4XAttdbJdxjq8yBmvupnAGZr3e+Yr3t+H/v/LHxT
 nmYWLAxaA/+bUGnx0eiHqrNKX3sgjWo6i8Uv33UgOnsHqF0/sVZofTO1SjjH2bs1jEsga+rO9ho
 9Qh8ihAvSXDzPyRGYFGggIDuGO+sGrbfTNG9o3HDKN6plORZ0aKGeP0FsU=
X-Received: by 2002:a05:6512:2c87:b0:5ae:9e01:57a7 with SMTP id
 2adb3069b0e04-5ae9e015817mr265008e87.51.1782283883294; 
 Tue, 23 Jun 2026 23:51:23 -0700 (PDT)
X-Received: by 2002:a05:6512:2c87:b0:5ae:9e01:57a7 with SMTP id
 2adb3069b0e04-5ae9e015817mr264996e87.51.1782283882780; Tue, 23 Jun 2026
 23:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-5-david.marchand@redhat.com>
 <c4c30773-40ad-4eca-a369-926886e17ab1@huawei.com>
In-Reply-To: <c4c30773-40ad-4eca-a369-926886e17ab1@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 24 Jun 2026 08:51:11 +0200
X-Gm-Features: AVVi8CfM-DqQBzp60RW0g5HBrG9aiENN-1biXjrt_KuWZ9jf8tU6gsmmUr2Cxvw
Message-ID: <CAJFAV8wGuVYfe7X857EauTHfeHaFEN8AFZteracs9OYFQpVN5Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] bus/pci: fix mapping leak in bus cleanup
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, longli@microsoft.com, hemant.agrawal@nxp.com, 
 stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 54FpSSSx3C3IfwGVMeIloSflno8QJBCpC_Cneuv4x7s_1782283883
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

Hello Chengwen,

Thanks for the reviews!

On Wed, 24 Jun 2026 at 03:24, fengchengwen <fengchengwen@huawei.com> wrote:
>
> On 6/23/2026 6:54 PM, David Marchand wrote:
> > When calling this bus cleanup, PCI resources were not unmapped.
> >
> > Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/bus/pci/pci_common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
> > index fd18b8772b..791e9a7b49 100644
> > --- a/drivers/bus/pci/pci_common.c
> > +++ b/drivers/bus/pci/pci_common.c
> > @@ -344,6 +344,10 @@ pci_cleanup(void)
> >                       rte_errno = errno;
> >                       error = -1;
> >               }
> > +
> > +             if (drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
> > +                     rte_pci_unmap_device(dev);
>
> rte_pci_unmap_device() also invoked in some drivers remove callback, e.g.
>   eth_virtio_pci_uninit()
>   ifcvf_pci_remove()
>   ...
>
> In this case it may doulbe-free

$ git grep -l rte_pci_unmap_device drivers :^drivers/bus/pci | cut -d
/ -f 2,3 | sort -u
net/nbl
net/virtio
net/xsc
vdpa/ifc
vdpa/nfp
vdpa/sfc

Those drivers do not set RTE_PCI_DRV_NEED_MAPPING and have their own
logic when it comes to mapping/unmapping resources.

$ for drv in $(git grep -l rte_pci_unmap_device drivers
:^drivers/bus/pci | cut -d / -f 2,3 | sort -u); do git grep -l
RTE_PCI_DRV_NEED_MAPPING drivers/$drv; done
drivers/vdpa/nfp/nfp_vdpa.c

I suspect calling rte_pci_unmap_device twice will end up with some
error before a double free.
Worth a fix on vdpa/nfp regardless, I'll work on it quickly.

Thanks again!


-- 
David Marchand

