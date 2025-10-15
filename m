Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A78BCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:25:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ED3040ED9;
	Wed, 15 Oct 2025 14:25:35 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 6F72C40655
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:25:33 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ctJyI5VnJGbBJdnlp/IUZ0WKjJsckLm+ff7NhFjjaJ0=;
 b=L+B7qPokRRSodkBz9SrCUfCC/gzqQWUa76P7cwEUggMs5zWinfY9GPhS7uxfMhhoGxkw/qQ2w
 weerbWNanFllN9DGZ27c+0ZPUsWF/WfwSGvmge+XgT0de+hz/+aNZxNNBhEFZ1fjA1feUkukWWE
 VoYREq/hgq3bqGEfouNngOE=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cmqyn1Td3zcZyT;
 Wed, 15 Oct 2025 20:24:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id BFEB0180064;
 Wed, 15 Oct 2025 20:25:31 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:25:31 +0800
Message-ID: <5d5f10f8-750d-354f-1c1b-c475c7a69644@huawei.com>
Date: Wed, 15 Oct 2025 20:25:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 10/21] eal: define the EAL parameters in argparse
 format
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-11-bruce.richardson@intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-11-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.82.20.40]
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

Acked-by: Chengwen Feng<fengchengwen@huawei.com>

On 2025/10/9 21:00, Bruce Richardson wrote:
> Create eal_option_list.h, containing all the possible EAL parameters,
> and basic info about them, such as type, whether they take a parameter
> or not. Each entry is defined using a macro, which will be then
> interpreted when the file is included.
>
> First time this header in included in the eal_common_options.c file, the
> macros are defined in such a way as to define field elements for an
> "eal_init_args" structure, where each value is either a string type, if
> it takes a parameter, or boolean type if it doesn't. For those elements
> that take multiple values, i.e. are passed multiple times, we put them
> in a TAILQ.
>
> The second time of inclusion, the macros are defined so as to define the
> arguments in an rte_argparse structure for EAL. For the basic string and
> boolean types, we just store the values in the appropriate field in the
> previous defined "eal_init_args" structure. For the list elements, we
> use the argparse callback to process those elements, adding them to the
> TAILQ as they are encountered.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
