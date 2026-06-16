Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C1CD98E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C29D140DD0;
	Tue, 16 Jun 2026 23:07:08 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 93D4740A8A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:06 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-13986d61b4eso2833125c88.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644026;
 x=1782248826; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiofEvyIGeRZcyU71SeiDXEL6yuTUzjq52/fwp+17zg=;
 b=b20DFWOl+ShQtRtREAlTQplkaG7rjTmrSc9MTLiHTsEHPdyKsHGvuKewJARdnBjreY
 9zn2Cq3csUzrJopMnKJaHVchglFEb2gudEJioJSMlK8o0GN49TiFfcXw8ZzuDrsA0dyo
 5pSyl/0Uh714aBaHHrxHsLPRD0bRjCQfdfNoeMjZYtziSFnMl1/mX5YHHrAjrE2DGgTG
 7LVTpKAbWK74DOMFyVP3i9jIrwN2vSBNBlzql/H4VNy8W68K5Ovp/PRhtdEzICNi/9+G
 Xuz18+Ow+lY/nmDbqgb2N7Rf0Ho8vqIekmR2DK58XZxAVaxHbb/tGteQEKG7cz7IbW/B
 y2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644026; x=1782248826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LiofEvyIGeRZcyU71SeiDXEL6yuTUzjq52/fwp+17zg=;
 b=mgD5r1eHKlXqC4qFaNO5TtmxqHTCc5UsbJzZ6yJ/8G19IfyzDlKVjVtjQDh2Tr4Thx
 gnfu5VR1xiUFOeNwf9A8ErqMcHzDu9rkfxb/ie5CyKV7xIduRDECxsc736ov0PZogRIV
 VsnRfa5kh//C3hzfl4w3bauN9niRdwVDmiHFfPilJoei+hRLR4yhrnIjnHGmQnJYMfuU
 DzZT+TXFhVcdheaR+stSv2YoF9lex3Cag5BaUkJWjrm8JcVNtIcbXDduB0QqAZUNb0B+
 SkdHiDLqnLE8qMKnur+LS+RzDYqsOhww10BCBekB4jLVv81SPZrf+7RO+bRZeQyqwtDo
 IV3Q==
X-Gm-Message-State: AOJu0Yxsg1yNcPap3fka8/AcpAeUfub3zS46CcK7CAR7ukdBS3zFA0PV
 Ml5bSNeiPtDFi5ExPgGM6UjChitpg0iV5fMqS8aTU0/uHgJF4zgKjU6vzFtDCtTFbOVgbAKIQsU
 aQJVQ
X-Gm-Gg: Acq92OG6g6xucjbm7vyIkQ84QiYti3d9HCt8wr6tRMNQ7WDK50QgaHosgdQvTk3sKWY
 kMi2e4RuejcO7u6tRZtlWVlwa77m7xLyF0mUBI3ZK0QQSnwbzZnyuTeGYfLFSp1xp7txuN2xJvo
 NgaNcfldqQvFBHghNZkYbA2Lda4PK6GI61Yn8+RHtpKvLykD2D4GSmy7rLSrZUQh1NrMXD3QsYM
 GsGqwcI7kRUsHK67wkVeUESR+5wSnkUoSx0f0KGWSYWfj0Zqh8mpNU/rlaJQvW79nL9iQm08Co2
 gkRBSXImO9KXPrTesB+A3omj9Ss9PFb7dmLZi8ngy5SZ4jWyILWz9DJkEF4aFwJma9/uwXeeqWF
 sBT0j518Hls3+/kxraAKkyNDo9VV3ZMlEtnyeTX3fGTb16VkHeQ7RBORTdSKS7uGeku4TxGdnH3
 ITsFM5cHBTU+ctUBol4apuy5lMnBcxvKhZr+Rz6H1JkpN/HBeVt+xsDITTsZkVGQ==
X-Received: by 2002:a05:7022:207:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-1398f68658cmr384444c88.16.1781644025647; 
 Tue, 16 Jun 2026 14:07:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:07:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 4/6] ip_frag: drop IPv6 fragments with unexpected headers
Date: Tue, 16 Jun 2026 14:05:36 -0700
Message-ID: <20260616210656.464062-5-stephen@networkplumber.org>
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

DPDK version of IPv6 reassembly only handles a fragment header placed
directly after the IPv6 header. With other extension headers in the
unfragmentable part, ipv6_frag_reassemble() patches the wrong
next-header field, miscomputes the payload length, and shifts the
wrong bytes, corrupting the result.

Drop the fragment when l3_len covers more than the IPv6 and fragment
headers. RFC 8200 allows a receiver to discard packets whose extension
headers are not in the recommended order, and RFC 9099 recommends
dropping non-conforming fragmented IPv6 packets, so dropping here is
permitted rather than a deviation.

Fixes: 4f1a8f633862 ("ip_frag: add IPv6 reassembly")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/rte_ipv6_reassembly.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 0e809a01e5..7c1659002b 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -180,6 +180,19 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		return NULL;
 	}
 
+	/*
+	 * Only a fragment header directly following the IPv6 header is
+	 * supported. Other extension headers in the unfragmentable part are
+	 * not handled: ipv6_frag_reassemble() assumes l3_len covers exactly
+	 * the IPv6 and fragment headers when it patches the next-header field
+	 * and removes the fragment header. Drop the fragment rather than
+	 * produce a corrupt datagram.
+	 */
+	if (mb->l3_len != sizeof(struct rte_ipv6_hdr) + sizeof(*frag_hdr)) {
+		IP_FRAG_MBUF2DR(dr, mb);
+		return NULL;
+	}
+
 	if (unlikely(trim > 0))
 		rte_pktmbuf_trim(mb, trim);
 
-- 
2.53.0

