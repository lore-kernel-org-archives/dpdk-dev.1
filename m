Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E523CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4409E40268;
	Tue,  2 Dec 2025 10:31:34 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 5FABF400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 10:31:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764667890;
 bh=AWNuYc7rx20VGvb5fTPxq3uLC4OJDy3yp+eA0Mzefr4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=lhoFyps7oUcR88NVhNxGgSnv9oeb0PjWJCiF8IKZhyaeZYpKduUN1woWJ6Vrl7kXD
 WJNYpqNoIQPwTzyQsYCI9Gqfky5mc8JEGYH8JEfJWfG/hy2JvvDmNtHo8HFvU15DSg
 mGo9SAvhVoQLN5pJfxFvl6eN37atEHW+nwSMHA/Q=
X-QQ-mid: esmtpgz10t1764667889t14be34ad
X-QQ-Originating-IP: WlP81WaDYhnKtNUF8Gvn25cho7VmrItY9uk3RebAuTU=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 02 Dec 2025 17:31:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7060600564640799184
Message-ID: <1DF1D898A5174549+02f62241-5859-4ba3-9edb-d2c086ec497d@tencent.com>
Date: Tue, 2 Dec 2025 17:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v5] acl: support custom memory allocators in
 rte_acl_build
To: fengchengwen <fengchengwen@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
References: <db4d85aea29e4549b04750288db649c3@huawei.com>
 <2AAF65CF8F892CB1+20251201124518.122734-1-mannywang@tencent.com>
 <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPRquJFDOUjC75YQxVRktM7gXWf4m99qAfF1vz1hlPlksjlPExacGs2c
 Xk1NQ7YlDwWX4EzdhOM0dCqRoKUH4NIsY1Vjc1/xrHzPk6BRTj3O90tldW6tUctcld+BEQ2
 K75imAbUZMiPG4H2tLm79KDK4KsWvntShFFe+uqamZltVKQzVCbeMqxPofrnA/UVMYdv7hH
 uY1hGMVs51nadp2oEZKKWYu+K5VFHegA/mKKLA7ki38gXQ9xN7fjURLfqCEJkygWeqs+W0v
 8QASQTwOs0jCmvbSKEef9dYyCRDwu0xKf1KoHSFnR9AX6GTeH2UE0vJXhV5iMkBl3mY0Dhb
 l1A2VdApjVVnHibsyts2IADpHllbVtCFRQpszgJpK8l/LuK3n9oT42HA7WQiAIyQjGZvULx
 VovvNsiaOtKBQ8GSSeD/7qZhDoffjtqxkThRugGDHQq1dW4FVj4rgzq+DWvsmBAdPY+0GxL
 7CE4MJ2k7+A7ScXinuCIfL1urjFOCg68PNkEjZi+SJYUDgx5cC5WGfGlAc65Zolp6RH8Px0
 GN3MtBlqYGtp+ONZA+fiLdNlJjZo88HG/vKglIVfCPmxjVa+RBZaSZl1yYHh+wIZWRODgn+
 EgjLSQ9yzH8LJ5t9hVorlXhef/guMLxKqIWK6XznJhCuSZywjGKUgf//qe8oTtU3jUobG/U
 aENw0VImMAs4xIhg+7DJjcepLZoXLZ8IRh0lTB740g/8Z1Mr/yVK2tbPhlPcdqOI3MYqAEl
 0zotkr/I2xCETfGjzBQL5+Vvolky8VXAVyHAUg+pwgK386W6UT0Muqpi567kPrWdVDj4r52
 e2Oz219klDQb/OfIgAGg3u53RotTkniIxP43rrbhJqS7X95JJ1ICutA1RdX9n2gDRoLcjL2
 hHBZa+mQUbLjg/jJ2+oD/4AM+JSeIWCDJbF7YWCK6phFciWMXyPoPmQkNSeYkFw+ZLeUrbg
 mp4nb2VRsS1lXd7+1E9H1nPMYkgzRFFluWX6oC/RkjLiDCA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

Thanks for the review and comments.

Regarding the placement of mem_hook (or mem_cb):
I didn’t adopt the suggestion to move this field after num_categories, 
because the memory region after num_categories is cleared during 
rte_acl_reset().
To preserve the callback data across resets, the field must be located 
before num_categories.

All the other comments have been addressed in this version.

On 12/2/2025 10:47 AM, fengchengwen wrote:
> commit header could simply as: acl: support custom memory allocator
> 
> On 12/1/2025 8:45 PM, mannywang(王永峰) wrote:
>> Allow users to provide custom
>> memory allocation callbacks for runtime memory in rte_acl_ctx, via
>> struct rte_acl_mem_cb.
>>
>> Key changes:
>> - Added struct rte_acl_mem_cb with zalloc, free, and udata.
>> - Added rte_acl_set_mem_cb() / rte_acl_get_mem_cb() to set/get callbacks.
>> - Default allocation uses existing rte_zmalloc_socket/rte_free.
>> - Modified ACL code to call callbacks for runtime allocations instead
>>    of rte_zmalloc_socket/rte_free directly.
>>
>> v5:
>> - Remove temporary memory allocation callback for build stage.
>> - Introduce new API (rte_acl_set_mem_cb / rte_acl_get_mem_cb) instead of
>>    modifying existing rte_acl_config to preserve ABI compatibility.
>>
>> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
>> ---
>>   app/test/test_acl.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
>>   lib/acl/acl.h       |   1 +
>>   lib/acl/acl_bld.c   |   2 +-
>>   lib/acl/acl_gen.c   |   4 +-
>>   lib/acl/rte_acl.c   |  45 +++++++++++++++-
>>   lib/acl/rte_acl.h   |  42 +++++++++++++++
>>   6 files changed, 211 insertions(+), 4 deletions(-)
>>
>> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
>> index 43d13b5b0f..930fdf8362 100644
>> --- a/app/test/test_acl.c
>> +++ b/app/test/test_acl.c
>> @@ -1721,6 +1721,125 @@ test_u32_range(void)
>>   	return rc;
>>   }
>>   
>> +struct acl_ctx_wrapper_t {
> 
> no need add post-fix _t
> 
>> +	struct rte_acl_ctx *ctx;
>> +	void *running_buf;
>> +	bool running_buf_using;
>> +};
>> +
>> +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
>> +
>> +static void *running_alloc(void *udata, char *name, size_t size,
>> +	size_t align, int32_t socket_id)
>> +{
>> +	(void)align;
>> +	(void)name;
>> +	(void)socket_id;
>> +	if (size > ACL_RUNNING_BUF_SIZE)
>> +		return NULL;
>> +	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)udata;
> 
> gwlb - what the meaning? suggest simple acl_ctx or just ctx.
> 
>> +	if (gwlb_acl_ctx->running_buf_using)
>> +		return NULL;
>> +	printf("running memory alloc for acl context, size=%zu, pointer=%p\n",
>> +		size,
>> +		gwlb_acl_ctx->running_buf);
>> +	memset(gwlb_acl_ctx->running_buf, 0, size);
>> +	gwlb_acl_ctx->running_buf_using = true;
> 
> this allocator don't support conti alloc, it will has dependent for acl-library,
> how about use Dmitry Kozlyuk's comment for [PATCH v3], that is use rte_malloc_heap_create
> 
>> +	return gwlb_acl_ctx->running_buf;
>> +}
>> +
>> +static void running_free(void *udata, void *ptr)
>> +{
>> +	if (!ptr)
>> +		return;
>> +	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)udata;
>> +	printf("running memory free, pointer=%p\n", ptr);
>> +	gwlb_acl_ctx->running_buf_using = false;
>> +}
>> +
>> +static int
>> +test_mem_cb(void)
>> +{
>> +	int i, ret;
>> +	struct acl_ctx_wrapper_t g_acl_ctx_wrapper;
> 
> no need add g_acl_ prefix, and suggest zero default (struct acl_ctx_wrapper ctx_wrap = {0})
> 
>> +	g_acl_ctx_wrapper.ctx = rte_acl_create(&acl_param);
>> +	if (g_acl_ctx_wrapper.ctx == NULL) {
>> +		printf("Line %i: Error creating ACL context!\n", __LINE__);
>> +		return -1;
>> +	}
>> +	g_acl_ctx_wrapper.running_buf = rte_zmalloc_socket(
>> +		"test_acl",
>> +		ACL_RUNNING_BUF_SIZE,
>> +		RTE_CACHE_LINE_SIZE,
>> +		SOCKET_ID_ANY);
>> +	if (!g_acl_ctx_wrapper.running_buf) {
>> +		printf("Line %i: Error allocing running buf for acl context!\n", __LINE__);
> 
> please add resource rollback, the same as following.
> 
>> +		return 1;
>> +	}
>> +	g_acl_ctx_wrapper.running_buf_using = false;
>> +
>> +	struct rte_acl_mem_cb mcb = {
>> +		.zalloc = running_alloc,
>> +		.free = running_free,
>> +		.udata = &g_acl_ctx_wrapper
>> +	};
>> +	ret = rte_acl_set_mem_cb(g_acl_ctx_wrapper.ctx, &mcb);
>> +	if (ret) {
> 
> please use explicit exp, e.g. if (ret != 0), the same as other place.
> 
>> +		printf("Line %i: Error set mem cb for acl context!\n", __LINE__);
>> +		return 1;
>> +	}
>> +	struct rte_acl_mem_cb new_mcb;
>> +	memset(&new_mcb, 0, sizeof(struct rte_acl_mem_cb));
>> +	ret = rte_acl_get_mem_cb(g_acl_ctx_wrapper.ctx, &new_mcb);
>> +	if (ret) {
>> +		printf("Line %i: Error get mem cb for acl context!\n", __LINE__);
>> +		return 1;
>> +	}
>> +	if (memcmp(&mcb, &new_mcb, sizeof(struct rte_acl_mem_cb)) != 0) {
>> +		printf("Line %i: Error get mem cb for acl context!\n", __LINE__);
>> +		return 1;
>> +	}
>> +	ret = 0;
>> +	for (i = 0; i != TEST_CLASSIFY_ITER; i++) {
> 
> why not i < TEST_CLASSIFY_ITER ?
> 
>> +
>> +		if ((i & 1) == 0)
>> +			rte_acl_reset(g_acl_ctx_wrapper.ctx);
>> +		else
>> +			rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
>> +
>> +		ret = test_classify_buid(g_acl_ctx_wrapper.ctx, acl_test_rules,
>> +			RTE_DIM(acl_test_rules));
>> +		if (ret != 0) {
>> +			printf("Line %i, iter: %d: "
>> +				"Adding rules to ACL context failed!\n",
> 
> no need extra line for log-string.
> 
>> +				__LINE__, i);
>> +			break;
>> +		}
>> +
>> +		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
>> +			RTE_DIM(acl_test_data));
>> +		if (ret != 0) {
>> +			printf("Line %i, iter: %d: %s failed!\n",
>> +				__LINE__, i, __func__);
>> +			break;
>> +		}
>> +
>> +		/* reset rules and make sure that classify still works ok. */
>> +		rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
>> +		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
>> +			RTE_DIM(acl_test_data));
>> +		if (ret != 0) {
>> +			printf("Line %i, iter: %d: %s failed!\n",
>> +				__LINE__, i, __func__);
>> +			break;
>> +		}
>> +	}
>> +
>> +	rte_acl_free(g_acl_ctx_wrapper.ctx);
>> +	rte_free(g_acl_ctx_wrapper.running_buf);
>> +	return ret;
>> +}
>> +
>>   static int
>>   test_acl(void)
>>   {
>> @@ -1742,6 +1861,8 @@ test_acl(void)
>>   		return -1;
>>   	if (test_u32_range() < 0)
>>   		return -1;
>> +	if (test_mem_cb() < 0)
>> +		return -1;
>>   
>>   	return 0;
>>   }
>> diff --git a/lib/acl/acl.h b/lib/acl/acl.h
>> index c8e4e72fab..3acfc0cb9f 100644
>> --- a/lib/acl/acl.h
>> +++ b/lib/acl/acl.h
>> @@ -174,6 +174,7 @@ struct rte_acl_ctx {
>>   	uint32_t            max_rules;
>>   	uint32_t            rule_sz;
>>   	uint32_t            num_rules;
>> +	struct rte_acl_mem_cb mem_cb;
> 
> why not place near *mem/mem_sz field ?
> 
>>   	uint32_t            num_categories;
>>   	uint32_t            num_tries;
>>   	uint32_t            match_index;
>> diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
>> index 7056b1c117..e3d342bd79 100644
>> --- a/lib/acl/acl_bld.c
>> +++ b/lib/acl/acl_bld.c
>> @@ -779,7 +779,7 @@ acl_merge_trie(struct acl_build_context *context,
>>   static void
>>   acl_build_reset(struct rte_acl_ctx *ctx)
>>   {
>> -	rte_free(ctx->mem);
>> +	ctx->mem_cb.free(ctx->mem_cb.udata, ctx->mem);
>>   	memset(&ctx->num_categories, 0,
>>   		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
>>   }
>> diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
>> index 3c53d24056..f482317884 100644
>> --- a/lib/acl/acl_gen.c
>> +++ b/lib/acl/acl_gen.c
>> @@ -478,8 +478,8 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
>>   		return -ERANGE;
>>   	}
>>   
>> -	mem = rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
>> -			ctx->socket_id);
>> +	mem = ctx->mem_cb.zalloc(ctx->mem_cb.udata, ctx->name, total_size,
>> +			RTE_CACHE_LINE_SIZE, ctx->socket_id);
>>   	if (mem == NULL) {
>>   		ACL_LOG(ERR,
>>   			"allocation of %zu bytes on socket %d for %s failed",
>> diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
>> index 8c0ca29618..3c1a118c46 100644
>> --- a/lib/acl/rte_acl.c
>> +++ b/lib/acl/rte_acl.c
>> @@ -264,6 +264,20 @@ acl_get_best_alg(void)
>>   	return alg[i];
>>   }
>>   
>> +static void *
>> +zalloc_dft(void *udata, char *name, size_t size, size_t align, int32_t socket_id)
> 
> how about acl_mem_default_zalloc?
> 
>> +{
>> +	(void)udata;
>> +	return rte_zmalloc_socket(name, size, align, socket_id);
>> +}
>> +
>> +static void
>> +free_dft(void *udata, void *ptr)
> 
> how about acl_mem_default_free?
> 
>> +{
>> +	(void)udata;
>> +	rte_free(ptr);
>> +}
>> +
>>   RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
>>   extern int
>>   rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
>> @@ -362,7 +376,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
>>   
>>   	rte_mcfg_tailq_write_unlock();
>>   
>> -	rte_free(ctx->mem);
>> +	ctx->mem_cb.free(ctx->mem_cb.udata, ctx->mem);
>>   	rte_free(ctx);
>>   	rte_free(te);
>>   }
>> @@ -425,6 +439,9 @@ rte_acl_create(const struct rte_acl_param *param)
>>   		ctx->rule_sz = param->rule_size;
>>   		ctx->socket_id = param->socket_id;
>>   		ctx->alg = acl_get_best_alg();
>> +		ctx->mem_cb.zalloc = zalloc_dft;
>> +		ctx->mem_cb.free = free_dft;
>> +		ctx->mem_cb.udata = NULL;
>>   		strlcpy(ctx->name, param->name, sizeof(ctx->name));
>>   
>>   		te->data = (void *) ctx;
>> @@ -555,3 +572,29 @@ rte_acl_list_dump(void)
>>   	}
>>   	rte_mcfg_tailq_read_unlock();
>>   }
>> +
>> +/*
>> + * Set memory allocation callbacks for a given ACL context.
>> + */
>> +RTE_EXPORT_SYMBOL(rte_acl_set_mem_cb)
> 
> Should be RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_set_mem_cb, 26.03)
> 
>> +int
>> +rte_acl_set_mem_cb(struct rte_acl_ctx *acl, const struct rte_acl_mem_cb *mcb)
>> +{
>> +	if (!acl || !mcb || !mcb->zalloc || !mcb->free)
> 
> suggest acl == NULL || mcb == NULL and ...
> 
>> +		return -EINVAL;
>> +	memcpy(&acl->mem_cb, mcb, sizeof(struct rte_acl_mem_cb));
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Retrieve the memory allocation callbacks assigned to the ACL context.
>> + */
>> +RTE_EXPORT_SYMBOL(rte_acl_get_mem_cb)
> 
> Should be RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_get_mem_cb, 26.03)
> 
>> +int
>> +rte_acl_get_mem_cb(const struct rte_acl_ctx *acl, struct rte_acl_mem_cb *mcb)
>> +{
>> +	if (!acl || !mcb)
> 
> suggest acl == NULL || mcb == NULL
> 
>> +		return -EINVAL;
>> +	memcpy(mcb, &acl->mem_cb, sizeof(struct rte_acl_mem_cb));
>> +	return 0;
>> +}
>> diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
>> index 95354cabb8..e3273556e2 100644
>> --- a/lib/acl/rte_acl.h
>> +++ b/lib/acl/rte_acl.h
>> @@ -136,6 +136,48 @@ struct rte_acl_param {
>>   /** @internal opaque ACL handle */
>>   struct rte_acl_ctx;
>>   
>> +/**
>> + * Memory allocation callbacks for ACL runtime.
>> + */
>> +struct rte_acl_mem_cb {
> 
> How about rte_acl_mem_hook ?
> I think hook is better suited to this semantics.
> 
>> +	/** Allocate zero-initialized memory used during runtime. */
>> +	void *(*zalloc)(void *udata, char *name, size_t size, size_t align, int32_t socket_id);
> 
> Suggest move udata as the last one parameter.
> 
>> +
>> +	/** Free memory previously allocated by zalloc(). */
>> +	void (*free)(void *udata, void *ptr);
> 
> Suggest move udata as the last one parameter.
> 
>> +
>> +	/** User-provided context passed to allocation/free callbacks. */
>> +	void *udata;
>> +};
>> +
>> +/**
>> + * Set memory allocation callbacks for a given ACL context.
>> + *
>> + * @param acl
>> + *   The ACL context.
>> + * @param mcb
>> + *   Pointer to the memory callback structure
> 
> Suggest add one note about when could invoke this API.
> 
>> + *
>> + * @return
>> + *   0 on success.
>> + *   -EINVAL if parameters are invalid.
>> + */
> 
> should add __rte_experimental
> 
>> +int rte_acl_set_mem_cb(struct rte_acl_ctx *acl, const struct rte_acl_mem_cb *mcb);
>> +
>> +/**
>> + * Retrieve the memory allocation callbacks assigned to the ACL context.
>> + *
>> + * @param acl
>> + *   The ACL context.
>> + * @param mcb
>> + *   Output location for the current memory callback structure
>> + *
>> + * @return
>> + *   0 on success.
>> + *   -EINVAL if parameters are invalid.
>> + */
> 
> should add __rte_experimental
> 
>> +int rte_acl_get_mem_cb(const struct rte_acl_ctx *acl, struct rte_acl_mem_cb *mcb);
>> +
>>   /**
>>    * De-allocate all memory used by ACL context.
>>    *
> 
> please add descriptor section for packet_classif_access_ctrl.rst and release note.
> 
> 
> 


