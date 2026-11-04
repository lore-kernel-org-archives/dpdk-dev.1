Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6E606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sCdWZnMk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1E494026E;
	Wed,  4 Nov 2026 09:55:59 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTPS id 5972240151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 09:55:57 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=49Qs24s7RjTRFPP7GoAps3uDGddEuRb6EByrrallmH4=;
 b=sCdWZnMkUFrItfRtlscebVyh0FM07Ns2pG0PzQucAJnZM21vH4I5KWw+/Ork6fKwxVKPjp/Uw
 SM5FDqVMrm+JxSDLW8s5BHVIP3RvcdYKupzIurHFklxSkzqOZRtbgWGQyhU8PqE4/fyVw77WgMH
 EHl3z2b8wtcwgDhF0oCvgu8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jKK6D4yFNz1K96t;
 Wed,  4 Nov 2026 16:55:48 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 956024056C;
 Wed,  4 Nov 2026 16:55:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 16:55:53 +0800
Message-ID: <7add359d-c77c-42ed-8e92-d5d496b8bcb4@huawei.com>
Date: Wed, 4 Nov 2026 16:55:52 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
To: Stephen Hemminger <stephen@networkplumber.org>, Chengwen Feng
 <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261104083450.215d2660@stephen-xps.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261104083450.215d2660@stephen-xps.local>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/2026 3:34 PM, Stephen Hemminger wrote:
> On Tue,  3 Nov 2026 22:49:18 +0800
> Chengwen Feng <chengwen.feng@linux.dev> wrote:
> 
>> From: Chengwen Feng <fengchengwen@huawei.com>
>>
>> The DPDK tree conflates CPU sockets with NUMA memory nodes: public
>> APIs, structure fields and macros are named after "socket" although
>> they actually identify a NUMA node (e.g. rte_socket_id(), the
>> socket_id field of rte_memzone, SOCKET_ID_ANY). This naming misleads
>> application developers and pollutes vendor code that targets NUMA
>> topologies.
>>
>> This series renames the terminology tree-wide:
>>
>> Foundation (EAL):
>> - New NUMA-aware functions are added: rte_numa_id(),
>>   rte_numa_count(), rte_numa_id_by_idx(), rte_lcore_to_numa_id(),
>>   rte_malloc_heap_numa_is_external(), and friends.
>> - SOCKET_ID_ANY becomes RTE_NUMA_ID_ANY; SOCKET_ID_ANY is kept as a
>>   deprecated macro alias.
>> - The socket_id fields of the public structures are renamed to
>>   numa_id, keeping socket_id as a deprecated union alias (so field
>>   offsets, and therefore ABI layout, are unchanged). Affected
>>   structures include rte_memzone, rte_memseg, rte_memseg_list,
>>   rte_mempool, rte_hash_parameters, rte_graph, rte_service_spec,
>>   rte_acl_param, rte_gro_param, rte_ipsec_sad_conf, rte_member_*,
>>   rte_bbdev_*, rte_cryptodev_config, rte_compressdev_config,
>>   rte_event_*, rte_ml_dev_config, rte_rawdev* -- see
>>   doc/guides/rel_notes/deprecation.rst for the full list.
>>
>> Libraries:
>> - Library-specific APIs follow the same pattern: ethdev, cryptodev,
>>   compressdev, rawdev, mldev, bbdev and eventdev gain NUMA-named
>>   device APIs (e.g. rte_event_dev_numa_id()) with the socket
>>   variants kept as deprecated aliases.
>>
>> Drivers, applications, examples and documentation:
>> - One commit per unit; in-tree users are updated in the same commit
>>   as the unit they belong to, moving from libs to drivers and then
>>   to app/examples.
>> - The programming guides and API docs are updated to the new names.
>>
>> Compatibility notes:
>> - The deprecated aliases preserve source compatibility for external
>>   applications for one release; they will be removed in a future
>>   release, as recorded in deprecation.rst.
>> - No ABI break: the deprecated union alias keeps the layout
>>   identical.
>> - Device arguments and command-line options that literally use the
>>   "socket" name (e.g. --socket-mem, --socket-limit, the
>>   socket_id= parameter of the bbdev/compressdev vdevs) are
>>   intentionally NOT renamed to avoid breaking user scripts; their
>>   documentation still describes the existing parameter names.
>>   Feedback on whether/how to migrate these user-facing names is
>>   welcome.
>>
>> This series is based on v26.11-rc2 and developped by AI.
>>

...

>>  lib/vhost/rte_vhost_crypto.h                  |   4 +-
>>  lib/vhost/vhost.c                             |   4 +-
>>  lib/vhost/vhost_crypto.c                      |  16 +-
>>  lib/vhost/vhost_user.c                        |  22 +-
>>  905 files changed, 6113 insertions(+), 5439 deletions(-)
>>
> 
> Maybe a single coccinelle script would help here? Rather than trying to look
> at so many patches.

A coccinelle script is a helpful idea. I will try to prepare one.




