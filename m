Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B732BCA5FAD
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 01:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6F08402A2;
	Wed, 30 Sep 2026 03:14:26 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 11035400EF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 03:14:25 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=HINBK6eHCAbBRugQ1BVduvpQhnCwXz9gddr+Mma9nWY=;
 b=etzlgH+KeKjQDO5AZjXKD5/NdRXlVlZe4/iS3zkjG3Oz96W9gHEwogXqCuPTiqR3Rk5+G04fU
 qg+Kt4EydG04ge2GrDH0ZBzX+7lKuMyZlQREzwVUj1NDMFV5xjZFzKvLLTEL+MWMKHXaXb7idfL
 2WJxrXt6GirPj1L6gwOndwA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hvcFv64rCz1prLV;
 Wed, 30 Sep 2026 09:02:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id F270440575;
 Wed, 30 Sep 2026 09:14:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 30 Sep 2026 09:14:22 +0800
Message-ID: <94bad4cd-30e7-4cad-87da-f9957f620088@huawei.com>
Date: Wed, 30 Sep 2026 09:14:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/61] kvargs: add numeric conversion helpers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 9/30/2026 12:36 AM, Stephen Hemminger wrote:
> Almost every driver parses numeric device arguments with its own
> code, and most get some part of it wrong: atoi() does not detect
> invalid input, errno is checked without being cleared, the end
> pointer is ignored, the value is truncated before it is range
> checked, or base 0 turns a leading zero into octal.
> 
> This series adds range checked converters and ready made
> rte_kvargs_process() handlers to librte_kvargs, then converts the drivers.
> 
> Library (patches 1 to 3)
> ------------------------
> 
>   rte_kvargs_to_uint/to_int/to_hex     convert with an explicit range
> 
>   rte_kvargs_handle_u8/u16/u32/u64     store into a typed variable
>   rte_kvargs_handle_i8/i16/i32/i64
>   rte_kvargs_handle_uint/int/long/ulong/size
> 
>   rte_kvargs_handle_bool               1/y/yes/on/true and negatives,
>                                        bare key means true
>   rte_kvargs_handle_socket_id          -1 (SOCKET_ID_ANY) through
>                                        RTE_MAX_NUMA_NODES - 1
>   rte_kvargs_handle_hex32/hex64        bare hex mask, 0x optional

The argparse also provide such convert functions
int rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val);

Can these be merged into one?

> 
> Values are decimal or 0x hexadecimal, no octal, no negative value for
> an unsigned type, no trailing garbage.
> The handlers log key, value, and expected range on failure.
> Unit tests cover all of them.
> 
> The new api's are marked experimental for 26.11.

