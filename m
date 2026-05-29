Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7704CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 20:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D0540264;
	Fri, 29 May 2026 22:55:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E005740262
 for <dev@dpdk.org>; Fri, 29 May 2026 22:55:27 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447AC2576;
 Fri, 29 May 2026 13:55:22 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 010943F632;
 Fri, 29 May 2026 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780088127; bh=ZOpGo8eVWVW3LMXicTYtzsmoUS7UG1qM+CwYaXejHvQ=;
 h=From:To:Cc:Subject:Date:From;
 b=SQOX+th/wEGdpogP2iCPQ/GZGGbs8XUIjWqnBBlusgs0locwI2ZXj3YsOKb2du9MR
 cSDZ+Psw2Kqc/1zXEzKsX6Kb7mBP8UjifuAtHVh6VK9dCwGDeu+MYcQDgaBU8hPW+L
 S0z/dDXH+2sh8umFHg3BEV0QPsm6lqZFtjPb1OKE=
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org, nd@arm.com, Paul.Elliott@arm.com, Dhruv.Tripathi@arm.com,
 Shebu.VargheseKuriakose@arm.com,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs on Arm
Date: Fri, 29 May 2026 20:55:11 +0000
Message-ID: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
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

Extend Arm PMD gating in ipsec_mb_create() to permit
IPSEC_MB_PMD_TYPE_AESNI_MB and IPSEC_MB_PMD_TYPE_AESNI_GCM
in addition to existing SNOW3G and ZUC.

This removes -ENOTSUP rejection for crypto_aesni_mb and
crypto_aesni_gcm on Arm, enabling these vdevs to probe and run
when backed by a compatible ipsec-mb library.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 drivers/crypto/ipsec_mb/ipsec_mb_private.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.c b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
index b4c36e7f58..468d77fead 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
@@ -72,7 +72,9 @@ ipsec_mb_create(struct rte_vdev_device *vdev,
 
 #if defined(RTE_ARCH_ARM)
 	if ((pmd_type != IPSEC_MB_PMD_TYPE_SNOW3G) &&
-		(pmd_type != IPSEC_MB_PMD_TYPE_ZUC))
+		(pmd_type != IPSEC_MB_PMD_TYPE_ZUC) &&
+		(pmd_type != IPSEC_MB_PMD_TYPE_AESNI_MB) &&
+		(pmd_type != IPSEC_MB_PMD_TYPE_AESNI_GCM))
 		return -ENOTSUP;
 #endif
 
-- 
2.43.0

