Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E0CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 13:06:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAD25402E4;
	Thu, 21 May 2026 15:06:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CE7A3402B0
 for <dev@dpdk.org>; Thu, 21 May 2026 15:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779368782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7HwaM7bMZpgWwPHpFmGJ7cNEwteQHQCgCniswu3D34=;
 b=D4O6NPXRyYL9dfeGsvrxkEntXy7SQOyZHUOtDZqAP515g9lIMpdP6WEuiGVCfDtXf3UvKD
 S2JqQPm1L4sG1e/CfMLPdbrAGEUuR1ebIicFCB0FQBycJaLlb5/+Hbdm/BNsfQXrednpnr
 q7aCVYYx1d/N14rJ5xuSO8W7s0pmyAQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-80A2m-KaN3GTjy8pb3KiIA-1; Thu, 21 May 2026 09:06:19 -0400
X-MC-Unique: 80A2m-KaN3GTjy8pb3KiIA-1
X-Mimecast-MFC-AGG-ID: 80A2m-KaN3GTjy8pb3KiIA_1779368778
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38e936cabf2so53572191fa.1
 for <dev@dpdk.org>; Thu, 21 May 2026 06:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779368778; x=1779973578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7HwaM7bMZpgWwPHpFmGJ7cNEwteQHQCgCniswu3D34=;
 b=gWzyL6xkWDL875g30VvqcgqcKnf17lV2+dbcN3o/xZT1WcZHzex2ZfPEsQ0ZkSjW1b
 dEZvFoxu9aCVs93MFOivwyfPrJPy/YgpSmeqeX3wtKkF4Zk2W0HzDtK2mkaapWSTfZ8f
 etjkuLQtHcuq/2J5Zyon5y4zEvLh/GCu9ilqRFPx20RYXUGHBL64dIb9oUdtsnX1UoAq
 7G/2AyHHBdc4gb5NHLilIZivJTVShA8CfT0maqe6vjWY2vqAquuCLa2Na7+XZZ6Ye6Ww
 NLvUs39jI4iYC7W8X6M9cP0jSDgHyfg3I09mBLZHztrMxbFvPDkvOmYJwDlICJOztBmF
 eifQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z3s3drkQS5Qq+T+F5TE1QeJdZZQKA+RVqyfAh6JKoXK2mgL7q3M1O/4huLbMCMghL8HI=@dpdk.org
X-Gm-Message-State: AOJu0YxTbQ6NBXRoWxBVUXMtkN8CRO//nwIlytE2ZNmV7f1VU5pDJbRo
 Q2WrpO56d7TpxGrqj39HuWWG4J9e1GHLUt+OnnIR3BrQUqDr9EU27FlR3ckfUbNloSsozgqBPSZ
 9sKuOQ9eFqe0JdEA9JTmFIWM7SH03HML0TbVc8oBIF9i6n6Q6Boq8TEj91LltmnjzsVM79YafK5
 heKvrtIyTuvqRahja4Emk=
X-Gm-Gg: Acq92OHz0yPgyEsFeX5NEH2AT876ipA4ee7AgPm59jWGudJWbv9HYdCiJEyBH/OFXYJ
 aASaZmoPjTLwlefn/lWiuM1ns+VY1gDRO1vl4kCernP3tvcre5ostUcjLlDwLHQ9dxeGkNtELIl
 fbWBdF1Hd176Fl4PuGbO0K0TW0eAGnfjk9ekEhwLPtpOKQQNbgqxQ5J4YQ75utZDYj0iNyjsVy9
 AS49C3Eso19LTj6GFM2LCnlzmo5+P6jEb6g2awzuKB2vxkU3HU3vX6NDJOEy+c0FChLWA==
X-Received: by 2002:a05:6512:33cc:b0:5a8:6f3d:6cfc with SMTP id
 2adb3069b0e04-5aa2ba9cd94mr1391707e87.41.1779368777823; 
 Thu, 21 May 2026 06:06:17 -0700 (PDT)
X-Received: by 2002:a05:6512:33cc:b0:5a8:6f3d:6cfc with SMTP id
 2adb3069b0e04-5aa2ba9cd94mr1391684e87.41.1779368777201; Thu, 21 May 2026
 06:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260302110206.49670-1-fengchengwen@huawei.com>
 <20260302110206.49670-2-fengchengwen@huawei.com>
In-Reply-To: <20260302110206.49670-2-fengchengwen@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 21 May 2026 15:06:05 +0200
X-Gm-Features: AVHnY4L-7ku8RhBahP4-CNXTnui3quucs2Hnl_L0sEGrgl92bwrCca-JroKSGBc
Message-ID: <CAJFAV8wbj3oKRoF-0+jr1ceWMgVDZT-a9Rd5Ptdx9=N+1_WA7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus/uacce: support driver forward compatibility
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, dev@dpdk.org, qianweili@huawei.com, 
 liuyonglong@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJ_vEdEJovRYLvXA1JWEHQWx_su23It5XtC5YcQ8BXE_1779368778
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

On Mon, 2 Mar 2026 at 12:02, Chengwen Feng <fengchengwen@huawei.com> wrote:
>
> As we know, the uacce driver (e.g. hisi_acc DMA driver) reads the API of
> the hardware device (through /sysfs/class/uacce/xxx/api) and compares it
> with the API supported by the driver to match the corresponding hardware
> device.
>
> Hardware devices will continue to evolve, which means their APIs will
> change, but business requirements demand that they support old
> programming interfaces as much as possible.
>
> To adapt to this situation, this commit supports forward compatibility
> of driver APIs. For example, if the driver supports the hisi_qm_v5 API,
> it can drive the hardware device that supports the hisi_qm_v6 or
> hisi_qm_v7 API.
>
> In addition, a driver flag (RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV) is
> introduced. The driver supports forward compatibility of APIs only when
> this flag is defined.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/bus/uacce/bus_uacce_driver.h |  5 +++
>  drivers/bus/uacce/uacce.c            | 51 ++++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
> index 618e0f9b76..c7445778a6 100644
> --- a/drivers/bus/uacce/bus_uacce_driver.h
> +++ b/drivers/bus/uacce/bus_uacce_driver.h
> @@ -50,6 +50,7 @@ struct rte_uacce_device {
>         char dev_root[RTE_UACCE_DEV_PATH_SIZE];  /**< Sysfs path with device name. */
>         char cdev_path[RTE_UACCE_DEV_PATH_SIZE]; /**< Device path in devfs. */
>         char api[RTE_UACCE_API_NAME_SIZE];       /**< Device context type. */
> +       uint32_t api_ver;                        /**< Device api version used for compatibility. */

I have some problem with this field.
See below.


>         char algs[RTE_UACCE_ALGS_NAME_SIZE];     /**< Device supported algorithms. */
>         uint32_t flags;                          /**< Device flags. */
>         int numa_node;                           /**< NUMA node connection, -1 if unknown. */
> @@ -100,8 +101,12 @@ struct rte_uacce_driver {
>         rte_uacce_probe_t *probe;               /**< Device probe function. */
>         rte_uacce_remove_t *remove;             /**< Device remove function. */
>         const struct rte_uacce_id *id_table;    /**< ID table, NULL terminated. */
> +       uint32_t drv_flags;                     /**< Flags RTE_UACCE_DRV_*. */
>  };
>
> +/** Device driver supports forward compatibility device */
> +#define RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV        0x1
> +
>  /**
>   * Get available queue number.
>   *
> diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
> index 79f990c54c..a471edcad0 100644
> --- a/drivers/bus/uacce/uacce.c
> +++ b/drivers/bus/uacce/uacce.c
> @@ -2,6 +2,7 @@
>   * Copyright(c) 2024 HiSilicon Limited
>   */
>
> +#include <ctype.h>
>  #include <dirent.h>
>  #include <errno.h>
>  #include <fcntl.h>
> @@ -324,19 +325,62 @@ uacce_scan(void)
>         return -1;
>  }
>
> +static uint32_t
> +uacce_calc_api_ver(const char *api, int *offset)
> +{
> +       int len = strlen(api);
> +       int end = len - 1;
> +       unsigned long ver;
> +
> +       while (end >= 0 && isdigit(api[end]))
> +               end--;
> +
> +       if (end <= 0 || end == len - 1 || api[end] != 'v')
> +               return 0;
> +
> +       ver = strtoul(api + end + 1, NULL, 10);
> +       if (ver > UINT32_MAX)
> +               return 0;
> +
> +       if (offset != NULL)
> +               *offset = end + 1;
> +       return (uint32_t)ver;
> +}
> +
> +static bool
> +uacce_match_api(const struct rte_uacce_device *dev, bool forward_compat,
> +               const struct rte_uacce_id *id_table)
> +{
> +       int dev_ver_off = 0, id_ver_off = 0;
> +       uint32_t dev_ver, id_ver;
> +
> +       if (!forward_compat)
> +               return strcmp(id_table->dev_api, dev->api) == 0;
> +
> +       dev_ver = uacce_calc_api_ver(dev->api, &dev_ver_off);
> +       id_ver = uacce_calc_api_ver(id_table->dev_api, &id_ver_off);
> +       return dev_ver > 0 && id_ver > 0 && dev_ver_off == id_ver_off &&
> +               strncmp(id_table->dev_api, dev->api, dev_ver_off) == 0 &&
> +               dev_ver >= id_ver;
> +}
> +
>  static bool
> -uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *dev)
> +uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)

A matching helper should only match, and not modify the object.

>  {
> +       bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
> +       uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);

This conversion from a string to integer could be placed in the scanning step.
Why place it here?


The dev->api_ver has no in-tree user.
This field was (silently?) dropped by my best AI friend in the bus
refactoring series I posted.
https://patchwork.dpdk.org/project/dpdk/patch/20260506155201.2709810-12-david.marchand@redhat.com/

Please advise if I can drop this field (it is just the integer value
extracted from dev->api afaiu), or if it should be moved to the
scanning step.


-- 
David Marchand

