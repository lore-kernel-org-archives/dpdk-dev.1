Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69489606A337
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=i3Bp6+P5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED0E240DF8;
	Thu,  5 Nov 2026 15:12:28 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTPS id B7D044060F
 for <dev@dpdk.org>; Thu,  5 Nov 2026 15:12:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bJgKGiaiV0v2ItqA1XqzAou5q9YD7FD6JqjTbpTRLic=;
 b=i3Bp6+P5wO/A56ZnVc7X7b9Ftd4pzAE0RIZIdenY+5Npt4QSM+ebf0f6yZI1xk4OxNvakb2zk
 2x136QvX4NBYEkzUy9jsEyTmlonFKuc+Gbmh1ijPURdfjNINMaYefOSX49wqnRRh+ZsLsj8sT2D
 ksAyhTCgq7SbtwWkV1oLmu4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jL44q2YMRz1cyQD;
 Thu,  5 Nov 2026 22:12:11 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 4054D40563;
 Thu,  5 Nov 2026 22:12:23 +0800 (CST)
Received: from [10.67.121.46] (10.67.121.46) by dggpemr100003.china.huawei.com
 (7.185.36.150) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 22:12:22 +0800
Message-ID: <9936b6cc-93f9-466d-a284-c3a1b0bd2568@h-partners.com>
Date: Thu, 5 Nov 2026 22:12:20 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
To: Slava Ovsiienko <viacheslavo@nvidia.com>, yangxingui
 <yangxingui@huawei.com>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "liuyonglong@huawei.com"
 <liuyonglong@huawei.com>, "kangfenglong@huawei.com" <kangfenglong@huawei.com>
References: <20260811085231.2260761-1-yangxingui@huawei.com>
 <4a35e332-d89e-af61-03bb-3b72f3f230c7@huawei.com>
 <c0e9bea1-5fd5-4bed-be68-1d639ccb694c@h-partners.com>
 <8d86f620-a641-48d0-839b-1b04710139ae@h-partners.com>
 <DM4PR12MB6087DF53A89ED26EAF9F5E75DF682@DM4PR12MB6087.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Shuaisong Yang <yangshuaisong@h-partners.com>
In-Reply-To: <DM4PR12MB6087DF53A89ED26EAF9F5E75DF682@DM4PR12MB6087.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
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

Hi Slava,

Thanks for the review.

The "if (is_extmem) goto out;" early exit is dropped in v3: external
memory keeps its original behavior - if the entire pool resides within
a single hugepage, all ranges are combined into one range of the
hugepage size and share_hugepage is set, so the MR sharing between
mempools keeps working as before. The new hugepage alignment with
merging of the adjacent ranges is kept for non-external memory only.

Best regards,
Shuaisong Yang

On 2026/11/4 17:38, Slava Ovsiienko wrote:
> For the external memory - we should keep existing behavior, not skip combining within a single huge page.
> I would also elaborate this approach and combine the ranges within the next huge pages (if any), but
> not combine the huge page itself (for the external memory).

