Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDBD2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E92540A77;
	Fri,  5 Dec 2025 03:30:04 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3F0994069D
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:00 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4ed75832448so22295671cf.2
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901799;
 x=1765506599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=Yv/pCVjFfrneP4lbCj0uVqGDVYWa+WUifGjCFQQ4t9p+toRIirVStsYUhyOpG0rKsw
 4eA8iensPNEGmnCLwWa+UufgV8cr+n8NXC8wZ2fsHtaCeHmCLDylsT1MkNaEKqAzzJwK
 4rSUP6bgJrhlwOdFaSovZp08nKzNfqzcaBZu+VL/Cd+DtyuyeE6Jxs53Gmq7TEECRBsc
 wwjPq2L0nA9QAgrQ3MBMdNxR9jMnESdl102oDonn1jimAxRihQ3ZuOt4jKNQDYdx2b89
 I1Qe7sTQW2QskiaIb7RRIYS6vJVjoXt66bEBHrU3uP2oFrjoQMEXgztWs64wv6l3ZNck
 vfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901799; x=1765506599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=T9LDBGhakTtn+dlrwx6Vz/FYaM+C/xP6jjxGR1RLmxXlwOgS9sHF3/AGmnNChYBuZE
 VTmozvZzZklKq0015lQtT4bs8Rgq15hkzS+kf+ZCpU+YJleuJL8adMg+1g12QFIpRCMu
 TrGbET1ZWsJ9vZyP78oLPzYJjUCgw0gVyncXl1JlsJ0/d43OU9opLYojA0bi6ky6NeMg
 np5p/1vJH9XmVlwoIz0sfE2U0mtp5UCywhujh21sQhBlSGqFJi55IXAaDpe/c/qFE5mT
 aVOXyzP1TQQzfFJNUySjSBAVh6KN6uj2GWeD1vaD7AOdBhLTl+ZCG8Rvy2f40xU4KfsG
 xhfg==
X-Gm-Message-State: AOJu0YwT2iqPa2Y/KuztWh2zq4HKLHkFp9ZIgOUhVXMh8Puf53iTK6Dy
 oSMrF6BE0NiRLBgBNmTGnNcFioAzX4CBdi6tlcXSelfFPtRJPL2HepM9TvuEp8BEmb3YXTW6vvE
 vxSK0
X-Gm-Gg: ASbGncuXVYWxhXi/RDs/tnp2v3x1vL3P9Z1nbq9CqwmgB7vpg+kVdpJIRLprNeGU+Vr
 SLiLpuuCnrMAravL3dMo2Foetn6GbuOBWpbH8xWJUcjT+qgnKbomtjdz1D3IMr1022h+aZZ4szm
 4szeTjChXlumycvBCICidds8eH9j1bPfzuH7/o+gaPkEDpwNrQjtY7/l7oZXvvduYEW/54XsjAt
 E71QDRXy9bqsqP5jdFwERYQ12WOeNwaXxxwyyFxOpj0/zrVcnHWCX2oqfKubt2ejLRnaXhCX4ev
 wQ76JCKQuuFKI7EAmgAhzEDd3ecZUYgV+iUTha5ukpTBEYWBxeI8hMuQTxH92jeYJUTpT4/VeRy
 C4YcTYreHjjgFfj1y7OVz0FJjHUqtlZoo0gSJJCo2bn2PmIOb7LSu+SePt51/3WODjp6Fc1SCgZ
 ulECeJPxXTmelgfen0ZU6OuGu85TKIjV5a9JtBuMww1Gl0jz2ZiQ==
X-Google-Smtp-Source: AGHT+IH4WwtUJxSRiWMLDn3Kjaw9AdQ90OAXBsZGihzbAhrpBkAYu1S/XwFGMcVZEGFuqQOC7pEENw==
X-Received: by 2002:a05:622a:613:b0:4ed:68b:c73b with SMTP id
 d75a77b69052e-4f0175cbae1mr136294031cf.20.1764901799604; 
 Thu, 04 Dec 2025 18:29:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 07/14] eal: avoid format overflow when handling addresses
Date: Thu,  4 Dec 2025 18:28:16 -0800
Message-ID: <20251205022948.327743-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

