Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB457CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 00:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54FBE4025D;
	Fri, 15 Aug 2025 02:19:06 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 5BAB24021F
 for <dev@dpdk.org>; Fri, 15 Aug 2025 02:19:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c32gq4XLTz13N4V;
 Fri, 15 Aug 2025 08:15:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D33721402DF;
 Fri, 15 Aug 2025 08:19:01 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 08:19:01 +0800
Message-ID: <4910dac9-07f1-482a-9df7-46d4e488dff5@huawei.com>
Date: Fri, 15 Aug 2025 08:19:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: remove KNI diagrams
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20250814154604.6878-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250814154604.6878-1-stephen@networkplumber.org>
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

On 8/14/2025 11:46 PM, Stephen Hemminger wrote:
> KNI was removed from DPDK but the diagrams in the documentation
> were left behind.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

