Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE6DC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C5CC40A6D;
	Tue, 30 Jun 2026 17:37:34 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id BEA6E40697
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:30 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so8017999eec.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833850;
 x=1783438650; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4Zlc36w/+GePmOFyeEtZZUxsAOUdm+lHu4F1VwbK8Q=;
 b=gTch8DPgsOaRhqKkJzxbAVUkmAKMy9GdX+tf87wsymBPXh1VsLup9txr6201znNxfZ
 ehIlEnorE8TMAKwZ7rQ8u3pp+HTMQBfvgZyuwYfaI2pNhyilBkOHF1za5gskrwSljaw5
 kJmLrrmmDEhYIOdJnogvwloAEI10rJvtzoBs0Hw3johVh5wmoEtZxBNa4ckAtcoCmjDc
 5d6zEmSmwsZkVNslmX1AH6dU0KOyZponq3gjnYSkbckSiWPd1PjKkASjduqlfDJWV+hA
 2LgY1q/jVAiKIc+kGIjAcs38fIaX00/p4ln/qeboHggctqqq+F1QUVkGqBUM86/+18cI
 Jlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833850; x=1783438650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4Zlc36w/+GePmOFyeEtZZUxsAOUdm+lHu4F1VwbK8Q=;
 b=YdJXRq5uFkQj3O5aFpEFVITJzvam2A+bWOc6dkcdgnP6EzRR3xwoNa+1a7VB3rs0tR
 z4n7BBVn52RKjRhhbnhbkQ5CX2jJ8BUFJQdf8Kx95Gg9gJd0z1nNrvW4ftDek1/6YlKS
 Fvek9MCBpzLUG3efdCqthpOx6EWoSGbDdHeTh/7tVkbfcxPVgVOZH9WvTBQbzwwDdN8L
 jDV+O9xvtv3fkfME4G/pfiSHNBrfnsnj93VCR822X8NQSvrss75g1CbgL6JBuiLCESTS
 tlO2YJraL8SgiyrdZuS+ly/od1+1vtBqfuUj4qnmgRzFykPaAEUvVUqvUX4IGO4f54gF
 SLPA==
X-Gm-Message-State: AOJu0YyiqnLLf8LKooYFWJdwYJQVzedh9UzcZ4Zdio3z8o8Y4oKtfjqM
 UlWOtItFwSVc1qsfPpMhBsCa0znMtRvmuhcc9J/PMKC2LP61kcQP65x0NR4I9f9Q/B+GtZl+kKC
 JJv1c
X-Gm-Gg: AfdE7clZn4gs8UQHpWkdL+JAH0AHVD28zPeJe++cLRZDJ45/cutt6WLjvMn/V9ZGSUm
 C3Vgrcbv+84PHXbiKD0J4ET0qQqq9iT6n00Cn9I2qFJ4e1xgsh2iuDWenojA00tWayaIslTNNJi
 dK5wrSqg3cx/XxKjMLGNUTHhOyZKyeJHDOAyEQ+v/4XYJbfUV8aY6hmIsJXVclsryuddHq/Q0n1
 qnyEdW+TW5e9uu0oLcB71BLmGXIcvCaFSMP8cdo5AGOWs1VIzjyrlnuLDoDLhx/bfRWcZ/WW3Ry
 WZsHyeaK7a864/KhRDj91Bk2I5KwFiSD97QcLA8EE9o7tDcHchI0DLPy1v/+6hT8utGV9iUYxMC
 KtZf8pVt4fzCkpydqdexIKiWxQvIyFR7xwgVm+Wjp5REibUm9VHxmE2GHfhaacplf72HPW/ljMa
 5WUyQd8YYiqx11PIrvfogXQmtE4Rl6vOmWxB7nMC/GESdiPmae0Kw=
X-Received: by 2002:a05:7300:57a3:b0:30c:23ab:b7d2 with SMTP id
 5a478bee46e88-30ef0975166mr882111eec.28.1782833849679; 
 Tue, 30 Jun 2026 08:37:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 3/8] ip_frag: include protocol in IPv4 reassembly key
Date: Tue, 30 Jun 2026 08:36:15 -0700
Message-ID: <20260630153723.525167-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153723.525167-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
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

