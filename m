Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074BBCD4F25
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 00:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2750340274;
	Fri, 15 May 2026 02:20:55 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 1E25B40151
 for <dev@dpdk.org>; Fri, 15 May 2026 02:20:53 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JeWesubHicV3oO56nyXYy/xd95PisMoNcnvSgjsbmkQ=;
 b=XcyAWW10BKpTJwtPzsrHD0FJKigGSq0pJwjMv+sUXqCDpdn133tbrCWrKq53J5PJmORn9eo2v
 1udwQjlRU5eU7zi2S1p8uETGdoTji6la+TKzJm6nSUW+6XOYgodRNMg9cRjeXF7OZ2nGMu/bokC
 8JOG3f6PBZfIqx/5b59TnS4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gGnjL43J5zcZyN;
 Fri, 15 May 2026 08:13:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CB5A540561;
 Fri, 15 May 2026 08:20:50 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 08:20:50 +0800
Message-ID: <b4e44ed7-7902-4369-a4e4-509ed3addf91@huawei.com>
Date: Fri, 15 May 2026 08:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost hdr
To: <pravin.bathija@dell.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <thomas@monjalon.net>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
 <20260514224627.2014566-2-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260514224627.2014566-2-pravin.bathija@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 5/15/2026 6:46 AM, pravin.bathija@dell.com wrote:
> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> - add user to mailmap file.
> - define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>   that depicts if the feature/capability to add/remove memory regions
>   is supported. This is a part of the overall support for add/remove
>   memory region feature in this patchset.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>

Please attach reviewed/acked-by of this commit in new version



