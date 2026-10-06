Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FBCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3D7A40E2E;
	Tue,  6 Oct 2026 04:31:06 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 53AE440E2D
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:05 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e2e0bc619fso26362035ad.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253864; x=1791858664; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ODNlNFb7ZAI+UzK2MMgb6dPVPalH+S4gxsrt/2hQyr8=;
 b=bQHUccK5kFZVe4tiU+F+K5ObATVhfbQOzs9TNVp4SppgS114IvfVWKiXGkjSc5emOI
 ZnMgwYJiNP2Je3q09MNrtafwOPz0ReBy5t9IYpSum9TiRL+VYo9JY+9JVmz7+1/jyWeX
 wfAq9IYjsJQlPK9BFX/5xVOQLbVONaRZ0aN0ADFRruNMOOt64x9c1/PTSo68WhTXu9Qd
 wt6noSbwqhaO2GLRYofIJF5wJCqsFQssJJIgqH7l9H4O+tXDha14EsKOIjd83HLn42hU
 scpnqJMAvjCnqy4mepY4DFzUpLODLJ81iSqot/CxGuRv9/I63bOeS1CSEFxN17ivB3pm
 IswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253864; x=1791858664;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ODNlNFb7ZAI+UzK2MMgb6dPVPalH+S4gxsrt/2hQyr8=;
 b=fipxwcrYNYPi6BWcFh8Hbdpve8U0XBNLjzCOzc/A2+osRxTQJLJkovhZtTmWy2kjRh
 /Sn2xN2EHWYTzC7RcP+MywjOfkjoRwcLlZvSCBGk1Q2d5hX6A4ew3i+Tjb0Ip4n6KzQh
 WDIQ7ZZpDCLC8h1NZAkpd49C/Md3KzwU/2t0rQbZ6tJP1qbVWhMzrjSCCl0HT7n7P6e1
 CDn0UnrxFFkAl9XCrQ2X7IzGYlcmulHdChZc5Y0trXTf1FDN+rX/mZSSkeRFVAEuC54q
 Iww6zErtmh12oM5Lxaqwr78q2FZVEHbBST4bnfFUWFtEw3DLynUh2gwtOterd7eOPy85
 fQag==
X-Gm-Message-State: AFq9FYIXvMtgMFRKfAsa/jH8YyXd2foCw/Ck+L/YXqZ+CM8tedUVGZmV
 9s8V99i0SVWZPijP6d+n3y0CcEU3C0BC9BY9+yDyzo6X4qjEiFjg7TP1uM7jwu04hD7mTLe9pKG
 2Q1r7d9RN96cNVg==
X-Received: from plfu6.prod.google.com ([2002:a17:902:e5c6:b0:2e4:94af:d714])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aeb:b0:2dd:8639:9931 with SMTP id
 d9443c01a7336-2e4ea1bed2dmr82848545ad.19.1791253864256; 
 Mon, 05 Oct 2026 19:31:04 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:41 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-6-joshwash@google.com>
Subject: [PATCH v4 05/15] net/qede: use common division round up macro
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
Changes in v4:
  - Add rte_common.h include.
Changes in v3:
  - Leave call sites in base/ alone and map DIV_ROUND_UP to
    RTE_DIV_ROUND_UP in bcm_osal.h.
  - Drop line rewraps.
---
 drivers/net/qede/base/bcm_osal.h |  2 +-
 drivers/net/qede/qede_debug.c    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/qede/base/bcm_osal.h b/drivers/net/qede/base/bcm_osal.h
index 357981f63d..7bcd2d1e32 100644
--- a/drivers/net/qede/base/bcm_osal.h
+++ b/drivers/net/qede/base/bcm_osal.h
@@ -11,6 +11,7 @@
 #include <pthread.h>
 #include <time.h>
 
+#include <rte_common.h>
 #include <rte_bitops.h>
 #include <rte_branch_prediction.h>
 #include <rte_byteorder.h>
@@ -396,7 +397,6 @@ int qede_save_fw_dump(uint16_t port_id);
 
 /* Utility functions */
 
-#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DIV_ROUND_UP(size, to_what) RTE_DIV_ROUND_UP(size, to_what)
 #define RTE_ROUNDUP(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define ROUNDUP(value, to_what) RTE_ROUNDUP((value), (to_what))
diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index d14ef93a3c..9e1f19ad96 100644
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
@@ -3053,7 +3053,7 @@ static u32 qed_grc_dump_big_ram(struct ecore_hwfn *p_hwfn,
 		return offset + ram_size;
 
 	/* Dump Big RAM */
-	for (i = 0; i < DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
+	for (i = 0; i < RTE_DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
 	     i++) {
 		u32 addr, len;
 
@@ -4154,8 +4154,8 @@ static enum dbg_status qed_mcp_trace_dump(struct ecore_hwfn *p_hwfn,
 
 	/* Find trace data size */
 	trace_data_size_dwords =
-	    DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
-			 BYTES_IN_DWORD);
+	    RTE_DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
+			     BYTES_IN_DWORD);
 
 	/* Dump trace data section header and param */
 	offset += qed_dump_section_hdr(dump_buf + offset,
@@ -4810,10 +4810,10 @@ static u32 qed_ilt_dump(struct ecore_hwfn *p_hwfn,
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
2.56.0.rc1.315.gc6ed9934b7-goog

