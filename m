Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F28C55172
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3599D40144;
	Tue,  4 Aug 2026 10:41:51 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 13654400D7
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:41:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=PY8jStg21Y/RNHf2inykwgn5Wk3kKqMGDQ/F9NMhbUE=;
 b=hrG6vce5DMEPjrxIEdiV8H6K9cmRQQF6lo9RmdWoqCwAN6bbyhf8Bqdd7QT6cG/K2+StgiPMe
 lB/Ywkpdf1M7j3BpPoWjmtZKiKycta5oegbAZQqxbcKFBwBUMb1pp2OysQkLJWPVXsn3Je8G5Dz
 agQgjkTjMLi8NKTFZPayTWc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hDmxR1yqWzRhQt;
 Tue,  4 Aug 2026 16:32:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 9FA5940561;
 Tue,  4 Aug 2026 16:41:40 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 16:41:40 +0800
Message-ID: <047b7271-725d-46b0-a6b7-6e59bbf39863@huawei.com>
Date: Tue, 4 Aug 2026 16:41:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] devtools: support local opencode agent for patch review
To: <datshan@qq.com>, <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <aconole@redhat.com>, <dev@dpdk.org>
References: <20260703091902.525837-1-datshan@qq.com>
 <tencent_CFE5ECAF36405DFD2FB29DB7319B04E72C08@qq.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <tencent_CFE5ECAF36405DFD2FB29DB7319B04E72C08@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Ping for review

Thanks

On 7/25/2026 4:43 PM, datshan@qq.com wrote:
> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> Currently review-patch.py only supports cloud AI providers
> (Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.
> 
> Add a --via option that invokes the locally installed opencode CLI as
> the review runner instead of making HTTP calls. opencode reads
> AGENTS.md from the DPDK project directory automatically, needing no
> configuration beyond opencode on PATH.
> 
> The --via and -p/--provider options are independent -- via routes to
> the local agent mode while -p continues to use the cloud API path.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
