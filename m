Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1DC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D327340A75;
	Tue, 30 Jun 2026 17:37:40 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 0874E4069D
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:32 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30b9e755555so926188eec.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833851;
 x=1783438651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSrTCGIBp0/XY1FlWUYf0WMDaKscJ78+Q9zOsD7WqyE=;
 b=j+UIqD9mQM3bjdqu5KQq71IOVFou3Wa9moTW7iEK2cIuILmxFjhqaEcRBqJW5CUD0w
 7s/L6IOExeezuqjd2cdvuwtlzPcbfaWsi30bhHHU3O9D+O44NLjVoKlUhxMa3SFA6tub
 iIkuG8e5pf+a9r8w2xiGvpLWZfm8vLWOVJrsZR2z3CsX8lYuONEjFqhyRwfwnDTy8IvN
 sbM38/YWbmPxMtRgrIwPuabpVT0L4f8EWC+B9UvgJ5G3vBxW/3B/eui3EqytjuSNCODd
 j98L9o5sh0gweBnE6b0T3DxR0TU2mp3pqCpuFIdgkGwXHPK6xxrvtMUcy+tLlErb8q3F
 OnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833851; x=1783438651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FSrTCGIBp0/XY1FlWUYf0WMDaKscJ78+Q9zOsD7WqyE=;
 b=EW0W5Ofw6uRtlL8WyeG67L3jQUVh1f2Cte+QXD5evV+fupq2xkXAAe0I0nP8O3dNfN
 gbhfjPc8Bi3XMu/xk9bnIQ4v7ioQkXBOz3UXijRSZ0xMqF61HnWnVtPuvdj6h+riThGC
 C69fESmr7uBMBsGdSVtFzsbwNsfh/bIAqW46y0S+GO0Q7jDrHfzIM9TxxFuSF/ZldBg+
 TZteIYF8FmgXQx2Yfi79Pdah9MFkqIBXUfoTv3DfIYVBcduuPY2fKa0Isc3E56SuqRWw
 +xI5INzMZ+vFyKQPfIGd8M9lzeN2djE6iLNdk0VahmOLNJ8HmwWh4gzgImkMgLIOrGyc
 fCDQ==
X-Gm-Message-State: AOJu0YwzOVCQKPrAk5GDGzzfRDtfxsRneI9urk6D+6plXUhTP6SreXo/
 Ksj2tpC7GNulcvsMUQEX/ChbO4dgSATPfwuZB7nOCAkdqn+RTg82Rr1KDR2wgjCo0LzbWwfaRGq
 2AaIX
X-Gm-Gg: AfdE7ckk1AY6SEm5/v2Qdou0O3/7ZC9eMSgZMx3//YpJkLi+jQTMDnBO/dqwRY26GBk
 CjfJIJw8Kp0cVpRkQqxhsRtAojtWiI1V7GNfd4IdSKeCqWmBoQR7FGIDxLvfbjEmJVtq/6+ODoT
 LUCLZX8xmab8TmrGkWtSgaCmKS/JRAGkRs4ncHXwz8yF/A8GUZg30FvH6WFbM4QkG2Rz8Se1wfC
 BD15Zfk9Triko9vQl2grmcqo5x/HqCGxaMBgVu6JMIYMMzoGQgqDMLondgri7dEp1443Wj4FaEj
 gLjlPm5SJ+U+osQkdeCrF0WkrO+/miA92yXE3A+rVb3mb+/rdfIIVCqfGmDko6bbdFb9ktB6sEA
 6SGWTPR8JEs/QuHgXxmmVi4eQROsl8WJclCJLIyhoupDquT4TXl2vc/JP+uYYTZM6zrIv3qce/f
 ggxJUk31gmpFC5iQbn00gISGm+dese0PQpvA8XlylPe/WDE97AQyJC0n7QJDDxSw==
X-Received: by 2002:a05:7300:7fa3:b0:30c:96ea:2dda with SMTP id
 5a478bee46e88-30ef09a91b8mr810684eec.29.1782833850886; 
 Tue, 30 Jun 2026 08:37:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 4/8] ip_frag: drop IPv6 fragments with per-fragment headers
Date: Tue, 30 Jun 2026 08:36:16 -0700
Message-ID: <20260630153723.525167-5-stephen@networkplumber.org>
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

