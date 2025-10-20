Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83ADCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 06:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE2F402CC;
	Mon, 20 Oct 2025 08:52:37 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id A6D12400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 08:52:36 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=M/1nAHpODpJE0qF7rinESimKjQRCb7IYRc6zp+MyLko=;
 b=vEh8v0gQkbxigtlTOwrhtUVCRaAhME5bwD42a1jPeVu+lzw+QVpj0vKFO6U6vD+dnr9WlZGNR
 MS4qond0sghUlE5zC5SQRdhHuhEvK7HwBOLorEHKWFphwYp4fo2SHWkn9JF36F57g1kgLPS5q0R
 D8uEYGYYNBHmsAp1siUa+pQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cqmLc5ZGRz12LJn
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:51:52 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2785B180B73
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:52:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 14:52:34 +0800
Message-ID: <391b7ded-cf8e-4e27-a0d0-29abc7306065@huawei.com>
Date: Mon, 20 Oct 2025 14:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] format telemetry scripts using black
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251017135622.1152341-1-bruce.richardson@intel.com>
 <20251017141927.1156370-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251017141927.1156370-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/17/2025 10:19 PM, Bruce Richardson wrote:
> Run "black" tool on the dpdk-telemetry scripts to enforce coding style
> for python scripts.
> 
> V2:
> * use correct baseline of "main" for patches
> 
> Bruce Richardson (2):
>   usertools/dpdk-telemetry.py: correct script formatting
>   usertools/dpdk-telemetry-client: correct script formatting
> 
>  usertools/dpdk-telemetry-client.py | 49 +++++++++--------
>  usertools/dpdk-telemetry.py        | 86 ++++++++++++++++--------------
>  2 files changed, 75 insertions(+), 60 deletions(-)
> 
> --
> 2.48.1
> 

