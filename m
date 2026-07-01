Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6601C43602
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7A2F406BA;
	Wed,  1 Jul 2026 18:21:36 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 526AB4064C
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:34 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37fc02e660bso539708a91.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922893;
 x=1783527693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4Zlc36w/+GePmOFyeEtZZUxsAOUdm+lHu4F1VwbK8Q=;
 b=gYSghpDpZOwdKtwGUm6znwZw/nEePyka9kECFw0HOkiWHYjM1Qu5aN3jR6tpC5f5Eq
 9yrgxPqNa5vL2ac2+4KPTrzXtmtu3ZwuPwwo19+i8bOMD4Uo1qLATZrdfkzAVtpAaHVR
 fgE0KhwevVw8GLzvWD/pyvKWidduPGWiABi2nKHENqovENESYdeTLJJBnMbJtjPUR13V
 vQmXAGBrcCtzZ1PAaQjMJc8v2tP0tfLcp7qbkHEPf2RqkLymmX0eyOu4XHwfINVxsPYH
 +LYBlyV0qyp/puvIXiUIGE0xRcA48kTd8ln33gXyhxbRfi5lL0+RJXl6pvwYRVW8+M1e
 gTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922893; x=1783527693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4Zlc36w/+GePmOFyeEtZZUxsAOUdm+lHu4F1VwbK8Q=;
 b=A5LJdS40VfyN1oH7KdAO+/SBeYc8dPWGe7HKTPqehke9ivvvd1L0rCktxJIVIHBril
 quPiqJBBP6gSCsNPj0776KB7wPo5pntB8PmONgsBAJuesLTLYMvgkj6M5TRsTZCSCZvr
 1dgPhS7/agnVD3PDvW8V7PzUm0OzGOufsqillDMQMaYIVZxmdF1ibYqHsXY8g9El2gmV
 cZYcenRq/2P95jMAVHDmDEdAAkq2k4q2aIJqLz3OFZZPyg5RVuscGvy9JF8Gsr7YlngE
 Az+k3bi03+AxBm6/8Og4oQPaY/ZTAAkWWoHRxb5GbddDBTkUDvpcl9YqUC9GEdMt8cRI
 51og==
X-Gm-Message-State: AOJu0YwAF6w2ohl4kGuw64ozi97gEvHsUQTce5lWoGGPMSlKaxIKhszJ
 O4wan9iQusM/ZKcXwtwpG3orqRu4koIoRBufrJAN/nxxww43dujmhBSmRJffJdmnmqQLzTQNjA4
 Vb8Bo
X-Gm-Gg: AfdE7cmTHIgk/XjeK9iIZ1NcZCnp6hAHrv4wiiRCHDgy/1UpoIVGh2izVd/dX+8lpsF
 8GSiKKPYpFQk1euZE9cwqjynCzBis4KvixeDsRCfLo0IpvQ2XxubtlSjelGEQYxmpr67ReKto1U
 awEZWs1kmdWPa6c7CQ5Jvx2iHLk5q1NJxJUOUhBOjWE6nE4jWgV+ffjOd0IVITp2/G0ZtbhvA4Q
 z30sPNv/Z9nymW6roPChD4l7KjMCIsI45gcvUowYOQ71yeHVUX5ipokM8VzrIP1aRK5TASkK5gu
 AMr5zeLBkaey09I4vUm3PXQDsPzxrd3VBCjZzBhvCm7rAmI+I75qe771Km5BaDFY6LekL125Jf1
 9n83M/hsSaTfQ2fXI3PsnVkmMmm5MXFn/COJ9CuhI/SyO94ABTQi9eQeHtWAWIZ8o/VKU6UB8rT
 +s92sVXMEeNs2KOUqJnXZvvbtDm2NdQBeLjEvG4a+jewwH/vsXCCo=
X-Received: by 2002:a17:90b:17ca:b0:37f:f8c5:93c3 with SMTP id
 98e67ed59e1d1-380aa0e25c3mr2213301a91.15.1782922893403; 
 Wed, 01 Jul 2026 09:21:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 3/8] ip_frag: include protocol in IPv4 reassembly key
Date: Wed,  1 Jul 2026 09:20:28 -0700
Message-ID: <20260701162127.207318-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

DPDK IPv4 reassembly code was not following RFC 791 section 3.2
which says:
    The internet identification field (ID) is used together with the
    source and destination address, and the protocol fields, to identify
    datagram fragments for reassembly.

Omitting the protocol means two datagrams between the
same pair of hosts that share an IP id but carry different protocols
(for example UDP and ICMP) are merged into a single reassembly context,
producing a corrupted datagram.

Fold the protocol into the unused upper bits of the 32-bit id field
of the key. The IPv4 identification is 16 bits and occupies the low
half, so the protocol can be carried in the upper bits without changing
the key layout, the key comparison or the hash.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/rte_ipv4_reassembly.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_reassembly.c
index 3c8ae113ba..980f7a3b77 100644
--- a/lib/ip_frag/rte_ipv4_reassembly.c
+++ b/lib/ip_frag/rte_ipv4_reassembly.c
@@ -111,9 +111,15 @@ rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	ip_ofs = (uint16_t)(flag_offset & RTE_IPV4_HDR_OFFSET_MASK);
 	ip_flag = (uint16_t)(flag_offset & RTE_IPV4_HDR_MF_FLAG);
 
+	/*
+	 * RFC 791 requires using: source, destination, identifier field and protocol
+	 */
+
 	/* use first 8 bytes only */
 	memcpy(&key.src_dst[0], &ip_hdr->src_addr, 8);
-	key.id = ip_hdr->packet_id;
+
+	/* packet_id is 16 bits and proto id is 8 bits */
+	key.id = ((uint32_t) ip_hdr->next_proto_id << 16) | ip_hdr->packet_id;
 	key.key_len = IPV4_KEYLEN;
 
 	ip_ofs *= RTE_IPV4_HDR_OFFSET_UNITS;
-- 
2.53.0

