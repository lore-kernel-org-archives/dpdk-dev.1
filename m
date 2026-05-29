Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941BCD6E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 07:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D0164021E;
	Fri, 29 May 2026 09:47:33 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id A8776400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 09:47:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZRRMNMbEE6pJ1qKmFnLZHDoBNfar54lnGjvqejs3HMQ=;
 b=vKWjE0GjRCBFOkz9T9lnKh8DdihAQ1lqGiVn+5ll4CZ8JS0u4fEJKH9xOXEMHiJWcC3kMXUUh
 yFqlK08zLJP18pAx+9IgombFBqmlcxOLPtAWozN9auMCyNKcFzTR5CjegbY1K4yUfM1B19B3P1f
 t50E1iDg6OI9Icu9f0uLJF4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gRZxq55T8z1K97q;
 Fri, 29 May 2026 15:39:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3FE094056C;
 Fri, 29 May 2026 15:47:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 15:47:28 +0800
Message-ID: <8fe9d77c-9ade-4cbe-ac99-582f95531cb4@huawei.com>
Date: Fri, 29 May 2026 15:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] Consolidate bus driver infrastructure
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260527075654.3780732-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Hi David,

First, this is a great refactoring, thank you very much.

I have tested this patchset on the UACCE bus and it passes. Two issues were
found during testing and review:

1. Patch 25/25 fails to apply to the current main branch.
2. Patch 15/25 (bus: support multiple probing) has issues with directly
   enabling multiple probing. I suggest merging this patch into Patch 17/25.

The UACCE bus part has passed testing. Please add my Acked-by tag to the
related commits.

Thanks.

On 5/27/2026 3:56 PM, David Marchand wrote:
> This is a continuation of the work I started on the bus infrastructure,
> but this time, a lot of the changes were done by a AI "friend".
> It is still an unfinished topic as the current series focuses on probing
> only. The detaching/cleanup aspect is postponed to another release/time.
> 
> My AI "friend" really *sucked* at git and at separating unrelated changes,
> so it required quite a lot of massage/polishing afterwards.
> But it seems good enough now for upstream submission.
> 
> I would like to see this series merged in 26.07, so that we have enough
> time to stabilize it before the next LTS.
> And seeing how it affects drivers, it is probably better to merge it
> the sooner possible (so Thomas does not have to solve too many conflicts
> when pulling next-* subtrees after, especially wrt the last patch).
> 
> 
> This series refactors the DPDK bus infrastructure to consolidate common
> operations and reduce code duplication across all bus drivers.
> Currently, each bus implements its own specific device/driver lists,
> probe logic, and lookup functions.
> This series moves these common patterns into the EAL bus layer,
> providing generic helpers that all buses can use.
> 
> The refactoring removes approximately 1,400 lines of duplicated code across
> the codebase while maintaining full functional equivalence.
> 
> Key changes:
> - Factorize device and driver lists into struct rte_bus
> - Implement generic probe, device/driver lookup, and iteration helpers in EAL
> - Introduce conversion macros (RTE_BUS_DEVICE, RTE_BUS_DRIVER, RTE_CLASS_TO_BUS_DEVICE)
>   to safely convert between generic and bus-specific types
> - Remove bus-specific device/driver types from most driver code
> - Move probe logic from individual buses to rte_bus_generic_probe()
> - Separate NXP-specific metadata from generic bus structures
> 
> Benefits:
> - Significant code reduction (~1,400 lines removed)
> - Consistent behavior across all bus types
> - Simplified bus driver implementation
> - Easier maintenance and future enhancements
> 
> The series is structured as a progressive refactoring:
> - Remove redundant checks and helpers (patches 1-5)
> - Add conversion macros and factorize lists (patches 6-8)
> - Consolidate device/driver lookup and iteration (patches 9-11)
> - Refactor probe logic (patches 12-15)
> - Remove bus-specific types from drivers (patches 16-23)
> 
> Note on ABI:
> This series breaks the ABI for drivers (changes to rte_pci_device,
> rte_pci_driver, and similar structures for other buses). However, the DPDK
> ABI policy does not provide guarantees for driver-level interfaces.
> 
> 

