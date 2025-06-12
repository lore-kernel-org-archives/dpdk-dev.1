Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7224FC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 13:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7984B40ED4;
	Thu, 12 Jun 2025 15:23:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1051E402C1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 15:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749734612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5NlVkOpdwHf7/1/sIGyrjB6Hub7TRs0XINAJYTnbJQ=;
 b=GTavV8f+fUCRqPyhb09S2bjOThKBp80NqSiRip4sM8QLWxNRfDQ+WQsCLJb08Tn/vTZ4ZW
 uW4TJVIQI0SPrGMY+yDTP20sgVUXNNp1rtDha497VApfq4Ke9/Mu6ZeV2vPA+rdKgS/zIW
 eQDUIcc3+BR21f/NCypE91KgOfPj9Dw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-MjmUc3orN8aE_tdGBd4CUQ-1; Thu, 12 Jun 2025 09:23:24 -0400
X-MC-Unique: MjmUc3orN8aE_tdGBd4CUQ-1
X-Mimecast-MFC-AGG-ID: MjmUc3orN8aE_tdGBd4CUQ_1749734603
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32b3900fb49so1191271fa.3
 for <dev@dpdk.org>; Thu, 12 Jun 2025 06:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749734603; x=1750339403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5NlVkOpdwHf7/1/sIGyrjB6Hub7TRs0XINAJYTnbJQ=;
 b=a8IQEj6CnGNTShjWIIKM1v6NVKNVzbm3VOsBSBi6B9kwJ2FC2D3A/kraYUAwbEqRp0
 KCgyqLm59Y2mBiaTPymxPQx1QzdMuuoc9vdCGLTTshhNah8UGTyqGbEEKRNj4+ejJ1mG
 gnDVcJpcqOb+Wbt25hs7AKZKRjN7kVbOG5QXIc9V6po9GL1aESOidvHroKIYDBuGIpHs
 syL6zsti9gHFccdPy/5Da/N2eSkGA5j6x0BKPcEIDX6Ii06PvLN2dRz0doizL/3hLBRD
 ymM1f7jVlQ8Jm+MZKArs3X1DpUWUgl1qpTHaLUMzacz7NCi2O1sZkgvgwDWKs3foDjhI
 fxkA==
X-Gm-Message-State: AOJu0YxF+9qC76F6VBgS4dTTVOUqd35tAv85PRkiO8G5CXTtERSTDQae
 zcufQe4wP6UkU7bxpMMutVRQOyyipUA2rhEMrxLcAl7RjZ4StJVP4gRVxo6KVaLGzoUXpwA1BUg
 l64MrJY1nIAhRIvkmKzpUPb+zVQmV+sgZsd9Ch/OGIWs6mz7YaLzRnLnazbozYy6vXYutLOfMtr
 JPkHfajmdeX2ge6s+kSMyN7dkN1Sg=
X-Gm-Gg: ASbGnctXF/7nPURRpSs+rKMhSyhTnSdrIhZ/Xq+RRAihuPtctRD509JDCTFkRRTHEKF
 eDWarWmRISpwENU29XjwCo4oRQLm1yba7SOtU221ZPDIQE5z6wi4JjyOLrikLHqFpRKLm6N8Dua
 yy23DfSQ==
X-Received: by 2002:a05:6512:3b0c:b0:553:2fb1:cfe5 with SMTP id
 2adb3069b0e04-553a643f1e6mr1042492e87.12.1749734602670; 
 Thu, 12 Jun 2025 06:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHYPvnUIlr/0GsV1ayNx8XHZnrSvUjYZIzMPsMNJv1zKvmD16DUZN1j/dYVRNgqlY87dHLU+aXD+rmUrBftE=
X-Received: by 2002:a05:6512:3b0c:b0:553:2fb1:cfe5 with SMTP id
 2adb3069b0e04-553a643f1e6mr1042485e87.12.1749734602226; Thu, 12 Jun 2025
 06:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
In-Reply-To: <20250611094532.1242167-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Jun 2025 15:23:10 +0200
X-Gm-Features: AX0GCFs63bvSkMwm0Sv-WqDQKxR4FmFJMWVwW0OIJ0m3Ttcw7H5UXDusuTtioy4
Message-ID: <CAJFAV8z-uvXe2+z6+VfjdEdRmqGOF3uz7R3hx2Ow-Muuau65FQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] allow pmdinfo to be inserted and parsed using MSVC
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K-nkGzAWxilj8E7JkyWEHHdeUu8QThk1M7JzK3Fq58c_1749734603
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

On Wed, Jun 11, 2025 at 11:45=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> This is a rework of Andre v5, trying to hide the ugly details in a
> driver only macro not exposed publicly.
>
>
> --
> David Marchand
>
> Changes since v6:
> - changed this_pmd_name symbols construction,
>
> Changes since v5:
> - moved details in dev_driver.h,
> - renamed RTE_INCLUDE as RTE_PMD_EXPORT_SYMBOL,
>
> Andre Muezerie (3):
>   dev: export driver information with MSVC
>   buildtools: embed driver information with MSVC
>   usertools: enable pmdinfo with MSVC
>
> David Marchand (2):
>   dev: hide driver export macros
>   dev: rename pmdinfo internal symbols
>
>  buildtools/gen-pmdinfo-cfile.py              | 25 +++++++--
>  buildtools/meson.build                       |  2 +
>  buildtools/pmdinfogen.py                     | 13 ++---
>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 +-
>  drivers/bus/cdx/bus_cdx_driver.h             |  5 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h           |  2 +-
>  drivers/bus/fslmc/bus_fslmc_driver.h         |  4 +-
>  drivers/bus/ifpga/bus_ifpga_driver.h         |  2 +-
>  drivers/bus/pci/bus_pci_driver.h             |  2 +-
>  drivers/bus/platform/bus_platform_driver.h   |  2 +-
>  drivers/bus/uacce/bus_uacce_driver.h         |  2 +-
>  drivers/bus/vdev/bus_vdev_driver.h           |  2 +-
>  drivers/bus/vmbus/bus_vmbus_driver.h         |  2 +-
>  drivers/common/mlx5/mlx5_common.c            |  2 +-
>  drivers/common/mlx5/mlx5_common_pci.c        |  2 +-
>  drivers/compress/mlx5/mlx5_compress.c        |  2 +-
>  drivers/crypto/mlx5/mlx5_crypto.c            |  2 +-
>  drivers/net/mlx4/mlx4.c                      |  2 +-
>  drivers/net/mlx5/mlx5.c                      |  2 +-
>  drivers/net/virtio/virtio_pci_ethdev.c       |  2 +-
>  drivers/regex/mlx5/mlx5_regex.c              |  2 +-
>  drivers/vdpa/mlx5/mlx5_vdpa.c                |  2 +-
>  lib/eal/common/eal_common_options.c          |  2 +-
>  lib/eal/include/dev_driver.h                 | 43 ++++++++++++++++
>  lib/eal/include/rte_dev.h                    | 41 ---------------
>  usertools/dpdk-pmdinfo.py                    | 53 ++++++++++++++++----
>  26 files changed, 137 insertions(+), 85 deletions(-)

Series applied, thanks.


--=20
David Marchand

