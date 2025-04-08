Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3DC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E451440E4C;
	Tue,  8 Apr 2025 10:28:46 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 208824027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:28:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZWzdh3ZdpzvWr9;
 Tue,  8 Apr 2025 16:24:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id F36A91400DC;
 Tue,  8 Apr 2025 16:28:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:28:42 +0800
Message-ID: <b76c98b0-5158-4d21-aadf-05a203f90129@huawei.com>
Date: Tue, 8 Apr 2025 16:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for hns3
To: "lihuisong (C)" <lihuisong@huawei.com>, Jie Hai <haijie1@huawei.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <stephen@networkplumber.org>
CC: <fengcengwen@huawei.com>, <huangdengdui@huawei.com>
References: <20250402084744.334095-1-haijie1@huawei.com>
 <c4e340cb-3626-48ad-8c16-ebc6516d45a5@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <c4e340cb-3626-48ad-8c16-ebc6516d45a5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2025/4/3 18:01, lihuisong (C) wrote:
> 
> 在 2025/4/2 16:47, Jie Hai 写道:
>> I am moving on to other things and dengdui is going to
>> take over the role of hns3 maintainer. Update the
>> MAINTAINERS accordingly.
>>
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
> Thanks for your contributions to hns3.
> 
> Acked-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4b01103f8e83..bcc9fdaf0c92 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -765,7 +765,7 @@ F: doc/guides/nics/gve.rst
>>   F: doc/guides/nics/features/gve.ini
>>     Hisilicon hns3
>> -M: Jie Hai <haijie1@huawei.com>
>> +M: Dengdui Huang <huangdengdui@huawei.com>
>>   F: drivers/net/hns3/
>>   F: doc/guides/nics/hns3.rst
>>   F: doc/guides/nics/features/hns3.ini

