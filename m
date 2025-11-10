Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:14:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7B6402EB;
	Mon, 10 Nov 2025 02:14:46 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id AF714400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 02:14:44 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZGoSNOvMWme7S00om8uD8T7Y7s9V3tHC4mXlTxB9SaM=;
 b=QY4sqrY/eU2s8x1L8lUM08As1yWvsVVMm/IHZ4lDkBWZLMKyzOdexX9Hpnn7iEV5TkBS8bhXL
 QosYvgIVVutknDWqk6iRghk2Es06JAAwpO42CkS8kTiHEBFQaRUvVQ1SihOyyN/HRJIRDqwLEXw
 fsy31f5Hu4wytE6tiqL0nnQ=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d4Wqs4fQ0zcb04;
 Mon, 10 Nov 2025 09:12:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CE98F140156;
 Mon, 10 Nov 2025 09:14:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 09:14:41 +0800
Message-ID: <d91babe9-5ce1-491a-8642-c02380846f2f@huawei.com>
Date: Mon, 10 Nov 2025 09:14:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 32/33] examples: ignore variable shadowing warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>, Chas Williams
 <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Ori Kam <orika@nvidia.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, Akhil
 Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, Sunil Kumar
 Kori <skori@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt
 <david.hunt@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Volodymyr Fialko <vfialko@marvell.com>, Kirill Rybalchenko
 <kirill.rybalchenko@intel.com>, Byron Marohn <byron.marohn@intel.com>, Yipeng
 Wang <yipeng1.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-33-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-33-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 11/7/2025 11:50 PM, Bruce Richardson wrote:
> For examples which don't compile with -Wshadow, explicitly disable those
> warnings.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

