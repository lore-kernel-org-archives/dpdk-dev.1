Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44E606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nev3Zp9/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 133C7402B0;
	Sat, 24 Oct 2026 10:56:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7080D4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 10:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792832181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYCOhNQtYIxLw6GlG6DszyYMOVqkCFbmctxa++GmMzE=;
 b=Nev3Zp9/RqMuGjtd+ymeDmp+57gtODm7vn1Ny703gA/aixjxoUYTWG8sldZ162sp9Jp7dm
 8C3P1lCbM4g/PkQ8XKbGJUePmprgzpH+R0DH0tsmi0RPlZwOeZ5aBcRyjzwNLbWtHDvEt9
 tt9h7IhxDTPUUzuNzQPOkbnekYkZ6VA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-WXvhx0IZMUCzRshJ1wG5Jg-1; Sat, 24 Oct 2026 04:56:16 -0400
X-MC-Unique: WXvhx0IZMUCzRshJ1wG5Jg-1
X-Mimecast-MFC-AGG-ID: WXvhx0IZMUCzRshJ1wG5Jg_1792832175
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5bcf39533ebso971579e87.0
 for <dev@dpdk.org>; Sat, 24 Oct 2026 01:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792832175; x=1793436975;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rYCOhNQtYIxLw6GlG6DszyYMOVqkCFbmctxa++GmMzE=;
 b=IyUnYIQEYIJtCxEAarpQw2KPcvi2/Kmarb2GWc8d2zO1XvLbW5yBEyTBOHoKb+8bGd
 ALx32x2CF4Jkx1xJD62NIX76F3gZvl6Ds1aBEk4ejE5EaNjnduODsv6ABGWkMRvIfb7P
 qclxpRHgd39LY4mOfKDOA2zqLZ749Gzs9j/dgNvCHkSmGtZUR/u/XjRlmsny9lbzC7qS
 q2RpxRiT51OVw2Cbvnp1BTha5J4fa2h6TXsoPtJ/wNMiIuMMAFk2+yRd9Hoi/iEjtBgO
 08cuKKJCl7dmuk4O7gnCDeUCoEU0wNkPkcrik8pWhdEaH5oJUCTAr8OWEnY9VxWF8+lR
 afxQ==
X-Gm-Message-State: AFq9FYKmHt/2RIFl80FIDu7650FDHcwwbNE1h+RU60cX1WDI+u1mDjeX
 RxiKANBKqG4q5q18iiatnaUsvnofx/C//rV2CzZ2Pcygis/IJJ/Fr2JwWnU5iAKDbhQl3JssDKP
 clbHorVu88NfH7ZfClGXzjaj8xqHLecDus6DNljWucwnRqXHaSgOxgbJNhVMJdTuSb9Nr5A1r21
 dCpesic9SM+EGgmPqgXBY=
X-Gm-Gg: AYBFou3mdCcntP8ErhSNIZ8xATWK4TCrUg8SOzqkzmbXdQ3PK4ndfwpNe9H24ZxkygT
 paDjq/9zA3H+oad7wooh7MyNjh2Wp9zsgETiAAvGQvM5KKBWnq9hwcRCj6/EIjFCSFBmXS32+G9
 J1FpLYsfGJai3MjKoNDzda9tIj/vEB8UvJV6LG+7hKyb1VXc7MZO7yzGoNd+CHFTrvvLQdGseWJ
 ZyfIgqKo0Zwp+Kfg9THdCRAvp0bEGBMOpfgqcGciw5YYzJ0
X-Received: by 2002:a05:651c:1b13:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3ac6f9f75bamr4017951fa.0.1792832175363; 
 Sat, 24 Oct 2026 01:56:15 -0700 (PDT)
X-Received: by 2002:a05:651c:1b13:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3ac6f9f75bamr4017911fa.0.1792832174856; Sat, 24 Oct 2026
 01:56:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <6313a2be1e6288e2844cb13e0c8523f7296c5b98.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8zHmbL99Xi3REFd6P0WEewstUZ29=imnbVoxym9KTWA+w@mail.gmail.com>
 <6be57c4e-0c3d-4505-a64b-ac7f3037d7da@intel.com>
In-Reply-To: <6be57c4e-0c3d-4505-a64b-ac7f3037d7da@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 24 Oct 2026 10:56:02 +0200
X-Gm-Features: AclHuK9toQ4MtENqyaM_pQCxAkJui7srbqldR2-pa_DjJSGQbjOv2xc_k8_T0m8
Message-ID: <CAJFAV8yh9UxD9D+bNCvh+tcKASpVg0x=czpDfdJnVvgXxPmxsg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] interrupts: warn on leaked event FDs
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sBgRZUL-fL8tb4i8vX7Navhjcv6VNdQJKrTTEN39NZ8_1792832175
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 16:48, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 10/23/2026 4:41 PM, David Marchand wrote:
> > On Fri, 23 Oct 2026 at 15:52, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> >> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
> >> index aadb7b84a22..f6f51ba53c0 100644
> >> --- a/lib/eal/linux/eal_interrupts.c
> >> +++ b/lib/eal/linux/eal_interrupts.c
> >> @@ -1667,6 +1667,8 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
> >>                  for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
> >>                          close(rte_intr_efds_index_get(intr_handle, i));
> >>          }
> >> +       for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
> >> +               rte_intr_efds_index_set(intr_handle, i, -1);
> >
> > We don't want to waive for types != VFIO_MSIX, do we?
> >
>
> Looking into this further, I suspectwe want to check for != VDEV
> instead. All handle types except VDEV will write into the handle.

Indeed, I had misunderstood rte_intr_efd_enable...
Ok, I'll respin those patches as part of my series and let the whole
set of changes go through CI.


-- 
David Marchand

