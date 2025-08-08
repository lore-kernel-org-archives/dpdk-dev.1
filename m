Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E50C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A64C409FA;
	Fri,  8 Aug 2025 18:59:06 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id D39964069D
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:04 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b790dbb112so1394273f8f.3
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672344;
 x=1755277144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=g9YxYl4msh7MB/ExTWRHZHCwkmqZxqwdkZdd3HFVjpSKEL843H46PjXivP9auLeOIh
 NMZK59NgoqNkP1PAKZ+0VuHkXdAeKbbjTJcjbeU42QstyFKpIEcqQjVIexna2cFNpy79
 Cp5LPT3WQ2xvuTg9s3DodF0GHQisitZJmApNvT73UZPqXGOLxVKm6HG48SFftSCvxI99
 jc4QPU2Y1RZIRDP5skybido4NNa9HaUongEz1de86SqSa18+bEr4GxJowFQ9dRr6XRp+
 FR2VFL5+BxTW3SdJnN/UGjBI7vTZrg/NMU3C7la4sjF8aaeItddZYFPhPg7XsP5gJ+ur
 3/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672344; x=1755277144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=jhTi3XA6MW3hYHpXbklHyF4SGbdfF14WdnC2sjmar34dt8beyPExhXwvqoY5zAv1gh
 k7UPzYS1gGJppPwHflOJaz43Z0+bPDshZGHz/zk9Jx5XJpkfIKDDHll2D6sytuKjND3V
 NlvCFfjW0uXr6cUhfYUpftbJMZyUMBk/v6WsFpdDTr9EzKzpgp4V1vDSrF8LhSx9Q+x4
 X9YiYg2nzWYvo9slteJLnGtB7tGxKPtSy8zDi1anxEQE6s306PSOlztrH7ghniMdQOyz
 wZtMj8BDBQKhXlswlyaMqVVJP1gmgUe0L692VpXewo41WOfgD4D73Py/vRbbH1YZPaYV
 4bSg==
X-Gm-Message-State: AOJu0Yx3WvB8YELcP7+8gV5Uwt0i2Cmd5B6fGxn3C96rBbnydiV+icTs
 BOJQUS1N7B74KcwiQBDu3HSPaFc8rEN1+WH2smELYo24aXZrDh4Uc6kic1GBKBOttcCEJbBGeP8
 0c4q2
X-Gm-Gg: ASbGncv5LpU4qJIcPgQW26CYxO/spa2t+bwUBK8w1XMOrJuza2VPndtxaYL1HUo3q6o
 8lzqxrFYzjkZjQRBe/H1A3IAJcW9HCuovYwydnVr5IDVyZYb32hGwTMj3PfKTVO6Cjoc2xbwcEQ
 zkPYMuUhsYHKI4e272m2guddwh6yNYLqi5Sv7mZ5O1Uq0xGCslLmq3F4TXI5frxqloZGGiUej98
 YR+es6kP4Fz5JluHGrd7+aHyZrTzM4kpSJ6iYgEY5i4TmUNX48CBM+KPow4mktLU+9H4ZiJSUJS
 +cLz1whrHGcBHUoNlAbELrfe3YbWBmftIVgIiiLDZEaSe+APzkJ1Y1tmBHPnEcDaFUH35LnDOZ5
 zYr9F8444R0+l5OARqVRK1FnHsACFPHxnz+ObVR8zo19P1D/t01yCmCBzkcoYcRmXnGL80Mla
X-Google-Smtp-Source: AGHT+IFRN7pqtSbAW6LTyO3Cp0pth2txsyp+ZDiR6ywzKRuuEbZQqu7r8aGPkdEqAdAL/5FhjfeDxw==
X-Received: by 2002:a05:6000:22c2:b0:3a4:dc42:a0c3 with SMTP id
 ffacd0b85a97d-3b900b6ad72mr3239144f8f.56.1754672344430; 
 Fri, 08 Aug 2025 09:59:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 08/14] mbuf: add dynamic flag for use by port mirroring
Date: Fri,  8 Aug 2025 09:55:46 -0700
Message-ID: <20250808165843.39075-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

