Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363DEDB7D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 01:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F117740261;
	Wed,  8 Apr 2026 03:44:32 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 6A1184013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 03:44:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NNZrRBSfE3J3Qyz0PyI3BrI2kUUIGMx4POqhxMzbqWA=;
 b=l5stW2jud3Du/l0Gaj7eNdHM0FayBQJUc4NAa60qSRrO5vSMcRJBar/EBgktUjYtJPdr2Ytuo
 Q3MuFl90CkBBYdVVwgOF8OyWX6hlFYNtk7XVaZPnaDs8jYdscyiS1DupeG1EzcA9D0HcyWOcqbt
 ihwY1oQohXp3N3Ko7Ag2w28=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fr5LH3w5HzRhST;
 Wed,  8 Apr 2026 09:38:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 67EEB4048F;
 Wed,  8 Apr 2026 09:44:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 09:44:28 +0800
Message-ID: <b84768a0-370f-45c9-83b2-08e802e71d6e@huawei.com>
Date: Wed, 8 Apr 2026 09:44:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] eal: configure initial device probing
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry
 <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy
 <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-8-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260407115211.1903623-8-david.marchand@redhat.com>
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

On 4/7/2026 7:52 PM, David Marchand wrote:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
> 
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
> 
> Add an EAL option so that we can change the default behavior from
> block-listing to allow-listing which can be summed up as disabling
> automatic probing.
> In case some applications want to require automatic probing, add the
> opposite option.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Kevin Traynor <ktraynor@redhat.com>

