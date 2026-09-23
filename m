Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07415C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EC7942EB1;
	Wed, 23 Sep 2026 03:07:56 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 8BAF942EA3
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:53 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso4521045ad.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125673; x=1790730473; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zcloIExdz0LcRDAcfFqw5d23W5GWRpOmLo35JjgywXY=;
 b=mKMjhtcTNBwL3LWQ6CHEHVhriBOO+FTEeNJPFo5iGQF+lSwRwBmsaT/Z8xxOY/sxUE
 yqyr7afzijh2aSQmzUWGPnXdt1DA7orcx0REHF8LH/sm7FOW1RQqf5MN9MQfW3ZdsqIl
 hUpR9U6VEo0jyqoYWNdVTLxTCt6MOMrAIDFAxrwzMEVMOOhv5nm9vQtqArU0w40m/j3s
 VGQT0QRU7+qrZ/3vsvYKBVnJh3++UP9eEGKwPnQVAe2JpC+tF27m+HZvRwc5Fh/yK1AS
 Uxz3jVonAN6tTpt2qtKAyA/oY0BM6qT2LH2IM/F6IWnbrpv0a0HiAU9lC9UMbsaJhZRX
 L56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125673; x=1790730473;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcloIExdz0LcRDAcfFqw5d23W5GWRpOmLo35JjgywXY=;
 b=VJMuvTA5FBOfYe2iImGsoUcVIPNpciyRXMVKUwc0/DFSUngPMDi2Nn7Zi5Y2R4yyNu
 96eXvKHKzn32b95PDAXxavSYoMdomojU+JPPzd8kTmwit2qudM0DnwusvXmFPSb+RGmQ
 USg9FHflsCJBc1gKV+w7TTnGC8IxyJetH1Fus2czuNoKex4siYtX1afd4amGhOmZzWJF
 4O/TylmatsqbeA0rardGDYH+OrQIbLrGj04tKI2+j0b4KWtTH3f6kaHd03ULfSTpJUeR
 WGW0pZFYBIAOu44UbnjHqlFuV2injCdcKWnIiUTvKNhhCNUfXUtnFKm6kkF7fEcE7L/c
 zdXg==
X-Gm-Message-State: AFuF++lScIb4H6hnw3dIBmLzbIRiXRrq8bIR4Kr1V1jnKneL4odLPWJG
 yLmdsdLFKfVJBQjxmYGvMD5MZOW+53686Uus//wyPZukAav6Pgy3AUHUessABWpFmQC5D2BNPbX
 heNmyid+ZQYlU2A==
X-Received: from plpp18.prod.google.com ([2002:a17:902:c712:b0:2df:474d:a5c7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b04:b0:2dd:c100:425a with SMTP id
 d9443c01a7336-2df69e0cc6dmr8411475ad.62.1790125672433; 
 Tue, 22 Sep 2026 18:07:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:28 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-6-joshwash@google.com>
Subject: [PATCH v3 05/16] net/qede: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP and
RTE_DIV_ROUND_UP definitions redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - Leave call sites in base/ alone and map DIV_ROUND_UP to
    RTE_DIV_ROUND_UP in bcm_osal.h.
  - Drop line rewraps.
---
 drivers/net/qede/base/bcm_osal.h |  1 -
 drivers/net/qede/qede_debug.c    | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/qede/base/bcm_osal.h b/drivers/net/qede/base/bcm_osal.h
index 357981f63d..7c47a8f614 100644
--- a/drivers/net/qede/base/bcm_osal.h
+++ b/drivers/net/qede/base/bcm_osal.h
@@ -396,7 +396,6 @@ int qede_save_fw_dump(uint16_t port_id);
 
 /* Utility functions */
 
-#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DIV_ROUND_UP(size, to_what) RTE_DIV_ROUND_UP(size, to_what)
 #define RTE_ROUNDUP(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define ROUNDUP(value, to_what) RTE_ROUNDUP((value), (to_what))
diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 1d3147b724..c4cf40b15d 100644
--- a/drivers/net/qede/qede_debug.c
+++ b/drivers/net/qede/qede_debug.c
@@ -332,7 +332,7 @@ struct split_type_defs {
 
 #define BYTES_IN_DWORD			sizeof(u32)
 /* In the macros below, size and offset are specified in bits */
-#define CEIL_DWORDS(size)		DIV_ROUND_UP(size, 32)
+#define CEIL_DWORDS(size)		RTE_DIV_ROUND_UP(size, 32)
 #define FIELD_BIT_OFFSET(type, field)	type ## _ ## field ## _ ## OFFSET
 #define FIELD_BIT_SIZE(type, field)	type ## _ ## field ## _ ## SIZE
 #define FIELD_DWORD_OFFSET(type, field) \
@@ -3060,7 +3060,7 @@ static u32 qed_grc_dump_big_ram(struct ecore_hwfn *p_hwfn,
 		return offset + ram_size;
 
 	/* Dump Big RAM */
-	for (i = 0; i < DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
+	for (i = 0; i < RTE_DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
 	     i++) {
 		u32 addr, len;
 
@@ -4161,8 +4161,8 @@ static enum dbg_status qed_mcp_trace_dump(struct ecore_hwfn *p_hwfn,
 
 	/* Find trace data size */
 	trace_data_size_dwords =
-	    DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
-			 BYTES_IN_DWORD);
+	    RTE_DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
+			     BYTES_IN_DWORD);
 
 	/* Dump trace data section header and param */
 	offset += qed_dump_section_hdr(dump_buf + offset,
@@ -4817,10 +4817,10 @@ static u32 qed_ilt_dump(struct ecore_hwfn *p_hwfn,
 		offset += num_pages * PAGE_MEM_DESC_SIZE_DWORDS;
 	}
 
-	valid_conn_pf_pages = DIV_ROUND_UP(valid_conn_pf_cids,
-					   num_cids_per_page);
-	valid_conn_vf_pages = DIV_ROUND_UP(valid_conn_vf_cids,
-					   num_cids_per_page);
+	valid_conn_pf_pages = RTE_DIV_ROUND_UP(valid_conn_pf_cids,
+					       num_cids_per_page);
+	valid_conn_vf_pages = RTE_DIV_ROUND_UP(valid_conn_vf_cids,
+					       num_cids_per_page);
 
 	/* Dump ILT pages IDs */
 	offset += qed_ilt_dump_pages_section(p_hwfn,
-- 
2.55.0.1082.g2b9226bbc0-goog

