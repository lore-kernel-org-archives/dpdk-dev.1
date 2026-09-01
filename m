Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD7C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 08:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F03EB402E9;
	Tue,  1 Sep 2026 10:17:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B7AD64027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 10:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788250665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VcSmT8viBHBKRErX7hlq7HzklCsrxw5oi/tyYmpXz4Q=;
 b=E1KvcAUVR0RWO0c7owVXp/377jRtGpqvnFHQiUCe3KsQbNdDge2ntPCyz/wMX9uJ0lXyvw
 fi8b5dheVn78A9k1fr6A2+zFhX9vbtrAEyJrtwBDfHRK5zBcE0vPZOPp+2tcrR1wcji0ds
 2597CAX857GWQHrwlEV97A2Fu5sKgCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-3SY9Nz7yOS6_PSWQWCK__w-1; Tue, 01 Sept 2026 04:17:43 -0400
X-MC-Unique: 3SY9Nz7yOS6_PSWQWCK__w-1
X-Mimecast-MFC-AGG-ID: 3SY9Nz7yOS6_PSWQWCK__w_1788250662
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b4fe10d092so2864417e87.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 01:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788250662; x=1788855462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VcSmT8viBHBKRErX7hlq7HzklCsrxw5oi/tyYmpXz4Q=;
 b=O2AcYUuHlzcdztiKYaMo9QLgkBLUwxoiErsrmApZael5DyMN/bXW1Boj9J2Or8dHkd
 F+YGMDQVXtGV+xG63layCQUdPgDWEGiXFBZryd/mF6rr+zMFu1AMFBtVIOdGPFB+Edth
 BGiLnKVOtyBBSLFNSynyxhCDpGDO5CjTyDLt2UPPnobt0V2La0B4h31BYqVIwYTT1mh8
 hjaUVbIbYZ9cTkUTKtDsw+7dS2dwdKlx3RT44pmaIb56qoOTGAfzzBt708nrhwQ8mU9J
 oVmVwHVb1ue1ASkzx4k/Z7rupMeCXM0cvPL4soN4RUPr3/F/6D+6OAP35VLn/T6Ru17g
 uzEA==
X-Gm-Message-State: AFuF++mR4/sMlXWgAhA/MytxFdQT2KtLGA6ACpTMAvlTXJrMpWP/lkCz
 QEtBlPSxF+fxxGWmM3EeMGDz9492vCMJd397XWVrHpZes8HZg84hq8ShNEZDsUpUgVb/h3ylhna
 N4Vqdb2L26I7QSpcqE8zMAPHyT9hDHDrD0+rf7lmJgQf2cOw7t2ocUznae5ep5a8yfCdmQrmZiv
 UsFGmcJ9LKENfz3JnDk+k=
X-Gm-Gg: AYBFou2gsYlo71lrpelpcq9re6aFLoqPu9smCAp1Fj9gApwPiLahabkhtAl66H9vF/5
 J/b/1/T+Xm8jyWHsZjzbzPMJmOQTjJIVV3m76L8UqjRMMeilk+X4LR2BWXHfDUUHzmT+27JH3Rg
 /MmbsUYRU9mXCUfiYoJ6llZLaRJk5VQvtLf/2B/wgET09AEDKYaVyfunspTJylALdpejWCzqtQ7
 as+xwKXPJNVRaeU1SKyzwY+2yIAjd1tyS2FLFwmmwt26+QL
X-Received: by 2002:a05:6512:12cb:b0:5b5:e8d5:7fe2 with SMTP id
 2adb3069b0e04-5b5fe091415mr1819506e87.5.1788250662255; 
 Tue, 01 Sep 2026 01:17:42 -0700 (PDT)
X-Received: by 2002:a05:6512:12cb:b0:5b5:e8d5:7fe2 with SMTP id
 2adb3069b0e04-5b5fe091415mr1819491e87.5.1788250661754; Tue, 01 Sep 2026
 01:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260831074159.1506521-1-david.marchand@redhat.com>
 <20260901070024.1606766-1-david.marchand@redhat.com>
 <apaGCjzrVq4XyiJp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <apaGCjzrVq4XyiJp@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Sep 2026 10:17:29 +0200
X-Gm-Features: AcwNN1X2xEYBSVP7Ha_YBMe8lyI-g-i3k3IwvEslu4MSM-CO6IeudLHX9PVLpBo
Message-ID: <CAJFAV8zpd_98-Qi+M0pYUfXHG44GRmJzRFR+4i0N7L8z5W1TFg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: remove dependency on PCI library
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Sunil Pai G <sunil.pai.g@intel.com>, 
 Jiayu Hu <hujiayu.hu@foxmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3bVUWV59EfNIkC3luq9t5-EzBP8zQWBSS26Mr_KyaPM_1788250662
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

On Tue, 1 Sept 2026 at 10:00, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Sep 01, 2026 at 09:00:24AM +0200, David Marchand wrote:
> > Since the async datapath code switched to dmadev, there is no reason to
> > depend on the pci library.
> >
> > Fixes: 53d3f4778c1d ("vhost: integrate dmadev in asynchronous data-path")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since v1:
> > - fixed "internal" dependencies of examples,
> >
> > ---
> >  examples/vdpa/meson.build  | 1 +
> >  examples/vhost/meson.build | 1 +
> >  lib/vhost/meson.build      | 2 +-
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >
> No objection to this patch, but rather than changing this now, would we not
> be better just waiting to see what happens with the sync datapath itself?

*a*sync I guess.

> If it gets removed from vhost lib, then a larger cleanup is likely which
> should encompass these changes and more.

On second thought, I agree, it is not worth having as a simple
(backportable) fix, it is only an internal dependency.

I don't mind merging it in the series
https://patchwork.dpdk.org/project/dpdk/list/?series=39064&state=*


-- 
David Marchand

