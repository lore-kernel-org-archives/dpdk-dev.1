Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F649C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D0C140659;
	Fri, 20 Feb 2026 06:04:23 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 24A6040608
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:19 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-896f82e5961so23634996d6.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563858;
 x=1772168658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=1RO9gk5Ug+hlQiA7cnmWp+eOoHkpjLM0QCPRh0oa03aGmhfsIgE0QqGtVs9dzIR3v+
 TZ9i5H1b5D1AFXT6K4ElERAl8yGS1juxvZIUY36vlHFUEy9pLBp1OVnT2/jCdMqDIiCE
 1f/TNeJloY3zzls7TBjFGVJ2wGr8OMcAX/qi8FbCdLOK0ZMFiUOF/+oi6IYcrfUk5Mz9
 R5mKOimytICgQXzm67qqKSu5fr7ByjGpaPOS9vmxrsw+US75DBry/rNhgNMqrZ82MDmq
 zVoOwpitpAiD0/IBNQZe7WJXGa6aciZKqfEyjRDA7CSEnFUENlITUE9JG5GuLy8Kju6z
 6LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563858; x=1772168658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=OkUzBtPsSvgQ16bd/Fw/dYxqs/jsM9D6WQfeNbWKslYJ+ykXqdkjnzJbUkicTqgJGo
 suMdJlSW/3DblEs6wTCjY79WKPp0Ad/+hhj+doOVNc762FDXsT+zEYdl5sjWRt8+PNiS
 ovG5ZiEKNMm+9Q8hnTtnQtMNiBaOaM1nJ1z45/s/yCTDth+UkzZQmvlChyKtZou6OE4V
 ue56vm+J93XU5M2niNN58WWCE5U7EbgDFdZ15uxv983HVjv0yy6zoVijshh0ktGvkz1F
 SLFyyJ1ARHH5duF4xR0Zdo38e2pScBOs78ZpNSu3W5tV/CZ1aVL9nbGTR933iQsESMlj
 H5uA==
X-Gm-Message-State: AOJu0YwlcXgo/nwBfcx7KGhd9KtRFBo+6t8JQ1I6EnxyybXXWmhGk+r+
 c9/RuLWV2jiJ7LxfCBk/FfYovQyXPpPhHxJ4QBrs85kowXMQDGLxUnDYgRoxEdnhzkLymoM922i
 FQgZk
X-Gm-Gg: AZuq6aKSS1N9aU+NjZxM1+6coYMTi5QQWWWhWwH6rLI1bHl0ZHqY/xcuJXW8xrEPlkH
 D67FpWzNdzErkbQCJt9w47j3UIrl0oprHPSvwSH5dz0Nci5TnKUl2lHUw9FZ8lnJUj85ObblqZn
 w64pY21kRGUrNsFWFPlXZ1NkfdXyORkvNtbDtO72knHCCtuwm1W3KXIcK46SGweYjbe0YdjDz3Y
 aULbaZQ9nCUuFa5T+ywJS358JKl9iT5/OOGrXT+qdEFi4KcWgbYV0J7t7VWwwMRbt/mi0yJHHQq
 qK2vVAvjDpXDg5zBr+NM2vmIxmWmbTQOzmb0kEzFnlzXcYMjBxthewxneLE0PzisfuPXgeD8KtK
 j0tkR2o9sZkLELm/pF7qaTUZCJmf3mmTo9CWV0CgZ/hV6nTrj1hTY8eJpGj0SI1puSxLKBLrS2Y
 dJIJmxQR0pdf/jl8WiEojYxf2zTqIc/tCdazdee6DhS/UpY9J/RZ+JGuP9P+UonJu5mGSNhTng
X-Received: by 2002:ad4:5ca9:0:b0:896:76ab:5a1 with SMTP id
 6a1803df08f44-897404d10dbmr326829086d6.65.1771563858392; 
 Thu, 19 Feb 2026 21:04:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 05/10] net/tap: skip checksum on truncated L4 headers
Date: Thu, 19 Feb 2026 21:02:07 -0800
Message-ID: <20260220050409.1571022-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

Add a bounds check before accessing the UDP or TCP header in
tap_verify_csum(). A single-segment packet whose L4 header extends
past rte_pktmbuf_data_len() would cause an out-of-bounds read.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 8b6d5db37e..45ca32cfb8 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -365,8 +365,15 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 		 */
 		return;
 	}
+
 	if (l4 == RTE_PTYPE_L4_UDP || l4 == RTE_PTYPE_L4_TCP) {
 		int cksum_ok;
+		const unsigned int l4_min_len = (l4 == RTE_PTYPE_L4_UDP)
+			? sizeof(struct rte_udp_hdr) : sizeof(struct rte_tcp_hdr);
+
+		/* Don't verify checksum if L4 header is truncated */
+		if (l2_len + l3_len + l4_min_len > rte_pktmbuf_data_len(mbuf))
+			return;
 
 		l4_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l2_len + l3_len);
 		/* Don't verify checksum for multi-segment packets. */
-- 
2.51.0

