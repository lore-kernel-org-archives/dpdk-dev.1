Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D620EFB810
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 298FA40609;
	Tue, 24 Feb 2026 08:42:26 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id B6FF7400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:42:24 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=c68GZMalWvvkGDNYT5UbWZBh/ey5EtMBZta/WjLlCJ8=;
 b=KAss3nDMMsRD0gdsQKGIrZ40U1GfaH4stWsT8I9SI+ujHz/yMX2mWWdVRbrnDUXrpD0KaZ54V
 8lqle7sFiq0HfUk3KenvA28V7S9ifcGKbGGj5bMl1Jy6gldxPIbGi3Y0r5Qsai7sWYOfHLftffg
 oNlNtAqfRS2y0JwHdW+bL94=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fKqLq1fpHz1K96m;
 Tue, 24 Feb 2026 15:37:39 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 19AC440562;
 Tue, 24 Feb 2026 15:42:23 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 15:42:22 +0800
Message-ID: <d89be0f0-6b0a-bda2-f283-79d1f72d14fa@huawei.com>
Date: Tue, 24 Feb 2026 15:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] app/testpmd: add show DCB fwd-tc command
Content-Language: en-CA
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
References: <20260224072647.607-1-fengchengwen@huawei.com>
 <20260224072647.607-3-fengchengwen@huawei.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260224072647.607-3-fengchengwen@huawei.com>
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
> This commit adds "show config dcbfwdtc" command which show DCB
> forwarding TC list and cores per-TC.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

Acked-by: Xingui Yang <yangxingui@huawei.com>
