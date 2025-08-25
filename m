Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC06CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 06:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 561F24025E;
	Mon, 25 Aug 2025 08:05:31 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id D94F44025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:05:29 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 78E191CCBD
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:05:29 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 6CFA41CD1E; Mon, 25 Aug 2025 08:05:29 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 0B4D81CCBC;
 Mon, 25 Aug 2025 08:05:26 +0200 (CEST)
Message-ID: <b283e922-365c-45c7-9282-94b92067641f@lysator.liu.se>
Date: Mon, 25 Aug 2025 08:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] hash: add support for common small key sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-4-stephen@networkplumber.org>
 <5427c6f3-4446-4ee3-909e-5f2925d2b286@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE61@smartserver.smartshare.dk>
 <90ad6122-467c-441d-8515-c043146a8a57@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE63@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE63@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-08-22 20:57, Morten Brørup wrote:
>>>>> +static inline int
>>>>> +rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len
>>>> __rte_unused)
>>>>> +{
>>>>> +	const uint16_t *k1 = key1;
>>>>> +	const uint16_t *k2 = key2;
>>>>> +
>>>>
>>>> What we do now is to require the keys are 16-bit aligned (which wasn't
>>>> the case before).
>>>>
>>>> You could
>>>>
>>>> uint16_t k1;
>>>> memcpy(&k1, key1, sizeof(uint16_t));
>>>> instead.
>>>>
>>>> Would generate the same code, but be safe from any future alignment issues.
>>>
>>> Or use the unaligned types, e.g.:
>>> 	const unaligned_uint16_t *k1 = key1;
>>> 	const unaligned_uint16_t *k2 = key2;
>>>
>>
>> Could you explain why that is safe? Doesn't
>> __attribute__((__aligned__(1)))
>> just say specify the object doesn't have any alignment requirements,
>> without asking the compiler to deal with it?
> 
> It is safe because the compiler does deal with it.
> Here's a simple example:
> https://godbolt.org/z/r39zdeEcx
> 

I see. Thanks!

> I don't know how MSVC deals with it, but it doesn't support alignment sensitive architectures, so no real problem.
> 
>>
>>>>
>>>> Anyway, maybe it's safe to assume the keys are aligned, so this is not
>>>> an issue.
>>>
>>> Lots of DPDK code ignores alignment issues.
>>>
>>>>
>>>>> +	return k1[0] ^ k2[0];
>>>>> +}
>>>>
>>>> Haven't you implemented "neq" rather than "eq" here? If the keys are
>>>> equal, the result is 0. Should be != 0.
>>>
>>> Not a bug.
>>
>> Well, the function body doesn't do what the function name tells it. :)
> 
> Agree. They really should be renamed to _cmp_neq.
> And _cmp_eq wrappers could be kept for backwards API compatibility. Possibly marked deprecated.
> 
>>
>>> These hash compare functions are in fact "neq", not "eq".
>>> Having "_cmp_eq" in the function names is extremely unfortunate and
>> misleading.
>>>
>>>>
>>>> Would it be worth adding a comment like "use XOR to make this
>>>> branch-free"? It may not be obvious to all readers.
>>>>
>>>> That said, I’m not sure this trick will actually change the generated
>>>> object code - especially if the result of the eq function is still used
>>>> in a conditional afterward. Anyway, keeping it seems like a good
>>>> conservative approach.
>>>
>>> I wonder if any compiler is clever enough to use a different memcmp
>> implementation if we inform the compiler at build time that we don't care if
>> key1 is less than or greater key2, only if they differ or not.
>>
>> All what is needed is a constant-size length. (Only tested with the most
>> recent GCC and clang.)
> 
> Yes. But that was not what I was thinking about... I was wondering if "memcmp()!=0" compiles to code that calls some other memcmp implementation that doesn't check which of the two strings is lower, but only tests if they differ.
> 

I don't think so. On GCC 15.2 at least, for non-constant buffer lengths, 
glibc memcmp() will always be invoked.

>>
>> At least GCC will emit a cmp instruction though (so not branch free), if
>> that matters.
>>
>>> If so, the OTHER_BYTES handler shouldn't call memcmp() directly, but a
>> wrapper around it:
>>>
>>> rte_hash_k_cmp_eq(const void *key1, const void *key2, size_t key_len
>> __rte_unused)
>>> {
>>> 	return memcmp(key1, key2, key_len) != 0;
>>> }
>>>
>>
>> Should work. (Remove __rte_unused.)
> 
> I just tested it in Compiler Explorer, and the function calls the same memcmp(), regardless of the !=0.
> So no benefit compared to calling memcmp() directly from the jump table.
> 

The rte_hash_k_cmp_eq() must be invoked from some other function, which 
provides a constant key_len, for the magic to happen.

I would keep this function (maybe as __rte_hash_cmp_neq()) for that purpose.

