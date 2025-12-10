Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37AD2CE17
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 04:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86654028F;
	Wed, 10 Dec 2025 05:09:35 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 55FB040285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 05:09:33 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tewKn+kONInav4VtXxstfu0so7j9GR0ziEgeTE2Mlf4=;
 b=L0woYvYoVWB2FnS4+3h301II1zDD2HJ/cD6Ue9Q4+Iyi8gSDcKqqTn5nR2iw82xVtiuw78w5e
 yTAFWccujH0XsmVpW2W7Zre8xbsCxk+570iTghof7kW7Geo8WhpUjcGCkHYvt87ASWXJOp9dkAe
 yMWx9f0xbhZdjiNxYf+SRC0=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dR2Gp2fN9zpSvc;
 Wed, 10 Dec 2025 12:06:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B75AE18047D;
 Wed, 10 Dec 2025 12:09:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Dec 2025 12:09:29 +0800
Message-ID: <46bf8bcd-9abb-47dc-905f-8190053dff58@huawei.com>
Date: Wed, 10 Dec 2025 12:09:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] acl: support custom memory allocators
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: =?UTF-8?B?bWFubnl3YW5nKOeOi+awuOWzsCk=?= <mannywang@tencent.com>,
 "dev@dpdk.org" <dev@dpdk.org>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
 <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
 <2571c074e438491e837c51d1bdc5a538@huawei.com>
 <20251208112916.2743f596@phoenix.local>
 <f1d4e2f3dd2841dd86799faf00a6d559@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <f1d4e2f3dd2841dd86799faf00a6d559@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 12/9/2025 7:06 PM, Konstantin Ananyev wrote:
> 
> 
>> On Mon, 8 Dec 2025 09:43:01 +0000
>> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
>>
>>>> Allow users to provide custom
>>>> memory allocation hooks for runtime memory in rte_acl_ctx, via
>>>> struct rte_acl_mem_hook.
>>>
>>> LGTM in general, few extra comments below.
>>>
>>>> Key changes:
>>>> - Added struct rte_acl_mem_hook with zalloc, free, and udata.
>>>> - Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get
>> callbacks.
>>>> - Default allocation uses existing rte_zmalloc_socket/rte_free.
>>>> - Modified ACL code to call callbacks for runtime allocations instead
>>>>   of rte_zmalloc_socket/rte_free directly.
>>>>
>>>> v5:
>>>> - Remove temporary memory allocation callback for build stage.
>>>> - Introduce new API (rte_acl_set_mem_hook / rte_acl_get_mem_hook)
>>>>   instead of modifying existing rte_acl_config to preserve
>>>>   ABI compatibility.
>>>>
>>>> v6:
>>>> - Reworked API to meet consistency and naming conventions.
>>>> - Adjusted parameter order for better readability and alignment.
>>>> - Renamed internal variables for clarity and code consistency.
>>>>
>>>> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
>>>> ---
>>>>  app/test/test_acl.c                           | 121 ++++++++++++++++++
>>>>  .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
>>>>  lib/acl/acl.h                                 |   1 +
>>>>  lib/acl/acl_bld.c                             |   2 +-
>>>>  lib/acl/acl_gen.c                             |   4 +-
>>>>  lib/acl/rte_acl.c                             |  45 ++++++-
>>>>  lib/acl/rte_acl.h                             |  47 +++++++
>>>>  7 files changed, 247 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
>>>> index 43d13b5b0f..3c9a0cb8c0 100644
>>>> --- a/app/test/test_acl.c
>>>> +++ b/app/test/test_acl.c
>>>> @@ -1721,6 +1721,125 @@ test_u32_range(void)
>>>>  	return rc;
>>>>  }
>>>>
>>>> +struct acl_ctx_wrapper {
>>>> +	struct rte_acl_ctx *ctx;
>>>> +	void *running_buf;
>>>> +	bool running_buf_using;
>>>> +};
>>>> +
>>>> +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
>>>> +
>>>> +static void *running_alloc(char *name, size_t size,
>>>> +	size_t align, int32_t socket_id, void *udata)
>>>> +{
>>>> +	RTE_SET_USED(align);
>>>> +	RTE_SET_USED(name);
>>>> +	RTE_SET_USED(socket_id);
>>>> +	if (size > ACL_RUNNING_BUF_SIZE)
>>>> +		return NULL;
>>>> +	struct acl_ctx_wrapper *acl_ctx = (struct acl_ctx_wrapper *)udata;
>>>> +	if (acl_ctx->running_buf_using)
>>>> +		return NULL;
>>>> +	printf("running memory alloc for acl context, size=%zu, pointer=%p\n",
>>>> +		size,
>>>> +		acl_ctx->running_buf);
>>>> +	memset(acl_ctx->running_buf, 0, size);
>>>> +	acl_ctx->running_buf_using = true;
>>>> +	return acl_ctx->running_buf;
>>>> +}
>>>
>>> Is there any point to have such memhook in our UT?
>>> From one side: it doesn't test anything new, as memory is still allocsted via
>> rte_zmalloc().
>>> From other side it is error prone, as you don't check that pre-allocated buffer
>>> will really satisfy requested  size and alignment parameters.
>>> Might be just use libc malloc/free here?
>>
>> A lot of the problems would go away if ACL just used regular malloc/free more,
>> and rte_malloc/rte_free less.
> 
> It uses rte_malloc in just two places - to allocate ctx itself and for actual Run-Time table.
> All temporary allocations are done with normal malloc.
> There are obvious reasons why people prefer to use rte_malloc-ed memory
> in their data-path functions: rte-malloc-ed memory uses hugepages and is MP shared.  
> So I suppose providing users a choice where they want their ACL tables to be located
> is a good option.

There is a global acl list (rte_acl_tailq) which could across multi-process, so that
main process create one acl, then secondary process could get the same acl by
rte_acl_create() with same name. This based on the acl library use rte_malloc.
Now the base is broken when introduce this commit.

> 
>> The existing rte_malloc is slow and fragments badly. 
> Then we probably need to improve it, don't we?
> 
> 

