Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9322CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B6D40612;
	Tue, 13 Oct 2026 17:08:33 +0200 (CEST)
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.155.198.111])
 by mails.dpdk.org (Postfix) with ESMTP id D9FED40612
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904111; x=1823440111;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=H1Zyphc0pRudlf2l06tzczSX17o5299Hg85SCdWsRPs=;
 b=hQU1SQgvnG1vlL0tqJgCH3NC4RxrinQTWuUN1caA2FAi16OQSvlUbai6
 Pq3g0JEIkqi2BHTv1UoxNkwqIE1IxY9lp86fYjATQ0Xbud6DQs1r1s0YK
 4moSUkNz0ZVPDSeKg29kWuhEUjaGMnZcTQvPiazhZPFhbZ0JJM4FAtGX2
 Nzvmi3x/F5hjx+x3+NnL2ywSw3jOEMpb8YpLaGzJQ6cwIt6PDWmzY2Qo8
 qvRuYSc9qUEzrGwB9/n3AdJrQ8VQmtFMNdeA2Y285SviaFDdnfFsTimLH
 SkfcfKHhsl/OtzqySA0SPYFo1tAdnf4/CQc3aviL0YFfv2reETEZMTBiM Q==;
X-CSE-ConnectionGUID: HHWyesysSRG96J0dTruJHA==
X-CSE-MsgGUID: WqIEKKCxT+a2ndH4egBP5A==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31040999"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:08:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:18771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.241:2525]
 with esmtp (Farcaster)
 id af6e00fa-52cd-421c-b8c5-69cc74a2530f; Tue, 13 Oct 2026 15:08:27 +0000 (UTC)
X-Farcaster-Flow-ID: af6e00fa-52cd-421c-b8c5-69cc74a2530f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:08:26 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:08:25 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 04/13] net/ena/base: rename bounce buffer references
Date: Tue, 13 Oct 2026 18:08:12 +0300
Message-ID: <20261013150812.9433-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Rename curr_bounce_buf pointer in sq llq packet control to
curr_llq_entry for future use of llq not only with bounce buffers.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 4 ++--
 drivers/net/ena/base/ena_com.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index f08d9214aa..9a118394d2 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -391,9 +391,9 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		       sizeof(io_sq->llq_info));
 
 		/* Initiate the first bounce buffer */
-		io_sq->llq_buf_ctrl.curr_bounce_buf =
+		io_sq->llq_buf_ctrl.curr_llq_entry =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
+		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
 		       0x0, io_sq->llq_info.desc_list_entry_size);
 		io_sq->llq_buf_ctrl.descs_left_in_line =
 			io_sq->llq_info.descs_num_before_header;
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 0b728a94bc..2002dd2bda 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -138,7 +138,7 @@ struct ena_com_io_bounce_buffer_control {
 
 /* This struct is to keep tracking the current location of the next llq entry */
 struct ena_com_llq_pkt_ctrl {
-	u8 *curr_bounce_buf;
+	u8 *curr_llq_entry;
 	u16 idx;
 	u16 descs_left_in_line;
 };
-- 
2.17.1

