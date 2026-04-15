Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3AFA0C3B
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 07:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B922D4042F;
	Wed, 15 Apr 2026 09:08:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 867A3402B0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 09:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776236894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxX7rWm3CKdoUPK1fhVT40mYWsxCZUrACA1Wlt38mEw=;
 b=ad9G4iBM17NZvAm501b0S48GGrGe9d3TEn5E5D3cSvzN+ZTLLHrEnE9FGZpEynfaFx7f1N
 KZ5qsLI2EDjGB3ccKxMmaM0plD3C/HtFowRaaVaqz5/8Xja5HLRui1WKaLd+mt8GZc6Hik
 HPg6OwE/yErEkR4FTO5pTCAXoRAkj4o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-rG7dp7GcOcOScuInAVDNwA-1; Wed, 15 Apr 2026 03:08:13 -0400
X-MC-Unique: rG7dp7GcOcOScuInAVDNwA-1
X-Mimecast-MFC-AGG-ID: rG7dp7GcOcOScuInAVDNwA_1776236892
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a12514a844so3770083e87.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 00:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776236892; x=1776841692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxX7rWm3CKdoUPK1fhVT40mYWsxCZUrACA1Wlt38mEw=;
 b=ODFZ9FmG9dLOMMfqe/YU4Jznb2SGNe4mrK91IcEdnw/RSQFkg8ls6JkAgsd7wQhjEg
 oxDQim+PLynd3Vp7HLq0UxZuXw9M4REpEov5w3qbccEYhqmJiPMa//1XGKaOq9D/kR0t
 W3S2izTbEjiZw3WLAktZ0lap3A5cBR6jZn5IwSoQBbw1tohV2Cxw56sQgwBpcz9FLu9e
 uJIMcaaZDTtF3W7jEdmATo7TedAHHDIVWulgtyA671pZl1BbV+bFcJpjWJwJr35vJkj/
 zvCpS47gpXoU5OBAL4QwIYUJeoe/nivW1/Zgz3Xx9bGA2OdZQ642uM5oRSL29FF7Ul8G
 RqnA==
X-Gm-Message-State: AOJu0YxNzKtO1sMKGVCwIDJk13hUulhYZsCQx1mFjFFvqM4XGaL/cETL
 BJwUhvmcT+UK92pWiUVzdzsYx1AuAlIQ2CU8/5EtcmkI1krx7P7IYKCE1V0HrBd1Za5F4JONntl
 toGck0pKAJSpjyxMlig+mT6lXLCcSC4QEaCdODR9KbxkXYkbiQN0RepxDlzYGYSMgUtSyl18ikp
 LmXTfRLyKZcHC5jj0iQ78=
X-Gm-Gg: AeBDieuxQ730ezcD9No5h9OOA0oBrWWjoM95Bu04DHj/Txueh7hgS3BmPllIb3cdx6L
 u33xqu3fa8ryloBCzC0538ng3fJTL5wQPUhgnaz67+B69tHeHsn3a+6ziKuiXrLApRtbxH6VUQx
 g0JifkvrZ+v1++xaVaGEiBpT2LO4YemOrIGxn8VHjLckqKS102SCsWBefk8TiHejbiBm0SK4Cch
 N9fpMUhz6e+iiQVb2Kcg8vo0/72aI6ANYfWGdXNUPQLgDHJsJeD+xRumN+2nxB5Lp/ViMUAnsYx
 5x6t
X-Received: by 2002:a05:6512:3a90:b0:5a2:a851:b00 with SMTP id
 2adb3069b0e04-5a3efb2d30dmr8535229e87.3.1776236891757; 
 Wed, 15 Apr 2026 00:08:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3a90:b0:5a2:a851:b00 with SMTP id
 2adb3069b0e04-5a3efb2d30dmr8535203e87.3.1776236891059; Wed, 15 Apr 2026
 00:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260414123900.3355883-1-david.marchand@redhat.com>
In-Reply-To: <20260414123900.3355883-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 15 Apr 2026 09:07:58 +0200
X-Gm-Features: AQROBzC64kXUv1hWM_ovLLj7M0blOfwDxBaq3jo64N3tFtd6e8a5pgLb_CyeNC4
Message-ID: <CAJFAV8zCa4dXy30sDkwKEeCLfSL_cBPAdpZLCuVu=tMF+Frv=g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Rework device probing
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Kevin Traynor <ktraynor@redhat.com>, Maxime Leroy <maxime@leroys.fr>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LbUvtE7RU3xNnd2xwhpDPgDMh1OQ9e_eGF0y-onMugQ_1776236892
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

On Tue, 14 Apr 2026 at 14:39, David Marchand <david.marchand@redhat.com> wrote:
>
> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>
>
> --
> David Marchand
>
> Changes since v3:
> - renamed some internal API,
> - updated documentation,
> - added a release notes entry,
>
> Changes since v2:
> - rebased for late 26.03 fslmc bus changes,
> - fixed devargs lookup,
> - added debug logs,
>
> Changes since v1:
> - restored per bus scan mode,
> - fixed logic in device selection for dma/idxd,
> - fixed raw/ifpga hotplug on ifpga bus,
> - fixed some doxygen,
>
> Changes since RFC v3:
> - removed per bus scan mode,
>
> Changes since RFC v2:
> - went one step further and reworked devargs lookup in buses following
>   Bruce comment (see patch 4 which is cosmetic, and patch 5),
> - updated device selection helper accordingly and
>   changed API to be device name based,
> - renamed option, added check on -b presence, updated doc in the last
>   patch,
>
> Changes since RFC v1:
> - reviewed bus probe() and cleaned up NXP drivers,
> - changed approach following Bruce comment,
>
> David Marchand (7):
>   devtools: check packet forwarding in null test
>   bus/fslmc: fix bus cleanup
>   drivers/bus: require probe function for NXP drivers
>   drivers/bus: cleanup devargs lookup in scan
>   bus: factorize devargs lookup
>   bus: factorize device selection
>   eal: configure initial device probing
>
>  app/test/test_eal_flags.c                    | 63 ++++++++++++++++
>  devtools/test-null.sh                        | 10 ++-
>  doc/guides/linux_gsg/eal_args.include.rst    | 18 +++++
>  doc/guides/rel_notes/release_26_07.rst       |  8 +++
>  drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
>  drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
>  drivers/bus/auxiliary/private.h              |  6 --
>  drivers/bus/cdx/cdx.c                        | 34 +--------
>  drivers/bus/dpaa/dpaa_bus.c                  | 71 ++++++++----------
>  drivers/bus/fslmc/fslmc_bus.c                | 75 ++++++++------------
>  drivers/bus/fslmc/fslmc_vfio.c               | 21 ++----
>  drivers/bus/ifpga/ifpga_bus.c                |  8 ++-
>  drivers/bus/pci/bsd/pci.c                    |  5 +-
>  drivers/bus/pci/linux/pci.c                  |  2 +-
>  drivers/bus/pci/pci_common.c                 | 51 ++++---------
>  drivers/bus/pci/private.h                    | 11 ---
>  drivers/bus/pci/windows/pci.c                |  4 +-
>  drivers/bus/platform/platform.c              | 43 +----------
>  drivers/bus/uacce/uacce.c                    | 39 +---------
>  drivers/bus/vdev/vdev.c                      |  2 +-
>  drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
>  drivers/bus/vmbus/private.h                  |  3 -
>  drivers/bus/vmbus/vmbus_common.c             | 45 +++---------
>  drivers/dma/idxd/idxd_bus.c                  | 18 +----
>  lib/eal/common/eal_common_bus.c              | 54 ++++++++++++++
>  lib/eal/common/eal_common_options.c          | 10 +++
>  lib/eal/common/eal_internal_cfg.h            |  1 +
>  lib/eal/common/eal_option_list.h             |  2 +
>  lib/eal/include/bus_driver.h                 | 38 ++++++++++
>  30 files changed, 314 insertions(+), 367 deletions(-)

Series applied, thanks for all the reviews!


-- 
David Marchand

