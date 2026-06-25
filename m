Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA0CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 12:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9114140430;
	Thu, 25 Jun 2026 14:24:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D165F40280
 for <dev@dpdk.org>; Thu, 25 Jun 2026 14:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782390272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrL9U9/r8T+rDzab23BOHDnw8kkbrYg6eOL1xcFynS0=;
 b=FlPytiNtUrP5H/8txJYCAhk+wRGbMZFP2u2gL2RM9fbOSvi4Id9YJcFQkqahN8RL7GurhX
 6FJyGixqoP2c+wFGdqQcxLUGZ81yuLp+IK76YV8MS5sZ42n4VglJ6xa5CRoBacv7oDSs9e
 DR/8ABnLISOHx67PtsMIhNnAO6GfmPY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-NV9n1TywOCGVY-7oh7eXuQ-1; Thu, 25 Jun 2026 08:24:29 -0400
X-MC-Unique: NV9n1TywOCGVY-7oh7eXuQ-1
X-Mimecast-MFC-AGG-ID: NV9n1TywOCGVY-7oh7eXuQ_1782390268
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39ad3cb5c79so1554431fa.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 05:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782390267; x=1782995067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrL9U9/r8T+rDzab23BOHDnw8kkbrYg6eOL1xcFynS0=;
 b=AwhuVDUS1+dg+hmFSlcFcirccBioErTwcq6iRQga+bLAP2bLtUDsqPDi6lh9Es7F9d
 2esKipHsnHLONSMUu31EwuTj+qaKGS5vCxL3272uhG++3YzhxdKLzR62jN+o7SbeN7oG
 a4Ix6i+XOA8nk8feMlT5ZGeQiD3/0p5LrnodWBiLWd4rO0afP9Dx6Ltf40X/3/c//V9M
 5mtdd82lPnqH+Owlj3FIhfGcvD+wd3Poibn0XddDAyUVf61NqDuCRS8+yj+JLg5Pi3Ul
 UFiNAlLu/6IWOGVYQsmTsXw3x8cdRnFs+RY3dRqZOuWbhsDvZsyfsK9eFptOdLCmY4pW
 YEqg==
X-Gm-Message-State: AOJu0YxYUD9iDmkF1Gz0PpGcn36GEIvyzXfmKuZuIW3GHXFIGrCsa6iP
 CT2xtJFPZ4zeNkxviqk/KTpK3YuBQZ2rwXfASmNKreFVrw1ijMOQ3b5u4YbXv+a4+OG1Pk/QJ9c
 ThgZKUXT43d8fMic598BwNbi1+oTb77q+jjVqfcs/xaYdGZ+Eb9A8JGDkVwPUvy3+qkSqrWM9J/
 V4Mm0uGkDgf9TivMpVifM=
X-Gm-Gg: AfdE7cmIhkYdrqdGffj/BgL7eQlTX4kIUzw7K1BWlwgmt32ZPA8dZ9jgzOoDaM4tWQm
 zlMZx7esfcC+6ReqYHB0mTgv67LXEDuoHN01deElBQj54f+LSL/sDfXXFPqWHQNvFjXIp/J5MiO
 kTnMrO2nYNc1btcyWj+mmgDWGjtkQvrZ0YkvfaWgGAQPkxk/uWXSUulrmtVqr0A57Ossi4lyzA3
 3qLwUg/N8mxM+E/YDJ7YFLWL6kClANKBuN1DokoLvPhTjFORrKfOWQLdJk=
X-Received: by 2002:a2e:a547:0:b0:399:876b:3a9c with SMTP id
 38308e7fff4ca-39acb69d932mr6213431fa.16.1782390267409; 
 Thu, 25 Jun 2026 05:24:27 -0700 (PDT)
X-Received: by 2002:a2e:a547:0:b0:399:876b:3a9c with SMTP id
 38308e7fff4ca-39acb69d932mr6213351fa.16.1782390266823; Thu, 25 Jun 2026
 05:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 14:24:13 +0200
X-Gm-Features: AVVi8Cc9J1hWwoitbqfspHTZrd1NbrB5J8KR8IrJsMmhzICwSHOB2DJOR9EGbck
Message-ID: <CAJFAV8zGLQ2Lh5hMt8g50=-S54y11a-mYL=tU=Nb5i9nkOjODA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Bus cleanup infrastructure and fixes
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com, 
 hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i-DaSMIgrBj9WC4KJNFGmBLMSoSqSBlNSx9IiOqkUic_1782390268
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

On Wed, 24 Jun 2026 at 12:43, David Marchand <david.marchand@redhat.com> wrote:
>
> This is a followup of the previous bus refactoring.
> See https://inbox.dpdk.org/dev/CAJFAV8zvFpLwz8SY8DUUezyJyM43eRZ17Yj30ex808eHC4ZE=g@mail.gmail.com/.
>
> This series refactors the bus cleanup infrastructure to reduce code
> duplication and fix resource leaks in several bus drivers.
> It should address the leak Thomas pointed at.
>
> The first part of the series (patches 1-6) addresses several bugs and
> inconsistencies:
> - Documentation and log message inconsistencies from earlier bus
>   refactoring
> - Device list management issues in dma/idxd and bus/vdev
> - Resource leaks in PCI and VMBUS bus cleanup (mappings and interrupts)
> - Deferred interrupt allocation to probe time (VMBUS)
>
> The core infrastructure changes (patches 7-8) introduce the generic
> cleanup framework:
> - Refactors unplug operations to be the counterpart of probe_device
> - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> - Adds .free_device operation to struct rte_bus
>
> The final patches (9-10) convert the VMBUS bus to use the generic
> cleanup helper.
>
> After this series, most buses use the generic cleanup helper, eliminating
> duplicated code and ensuring consistent cleanup behavior across the
> codebase.
>
> NXP bus drivers require more (leak) fixes and refactoring and
> are left untouched.
>
>
> --
> David Marchand
>
> Changes since v3:
> - added fix on vdpa/nfp,
>
> Changes since v2:
> - moved ifpga interruption allocation,
>
> Changes since v1:
> - dropped all changes on DPAA and FSLMC bus,
> - added one more cleanup on the first patch,
> - changed coding style in rte_vdev_init,
> - implemented explicit .free_device instead of hack for calling free(),
> - reordered interrupt handle allocation in VMBUS bus,
>
>
> David Marchand (12):
>   bus: fix reference to plug callback
>   dma/idxd: remove next pointer in bus specific device
>   bus/vdev: remove driver setting in probe
>   vdpa/nfp: fix double PCI unmap on unplug
>   bus/pci: fix mapping leak in bus cleanup
>   bus/vmbus: fix interrupt leak in cleanup
>   bus/vmbus: allocate interrupt during probing
>   bus/ifpga: allocate interrupt during probing
>   bus: align unplug with device probe
>   bus: implement cleanup in EAL
>   bus/vmbus: store name in bus specific device
>   bus/vmbus: support unplug
>
>  doc/guides/prog_guide/device_hotplug.rst | 20 +++---
>  doc/guides/rel_notes/release_26_07.rst   |  4 ++
>  drivers/bus/auxiliary/auxiliary_common.c | 54 +++------------
>  drivers/bus/cdx/cdx.c                    | 29 ++------
>  drivers/bus/dpaa/dpaa_bus.c              |  4 +-
>  drivers/bus/fslmc/fslmc_bus.c            |  9 +--
>  drivers/bus/ifpga/ifpga_bus.c            | 88 ++++++++----------------
>  drivers/bus/pci/pci_common.c             | 68 +++---------------
>  drivers/bus/platform/platform.c          | 26 ++-----
>  drivers/bus/uacce/uacce.c                | 59 +++-------------
>  drivers/bus/vdev/vdev.c                  | 76 ++++++++------------
>  drivers/bus/vmbus/bus_vmbus_driver.h     |  1 +
>  drivers/bus/vmbus/linux/vmbus_bus.c      | 16 +----
>  drivers/bus/vmbus/vmbus_common.c         | 58 +++++++++-------
>  drivers/dma/idxd/idxd_bus.c              |  1 -
>  drivers/vdpa/nfp/nfp_vdpa.c              |  4 +-
>  lib/eal/common/eal_common_bus.c          | 33 ++++++++-
>  lib/eal/common/eal_common_dev.c          | 10 +--
>  lib/eal/include/bus_driver.h             | 51 +++++++++-----
>  19 files changed, 235 insertions(+), 376 deletions(-)

Series applied, thanks for the reviews.


-- 
David Marchand

