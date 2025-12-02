Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F79D116F3
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 01:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B81F4021F;
	Tue,  2 Dec 2025 02:08:01 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id B4F9F4013F
 for <dev@dpdk.org>; Tue,  2 Dec 2025 02:07:59 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=y3sctlh/1zakw6Mre6d9iMBtO9u4nX2U2ZR8g8M39jc=;
 b=qn6gfmZy3CSFGlJ0CaY+K8t4sW18bYdUTW7o3KJnBXj+AQphxC2kON3mgcyie/BsKxmK1v5+S
 HQAABaSx6YcGG7VIYDxG2MFYxgHoOrf1bWijkyKSSpqaoUDCyL0NBZ9zRztVMDLOI0Z2Eo+ztC8
 K+SVT0dNuKLlMwSNhQzXv8c=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dL2d75zDLzcb07
 for <dev@dpdk.org>; Tue,  2 Dec 2025 09:05:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 28F21180B50
 for <dev@dpdk.org>; Tue,  2 Dec 2025 09:07:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 09:07:56 +0800
Message-ID: <4fdea0d3-01ae-42bd-9917-375883155ec1@huawei.com>
Date: Tue, 2 Dec 2025 09:07:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/test: remove use of coremasks
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251201181024.1583767-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251201181024.1583767-1-bruce.richardson@intel.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 12/2/2025 2:10 AM, Bruce Richardson wrote:
> A number of test cases spawned off secondary processes and used the
> "-c", or coremask, EAL option to do so. This option is deprecated, so
> replace it with "-l" in tests.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

