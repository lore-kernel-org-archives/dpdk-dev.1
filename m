Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B1ACD3446
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 09:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5AE40670;
	Thu,  7 May 2026 11:50:54 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 0C8D54066F
 for <dev@dpdk.org>; Thu,  7 May 2026 11:50:54 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48374014a77so7509295e9.3
 for <dev@dpdk.org>; Thu, 07 May 2026 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778147453; x=1778752253; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7fPm5rv3HY+O1xM7vRfdhHVmzrvNFpSqX+nJ/ltryo=;
 b=LCpvaZvuUGFOaxrhDe8+lJ7hMvKy8LBUbfbaPUyF7HYa3Dq1/W89He6/QRdMyZc/k1
 ZntyJHwRbwD0Y7Jf8UU7DuCorT4JE1l0/5MZrPc2iRtCU4ukkqc4Mq2SbA5nlF2YxxAt
 dshR3KrZhTaqou8HHL/C8X19QSru/gJAOiIAqmPBz57L/kRToMmShpXmAMrHKyGRlyT6
 4nXIB50jPEp66cV7HnE+qEV6ukvI4f/tv8am4vWUDIF7VpJLShFyAaxco1YCje1sh9yq
 nhMTtDPaM0FcNera0IHWZYX+SEUmZ2B3DNv4wSujtO8UJ2Yy+iMa/551w3QTpRPHcJqr
 Z8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147453; x=1778752253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7fPm5rv3HY+O1xM7vRfdhHVmzrvNFpSqX+nJ/ltryo=;
 b=nArEOFw8F2/7wosaRdSyQvKNkjdyMcYp7pwY/b4dgfWnIC0V4SlBF2Gv0hMKRxlw6z
 y9s6zA5tUZ4b4smxBN+mGgHlcbZ9ZMZQ10I+E16Bq7VjtVP8gUMJqCphnWlJnQnvB5LO
 XiKk5D5H9oDSdbqUNz3vsIFdUaURvVBkygjk2dZwkHJEoWMJcLD24muJPzx+LtLhknQn
 kQQcCn62bQLnhI5LX/XBcPlE4hwKt2g1qk24IX2/q5jdEPccLCpW1Bkl7sYLZrrud2PX
 380FYBJnjodpmAlwHS9Sp6xptmXXO0BlSr14DgTP1M2n8WPgVpngzIAC7cMfgZN/ZuwY
 f7+g==
X-Gm-Message-State: AOJu0YxGmmF1YCgdP5RJ+XE3uvGwqrLXj8wOp7IJbqLyh8BkVSkVabtM
 9Zfap0BCSGUI9VqBFxF7ZZIzhQFf7ZJQFJyKEIcIVPegzozwRpujRu9a
X-Gm-Gg: AeBDiesRBKsjD2GD4HOTpJuH3XvWhXUHOBcXmUL3EkkLzEgc3X+CkV6nO/J18xTjZmy
 o7NinAH6OLXuqdTwX+pOjx+Nhpu/Xnsi4iF5brTHz6X7KvmP3lvvygBbYNvD+YFR6QWl+UWVUvJ
 GKLLAvYEXvssVTnea/sJCmwH7w76f59bK1hZFLJreLd+sHWETRYVROc4FXKuN/9vOrngaBm8Igz
 uhPjPIAbLE0eiV/YsTnsV1RyrXtKXc5zPd9UrJwZD9W+T4kHvXRC6TgnbJn70ybh4+4Db8/fZvy
 SiRKohCF43vATtCu8kpf4tjfzqhwmpn3nPgEEGAwDTeTibzQH8l96y/e/hoLALb6oO4xMPcvgvm
 wkCiZLuuYQtgTt6/mxdctXPhyxzmovZ+e0JYf82CuDfKC4WWYJvetevNiHommGXkZ4AuL98H0mz
 X3a/6mj6caqchL34r7gQ61elbIRKhRsgnfMAwnQKTC40NOaQ8byEXihzhEeZTsBCc=
X-Received: by 2002:a05:600c:c494:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48e51f41be6mr112929035e9.25.1778147453412; 
 Thu, 07 May 2026 02:50:53 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052483166sm18295273f8f.7.2026.05.07.02.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:50:52 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 3/3] fib: drop redundant tbl8 reservation counter
Date: Thu,  7 May 2026 11:50:43 +0200
Message-ID: <f0f08a796e1554f9cfa58bd94ad5deb7e732098d.1778146229.git.maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778146229.git.maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
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

In dir24_8, rsvd_tbl8s mirrors cur_tbl8s: both are bumped when
depth > 24 and no /24+ cover exists, and decremented under the
same condition. Removing rsvd_tbl8s leaves cur_tbl8s as the
single source of truth for the pre-check.

Move the DQ reclaim retry from tbl8_alloc() into the pre-check,
mirroring the layout used by the trie path. Behavior is unchanged
for non-DQ modes; in DQ mode the pre-check now performs the
reclaim that the in-allocator retry used to perform.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/dir24_8.c | 31 ++++++++++---------------------
 lib/fib/dir24_8.h |  1 -
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427..80215b93b0 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -207,12 +207,6 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	uint8_t	*tbl8_ptr;
 
 	tbl8_idx = tbl8_get_idx(dp);
-
-	/* If there are no tbl8 groups try to reclaim one. */
-	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
-			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get_idx(dp);
-
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = (uint8_t *)dp->tbl8 +
@@ -504,9 +498,14 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
 				RTE_RIB_GET_NXT_COVER);
 			if ((tmp == NULL) &&
-				(dp->rsvd_tbl8s >= dp->number_tbl8s))
-				return -ENOSPC;
-
+			    (dp->cur_tbl8s >= dp->number_tbl8s)) {
+				/* Reclaim deferred tbl8s before failing. */
+				if (dp->dq != NULL)
+					rte_rcu_qsbr_dq_reclaim(dp->dq, 1,
+						NULL, NULL, NULL);
+				if (dp->cur_tbl8s >= dp->number_tbl8s)
+					return -ENOSPC;
+			}
 		}
 		node = rte_rib_insert(rib, ip, depth);
 		if (node == NULL)
@@ -516,16 +515,13 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 		if (parent != NULL) {
 			rte_rib_get_nh(parent, &par_nh);
 			if (par_nh == next_hop)
-				goto successfully_added;
+				return 0;
 		}
 		ret = modify_fib(dp, rib, ip, depth, next_hop);
 		if (ret != 0) {
 			rte_rib_remove(rib, ip, depth);
 			return ret;
 		}
-successfully_added:
-		if ((depth > 24) && (tmp == NULL))
-			dp->rsvd_tbl8s++;
 		return 0;
 	case RTE_FIB_DEL:
 		if (node == NULL)
@@ -539,15 +535,8 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 				ret = modify_fib(dp, rib, ip, depth, par_nh);
 		} else
 			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
-		if (ret == 0) {
+		if (ret == 0)
 			rte_rib_remove(rib, ip, depth);
-			if (depth > 24) {
-				tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
-					RTE_RIB_GET_NXT_COVER);
-				if (tmp == NULL)
-					dp->rsvd_tbl8s--;
-			}
-		}
 		return ret;
 	default:
 		break;
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..502540173c 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -30,7 +30,6 @@
 
 struct dir24_8_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
-	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
 	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
 	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	/* RCU config. */
-- 
2.43.0

