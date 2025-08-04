Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E310C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA1A40B91;
	Mon,  4 Aug 2025 18:31:04 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 18E2240A7A
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:31:02 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so30692625e9.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325062;
 x=1754929862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=BC8M6S5VjtGbTfDG4yt5P8aU2EH1Z1JSKNrJkwe8qafKT/5UGjdVGJn6Q4PgLAfjVY
 ddbWc/r9tOgqUB6IofCV0KO6FVgcFEsAou6lbq2HUal7KhdDYSz9ugSt8+ZqGCd7Cj33
 sX7q+zzHOrCd6b/FiTTS/nqAQSHIKnPgU2F7/VnJ/66Ili9MLpYdC2R45zaEP02Our4L
 UBlAxkDbpnTqhF4oFKLWvSU6tDKKIU163jnFqdqP2VeA3S4OpsonBoVwNy4WJhbWCPWU
 Ywa/ty4ybtkD39wbbDHEIn/mfqdk8ouheGXoueS7qiOAApfhl2xRVMyC5hBs3A/y0KxD
 PUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325062; x=1754929862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=ZZjF+zl08alvqTZABie2EACgugKo6lVuzPsrc+Q2Q3f5q7X5IEC2/qxra2145ETmNM
 Xn5r2OptX78cr/hlmSHsUGCNG+cOvVR6kIXbvyjgjF25Ub2QBCafPI4/Oj5ntWa1Lyok
 HR2p1X6V3L3b9q8exSadaej+IIR4ob+R1BEXwuXQrdceucfNyDghvpavEflJ+CcPBV6A
 E3y1qsRrKeVbeVOTw8Hvf9egMYCSyf9fLTOqyYvgnsNVm7F2d+O7sUKB671EcydijEV0
 7QP4RS3cqILU0sGDd+kqoteHRHZXXDsQMMDXTbYFJPQk6Fjq4w6rb8xGebmIg3Q4j1om
 u3xw==
X-Gm-Message-State: AOJu0YzE7U7/LsCsE8S7SnknpuHNVDyX9WizcVtDsd1QcO9NhcvZWkqV
 zCa7d9GOEtAftkNzMNAKaOUtfyNGBWD/ncbhUvqTrr+phNo6E3Qv9FiUkBYyeGN4ILPY4KG2zOq
 vtdJc
X-Gm-Gg: ASbGncvU5n9NOJTXsaRYUDwyqJ6IakgrQw0kztS3k72ic10inHt/rH0yT6i5LSa1Mla
 MBE5fNl3KFUTHwvH6C6dpiJyofRcXapsT2UkdcZ9sX8sSI4EKh3qP5jNjwpt+93+4uC1lVKp7c2
 MLCZ8TeskJjQdcWQyi8v0rPSmKBUjuOnlOykJbo2F2rIo692al4+3B7eoZzkW+hHUr4MPabUzn9
 6A7KIwe18xiSzibuiasxvTAAArpYlbFfgg90HCEo3m6qws8U1AdRL8aLlzsKrjOG60LDVeFK1n4
 33Ky8o2nEyjBPhp0XbR1BfBPgSECv/PIkmwArNMqdH6rwt+18RL+3SCPZYCFyM+FrbWDv0aJeRp
 oPtXVeIroZcGkrKT3NpvoJBdwh+nzmFFK+VWMPHxDTtEm+VjSH/9QP03l2xZjcb/LnwYoObZP
X-Google-Smtp-Source: AGHT+IE4KK6zxsPL4JxlkoLGXqbljdVBZyC+4ppUYJQgLhDkB6UiNlrWF47b3A0xsxU3L6/gIbwRmw==
X-Received: by 2002:a05:600c:1554:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-458b6b31276mr75776535e9.21.1754325061667; 
 Mon, 04 Aug 2025 09:31:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:31:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 08/13] mbuf: add dynamic flag for use by port mirroring
Date: Mon,  4 Aug 2025 09:27:39 -0700
Message-ID: <20250804163039.138959-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

