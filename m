Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B3E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA52E40665;
	Tue, 17 Feb 2026 00:04:54 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 5E7E74064E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:51 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48371119eacso33567305e9.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283091;
 x=1771887891; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=JWeYHk8mKoIlUxL1Fc+34Ru9LJk/lCY+YtbGf9ybirPS7crHD8qXxnN2k6PStRQBSR
 4SzoptsIQ9tnzgD2JY9697Ky4V/NUhcwNNLLueu+3Kq1u0cOeKvJBXbAwoJp5MXMgUIj
 kB8XA1tfbTw8RsgIVhYDSqZDuWB7DIJMJSHQus2Dm8ykILudpfE2hTfNPc6FDNXGbAsr
 SnrYY1WDYvBkQ01KGH43ngMVPgKquVp26XzkGMDKl3BavDxQa6wSfwHF1Q3ADdCYMRnY
 85GvyamLxEg4mUniRbmeatVYZgVeMWSvOS/aWrrH79XYf1NZBAHP3BLZdwgedOZqRq1d
 fIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283091; x=1771887891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=Ot+hkl7KeAXhnusJv3JhIfIApObafbemlVo8d1DwO6I0P3rVToeuK3g91e90J7MZaX
 f6XRDieeOiyRipv/F5+osve+OXckkcqrDAO0yc2S1o4JlCG8SyQYS/TOGZRtQNvUILrm
 mlO3uAO5aTvXzuWE9Pqc9L3Vzpxrk4v9pbuKV17JOARda5joqiaU8YVUDROUDxA44saf
 PKNweGcRe3k4ODHT+NDp54cMmnZ6JS57qyk/galum7HsmsebBfHlyoaIkbQJPKxaIC8n
 LjHN9jADVO0QZpYn/xUsX0WESde1mRfkXW9HEuMSR7wp0MhbFf51q0r9Fey7o0HJzLBa
 XreA==
X-Gm-Message-State: AOJu0Yy7ggmrOZ3Z4A3fYnpJRlxd4vXdMmvlMcBTE6b9HKLHaWap/jeJ
 JD7jYStPk6H1UcMtHv5QQJyhtx49IjN+iRFurKCXi2e90gDC918du8TrPE48g9Lj9Q9eS5eDxxx
 yEovMEK8=
X-Gm-Gg: AZuq6aIJ3NMEHcf9XhixKKayJzsO+K/PWkp3FiS46sj3xfAIrRiV2TVSMVnA8B3k2SE
 mreAV7brYCgeoL1WaqalElVi2j+3LG5tqaS/XQUTqn8WCoVCsQTBq3D42jRDshHiaWkHCcRGPTb
 JL5xLn7zww56oWl2yAxVHtfN0g7MBdQCi2j/m3sPVBm6nyPDq3h9VMkiUeO9mae8uwrLTrOsspN
 AWa/YTE4rAEvdKOPP/MXP34oVCdSUdQYZnon11NlkjAs/a1m7z5kcPjCtyiovgFwfjsbOl+iESj
 jEpEUNH2fZoJB46lXcF+n1hi9RiwdkNcR8Oaoue8ZmhSCVL1oLjYWNKdpMIMjOyBH+8T//hYhjr
 x6dVuacJpyNZxUUKBHdxsMSGV5hNUxrVvfKXoqACnKeFnOX36x5o8XDJ/dfOEcWNM1QdPFeQaI/
 93l3UfGYmNDBQLoJGvy72Ayd8vKm3uaaRCfACU9a/bi7jcAxpjt1YFHlO05kLxXg==
X-Received: by 2002:a05:600c:1909:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-48373a78e7amr206466495e9.35.1771283090942; 
 Mon, 16 Feb 2026 15:04:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 05/11] net/tap: skip checksum on truncated L4 headers
Date: Mon, 16 Feb 2026 15:02:29 -0800
Message-ID: <20260216230437.847578-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

