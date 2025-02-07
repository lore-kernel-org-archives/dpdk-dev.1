Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A26EC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EDF542EE2;
	Fri,  7 Feb 2025 13:46:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id ADEB242EC3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932397; x=1770468397;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=T3y9qXh66pl5Tv/JjgXWDP9+X4bXpo7UEVSVHLIMHGE=;
 b=WY6BHa9W0VpIsh7+9OYQKdPVSdtisnU7iDBiO6JrLUwZdoP7Nj4mZ1Yn
 ZiAuvT/0GY0vq7ac3YpMObnYIc1qj+RpBhSyTcrZ86UHoEPJ1JNvHbLut
 ZfQC1WyzkngYvA7F+y6K4XE9U5Fdy7zjDPX4KMVLW+XVpPLBnlH8ZeQKK
 5FO5DURBzMzAOYyWYpq5F9aFOFmTbkaVxMHLY38bfZP1XinDuSQExloGJ
 0g/TtiQISJMvmLh20ZeH6y7AsvT8M/Kx25aclqyWsVIzo+IdJK/b/32fM
 dHgUaXpxmWMJHaGj3E1AO/FCO8/IcI9DB/bwZKuofHaFivQjt5ceoHdc1 Q==;
X-CSE-ConnectionGUID: RLe5KLOsRHKHEcLpFLbSwg==
X-CSE-MsgGUID: ORZ0PGn0R36aUp7WIed0nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331889"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331889"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:37 -0800
X-CSE-ConnectionGUID: aGfj3KUGQrGfmDUgmoAPIw==
X-CSE-MsgGUID: 8ymSoq0STkK0rllXH3m0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953848"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 35/36] net/e1000/base: rename NVM version variable
Date: Fri,  7 Feb 2025 12:45:27 +0000
Message-ID: <0933f693937ff29cf920aa70427e09f497446b98.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Piotr Kubaj <piotrx.kubaj@intel.com>

Rename version to nvm_version to avoid shadowing global variables on some
systems.

Signed-off-by: Piotr Kubaj <piotrx.kubaj@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                                  |  2 +-
 drivers/net/intel/e1000/base/e1000_i210.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 857af326e3..4c5600a3c2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1206,7 +1206,7 @@ Piotr Azarewicz <piotr.azarewicz@intel.com> <piotrx.t.azarewicz@intel.com>
 Piotr Bartosiewicz <piotr.bartosiewicz@atendesoftware.pl>
 Piotr Bronowski <piotrx.bronowski@intel.com>
 Piotr Gardocki <piotrx.gardocki@intel.com>
-Piotr Kubaj <pkubaj@freebsd.org>
+Piotr Kubaj <piotrx.kubaj@intel.com> <pkubaj@freebsd.org>
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
 Piotr Pietruszewski <piotr.pietruszewski@intel.com>
 Piotr Raczynski <piotr.raczynski@intel.com>
diff --git a/drivers/net/intel/e1000/base/e1000_i210.c b/drivers/net/intel/e1000/base/e1000_i210.c
index 52800376e4..479d2dc2c2 100644
--- a/drivers/net/intel/e1000/base/e1000_i210.c
+++ b/drivers/net/intel/e1000/base/e1000_i210.c
@@ -479,7 +479,7 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 					     E1000_INVM_RECORD_SIZE_IN_BYTES);
 	u32 buffer[E1000_INVM_SIZE];
 	s32 status = -E1000_ERR_INVM_VALUE_NOT_FOUND;
-	u16 version = 0;
+	u16 nvm_version = 0;
 
 	DEBUGFUNC("e1000_read_invm_version");
 
@@ -496,14 +496,14 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 
 		/* Check if we have first version location used */
 		if ((i == 1) && ((*record & E1000_INVM_VER_FIELD_ONE) == 0)) {
-			version = 0;
+			nvm_version = 0;
 			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have second version location used */
 		else if ((i == 1) &&
 			 ((*record & E1000_INVM_VER_FIELD_TWO) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			nvm_version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
 			status = E1000_SUCCESS;
 			break;
 		}
@@ -514,7 +514,7 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 		else if ((((*record & E1000_INVM_VER_FIELD_ONE) == 0) &&
 			 ((*record & 0x3) == 0)) || (((*record & 0x3) != 0) &&
 			 (i != 1))) {
-			version = (*next_record & E1000_INVM_VER_FIELD_TWO)
+			nvm_version = (*next_record & E1000_INVM_VER_FIELD_TWO)
 				  >> 13;
 			status = E1000_SUCCESS;
 			break;
@@ -525,16 +525,16 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 		 */
 		else if (((*record & E1000_INVM_VER_FIELD_TWO) == 0) &&
 			 ((*record & 0x3) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			nvm_version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
 			status = E1000_SUCCESS;
 			break;
 		}
 	}
 
 	if (status == E1000_SUCCESS) {
-		invm_ver->invm_major = (version & E1000_INVM_MAJOR_MASK)
+		invm_ver->invm_major = (nvm_version & E1000_INVM_MAJOR_MASK)
 					>> E1000_INVM_MAJOR_SHIFT;
-		invm_ver->invm_minor = version & E1000_INVM_MINOR_MASK;
+		invm_ver->invm_minor = nvm_version & E1000_INVM_MINOR_MASK;
 	}
 	/* Read Image Type */
 	for (i = 1; i < invm_blocks; i++) {
-- 
2.43.5

