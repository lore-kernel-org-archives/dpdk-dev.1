Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0F606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=fEwQEjuf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A76EF4060C;
	Wed, 25 Nov 2026 18:05:50 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 6136F40274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+YADXCw5OpNNI6r/dYARF/36Vl46/ndOdtP+/aT+Q4k=;
 b=fEwQEjuf8IFMLpJWge1j/kGB5CWOcaAfdSy9hHMNYCR4Q52gsp/Gil3JRqSMuJ
 NlYXmKQjXMpbrKz7CqU2m2dP9dsm3aKN20SbwaqfBGQXSZSM7xmSbFT1oPg6MNQ9
 aRtBGsOj4AwY7KnhE+YezPt8+4v1FcmfdCc5kyM2+KFUw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 03/30] net/hinic3: fix TCAM index leak on ethertype flow set
Date: Thu, 26 Nov 2026 01:03:57 +0800
Message-ID: <20261125170425.5430-4-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4ftFWfXrW7uF15uF4DArb_yoW8Jw4UpF
 Z09ayvyrykt3yUC3WkJa18Za98Ca1Iy34UKan7u348urs8Xa1rA34YkFW8Wr1kZrW7Aa42
 vF4DCr9IgF1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7ID7UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwj7BmsHFWgafAAA3x
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

