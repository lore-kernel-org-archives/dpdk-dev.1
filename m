Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B10CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E35F40A6C;
	Wed, 15 Oct 2025 14:20:51 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 287BA40655
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:20:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EpIO0jXClQaiS5zFLVkjjoV7rGXTOv+VrkKfTHRD/Bk=;
 b=t6hLNelJRrujU8jKS7X9UUX4QALk4CfItlcOyWmuao0+VCDYvdsfb2BFXC1+dzSj+ipob/fhz
 FXe0jfNNGsbuiDnDxEAvJ8BZwtvkjAp2FeS++hz7gXECwJsGSrfxaVlFFosBtTc+i18vXClIB4z
 d7Fn7BFdX///jK/1/akFwYY=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmqt24lrvzKm5G;
 Wed, 15 Oct 2025 20:20:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E4F7618001B;
 Wed, 15 Oct 2025 20:20:46 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:20:46 +0800
Message-ID: <d103ba1f-b941-090f-6d2b-a742a7717b26@huawei.com>
Date: Wed, 15 Oct 2025 20:20:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 08/21] argparse: support parameters to short options
 without "="
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-9-bruce.richardson@intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-9-bruce.richardson@intel.com>
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

Please add document about this,
Acked-by: Chengwen Feng<fengchengwen@huawei.com>

On 2025/10/9 21:00, Bruce Richardson wrote:
> When passing an optional parameter to a argparse argument, the only way
> to do so has been to pass the argument using "=arg" on the end of the
> option, for example "--foo=bar". However, for short options, i.e. those
> of the form "-x", this requirement is unusual as getopt also supports
> taking additional characters after the option as the parameter, e.g.
> "-xarg".
>
> Add support for this form of parameter for short options to argparse.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
