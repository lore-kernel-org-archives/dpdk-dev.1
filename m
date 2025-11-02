Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB851CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:57:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 139F040613;
	Sun,  2 Nov 2025 16:57:00 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0BF1340430;
 Sun,  2 Nov 2025 16:56:57 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B47C9EC02DB;
 Sun,  2 Nov 2025 10:56:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 10:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1762099016; x=
 1762185416; bh=TUt493zAxFZjeLXvjh6+tB2rXur84zsBM+H/2qiqPV8=; b=m
 SG5hwNflSh6DCdYbju3x3RRYgjUyK2nqAJ8oTnXjQvbqU2Xt5Si/8GcLQgn1Ypbc
 qJ1AJSR2Osljsv0Dy3vsuNA0ADJzjxaF8GqUDLkJQtwBFegQ/yMeZjAtksG8prfc
 6bG6OlbFa9/PtW328VgwxH/ydxs/VjOluwPDRmmlB44kfD3tCHo2tO5m+1pH8hx3
 vlLBCR9eS2Ltjrlg6dR5lZHT2DGhGjRFfMBri2qJxTljAkxDqLZyjSlrOr7d+XGy
 oHqGFwLIU4p8TOzy7EkyeM+SVa+TD6X8PBFOIMIrVa6ASa6ks2mgzD6KBQRpvPl5
 ToIDPjhJP2wgOB7roWzOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762099016; x=1762185416; bh=T
 Ut493zAxFZjeLXvjh6+tB2rXur84zsBM+H/2qiqPV8=; b=SQBJHuhf+f4fB1flh
 BxZQzUNOsO1yWy7ESMT/zRvtW41wXDkx1pnGVvK87RZerqnDbbLT3Up033RzmAy3
 VwfZFzIrdM1eeUE7XVx5+f3j7iMRNMWCWOIWFic09emOZBsGNmxOX7akiQ65NYym
 JtNCnw6yzw1a4K9o7Srji2GPvBPX2Hq65jbEY3AEtkuXn4ZhFvu8UPH1I6XVA5ZH
 afWm6ZMftH66Gnh7JvKFuc12gqO2MNgxipidqOJ2xEZU/mP/pGTAE3D5tul3XdBH
 RaxZECmlLi7I7/9pYQ4rgI4fOCdACbG7J9gSBJPx5yQQhAJk/RFyQRo13S9/5KFY
 AelaQ==
X-ME-Sender: <xms:SH8HaVbboKTtGIYn7jr1xddH0zEtK7DwZ4Hw9B5qFIs_Y7-lB3WQNQ>
 <xme:SH8HaXXGBPSpS3tDcPpPSjAN1cPSncy59IOxkYi-kf_xUwQZ3mcIVbKooWM1tEjh8
 zR2-SJ6cuD4pPJeBP5dWAWXdLxA_cLKqmdiRK49y56uxm1EAgRqXg>
X-ME-Received: <xmr:SH8HaW8UOqgbqt9lJ9UrdV7FkfBubG1_m9u99etCt0mrtC2ZfM4CIN85xBtOWZkuS_NTTbXATBBGADa4CD4fEebIHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepohhrihhkrgesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohephihuvhgrlhgrvhesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepghhgrhhisggsohhnsehnvhhiughirgdrtghomhdprhgtphhtthhopehf
 khgvlhhlhiesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprgguhihpohguohhmrghnse
 hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SH8HaY9xOObsFfIcGsnggHW4Hd_V5O265orgw1Pt1LPx4tH_tXwIXQ>
 <xmx:SH8HaeSvJllOZsvxb2hI-k8UvDQ6yp5zbZuD7iN-dWNHjzxC1N0wwg>
 <xmx:SH8HaUcqXyT-uwM9RZik97nx-or_3dlYQdWq5kQbePT1DZV4bj1ymQ>
 <xmx:SH8HaaCeqc_Q-bCn3dGN-Il3oSErS_IikBoMrjs5E8Fs5Nz81NLiTA>
 <xmx:SH8HaeN-OZfFRLmqaI22URciYllcMEJd3Fwm9DVE-ZpaAHpzOM7CEKVh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 10:56:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Ori Kam <orika@nvidia.com>,
 Yuval Avnery <yuvalav@nvidia.com>, Gerry Gribbon <ggribbon@nvidia.com>,
 Francis Kelly <fkelly@nvidia.com>, Ady Agbarih <adypodoman@gmail.com>
Subject: [PATCH 3/5] regex/mlx5: remove useless constants
Date: Sun,  2 Nov 2025 16:53:02 +0100
Message-ID: <20251102155617.4001783-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102155617.4001783-1-thomas@monjalon.net>
References: <20251102155617.4001783-1-thomas@monjalon.net>
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

All these constants were unused since their introduction:

- MLX5_REGEX_WQE_CTRL_OFFSET
- MLX5_REGEX_RXP_ROF2_LINE_LEN
- MLX5_RXP_BF4_ROF_VERSION_STRING
- MLX5_RXP_CTRL_TYPE_*
- MLX5_RXP_CTRL_JOB_DESC_FLAGS
- MLX5_RXP_CTRL_VALID
- MLX5_RXP_INITIALIZATION_TIMEOUT

This constant became unused after supporting combined rule file:

- MLX5_RXP_POLL_CSR_FOR_VALUE_TIMEOUT

All these constants became unused after removing DB and register R/W:

- MLX5_RXP_MAX_ENGINES
- MLX5_RXP_EM_COUNT
- MLX5_RXP_DB_NOT_ASSIGNED
- MLX5_RXP_CSR_NUM_ENTRIES
- MLX5_RXP_CSR_CTRL_DISABLE_L2C

Fixes: 4d4e245ad637 ("regex/mlx5: support enqueue")
Fixes: f324162e8e77 ("regex/mlx5: support combined rule file")
Fixes: ab74680160ba ("regex/mlx5: support combined ROF file")
Fixes: b34d816363b5 ("regex/mlx5: support rules import")
Fixes: ab2e0b0d3531 ("regex/mlx5: remove register read/write")
Fixes: 9fa82d287f65 ("regex/mlx5: move RXP to CrSpace")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/regex/mlx5/mlx5_regex_fastpath.c |  1 -
 drivers/regex/mlx5/mlx5_rxp.c            |  2 --
 drivers/regex/mlx5/mlx5_rxp.h            | 20 --------------------
 3 files changed, 23 deletions(-)

diff --git a/drivers/regex/mlx5/mlx5_regex_fastpath.c b/drivers/regex/mlx5/mlx5_regex_fastpath.c
index 8e5f8c9c95..6e21574d29 100644
--- a/drivers/regex/mlx5/mlx5_regex_fastpath.c
+++ b/drivers/regex/mlx5/mlx5_regex_fastpath.c
@@ -27,7 +27,6 @@
 #define MLX5_REGEX_MAX_WQE_INDEX 0xffff
 #define MLX5_REGEX_METADATA_SIZE ((size_t)64)
 #define MLX5_REGEX_MAX_OUTPUT (((size_t)1) << 11)
-#define MLX5_REGEX_WQE_CTRL_OFFSET 12
 #define MLX5_REGEX_WQE_METADATA_OFFSET 16
 #define MLX5_REGEX_WQE_GATHER_OFFSET 32
 #define MLX5_REGEX_WQE_SCATTER_OFFSET 48
diff --git a/drivers/regex/mlx5/mlx5_rxp.c b/drivers/regex/mlx5/mlx5_rxp.c
index 7730e11fb1..dda4a7fdb0 100644
--- a/drivers/regex/mlx5/mlx5_rxp.c
+++ b/drivers/regex/mlx5/mlx5_rxp.c
@@ -24,8 +24,6 @@
 #define MLX5_REGEX_MAX_RULES_PER_GROUP UINT32_MAX
 #define MLX5_REGEX_MAX_GROUPS MLX5_RXP_MAX_SUBSETS
 
-#define MLX5_REGEX_RXP_ROF2_LINE_LEN 34
-
 const uint64_t combined_rof_tag = 0xff52544424a52475;
 
 /* Private Declarations */
diff --git a/drivers/regex/mlx5/mlx5_rxp.h b/drivers/regex/mlx5/mlx5_rxp.h
index 08b9a2680b..8ef1541d1a 100644
--- a/drivers/regex/mlx5/mlx5_rxp.h
+++ b/drivers/regex/mlx5/mlx5_rxp.h
@@ -9,27 +9,13 @@
 #define MLX5_RXP_BF3_IDENTIFIER 0x1
 #define MLX5_RXP_MAX_JOB_LENGTH	16384
 #define MLX5_RXP_MAX_SUBSETS 4095
-#define MLX5_RXP_CSR_NUM_ENTRIES 31
 #define MLX5_RXP_BF2_ROF_VERSION_STRING 0x07055254
 #define MLX5_RXP_BF3_ROF_VERSION_STRING 0x00065254
-#define MLX5_RXP_BF4_ROF_VERSION_STRING 0x00075254
-
-#define MLX5_RXP_CTRL_TYPE_MASK	7
-#define MLX5_RXP_CTRL_TYPE_JOB_DESCRIPTOR 0
-#define MLX5_RXP_CTRL_TYPE_RESPONSE_DESCRIPTOR 1
-#define MLX5_RXP_CTRL_TYPE_MEMORY_WRITE	4
-#define MLX5_RXP_CSR_CTRL_DISABLE_L2C (1 << 7)
 
 #define MLX5_RXP_CTRL_JOB_DESC_SOF 0x0010
 #define MLX5_RXP_CTRL_JOB_DESC_EOF 0x0020
 #define MLX5_RXP_CTRL_JOB_DESC_HPM_ENABLE 0x0100
 #define MLX5_RXP_CTRL_JOB_DESC_ANYMATCH_ENABLE 0x0200
-#define MLX5_RXP_CTRL_JOB_DESC_FLAGS (MLX5_RXP_CTRL_JOB_DESC_SOF | \
-				      MLX5_RXP_CTRL_JOB_DESC_EOF | \
-				      MLX5_RXP_CTRL_JOB_DESC_HPM_ENABLE | \
-				      MLX5_RXP_CTRL_JOB_DESC_ANYMATCH_ENABLE)
-
-#define MLX5_RXP_CTRL_VALID 0x8000
 
 #define MLX5_RXP_RESP_STATUS_MAX_PRI_THREADS (1 << 3)
 #define MLX5_RXP_RESP_STATUS_MAX_SEC_THREADS (1 << 4)
@@ -128,12 +114,6 @@ enum mlx5_rxp_program_mode {
 	MLX5_RXP_PRIVATE_PROG_MODE,
 };
 
-#define MLX5_RXP_POLL_CSR_FOR_VALUE_TIMEOUT 3000 /* Poll timeout in ms. */
-#define MLX5_RXP_INITIALIZATION_TIMEOUT 60000 /* Initialize timeout in ms. */
-#define MLX5_RXP_MAX_ENGINES 2u /* Number of RXP engines. */
-#define MLX5_RXP_EM_COUNT 1u /* Extra External Memories to use. */
-#define MLX5_RXP_DB_NOT_ASSIGNED 0xFF
-
 struct mlx5_regex_mkey {
 	struct mlx5dv_devx_umem *umem;
 	struct mlx5_devx_obj *mkey;
-- 
2.51.0

