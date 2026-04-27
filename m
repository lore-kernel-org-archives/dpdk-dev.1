Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DDFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97BF640668;
	Wed, 29 Apr 2026 11:58:23 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id A6A51402BC;
 Mon, 27 Apr 2026 17:44:10 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777304649; h=from:subject:to:date:message-id;
 bh=FCLU93Nzq+hV4AqEg2CE0IlWTs+7grXxggCWxPMjERk=;
 b=jKjKkFYSo/57/bPhTc0n6Nf0HpeFpZebDFCATLiA+0FVULcvDm1lE8DfJGd8hV/RJeL6zxOAqjG
 zyydhSCTwUmIOpWKWPoqKZqyv67fg65839yX5m2cSeTWvoDJJXcSGFW2I2Osp2AMAVmjcKk/xmGLh
 s+qnLmJdUSHP7ABpqCpMTGxHu7wsy+bm3kEyaVyHDSFLaYYIFsuvb8ir3ZaVwSVtcdsn/3CC7VKSp
 CTJw+lrx+aKThVYA+xtQtNZhvZk03SfrVpuOOX7+iM0ZfqvQDGPfFHueesyiFb6U+rxmjwyQRTqLD
 xF98JRFDE+FM/CzxTuG2+03UEyp4pRe9/eHA==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 27 Apr
 2026 18:44:08 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Andrey
 Chilikin <andrey.chilikin@intel.com>, Beilei Xing <beilei.xing@intel.com>
CC: Daniil Iskhakov <dish@amicon.ru>, <stable@dpdk.org>, Daniil Agalakov
 <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] net/i40e: validate DDP segment header before use
Date: Mon, 27 Apr 2026 18:44:01 +0300
Message-ID: <20260427154401.1813519-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

rte_pmd_i40e_get_ddp_info() retrieves the I40E segment header with
i40e_find_segment_in_package(). That helper may return NULL if the
segment cannot be found.

The returned pointer is validated only in one code path, while other
branches use it without checking. This can lead to a NULL pointer
dereference when parsing a malformed or incomplete DDP package.

Move the NULL check right before the segment usage so it applies to all
request types needed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edeab742edac ("net/i40e: get information about DDP profile")
Cc: stable@dpdk.org

Signed-off-by: Daniil Agalakov <ade@amicon.ru>
Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: andrey.chilikin@intel.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 drivers/net/intel/i40e/rte_pmd_i40e.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 4fdef9464b..78b1f1f12d 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -1878,6 +1878,11 @@ int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 		return I40E_SUCCESS;
 	}
 
+	if (!i40e_seg_hdr) {
+		PMD_DRV_LOG(ERR, "Failed to find i40e segment header");
+		return -EINVAL;
+	}
+
 	/* get i40e segment header info */
 	if (type == RTE_PMD_I40E_PKG_INFO_HEADER) {
 		struct rte_pmd_i40e_profile_info *info =
@@ -1893,11 +1898,6 @@ int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 			return -EINVAL;
 		}
 
-		if (!i40e_seg_hdr) {
-			PMD_DRV_LOG(ERR, "Failed to find i40e segment header");
-			return -EINVAL;
-		}
-
 		memset(info, 0, sizeof(struct rte_pmd_i40e_profile_info));
 		info->owner = RTE_PMD_I40E_DDP_OWNER_UNKNOWN;
 		info->track_id =
-- 
2.43.0

