Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E07CA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:29:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8A1240274;
	Sat, 10 Oct 2026 11:29:50 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 1C3C34026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:29:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=l0f+qP3zbwpax8raUgP2m727a5XIOWPMUdw85QXh+is=;
 b=XlijDXX5AJ87HtscPhVO/DBFKZykVdujT1zS8ie1ge9y3gDDtGBgZyO77fSZEj8Jnh0wuFWGR
 CJTy/WtjQ2WWk15MK+kKgfNFy8poxO9PbvyOhflgQt2803V4m36XjcBAAPhxbuuaCWHUgDgrFum
 A5Yda6EgmOAz4AYu4LSd6Q4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j1ynC3MbSz12LD9;
 Sat, 10 Oct 2026 17:17:51 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C58812011D;
 Sat, 10 Oct 2026 17:29:47 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 17:29:47 +0800
Message-ID: <419a7f8d-d254-4a6f-9c2c-0d935a956553@huawei.com>
Date: Sat, 10 Oct 2026 17:29:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] bus/platform: match device by devicetree
 compatible string
To: Gagandeep Singh <g.singh@nxp.com>, <dev@dpdk.org>
CC: <hemant.agrawal@nxp.com>
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <20260812092929.563973-2-g.singh@nxp.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260812092929.563973-2-g.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/12/2026 5:29 PM, Gagandeep Singh wrote:
> The platform bus currently matches a DPDK driver to a device only by
> comparing the kernel driver name bound to the device against the DPDK
> driver name. Devices bound to the generic vfio-platform kernel driver
> all report the same driver name, which carries no device identity, so a
> specific DPDK driver cannot claim its device this way.
> 
> Add of_device_is_compatible(), which reads the device-tree "compatible"
> strings exposed under the device's of_node in sysfs and compares them
> against a requested string. platform_bus_match() now falls back to
> matching the DPDK driver name or its alias against these compatible
> strings, letting a driver bind to a device identified by its
> device-tree "compatible" value.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
