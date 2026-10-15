Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5CCC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB0B7402DF;
	Thu, 15 Oct 2026 19:54:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3319D4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792086889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OnSeBGWzS4EpMV/U2mcZUskMRgVqJX9i6s619ZU1t10=;
 b=h1tFNBtYPPvZj2cC4c/fYfu34ZnHRVR6TCjPI5FAZ4CmfpV4+dfFGolBRPgS+H+GuM8HWy
 arm1afnywylT6H5o+A6HsRQTOnVD9P4vggv9aSM4WNSSzqAdAEJzA7iL3Tf1iL9ysQKft+
 5ppi3FBoJZyWgfMcF+ZLy6muPE2dGlo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-SmRrszkuOu6FEkNZwLDkpA-1; Thu, 15 Oct 2026 17:54:48 +0000
X-MC-Unique: SmRrszkuOu6FEkNZwLDkpA-1
X-Mimecast-MFC-AGG-ID: SmRrszkuOu6FEkNZwLDkpA_1792086886
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a77cbb4202so12732661fa.2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086886; x=1792691686;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OnSeBGWzS4EpMV/U2mcZUskMRgVqJX9i6s619ZU1t10=;
 b=pPT8m/kMvqvuwgiQ3gTNyyNN47J47ptuLbwpBqELt/pGMJR0IXqJjL+MXFTXvg99lE
 aw/O5jPW+gcjscx45TkXAK6Dz4MQ/9SA4tcNX1rQWKtpOsLmaTOJ6CY6snWnjD6+szUx
 d3VOdSWlZ3ra1SyDCTDwRJOw2qzNf2G2zwbEsih2sXAo7R01I4UL2Qw1A2XXKDwBTxdJ
 BBSyRlP7usNj7FzcXPdWpUw/hMnI9fVXSXhP9bKjxbZtiHXigW7oeno20A2B4pWd2A/Y
 bOwo2vYMYu31yz4j80DXODVoBIFebTxHxsJnie0mdhGGqpgsf2+YrEx00Jh5l1nf0gr4
 QQbA==
X-Gm-Message-State: AFq9FYI0gsf/pk/uRE/KTtHg9IUqfglZKSHALd8U3sNM7bBsQuANlS9s
 pnxrNlcUOgLCcEwKEW8bUeU+EM8jci2lFAz42JEe4lJPFjKKETgrxv+gGF24jld7v/QJNWzeI0l
 OnoDQztnv1s+W3FaR1+FSlwhb7EhZntlI4yQvE559/2B8b8RUuR/Jv1NiQxc8L9rB9Oi14fe4Ml
 x1SCH9o55dLjD0/BO7ln4=
X-Gm-Gg: AYBFou2kgc2sVzF9R0vQtuNUnOu1RlGEa2yoMxln8SHuEE/2hakz1EZSTcCVEXFXeZz
 fRVxYNDzm1ZxQlEPb54rLSS0VTjL8e8KB4f44QFs4K30+fMINBhkL2OK6cr+1qukZblDziKmrtg
 XGMcdhEd+Rhwq7nY7qnm9tRTB0d3y6fSfzhJL0Z1daoVck+nYN977vQXsfCFCyReBn6q26Tk/f9
 xo6dTthsyNtDJcMeEeYh11o32yZrRmC5F3bxz09Mn8OTSY7
X-Received: by 2002:a05:651c:211e:b0:3a1:30c4:d95 with SMTP id
 38308e7fff4ca-3a9c515d781mr50539731fa.5.1792086886398; 
 Thu, 15 Oct 2026 10:54:46 -0700 (PDT)
X-Received: by 2002:a05:651c:211e:b0:3a1:30c4:d95 with SMTP id
 38308e7fff4ca-3a9c515d781mr50539651fa.5.1792086885941; Thu, 15 Oct 2026
 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <ee502d37f54dbb6ea8ae4473e684eeb0f500db1d.1792079025.git.anatoly.burakov@intel.com>
 <CAJFAV8wubWQvcN7wArMbVZ5yxu8iLEMiUUQwWzGmCqyAVDk6Mg@mail.gmail.com>
In-Reply-To: <CAJFAV8wubWQvcN7wArMbVZ5yxu8iLEMiUUQwWzGmCqyAVDk6Mg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 19:54:32 +0200
X-Gm-Features: AclHuK88JEw-xLAjCzucIUClhB368WCDQWk6Jl263dUX9h7MMhgU9XW5qdDnskY
Message-ID: <CAJFAV8xaCdniuSE-whogA66Fxpxc9hipD_4===u=X5p9iWG23w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] vfio: fix device lookup with no-IOMMU mode enabled
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, abailey@iol.unh.edu,
 dladd@iol.unh.edu
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vKg526ohXY5MCN4J132EsbHXEOC8BbY-7cAA3GGdCn4_1792086886
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

On Thu, 15 Oct 2026 at 18:15, David Marchand <david.marchand@redhat.com> wrote:
>
> On Thu, 15 Oct 2026 at 17:44, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> >
> > Currently, when the `enable_unsafe_noiommu_mode` VFIO module parameter is
> > set, VFIO selects PA IOVA mode and then only looks for no-IOMMU device
> > nodes: `/dev/vfio/noiommu-N` in group mode, and `noiommu-vfioN` in cdev
> > mode.
> >
> > However, the parameter does not make every VFIO device a no-IOMMU
> > device. The kernel only creates a no-IOMMU group for a device that has no
> > IOMMU group of its own; devices behind a real IOMMU still get a regular
> > `/dev/vfio/N` group and `vfioN` cdev. On such systems, devices bound
> > to `vfio-pci` are therefore reported as not managed by VFIO and fail
> > to probe.
> >
> > Fix it by trying the regular node name first and falling back to the
> > no-IOMMU one, in both group and cdev modes.
> >
> > Fixes: 6cb38a7f56e0 ("vfio: introduce VFIO mode")
> > Fixes: d129414711aa ("vfio: introduce cdev mode")
> >
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

