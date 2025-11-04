Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01121CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 09:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DF04028C;
	Tue,  4 Nov 2025 10:24:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C530940285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 10:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762248270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kef63HYIzlcnVRC/YkP5zIUEIAfCsG8B/NrxgVI5oT4=;
 b=SCo/kqiZ5RqGH2G9YXdEKvdoY7EpKujDWWawPd9pZ1BZTssw34XVGv1IsFTYIhsOZ6RiKY
 DV0OWSFlKXCv/HqnqKGAo2zrzg9Ou4yxAm2nhjXr6ikGOTZ8Ij7PjESD//yhtHUN8jVKnV
 4j8XZoMOFmMc6n3NuGuz/sNihHRWrV0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-AxkXfXfqMHGJHViElaleng-1; Tue, 04 Nov 2025 04:24:28 -0500
X-MC-Unique: AxkXfXfqMHGJHViElaleng-1
X-Mimecast-MFC-AGG-ID: AxkXfXfqMHGJHViElaleng_1762248267
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5942ee3c805so1643922e87.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 01:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762248267; x=1762853067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kef63HYIzlcnVRC/YkP5zIUEIAfCsG8B/NrxgVI5oT4=;
 b=dmLiAfEMbKFgroQL4ZL2ZFFo/Azy8vSBgpmv08/1aTNJyvuzQQrWUvQMm0hg7y3muH
 b+V/kLqz/cDYUxTQFohmEgrCXw+hUY3cA91B71TSO4aB0NXkOlha/MRPpVAGGBtRnGsM
 CLow881ozpj/aM9LtDhJTbfOEUrlHialAg+jcwHGjtqyiOXrXObDdc3E6agF4NopJn90
 zdlT21VKGrQWrOx7GLLI4o8SaJGZAtvwgAXiOYQHrPQbxj3kJB9xv7jHDB0OF8LF95rI
 IiT/QK7cu2HDxk1u8PCMjK9zFgOT4AzDpg3gGMd1+FK0X9LTDe8OqgEayWhV1oYG7ftL
 dgBQ==
X-Gm-Message-State: AOJu0YyO22rcTWrdLWQ/SB94EtqxEUpv3FH1l44KpyjaYh4iUtM8RKZ3
 eOiJfN+6fa/ngZMZKf1AuBZMezGmE6GxfR3djltEJmGYxFZWnNh0YDjdAdccOrwFE595JN5nFSc
 C0I3sjXGnsPCOJW1GueYZKHh0/aQmJ0RvlhWcDVHfwARjD9H1BvGmnZEUEniVgQvRUeW46xZUrx
 ontdpS2Uhq9xlZOD2ZmXk=
X-Gm-Gg: ASbGncs/xDFr69TK9BJw5suhbVbkG2bNPvHrZc57o3tlDuFw02o0WD4MAF4K9RsxYbs
 0+Bub29poQKrE2csGBTiBXCkTe0h3IL59phf7hBXJ6lqv1sG5tuhdB9yzoHpCHmEDX506RxZ4NR
 V4pMdBNB685pASbCP2W+3iuHs4JaOWypXD604QD1Ls5wXz51Vs0cz+OA==
X-Received: by 2002:a05:6512:31d0:b0:55f:6fb4:e084 with SMTP id
 2adb3069b0e04-5941d551601mr4765314e87.50.1762248266855; 
 Tue, 04 Nov 2025 01:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG20Cq98aw7znt6+JeNkQqloPq59DQVsbb2tgw5uuUPYVBemgNW4pBIzMsbVkuu5AZ8HDHE+yEScD23NZf57Xk=
X-Received: by 2002:a05:6512:31d0:b0:55f:6fb4:e084 with SMTP id
 2adb3069b0e04-5941d551601mr4765307e87.50.1762248266415; Tue, 04 Nov 2025
 01:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-40-stephen@networkplumber.org>
In-Reply-To: <20251103164915.101713-40-stephen@networkplumber.org>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 4 Nov 2025 10:24:14 +0100
X-Gm-Features: AWmQ_bk1GduFhrOAwELn1eN2eS__5CmACeLlaWiYJTPqFQNebzzbFlR1zvhJzT4
Message-ID: <CAO55csyPHbCqDqF7t=ZT_JRtHaViyoLeUT_MxZyg40m4Ag1-cA@mail.gmail.com>
Subject: Re: [PATCH v3 39/44] drivers/vdpa: replace use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Matan Azrad <matan@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oKGeQwFdowkqOuzaFr1AKS-Er-tG0vEYzAtNxRUXyy8_1762248267
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

On Mon, Nov 3, 2025 at 5:53=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Use rte_bsd_queue.h instead.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/vdpa/mlx5/mlx5_vdpa.h | 3 ++-
>  drivers/vdpa/sfc/sfc_vdpa.c   | 2 +-
>  drivers/vdpa/sfc/sfc_vdpa.h   | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.h b/drivers/vdpa/mlx5/mlx5_vdpa.=
h
> index a398aa22ce..8071e1a5e0 100644
> --- a/drivers/vdpa/mlx5/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/mlx5_vdpa.h
> @@ -6,7 +6,8 @@
>  #define RTE_PMD_MLX5_VDPA_H_
>
>  #include <linux/virtio_net.h>
> -#include <sys/queue.h>
> +
> +#include <rte_bsd_queue.h>
>
>  #ifdef PEDANTIC
>  #pragma GCC diagnostic ignored "-Wpedantic"
> diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
> index eda111954f..73c75acca2 100644
> --- a/drivers/vdpa/sfc/sfc_vdpa.c
> +++ b/drivers/vdpa/sfc/sfc_vdpa.c
> @@ -5,8 +5,8 @@
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <pthread.h>
> -#include <sys/queue.h>
>
> +#include <rte_bsd_queue.h>
>  #include <rte_common.h>
>  #include <rte_devargs.h>
>  #include <rte_errno.h>
> diff --git a/drivers/vdpa/sfc/sfc_vdpa.h b/drivers/vdpa/sfc/sfc_vdpa.h
> index 2b843e563d..a240a8be25 100644
> --- a/drivers/vdpa/sfc/sfc_vdpa.h
> +++ b/drivers/vdpa/sfc/sfc_vdpa.h
> @@ -6,8 +6,8 @@
>  #define _SFC_VDPA_H
>
>  #include <stdint.h>
> -#include <sys/queue.h>
>
> +#include <rte_bsd_queue.h>
>  #include <bus_pci_driver.h>
>
>  #include "sfc_efx.h"
> --
> 2.51.0
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

