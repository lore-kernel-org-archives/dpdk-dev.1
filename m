Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0E2CCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 030FE4065E;
	Wed, 15 Oct 2025 14:44:06 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 90C5740273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:44:04 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=TUsaAdWW2jqyyYPOhBonyQakyGKoofjnAOFTo3CUM90=;
 b=Afqzqb608n/Ko1Bezw1JPeUovGZOLy/W9opZm0reH/oqabgqx0jcQRJMmI9RRGyS70MfQ1IfF
 30TPLzu47Sk3WZyk9v0wvbHA6UhhTT86z8T5pOF14orUpdN45L53u3Y8h4QDFd9/nF82L2ms6i2
 zcnWfyp4qP8cHtGZ108k8w0=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cmrN70rZVzcb2f;
 Wed, 15 Oct 2025 20:43:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B234C180B6B;
 Wed, 15 Oct 2025 20:44:01 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:44:01 +0800
Message-ID: <1af62070-2c08-9f92-4671-1c1daa5ab868@huawei.com>
Date: Wed, 15 Oct 2025 20:44:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 04/21] argparse: allow user-override of help printing
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-5-bruce.richardson@intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.82.20.40]
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

Acked-by: Chengwen Feng<fengchengwen@huawei.com>

On 2025/10/9 21:00, Bruce Richardson wrote:
> When the arguments passed to argparse include -h/--help then usage
> information is automatically printed. Provide the capability for the
> user to supply their own help function for this.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
