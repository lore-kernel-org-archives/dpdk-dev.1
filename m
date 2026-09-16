Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E3C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC154410FD;
	Wed, 16 Sep 2026 11:43:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBC0C4067A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 11:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789551793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrfsbkzIuhvA0/5X+uF56YelbSqsd2IZx8RpFtamjrw=;
 b=IBDc54hxjB1azTbJipm6VFWWkgmT+DY4b3m6qQY0vQsNcNWqCv6OSlggsyjXNsmVcYd80D
 bYYw/+oWTl9UzZmx8SIjJ7R61AJfgqJy0ZXT0K+v2mCmw4y/N0PQSwfYuucyuKiNIwFwq8
 jxFRWoCaYqKAnnb7OqwgrLf7Kpv9oLM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611--B9hcNwNPo2PDi2xdyr38w-1; Wed, 16 Sep 2026 05:43:11 -0400
X-MC-Unique: -B9hcNwNPo2PDi2xdyr38w-1
X-Mimecast-MFC-AGG-ID: -B9hcNwNPo2PDi2xdyr38w_1789551790
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a202ac1011so27225861fa.1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 02:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789551790; x=1790156590;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zrfsbkzIuhvA0/5X+uF56YelbSqsd2IZx8RpFtamjrw=;
 b=Zx5ZXQ+rigsnZ2VPQGJDszlJDG/PhbuszgFO+FVORgyGWjR1QWIFLBjVBJpBOPTSt1
 /VHAQ/j3b/hkLJC7uq7zq3IxvlZ3IV3GwSjaqkU8VBNq0xaAryFH89NNCTU5YY61ab8y
 VZ8o0t0bWFx82j3NWK4VxwgQxyu/O0H8gjXjU3izZyiFMN0NLFbVE7D/02F2sscTbOxe
 03foxxnxbZRtHp2+c7sluwuZJNLrgre7UQQp//OMt6szAx+24ZNP2QchkxlpAt9RncvA
 W0BBZ98dwh9pxH13CMViMtGNkCfGQd+Cyx5OhKTrT6kTgFRYfG52GQmrw+I4My5rmkNt
 59rA==
X-Gm-Message-State: AFuF++k4exinmq0RvdPDNf287RV6xhPftgrhDbwNpt559Yx8Xvs/tK8A
 KmWE3vb9pI9+LaN6hR1kMYjHu5t7EPqn71PJi4UlVGS3nKy5PkaGfrAB2IAjvH21dzvUCDdGBtB
 AMXdferZ6K3GbPJQ2H0ePxpgY+sFtr7mB72h4k+zaXyTXYeS+M6+UN2Xbtt/uPpMxUp6MTRBsLj
 XSzg0fdzbDbyhczIGbXPk=
X-Gm-Gg: AYBFou3WnmizO7ZoC95VFMRrKHndDfzI9volTifTqQDGrb2eZvvsZfi+VIJNzMls7QS
 o2eu2Vveh+unWSHX8AI7yYwIBSlBfHWYkaelKmmxS8Vm01BeeMDPpaqdJuBk3OVE4reoLui709Y
 cWWvOzw5wjvenQsrOpxOFMmxAQ8q+gRZa3fonu3oMe33PrQg7bOveahoqhZPBjvHyYK+DXhyCia
 YDPcpX+RSD6lPnxnkNJtGZ55ex9HJ1Hatfs2FBhTzsKplVn
X-Received: by 2002:a2e:a98c:0:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5dca18962mr3353391fa.22.1789551789936; 
 Wed, 16 Sep 2026 02:43:09 -0700 (PDT)
X-Received: by 2002:a2e:a98c:0:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5dca18962mr3353331fa.22.1789551789423; Wed, 16 Sep 2026
 02:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cdedc9f8885ef46eb5a903c907c3b2bfeef0704b.1789044747.git.anatoly.burakov@intel.com>
In-Reply-To: <cdedc9f8885ef46eb5a903c907c3b2bfeef0704b.1789044747.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 11:42:57 +0200
X-Gm-Features: AcwNN1WEYH6we5Pu8sfNRwf8umqzR5AaDYyrQvVlJQAmSO3-TrpoESZLPll_aFA
Message-ID: <CAJFAV8w8GbvBRQ+O5LkL=jJ0f57Y4XaKJbqXJjxpgk94Ane6Wg@mail.gmail.com>
Subject: Re: [PATCH v17 20/26] vfio: cleanup and refactor
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, 
 Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 80fQkvH_rZxLO-IEnxjebUP5lLwBo2cMuEqY-cug1zo_1789551790
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

On Thu, 10 Sept 2026 at 14:55, Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
> diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
> index f2dbf46481..c62d38e524 100644
> --- a/lib/eal/include/dev_vfio.h
> +++ b/lib/eal/include/dev_vfio.h
> @@ -18,6 +18,7 @@
>  #include <stdint.h>
>
>  #include <rte_compat.h>
> +#include <rte_common.h>
>
>  #ifdef __cplusplus
>  extern "C" {
> @@ -29,8 +30,6 @@ extern "C" {
>  #define DEV_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
>  #define DEV_VFIO_GROUP_FMT "/dev/vfio/%u"
>  #define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
> -#define DEV_VFIO_NOIOMMU_MODE      \
> -       "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
>
>  #endif /* RTE_EXEC_ENV_LINUX */
>
> @@ -39,28 +38,64 @@ struct vfio_device_info;
>
>  #define DEV_VFIO_DEFAULT_CONTAINER_FD (-1)
>
> +/**
> + * @enum dev_vfio_mode
> + * Enumeration of VFIO operational modes.
> + *
> + * These modes define how VFIO devices are accessed.
> + *
> + * - DEV_VFIO_MODE_NONE: VFIO is not enabled.
> + * - DEV_VFIO_MODE_GROUP: Legacy group mode.
> + */
> +enum dev_vfio_mode {
> +       DEV_VFIO_MODE_NONE = 0, /**< VFIO not enabled */
> +       DEV_VFIO_MODE_GROUP,    /**< Group mode */
> +};
> +
> +/**
> + * @enum dev_vfio_iommu_mode
> + * Enumeration of VFIO IOMMU protection modes.
> + *
> + * These modes define whether devices are protected by an IOMMU.
> + *
> + * - DEV_VFIO_IOMMU_MODE_UNKNOWN: IOMMU mode has not been determined.
> + * - DEV_VFIO_IOMMU_MODE_SAFE: Devices are protected by an IOMMU.
> + * - DEV_VFIO_IOMMU_MODE_UNSAFE: Devices are not protected by an IOMMU.
> + */
> +enum dev_vfio_iommu_mode {
> +       DEV_VFIO_IOMMU_MODE_UNKNOWN = 0, /**< IOMMU mode not determined */
> +       DEV_VFIO_IOMMU_MODE_SAFE,        /**< IOMMU protection enabled */
> +       DEV_VFIO_IOMMU_MODE_UNSAFE,      /**< IOMMU protection disabled */
> +};

My two cents.

This "safety" mode is ambiguous (for example, the bus/fslmc change
looks wrong, as I reported earlier).

The main concern for drivers is the "class" (physical, virtual) of addresses.
The noiommu notion was simple in that drivers understood they had to
handle physical addresses.

There is some other concern about iommu capability that is not
captured in the new API.
Take a look at the PCI bus for example, where some decision is taken
on a DMA mask.

In the end, it may mean that the whole iommu class discovery (that
impacts IOVA mode) should get revisited too... ?

At least, with an *internal* VFIO API, we can revisit more easily in
the future, so those comments are not blocking the series.


-- 
David Marchand

