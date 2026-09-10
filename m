Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C9C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:30:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04904410DC;
	Thu, 10 Sep 2026 14:30:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 886174028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789043441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUnnBT9bjZL13vexCKDy3UfjGo9qfWY3IlChzcT/XSs=;
 b=ALNmx6kM1Q2+QzJQFknat6JdmYC6rrRmY+LBYeT5GXxDFINMYnZU7tRWQD5tvaatQZlY3L
 NHLxugF1qeGIdwgk2n24fSv5t65FbxCWdPAmGD07uT0cnndSoJyp56/Mzng2pI/w1Kb8Mn
 8W5tUUcLvD7xsUVXBJMH+oh8LX8sAsc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ueN4njqZOG2Q9x-KxrDLFg-1; Thu, 10 Sep 2026 08:30:40 -0400
X-MC-Unique: ueN4njqZOG2Q9x-KxrDLFg-1
X-Mimecast-MFC-AGG-ID: ueN4njqZOG2Q9x-KxrDLFg_1789043439
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b823dca1a0so1323070e87.1
 for <dev@dpdk.org>; Thu, 10 Sep 2026 05:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789043439; x=1789648239;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JUnnBT9bjZL13vexCKDy3UfjGo9qfWY3IlChzcT/XSs=;
 b=Q4IL4wWaYxbTGAVpWZlcap7vQoYTq/JlC+NTsx3RM1uYoD6KuhDgyfJhIWsxJJ3oHt
 U7oUpRkey8jYkFZBlrbVXCreBW8Eh837yLtXW/O4Bvge6LBtjXjNQKYOizBAjmaYjMY9
 2cWTZXXHAvbb2DVODgOCxwcrCeOOzfgdvvM+0y7VQZDbn6f0IC+VSlMFTDTjnJ7zHN0H
 fuuNJl2ZMVZZd8Z0B5ZLhobm+qczOUR5k1gZsCV+3SOFQVUYXE0ktC8sYc/XFtGXbA2t
 UI3BYJ62S9mmfOgbTbr8jSAJ+VaXVWPkNtY/FU3KugmQQlD+CMgrRaS4PkHpV6J5helq
 43WA==
X-Gm-Message-State: AFuF++lOuMqatqAnxEYVmZA6l6rB0MZAqNQb4uD84peXy1NAGPN4Jpaf
 EJwzrJMOerQgprmIKn2qb0hrSrLqQ9Ts0HLb46oSKxpi9DbBWeN16MgoztGxJVkCv1it2TLNn4Y
 l2okjfFEF8v5FKs6nXf7sdG4R36igylyZHZQNUD1EhiJ3yETPD9eqBAv23jCGvOEAqCQTv2LFd8
 +HOt8OFAfA+n2k934K8iw=
X-Gm-Gg: AYBFou3Kzscun0INYTOPohZ2I1ljcAwllYDNGBXkvTkXn1EuxvDl+jP7pr0K3Ib/1Jl
 XnHhgQRDF7qWu67kH7LApyx82qVGpq+jyugsrvITpaOP9imwqAg9ewNfw+L3W+0t5+PHj8iQU3E
 cPtLsT7KYgXG9m7lUtCvFIFMIy2qG2IixjKbyLa/+XOt5HDf/Z8SE3WPB4SLoEQx+P9osYWzReL
 PV52IVpO0VI2ujATxM/hCSYl/vTHl3m6JqJCOhJU3WX40KQ
X-Received: by 2002:a05:6512:b8d:b0:5b6:1a7c:59d2 with SMTP id
 2adb3069b0e04-5b61a7c5a26mr6925995e87.44.1789043438992; 
 Thu, 10 Sep 2026 05:30:38 -0700 (PDT)
X-Received: by 2002:a05:6512:b8d:b0:5b6:1a7c:59d2 with SMTP id
 2adb3069b0e04-5b61a7c5a26mr6925985e87.44.1789043438485; Thu, 10 Sep 2026
 05:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <115329f1-ef86-4330-a198-2471cf3d69f5@intel.com>
 <632cdb2b-3df4-47f0-9405-5a164bd82dd6@intel.com>
In-Reply-To: <632cdb2b-3df4-47f0-9405-5a164bd82dd6@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Sep 2026 14:30:25 +0200
X-Gm-Features: AcwNN1XsgnUYwxUjMC7z6J0s4loi6n1mhe_ze99YtjcWt3YWe8CpZIwTrsI2Ytc
Message-ID: <CAJFAV8z2SwkPkn=nL7CFa4SW4P5ghbVGz6P=J2=xtFJMogUTAw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XsXjw2Cict0H4RbXfcilYoSFe8U30Gbm3Or4V-8jqjo_1789043439
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

On Thu, 10 Sept 2026 at 14:20, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 9/10/2026 2:13 PM, Burakov, Anatoly wrote:
> > On 9/4/2026 2:28 PM, David Marchand wrote:
> >> E810 hardware provides 32k switch lookups.
> >> Thanks to this, it is possible to allow a lot more secondary mac
> >> addresses than what is possible today.
> >>
> >> In practice, the maximum number of macs available per port may be lower
> >> and depends on usage by other (trusted?) VFs on the same PF.
> >> There is no way to figure out this limit but to try adding a mac address
> >> and get an error from the PF driver.
> >>
> >> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> >> accordingly.
> >>
> >> Signed-off-by: David Marchand <david.marchand@redhat.com>
> >> ---
> >
> > On another note, I don't think this is even compatible with ethdev API.
> >
> > In `ethdev_driver.h`:
> >
> > struct __rte_cache_aligned rte_eth_dev_data {
> >      ...
> >      /**
> >       * Device Ethernet link addresses.
> >       * All entries are unique.
> >       * The first entry (index zero) is the default address.
> >       */
> >      struct rte_ether_addr *mac_addrs;
> >      /** Bitmap associating MAC addresses to pools */
> >      uint64_t mac_pool_sel[RTE_ETH_NUM_RECEIVE_MAC_ADDR];
> >      ...
> > }
> >
> > example of this bitmap in rte_eth_dev_mac_addr_remove:
> >
> >      /* Update NIC */
> >      dev->dev_ops->mac_addr_remove(dev, index);
> >
> >      /* Update address in NIC data structure */
> >      rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);
> >
> >      /* reset pool bitmap */
> >      dev->data->mac_pool_sel[index] = 0;
> >
> >      rte_ethdev_trace_mac_addr_remove(port_id, addr);
> >
> > meaning, the mac_addrs array and the mac_pool_sel have the same
> > limitation because they are indexed by the same index.
> >
> > RTE_ETH_NUM_RECEIVE_MAC_ADDR is defined as 128, so correct me if I'm
> > wrong here, but according to ethdev API one cannot have more than 128
> > MAC addresses?
> >
>
> I would even go as far as to suggest that ethdev API should probably
> check max MAC addrs number to make sure it doesn't exceed the size of
> RTE_ETH_NUM_RECEIVE_MAC_ADDR, because otherwise that's a latent
> potential buffer overrun?

This limit is something that was put in place for VMDq.

I removed it in next-net (it did not hit main yet).
https://git.dpdk.org/next/dpdk-next-net/commit?id=f9ddb36e00655e38c115502d5ee180d4fda633c0
https://git.dpdk.org/next/dpdk-next-net/commit?id=31ea14ef354c8664482af27039ecd3c6130254b1

There may be some check missing in case a driver announces a
max_mac_addrs larger than RTE_ETH_NUM_RECEIVE_MAC_ADDR with VMDq
enabled.


-- 
David Marchand

