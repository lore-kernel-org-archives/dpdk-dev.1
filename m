Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBFCA5FAD
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 01:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3935C402A2;
	Wed, 30 Sep 2026 03:01:18 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 59542400EF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 03:01:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zjVCmGLC3RSpiCZ6l3P+R3tVrN0x4aiWSA5A6xG52uE=;
 b=K4fBAAEwejE5JKOGVoEGxp1V4UMCzOFMJwxfefW5CLxWSxCHcJi51etEH/DnwTw9x/pweiA/Y
 Pt793A6tLOycEfz3PYppOh4PnJjgFLa00vrG66fppC8oOA2Yy9A0eqqGp9Ye7AU3uSBRXidcxrL
 /L4JgTXNWZPf/t8eU4v9bSc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hvbyn2xrtz1K96s;
 Wed, 30 Sep 2026 08:49:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 106294057C;
 Wed, 30 Sep 2026 09:01:15 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 30 Sep 2026 09:01:14 +0800
Message-ID: <28baf281-2eb8-4b8f-935d-abae4af539c8@huawei.com>
Date: Wed, 30 Sep 2026 09:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/61] kvargs: add a socket ID handler
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
 <20260929163800.1108305-3-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260929163800.1108305-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 9/30/2026 12:36 AM, Stephen Hemminger wrote:
> Device arguments naming a NUMA socket are common, and every driver that
> takes one open codes the same range check against RTE_MAX_NUMA_NODES.
> They do not agree on what the range is: dlb2 accepts RTE_MAX_NUMA_NODES
> itself, and turbo_sw and bbdev_null check only the upper bound, so a
> negative socket id is taken as valid.
> 
> Add a handler for these:
> 
>     rte_kvargs_handle_socket_id
> 
> It stores through an int and accepts -1, which is SOCKET_ID_ANY, through
> RTE_MAX_NUMA_NODES - 1.
> 
> The bound is the compile time maximum rather than the sockets present on
> the running system, which is what the open coded checks used. Validating
> against rte_socket_count() would also make kvargs depend on EAL, which
> depends on kvargs in turn.
> 
> SOCKET_ID_ANY is spelled as a literal -1 rather than included from
> rte_memory.h for the same reason. The value is part of the ABI.
> 
> No handler is added for lcore ids. There is no caller for one: the
> drivers that take a core argument either parse a list, as crypto/scheduler
> does with its coremask, or dispatch many keys through one shared handler,
> as mlx5 does with service_core. One can be added when a user appears.
> 
> Nor is one added for queue ids or queue counts. Those look similar but
> are not: some drivers count from one and others from zero, and the useful
> bound is nearly always a hardware limit well below
> RTE_MAX_QUEUES_PER_PORT, which rte_kvargs_to_uint() already covers.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

