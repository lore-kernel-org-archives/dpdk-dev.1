Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBF2CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 16:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB9704042C;
	Mon,  1 Jun 2026 18:17:51 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 6DC514042C
 for <dev@dpdk.org>; Mon,  1 Jun 2026 18:17:50 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304f0039c02so6199303eec.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780330669;
 x=1780935469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyXcSf0ZAoWYDoOJ/XE9DOA08LPY3K6WfwrNLT2fEBw=;
 b=Ijjz/ibXHC6Q8OfhSLPVujO/vm7yc7MmFxBdwxT5hTO9z4L+YFk7XjyR2dPKrpVyTH
 xUppKIFHvcoQIJw/dIAxGlVXDRVMpJHO1wu9l3A297KqoMULSHxU47AqRWcCe8z02kBk
 XfGy9gHynYjV5UCUIlRalzo6kH2RRPJEeE2XMCsDWS1PQ2ZwnTDY+SbyLbFa1r+0iQjb
 TjKgEPrrRdm6RLlSRiB80wWzQ7//DP0oLKtnOxy48JO8n484Bpu6btK5YGjmPD2BskhF
 SnZKt3/EX0gU0mPJkmkJ0pF8evioz+PMJhfX/QS12CY+Xn6Qn4B0TrE59SNcverlNlG0
 iXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330669; x=1780935469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyXcSf0ZAoWYDoOJ/XE9DOA08LPY3K6WfwrNLT2fEBw=;
 b=Cwu1EThTeYR28WiaYu1MFRog1G6v5SEH81Q3a1Lg5nmPsei8DrYnOQ2g3+1aDOtEC7
 07Mu8CRzcdE6CRzyIW3wXEKtVOcPhD3rggvlVFGiPgLGviYIZZxV2HJUCcj72Vo8uMCT
 Ze8a5ri4gJtQY+/eH6Obz/t+MZKbWdmba4DXqPIwnvAIYYZKFMs6gq5RI7b4q4My3uAS
 EyYvDAxU23BM3q/uKM2qpW7/hsR8sRzCu0WYcsgrIgJ568xO1hbuuj7HuNACw+0QPaQD
 4xmWC6JQcTtAJ9JLFk43ElzCtQxNj1Q61qb5qRfjdtvdw7q8po6bILEIn9ZEzjz90CVt
 pToA==
X-Gm-Message-State: AOJu0Yxdu72FQlShwlvyQQYfzrxIM5JQayq1V8BiaNVDOvA7FXwYYrQs
 hUW2ltoeiwdm1s20jeF+DYC8NpZIjnIbAB9GjfOA/we1c2F0CEbLppOyLep5Fg3wvNAHyTtMkY3
 vKdTy
X-Gm-Gg: Acq92OGmhShjNPan/X55BzOeN9D5URZ+AtHzvfkSIJ+sQ8rb1IqrmSfSBrp3NECnNPb
 DFUjJVPQSqYFjrGTjoAvfEEk/hHuKWcw9vUSlNF/yYbZhhBg9r1F8aBE6TcFjexlKUe3ewz1n2I
 EQUnAhPbXYFcfzcNjJsIo3zb5vCXDZamw65OMiK2P6V0z08RPEePFnDsMQLPG/KTZy7QoGroriV
 r6Ia2E0LJkAnZ2II44iIpdcvvnfgUA24LGSN65S2rNTfy21PVJAwZRSuKlVo81NQHKVzNXi7zbM
 FIA5JV0LFG2iTaq0bWFsuQuTNCXefWqM7OTsyfK5Xgtck165Yu8QPkHBkz5JIpv6kY/qPmln7uH
 ac5EOwO/akSYJI+847oPtHuHh3bYDj23xQQKn+KyOR+T+kWX6GCZW2lqFrOytC7mdwGmsL/ObBg
 Xu3HUMlousr6tH5j7m2lGhmL/2Dh4bkxI17iSr3prDFtKkyhGVvU8O88igJAGzX4Q7EiAp3Srx
X-Received: by 2002:a05:7300:2327:b0:304:188d:d0b0 with SMTP id
 5a478bee46e88-304fa5ee336mr6055601eec.20.1780330669345; 
 Mon, 01 Jun 2026 09:17:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a114dsm9491367eec.24.2026.06.01.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:17:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jie Hai <haijie1@huawei.com>
Subject: [PATCH v2] net: fix GTP Tunnel parse out-of-bounds read
Date: Mon,  1 Jun 2026 09:17:27 -0700
Message-ID: <20260601161746.147010-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409161556.141251-1-stephen@networkplumber.org>
References: <20260409161556.141251-1-stephen@networkplumber.org>
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
Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
v2 - change variable name of l3 header byte

 lib/net/rte_net.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 458b4814a9..0a91e92ba0 100644
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
@@ -231,9 +230,17 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		 * Check message type. If message type is 0xff, it is
 		 * a GTP data packet. If not, it is a GTP control packet
 		 */
+		*off += gtp_len;
 		if (gh->msg_type == 0xff) {
-			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
-			ip_ver = (ip_ver) & 0xf0;
+			const uint8_t *l3_byte;
+			uint8_t l3_copy, ip_ver;
+
+			/* read first byte of l3 header */
+			l3_byte = rte_pktmbuf_read(m, *off, sizeof(uint8_t), &l3_copy);
+			if (unlikely(l3_byte == NULL))
+				return 0;
+
+			ip_ver = *l3_byte & 0xf0;
 			if (ip_ver == RTE_GTP_TYPE_IPV4)
 				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
 			else if (ip_ver == RTE_GTP_TYPE_IPV6)
@@ -243,7 +250,6 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		} else {
 			*proto = 0;
 		}
-		*off += gtp_len;
 		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
 		hdr_lens->tunnel_len = gtp_len;
 		if (port_no == RTE_GTPC_UDP_PORT)
-- 
2.53.0

