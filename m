Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73387F31E5E
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 16:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DB940609;
	Thu,  9 Apr 2026 18:16:02 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id ED11740276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 18:16:00 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c20010f10so2542076c88.0
 for <dev@dpdk.org>; Thu, 09 Apr 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775751360;
 x=1776356160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3TOYfN9HYPUCEbCTt4RLWqE0YH8A28azI/lUSJHS1i4=;
 b=0oZBJnSMebaihFrX2fbsqv5dFMvrt9oXDmlPr++wIGfmwiM1i+UX7Mcuqa3oFwpxFi
 Ms4DXl/dw2jGjdwpnisItCNuuid+ymmMViZnpSabklOG7buB2gro+RCp7xuo/fR1rfVk
 NlVat4KXWQD2w2RX8ZX3q0HnPumtUe4zNpt5N+OpGOYS1jbTMgfIGSiKw+Z+ml7i3X8O
 +RFAOB9daDCS77iRmEiuKoz/lQY2seMKtF+0vAyvM1JnlOGmj3wbSmvxvJm4TSAFJvSh
 DxtLw/bMRDb0FMxdqBujQkGZ1opYsSpn7I8OThAjUh/Jdia7/K88xeZZ+yPPtaRRCK+d
 urlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775751360; x=1776356160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TOYfN9HYPUCEbCTt4RLWqE0YH8A28azI/lUSJHS1i4=;
 b=JrJTXkvEKZ7vEXdRgf6wRcNUnR/yxzcXNbWvuMsBrJQ1gVLmyojQmvwbKYzUGmF3uE
 pWhyq1UYKjwNwB2IdbZPNKQuzUlaKBMYa+BPaq537a+h+4c+xOcN6oTQ+IFSks4Qp7ea
 7R573roF2zwYritPBYUfuD/r1LkyEBHLmY4Td5JNGe3cRwRC5ZlEvDvcjVcCg147Ma5z
 n+LRAF3f6E6uwbP9Ia/Atee7SSOhAuyClxKu1mof9ScQNJHVJzVkoJB8ZmNGAV9EG5tx
 GRTFftytUg+sZAdijvtmc7Kj0qDSbNGPkzK7/9i/2m8C1nqPTd3vQIDdsiA0lTOO7sCj
 xyWQ==
X-Gm-Message-State: AOJu0YwROM6qTTUrIyf0jN18Xa5U8gXb3RnHoSc7ThZ2JAumW4nlwk9Y
 LfPW+b1vEt4uy5JomjYPmvmu8ms+w5jxhhvMl5R8rJPG69d48euNJ65+cEOOsd/iBQS+BpSxkw4
 qIBWS
X-Gm-Gg: AeBDiesTy08DL8ReHJMO4s5hvev02qcnOeEO8fdInAkAEqEk3Kc5wWQawzhlWqTrYmb
 Ku3pyDWV/yRjh+BaMeD5EctE+lVxMATyYnsg1R79gFztobFyH2znUowp2mCWWgdUhiDjRYuKyn/
 CI3kX6/bNtCNop361S08LA6AWr41kUtlj9OMi0TYFq2gXITiRFx1ROXIQ5gIQNsgHjkMpmTJDfX
 mzFj7swj6K3hBT3Mu1YIoEzc9pNdxhB57Bq3d/O41cYCRu7E0Ej6ZD2lbN9YcvI+BQywTEFffrS
 5BLjgYPkjjkehFgZnTPj4weAEBSgP1JjCrTdEoGcRLGN9eH+bH8bjyf0FOjqp6GP7WI6D0p3lbC
 Y2F+WRm3yQukygdteIRD0Wh712MBM7w+8BbSCXtxLBSHFzGmZHs/GVsLFHZwsxm0ciI3Dc8P+Zp
 ImgzGJ/gRREqVB7OJXn+MX7xtfsDowcxm3
X-Received: by 2002:a05:7022:10d:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-12bfb74c67bmr13576040c88.19.1775751359662; 
 Thu, 09 Apr 2026 09:15:59 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c217068c6sm7016167c88.14.2026.04.09.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:15:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jie Hai <haijie1@huawei.com>
Subject: [PATCH] net: fix GTP Tunnel parse out-of-bounds read
Date: Thu,  9 Apr 2026 09:15:56 -0700
Message-ID: <20260409161556.141251-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

If packet is fragmented across multiple mbufs or the packet
has only GTP header the code would reference outside
the incoming mbuf.

Send GTP packet:
- Valid GTP header (8 bytes)
- msg_type = 0xff
- e=1, s=1, pn=1 (sets gtp_len = 12)
- Total packet size = 10 bytes

Read at gh + 12 accesses 2 bytes beyond packet end.

The fix is to use rte_pktmbuf_read in a manner similar
to the read of the GTP header.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/net/rte_net.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 458b4814a9..da4018437b 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -219,8 +219,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 	case RTE_GTPU_UDP_PORT: {
 		const struct rte_gtp_hdr *gh;
 		struct rte_gtp_hdr gh_copy;
-		uint8_t gtp_len;
-		uint8_t ip_ver;
+		uint32_t gtp_len;
 		gh = rte_pktmbuf_read(m, *off, sizeof(*gh), &gh_copy);
 		if (unlikely(gh == NULL))
 			return 0;
@@ -231,9 +230,16 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		 * Check message type. If message type is 0xff, it is
 		 * a GTP data packet. If not, it is a GTP control packet
 		 */
+		*off += gtp_len;
 		if (gh->msg_type == 0xff) {
-			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
-			ip_ver = (ip_ver) & 0xf0;
+			const uint8_t *l3_hdr;
+			uint8_t l3_copy, ip_ver;
+
+			l3_hdr = rte_pktmbuf_read(m, *off, sizeof(*l3_hdr), &l3_copy);
+			if (unlikely(l3_hdr == NULL))
+				return 0;
+
+			ip_ver = *l3_hdr & 0xf0;
 			if (ip_ver == RTE_GTP_TYPE_IPV4)
 				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
 			else if (ip_ver == RTE_GTP_TYPE_IPV6)
@@ -243,7 +249,6 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		} else {
 			*proto = 0;
 		}
-		*off += gtp_len;
 		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
 		hdr_lens->tunnel_len = gtp_len;
 		if (port_no == RTE_GTPC_UDP_PORT)
-- 
2.53.0

