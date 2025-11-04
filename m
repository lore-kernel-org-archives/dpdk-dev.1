Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D9CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 07:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFCE34028C;
	Tue,  4 Nov 2025 08:18:42 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3EB4240285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 08:18:41 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zBZDFlGtC5KjhQGWjhL5jtandClzNit1Mi6ZPgT2lmI=;
 b=Lpu9vIbNuxdnI6CyKnBt7HWPwmaGzChwnv4q+gFh8aoIAIWOjuZwbRYAu17fdEXZEi8bb4bUt
 M2pbs31qy/hcS5R4DTNP07V9mnhe8Q565kjeyPS3n2JwEdOsd2Qfz+Vql3ZC4dWIq9UVa5TYVdb
 EMM4eI97Tmst9kLmpDPjM8A=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d10Bm0qrCzKm7C;
 Tue,  4 Nov 2025 15:17:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 483BD18001B;
 Tue,  4 Nov 2025 15:18:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:18:38 +0800
Message-ID: <dc7a9577-a75e-4e4c-b0bb-5ec0e0d21d1a@huawei.com>
Date: Tue, 4 Nov 2025 15:18:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vhost_user: header defines for add/rem mem region
To: Pravin M Bathija <pravin.bathija@dell.com>, <dev@dpdk.org>
CC: <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-3-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104042142.2787631-3-pravin.bathija@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
> The changes in this file cover the enum message requests for
> supporting add/remove memory regions. The front-end vhost-user
> client sends messages like get max memory slots, add memory region
> and remove memory region which are covered in these changes which
> are on the vhost-user back-end. The changes also include data structure
> definition of memory region to be added/removed. The data structure
> VhostUserMsg has been changed to include the memory region.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>

