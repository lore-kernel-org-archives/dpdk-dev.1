Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91ACD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8231D40299;
	Wed, 24 Jun 2026 03:14:53 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 31DEF40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 03:14:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zjLB5HL3BxS1wsNAY1+2RVDCKP77QPZ4wdCldBvrYEI=;
 b=JJSiz2GTWE8uVt/7Bh4pHSHK+BHvpsrQQrzKx/0ljow6JHFsw1I54psBKCrITwICiCdHT/GRB
 dv3JrAgOGAfKRRXIc0DY4edpcKmP9ny/kQLX7aqNPjILv4EC/XE0M5Mt4RWxprXUfNu7s1DYTKh
 eMOFumLpZjeAS+BLDNImJH4=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4glNzm3m8HzcbT1;
 Wed, 24 Jun 2026 09:06:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zjLB5HL3BxS1wsNAY1+2RVDCKP77QPZ4wdCldBvrYEI=;
 b=JJSiz2GTWE8uVt/7Bh4pHSHK+BHvpsrQQrzKx/0ljow6JHFsw1I54psBKCrITwICiCdHT/GRB
 dv3JrAgOGAfKRRXIc0DY4edpcKmP9ny/kQLX7aqNPjILv4EC/XE0M5Mt4RWxprXUfNu7s1DYTKh
 eMOFumLpZjeAS+BLDNImJH4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4glNzh5nVmz1T4Fl;
 Wed, 24 Jun 2026 09:06:08 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 28D1240537;
 Wed, 24 Jun 2026 09:14:49 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 09:14:48 +0800
Message-ID: <7d08995d-84c0-4989-9453-ac412cd0737a@huawei.com>
Date: Wed, 24 Jun 2026 09:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] bus: fix reference to plug callback
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <longli@microsoft.com>,
 <hemant.agrawal@nxp.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-2-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260623105439.2144694-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 6/23/2026 6:54 PM, David Marchand wrote:
> Remove now unused typedef, update documentation
> and some log following the callback rename.
> 
> Fixes: 76622feba9e6 ("bus: refactor device probe")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

