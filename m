Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6623D1951A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C4B3406FF;
	Mon, 26 Jan 2026 22:06:30 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 10A3A40671
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:06:28 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so12896025e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769461588;
 x=1770066388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGyFr+fUfor+dRVOIPMTfGCw/u8YKQYw6sXchM8MU4Q=;
 b=NcMNSluSih+tpQdtqQ1nYgzjZg3HLa/GOQ+1wfQ9SvgyQLEVRNSeXjo+TDODvbgzSk
 1zVgxuDi7f5bHIQTb7GfoFGj6r4utG7tVGu34lFzzu7b0HB/oY1Vzi7oygVqcKMTeDj0
 W1ncQEUE/J4wTOYTjDWIEwed+CtGQOMoY9P09Z7/ByAT3W0gvS8WPbOXwjAtgu6akPvH
 tnjfzK20kq4XRDM7LyjoBWm509mzlRHmkkSSwMY6imGmGvd7CcsvG4nP8Mvj3ZUd9neE
 hgMV4/v+AHB65FpkNe6cMGNNC/A0hUpPpZ5EJLBUSJvbw5Qqn45Q3po01/CNTmc4ddGc
 ieuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461588; x=1770066388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGyFr+fUfor+dRVOIPMTfGCw/u8YKQYw6sXchM8MU4Q=;
 b=Rs2Y5oXhVDtkPk7Buf8Z+S8EYAXO/+AzH4WfeTrJkPn+GwP9zNQDSDXuvIJqQ8C+p/
 4ry/ZRejNLRAgv2RAajqHjIZYl0Ox6dCLWtecgrhN2xwoF7hKEqKHSw4RI+9+O/e/8NI
 583oA5yy8EBVQsgKO5Wzu+mb8NhfW4c2gpgpsjqPJ2jjRwLkuYQa6/izNkIGR/qBfguH
 /C2/ta6Fh3dsyDfA7pruNokodKlcjP14eokUVgwUI6UHC6CYS8RgonoH0uxn/uhNFu/u
 fi/aICQsdoVNPHi0lb994MTcL4xyBiO2S9i9mqGZYlsXHrKkEn14FrU3RIQJydUFcrfS
 A1+g==
X-Gm-Message-State: AOJu0YwWIMhfjrk8CldcC6l5JtDZ7k1OHjgtnPSwqFxCndj2xoyxa+tH
 3bN4+vVDB/dHYG23yBtcvqY9hdfEU/TTtwaQCsrtafF48CmpYJu1dEGSEJfCCFdNyb1A+Y6IdzJ
 Z5L/1
X-Gm-Gg: AZuq6aKXOQmKSMGMinWuLFAgzThq5iuEO7JBGpxwNm72ft0FCSijdjacMYkLxRwTt21
 XYMy1eY1Z8pyosVe7i2M348NSOcGYwpltGHNr435w2VgP7t8LY3BUpIISrwc8Vokb1yeMkijwL5
 ARLAJDFdevpX8J2nH10wV5gLMTiAkxBn+cpheovFHBWmOiUYjmQgfJ0ZICD8wnM4xdkoYg66i7f
 eFtrtfLE9yQWD1chCUV3CaQOp7C6GpeUeQ5V+8GLB0zPoXwPvLtb890CMH4Lva580a8se+Fvv6h
 c77GZxS8UaEwr9lWuDLg4O9AmX65hTp0WRP6Gnp5mBI2yXvsoASDk3rMQirA3KlqRD0bWLkJOOE
 ItEKZkn5vjno6rU7iycYmGxzAec4PWwt6JttaDiDrUuOR/apVn1lGC+lJDUf7bUtGtS9JB9tur2
 jf+Oi7zMsyHmYsSvjy797zNiuVHt4PO0Rxxx6zfIuQnHdu1aTvCQ==
X-Received: by 2002:a05:600c:190c:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-4805ce67eb4mr89825985e9.19.1769461587835; 
 Mon, 26 Jan 2026 13:06:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm15166915e9.1.2026.01.26.13.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v6 3/5] pcapng: chain additional mbuf when comment exceeds
 tailroom
Date: Mon, 26 Jan 2026 13:04:36 -0800
Message-ID: <20260126210615.175816-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126210615.175816-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260126210615.175816-1-stephen@networkplumber.org>
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
index d5b3a0cd29..b9de51849b 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -570,11 +570,26 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
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

