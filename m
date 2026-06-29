Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27825C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 00:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2E4E4021E;
	Mon, 29 Jun 2026 02:36:37 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id B6647400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:36:36 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oFRXix7OH0HF+lvqznQJ8RzkVNbbR018OLeEhx/MG4M=;
 b=08VtKQX/jhj26uO9RERKUtTwLfycLU7QWLrPl6vydsa6Aef3M4pur46uxnFcu8Vj0c1uk3Th9
 BluwWDDJWHEONB3JqkdWKim9r1kw5GOykEIPPz9YJ7jeMx3vpe9l7bhLDv3Bm3CtmN2rF5QtByi
 Jwlg3eA0dzq85BrTi8/RXm8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gpRv62TxWz1T566;
 Mon, 29 Jun 2026 08:27:46 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id B81884057D;
 Mon, 29 Jun 2026 08:36:33 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 08:36:33 +0800
Message-ID: <b44debc5-6b7b-453e-b871-bc010cd7fc81@huawei.com>
Date: Mon, 29 Jun 2026 08:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dma/ae4dma: add control path operations
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>,
 <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-3-raghavendra.ningoji@amd.com>
 <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
 <20260628090451.19970403@phoenix.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260628090451.19970403@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 6/29/2026 12:04 AM, Stephen Hemminger wrote:
> On Sat, 27 Jun 2026 08:09:09 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>>>  
>>> +static int
>>> +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
>>> +		const struct rte_dma_conf *dev_conf,
>>> +		uint32_t conf_sz)
>>> +{
>>> +	if (sizeof(struct rte_dma_conf) != conf_sz)
>>> +		return -EINVAL;  
>>
>> This may break ABI compatible
> 
> Ignore that suggestion. This is a reasonable way to handle new configuration
> functions. You need/want a minimal set of values. If rte_dma_conf grows in size
> then the code can add compatability; by requiring a minimum set of values
> and then setting the rest to zero.
> 
> Something like
> 
> static int
> ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
> 		const struct rte_dma_conf *dev_conf,
> 		size_t conf_sz)
> {
> 	if (conf_sz < sizeof(struct orig_rte_dma_conf))
> 		return -EINVAL;

+1 for this

> 
> 	struct rte_dma_conf conf;
> 	memcpy(&conf, dev_conf, RTE_MIN(conf_sz, sizeof(conf)));
>         dev_conf = &conf;
> 
> Looking at rte_dma_conf the structure has holes and dmadev lib
> doesn't validate undefined flags, so it already has future ABI problems.

Yes, it indeed
