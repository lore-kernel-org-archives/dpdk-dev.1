Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A351CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 07:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C40B402EB;
	Wed, 20 May 2026 09:32:02 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id EFD37402EB
 for <dev@dpdk.org>; Wed, 20 May 2026 09:32:00 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=xhgUXyVh56nz4rxCUEG4Ghkz3LsAZ2yuxWs0xDiRxDs=;
 b=E+p8yBUwmJlcy+EXnLlp/9ozmK5BQaKXZgD+Zs/qkmpmlxwekjzI57jI/3/qdzGAeGPyXIsat
 ZVYrXkNxv6I/Sz7zEJv1TrGFlthHXyelERTm8UQwS8Lbksv68YTDh6RP09pLAFc6Z4L3+ZvaRZQ
 Zb2ru9hUQ2At+yIwC1dr6ZE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gL32B2tpQz1cyPW;
 Wed, 20 May 2026 15:24:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 7CF3040539;
 Wed, 20 May 2026 15:31:58 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 15:31:58 +0800
Message-ID: <689a32bf-b6e2-4646-8073-cd1f895b692b@huawei.com>
Date: Wed, 20 May 2026 15:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] enhance telemetry list endpoint with device name
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65885@smartserver.smartshare.dk>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65885@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 5/20/2026 1:40 PM, Morten Brørup wrote:
>> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
>> Sent: Wednesday, 20 May 2026 05.57
>>
>> Currently, the /dmadev/list and /ethdev/list telemetry endpoints return
>> only integer IDs, making it hard to identify devices. This series
>> changes
>> both to output strings in "ID    NAME" format for better usability.
> 
> For machine reading of the JSON output, it would be better returning an object with an integer and a string field, {ID, "NAME"}.

The TEL_DICT could do {"ID", "NAME"}, which like:
  "/ethdev/list": {
    "0": "0000:7d:00.0",
    "1": "0000:7d:00.1"
  }

Maybe we could add one TEL_INT_DICT which is int-value pairs, we may get:
  "/ethdev/list": {
    0: "0000:7d:00.0",
    1: "0000:7d:00.1"
  }

I prefer the first one, However, the capacity is reduced from 512 (RTE_TEL_MAX_ARRAY_ENTRIES) to 256 (RTE_TEL_MAX_DICT_ENTRIES), but I think it is enough.

What's your opinion?

> 
> 

