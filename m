Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19935C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF98F40A72;
	Wed,  1 Jul 2026 18:21:38 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 33A0E406A2
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:36 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-37e4098e920so550660a91.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922895;
 x=1783527695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KyU0YnqxSGX7YJw9w2a3Tb9GMF3tR5rVB3ahj3FXdo=;
 b=0yf6wpqbcUHmV9TCwM5PAoyvRiw7MUyRT30krZ0ENqcerMPNgRaYfPYa/LELtgY/FX
 WVIXi1G0+iex+remlRLX4b44VVv2KyBWPjqoxwog6Yes5SDkvRK3abWCfZGNiR8YM6eu
 letmR3bf6+bULzdGpT6FsGeQm/PTdxIuMjMfXl44MgfY79Fk+AX6A2RUJt1flMrZQo5F
 wPcWOFxHgv1JH7qLdKHJWwJjC66sxWklBvFaGABkOtxlNSnVB4af/zgpkVqulGfkb9E5
 Hn9ZBK3cTGGzjNzA5iuINk+xekvYQrV73aTlpOmACE2qCoU/70g9pzd32Jf/YLVEUEAc
 c6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922895; x=1783527695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KyU0YnqxSGX7YJw9w2a3Tb9GMF3tR5rVB3ahj3FXdo=;
 b=AwNm9cOTsCyYsQWAtQHmDC72qI2mOcoD4ZKq15e4n5wCcOnlp7QdXD0ifkn9wPIxMT
 QQ4brLvHZ8C/65/e/Q5rsY+D5zaI3KmmSOmxk6qItj3Qwp3Fk7L1TmLKyeAlBVANUtDD
 YYxvjFGuUk2Gf8JKAPl8x3mf3s6paUygvbx32fMeh27NiXiZSR8h9npe5/hOpDTjoN6n
 KUeJ6tt1IWSMaD25rRwUWzNDZuDLrTQLSMmpodxH0V1U9SmYbZ5TBhzlskirmznPd14R
 9XTVCTLD6+GNBZVcZlhi54TR6v4vnmzDSylE0LqG0acch0rEiZuQzMop791cYa5fEW0t
 H5Lw==
X-Gm-Message-State: AOJu0YxopO/mPg3WMfeDTqr4lLvccMW5GE3vSSeY9EqVrnnpWx0e8EHi
 EYqQItJ2Ab6fBP7KEACnI2aC9Bu4uFgiQ1Gkd7d9M2UKpzPsuLQvu1tHcrahToTDW0/1Kqy261m
 nCCpI
X-Gm-Gg: AfdE7cn0tgzhvXX0vpup07P95o4v7HSZVeU+z1v+EgQREyYXFqWS+QNFuAqKuIcDfkx
 3VFhZtbZGoixo7/oJZxShMz3aEWqNpO8FLJSxlUlVbJElz73o/HUNshBWpAc3z3vW9Ot2FyYrEK
 VSADXwQq9BClWT44QMid/lZPvhPbuyu6q73/pFTJAduO4LKXGs0bwXMD+nbkIV06KOLLAPo3i1l
 hiAM5V75+ukT8yqdEoOVo40XA/S2AVvYnwz4WEVOgwAUjCdbs9J7wuPS23N9vpXd6wK+LLV1HFY
 Qz9ROiyDT0JHZ6E/vr9lw2eGKVr3ngIK8TKOr6IVun8K6sDMSUiQNPk75AbfEQLAd1A/W+nfDrN
 JUTRwrpJDsu7W7aWdB478Z84faucUzVE+r9iKjzouyso4z22e8yN0FHQ+bycw/MekfenP5UQNO9
 K38SGz3FCXvuVc61uDYY7LueaUTt2PxXu5Effy3aVNVw3k0CG7lzc=
X-Received: by 2002:a17:90b:264a:b0:37f:9ce0:af35 with SMTP id
 98e67ed59e1d1-380aa227dd0mr1992152a91.32.1782922895296; 
 Wed, 01 Jul 2026 09:21:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 5/8] ip_frag: reject oversized reassembled datagrams
Date: Wed,  1 Jul 2026 09:20:30 -0700
Message-ID: <20260701162127.207318-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

The reassembled total length of a packet must not exceed 65535.
A fragment with a high offset could drive the sum past that,
causing silent truncation since IP payload_len/total_length is 16 bits.

When reassembling a packet the total length should not be allowed
to exceed 65535. A fragment with high offset could drive the sum
past that, causing silent truncation.

A valid datagram never exceeds 65535 bytes, so reject any fragment
whose resulting length would exceed that.
Fold the test into the existing zero-length check.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/rte_ipv4_reassembly.c | 9 +++++++--
 lib/ip_frag/rte_ipv6_reassembly.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_reassembly.c
index 980f7a3b77..727fc58243 100644
--- a/lib/ip_frag/rte_ipv4_reassembly.c
+++ b/lib/ip_frag/rte_ipv4_reassembly.c
@@ -136,8 +136,13 @@ rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
 		tbl->use_entries);
 
-	/* check that fragment length is greater then zero. */
-	if (ip_len <= 0) {
+	/*
+	 * Drop fragments with no payload, and any fragment whose end would
+	 * make the reassembled datagram exceed the maximum IPv4 size. The
+	 * total_length field is 16 bits, so otherwise it is silently
+	 * truncated while the mbuf still holds the full length.
+	 */
+	if (ip_len <= 0 || ip_ofs + ip_len + mb->l3_len > UINT16_MAX) {
 		IP_FRAG_MBUF2DR(dr, mb);
 		return NULL;
 	}
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index b6f623d53b..9aa2f2d08b 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -174,8 +174,13 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
 		tbl->use_entries);
 
-	/* check that fragment length is greater then zero. */
-	if (ip_len <= 0) {
+	/*
+	 * Drop fragments with no payload, and any fragment whose end would
+	 * make the reassembled payload exceed 65535 bytes. The payload_len
+	 * field is 16 bits, so otherwise it is silently truncated while the
+	 * mbuf still holds the full length.
+	 */
+	if (ip_len <= 0 || ip_ofs + ip_len > UINT16_MAX) {
 		IP_FRAG_MBUF2DR(dr, mb);
 		return NULL;
 	}
-- 
2.53.0

