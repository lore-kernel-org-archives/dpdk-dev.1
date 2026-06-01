Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2FDCD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:24:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07265402F1;
	Mon,  1 Jun 2026 20:24:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BAFF0402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:24:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gTj5K3nSbzHnGdd;
 Tue,  2 Jun 2026 02:23:33 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 88FA340584;
 Tue,  2 Jun 2026 02:24:21 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 19:24:21 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 1 Jun 2026 19:24:20 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Bibo Mao <maobibo@loongson.cn>, "David
 Christensen" <drc@linux.ibm.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 02/27] eal: reimplement rte_smp_*mb with
 rte_atomic_thread_fence
Thread-Topic: [PATCH v4 02/27] eal: reimplement rte_smp_*mb with
 rte_atomic_thread_fence
Thread-Index: AQHc7WcAJ7c2DhXsqUCuIfwk2vOS7LYqDNhA
Date: Mon, 1 Jun 2026 18:24:20 +0000
Message-ID: <4f09d052697a45b7bf465bcf4b9c4eb6@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-3-stephen@networkplumber.org>
In-Reply-To: <20260526232542.620966-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.234]
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



> The rte_smp_mb(), rte_smp_wmb() and rte_smp_rmb() functions were
> flagged as deprecated by commit 3ec965b6de12 ("doc: update atomic
> operation deprecation") in 2021 but nothing came of it.
>=20
> Reimplement them as inline wrappers over rte_atomic_thread_fence()
> and drop the deprecation notice.
> The API is preserved; only the implementation changes.
>=20
> The wrapper provides stronger guarantees than previous code
> because there is no C11 equivalent to old rte_smp_qmb().
> Generated code is unchanged on x86; on arm64,
> release/acquire emit dmb ish instead of dmb ishst/ishld;
> the difference is below measurement noise.
>=20
> Drop restrictions on rte_smp_XX in checkpatch since they are
> no longer on deprecation cycle.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  devtools/checkpatches.sh               |   8 --
>  doc/guides/rel_notes/deprecation.rst   |   8 --
>  lib/eal/arm/include/rte_atomic_32.h    |   6 --
>  lib/eal/arm/include/rte_atomic_64.h    |   6 --
>  lib/eal/include/generic/rte_atomic.h   | 130 +++++--------------------
>  lib/eal/loongarch/include/rte_atomic.h |   6 --
>  lib/eal/ppc/include/rte_atomic.h       |   6 --
>  lib/eal/riscv/include/rte_atomic.h     |   6 --
>  lib/eal/x86/include/rte_atomic.h       |  33 +++----
>  9 files changed, 37 insertions(+), 172 deletions(-)
>=20
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index f5dd77443f..81bb0fe4e8 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -121,14 +121,6 @@ check_forbidden_additions() { # <patch>
>  		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
>  		"$1" || res=3D1
>=20
> -	# refrain from new additions of rte_smp_[r/w]mb()
> -	awk -v FOLDERS=3D"lib drivers app examples" \
> -		-v EXPRESSIONS=3D"rte_smp_(r|w)?mb\\\(" \
> -		-v RET_ON_FAIL=3D1 \
> -		-v MESSAGE=3D'Using rte_smp_[r/w]mb' \
> -		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
> -		"$1" || res=3D1
> -
>  	# refrain from using compiler __sync_xxx builtins
>  	awk -v FOLDERS=3D"lib drivers app examples" \
>  		-v EXPRESSIONS=3D"__sync_.*\\\(" \
> diff --git a/doc/guides/rel_notes/deprecation.rst
> b/doc/guides/rel_notes/deprecation.rst
> index 35c9b4e06c..2190419f79 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -47,14 +47,6 @@ Deprecation Notices
>    operations must be used for patches that need to be merged in 20.08 on=
wards.
>    This change will not introduce any performance degradation.
>=20
> -* rte_smp_*mb: These APIs provide full barrier functionality. However, m=
any
> -  use cases do not require full barriers. To support such use cases, DPD=
K has
> -  adopted atomic operations from
> -  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. The=
se
> -  operations and a new wrapper ``rte_atomic_thread_fence`` instead of
> -  ``__atomic_thread_fence`` must be used for patches that need to be mer=
ged in
> -  20.08 onwards. This change will not introduce any performance degradat=
ion.
> -
>  * lib: will fix extending some enum/define breaking the ABI. There are m=
ultiple
>    samples in DPDK that enum/define terminated with a ``.*MAX.*`` value w=
hich is
>    used by iterators, and arrays holding these values are sized with this
> diff --git a/lib/eal/arm/include/rte_atomic_32.h
> b/lib/eal/arm/include/rte_atomic_32.h
> index 696a539fef..4115271091 100644
> --- a/lib/eal/arm/include/rte_atomic_32.h
> +++ b/lib/eal/arm/include/rte_atomic_32.h
> @@ -17,12 +17,6 @@ extern "C" {
>=20
>  #define	rte_rmb() __sync_synchronize()
>=20
> -#define rte_smp_mb() rte_mb()
> -
> -#define rte_smp_wmb() rte_wmb()
> -
> -#define rte_smp_rmb() rte_rmb()
> -
>  #define rte_io_mb() rte_mb()
>=20
>  #define rte_io_wmb() rte_wmb()
> diff --git a/lib/eal/arm/include/rte_atomic_64.h
> b/lib/eal/arm/include/rte_atomic_64.h
> index 9f790238df..604e777bcd 100644
> --- a/lib/eal/arm/include/rte_atomic_64.h
> +++ b/lib/eal/arm/include/rte_atomic_64.h
> @@ -20,12 +20,6 @@ extern "C" {
>=20
>  #define rte_rmb() asm volatile("dmb oshld" : : : "memory")
>=20
> -#define rte_smp_mb() asm volatile("dmb ish" : : : "memory")
> -
> -#define rte_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> -
> -#define rte_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> -
>  #define rte_io_mb() rte_mb()
>=20
>  #define rte_io_wmb() rte_wmb()
> diff --git a/lib/eal/include/generic/rte_atomic.h
> b/lib/eal/include/generic/rte_atomic.h
> index 292e52fade..1b04b43cbb 100644
> --- a/lib/eal/include/generic/rte_atomic.h
> +++ b/lib/eal/include/generic/rte_atomic.h
> @@ -59,55 +59,25 @@ static inline void rte_rmb(void);
>   *
>   * Guarantees that the LOAD and STORE operations that precede the
>   * rte_smp_mb() call are globally visible across the lcores
> - * before the LOAD and STORE operations that follows it.
> - *
> - * @note
> - *  This function is deprecated.
> - *  It provides similar synchronization primitive as atomic fence,
> - *  but has different syntax and memory ordering semantic. Hence
> - *  deprecated for the simplicity of memory ordering semantics in use.
> - *
> - *  rte_atomic_thread_fence(rte_memory_order_acq_rel) should be used
> instead.
> + * before the LOAD and STORE operations that follow it.
>   */
>  static inline void rte_smp_mb(void);
>=20
>  /**
>   * Write memory barrier between lcores
>   *
> - * Guarantees that the STORE operations that precede the
> - * rte_smp_wmb() call are globally visible across the lcores
> - * before the STORE operations that follows it.
> - *
> - * @note
> - *  This function is deprecated.
> - *  It provides similar synchronization primitive as atomic fence,
> - *  but has different syntax and memory ordering semantic. Hence
> - *  deprecated for the simplicity of memory ordering semantics in use.
> - *
> - *  rte_atomic_thread_fence(rte_memory_order_release) should be used
> instead.
> - *  The fence also guarantees LOAD operations that precede the call
> - *  are globally visible across the lcores before the STORE operations
> - *  that follows it.
> + * Guarantees that the LOAD and STORE operations that precede the
> + * rte_smp_wmb() call are globally visible across the lcores before
> + * any STORE operations that follow it.
>   */
>  static inline void rte_smp_wmb(void);
>=20
>  /**
>   * Read memory barrier between lcores
>   *
> - * Guarantees that the LOAD operations that precede the
> - * rte_smp_rmb() call are globally visible across the lcores
> - * before the LOAD operations that follows it.
> - *
> - * @note
> - *  This function is deprecated.
> - *  It provides similar synchronization primitive as atomic fence,
> - *  but has different syntax and memory ordering semantic. Hence
> - *  deprecated for the simplicity of memory ordering semantics in use.
> - *
> - *  rte_atomic_thread_fence(rte_memory_order_acquire) should be used
> instead.
> - *  The fence also guarantees LOAD operations that precede the call
> - *  are globally visible across the lcores before the STORE operations
> - *  that follows it.
> + * Guarantees that any LOAD operations that precede the rte_smp_rmb()
> + * call complete before LOAD and STORE operations that follow it
> + * become globally visible.
>   */
>  static inline void rte_smp_rmb(void);
>  ///@}
> @@ -164,6 +134,24 @@ static inline void rte_io_rmb(void);
>   */
>  static inline void rte_atomic_thread_fence(rte_memory_order memorder);
>=20
> +static __rte_always_inline void
> +rte_smp_mb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
> +}
> +
> +static __rte_always_inline void
> +rte_smp_wmb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +}
> +
> +static __rte_always_inline void
> +rte_smp_rmb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
> +}
> +
>  /*------------------------- 16 bit atomic operations -------------------=
------*/
>=20
>  #ifndef RTE_TOOLCHAIN_MSVC
> @@ -184,9 +172,6 @@ static inline void
> rte_atomic_thread_fence(rte_memory_order memorder);
>   * @return
>   *   Non-zero on success; 0 on failure.
>   */
> -static inline int
> -rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
> -
>  static inline int
>  rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
>  {
> @@ -303,9 +288,6 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic16_inc(rte_atomic16_t *v);
> -
>  static inline void
>  rte_atomic16_inc(rte_atomic16_t *v)
>  {
> @@ -318,9 +300,6 @@ rte_atomic16_inc(rte_atomic16_t *v)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic16_dec(rte_atomic16_t *v);
> -
>  static inline void
>  rte_atomic16_dec(rte_atomic16_t *v)
>  {
> @@ -379,8 +358,6 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t de=
c)
>   * @return
>   *   True if the result after the increment operation is 0; false otherw=
ise.
>   */
> -static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
> -
>  static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
>  {
>  	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&=
v-
> >cnt, 1,
> @@ -398,8 +375,6 @@ static inline int
> rte_atomic16_inc_and_test(rte_atomic16_t *v)
>   * @return
>   *   True if the result after the decrement operation is 0; false otherw=
ise.
>   */
> -static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
> -
>  static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
>  {
>  	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&=
v-
> >cnt, 1,
> @@ -417,8 +392,6 @@ static inline int
> rte_atomic16_dec_and_test(rte_atomic16_t *v)
>   * @return
>   *   0 if failed; else 1, success.
>   */
> -static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
> -
>  static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
>  {
>  	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
> @@ -453,9 +426,6 @@ static inline void rte_atomic16_clear(rte_atomic16_t =
*v)
>   * @return
>   *   Non-zero on success; 0 on failure.
>   */
> -static inline int
> -rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
> -
>  static inline int
>  rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
>  {
> @@ -572,9 +542,6 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic32_inc(rte_atomic32_t *v);
> -
>  static inline void
>  rte_atomic32_inc(rte_atomic32_t *v)
>  {
> @@ -587,9 +554,6 @@ rte_atomic32_inc(rte_atomic32_t *v)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic32_dec(rte_atomic32_t *v);
> -
>  static inline void
>  rte_atomic32_dec(rte_atomic32_t *v)
>  {
> @@ -648,8 +612,6 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t de=
c)
>   * @return
>   *   True if the result after the increment operation is 0; false otherw=
ise.
>   */
> -static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
> -
>  static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
>  {
>  	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&=
v-
> >cnt, 1,
> @@ -667,8 +629,6 @@ static inline int
> rte_atomic32_inc_and_test(rte_atomic32_t *v)
>   * @return
>   *   True if the result after the decrement operation is 0; false otherw=
ise.
>   */
> -static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
> -
>  static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
>  {
>  	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&=
v-
> >cnt, 1,
> @@ -686,8 +646,6 @@ static inline int
> rte_atomic32_dec_and_test(rte_atomic32_t *v)
>   * @return
>   *   0 if failed; else 1, success.
>   */
> -static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
> -
>  static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
>  {
>  	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
> @@ -721,9 +679,6 @@ static inline void rte_atomic32_clear(rte_atomic32_t =
*v)
>   * @return
>   *   Non-zero on success; 0 on failure.
>   */
> -static inline int
> -rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
> -
>  static inline int
>  rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
>  {
> @@ -770,9 +725,6 @@ typedef struct {
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic64_init(rte_atomic64_t *v);
> -
>  static inline void
>  rte_atomic64_init(rte_atomic64_t *v)
>  {
> @@ -798,9 +750,6 @@ rte_atomic64_init(rte_atomic64_t *v)
>   * @return
>   *   The value of the counter.
>   */
> -static inline int64_t
> -rte_atomic64_read(rte_atomic64_t *v);
> -
>  static inline int64_t
>  rte_atomic64_read(rte_atomic64_t *v)
>  {
> @@ -828,9 +777,6 @@ rte_atomic64_read(rte_atomic64_t *v)
>   * @param new_value
>   *   The new value of the counter.
>   */
> -static inline void
> -rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
> -
>  static inline void
>  rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
>  {
> @@ -856,9 +802,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value=
)
>   * @param inc
>   *   The value to be added to the counter.
>   */
> -static inline void
> -rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
> -
>  static inline void
>  rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
>  {
> @@ -874,9 +817,6 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
>   * @param dec
>   *   The value to be subtracted from the counter.
>   */
> -static inline void
> -rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
> -
>  static inline void
>  rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
>  {
> @@ -890,9 +830,6 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic64_inc(rte_atomic64_t *v);
> -
>  static inline void
>  rte_atomic64_inc(rte_atomic64_t *v)
>  {
> @@ -905,9 +842,6 @@ rte_atomic64_inc(rte_atomic64_t *v)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void
> -rte_atomic64_dec(rte_atomic64_t *v);
> -
>  static inline void
>  rte_atomic64_dec(rte_atomic64_t *v)
>  {
> @@ -927,9 +861,6 @@ rte_atomic64_dec(rte_atomic64_t *v)
>   * @return
>   *   The value of v after the addition.
>   */
> -static inline int64_t
> -rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
> -
>  static inline int64_t
>  rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
>  {
> @@ -950,9 +881,6 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t in=
c)
>   * @return
>   *   The value of v after the subtraction.
>   */
> -static inline int64_t
> -rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
> -
>  static inline int64_t
>  rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
>  {
> @@ -971,8 +899,6 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t de=
c)
>   * @return
>   *   True if the result after the addition is 0; false otherwise.
>   */
> -static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
> -
>  static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_add_return(v, 1) =3D=3D 0;
> @@ -989,8 +915,6 @@ static inline int
> rte_atomic64_inc_and_test(rte_atomic64_t *v)
>   * @return
>   *   True if the result after subtraction is 0; false otherwise.
>   */
> -static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
> -
>  static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_sub_return(v, 1) =3D=3D 0;
> @@ -1007,8 +931,6 @@ static inline int
> rte_atomic64_dec_and_test(rte_atomic64_t *v)
>   * @return
>   *   0 if failed; else 1, success.
>   */
> -static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
> -
>  static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
> @@ -1020,8 +942,6 @@ static inline int
> rte_atomic64_test_and_set(rte_atomic64_t *v)
>   * @param v
>   *   A pointer to the atomic counter.
>   */
> -static inline void rte_atomic64_clear(rte_atomic64_t *v);
> -
>  static inline void rte_atomic64_clear(rte_atomic64_t *v)
>  {
>  	rte_atomic64_set(v, 0);
> diff --git a/lib/eal/loongarch/include/rte_atomic.h
> b/lib/eal/loongarch/include/rte_atomic.h
> index 785a452c9e..a789e3ab4d 100644
> --- a/lib/eal/loongarch/include/rte_atomic.h
> +++ b/lib/eal/loongarch/include/rte_atomic.h
> @@ -18,12 +18,6 @@ extern "C" {
>=20
>  #define rte_rmb()	rte_mb()
>=20
> -#define rte_smp_mb()	rte_mb()
> -
> -#define rte_smp_wmb()	rte_mb()
> -
> -#define rte_smp_rmb()	rte_mb()
> -
>  #define rte_io_mb()	rte_mb()
>=20
>  #define rte_io_wmb()	rte_mb()
> diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_a=
tomic.h
> index 64f4c3d670..0e64db2a35 100644
> --- a/lib/eal/ppc/include/rte_atomic.h
> +++ b/lib/eal/ppc/include/rte_atomic.h
> @@ -24,12 +24,6 @@ extern "C" {
>=20
>  #define	rte_rmb() asm volatile("sync" : : : "memory")
>=20
> -#define rte_smp_mb() rte_mb()
> -
> -#define rte_smp_wmb() rte_wmb()
> -
> -#define rte_smp_rmb() rte_rmb()
> -
>  #define rte_io_mb() rte_mb()
>=20
>  #define rte_io_wmb() rte_wmb()
> diff --git a/lib/eal/riscv/include/rte_atomic.h b/lib/eal/riscv/include/r=
te_atomic.h
> index 061b175f33..04c40e4e9b 100644
> --- a/lib/eal/riscv/include/rte_atomic.h
> +++ b/lib/eal/riscv/include/rte_atomic.h
> @@ -23,12 +23,6 @@ extern "C" {
>=20
>  #define rte_rmb()	asm volatile("fence r, r" : : : "memory")
>=20
> -#define rte_smp_mb()	rte_mb()
> -
> -#define rte_smp_wmb()	rte_wmb()
> -
> -#define rte_smp_rmb()	rte_rmb()
> -
>  #define rte_io_mb()	asm volatile("fence iorw, iorw" : : : "memory")
>=20
>  #define rte_io_wmb()	asm volatile("fence orw, ow" : : : "memory")
> diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_a=
tomic.h
> index 4f05302c9f..f4d39ce4fe 100644
> --- a/lib/eal/x86/include/rte_atomic.h
> +++ b/lib/eal/x86/include/rte_atomic.h
> @@ -23,10 +23,6 @@
>=20
>  #define	rte_rmb() _mm_lfence()
>=20
> -#define rte_smp_wmb() rte_compiler_barrier()
> -
> -#define rte_smp_rmb() rte_compiler_barrier()
> -
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -63,20 +59,6 @@ extern "C" {
>   * So below we use that technique for rte_smp_mb() implementation.
>   */
>=20
> -static __rte_always_inline void
> -rte_smp_mb(void)
> -{
> -#ifdef RTE_TOOLCHAIN_MSVC
> -	_mm_mfence();
> -#else
> -#ifdef RTE_ARCH_I686
> -	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
> -#else
> -	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> -#endif
> -#endif
> -}
> -
>  #define rte_io_mb() rte_mb()
>=20
>  #define rte_io_wmb() rte_compiler_barrier()
> @@ -93,10 +75,19 @@ rte_smp_mb(void)
>  static __rte_always_inline void
>  rte_atomic_thread_fence(rte_memory_order memorder)
>  {
> -	if (memorder =3D=3D rte_memory_order_seq_cst)
> -		rte_smp_mb();
> -	else
> +	if (memorder =3D=3D rte_memory_order_seq_cst) {
> +#ifdef RTE_TOOLCHAIN_MSVC
> +		_mm_mfence();
> +#else
> +#ifdef RTE_ARCH_I686
> +		asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
> +#else
> +		asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> +#endif
> +#endif
> +	} else {
>  		__rte_atomic_thread_fence(memorder);
> +	}
>  }
>=20
>  #ifdef __cplusplus
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

