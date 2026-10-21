Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EB606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ArOXpD+4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D576402B3;
	Wed, 21 Oct 2026 19:20:49 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 14185402B3
 for <dev@dpdk.org>; Wed, 21 Oct 2026 19:20:48 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-53381e53b80so10737601cf.1
 for <dev@dpdk.org>; Wed, 21 Oct 2026 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792603247; x=1793208047; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUUN/2QH6WEBMB13GQDvn9SpkafVsBq+0FGaLMB/pF0=;
 b=ArOXpD+457tAT0iU1pNekx2HcqyGRuy4JhQ/OiVf7IFWJqQEFWa0tb2lQb6t159Ayp
 N7XQB0ozLlSFQW4Bf0sswcO9xBlIwZqTlHB4Wlj2Lv5ETiu7ULFd3ZiHfHFR8cHWrxVn
 TovVbL5XGS5FgvAgWxHTkixCo7XbSRpWQ1FaysE0q+5jNx3VibIgMp9xC7PXzYG/1Bk0
 wRQmYqfjjhfEIPOk9ocjVxwwUKCQGVk5aSD2e/w4CRoO5OdYTyI6TgSCosGo0jZtnGDo
 QsCIDgs69lNJzOWKCHtOg9SCcwrBA5Y+jaZOeRSZUOjjFprL3PlXZGKs1+/gMejBilqo
 vhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792603247; x=1793208047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUUN/2QH6WEBMB13GQDvn9SpkafVsBq+0FGaLMB/pF0=;
 b=PVx8s1KkXuMzVu0MwW9tRZBmmEapdDfiiqx7WZyzaQuCoRh0Qfc6PEK6L4GoqtUL6d
 UdlG03XE121ivqzz8gW7ZxUVjuPEZz80tDoa9BwAxJmYetH6lyoggtn9r/DtwXY2U0cy
 O4Ul07QJo9FdR/w7HfqAaLs9h8qCnoTZln6dIFYib3FTt2GKHvcV1ASnIcdGoVwOw8aY
 zRpaq9GxcZZr9qYpvVPo2llf7iwzv8PYM1FWdJ3bvC6CA11sMO42Jp+psNmAbDkAYRi3
 fn+srYT4iOkxHN/7IaWkdMCygXEqG9Ao39uZ/njjTFci/QsrJT7yQnxyo3NBOmIZAOrd
 J2qg==
X-Gm-Message-State: AFq9FYKwVOLCmDcTLhZ2r2UbDTYId71+LcA7yeOQFcuTyjnsXajYDjZO
 ApKTaa921kKQjlQkl4h6iZKNKZEG5Z/fIoQr0pR23JpugJW/aH1Z4pXpHYJHXwNT
X-Gm-Gg: AYBFou3GT37LDS+J/69SlWoTDF78mXW55Iv7LUCFgpNFn/E2uC357g9gwzLKID7zyZQ
 TJhLycmlPBWtZtutIXlRRFcLve9k1kko27afRf9w+8Cssb2fsxEr1vhcFRNfNK0B0CCBpD5nURw
 Iee9DeW8o2R4WdkI4UBPko6tgyUR/fGmMK/yzz0LuEVZC9ziNSUcPfUs8cSyPzE5Q4bWVz6abuk
 HiuEyJw+gF8AwRRfUheIUG2QJPIvPRdlCDvNkQ+lqfH+TcHG9TEh97nbuP/5zCuPdGMxUxT6E7g
 oEkwzVNNfkjirzaw+sw31CzFskt4f8uDc0p6sMpqZMybWi16Ys1SPpJQJquDn/idN2SHGzRNfNc
 gZzuyZXldOj28516TQcv30nrisS9IU8cYKRgX5UJ3deykbevDXiFjGyJQYwJ9UJ7rKe7tVGyZ3s
 SNEkEgTZ/eLo+WWczrR3+DxI0JPB0m5n+GnsBEDA2jeCqA8QDfeB/gmmYJbeILCJcOvFFg2bhuR
 EAKa4Cb7PGGrLgUZ5bdqfcOL9PSi89/rZvhJKK4u7cdwiIT/AuhNs0pjjNi+OuZE/faCGxbiToz
 Iq5CDQCfinMNvOYnWo8Q4xPEhmwZa1mY7WdvEdzzw5p8xzHUyW20/3Y6HRZZtqwpnqmTGxTzl/J
 i7/2qy8G+CWZjbs4GT3VzdLlfHD5np399j4stwXfktb9QvJrc
X-Received: by 2002:ac8:5d04:0:b0:536:79aa:de06 with SMTP id
 d75a77b69052e-5369b8b48fdmr41401411cf.52.1792603247051; 
 Wed, 21 Oct 2026 10:20:47 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0cdsm4639661cf.8.2026.10.21.10.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:20:45 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v1] fib6: fix sign conversion of tbl8 indexes
Date: Wed, 21 Oct 2026 13:20:30 -0400
Message-Id: <20261021172030.3824657-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Fixes: c3e12e0f03 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
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

