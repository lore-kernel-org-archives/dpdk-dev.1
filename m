Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DBC83F34
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 22:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C13400D7;
	Sun, 20 Jul 2025 00:30:19 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C784E400D5
 for <dev@dpdk.org>; Sun, 20 Jul 2025 00:30:18 +0200 (CEST)
Received: from debian (unknown [78.109.66.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D9EB6E046C;
 Sun, 20 Jul 2025 02:30:15 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D9EB6E046C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752964216;
 bh=wWLX9KhQfEyhB3M5gBYABe8Bqt4dDisSZCDtmYkChBY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=xzXth1nzLKCsijCoWPO3YZ6GjKLU9AVl6UxgZPO/ZeFNYJzmsbuG24bkAxpR8q9Xs
 ev4mCr0fdyx8Jw5cmBPnWjYD/pDrx/dtfJBJ4/uVM2/6H4vMNC88aeBJWw4upxHaQc
 Z9efkuWzfKt+uBFJOao72bV3SQBBC3/CCUYE4NJbjMWdZoVRMT1gT8KsQQR4ZLX3zF
 rIVK238MYCeZpcARhcmm+UhB8AuFO2ShAcMbJVq3/w1sqwOsvYpTXHPOdLfvkL6e1+
 cUcyqjnQtc2jAey4LDJRsEjyYqkmWIQ4D0oRYa9bVs4EZsiCAob4YdJsrbDQzk74Th
 2/s43eyGnctug==
Date: Sun, 20 Jul 2025 02:30:07 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH] mbuf: de-inline sanity checking a reinitialized mbuf
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDB9@smartserver.smartshare.dk>
Message-ID: <9af226cf-54c0-da6c-e572-324060b0c69a@arknetworks.am>
References: <20250719102315.435921-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB9@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-659345577-1752964216=:8807"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-659345577-1752964216=:8807
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Morten,

On Sat, 19 Jul 2025, Morten Brørup wrote:

>> From: Morten Brørup [mailto:mb@smartsharesystems.com]
>> Sent: Saturday, 19 July 2025 12.23
>>
>> Sanity checking a reinitialized mbuf (a.k.a. raw mbuf) has been
>> refactored
>> to follow the same design pattern as sanity checking a normal mbuf, and
>> now depends on RTE_LIBRTE_MBUF_DEBUG instead of RTE_ENABLE_ASSERT.
>>
>> The details of the changes are as follows:
>>
>> Non-inlined functions rte_mbuf_raw_sanity_check() and
>> rte_mbuf_raw_check()
>> have been added.
>> They do for a reinitialized mbuf what rte_mbuf_sanity_check() and
>> rte_mbuf_check() do for a normal mbuf.
>> They basically check the same conditions as
>> __rte_mbuf_raw_sanity_check()
>> previously did, but use "if (!condition) rte_panic(message)" instead of
>> RTE_ASSSERT(), so they don't depend on RTE_ENABLE_ASSERT.
>>
>> The inline function __rte_mbuf_raw_sanity_check() has been replaced
>> by the new macro __rte_mbuf_raw_sanity_check_mp(), which either calls
>> rte_mbuf_raw_sanity_check() or does nothing, depending on
>> RTE_LIBRTE_MBUF_DEBUG, just like the __rte_mbuf_sanity_check() macro
>> does
>> for a normal mbuf.
>>
>> Note that the new macro __rte_mbuf_raw_sanity_check_mp() takes an
>> optional
>> mempool parameter to verify that the mbuf belongs to the expected mbuf
>> pool.
>> This addition is mainly relevant for sanity checking reinitialized mbufs
>> freed directly into a given mempool by a PMD when using
>> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE.
>>
>> The macro __rte_mbuf_raw_sanity_check() has been kept for backwards API
>> compatibility.
>> It simply calls __rte_mbuf_raw_sanity_check_mp() without specifying a
>> mempool.
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>
> Building this with RTE_LIBRTE_MBUF_DEBUG 1 in rte_config.h spews out warnings like:

Oddly, for me, building DPDK this way does not result in similar warnings.
OS: Debian 12, gcc (Debian 12.2.0-14) 12.2.0, meson 1.0.1, ninja 1.11.1.

May be I'm missing something.

Thank you.

>
> ../lib/mbuf/rte_mbuf.h: In function ‘rte_mbuf_raw_free’:
> ../lib/mbuf/rte_mbuf.h:700:9: warning: ‘rte_mbuf_raw_sanity_check’ is deprecated: Symbol is not yet part of stable ABI [-Wdeprecated-declarations]
>  700 |         __rte_mbuf_raw_sanity_check_mp(m, NULL);
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/mbuf/rte_mbuf.h:542:1: note: declared here
>  542 | rte_mbuf_raw_sanity_check(const struct rte_mbuf *m, const struct rte_mempool *mp);
>      | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Exporting the new APIs as non-experimental (i.e. using RTE_EXPORT_SYMBOL() instead of RTE_EXPORT_EXPERIMENTAL_SYMBOL() in the C file, and omitting __rte_experimental in the header file, as shown below) works, but is that acceptable?
>
> Or is there a better way of avoiding these warnings?
>
>> ---
>>  lib/mbuf/rte_mbuf.c |  61 ++++++++++++++++++++++++++
>>  lib/mbuf/rte_mbuf.h | 104 ++++++++++++++++++++++++++++----------------
>>  2 files changed, 127 insertions(+), 38 deletions(-)
>>
>> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
>> index 9e7731a8a2..ff4db73b50 100644
>> --- a/lib/mbuf/rte_mbuf.c
>> +++ b/lib/mbuf/rte_mbuf.c
>> @@ -373,6 +373,67 @@ rte_pktmbuf_pool_create_extbuf(const char *name,
>> unsigned int n,
>>  	return mp;
>>  }
>>
>> +/* do some sanity checks on a reinitialized mbuf: panic if it fails */
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_raw_sanity_check, 25.11)
>
> +// RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_raw_sanity_check, 25.11)
> +RTE_EXPORT_SYMBOL(rte_mbuf_raw_sanity_check)
>
>> +void
>> +rte_mbuf_raw_sanity_check(const struct rte_mbuf *m, const struct
>> rte_mempool *mp)
>> +{
>> +	const char *reason;
>> +
>> +	if (rte_mbuf_raw_check(m, mp, &reason))
>> +		rte_panic("%s\n", reason);
>> +}
>> +
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_raw_check, 25.11)
>
> +// RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_raw_check, 25.11)
> +RTE_EXPORT_SYMBOL(rte_mbuf_raw_check)
>
>> +int rte_mbuf_raw_check(const struct rte_mbuf *m, const struct
>> rte_mempool *mp,
>> +		   const char **reason)
>> +{
>> +	/* check sanity */
>> +	if (rte_mbuf_check(m, 0, reason) == -1)
>> +		return -1;
>> +
>> +	/* check initialized */
>> +	if (rte_mbuf_refcnt_read(m) != 1) {
>> +		*reason = "uninitialized ref cnt";
>> +		return -1;
>> +	}
>> +	if (m->next != NULL) {
>> +		*reason = "uninitialized next ptr";
>> +		return -1;
>> +	}
>> +	if (m->nb_segs != 1) {
>> +		*reason = "uninitialized nb_segs";
>> +		return -1;
>> +	}
>> +	if (RTE_MBUF_CLONED(m)) {
>> +		*reason = "cloned";
>> +		return -1;
>> +	}
>> +	if (RTE_MBUF_HAS_EXTBUF(m)) {
>> +		if (!RTE_MBUF_HAS_PINNED_EXTBUF(m)) {
>> +			*reason = "external buffer not pinned";
>> +			return -1;
>> +		}
>> +
>> +		uint16_t cnt = rte_mbuf_ext_refcnt_read(m->shinfo);
>> +		if ((cnt == 0) || (cnt == UINT16_MAX)) {
>> +			*reason = "pinned external buffer bad ref cnt";
>> +			return -1;
>> +		}
>> +		if (cnt != 1) {
>> +			*reason = "pinned external buffer uninitialized ref
>> cnt";
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	if (mp != NULL && m->pool != mp) {
>> +		*reason = "wrong mbuf pool";
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /* do some sanity checks on a mbuf: panic if it fails */
>>  RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check)
>>  void
>> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
>> index 06ab7502a5..2621cc385c 100644
>> --- a/lib/mbuf/rte_mbuf.h
>> +++ b/lib/mbuf/rte_mbuf.h
>> @@ -339,11 +339,17 @@ rte_pktmbuf_priv_flags(struct rte_mempool *mp)
>>
>>  #ifdef RTE_LIBRTE_MBUF_DEBUG
>>
>> +/**  check reinitialized mbuf type in debug mode */
>> +#define __rte_mbuf_raw_sanity_check_mp(m, mp)
>> rte_mbuf_raw_sanity_check(m, mp)
>> +
>>  /**  check mbuf type in debug mode */
>>  #define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m, is_h)
>>
>>  #else /*  RTE_LIBRTE_MBUF_DEBUG */
>>
>> +/**  check reinitialized mbuf type in debug mode */
>> +#define __rte_mbuf_raw_sanity_check_mp(m, mp) do { } while (0)
>> +
>>  /**  check mbuf type in debug mode */
>>  #define __rte_mbuf_sanity_check(m, is_h) do { } while (0)
>>
>> @@ -513,6 +519,54 @@ rte_mbuf_ext_refcnt_update(struct
>> rte_mbuf_ext_shared_info *shinfo,
>>  } while (0)
>>
>>
>> +/**
>> + * @warning
>> + * @b EXPERIMENTAL: This API may change, or be removed, without prior
>> notice.
>> + *
>> + * Sanity checks on a reinitialized mbuf.
>> + *
>> + * Check the consistency of the given reinitialized mbuf.
>> + * The function will cause a panic if corruption is detected.
>> + *
>> + * Check that the mbuf is properly reinitialized (refcnt=1, next=NULL,
>> + * nb_segs=1), as done by rte_pktmbuf_prefree_seg().
>> + *
>> + * @param m
>> + *   The mbuf to be checked.
>> + * @param mp
>> + *   The mempool to which the mbuf belongs.
>> + *   NULL if unknown, not to be checked.
>> + */
>> +__rte_experimental
>
> +// __rte_experimental
>
>> +void
>> +rte_mbuf_raw_sanity_check(const struct rte_mbuf *m, const struct
>> rte_mempool *mp);
>> +
>> +/**
>> + * @warning
>> + * @b EXPERIMENTAL: This API may change, or be removed, without prior
>> notice.
>> + *
>> + * Sanity checks on a reinitialized mbuf.
>> + *
>> + * Almost like rte_mbuf_raw_sanity_check(), but this function gives the
>> reason
>> + * if corruption is detected rather than panic.
>> + *
>> + * @param m
>> + *   The mbuf to be checked.
>> + * @param mp
>> + *   The mempool to which the mbuf belongs.
>> + *   NULL if unknown, not to be checked.
>> + * @param reason
>> + *   A reference to a string pointer where to store the reason why a
>> mbuf is
>> + *   considered invalid.
>> + * @return
>> + *   - 0 if no issue has been found, reason is left untouched.
>> + *   - -1 if a problem is detected, reason then points to a string
>> describing
>> + *     the reason why the mbuf is deemed invalid.
>> + */
>> +__rte_experimental
>
> +// __rte_experimental
>
>> +int rte_mbuf_raw_check(const struct rte_mbuf *m, const struct
>> rte_mempool *mp,
>> +		   const char **reason);
>> +
>>  /**
>>   * Sanity checks on an mbuf.
>>   *
>> @@ -550,33 +604,11 @@ rte_mbuf_sanity_check(const struct rte_mbuf *m,
>> int is_header);
>>  int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
>>  		   const char **reason);
>>
>> -/**
>> - * Sanity checks on a reinitialized mbuf in debug mode.
>> - *
>> - * Check the consistency of the given reinitialized mbuf.
>> - * The function will cause a panic if corruption is detected.
>> - *
>> - * Check that the mbuf is properly reinitialized (refcnt=1, next=NULL,
>> - * nb_segs=1), as done by rte_pktmbuf_prefree_seg().
>> - *
>> - * @param m
>> - *   The mbuf to be checked.
>> - */
>> -static __rte_always_inline void
>> -__rte_mbuf_raw_sanity_check(__rte_unused const struct rte_mbuf *m)
>> -{
>> -	RTE_ASSERT(rte_mbuf_refcnt_read(m) == 1);
>> -	RTE_ASSERT(m->next == NULL);
>> -	RTE_ASSERT(m->nb_segs == 1);
>> -	RTE_ASSERT(!RTE_MBUF_CLONED(m));
>> -	RTE_ASSERT(!RTE_MBUF_HAS_EXTBUF(m) ||
>> -			(RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
>> -			rte_mbuf_ext_refcnt_read(m->shinfo) == 1));
>> -	__rte_mbuf_sanity_check(m, 0);
>> -}
>> +/** For backwards compatibility. */
>> +#define __rte_mbuf_raw_sanity_check(m)
>> __rte_mbuf_raw_sanity_check_mp(m, NULL)
>>
>>  /** For backwards compatibility. */
>> -#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_sanity_check(m)
>> +#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_sanity_check_mp(m, NULL)
>>
>>  /**
>>   * Allocate an uninitialized mbuf from mempool *mp*.
>> @@ -606,7 +638,7 @@ static inline struct rte_mbuf
>> *rte_mbuf_raw_alloc(struct rte_mempool *mp)
>>
>>  	if (rte_mempool_get(mp, &ret.ptr) < 0)
>>  		return NULL;
>> -	__rte_mbuf_raw_sanity_check(ret.m);
>> +	__rte_mbuf_raw_sanity_check_mp(ret.m, mp);
>>  	return ret.m;
>>  }
>>
>> @@ -644,7 +676,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp,
>> struct rte_mbuf **mbufs, unsigne
>>  	int rc = rte_mempool_get_bulk(mp, (void **)mbufs, count);
>>  	if (likely(rc == 0))
>>  		for (unsigned int idx = 0; idx < count; idx++)
>> -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
>> +			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], mp);
>>  	return rc;
>>  }
>>
>> @@ -665,7 +697,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp,
>> struct rte_mbuf **mbufs, unsigne
>>  static __rte_always_inline void
>>  rte_mbuf_raw_free(struct rte_mbuf *m)
>>  {
>> -	__rte_mbuf_raw_sanity_check(m);
>> +	__rte_mbuf_raw_sanity_check_mp(m, NULL);
>>  	rte_mempool_put(m->pool, m);
>>  }
>>
>> @@ -696,12 +728,8 @@ __rte_experimental
>>  static __rte_always_inline void
>>  rte_mbuf_raw_free_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs,
>> unsigned int count)
>>  {
>> -	for (unsigned int idx = 0; idx < count; idx++) {
>> -		const struct rte_mbuf *m = mbufs[idx];
>> -		RTE_ASSERT(m != NULL);
>> -		RTE_ASSERT(m->pool == mp);
>> -		__rte_mbuf_raw_sanity_check(m);
>> -	}
>> +	for (unsigned int idx = 0; idx < count; idx++)
>> +		__rte_mbuf_raw_sanity_check_mp(mbufs[idx], mp);
>>
>>  	rte_mempool_put_bulk(mp, (void **)mbufs, count);
>>  }
>> @@ -1021,22 +1049,22 @@ static inline int rte_pktmbuf_alloc_bulk(struct
>> rte_mempool *pool,
>>  	switch (count % 4) {
>>  	case 0:
>>  		while (idx != count) {
>> -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
>> +			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
>>  			rte_pktmbuf_reset(mbufs[idx]);
>>  			idx++;
>>  			/* fall-through */
>>  	case 3:
>> -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
>> +			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
>>  			rte_pktmbuf_reset(mbufs[idx]);
>>  			idx++;
>>  			/* fall-through */
>>  	case 2:
>> -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
>> +			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
>>  			rte_pktmbuf_reset(mbufs[idx]);
>>  			idx++;
>>  			/* fall-through */
>>  	case 1:
>> -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
>> +			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
>>  			rte_pktmbuf_reset(mbufs[idx]);
>>  			idx++;
>>  			/* fall-through */
>> --
>> 2.43.0
>
>
--8323328-659345577-1752964216=:8807--
