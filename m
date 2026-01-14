Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B507D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 04:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F294E4060A;
	Wed, 14 Jan 2026 05:59:46 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 7BAA840289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 05:59:45 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so2681115e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768366785;
 x=1768971585; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJ0dOyJhXyJdkRJlj6WcetZQ3RXtPhSMmxOt5FeiNKk=;
 b=Nps3YoE9kab9zuQ1eZs7u/kCH5yMBud7x8k0r3fXIScROD3ZODH0Ls8X+mrW97rmLN
 CgfE28jyxm8UEB2QwgSuf9uYv3hjPcayT11Id+Ji/v0qpEHdBpnJ9uGHLFxqWCTmwtV8
 RUsGu7F4OH76xBsgpUbRHX8UUB+Gg3A6w8sgQDrxXTTcYiXTCphcgGQQfOzBEzaFQDaM
 YtOdUT5vbyUNJJLlgfoWOChx4TZ360lJvK/y34nPGso7zk9PG4uUFvTnzLL7KNzGjxaV
 oekqYuUdIeB+U5E3hq+DDUDyFNqYZgfxkBwImuLqI0DGuOqHupMpMZu5KUAD66yVjoT+
 ykXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366785; x=1768971585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xJ0dOyJhXyJdkRJlj6WcetZQ3RXtPhSMmxOt5FeiNKk=;
 b=J+CAnKYSg+JghAG9VBMp7Za1JYejXw85isUiROTsLc7kZ/CimuI9OsdQG8PCtOwPPr
 lz7WVnO/VQ0DtAaATK8UGlvR+cgryfFzoZ6l7Cr3cVk/m7F67C4ryjxY/R9IlGgMCtY4
 oIyArGOaxvSiP4WadIrx1AwFhBLevoixRk88l/DNIw6VTV0z/tYoh4sXLP2H+QXWY/sl
 WapjphJZCMayT2tSvrSsNnZbo3/UOYo6KR6JXzs2zX9qGRz37FNPaJb/9LSPcQ9F9Y4P
 bnb8y6BGLYfEHmOy2fj4b7XxhYNaFZWsYfdAij0aMTtugJbYx5p0+zSdTc56Lo7t4Lof
 Y5dA==
X-Gm-Message-State: AOJu0YzTjlIhC5XBXgi48SsiahnxF/18zmt1VI/ndUqPlbf/rP/Ww36J
 Sh60ibk9QGGbfZNTdf4nWsBg6g2Iccq9YOE9LfFsM1/wMlPgiDS7HNuzs9Py9BaC+sk=
X-Gm-Gg: AY/fxX4fWvTmQnGSkcTYUhH/V3kadqKqeybNfTfcZMSFBZG77DV5/fnrXRux+J5sfmi
 m+S5uidz5mrBb8W3LziqWxNK9zv6yb0kfX1P1ZDHnUFwf3Dkcf0F3TYXZrHJrtVCugWCOQBHrZk
 zXz/i4+vq+v2Khc1SACWnaGFG3egVY0Eh5MPNfvUF0XrmSO0oPuvfyjpMhteMJ4+/0pVqTeCxDi
 1bog2V7lw2SJTM8zCusOu5z2COBvb/e0OyebC0YWQmEZyjRhxbz2zRVycHJ91OYUMkAOVHKxr2w
 OLu7pjtp3B4udpHXtcHQZwKjdjhVGTLwso7XJF7gVQQWb5S/vpAyHsvAv4rBTDpw201W+ev8zfN
 P8rbyfi3y2XFB8jj/8J7tr8Pz2nNUnFUBcUqGVANi667sh+/HXnHyjAXY2JqZyOuK+F78WC1kWa
 M0Q1pW44O/g9t0Ndtr7eVpx1NGVpWDgr98Ttt1dPmmwvTS8y06C3V7fzzWKhNZGlQ=
X-Received: by 2002:a05:600c:1c02:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47ee37a440bmr14186955e9.10.1768366784174; 
 Tue, 13 Jan 2026 20:59:44 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm12442645e9.7.2026.01.13.20.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:59:43 -0800 (PST)
Date: Tue, 13 Jan 2026 20:57:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Kiselev <alex@bisonrouter.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, vladimir.medvedkin@intel.com
Subject: Re: [PATCH] lpm: add new LPM v6 implementation (lpm6c)
Message-ID: <20260113205753.4481fde0@phoenix.local>
In-Reply-To: <20251103132433.38627-1-alex@bisonrouter.com>
References: <20251103132433.38627-1-alex@bisonrouter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  3 Nov 2025 14:24:33 +0100
Alex Kiselev <alex@bisonrouter.com> wrote:

> lpm6c is a new implementation of the IPv6 LPM algorithm, based on
> the existing lpm module. It utilizes a trie path compression technique to
> optimize lookup operations.
> 
> The implementation offers a performance improvement over the lpm
> module starting from /64 and longer prefixes. This makes it beneficial
> for use cases like BNG routers, whose FIB tables contain numerous /64
> prefixes and primarily handle traffic targeting them.
> 
> Performance comparison results against the original LPM6 for lookups
> at AMD Ryzen 9 5900XT CPU:
> 
> prefix /48 tests:
> Speedup vs LPM6: LPM6c 0.991x, LPM6c VEC 0.921x, FIB 1.000x, FIB VEC 1.048x
> 
> prefix /64 tests:
> Speedup vs LPM6: LPM6c 1.399x, LPM6c VEC 1.302x, FIB 1.145x, FIB VEC 1.292x
> 
> prefix /80 tests:
> Speedup vs LPM6: LPM6c 1.620x, LPM6c VEC 1.558x, FIB 1.096x, FIB VEC 1.226x
> 
> prefix /128 tests:
> Speedup vs LPM6: LPM6c 2.497x, LPM6c VEC 2.369x, FIB 1.255x, FIB VEC 1.349x
> 
> Signed-off-by: Alex Kiselev <alex@bisonrouter.com>

There are multiple LPM's for v4 so good to have something better for V6.
But I have multiple comments, and AI also found some.

>  app/test/meson.build           |    3 +
>  app/test/test_lpm6c.c          | 1776 ++++++++++++++++++++++++++++++++
>  app/test/test_lpm6c_perf.c     |  161 +++
>  app/test/test_lpm6c_perf_cmp.c |  409 ++++++++
>  lib/lpm/meson.build            |    4 +-
>  lib/lpm/rte_lpm6c.c            | 1320 ++++++++++++++++++++++++
>  lib/lpm/rte_lpm6c.h            |  560 ++++++++++
>  7 files changed, 4231 insertions(+), 2 deletions(-)
>  create mode 100644 app/test/test_lpm6c.c
>  create mode 100644 app/test/test_lpm6c_perf.c
>  create mode 100644 app/test/test_lpm6c_perf_cmp.c
>  create mode 100644 lib/lpm/rte_lpm6c.c
>  create mode 100644 lib/lpm/rte_lpm6c.h
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 8df8d3edd1..1f0a09c889 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -116,7 +116,10 @@ source_file_deps = {
>      'test_logs.c': [],
>      'test_lpm.c': ['net', 'lpm'],
>      'test_lpm6.c': ['lpm'],
> +    'test_lpm6c.c': ['lpm'],

Would prefer multiple test cases in existing test_lpm6 instead of a new file.
Less clutter

>      'test_lpm6_perf.c': ['lpm'],
> +    'test_lpm6c_perf.c': ['lpm'],
> +    'test_lpm6c_perf_cmp.c': ['lpm'],
>      'test_lpm_perf.c': ['net', 'lpm'],
>      'test_malloc.c': [],
>      'test_malloc_perf.c': [],
> diff --git a/app/test/test_lpm6c.c b/app/test/test_lpm6c.c
> new file mode 100644
> index 0000000000..fc7d70d8e8
> --- /dev/null
> +++ b/app/test/test_lpm6c.c
> @@ -0,0 +1,1776 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2010-2014 Intel Corporation

You don't work for Intel so putting Intel Copyright on it is wrong.

> + */
> +
> +#include "test.h"
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_memory.h>
> +#include <rte_lpm6c.h>
> +
> +#include "test_lpm6_data.h"
> +
> +#define TEST_LPM_ASSERT(cond) do { \
> +	if (!(cond)) { \
> +		printf("Error at line %d:\n", __LINE__); \
> +		return -1; \
> +	} \
> +} while (0)
> +
> +typedef int32_t (*rte_lpm6c_test)(void);
> +
> +static int32_t test0(void);
> +static int32_t test1(void);
> +static int32_t test2(void);
> +static int32_t test3(void);
> +static int32_t test4(void);
> +static int32_t test5(void);
> +static int32_t test6(void);
> +static int32_t test7(void);
> +static int32_t test8(void);
> +static int32_t test9(void);
> +static int32_t test10(void);
> +static int32_t test11(void);
> +static int32_t test12(void);
> +static int32_t test13(void);
> +static int32_t test14(void);
> +static int32_t test15(void);
> +static int32_t test16(void);
> +static int32_t test17(void);
> +static int32_t test18(void);
> +static int32_t test19(void);
> +static int32_t test20(void);
> +static int32_t test21(void);
> +static int32_t test22(void);
> +static int32_t test23(void);
> +static int32_t test24(void);
> +static int32_t test25(void);
> +static int32_t test26(void);
> +static int32_t test27(void);
> +static int32_t test28(void);

If you order functions correctly, no need for forward declarations.

> +rte_lpm6c_test tests6c[] = {
> +/* Test Cases */
> +	test0,
> +	test1,
> +	test2,
> +	test3,
> +	test4,
> +	test5,
> +	test6,
> +	test7,
> +	test8,
> +	test9,
> +	test10,
> +	test11,
> +	test12,
> +	test13,
> +	test14,
> +	test15,
> +	test16,
> +	test17,
> +	test18,
> +	test19,
> +	test20,
> +	test21,
> +	test22,
> +	test23,
> +	test24,
> +	test25,
> +	test26,
> +	test27,
> +	test28,
> +};

Use the existing unit_test_suite_runner() pattern in test.h
This is the kind of source transformation AI can do relatively easily and cleanly.

Better names for tests would also help.

> +#define MAX_DEPTH                                                    128
> +#define MAX_RULES                                                1000000
> +#define NUMBER_TBL8S                                           (1 << 16)
> +#define MAX_NUM_TBL8S                                          (1 << 21)
> +#define PASS 0
> +
> +/*
> + * Check that rte_lpm6c_create fails gracefully for incorrect user input
> + * arguments
> + */
> +int32_t
> +test0(void)
> +{
> +	struct rte_lpm6c *lpm = NULL;
> +	struct rte_lpm6c_config config;
> +
> +	config.max_rules = MAX_RULES;
> +	config.number_tbl8s = NUMBER_TBL8S;
> +	config.flags = 0;

Maybe use struct initialization to ensure everything is initialized.

> +
> +	/* rte_lpm6c_create: lpm name == NULL */
> +	lpm = rte_lpm6c_create(NULL, SOCKET_ID_ANY, &config);
> +	TEST_LPM_ASSERT(lpm == NULL);

Use existing TEST_ASSERT macro in test.h instead of inventing new one.

> +
> +	/* rte_lpm6c_create: max_rules = 0 */
> +	/* Note: __func__ inserts the function name, in this case "test0". */
> +	config.max_rules = 0;
> +	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
> +	TEST_LPM_ASSERT(lpm == NULL);
> +
> +	/* socket_id < -1 is invalid */
> +	config.max_rules = MAX_RULES;
> +	lpm = rte_lpm6c_create(__func__, -2, &config);
> +	TEST_LPM_ASSERT(lpm == NULL);
> +
> +	/* rte_lpm6c_create: number_tbl8s is bigger than the maximum */
> +	config.number_tbl8s = MAX_NUM_TBL8S + 1;
> +	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
> +	TEST_LPM_ASSERT(lpm == NULL);
> +
> +	/* rte_lpm6c_create: config = NULL */
> +	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, NULL);
> +	TEST_LPM_ASSERT(lpm == NULL);
> +
> +	return PASS;

Use existing test.h macro TEST_PASSED instead.

...

> +
> +REGISTER_FAST_TEST(lpm6c_autotest, true, true, test_lpm6c);

...

>
> diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
> index c4522eaf0c..4fdf408898 100644
> --- a/lib/lpm/meson.build
> +++ b/lib/lpm/meson.build
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2017 Intel Corporation
>  
> -sources = files('rte_lpm.c', 'rte_lpm6.c')
> -headers = files('rte_lpm.h', 'rte_lpm6.h')
> +sources = files('rte_lpm.c', 'rte_lpm6.c', 'rte_lpm6c.c')
> +headers = files('rte_lpm.h', 'rte_lpm6.h', 'rte_lpm6c.h')
>  # since header files have different names, we can install all vector headers
>  # without worrying about which architecture we actually need
>  indirect_headers += files(
> diff --git a/lib/lpm/rte_lpm6c.c b/lib/lpm/rte_lpm6c.c
> new file mode 100644
> index 0000000000..1c28e3cd54
> --- /dev/null
> +++ b/lib/lpm/rte_lpm6c.c
> @@ -0,0 +1,1320 @@
> +/*
> + * SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
> + */
> +#include <string.h>
> +#include <stdint.h>
> +#include <errno.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <sys/queue.h>
> +
> +#include <rte_log.h>
> +#include <rte_branch_prediction.h>
> +#include <rte_common.h>
> +#include <rte_memory.h>
> +#include <rte_malloc.h>
> +#include <rte_memcpy.h>
> +#include <rte_eal.h>
> +#include <rte_eal_memconfig.h>
> +#include <rte_per_lcore.h>
> +#include <rte_string_fns.h>
> +#include <rte_errno.h>
> +#include <rte_rwlock.h>
> +#include <rte_spinlock.h>
> +#include <rte_hash.h>
> +#include <assert.h>
> +#include <rte_jhash.h>
> +#include <rte_tailq.h>
> +#include <rte_ip6.h>
> +#include "lpm_log.h"
> +#include "rte_lpm6c.h"
> +
> +#define RULE_HASH_TABLE_EXTRA_SPACE              64
> +#define TBL24_IND                        UINT32_MAX
> +
> +TAILQ_HEAD(rte_lpm6c_list, rte_tailq_entry);
> +
> +static struct rte_tailq_elem rte_lpm6c_tailq = {
> +	.name = "RTR_LPM6C",
> +};
> +EAL_REGISTER_TAILQ(rte_lpm6c_tailq)
> +
> +/*
> + * Convert a depth to a one byte long mask
> + *   Example: 4 will be converted to 0xF0
> + */
> +static uint8_t __rte_pure
> +depth_to_mask_1b(uint8_t depth)
> +{
> +	/* To calculate a mask start with a 1 on the left hand side and right
> +	 * shift while populating the left hand side with 1's
> +	 */
> +	return (signed char)0x80 >> (depth - 1);
> +}
> +
> +/*
> + * LPM6 rule hash function
> + *
> + * It's used as a hash function for the rte_hash
> + *	containing rules
> + */
> +static inline uint32_t
> +rule_hash(const void *data, __rte_unused uint32_t data_len,
> +		  uint32_t init_val)
> +{
> +	return rte_jhash(data, sizeof(struct rte_lpm6c_rule_key), init_val);
> +}
> +
> +/*
> + * Init pool of free tbl8 indexes
> + */
> +static void
> +tbl8_pool_init(struct rte_lpm6c *lpm)
> +{
> +	uint32_t i;
> +
> +	/* put entire range of indexes to the tbl8 pool */
> +	for (i = 0; i < lpm->number_tbl8s; i++)
> +		lpm->tbl8_pool[i] = i;
> +
> +	lpm->tbl8_pool_pos = 0;
> +}
> +
> +/*
> + * Get an index of a free tbl8 from the pool
> + */
> +static inline uint32_t
> +tbl8_get(struct rte_lpm6c *lpm, uint32_t *tbl8_ind)
> +{
> +	if (lpm->tbl8_pool_pos == lpm->number_tbl8s)
> +		/* no more free tbl8 */
> +		return -ENOSPC;
> +
> +	/* next index */
> +	*tbl8_ind = lpm->tbl8_pool[lpm->tbl8_pool_pos++];
> +	return 0;
> +}
> +
> +/*
> + * Put an index of a free tbl8 back to the pool
> + */
> +static inline uint32_t
> +tbl8_put(struct rte_lpm6c *lpm, uint32_t tbl8_ind)
> +{
> +	if (lpm->tbl8_pool_pos == 0)
> +		/* pool is full */
> +		return -ENOSPC;
> +
> +	lpm->tbl8_pool[--lpm->tbl8_pool_pos] = tbl8_ind;
> +	return 0;
> +}
> +
> +/*
> + * Init a rule key.
> + *	  note that ip must be already masked
> + */
> +static inline void
> +rule_key_init(struct rte_lpm6c_rule_key *key, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth)
> +{
> +	key->ip = *ip;
> +	key->depth = depth;
> +}
> +
> +/*
> + * Allocates memory for LPM object
> + */
> +struct rte_lpm6c *
> +rte_lpm6c_create(const char *name, int socket_id,
> +		const struct rte_lpm6c_config *config)
> +{
> +	char mem_name[RTE_LPM6C_NAMESIZE];
> +	struct rte_lpm6c *lpm = NULL;
> +	struct rte_tailq_entry *te;
> +	uint64_t mem_size;
> +	struct rte_lpm6c_list *lpm_list;
> +	struct rte_hash *rules_tbl = NULL;
> +	uint32_t *tbl8_pool = NULL;
> +	struct rte_lpm6c_tbl8_hdr *tbl8_hdrs = NULL;
> +
> +	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
> +
> +	RTE_BUILD_BUG_ON(sizeof(struct rte_lpm6c_tbl_entry) != sizeof(uint32_t));

prefer static_assert in new code()

> +
> +	/* Check user arguments. */
> +	if ((name == NULL) || (socket_id < -1) || (config == NULL) ||
> +			(config->max_rules == 0) ||
> +			config->number_tbl8s > RTE_LPM6C_TBL8_MAX_NUM_GROUPS) {

Extra paren's not needed.
Other code uses 
	if ((socket_id != SOCKET_ID_ANY) && socket_id < 0) {

> +		rte_errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	/* create rules hash table */
> +	snprintf(mem_name, sizeof(mem_name), "LRH_%s", name);

Need to check for format overflow

> +	struct rte_hash_parameters rule_hash_tbl_params = {
> +		.entries = config->max_rules * 1.2 +
> +			RULE_HASH_TABLE_EXTRA_SPACE,
> +		.key_len = sizeof(struct rte_lpm6c_rule_key),
> +		.hash_func = rule_hash,
> +		.hash_func_init_val = 0,
> +		.name = mem_name,
> +		.reserved = 0,
> +		.socket_id = socket_id,
> +		.extra_flag = 0
> +	};
> +
> +	rules_tbl = rte_hash_create(&rule_hash_tbl_params);
> +	if (rules_tbl == NULL) {
> +		LPM_LOG(ERR, "LPM rules hash table allocation failed: %s (%d)",
> +				  rte_strerror(rte_errno), rte_errno);
> +		goto fail_wo_unlock;
> +	}
> +
> +	/* allocate tbl8 indexes pool */
> +	tbl8_pool = rte_malloc(NULL,
> +			sizeof(uint32_t) * config->number_tbl8s,
> +			RTE_CACHE_LINE_SIZE);
> +	if (tbl8_pool == NULL) {
> +		LPM_LOG(ERR, "LPM tbl8 pool allocation failed: %s (%d)",
> +				  rte_strerror(rte_errno), rte_errno);
> +		rte_errno = ENOMEM;
> +		goto fail_wo_unlock;
> +	}
> +
> +	/* allocate tbl8 headers */
> +	tbl8_hdrs = rte_malloc(NULL,
> +			sizeof(struct rte_lpm6c_tbl8_hdr) * config->number_tbl8s,
> +			RTE_CACHE_LINE_SIZE);
> +	if (tbl8_hdrs == NULL) {
> +		LPM_LOG(ERR, "LPM tbl8 headers allocation failed: %s (%d)",
> +				  rte_strerror(rte_errno), rte_errno);
> +		rte_errno = ENOMEM;
> +		goto fail_wo_unlock;
> +	}
> +
> +	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
> +
> +	/* Determine the amount of memory to allocate. */
> +	mem_size = sizeof(*lpm) + (sizeof(lpm->tbl8[0]) * config->number_tbl8s);
> +
> +	rte_mcfg_tailq_write_lock();
> +
> +	/* Guarantee there's no existing */
> +	TAILQ_FOREACH(te, lpm_list, next) {
> +		lpm = (struct rte_lpm6c *) te->data;
> +		if (strncmp(name, lpm->name, RTE_LPM6C_NAMESIZE) == 0)
> +			break;
> +	}
> +	lpm = NULL;
> +	if (te != NULL) {
> +		rte_errno = EEXIST;
> +		goto fail;
> +	}
> +
> +	/* allocate tailq entry */
> +	te = rte_zmalloc("LPM6_TAILQ_ENTRY", sizeof(*te), 0);
> +	if (te == NULL) {
> +		LPM_LOG(ERR, "Failed to allocate tailq entry!");
> +		rte_errno = ENOMEM;
> +		goto fail;
> +	}
> +
> +	/* Allocate memory to store the LPM data structures. */
> +	lpm = rte_zmalloc_socket(mem_name, (size_t)mem_size,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +
> +	if (lpm == NULL) {
> +		LPM_LOG(ERR, "LPM memory allocation failed");
> +		rte_free(te);
> +		rte_errno = ENOMEM;
> +		goto fail;
> +	}
> +
> +	/* Save user arguments. */
> +	lpm->max_rules = config->max_rules;
> +	lpm->number_tbl8s = config->number_tbl8s;
> +	snprintf(lpm->name, sizeof(lpm->name), "%s", name);
> +	lpm->rules_tbl = rules_tbl;
> +	lpm->tbl8_pool = tbl8_pool;
> +	lpm->tbl8_hdrs = tbl8_hdrs;
> +
> +	/* init the stack */
> +	tbl8_pool_init(lpm);
> +
> +	te->data = (void *) lpm;
> +
> +	TAILQ_INSERT_TAIL(lpm_list, te, next);
> +	rte_mcfg_tailq_write_unlock();
> +	return lpm;
> +
> +fail:
> +	rte_mcfg_tailq_write_unlock();
> +
> +fail_wo_unlock:
> +	rte_free(tbl8_hdrs);
> +	rte_free(tbl8_pool);
> +	rte_hash_free(rules_tbl);
> +
> +	return NULL;
> +}
> +
> +/*
> + * Find an existing lpm table and return a pointer to it.
> + */
> +struct rte_lpm6c *
> +rte_lpm6c_find_existing(const char *name)
> +{
> +	struct rte_lpm6c *l = NULL;
> +	struct rte_tailq_entry *te;
> +	struct rte_lpm6c_list *lpm_list;
> +
> +	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
> +
> +	rte_mcfg_tailq_read_lock();
> +	TAILQ_FOREACH(te, lpm_list, next) {
> +		l = (struct rte_lpm6c *) te->data;
> +		if (strncmp(name, l->name, RTE_LPM6C_NAMESIZE) == 0)
> +			break;
> +	}
> +	rte_mcfg_tailq_read_unlock();
> +
> +	if (te == NULL) {
> +		rte_errno = ENOENT;
> +		return NULL;
> +	}
> +
> +	return l;
> +}
> +
> +/*
> + * De-allocates memory for given LPM table.
> + */
> +void
> +rte_lpm6c_free(struct rte_lpm6c *lpm)
> +{
> +	struct rte_lpm6c_list *lpm_list;
> +	struct rte_tailq_entry *te;
> +
> +	/* Check user arguments. */
> +	if (lpm == NULL)
> +		return;
> +
> +	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
> +
> +	rte_mcfg_tailq_write_lock();
> +
> +	/* find our tailq entry */
> +	TAILQ_FOREACH(te, lpm_list, next) {
> +		if (te->data == (void *) lpm)
> +			break;
> +	}
> +
> +	if (te != NULL)
> +		TAILQ_REMOVE(lpm_list, te, next);
> +
> +	rte_mcfg_tailq_write_unlock();
> +
> +	rte_free(lpm->tbl8_hdrs);
> +	rte_free(lpm->tbl8_pool);
> +	rte_hash_free(lpm->rules_tbl);
> +	rte_free(lpm);
> +	rte_free(te);
> +}
> +
> +/* Find a rule */
> +static inline int
> +rule_find_with_key(struct rte_lpm6c *lpm,
> +		  const struct rte_lpm6c_rule_key *rule_key,
> +		  uint32_t *next_hop)
> +{
> +	uint64_t hash_val;
> +	int ret;
> +
> +	/* lookup for a rule */
> +	ret = rte_hash_lookup_data(lpm->rules_tbl, (const void *)rule_key,
> +		(void **)&hash_val);
> +	if (ret >= 0) {
> +		*next_hop = (uint32_t) hash_val;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Find a rule */
> +static int
> +rule_find(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
> +		  uint32_t *next_hop)
> +{
> +	struct rte_lpm6c_rule_key rule_key;
> +
> +	/* init a rule key */
> +	rule_key_init(&rule_key, ip, depth);
> +
> +	return rule_find_with_key(lpm, &rule_key, next_hop);
> +}
> +
> +/*
> + * Checks if a rule already exists in the rules table and updates
> + * the nexthop if so. Otherwise it adds a new rule if enough space is available.
> + *
> + * Returns:
> + *    0 - next hop of existed rule is updated
> + *    1 - new rule successfully added
> + *   <0 - error
> + */
> +static inline int
> +rule_add(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip, uint8_t depth,
> +		  uint32_t next_hop)
> +{
> +	int ret, rule_exist;
> +	struct rte_lpm6c_rule_key rule_key;
> +	uint32_t unused;
> +
> +	/* init a rule key */
> +	rule_key_init(&rule_key, ip, depth);
> +
> +	/* Scan through rule list to see if rule already exists. */
> +	rule_exist = rule_find_with_key(lpm, &rule_key, &unused);
> +
> +	/*
> +	 * If rule does not exist check if there is space to add a new rule to
> +	 * this rule group. If there is no space return error.
> +	 */
> +	if (!rule_exist && lpm->used_rules == lpm->max_rules)
> +		return -ENOSPC;
> +
> +	/* add the rule or update rules next hop */
> +	ret = rte_hash_add_key_data(lpm->rules_tbl, &rule_key,
> +		(void *)(uintptr_t) next_hop);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Increment the used rules counter for this rule group. */
> +	if (!rule_exist) {
> +		lpm->used_rules++;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Find a less specific rule
> + */
> +static int
> +rule_find_less_specific(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, struct rte_lpm6c_rule *rule)
> +{
> +	int ret;
> +	uint32_t next_hop;
> +	uint8_t mask;
> +	struct rte_lpm6c_rule_key rule_key;
> +
> +	if (depth == 1)
> +		return 0;
> +
> +	rule_key_init(&rule_key, ip, depth);
> +
> +	while (depth > 1) {
> +		depth--;
> +
> +		/* each iteration zero one more bit of the key */
> +		mask = depth & 7; /* depth % RTE_LPM6C_BYTE_SIZE */
> +		if (mask > 0)
> +			mask = depth_to_mask_1b(mask);
> +
> +		rule_key.depth = depth;
> +		rule_key.ip.a[depth >> 3] &= mask;
> +
> +		ret = rule_find_with_key(lpm, &rule_key, &next_hop);
> +		if (ret) {
> +			rule->depth = depth;
> +			rule->ip = rule_key.ip;
> +			rule->next_hop = next_hop;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Function that expands a rule across the data structure when a less-generic
> + * one has been added before. It assures that every possible combination of bits
> + * in the IP address returns a match.
> + */
> +static void
> +expand_rule(struct rte_lpm6c *lpm, uint32_t tbl8_ind, uint8_t old_depth,
> +		uint8_t new_depth, uint32_t next_hop, uint8_t valid)
> +{
> +	uint32_t j;
> +	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
> +	struct rte_lpm6c_tbl8 *tbl;
> +	struct rte_lpm6c_tbl_entry *entries;
> +
> +	tbl_hdr = &lpm->tbl8_hdrs[tbl8_ind];
> +	tbl = &lpm->tbl8[tbl8_ind];
> +
> +	if (tbl_hdr->lsp_depth <= old_depth ||
> +			  tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP) {
> +		if (valid) {
> +			tbl->lsp_next_hop = next_hop;
> +			tbl_hdr->lsp_depth = new_depth;
> +		} else
> +			tbl->lsp_next_hop = RTE_LPM6C_UNDEF_NEXT_HOP;
> +	}
> +
> +	entries = lpm->tbl8[tbl8_ind].entries;
> +
> +	struct rte_lpm6c_tbl_entry new_tbl8_entry = {
> +		.valid = valid,
> +		.valid_group = valid,
> +		.depth = new_depth,
> +		.next_hop = next_hop,
> +		.ext_entry = 0,
> +	};
> +
> +	for (j = 0; j < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; j++)
> +		if (!entries[j].valid || (entries[j].ext_entry == 0
> +				&& entries[j].depth <= old_depth)) {
> +
> +			entries[j] = new_tbl8_entry;
> +
> +		} else if (entries[j].ext_entry == 1) {
> +
> +			expand_rule(lpm, entries[j].lpm6_tbl8_ind,
> +					  old_depth, new_depth, next_hop, valid);
> +		}
> +}
> +
> +/*
> + * Init a tbl8 header
> + */
> +static inline void
> +init_tbl8_header(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t tbl_ind, uint32_t owner_tbl_ind,
> +		  uint32_t owner_entry_ind, uint32_t lsp_next_hop, uint8_t lsp_depth)
> +{
> +	struct rte_lpm6c_tbl8_hdr *tbl_hdr = &lpm->tbl8_hdrs[tbl_ind];
> +	struct rte_lpm6c_tbl8 *tbl = &lpm->tbl8[tbl_ind];
> +
> +	tbl_hdr->owner_tbl_ind = owner_tbl_ind;
> +	tbl_hdr->owner_entry_ind = owner_entry_ind;
> +
> +	tbl_hdr->nb_ext  = 0;
> +	tbl_hdr->nb_rule  = 0;
> +
> +	tbl->ip = *ip;
> +	rte_ipv6_addr_mask(&tbl->ip, depth);
> +	tbl_hdr->depth = depth;
> +
> +	tbl_hdr->lsp_depth = lsp_depth;
> +	tbl->lsp_next_hop = lsp_next_hop;
> +}
> +
> +/*
> + * Calculate index to the table based on the number and position
> + * of the bytes being inspected in this step.
> + */
> +static uint32_t
> +get_bitshift(const struct rte_ipv6_addr *ip, uint8_t first_byte, uint8_t bytes)
> +{
> +	uint32_t entry_ind, i;
> +	int8_t bitshift;
> +
> +	entry_ind = 0;
> +	for (i = first_byte; i < (uint32_t)(first_byte + bytes); i++) {
> +		bitshift = (int8_t)((bytes - i) * RTE_LPM6C_BYTE_SIZE);
> +
> +		if (bitshift < 0)
> +			bitshift = 0;
> +		entry_ind = entry_ind | ip->a[i - 1] << bitshift;
> +	}
> +
> +	return entry_ind;
> +}
> +
> +/*
> + * Returns number of free tbl8s
> + */
> +uint32_t
> +rte_lpm6c_tbl8_available(struct rte_lpm6c *lpm)
> +{
> +	return lpm->number_tbl8s - lpm->tbl8_pool_pos;
> +}
> +
> +/*
> + * Returns number of tbl8s in use
> + */
> +uint32_t
> +rte_lpm6c_tbl8_in_use(struct rte_lpm6c *lpm)
> +{
> +	return lpm->tbl8_pool_pos;
> +}
> +
> +int
> +rte_lpm6c_is_rule_present(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t *next_hop)
> +{
> +	struct rte_ipv6_addr masked_ip;
> +
> +	/* Check user arguments. */
> +	if ((lpm == NULL) || next_hop == NULL || ip == NULL ||
> +			(depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
> +		return -EINVAL;
> +
> +	/* Copy the IP and mask it to avoid modifying user's input data. */
> +	masked_ip = *ip;
> +	rte_ipv6_addr_mask(&masked_ip, depth);
> +
> +	return rule_find(lpm, &masked_ip, depth, next_hop);
> +}
> +
> +static uint8_t
> +depth_to_level(uint8_t depth)
> +{
> +	if (depth <= RTE_LPM6C_ROOT_LEV_BYTES * RTE_LPM6C_BYTE_SIZE)
> +		return 0;
> +	return 1 + (depth - 1 - RTE_LPM6C_ROOT_LEV_BYTES * RTE_LPM6C_BYTE_SIZE) /
> +			  RTE_LPM6C_BYTE_SIZE;
> +}
> +
> +static uint8_t
> +level_to_depth(uint8_t level)
> +{
> +	if (level == 0)
> +		return 0;
> +	return (RTE_LPM6C_ROOT_LEV_BYTES + level - 1) * RTE_LPM6C_BYTE_SIZE;
> +}
> +
> +#define LPM6_TBL_NOT_FOUND 0
> +#define LPM6_DEST_TBL_FOUND 1
> +#define LPM6_INTRM_TBL_FOUND 2
> +
> +static int
> +find_table(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
> +		  uint8_t *p_level, struct rte_lpm6c_tbl_entry **p_tbl,
> +		  uint32_t *p_tbl_ind, uint32_t *p_entry_ind)
> +{
> +	uint8_t bits, first_byte, bytes, level;
> +	struct rte_ipv6_addr masked_ip;
> +	uint32_t entry_ind, tbl_ind, ext_tbl_ind;
> +	int ret;
> +	struct rte_lpm6c_tbl_entry *entries;
> +	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
> +	struct rte_lpm6c_tbl8 *tbl8;
> +
> +	entries = *p_tbl;
> +	tbl_ind = *p_tbl_ind;
> +	level = *p_level;
> +
> +	while (1) {
> +		if (level == 0) {
> +			first_byte = 1;
> +			bytes = RTE_LPM6C_ROOT_LEV_BYTES;
> +		} else {
> +			first_byte = RTE_LPM6C_ROOT_LEV_BYTES + level;
> +			bytes = 1;
> +		}
> +
> +		/*
> +		 * Calculate index to the table based on the number and position
> +		 * of the bytes being inspected in this step.
> +		 */
> +		entry_ind = get_bitshift(ip, first_byte, bytes);
> +		/* Number of bits covered in this step */
> +		bits = (uint8_t)((bytes + first_byte - 1) * RTE_LPM6C_BYTE_SIZE);
> +
> +		/*
> +		 * If depth if smaller than this number,
> +		 * then the destination (last level) table is found.
> +		 */
> +		if (depth <= bits) {
> +			ret = LPM6_DEST_TBL_FOUND;
> +			break;
> +		}
> +		if (!entries[entry_ind].valid || entries[entry_ind].ext_entry == 0) {
> +			ret = LPM6_INTRM_TBL_FOUND;
> +			break;
> +		}
> +
> +		/* follow the reference to the next level */
> +		assert(entries[entry_ind].ext_entry == 1);
> +		level = entries[entry_ind].depth;
> +
> +		/* check that the next level is still on the prefix path */
> +		if (depth < level_to_depth(level) + 1) {
> +			ret = LPM6_TBL_NOT_FOUND;
> +			break;
> +		}
> +
> +		/* Check that the next level table is still on the prefix path */
> +		ext_tbl_ind = entries[entry_ind].lpm6_tbl8_ind;
> +		tbl_hdr = &lpm->tbl8_hdrs[ext_tbl_ind];
> +		tbl8 = &lpm->tbl8[ext_tbl_ind];
> +		masked_ip = *ip;
> +		rte_ipv6_addr_mask(&masked_ip, tbl_hdr->depth);
> +		if (!rte_ipv6_addr_eq(&tbl8->ip, &masked_ip)) {
> +			ret = LPM6_TBL_NOT_FOUND;
> +			break;
> +		}
> +
> +		tbl_ind = ext_tbl_ind;
> +		entries = lpm->tbl8[tbl_ind].entries;
> +		*p_level = level;
> +	}
> +
> +	*p_tbl = entries;
> +	*p_tbl_ind = tbl_ind;
> +	*p_entry_ind = entry_ind;
> +	return ret;
> +}
> +
> +static void
> +fill_dst_tbl(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, struct rte_lpm6c_tbl_entry *tbl, uint8_t level,
> +		  uint32_t tbl_ind, int is_new_rule, uint32_t next_hop)
> +{
> +	uint32_t entry_ind, tbl_range, i;
> +	uint8_t bits_covered, first_byte, bytes;
> +
> +	if (level == 0) {
> +		first_byte = 1;
> +		bytes = RTE_LPM6C_ROOT_LEV_BYTES;
> +	} else {
> +		first_byte = RTE_LPM6C_ROOT_LEV_BYTES + level;
> +		bytes = 1;
> +	}
> +
> +	/*
> +	 * Calculate index to the table based on the number and position
> +	 * of the bytes being inspected in this step.
> +	 */
> +	entry_ind = get_bitshift(ip, first_byte, bytes);
> +	/* Number of bits covered in this step */
> +	bits_covered = (uint8_t)((bytes + first_byte - 1) * RTE_LPM6C_BYTE_SIZE);
> +
> +	/*
> +	 * If depth if smaller than this number (i.e. this is the last step)
> +	 * expand the rule across the relevant positions in the table.
> +	 */
> +	assert(depth <= bits_covered);
> +	tbl_range = 1 << (bits_covered - depth);
> +
> +	for (i = entry_ind; i < (entry_ind + tbl_range); i++) {
> +		if (!tbl[i].valid || (tbl[i].ext_entry == 0 &&
> +				tbl[i].depth <= depth)) {
> +
> +			struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +				.next_hop = next_hop,
> +				.depth = depth,
> +				.valid = VALID,
> +				.valid_group = VALID,
> +				.ext_entry = 0,
> +			};
> +
> +			tbl[i] = new_tbl_entry;
> +
> +		} else if (tbl[i].ext_entry == 1) {
> +			/*
> +			 * If tbl entry is valid and extended calculate the index
> +			 * into next tbl8 and expand the rule across the data structure.
> +			 */
> +			expand_rule(lpm, tbl[i].lpm6_tbl8_ind, depth, depth,
> +					  next_hop, VALID);
> +		}
> +	}
> +
> +	/* increase the number of rules saved in the table */
> +	if (tbl_ind != TBL24_IND && is_new_rule)
> +		lpm->tbl8_hdrs[tbl_ind].nb_rule++;
> +}
> +
> +static int
> +add_new_tbl(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, struct rte_lpm6c_tbl_entry *parent_tbl,
> +		  uint32_t entry_ind, uint32_t parent_tbl_ind, uint8_t level,
> +		  struct rte_lpm6c_tbl_entry **p_new_tbl,
> +		  uint32_t *p_new_tbl_ind)
> +{
> +	bool lsp;
> +	uint8_t lsp_depth;
> +	int ret;
> +	uint32_t tbl8_gindex;
> +	uint32_t lsp_next_hop;
> +	struct rte_lpm6c_tbl_entry *new_tbl;
> +
> +	/* get a new tbl8 index */
> +	ret = tbl8_get(lpm, &tbl8_gindex);
> +	if (ret != 0)
> +		return -ENOSPC;
> +	new_tbl = lpm->tbl8[tbl8_gindex].entries;
> +
> +	lsp = false;
> +	lsp_next_hop = RTE_LPM6C_UNDEF_NEXT_HOP;
> +	lsp_depth = 0;
> +
> +	if (parent_tbl[entry_ind].valid) {
> +		if (parent_tbl[entry_ind].ext_entry) {
> +			struct rte_lpm6c_rule lsp_rule;
> +
> +			ret = rule_find_less_specific(lpm, ip, depth, &lsp_rule);
> +			if (ret) {
> +				lsp = true;
> +				lsp_next_hop = lsp_rule.next_hop;
> +				lsp_depth = lsp_rule.depth;
> +			}
> +		} else {
> +			lsp = true;
> +			lsp_next_hop = parent_tbl[entry_ind].next_hop;
> +			lsp_depth = parent_tbl[entry_ind].depth;
> +		}
> +	}
> +
> +	/* If it's invalid a new tbl8 is needed */
> +	if (lsp) {
> +		/*
> +		 * If it's valid but not extended the rule that was stored
> +		 * here needs to be moved to the next table.
> +		 */
> +		int i;
> +
> +		struct rte_lpm6c_tbl_entry tbl_entry = {
> +			.next_hop = lsp_next_hop,
> +			.depth = lsp_depth,
> +			.valid = VALID,
> +			.valid_group = VALID,
> +			.ext_entry = 0
> +		};
> +
> +		/* Populate new tbl8 with tbl value. */
> +		for (i = 0; i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; i++)
> +			new_tbl[i] = tbl_entry;
> +	} else
> +		/* invalidate all new tbl8 entries */
> +		memset(new_tbl, 0,
> +				  RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES *
> +				  sizeof(struct rte_lpm6c_tbl_entry));
> +
> +	/*
> +	 * Init the new table's header:
> +	 *   save the reference to the owner table
> +	 */
> +	init_tbl8_header(lpm, ip, level_to_depth(level),
> +			  tbl8_gindex, parent_tbl_ind, entry_ind,
> +			  lsp_next_hop, lsp_depth);
> +
> +	/* reference to a new tbl8 */
> +	struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +		.lpm6_tbl8_ind = tbl8_gindex,
> +		.depth = level,
> +		.valid = VALID,
> +		.valid_group = VALID,
> +		.ext_entry = 1,
> +	};
> +
> +	parent_tbl[entry_ind] = new_tbl_entry;
> +
> +	/* increase the number of external entries saved in the parent table */
> +	if (parent_tbl_ind != TBL24_IND)
> +		lpm->tbl8_hdrs[parent_tbl_ind].nb_ext++;
> +
> +	*p_new_tbl = new_tbl;
> +	*p_new_tbl_ind = tbl8_gindex;
> +	return 0;
> +}
> +
> +static int
> +add_intermediate_tbl(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip,
> +		  uint8_t depth, struct rte_lpm6c_tbl_entry *tbl, uint32_t tbl_ind,
> +		  uint32_t entry_ind)
> +{
> +	int ret, i, cnt;
> +	uint8_t level;
> +	uint32_t ext_tbl_ind, interm_tbl_ind;
> +	struct rte_lpm6c_tbl_entry ext_entry;
> +	struct rte_lpm6c_tbl8_hdr *ext_tbl_hdr;
> +	struct rte_lpm6c_tbl8 *tbl8;
> +	struct rte_lpm6c_tbl_entry *interm_tbl;
> +
> +	/*
> +	 * determine the level at which a new intermediate table
> +	 * should be added
> +	 */
> +	ext_entry = tbl[entry_ind];
> +	assert(ext_entry.ext_entry == 1);
> +	ext_tbl_ind = ext_entry.lpm6_tbl8_ind;
> +	ext_tbl_hdr = &lpm->tbl8_hdrs[ext_tbl_ind];
> +	tbl8 = &lpm->tbl8[ext_tbl_ind];
> +
> +	/*
> +	 * ext table's prefix and the given prefix should be
> +	 * equal at the root level
> +	 */
> +	assert(memcmp(ip->a, tbl8->ip.a, RTE_LPM6C_ROOT_LEV_BYTES) == 0);
> +
> +	cnt = RTE_MIN(depth_to_level(depth), depth_to_level(ext_tbl_hdr->depth));
> +	for (i = 1; i <= cnt; i++)
> +		if (ip->a[RTE_LPM6C_ROOT_LEV_BYTES + i - 1] !=
> +				  tbl8->ip.a[RTE_LPM6C_ROOT_LEV_BYTES + i - 1])
> +			break;
> +	level = i > cnt ? cnt : i;
> +
> +	/* add a new intermediate table */
> +	ret = add_new_tbl(lpm, ip, depth, tbl, entry_ind, tbl_ind, level,
> +			  &interm_tbl, &interm_tbl_ind);
> +	if (ret != 0)
> +		return ret;
> +
> +	/* move the initial reference to the intermediate table */
> +	entry_ind = tbl8->ip.a[RTE_LPM6C_ROOT_LEV_BYTES + level - 1];
> +	interm_tbl[entry_ind] = ext_entry;
> +	/* update the header of ext table */
> +	ext_tbl_hdr->owner_tbl_ind = interm_tbl_ind;
> +	ext_tbl_hdr->owner_entry_ind = entry_ind;
> +
> +	if (tbl_ind != TBL24_IND) {
> +		assert(lpm->tbl8_hdrs[tbl_ind].nb_ext > 0);
> +		lpm->tbl8_hdrs[tbl_ind].nb_ext--;
> +	}
> +	lpm->tbl8_hdrs[interm_tbl_ind].nb_ext++;
> +
> +	return 0;
> +}
> +
> +int
> +rte_lpm6c_add(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t next_hop)
> +{
> +	struct rte_lpm6c_tbl_entry *tbl, *new_tbl;
> +	int ret, is_new_rule;
> +	uint32_t tbl_ind, entry_ind;
> +	uint8_t level;
> +	struct rte_ipv6_addr masked_ip;
> +
> +	/* Check user arguments. */
> +	if ((lpm == NULL) || (depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
> +		return -EINVAL;
> +
> +	/* Copy the IP and mask it to avoid modifying user's input data. */
> +	masked_ip = *ip;
> +	rte_ipv6_addr_mask(&masked_ip, depth);
> +
> +	/*
> +	 * Check that tbl8 pool contains enough entries to create the longest
> +	 * path in the tree
> +	 */
> +	if (rte_lpm6c_tbl8_available(lpm) < MIN_TBL8_REQ_FOR_ADD)
> +		return -ENOSPC;
> +
> +	/* Add the rule to the rule table. */
> +	is_new_rule = rule_add(lpm, &masked_ip, depth, next_hop);
> +	/* If there is no space available for new rule return error. */
> +	if (is_new_rule < 0)
> +		return is_new_rule;
> +
> +	level = 0;
> +	tbl = lpm->tbl24;
> +	tbl_ind = TBL24_IND;
> +
> +start:
> +	ret = find_table(lpm, &masked_ip, depth,
> +			  &level, &tbl, &tbl_ind, &entry_ind);
> +
> +	switch (ret) {
> +	case LPM6_TBL_NOT_FOUND:
> +		ret = add_intermediate_tbl(lpm, &masked_ip, depth, tbl, tbl_ind,
> +				  entry_ind);
> +		if (ret < 0)
> +			return ret;
> +		goto start;
> +
> +	case LPM6_DEST_TBL_FOUND:
> +		/* fill existing table and expand some cells if necessary */
> +		fill_dst_tbl(lpm, &masked_ip, depth, tbl, level, tbl_ind,
> +				  is_new_rule, next_hop);
> +		ret = 0;
> +		break;
> +
> +	case LPM6_INTRM_TBL_FOUND:
> +		/* link a new table and fill it */
> +		level = depth_to_level(depth);
> +		ret = add_new_tbl(lpm, &masked_ip, depth, tbl, entry_ind, tbl_ind, level,
> +				  &new_tbl, &tbl_ind);
> +		if (ret < 0)
> +			break;
> +		fill_dst_tbl(lpm, &masked_ip, depth, new_tbl, level, tbl_ind,
> +				  is_new_rule, next_hop);
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Delete a rule from the rule table.
> + * NOTE: Valid range for depth parameter is 1 .. 128 inclusive.
> + * return
> + *	  0 on success
> + *   <0 on failure
> + */
> +static inline int
> +rule_delete(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip, uint8_t depth)
> +{
> +	int ret;
> +	struct rte_lpm6c_rule_key rule_key;
> +
> +	/* init rule key */
> +	rule_key_init(&rule_key, ip, depth);
> +
> +	/* delete the rule */
> +	ret = rte_hash_del_key(lpm->rules_tbl, (void *)&rule_key);
> +	if (ret >= 0)
> +		lpm->used_rules--;
> +
> +	return ret;
> +}
> +
> +/*
> + * Deletes a group of rules
> + */
> +int
> +rte_lpm6c_delete_bulk_func(struct rte_lpm6c *lpm,
> +		const struct rte_ipv6_addr *ips, uint8_t *depths, unsigned int n)
> +{
> +	unsigned int i;
> +
> +	/* Check input arguments. */
> +	if ((lpm == NULL) || (ips == NULL) || (depths == NULL))
> +		return -EINVAL;
> +
> +	for (i = 0; i < n; i++)
> +		rte_lpm6c_delete(lpm, &ips[i], depths[i]);
> +
> +	return 0;
> +}
> +
> +/*
> + * Delete all rules from the LPM table.
> + */
> +void
> +rte_lpm6c_delete_all(struct rte_lpm6c *lpm)
> +{
> +	/* Zero used rules counter. */
> +	lpm->used_rules = 0;
> +
> +	/* Zero tbl24. */
> +	memset(lpm->tbl24, 0, sizeof(lpm->tbl24));
> +
> +	/* Zero tbl8. */
> +	memset(lpm->tbl8, 0, sizeof(lpm->tbl8[0]) * lpm->number_tbl8s);
> +
> +	/* init pool of free tbl8 indexes */
> +	tbl8_pool_init(lpm);
> +
> +	/* Delete all rules form the rules table. */
> +	rte_hash_reset(lpm->rules_tbl);
> +}
> +
> +/*
> + *	Iterate rules
> + */
> +void
> +rte_lpm6c_rules_iterate_cb(const struct rte_lpm6c *lpm, lpm6_iter_cb cb,
> +		  void *cb_param)
> +{
> +	struct rte_lpm6c_rule_key *rule_key;
> +	uint64_t next_hop;
> +	uint32_t iter = 0;
> +
> +	while (rte_hash_iterate(lpm->rules_tbl, (void *)&rule_key,
> +			(void **)&next_hop, &iter) >= 0)
> +		cb(cb_param, &rule_key->ip, rule_key->depth, (uint32_t) next_hop);
> +}
> +
> +int32_t
> +rte_lpm6c_rules_iterate(const struct rte_lpm6c *lpm, uint32_t *iter,
> +		  const struct rte_ipv6_addr **ip, uint8_t *depth, uint32_t *next_hop)
> +{
> +	uint64_t hash_val;
> +	const struct rte_lpm6c_rule_key *rule_key;
> +
> +	int32_t ret = rte_hash_iterate(lpm->rules_tbl, (void *)&rule_key,
> +			(void **)&hash_val, iter);
> +	if (ret >= 0) {
> +		*ip = &rule_key->ip;
> +		*depth = rule_key->depth;
> +		*next_hop = (uint32_t)hash_val;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Remove an intermediate table
> + */
> +static void
> +del_intermediate_tbl(struct rte_lpm6c *lpm, uint32_t tbl_ind,
> +		  struct rte_lpm6c_tbl8_hdr *tbl_hdr)
> +{
> +	unsigned int i;
> +	struct rte_lpm6c_tbl_entry *entry, *owner_entry;
> +	struct rte_lpm6c_tbl8_hdr *ext_tbl_hdr;
> +
> +	assert(tbl_hdr->nb_ext == 1);
> +	entry = lpm->tbl8[tbl_ind].entries;
> +	for (i = 0; i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; i++, entry++)
> +		if (entry->ext_entry == 1)
> +			break;
> +	assert(i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES);
> +
> +	/*
> +	 * move found external entry from the intermediate
> +	 * table to the intermediate's parent table
> +	 */
> +	if (tbl_hdr->owner_tbl_ind == TBL24_IND)
> +		owner_entry = &lpm->tbl24[tbl_hdr->owner_entry_ind];
> +	else
> +		owner_entry = &lpm->tbl8[tbl_hdr->owner_tbl_ind].entries[
> +			tbl_hdr->owner_entry_ind];
> +	*owner_entry = *entry;
> +
> +	/* update the header of ext table */
> +	ext_tbl_hdr = &lpm->tbl8_hdrs[entry->next_hop];
> +	ext_tbl_hdr->owner_tbl_ind = tbl_hdr->owner_tbl_ind;
> +	ext_tbl_hdr->owner_entry_ind = tbl_hdr->owner_entry_ind;
> +
> +	tbl8_put(lpm, tbl_ind);
> +}
> +
> +/*
> + * Remove a table from the LPM tree
> + */
> +static void
> +remove_tbl(struct rte_lpm6c *lpm, struct rte_lpm6c_tbl8_hdr *tbl_hdr,
> +		  uint32_t tbl_ind, struct rte_lpm6c_rule *lsp_rule)
> +{
> +	struct rte_lpm6c_tbl_entry *owner_entry;
> +
> +	if (tbl_hdr->owner_tbl_ind == TBL24_IND) {
> +		owner_entry = &lpm->tbl24[tbl_hdr->owner_entry_ind];
> +		assert(owner_entry->ext_entry == 1);
> +	} else {
> +		uint32_t owner_tbl_ind;
> +		struct rte_lpm6c_tbl8_hdr *owner_tbl_hdr;
> +
> +		owner_tbl_ind = tbl_hdr->owner_tbl_ind;
> +		owner_entry = &lpm->tbl8[owner_tbl_ind].entries[
> +			tbl_hdr->owner_entry_ind];
> +		assert(owner_entry->ext_entry == 1);
> +
> +		owner_tbl_hdr = &lpm->tbl8_hdrs[owner_tbl_ind];
> +		owner_tbl_hdr->nb_ext--;
> +		if (owner_tbl_hdr->nb_ext == 1 && owner_tbl_hdr->nb_rule == 0) {
> +			/*
> +			 * down external flag in order to del_intermediate_tbl()
> +			 * find the right (last one) external entry
> +			 */
> +			owner_entry->ext_entry = 0;
> +			del_intermediate_tbl(lpm, owner_tbl_ind, owner_tbl_hdr);
> +			tbl8_put(lpm, tbl_ind);
> +			return;
> +		}
> +	}
> +
> +	/* unlink the table */
> +	if (lsp_rule != NULL) {
> +		struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +			.next_hop = lsp_rule->next_hop,
> +			.depth = lsp_rule->depth,
> +			.valid = VALID,
> +			.valid_group = VALID,
> +			.ext_entry = 0
> +		};
> +
> +		*owner_entry = new_tbl_entry;
> +	} else {
> +		struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +			.next_hop = 0,
> +			.depth = 0,
> +			.valid = INVALID,
> +			.valid_group = INVALID,
> +			.ext_entry = 0
> +		};
> +
> +		*owner_entry = new_tbl_entry;
> +	}
> +
> +	/* return the table to the pool */
> +	tbl8_put(lpm, tbl_ind);
> +}
> +
> +/*
> + * Find range of tbl8 cells occupied by a rule
> + */
> +static void
> +rule_find_range(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, struct rte_lpm6c_tbl_entry **from,
> +		  struct rte_lpm6c_tbl_entry **to,
> +		  uint32_t *out_tbl_ind)
> +{
> +	uint32_t ind = 0;
> +	uint32_t first_3bytes = RTE_LPM6C_ROOT_TBL_IND(ip);
> +
> +	if (depth <= RTE_LPM6C_ROOT_LEVEL_BITS) {
> +		/* rule is within the top level */
> +		ind = first_3bytes;
> +		*from = &lpm->tbl24[ind];
> +		ind += (1 << (24 - depth)) - 1;
> +		*to = &lpm->tbl24[ind];
> +		*out_tbl_ind = TBL24_IND;
> +	} else {
> +		int i;
> +		uint32_t level = 0;
> +		uint32_t tbl_ind = 0;
> +		struct rte_lpm6c_tbl_entry *entry;
> +		struct rte_lpm6c_tbl_entry *entries = NULL;
> +
> +		/* top level entry */
> +		entry = &lpm->tbl24[first_3bytes];
> +		assert(entry->ext_entry == 1);
> +		/* iterate through levels until we reach the last one */
> +		do {
> +			if (level_to_depth(entry->depth) >= depth)
> +				break;
> +			level = entry->depth;
> +			tbl_ind = entry->lpm6_tbl8_ind;
> +			entries = lpm->tbl8[tbl_ind].entries;
> +			ind = ip->a[RTE_LPM6C_ROOT_LEV_BYTES + level - 1];
> +			entry = &entries[ind];
> +		} while (entry->ext_entry == 1);
> +
> +		/* last level */
> +		*from = entry;
> +		assert(depth > level_to_depth(level));
> +		i = depth - level_to_depth(level);
> +		assert(i <= RTE_LPM6C_BYTE_SIZE);
> +		ind += (1 << (RTE_LPM6C_BYTE_SIZE - i)) - 1;
> +		assert(entries != NULL);
> +		*to = &entries[ind];
> +		*out_tbl_ind = tbl_ind;
> +	}
> +}
> +
> +/*
> + * Deletes a rule
> + */
> +int
> +rte_lpm6c_delete(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth)
> +{
> +	struct rte_ipv6_addr masked_ip;
> +	struct rte_lpm6c_rule lsp_rule_obj;
> +	struct rte_lpm6c_rule *lsp_rule;
> +	int ret;
> +	uint32_t tbl_ind;
> +	struct rte_lpm6c_tbl_entry *from, *to;
> +	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
> +
> +	/* Check input arguments. */
> +	if ((lpm == NULL) || (depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
> +		return -EINVAL;
> +
> +	/* Copy the IP and mask it to avoid modifying user's input data. */
> +	masked_ip = *ip;
> +	rte_ipv6_addr_mask(&masked_ip, depth);
> +
> +	/* Delete the rule from the rule table. */
> +	ret = rule_delete(lpm, &masked_ip, depth);
> +	if (ret < 0)
> +		return -ENOENT;
> +
> +	/* find rule cells */
> +	rule_find_range(lpm, &masked_ip, depth, &from, &to, &tbl_ind);
> +
> +	/* find a less specific rule (a rule with smaller depth)
> +	 * note: masked_ip will be modified, don't use it anymore
> +	 */
> +	ret = rule_find_less_specific(lpm, &masked_ip, depth,
> +			&lsp_rule_obj);
> +	lsp_rule = ret ? &lsp_rule_obj : NULL;
> +
> +	/* decrement the number of rules in the table
> +	 * note that tbl24 doesn't have a header
> +	 */
> +	if (tbl_ind != TBL24_IND) {
> +		tbl_hdr = &lpm->tbl8_hdrs[tbl_ind];
> +		tbl_hdr->nb_rule--;
> +		if (tbl_hdr->nb_rule == 0 && tbl_hdr->nb_ext == 0) {
> +			/* remove the table */
> +			remove_tbl(lpm, tbl_hdr, tbl_ind, lsp_rule);
> +			return 0;
> +		}
> +	}
> +
> +	/* iterate rule cells */
> +	for (; from <= to; from++)
> +		if (from->ext_entry == 1) {
> +			/* reference to a more specific space
> +			 * of the prefix/rule. Entries in a more
> +			 * specific space that are not used by
> +			 * a more specific prefix must be occupied
> +			 * by the prefix
> +			 */
> +			if (lsp_rule != NULL)
> +				expand_rule(lpm,
> +					from->lpm6_tbl8_ind,
> +					depth, lsp_rule->depth,
> +					lsp_rule->next_hop, VALID);
> +			else
> +				/* since the prefix has no less specific prefix,
> +				 * its more specific space must be invalidated
> +				 */
> +				expand_rule(lpm,
> +					from->lpm6_tbl8_ind,
> +					depth, 0, 0, INVALID);
> +		} else if (from->depth == depth) {
> +			/* entry is not a reference and belongs to the prefix */
> +			if (lsp_rule != NULL) {
> +				struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +					.next_hop = lsp_rule->next_hop,
> +					.depth = lsp_rule->depth,
> +					.valid = VALID,
> +					.valid_group = VALID,
> +					.ext_entry = 0
> +				};
> +
> +				*from = new_tbl_entry;
> +			} else {
> +				struct rte_lpm6c_tbl_entry new_tbl_entry = {
> +					.next_hop = 0,
> +					.depth = 0,
> +					.valid = INVALID,
> +					.valid_group = INVALID,
> +					.ext_entry = 0
> +				};
> +
> +				*from = new_tbl_entry;
> +			}
> +		}
> +
> +	if (tbl_ind != TBL24_IND && tbl_hdr->nb_rule == 0 && tbl_hdr->nb_ext == 1)
> +		del_intermediate_tbl(lpm, tbl_ind, tbl_hdr);
> +
> +	return 0;
> +}
> +
> +uint32_t
> +rte_lpm6c_pool_pos(struct rte_lpm6c *lpm)
> +{
> +	return lpm->tbl8_pool_pos;
> +}
> +
> +uint32_t
> +rte_lpm6c_used_rules(struct rte_lpm6c *lpm)
> +{
> +	return lpm->used_rules;
> +}
> diff --git a/lib/lpm/rte_lpm6c.h b/lib/lpm/rte_lpm6c.h
> new file mode 100644
> index 0000000000..79286d5ccc
> --- /dev/null
> +++ b/lib/lpm/rte_lpm6c.h
> @@ -0,0 +1,560 @@
> +/*
> + * SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
> + */
> +#ifndef _RTE_LPM6C_H_
> +#define _RTE_LPM6C_H_
> +
> +/**
> + * @file
> + * Longest Prefix Match for IPv6 (LPM6)
> + * Path Compressed DIR24-8(n) trie.
> + */
> +
> +#include <sys/cdefs.h>
> +
> +__BEGIN_DECLS
> +
> +#include <stdint.h>
> +#include <rte_compat.h>
> +#include <rte_branch_prediction.h>
> +#include <rte_memory.h>
> +#include <rte_ip6.h>
> +
> +/** Max number of characters in LPM name. */
> +#define RTE_LPM6C_NAMESIZE                 32
> +
> +#define RTE_LPM6C_ROOT_LEVEL_BITS                24
> +#define RTE_LPM6C_TBL24_NUM_ENTRIES        (1 << RTE_LPM6C_ROOT_LEVEL_BITS)
> +#define RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES         256
> +#define RTE_LPM6C_TBL8_MAX_NUM_GROUPS      (1 << 21)
> +
> +#define RTE_LPM6C_VALID_EXT_ENTRY_BITMASK 0xA0000000
> +#define RTE_LPM6C_LOOKUP_SUCCESS          0x20000000
> +#define RTE_LPM6C_TBL8_BITMASK            0x001FFFFF
> +
> +#define RTE_LPM6C_DEPTH(x)      (((x) >> 21) & 0xFF)
> +
> +#define RTE_LPM6C_ROOT_LEV_BYTES                  3
> +#define RTE_LPM6C_BYTE_SIZE                       8
> +#define RTE_LPM6C_BYTES2_SIZE                    16
> +
> +#define RTE_LPM6C_ROOT_TBL_IND(ip) (\
> +			  (uint32_t)ip->a[0] << RTE_LPM6C_BYTES2_SIZE | \
> +			  (uint32_t)ip->a[1] << RTE_LPM6C_BYTE_SIZE | ip->a[2])
> +
> +#define lpm6_tbl8_ind next_hop
> +
> +#define MIN_TBL8_REQ_FOR_ADD 14
> +
> +#define RTE_LPM6C_UNDEF_NEXT_HOP         UINT32_MAX
> +
> +/** Flags for setting an entry as valid/invalid. */
> +enum valid_flag {
> +	INVALID = 0,
> +	VALID
> +};
> +
> +/** Tbl entry structure. It is the same for both tbl24 and tbl8 */
> +struct rte_lpm6c_tbl_entry {
> +	uint32_t next_hop:	21;  /**< Next hop / next table to be checked. */
> +	uint32_t depth	:8; /**< Either a rule depth or a tree next level if
> +	                     * it's an external entry
> +	                     */
> +	/* Flags. */
> +	uint32_t valid     :1;   /**< Validation flag. */
> +	uint32_t valid_group :1; /**< Group validation flag. */
> +	uint32_t ext_entry :1;   /**< External entry. */
> +};
> +
> +/**
> + * tbl8
> + */
> +#define SIZEOF_TBL8_UNPADDED \
> +	(RTE_IPV6_ADDR_SIZE + \
> +	sizeof(uint32_t) + \
> +	sizeof(struct rte_lpm6c_tbl_entry[RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES]))
> +
> +#define PADDING_TBL8 ((RTE_CACHE_LINE_SIZE - \
> +	(SIZEOF_TBL8_UNPADDED % RTE_CACHE_LINE_SIZE)) % RTE_CACHE_LINE_SIZE)
> +
> +struct rte_lpm6c_tbl8 {
> +	struct rte_ipv6_addr ip;
> +	uint32_t lsp_next_hop;
> +	struct rte_lpm6c_tbl_entry entries[RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES];
> +	uint8_t padding[PADDING_TBL8];
> +}
> +__rte_cache_aligned;
> +
> +/** Rules tbl entry structure. */
> +struct rte_lpm6c_rule {
> +	struct rte_ipv6_addr ip; /**< Rule IP address. */
> +	uint32_t next_hop; /**< Rule next hop. */
> +	uint8_t depth; /**< Rule depth. */
> +};
> +
> +/** Rules tbl entry key. */
> +struct rte_lpm6c_rule_key {
> +	struct rte_ipv6_addr ip; /**< Rule IP address. */
> +	uint32_t depth; /**< Rule depth. */
> +};
> +
> +/* Header of tbl8 */
> +struct rte_lpm6c_tbl8_hdr {
> +	uint32_t owner_tbl_ind; /**< owner table: TBL24_IND if owner is tbl24,
> +	                          * otherwise index of tbl8
> +	                          */
> +	uint32_t owner_entry_ind; /**< index of the owner table entry where
> +	                            * pointer to the tbl8 is stored
> +	                            */
> +
> +	uint32_t nb_rule; /**< number of rules  */
> +	uint32_t nb_ext; /**< number of external entries */
> +
> +	uint8_t depth;
> +	uint8_t lsp_depth;
> +}
> +__rte_cache_aligned;
> +
> +/** LPM6 structure. */
> +struct rte_lpm6c {
> +	uint32_t max_rules;              /**< Max number of rules. */
> +	uint32_t used_rules;             /**< Used rules so far. */
> +	uint32_t number_tbl8s;           /**< Number of tbl8s to allocate. */
> +
> +	uint32_t tbl8_pool_pos; /**< current position in the tbl8 pool */
> +
> +	/* next hop index */
> +	uint32_t default_next_hop_ind;
> +
> +	/* LPM Tables. */
> +	struct rte_hash *rules_tbl; /**< LPM rules. */
> +	struct rte_lpm6c_tbl8_hdr *tbl8_hdrs; /* array of tbl8 headers */
> +	uint32_t *tbl8_pool; /**< pool of indexes of free tbl8s */
> +
> +	/* LPM metadata. */
> +	char name[RTE_LPM6C_NAMESIZE];    /**< Name of the lpm. */
> +
> +	alignas(RTE_CACHE_LINE_SIZE) struct rte_lpm6c_tbl_entry
> +			  tbl24[RTE_LPM6C_TBL24_NUM_ENTRIES]; /**< LPM tbl24 table. */
> +
> +	alignas(RTE_CACHE_LINE_SIZE) struct rte_lpm6c_tbl8 tbl8[0];
> +			  /**< LPM tbl8 table. */
> +};
> +
> +/** LPM configuration structure. */
> +struct rte_lpm6c_config {
> +	uint32_t max_rules;      /**< Max number of rules. */
> +	uint32_t number_tbl8s;   /**< Number of tbl8s to allocate. */
> +	int flags;               /**< This field is currently unused. */
> +};
> +
> +/**
> + * Create an LPM object.
> + *
> + * @param name
> + *   LPM object name
> + * @param socket_id
> + *   NUMA socket ID for LPM table memory allocation
> + * @param config
> + *   Structure containing the configuration
> + * @return
> + *   Handle to LPM object on success, NULL otherwise with rte_errno set
> + *   to an appropriate values. Possible rte_errno values include:
> + *    - EINVAL - invalid parameter passed to function
> + *    - EEXIST - a memzone with the same name already exists
> + *    - ENOMEM - no appropriate memory area found in which to create memzone
> + */
> +struct rte_lpm6c *
> +rte_lpm6c_create(const char *name, int socket_id,
> +		const struct rte_lpm6c_config *config);
> +
> +/**
> + * Find an existing LPM object and return a pointer to it.
> + *
> + * @param name
> + *   Name of the lpm object as passed to rte_lpm6c_create()
> + * @return
> + *   Pointer to lpm object or NULL if object not found with rte_errno
> + *   set appropriately. Possible rte_errno values include:
> + *    - ENOENT - required entry not available to return.
> + */
> +struct rte_lpm6c *
> +rte_lpm6c_find_existing(const char *name);
> +
> +/**
> + * Free an LPM object.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @return
> + *   None
> + */
> +void
> +rte_lpm6c_free(struct rte_lpm6c *lpm);
> +
> +/**
> + * Add a rule to the LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ip
> + *   IP of the rule to be added to the LPM table
> + * @param depth
> + *   Depth of the rule to be added to the LPM table
> + * @param next_hop
> + *   Next hop of the rule to be added to the LPM table
> + * @return
> + *   0 on success, negative value otherwise
> + */
> +int
> +rte_lpm6c_add(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t next_hop);
> +
> +/**
> + * Check if a rule is present in the LPM table,
> + * and provide its next hop if it is.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ip
> + *   IP of the rule to be searched
> + * @param depth
> + *   Depth of the rule to searched
> + * @param next_hop
> + *   Next hop of the rule (valid only if it is found)
> + * @return
> + *   1 if the rule exists, 0 if it does not, a negative value on failure
> + */
> +int
> +rte_lpm6c_is_rule_present(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t *next_hop);
> +
> +/**
> + * Delete a rule from the LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ip
> + *   IP of the rule to be deleted from the LPM table
> + * @param depth
> + *   Depth of the rule to be deleted from the LPM table
> + * @return
> + *   0 on success, negative value otherwise
> + */
> +int
> +rte_lpm6c_delete(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		  uint8_t depth);
> +
> +/**
> + * Delete a rule from the LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ips
> + *   Array of IPs to be deleted from the LPM table
> + * @param depths
> + *   Array of depths of the rules to be deleted from the LPM table
> + * @param n
> + *   Number of rules to be deleted from the LPM table
> + * @return
> + *   0 on success, negative value otherwise.
> + */
> +int
> +rte_lpm6c_delete_bulk_func(struct rte_lpm6c *lpm,
> +		const struct rte_ipv6_addr *ips, uint8_t *depths, unsigned int n);
> +
> +/**
> + * Delete all rules from the LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + */
> +void
> +rte_lpm6c_delete_all(struct rte_lpm6c *lpm);
> +
> +/**
> + * Returns number of free tbl8s
> + *
> + * @param lpm
> + *   LPM object
> + *  @return
> + *   number of free tbl8
> + */
> +uint32_t
> +rte_lpm6c_tbl8_available(struct rte_lpm6c *lpm);
> +
> +/**
> + * Returns number of tbl8s in use
> + *
> + * @param lpm
> + *   LPM object
> + *  @return
> + *   number of tbl8 in use
> + */
> +uint32_t
> +rte_lpm6c_tbl8_in_use(struct rte_lpm6c *lpm);
> +
> +typedef void (*lpm6_iter_cb) (void *cb_param, struct rte_ipv6_addr *ip,
> +		  uint8_t depth, uint32_t next_hop);
> +
> +int32_t
> +rte_lpm6c_rules_iterate(const struct rte_lpm6c *lpm, uint32_t *iter,
> +		  const struct rte_ipv6_addr **ip, uint8_t *depth, uint32_t *next_hop);
> +
> +void
> +rte_lpm6c_rules_iterate_cb(const struct rte_lpm6c *lpm, lpm6_iter_cb cb,
> +		  void *cb_param);
> +
> +/**
> + * Lookup an IP into the LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ip
> + *   IP to be looked up in the LPM table
> + * @param next_hop
> + *   Next hop of the most specific rule found for IP (valid on lookup hit only)
> + * @return
> + *   -EINVAL for incorrect arguments, -ENOENT on lookup miss, 0 on lookup hit
> + */
> +static inline int
> +rte_lpm6c_lookup(const struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
> +		uint32_t *next_hop)
> +{
> +	uint32_t entry_val, tbl_ind, i, byte_ind, level;
> +	const struct rte_lpm6c_tbl8 *tbl;
> +	const struct rte_lpm6c_tbl_entry *entry;
> +
> +	/* DEBUG: Check user input arguments. */
> +	if (unlikely(lpm == NULL) || (ip == NULL) || (next_hop == NULL))
> +		return -EINVAL;
> +
> +	byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
> +	tbl_ind = RTE_LPM6C_ROOT_TBL_IND(ip);
> +	/* Calculate pointer to the first entry to be inspected */
> +	entry = &lpm->tbl24[tbl_ind];
> +
> +	do {
> +		/* Take the integer value from the pointer. */
> +		entry_val = *(const uint32_t *)entry;
> +		tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
> +
> +		if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
> +				RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
> +			*next_hop = tbl_ind;
> +			return (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ? 0 : -ENOENT;
> +		}
> +
> +		/* If it is valid and extended we calculate the new pointer to return. */
> +		level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
> +		tbl = &lpm->tbl8[tbl_ind];
> +
> +		/*
> +		 * if some levels were skipped then make sure that
> +		 * the ip matches the ip address of a table we've jumped to,
> +		 * i.e. check the ip's bytes corresponding the skipped levels.
> +		 */
> +		for (i = byte_ind; i < level; i++)
> +			if (tbl->ip.a[i] != ip->a[i]) {
> +				if (tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP)
> +					return -ENOENT;
> +				*next_hop = tbl->lsp_next_hop;
> +				return 0;
> +			}
> +
> +		/* move ip byte index one byte further */
> +		byte_ind = level + 1;
> +		/* go to next level */
> +		entry = &tbl->entries[ip->a[level]];
> +	} while (true);
> +}
> +
> +/**
> + * Lookup multiple IP addresses in an LPM table.
> + *
> + * @param lpm
> + *   LPM object handle
> + * @param ips
> + *   Array of IPs to be looked up in the LPM table
> + * @param next_hops
> + *   Next hop of the most specific rule found for IP (valid on lookup hit only).
> + *   This is an array of two byte values. The next hop will be stored on
> + *   each position on success; otherwise the position will be set to -1.
> + * @param n
> + *   Number of elements in ips (and next_hops) array to lookup.
> + *  @return
> + *   -EINVAL for incorrect arguments, otherwise 0
> + */
> +static inline int
> +rte_lpm6c_lookup_bulk(const struct rte_lpm6c *lpm,
> +		  const struct rte_ipv6_addr *ips,
> +		  int32_t *next_hops, const unsigned int n)
> +{
> +	uint32_t entry_val, tbl_ind, i, byte_ind, level;
> +	unsigned int j;
> +	const unsigned int n_unrolled = n & ~1U; /* Process pairs of IPs */
> +	const struct rte_lpm6c_tbl8 *tbl;
> +
> +	/* DEBUG: Check user input arguments. */
> +	if (unlikely(lpm == NULL) || (ips == NULL) || (next_hops == NULL))
> +		return -EINVAL;
> +
> +	/* Unrolled loop processing two lookups at a time */
> +	for (j = 0; j < n_unrolled; j += 2) {
> +		const struct rte_lpm6c_tbl_entry *entry0, *entry1;
> +		const struct rte_ipv6_addr *ip0, *ip1;
> +
> +		/* Start processing two independent lookups */
> +		ip0 = &ips[j];
> +		ip1 = &ips[j + 1];
> +
> +		entry0 = &lpm->tbl24[RTE_LPM6C_ROOT_TBL_IND(ip0)];
> +		entry1 = &lpm->tbl24[RTE_LPM6C_ROOT_TBL_IND(ip1)];
> +
> +		/* Lookup for IP #0 */
> +		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
> +		do {
> +			/* Take the integer value from the pointer. */
> +			entry_val = *(const uint32_t *)entry0;
> +			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
> +
> +			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
> +					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
> +				next_hops[j] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
> +						  (int32_t)tbl_ind : -1;
> +				break;
> +			}
> +
> +			/*
> +			 * If it is valid and extended we calculate the new pointer
> +			 * to return.
> +			 */
> +			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
> +			tbl = &lpm->tbl8[tbl_ind];
> +
> +			/*
> +			 * if some levels were skipped then make sure that
> +			 * the ip matches the ip address of a table we've jumped to,
> +			 * i.e. check the ip's bytes corresponding the skipped levels.
> +			 */
> +			for (i = byte_ind; i < level; i++)
> +				if (tbl->ip.a[i] != ip0->a[i]) {
> +					next_hops[j] = tbl->lsp_next_hop ==
> +							  RTE_LPM6C_UNDEF_NEXT_HOP ?
> +						-1 : (int32_t)tbl->lsp_next_hop;
> +					goto next_ip0;
> +				}
> +
> +			/* move ip byte index one byte further */
> +			byte_ind = level + 1;
> +			/* go to next level */
> +			entry0 = &tbl->entries[ip0->a[level]];
> +		} while (true);
> +
> +next_ip0:
> +		/* Lookup for IP #1 */
> +		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
> +		do {
> +			/* Take the integer value from the pointer. */
> +			entry_val = *(const uint32_t *)entry1;
> +			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
> +
> +			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
> +					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
> +				next_hops[j + 1] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
> +						  (int32_t)tbl_ind : -1;
> +				break;
> +			}
> +
> +			/*
> +			 * If it is valid and extended we calculate the new pointer
> +			 * to return.
> +			 */
> +			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
> +			tbl = &lpm->tbl8[tbl_ind];
> +
> +			/*
> +			 * if some levels were skipped then make sure that
> +			 * the ip matches the ip address of a table we've jumped to,
> +			 * i.e. check the ip's bytes corresponding the skipped levels.
> +			 */
> +			for (i = byte_ind; i < level; i++)
> +				if (tbl->ip.a[i] != ip1->a[i]) {
> +					next_hops[j + 1] =
> +						tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP ?
> +							-1 : (int32_t)tbl->lsp_next_hop;
> +					goto next_ip1;
> +				}
> +
> +			/* move ip byte index one byte further */
> +			byte_ind = level + 1;
> +			/* go to next level */
> +			entry1 = &tbl->entries[ip1->a[level]];
> +		} while (true);
> +
> +next_ip1:;
> +	}
> +
> +	for (; j < n; j++) {
> +		const struct rte_lpm6c_tbl_entry *entry;
> +		const struct rte_ipv6_addr *ip0 = &ips[j];
> +
> +		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
> +		tbl_ind = RTE_LPM6C_ROOT_TBL_IND(ip0);
> +		/* Calculate pointer to the first entry to be inspected */
> +		entry = &lpm->tbl24[tbl_ind];
> +
> +		do {
> +			/* Take the integer value from the pointer. */
> +			entry_val = *(const uint32_t *)entry;
> +			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
> +
> +			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
> +					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
> +				next_hops[j] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
> +						  (int32_t)tbl_ind : -1;
> +				break;
> +			}
> +
> +			/*
> +			 * If it is valid and extended we calculate the new pointer
> +			 * to return.
> +			 */
> +			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
> +			tbl = &lpm->tbl8[tbl_ind];
> +
> +			/*
> +			 * if some levels were skipped then make sure that
> +			 * the ip matches the ip address of a table we've jumped to,
> +			 * i.e. check the ip's bytes corresponding the skipped levels.
> +			 */
> +			for (i = byte_ind; i < level; i++)
> +				if (tbl->ip.a[i] != ip0->a[i]) {
> +					next_hops[j] = tbl->lsp_next_hop ==
> +							  RTE_LPM6C_UNDEF_NEXT_HOP ?
> +						-1 : (int32_t)tbl->lsp_next_hop;
> +					goto next_ip;
> +				}
> +
> +			/* move ip byte index one byte further */
> +			byte_ind = level + 1;
> +			/* go to next level */
> +			entry = &tbl->entries[ip0->a[level]];
> +		} while (true);
> +
> +next_ip:;
> +	}
> +
> +	return 0;
> +}
> +
> +uint32_t
> +rte_lpm6c_pool_pos(struct rte_lpm6c *lpm);
> +
> +uint32_t
> +rte_lpm6c_used_rules(struct rte_lpm6c *lpm);
> +
> +__END_DECLS
> +
> +#endif

