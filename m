Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4944C88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 07:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE58406B4;
	Tue, 15 Sep 2026 09:55:54 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 4144E40290;
 Tue, 15 Sep 2026 09:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 5E5872C0B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789458951; bh=U0Ok0fGf1zmp2WUo9Uzr2gTqsbkBb04TGoMGnBe0Gxc=;
 h=From:To:CC:Subject:Date:From;
 b=rO6KjV1ABiNaZxANFxaMPMBkcbZk+7AUPnJm7fE/9MkxnkrbC89fiFdt3c9rIERnD
 fmG2I48v6WCOcK9aGBORxswsLWxia4U+o3JKMY3JhPxk9NnGliy8PcFW6pmM4hS2/O
 74BdYuj33G0rQaUZo+GzT/ta+AcJTeROfnU54ZTg=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 5E5872C0B6E;
 Tue, 15 Sep 2026 10:55:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 08B1B2C0053
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 08B1B2C0053;
 Tue, 15 Sep 2026 10:55:51 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <ting.xu@intel.com>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH 1/5] Removing comparison enum to bool
Date: Tue, 15 Sep 2026 07:55:49 +0000
Message-ID: <20260915075549.429013-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 05:24:00 #28584173
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

---
 drivers/net/intel/iavf/iavf_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 1d12196ba6..2d40028450 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -190,7 +190,7 @@ iavf_node_param_check(struct iavf_info *vf, uint32_t node_id,
 	}
 
 	/* for leaf node */
-	if (params->leaf.cman) {
+	if (params->leaf.cman != RTE_TM_CMAN_TAIL_DROP) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_CMAN;
 		error->message = "Congestion management not supported";
 		return -EINVAL;
-- 
2.39.5

