Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAD5C369D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 01:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6028E402A3;
	Tue, 29 Apr 2025 03:14:56 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 42F904026C
 for <dev@dpdk.org>; Tue, 29 Apr 2025 03:14:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zmj2008rDzLpdg;
 Tue, 29 Apr 2025 09:11:20 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 28C7A18047D;
 Tue, 29 Apr 2025 09:14:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 09:14:51 +0800
Message-ID: <15eea4ec-08d0-4b1a-92dc-a8dd7945d539@huawei.com>
Date: Tue, 29 Apr 2025 09:14:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add one example of DPI ?
To: Stephen Hemminger <stephen@networkplumber.org>
CC: thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
References: <2c503191-c235-4fbc-ae7a-d21dbe83d2a7@huawei.com>
 <20250428084901.0aeeee04@hermes.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250428084901.0aeeee04@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2025/4/28 23:49, Stephen Hemminger wrote:
> On Mon, 28 Apr 2025 16:20:22 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> Hi all,
>>
>> Currently, we supported several DPI application scenarios performance tuning,
>> in these scenarios, the DPDK library ethdev, ring, mbuf and hash APIs are used.
>>
>> One of the scenarios is:
>>
>>     ------------------------                           -------------------------
>>     |                      |       rte_ring-0          |                       |
>>     |  packet-recv-process | ===>  rte_ring-1  ===>    | packet-detect-process |
>>     |                      |         ...               |                       |
>>     |                      |       rte_ring-n          |                       |
>>     ------------------------                           -------------------------
>>
>>     packet-recv-process dispatch flow to different rings by such 'rte_hash_crc' function.
>>     packet-detect-process build flow context based on rte_hash library.
>>
>> I think it is necessary to add a DPI example to show that DPDK has the basic
>> capability of building DPI applications and provides best performance practices.
>>
>> Hope to listen to the community's opinions.
>>
>> Thanks
>>
> 
> Did you consider the impact of CPU cache on this scenario.
> When you process the packet in two different threads, it ends up adding
> an additional data cache miss which can cut performance in half.

Yes, this model has the cache problem (it did has performance loss, but not so much). Let assume that this model is A.

Another scenarios (this model is cache friendly) is:
     --------------------------
     |                        |
     |  packet-detect-process |
     |                        |
     |  packet-recv-process   |
     |                        |
     --------------------------
         |  multi-queues  |
     --------------------------
     |   hardware-RSS         |
     --------------------------
   The NIC hardware dispatch flow to different hardware queues by RSS.
   Each threads in the process then receive and detect.
   Let assume this model is B.

Currently, there are many traffic encapsulation formats, but the NIC RSS hash always very simple (more complex
can be implemented throught flow matching, but many NICs do not support this feature). In this case, the model
A could be used, the software could dispatch flow by user-defined.

I think this example could both support the above two model.

