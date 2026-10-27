Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A470606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tzhTRWCX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF78B4025A;
	Tue, 27 Oct 2026 03:41:46 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTPS id D1BE140151
 for <dev@dpdk.org>; Tue, 27 Oct 2026 03:41:45 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5GeR5nVFPP6T3iiJnbcu8a7AWxGnn6/sgH13BCJR7kk=;
 b=tzhTRWCXzXjIRjaxrzlPF/bg11Kb1qidRgf1R3LrvyLOmZqfUjI6ctwhcfsQEDhH/VfpXAxlp
 N3y5NLy1+asSIPloliNx1rCSSyxp/2pAz1IEeJHs3StvnOayRDDJsALV2ngHxkvNAKhffy5a7IA
 Q7u6f5e1za4aN96k46G2Gp0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jDFB80BLdzLlWn;
 Tue, 27 Oct 2026 10:41:36 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id AEFA94055B;
 Tue, 27 Oct 2026 10:41:41 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 10:41:40 +0800
Message-ID: <d43e47f1-260b-4465-825a-9d0d00450431@huawei.com>
Date: Tue, 27 Oct 2026 10:41:40 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ethdev: check RSS availability
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, Sunil Kumar Kori <skori@marvell.com>, Rakesh
 Kudurumalla <rkudurumalla@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Praveen Shetty <praveen.shetty@intel.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, Yipeng Wang
 <yipeng1.wang@intel.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-13-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261022174447.412638-13-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/23/2026 1:44 AM, David Marchand wrote:
> Add RSS capability check in rte_eth_dev_configure() using
> dev_info.flow_type_rss_offloads.
> 
> When zero, reject Rx modes with RTE_ETH_MQ_RX_RSS_FLAG
> unless only one queue was requested.
> 
> If a driver does not advertise RSS, don't request it in test
> applications or examples, as role model citizens.
> 
> Remove redundant RSS checks from drivers.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

