Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB973CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A47CF40615;
	Mon, 19 Oct 2026 11:28:32 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id B668C40269;
 Mon, 19 Oct 2026 11:28:30 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/i8uh/ppoEK5ClHdYtXXi0BJYctA+aWGkd0Lj2Rr8vo=;
 b=r2L7DdY17nLJ3T/1w6+rfz2Kr1WwmXxruRcixXmqMDmLPNig0gQi65F/48DMHOFUjoBch7/F1
 /33RccUW9bRZlhd9h1HiIqz+5omS2I72/Q+vfEtZc3M7t9jKgWE5aEJI2vUmQRn9fGRrHcuIcnU
 A2Lz6UyzG4r/DWaVTgMy8Ew=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j7VbD0D6pzRhR6;
 Mon, 19 Oct 2026 17:28:24 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C09D40561;
 Mon, 19 Oct 2026 17:28:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 17:28:26 +0800
Message-ID: <6c6ae3d3-bcca-4bb3-9872-5113fc616a1f@huawei.com>
Date: Mon, 19 Oct 2026 17:28:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test: defer timer initialization
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>, <stable@dpdk.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Anoob Joseph
 <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>, Erik Gabriel
 Carrillo <erik.g.carrillo@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
References: <20261017144747.2155513-1-david.marchand@redhat.com>
 <20261019081602.2426732-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261019081602.2426732-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/19/2026 4:16 PM, David Marchand wrote:
> Initialize timers only in unit tests that do require them.
> 
> This removes an unconditional memzone allocation (3MB on ARM) and
> avoids failures of the eal_flags_file_prefix_autotest unit test
> that runs in legacy mem mode and has a tight 18MB memory budget.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>

