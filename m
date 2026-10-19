Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6860A6F65
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=kcqZVuHo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D6AF4069D;
	Mon, 19 Oct 2026 17:20:04 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 2C6E440659
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=HYhSP+A4L7sX9PuKBfUwICNxFiPu+783rejwdf2Ikoo=;
 b=kcqZVuHo+OIr66zeA3+GGcsaFd5HjeUWrGqJGBg8TbYSFyoa2MHab26CwOs0Dw
 RRGBU9fnzOIWurjAE1Wz/JKrfjolJcuAJ36Jq8coadJpTDpj8PgR0eo5R7Yxx256
 QWfA1P1ZJ14kyVElAUrgsxqRQDTL85omGzp2rIY8WCrz4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 01/27] net/hinic3: fix SP230 VF PCI device ID
Date: Mon, 19 Oct 2026 23:19:03 +0800
Message-ID: <20261019151930.1572-2-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1fXFW7Jr45Xw1DJrWxtFb_yoW8Jw45pF
 47GrWjkFWkKw4jy3WDK34DZryUXa4xC34jgwn7A3ZI9F1UXr15Z340gayrZry5tr4xXa4a
 vrsF93yIgw12v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uia9fUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhmjrWrWNRnUnAAA35
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Firmware changed the SP230 VF device ID to 0x022a. Sync the driver
table to avoid probe failure with the old 0x3750 value.

Fixes: 8843a7a6bca5 ("net/hinic3: support new SPx series NIC")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 .mailmap                             | 1 +
 drivers/net/hinic3/base/hinic3_csr.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..7b73c3b492 100644
--- a/.mailmap
+++ b/.mailmap
@@ -757,6 +757,7 @@ Jesse Bruni <jesse.bruni@intel.com>
 Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>
 Jia Jia <physicalmtea@gmail.com>
 Jia Yu <jyu@vmware.com>
+Jiacheng Ye <yejiacheng4@h-partners.com>
 Jian Wang <jianwang@trustnetic.com>
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>
 Jianfeng Tan <jianfeng.tan@intel.com>
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index eceb34e9fd..7cae2419c0 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -11,7 +11,7 @@
 #define HINIC3_DEV_ID_VF_SP620	0x375F
 
 #define HINIC3_DEV_ID_SP230	0x0229
-#define HINIC3_DEV_ID_VF_SP230	0x3750
+#define HINIC3_DEV_ID_VF_SP230	0x022a
 
 #define HINIC3_DEV_ID_SP920	0x0224
 
-- 
2.33.0

