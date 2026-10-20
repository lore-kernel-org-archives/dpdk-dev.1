Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71E606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMHEzOZx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6504F40264;
	Thu, 22 Oct 2026 09:36:19 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id D4326402CE
 for <dev@dpdk.org>; Tue, 20 Oct 2026 21:43:52 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-93e503815adso1290185a.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792525432; x=1793130232; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=om2EHJqDf2OlP6hUOpOmlHkzuzaftJeN+FWJoETTbII=;
 b=YMHEzOZx5NgV7bpUyQPRMCo7BrBf3pzQfASYjVSP2r7Lf0cc4QUbkuqEeSElz5M6HL
 2rsBGRnPMbHOGzNQ8J0Jern85y35czbbhCq4msFg08DJ2CXJ4NMHjhdfMnD1gkVFVPlR
 dYpRB8Je3Rep9BRUnrKDnRRKXMPh4vU5RSwL89cAvQrJfujN3VZWaW9pVYu8kjHRp85T
 hvhNy65n9FRGvUVAzN3SPcr8RCLwLpsD7pGjzknbflvHQKOOIQ6405jCKOGl7/JTcIaU
 nEK53aRqlh0LlzCDoE/3e6DIIPnp9INsJ+1eqHVRbHHcqwGF6fdCAYmpVqyPDGLoJDlD
 4GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792525432; x=1793130232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=om2EHJqDf2OlP6hUOpOmlHkzuzaftJeN+FWJoETTbII=;
 b=0zuxltxAKpZBwIEm3hnS9bPA2hViMGOrNO7Odt97kmqAknUDJWoWTJsSh6Ne0KJzuz
 eYkNJGdySebL6yJ/76dH4NZW1RyRz4zP+dwxCwk+qKhJBzZ7XfRUsCalpx6Il6z+xMj1
 lLr/pjDZCNj4fdLblTQgLdDU/2f/ztJCl2XugSgTfBSUpYFMXJTDkOqukuaS04Y5NgZ1
 HCzm3vjp/6GARu07fvt1jQWHa6qF1SHxi4ce/NmxRjxMfjugdy4DfY1ZwnarQ9Sgkyqs
 TZc1lUr5r3IwFtds/LBHApaRZfgxJAkkOuxrity0fL04dsNbD8UHfy8l+Y3gqoeP90Jk
 uLYg==
X-Gm-Message-State: AFq9FYJmU1YIYKSY4vXLfxif3KKSis1wGVgmmVa6AMhdvjtOOra6ghU4
 pg77b0mSf3EWUh7PCXmVs5vdtPJ0+oEwZTgL8VSJpVM73TC1LtHNZtj0PUH8Ix9Y
X-Gm-Gg: AYBFou1u8eEeq+IzbIRWSr1Q6K+1HfuFMPmgUgaZM2IjQikO/7LA8g3Nxhc6WZNDl9C
 m8ja+GNtkfXtyR7AC0a/kk46LJocl/s6ZeWaoZP4pQ0oFViQzGm3jJApCxA5UHzvdtMdJbNSaAB
 GwZ03eRxvOF28rRc/lehln2AuCTUG9enhZUeQFo9RRDp8Wsiz03e3pn0+H0VfDT6GoE4gkcWh1Y
 mOYPKc3C2PLKysG0YKi1YuBeQT3KHv5qrRnrPnydGZ7ReV2QkiUrrnsuy1dwhiZHKnbkhkbPtd8
 gtOZbDXxcLyuiRnxF36iWVblT3qQKXJeNYaKQhMxN5lozAtTKRAOIm6q22GKrLUkNOjMrTm9w9W
 xK8CqPgFkJbHlZidSETCFziLkGOL1jEeWBky9xPvJmxlCl+5G5Eeiq72jOyfB2ue4FIVtsUhLAa
 CxK7xdJRoiEqD648Pmbf7MfOyehCwYTn2IiPMFTnFkAS+ghn4SoC0wp9NR5ctjy2Qow2aMfsrY2
 fbMFwTAnU4oqCEGlCBJZFx+ofkO3ht9geoJ1xE7AST2aRIp6Aofbh5RPaS987dMrZtxE/UMrHxx
 JnsQCAKbuXlTlFvViOYeQf7b2fUvyJYsQOYLoCWhBXZKD3Y=
X-Received: by 2002:a05:620a:4398:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-93f5803fd22mr46372885a.82.1792525432023; 
 Tue, 20 Oct 2026 12:43:52 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56e1db54sm61292485a.36.2026.10.20.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:43:51 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH] fib6: fix signedness in common root build
Date: Tue, 20 Oct 2026 15:43:06 -0400
Message-Id: <20261020194306.3276949-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:36:18 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

In build_common_root(), get_idx() returns a uint32_t, but the result
was stored in an int. When the high bit was set, the value became
negative and was then sign-extended when passed as the uint64_t index
to get_tbl_p_by_idx(), producing a bogus table pointer.

Make idx and prev_idx unsigned, and use a separate signed tbl8_idx for
the tbl8_alloc() result, since it returns a negative value on error.
Widen to 64 bits before shifting or multiplying so the intermediate
results cannot overflow.

Fixes: c3e12e0f03 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/fib/trie.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 187360d1c8..dc57127dc9 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -317,7 +317,8 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 	void *tbl_ptr = NULL;
 	uint64_t *cur_tbl;
 	uint64_t val;
-	int i, j, idx, prev_idx = 0;
+	uint32_t idx, prev_idx = 0;
+	int i, j, tbl8_idx;
 
 	cur_tbl = dp->tbl24;
 	for (i = 3, j = 0; i <= common_bytes; i++) {
@@ -325,20 +326,20 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 		val = get_tbl_val_by_idx(cur_tbl, idx, dp->nh_sz);
 		tbl_ptr = get_tbl_p_by_idx(cur_tbl, idx, dp->nh_sz);
 		if ((val & TRIE_EXT_ENT) != TRIE_EXT_ENT) {
-			idx = tbl8_alloc(dp, val);
-			if (unlikely(idx < 0))
-				return idx;
-			write_to_dp(tbl_ptr, (idx << 1) |
+			tbl8_idx = tbl8_alloc(dp, val);
+			if (unlikely(tbl8_idx < 0))
+				return tbl8_idx;
+			write_to_dp(tbl_ptr, ((uint64_t)tbl8_idx << 1) |
 				TRIE_EXT_ENT, dp->nh_sz, 1);
-			prev_idx = idx;
+			prev_idx = tbl8_idx;
 		} else
 			prev_idx = val >> 1;
 
 		j = i;
 		cur_tbl = dp->tbl8;
 	}
-	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * TRIE_TBL8_GRP_NUM_ENT,
-		dp->nh_sz);
+	*tbl = get_tbl_p_by_idx(cur_tbl,
+		(uint64_t)prev_idx * TRIE_TBL8_GRP_NUM_ENT, dp->nh_sz);
 	return 0;
 }
 
-- 
2.34.1

