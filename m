Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33FCD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 04:16:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 292134027C;
	Fri, 29 May 2026 06:16:35 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id EF04D40264
 for <dev@dpdk.org>; Fri, 29 May 2026 06:16:33 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gHLfPe7R+ImsL5F8AOBRRuDrnEvlTxeu5kTpqm3/qN8=;
 b=3QUPxmGAsICDqkmtgVXYqYQR/cRH6saZkWuk9X314YGmXp9K7L/y7n9syWaQRv2CPP+WvEkgD
 jocg3BMqOYU2n5SMLNnd8SpOqOV1hw79G+0LDThTlHKrCPLKYguMiDxIklCIt8TkR7AUgyIgfwa
 evsIHU77iulGnCFbXiHmob8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gRVGP1N7WzRhRB;
 Fri, 29 May 2026 12:08:45 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 91FD0201E9;
 Fri, 29 May 2026 12:16:31 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 12:16:30 +0800
Message-ID: <184b9edc-6231-4ae2-8abe-4f3ebe1847f8@huawei.com>
Date: Fri, 29 May 2026 12:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/25] drivers/bus: remove device and driver checks in
 unplug
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <20260527075654.3780732-7-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260527075654.3780732-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

On 5/27/2026 3:56 PM, David Marchand wrote:
> rte_dev_remove() checks if a device is probed before calling the bus
> unplug operation. Individual bus detach/remove functions checking that
> dev->driver is non-NULL are therefore redundant.
> 
> However, when the unplug operation is called at bus cleanup, care must
> be taken that devices are in probed state, so some check on
> rte_dev_is_probed() must be added.
> 
> The device parameter passed to bus unplug operations cannot be NULL as
> the caller already dereferenced the bus structure to invoke these
> operations.
> The driver reference in the bus-specific device cannot be NULL since
> calling the .unplug is done after dereferencing this pointer.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

