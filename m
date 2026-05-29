Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08481CD6E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 08:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 089BB4021E;
	Fri, 29 May 2026 10:54:02 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id E8C2D400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 10:53:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=U9DKpqWN+aOKbX6+ff8PApQLVTnTNJ7/moU6uWU6L2U=;
 b=EIrQQZl6A1VOEB2iawYwEQcSThLdlbVAhSFKOPa+/OuNmrdulnbAlLbrrLl6NoXkTJ1sFjVLa
 DvX4izKLiRha6Qwu/E5bcyQJhw016IFn85Ts5A2xFbTJSwjl1IgneO0dDPmvYH4M4eg47FuXdra
 b8Eao5keFcGePADnP1v0aJQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gRcQK2gw2znTVf;
 Fri, 29 May 2026 16:46:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5DD6F4048B;
 Fri, 29 May 2026 16:53:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 16:53:56 +0800
Message-ID: <9b627380-0fc4-40b8-b927-c443a7bbba1b@huawei.com>
Date: Fri, 29 May 2026 16:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mempool: improve cache behaviour and performance
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Bruce Richardson
 <bruce.richardson@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, Praveen
 Shetty <praveen.shetty@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260526140000.175092-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260526140000.175092-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 5/26/2026 10:00 PM, Morten Brørup wrote:
> This patch refactors the mempool cache to eliminate some unexpected
> behaviour and reduce the mempool cache miss rate.
> 
> 1.
> The actual cache size was 1.5 times the cache size specified at run-time
> mempool creation.
> This was obviously not expected by application developers.
> 
> 2.
> In get operations, the check for when to use the cache as bounce buffer
> did not respect the run-time configured cache size,
> but compared to the build time maximum possible cache size
> (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> E.g. with a configured cache size of 32 objects, getting 256 objects
> would first fetch 32 + 256 = 288 objects into the cache,
> and then move the 256 objects from the cache to the destination memory,
> instead of fetching the 256 objects directly to the destination memory.
> This had a performance cost.
> However, this is unlikely to occur in real applications, so it is not
> important in itself.
> 
> 3.
> When putting objects into a mempool, and the mempool cache did not have
> free space for so many objects,
> the cache was flushed completely, and the new objects were then put into
> the cache.
> I.e. the cache drain level was zero.
> This (complete cache flush) meant that a subsequent get operation (with
> the same number of objects) completely emptied the cache,
> so another subsequent get operation required replenishing the cache.
> 
> Similarly,
> When getting objects from a mempool, and the mempool cache did not hold so
> many objects,
> the cache was replenished to cache->size + remaining objects,
> and then (the remaining part of) the requested objects were fetched via
> the cache,
> which left the cache filled (to cache->size) at completion.
> I.e. the cache refill level was cache->size (plus some, depending on
> request size).
> 
> (1) was improved by generally comparing to cache->size instead of
> cache->flushthresh, when considering the capacity of the cache.
> The cache->flushthresh field is kept for API/ABI compatibility purposes,
> and initialized to cache->size instead of cache->size * 1.5.
> 
> (2) was improved by generally comparing to cache->size / 2 instead of
> RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.
> 
> (3) was improved by flushing and replenishing the cache by half its size,
> so a flush/refill can be followed randomly by get or put requests.
> This also reduced the number of objects in each flush/refill operation.
> 
> As a consequence of these changes, the size of the array holding the
> objects in the cache (cache->objs[]) no longer needs to be
> 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
> RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.
> 
> Performance data:
> With a real WAN Optimization application, where the number of allocated
> packets varies (as they are held in e.g. shaper queues), the mempool
> cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> This was deployed in production at an ISP, and using an effective cache
> size of 384 objects.

Does the application run as a RTC (run-to-complete) mode?
How about pipeline model which NIC recv packets and enqueue ring, another
work thread dequeue packets, process packets and then free packets mbuf?


