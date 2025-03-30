Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51373C3600B
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Mar 2025 08:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F2D7402AB;
	Sun, 30 Mar 2025 10:10:00 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 61D1A402A4
 for <dev@dpdk.org>; Sun, 30 Mar 2025 10:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 05C4A41
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743322197;
 bh=eTVe9BGVLz5rc4JI1wujSW4Eqq+n5k0YWM8+ZNbpknI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xu47lwo15PUQtDjM6WOEBWhz4nVR53MlsKV2p2489WW2W1H6qyErTaU5ANrIsZC9g
 MNor0tF1BNpAZ9lGf6DNzBn9g7qWpguokgsCmbnUFCtwp7GDjsy0ml/DwvmJyRCJ4g
 Fw+mJXqIl5gcLT7/ky4Z39jExOMEFzHuK2R0RzZI=
Received: from [192.168.1.38] (unknown [188.170.78.30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 05C4A41;
 Sun, 30 Mar 2025 11:09:56 +0300 (MSK)
Message-ID: <e7ff43da-001a-483a-b62c-e819944864ff@oktetlabs.ru>
Date: Sun, 30 Mar 2025 11:09:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: micro optimizations
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
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

On 3/27/25 20:15, Bruce Richardson wrote:
> On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Brørup wrote:
>> The comparisons lcore_id < RTE_MAX_LCORE and lcore_id != LCORE_ID_ANY are
>> equivalent, but the latter compiles to fewer bytes of code space.
>> Similarly for lcore_id >= RTE_MAX_LCORE and lcore_id == LCORE_ID_ANY.
>>
>> The rte_mempool_get_ops() function is also used in the fast path, so
>> RTE_VERIFY() was replaced by RTE_ASSERT().
>>
>> Compilers implicitly consider comparisons of variable == 0 likely, so
>> unlikely() was added to the check for no mempool cache (mp->cache_size ==
>> 0) in the rte_mempool_default_cache() function.
>>
>> The rte_mempool_do_generic_put() function for adding objects to a mempool
>> was refactored as follows:
>> - The comparison for the request itself being too big, which is considered
>>    unlikely, was moved down and out of the code path where the cache has
>>    sufficient room for the added objects, which is considered the most
>>    likely code path.
>> - Added __rte_assume() about the cache length, size and threshold, for
>>    compiler optimization when "n" is compile time constant.
>> - Added __rte_assume() about "ret" being zero, so other functions using
>>    the value returned by this function can be potentially optimized by the
>>    compiler; especially when it merges multiple sequential code paths of
>>    inlined code depending on the return value being either zero or
>>    negative.
>> - The refactored source code (with comments) made the separate comment
>>    describing the cache flush/add algorithm superfluous, so it was removed.
>>
>> A few more likely()/unlikely() were added.
> 
> In general not a big fan of using likely/unlikely, but if they give a perf
> benefit, we should probably take them.
> 
> Few more comments inline below.
> 
>> A few comments were improved for readability.
>>
>> Some assertions, RTE_ASSERT(), were added. Most importantly to assert that
>> the return values of the mempool drivers' enqueue and dequeue operations
>> are API compliant, i.e. 0 (for success) or negative (for failure), and
>> never positive.
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>


Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
