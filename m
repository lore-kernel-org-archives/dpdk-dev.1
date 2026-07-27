Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A1DC54EFC
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 06:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3190040269;
	Mon, 27 Jul 2026 08:16:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 68CA440150
 for <dev@dpdk.org>; Mon, 27 Jul 2026 08:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785133016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiN1qwz+frkIbnmGMkNx7hBfwiIlq3uPMCVmLJKiwrg=;
 b=ODM2OBfFY8BAskbuW3EfktYGTyNaxZ+gPrlbB5lvuMhn+Soqh31i2XdUxoMMwil5VfuyRP
 6QSihN/Eq5Jd0bIhAgPsK1bfQ3h4+mWubEbPqrlbrYOI6qlWoO5TSoiZMz9hUVwwlLoZ1N
 M4Nm3QREPtQNmmY9f3zseFKUVbeKf+w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-1N329rrwMSe0_LCNNtyEQg-1; Mon, 27 Jul 2026 02:15:41 -0400
X-MC-Unique: 1N329rrwMSe0_LCNNtyEQg-1
X-Mimecast-MFC-AGG-ID: 1N329rrwMSe0_LCNNtyEQg_1785132940
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa68dae27dso1751945e87.2
 for <dev@dpdk.org>; Sun, 26 Jul 2026 23:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785132940; x=1785737740;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RiN1qwz+frkIbnmGMkNx7hBfwiIlq3uPMCVmLJKiwrg=;
 b=DRptYOwP6DJdqQE/v03aZ3eDbJPxR0uFg9WUu1QNdBjbPU6nWGPgTyA8jMBvX0Oxwr
 N2qpGXU8xhikyeYtbePIYI/FkDKnTQgve9pz0dazaeMhXjsCD2Tl5QMK5HJ04JpYbQc/
 KzvhIOnVAFDd2Od5h/VM+ex1lQidlKbV2ERD0VJlR54P+1K6c5WPrF0fMKveXulbIGE4
 DpZoYrnEDftqJEfZXmxSfoJZxwjJ2xD4+H3l/jfZQaqmXGF431e3XGjK4smhAN+Bs216
 ZqA5Gct8ytok3nXLA8lmbaazCkygI3Fu68RLz2hl7KrKzHEZxcuhOm3IdA9Pe9cSMfqy
 GNlA==
X-Gm-Message-State: AOJu0YxkT4jpY1rLDL1qY6cmLY/Bd1gxxMAFtCvabo9mg4k8ZbTKKiQZ
 uAXLbEGAh4T7NnGMW9djAgomCCj9uOQvyHEXbkV1XFMzUYkODGXo2HWRpW7xOurFWKHSnS+l3E7
 vzIlVbh0MNddF0xdGbDpyPniURHRraa8OFOPBs5dAQksAFZ2/2UrmC3+nk3IAfoEx2Y8yS+s29u
 CjeqZR1bJ+yee7c/g6uJY=
X-Gm-Gg: AR+sD10NVCDc1mymIttNQ7lP1+6E6mxvOGLI341lgwqrgft/+A0g5MIvdSxQ+Q9b+yn
 psNqWwf3gf7fyoIxAx6zojSmO5ulPa5Fc96tBDNbi7bJrBrd7ZYwOXKCn56bLUvEB3R8B8TqS7Z
 yH3xLRaj/1j/f4K17vynqABY8+dWIsokCRGAF6CABM5SIxD+KZkpDStQWRTjz9jwyQCVerIyfyf
 Avel8k3kabTd8ea6K9abtaLEm5EoxFQ6KM6acBivkVtTmh7
X-Received: by 2002:a05:6512:23a9:b0:5b2:8d3e:7229 with SMTP id
 2adb3069b0e04-5b2c1b4dcf4mr1409491e87.57.1785132939687; 
 Sun, 26 Jul 2026 23:15:39 -0700 (PDT)
X-Received: by 2002:a05:6512:23a9:b0:5b2:8d3e:7229 with SMTP id
 2adb3069b0e04-5b2c1b4dcf4mr1409472e87.57.1785132939258; Sun, 26 Jul 2026
 23:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260612071434.2722918-1-yangxingui@huawei.com>
In-Reply-To: <20260612071434.2722918-1-yangxingui@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 27 Jul 2026 08:15:27 +0200
X-Gm-Features: AUfX_mybejMaQGHIPLZfoi_7iyhS-GWipWD3keCnO8ZFAU20WDza6w7aaqyHoIo
Message-ID: <CAJFAV8xzvx8RtqpkG-KcRrbKGk+HPk0ms-=kFSLcDhO1KZkk-A@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix high SMMU TLB miss with mempool alignment
To: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com, 
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net, 
 Xingui Yang <yangxingui@huawei.com>, dmitry.kozliuk@gmail.com,
 fengchengwen@huawei.com, 
 yangshuaisong@h-partners.com, lihuisong@huawei.com, liuyonglong@huawei.com, 
 kangfenglong@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kz0cX1jRMxfvk3IDt6ITGuPTo6cut1Iwq62UymCMG80_1785132940
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

Hello mlx5 guys,

On Fri, 12 Jun 2026 at 09:14, Xingui Yang <yangxingui@huawei.com> wrote:
>
> From: Shuaisong Yang <yangshuaisong@h-partners.com>
>
> On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core pinning
> under SMMU nonstrict/strict mode shows about 30% performance degradation
> compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,
> intra-NUMA performs as expected (slightly better than cross-NUMA).
>
> CX7 in NUMA1
> NUMA node0 CPU(s):    0-39
> NUMA node1 CPU(s):    40-79
>
> intra-NUMA:
> dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
>   --config='(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\
>             (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\
>             (0,10,50),(0,11,51),(0,12,52),(0,13,53),\
>             (0,14,54),(0,15,55)' \
>   --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64
>
> cross-NUMA:
> dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
>   --config='(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\
>             (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\
>             (0,10,21),(0,11,22),(0,12,23),(0,13,24),\
>             (0,14,25),(0,15,26)' \
>   --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64
>
> The root cause is that under SMMU enabled mode, the mempool allocated
> for intra-NUMA pinning is aligned to system page size instead of
> hugepage size, while cross-NUMA pinning correctly uses hugepage size
> alignment. This causes high TLB miss rates under SMMU.
>
> Align all memory ranges to hugepage boundaries during mempool
> registration to ensure hugepage_sz alignment, thereby reducing TLB
> misses and fixing the intra-NUMA performance degradation.
>
> Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
> Cc: stable@dpdk.org
>
> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Review please.


-- 
David Marchand

