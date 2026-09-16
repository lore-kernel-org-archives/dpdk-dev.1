Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669BC982C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E54427AE;
	Wed, 16 Sep 2026 09:45:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 431E440265
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789544704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ot/9lTCtbXZzCn9Pg7Q1nDHe5nm7oRyrfnV9cE3tXjI=;
 b=TxietdxNmtKclj2SnhYGVurkyV+NchE1lMOt4mA6+RLHGgUwTJM66OaOQjiToBe55NNg11
 qvG3AwYNR5jm4XISdhZahGJArWoDrIuHqoIAq+VXk2ZOwQ9XTJAGORx8acemtIcdOJGpkL
 T9PYTnWds7mHEVwSMmJbfhxH67JIbOY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-qs3Yft9mMb6PLEze71g6Ww-1; Wed, 16 Sep 2026 03:45:03 -0400
X-MC-Unique: qs3Yft9mMb6PLEze71g6Ww-1
X-Mimecast-MFC-AGG-ID: qs3Yft9mMb6PLEze71g6Ww_1789544702
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a49dcb2b24so12410631fa.1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789544702; x=1790149502;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ot/9lTCtbXZzCn9Pg7Q1nDHe5nm7oRyrfnV9cE3tXjI=;
 b=IQFM9TedFMTXePAWuVlUtZC7d/sYn4xq7e2bE00rxxuZv06/SwgOTNkWLHOEFmFIKV
 CjxaD7yueYg6RkMC4urSRMRVonTIYfnH8UE7TgB6462khM7bIdi/abB5dayq4YmJ/nx8
 UdsB9gSKcwseHZO96E4MlyEkm9m0v7g/sqRq4QBSGE5szOApvYGkkiAstYsePtJKdYHf
 OrHKdAoEOikAxji9rvCI6Ch3gfkrJk9xxcSgbasn5cnIuYSLjakjAGJlxWrE95fphjtf
 2y5Km1X7hbLNY/ghIZ3GDCSkLB6yGfHH78HehC5tAA0/yBS+AP2HLBi7mbRK/tF1ui9r
 mY9A==
X-Gm-Message-State: AFuF++lGkfFj0t7zZbZPD2UXjZ39KTMv74DnLdrKXsadcgqiOpxLydjA
 0yOOGZRutLowsBeSiudiAyxuuKaLn5PQfeyuRch3ZQ0NbQBjr1EiTAnlYc0YdKjeUAm/8dsSbnz
 k85yqETcHJHvzlH39HT/3HbHbJMKSQbGT9ODUupAixcTxyIaHmI/mb981eMWSGULKFePrfA/6Vx
 WYumbNshL4a+9lq8hlfuU=
X-Gm-Gg: AYBFou0svQbbkrXvJH/yjxWZoiEmwNhVQFCoE72YqeqIh8CGuViZ+SN0hQ0rdKzMN6N
 2kNa2hjdWmJRhDVE2sD7uUAwL4hCsWGkVgPF5bBiVOjfj+jfwEexm4T+xb3DX3rN6qzjR7TLYr9
 b53vcEeTHnMzGswcTk0kT3jE7cI7GGqhNeEPHSUJH4fxawC4UxpVgx6sJc5Q/UF16tGBPa2uCL9
 52lPVQ5Ck2NsR+SZ1pqsJzvhuNbx8zwP9MnW5VlDJbze/Dm
X-Received: by 2002:a05:651c:2121:b0:3a3:62de:96aa with SMTP id
 38308e7fff4ca-3a5d18807cemr10440631fa.4.1789544701861; 
 Wed, 16 Sep 2026 00:45:01 -0700 (PDT)
X-Received: by 2002:a05:651c:2121:b0:3a3:62de:96aa with SMTP id
 38308e7fff4ca-3a5d18807cemr10440591fa.4.1789544701343; Wed, 16 Sep 2026
 00:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <f9eb863a0ce981615476a97f9ac14d1e3db4aea0.1789044748.git.anatoly.burakov@intel.com>
In-Reply-To: <f9eb863a0ce981615476a97f9ac14d1e3db4aea0.1789044748.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 09:44:49 +0200
X-Gm-Features: AcwNN1VGrTs_A1zQbT6M4x-vUectscE-Iuh0NURKbhxT73oRrnD20QYh6U-eiao
Message-ID: <CAJFAV8xB1Wg8jZM+znxaeW6dWr64LQfVqW0gkARTJNnB9djgcg@mail.gmail.com>
Subject: Re: [PATCH v17 22/26] bus/fslmc: use the new VFIO IOMMU mode API
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xjg7E8RbGP4j2WF-x_bqEc6B2OfIc7emuX71XyG18VA_1789544702
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

On Thu, 10 Sept 2026 at 14:56, Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
> @@ -500,7 +507,8 @@ rte_dpaa2_get_iommu_class(void)
>                 return RTE_IOVA_DC;
>
>         /* check if all devices on the bus support Virtual addressing or =
not */
> -       if (fslmc_all_device_support_iova() !=3D 0 && dev_vfio_noiommu_is=
_enabled() =3D=3D 0)
> +       if (fslmc_all_device_support_iova() !=3D 0 &&
> +                       dev_vfio_get_iommu_mode() =3D=3D DEV_VFIO_IOMMU_M=
ODE_UNSAFE)
>                 return RTE_IOVA_VA;
>
>         return RTE_IOVA_PA;

IA flagged this part:

In `fslmc_bus.c`, the condition changed from:
```c
/* Old */
if (fslmc_all_device_support_iova() !=3D 0 && dev_vfio_noiommu_is_enabled()=
 =3D=3D 0)
    return RTE_IOVA_VA;

/* New */
if (fslmc_all_device_support_iova() !=3D 0 &&
        dev_vfio_get_iommu_mode() =3D=3D DEV_VFIO_IOMMU_MODE_UNSAFE)
    return RTE_IOVA_VA;
```

The old code returned `RTE_IOVA_VA` when NOIOMMU was **disabled** (=3D=3D
0), but the new code returns `RTE_IOVA_VA` when IOMMU mode is
**UNSAFE** (i.e., NOIOMMU is enabled).

Looking at `dev_vfio_noiommu_is_enabled()`:
```c
int
dev_vfio_noiommu_is_enabled(void)
{
    return vfio_global_cfg.iommu_mode =3D=3D DEV_VFIO_IOMMU_MODE_UNSAFE;
}
```

So:
- Old: `dev_vfio_noiommu_is_enabled() =3D=3D 0` =E2=86=92 NOIOMMU is NOT en=
abled =E2=86=92
IOMMU is SAFE
- New: `dev_vfio_get_iommu_mode() =3D=3D DEV_VFIO_IOMMU_MODE_UNSAFE` =E2=86=
=92
NOIOMMU IS enabled

**This is an inverted condition.** The old code returned `RTE_IOVA_VA`
when IOMMU was safe (NOIOMMU disabled), but the new code returns
`RTE_IOVA_VA` when IOMMU is unsafe (NOIOMMU enabled). This appears to
be a correctness bug that will change the IOVA mode selection
behavior.

**Suggested fix:** The new condition should likely be:
```c
if (fslmc_all_device_support_iova() !=3D 0 &&
        dev_vfio_get_iommu_mode() !=3D DEV_VFIO_IOMMU_MODE_UNSAFE)
    return RTE_IOVA_VA;
```

Or if the intent was to check for safe mode:
```c
if (fslmc_all_device_support_iova() !=3D 0 &&
        dev_vfio_get_iommu_mode() =3D=3D DEV_VFIO_IOMMU_MODE_SAFE)
    return RTE_IOVA_VA;
```

--=20
David Marchand

