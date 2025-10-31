Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1CCCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 09:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F407A402F1;
	Fri, 31 Oct 2025 10:18:29 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id D680040395;
 Fri, 31 Oct 2025 10:18:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=A58u35Qjpgh5gULV1mUAzHoJhJm0n1zJ6ae3aOsojik=;
 b=LQIGDqRGlb8SkocFbhlmvxu+D8BBeO65GRwmq0rISHGZGwdwwSLRr2wGtClObWDJgfJXHbn6i
 /P723+ciUwEJwuaYd89y7QppZjz1kaB5dhLS69gcnx2RPKMosSx/2iiuEtnRVS4DKn0Wj8MGoYt
 hT0QMpPcim7eXG84j4meOfE=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyb436HvxzKm4k;
 Fri, 31 Oct 2025 17:17:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D341F1401E9;
 Fri, 31 Oct 2025 17:18:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Oct 2025 17:18:25 +0800
Message-ID: <81d70c4e-aa4b-482e-a708-be477ed22f5b@huawei.com>
Date: Fri, 31 Oct 2025 17:18:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
To: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>, Pavan Nikhilesh
 Bhagavatula <pbhagavatula@marvell.com>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Ande, Venkat Kumar"
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <PH0PR18MB40861D909AD3BC9A0695309ADE6AA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <CH3PR12MB8233DABD201A97C7A71D8D2C86EEA@CH3PR12MB8233.namprd12.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CH3PR12MB8233DABD201A97C7A71D8D2C86EEA@CH3PR12MB8233.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Hi Sivaprasad,

Are you going to send v3 (add log) version?

There is another patch about adjust burst size [1], if this patch
don't continue, maybe we should restart that one.

[1] https://patchwork.dpdk.org/project/dpdk/patch/20241204020622.977156-1-haijie1@huawei.com/

Thanks

On 10/9/2025 10:32 AM, Tummala, Sivaprasad wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Pavan,
> 
> Please find my response inline.
> 
> ________________________________
> From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
> Sent: Tuesday, June 10, 2025 7:59 PM
> To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; david.hunt@intel.com <david.hunt@intel.com>; anatoly.burakov@intel.com <anatoly.burakov@intel.com>; Jerin Jacob <jerinj@marvell.com>; radu.nicolau@intel.com <radu.nicolau@intel.com>; Akhil Goyal <gakhil@marvell.com>; cristian.dumitrescu@intel.com <cristian.dumitrescu@intel.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>; konstantin.ananyev@huawei.com <konstantin.ananyev@huawei.com>; mb@smartsharesystems.com <mb@smartsharesystems.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; haijie1@huawei.com <haijie1@huawei.com>; stable@dpdk.org <stable@dpdk.org>; Ande, Venkat Kumar <VenkatKumar.Ande@amd.com>; Dengdui Huang <huangdengdui@huawei.com>
> Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based on Rx burst
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>>> Previously, the TX burst size was fixed at 256, leading to performance
>>> degradation in certain scenarios.
>>>
>>> This patch introduces logic to set the TX burst size to match the
>>> configured RX burst size (--burst option, default 32, max 512)
>>> for better efficiency.
>>>
>>> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
>>> Cc: haijie1@huawei.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>> Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
>>> Tested-by: Dengdui Huang <huangdengdui@huawei.com>
> 
>> It would be good if the selected burst sizes of Rx and Tx are logged.
> ACK
> 
>> On CN10K platform we see upto 5% improvement, and upto 30% improvement on CN9K.
> 
>> Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
>> ---
>> examples/l3fwd/l3fwd.h        |  8 ++------
>> examples/l3fwd/l3fwd_common.h | 11 +++++++----
>> examples/l3fwd/main.c         |  2 ++
>> 3 files changed, 11 insertions(+), 10 deletions(-)
> 
> 

