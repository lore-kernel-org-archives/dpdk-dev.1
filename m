Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF01CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 07:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77634028C;
	Tue,  4 Nov 2025 08:15:10 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id E9E3F40285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 08:15:08 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/GtfSTIORJHgp+7PVElaEb9iXsZaillMdeP9CNZjRnw=;
 b=kKB/yzRO+uJTUrEb69pRkean81J3MQk8cBfyK1dI/fbxQa293Mkr2x+Tp0IxB8po9boEhfNfI
 R86J3ocAP+TjZ/vY5DSagqUuI/+/Z15SYZWVJYwRZ++aVxt+8ohaqHgdiI681bKzn8QXRygT6k7
 KK0iEnhnqRW4SAhkDflYMhA=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d106h1FPjzcZy3;
 Tue,  4 Nov 2025 15:13:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CF0DE1400C8;
 Tue,  4 Nov 2025 15:15:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:15:06 +0800
Message-ID: <ae3c917c-42f0-4764-836a-292cd89b7a53@huawei.com>
Date: Tue, 4 Nov 2025 15:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vhost: add user to mailmap and define to vhost hdr
To: Pravin M Bathija <pravin.bathija@dell.com>, <dev@dpdk.org>
CC: <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-2-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104042142.2787631-2-pravin.bathija@dell.com>
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

Please fix a typo below
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
> - add user to mailmap fle
> - define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> that depicts if the fature/capability to add/remove memory regions is

fature -> feature

> supported. This is a part of the overall support for add/remove
> memory region feature in this patchset.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>

