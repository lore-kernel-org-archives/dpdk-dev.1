Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981AC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 10:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48389402C4;
	Tue, 18 Mar 2025 11:54:00 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 933C140291;
 Tue, 18 Mar 2025 11:53:58 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.72.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B1B51E0E7D;
 Tue, 18 Mar 2025 14:53:57 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B1B51E0E7D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1742295238;
 bh=0bJPZ6Nb466VGU/N7m/a8g7Dn6S9u3jhORYdjBfwiIs=;
 h=From:To:Cc:Subject:Date:From;
 b=cznjgPa6Z+OvgYgyx6QwO7Tj1JdSblu//A4awkl9faQfNbJDyEh3RLaGLJX99yD6Q
 AcjhCfgm/e4tcliNrVqr4kZTuGM+sHkYbSbOiL8ygj/ipiRBy70p7Kp1m4UUi0DtGP
 4gqolmZW4Th7iGezEq1j4H830c+ZAZ8gkIu1AYcWxRNgAcKVLC0xCoiC/trkwhFayE
 xpBqPvMeijTVcWRB5TJqHINhSnztwJTMDVcoZydH+RfJVzHlPvsqmiVUBkaAAV4U/o
 SAlSVt695BFU4EpGFT8LNt15EYcBIfn0sJPlZ5qlt58o4+rvzWtGeUuyNVyN9P7vB/
 3PlqGQ5G2WwZA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org,
 Andy Moreton <andy.moreton@amd.com>
Subject: [PATCH] net/sfc: fix action order on fail path for the adaptor start
Date: Tue, 18 Mar 2025 14:53:49 +0400
Message-Id: <20250318105349.8331-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Having incorrect order leads to an assert in efx_nic_fini().

Fixes: bc712f1c86fc ("net/sfc: support attaching to HW table")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 2cfff20f47..938c967430 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -530,12 +530,12 @@ sfc_try_start(struct sfc_adapter *sa)
 fail_rx_start:
 	sfc_port_stop(sa);
 
-fail_tbls_start:
-	sfc_ev_stop(sa);
-
 fail_port_start:
 	sfc_tbls_stop(sa);
 
+fail_tbls_start:
+	sfc_ev_stop(sa);
+
 fail_ev_start:
 	sfc_intr_stop(sa);
 
-- 
2.17.1

