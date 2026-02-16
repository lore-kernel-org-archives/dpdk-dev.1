Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0969E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 488524065B;
	Mon, 16 Feb 2026 22:43:30 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id BEABC40665
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:27 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so2667293f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278207;
 x=1771883007; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWoWv6d80gBOYTs5BGgftrs0z7gwtkW+9eDgctqm+og=;
 b=AUERbWRDuS4z8BoZK9/rWgFfVr8tA59Bts0aMkfx1+M1TNwO+qalyIV/XGlUm+pf4p
 0P+TgSBjdJ8DMpUJVk0etqQvXAuWS26oPmjdmwrflkwxsmhpOg+M0OJhhM94Np1q3UuX
 f+qMIGZ7tEJcV3YyQ10yo98kn2KF0BTx5qLNaEnAipUbK6LHXkVMIBGBWq8kO0SOLdRq
 gMPBrN+JbdawWtrYN9WKGkL4m80srpVwMdta9wvOH9FEJlXsn7KVj1WP7XA6Uh+ggPJB
 XQ5/MRsUlHjHC5NY1YfnLGjQ9XFjf3TExZgba5ZLIzcuriSiPZ+J4LuGZ+w4iZn27MyR
 nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278207; x=1771883007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWoWv6d80gBOYTs5BGgftrs0z7gwtkW+9eDgctqm+og=;
 b=SfIsLhVtoHIR1FUlfwCxG9wX3MlmlJ6CAxZdYgsRvolu+A3rrNuNcAEJa4EzJ53cJK
 0lBh6vZJyKgVe59vD9YE/ECg7ZW8GnYlGn+3lQsiS5k5nt27Ex4/tKXzfRm02Ud8+CSM
 JH5ckMCqclit7b0epuQTRXuG8rqC1EgXhY5MjeWMycXQI61iMA8z0cFT+UGq2JZmXLme
 i047Z1yLWm0kOvuE5Mwhh7TpyFWDyDluUWuG8rfFd7cSXKKsv+a1g2FXgOkVxqazJJlL
 iq/ggG/4gk2PzDBxoj5VC+B89l9IsOKTIx9ESjblACeCcUFO4Nm9L6BKlV9xZTh7ImAM
 TCqQ==
X-Gm-Message-State: AOJu0Yz4duKMvZ/sc3rO511deyc84PzJjPrOtn4j1xcmzhmv3irljnj/
 cUDDec0lbcssc6KRFalQCyvDmcaa/3yXZ/WSs64USct/lVNRy8Tmr6EE27EPX7FFuZJoaqArX7J
 bf3ILDKU=
X-Gm-Gg: AZuq6aJE41HcHr1paJGbEf99cMiFa8Hs+EpgmXzJYH7VAkH+3Ccl0LlhA5aZluNDuQV
 5xhMkAf170nGCaPTjjJOp54TJPy9mFQQ5rmtXtkWAHZ8+/nBLtESufMtlScdI3ICPr8QyAxMcKI
 2snfrO8vP5UdPezQ8gRoqWhir/5AC6KUAzKQvn9ergmQwLuAajN6EiCdOC/eOJTA23zNmQrFNnQ
 66TSHMVVS4AlhRt7y+JmxNWy9K6Uo0NBN2KAvNi6sI83sDf7AkPQHjbF8Bp4R1qZD1u77CaGWcC
 /6AOCCLa6L+itX98P0a5AVRVhERWXIqKHSYTtD+BfwLQYeO8XuEmtc3szWGXoUDrU1S6q6newWQ
 i8Gz4CeX0yC9o0WOEK5BXurlzWDohxN158Uv/eEDDUGw9p+rB7bObuO2eawMkKeFHEBZfeojqro
 BNPJVrQ+BI/crPX1mXfb6KayLLZxiPbDEAZ8vl5kQKTEpIMuVQ9ms7t2E+NQRrqA==
X-Received: by 2002:a5d:588d:0:b0:437:7710:5204 with SMTP id
 ffacd0b85a97d-43796afa1eemr24473695f8f.53.1771278207199; 
 Mon, 16 Feb 2026 13:43:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v8 5/8] pcapng: chain additional mbuf when comment exceeds
 tailroom
Date: Mon, 16 Feb 2026 13:38:02 -0800
Message-ID: <20260216214311.717492-6-stephen@networkplumber.org>
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
index a5a9a827bb..2cc2ea2f2f 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -567,11 +567,26 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strnlen(comment, PCAPNG_STR_MAX));
 
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

