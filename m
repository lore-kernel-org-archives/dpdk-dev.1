Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92ABC88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AED1740A82;
	Tue, 15 Sep 2026 10:48:55 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id CCD3240290;
 Tue, 15 Sep 2026 10:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 104AA2C0BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462133; bh=AZMg2rWf9HGp+pBXe1keSMph94FDt4Q5kgH3G+yJJ64=;
 h=From:To:CC:Subject:Date:From;
 b=TMZRa/zxHa88X6tlnfsGWJyCqwiuWuFUmT0VXQVRP01yZcHU/rZkiDi2fs750EwQv
 s4ZuhHtHpSa3z5d+PTgfr9MPw5OpDaq1MflcpL5U+5gHT1j5qFmBlfirIOTlBvi2gu
 t2aNy6sm3VCnqedN2lKgjh0tb5PlI5Kj12hGvqK4=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 104AA2C0BBE;
 Tue, 15 Sep 2026 11:48:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt BF5842C0BC6
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id BF5842C0BC6;
 Tue, 15 Sep 2026 11:48:52 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Jay Ding <jay.ding@broadcom.com>, Farah Smith
 <farah.smith@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Peter Spreadborough
 <peter.spreadborough@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: fix channel disable bitmap handling
Date: Tue, 15 Sep 2026 08:48:50 +0000
Message-ID: <20260915084850.430813-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-01.infotecs-nt (10.17.0.3) To
 msk-exch-02.infotecs-nt (10.17.0.2)
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

The MPC channel enable bitmap is cleared before it is used to build
the channel mask. As a result, no channels are selected for disable.

Preserve the bitmap before clearing it and use the saved value when
building the channel mask.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 80317ff6adf ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_mpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index d77f9dd308..1398321ca7 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -48,18 +48,20 @@ static int bnxt_mpc_chnls_enable(struct bnxt *bp)
 static int bnxt_mpc_chnls_disable(struct bnxt *bp)
 {
 	struct bnxt_mpc *mpc = bp->mpc;
+	uint8_t mpc_chnl_flg;
 	uint8_t mpc_chnl_msk = 0;
 	int i, rc;
 
 	if (!mpc)
 		return -EINVAL;
+	mpc_chnl_flg = mpc->mpc_chnls_en;
 	mpc->mpc_chnls_en = 0;
 
 	if (!BNXT_PF(bp))
 		return 0;
 
 	for (i = 0; i < BNXT_MPC_CHNL_MAX; i++) {
-		if (!(mpc->mpc_chnls_en & (1 << i)))
+		if (!(mpc_chnl_flg & (1 << i)))
 			continue;
 		mpc_chnl_msk |= (1 << i);
 	}
-- 
2.30.2

