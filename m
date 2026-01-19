Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F2C9830C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 01:21:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAEDB40696;
	Mon, 19 Jan 2026 02:21:32 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id DA26C4025A;
 Mon, 19 Jan 2026 02:21:31 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=n07BF+VJX8WhMCxG+zkvHd7Hcftd1I6cXRMaCTiQ95k=;
 b=kclyoM96BTLBF0s1tpSTyKQh4+0FoIWc0x8elhSpbPpgUrpSiKnAg6p3KeB9liPkTcnL2PCkG
 LwaH5bU/DN4GxcumzaBKosm/dxWKp4n+RbIgDHJaiKXYvszrbeMjjHfYeepesKGR2egCMQrZToA
 wDdYqhCcSW8Dd0hexxz8uUQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dvXdV63ZkzKm77;
 Mon, 19 Jan 2026 09:18:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E295940565;
 Mon, 19 Jan 2026 09:21:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:21:29 +0800
Message-ID: <b544e5fe-c3f2-4350-b11d-a70564f74f72@huawei.com>
Date: Mon, 19 Jan 2026 09:21:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Ciara Power <ciara.power@intel.com>
CC: <stable@dpdk.org>
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260108105036.1341037-2-rjarry@redhat.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 1/8/2026 6:50 PM, Robin Jarry wrote:
> Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> is not supported by rte_tel_data_add_array_container. It wrongfully
> returns -EINVAL where it should allow it.
> 
> This is supported by the JSON formatter.
> 
> Allow the same value types than rte_tel_data_add_dict_container().
> 
> Add test case to verify it works as expected.
> 
> Fixes: c933bb5177ca ("telemetry: support array values in data object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

