Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB5104C007
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA1D4067C;
	Wed, 11 Mar 2026 11:57:53 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id F09FF40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:57:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru D095444
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1773226671;
 bh=9lK5csVJFQ2BSORim6y7hc0m/TLQBPeL/V9bGpMu0MQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=uudYCqCrlk13UhJmyEBR2UGSFkGFEbqmDlDyuipmC8/Di0wkDa2SoZxKAqCoqx4PS
 +Ss3GMiGE0smIQMyQPWooaM3N7oi/KiDR8f9UXOq0VpvSHVGKsX0DtmOaj/Ah+mpN4
 xz1frpHX3Ta+sZLY4vnAWnIQkkNi44R9gzKyZA6c=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id D095444;
 Wed, 11 Mar 2026 13:57:50 +0300 (MSK)
Message-ID: <c4803a29-f156-4a89-914f-09a26042c70b@oktetlabs.ru>
Date: Wed, 11 Mar 2026 13:57:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mempool name size incorrect?
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
References: <98CBD80474FA8B44BF855DF32C47DC35F65773@smartserver.smartshare.dk>
 <f8381c90-d73c-446c-bb2f-2fe3bc921714@oktetlabs.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65777@smartserver.smartshare.dk>
 <144d8fcf192645e3aa240fc43d85097c@huawei.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <144d8fcf192645e3aa240fc43d85097c@huawei.com>
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

On 3/11/26 1:52 PM, Konstantin Ananyev wrote:
> 
> 
>>> On 3/10/26 5:10 PM, Morten Brørup wrote:
>>>> Isn't the RTE_MEMPOOL_NAMESIZE too short?
>>>>
>>>> Looking at the names sizes:
>>>>
>>>> RTE_MEMZONE_NAMESIZE = 32,
>>>> RTE_RING_NAMESIZE = RTE_MEMZONE_NAMESIZE - (sizeof("RG_")=4) + 1 =
>>> 29,
>>>> RTE_MEMPOOL_NAMESIZE = RTE_RING_NAMESIZE - (sizeof("MP_")=4) + 1 =
>> 26
>>>>
>>>> Referring to [1], I think it should be fixed as:
>>>> - #define RTE_MEMPOOL_NAMESIZE (RTE_RING_NAMESIZE - \
>>>> 			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
>>>> + #define RTE_MEMPOOL_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
>>>> 			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
>>>>
>>>> There is no ring involved, so I guess it is some kind of copy-paste-
>>> search-replace error.
>>>>
>>>
>>> I guess ring is involved in fact since the default mempool driver is
>>> ring.
>>>
>>> See drivers/mempool/ring/rte_mempool_ring.c ring_alloc().
>>>
>>> Yes, it is not ideal, but at least it explains why RTE_RING_NAMESIZE
>>> is used.
>>
>> Thanks, that explains it. Bad layer violation...
>> Let's hope no future mempool driver adds anything longer than "RG_" to the
>> name of any memzone it creates.
>>
>> Looking into the associated string length checks, using a too long name will fail
>> with ENAMETOOLONG.
>> So, using a long mempool name might succeed with some mempool drivers and
>> fail with others. :-(
>>
>> I guess there's no simple fix for that.
>> And I was wrong to think that the RTE_MEMPOOL_NAMESIZE should be
>> increased from 26 to 29.
> 
> As a generic thought: might be it is time to make the length across these
> structs (mempool, ring, etc.) arbitrary?
> At our next big API breakage or so.

Why not, if it is really required

> 
>>>
>>>>
>>>> Looking at the rte_mempool structure [2]:
>>>> struct __rte_cache_aligned rte_mempool {
>>>> 	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
>>>> 	union {
>>>> 		void *pool_data;         /**< Ring or pool to store
>>> objects. */
>>>> 		uint64_t pool_id;        /**< External mempool identifier.
>>> */
>>>> 	};
>>>>
>>>>
>>>> Due to the 8-byte alignment of the pool_id field following the name
>>> field, fixing the length as suggested doesn't change the memory layout
>>> for 64 bit CPU architectures.
>>>> But it does for 32 bit CPU architectures, which will only 4-byte
>>> align the pool_id field.
>>>>
>>>> [1]: https://elixir.bootlin.com/dpdk/v26.03-
>>> rc1/source/lib/mempool/rte_mempool.h#L128
>>>> [2]: https://elixir.bootlin.com/dpdk/v26.03-
>>> rc1/source/lib/mempool/rte_mempool.h#L230
>>>>
>>>>
>>>> Another thing:
>>>> On 32 bit CPU architectures, the cache_size and local_cache fields in
>>> the rte_mempool structure are not in the same cache line.
>>>> But I guess we don't really care about 32 bit CPU architectures.
>>>>
>>>>
>>>> Venlig hilsen / Kind regards,
>>>> -Morten Brørup
>>>>
> 

