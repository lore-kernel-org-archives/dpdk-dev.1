Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FEC88E41
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 00:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 829FF402C5;
	Wed, 28 Jan 2026 01:41:58 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 2621A402C4;
 Wed, 28 Jan 2026 01:41:55 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ezmdgf63U6wZiEA5wjfi2+J6IbGoiPRAJqU7D694U1U=;
 b=TP8nTkPUokkDqNMvyG1W3RNjC/j5bNpl5z0BCCr/TkOEUkry29LqgxGV3t+SK0RonFx/gGZAY
 kI08CGKfVt0sVtADPecPDfO1HyZYK4uZWNnWqWwXTTQW+VLf5itsyJpjPGbl5I3OOlXHmENVo7k
 exo47D75l1q1/RojE2Wioow=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f13KZ3ygBzLlSt;
 Wed, 28 Jan 2026 08:38:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id A12CE40363;
 Wed, 28 Jan 2026 08:41:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 08:41:53 +0800
Message-ID: <bc1d9096-6dd4-4862-9be7-19531c9364a7@huawei.com>
Date: Wed, 28 Jan 2026 08:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] eal: variable first arguments of RTE_SHIFT_VALxx
To: Marat Khalili <marat.khalili@huawei.com>, <dev@dpdk.org>, Jack
 Bond-Preston <jack.bond-preston@foss.arm.com>
CC: <jerinjacobk@gmail.com>, <konstantin.ananyev@huawei.com>,
 <mb@smartsharesystems.com>, <stephen@networkplumber.org>, <stable@dpdk.org>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
 <20260127114944.35993-2-marat.khalili@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260127114944.35993-2-marat.khalili@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 1/27/2026 7:49 PM, Marat Khalili wrote:
> Macros RTE_SHIFT_VAL32 and RTE_SHIFT_VAL64 were implemented by applying
> UINT32_C or UINT64_C correspondingly to its first argument. As a
> consequence first argument had to be a constant. Replace UINT32_C and
> UINT64_C with casts to uint32_t and uint64_t to allow these arguments be
> variable. For constants the result should be the same.
> 
> (Yes, technically UINT64_C promotes to uint_least64_t, not uint64_t, but
> I think most users of RTE_SHIFT_VAL64 expect the result to be uint64_t.)
> 
> Fixes: 1d8f2285ed3f ("eal: introduce more macros for bit definition")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

...
