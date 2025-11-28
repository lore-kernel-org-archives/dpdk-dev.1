Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98906D116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 832B84013F;
	Fri, 28 Nov 2025 14:27:01 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5CB20400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:26:59 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHvFV6M8yzHnGgW;
 Fri, 28 Nov 2025 21:26:06 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 62E9E1402E9;
 Fri, 28 Nov 2025 21:26:57 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 28 Nov 2025 13:26:57 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 28 Nov 2025 13:26:56 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-2022-jp?B?bWFubnl3YW5nKBskQjImMUpKdhsoQik=?= <mannywang@tencent.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3] acl: support custom memory allocator
Thread-Topic: [PATCH v3] acl: support custom memory allocator
Thread-Index: AQHcXgUgi5rf52Vm+kC03uKxL4rzm7UIFOPA
Date: Fri, 28 Nov 2025 13:26:56 +0000
Message-ID: <db4d85aea29e4549b04750288db649c3@huawei.com>
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
In-Reply-To: <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="iso-2022-jp"
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



> Reduce memory fragmentation caused by dynamic memory allocations
> by allowing users to provide custom memory allocator.
>=20
> Add new members to struct rte_acl_config to allow passing custom
> allocator callbacks to rte_acl_build:
>=20
> - running_alloc: allocator callback for run-time internal memory
> - running_free: free callback for run-time internal memory
> - running_ctx: user-defined context passed to running_alloc/free
>=20
> - temp_alloc: allocator callback for temporary memory during ACL build
> - temp_reset: reset callback for temporary allocator
> - temp_ctx: user-defined context passed to temp_alloc/reset
>=20
> These callbacks allow users to provide their own memory pools or
> allocators for both persistent runtime structures and temporary
> build-time data.
>=20
> A typical approach is to pre-allocate a static memory region
> for rte_acl_ctx, and to provide a global temporary memory manager
> that supports multipleallocations and a single reset during ACL build.
>=20
> Since tb_mem_pool handles allocation failures using siglongjmp,
> temp_alloc follows the same approach for failure handling.

Thank you for the patch, though overall approach looks
a bit overcomplicated to me: in particular I am still not convinced
that we do need a special allocator for temporary build buffers.
Another concern, is that 'struct rte_acl_config' is part of public=20
API and can't be changed at will: only at next API/ABI breakage point.
Can I suggest something more simpler:

1. Add new pubic API:
struct rte_acl_mem_cb {
    void (*zalloc)(void *udata, size_t size, size_t align, int32_t numa_soc=
ket);
   void (*free)( void *udata, void *ptr2free);
   void *udata;
};=20
   =20
int rte_acl_set_mem_cb(struct rte_acl_ctx *acl, const struct struct rte_acl=
_mem_ctx *mcb);
int rte_acl_get_mem_cb(const struct rte_acl_ctx *acl, struct struct rte_acl=
_mem_ctx *mcb);

and add ' struct rte_acl_mem_cb' instance into struct rte_acl_ctx.
At  rte_acl_create() initialize them into some default functions that will =
be just a stubs
around calling rte_zmallo_socket()/rte_free().
At acl_gen.c we will have:
-    mem =3D rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
+   mem =3D ctx->mcb.zmalloc(ctx->mcb.udata, total_size, RTE_CACHE_LINE_SIZ=
E,
                        ctx->socket_id);

Does it make sense to you?
=20
> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> ---
>  app/test/test_acl.c | 181
> +++++++++++++++++++++++++++++++++++++++++++-
>  lib/acl/acl.h       |   3 +-
>  lib/acl/acl_bld.c   |  14 +++-
>  lib/acl/acl_gen.c   |   8 +-
>  lib/acl/rte_acl.c   |   5 +-
>  lib/acl/rte_acl.h   |  20 +++++
>  lib/acl/tb_mem.c    |   8 ++
>  lib/acl/tb_mem.h    |   6 ++
>  8 files changed, 236 insertions(+), 9 deletions(-)
>=20
> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> index 43d13b5b0f..9c6ed34f0c 100644
> --- a/app/test/test_acl.c
> +++ b/app/test/test_acl.c
> @@ -1721,6 +1721,184 @@ test_u32_range(void)
>  	return rc;
>  }
>=20
> +struct acl_ctx_wrapper_t {
> +	struct rte_acl_ctx *ctx;
> +	void *running_buf;
> +	bool running_buf_using;
> +};
> +
> +struct acl_temp_mem_mgr_t {
> +	void *buf;
> +	uint32_t buf_used;
> +	sigjmp_buf fail;
> +};
> +
> +struct acl_ctx_wrapper_t g_acl_ctx_wrapper;
> +struct acl_temp_mem_mgr_t g_temp_mem_mgr;
> +
> +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
> +#define ACL_TEMP_BUF_SIZE (10 * 1024 * 1024)
> +
> +static void *running_alloc(size_t size, unsigned int align, void *cb_dat=
a)
> +{
> +	(void)align;
> +	struct acl_ctx_wrapper_t *gwlb_acl_ctx =3D (struct acl_ctx_wrapper_t
> *)cb_data;
> +	if (gwlb_acl_ctx->running_buf_using)
> +		return NULL;
> +	printf("running memory alloc for acl context, size=3D%zu, pointer=3D%p\=
n",
> +		size,
> +		gwlb_acl_ctx->running_buf);
> +	gwlb_acl_ctx->running_buf_using =3D true;
> +	return gwlb_acl_ctx->running_buf;
> +}
> +
> +static void running_free(void *buf, void *cb_data)
> +{
> +	if (!buf)
> +		return;
> +	struct acl_ctx_wrapper_t *gwlb_acl_ctx =3D (struct acl_ctx_wrapper_t
> *)cb_data;
> +	printf("running memory free pointer=3D%p\n", buf);
> +	gwlb_acl_ctx->running_buf_using =3D false;
> +}
> +
> +static void *temp_alloc(size_t size, sigjmp_buf fail, void *cb_data)
> +{
> +	struct acl_temp_mem_mgr_t *gwlb_acl_build =3D (struct
> acl_temp_mem_mgr_t *)cb_data;
> +	if (ACL_TEMP_BUF_SIZE - gwlb_acl_build->buf_used < size) {
> +		printf("Line %i: alloc temp memory fail, size=3D%zu, used=3D%d\n",
> +			__LINE__,
> +			size,
> +			gwlb_acl_build->buf_used);
> +		siglongjmp(fail, -ENOMEM);
> +		return NULL;
> +	}
> +	void *ret =3D (char *)gwlb_acl_build->buf + gwlb_acl_build->buf_used;
> +	gwlb_acl_build->buf_used +=3D size;
> +	return ret;
> +}
> +
> +static void temp_reset(void *cb_data)
> +{
> +	struct acl_temp_mem_mgr_t *gwlb_acl_build =3D (struct
> acl_temp_mem_mgr_t *)cb_data;
> +	memset(gwlb_acl_build->buf, 0, ACL_TEMP_BUF_SIZE);
> +	printf("temp memory reset, used total=3D%u\n", gwlb_acl_build-
> >buf_used);
> +	gwlb_acl_build->buf_used =3D 0;
> +}
> +
> +static int
> +rte_acl_ipv4vlan_build_wich_mem_cb(struct rte_acl_ctx *ctx,
> +	const uint32_t layout[RTE_ACL_IPV4VLAN_NUM],
> +	uint32_t num_categories)
> +{
> +	struct rte_acl_config cfg;
> +
> +	if (ctx =3D=3D NULL || layout =3D=3D NULL)
> +		return -EINVAL;
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	acl_ipv4vlan_config(&cfg, layout, num_categories);
> +	cfg.running_alloc =3D running_alloc;
> +	cfg.running_free =3D running_free;
> +	cfg.running_cb_ctx =3D &g_acl_ctx_wrapper;
> +	cfg.temp_alloc =3D temp_alloc;
> +	cfg.temp_reset =3D temp_reset;
> +	cfg.temp_cb_ctx =3D &g_temp_mem_mgr;
> +	return rte_acl_build(ctx, &cfg);
> +}
> +
> +static int
> +test_classify_buid_wich_mem_cb(struct rte_acl_ctx *acx,
> +	const struct rte_acl_ipv4vlan_rule *rules, uint32_t num)
> +{
> +	int ret;
> +
> +	/* add rules to the context */
> +	ret =3D rte_acl_ipv4vlan_add_rules(acx, rules, num);
> +	if (ret !=3D 0) {
> +		printf("Line %i: Adding rules to ACL context failed!\n",
> +			__LINE__);
> +		return ret;
> +	}
> +
> +	/* try building the context */
> +	ret =3D rte_acl_ipv4vlan_build_wich_mem_cb(acx, ipv4_7tuple_layout,
> +		RTE_ACL_MAX_CATEGORIES);
> +	if (ret !=3D 0) {
> +		printf("Line %i: Building ACL context failed!\n", __LINE__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +test_mem_cb(void)
> +{
> +	int i, ret;
> +	g_acl_ctx_wrapper.ctx =3D rte_acl_create(&acl_param);
> +	if (g_acl_ctx_wrapper.ctx =3D=3D NULL) {
> +		printf("Line %i: Error creating ACL context!\n", __LINE__);
> +		return -1;
> +	}
> +	g_acl_ctx_wrapper.running_buf =3D rte_zmalloc_socket(
> +		"test_acl",
> +		ACL_RUNNING_BUF_SIZE,
> +		RTE_CACHE_LINE_SIZE,
> +		SOCKET_ID_ANY);
> +	if (!g_acl_ctx_wrapper.running_buf) {
> +		printf("Line %i: Error allocing running buf for acl context!\n",
> __LINE__);
> +		return 1;
> +	}
> +	g_acl_ctx_wrapper.running_buf_using =3D false;
> +
> +	g_temp_mem_mgr.buf =3D malloc(ACL_TEMP_BUF_SIZE);
> +	if (!g_temp_mem_mgr.buf)
> +		printf("Line %i: Error allocing teem buf for acl build!\n",
> __LINE__);
> +	memset(g_temp_mem_mgr.buf, 0, ACL_TEMP_BUF_SIZE);
> +	g_temp_mem_mgr.buf_used =3D 0;
> +
> +	ret =3D 0;
> +	for (i =3D 0; i !=3D TEST_CLASSIFY_ITER; i++) {
> +
> +		if ((i & 1) =3D=3D 0)
> +			rte_acl_reset(g_acl_ctx_wrapper.ctx);
> +		else
> +			rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
> +
> +		ret =3D test_classify_buid_wich_mem_cb(g_acl_ctx_wrapper.ctx,
> acl_test_rules,
> +			RTE_DIM(acl_test_rules));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: "
> +				"Adding rules to ACL context failed!\n",
> +				__LINE__, i);
> +			break;
> +		}
> +
> +		ret =3D test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
> +			RTE_DIM(acl_test_data));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: %s failed!\n",
> +				__LINE__, i, __func__);
> +			break;
> +		}
> +
> +		/* reset rules and make sure that classify still works ok. */
> +		rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
> +		ret =3D test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
> +			RTE_DIM(acl_test_data));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: %s failed!\n",
> +				__LINE__, i, __func__);
> +			break;
> +		}
> +	}
> +
> +	rte_acl_free(g_acl_ctx_wrapper.ctx);
> +	free(g_temp_mem_mgr.buf);
> +	rte_free(g_acl_ctx_wrapper.running_buf);
> +	return ret;
> +}
> +
>  static int
>  test_acl(void)
>  {
> @@ -1742,7 +1920,8 @@ test_acl(void)
>  		return -1;
>  	if (test_u32_range() < 0)
>  		return -1;
> -
> +	if (test_mem_cb() < 0)
> +		return -1;
>  	return 0;
>  }
>=20
> diff --git a/lib/acl/acl.h b/lib/acl/acl.h
> index c8e4e72fab..7080fff64d 100644
> --- a/lib/acl/acl.h
> +++ b/lib/acl/acl.h
> @@ -189,7 +189,8 @@ struct rte_acl_ctx {
>=20
>  int rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
>  	struct rte_acl_bld_trie *node_bld_trie, uint32_t num_tries,
> -	uint32_t num_categories, uint32_t data_index_sz, size_t max_size);
> +	uint32_t num_categories, uint32_t data_index_sz, size_t max_size,
> +	const struct rte_acl_config *cfg);
>=20
>  typedef int (*rte_acl_classify_t)
>  (const struct rte_acl_ctx *, const uint8_t **, uint32_t *, uint32_t, uin=
t32_t);
> diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
> index 7056b1c117..1fd0ee3aa5 100644
> --- a/lib/acl/acl_bld.c
> +++ b/lib/acl/acl_bld.c
> @@ -777,9 +777,12 @@ acl_merge_trie(struct acl_build_context *context,
>   *  - reset all RT related fields to zero.
>   */
>  static void
> -acl_build_reset(struct rte_acl_ctx *ctx)
> +acl_build_reset(struct rte_acl_ctx *ctx, const struct rte_acl_config *cf=
g)
>  {
> -	rte_free(ctx->mem);
> +	if (cfg->running_free)
> +		cfg->running_free(ctx->mem, cfg->running_cb_ctx);
> +	else
> +		rte_free(ctx->mem);
>  	memset(&ctx->num_categories, 0,
>  		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
>  }
> @@ -1518,6 +1521,9 @@ acl_bld(struct acl_build_context *bcx, struct rte_a=
cl_ctx
> *ctx,
>  	bcx->acx =3D ctx;
>  	bcx->pool.alignment =3D ACL_POOL_ALIGN;
>  	bcx->pool.min_alloc =3D ACL_POOL_ALLOC_MIN;
> +	bcx->pool.alloc_cb =3D cfg->temp_alloc;
> +	bcx->pool.reset_cb =3D cfg->temp_reset;
> +	bcx->pool.cb_ctx =3D cfg->temp_cb_ctx;
>  	bcx->cfg =3D *cfg;
>  	bcx->category_mask =3D RTE_LEN2MASK(bcx->cfg.num_categories,
>  		typeof(bcx->category_mask));
> @@ -1635,7 +1641,7 @@ rte_acl_build(struct rte_acl_ctx *ctx, const struct
> rte_acl_config *cfg)
>  	if (rc !=3D 0)
>  		return rc;
>=20
> -	acl_build_reset(ctx);
> +	acl_build_reset(ctx, cfg);
>=20
>  	if (cfg->max_size =3D=3D 0) {
>  		n =3D NODE_MIN;
> @@ -1655,7 +1661,7 @@ rte_acl_build(struct rte_acl_ctx *ctx, const struct
> rte_acl_config *cfg)
>  			rc =3D rte_acl_gen(ctx, bcx.tries, bcx.bld_tries,
>  				bcx.num_tries, bcx.cfg.num_categories,
>  				ACL_MAX_INDEXES * RTE_DIM(bcx.tries) *
> -				sizeof(ctx->data_indexes[0]), max_size);
> +				sizeof(ctx->data_indexes[0]), max_size, cfg);
>  			if (rc =3D=3D 0) {
>  				/* set data indexes. */
>  				acl_set_data_indexes(ctx);
> diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
> index 3c53d24056..6aa7d74635 100644
> --- a/lib/acl/acl_gen.c
> +++ b/lib/acl/acl_gen.c
> @@ -448,7 +448,8 @@ acl_calc_counts_indices(struct acl_node_counters
> *counts,
>  int
>  rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
>  	struct rte_acl_bld_trie *node_bld_trie, uint32_t num_tries,
> -	uint32_t num_categories, uint32_t data_index_sz, size_t max_size)
> +	uint32_t num_categories, uint32_t data_index_sz, size_t max_size,
> +	const struct rte_acl_config *cfg)
>  {
>  	void *mem;
>  	size_t total_size;
> @@ -478,7 +479,10 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_=
trie
> *trie,
>  		return -ERANGE;
>  	}
>=20
> -	mem =3D rte_zmalloc_socket(ctx->name, total_size,
> RTE_CACHE_LINE_SIZE,
> +	if (cfg->running_alloc)
> +		mem =3D cfg->running_alloc(total_size, RTE_CACHE_LINE_SIZE, cfg-
> >running_cb_ctx);
> +	else
> +		mem =3D rte_zmalloc_socket(ctx->name, total_size,
> RTE_CACHE_LINE_SIZE,
>  			ctx->socket_id);
>  	if (mem =3D=3D NULL) {
>  		ACL_LOG(ERR,
> diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
> index 8c0ca29618..e765c40f4f 100644
> --- a/lib/acl/rte_acl.c
> +++ b/lib/acl/rte_acl.c
> @@ -362,7 +362,10 @@ rte_acl_free(struct rte_acl_ctx *ctx)
>=20
>  	rte_mcfg_tailq_write_unlock();
>=20
> -	rte_free(ctx->mem);
> +	if (ctx->config.running_free)
> +		ctx->config.running_free(ctx->mem, ctx-
> >config.running_cb_ctx);
> +	else
> +		rte_free(ctx->mem);
>  	rte_free(ctx);
>  	rte_free(te);
>  }
> diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
> index 95354cabb8..c675c9ff81 100644
> --- a/lib/acl/rte_acl.h
> +++ b/lib/acl/rte_acl.h
> @@ -13,6 +13,7 @@
>=20
>  #include <rte_common.h>
>  #include <rte_acl_osdep.h>
> +#include <setjmp.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -61,6 +62,11 @@ struct rte_acl_field_def {
>   * ACL build configuration.
>   * Defines the fields of an ACL trie and number of categories to build w=
ith.
>   */
> +typedef void *(*rte_acl_running_alloc_t)(size_t, unsigned int, void *);
> +typedef void  (*rte_acl_running_free_t)(void *, void *);
> +typedef void *(*rte_acl_temp_alloc_t)(size_t, sigjmp_buf, void *);
> +typedef void  (*rte_acl_temp_reset_t)(void *);
> +
>  struct rte_acl_config {
>  	uint32_t num_categories; /**< Number of categories to build with. */
>  	uint32_t num_fields;     /**< Number of field definitions. */
> @@ -68,6 +74,20 @@ struct rte_acl_config {
>  	/**< array of field definitions. */
>  	size_t max_size;
>  	/**< max memory limit for internal run-time structures. */
> +
> +	/**< Allocator callback for run-time internal memory. */
> +	rte_acl_running_alloc_t  running_alloc;
> +	/**< Free callback for run-time internal memory. */
> +	rte_acl_running_free_t   running_free;
> +	/**< User context passed to running_alloc/free. */
> +	void                     *running_cb_ctx;
> +
> +	/**< Allocator callback for temporary memory used during build. */
> +	rte_acl_temp_alloc_t     temp_alloc;
> +	/**< Reset callback for temporary allocator. */
> +	rte_acl_temp_reset_t     temp_reset;
> +	/**< User context passed to temp_alloc/reset. */
> +	void                     *temp_cb_ctx;
>  };
>=20
>  /**
> diff --git a/lib/acl/tb_mem.c b/lib/acl/tb_mem.c
> index 9264433422..b9c69b563e 100644
> --- a/lib/acl/tb_mem.c
> +++ b/lib/acl/tb_mem.c
> @@ -55,6 +55,9 @@ tb_alloc(struct tb_mem_pool *pool, size_t size)
>=20
>  	size =3D RTE_ALIGN_CEIL(size, pool->alignment);
>=20
> +	if (pool->alloc_cb)
> +		return pool->alloc_cb(size, pool->fail, pool->cb_ctx);
> +
>  	block =3D pool->block;
>  	if (block =3D=3D NULL || block->size < size) {
>  		new_sz =3D (size > pool->min_alloc) ? size : pool->min_alloc;
> @@ -71,6 +74,11 @@ tb_free_pool(struct tb_mem_pool *pool)
>  {
>  	struct tb_mem_block *next, *block;
>=20
> +	if (pool->reset_cb) {
> +		pool->reset_cb(pool->cb_ctx);
> +		return;
> +	}
> +
>  	for (block =3D pool->block; block !=3D NULL; block =3D next) {
>  		next =3D block->next;
>  		free(block);
> diff --git a/lib/acl/tb_mem.h b/lib/acl/tb_mem.h
> index 2093744a6d..2fdebefc31 100644
> --- a/lib/acl/tb_mem.h
> +++ b/lib/acl/tb_mem.h
> @@ -24,11 +24,17 @@ struct tb_mem_block {
>  	uint8_t             *mem;
>  };
>=20
> +typedef void *(*rte_tb_alloc_t)(size_t, sigjmp_buf, void *);
> +typedef void (*rte_tb_reset_t)(void *);
> +
>  struct tb_mem_pool {
>  	struct tb_mem_block *block;
>  	size_t               alignment;
>  	size_t               min_alloc;
>  	size_t               alloc;
> +	rte_tb_alloc_t       alloc_cb;
> +	rte_tb_reset_t       reset_cb;
> +	void                 *cb_ctx;
>  	/* jump target in case of memory allocation failure. */
>  	sigjmp_buf           fail;
>  };
> --
> 2.43.0

