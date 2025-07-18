Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB9C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1805340E19;
	Fri, 18 Jul 2025 18:32:57 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id C09C440E19
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:55 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7dfd667e539so251162185a.2
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856375;
 x=1753461175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=3CCmSCkt27ZDS9PtNYWzmLIgjccN0yDLGAkzoJfGwPNFdmrxTGCnFpYIXzOizbakj9
 DKIpxq5dF2x1sprb4cpfLrACh6G/Wvrcs1ROYfl7uBLL6Vevd3adixoXWhScBoIm/TYR
 4pvV/tp+UQW9Ic/ecDFT1EKF7p8G4u57OMINXkTzLA2PqgqtBcqphgSEsC08U0Dts14j
 OSjVjFMIbczbwJlSmM7t65K0d8apSs9pXkCPcwPomAz0AnQKZS7di6Utv2lg7J/Hn8ig
 /KA9+Fa2E3gDT4YM8S+lwdBaFF5hH7T8aRDzOEh0re1LlbSItfDrMVkfXnCvHr3Zo03M
 65/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856375; x=1753461175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=Y0LSpuna7gWUiAWn6xNn9atZC0OhgBc0lfmiWokw12shR57VbZmL2SSo32BC43htr9
 o4ACBpIHq5IaRsL+VeUTptIxVZgegMwjkED+YcDrgaKVVaAnD/nd+AkEOBm97ho+nQtW
 gHDm6G/dE2oUi9h5uLl2kOFOAqAHWnv/sK8z8kYBflaboCw741dwZWneqkBGdRtl6+M6
 y3SQQk+aaJfsxOavLbrEuG5kVCba85/TpLwNMxIXAhfWgTiC7aCdCiuioayYfb6yM4XX
 qgkKNpt4E0KO5wN1C9jSrxgSYtVJGRvw6fbDGC0Sz3frpHdjL+yj6tr6mzQThFPS2oin
 glmg==
X-Gm-Message-State: AOJu0Yx7neVgkH9CX8BWMpAc8ny1NscBf0aIfGZkGEaDHmNRbmit2wlB
 8XKmbgIdUoA36Nr2JdRkXVcDOmFFqul2oMlUBEI7vtcB19mEPTXVcaEGIrZnbaaJdV7Vlal67fr
 1N4Za
X-Gm-Gg: ASbGnctZKAzbXxqnAS3kjkxPT9XILy/G7ahyr05VpsmjXhImDXEFpBJJam9wDRc7URX
 8VZl53EHU1cSyNKllABSK7FpxhLXsG2g87giBRp+t400QWEMtsRqifdDMBttYy97zrAminnOp1f
 2na8kzgmfhlRpwck2YJg1qKyJog0RMqj3q6jTNENKHAmQbqga1veUBC9zMShRVHhiesjeCuIMlC
 nWtWkTFvfdvvIWHCURLsFyKcWN12xm8FsWiw0Kqbw96oHZlmeVIdZjletq0YRWV2jQoVBtAMn+t
 tM5PUZsMBoF+mBxern8Me3IgknkCIXXsSBpNRUOizME0fs7wsCRk+gGm2h0T0ABme5xXo846DDm
 g3FkpLPu0D8BvxnE1ZCZ3Jw3Bq9oQYveISeG/y3Ck0zaMZhDUsM4clCv5cX+yvJvLKM7BiL8w
X-Google-Smtp-Source: AGHT+IF0BieSgL7/HDOHcWOBdqvjcVj/Twj+zJi43nPr3Jw+rL77Bga8iMvd0ma96ARsDVSC8JUUwA==
X-Received: by 2002:a05:620a:4d91:b0:7e3:4416:fda with SMTP id
 af79cd13be357-7e344165897mr1336217985a.61.1752856375070; 
 Fri, 18 Jul 2025 09:32:55 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 06/13] mbuf: add dynamic flag for use by port mirroring
Date: Fri, 18 Jul 2025 09:28:23 -0700
Message-ID: <20250718163236.9870-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

