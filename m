Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30450D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1E5402D0;
	Fri, 30 Jan 2026 02:22:27 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3EF15402C9
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:22:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=xh6CYliKpSGvn6M6oWVKy2jHIs5xui11dDyA96y6XTU=;
 b=NC36XdqI2zBSvVpkPGt2xJFsvA3uNL/+4lup92KbG7YJxuM0fYh/64GxegJIZEPGWUSsEuehM
 6gATlKoanh3fdCg00Vczn7oRYly62wfzBsQsaNFUCLopMRCYitNZLWLw8cF84Xeie5Dk4FfWEM9
 BTtyYyyXrxXbLNrT3vgRB7E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f2J7L5475zKmWZ;
 Fri, 30 Jan 2026 09:18:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 58CDF40565;
 Fri, 30 Jan 2026 09:22:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 09:22:23 +0800
Message-ID: <71e7179b-ed4a-4b10-a3e1-fecbb3f913ab@huawei.com>
Date: Fri, 30 Jan 2026 09:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: remove extra characters ending comment blocks
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, Ori Kam
 <orika@nvidia.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jerin
 Jacob <jerinj@marvell.com>, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, Paul
 Szczepanek <paul.szczepanek@arm.com>
References: <20260129144749.3637111-1-thomas@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260129144749.3637111-1-thomas@monjalon.net>
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

On 1/29/2026 10:47 PM, Thomas Monjalon wrote:
> At the end of a comment, no need for an extra line.
> 
> This pattern was fixed with the following command:
> git ls lib | xargs sed -i '/^ *\* *$/{N;/ *\*\/ *$/D;}'
> 
> A comment should always be terminated with */
> 
> Extra asterisks were found with this command:
> git grep '\* *\*/' lib
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

