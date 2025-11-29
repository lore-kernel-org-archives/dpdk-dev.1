Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03429D116E2
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 00:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B434021F;
	Sat, 29 Nov 2025 01:35:05 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id BA6DE4013F;
 Sat, 29 Nov 2025 01:35:04 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=K9OG8TbtoAFbdeGYQpkNyplWI/WabZbUoK8CLXVz5YM=;
 b=LJAI63ETyfUnJyeaVQ74wYm7wWxBGRxwx+hsirJZ0e3NJB2JdO2TwJqFhqhqyZDSXStbLSSHK
 Btpq//7iyKapoE0BawcyrjMuKj7KvjA6C9MQ/Kj03F1GMt1+HpqyiOgIK6pL8osP2QRDl5WckOL
 dTdyCxGba7ka7nFwZBVO8Io=
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJB2b0YC0znTW1;
 Sat, 29 Nov 2025 08:32:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0AB5B1402F2;
 Sat, 29 Nov 2025 08:35:03 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 08:35:02 +0800
Message-ID: <4c5e036c-e9eb-48c2-93fa-e0db36233753@huawei.com>
Date: Sat, 29 Nov 2025 08:35:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] app/procinfo: fix const pointer in collectd format
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>, Harry van
 Haaren <harry.van.haaren@intel.com>, Roman Korynkevych
 <romanx.korynkevych@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
 <20251128135616.2662164-8-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251128135616.2662164-8-david.marchand@redhat.com>
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/28/2025 9:56 PM, David Marchand wrote:
> With latest glibc (Fedora Rawhide):
> ../app/proc-info/main.c: In function 'collectd_resolve_cnt_type':
> ../app/proc-info/main.c:689:26: warning: initialization discards
> 	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   689 |         char *type_end = strrchr(cnt_name, '_');
>       |                          ^~~~~~~
> 
> Fixes: 2deb6b5246d7 ("app/procinfo: add collectd format and host id")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

