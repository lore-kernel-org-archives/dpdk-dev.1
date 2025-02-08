Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EFC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E28B40A4B;
	Sat,  8 Feb 2025 21:32:21 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id DAB1A40693
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:17 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa4493a695so1021957a91.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046737;
 x=1739651537; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDpgqYPNFIiCtUSqeygn7R0ZOSGdUQvXZl5vN2i7aac=;
 b=p6AdxIVmKUBp5UdusL/42T3dL8qLQJnrIe87kAltgNopTS1knNIukYyLY7Zpl22gPl
 Vmtcqh720qhvWaZADZ9BadaKw6oO/6n3qPR8kMJafEPtnN3cvrhYU3xk4Z1rnbxGM/an
 fTZ2a2FH5J9OlrDDMD86DVVMEHXMjtJX3YauMcPjEWx4y3Ng6wJzYx7RWw9eYBFdiPZx
 FZJs0kYGlNKhDfHrRPC3RJJB8e+MZX15eN82spmbtCKduBimMLWHcZJQXXi7U4OvbdLd
 HM1iSQYLL8kBX9x/By/PCCOLORHDHjAzNsL5qsSL0GHD2MyWAQkY74OPL1XOWW8kmP8N
 82FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046737; x=1739651537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDpgqYPNFIiCtUSqeygn7R0ZOSGdUQvXZl5vN2i7aac=;
 b=c9tSisAR82xcC1OEvRBec+G4+PrFFNnM7Nq2u2d7Fu+KxfJD4ssNTg5aC0B9VPM+uq
 Uo6aOPPaF+uva1+5Q8cnVLb/558jT4UdUAauq7bUBrGxGAX51U/j3VUjAxkbziAebzvh
 vcbzefWp3/rfnxAXs8BN8lysE3L8ty833r7GD5ZJ72u99zjpRV0FWEJXgzO6lHAa3gpU
 fGek7AwT6uTNIZB66qvt4UZW1yqBUHzvvZbBpKGYxlbWIwewFU4Bc7s+xohzG2LSBhjN
 CddzzsWQn2TXbdYCzhtfpMynSLpvGNePXn5sA/gWN0aiXKMHhvkXYybxESqy0lyeTVNp
 tfxA==
X-Gm-Message-State: AOJu0YxqoQY+3c/wd12qFmlXmRsliIp6WvfcxhjKVw2TF/tEK6RGnGCx
 MRH80frGk6S2pFLJ4+LBtE/lqo+5RqfMLWoLh5fuWxf2cCqzFWEpoy+FMej8Ki4ebdN4avl+l+8
 I/Lo=
X-Gm-Gg: ASbGncveFXmrAVr9cJtvy6QFCyZSLrmYltLfBe58b3VlYKS+pqozip4o7F8zERvKxL8
 5lrlhLz4OYJvCc8KDzQIP20O91TS1rMuIggwMlqoB1DTNsU7HFpXfb3ByH5a4kd2MSCqdpMoTAB
 ghmvCgngrkB7Ipx5igM28+XmdXdK74yUjjsBRkj/T0ZnIg+mKOPngv+C+w2YM4XtnZAq33UVb8l
 8jsljGAfa95T8V5QXWs1dgEgxQ0bmaqOM+Rq9pTYgp3UsgD+IA76iaMq9KjebUjiqWmAY27+c2B
 kGxc7g2oonxb2J+7hGgB2yC7Sq2LWWlJY94cuBulGDGAcAmAa3ltfx4qFHkESXWK8Ybl
X-Google-Smtp-Source: AGHT+IHsowE3iQljQtRVztR+c2W10s7kD9/fwI7VbQhY7rjMIXyj5G6TAyAKG0PesJc/8obfWYJn2w==
X-Received: by 2002:a05:6a00:18a9:b0:72f:c513:a5fc with SMTP id
 d2e1a72fcca58-7305d51886fmr10447131b3a.23.1739046737141; 
 Sat, 08 Feb 2025 12:32:17 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 19/32] net/dpaa2: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:11 -0800
Message-ID: <20250208203142.242284-20-stephen@networkplumber.org>
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
 drivers/net/dpaa2/dpaa2_mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 2f124313fa..3f259cd16f 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -293,7 +293,7 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 				ret);
 			goto creation_error;
 		}
-		rte_memcpy(&s_kg_cfg, &kg_cfg, sizeof(struct dpkg_profile_cfg));
+		s_kg_cfg = kg_cfg;
 	} else {
 		if (memcmp(&s_kg_cfg, &kg_cfg,
 			sizeof(struct dpkg_profile_cfg))) {
-- 
2.47.2

