Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD0BCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2134840693;
	Wed, 15 Oct 2025 09:28:17 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 827A640687;
 Wed, 15 Oct 2025 09:28:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0DjxYFkdMQqwvmlKj5Tu2S8DdSsQ2tWcDXx+3dYyPBA=;
 b=2vjVRjv+t/M8DgLScbbHqfzisqtwps5Tz0R28b/JPRp3S47TmM4Piga1nug4i2oFr1vt/Q3t4
 L9Zsh5Y8Xm6VFgNdIBjOa3SE7DSw9YCnftyOJLmu0A98kycE7XAvUjwKg2eW8PO0tLi9N/1gYXi
 wLsxQPLCJ0qW5+IdsqvO/9Y=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cmjMq5T4BzpTKx;
 Wed, 15 Oct 2025 15:27:19 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 331941400E3;
 Wed, 15 Oct 2025 15:28:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:28:13 +0800
Message-ID: <7cb7e6cb-1183-41dc-a1a0-67c1d025124e@huawei.com>
Date: Wed, 15 Oct 2025 15:28:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/21] test/func_reentrancy: fix args to EAL init call
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stable@dpdk.org>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-3-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-3-bruce.richardson@intel.com>
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

On 10/9/2025 9:00 PM, Bruce Richardson wrote:
> The unit test for EAL init was passing in a NULL argv[0] value which is
> invalid. Update to have a valid string for argv[0].
> 
> Fixes: 104a92bd026f ("app: add reentrancy tests")
> Fixes: 978ead0144c1 ("test/func_reentrancy: fix EAL init call")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

