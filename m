Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A2EF99CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37DF54066E;
	Fri, 13 Feb 2026 20:20:52 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id D4A0F40666
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:50 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so14290425e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010450;
 x=1771615250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCY0YpOPYhbzrddNgjR0uGcO0DeKhMswLqx+KQqfrFk=;
 b=qo6XVZlnkPrh9EpSu3Uln+gi/SYTOzaYtdMNwHn5QtATUH2hZvJlmimGqEVHzpDdDF
 lWCE293jRk6WJmsc3vqiUpg/+IsYgTatJMVi5dvuhRDOa1dD/Nf0vLhF84pXp+QKzqjw
 wyRJH5zn275J5Df9Enf9RSoybeL9N1umhCPAawFcLB0RkuqUvdNlyrgK8wH96vmNJLvu
 7ZM6EP4x3D6j7u4OPTt4I4lsWKD46QgZDx4cU9aMDTJaph+rJpmkhx72dXBcQwYZorrI
 VWUiawrfHeyo7kh70i7FenFVRjnX58raQgtHUZQ5ED2raVda/bihdpLTL4v/s9yL+Lc6
 R4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010450; x=1771615250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCY0YpOPYhbzrddNgjR0uGcO0DeKhMswLqx+KQqfrFk=;
 b=dzu8ZfMMHESH01senF2P2/CSfYkTCM5ejsNjQt3C1g1X5D7CvdnXKahlfYd57nn4pp
 wVYMDTk6sEWc1uyrHgEG7DkbEuKevysTXo1Xdv5ybFEFU056SpUmFx2Yag4wvgDhXsqv
 f1B4eTebtEzChyjJpm8YZGwUHpOoTeimPBorIJF6N1RjnYufjX3s1ozHAHBZXBfnyv+2
 LVjE9dBOtb4EOiNJSqQxvG7mgDrnawwF4dOxED9I29Z7wTiHnXbO3v1xWx+NPJwsKnX2
 YEsPN2XyhtcOoduO4f4c4Qs5SQwYaZAiBQyW/Ue6X5zdtICnr8cdr9vLR+qHysVjrb63
 vgJA==
X-Gm-Message-State: AOJu0Yw5GHGVBcnBeV611thdUWExmVcsLb3GZxeZO510q7r9Jx/PveHb
 Pt9COJv3PhxeDR/XroFtD4bQGxt8JEJ0Ca1ZlE1+wSAetrkTBpMaP/k7DteywvmIcz8IQSZDE5I
 dDAb/
X-Gm-Gg: AZuq6aICXKRRjJ8Gqq14q82WfjDTewvtaH4T88NJ/0Bm8u7ETB1f0aY5bbVOWBZRzfI
 atbNzvQc1GkLbAT7SuzhjIQdodeMHR/meZtyKJZnevW92QPn23SkUUuZpjBodmReQjVEnk8KJeU
 6ad0QVVYiW+b6tjw32WNfrN0qCUCNP+YED6N3oZnYu5rBKSdt1fis91dneRXgWfyFtQ5BJAmN6S
 bm4zVnfDLqFElAFLteTAwvvrqAcS5L/td2L5/BsL5kJelCRY9yDJvWW2p7boKsGbM26w5IlCFud
 ANjVoSZAVdjqk9wsafShipZZqVV+EMGOQZsxQWy8U13OsVJL7p2cAJPxS4whqY9yYO/CJon8K/o
 SCkVL8t00Px0eNcUvNtKYnrBYq/8RHOR6qEeiBNmgQ6ep0D/l4o7FpFsjgwp/I5gyYHknBiTAZk
 XqoES4cAA4tSRkN6+ikf8ZRl6GlQKNAIvw3uuRNhqFsczgpJr7/yQkIE6M+jPBUg==
X-Received: by 2002:a05:600c:4745:b0:47e:e20e:bbbe with SMTP id
 5b1f17b1804b1-48373a4e7dfmr50681475e9.25.1771010450308; 
 Fri, 13 Feb 2026 11:20:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v7 3/7] pcapng: chain additional mbuf when comment exceeds
 tailroom
Date: Fri, 13 Feb 2026 11:18:20 -0800
Message-ID: <20260213192039.221213-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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

When rte_pcapng_copy() is called with a comment, the option data
may not fit in the mbuf's remaining tailroom, causing the append
to fail and the packet to be dropped.

Fix this by allocating and chaining an additional mbuf segment
when rte_pktmbuf_append() fails. This allows comments of any
length (up to UINT16_MAX) to be attached to captured packets.

Fixes: c1abd1e93dbd ("pcapng: support comment in enhanced packet block")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 413e6f1f4a..a2254ba807 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -567,11 +567,26 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strlen(comment));
 
-	/* reserve trailing options and block length */
-	opt = (struct pcapng_option *)
-		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
-	if (unlikely(opt == NULL))
-		goto fail;
+	/*
+	 * Try to put options at the end of this mbuf.
+	 * If not extend the mbuf by adding another segment.
+	 */
+	opt = (struct pcapng_option *)rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
+	if (unlikely(opt == NULL)) {
+		struct rte_mbuf *ml = rte_pktmbuf_alloc(mp);
+
+		if (unlikely(ml == NULL))
+			goto fail;	/* mbuf pool is empty */
+
+		if (unlikely(rte_pktmbuf_chain(mc, ml) != 0)) {
+			rte_pktmbuf_free(ml);
+			goto fail;	/* too many segments in the mbuf */
+		}
+
+		opt = (struct pcapng_option *)rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
+		if (unlikely(opt == NULL))
+			goto fail;	/* additional segment and still no space */
+	}
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
-- 
2.51.0

