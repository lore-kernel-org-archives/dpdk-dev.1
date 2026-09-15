Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EDC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D74BA40A77;
	Tue, 15 Sep 2026 11:51:00 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 6A2674003C;
 Tue, 15 Sep 2026 11:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru AE4C02C0BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789465859; bh=6NzXSNrARlN2H+K3EBVy1Zt+Fs+m5+S3hI6D8SYfo58=;
 h=From:To:CC:Subject:Date:From;
 b=mrUVvbLWQ3tgMjaIwuaUPl3LJywrqOQlGFpbp0NF1sQ9PHe2iIPzPa/43EUvW6TD7
 jIhkoGENekKNBX6Stfa3B7n6yeCjTAp4bOlG7ncaXpJHdcDGpsWrFkJvZOl5YWgI2h
 W6Ss0j0uuPeBKLM7kWLulyPJ0y/U8ip0f6wlcrsE=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id AE4C02C0BC6;
 Tue, 15 Sep 2026 12:50:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 4F3752C0B1D
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 4F3752C0B1D;
 Tue, 15 Sep 2026 12:50:57 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jia.guo@intel.com>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/iavf: remove redundant assignment in FDIR parser
Date: Tue, 15 Sep 2026 09:50:54 +0000
Message-ID: <20260915095055.431718-1-Evgeny.Sokolov@infotecs.ru>
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
 bases: 2026/09/15 09:01:00 #28584736
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

The assignment to next_type in the <case> branch is redundant since
the value is never used afterwards.

Remove the leftover assignment, which appears to have been copied from
another parser branch, to avoid confusing readers.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/intel/iavf/iavf_fdir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index ea620863ca..a5fe90283f 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -711,7 +711,6 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 			ipv4_spec = item->spec;
 			ipv4_last = item->last;
 			ipv4_mask = item->mask;
-			next_type = (item + 1)->type;
 
 			hdr = &hdrs->proto_hdr[layer];
 
-- 
2.30.2

