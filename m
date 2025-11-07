Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB4CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 02:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F052F402E5;
	Fri,  7 Nov 2025 03:43:11 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 5099C4013F;
 Fri,  7 Nov 2025 03:43:10 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=MLHb8nMPcwbWPEackdBWJjpTPlPxn0ooaDhLC7TtqHU=;
 b=6IZt3BQZwaV5wcJmsP81oXlTEVSVj7CipWRdjnz68iJB5raFPNvu3WYUA6lU15accudKPC/Oe
 /1H1vuWkjztmkom27xuYPMwx67NaKxlXO9cru07da4Mt+OHRFuofuFBz0GszqkuJ6bM5XL2nD3v
 5/lA7uckmm8XdU1UeUj9Pvc=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d2jxT2h4VzpStj;
 Fri,  7 Nov 2025 10:41:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D27D140109;
 Fri,  7 Nov 2025 10:43:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 10:43:06 +0800
Message-ID: <fcbe28fc-017b-4722-82d0-366df663312b@huawei.com>
Date: Fri, 7 Nov 2025 10:43:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/19] telemetry: make socket handler typedef private
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-11-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251106140948.2894678-11-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 11/6/2025 10:09 PM, Bruce Richardson wrote:
> The socket handler typedef, just called "handler" does not belong in the
> public namespace, especially since it is unprefixed. Rename to
> "telemetry_sock_handler" and move to internal header.
> 
> Doing so also clears shadowing warnings in dmadev library, when it is
> built with -Wshadow.
> 
> Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

