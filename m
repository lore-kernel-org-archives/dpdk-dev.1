Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7B606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3I4/MlUp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20EB340281;
	Wed,  4 Nov 2026 03:05:16 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTPS id EFE5F4026E;
 Wed,  4 Nov 2026 03:05:13 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NUCZZf7Spx4msoitZJ58RMAm3pODzc65bboM6vy9j8c=;
 b=3I4/MlUpGkWNYCR2HfLAaBwzbkynefun3t5+itCPHgWvWdOkIIJFQZ1DngrNW4NPYfe78tTYv
 Lk39NahPjlmOCUXBSVuxB7Php3+cRrfKvi7qrgOeFLsl7/AHQNSK+CaCVjgfkD0PLHFGNM+x5/a
 QuKz16I51Ve2OzzmrLcrMQs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jK80J2FxkzRhV0;
 Wed,  4 Nov 2026 10:05:04 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F4B14056E;
 Wed,  4 Nov 2026 10:05:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 10:05:09 +0800
Message-ID: <fe4620be-0f0b-4061-b25f-9e1ac26f7390@huawei.com>
Date: Wed, 4 Nov 2026 10:05:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
To: Aaron Conole <aconole@redhat.com>, Chengwen Feng <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>,
 <ci@dpdk.org>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <f7t7bitkhzf.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <f7t7bitkhzf.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 11/4/2026 12:16 AM, Aaron Conole wrote:
> Chengwen Feng <chengwen.feng@linux.dev> writes:
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
> 
> Do not do this again.
> 
> I have set the robot from considering patches from you for the next 227
> hours.  One for each hour that a patch-by-patch test would take.  Do not
> repost this series again and expect the github robot to run for it.
> Please work with existing maintainers to come up with a plan for each
> area rename.
> 
> CI resources are shared, and in the case of the github robot, they are
> shared among OVS, OVN, and DPDK.  Additionally, a 227 patch series is
> completely unreviewable, and completely inconsiderate of reviewers time.
> Anything above 15 patches is, truly - who can keep that much details in
> mind.

Thanks for your feedback. This 227-patch set exposes the full scope of
the NUMA terminology cleanup, as a starting point for discussion and
planning. The scope is indeed large, and this rework direction was
previously discussed with Thomas and Konstantin.

Could you please lift the robot block for this posting?
I will wait for community consensus before splitting the changes into
proper batches for subsequent review.

I apologize for the heavy load imposed on shared CI resources.

Regards,
Chengwen

> 
> 

