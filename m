Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AE606EEBB
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PieQfT9F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D30040297;
	Fri,  6 Nov 2026 10:33:00 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTPS id EB0A44026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 10:32:58 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=P8ZmWTdvGDtWQ0LQgK+yb66qOtPWsfghn4CXlWUAspw=;
 b=PieQfT9F7g4GrIrEr3/aKlxY4quXNTbWhHTq/pK9klAv4VZaQDtUMpYDPkoSGNuVMDEW7qpbi
 jjhtFz/tsRI//eCtlA7GjfQATBnmDCgBhBm/XZL6pPYF9G7EuUvAN24MWhkvaCYMPRUGF93nhgP
 X40yUeb3MvnWtWjh4/oMuCw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jLYqy4Sfjz1K96j;
 Fri,  6 Nov 2026 17:32:46 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C3E1840586;
 Fri,  6 Nov 2026 17:32:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 6 Nov 2026 17:32:52 +0800
Message-ID: <36c8f004-36e2-46fe-904c-eab9bb28c89f@huawei.com>
Date: Fri, 6 Nov 2026 17:32:51 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] use NUMA node terminology
To: Bruce Richardson <bruce.richardson@intel.com>, Chengwen Feng
 <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <dev@dpdk.org>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261106061438.392492-1-chengwen.feng@linux.dev>
 <au2T6IClba6Ggpwg@bricha3-mobl1.ger.corp.intel.com>
 <au2UvV4uBfsAHHSU@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <au2UvV4uBfsAHHSU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 4:50 PM, Bruce Richardson wrote:
> On Fri, Nov 06, 2026 at 08:46:32AM +0000, Bruce Richardson wrote:
>> On Fri, Nov 06, 2026 at 02:14:36PM +0800, Chengwen Feng wrote:
>>> From: Chengwen Feng <fengchengwen@huawei.com>
>>>
>>> This is a new version of the "use NUMA node terminology" series,
>>> which converted the whole tree to the NUMA node terminology
>>> (about 227 patches).
>>>
>>> Following the review feedback, this version takes a staged
>>> approach. This series only contains the groundwork, there is no
>>> tree-wide replacement patch:
>>>
>>> 1/2 doc: deprecate socket terminology in favor of NUMA node
>>> 2/2 cocci: add script for NUMA node terminology renames
>>>
>>> The deprecation notice announces the socket_id to numa_node field
>>> renames of the public structures and the deprecation of the
>>> socket-named functions, the rte_malloc_socket_stats structure and
>>> the SOCKET_ID_ANY macro. The old names are kept as deprecated
>>> aliases for one release, giving applications a full release
>>> window to migrate.
>>>
>>> Once the notice has completed a release cycle, the coccinelle
>>> script will be used to generate a single tree-wide conversion
>>> patch, instead of the previous large series of small patches
>>> which overloaded the CI.
>>>
>>> The script covers the mechanical source renames: API function
>>> call sites, macros, the rte_malloc_socket_stats structure, and
>>> socket_id member accesses. Coccinelle cannot express every
>>> needed change: designated initializers, union field declarations,
>>> documentation and string literals require manual adjustments; it
>>> also silently skips functions whose signature carries attribute
>>> macros it does not know (e.g. __rte_unused). The same applies to
>>> the fields named "socket" in rte_graph and rte_bbdev_queue_conf,
>>> where a generic rename rule would over-match.
>>>
>>> The replacement names follow the libnuma node semantics while
>>> keeping the existing DPDK memory allocation model: bare node
>>> getters (rte_numa_node(), rte_numa_node_count(),
>>> rte_numa_node_by_idx(), rte_cpu_numa_node(),
>>> rte_lcore_to_numa_node()), an rte_malloc_onnode() allocation
>>> family shaped after libnuma's numa_alloc_onnode(), and
>>> rte_malloc_heap_get_numa_node().
>>>
>>> Series-changes: 2
>>> - only the deprecation notice and the coccinelle script, the
>>>   tree-wide conversion patch will be submitted after the notice
>>>   completes a release cycle
>>> - keep old names as deprecated aliases for one release window
>>> - cover the full rename set in the script (malloc family,
>>>   rte_cpu_socket_id, rte_cryptodev_socket_id,
>>>   rte_ml_dev_socket_id, rte_malloc_socket_stats)
>>> - use a "Terminology change" tag in the deprecation notice as
>>>   the rename spans several libraries
>>> - name the replacements after libnuma semantics
>>>   (rte_numa_node(), rte_malloc_onnode(), ...)
>>>
>>> Chengwen Feng (2):
>>>   doc: deprecate socket terminology in favor of NUMA node
>>>   cocci: add script for NUMA node terminology renames
>>>
>> I worry a bit about the churn and compatibilty issues such a widespread
>> rename sould cause. These are some very widely used, common APIs that have
>> been around since the earliest days of DPDK. At minimum I think we need to
>> keep the old functions around for well longer than just one release window
>> after deprecation - a multi-year deprecation and removal plan would be
>> better to avoid suddenly breaking every  DPDK end-application out there.
>>
> 
> Might an alternative solution be to just document that DPDK historically
> uses "socket" as a synonym for numa node, even though such a term is
> inaccurate. Just accept the less-than-optimal naming as a historical
> oddity?

I share the concern about compatibility impact given how ubiquitous these APIs are.
It is important to separate two steps:
1) Updating DPDK internal code to use the new NUMA naming via the cocci script
2) Removing the deprecated socket-named aliases for applications

The first step only cleans the in-tree codebase. The old aliases can stay present
for applications for a multi-year period, and their removal can be scheduled
independently, not immediately after one release cycle.

Keeping the existing names and only updating documentation is a pragmatic option,
but it does not resolve the recurring confusion between CPU socket and NUMA node.
This mismatch still misleads new developers and triggers topology-related bugs.

I am willing to follow community consensus on the deprecation timeline and
the overall approach.

> 
> /Bruce
> 

