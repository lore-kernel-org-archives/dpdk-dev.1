Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30DC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 10:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 683C24025D;
	Wed,  7 May 2025 12:36:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 48BAC4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 12:35:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zss6z0rftz6L5Zf;
 Wed,  7 May 2025 18:33:31 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id E336C1407F9;
 Wed,  7 May 2025 18:35:57 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 12:35:57 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 7 May 2025 12:35:57 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v4 1/2] cmdline: add floating point support
Thread-Topic: [PATCH v4 1/2] cmdline: add floating point support
Thread-Index: AQHbvzcTeT1qaAd3QECXN7tR6Oj62LPG+Myg
Date: Wed, 7 May 2025 10:35:57 +0000
Message-ID: <73248ba4775b4b95b117890851b8257e@huawei.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
In-Reply-To: <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.35]
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



> Add support for parsing floating point numbers in cmdline library, as wel=
l
> as unit tests for the new functionality. The parser supports single and
> double precision floats, and will understand decimal fractions as well as
> scientific notation.

There are standard functions for that: strtod/strtof - can't we simply use =
them? =20

>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>=20
> Notes:
>     v3 -> v4:
>     - Removed unnecessary check for integer overflow when parsing negativ=
e
>       floats (as we convert to double before changing sign)
>     - Make naming of float exponent states more consistent
>=20
>     v2 -> v3:
>     - Fixed a bug where a free-standing negative exponent ("1e-") would a=
ttempt to be
>       parsed, and added unit tests for this case
>     - Added support for floats in dpdk-cmdline-gen script
>     - Added documentation updates to call out float support
>=20
>  app/test/test_cmdline_num.c            | 203 +++++++++++++++++-
>  buildtools/dpdk-cmdline-gen.py         |  24 ++-
>  doc/guides/prog_guide/cmdline.rst      |   3 +
>  doc/guides/rel_notes/release_25_07.rst |   5 +
>  lib/cmdline/cmdline_parse_num.c        | 273 +++++++++++++++++++++++++
>  lib/cmdline/cmdline_parse_num.h        |   4 +-
>  6 files changed, 497 insertions(+), 15 deletions(-)
>=20
> diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
> index 9276de59bd..e4038271c9 100644
> --- a/app/test/test_cmdline_num.c
> +++ b/app/test/test_cmdline_num.c
> @@ -5,6 +5,8 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <inttypes.h>
> +#include <float.h>
> +#include <math.h>
>=20
>  #include <rte_string_fns.h>
>=20
> @@ -23,6 +25,11 @@ struct num_signed_str {
>  	int64_t result;
>  };
>=20
> +struct num_float_str {
> +	const char * str;
> +	double result;
> +};
> +
>  const struct num_unsigned_str num_valid_positive_strs[] =3D {
>  		/* decimal positive */
>  		{"0", 0 },
> @@ -141,6 +148,63 @@ const struct num_signed_str num_valid_negative_strs[=
] =3D {
>  		{"-9223372036854775808", INT64_MIN },
>  };
>=20
> +const struct num_float_str num_valid_float_strs[] =3D {
> +		/* zero */
> +		{"0", 0},
> +		/* parse int as float */
> +		{"1", 1},
> +		{"-1", -1},
> +		/* fractional */
> +		{"1.23", 1.23},
> +		{"-1.23", -1.23},
> +		{"0.123", 0.123},
> +		{"-0.123", -0.123},
> +		{"123.456", 123.456},
> +		{"-123.456", -123.456},
> +		/* positive exponent */
> +		{"1e2", 1e2},
> +		{"-1e2", -1e2},
> +		{"1E2", 1E2},
> +		{"-1E2", -1E2},
> +		{"0.12e3", 0.12e3},
> +		{"-0.12e3", -0.12e3},
> +		{"1.23e4", 1.23e4},
> +		{"-1.23e4", -1.23e4},
> +		{"1.23E4", 1.23E4},
> +		{"-1.23E4", -1.23E4},
> +		{"123.456e7", 123.456e7},
> +		{"-123.456e7", -123.456e7},
> +		{"123.456E7", 123.456E7},
> +		{"-123.456E7", -123.456E7},
> +		/* negative exponent */
> +		{"1e-2", 1e-2},
> +		{"-1e-2", -1e-2},
> +		{"1E-2", 1E-2},
> +		{"-1E-2", -1E-2},
> +		{"0.12e-3", 0.12e-3},
> +		{"-0.12e-3", -0.12e-3},
> +		{"1.23e-4", 1.23e-4},
> +		{"-1.23e-4", -1.23e-4},
> +		{"1.23E-4", 1.23E-4},
> +		{"-1.23E-4", -1.23E-4},
> +		{"123.456e-7", 123.456e-7},
> +		{"-123.456e-7", -123.456e-7},
> +		{"123.456E-7", 123.456E-7},
> +		{"-123.456E-7", -123.456E-7},
> +		/* try overflowing float */
> +		{"2e63", 2e63},
> +		{"-2e63", -2e63},
> +		{"2E63", 2E63},
> +		{"-2E63", -2E63},
> +		{"18446744073709551615", (double) UINT64_MAX},
> +		{"-9223372036854775808", (double) INT64_MIN},
> +		/* try overflowing double */
> +		{"2e308", HUGE_VAL},
> +		{"-2e308", -HUGE_VAL},
> +		{"2E308", HUGE_VAL},
> +		{"-2E308", HUGE_VAL},
> +};
> +
>  const struct num_unsigned_str num_garbage_positive_strs[] =3D {
>  		/* valid strings with garbage on the end, should still be valid */
>  		/* decimal */
> @@ -183,6 +247,30 @@ const struct num_signed_str num_garbage_negative_str=
s[] =3D {
>  		{"-9223372036854775808 garbage", INT64_MIN },
>  };
>=20
> +const char *float_invalid_strs[] =3D {
> +	"0.",
> +	".1",
> +	"1.1.",
> +	"1.1.1",
> +	"-0.",
> +	"-.1",
> +	"-1.1.",
> +	"-1.1.1",
> +	"e",
> +	"1e",
> +	"-1e",
> +	"0.1e",
> +	"-0.1e",
> +	"1.e",
> +	"-1.e",
> +	"1.23e3.4",
> +	"-1.23e3.4",
> +	"1e1e",
> +	"1e1e1",
> +	"1e-",
> +	"-1e-"
> +};
> +
>  const char * num_invalid_strs[] =3D {
>  		"18446744073709551616", /* out of range unsigned */
>  		"-9223372036854775809", /* out of range negative signed */
> @@ -202,7 +290,16 @@ const char * num_invalid_strs[] =3D {
>  		/* too long (128+ chars) */
>  		("0b1111000011110000111100001111000011110000111100001111000011110000"
>  		  "1111000011110000111100001111000011110000111100001111000011110000"),
> +		/* valid float values but should fail to parse as ints */
>  		"1E3",
> +		"-1E3",
> +		"1.23",
> +		"-1.23",
> +		"1E-3",
> +		"-1E-3",
> +		"1.23E4",
> +		"-1.23E4",
> +		/* misc invalid values */
>  		"0A",
>  		"-B",
>  		"+4",
> @@ -216,6 +313,47 @@ const char * num_invalid_strs[] =3D {
>  		"\0",
>  };
>=20
> +static int
> +float_cmp(double expected, void *actual_p, enum cmdline_numtype type)
> +{
> +	double eps;
> +	double actual_d;
> +
> +	if (type =3D=3D RTE_FLOAT_SINGLE) {
> +		/* read as float, convert to double */
> +		actual_d =3D (double)*(float *)actual_p;
> +		/* FLT_EPSILON is too small for some tests */
> +		eps =3D 1e-5f;
> +	} else {
> +		/* read as double */
> +		actual_d =3D *(double *)actual_p;
> +		eps =3D DBL_EPSILON;
> +	}
> +	/* compare using epsilon value */
> +	if (fabs(expected - actual_d) < eps)
> +		return 0;
> +	/* not equal */
> +	return expected < actual_d ? -1 : 1;
> +}
> +
> +static int
> +can_parse_float(double expected_result, enum cmdline_numtype type)
> +{
> +	switch (type) {
> +	case RTE_FLOAT_SINGLE:
> +		if (expected_result > FLT_MAX || expected_result < -FLT_MAX)
> +			return 0;
> +		break;
> +	case RTE_FLOAT_DOUBLE:
> +		if (expected_result > DBL_MAX || expected_result < -DBL_MAX)
> +			return 0;
> +		break;
> +	default:
> +		return 1;
> +	}
> +	return 1;
> +}
> +
>  static int
>  can_parse_unsigned(uint64_t expected_result, enum cmdline_numtype type)
>  {
> @@ -371,11 +509,11 @@ test_parse_num_invalid_data(void)
>  	int ret =3D 0;
>  	unsigned i;
>  	char buf[CMDLINE_TEST_BUFSIZE];
> -	uint64_t result; /* pick largest buffer */
>  	cmdline_parse_token_num_t token;
>=20
> -	/* cycle through all possible parsed types */
> +	/* cycle through all possible integer types */
>  	for (type =3D RTE_UINT8; type <=3D RTE_INT64; type++) {
> +		uint64_t result; /* pick largest buffer */
>  		token.num_data.type =3D type;
>=20
>  		/* test full strings */
> @@ -397,6 +535,31 @@ test_parse_num_invalid_data(void)
>  			}
>  		}
>  	}
> +
> +	/* cycle through all possible float types */
> +	for (type =3D RTE_FLOAT_SINGLE; type <=3D RTE_FLOAT_DOUBLE; type++) {
> +		double result; /* pick largest buffer */
> +		token.num_data.type =3D type;
> +
> +		/* test full strings */
> +		for (i =3D 0; i < RTE_DIM(float_invalid_strs); i++) {
> +
> +			memset(&result, 0, sizeof(double));
> +			memset(&buf, 0, sizeof(buf));
> +
> +			ret =3D cmdline_parse_num((cmdline_parse_token_hdr_t*)&token,
> +					float_invalid_strs[i], (void*)&result, sizeof(result));
> +			if (ret !=3D -1) {
> +				/* get some info about what we are trying to parse */
> +				cmdline_get_help_num((cmdline_parse_token_hdr_t*)&token,
> +						buf, sizeof(buf));
> +
> +				printf("Error: parsing %s as %s succeeded!\n",
> +						float_invalid_strs[i], buf);
> +				return -1;
> +			}
> +		}
> +	}
>  	return 0;
>  }
>=20
> @@ -408,13 +571,13 @@ test_parse_num_valid(void)
>  	enum cmdline_numtype type;
>  	unsigned i;
>  	char buf[CMDLINE_TEST_BUFSIZE];
> -	uint64_t result;
>  	cmdline_parse_token_num_t token;
>=20
>  	/** valid strings **/
>=20
>  	/* cycle through all possible parsed types */
>  	for (type =3D RTE_UINT8; type <=3D RTE_INT64; type++) {
> +		uint64_t result;
>  		token.num_data.type =3D type;
>=20
>  		/* test positive strings */
> @@ -489,10 +652,44 @@ test_parse_num_valid(void)
>  		}
>  	}
>=20
> +	/* float values */
> +	for (type =3D RTE_FLOAT_SINGLE; type <=3D RTE_FLOAT_DOUBLE; type++) {
> +		double result;
> +		token.num_data.type =3D type;
> +
> +		/* test all valid strings */
> +		for (i =3D 0; i < RTE_DIM(num_valid_float_strs); i++) {
> +			result =3D 0;
> +			memset(&buf, 0, sizeof(buf));
> +
> +
> +			cmdline_get_help_num((cmdline_parse_token_hdr_t*)&token,
> +					buf, sizeof(buf));
> +
> +			ret =3D cmdline_parse_num((cmdline_parse_token_hdr_t*) &token,
> +				num_valid_float_strs[i].str,
> +				(void*)&result, sizeof(result));
> +
> +			/* if it should have passed but didn't, or if it should have failed b=
ut didn't */
> +			if ((ret < 0) =3D=3D (can_parse_float(num_valid_float_strs[i].result,=
 type) > 0)) {
> +				printf("Error: parser behaves unexpectedly when parsing %s as %s!\n"=
,
> +						num_valid_float_strs[i].str, buf);
> +				return -1;
> +			}
> +			/* check if result matches */
> +			if (ret > 0 && float_cmp(num_valid_float_strs[i].result, &result, typ=
e) !=3D 0) {
> +				printf("Error: parsing %s as %s failed: result mismatch!\n",
> +						num_valid_float_strs[i].str, buf);
> +				return -1;
> +			}
> +		}
> +	}
> +
>  	/** garbage strings **/
>=20
>  	/* cycle through all possible parsed types */
>  	for (type =3D RTE_UINT8; type <=3D RTE_INT64; type++) {
> +		uint64_t result;
>  		token.num_data.type =3D type;
>=20
>  		/* test positive garbage strings */
> diff --git a/buildtools/dpdk-cmdline-gen.py b/buildtools/dpdk-cmdline-gen=
.py
> index 7dadded783..6c76d7116a 100755
> --- a/buildtools/dpdk-cmdline-gen.py
> +++ b/buildtools/dpdk-cmdline-gen.py
> @@ -17,16 +17,18 @@
>      RTE_SET_USED(cl);
>      RTE_SET_USED(data);
>  """
> -NUMERIC_TYPES =3D [
> -    "UINT8",
> -    "UINT16",
> -    "UINT32",
> -    "UINT64",
> -    "INT8",
> -    "INT16",
> -    "INT32",
> -    "INT64",
> -]
> +NUMERIC_TYPES =3D {
> +    "UINT8": "uint8_t",
> +    "UINT16": "uint16_t",
> +    "UINT32": "uint32_t",
> +    "UINT64": "uint64_t",
> +    "INT8": "int8_t",
> +    "INT16": "int16_t",
> +    "INT32": "int32_t",
> +    "INT64": "int64_t",
> +    "FLOAT_SINGLE": "float",
> +    "FLOAT_DOUBLE": "double",
> +}
>=20
>=20
>  def process_command(lineno, tokens, comment):
> @@ -70,7 +72,7 @@ def process_command(lineno, tokens, comment):
>                  f"\tTOKEN_STRING_INITIALIZER(struct cmd_{name}_result, {=
t_name}, {t_val});"
>              )
>          elif t_type in NUMERIC_TYPES:
> -            result_struct.append(f"\t{t_type.lower()}_t {t_name};")
> +            result_struct.append(f"\t{NUMERIC_TYPES[t_type]} {t_name};")
>              initializers.append(
>                  f"static cmdline_parse_token_num_t cmd_{name}_{t_name}_t=
ok =3D\n"
>                  f"\tTOKEN_NUM_INITIALIZER(struct cmd_{name}_result, {t_n=
ame}, RTE_{t_type});"
> diff --git a/doc/guides/prog_guide/cmdline.rst b/doc/guides/prog_guide/cm=
dline.rst
> index e20281ceb5..447a90e32e 100644
> --- a/doc/guides/prog_guide/cmdline.rst
> +++ b/doc/guides/prog_guide/cmdline.rst
> @@ -22,6 +22,7 @@ The DPDK command-line library supports the following fe=
atures:
>=20
>     * Strings
>     * Signed/unsigned 16/32/64-bit integers
> +   * Single/double precision floats
>     * IP Addresses
>     * Ethernet Addresses
>=20
> @@ -68,6 +69,8 @@ The format of the list file must be:
>=20
>    * ``<UINT16>port_id``
>=20
> +  * ``<FLOAT_SINGLE>ratio``
> +
>    * ``<IP>src_ip``
>=20
>    * ``<IPv4>dst_ip4``
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 093b85d206..54bc545110 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +* **Added floating point numbers support to cmdline library.**
> +
> +  The cmdline library now supports parsing single- and double-precision
> +  floating point numbers in interactive user commands.
> +
>=20
>  Removed Items
>  -------------
> diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_=
num.c
> index f21796bedb..9e4d559325 100644
> --- a/lib/cmdline/cmdline_parse_num.c
> +++ b/lib/cmdline/cmdline_parse_num.c
> @@ -7,6 +7,8 @@
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> +#include <float.h>
> +#include <math.h>
>  #include <string.h>
>  #include <eal_export.h>
>  #include <rte_string_fns.h>
> @@ -34,6 +36,10 @@ enum num_parse_state_t {
>  	DEC_NEG,
>  	BIN,
>  	HEX,
> +	FLOAT_POS,
> +	FLOAT_NEG,
> +	FLOAT_EXP_POS,
> +	FLOAT_EXP_NEG,
>=20
>  	ERROR,
>=20
> @@ -44,12 +50,27 @@ enum num_parse_state_t {
>  	BIN_OK,
>  	DEC_NEG_OK,
>  	DEC_POS_OK,
> +	FLOAT_POS_OK,
> +	FLOAT_NEG_OK,
> +	FLOAT_EXP_POS_OK,
> +	FLOAT_EXP_NEG_OK,
> +};
> +
> +struct float_parse_state {
> +	uint64_t dec;
> +	uint64_t frac;
> +	uint64_t frac_exp;
> +	uint64_t exp;
> +#define FLOAT_FLAG_NEG_RES     (1 << 0)
> +#define FLOAT_FLAG_NEG_EXP     (1 << 1)
> +	int flags;
>  };
>=20
>  /* Keep it sync with enum in .h */
>  static const char * num_help[] =3D {
>  	"UINT8", "UINT16", "UINT32", "UINT64",
>  	"INT8", "INT16", "INT32", "INT64",
> +	"SINGLE", "DOUBLE"
>  };
>=20
>  static inline int
> @@ -63,6 +84,50 @@ add_to_res(unsigned int c, uint64_t *res, unsigned int=
 base)
>  	return 0;
>  }
>=20
> +static inline int
> +check_float_result(enum cmdline_numtype res_type, struct float_parse_sta=
te *fps,
> +		void *res)
> +{
> +	double dec, frac, exp, result;
> +
> +	/* extract parts */
> +	dec =3D (double) fps->dec;
> +	frac =3D (double) fps->frac * pow(10.0, -(double)fps->frac_exp);
> +	exp =3D (double) fps->exp;
> +
> +	/* exponent might be negative */
> +	if (fps->flags & FLOAT_FLAG_NEG_EXP)
> +		exp =3D pow(10.0, -exp);
> +	else
> +		exp =3D pow(10.0, exp);
> +
> +	/* combine decimal, fractional, and exponent parts */
> +	result =3D (dec + frac) * exp;
> +
> +	/* check for any overflows */
> +	if (isinf(frac) || isinf(exp) || isinf(result))
> +		return -1;
> +
> +	/* result is a valid double */
> +
> +	/* check if result needs to be negative */
> +	if (fps->flags & FLOAT_FLAG_NEG_RES)
> +		result =3D -result;
> +
> +	if (res_type =3D=3D RTE_FLOAT_SINGLE) {
> +		/* float can overflow from conversion */
> +		float flt =3D (float)result;
> +		if (isinf(flt))
> +			return -1;
> +		if (res) *(float *)res =3D flt;
> +	} else if (res_type =3D=3D RTE_FLOAT_DOUBLE) {
> +		if (res) *(double *)res =3D result;
> +	} else {
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int
>  check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
>  {
> @@ -87,6 +152,14 @@ check_res_size(struct cmdline_token_num_data *nd, uns=
igned ressize)
>  		if (ressize < sizeof(int64_t))
>  			return -1;
>  		break;
> +	case RTE_FLOAT_SINGLE:
> +		if (ressize < sizeof(float))
> +			return -1;
> +		break;
> +	case RTE_FLOAT_DOUBLE:
> +		if (ressize < sizeof(double))
> +			return -1;
> +		break;
>  	default:
>  		return -1;
>  	}
> @@ -104,6 +177,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, cons=
t char *srcbuf, void *res,
>  	const char * buf;
>  	char c;
>  	uint64_t res1 =3D 0;
> +	struct float_parse_state fps =3D {};
>=20
>  	if (!tk)
>  		return -1;
> @@ -156,6 +230,10 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, con=
st char *srcbuf, void *res,
>  				else
>  					st =3D OCTAL_OK;
>  			}
> +			else if (c =3D=3D '.') {
> +				st =3D FLOAT_POS;
> +				break;
> +			}
>  			else  {
>  				st =3D ERROR;
>  			}
> @@ -173,11 +251,80 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, co=
nst char *srcbuf, void *res,
>  			}
>  			break;
>=20
> +		case FLOAT_POS:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else {
> +					st =3D FLOAT_POS_OK;
> +					fps.frac_exp++;
> +				}
> +			}
> +			else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_NEG:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else {
> +					st =3D FLOAT_NEG_OK;
> +					fps.frac_exp++;
> +				}
> +			}
> +			else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_EXP_POS:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else
> +					st =3D FLOAT_EXP_POS_OK;
> +			}
> +			else if (c =3D=3D '-') {
> +				st =3D FLOAT_EXP_NEG;
> +				fps.flags |=3D FLOAT_FLAG_NEG_EXP;
> +			}
> +			else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_EXP_NEG:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else
> +					st =3D FLOAT_EXP_NEG_OK;
> +			}
> +			else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
>  		case DEC_NEG_OK:
>  			if (c >=3D '0' && c <=3D '9') {
>  				if (add_to_res(c - '0', &res1, 10) < 0)
>  					st =3D ERROR;
>  			}
> +			else if (c =3D=3D '.') {
> +				fps.dec =3D res1;
> +				fps.flags |=3D FLOAT_FLAG_NEG_RES;
> +				st =3D FLOAT_NEG;
> +				/* erase result */
> +				res1 =3D 0;
> +			} else if (c =3D=3D 'e' || c =3D=3D 'E') {
> +				fps.dec =3D res1;
> +				fps.flags |=3D FLOAT_FLAG_NEG_RES;
> +				st =3D FLOAT_EXP_POS;
> +				/* erase result */
> +				res1 =3D 0;
> +			}
>  			else {
>  				st =3D ERROR;
>  			}
> @@ -188,11 +335,75 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, co=
nst char *srcbuf, void *res,
>  				if (add_to_res(c - '0', &res1, 10) < 0)
>  					st =3D ERROR;
>  			}
> +			else if (c =3D=3D '.') {
> +				fps.dec =3D res1;
> +				st =3D FLOAT_POS;
> +				/* erase result */
> +				res1 =3D 0;
> +			}
> +			else if (c =3D=3D 'e' || c =3D=3D 'E') {
> +				fps.dec =3D res1;
> +				st =3D FLOAT_EXP_POS;
> +				/* erase result */
> +				res1 =3D 0;
> +			}
>  			else {
>  				st =3D ERROR;
>  			}
>  			break;
>=20
> +		case FLOAT_POS_OK:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else
> +					fps.frac_exp++;
> +			} else if (c =3D=3D 'e' || c =3D=3D 'E') {
> +				fps.frac =3D res1;
> +				st =3D FLOAT_EXP_POS;
> +				/* erase result */
> +				res1 =3D 0;
> +			} else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_NEG_OK:
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +				else
> +					fps.frac_exp++;
> +			} else if (c =3D=3D 'e' || c =3D=3D 'E') {
> +				fps.frac =3D res1;
> +				st =3D FLOAT_EXP_POS;
> +				/* erase result */
> +				res1 =3D 0;
> +			} else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_EXP_POS_OK:
> +			/* exponent is always whole */
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +			} else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
> +		case FLOAT_EXP_NEG_OK:
> +			/* exponent is always whole */
> +			if (c >=3D '0' && c <=3D '9') {
> +				if (add_to_res(c - '0', &res1, 10) < 0)
> +					st =3D ERROR;
> +			} else {
> +				st =3D ERROR;
> +			}
> +			break;
> +
>  		case HEX:
>  			st =3D HEX_OK;
>  			/* fall-through */
> @@ -282,6 +493,12 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, con=
st char *srcbuf, void *res,
>  		} else if (nd.type =3D=3D RTE_UINT64) {
>  			if (res) *(uint64_t *)res =3D res1;
>  			return buf-srcbuf;
> +		} else if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT=
_DOUBLE) {
> +			/* parsed double from integer */
> +			fps.dec =3D res1;
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
>  		} else {
>  			return -1;
>  		}
> @@ -304,6 +521,62 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, con=
st char *srcbuf, void *res,
>  				res1 <=3D (uint64_t)INT64_MAX + 1) {
>  			if (res) *(int64_t *)res =3D (int64_t) (-res1);
>  			return buf-srcbuf;
> +		} else if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT=
_DOUBLE) {
> +			/* parsed double from negative integer */
> +			fps.dec =3D res1;
> +			fps.flags |=3D FLOAT_FLAG_NEG_RES;
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
> +		} else {
> +			return -1;
> +		}
> +		break;
> +
> +	case FLOAT_POS_OK:
> +		if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT_DOUBLE=
) {
> +			fps.frac =3D res1;
> +
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
> +		} else {
> +			return -1;
> +		}
> +		break;
> +
> +	case FLOAT_NEG_OK:
> +		if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT_DOUBLE=
) {
> +			fps.frac =3D res1;
> +
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
> +		} else {
> +			return -1;
> +		}
> +		break;
> +
> +	case FLOAT_EXP_POS_OK:
> +		/* watch for overflow in the exponent */
> +		if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT_DOUBLE=
) {
> +			fps.exp =3D res1;
> +
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
> +		} else {
> +			return -1;
> +		}
> +		break;
> +
> +	case FLOAT_EXP_NEG_OK:
> +		if (nd.type =3D=3D RTE_FLOAT_SINGLE || nd.type =3D=3D RTE_FLOAT_DOUBLE=
) {
> +			fps.exp =3D res1;
> +
> +			if (check_float_result(nd.type, &fps, res) < 0)
> +				return -1;
> +			return buf-srcbuf;
>  		} else {
>  			return -1;
>  		}
> diff --git a/lib/cmdline/cmdline_parse_num.h b/lib/cmdline/cmdline_parse_=
num.h
> index bdd0267612..b2792a2d11 100644
> --- a/lib/cmdline/cmdline_parse_num.h
> +++ b/lib/cmdline/cmdline_parse_num.h
> @@ -22,7 +22,9 @@ enum cmdline_numtype {
>  	RTE_INT8,
>  	RTE_INT16,
>  	RTE_INT32,
> -	RTE_INT64
> +	RTE_INT64,
> +	RTE_FLOAT_SINGLE,
> +	RTE_FLOAT_DOUBLE,
>  };
>=20
>  struct cmdline_token_num_data {
> --
> 2.47.1

