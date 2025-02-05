Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA945C02196
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 01:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7964021E;
	Wed,  5 Feb 2025 02:55:44 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 49957400EF
 for <dev@dpdk.org>; Wed,  5 Feb 2025 02:55:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ynjsb1pKGzgcTQ;
 Wed,  5 Feb 2025 09:52:19 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8D2FF180088;
 Wed,  5 Feb 2025 09:55:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 09:55:35 +0800
Message-ID: <62c59ce2-6aab-409f-b44f-6b1faf0eaf2a@huawei.com>
Date: Wed, 5 Feb 2025 09:55:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bus: fix inconsistent representation of PCI numbers
To: Bruce Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Shani Peretz <shperetz@nvidia.com>, <dev@dpdk.org>, <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Parav Pandit
 <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>, Jan Blunck
 <jblunck@infradead.org>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129091738.681777f1@hermes.local>
 <Z5puC3JYHR0LBxKH@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <Z5puC3JYHR0LBxKH@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2025/1/30 2:06, Bruce Richardson wrote:
> On Wed, Jan 29, 2025 at 09:17:38AM -0800, Stephen Hemminger wrote:
>> On Wed, 29 Jan 2025 10:54:16 +0200
>> Shani Peretz <shperetz@nvidia.com> wrote:
>>
>>> DPDK provides two formats for specifying PCI device numbers:
>>> a full version ("0000:08:00.0") and a short version ("08:00.0").
>>> Issues can occur when an application uses one format (e.g., short)
>>> while running testpmd, then attempts to use the other format
>>> (e.g., full) in a later command, resulting in a failure.
>>>
>>> The issue is that find_device goes over the list of devices and
>>> compares the user-provided string to the rte_device structure's
>>> device->name (device->name is just the string received from devargs
>>> (i.e "08:00.0" or "0000:08:00.0")).
>>> Notice that there's another field that represents the device name,
>>> but this one is in the rte_pci_bus struct. This name is actually the result
>>> of the PCI parse function ("0000:08:00.0").
>>> If we want to accurately compare these names, we'll need to bring both
>>> sides to the same representation by invoking the parse function on
>>> the user input.
>>>
>>> To make the cmp_dev_name function applicable to all buses—not just PCI—
>>> the proposed solution is to utilize the parse function implemented by
>>> each bus. When comparing names, we will call parse on the supplied
>>> string as well as on the device name itself and compare the results.
>>> This will allow consistent comparisons between different representations
>>> of same devices.
>>>
>>> Also, the pci_common_set function has been modified to improve naming
>>> consistency for PCI buses.
>>> Now, the name stored in rte_device for PCI buses will match the parsed
>>> name that is also stored in rte_pci_device name,
>>> rather than using the user-provided string from devargs.
>>> As a result, when a new PCI device is registered, the name displayed in
>>> the device list will be the parsed version.
>>>
>>> Added tests that compare and find devices in various forms of names
>>> under test_devargs.
>>>
>>> Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")
>>
>> Maybe just fix for now by normalizing the PCI device string when before
>> storing and after parsing?  That would allow for simple fix that can be backported.
>> The more complex generalization of bus address is too much to go to stable branch.

+1

> 
> One idea for backport, perhaps?
> 
> https://patches.dpdk.org/project/dpdk/patch/20241119155723.2307189-1-bruce.richardson@intel.com/

ack

> 

