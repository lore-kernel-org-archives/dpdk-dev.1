Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27666CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA2040650;
	Wed, 10 Jun 2026 03:19:46 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id CC851400D5;
 Wed, 10 Jun 2026 03:19:44 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3blwkgki2omKYS73mQFe9dgR2UGxZfH5t8cly6e0FNI=;
 b=dF1nizCkgOGWrrobkQeqovd9YJihoXC6pSedZxzlSDvjeq34MLDZLJTWCWwZXoU6gp7dBd418
 MHker9E7oihped+X7z//uI55/S80C/UPWlNPhCQkmJpgbQYSYUWWztX45/x6tsmKIZ+32IlHCey
 tDRN9v2Qh5w3feH7exe+vYo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gZnml1p2Kz12LG2;
 Wed, 10 Jun 2026 09:11:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 216D040561;
 Wed, 10 Jun 2026 09:19:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:19:42 +0800
Message-ID: <bfa31475-848f-42af-bfb4-f796433c3073@huawei.com>
Date: Wed, 10 Jun 2026 09:19:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal: add destructor to unregister tailq on unload
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Neil
 Horman <nhorman@tuxdriver.com>, David Marchand <david.marchand@redhat.com>
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609142701.163908-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260609142701.163908-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 6/9/2026 10:26 PM, Stephen Hemminger wrote:
> EAL_REGISTER_TAILQ registers a static rte_tailq_elem from a
> constructor but provides no destructor. If a library using the
> macro is loaded with dlopen() and later unloaded with dlclose(),
> the process-local list keeps a dangling pointer to the unmapped
> elem, and the next dlopen() crashes in rte_eal_tailq_local_register()
> while walking the list.
> 
> Add a new RTE_FINI destructor that is paired with the constructor
> in the macro. rte_eal_tailq_unregister() drops the local entry on
> unload. The shared mcfg->tailq_head[] slot is left reserved since
> it is keyed by name and shared between processes;
> rte_eal_tailq_update() now reattaches to that slot on re-register
> instead of failing.
> 
> Bugzilla ID: 1081
> Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2 - cover the case where name still is reserved
> 
>  lib/eal/common/eal_common_tailqs.c | 13 +++++++++++++
>  lib/eal/include/rte_tailq.h        | 16 ++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
> index c581f43b6f..9355c108f2 100644
> --- a/lib/eal/common/eal_common_tailqs.c
> +++ b/lib/eal/common/eal_common_tailqs.c
> @@ -113,6 +113,11 @@ rte_eal_tailq_update(struct rte_tailq_elem *t)
>  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
>  		/* primary process is the only one that creates */
>  		t->head = rte_eal_tailq_create(t->name);
> +
> +		if (t->head == NULL) {
> +			/* slot reserved by an earlier load -- reuse it */
> +			t->head = rte_eal_tailq_lookup(t->name);



> +		}
>  	} else {
>  		t->head = rte_eal_tailq_lookup(t->name);
>  	}
> @@ -148,6 +153,14 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
>  	return -1;
>  }
>  
> +RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)

this should be with EXPERIMENTAL

> +void
> +rte_eal_tailq_unregister(struct rte_tailq_elem *t)
> +{
> +	TAILQ_REMOVE(&rte_tailq_elem_head, t, next);

We need first make sure it exist the tailq, just like TAILQ_FOREACH rte_eal_tailq_local_register()

> +	t->head = NULL;
> +}
> +
>  int
>  rte_eal_tailqs_init(void)
>  {
> diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
> index e7caed6812..d4d8bfd6d4 100644
> --- a/lib/eal/include/rte_tailq.h
> +++ b/lib/eal/include/rte_tailq.h
> @@ -117,11 +117,27 @@ struct rte_tailq_head *rte_eal_tailq_lookup(const char *name);
>   */
>  int rte_eal_tailq_register(struct rte_tailq_elem *t);
>  
> +/**
> + * Remove a tail queue element from the local list.
> + * This function is mainly used for EAL_REGISTER_TAILQ macro which pairs
> + * an RTE_FINI destructor with the existing RTE_INIT constructor.
> + * The destructor calls this function during dlclose() to prevent
> + * dangling pointers to unmapped library data.

Currently this patch only support next dlopen() the same so file. the
global still exist. Suggest add document for the global entry still exist,
just like commit-log:
"The shared mcfg->tailq_head[] slot is left reserved since
 it is keyed by name and shared between processes;"

> + *
> + * @param t
> + *   The tailq element to remove from the EAL tailq list.
> + */
> +void rte_eal_tailq_unregister(struct rte_tailq_elem *t);
> +
>  #define EAL_REGISTER_TAILQ(t) \
>  RTE_INIT(tailqinitfn_ ##t) \
>  { \
>  	if (rte_eal_tailq_register(&t) < 0) \
>  		rte_panic("Cannot initialize tailq: %s\n", t.name); \
> +} \
> +RTE_FINI(tailqfinifn_ ##t) \
> +{ \
> +	rte_eal_tailq_unregister(&t); \
>  }
>  
>  /* This macro permits both remove and free var within the loop safely.*/

