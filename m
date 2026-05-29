Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC10CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 03:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2614027C;
	Fri, 29 May 2026 05:50:16 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 5221D40264
 for <dev@dpdk.org>; Fri, 29 May 2026 05:50:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=QGoYb41/9xUgfymIOYCpdVh9rswByoPhYAtRnB4Ay6M=;
 b=MXHmfP4bGApYY+VIZngdbzJ6amatGu82dAnckvi/Smwap6UVk4V07ws+1fxU19Un8/jMD5Zjb
 LyPxVhJKX+ucrBcxS6Rgv59cXPJwRQ674lJ01cOg+/z+roggsQ1ugGE2qnX/ZwKURfhDQehbkVd
 JZsC79tMZnbi18KUBB8X5Sc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gRThL32hrzpTKp;
 Fri, 29 May 2026 11:42:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C12F40538;
 Fri, 29 May 2026 11:50:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 11:50:11 +0800
Message-ID: <098572ee-a6e6-4774-9f02-d9e9e8d191f2@huawei.com>
Date: Fri, 29 May 2026 11:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/25] bus/uacce: set API version during scan
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <20260527075654.3780732-3-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260527075654.3780732-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 5/27/2026 3:56 PM, David Marchand wrote:
> Move API version parsing from the match callback to the time where the
> device object is allocated and filled, since this property is constant.
> 
> This avoids any side effect on the device object when calling the match
> callback.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

