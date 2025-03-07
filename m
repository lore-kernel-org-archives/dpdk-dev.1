Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC62C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 09:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72F7C4029E;
	Fri,  7 Mar 2025 10:33:51 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 334B840275;
 Fri,  7 Mar 2025 10:33:49 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z8Lbp1Sr4zvWps;
 Fri,  7 Mar 2025 17:29:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8E23C18006C;
 Fri,  7 Mar 2025 17:33:46 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 17:33:46 +0800
Message-ID: <e0910bbf-63f5-4753-aae8-cef904b81bca@huawei.com>
Date: Fri, 7 Mar 2025 17:33:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: fix get_reg_info
To: Stephen Hemminger <stephen@networkplumber.org>, Thierry Herbelot
 <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, <stable@dpdk.org>
References: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
 <20250219104555.0bc2e0ff@hermes.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250219104555.0bc2e0ff@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 2025/2/20 2:45, Stephen Hemminger wrote:
> On Tue, 18 Feb 2025 12:58:28 +0100
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> 
>> 'width' and 'offset' are input parameters when dumping the register
>> info of an Ethernet device. They should be copied in the new request
>> before calling the device callback function.
>>
>> Fixes: 083db2ed9e9 ('ethdev: add report of register names and filter')
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> 
> Why does the ethdev code create an on stack temporary variable.
> Looks like it only wants to make sure that names element is NULL.

It mainly for ABI compatibility.

The original solution is to add an ext API (rte_eth_dev_get_reg_info_ext) and deprecate the original API (rte_eth_dev_get_reg_info).

> 
> Really should be one function and when extended fields were added
> should have used API versioning.
> Probably too late now, although rte_eth_dev_get_reg_info_ext()
> is an experimental API.



