Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45611CCFA18
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 01:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4956140281;
	Wed, 12 Nov 2025 02:34:37 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id BEFE74026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 02:34:35 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=IJabv1Kk95ZBc5bdj8M0An/BpchGgnT1D/p7g1abytk=;
 b=aBazXa/l/QClQ5nyXa1YFRuazul/OX3T66VexVIKcOldIDIzUQWdp00CCYmoeJQ/SycS1otdN
 1p/jU2fQRoLA+RoqrYmrACn3+vcW0gDejX39ZuhwiKu9ZfRglMBm6whLSDHCvIlSpB4NsCweuAx
 CvcceWJ29VRPkSXzuA0cC4A=
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d5m9z16lqz1K9Vt;
 Wed, 12 Nov 2025 09:32:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C8283140135;
 Wed, 12 Nov 2025 09:34:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:34:32 +0800
Message-ID: <eddab543-8dbd-4391-8e1e-2172c07f6697@huawei.com>
Date: Wed, 12 Nov 2025 09:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] two enhance for testpmd DCB test
From: fengchengwen <fengchengwen@huawei.com>
To: <stephen@networkplumber.org>, Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251111091303.39491-1-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20251111091303.39491-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Hi Stephen,

Can this patchset be merged into 25.11?

This patchset introduce two commands, behave the same as before if user
don't execute these two commands.

Thanks

On 11/11/2025 5:13 PM, Chengwen Feng wrote:
> This patchset contains two enhancement for testpmd DCB test.
> 
> Chengwen Feng (2):
>   app/testpmd: support specify TCs when DCB forward
>   app/testpmd: support multi-cores process one TC
> 
> ---
> v7: rebase to main branch.
> v6: try to fix CI windows 2022 compile error:
>     ../app/test-pmd/config.c(5263): warning C4018: '<': signed/unsigned mismatch
> v5: optimize naming and add line breaks for first commit.
>     add second commit "support multi-cores process one TC".
> v4: use direct assign of dcb-info according comment from Stephen.
>     fix CI llvm compiler error.
> v3: use new way to impl and fix comment from Stephen.
> v2: introduce pause/resume lcore's forwarding.
> 
>  app/test-pmd/cmdline.c                      | 105 +++++++++++++++
>  app/test-pmd/config.c                       | 135 +++++++++++++++++---
>  app/test-pmd/testpmd.c                      |  15 +++
>  app/test-pmd/testpmd.h                      |   4 +
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  16 +++
>  5 files changed, 256 insertions(+), 19 deletions(-)
> 

