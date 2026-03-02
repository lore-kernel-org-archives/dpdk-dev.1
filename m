Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B3D58E47
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 03:28:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 831A0402EE;
	Mon,  2 Mar 2026 04:28:22 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9F84028C;
 Mon,  2 Mar 2026 04:28:20 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=IpSj507dMxgzcMBQC/4S+VavowkkjDosUvx7QYvZIeQ=;
 b=lcghwMl/UagIYvCeTYGvzYGZMWB6kiTeG3Cu8pe7xsvb6326X4O8KXnpGmLY7QC0hIF1OpHII
 KH+tJnqwqrKzcnPVQPukgL3CpD6mkbYfcYAajTmWtadOMKIwmeUiUCFsRZBifG8bqFRYHCtjGc+
 sXpH9HBew9YKJbSdHHtajMg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPPR04btBznTVK;
 Mon,  2 Mar 2026 11:23:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6527940568;
 Mon,  2 Mar 2026 11:28:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 11:28:12 +0800
Message-ID: <c2c5f638-b634-4f66-9c70-a973ac8dfa29@huawei.com>
Date: Mon, 2 Mar 2026 11:28:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 02/23] net/pcap: fix build on Windows
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
 <20260301020726.852401-3-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260301020726.852401-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 3/1/2026 10:05 AM, Stephen Hemminger wrote:
> The log messages in the pcap OS dependent code for Windows
> was never converted during the last release.
> 
> It looks like the osdep part of pcap was not being built.
> Building requires have libpcap for Windows built which is not
> part of the CI infrastructure.
> 
> Fixes: 2b843cac232e ("drivers: use per line logging in helpers")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

