Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF72C021B2
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 01:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8EFF402A8;
	Fri, 21 Feb 2025 02:16:33 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 07EAF4026D
 for <dev@dpdk.org>; Fri, 21 Feb 2025 02:16:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YzXH350RrzRxwT;
 Fri, 21 Feb 2025 09:14:55 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
 by mail.maildlp.com (Postfix) with ESMTPS id 4EE5314011B;
 Fri, 21 Feb 2025 09:16:28 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 09:16:28 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Feb
 2025 09:16:27 +0800
Message-ID: <a4a62bed-4280-cd3d-9c75-c46e80ac6e10@huawei.com>
Date: Fri, 21 Feb 2025 09:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] app/testpmd: fix fail to set queue number when attach
 device
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <songx.jiale@intel.com>, <liuyonglong@huawei.com>
References: <20250218113156.7174-1-lihuisong@huawei.com>
 <20250220125605.60807aa6@hermes.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250220125605.60807aa6@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


在 2025/2/21 4:56, Stephen Hemminger 写道:
> On Tue, 18 Feb 2025 19:31:56 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> Testpmd doesn't modify the Rx/Tx queue number of all ports after attach a
>> new device. The root cause is that "port config all rxq <value>" would
>> check if all ports are stopped and the status of this port is still in
>> 'RTE_PORT_HANDLING'. This status is changed to 'RTE_PORT_STOPPED' in
>> setup_attached_port() when start port.
>>
>> In addition, this new port needs to be initialized in advance because these
>> information are depanded on many commands. Otherwise other commands like
>> "port config xxx" may also encounter similar issue. But the initialization
>> can't be in new event callback as discussed in following commit. So this
>> patch moves setup_attached_port() to the time point 100ms after received
>> the new event.
>>
>> Bugzilla ID: 1663
>> Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple process")
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
> Applied to next-net with some rewording of commit message to improve grammar.
> Should this patch be cc to stable since it has a Fixes tag?
No need to cc to stable because above Fixes is just in this 25.03 version.
> .
