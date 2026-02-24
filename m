Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37888EFB810
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D1EC4027F;
	Tue, 24 Feb 2026 08:41:46 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id AAEBF400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:41:44 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=w2lQ9URxmZAbEjgvQQ5xfAYQ693l22xz59V6lPYQAUA=;
 b=PqGP+CqEXXjaofAsYghED5/oqKKBnR81IaX48hHMVBFnTsW2UqigOviKb7h6O2ixmsE58TKjD
 X6k/dC2sRRsDHfbm54RsCIztnnRc993JCc4BvKsM9fpd2YxBSc+egr526z1Qa27V4a2EfrQfTS1
 rTpFvuiigm9uYZQ31kqBkEE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fKqKv69JZz1T4JH;
 Tue, 24 Feb 2026 15:36:51 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 3062E40561;
 Tue, 24 Feb 2026 15:41:42 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 15:41:41 +0800
Message-ID: <c25e6b16-4e8f-c47a-b63d-34dcdce19a40@huawei.com>
Date: Tue, 24 Feb 2026 15:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] app/testpmd: check whether start for DCB fwd-tc
 command
Content-Language: en-CA
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
References: <20260224072647.607-1-fengchengwen@huawei.com>
 <20260224072647.607-2-fengchengwen@huawei.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260224072647.607-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh200012.china.huawei.com (7.202.181.121) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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



On 2026/2/24 15:26, Chengwen Feng wrote:
> The 'set dcb fwd_tc xxx' and 'set dcb fwd_tc_cores xxx' commands should
> check whether started forwarding, this patch add it.
> 
> Fixes: c58bdc7a589c ("app/testpmd: set DCB forwarding TCs")
> Fixes: 945e9be0a803 ("app/testpmd: support multi-cores process one TC")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

Acked-by: Xingui Yang <yangxingui@huawei.com>
