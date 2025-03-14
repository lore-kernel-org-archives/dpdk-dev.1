Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A3C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 11:56:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DD340289;
	Fri, 14 Mar 2025 12:56:24 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 37E6B400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 12:56:23 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id A82841E85B
 for <dev@dpdk.org>; Fri, 14 Mar 2025 12:56:22 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9C4031E7F9; Fri, 14 Mar 2025 12:56:22 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 0BF4E1E7F8;
 Fri, 14 Mar 2025 12:56:19 +0100 (CET)
Message-ID: <225ec43f-40c3-4916-b4a5-62b67e511e91@lysator.liu.se>
Date: Fri, 14 Mar 2025 12:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] eal: add function rte_size_to_str
To: Bruce Richardson <bruce.richardson@intel.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, sameh.gobriel@intel.com, vladimir.medvedkin@intel.com,
 yipeng1.wang@intel.com
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
 <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025-03-13 10:09, Bruce Richardson wrote:
> On Wed, Mar 12, 2025 at 12:28:32PM -0700, Andre Muezerie wrote:
>> It's common to use %' in the printf format specifier to make large numbers
>> more easily readable by having the thousands grouped. However, this
>> grouping does not work on Windows. Therefore, a function is needed to make
>> uint64_t numbers more easily readable. There are at least two tests that
>> can benefit from this new function.
>>
>> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
>> ---
> 
> Thanks Andre, comments inline below.
> 
> /Bruce
> 
>>   lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
>>   lib/eal/include/rte_common.h           | 31 ++++++++++++++++++
>>   lib/eal/version.map                    |  3 ++
>>   3 files changed, 78 insertions(+)
>>
>> diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
>> index 9ca2045b18..4cc7f35652 100644
>> --- a/lib/eal/common/eal_common_string_fns.c
>> +++ b/lib/eal/common/eal_common_string_fns.c
>> @@ -4,6 +4,7 @@
>>   
>>   #include <ctype.h>
>>   #include <errno.h>
>> +#include <inttypes.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   
>> @@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
>>   		endptr++; /* allow 1 space gap */
>>   
>>   	switch (*endptr) {
>> +	case 'E': case 'e':
>> +		size *= 1024; /* fall-through */
>> +	case 'P': case 'p':
>> +		size *= 1024; /* fall-through */
>> +	case 'T': case 't':
>> +		size *= 1024; /* fall-through */
>>   	case 'G': case 'g':
>>   		size *= 1024; /* fall-through */
>>   	case 'M': case 'm':
>> @@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
>>   	}
>>   	return size;
>>   }
>> +
>> +int
>> +rte_size_to_str(char *buf, int buf_size,
>> +		uint64_t count, bool use_iec)
> 
> Minor nit, I don't think you should need to wrap this, we can have lines up
> to 100 chars long.
> 
>> +{
>> +	const char *prefix = "kMGTPE";
> 
> Why is "k" in lower case compared to the others all in upper-case?

That's how International Bureau of Weights and Measures likes it, 
although they keep them a factor 1000 and not 1024 apart.

https://www.bipm.org/documents/20126/41483022/SI-Brochure-9-EN.pdf

Page 143, table 7.

> Also, these are suffixes not prefixes. :-)
> 
>> +	const unsigned int base = use_iec ? 1024 : 1000;
>> +	uint64_t powi = 1;
>> +	uint16_t powj = 1;
>> +	uint8_t precision = 2;
>> +
>> +	if (count < base)
>> +		return snprintf(buf, buf_size, "%"PRIu64" ", count);
>> +
>> +	/* increase value by a factor of 1000/1024 and store
>> +	 * if result is something a human can read
>> +	 */
>> +	for (;;) {
>> +		powi *= base;
>> +		if (count / base < powi)
> 
> This would seem more logical to me as "count / powi < base" since it would
> match the initial check for "count < base" (which is essentially the same
> check since powi == 1).
> 
>> +			break;
>> +
>> +		if (!prefix[1])
> 
> Since prefix is character string, the comparison should be against '\0',
> according to DPDK coding style. The "!" should only be used on bool values.
> So "if (prefix[1] == '\0')" or "if (*(prefix + 1) == '\0')".
> 
>> +			break;
>> +		++prefix;
>> +	}
>> +
>> +	/* try to guess a good number of digits for precision */
>> +	for (; precision > 0; precision--) {
>> +		powj *= 10;
>> +		if (count / powi < powj)
>> +			break;
>> +	}
>> +
>> +	return snprintf(buf, buf_size, "%.*f %c%s", precision,
>> +			(double)count / powi, *prefix, use_iec ? "i" : "");
>> +}
>> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
>> index 386f11ae40..781c56adcd 100644
>> --- a/lib/eal/include/rte_common.h
>> +++ b/lib/eal/include/rte_common.h
>> @@ -14,9 +14,11 @@
>>   
>>   #include <assert.h>
>>   #include <limits.h>
>> +#include <stdbool.h>
>>   #include <stdint.h>
>>   #include <stdalign.h>
>>   
>> +#include <rte_compat.h>
>>   #include <rte_config.h>
>>   
>>   /* OS specific include */
>> @@ -919,6 +921,35 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
>>   uint64_t
>>   rte_str_to_size(const char *str);
>>   
>> +/**
>> + * Converts the uint64_t value provided to a human-readable string.
>> + * It null-terminates the string, truncating the data if needed.
>> + *
>> + * Sample outputs with "use_iec" disabled and enabled:
>> + * 0 : "0 ", "0 "
>> + * 700 : "700 ", "700 "
>> + * 1000 : "1.00 k", "1000 "
>> + * 1024 : "1.02 k", "1.00 ki"
>> + * 21474836480 : "21.5 G", "20.0 Gi"
>> + * 109951162777600 : "110 T", "100 Ti"
>> + *
> 
> I would omit the space before the suffixes in the output. As well as
> looking better to me, it also solves the issue of the non-suffixed numbers
> having a trailing space.
> 
>> + * @param buf
>> + *     Buffer to write the string to.
>> + * @param buf_size
>> + *     Size of the buffer.
>> + * @param count
>> + *     Number to convert.
>> + * @param use_iec
>> + *     If true, use IEC units (1024-based), otherwise use SI units (1000-based).
>> + * @return
>> + *     Number of characters written (not including the null-terminator),
>> + *     or that would have been required when the buffer is too small.
>> + */
>> +__rte_experimental
>> +int
>> +rte_size_to_str(char *buf, int buf_size,
>> +		uint64_t count, bool use_iec);
> 
> Again, no need to wrap.
> 
>> +
>>   /**
>>    * Function to terminate the application immediately, printing an error
>>    * message and returning the exit_code back to the shell.
>> diff --git a/lib/eal/version.map b/lib/eal/version.map
>> index a20c713eb1..01b6a7c190 100644
>> --- a/lib/eal/version.map
>> +++ b/lib/eal/version.map
>> @@ -398,6 +398,9 @@ EXPERIMENTAL {
>>   	# added in 24.11
>>   	rte_bitset_to_str;
>>   	rte_lcore_var_alloc;
>> +
>> +	# added in 25.07
>> +	rte_size_to_str;
>>   };
>>   
>>   INTERNAL {
>> -- 
>> 2.48.1.vfs.0.1
>>

