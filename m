Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73042FF885D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6979F402A3;
	Tue, 28 Apr 2026 09:44:21 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 3512F40285
 for <dev@dpdk.org>; Tue, 28 Apr 2026 09:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru AFBAA50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1777362256;
 bh=uGeLtTjn1AFMJH9kEQJAn/zWE2O7xpjF5ctXoeGLhWo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=HcFvpau75wbxSb9eO2KXaYtJ91YW5mT7JgiYjzMN+n7ulOZPGIwEApPePH4YU2w3U
 sLPKuEZh9Cb0jJE++sZ8CiY9GlayOlDjJ6xpVturgLZIN8y8wXRFFsJ7ataxUk08d9
 M57llXwKuWRA8zAsyqb00/sx9TCFBZg+7ygAk/dk=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id AFBAA50;
 Tue, 28 Apr 2026 10:44:16 +0300 (MSK)
Message-ID: <af656761-32ce-4dd4-b400-829eac5662bf@oktetlabs.ru>
Date: Tue, 28 Apr 2026 10:44:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mempool: improve cache behaviour and performance
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260419095526.39526-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/19/26 12:55 PM, Morten Brørup wrote:
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
> 
> As a consequence of the improved mempool cache algorithm, some drivers
> were updated accordingly:
> - The Intel idpf PMD was updated regarding how much to backfill the
>    mempool cache in the AVX512 code.
> - The NXP dpaa and dpaa2 mempool drivers were updated to not set the
>    mempool cache flush threshold; doing this no longer has any effect, and
>    thus became superfluous.
> 
> Bugzilla ID: 1027
> Fixes: ea5dd2744b90 ("mempool: cache optimisations")
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> Depends-on: patch-163181 ("net/intel: do not bypass mbuf lib for mbuf fast-free")

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

