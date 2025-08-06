Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE66C87FD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:43:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A99F940672;
	Wed,  6 Aug 2025 23:42:40 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 3723740671
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:39 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-459e210bd2dso5136365e9.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516559;
 x=1755121359; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=gh5JzbA52fJwUFGSuHHWer62knXkO6WeXivCl8stwuTnYfcfJ+gpq4Ez0Bc2VcyYAo
 t+v+2XozSVeTPbWf5x2I1jxKlfJ1bgw1egm7tjfllg7WL2uX6dSwo7+yEPEuwXeI+2mo
 VOs66hj0CrDpGs/k336pUz36i2KOCfU5kBW4tHVVmDsMiLaVHX207u52TliOlaGf+tO4
 0uvYVMIf9Mx8D6rqQ1ZTum0Lv1Uma/U38hvBC4l0iR3YSsBugFqcWGM+tEhB/52Sw/2D
 FeUYY1PKH41ePCexodCSeT1bDe8WDd2Ma7nKvQ3IkeAMpHDK9eksUwdE4nGay7j3dM6e
 4Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516559; x=1755121359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=pcL8Gucu5CFa6gojkGpSp1phGLUywX3J+NuM6bk+vt3+jKxoW5DsDGqr2rlr+zuI7/
 qCccuo+34q+eJJNB7dIUxAln8wicEvXkveW/HFnwPdWo4XMkDVkAognBkWjQE0kvEpia
 bqVq2lhT/JQvdXFtAfHlaxV7ajPFKPf32559yEwoxemLIxU5Uaqw7TwC2H/4p/F3e9Rf
 n7Me89Hh1Q6nhVX5rULbQc/AfKXdU4ICpBiUblNkzOkwPuXsi+Kq17kbTzVimJPnn13b
 8auGl3a4EZDoop1fjCIepibGWLW+3q5l5RFjDfn6JONdKDHLEw5UOckvKU1xinSnfKsQ
 Cxcg==
X-Gm-Message-State: AOJu0Yxs47lipm0uN2txqJJIj6fo6nZNIBm5exW0EWstvOLZRf7Socld
 SPWQTjt91OW5JtNHvXluUtWrZySzTpRuq6o/0B7LsaaxokOCCbiJgSYVH//x+U769bYD5DSAlw6
 Xwc+N
X-Gm-Gg: ASbGncvwUb1AqrUXTluDgq1zz4jyyUEsp9Y1hDPJZ+Dgls6bAHFehJ5RPGiFN7Vrdi1
 oZ8vJ2/xlMGpNEA+fVgahCy9Y+eUyyQBZOdVz/TVvNISBfgyg7D+uMmEop/fRM/Fwlwe9MYvqKv
 Yhdp+gbYcQAJMPW8fJhzUL/Px/IsPHYQIRObdW9kuMGGIs9c03ORbqT0GCcBV1IrBSXlf1jNvib
 HwNIZou5eZIt8CltkqlWeCXio9QQHXgV2QtzbPesCGTU6mLdCXqzF1y+U7bSkircP11ZQwv7NyW
 39sD5B0vDkSX3haBTHcJP6RQ/bGanaxyNTXFnAoodwWPiBKnj3FaWRvwStK3qRUjm3vxdvM8Dks
 MZo8vhHQGTdbG8LDl0LglGDO9JZM/4bfGMobhyTHcJMErFKas/XIcn3RvGgu1zjOYIrWj3cOg
X-Google-Smtp-Source: AGHT+IHyzPYCptDx0GQbD8DEzdC3/ymTCVLVx4BMPGSNR6+1OQb18QKOQJmMOdflei3breoDFlxrpg==
X-Received: by 2002:a05:600c:188a:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-459ee097f83mr5755005e9.12.1754516558738; 
 Wed, 06 Aug 2025 14:42:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v9 12/13] pcapng: make queue optional
Date: Wed,  6 Aug 2025 14:40:41 -0700
Message-ID: <20250806214200.193029-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

The queue field is optional in pcapng received packet.
Use UINT16_MAX as flag value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 7 ++++---
 lib/pcapng/rte_pcapng.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 6db5d4da50..c27cb9b48e 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -500,8 +500,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 
 	uint16_t optlen = pcapng_optlen(sizeof(flags));
 
-	/* make queue optional? */
-	optlen += pcapng_optlen(sizeof(queue));
+	if (queue != UINT16_MAX)
+		optlen += pcapng_optlen(sizeof(queue));
 
 	/* does packet have valid RSS hash to include */
 	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
@@ -531,7 +531,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
-	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
+	if (queue != UINT16_MAX)
+		opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
 
 	if (rss_hash) {
 		uint8_t hash_opt[5];
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 4914ac9622..48aaab365c 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -135,8 +135,8 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
  * @param m
  *   The mbuf to modify.
  * @param queue
- *   The queue on the Ethernet port where packet was received
- *   or is going to be transmitted.
+ *   The queue on the Ethernet port where packet was received or is going to be transmitted.
+ *   Optional: use UINT16_MAX if not specified.
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param orig_len
-- 
2.47.2

