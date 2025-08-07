Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F3C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C6F40691;
	Thu,  7 Aug 2025 19:35:05 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id E2F2F40695
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:02 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso716852f8f.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588102;
 x=1755192902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=Uz4NF2dDnhIPdRXjC8EjGv6DG+BlMqpQ55bjy8uNC/POoPx/v46rEwjd+a1V0Y3Bi/
 lbKVp8RXXqKjWdovNr1Uwf2ZF04DK1zbJl9HzvxPdiRd4LnwSdIHeTX8RIaIziQog5VY
 SUiCa5d4koJZcMtIOU3u6xMmJJO34YECiTFmJ4Q5h80GSkvSpgvrwtk8huEe0YxF6W9e
 7A2wkm+y0W/ArZCJWdf+Z7hFLeu/EDLYPOasREkr79c194ItBG4ODcjBx95Z11It1/cF
 D2rtf4F3PoKoH+qJdhK/RhbD2XBpagrBNVh2W/LIqdLNwOL0XHYUwcrVIHGJbA0DXJAo
 4yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588102; x=1755192902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=F27U873g+V6jFxIJAFgOhdhVc7+gydLeEvefWLB99Z+OH0sT37otM7za/ld+0poe1E
 WI2AUPAxt5/2OXY1WztI9N2k1YsEM8A1epUoxsti98b5BYAMjL5qAOdo+Db18IQOLM2x
 /9uq2Y1xY5r5XAYZXNuD+Q1W2MQpm6HTuPdOPmOb6fspZnNPgG0ML9dBJUoeOGwxeoZm
 7cSr7JEq9s8elHHmOdLsnkjQGacVxGW5chIvNeTsDExKuHFv3vYXYUS8D8NAPjRT0J5s
 EMScdpK5YbcQYDJnc9KOKw5pGHQPqUBjk8Bni3kqlGFGdlsxmeSMGwv13TwiwhqvLTTx
 t74A==
X-Gm-Message-State: AOJu0YwYobJHhDIVVLbUkv15ULZuMr79ps2vbCaXXQihl1cl4fOcPeTr
 m1ZHaUkyPmkAxb85TB0VryD7RhQki4MZ0E05DF6cUhCDDqGjIqRpykNDL8mPvbKNq7qcm0hChWX
 4vgZ9
X-Gm-Gg: ASbGnctiwMeGIYVUiY23YHpVcz8ofPqmgbX5GXumS9+Wb6OSiwSikjzc/4p9dRXwKc+
 QMvuViTjSKYyogXgIdxP+mZX9nYAzCZYsZQq5zT03HKGbbdxWyuruuiSMHi6FfMyRtUa+pj0U7e
 1Qp57Emp28CxIPrcCCwXk+/wr5gn3Jg2KYxR4vPavnn0gVYQdj08y2DWrTrH3Vxt2jVa3G3I7vM
 bpCU/Wco/9GGVYVRUSJwfpUSyveEEib8F6wcv6AaCSnqsYrRsDlcYuCriWWO9D/ZBLCMZVtO0+k
 8cYgCKXyKraT5oVi80trUwykwCGxldNxBlNqUm3SAm2Uw+Z+e4MXt+oNLiK5LVylvb0jJPdflPP
 qvR9bnajbYmB9iQyls9RDOeSpRRN3doQNOPT/g2kxHLoMtWTK9fz4r19rCo504c7TxPtZcEP2fW
 5NT2kAK/M=
X-Google-Smtp-Source: AGHT+IEKAaTZcZSMeHyYg/2ydnruw7kTsw47MSlZ0R/f7VqR+ZAd6tIJLq+MX9gi5eIngsbHO9u2NQ==
X-Received: by 2002:a05:6000:1b88:b0:3b8:eb7d:f82a with SMTP id
 ffacd0b85a97d-3b90092fd2cmr119296f8f.3.1754588102446; 
 Thu, 07 Aug 2025 10:35:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 08/14] mbuf: add dynamic flag for use by port mirroring
Date: Thu,  7 Aug 2025 10:33:22 -0700
Message-ID: <20250807173437.11442-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

