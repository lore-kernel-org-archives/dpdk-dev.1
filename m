Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E1606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gj8vXuu5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B11B8402E3;
	Tue,  3 Nov 2026 01:49:39 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 923584028B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 01:49:38 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-91c7a706b1fso2497636d6.1
 for <dev@dpdk.org>; Mon, 02 Nov 2026 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793666977; x=1794271777; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8cfXilHCEdAliYXijIAcoHktPICmRVdBXoVzNmS8vs=;
 b=Gj8vXuu5Fp463EOo3hzbGLdWskduRd9fPh36tqlnfmPeF1QR4BfLtC0B2KzqCKSyin
 6SMh9W01aOCcMRi9/YAfFf9wxcA++kAeP3fnK2f4b4ZGBKc4Z9DcL7q5vqMow2j6Iedq
 jxo7+BLWf4qbd22J4yKqA1ZgSFiWWl74s9N4jjUnr1sUPk5hCwTirhnPmC4zVtFW/Bpl
 YfWQ6FBsr8KavKwjOC+kzzNhLvqNp/3pRDfQrUQVZL76fHjcmlXotlAiU222pN1iHrW6
 fnoqtq+3y0J1CYcCSolsKZT5jQRx76I5knu2SxZAnTMfkquvlWqAx6KGnsDHDdhPLM6x
 wP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793666977; x=1794271777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S8cfXilHCEdAliYXijIAcoHktPICmRVdBXoVzNmS8vs=;
 b=e+3IjEaJw7j+EC6CrPWijBiuHMYBnec7SoLWBFVpgcIZM9orbc0mLt2LwbWyPDIsXg
 EAj22a/l3FpMqHPtFUTWSFMRss/z2ASnljBojXN6xAJ7N02+ZDZWme/+PUNyALDULy1p
 t/2S4Z8w4tegwS8vh/3lKkDnQawZh96qSyiav1Az6ooZMoih6keOuRmux8haGSeQJ4Au
 DV8GNMtE4AIE/MAUPgjsVP53eqhxh2cuDJ69FtUufk92lLre1vK7mVrYdojc7Q3HXWrZ
 INB2XZaUN1pW6DQg6e+0pbE9GJGUybxAyKzHUjGJQmK0rL6fccIleh9/+fAFYursA8p9
 H+KQ==
X-Gm-Message-State: APuU4Z/xfNQwXXrEwCccGWiB9TjIwO6c6k5Ej6zeH57jUsv0Z4muu9Re
 QRguICYf79WoSAZWog8s6KU5SRn5KrLe3jGLBd4gO3b94Ei3X8eATMCTZi+8lQ==
X-Gm-Gg: AYBFou1tirw6rjLzxSg/lcC+qO55GVQKkQcDMtckcWbm+BiOYzvsgQsrKelPPoDtMhy
 90L3PhkZvPwbit0y8WrXPLn1x4XHzK9MEUbH0lj1xJZlS5XyjSsA1VQkRyWpyqgOOuT5/79OmCG
 tQv/ZyRZeilaj2Nd7pNQbc6HMlRA1XT8GpORj20K0oWTHS/2GInj+IaGcqJjoVK0e9wz3uC7xew
 xU6go6Dn7+git3n4IGhNgkuK8B/je0Olto2a16ffK8/KTJvRDaBpKVUdPIm0pskfLCrFu8JiGfN
 Afo+GyVOphqoM+moibfdMnhp78MNor3Aw9N+McA7FenttZT7QH+YXFXbEN38xzFaUZ4iC278ZCb
 TOpowXLgtHS1B+LLd8NkR2u/1ptceNPbu+BWHWOKimDysaOT36BjQ1o9W82uHTw1RhX1BcP3xuX
 O/gRkac3H63r0JvDv99Z9q+flBOBHDLCHTvuv33enM2dfODap9EJMJltezS0OuLOyiP074a8joh
 h0ZE+fBXPc65ZMPD6yn5w4iX/BK6JcPXqqq1XtpXJ35WnQXRkdrNxnJAagBsCU6dzVKyxfYA+Ev
 K1weQqgj2/Y3GW9W3/CrUGquxSUxArOWgdno0A3k+N7G06bokWPI4Zu1OeoH/WRi9yf/GY0+p2B
 oGLpWbo2BhEQPLOdZZcxOMJ4TzkEyeW64MOniDvO40vH0GrqkiJMcAPnqZbf7JC/N37kuaU0laq
 zm
X-Received: by 2002:a05:6214:4a90:b0:917:a7a5:af08 with SMTP id
 6a1803df08f44-91c907427c1mr227060156d6.25.1793666977298; 
 Mon, 02 Nov 2026 16:49:37 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f3db1asm106463006d6.16.2026.11.02.16.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 16:49:36 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v3] fib6: fix overflow of tbl8 indexes
Date: Mon,  2 Nov 2026 19:49:03 -0500
Message-Id: <20261103004903.3616661-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5f260c1a-3f03-4e7d-aa38-15b8d6cdaeff@intel.com>
References: <5f260c1a-3f03-4e7d-aa38-15b8d6cdaeff@intel.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

The trie keeps the index of an entry in the tbl8 array, the tbl8 group
number times 256 plus one address byte, in 32-bit variables in several
places. This breaks large tables in two steps.

In build_common_root(), the index returned by get_idx() was stored in
an int. Once the tbl8 group number reaches 2^23, the value goes negative
and is sign-extended when converted to the uint64_t index passed to
get_tbl_p_by_idx(), which yields a bogus table pointer. With random /128
routes and 4-byte next hops, adding routes crashes with SIGSEGV in
install_to_dp() after about 640,000 routes.

From tbl8 group 2^24 on, the index no longer fits in 32 bits:
get_idx() computes it in 64 bits but returns a uint32_t, and
get_tbl_val_by_idx() and get_tbl_pos() take a uint32_t. The truncated
index points 2^24 groups too low, so routes are written into the wrong
tbl8 group and the add still returns 0. In a test with 1,360,000 random
/128 routes (17.6M tbl8 groups), every route added after tbl8 group 2^24
was allocated returned the default next hop on lookup, and deleting all
routes left 853,337 tbl8 groups allocated.

Use uint64_t for the tbl8 entry indexes in get_idx(),
build_common_root(), install_to_dp(), get_tbl_val_by_idx(),
get_tbl_pos() and get_psd_idx(). Keep a separate signed tbl8_idx for
the tbl8_alloc() result, which is negative on error, and cast it to
uint64_t before shifting it left, in build_common_root() and in
write_edge(). The shift was done in int, which can overflow before the
result is widened.

The tbl8 group number itself stays an int, as returned by tbl8_alloc().
trie_create() already limits num_tbl8 to 2^31 - 1 with 4-byte next
hops, and to 2^15 - 1 with 2-byte next hops, which cannot reach either
problem above.

With this change, the same test passes: every lookup returns the right
next hop, and no tbl8 group is left after deleting all routes.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
v3:
- Also widen the indexes in get_idx(), get_tbl_val_by_idx(),
  get_tbl_pos(), get_psd_idx() and install_to_dp(), so tables with
  2^24 or more tbl8 groups work too (suggested by Vladimir Medvedkin).
- Change the title, since the fix now covers more than the sign conversion.
- Rebase on 26.11-rc2.
v2: use a 12-character sha in the Fixes tag.

 lib/fib/trie.c | 23 ++++++++++++-----------
 lib/fib/trie.h |  8 ++++----
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 9ede1a5bf7..4346789972 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -257,8 +257,8 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 }
 
 #define BYTE_SIZE	8
-static inline uint32_t
-get_idx(const struct rte_ipv6_addr *ip, uint32_t prev_idx, int bytes, int first_byte)
+static inline uint64_t
+get_idx(const struct rte_ipv6_addr *ip, uint64_t prev_idx, int bytes, int first_byte)
 {
 	int i;
 	uint32_t idx = 0;
@@ -319,7 +319,8 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 	void *tbl_ptr = NULL;
 	uint64_t *cur_tbl;
 	uint64_t val;
-	int i, j, idx, prev_idx = 0;
+	uint64_t idx, prev_idx = 0;
+	int i, j, tbl8_idx;
 
 	cur_tbl = dp->tbl24;
 	for (i = 3, j = 0; i <= common_bytes; i++) {
@@ -327,12 +328,12 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
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
+			prev_idx = (uint64_t)tbl8_idx;
 		} else
 			prev_idx = val >> 1;
 
@@ -361,7 +362,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 			tbl8_idx = tbl8_alloc(dp, val);
 			if (tbl8_idx < 0)
 				return tbl8_idx;
-			val = (tbl8_idx << 1)|TRIE_EXT_ENT;
+			val = ((uint64_t)tbl8_idx << 1) | TRIE_EXT_ENT;
 		}
 		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
 			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
@@ -448,8 +449,8 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 	uint8_t first_byte_idx = (common_bytes < 3) ? 0 : common_bytes;
 	uint8_t first_idx_len = (common_bytes < 3) ? 3 : 1;
 
-	uint32_t left_idx = get_idx(ledge, 0, first_idx_len, first_byte_idx);
-	uint32_t right_idx = get_idx(&redge, 0, first_idx_len, first_byte_idx);
+	uint64_t left_idx = get_idx(ledge, 0, first_idx_len, first_byte_idx);
+	uint64_t right_idx = get_idx(&redge, 0, first_idx_len, first_byte_idx);
 
 	ent = get_tbl_p_by_idx(common_root_tbl, left_idx, dp->nh_sz);
 	ret = write_edge(dp, &ledge->a[first_tbl8_byte + !(common_bytes < 3)],
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index c34cc2c057..e0f53e0c47 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -80,19 +80,19 @@ lookup_msk(uint8_t nh_sz)
 }
 
 static inline uint8_t
-get_psd_idx(uint32_t val, uint8_t nh_sz)
+get_psd_idx(uint64_t val, uint8_t nh_sz)
 {
 	return val & ((1 << (3 - nh_sz)) - 1);
 }
 
-static inline uint32_t
-get_tbl_pos(uint32_t val, uint8_t nh_sz)
+static inline uint64_t
+get_tbl_pos(uint64_t val, uint8_t nh_sz)
 {
 	return val >> (3 - nh_sz);
 }
 
 static inline uint64_t
-get_tbl_val_by_idx(uint64_t *tbl, uint32_t idx, uint8_t nh_sz)
+get_tbl_val_by_idx(uint64_t *tbl, uint64_t idx, uint8_t nh_sz)
 {
 	return ((tbl[get_tbl_pos(idx, nh_sz)] >> (get_psd_idx(idx, nh_sz) *
 		bits_in_nh(nh_sz))) & lookup_msk(nh_sz));
-- 
2.34.1

