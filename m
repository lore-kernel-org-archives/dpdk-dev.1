Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B143F01804
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 08:27:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B599402D3;
	Fri,  6 Mar 2026 09:27:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C90E40278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 09:27:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772785621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JfbqPfv03GcBD9AAh/97zAKr2kX/fS3Dv5ahhUEYJUo=;
 b=NXQQPa7ena6Rn7T+SY9bdXUIr2BQto5oRM1Rx4Zu+rQzfrk7/DclXa5hBchCJs8JHbHjE5
 FDVvRu6lCbGz+X6XmzJ7x9hnzi/97O1JGYtYbgwNzCZTnJgCbr4gzQ3RPHcE5BDyoTrb86
 +81J1CBHqPd0IfdOoArmvQRPjTH89WY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-TG19WIuGMHy0QhfzVpA1UA-1; Fri, 06 Mar 2026 03:27:00 -0500
X-MC-Unique: TG19WIuGMHy0QhfzVpA1UA-1
X-Mimecast-MFC-AGG-ID: TG19WIuGMHy0QhfzVpA1UA_1772785619
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6cbd5493so2198868e87.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 00:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772785618; x=1773390418;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JfbqPfv03GcBD9AAh/97zAKr2kX/fS3Dv5ahhUEYJUo=;
 b=UQWR5nYp4rf9YFzeBjP15Zx82oZLrHEu9AktX1nshd1OmH0vV8jvlTEqREdpOWH9eN
 JK4NjrJyYNhal/KmB293JGbI3AU3n66oisLYxNcVIRyAtuOBfoa1baTKK6Z12s6fQjTF
 49h/MmQW3PBtXCLF9ZD1SVC6zGyNmuzNQ1u0N+eMsqqtVuCe2+r8nWbhBOXABKMdHy1u
 sezL1RUxapnG2UUnwjEdGM/1mhOCeUy0gXs45prnKpO5POqOfX+qIbw/9sD2hFhpRQdf
 fIEngVKiizueuxMpPuzwoEPCb03Y2IN1qpQvEdZi+EPqneULhddMHn3v6PZ2ykCzb/Zz
 TW4g==
X-Gm-Message-State: AOJu0YxdadqCqgQPEJCnmUXUHZO3GbR5j4E8GiRAXk7n3ovk6cVLWamY
 Nqo8OnEqnQxI8RBfSYIkOwXD9zJQ9exaegci6JR07oiE3OobjRZ+1W2uKZlIxLowTwqek9LIWlc
 cIif4iMZ6dkVCshuF6W/X42PM9kCSfTDNOVAaMzd4xY5+dgmtiEMDgFM23W9+jqrCNSyZamXy9x
 iD0ImujHpFfP6hqgKb/IsYiAc79C3+vw==
X-Gm-Gg: ATEYQzxqAmx+CwFkYtaiypSSMo/RhRAHfp5SLth1usWnCDAU3TPn2D2zsl2CxRUFy9i
 4IzqnDOmUZrwE80W+tTOQ9dKJd35/Sd+2KAJ/Zbgcq3vuvdpUx8VdjuyiBRfR5d0RrCKB39pcf3
 Xm9TBMJ5SM57jB89JR+mv8gCcPpwDkGH0Hy7SrnbGsRNAf9s2pZVIELxjGVcKc8zz092M/Jd11h
 aU5TXT8dt6zTAseojeyFSHvy3fx2ZFNmedMrhRVY6f6UrdlwxzVBCm95nZ4jq/2RyCFSA==
X-Received: by 2002:a2e:b8d1:0:b0:38a:aba:9bf9 with SMTP id
 38308e7fff4ca-38a40a1c8aamr4403591fa.8.1772785618174; 
 Fri, 06 Mar 2026 00:26:58 -0800 (PST)
X-Received: by 2002:a2e:b8d1:0:b0:38a:aba:9bf9 with SMTP id
 38308e7fff4ca-38a40a1c8aamr4403411fa.8.1772785617610; Fri, 06 Mar 2026
 00:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Mar 2026 09:26:46 +0100
X-Gm-Features: AaiRm52VVe_aZKugrc1TTGfjlLmDen20JBheahn-8SOrc6fLS_j9lsiIoHOBrrE
Message-ID: <CAJFAV8wYgF7TuQoM=82OWx5oO2+rfi1qEqkO=HAxuOVPQP=qZg@mail.gmail.com>
Subject: Re: [RFC v3 0/7] Rework device probing
To: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -t_3gihRawCOn9Hu6gXfZnRFC3a1Lj205jyeGDEATC4_1772785619
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

On Thu, 5 Mar 2026 at 17:46, David Marchand <david.marchand@redhat.com> wrote:
>
> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>
>
> --
> David Marchand
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
>   drivers: cleanup devargs lookup in bus scan
>   bus: factorize devargs lookup
>   bus: factorize device selection
>   eal: configure initial device probing
>
>  app/test/test_eal_flags.c                    | 63 +++++++++++++++++
>  devtools/test-null.sh                        | 10 ++-
>  doc/guides/linux_gsg/eal_args.include.rst    | 13 ++++
>  drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
>  drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
>  drivers/bus/auxiliary/private.h              |  6 --
>  drivers/bus/cdx/cdx.c                        | 34 +---------
>  drivers/bus/dpaa/dpaa_bus.c                  | 71 +++++++++-----------
>  drivers/bus/fslmc/fslmc_bus.c                | 69 ++++++++-----------
>  drivers/bus/fslmc/fslmc_vfio.c               | 22 ++----
>  drivers/bus/ifpga/bus_ifpga_driver.h         |  2 -
>  drivers/bus/ifpga/ifpga_bus.c                |  4 +-
>  drivers/bus/pci/bsd/pci.c                    |  5 +-
>  drivers/bus/pci/linux/pci.c                  |  2 +-
>  drivers/bus/pci/pci_common.c                 | 51 ++++----------
>  drivers/bus/pci/private.h                    | 11 ---
>  drivers/bus/pci/windows/pci.c                |  4 +-
>  drivers/bus/platform/platform.c              | 43 +-----------
>  drivers/bus/uacce/uacce.c                    | 39 +----------
>  drivers/bus/vdev/vdev.c                      |  2 +-
>  drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
>  drivers/bus/vmbus/private.h                  |  3 -
>  drivers/bus/vmbus/vmbus_common.c             | 45 +++----------
>  drivers/dma/idxd/idxd_bus.c                  | 18 +----
>  drivers/raw/ifpga/ifpga_rawdev.c             |  2 +-
>  lib/eal/common/eal_common_bus.c              | 44 ++++++++++++
>  lib/eal/common/eal_common_options.c          | 10 +++
>  lib/eal/common/eal_internal_cfg.h            |  1 +
>  lib/eal/common/eal_option_list.h             |  2 +
>  lib/eal/include/bus_driver.h                 | 37 ++++++++++
>  31 files changed, 288 insertions(+), 364 deletions(-)

Recheck-request: github-robot


-- 
David Marchand

