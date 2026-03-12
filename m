Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D49103E2F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 00:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1D7C40ED1;
	Thu, 12 Mar 2026 01:21:34 +0100 (CET)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id 7FB5740264
 for <dev@dpdk.org>; Thu, 12 Mar 2026 01:21:30 +0100 (CET)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4152698e745so223411fac.1
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773274889;
 x=1773879689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDOpUOWbfiXY09Bhjt9SnMDFoZHw/eJf0zuQeJ5dLrc=;
 b=Sl8CtnHhAgxJhzR1cpfYmP4OoffF9ZqTZGCVNglCw55hsjYJJvtdp9nNgsNJCndUMS
 mfGtCjwYu8YCCrT/bKGik4cYs6d75IN8dOtqj6Te2X63bXaDGbPn9HWkHMHFIksFtPl2
 0tJ+7JQc32ClXYua86LRWu6elJuV5Khb1yWzcUlFs2LF/ddJv7eJYsx+WHXJbQmaWy6b
 1eFKs+ZB5xkYIavYDb+IgxnlsrEXVsD0BnmkP5KBoHg1UBBO2Wq4PJpa4gCFkxEmFPHW
 5QMxJVZpU/xib5Wss3gtHVHwESX7P6ofJXl5nDQmoINiYUs5pNy9lDfKd/XiSbLsevB8
 awXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274889; x=1773879689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UDOpUOWbfiXY09Bhjt9SnMDFoZHw/eJf0zuQeJ5dLrc=;
 b=VrAhW/7JJpqTl/zVK9xqPurDAc7azG9m3mbXlYFOxRs+78EgwLVgtgRx1nE9FByIDZ
 Jbe9eq8xyiAeso3XL4b0DvY/Ai9dl29N87cDJ7jav2sSxsCAc7E/8E0Z59qghCRXAkNL
 Z7pjtcyf4HRT7qo+lwWWMev+pKM8Db4P4RLG2W+UqG3w07JQlxkmTGwCbHMffyzR/hYi
 bPcq1FGaK9Jra9a43uTBHspLRirHPD/fKrrN4U7/8MLQ3Zi4SqgC9tPPKB9CPgmoGHil
 B2f8itTXybvZK9jhq0zDHZxRSAhZuYR/6HYdtaz3lHWpFlqmBoX1E8m1SLjsBE7qsPk0
 Q12Q==
X-Gm-Message-State: AOJu0YyRWXmJHGPvulZJOnm9y5ukdUv6avD+eCZFJTvePW9nE4vdS51S
 yeBYuubj5upDWDUQ2w2P4GLdIySy+lXDmzxFVfZtZy/Q6HiaiE2owSPG8AKVBwg3OitkRXEKRvB
 1mdYGXzA=
X-Gm-Gg: ATEYQzwSrzXlMdKipoO/TKOj/AphtUwzC/O61cprYr4dFuZjcmqJ+xH4Hy2SW1yb3pM
 wXiKj3agMXrDlHyCoQpfrpiMKjCEisZ4w6nDvUS5nfSVru0gXh+iHImsIV+haJnoz0KG4nxaRl7
 X8ypkry9KXhk/fitd+mYOVGs+e9fuT1nhdvzUibPjr34hGg6RK1CtGafuB+nz316Zwc+X+J/4aF
 2ErWzoR7tiMq8gClpphmr7vd8Y8sAEFAR+CU3Jq2dGFHk9MqG+dhQFQxQ3qrzG9wOnTfujZ4ooW
 bhC0fuP2U56dZkPckV1FU4FJ0cDgxh+vH/vWyxENs94eZvqSSZiQ3D5D3/JerNVH/ZWCBVVK/uG
 zeEgOxHYDnzJRHpSrMZPmFkpwg4HITAs9MhwzsOEx9qjx6OZ6yb8c5Du4L/XQaEutoONnpCW7vs
 DvJa6WUBEHIfOV/IK7eiRCzagDaDJji08Z
X-Received: by 2002:a05:6871:4143:b0:417:5c29:ace7 with SMTP id
 586e51a60fabf-4177c5c8da2mr2797612fac.2.1773274889421; 
 Wed, 11 Mar 2026 17:21:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e26e2c6sm3779484fac.7.2026.03.11.17.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 17:21:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/2] eal: add RTE_MIN4 and RTE_MAX4 macros
Date: Wed, 11 Mar 2026 17:20:26 -0700
Message-ID: <20260312002123.867357-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312002123.867357-1-stephen@networkplumber.org>
References: <20260312002123.867357-1-stephen@networkplumber.org>
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

These are analogous to the existing RTE_MIN3 macros and allow
drivers to take compute minimum of four values without invoking
the shadow warning gods.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_common.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..79364170d6 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -812,6 +812,16 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 			(_b_min3 < _c_min3 ? _b_min3 : _c_min3); \
 	})
 
+/**
+ * Macro to return the minimum of four numbers
+ */
+#define RTE_MIN4(a, b, c, d) \
+	__extension__ ({ \
+		typeof (a) _min4_ab = RTE_MIN((a), (b)); \
+		typeof (c) _min4_cd = RTE_MIN((c), (d)); \
+		RTE_MIN(_min4_ab, _min4_cd); \
+	})
+
 /**
  * Macro to return the minimum of two numbers
  *
@@ -845,6 +855,16 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 			(_b_max3 > _c_max3 ? _b_max3 : _c_max3); \
 	})
 
+/**
+ * Macro to return the maximum of four numbers
+ */
+#define RTE_MAX4(a, b, c, d) \
+	__extension__ ({ \
+		typeof (a) _max4_ab = RTE_MAX((a), (b)); \
+		typeof (c) _max4_cd = RTE_MAX((c), (d)); \
+		RTE_MAX(_max4_ab, _max4_cd); \
+	})
+
 /**
  * Macro to return the maximum of two numbers
  *
-- 
2.51.0

