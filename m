Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A7CE8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67C6B40612;
	Mon, 16 Feb 2026 22:43:22 +0100 (CET)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65]) by mails.dpdk.org (Postfix) with ESMTP id D34A540609
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:20 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-4362197d174so2415779f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278200;
 x=1771883000; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaa+u32Y7tMwxhvZ4w5iZzpc/GsAyf3Ftvlnzr0ugtc=;
 b=xCIzkgaVmkPSyYIs8wbmjSpl9Tcj/yZ2Po31ZqFfsVqZCPvAdLBq5JcY6FcYajRKdh
 UQy63RR6YhUQr4SopTynEZU65VJadtC31CTIhd3Is4CG5okpmJofdAy7tEKKpdGl00Su
 8b+9FhhTjMatWrfBHTnQAuQjc1/vrkEOg6a9Nim64399EInKD93QgRIlkk97DgEmwHPI
 0/sVakX73sinfQCvgiRu4WJerqqJyhFM+6jnOi42g8t+o6C7CQiMHm0yyUlBZfMlaUrD
 1qBBGe2fRj/pRnvv+kfMn4gX8uRTyMJM/THM0TGWsHD5cG28Tl8pYtgJPO0WgAxxEtxF
 n1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278200; x=1771883000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iaa+u32Y7tMwxhvZ4w5iZzpc/GsAyf3Ftvlnzr0ugtc=;
 b=o3YW+VjgFS1rnUMWGr6fETcRcLZMumd/eVWhRfljz0ErxVtAj2L1xUn1BNq0sTsyNY
 MFuW+Q2nVf9xtmLoiigmwki0Ojf0s9lhpU7vxMHoeUCML+opiWTpaBjL26bpBQZ7n1Aj
 12sGjsTguAnW3EH+lom6OUiFIL/+b6TqIg6Qd7d4vp3vFZZqiRiNbpl37LkESAmUCXUf
 tXTrEpl4n4fAZiEG+wgzi+PYmFlAKcFgayez7V4O9A9RkwwNvDxrR3Lat9m2ns8KzeDE
 x+TygWO/D5U5zOswnFdAd5ER959CLqoMRIM7GerNGSQ5PUQjhi0aC+QDiGR4IJAKt1H2
 qXIQ==
X-Gm-Message-State: AOJu0YwUlDoZJAqYUeuzrLZo3o1WlJqIEWetGmtflymC34PdHCUxSWqP
 ecL7l8gcRYavRAPXV0rjFOq0y4UAmu7QcHbPlmMrcNmRUuEBY08C3sxeyl4raj3JxHJT9WehGTE
 aLU0FgEnfsw==
X-Gm-Gg: AZuq6aJgN6RGFstO8rNmOgArjGEkghKZ0o2CkXeTpXba0GzI/8mePOhNVkxy9y8OaXV
 X9q3vxAmuC4avlpFVc9d/dWqpJnSdjzi2QnF/rEYKTLpezRKFxDRRDB+XEmdCYmB0Fg0cc9INJF
 AZK95KHet10yikLDZjjBphJMGP8t8bQ3InNJzUA4IuR0vHFnavGxfXhJZA1zjyFAeL7HQS+Whns
 sDsVBrdf/O1fBGUuhBD4sKlm1t5shCYigGxzi+B2/0CglGLciFYYwVl90g1O3FM1o9r1nS7aZyk
 G6G5yoPBEPo70RPnkv+tQRKjeAo6jZr+e447my/bp0imI/2wdNAiH3i6eG+4h/maS0L4aAn3fRz
 H1G6HfEsknyOoIAKetexL8Il0FiF6WHecRYsVAP/H1e0XJIXTUeUAOp731UWy1tDES1WeHt35vM
 Dc6NaA5OogR5zBYF634VJ1viJOHu4xel1ar6JgLfo90sJYbxDa9O8zd+tmtEwcXA==
X-Received: by 2002:a05:6000:1863:b0:437:6b62:4540 with SMTP id
 ffacd0b85a97d-437978cd231mr22024995f8f.19.1771278200298; 
 Mon, 16 Feb 2026 13:43:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v8 2/8] pcapng: document return values
Date: Mon, 16 Feb 2026 13:37:59 -0800
Message-ID: <20260216214311.717492-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
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

Update the Doxygen comments for rte_pcapng_add_interface()
and rte_pcapng_write_stats() to document return values.

Return values management in this library is not as consistent
as other libraries like ethdev but fixing it would break
API and ABI compatibility.

Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index de1bf953e9..8d0974c3fd 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -89,6 +89,9 @@ rte_pcapng_close(rte_pcapng_t *self);
  * Interfaces must be added to the output file after opening
  * and before any packet record. All ports used in packet capture
  * must be added.
+ *
+ * @return
+ *   number of bytes written to file, -1 on failure
  */
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
@@ -128,7 +131,7 @@ enum rte_pcapng_direction {
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
- *   - NULL if allocation fails.
+ *   - NULL on error such as invalid port or out of memory.
  */
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
@@ -192,7 +195,9 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  * @param comment
  *  Optional comment to add to statistics.
  * @return
- *  number of bytes written to file, -1 on failure to write file
+ *  On success number of bytes written to file,
+ *   -1 on failure to write file (and errno is set)
+ *   - (-EINVAL) if bad parameter.
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

