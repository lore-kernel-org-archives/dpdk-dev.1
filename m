Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A758AFE51F3
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 09:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C93E2402A2;
	Fri, 24 Apr 2026 11:48:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BB584402A0
 for <dev@dpdk.org>; Fri, 24 Apr 2026 11:48:50 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g27SJ2SyTzHnGgq;
 Fri, 24 Apr 2026 17:48:16 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 0761B40571;
 Fri, 24 Apr 2026 17:48:50 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Apr 2026 11:48:49 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 24 Apr 2026 11:48:49 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Weijun Pan <wpan3636@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Weijun Pan <wpan36@wisc.edu>
Subject: RE: [PATCH] test: parenthesize assertion macro parameters
Thread-Topic: [PATCH] test: parenthesize assertion macro parameters
Thread-Index: AQHc07mjaNfZv7wizk6bjM4u9S39fbXt62oQ
Date: Fri, 24 Apr 2026 09:48:49 +0000
Message-ID: <254bea4a0dcf4161bbecc563dc65b0db@huawei.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
In-Reply-To: <20260419164818.20609-1-wpan36@wisc.edu>
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

Hi, thanks for doing this! Please see some comments inline below.

> -----Original Message-----
> From: Weijun Pan <wpan3636@gmail.com>
> Sent: Sunday 19 April 2026 17:48
> Cc: dev@dpdk.org; Weijun Pan <wpan36@wisc.edu>
> Subject: [PATCH] test: parenthesize assertion macro parameters
>=20
> Some test assertion macros use parameters directly in expressions,
> which can lead to unexpected evaluation due to operator precedence
> after macro substitution.
>=20
> Fix this by parenthesizing macro parameters and the resulting
> expressions in rte_test.h and app/test/test.h.
>=20
> Bugzilla ID: 1925
>=20
> Signed-off-by: Weijun Pan <wpan36@wisc.edu>
> ---
>  app/test/test.h            | 34 +++++++++++++++++-----------------
>  lib/eal/include/rte_test.h | 12 ++++++------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/app/test/test.h b/app/test/test.h
> index 1f12fc5397..b1174e4973 100644
> --- a/app/test/test.h
> +++ b/app/test/test.h
> @@ -34,7 +34,7 @@
>=20
>  /* Compare two buffers (length in bytes) */
>  #define TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, len,  msg, ...) do {	\
> -	if (memcmp(a, b, len)) {                                        \
> +	if (memcmp((a), (b), (len))) {                                        \
>  		printf("TestCase %s() line %d failed: "              \
>  			msg "\n", __func__, __LINE__, ##__VA_ARGS__);    \
>  		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);    \
> @@ -44,21 +44,21 @@
>=20
>  /* Compare two buffers with offset (length and offset in bytes) */
>  #define TEST_ASSERT_BUFFERS_ARE_EQUAL_OFFSET(a, b, len, off, msg, ...) d=
o { \
> -	const uint8_t *_a_with_off =3D (const uint8_t *)a + off;              \
> -	const uint8_t *_b_with_off =3D (const uint8_t *)b + off;              \
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, len, msg);  \
> +	const uint8_t *_a_with_off =3D (const uint8_t *)(a) + (off);           =
   \
> +	const uint8_t *_b_with_off =3D (const uint8_t *)(b) + (off);           =
   \
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, (len), msg);  \

Probably needed a comment somewhere in the commit message or cover letter (=
part
after --- for a single commit) what the strategy was to help reviewers:
parenthesize all substitutions even in unambiguous places like surrounded b=
y
commas (which is fine to me personally, finding places where parentheses ar=
e
not strictly necessary needs effort), but leave msg alone since it has to b=
e a
string literal and parenthesizing it would break literal concatenation.

>  } while (0)
>=20
>  /* Compare two buffers (length in bits) */
>  #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {	\
>  	uint8_t _last_byte_a, _last_byte_b;                       \
>  	uint8_t _last_byte_mask, _last_byte_bits;                  \
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, (len >> 3), msg);     \
> -	if (len % 8) {                                              \
> -		_last_byte_bits =3D len % 8;                   \
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL((a), (b), ((len) >> 3), msg);     \
> +	if ((len) % 8) {                                              \
> +		_last_byte_bits =3D (len) % 8;                   \
>  		_last_byte_mask =3D ~((1 << (8 - _last_byte_bits)) - 1); \
> -		_last_byte_a =3D ((const uint8_t *)a)[len >> 3];            \
> -		_last_byte_b =3D ((const uint8_t *)b)[len >> 3];            \
> +		_last_byte_a =3D ((const uint8_t *)(a))[(len) >> 3];            \
> +		_last_byte_b =3D ((const uint8_t *)(b))[(len) >> 3];            \
>  		_last_byte_a &=3D _last_byte_mask;                     \
>  		_last_byte_b &=3D _last_byte_mask;                    \
>  		if (_last_byte_a !=3D _last_byte_b) {                  \
> @@ -74,16 +74,16 @@
>  #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT_OFFSET(a, b, len, off, msg, ..=
.) do {	\
>  	uint8_t _first_byte_a, _first_byte_b;                                 \
>  	uint8_t _first_byte_mask, _first_byte_bits;                           \
> -	uint32_t _len_without_first_byte =3D (off % 8) ?                       =
\
> -				len - (8 - (off % 8)) :                       \
> -				len;                                          \
> -	uint32_t _off_in_bytes =3D (off % 8) ? (off >> 3) + 1 : (off >> 3);    =
 \
> -	const uint8_t *_a_with_off =3D (const uint8_t *)a + _off_in_bytes;     =
 \
> -	const uint8_t *_b_with_off =3D (const uint8_t *)b + _off_in_bytes;     =
 \
> +	uint32_t _len_without_first_byte =3D ((off) % 8) ?                     =
  \
> +				((len) - (8 - ((off) % 8))) :                       \
> +				(len);                                          \
> +	uint32_t _off_in_bytes =3D ((off) % 8) ? (((off) >> 3) + 1) : ((off) >>=
 3);     \
> +	const uint8_t *_a_with_off =3D (const uint8_t *)(a) + _off_in_bytes;   =
   \
> +	const uint8_t *_b_with_off =3D (const uint8_t *)(b) + _off_in_bytes;   =
   \
>  	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(_a_with_off, _b_with_off,           \
>  				_len_without_first_byte, msg);                \
> -	if (off % 8) {                                                        \
> -		_first_byte_bits =3D 8 - (off % 8);                             \
> +	if ((off) % 8) {                                                       =
 \
> +		_first_byte_bits =3D 8 - ((off) % 8);                             \
>  		_first_byte_mask =3D (1 << _first_byte_bits) - 1;               \
>  		_first_byte_a =3D *(_a_with_off - 1);                           \
>  		_first_byte_b =3D *(_b_with_off - 1);                           \
> diff --git a/lib/eal/include/rte_test.h b/lib/eal/include/rte_test.h
> index 62c8f165af..b73d4e75c2 100644
> --- a/lib/eal/include/rte_test.h
> +++ b/lib/eal/include/rte_test.h
> @@ -26,21 +26,21 @@
>  } while (0)
>=20
>  #define RTE_TEST_ASSERT_EQUAL(a, b, msg, ...) \
> -	RTE_TEST_ASSERT(a =3D=3D b, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((a) =3D=3D (b)), msg, ##__VA_ARGS__)

Parenthesizing both arguments passed and arguments substituted is not stric=
tly
necessary, although not technically wrong.

>=20
>  #define RTE_TEST_ASSERT_NOT_EQUAL(a, b, msg, ...) \
> -	RTE_TEST_ASSERT(a !=3D b, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((a) !=3D (b)), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_SUCCESS(val, msg, ...) \
> -	RTE_TEST_ASSERT(val =3D=3D 0, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((val) =3D=3D 0), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_FAIL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val !=3D 0, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((val) !=3D 0), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_NULL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val =3D=3D NULL, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((val) =3D=3D NULL), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_NOT_NULL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val !=3D NULL, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT(((val) !=3D NULL), msg, ##__VA_ARGS__)
>=20
>  #endif /* _RTE_TEST_H_ */
> --
> 2.34.1

Patchwork has detected that your From email is different from your
Signed-off-by email. I believe this is a formal requirement that may preven=
t
your patch from getting merged. If you plan to send patches from your perso=
nal
email please add it as an alias to the .mailmap .

The patch is technically correct and would work, neither of my comments is =
a
blocker (although last one might be a blocker from maintainer), but given t=
hat
there are three of them maybe you would want to send a v2 to practice the
process. Don't forget --in-reply-to when sending it.
