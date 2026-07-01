Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D9C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9C5840A6B;
	Wed,  1 Jul 2026 18:21:37 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 3932E4068E
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:35 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-37f816d01e3so676298a91.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922894;
 x=1783527694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSrTCGIBp0/XY1FlWUYf0WMDaKscJ78+Q9zOsD7WqyE=;
 b=aHbunkGeuVCCVkNJRPMD8qMpb2Mw5L6PGmwUhVmrXXF1aoQQshNiNS/u4nO9vTd1Wm
 vcUJQu14G34ixjSkvPnnwZTMzB3U+kQBIk46H7Zv3B4L55hU77CRNGnlhRG1XGAzP/cf
 BsYPghCfEBuAOGRHDDC14oqN14wYXOauW+7AnJetgM7NeYfo3AT7+wU7PoxTbWrCN6P3
 ZX/mbc/bfYMlGbiCsxk94QdaW3kdjDCJdqL6ktzM3i0v03MEIehf2RkMFaoZ1Qy0jR92
 UHTLKqJAl4P2KmsEii/0x45eK/dEfHS5E44XlpL+Jj79ZZJVxBkEt2HualfyGIZGSRS/
 UeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922894; x=1783527694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FSrTCGIBp0/XY1FlWUYf0WMDaKscJ78+Q9zOsD7WqyE=;
 b=QhpnwjuCk2B2RJ4mdz133CtDwJ3NDmgYfzqh7B8+ydqqax6qqEMP3bTjQAlJEirUDy
 CWbAlafxJO3cQN6ligo7BpaEn4RE1BVq7VB10iGP6e3Ld59aQUCOl7a478imtdNfMXWI
 Z1mgO52eBsQ1q9iaMCgfbFSkLO9Ne00HE9VJk3r3rkdqZF0dF6pnq4HQhhIMuANY7CpP
 bCdcAKPwrM+ZMPs3OPlFc5xtogDfn2a4NcCIl71xN4lLPV8Fa6yDNVUzk5pIuHOfYA+y
 yQ94JztwUbagdV+CWgVwxKeklSPDYdkiXoxKeF/TnDKmIvA+1R9Lfy5lCPIsIPZ2CXcm
 +sLQ==
X-Gm-Message-State: AOJu0YyJnpaTpVKsYIC2IyZE3CQgo5LK4HPjYYJxoXiMR2AmjtI+GYnV
 gSmlezMz5hC8nGjgMXydjy5u6zmq0B/yE2dqnIplsVkPlUA6AYKEdI9wpUQZC+qz7z8PN4oZIjb
 +BPkX
X-Gm-Gg: AfdE7cm5OdKcjnJ+9pQC1/8IaXrh6Dah51pszVTMJ9QvGHkhvznb3c2YMAOcoNHxO0A
 Ku4/ViY/ai5jtd2B7F4CRnaYpomR2+9FPXrDLyb60Y8NOkjxchpR8RASRnWKh6r/gsj13y//ahy
 5WUgEpyIgI9N5AeQoxXCErgaFPwrIKl+FvJk0ALlw1BsYPikIvxdsyjkU14DgH98YXkIjTDgo9z
 nl4+qKCeiOXVK3MKGoLHAZnvkAQQZnB2WynWGiYocHIx0on6RaJw+6pH5vFuE88iqp5WxfEKLCC
 XO11k6RrElPfdMSBJYHVrjZ0qAhgrTtgzD+fpoDlee6kZIWnklqNw6mBnGei9JqloKYTkBkZzWc
 h/AMJib+SNAanqBvHHyjlfvjbIjYDCoj7QHcqrIpFwXBm2SLESPMNJE+0ujLqIDyykWYyKW+TAi
 SaA2Sq0b4Zqcss8it0mAsRBOOWVgzB1lv4rV/nY985yNv836ymiTM=
X-Received: by 2002:a17:90b:3ec4:b0:380:94de:155e with SMTP id
 98e67ed59e1d1-380aa07cc86mr2278905a91.5.1782922894344; 
 Wed, 01 Jul 2026 09:21:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 4/8] ip_frag: drop IPv6 fragments with per-fragment headers
Date: Wed,  1 Jul 2026 09:20:29 -0700
Message-ID: <20260701162127.207318-5-stephen@networkplumber.org>
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

IPv6 reassembly assumes the fragment header directly follows the IPv6
header. ipv6_frag_reassemble() patches the next-header field and removes
the fragment header at a fixed offset, so a fragment with per-fragment
extension headers before the fragment header reassembles to a corrupt
datagram.

Drop the fragment when its fragment header does not directly follow the
IPv6 header. Headers after the fragment header are payload and are
unaffected.

RFC 8200 permits discarding packets with extension headers out of the
recommended order, and RFC 9099 recommends dropping non-conforming
fragmented packets.

Fixes: 4f1a8f633862 ("ip_frag: add IPv6 reassembly")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/rte_ipv6_reassembly.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 0e809a01e5..b6f623d53b 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -180,6 +180,28 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		return NULL;
 	}
 
+	/*
+	 * Only a fragment header directly following the IPv6 header is supported.
+	 * Per-fragment (unfragmentable) extension headers placed
+	 * before the fragment header are not handled: ipv6_frag_reassemble()
+	 * patches the IPv6 header's next-header field and removes the fragment
+	 * header assuming it sits immediately after the IPv6 header, so such a
+	 * fragment would be reassembled into a corrupt datagram. Drop it.
+	 *
+	 * Extension headers after the fragment header (destination options,
+	 * AH, ESP, upper-layer) are part of the fragmentable payload and are
+	 * reassembled as opaque bytes, so they are not affected. The test uses
+	 * the fragment header's position rather than l3_len so that callers
+	 * which include later headers in l3_len are not rejected.
+	 */
+	if ((uintptr_t)frag_hdr != (uintptr_t)(ip_hdr + 1)) {
+		IP_FRAG_LOG(DEBUG,
+			    "%s:%d: drop fragment with header before frag header, offset %zu\n",
+			    __func__, __LINE__, (uintptr_t)frag_hdr - (uintptr_t)ip_hdr);
+		IP_FRAG_MBUF2DR(dr, mb);
+		return NULL;
+	}
+
 	if (unlikely(trim > 0))
 		rte_pktmbuf_trim(mb, trim);
 
-- 
2.53.0

