Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF5CA5FAD
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 00:49:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F30E7402A2;
	Wed, 30 Sep 2026 02:49:38 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id DACE6400EF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 02:49:36 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qVcrNgBdLkwefT/8QXqpHTe30JeA1wl9qHLFR5TpCxY=;
 b=xnWgCZGnI6ioIFUM/YCD4rp78SDZ7+a1DeZlC4ic0B2aAzBTwRS2YlomSrm0ENc+raNTJ4d33
 Vnnr7sc2RphJxD5taevTxt/Nn710WxJ782XfmgkYVI4ZVGMH66A56agetnwd35W8YTy7V66s3co
 ndfVLzcGgook+fvoMJFj4L8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hvbkQ15rfz1cyV9;
 Wed, 30 Sep 2026 08:38:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 93B9940578;
 Wed, 30 Sep 2026 08:49:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 30 Sep 2026 08:49:28 +0800
Message-ID: <7138b15e-91d0-422d-b909-0ed628136e14@huawei.com>
Date: Wed, 30 Sep 2026 08:49:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/61] kvargs: add numeric conversion helpers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
 <20260929163800.1108305-2-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260929163800.1108305-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 9/30/2026 12:36 AM, Stephen Hemminger wrote:
> Drivers which take numeric values in devargs each open code the
> conversion from string to integer, and often get it wrong.
> A survey of the tree finds at least fifteen separate
> implementations of "parse an unsigned integer devarg", of which two are
> exported from lib/ and byte for byte identical to each other.
> 
> The recurring bugs are:
> 
>   - atoi() is used, so overflow is undefined and nothing is validated;
>   - errno is checked without being reset first, so an unrelated earlier
>     failure rejects a valid value;
>   - errno is checked but endptr is not, so "foo" is silently accepted
>     as zero;
>   - endptr is checked but errno is not, so an overflowing value is
>     accepted as ULLONG_MAX;
>   - the result is stored into a narrower type with no range check, so
>     nb_desc=65537 silently becomes 1;
>   - strtoul() is used for an unsigned target, so a leading '-' is
>     accepted and wrapped around, and dev_caps_mask=-1 enables
>     everything;
>   - the value is dereferenced without checking for NULL, so a key given
>     with no value segfaults;
>   - base 0 is passed, so a leading zero unexpectedly selects octal.
> 
> Add a set of helpers matching arg_handler_t, so they can be passed
> straight to rte_kvargs_process(), covering the integer types drivers
> actually store into. Each validates the whole string and only writes
> the target on success, so a caller supplied default survives a bad
> argument.
> 
> Add rte_kvargs_handle_bool for on/off style arguments. It accepts the
> word forms which only sfc supports today, and treats a key given
> without a value as true.
> 
> Where a driver needs a range narrower than the target type, expose the
> underlying rte_kvargs_to_uint and rte_kvargs_to_int.
> 
> Octal is deliberately not supported: no driver documents it, and
> reading "010" as eight has been a recurring surprise.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

...

> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Convert a string to a signed integer, checking it against a range.
> + *
> + * This is the signed counterpart of rte_kvargs_to_uint().
> + *
> + * @param value
> + *   The string to convert. Must be non-NULL and non-empty. See
> + *   rte_kvargs_handle_u8() for the accepted syntax.
> + * @param min
> + *   Smallest acceptable value, inclusive.
> + * @param max
> + *   Largest acceptable value, inclusive.
> + * @param result
> + *   Where to store the converted value. Left unmodified on error.
> + *
> + * @return
> + *   - 0 on success.
> + *   - -EINVAL if the value is missing or malformed, or if @p result is NULL.
> + *   - -ERANGE if the value is outside [@p min, @p max].
> + */
> +__rte_experimental
> +int rte_kvargs_to_int(const char *value, int64_t min, int64_t max,
> +	int64_t *result);

How about rte_kvargs_handle_int_range() ?

> +
>  #ifdef __cplusplus
>  }
>  #endif

