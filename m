Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033ACA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2A240E2F;
	Mon,  5 Oct 2026 22:25:30 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 1607D40B99
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:30 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2dd9ec41bc4so2709605ad.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231929; x=1791836729;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ei2roZ5Rs39jHHo+sBAOzQvYKS9zT3stB8tM3otuGp0=;
 b=0ti42U+nqFO+uqFfyqFb66NJFX8gN5e+w0KdhCIE7+L3FdGvXajadfMf0nQw5rkmRU
 EDRmszHJERoQ4voXjdrk50SRAulYQyUl5L6p94jyyoH8FVI8prUGwx1C5VDYdhLvrLVQ
 n511K8sLlT3gUsjVDwounAXTHanBIQJVqwiHi573oj/6lF4MoZQNnkwQ/rA+ucfa7MKs
 wbEElmE2jx7rAlN7ktZUXD6+Jkuj+2ByX9LSWhKiV2+44LybXIILRkMjKgHqgU3/0c0h
 EZdPp95PS/pOaGV6aRrVhmpF/ZOIQ4VYxgefmifgq7hUzfGoKPRXoY7O2/GzWXe9tnbU
 uUzQ==
X-Gm-Message-State: AFq9FYK/POaBWEqGenq5fLyOvh+GV02BJhsCD5a6Jt10Q0AJf/a7Kx/h
 bWiXcdBnMeUCCTlvCufKkbn9pE0wFdsQwt/Ak2yhuJk4h+TlKdJpn7NajePZG4zaNy3+oJBJcIL
 lM5kDxMVeAsnQGhf4tzeYcT7edPgM+IOMsAXArPvn24+27hFGSE26Q6pudjN6JFplnYslpRNW9b
 ocfRr//YJehra9TNWPlGoUUG3CBnmacfbVh2Lkm3QFtpaKf1vqvVqc3fOaYrYUH8PhzWCdfA==
X-Gm-Gg: AYBFou1sMsojaLQQci0F7qqJz1G6MWJVfPTqbzf2Tvqbej5DSA7A/gKWjcZupE5M72i
 5/zRGs/Sk4KF23E7dxoZp0oBwzfhwTV01dke/YLGK2edPlUbQCQfjUTta5Ve3w1ajSUOTC+L/F7
 gYNVMWnrP+XdCQZHyfKtEKB0VbmWvhib1xXoRTv3n0YkJBXiXj7umIJaHFD0LZdVkn1KvL07FNO
 bjz8lYdF3YWRiR3E/bsPWZDaYhfaVjOwbp9et7+W/GZX0W8Ed/oQ47mUMFNeLUJoCpomJ72ezI9
 YvBPRsoHp9BOKG1MgBLytkYvFE9DPC5rRRjVP07tYW3LkiJYoF932EQd9bVijixdiHM8ED8RdXM
 8582N2WhX1jO4mBGa56WPDZwwGxe7362o3Sx6aNNBDAnXIxv/mTLLkHdqRvX5VAnF/Qgu5whxaA
 PY+3ZcDi+atdm2HNy/VGRCbT+U3bi81epKgrcVtg==
X-Received: by 2002:a17:90b:4b8a:b0:3a4:8d74:2ee1 with SMTP id
 98e67ed59e1d1-3a6ce6b4314mr9714210a91.22.1791231928765; 
 Mon, 05 Oct 2026 13:25:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6dcd2753esm2226122a91.1.2026.10.05.13.25.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so49055026d6.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231927; x=1791836727; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ei2roZ5Rs39jHHo+sBAOzQvYKS9zT3stB8tM3otuGp0=;
 b=W73/XwL1Glf05Php2j9i5qStXE3lOGBPdo8FjWfJ1/Hk7rL2QT0QpuArMMrEbvMss7
 hNNfHiyTmt9T2XO39X0ZNwj+t46lPvz6G1u5Gv+TgMWIgBP4Mh0QTbmh21Np5hqvDDej
 lGV3/uDDhMIvOgTLVAP6rlxP1/Ql5tMZV/Irc=
X-Received: by 2002:a05:6214:2527:b0:917:89bc:cce5 with SMTP id
 6a1803df08f44-917c00ca18amr223032076d6.28.1791231927064; 
 Mon, 05 Oct 2026 13:25:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2527:b0:917:89bc:cce5 with SMTP id
 6a1803df08f44-917c00ca18amr223031566d6.28.1791231926397; 
 Mon, 05 Oct 2026 13:25:26 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917d593a20asm95846576d6.2.2026.10.05.13.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joey Zhong <xiaozhen.zhong@broadcom.com>
Subject: [PATCH] net/bnxt: truflow enhance bitalloc utility
Date: Mon,  5 Oct 2026 15:25:23 -0500
Message-Id: <20261005202523.17923-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Joey Zhong <xiaozhen.zhong@broadcom.com>

Add ba_find_prev_inuse() and ba_find_prev_inuse_free(), the
backward-searching counterparts of the existing ba_find_next_inuse()
and ba_find_next_inuse_free(). The new helpers walk the multi-level
bitalloc tree from a given index down towards index 0, using ba_fls()
to locate the highest in-use bit at or below the starting position,
mirroring the forward-search helpers which use ba_ffs() to locate the
lowest in-use bit at or above the starting position.

Signed-off-by: Joey Zhong <xiaozhen.zhong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 .mailmap                            |  1 +
 drivers/net/bnxt/tf_core/bitalloc.c | 81 +++++++++++++++++++++++++++++
 drivers/net/bnxt/tf_core/bitalloc.h | 14 +++++
 3 files changed, 96 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..9763a95d09 100644
--- a/.mailmap
+++ b/.mailmap
@@ -785,6 +785,7 @@ Job Abraham <job.abraham@intel.com>
 Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
 Joel Kavanagh <joel.kavanagh@intel.com>
 Joey Xing <joey.xing@jaguarmicro.com>
+Joey Zhong <xiaozhen.zhong@broadcom.com>
 Johan Faltstrom <johan.faltstrom@netinsight.net>
 Johan Källström <johan.kallstrom@ericsson.com>
 Johan Samuelsson <johan.xb.samuelsson@ericsson.com>
diff --git a/drivers/net/bnxt/tf_core/bitalloc.c b/drivers/net/bnxt/tf_core/bitalloc.c
index 136263b6a4..dc0a2c8834 100644
--- a/drivers/net/bnxt/tf_core/bitalloc.c
+++ b/drivers/net/bnxt/tf_core/bitalloc.c
@@ -470,3 +470,84 @@ ba_find_next_inuse_free(struct bitalloc *pool, int index)
 
 	return ba_find_next_helper(pool, 0, 1, 32, &index, 1);
 }
+
+static int
+ba_find_prev_helper(struct bitalloc *pool,
+		    int              offset,
+		    int              words,
+		    unsigned int     size,
+		    int             *index,
+		    int              free)
+{
+	bitalloc_word_t *storage = &pool->storage[offset];
+	int       loc, r, bottom = 0;
+
+	if (pool->size > size)
+		r = ba_find_prev_helper(pool,
+					offset + words + 1,
+					storage[words],
+					size * 32,
+					index,
+					free);
+	else
+		bottom = 1; /* Bottom of tree */
+
+	loc = (*index % 32);
+	*index = *index / 32;
+
+	if (bottom) {
+		int bit_index = *index * 32;
+
+		loc = ba_fls(~storage[*index] & ((bitalloc_word_t)-1 >> (31 - loc)));
+		if (loc > 0) {
+			loc--;
+			r = (bit_index + loc);
+		} else {
+			/* Loop over array at bottom of tree */
+			r = -1;
+			bit_index -= 32;
+			*index = *index - 1;
+			while (bit_index >= 0) {
+				loc = ba_fls(~storage[*index]);
+
+				if (loc > 0) {
+					loc--;
+					r = (bit_index + loc);
+					break;
+				}
+				bit_index -= 32;
+				*index = *index - 1;
+			}
+		}
+	}
+
+	if (r >= 0 && (free)) {
+		if (bottom)
+			pool->free_count++;
+		storage[*index] |= (1 << loc);
+	}
+
+	return r;
+}
+
+int
+ba_find_prev_inuse(struct bitalloc *pool, int index)
+{
+	if (index < 0 ||
+	    index >= (int)pool->size ||
+	    pool->free_count == pool->size)
+		return -1;
+
+	return ba_find_prev_helper(pool, 0, 1, 32, &index, 0);
+}
+
+int
+ba_find_prev_inuse_free(struct bitalloc *pool, int index)
+{
+	if (index < 0 ||
+	    index >= (int)pool->size ||
+	    pool->free_count == pool->size)
+		return -1;
+
+	return ba_find_prev_helper(pool, 0, 1, 32, &index, 1);
+}
diff --git a/drivers/net/bnxt/tf_core/bitalloc.h b/drivers/net/bnxt/tf_core/bitalloc.h
index bf15cbc87b..6c8e325675 100644
--- a/drivers/net/bnxt/tf_core/bitalloc.h
+++ b/drivers/net/bnxt/tf_core/bitalloc.h
@@ -106,6 +106,20 @@ int ba_find_next_inuse(struct bitalloc *pool, int idx);
  */
 int ba_find_next_inuse_free(struct bitalloc *pool, int idx);
 
+/**
+ * Find prev index that is in use, start checking at index 'idx'
+ *
+ * Returns prev index that is in use on success, or
+ * -1 if no in use index is found
+ */
+int ba_find_prev_inuse(struct bitalloc *pool, int idx);
+
+/**
+ * Variant of ba_find_prev_inuse that also frees the prev in use index,
+ * same return codes as ba_find_prev_inuse
+ */
+int ba_find_prev_inuse_free(struct bitalloc *pool, int idx);
+
 /**
  * Multiple freeing of the same index has no negative side effects,
  * but will return -1.  returns -1 on failure, 0 on success.
-- 
2.31.1

