Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ABCD6E42
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:20:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 614FE40678;
	Thu, 13 Nov 2025 13:20:29 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 7FCB140151;
 Thu, 13 Nov 2025 13:20:28 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/WeJ4i2HI3TEOgguiceI0wCmTs0m46vNnoa9NggvoyI=;
 b=Uw+V8XAJHKuX8LIJt6NMIkihlWlzmK5G3G3+yBHctY0s6cAnvs5+e/VvAIqjetzegT3emAf6P
 6TuQVuO3ejB5vG1e6aqKaR7qItluAQAXmWyu06156/tqN5ZosSk/YpPwRrzeRIRp7s5C2xvqzmh
 vv0gllN00a0qjZXRoDuFtZ0=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6fSv48YwznTVN;
 Thu, 13 Nov 2025 20:18:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D92B140155;
 Thu, 13 Nov 2025 20:20:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 20:20:25 +0800
Message-ID: <64ed8763-22bf-4048-9b9c-b2911a46aa91@huawei.com>
Date: Thu, 13 Nov 2025 20:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
 header
To: "Ye, MingjinX" <mingjinx.ye@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
 <20251105024724.830304-2-mingjinx.ye@intel.com>
 <6bf71e03-6492-44d5-8361-c5879f25abf9@huawei.com>
 <LV3PR11MB86016920D48D0E6E7C13C3ECE5CCA@LV3PR11MB8601.namprd11.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <LV3PR11MB86016920D48D0E6E7C13C3ECE5CCA@LV3PR11MB8601.namprd11.prod.outlook.com>
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

Hi Mingjin,

We have reproduce this bug in our platform, and trying to fix the solution.

Thanks

On 11/12/2025 5:01 PM, Ye, MingjinX wrote:
> Hi Chengwen,
> 
> Please refer to Bugzilla for more information.
> Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=1813
> 
> Thanks~
> 
>> -----Original Message-----
>> From: fengchengwen <fengchengwen@huawei.com>
>> Sent: Monday, November 10, 2025 5:56 PM
>> To: Ye, MingjinX <mingjinx.ye@intel.com>; dev@dpdk.org
>> Cc: stable@dpdk.org; Singh, Aman Deep <aman.deep.singh@intel.com>
>> Subject: Re: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
>> header
>>
>> Hi Mingjin,
>>
>> Could you please detail the step of testcase? we will try to reproduce it and
>> see how to solve it.
>>
>> Thanks.
>>
>> On 11/5/2025 10:47 AM, Mingjin Ye wrote:
>>> This reverts commit 496159613ffc7b6ba592432a1ba4d1a38f6935de.
>>>
>>> When the TX IP checksum offload feature is enabled, it may result in
>>> internal UDP checksum errors in VXLAN tunnel packets.
>>>
>>> Fixes: 496159613ffc ("app/testpmd: fix L4 protocol retrieval from L3
>>> header")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> 

