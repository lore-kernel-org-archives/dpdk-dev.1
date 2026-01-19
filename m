Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F6DD29C58
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB3440608;
	Mon, 19 Jan 2026 19:20:30 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 6FB1A4064E
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:28 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so7033077a12.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846828;
 x=1769451628; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJwA0E8+xiifU7wcHnofH+IlMZCJScZxFP8jq/rYjDs=;
 b=O150dT2dOabZye37mSTyvocl5BK8pdPGd/1HJ8eyoGsa3oFALMksPdCayhhRG007ft
 A5d4DcPHYMotlwq8G+AnJMryzkx/ubG1ebMpm79VtFTzoIG6Q5nG7lZ7TF0HU8Z1G5fV
 ZEWHc1wZA7nbm6DJq2x27yWcZk23wIb8NjPKqaRXoTChxDj8rQEXhOrBB/SBESVi9Ca6
 hKpV2AXDOsvDe7RYGa6bX8xuApBYzlyYeD/q3XLUu+XG7vy1drKcGYl+JYmRlHnmtF1D
 ddyNqiR1DJElAOAEGxVIPS5Y1eAY6xB8vwpwz/oZPU7D8NjXf5omQXY0m3IbjrK1HB5a
 NlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846828; x=1769451628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJwA0E8+xiifU7wcHnofH+IlMZCJScZxFP8jq/rYjDs=;
 b=TTIEzEDdBAnXXbe0H6/gPKDboQoqkEAxIJjoRiOVa4Cimza8/Eo092M8KmRU1t4G7Z
 WrNgoc3HxLx/h5MGORndRbev9cqwDw8HJy5K6FAU9pc5ito1JIxKgPiYsBkqTz+e/PDu
 7214rDXShBH8z+LQ4KxAKwvKIWreZthhXJLls+594wP0tLeltZ+mp8VaBnqTTfzEIpFV
 2xFOkyhGWhB6yGON5oZmluGuWmhYIxskJDO7Nq9vDdtpoVbCR34RQeH3XHYHfRwX7GBF
 QcQg9JPPAqtEhAUY+afmM1sAACBCRKZDYrD8W7uGJwL1BXpGVaJHVh0BWE1dCbc4gcjq
 LONQ==
X-Gm-Message-State: AOJu0YzLD8z9NesC+1s9i5LlIHBAGczI2mjqjb3b4lR6f/pAIhk6/PdT
 rpUznDGHz/Ge9Fvnh/gOoSfBi7yYqzr31978N+qXRN3wFJJIb6pCVDqndK99XMoLZkzh98mfvZC
 w4ldh
X-Gm-Gg: AZuq6aJL33ShLZmuBSaYKgjYT2qI4vVN0q/5M1x3GEBqC2UXcSK6EumkxfegQeYnyrU
 Z1I8OEZ+WfgqMqxs60iZdbELcRb0z7hwQb084hWCVHElfdHKngji2bi4hLJVBCS+lOSnvMa8Cx9
 ej3VzglfoB9jNy+wEibb33CQIYPwH52MAf45etqUjVbXVL1Yy4KZ7ces5k9V8fOKNMlx/t2Wx9N
 6kSYls0SkMSUlMCnONAckYh9Z1IYgLz9/lCMCGpXZHZLcLmRkcARhanF+XFsCChHWCakQmf3LjF
 Bt/qh+9c+6dk6mdwJwsebrO9V0FXaqBuG3HmJGs2bXiC5zo02ft/8V4YHArIi53Dec2kEXqx7oX
 y6HJ8pmFVdPKOHrhnU5xxKMjfeDKRGuabH+cW9dCbS2dBTq3lvKLe1aZaE0vZmTl0OFa3qFr2eg
 87vWGIhRAHMrqJQD1Z0KHtRZVrF64VaYFopDzuqLc7T74KfeH63Q==
X-Received: by 2002:a05:6402:210a:b0:64b:6e44:2c6c with SMTP id
 4fb4d7f45d1cf-65452ad0a38mr9881745a12.16.1768846827980; 
 Mon, 19 Jan 2026 10:20:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v5 3/5] pcapng: add additional mbuf if space required on copy
Date: Mon, 19 Jan 2026 10:19:01 -0800
Message-ID: <20260119182016.44769-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119182016.44769-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260119182016.44769-1-stephen@networkplumber.org>
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

If comment is passed to rte_pcapng_copy(), additional space
may be needed at the end of the mbuf. To handle this case generate
a segmented mbuf with additional space for the options.

Fixes: c1abd1e93dbd ("pcapng: support comment in enhanced packet block")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 49fac60a3d..7deef7639f 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -566,11 +566,24 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strlen(comment));
 
-	/* reserve trailing options and block length */
+	/*
+	 * Try to put options at the end of this mbuf.
+	 * If not use an mbuf chain.
+	 */
 	opt = (struct pcapng_option *)
 		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
-	if (unlikely(opt == NULL))
-		goto fail;
+	if (unlikely(opt == NULL)) {
+		struct rte_mbuf *ml = rte_pktmbuf_alloc(mp);
+
+		if (unlikely(ml == NULL))
+			goto fail;
+
+		opt = (struct pcapng_option *)rte_pktmbuf_append(ml, optlen + sizeof(uint32_t));
+		if (unlikely(opt == NULL || rte_pktmbuf_chain(mc, ml) != 0)) {
+			rte_pktmbuf_free(ml);
+			goto fail;
+		}
+	}
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
-- 
2.51.0

