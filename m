Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED43CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ED5040A84;
	Tue, 16 Jun 2026 23:07:07 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 64D57402EE
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:05 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so7349065c88.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644024;
 x=1782248824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGieHqVAR7vg5SBk/wOS7C1FD9FIbYnBGwRUrHPVGfY=;
 b=XZuorg5N29TgPWSKc/Px9w9VLsg7yrFrBzR5ax3hABHwoXLh53/EsPFbFUROQEBKxG
 7i877preFxyhtf9DlszLSClpGPuSpW8T6e95A/gQVpWUwcJZjKLIupiSkTXn3giNV3ig
 ObDDhnGiAR2UF7tZxuFFeZyVcXyc7j8bjcH4R1jbxMT64B8w1peaFt0LyBEJYrJdYEcF
 4QHBeTijDC+v6pggcnF7ADcRLhwHZvSmZjxxDlNvZvk46tmNh71dsC2eMdn3+2ZJ2oea
 o0FMAQVJJkrfmh+6w/RQb+R6Iav/ztqNQw8HwPcT59bIILv4neHJCVoX7NxbDvjANYHI
 f3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644024; x=1782248824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGieHqVAR7vg5SBk/wOS7C1FD9FIbYnBGwRUrHPVGfY=;
 b=sU8ZhtDOIAgWjEpiMzCcXGwKiflMvo81cTaZzoTHWbW65mXdynt7OxAjBa0OsZxUA8
 FnnDe4w84Udx0DS0oM9MqxIFRAq131rLHqtrh6PLCsbgnPdyLVo1c1gL2nLVAPKipVj8
 fezOQujXK/y2+Rg5UfbaFUtMnRw8D4tVLgDwvqKkiugSxUx9KP48iiGmY9K3QBmoowgJ
 lbomWt6lX2sjonuPTGxfldUO7z6v3zPfGYlELKwbKeJaejO2z/hCIS57GHgEk873+nKL
 U77OpYvyt2oDBKCuzGf03qeCPOOiSNSftXJZUAEm3D1sqo5uF5FKZ5rr/Qg7BN8fZS/4
 SBcQ==
X-Gm-Message-State: AOJu0YwPdcqZWojTRKlVSMCmAs7KQZgv2qgwI3MoGlOfiLdh8wjNUByc
 lfGVl4H/CyBGsqpK7ifEt2B5JieozDe3zp6lD/PCKZLjZ9DZhFZLzw8Nh2rKow3UQ+R3u6k6Gpm
 gHS6d
X-Gm-Gg: Acq92OGhjXAnAq87TBh5kcFQfqQwbtcUonnDZ6E5aayxfyJ/yFvahTv8lh2JgYicvWZ
 gBRl8Yakk0dq8IvVt3LVEADsDw36f/KPmuej5ieRAzWksnptMdxIaWVP3mw0ZwUftSzDh+JmxZT
 +oOwtA0pdej8jHGfWwUE5cYgX+zysYJ42oo1ihLdoSVd74YqWgD+E5DYlrkF2ppF+1CDAa5JkBh
 ImVARkXf9e1Q/okrZYBmuiK7rHUiIFoscUUSeI9UWfCMajhCfz9LYlJRb20oyDurEN4FIZAZJGS
 izQd71km0858Bv7NnpUaov6HEjLqOui1hw/Yr2L+UFDAmrAqt0SbNYag9+6O1J+CcKfazwhIXQI
 hFgMnifVZFQ40lp5DfBDyFAB26BiOkGTjVOF46rDUQjc4K0CFvFACzrfF7avr9l+jkGAROKNO6D
 Hh86tbcElBFCRKIAvQGzewJ47wRy3CsznjVy8/USfVi/HJfBQTDb2i4TEJLePz3A==
X-Received: by 2002:a05:7022:f8c:b0:138:916:5179 with SMTP id
 a92af1059eb24-1398f676bd6mr310929c88.14.1781644024369; 
 Tue, 16 Jun 2026 14:07:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:07:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 3/6] ip_frag: include protocol in IPv4 reassembly key
Date: Tue, 16 Jun 2026 14:05:35 -0700
Message-ID: <20260616210656.464062-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
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

