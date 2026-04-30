Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94843FF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 12:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDA8402A0;
	Thu, 30 Apr 2026 14:33:13 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 71A184021F;
 Thu, 30 Apr 2026 14:33:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5tpx4w3ZzHnGd0;
 Thu, 30 Apr 2026 20:32:25 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 78AF94058D;
 Thu, 30 Apr 2026 20:33:11 +0800 (CST)
Received: from frapema100003.china.huawei.com (7.182.19.100) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Apr 2026 14:33:11 +0200
Received: from frapema100003.china.huawei.com ([7.182.19.100]) by
 frapema100003.china.huawei.com ([7.182.19.100]) with mapi id 15.02.1544.036;
 Thu, 30 Apr 2026 14:33:11 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Weijun Pan <wpan3636@gmail.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Deepak Kumar Jain <deepak.k.jain@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH 1/2] test: use inline helpers in buffer comparison macros
Thread-Topic: [PATCH 1/2] test: use inline helpers in buffer comparison macros
Thread-Index: AQHc1+cY0e71C4rrT0ykePhvnCDqlbX3gA1g
Date: Thu, 30 Apr 2026 12:33:11 +0000
Message-ID: <c842fc3b7ea640879e374897858cf051@huawei.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260429144632.164970-1-stephen@networkplumber.org>
 <20260429144632.164970-2-stephen@networkplumber.org>
In-Reply-To: <20260429144632.164970-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

With or without addressing inline comments below,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 29 April 2026 15:42
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Weijun Pan <wpan3636@=
gmail.com>; stable@dpdk.org;
> Deepak Kumar Jain <deepak.k.jain@intel.com>; Pablo de Lara <pablo.de.lara=
.guarch@intel.com>
> Subject: [PATCH 1/2] test: use inline helpers in buffer comparison macros
>=20
> The TEST_ASSERT_BUFFERS_ARE_EQUAL family of macros had several
> problems stemming from doing all the work inside the macro body:
>=20
>  - Macro parameters were used directly in arithmetic expressions
>    without parentheses.
>  - Arguments were evaluated multiple times.
>  - There was no type checking.
>=20
> In addition, the _OFFSET and _BIT_OFFSET wrappers chained to the
> inner assertion macro passing only "msg" and dropped the variadic
> arguments, so any printf parameters after the format string were
> silently lost on failure.
>=20
> Move the comparison logic into static inline helpers and keep the
> macros as thin wrappers around the printf / TEST_TRACE_FAILURE /
> return TEST_FAILED boilerplate (which must remain a macro to
> capture __func__ / __LINE__ and to return from the caller).
> Each argument is now evaluated exactly once where the macro hands
> it to the helper, the size_t parameters give the compiler real
> types to check against, and the bit-mask arithmetic lives in C
> rather than the preprocessor.  Existing call sites need no
> changes.
>=20
> Bugzilla ID: 1925
> Suggested-by: Weijun Pan <wpan3636@gmail.com>
> Fixes: db4faf469816 ("app/test: add new buffer comparison macros")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test.h | 147 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 95 insertions(+), 52 deletions(-)
>=20
> diff --git a/app/test/test.h b/app/test/test.h
> index 1f12fc5397..ebf6727639 100644
> --- a/app/test/test.h
> +++ b/app/test/test.h
> @@ -6,8 +6,12 @@
>  #define _TEST_H_
>=20
>  #include <errno.h>
> +#include <stdbool.h>
>  #include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <sys/queue.h>
>=20
>  #include <rte_hexdump.h>
> @@ -32,70 +36,109 @@
>=20
>  #define TEST_ASSERT_EQUAL RTE_TEST_ASSERT_EQUAL
>=20
> +/*
> + * Helpers backing the TEST_ASSERT_BUFFERS_ARE_EQUAL* macros.
> + *
> + * Keeping the comparison logic in inline functions ensures each macro
> + * argument is evaluated exactly once and gives the compiler real types
> + * to check against, which the original all-macro implementation could
> + * not provide.
> + */
> +static inline bool
> +test_buffers_equal(const void *a, const void *b, size_t len)
> +{
> +	return memcmp(a, b, len) =3D=3D 0;
> +}

Not sure it's really justified to define a separate function for this, coul=
d
either use memcmp directly or if striving for symmetry call
test_buffers_equal_offset with zero last argument.

> +
> +static inline bool
> +test_buffers_equal_offset(const void *a, const void *b,
> +		size_t len, size_t off)
> +{
> +	const uint8_t *pa =3D (const uint8_t *)a + off;
> +	const uint8_t *pb =3D (const uint8_t *)b + off;
> +
> +	return memcmp(pa, pb, len) =3D=3D 0;
> +}
> +
> +static inline bool
> +test_buffers_equal_bit(const void *a, const void *b, size_t len)
> +{
> +	const uint8_t *pa =3D a;
> +	const uint8_t *pb =3D b;
> +	size_t whole =3D len >> 3;
> +	size_t extra =3D len & 7;
> +
> +	if (memcmp(pa, pb, whole) !=3D 0)
> +		return false;
> +	if (extra !=3D 0) {
> +		uint8_t mask =3D (uint8_t)~((1U << (8 - extra)) - 1);

I know this is from the original, but I think we had some macros for this l=
ike
RTE_GENMASK32.

> +
> +		if ((pa[whole] & mask) !=3D (pb[whole] & mask))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static inline bool
> +test_buffers_equal_bit_offset(const void *a, const void *b,
> +		size_t len, size_t off)
> +{
> +	const uint8_t *pa =3D a;
> +	const uint8_t *pb =3D b;
> +	size_t off_bits =3D off & 7;
> +	size_t off_bytes =3D off >> 3;

Would be nice to have some consistency in naming these.

> +
> +	if (off_bits !=3D 0) {
> +		uint8_t first_bits =3D 8 - off_bits;
> +		uint8_t mask =3D (1U << first_bits) - 1;

Could use a standard macro here as well.

> +
> +		if ((pa[off_bytes] & mask) !=3D (pb[off_bytes] & mask))
> +			return false;
> +		off_bytes++;
> +		len -=3D first_bits;

Would an assert that len >=3D first_bits make sense before this line?

> +	}
> +	return test_buffers_equal_bit(pa + off_bytes, pb + off_bytes, len);
> +}
> +

// skip the rest
