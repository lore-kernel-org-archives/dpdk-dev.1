Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6BC83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CD8840E11;
	Wed,  9 Jul 2025 19:36:24 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 953EB40DCD
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:20 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2353a2bc210so1689155ad.2
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082580;
 x=1752687380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=WISBpzYrxZiBj3zY6/QZ+MKHvS6uRAMJZ6TVRWmnKtAy4xwvnPxjFtk0HhjovQu7vu
 9OUwU9ff9ia8w40xtlfmkAsinVJh5fUZr/4kpZsWUvfG1xUJy617JIwHZRiS2MJ+9Pou
 i0MFtY+XRGn2vi8PxzMLGBcgfiuZ4k/UGHLseB2w+pXXkhpwKuAQssP35jiesHvXSHxP
 Gf/7d0KNBQAy7LWoE46UhFPR9wj1RtKcab2GJwBgcvvC5BDF9FDszUfGSUrCKa6QvXrj
 ErWx30mx6y/UVGcKMf5mfxRccyOLzogaIDV91QdR3wMNnJvXwGaR18+Cagj8jqiYiuGz
 COMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082580; x=1752687380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=MLn+b9jE2XCZYIwB7nclooSDLADi6HKHi8oDSaZNOXDgQZj52zSU8ZMhzYoFBvoxQ3
 A6EoJX7Aqclh1G3xv/lzUtwxaoocpWygInMFHS7selImHQmxYHqzrsdB1ABbsKoDI6zW
 tgmmwNCBNYbBtwicuQ8F4oZgOLJ/Wxsd801Q7ImRDcIIC7xxMJEVDS901Tj6e9KBsZf0
 0S6F8Yf0xDfEUW53dPnzBK82/xw49XQDpmywNJi1UOx06m16R72aQxl0efXtNsu/NT1w
 ysMeZDD4dm0zqJeJ6yXhZQ34BLbDKnfxRhEWn91v6PxyYkDfSLxG7NH+X0AvTD4BY4IO
 HRSQ==
X-Gm-Message-State: AOJu0YwrB5UFLArn2TLCxEEFwuHNUFPQH9C1Eb9iToDENBWupH0/0GGA
 7MCSkLcjWprp0HBcDiPbOxWr6EWfUDPxcrFRlVmjAiIk1O+Iq4FPW0ALCQW93yetnnBPAVqBwqm
 MV6PF
X-Gm-Gg: ASbGncu6KGuoeFd1tpst3qFuLrRF9IH69/Z7QGv2egiWoFTZKdjQ9v9PjNNDgudlsxT
 ElTcUL0SAcz+uYiYpbeC8JuaqD2Yfgkx6IcAtgUL7xXLdk6LVBv+S06v/IysyKAn86qp3Q7fGmi
 M84yLWp/qczaGXXWzGgXbFTEyMFl1WmUUzMr6ykidbHI7ntNSl1JXpDk2i77WwkkAODvyvKRgo0
 v/RAP1xoD4DeUSZjQ16FO2itxLQqB8lQkjJ2P0j9kEMRZerrxgKtKf4ZvB64Dg/ZKpARm+/+xTk
 nF2qPOpOd+2Mobh4dUh2yd/XryL5+kjxv1rbqzsixvYTzbm/54U0hIlTZtMscQt1br4THaDUFIb
 NHsC+ijq1O2Y3paSsTxt0geQUtt3bFLjh7MlX
X-Google-Smtp-Source: AGHT+IHFlpCqsQ97xRMlXBZB77YwpdVVvrLeRGmGGR0Ty/7v+DJOUrAwfEaREpcCJdsTLVMPTiGKVQ==
X-Received: by 2002:a17:902:db02:b0:235:7c6:ebd2 with SMTP id
 d9443c01a7336-23de24d9366mr10890335ad.31.1752082579701; 
 Wed, 09 Jul 2025 10:36:19 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 05/12] mbuf: add dynamic flag for use by port mirroring
Date: Wed,  9 Jul 2025 10:33:31 -0700
Message-ID: <20250709173611.6390-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

Add names for new port mirror fields.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/rte_mbuf_dyn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..72a31b22b3 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -327,6 +327,15 @@ int rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag);
 #define RTE_MBUF_DYNFIELD_IP_REASSEMBLY_NAME "rte_dynfield_ip_reassembly"
 #define RTE_MBUF_DYNFLAG_IP_REASSEMBLY_INCOMPLETE_NAME "rte_dynflag_ip_reassembly_incomplete"
 
+/**
+ * The ethdev port mirror needs some extra packet information that
+ * includes information about the packet before it was copied to the mirror.
+ */
+#define RTE_MBUF_DYNFIELD_MIRROR_ORIGIN "rte_dynfield_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_ORIGIN  "rte_dynflag_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_INGRESS "rte_dynflag_mirror_ingress"
+#define RTE_MBUF_DYNFLAG_MIRROR_EGRESS "rte_dynflag_mirror_egress"
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

