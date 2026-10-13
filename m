Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC2CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB0CA4042F;
	Tue, 13 Oct 2026 16:49:48 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id D80A9402A4
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:43:58 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-141395927feso5047384c88.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791888237; x=1792493037; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SysvRlNmpk4rZlbLyTxd8PKwGqmpIhRYa6I87XIAiIA=;
 b=CV3bLK1LNbOhL9jHuUMW1ohYYCQSCVgus1SlY/o12tlJj1oVZOlW42PiMbnqERbv3/
 nb+HHEGt3SQxVC6A5nmjcJ6IYR7P2Jl7IoBp/zBLbiWjZAIziVjaUoPkM3cjCsgW70V8
 9AB5Pj/TiuIoKAkaoWvSNWi7uqeqWKc9uKFiHVlwZDiDw/CFhQ9cJIUyrRKGTeCxpp1A
 H+mq7wMDvi7ARVDIROytKdLp3OmC9hK45CGTbH7zGY7iKT3VbI/yQ92uUR7h79mKY128
 dlqdAJjyQVwaRRvwl+fvwVQSBav5Nw9NMB4iNNrY5rq+VqRHkkZfFHvkAIFQDKwMCYvd
 ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888237; x=1792493037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SysvRlNmpk4rZlbLyTxd8PKwGqmpIhRYa6I87XIAiIA=;
 b=sSh/tr+d5gAhvSO9z/jFHXnayhH8L1Vm4h0WTPhB1+5c5gjCZzDZ9fPJ/EpYXNavpu
 YnUzJFebIugfTDVl9aK2vNUMI+A9YxKfnyvirfnFLdtlSWLC1H3agRaNKfypl8ceX1QG
 PgKJlLR0eyWwsnftkvzJk17K6ehqj6vvlt0T0R7AgQX7mz7EkFSqxP6ZbVHdtEqNjHOF
 frM1z/gmKd+mBbKd5OUy17tFUOcqs0rWUd7ltCAYw5QSfWkKB8ZYfDDv7htFtz+AvNoB
 71dr/vaNOlilOHTywAeIiIe1S/p0qmPAXia/tM6Yhw7LmXB5wmRLNW5mtjqBEwlRqxVw
 KRnA==
X-Gm-Message-State: AFq9FYJbDYB7oDrML2rq/4i44PJsxKDznGh0+KdfUAFco5EpYpQ5cTg/
 BSJHdN+GjRB5fDFvj2NMeej2VPRRUIILzdAarFAJ8vQwtbBzlW+KKxhtdEzRAQ==
X-Gm-Gg: AYBFou1cj5q3h21Plbf1jJ3WljLbhSwLKp56KTzqo6VE+bu31A4Qh+kkX+Z5npX+hbO
 01wgcbH9djYv7YilpJDs80jBKTqlmXxiKcsb7/ZDCSM2begGdHfSPFYZM+JwsiY++N1ot09k5pP
 6bEqX+ulu+F8LMsXao+SUMWOehlsWjxyCSf2hIOyJ951UWLf50jqRoeGKDNhSvGJwDKZ6WMELxH
 6Ul7wHb/rpK3Y0QO2MX19USodZOzCbjqcdbTptO8PvlEJTO/kkXbFGz67fL6QH8NRJ69l6c1uFB
 HsKEehrPh9WoEzaPMGwTn8lDmSAfGM3T7DOz/WFzrFBHftxzg06W8GExWEMXP4EJLa8VIyisNaE
 sCI6IudBPKqizPvc4mThDimKJ0mLnfqNMw42tG5QqO60REphVwnsEILB3N6hQswI9CzdGJdBESt
 kqKG/8LuHYp8QXoj/5NcUIyMhbVNwPpfRn8x0FPURrpVgsYsEtJrxXEbKNBvQlL2BeoTo9Dagu
X-Received: by 2002:a05:7022:e888:b0:166:97d:4579 with SMTP id
 a92af1059eb24-16a5dbfdddamr17311157c88.8.1791888236842; 
 Tue, 13 Oct 2026 03:43:56 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm16695675eec.24.2026.10.13.03.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:43:56 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v2 1/4] net/gve: fix DQO descriptor cleaning loop bound
Date: Tue, 13 Oct 2026 10:43:45 +0000
Message-ID: <20261013104348.714550-2-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104348.714550-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:49:46 +0200
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

In gve_tx_clean_descs_dqo(), the loop condition "while (--nb_descs)"
causes an off-by-one error:
- When nb_descs == 1, --nb_descs decrements to 0 on the first check,
  executing 0 iterations instead of 1.
- When nb_descs == 0, --nb_descs underflows uint16_t to 65535,
  executing 65535 iterations.

Change the condition to "while (nb_descs--)" so that exactly nb_descs
iterations are executed for any input value.

Additionally, in gve_tx_clean_dqo(), handle unrecognized completion
types by breaking from the switch rather than returning immediately,
allowing complq_tail to advance past unknown descriptors rather than
stalling the completion ring at the same entry.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 5c03d3d1a2..c864d722d9 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -108,8 +108,8 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
 		break;
 	default:
-		PMD_DRV_DP_LOG(ERR, "unknown completion type.");
-		return;
+		PMD_DRV_DP_LOG(ERR, "unknown completion type %u", compl_desc->type);
+		break;
 	}
 
 	next++;
@@ -122,7 +122,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 static inline void
 gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
-	while (--nb_descs)
+	while (nb_descs--)
 		gve_tx_clean_dqo(txq);
 }
 
-- 
2.43.0

