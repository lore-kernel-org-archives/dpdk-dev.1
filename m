Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85C606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=HrUEWX/O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF0640B90;
	Fri, 23 Oct 2026 17:58:25 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id A12014067A;
 Fri, 23 Oct 2026 17:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=YJJVbT3Y/dnkT6R9lbCE34qvqJf09bLFJvbLTotep5M=;
 b=HrUEWX/OYgUvi0Ei9djMAZr06OuwEKWp6ZKjO2X+zdfv7r4j3Wvjw2/dHMnd54
 NQVsM0Q972eigRWkJq+AO+YPYJyxVlcNqkWkAzkPUhXSRieKetMWDmY+pdQrDJ8i
 UbspObBqBskdCSS6o+gaQP92pOoEMdjSXkLJRW3UZzoYk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v4 03/27] net/hinic3: fix TCAM index leak on ethertype flow set
Date: Fri, 23 Oct 2026 23:57:44 +0800
Message-ID: <20261023155809.855-4-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF43KrWkGFWDZr1UAr47urg_yoW8Gr1UpF
 ZxuayvyFyvy3yUC3WkJa10vFZ8Ca12y34DKan7u34Uurs8Xa1rA34YkFWrWr1kZrW7Aa42
 vF4DCr9Fg3WDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7CztUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMha3wWrbhBbigQAA3S
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

Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Cc: stable@dpdk.org

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

