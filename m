Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197CCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2470402C6;
	Wed, 15 Oct 2025 14:42:55 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id D92B740273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:42:53 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=MpF0WWKmqUA81F2IPl12Ky2D5BZi/6hvuHEMfaPQ2Nk=;
 b=JKopdN0SKVzQVNHM/Nnyiie1Cv6OJxOMg1GXIt77uOCUOtxZm054mqtF3PVyPX3xmKY+wlW9d
 AWVM4Oh9k2ccGtKcD8acxmg2UEqfuTXW9L71on2jvKTsNcbjo2FdFMeICRBaTVCbGjRmygWPivQ
 NgB1Q22BXDn012nqSO7J8rE=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cmrMV3xBSz1prLM;
 Wed, 15 Oct 2025 20:42:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 42F82180064;
 Wed, 15 Oct 2025 20:42:51 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:42:50 +0800
Message-ID: <77f4db7b-143e-5f01-90e3-83e8f7e6b54c@huawei.com>
Date: Wed, 15 Oct 2025 20:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 11/21] eal: gather EAL args before processing
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-12-bruce.richardson@intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-12-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.82.20.40]
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

Acked-by: Chengwen Feng<fengchengwen@huawei.com>

On 2025/10/9 21:00, Bruce Richardson wrote:
> DPDK traditionally has iterated through all args and processed them as
> they appear in the commandline. The arg processing logic can be
> simplified if instead we initially gather all arguments into a structure
> which is then processed with the arguments dealt with in a fixed/known
> order.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
