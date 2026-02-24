Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F2F3C985
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 14:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC9D402DF;
	Tue, 24 Feb 2026 15:44:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ADE6E40270
 for <dev@dpdk.org>; Tue, 24 Feb 2026 15:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771944287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UILWfny380lq2W4mgIv8tJPY2JOfC6+YGQulGGhu6mM=;
 b=TFiRAGTfljhWBo7eZqnmYaW0Zmer3f9GmO30iEczx1EUKTX3XxmBormr+JmRneQd57QLsL
 6LwyeTP1F6GejC0EzHqrsGv5iVhQjt8KNfyvf+ELI6IenQYWoLVwTaOjpqze2/F0FRTmwU
 4FA5uPhTt1ylMiUHl2/gcMNZcdQSxgo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-ysBYBcLfM5OLO-3PD0ciNw-1; Tue, 24 Feb 2026 09:44:43 -0500
X-MC-Unique: ysBYBcLfM5OLO-3PD0ciNw-1
X-Mimecast-MFC-AGG-ID: ysBYBcLfM5OLO-3PD0ciNw_1771944282
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38713b537d2so13310301fa.3
 for <dev@dpdk.org>; Tue, 24 Feb 2026 06:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944281; x=1772549081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UILWfny380lq2W4mgIv8tJPY2JOfC6+YGQulGGhu6mM=;
 b=sep0UOc/nBzuellZavAud2CLQAuV7UP3vaYIi3M7WxWW3Z0SGWHlyF4ilIMzhiFHl2
 R2KYNUDHjyf9P8M2Pk9WTI/XF1AAPpBaOUfpTUalP2cJFZ7EelGT742hTymrvDl6frUm
 qF3GKpmumOpv5HC7d1H/0iq3jmNmaq/bKHxTv2cFng+TClqULUdCF6ZeDFGR+JwPdAkL
 lD26z/ntitt9Maty1MKf9cbJuIKjaVcC9c6pNp1aZHrFinPV7A9xp2jRwLigTRGVIm99
 QIUEq8jBV7JBZ/Xv39nl5kvjghmKtrUA/YhDNZgsgORv2ZD8JXdrcVStHmePUHH71YWJ
 rutA==
X-Gm-Message-State: AOJu0Yw1qw+2Yz3FilaK/9ehuUVSQ1NBehj5iHnC+9ocW+AmNW5AEdrB
 05/EDwXK3bMb7/VuU7yKxwKFNg1aKJ/KHwljLTg1LozacmmS0EcyTHz0LqLMM8ThmW2CnCgD1wy
 B0B06M2q49knvKXDa/JGYi4wJ5rFIfBbogI8HJ13+0vcJ1zx5+DTw1QP0qdgiA/A4RYoUYF92NH
 h0YqZLXsTJALH+CHs2GNM=
X-Gm-Gg: ATEYQzyy6tDpxpywh8yDdrUBNN5vLCoOkthpge2Sm+3fnBXAzNUaa4tBMZvMzrjwMJ3
 GoV0a10nVVpYuXXTeL/Wi6XCRb/8qZHOMUJeC9OKD0xeEdPV7RxQWR2SjqoX/IrWr9TNJQ3BnuU
 ggPgmKqu2fd5nS6k5BHVzWW7V/R9/3rjxPhrRly1keWuZjnDPhJJgnyfgoWlh9L/4SaFZYGShlB
 Lpl/OvDKS40lyoq8hlglytiHUzd+u0reVXoCgeMQEmHUAuwkMuSQ9XOol763WZAFHDseQ==
X-Received: by 2002:a2e:bc08:0:b0:386:fa6b:44e0 with SMTP id
 38308e7fff4ca-389a5d6c05emr38857041fa.10.1771944281149; 
 Tue, 24 Feb 2026 06:44:41 -0800 (PST)
X-Received: by 2002:a2e:bc08:0:b0:386:fa6b:44e0 with SMTP id
 38308e7fff4ca-389a5d6c05emr38856861fa.10.1771944280350; Tue, 24 Feb 2026
 06:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20260224014259.443846-1-stephen@networkplumber.org>
 <CAJFAV8yNsWO7pFH3B4-Wce=XBMNA3N4t__YL7nDpKNeojV2Dtg@mail.gmail.com>
 <CAJFAV8z0oo6zUdfYJDPJe8pJCkpZ4WVyABn0Xq1=EN=s+6givA@mail.gmail.com>
 <20260224064110.1d65ef69@phoenix.local>
In-Reply-To: <20260224064110.1d65ef69@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Feb 2026 15:44:28 +0100
X-Gm-Features: AaiRm50vJfZYRuBaDPo8ioOg8S51m65J3FAjJXwmLgSAFvpst33DsAbf5_aHMdE
Message-ID: <CAJFAV8xC=F542X149H7C5+iA5gkhN_ZXgHaghr+xmLmEgMhQEA@mail.gmail.com>
Subject: Re: [RFC] net/vdev_netvsc: disable auto-detection by default
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q-UQiIi5qSH8WHMkOTZW19uqpGm1CqxLAA2wiS0RQSc_1771944282
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

On Tue, 24 Feb 2026 at 15:41, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 24 Feb 2026 08:58:45 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > On Tue, 24 Feb 2026 at 08:41, David Marchand <david.marchand@redhat.com> wrote:
> > >
> > > On Tue, 24 Feb 2026 at 02:43, Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:
> > > >
> > > > The vdev_netvsc driver auto-injects itself on Hyper-V via an
> > > > RTE_INIT constructor. This interferes with tests on github actions
> > > > which uses Azure where the driver probes in forked subprocesses
> > > > and crashes on uninitialized interrupt instances.
> > > >
> > > > Guard the auto-detection behind RTE_LIBRTE_VDEV_NETVSC_AUTO
> > > > (disabled by default). The driver must now be explicitly
> > > > requested with --vdev=net_vdev_netvsc.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > The failure in GHA can be avoided with a simpler:
> > > https://patchwork.dpdk.org/project/dpdk/patch/20260223155603.3651641-1-david.marchand@redhat.com/
> >
> > After rerunning with debug, the vdev netvsc is still probed, but is
> > not at fault for the recent failures we saw.
> >
> > VMBUS_BUS: vmbus_probe_one_driver(): VMBUS device
> > 7c1e52d8-3f86-7c1e-52d8-3f867c1e52d8 on NUMA socket -1
> > VMBUS_BUS: rte_vmbus_map_device(): Not managed by UIO driver, skipped
> > VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device net_ring0
> > VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device
> > net_vdev_netvsc
> > DPAA2_BUS: fslmc_vfio_close_group: Get fd by name((null)) failed(-19)
> > DPAA2_BUS: Unable to close devices -19
> > DPAA_BUS: dpaa_bus_cleanup():  >>
> > DPAA_BUS: Portal already cleaned
> > DPAA_BUS: dpaa_bus_cleanup(): Bus cleanup done
> > Calling recursive action for test_invalid_vdev_flag
> > Returned from recursive action for test_invalid_vdev_flag with 0
> > Cleaning up /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> > /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance returning 0
> > Test OK
> > RTE>>
>
> The DPAA_BUS looks like noise.
> And also VMBUS.
>
> Maybe we need a --no-bus flag that shuts off all buses?

I have this patch in store :-) since I also need this for OVS, I'll
send it soon.


-- 
David Marchand

