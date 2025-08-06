Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2BC87FD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE88040652;
	Wed,  6 Aug 2025 23:42:32 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 084E54065E
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:31 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3b78bca0890so127860f8f.3
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516550;
 x=1755121350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=j0oa1iDwQK0EiRHz0nYNxqpXlB17iUV7RlcM9S4KSr2ttmy7zTVJShauSHnmf95ZP7
 ThkD96uLlZ8NwzOBdycgc4RiNG0xUAlLXt30m+Ipse5qYZyTr9k3UGvC2cYXncI2ih1f
 eJJr+JbY04nceJVPhHFCpYuLQ/Pt6IaAvvSeNfTzmWkAfKMgEgfryblZ2/f8OICTwS8V
 hA/x4ZVAbaelbBmKVLVa+MVbr/WlC4/TGYC32cyjmZC6Fuwo2ElUKfvWKY+T6BWtf/pB
 yhve9oK3Yx0G6UQSlxozndgGcEVtq92IfZb0/8v8yAS5FDQnFrK6nfHUkOlOIuDhB/C5
 Y8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516550; x=1755121350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=ZdgDheAnisMGvPHpweuFpfrJWyUbY15lYFDq7RAG6e84ym/vkfQ4QxGj1A8ahWLjCg
 9gpRFfqjdauc7OSSTPwhkrl5GGrIEkLbsTvULxsiX2x8wqFS6JagiUD8HwhxzCSX08TC
 LLR+6a+kjxrb6xsXoIhCngniiPg0e2ZLB3cyTopJ/Qq3GD9BHJPYkvjbqHLyz0PwypG/
 VxDCBuQ5xOEucJNIYn4kkWVxcESoVJg3iLEAdr3V4EyrOHSwc8Q/RYHZ2PLcQMOrp74Q
 3vlkgBuecQfPkUiBPE9SPzf83QtxWYVzgOSku0qpkpSbXz0qIHPNt4lV8yrzfVEs5AqO
 GMCg==
X-Gm-Message-State: AOJu0YwF9smlaLiYDbUmCSOAdwXMc4yfYV0hb6OI/RIj8zANHpUId3FV
 SBO8IS9pkqQyOQTgquZgISPfMmhafMwB1kYjBWhPOLb4m30KCuAWzm8Q3WstFHGh80iQE/6v73j
 dk80S
X-Gm-Gg: ASbGnct5npqcU9R785vV88FEmbKqy9L/2s0roSODCZlVD59W4QOwkvO04Ce4UkB27kr
 8PZOYvyxTG0wtR0fPo7juysQykTxYcciRCYldRQQJeTw8J8jbf3CW86zA5sAlTU64UmiiwkJ/F9
 7brH2P8MdZebtxVAlpDQH4EfZaZGOYvYan/qNPslS+XKzAe0FGllOECR9pCBIZs0+z+m6GGyJ1O
 4V2mm8HiKnjT45DYLUmu0+r9KfJNrEs7Ii7Y7G1vwUObFwg727gYKiPe3Re84MUmDliMRyNbtJy
 wKJbPbdyY80YookImA+RpXcseWMykipxx3Wkv9WlHVwhceJ3Y0RQFF+2Ut5QV86kZrP2vHsBETU
 8/L+mMx9wdaVlFBee9vQ+aalcouseIXKe+ns1ReyEkiwD1tgPW30HKPNiPpt7zfqpp7zZh7uh
X-Google-Smtp-Source: AGHT+IEhzFUgS8ftEuMV5pxFyozYeh2uonOZhgy94+yOSeXRn0Ota0mAFUE2b0PQpZpfHk04UPW6nA==
X-Received: by 2002:a5d:5d85:0:b0:3b7:97c8:daae with SMTP id
 ffacd0b85a97d-3b8f41be9d9mr3469259f8f.58.1754516550578; 
 Wed, 06 Aug 2025 14:42:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 08/13] mbuf: add dynamic flag for use by port mirroring
Date: Wed,  6 Aug 2025 14:40:37 -0700
Message-ID: <20250806214200.193029-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

