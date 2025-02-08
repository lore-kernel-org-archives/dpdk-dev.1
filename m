Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84AC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 591EC40663;
	Sat,  8 Feb 2025 21:32:11 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2905A4065A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:08 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so19259555ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046727;
 x=1739651527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlVZN3TZ6YdSqh7cxKl5CdD2TINyVAMFiqe3mirEtSk=;
 b=vlx4cSjLcWwUV/OGh5u4+INc5gM6j/2Y65II/QOt0eFLO/qc9APM7ukZocFH7AwgWA
 BoIQ75Nutwy5vuznK/CB4Yoq8G3hwy36gvBfOqNvkHUem30k8z/CDsc1e1xozb50kxKH
 2larEL50SfZtlNUYBw6S40YKvrOc5a3Dc1MxTXTS0ovUswVMySSvYx3FOz60CqBPAHUL
 8Ixych9g2b3ubSka8eNcmwUpTrP5xJVogE5pG9mK5blvsAixo96H1Dw1BTdgg/fZo0oD
 JHiBDD7Wma9X31UQqqk45lagNHCie1h09iboU/S2wR05Sn0fzUeKXXMmbdrU7tK0GSG2
 FPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046727; x=1739651527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlVZN3TZ6YdSqh7cxKl5CdD2TINyVAMFiqe3mirEtSk=;
 b=f2lVRX/4PxHoixkKVfdPWquh9VCYHEAOq10DTeUQcp1qr2NthjdPg4i7w9UFLtCv5f
 IlpTpXyVK3BU11n9kMCm309mQuEaRfEv03EGYHSVqauNX3k9LSfnwObVocf3JD+smGce
 9vsEjRM2Rgpkny7HDVZhIEZBHclSgZxDgLtEAoQZOBBYmKOsAA/Q9K7t3Hv2OdTFiFg5
 1m1sUAQm2g5CX7j8OMIy/zq32Mlyc/Gg0Qqctf5n4bJygHUSuMGXUPnyv3GGFcJgXs1e
 H56dQeIhfOLkhc6NEwYIeHLcCH4693fmgfKSSeGJl0ZkhopX80ecxao+pcAx+WxD+qBA
 +y+Q==
X-Gm-Message-State: AOJu0Yx6Q5FNsetgn8kKw6zKLb8xHcS1U8Sg0X9ZKqWYeS6vCRA1pUrf
 j6j5NxXZdo+Wri+KZBZNZvoz5XULtEWWgGNIFsl3dr7V99auz8Z0ML8cZmDZpnPzLpf7uczw/LA
 u2u4=
X-Gm-Gg: ASbGncuMyhJiAHyRx2fV3aXb+KxkTmbYaqg4EUTA/pJf8wXxXfXwd9eiAEG2dQERQWi
 nbqLbqXwJ3sJ2a2PFV351SvyKUHwOkidVodCAeIp1qlD0cipS0bjqVuPN/CCw7POi1C0QbQlvMO
 Lgjin+303jJ9JeLl5oH7EDC4tLcK0+mc6oi2uL9K/LExWZzBBGCb4EkoJE5VnQ4ey1jpHreVhYu
 KT7VbI8cf3C5eP9a8Fwxp54ms/6F9N2jkIk28+FDFJulynjIvCAP/+WLWc4nJbHarYv+Eh1ZhJC
 XHhH5GeSu9CL3t/KnxroqsP14w8TYQqzemAVhtIOT2OuPDwtmQLREfN54OsRJ3SY9VZL
X-Google-Smtp-Source: AGHT+IFQ6vL8OJoN886TVC/UqLT0fdHuAj3N3DAPl/dt+X2SKZ1tpMcdF2DgC9q5p2dGdD1ueFmpnQ==
X-Received: by 2002:a05:6a00:4603:b0:725:f1e9:5334 with SMTP id
 d2e1a72fcca58-73042c73aeamr25042514b3a.8.1739046727272; 
 Sat, 08 Feb 2025 12:32:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>
Subject: [PATCH 10/32] examples: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:02 -0800
Message-ID: <20250208203142.242284-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bbdev_app/main.c      | 2 +-
 examples/l2fwd-cat/cat.c       | 3 +--
 examples/ptpclient/ptpclient.c | 4 +---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 46f20238db..03f15f91cc 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -360,7 +360,7 @@ add_ether_hdr(struct rte_mbuf *pkt_src, struct rte_mbuf *pkt_dst)
 	eth_to = rte_pktmbuf_mtod(pkt_dst, struct rte_ether_hdr *);
 
 	/* copy header */
-	rte_memcpy(eth_to, eth_from, sizeof(struct rte_ether_hdr));
+	*eth_to = *eth_from;
 }
 
 static inline void
diff --git a/examples/l2fwd-cat/cat.c b/examples/l2fwd-cat/cat.c
index 00e4cde48b..ac8feaec8e 100644
--- a/examples/l2fwd-cat/cat.c
+++ b/examples/l2fwd-cat/cat.c
@@ -314,8 +314,7 @@ parse_l3ca(const char *l3ca)
 		if (cmask != 0 && is_contiguous(cmask) == 0)
 			goto err;
 
-		rte_memcpy(&m_config[idx].cpumask,
-			&cpuset, sizeof(rte_cpuset_t));
+		m_config[idx].cpumask = cpuset;
 
 		if (cmask != 0) {
 			m_config[idx].cdp = 1;
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index def8de29ff..2f9764bf07 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -470,9 +470,7 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 		client_clkid->id[6] = eth_hdr->src_addr.addr_bytes[4];
 		client_clkid->id[7] = eth_hdr->src_addr.addr_bytes[5];
 
-		rte_memcpy(&ptp_data->client_clock_id,
-			   client_clkid,
-			   sizeof(struct clock_id));
+		ptp_data->client_clock_id = *client_clkid;
 
 		/* Enable flag for hardware timestamping. */
 		created_pkt->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
-- 
2.47.2

