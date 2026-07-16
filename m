Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA8C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 00:12:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF3240289;
	Thu, 16 Jul 2026 02:12:33 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 7B014400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 02:12:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=riHwy5BTBFyBNGCJjoiidgZybKmXlLmBNE/hZZ8GSCE=;
 b=QRKseCEzF+/RPEjZvECW3S9EKWpaFeeRsg8JsevHXawP3M8rFfFewapaxGkAh2Tnz8T4nOUh3
 6/BIPPGAMOdi6RfS6CkJjzqOJj4PrmRk5eYmiQaddci7tTlJxJ1/4fyY00g8mKVT9nlEM9F/5TY
 Sc0ia2gdx8IgErejmvzhU/A=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h0tXW4Rpyz12LCc;
 Thu, 16 Jul 2026 08:02:51 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 0EAAB40561;
 Thu, 16 Jul 2026 08:12:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Jul 2026 08:12:28 +0800
Message-ID: <b79c0cce-f9b3-4e90-848b-0ccd013c5cb4@huawei.com>
Date: Thu, 16 Jul 2026 08:12:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmadev: clarify last_idx documentation for completion
 APIs
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <kevin.laatz@intel.com>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <david.marchand@redhat.com>, <thomas@monjalon.net>
References: <20260715104934.3668478-1-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260715104934.3668478-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/15/2026 6:49 PM, Raghavendra Ningoji wrote:
> The last_idx output parameter was documented identically for
> rte_dma_completed() and rte_dma_completed_status(), even though the two
> APIs have different semantics:
> 
> - rte_dma_completed() only reports operations that completed
>   successfully and stops at the first error, so its last_idx is the
>   ring_idx of the last successfully completed operation.
> - rte_dma_completed_status() reports all completed operations regardless
>   of status, so its last_idx is the last completed operation's ring_idx
>   irrespective of success or failure.
> 
> In both cases only up to nb_cpls operations are reported per call, so
> last_idx is the ring_idx of the last reported operation, which may not
> be the last operation the device has actually completed.
> 
> Refresh the full documentation of both functions to remove the
> ambiguity and make the behaviour explicit.
> 
> Fixes: 91e581e5c924 ("dmadev: add data plane API")
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
