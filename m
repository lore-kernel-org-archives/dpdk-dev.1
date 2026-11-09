Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9209606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=kqsEHK9t
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7DD40E2D;
	Mon,  9 Nov 2026 17:21:00 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTPS id 243004028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=pU7Oph6nbGfsKxeFfvGMEDXjiz1bTS507cPWbQiiGb8=;
 b=kqsEHK9tgLKxoa1/hAriaEHnXvKWZvedW9aLyI8a8QLgJ8akUoJkxBHRTOaHfG
 nxnbKMi8WgvHATjC2YCLAAnNXGunWyT99FwDnCKiBaDDFzEbhSHPU7Cqwbw31vHu
 9x4IJ0cPEgbN2oGQm7OVyGpFurSYfy2IcmpI54PbcGZqA=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 01/28] net/hinic3: fix SP230 VF PCI device ID
Date: Tue, 10 Nov 2026 00:20:05 +0800
Message-ID: <20261109162033.1144-2-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xuFWUXw1kCw17Ar4ktFb_yoW8Gry7pF
 47GrWj9rWkGw4jv3WDG34DZryUXa4xC34jgwn7A3ZI9F1UXr15Z348KayrZry5tr4xXa4a
 vrsF934I9w12v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uia9fUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQIMFmrx8uIOMgAA3a
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

Firmware changed the SP230 VF device ID to 0x022a. Sync the driver
table to avoid probe failure with the old 0x3750 value.

Add the author to .mailmap while here.

Fixes: 8843a7a6bca5 ("net/hinic3: support new SPx series NIC")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 .mailmap                             | 1 +
 drivers/net/hinic3/base/hinic3_csr.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..30a60bfdb6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -762,6 +762,7 @@ Jesse Bruni <jesse.bruni@intel.com>
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

