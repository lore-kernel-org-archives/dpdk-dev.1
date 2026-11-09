Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BC606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=M7OEPWIY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E5714028B;
	Mon,  9 Nov 2026 17:20:57 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 645A140278
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+YADXCw5OpNNI6r/dYARF/36Vl46/ndOdtP+/aT+Q4k=;
 b=M7OEPWIYh7x5lpv2OGjBUwcY0+WFyTEEIBEp9dYltZM7sAUcs+ANiNSXiP8gEY
 bn3eMXqp8eqJZbrj3pISEPSaY7p2a9Tgo3JqaVPeXOZydypxJ9EkYh4b7Lg1PVuE
 PDm/nbrN5tPaVR/FNtAEa1IppBaO1wXEWV5sbna8cl1z4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 03/28] net/hinic3: fix TCAM index leak on ethertype flow set
Date: Tue, 10 Nov 2026 00:20:07 +0800
Message-ID: <20261109162033.1144-4-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4ftFWfXrW7uF15uF4DArb_yoW8Jw4UpF
 Z09ayvyrykt3yUC3WkJa18Za98Ca1Iy34UKan7u348urs8Xa1rA34YkFW8Wr1kZrW7Aa42
 vF4DCr9IgF1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0GQDUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQMMFmrx8uMONAAA3c
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When adding an ethertype filter on an HTN NIC, a TCAM index is allocated
before the firmware command is sent. If the command fails, the index is
never freed, leaking a dynamic TCAM slot and eventually exhausting the
dynamic TCAM pool. Free the index on the error path.

Fixes: b2d4933b80ec ("net/hinic3: support htn FDIR for new SPx series NIC")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_fdir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 71d50a3d22..95ce7cfe16 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -1001,6 +1001,9 @@ hinic3_set_fdir_ethertype_filter(void *hwdev, uint8_t pkt_type, void *filter, ui
 		PMD_DRV_LOG(ERR,
 			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0x%x, func_id %d",
 			    err, ethertype_cmd.head.status, out_size, ethertype_cmd.func_id);
+		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0 && en != 0)
+			hinic3_tcam_index_free(nic_dev, HINIC3_TCAM_GET_INDEX_IN_BLOCK(index),
+				HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index));
 		return -EIO;
 	}
 	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0) {
-- 
2.33.0

