Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D6ECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 00:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDBC8402D6;
	Wed,  5 Nov 2025 01:43:33 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id BDC0440269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 01:43:32 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=APmyihjAsEb0yoPSTkm/VA2o4EOfJ2BSyO1wMdIT5+I=;
 b=R0EvetZF0DSPqPFeTUWkLmSn2B3jCZUN51YsufoF6jNU9jyG7kG0t2uOFkAVRDg5pS6zf6Rng
 sUoU2KyQBegYEe2UFYSVHv2PlczaPXXsM9Ob6azJlzrxpzTYCuywHnojrMb2yYrVT894u/oNucB
 Vt6Bq8y7j8m5tJeR/KLCb4M=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d1RNL6S0fz12LDS;
 Wed,  5 Nov 2025 08:41:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 998FE1402C4;
 Wed,  5 Nov 2025 08:43:30 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 08:43:30 +0800
Message-ID: <dcb52244-1814-411e-bab3-853fa9665ab8@huawei.com>
Date: Wed, 5 Nov 2025 08:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] testpmd support stop specify lcore
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251104162146.46daf538@phoenix>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104162146.46daf538@phoenix>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 11/5/2025 8:21 AM, Stephen Hemminger wrote:
> On Tue, 4 Nov 2025 12:09:13 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> This patch support stop specify lcore for testpmd, and also include
>> two bugfix which found when test DCB function.
>>
>> Chengwen Feng (3):
>>   app/testpmd: fix invalid txp when setup DCB forward
>>   app/testpmd: fix wrong Rx queues when setup DCB forward
>>   app/testpmd: support stop specify lcore
>>
>>  app/test-pmd/cmdline.c                      | 63 +++++++++++++++++++++
>>  app/test-pmd/config.c                       |  9 +--
>>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
>>  3 files changed, 73 insertions(+), 6 deletions(-)
>>
> 
> If there is a stop lcore, why is there not a command to restart the lcore?

The restart lcore is more complex which include data prepare (init).

But I think could impl such pause / restart function by config fc->stopped a special value:

Current:
	run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
	{
		do {
			forwarding logic
		} while(!fc->stopped);
	}

We could adjust the logic to support pause / restart function:
	run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
	{
	_restart:
		do {
			forwarding logic
		} while(!fc->stopped);
 		while (fc->stopped == 2) {
			nop
		}
		if (fc->stopped == 1)
			return;
		if (fc->stopped == 0)
			// means restart
			goto _restart;
	}
So we could configure fc->stopped = 2 to pause forwarding, and config it to 0 to restart forwarding.

> Looks like this just an optimization for DCB.

Yes, mainly for test the Tx direction's DCB function.

> Could it be handled better by having testpmd not spawn lcores that
> have no queues? 

The lcore spawned by testpmd always has queues. In this patchset, we just stop some queue's forwarding.

> 


