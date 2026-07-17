Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF3C4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AABB40E72;
	Fri, 17 Jul 2026 11:40:53 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id AE20940270
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:40:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4ByqvHtlK2D9Xi39qP7rdkeZKdchyK8N2PkmlFKAwdk=;
 b=p2XvKb0iReP/TfZ5p0GFMG+mM9uvNQCEswa3XDRHfQ7wCfTCd9v+nP2IGo4Ed62LtOq4oO59C
 +8cf7D6Y2YLywNacoKbuIvXjSL5ZVMZqDnmcpl1XcZXlM4GPPE7NUGhwNBeJ1Q+ypMyvQwtYCTi
 OOMs1swOR/ZcktghhE7qams=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h1l693hSzzmV7C;
 Fri, 17 Jul 2026 17:31:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 46CFF4056C;
 Fri, 17 Jul 2026 17:40:49 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 17:40:48 +0800
Message-ID: <872af7d9-c6fb-4ac3-b9f7-ec3699ab28a4@huawei.com>
Date: Fri, 17 Jul 2026 17:40:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usertools/telemetry: load aliases from config directory
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry
 <rjarry@redhat.com>
References: <20260717091603.1492650-1-thomas@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260717091603.1492650-1-thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 7/17/2026 5:16 PM, Thomas Monjalon wrote:
> The default path of the telemetry alias file
> was at the top level of the home directory.
> 
> Load aliases from the DPDK configuration directory instead,
> using $XDG_CONFIG_HOME/dpdk/telemetry_aliases
> or $HOME/.config/dpdk/telemetry_aliases.
> 
> Keep --alias-file for users who want to provide an explicit path.
> 
> Fixes: 410d498412e4 ("usertools/telemetry: support aliases for long commands")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

