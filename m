Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B90C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDE9140B91;
	Tue, 29 Jul 2025 00:10:10 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id B51C840A80
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:07 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7e63adcd6d8so343970085a.2
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740607;
 x=1754345407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=0xNxsgUnJ6g4HcPoOK3IJ58HYE3kLBMdZhBp9j/YJ4RkAoEe7UuoJCKbjcwl9BPurn
 gro6pNPb9MpVq64W+wj8jct32coLU/3WHZIqz6Yt/7oe47Nx0Evd3VLGbMKczrnWptO4
 93yMtv+srHaBSY6U4SXadYHM4i3p1hQLerxUdxapdpOG634u23x0rsSTfvDQjgB5buGN
 U7yLTpJmXS5oMPpeCMmPkL/JkvMwT0fvoqNQ4rgwtc85Fed/Npy/RrFzhQB45X8J0H5J
 IRT0uIIoAFtF/nwRUN69zV+xS4Z1VQ28PcgusvfpOoHyP1Vxw4QRb2NXYcWLdWAB3Y2s
 NjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740607; x=1754345407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=FlXNqEmzawuTDKF8abkT/49ipoGyi2mEg8bA+V53a+uVEhXcRly1OZiXqjW4t7gpY1
 VSs2Nz/qkjtU2f9nNn1Nrk4miR+LPwnE9A5CA7EnEMwVINx3Bm51Z5qMheOICCvRv3e8
 zsYhctktuJShermvaWxcd71iOp/kS7QUYwVjpRMiOVZNPhL9EWenATa+0BIlio+WjC3A
 KtV4XrCPtkTrzGJ2rvuMK1BHUJvthm8Rp20uP0UqTt5DJ397xsfLWkNel/1Yn3nIV2qm
 PDrfyiZtL3tPxyM+6701HqXKBKQKyDBJOmxuBg/WbakvpxrRvLEHYxqpVki+e0Jnz9Kc
 /Yiw==
X-Gm-Message-State: AOJu0YwLU0scPzBD76TUq8ZLbYsagQgfSkjWdbY9A8Dq064YhPY9WeYL
 rq3KRtyIfhIHVPoUP27EfrPtBqUpGVjRQHzFMgCSU9I0V3D5DT/2i7nVFQnT0BKCsIqyi0oXASJ
 rH/UO
X-Gm-Gg: ASbGncvPRTpFWGXtVQtMjouYUY8WIrEtkUInXOZ2xNke9y4ckap7hgNLq62VpLSKfQc
 xcklRKUhdL8RKg5zViFtSNmNS/WT40H5TJhPTlnXFdMiSeRhhYScQiCTK8IRiVU29w+eKuHd41H
 JA3dGG567mqduuLA1kiV+xnT0tI8pZlHTxtlU1GefnFzzjG4EFRvqHZSe5LbrP+/QrZDvpgropX
 QYp/eBYmOS1spGE52SIJY97Tm4NTh2j2NUgBUbY0zwbDFZEiyqAV8tqKaFLVglDXeHWyC1WXASV
 A2esPJ+wmH40f+jnWOoUehsGb5zzfLiZUP2y8+S3oUjZEmQuPc5uguhn7VXzg0X/GL9c5032r/V
 zRz8id+F+SsMgBo/IpK3De0/sbGQWjgfGRquziAWEjKidAzxI6zjSODX9bbwlVGUpochcLxfk
X-Google-Smtp-Source: AGHT+IG8yG+c0+o18tQ9XRenEvHqK9qG1ZBvt6f0Pg2jkIMBBNm6YlSYU3cMixB0/L5JVmhHZ1w/cw==
X-Received: by 2002:a05:620a:199f:b0:7e1:4bec:91e3 with SMTP id
 af79cd13be357-7e63bf7cbd2mr1728853785a.14.1753740607060; 
 Mon, 28 Jul 2025 15:10:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 06/12] mbuf: add dynamic flag for use by port mirroring
Date: Mon, 28 Jul 2025 15:08:14 -0700
Message-ID: <20250728220955.332924-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

