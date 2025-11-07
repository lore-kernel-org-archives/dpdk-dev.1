Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E24CCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 00:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 592554021F;
	Fri,  7 Nov 2025 01:38:11 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 455234013F;
 Fri,  7 Nov 2025 01:38:09 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7j8EgBa0LSTcAVPVCsJJ9dQ6ZEuyfdJyTgrgKNX0j4s=;
 b=gteS8e244kAK0dGt/Jx6atXkOn6Hb+BS7xF3qq7dZCVBFEIiG2/ft1nW0n5gCeikimU9Xj68t
 T0OzaqvgppxokaTcohXbhGmUbgaLHkXsdKRiOORav0S2Xcrt3AqzqecJEQ0O/HYpaJ/kO8NR48u
 tjK7Zcstf4EKTIsmB7MY4wo=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d2g9B3Btvz1cyPs;
 Fri,  7 Nov 2025 08:36:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 036961A0188;
 Fri,  7 Nov 2025 08:38:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 08:38:06 +0800
Message-ID: <b0e82cda-3428-4932-8b6d-a73ed9f86759@huawei.com>
Date: Fri, 7 Nov 2025 08:38:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] examples/l3fwd: add Tx burst size configuration option
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Huisong Li
 <lihuisong@huawei.com>, Jie Hai <haijie1@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Venkat Kumar Ande
 <venkatkumar.ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>, Pavan
 Nikhilesh <pbhagavatula@marvell.com>
References: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <20251106141631.179443-1-sivaprasad.tummala@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251106141631.179443-1-sivaprasad.tummala@amd.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/6/2025 10:16 PM, Sivaprasad Tummala wrote:
> Previously, the TX burst size in l3fwd was fixed at 256, which could
> lead to suboptimal performance in certain scenarios.
> 
> This patch introduces separate --rx-burst and --tx-burst options to
> explicitly configure RX and TX burst sizes. By default, the TX burst
> size now matches the RX burst size for better efficiency and pipeline
> balance.
> 
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
> Cc: haijie1@huawei.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> Tested-by: Venkat Kumar Ande <venkatkumar.ande@amd.com>
> Tested-by: Dengdui Huang <huangdengdui@huawei.com>
> Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

