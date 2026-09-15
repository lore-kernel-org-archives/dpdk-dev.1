Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF6C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35ACE40A77;
	Tue, 15 Sep 2026 11:11:55 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2334003C;
 Tue, 15 Sep 2026 11:11:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D07FC2C0BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789463514; bh=r1iSf9q9jSzExXLrTwPArdPKJWPNnq2RYCAqw/MxflY=;
 h=From:To:CC:Subject:Date:From;
 b=RPSSW1RToSE9nWHjh01+lPT52js9uzKG/aYT/dCRFmNpAoF1nQkamKjWc84oG7c1E
 m0qJ2DEm+d0utPstK7xd80N+qrqYEzucjyZIFS9dE8bsHxpVQpVctvuI2/RvFTqLCZ
 zJqg+8SWx57noLW2oXowubtyKWF7x6GoX5hKP4V4=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id D07FC2C0BAF;
 Tue, 15 Sep 2026 12:11:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 879D12C0B19
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 879D12C0B19;
 Tue, 15 Sep 2026 12:11:53 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <stuart.schacher@broadcom.com>, Sokolov
 Evgeny <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt/tf_ulp: use 64-bit shift in burst size calculation
Date: Tue, 15 Sep 2026 09:11:50 +0000
Message-ID: <20260915091150.431471-1-Evgeny.Sokolov@infotecs.ru>
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

Use 1ULL instead of 1 in the left shift operation when
calculating the burst size mantissa.

This avoids undefined behavior when the shift count exceeds
the width of a 32-bit integer.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Cc: stable@dpdk.org
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index 7f6a84e699..88a2f30521 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -155,7 +155,7 @@ bnxt_ulp_flow_mtr_xbs_calc(int64_t xbs, uint16_t *reg)
 	 *   = round(xbs*2^(8-e) - 2^7)
 	 *
 	 */
-	m = xbs / (1 << (e - 8)) - (1 << 7);
+	m = xbs / (1ULL << (e - 8)) - (1ULL << 7);
 	*reg = ((m & 0x7F) << 5) | (e & 0x1F);
 	*reg = rte_cpu_to_be_16(*reg);
 }
-- 
2.30.2

