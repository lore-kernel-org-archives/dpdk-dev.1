Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D5CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A1F540280;
	Mon, 25 May 2026 20:23:49 +0200 (CEST)
Received: from smtp-gw.pt.net (smtp-gw.pt.net [206.210.192.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4C91540144
 for <dev@dpdk.org>; Mon, 25 May 2026 20:23:47 +0200 (CEST)
Received: from smtp-gw.pt.net (localhost.localdomain [127.0.0.1])
 by smtp-gw.pt.net (Proxmox) with ESMTP id 62231324BC;
 Mon, 25 May 2026 13:23:46 -0500 (CDT)
Received: from mail.pt.net (mail.pt.net [IPv6:2604:42c0:0:200::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-gw.pt.net (Proxmox) with ESMTPS;
 Mon, 25 May 2026 13:23:45 -0500 (CDT)
Received: from mail.pt.net (localhost [IPv6:::1])
 by mail.pt.net (Postfix) with ESMTP id 9E0F11F9AA6C;
 Mon, 25 May 2026 13:23:45 -0500 (CDT)
Received: from localhost (localhost [IPv6:::1])
 by mail.pt.net (Postfix) with ESMTP id 813FC1F9AD94;
 Mon, 25 May 2026 13:23:45 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.pt.net 813FC1F9AD94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perftech.com;
 s=B15A3A56-ABEA-11EE-9719-5F12F125680F; t=1779733425;
 bh=tk2luYA+WL640jQlfoCjV4Hgcjnny6SYXOO7JNtISW4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=ars/sEAxKgdoR54/10qqkZ8NRyvt7G/qXx8PuRuHFjOqusmLnnci6XyaabAtsX8+v
 RXtQZmnb5hL8/c4YJSPNhtEjCgbmf2wc3gFq0WRGCUV+eW564EtLmjqctpIJg10RYZ
 jirS9a3iCOR/zlsluQS822vOc3sY0G/1jPTvi1EKIyv8ZzDv09ZXah38uO5DyoOD8Z
 +QSeJ6JIQmnjJSJ9T6Gzph2Yc477lZ41Dr+mkpituL7bBj5piLSEgw71u5uBCPxRL/
 DYJjHbZJK/tODT5kW95lxGKXbxGOltuXyv/CLPv778IV/O/4Cm+RozyPKw6FZ9XWLT
 iFUE1MO4ayYVg==
Received: from mail.pt.net ([IPv6:::1])
 by localhost (mail.pt.net [IPv6:::1]) (amavis, port 10026) with ESMTP
 id gPutYz2dYJgU; Mon, 25 May 2026 13:23:45 -0500 (CDT)
Received: from mail.pt.net (mail.pt.net [206.210.194.11])
 by mail.pt.net (Postfix) with ESMTP id 5F2B01F9AD92;
 Mon, 25 May 2026 13:23:45 -0500 (CDT)
Date: Mon, 25 May 2026 13:23:45 -0500 (CDT)
From: Lewis Donzis <lew@perftech.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev <dev@dpdk.org>
Message-ID: <798329995.7656018.1779733425328.JavaMail.zimbra@donzis.com>
In-Reply-To: <20260525171340.1701509-3-bruce.richardson@intel.com>
References: <20260525171340.1701509-1-bruce.richardson@intel.com>
 <20260525171340.1701509-3-bruce.richardson@intel.com>
Subject: Re: [PATCH 2/2] eal/freebsd: implement virtual to IOVA translation fn
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [206.210.194.11]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - GC148
 (Mac)/10.1.16_GA_4863)
Thread-Topic: eal/freebsd: implement virtual to IOVA translation fn
Thread-Index: EOAj/u4/EeOwo72lmObo38BdmH+FRg==
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

Tested with igc driver, which previously failed and now works properly.

----- On May 25, 2026, at 12:13 PM, Bruce Richardson bruce.richardson@intel.com wrote:

> The function rte_mem_virt2iova() function was always returning BAD_IOVA
> on FreeBSD as it was not implemented. Unfortunately, this function was
> used by some drivers - expecting it to work as they used addresses from
> rte_malloc calls. Implement this call on FreeBSD to fix things and
> enable more drivers on BSD.  To verify the function works as expected
> add a basic unit test to the memory_autotest for it.
> 
> At the same time, we can trivially use this to implement the
> rte_mem_virt2phy function for the case of using contigmem where IOVAs
> are physical addresses.
> 
> Reported-by: Lewis Donzis <lew@perftech.com>
Tested-by: Lewis Donzis <lew@perftech.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> NOTE: This is one of those patches that could be either a bugfix or a
> feature. For now, I'm treating it as adding new feature support, though
> in doing so it enables previously broken drivers.
> ---
> app/test/test_memory.c       | 67 ++++++++++++++++++++++++++++++++++++
> lib/eal/freebsd/eal_memory.c | 22 +++++++++---
> 2 files changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/app/test/test_memory.c b/app/test/test_memory.c
> index 628714c0b8..260d5ed8f8 100644
> --- a/app/test/test_memory.c
> +++ b/app/test/test_memory.c
> @@ -8,6 +8,7 @@
> #include <rte_eal.h>
> #include <rte_errno.h>
> #include <rte_memory.h>
> +#include <rte_malloc.h>
> #include <rte_common.h>
> #include <rte_memzone.h>
> 
> @@ -75,6 +76,68 @@ check_seg_fds(const struct rte_memseg_list *msl, const struct
> rte_memseg *ms,
> 	return 0;
> }
> 
> +static int
> +check_malloc_virt2iova(void)
> +{
> +	const size_t alloc_sz = 128;
> +	const size_t off = 32;
> +	struct rte_memseg *ms;
> +	char *p;
> +	rte_iova_t iova, iova_off;
> +
> +	p = rte_malloc("memory_autotest", alloc_sz, RTE_CACHE_LINE_SIZE);
> +	if (p == NULL) {
> +		printf("rte_malloc failed\n");
> +		return -1;
> +	}
> +
> +	iova = rte_mem_virt2iova(p);
> +	if (iova == RTE_BAD_IOVA) {
> +		printf("rte_mem_virt2iova failed for rte_malloc pointer\n");
> +		rte_free(p);
> +		return -1;
> +	}
> +
> +	ms = rte_mem_virt2memseg(p, NULL);
> +	if (ms == NULL) {
> +		printf("failed to resolve memseg for rte_malloc pointer\n");
> +		rte_free(p);
> +		return -1;
> +	}
> +
> +	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
> +		if (ms->iova == RTE_BAD_IOVA || iova < ms->iova ||
> +					iova >= ms->iova + ms->len) {
> +			printf("translated iova is outside memseg range\n");
> +			rte_free(p);
> +			return -1;
> +		}
> +
> +		phys_addr_t physaddr = rte_mem_virt2phy(p);
> +		if (physaddr == RTE_BAD_PHYS_ADDR || physaddr != iova) {
> +			printf("rte_mem_virt2phy failed for rte_malloc pointer\n");
> +			rte_free(p);
> +			return -1;
> +		}
> +	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
> +		if (iova != (uintptr_t)p) {
> +			printf("rte_mem_virt2iova did not return VA in VA mode\n");
> +			rte_free(p);
> +			return -1;
> +		}
> +	}
> +
> +	iova_off = rte_mem_virt2iova(p + off);
> +	if (iova_off == RTE_BAD_IOVA || iova_off != iova + off) {
> +		printf("translated iova for interior pointer is invalid\n");
> +		rte_free(p);
> +		return -1;
> +	}
> +
> +	rte_free(p);
> +	return 0;
> +}
> +
> static int
> test_memory(void)
> {
> @@ -107,6 +170,10 @@ test_memory(void)
> 		return -1;
> 	}
> 
> +	ret = check_malloc_virt2iova();
> +	if (ret < 0)
> +		return ret;
> +
> 	return 0;
> }
> 
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index e56d149a22..6952b38630 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -40,16 +40,28 @@ RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
> phys_addr_t
> rte_mem_virt2phy(const void *virtaddr)
> {
> -	/* XXX not implemented. This function is only used by
> -	 * rte_mempool_virt2iova() when hugepages are disabled. */
> -	(void)virtaddr;
> -	return RTE_BAD_IOVA;
> +	/* not implemented for FreeBSD when not using contigmem memory */
> +	if (virtaddr == NULL || rte_eal_iova_mode() != RTE_IOVA_PA)
> +		return RTE_BAD_IOVA;
> +	/* when IOVA == PA, return the IOVA */
> +	return rte_mem_virt2iova(virtaddr);
> }
> +
> RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
> rte_iova_t
> rte_mem_virt2iova(const void *virtaddr)
> {
> -	return rte_mem_virt2phy(virtaddr);
> +	if (virtaddr == NULL)
> +		return RTE_BAD_IOVA;
> +
> +	if (rte_eal_iova_mode() == RTE_IOVA_VA)
> +		return (uintptr_t)virtaddr;
> +
> +	const struct rte_memseg *ms = rte_mem_virt2memseg(virtaddr, NULL);
> +	if (ms != NULL && ms->iova != RTE_BAD_IOVA)
> +		return ms->iova + RTE_PTR_DIFF(virtaddr, ms->addr);
> +
> +	return RTE_BAD_IOVA;
> }
> 
> int
> --
> 2.53.0

