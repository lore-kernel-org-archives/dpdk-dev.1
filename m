Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142FFCD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 01:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D34D40278;
	Tue, 12 May 2026 03:30:53 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 93AC740264
 for <dev@dpdk.org>; Tue, 12 May 2026 03:30:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=snaUtYoYLsqArWu3qTwR0Z7kpQU+qu9FhSYmJYFel5k=;
 b=XwiNYSuwYoZQXbwNTXtSHqpFDCc/aNqVrYp3eGYOcXaEvQn1s2IA4b63Gr6ov+km5Gt1xo/Qm
 BsmJgtYg4Se/9kTqbBzKhJ7mc2uiacPdh7a4XdHimdH4YUrTGKnVhxVkbeK2xFZWgeoCjGA6KQi
 6zYShk8P6lP76GOfZ7r0wZw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gDzP94Jbkz1TF8r;
 Tue, 12 May 2026 09:23:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 173A94056A;
 Tue, 12 May 2026 09:30:49 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 09:30:48 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 09:30:48 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH] power/intel_uncore: reduce log level for dependency missing
Date: Tue, 12 May 2026 09:30:47 +0800
Message-ID: <20260512013047.375535-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

When run dpdk-l3fwd with '-u' on non-X86 platform, user would
happen a noisy print as the following:
"POWER: Uncore frequency management not supported/enabled on this
kernel. Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel
x86 with linux kernel >= 5.6".

The root cause is that intel_uncore driver's .init() will be called
on any platform when use automatic detection mode. The function in
intel_uncore driver will print above log on non-X86 platform.

But the existing uncore core cannot solve this problem unless break
ABI to add new callback. So reduce its log level to avoid this
incorrect prompt.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/intel_uncore/intel_uncore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/intel_uncore/intel_uncore.c b/drivers/power/intel_uncore/intel_uncore.c
index 6759ea1445..ebca395075 100644
--- a/drivers/power/intel_uncore/intel_uncore.c
+++ b/drivers/power/intel_uncore/intel_uncore.c
@@ -419,7 +419,7 @@ power_intel_uncore_get_num_pkgs(void)
 
 	d = opendir(INTEL_UNCORE_FREQUENCY_DIR);
 	if (d == NULL) {
-		POWER_LOG(ERR,
+		POWER_LOG(DEBUG,
 		"Uncore frequency management not supported/enabled on this kernel. "
 		"Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel x86 with linux kernel"
 		" >= 5.6");
@@ -457,7 +457,7 @@ power_intel_uncore_get_num_dies(unsigned int pkg)
 
 	d = opendir(INTEL_UNCORE_FREQUENCY_DIR);
 	if (d == NULL) {
-		POWER_LOG(ERR,
+		POWER_LOG(DEBUG,
 		"Uncore frequency management not supported/enabled on this kernel. "
 		"Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel x86 with linux kernel"
 		" >= 5.6");
-- 
2.33.0

