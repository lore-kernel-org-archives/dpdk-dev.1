Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83022C369C2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 03:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB624025A;
	Thu, 17 Apr 2025 05:14:40 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id B1003400D5;
 Thu, 17 Apr 2025 05:14:38 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZdNKb0FVfzsSqR;
 Thu, 17 Apr 2025 11:14:27 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A2AD1400DD;
 Thu, 17 Apr 2025 11:14:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 11:14:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Apr
 2025 11:14:35 +0800
Message-ID: <9022ed7f-8aa1-4a03-90d5-1ebec97ca723@huawei.com>
Date: Thu, 17 Apr 2025 11:14:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/13] app/testpmd: revert auto attach/detach
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Dongdong Liu
 <liudongdong3@huawei.com>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-2-stephen@networkplumber.org>
 <89e4321b-4a28-400a-b54b-b723de2f6730@huawei.com>
 <20250415170628.44bbfac7@hermes.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250415170628.44bbfac7@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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


在 2025/4/16 8:06, Stephen Hemminger 写道:
> On Tue, 15 Apr 2025 21:28:07 +0800
> "lihuisong (C)" <lihuisong@huawei.com> wrote:
>
>> Hi Stephen,
>>
>> The main cause of cpfl driver attach failure is the added alarm in new
>> event callback to setup port automatically.
>> It's a question of when to set up the new port. Please see the
>> discussion[1]. I have a stupid method, but I'm not very willing to do that.
>> For the Bugzilla id1695, I'll take a look at it.
>>
>> [1] https://bugs.dpdk.org/show_bug.cgi?id=1671
>>
> For now I am going to revert the testpmd change.
> Come back when you have something that works without breaking pdump application.
ok
