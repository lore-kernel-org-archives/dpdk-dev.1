Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A7D2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE2C40693;
	Fri,  5 Dec 2025 03:29:59 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id DC70E4067D
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:55 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4f02dd964feso3846781cf.3
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901795;
 x=1765506595; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHfpngJsPBB1aice1mKsOtXuQPDGGzxV2T65XjfPegE=;
 b=ASQ2sQ8gmCI8JZIGaS1ngbgxenQMJNb6TYcxMotx6IrMIBlHvzaTjPx8xakcetI8dL
 250+UvuGzz0ruFTlxyhSwZ5aJ41fBEK+mxqLgU1B3f7a2MQ2H87/jRyg3LoFacNVbitn
 0hFzDA26UVSnISde9fQ2NDfsSONcS5s3tzmhSqm6c+x15gj7EgPO5PM8pZWz/e52Ajy5
 wI0NMosic2IEY9bAqyUitLnCOZzt6Z2iWVaH6voPCNMG5zOEpeEYQ2eAUQAIYQEiygtH
 Ez5EWe+xRqlvpp5mMqzOo7ksfc49Lkn7bEfWG1LBFFONFGJaNOdDF0rl+X110bqegjdT
 t0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901795; x=1765506595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHfpngJsPBB1aice1mKsOtXuQPDGGzxV2T65XjfPegE=;
 b=EP9upg3rZG4KQPN+I7SjC2DkmDJSxIemoFlTdCRJumaAkTJr8DJ1vPpcRVw7xZ+6Ci
 vjQlMWKD0v8iyTcJB+Zd+OXdRjXyvhbLWV4EQNgpXW6uh+HlRaieNUp4LyNAz3bG19iq
 XyK2SsrRtBhC76TN4XPiXYEy6bUDPkh1dYGg8ZL1+vovRKdYBply81K4RENaKWjhhdU+
 0Akec/1u2hCfc3bD3GIOYAHvhoCUAnGJbE1W0QVmaLgJjcm2VOgXUYHV5PGv1VRVG2B0
 ucBn3tMraGMt690Rl1TjGJb3Ie/jNG2lv2TAPR9MNEj5fZtJ3fbn/5bdSNPYiEWo5ISl
 an8A==
X-Gm-Message-State: AOJu0YwKpOBPt4sGzECm2py6Gq1pIfXuSnzphELEsP/bXb0NKivJqV+E
 pZfGi694yphXxfqAH3ATLJu7dZYRCnc5yViKQ3B25riPTQdtJvbEzv3Hs3LcZazFxtZhVcC5hJd
 mONja
X-Gm-Gg: ASbGnctg3w2EPyd91Rz/Fw6c+W/IsSwuqqlAekyeORb3SkmPp35hFoL6xF2HVLc5WC+
 BAVffWlwcO4q+z+VYwVpbGsLev4tCI3MlFQbCl1egkqGtO1BkgaIOo2Wz54XHMLycmwtrJ4TKJ0
 q7JhTrdGELKyuu4tyxTvKOjc7HP0Qliay4yFICc3VPs4wFg4af8dtsfM+6YtncUK0lGfz2UrUhi
 2dt5Dui2FcrtqHSCPXk+ZXw5BGcuTp4FYQrTRP8RFFvt1fhU7dlDdCt3UeNwpzGgDVC4p4FSM6Q
 Ib+hnQ9ZhsZMVBXx9cXYNxmuLHGJ5ELIC3C/nIW6G+TURUfdnq7kbQQqzpe/TVjjJgMb0HYKQL8
 Bzwc2IqHg16UBw5DUzqqNWgpAm+ptfqu7n4/lmoUfJxFiGxtQVPrqtRL/KqzsP11yS2FLH9+l6l
 Tq+JALjUMiSGkzAWg7MUluM5VYAd4NaBDc8u4yCNq6c+DA1CpJ0Q==
X-Google-Smtp-Source: AGHT+IESYIUIqRnBQ0c/BO682FI0mEnqdLfkP31f1lf4OfrIdepvlKDXZ/Ft/9XHx1G09Hj+B8CLRw==
X-Received: by 2002:ac8:5a46:0:b0:4ed:a9c0:1e30 with SMTP id
 d75a77b69052e-4f023a12961mr66979201cf.25.1764901795210; 
 Thu, 04 Dec 2025 18:29:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 03/14] lpm: restrict name size
Date: Thu,  4 Dec 2025 18:28:12 -0800
Message-ID: <20251205022948.327743-4-stephen@networkplumber.org>
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

Since LPM uses ring internally with a prefix, limit the
maximum allowed LPM name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index edfe77b458..21a93b7e44 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -26,7 +26,7 @@ extern "C" {
 #endif
 
 /** Max number of characters in LPM name. */
-#define RTE_LPM_NAMESIZE                32
+#define RTE_LPM_NAMESIZE  (RTE_RING_NAMESIZE - sizeof("LPM_RCU_") + 1)
 
 /** Maximum depth value possible for IPv4 LPM. */
 #define RTE_LPM_MAX_DEPTH               32
-- 
2.51.0

