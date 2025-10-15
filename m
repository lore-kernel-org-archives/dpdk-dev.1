Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71580CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD2A40DCE;
	Wed, 15 Oct 2025 14:22:27 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1FB40655
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:22:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=evGFk5DK+njQLJBuOnQqHcgbi9dzcqybZ2yqWtejHaM=;
 b=mXQrZhGO5S73bgBA8/IXpGRKSWYHYW+HYD8rHV26ELitXlAPki1v3tbZ6e9ivj4MRWKqPsxSj
 S9if1fnFVLNTGq8Whu3sjv6HEGoXr4hkvgq22a/MFt58/zSO/aj3xCND0ES5bavoT0PrC+nk3IC
 BHmRZigMgN2dARzz/O6CN58=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cmqvw1HNqzLlSk;
 Wed, 15 Oct 2025 20:22:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 88E0F18001B;
 Wed, 15 Oct 2025 20:22:24 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:22:24 +0800
Message-ID: <f0bacf4b-6901-0c33-3558-d794b6603ab5@huawei.com>
Date: Wed, 15 Oct 2025 20:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 09/21] eal: add long options for each short option
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-10-bruce.richardson@intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-10-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.82.20.40]
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

Acked-by: Chengwen Feng<fengchengwen@huawei.com>

On 2025/10/9 21:00, Bruce Richardson wrote:
> To simplify future rework of the EAL arg handling, add a long-option
> equivalent for each short option that doesn't already have one.
>
> When updating the docs with the new long options, standardize the format
> of options which have both short and long variants, and drop the
> deprecated service-coremask option from the docs, rather than adding its
> new long option.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
