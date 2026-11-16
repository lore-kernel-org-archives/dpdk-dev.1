Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6659606A332
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=foss.arm.com header.i=@foss.arm.com header.a=rsa-sha256 header.s=main header.b=rpNgEN+c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2309040150;
	Mon, 16 Nov 2026 15:09:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 063BB400EF;
 Mon, 16 Nov 2026 15:09:08 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164001A25;
 Mon, 16 Nov 2026 06:09:00 -0800 (PST)
Received: from [10.2.197.124] (KDFJ2LQKPJ.cambridge.arm.com [10.2.197.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8E13F763;
 Mon, 16 Nov 2026 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1794838143; bh=LelRC23jPuN2SadUCcJtRjL9RDPFcvzrg+isGOdobpM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rpNgEN+cqibnrItHDVkwtEaJq2d9fhn9MbCf8R7Q9QrmhRlCfGG24kZH9jsjtsks2
 7p8fc+/ISfrC2GgzOyZZ7uyBDBBsIHMKrobYAxC20ySNraq0drVLnGAbGddtO5tYXG
 MOz8xRi85EDBOzwSzfEWiwBM+CX45MbDcBFskjck=
Message-ID: <50581e90-ba05-40cc-89e5-004be6690284@foss.arm.com>
Date: Mon, 16 Nov 2026 14:09:00 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bitops: fix integer overflow in align64pow2
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bulatov Mark <ms.bulatov7@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Alexey Simakov <bigalex934@gmail.com>
References: <20261113141307.4727-1-ms.bulatov7@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65B0C@smartserver.smartshare.dk>
Content-Language: en-GB
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65B0C@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 18:07, Morten Brørup wrote:
>> If the function rte_combine64ms1b() returns the maximum possible
>> uint64_t
>> value, it will result in an overflow.
>>
>> To avoid this, add a check.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 7253e3d2a5 ("bitops: move bit count functions")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
>> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
>> ---
>>   lib/eal/include/rte_bitops.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/eal/include/rte_bitops.h
>> b/lib/eal/include/rte_bitops.h
>> index 45255b68aa..d2ed0c3c61 100644
>> --- a/lib/eal/include/rte_bitops.h
>> +++ b/lib/eal/include/rte_bitops.h
>> @@ -1307,6 +1307,9 @@ rte_align64pow2(uint64_t v)
>>   	v--;
>>   	v = rte_combine64ms1b(v);
>>
>> +	if (v == UINT64_MAX)
>> +		v--;
>> +
>>   	return v + 1;
>>   }
> 
> NAK.
> 
> The overflow bug is present, also in rte_align32pow2().
> 
> But the fix is wrong; it does not return a power-of-two value.
> 
> There is no solution to fix this overflow.
> The only possible fix is to specify in the function documentation that the parameter must not exceed 1 << 63 (0x8000000000000000).
> 
> -Morten

You are right Morten, sorry about that. No point avoiding the overflow 
if the return value doesn't even fulfil the purpose of the function 
itself. Also, I realised the provided fix would change the behaviour for 
the input value of 0 - currently this returns 0, but with this patch it 
would return UINT64_MAX.

I guess the change should look something like this:
-----

[PATCH] bitops: document input value range for rte_align[32,64]pow2

rte_align32pow2 and rte_align62pow2 will overflow and return incorrect
values for input values exceeding 1<<31 and 1<<63, respectively. There
is no way to return a valid result here: the next power of two above
these values is unrepresentable with 32/64 bit unsigned integers.

Adjust the documentation for these functions to clarify that input
values above these limits will return invalid results, and thus should
not be provided to these functions. Additionally, document an existing
edge case of the implementation: when the input is 0, it returns 0 (not
a power of 2).
---
  lib/eal/include/rte_bitops.h | 22 ++++++++++++++++++----
  1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index 45255b68aa..59dcf1e028 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1261,10 +1261,17 @@ rte_is_power_of_2(uint32_t n)
   * Aligns input parameter to the next power of 2
   *
   * @param x
- *   The integer value to align
+ *   The integer value to align. Must be less than or equal to 1 << 31
+ *   (0x80000000).
   *
   * @return
- *   The smallest power of 2 which is greater than or equal to @c x.
+ *   The smallest power of 2 which is greater than or equal to @c x, or 
0 if
+ *   @c v is 0.
+ *
+ * @note If the input parameter exceeds 1 << 31 (0x80000000), then the 
expected
+ *       result is unrepresentable and the return value is invalid.
+ * @note For the input value 0, this function returns 0, which is not a 
power of
+ *       2.
   */
  static inline uint32_t
  rte_align32pow2(uint32_t x)
@@ -1296,10 +1303,17 @@ rte_align32prevpow2(uint32_t x)
   * Aligns 64b input parameter to the next power of 2
   *
   * @param v
- *   The 64b value to align
+ *   The 64b value to align. Must be less than or equal to 1 << 63
+ *   (0x8000000000000000).
   *
   * @return
- *   The smallest power of 2 which is greater than or equal to @c v.
+ *   The smallest power of 2 which is greater than or equal to @c v, or 
0 if
+ *   @c v is 0.
+ *
+ * @note If the input parameter exceeds 1 << 63 (0x8000000000000000), 
then the
+ *       expected result is unrepresentable and the return value is 
invalid.
+ * @note For the input value 0, this function returns 0, which is not a 
power of
+ *       2.
   */
  static inline uint64_t
  rte_align64pow2(uint64_t v)
-- 
2.43.0
