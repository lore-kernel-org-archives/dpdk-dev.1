Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A604C88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BAA440E38;
	Tue, 15 Sep 2026 10:50:48 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 9D72A40290;
 Tue, 15 Sep 2026 10:50:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 105012C0B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462247; bh=NwNwMmM5Li7bULBbq/2uVr044CG+xVqS/mS40iXpAPE=;
 h=From:To:CC:Subject:Date:From;
 b=Z8zE60scmxRETLLHWjqQOY2Y1vznrQ/qlwbxAUx0xe9jTKHIizTh7eLzJ+I4XHI5p
 PoPGfiY2+SqUxqEhoqn9Q9k0vzednuS0TiEHtcQGHzhAJgoytLTXiMbURKhNZZrm4/
 GRB55rUmfwBW0AoneH9Ynl/qEiUENIdwRiXKtkzo=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 105012C0B6E;
 Tue, 15 Sep 2026 11:50:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 9736B2C0BBE
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 9736B2C0BBE;
 Tue, 15 Sep 2026 11:50:46 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Santoshkumar Karanappa Rastapur <santosh.rastapur@broadcom.com>, Venkat
 Duvvuru <venkatkumar.duvvuru@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: check return code of bnxt_hwrm_vnic_rss_cfg in flow
 create
Date: Tue, 15 Sep 2026 08:50:43 +0000
Message-ID: <20260915085043.430856-1-Evgeny.Sokolov@infotecs.ru>
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

The return value of bnxt_hwrm_vnic_rss_cfg() was not checked in
bnxt_flow.c. As a result, RSS configuration failures could be
silently ignored and the flow setup could continue with an
incorrect VNIC configuration.

Check the return status and propagate the error to the caller.

Fixes: adc0f81c655 ("net/bnxt: support RSS action")
Cc: stable@dpdk.org

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_flow.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..63cfa3a045 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -1631,7 +1631,16 @@ bnxt_validate_and_parse_flow(struct rte_eth_dev *dev,
 					       rss->key,
 					       rss->key_len);
 			}
-			bnxt_hwrm_vnic_rss_cfg(bp, vnic);
+			rc = bnxt_hwrm_vnic_rss_cfg(bp, vnic);
+			if (rc) {
+				rte_flow_error_set(error,
+						   -rc,
+						   RTE_FLOW_ERROR_TYPE_ACTION,
+						   act,
+						   "VNIC RSS configure failed");
+				rc = -rte_errno;
+				goto ret;
+			}
 		} else {
 			PMD_DRV_LOG_LINE(DEBUG, "No RSS config required");
 		}
-- 
2.30.2

