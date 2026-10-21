Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D0606A336
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfnZhYXq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE7C40679;
	Wed, 21 Oct 2026 20:18:57 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 12BC0402D6
 for <dev@dpdk.org>; Wed, 21 Oct 2026 20:18:56 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5367cc15121so13989741cf.0
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792606735; x=1793211535; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vsb5zO/t/QKF7MB5WtEytk6r5/+JrsdDwv3mr6HLJRA=;
 b=mfnZhYXq6XgqFAUTIvEk1ihqwU8N7xG6qj1Xp6f/L6yrsI5MLHFU0wCycYb22CKybe
 17A9L7XEZCj/9IhzvvXAb9g5pfGKVT3ngw5nxxZuixuZRTEf8kT0++ptSQjzzuUwqEOD
 W7b7Djk2FDO5HMugmbMXshgRmSJnzc+7V60JSgim5hPBQ43XPPdXu0rdaW01p9yhl+hV
 MDlpU632eaPAQxVc3qnVTcKQ+h9yyJAt9ULE/3YYEV3uoYw4LnYEwOrttJojZEeyDbfP
 RLfPwQefuF5Cnan21pu7nhzGdf4UZApsdHLkaaYRQzO+e2ZiADEDkFD8mfzFDJHqExxl
 V2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606735; x=1793211535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vsb5zO/t/QKF7MB5WtEytk6r5/+JrsdDwv3mr6HLJRA=;
 b=ngqyRb93SPx6GUaHskKr2eCJoyVg6B/7c6qDRV4I3HBFC+J7j0J8Qj8wljXViavd2V
 lob7+wnIDLnwUJlH+Q7R/RHZMUbt22ekbs9xnLrAelHtHAWUzhAsKxaRXLuI24EUdT27
 B97umLUc7vyKW6vuP9RFJbJ3koFfJChaKVcJyMXJWWQ3jDlKk/kcgJnPZPgbh+mv5MnT
 w7eLvZy86ThV9iaPWdPZJi80Q02ZvY9NHlZMHL2GNtX3CchU9opNxqvKZUpE0mtlze3G
 +t89lrCXI0Ru5scptVrBs02TVs+UG3YZQUMKnJjuX8lcdwK9Y4YU8gkOYj9oEzC8VqOY
 VqMA==
X-Gm-Message-State: AFq9FYIhrSOucb/2gYRtHsnBBU0mVLByoe9rPf+kwXeL3jyZj7/rSUDZ
 xkaANoeCEJMOsbtDdXG3DWOBIdVbiy5l2PtZxUQM7ZfsJcI3yNlagDgS8+xguZAQ
X-Gm-Gg: AYBFou1Fswtd42W+1uaLSi+wG+WcLBh7SV0fAvWao4Ivg8rN3/IGXq8iHABCo4c7EzD
 ZSDy1Q9V1d0M5SjJKOZ0Xr2UJn7JMTY0OJID/lisU/MlCjvqpgZXcyMgzwINTbtAORs3FwSnrWU
 AvfMgMWvqzcruHNZAwCtR4z765nUsUhLnAoandbCi4ol/rF38QoI+eSmW125sgPVUSlG8E6DCWd
 EtJiP/ib+d2HribGzKYojDv2Zp/2eXrBljCtqWGh3Icxq7+QOQVfLuO5adJMxpYLlXMEF5MWBM3
 5tuAG2BX+Md98PiVZUvYWTXlkLMevbmBvtL6fWs9oS1emptQqrWOeKu3XxT8ydX1lP4+PM2br7G
 EPCrwRzjwoHWPllQAYu/gs4kQRZwNkMjaOUbBsnGf5h3cuZFEUU8+8JlW7Uk6CpC5drIoD9lSkT
 VMF9Cq8E4n1a/0r1YWrIxxGC/zv8xsVPjXRbXvR2gPej2ms2XSlN0c9kCt9OZ6q+Cf4Yc204fo2
 jFAqCfDztRFZpOsitQgaTK3qv/vaKcahNtqvQl4E13aQ7Y9wC1BB9VIWOQNAgtKFTxeW7pIqf6X
 LMSt8SaHMvV4yfFB6D1Lv1ChMZlg9WjDlJkjLXTa1i4zrly59Bcr63boOvDD1fO1FnhN95j20A7
 xqBh2rwhs72EYHfnZYGazEXFRQQc=
X-Received: by 2002:a05:622a:6f13:20b0:535:19f5:e9da with SMTP id
 d75a77b69052e-5369b810113mr32754911cf.30.1792606735357; 
 Wed, 21 Oct 2026 11:18:55 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm5837021cf.6.2026.10.21.11.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:18:54 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v2] fib6: fix sign conversion of tbl8 indexes
Date: Wed, 21 Oct 2026 14:18:48 -0400
Message-Id: <20261021181848.3850548-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021172030.3824657-1-rsanford2@gmail.com>
References: <20261021172030.3824657-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
was stored in an int. Once the tbl8 group index reaches 2^23
(prev_idx * 256 reaches 2^31), the value has its high bit set and
goes negative. It is then sign-extended when converted to the
uint64_t index passed to get_tbl_val_by_idx() and
get_tbl_p_by_idx(), which yields a bogus table pointer.

This was hit in practice: a modified fib6_perf_autotest with 750,000
random /128 routes crashed with SIGSEGV in install_to_dp(), where
build_common_root() is inlined, when tbl8 group 0x800001 was
allocated (after roughly 630,000 to 650,000 routes). The faulting
store went to the table base plus the sign-extended index 0x800000a4
(a negative int), which wrapped to an unmapped address. With this
change the same test runs to completion.

Make idx and prev_idx unsigned, and use a separate signed tbl8_idx
for the tbl8_alloc() result, which returns a negative value on error.

Also cast tbl8_idx to uint64_t before shifting it left, in
build_common_root() and in write_edge(). The shift was done in int,
which can overflow before the result is widened.

The problem is also visible at compile time: GCC's -Wsign-conversion
reports the original get_idx() assignment, without having to build a
table large enough to hit it.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
v2: use a 12-character sha in the Fixes tag.

 lib/fib/trie.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 187360d1c8..95f79e26a5 100644
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
@@ -325,12 +326,12 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
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
+			prev_idx = (uint32_t)tbl8_idx;
 		} else
 			prev_idx = val >> 1;
 
@@ -359,7 +360,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 			tbl8_idx = tbl8_alloc(dp, val);
 			if (tbl8_idx < 0)
 				return tbl8_idx;
-			val = (tbl8_idx << 1)|TRIE_EXT_ENT;
+			val = ((uint64_t)tbl8_idx << 1) | TRIE_EXT_ENT;
 		}
 		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
 			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
-- 
2.34.1

