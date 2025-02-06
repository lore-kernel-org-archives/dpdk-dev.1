Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B196C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 15:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7CE402F1;
	Thu,  6 Feb 2025 16:19:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 230ED4029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 16:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738855195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oO2FerZ3RpIb8PK+5c5bH/9AXeXo4TtZQpvOkJ59akw=;
 b=dbQgBiQkY8I3yFdFnxxhfVN5WZmS0NS6tVatcmUXcUOsG9wewhui4/lzD2EAe2Np6YUSDd
 NhylrxpisAylceL08x3C8mUgWoexJIA4o+3pNhImBeFN66Nmhw6NRV+L3ojpLIwFi/EWgL
 mT0ztBbcXaB71s4BGu6k3qd0GtrFUAI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-N4te0IM5PDmkrLXSGB5W3g-1; Thu, 06 Feb 2025 10:19:52 -0500
X-MC-Unique: N4te0IM5PDmkrLXSGB5W3g-1
X-Mimecast-MFC-AGG-ID: N4te0IM5PDmkrLXSGB5W3g
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5412ceadaa3so551103e87.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 07:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738855191; x=1739459991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO2FerZ3RpIb8PK+5c5bH/9AXeXo4TtZQpvOkJ59akw=;
 b=wZt/O4bZP717YbtKofUMiB83f3vSC7k8CcvEOfBSyf8Zr0uLPb9TOMc40u9dnA375U
 BTVEeKN7F0MDxSe4qBaz4cSZjicuXlVt2ni0/FG1Mi3QCOV2TLWblY8ZXA6e0d8Nlp56
 pflNg4HHvmCI+mdWsYFVxt4nWpcWux1KNskR6ca069EqyPY9a9RNfvh/VtDnU14a91Zj
 2A9wtOfwHVQqVR6POSJW6g3PFOUAd5dNuBvL52WOYyM7B85ah0s1ZiLKsvJm/z3mvPW4
 uIqa6upfImFnRzVMvw19rSa8dmur2OlgLW+ksZXnrYp0YAbD1rVYAAbMr9IYLVuJykcH
 bnMA==
X-Gm-Message-State: AOJu0YxTOB2SEcbLNnPRp/St8Ms1YId978id7kE7B0C1ScVAJeKK1pn7
 kELwreqNJRRXTCf65TNlLMs0nxE7ZEX5Cp9NO1scAvPlq6j2QYGerE2EAhhCtjrN+jgEV4rHvJ6
 1OAzMZVMnDyCrToXFIKU3cYkHo0fTCw9jwZ9SoK/oW2lXZZdtrvQufVyWcTuYohXmjrUyObu3ND
 FtYAinGzC3yucCiqQ=
X-Gm-Gg: ASbGncswbIUkEdHi6bsriQbMhKgXyCxiMeqrdB16NEMcga2mEJUHbc276MHnl/R9xbA
 Sg+rTKsZlnadXAERoPQvB3uV4nKo/3uTQtB96SXPIJVJXv4fmgCzbQjkLWNF/+IDQ
X-Received: by 2002:a05:6512:3b99:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-54405a76a90mr3182455e87.49.1738855190689; 
 Thu, 06 Feb 2025 07:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5VuUD7CFRPk0ojzez3I3Fo6id1TVJsRjsfOr8kIsjxGU7nnz2tQBoasATWIlHCHyMCjw/2N85XD6jr1jPzKU=
X-Received: by 2002:a05:6512:3b99:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-54405a76a90mr3182424e87.49.1738855190256; Thu, 06 Feb 2025
 07:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250205182918.4041268-1-bruce.richardson@intel.com>
 <20250205182918.4041268-3-bruce.richardson@intel.com>
In-Reply-To: <20250205182918.4041268-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Feb 2025 16:19:38 +0100
X-Gm-Features: AWEUYZnRVyU0RBH-OjMSckPUpWMXxnLQyATmmCBxMW4-Nce1Bta3Z7txNjXNsfY
Message-ID: <CAJFAV8xYzL0QtKyUvRLPOxWAUSEBRtqfzSLaY7B+APWZi=k5YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] build: replace support for icc with icx
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, john.mcnamara@intel.com, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 John Daley <johndale@cisco.com>, 
 Hyong Youb Kim <hyonkim@cisco.com>, Ziyang Xuan <xuanziyang2@huawei.com>, 
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>, Jie Hai <haijie1@huawei.com>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>, 
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, 
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>, 
 Wajeeh Atrash <atrwajee@amazon.com>, David Christensen <drc@linux.ibm.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Patrick Robb <probb@iol.unh.edu>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UCtZTvn4XmoqGs7BKw26PLqgfej0lhnFGk-19NqPTXU_1738855191
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

On Wed, Feb 5, 2025 at 7:29=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
> index 260e4761bd..9e6a7d553a 100644
> --- a/app/test-pmd/testpmd.h
> +++ b/app/test-pmd/testpmd.h
> @@ -1292,10 +1292,6 @@ RTE_INIT(__##c) \
>         testpmd_add_driver_commands(&c); \
>  }
>
> -/*
> - * Work-around of a compilation error with ICC on invocations of the
> - * rte_be_to_cpu_16() function.
> - */
>  #ifdef __GCC__
>  #define RTE_BE_TO_CPU_16(be_16_v)  rte_be_to_cpu_16((be_16_v))
>  #define RTE_CPU_TO_BE_16(cpu_16_v) rte_cpu_to_be_16((cpu_16_v))

You may entirely drop those RTE_BE_TO_CPU_16 macros and just rely on
rte_be_to_cpu_16.


> diff --git a/buildtools/check-symbols.sh b/buildtools/check-symbols.sh
> index e458c0af72..b8ac24391e 100755
> --- a/buildtools/check-symbols.sh
> +++ b/buildtools/check-symbols.sh
> @@ -45,9 +45,8 @@ do
>         fi
>  done
>
> -# Filter out symbols suffixed with a . for icc
>  for SYM in `awk '{
> -       if ($2 !=3D "l" && $4 =3D=3D ".text.experimental" && !($NF ~ /\.$=
/)) {
> +       if ($2 !=3D "l" && $4 =3D=3D ".text.experimental") {
>                 print $NF
>         }
>  }' $DUMPFILE`
> @@ -76,9 +75,8 @@ do
>         fi
>  done
>
> -# Filter out symbols suffixed with a . for icc
>  for SYM in `awk '{
> -       if ($2 !=3D "l" && $4 =3D=3D ".text.internal" && !($NF ~ /\.$/)) =
{
> +       if ($2 !=3D "l" && $4 =3D=3D ".text.internal") {
>                 print $NF
>         }
>  }' $DUMPFILE`

LGTM, this is what I had in mind too.

>  API Changes
>  -----------
> diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
> index aea2e5c929..4c6af8285e 100644
> --- a/drivers/net/ena/ena_ethdev.c
> +++ b/drivers/net/ena/ena_ethdev.c
> @@ -1413,7 +1413,6 @@ static int ena_create_io_queue(struct rte_eth_dev *=
dev, struct ena_ring *ring)
>         struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);
>         struct rte_intr_handle *intr_handle =3D pci_dev->intr_handle;
>         struct ena_com_create_io_ctx ctx =3D
> -               /* policy set to _HOST just to satisfy icc compiler */
>                 { ENA_ADMIN_PLACEMENT_POLICY_HOST,
>                   0, 0, 0, 0, 0 };
>         uint16_t ena_qid;

No clue what this was about..

Looking at git history, it looks like something that got copy/pasted
over time...
I guess we can simply drop it.


> diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_comm=
on_dynmem.c
> index b4dc231940..3c34a7defb 100644
> --- a/lib/eal/common/eal_common_dynmem.c
> +++ b/lib/eal/common/eal_common_dynmem.c
> @@ -510,7 +510,6 @@ eal_dynmem_calc_num_pages_per_socket(
>                 /* if we didn't satisfy all memory requirements per socke=
t */
>                 if (memory[socket] > 0 &&
>                                 internal_conf->socket_mem[socket] !=3D 0)=
 {
> -                       /* to prevent icc errors */
>                         requested =3D (unsigned int)(
>                                 internal_conf->socket_mem[socket] / 0x100=
000);

I suspect those casts on socket_mem[] are unnecessary (and later, in
the same file).

>                         available =3D requested -


--=20
David Marchand

