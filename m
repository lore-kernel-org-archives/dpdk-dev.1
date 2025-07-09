Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E3C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 08:23:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01CD40430;
	Wed,  9 Jul 2025 10:23:39 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id D7EE7402CB;
 Wed,  9 Jul 2025 10:23:38 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bcWF56pBrz6GCBc;
 Wed,  9 Jul 2025 16:22:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E2F591402E9;
 Wed,  9 Jul 2025 16:23:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Jul 2025 10:23:37 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 9 Jul 2025 10:23:37 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Gage Eads <gage.eads@intel.com>, Olivier Matz
 <olivier.matz@6wind.com>, Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
Thread-Topic: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
Thread-Index: AQHb8AQpgIVIb3+fAUOdgY2fPV/nYbQpdONg
Date: Wed, 9 Jul 2025 08:23:37 +0000
Message-ID: <6329433c869243cbb7cb700abab420fe@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-10-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-10-david.marchand@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.34.14]
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



> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Tuesday, July 8, 2025 1:28 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>; Gage =
Eads <gage.eads@intel.com>; Olivier Matz
> <olivier.matz@6wind.com>; Honnappa Nagarahalli <honnappa.nagarahalli@arm.=
com>
> Subject: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
>=20
> Caught by UBSan:
>=20
> ../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for
> 	type 'const rte_int128_t', which requires 16 byte alignment
> 	0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for type
> 	'const union rte_int128_t::(anonymous at
> 	../lib/eal/include/generic/rte_atomic.h:1102:2)', which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:16: runtime error:
> 	load of misaligned address 0x7ffd9c67f228 for type
> 	'const uint64_t' (aka 'const unsigned long'), which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
>=20
> Fixes: 3340202f5954 ("stack: add lock-free implementation")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/stack/rte_stack_lf_c11.h     | 8 ++++----
>  lib/stack/rte_stack_lf_generic.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
> index b97e02d6a1..f674731235 100644
> --- a/lib/stack/rte_stack_lf_c11.h
> +++ b/lib/stack/rte_stack_lf_c11.h
> @@ -63,13 +63,13 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *l=
ist,
>  			  struct rte_stack_lf_elem *last,
>  			  unsigned int num)
>  {
> -	struct rte_stack_lf_head old_head;
> +	alignas(16) struct rte_stack_lf_head old_head;
>  	int success;
>=20
>  	old_head =3D list->head;
>=20
>  	do {
> -		struct rte_stack_lf_head new_head;
> +		alignas(16) struct rte_stack_lf_head new_head;
>=20
>  		/* Swing the top pointer to the first element in the list and
>  		 * make the last element point to the old top.
> @@ -102,7 +102,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *li=
st,
>  			 void **obj_table,
>  			 struct rte_stack_lf_elem **last)
>  {
> -	struct rte_stack_lf_head old_head;
> +	alignas(16) struct rte_stack_lf_head old_head;
>  	uint64_t len;
>  	int success =3D 0;
>=20
> @@ -129,7 +129,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *li=
st,
>=20
>  	/* Pop num elements */
>  	do {
> -		struct rte_stack_lf_head new_head;
> +		alignas(16) struct rte_stack_lf_head new_head;
>  		struct rte_stack_lf_elem *tmp;
>  		unsigned int i;
>=20
> diff --git a/lib/stack/rte_stack_lf_generic.h b/lib/stack/rte_stack_lf_ge=
neric.h
> index cc69e4d168..32f56dffdd 100644
> --- a/lib/stack/rte_stack_lf_generic.h
> +++ b/lib/stack/rte_stack_lf_generic.h
> @@ -36,13 +36,13 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *l=
ist,
>  			  struct rte_stack_lf_elem *last,
>  			  unsigned int num)
>  {
> -	struct rte_stack_lf_head old_head;
> +	alignas(16) struct rte_stack_lf_head old_head;
>  	int success;
>=20
>  	old_head =3D list->head;
>=20
>  	do {
> -		struct rte_stack_lf_head new_head;
> +		alignas(16) struct rte_stack_lf_head new_head;
>=20
>  		/* An acquire fence (or stronger) is needed for weak memory
>  		 * models to establish a synchronized-with relationship between
> @@ -77,7 +77,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list=
,
>  			 void **obj_table,
>  			 struct rte_stack_lf_elem **last)
>  {
> -	struct rte_stack_lf_head old_head;
> +	alignas(16) struct rte_stack_lf_head old_head;
>  	int success =3D 0;
>=20
>  	/* Reserve num elements, if available */
> @@ -99,7 +99,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list=
,
>=20
>  	/* Pop num elements */
>  	do {
> -		struct rte_stack_lf_head new_head;
> +		alignas(16) struct rte_stack_lf_head new_head;
>  		struct rte_stack_lf_elem *tmp;
>  		unsigned int i;
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20


> 2.50.0

