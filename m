Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7D2D3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 09:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C654240280;
	Mon,  8 Dec 2025 10:43:05 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C21254003C
 for <dev@dpdk.org>; Mon,  8 Dec 2025 10:43:03 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dPxqC2z2szJ469B;
 Mon,  8 Dec 2025 17:42:47 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id E0F614056D;
 Mon,  8 Dec 2025 17:43:01 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 8 Dec 2025 09:43:01 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 8 Dec 2025 09:43:01 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-2022-jp?B?bWFubnl3YW5nKBskQjImMUpKdhsoQik=?= <mannywang@tencent.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v6] acl: support custom memory allocators
Thread-Topic: [PATCH v6] acl: support custom memory allocators
Thread-Index: AQHcY22PWbrv6GKo5kS8T6P61cmsvLUXhRKw
Date: Mon, 8 Dec 2025 09:43:01 +0000
Message-ID: <2571c074e438491e837c51d1bdc5a538@huawei.com>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
 <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
In-Reply-To: <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.34]
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



> Allow users to provide custom
> memory allocation hooks for runtime memory in rte_acl_ctx, via
> struct rte_acl_mem_hook.

LGTM in general, few extra comments below.

> Key changes:
> - Added struct rte_acl_mem_hook with zalloc, free, and udata.
> - Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get callbacks.
> - Default allocation uses existing rte_zmalloc_socket/rte_free.
> - Modified ACL code to call callbacks for runtime allocations instead
>   of rte_zmalloc_socket/rte_free directly.
>=20
> v5:
> - Remove temporary memory allocation callback for build stage.
> - Introduce new API (rte_acl_set_mem_hook / rte_acl_get_mem_hook)
>   instead of modifying existing rte_acl_config to preserve
>   ABI compatibility.
>=20
> v6:
> - Reworked API to meet consistency and naming conventions.
> - Adjusted parameter order for better readability and alignment.
> - Renamed internal variables for clarity and code consistency.
>=20
> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> ---
>  app/test/test_acl.c                           | 121 ++++++++++++++++++
>  .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
>  lib/acl/acl.h                                 |   1 +
>  lib/acl/acl_bld.c                             |   2 +-
>  lib/acl/acl_gen.c                             |   4 +-
>  lib/acl/rte_acl.c                             |  45 ++++++-
>  lib/acl/rte_acl.h                             |  47 +++++++
>  7 files changed, 247 insertions(+), 4 deletions(-)
>=20
> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> index 43d13b5b0f..3c9a0cb8c0 100644
> --- a/app/test/test_acl.c
> +++ b/app/test/test_acl.c
> @@ -1721,6 +1721,125 @@ test_u32_range(void)
>  	return rc;
>  }
>=20
> +struct acl_ctx_wrapper {
> +	struct rte_acl_ctx *ctx;
> +	void *running_buf;
> +	bool running_buf_using;
> +};
> +
> +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
> +
> +static void *running_alloc(char *name, size_t size,
> +	size_t align, int32_t socket_id, void *udata)
> +{
> +	RTE_SET_USED(align);
> +	RTE_SET_USED(name);
> +	RTE_SET_USED(socket_id);
> +	if (size > ACL_RUNNING_BUF_SIZE)
> +		return NULL;
> +	struct acl_ctx_wrapper *acl_ctx =3D (struct acl_ctx_wrapper *)udata;
> +	if (acl_ctx->running_buf_using)
> +		return NULL;
> +	printf("running memory alloc for acl context, size=3D%zu, pointer=3D%p\=
n",
> +		size,
> +		acl_ctx->running_buf);
> +	memset(acl_ctx->running_buf, 0, size);
> +	acl_ctx->running_buf_using =3D true;
> +	return acl_ctx->running_buf;
> +}

Is there any point to have such memhook in our UT?
From one side: it doesn't test anything new, as memory is still allocsted v=
ia rte_zmalloc().
From other side it is error prone, as you don't check that pre-allocated bu=
ffer
will really satisfy requested  size and alignment parameters.
Might be just use libc malloc/free here?=20

> +
> +static void running_free(void *ptr, void *udata)
> +{
> +	if (!ptr)
> +		return;
> +	struct acl_ctx_wrapper *acl_ctx =3D (struct acl_ctx_wrapper *)udata;
> +	printf("running memory free, pointer=3D%p\n", ptr);
> +	acl_ctx->running_buf_using =3D false;
> +}
> +
> +static int
> +test_mem_hook(void)
> +{
> +	int i, ret;
> +	struct acl_ctx_wrapper acl_ctx_wrapper =3D {0};
> +	acl_ctx_wrapper.ctx =3D rte_acl_create(&acl_param);
> +	if (acl_ctx_wrapper.ctx =3D=3D NULL) {
> +		printf("Line %i: Error creating ACL context!\n", __LINE__);
> +		return -1;
> +	}
> +	acl_ctx_wrapper.running_buf =3D rte_zmalloc_socket(
> +		"test_acl",
> +		ACL_RUNNING_BUF_SIZE,
> +		RTE_CACHE_LINE_SIZE,
> +		SOCKET_ID_ANY);
> +	if (!acl_ctx_wrapper.running_buf) {
> +		rte_acl_free(acl_ctx_wrapper.ctx);
> +		printf("Line %i: Error allocing running buf for acl context!\n",
> __LINE__);
> +		return 1;
> +	}
> +	acl_ctx_wrapper.running_buf_using =3D false;
> +
> +	struct rte_acl_mem_hook mhook =3D {
> +		.zalloc =3D running_alloc,
> +		.free =3D running_free,
> +		.udata =3D &acl_ctx_wrapper
> +	};
> +	ret =3D rte_acl_set_mem_hook(acl_ctx_wrapper.ctx, &mhook);
> +	if (ret !=3D 0) {
> +		printf("Line %i: Error set mem hook for acl context!\n",
> __LINE__);
> +		rte_acl_free(acl_ctx_wrapper.ctx);
> +		rte_free(acl_ctx_wrapper.running_buf);
> +		return 1;
> +	}
> +	struct rte_acl_mem_hook new_hook;
> +	memset(&new_hook, 0, sizeof(struct rte_acl_mem_hook));
> +	if (rte_acl_get_mem_hook(acl_ctx_wrapper.ctx, &new_hook) !=3D 0
> +		|| memcmp(&mhook, &new_hook, sizeof(struct
> rte_acl_mem_hook)) !=3D 0) {
> +		printf("Line %i: Error get mem hook for acl context!\n",
> __LINE__);
> +		rte_acl_free(acl_ctx_wrapper.ctx);
> +		rte_free(acl_ctx_wrapper.running_buf);
> +		return 1;
> +	}
> +	ret =3D 0;
> +	for (i =3D 0; i < TEST_CLASSIFY_ITER; i++) {
> +
> +		if ((i & 1) =3D=3D 0)
> +			rte_acl_reset(acl_ctx_wrapper.ctx);
> +		else
> +			rte_acl_reset_rules(acl_ctx_wrapper.ctx);
> +
> +		ret =3D test_classify_buid(acl_ctx_wrapper.ctx, acl_test_rules,
> +			RTE_DIM(acl_test_rules));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: Adding rules to ACL context
> failed!\n",
> +				__LINE__, i);
> +			break;
> +		}
> +
> +		ret =3D test_classify_run(acl_ctx_wrapper.ctx, acl_test_data,
> +			RTE_DIM(acl_test_data));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: %s failed!\n",
> +				__LINE__, i, __func__);
> +			break;
> +		}
> +
> +		/* reset rules and make sure that classify still works ok. */
> +		rte_acl_reset_rules(acl_ctx_wrapper.ctx);
> +		ret =3D test_classify_run(acl_ctx_wrapper.ctx, acl_test_data,
> +			RTE_DIM(acl_test_data));
> +		if (ret !=3D 0) {
> +			printf("Line %i, iter: %d: %s failed!\n",
> +				__LINE__, i, __func__);
> +			break;
> +		}
> +	}
> +
> +	rte_acl_free(acl_ctx_wrapper.ctx);
> +	rte_free(acl_ctx_wrapper.running_buf);
> +	return ret;
> +}
> +
>  static int
>  test_acl(void)
>  {
> @@ -1742,6 +1861,8 @@ test_acl(void)
>  		return -1;
>  	if (test_u32_range() < 0)
>  		return -1;
> +	if (test_mem_hook() < 0)
> +		return -1;
>=20
>  	return 0;
>  }
> diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
> b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
> index 172f443f6e..55b2018db9 100644
> --- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
> +++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
> @@ -359,7 +359,38 @@ For example:
>          ret =3D rte_acl_build(acx, &cfg);
>       }
>=20
> +Custom Memory Hooks
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The ACL library supports custom memory allocation for runtime structures=
.
> +Applications can supply their own memory hooks through:
> +
> +.. code-block:: c
> +
> +    int rte_acl_set_mem_hook(struct rte_acl_ctx *ctx,
> +                           const struct rte_acl_mem_hook *mhook);
> +
> +    int rte_acl_get_mem_hook(const struct rte_acl_ctx *ctx,
> +                           struct rte_acl_mem_hook *mhook);
> +
> +The ``rte_acl_mem_hook`` structure defines memory hooks:
> +
> +.. code-block:: c
> +
> +    struct rte_acl_mem_hook {
> +        /** Allocate zero-initialized memory used during runtime. */
> +        void *(*zalloc)(char *name, size_t size, size_t align, int32_t s=
ocket_id, void
> *udata);
> +
> +        /** Free memory previously allocated by zalloc(). */
> +        void (*free)(void *ptr, void *udata);
> +
> +        /** User-provided context passed to allocation/free hooks. */
> +        void *udata;
> +    };
> +
> +Applications may use these hooks to allocate memory from custom pools or
> pre-allocated buffers.
>=20
> +If no memory hook is provided, the ACL library uses rte_zmalloc_socket()
> internally.
>=20
>  Classification methods
>  ~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/lib/acl/acl.h b/lib/acl/acl.h
> index c8e4e72fab..9c85a3d58a 100644
> --- a/lib/acl/acl.h
> +++ b/lib/acl/acl.h
> @@ -174,6 +174,7 @@ struct rte_acl_ctx {
>  	uint32_t            max_rules;
>  	uint32_t            rule_sz;
>  	uint32_t            num_rules;
> +	struct rte_acl_mem_hook mem_hook;
>  	uint32_t            num_categories;
>  	uint32_t            num_tries;
>  	uint32_t            match_index;
> diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
> index 7056b1c117..99d1dbc467 100644
> --- a/lib/acl/acl_bld.c
> +++ b/lib/acl/acl_bld.c
> @@ -779,7 +779,7 @@ acl_merge_trie(struct acl_build_context *context,
>  static void
>  acl_build_reset(struct rte_acl_ctx *ctx)
>  {
> -	rte_free(ctx->mem);
> +	ctx->mem_hook.free(ctx->mem, ctx->mem_hook.udata);
>  	memset(&ctx->num_categories, 0,
>  		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
>  }
> diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
> index 3c53d24056..77f19dd13a 100644
> --- a/lib/acl/acl_gen.c
> +++ b/lib/acl/acl_gen.c
> @@ -478,8 +478,8 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_t=
rie
> *trie,
>  		return -ERANGE;
>  	}
>=20
> -	mem =3D rte_zmalloc_socket(ctx->name, total_size,
> RTE_CACHE_LINE_SIZE,
> -			ctx->socket_id);
> +	mem =3D ctx->mem_hook.zalloc(ctx->name, total_size,
> +			RTE_CACHE_LINE_SIZE, ctx->socket_id, ctx-
> >mem_hook.udata);
>  	if (mem =3D=3D NULL) {
>  		ACL_LOG(ERR,
>  			"allocation of %zu bytes on socket %d for %s failed",
> diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
> index 8c0ca29618..3f2b194206 100644
> --- a/lib/acl/rte_acl.c
> +++ b/lib/acl/rte_acl.c
> @@ -264,6 +264,20 @@ acl_get_best_alg(void)
>  	return alg[i];
>  }
>=20
> +static void *
> +acl_mem_default_zalloc(char *name, size_t size, size_t align, int32_t so=
cket_id,
> void *udata)
> +{
> +	RTE_SET_USED(udata);
> +	return rte_zmalloc_socket(name, size, align, socket_id);
> +}
> +
> +static void
> +acl_mem_default_free(void *ptr, void *udata)
> +{
> +	RTE_SET_USED(udata);
> +	rte_free(ptr);
> +}
> +
>  RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
>  extern int
>  rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_=
alg alg)
> @@ -362,7 +376,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
>=20
>  	rte_mcfg_tailq_write_unlock();
>=20
> -	rte_free(ctx->mem);
> +	ctx->mem_hook.free(ctx->mem, ctx->mem_hook.udata);
>  	rte_free(ctx);
>  	rte_free(te);
>  }
> @@ -425,6 +439,9 @@ rte_acl_create(const struct rte_acl_param *param)
>  		ctx->rule_sz =3D param->rule_size;
>  		ctx->socket_id =3D param->socket_id;
>  		ctx->alg =3D acl_get_best_alg();
> +		ctx->mem_hook.zalloc =3D acl_mem_default_zalloc;
> +		ctx->mem_hook.free =3D acl_mem_default_free;
> +		ctx->mem_hook.udata =3D NULL;
>  		strlcpy(ctx->name, param->name, sizeof(ctx->name));
>=20
>  		te->data =3D (void *) ctx;
> @@ -555,3 +572,29 @@ rte_acl_list_dump(void)
>  	}
>  	rte_mcfg_tailq_read_unlock();
>  }
> +
> +/*
> + * Set memory allocation hooks for a given ACL context.
> + */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_set_mem_hook, 26.03)
> +int
> +rte_acl_set_mem_hook(struct rte_acl_ctx *acl, const struct rte_acl_mem_h=
ook
> *mhook)
> +{
> +	if (acl =3D=3D NULL || mhook =3D=3D NULL || mhook->zalloc  =3D=3D NULL =
|| mhook-
> >free =3D=3D NULL)
> +		return -EINVAL;
> +	memcpy(&acl->mem_hook, mhook, sizeof(struct rte_acl_mem_hook));
> +	return 0;
> +}
> +
> +/*
> + * Retrieve the memory allocation hooks assigned to the ACL context.
> + */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_get_mem_hook, 26.03)
> +int
> +rte_acl_get_mem_hook(const struct rte_acl_ctx *acl, struct
> rte_acl_mem_hook *mhook)
> +{
> +	if (acl  =3D=3D NULL || mhook =3D=3D NULL)
> +		return -EINVAL;
> +	memcpy(mhook, &acl->mem_hook, sizeof(struct rte_acl_mem_hook));
> +	return 0;
> +}
> diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
> index 95354cabb8..5cae733a65 100644
> --- a/lib/acl/rte_acl.h
> +++ b/lib/acl/rte_acl.h
> @@ -136,6 +136,53 @@ struct rte_acl_param {
>  /** @internal opaque ACL handle */
>  struct rte_acl_ctx;
>=20
> +/**
> + * Memory allocation hooks for ACL runtime.
> + */
> +struct rte_acl_mem_hook {
> +	/** Allocate zero-initialized memory used during runtime. */
> +	void *(*zalloc)(char *name, size_t size, size_t align, int32_t socket_i=
d,
> void *udata);
> +
> +	/** Free memory previously allocated by zalloc(). */
> +	void (*free)(void *ptr, void *udata);
> +
> +	/** User-provided context passed to allocation/free hooks. */
> +	void *udata;
> +};
> +
> +/**
> + * Set memory allocation hooks for a given ACL context.
> + *
> + * Applications may use these hooks to allocate memory from custom pools=
 or
> pre-allocated buffers.
> + * If no memory hook is provided, the ACL library uses rte_zmalloc_socke=
t()
> internally.
> + *
> + * @param acl
> + *   The ACL context.
> + * @param mhook
> + *   Pointer to the memory hook structure

We probably need to mention that it has to be called before acl_build().
And if acl_build() already was invoked (user wants to change mhook after it=
),
then user has to do the following sequence:
rte_acl_reset(); re_acl_set_mem_hook(); rte_acl_build();

> + *
> + * @return
> + *   0 on success.
> + *   -EINVAL if parameters are invalid.
> + */
> +__rte_experimental
> +int rte_acl_set_mem_hook(struct rte_acl_ctx *acl, const struct
> rte_acl_mem_hook *mhook);
> +
> +/**
> + * Retrieve the memory allocation hooks assigned to the ACL context.
> + *
> + * @param acl
> + *   The ACL context.
> + * @param mhook
> + *   Output location for the current memory hook structure
> + *
> + * @return
> + *   0 on success.
> + *   -EINVAL if parameters are invalid.
> + */
> +__rte_experimental
> +int rte_acl_get_mem_hook(const struct rte_acl_ctx *acl, struct
> rte_acl_mem_hook *mhook);
> +
>  /**
>   * De-allocate all memory used by ACL context.
>   *
> --
> 2.43.0

