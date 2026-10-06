Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F1CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4978140ECF;
	Tue,  6 Oct 2026 13:43:54 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9217440A81;
 Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C2961A01AD;
 Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D3E71A01A1;
 Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5E313180006C;
 Tue,  6 Oct 2026 19:43:50 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 1/6] crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
Date: Tue,  6 Oct 2026 17:13:41 +0530
Message-Id: <20261006114346.1229651-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006114346.1229651-1-g.singh@nxp.com>
References: <20260930070809.1929564-1-g.singh@nxp.com>
 <20261006114346.1229651-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

In build_authenc_gcm_fd, when both AAD (auth_only_len > 0) and decrypt
direction are active, the SGE layout occupies 8 entries plus 16 bytes of
old_icv storage at index 8. The FLE pool buffer was only 256 bytes
(8 x 32), causing old_icv to be written one entry past the end of the
allocated buffer. The resulting virtual address was not mapped by the
IOMMU, so DPAA2_VADDR_TO_IOVA returned 0 and the SEC engine received
iova=0x00000000 as the ICV buffer address, triggering an SMMU
translation fault (FSR=0x402 TF).

Additionally, the upfront bpid/IVP initialization only covered sge+3,
leaving sge+4 (the input data SGE when AAD is present) without a valid
bpid or IVP assignment.

Increase FLE_POOL_BUF_SIZE from 256 to 288 (9 x 32 bytes) to
accommodate the full layout, and extend the bpid/IVP initialization
to cover sge+4 in both branches of build_authenc_gcm_fd.

Fixes: 13273250eec5 ("crypto/dpaa2_sec: support AES-GCM and CTR")
Cc: stable@dpdk.org
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 2 ++
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..2a015a3d82 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -569,6 +569,7 @@ build_authenc_gcm_fd(dpaa2_sec_session *sess,
 		DPAA2_SET_FLE_BPID(sge + 1, bpid);
 		DPAA2_SET_FLE_BPID(sge + 2, bpid);
 		DPAA2_SET_FLE_BPID(sge + 3, bpid);
+		DPAA2_SET_FLE_BPID(sge + 4, bpid);
 	} else {
 		DPAA2_SET_FD_IVP(fd);
 		DPAA2_SET_FLE_IVP(fle);
@@ -577,6 +578,7 @@ build_authenc_gcm_fd(dpaa2_sec_session *sess,
 		DPAA2_SET_FLE_IVP((sge + 1));
 		DPAA2_SET_FLE_IVP((sge + 2));
 		DPAA2_SET_FLE_IVP((sge + 3));
+		DPAA2_SET_FLE_IVP((sge + 4));
 	}
 
 	/* Save the shared descriptor */
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 755c8e9cc3..ff32f3d860 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -17,7 +17,7 @@ extern uint8_t cryptodev_driver_id;
 
 /* FLE_POOL_NUM_BUFS is set as per the ipsec-secgw application */
 #define FLE_POOL_NUM_BUFS	32000
-#define FLE_POOL_BUF_SIZE	256
+#define FLE_POOL_BUF_SIZE	288
 #define FLE_POOL_CACHE_SIZE	512
 #define FLE_SG_MEM_SIZE(num)	(FLE_POOL_BUF_SIZE + ((num) * 32))
 
-- 
2.25.1

