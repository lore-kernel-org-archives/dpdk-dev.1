Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C1CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:10:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9448240274;
	Tue, 13 Oct 2026 17:10:25 +0200 (CEST)
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102]) by mails.dpdk.org (Postfix) with ESMTP id 18E9A40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904224; x=1823440224;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=mKoKy+JsX9bwHUf4b1P0t51PeJXXAlBHK69h4DW5aQg=;
 b=cflMS6/z57W0wDBo9oMTOi+5TgfumM0rsE0SKJwh5zjCBK6yNgdMXwhZ
 WBGMzWJlBCaWW3m0bS6BqQ9HEhJnB5x9QNL4pyR5UfOUd9JStEQZgo6st
 VM3ziFGMYBHqk5YqUtbA2yZpti83DzGz1TA6iKxqh/2ekFLDaZtwM7JFJ
 WSoX6fnCPbuLjs8ltLoStum0oZOKMyfke94od6NlH/wTyOZPTzjSqbWag
 Pta3vbTBJh8bECnI0F89Y4yjKTTXugt2clc3NKwiBJyxuIvHq2n9NrrRl
 4/Nx+2HvK0V/5gyxmJnv7QDdRl1NjV1KqKa9coNE3NDd9BddIi+YuW6xi w==;
X-CSE-ConnectionGUID: 3Ea+44wSQJahEBAFwHeQOQ==
X-CSE-MsgGUID: YnScyepZTAG9yN5KajZgOw==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31051413"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:10:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:16830]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.115:2525]
 with esmtp (Farcaster)
 id 1d96ac7c-08f4-4904-83ed-a121551fda21; Tue, 13 Oct 2026 15:10:17 +0000 (UTC)
X-Farcaster-Flow-ID: 1d96ac7c-08f4-4904-83ed-a121551fda21
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:10:17 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:10:16 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 08/13] net/ena/base: deduplicate meta caching config flag
Date: Tue, 13 Oct 2026 18:10:03 +0300
Message-ID: <20261013151003.9629-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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

struct ena_com_io_sq stores disable_meta_caching twice: once as a flat
field, initialised from io_sq->llq_info.disable_meta_caching, and once
inside the embedded llq_info structure. Both are assigned during queue
configuration and never diverge afterwards, making the flat field
redundant.

Remove the flat io_sq->disable_meta_caching field along with its
initialisation, and read the value from llq_info directly on the
metadata path.

No functional change.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c     | 2 --
 drivers/net/ena/base/ena_com.h     | 1 -
 drivers/net/ena/base/ena_eth_com.c | 2 +-
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index d218026220..268c04f617 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -397,8 +397,6 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		       0x0, io_sq->llq_info.desc_list_entry_size);
 		io_sq->llq_buf_ctrl.descs_left_in_line =
 			io_sq->llq_info.descs_num_before_header;
-		io_sq->disable_meta_caching =
-			io_sq->llq_info.disable_meta_caching;
 
 		if (io_sq->llq_info.max_entries_in_tx_burst > 0)
 			io_sq->entries_in_tx_burst_left =
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index e05933d6fe..1a64bf8ac5 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -153,7 +153,6 @@ struct ena_com_io_sq {
 	enum queue_direction direction;
 	enum ena_admin_placement_policy_type mem_queue_type;
 
-	bool disable_meta_caching;
 
 	u32 msix_vector;
 	struct ena_com_tx_meta cached_tx_meta;
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index ca15306859..63624d169b 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -439,7 +439,7 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	/* When disable meta caching is set, don't bother to save the meta and
 	 * compare it to the stored version, just create the meta
 	 */
-	if (io_sq->disable_meta_caching) {
+	if (io_sq->llq_info.disable_meta_caching) {
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
-- 
2.17.1

