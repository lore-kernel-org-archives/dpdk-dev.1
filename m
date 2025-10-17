Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FDECCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:02:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C63042DDC;
	Fri, 17 Oct 2025 17:02:49 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 30BD4400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:47 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-29226bc4bafso5125025ad.0
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713366;
 x=1761318166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxAeNxXIN3oOF0XVXMQCM7FsK3290kzDxIMHQXChHhU=;
 b=gsS45DQ+/FZHGquFpLvCk+XQszSBIVlVOl0k94fE/LRUVknw7e+0Pd5ZhTzCMAjScX
 ShGDlcFRsC7/YZ4CSbEL7BM+BEpfShUTXTvTeyuI0qoboa2Hn2OWeBjicazBnEDaa8Kb
 Jblg2J/1/QSkYLHppdng/Nu7qw1Gy4+M/X07XahKukeXjjJnO0+IGXieyrfLOBgvz4wn
 z6rbfhh1oWTKEHCDytUIY9YPPoS0e04Wc2/PnkOUK/ALOViP/Rvc0E2pJGTxeK9Kmhso
 DsrYBntbnGj43hVib3UdN+zwGc04f8kzz6VSBpgmBQr8xKyfqd8vp+trQji5OQxGYs//
 6Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713366; x=1761318166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxAeNxXIN3oOF0XVXMQCM7FsK3290kzDxIMHQXChHhU=;
 b=RrjbE6Kqklj2BeaQ3c1vBFkGsTcYDnRWgChhNOaoO2RTvbIFXPed6qH51LDo++nrr4
 Z6auBZzbsiAPwPT05SmX25OzTTsYn3tW8dfMCR03NMQow0l9exjxZG3pUMehr+ybb0m+
 T/z116bx+sJ7r1m8RVcEt0i14MZxlGEZGvKzTdCMT7O7cnktzJK6yapKqhGW1Hq4TuE9
 yyGoU6KuzXzkuF1ECEryloW2fT6yoQIzW9i7jtIbJslR7wbTRVQxpRCC7byG6bcaBcuK
 GHBVf+7r/UyyxAdiHMdHsF0wLWgG4M+ZKdLpjgvlqfP1Dk1zME2D+e0PQhgMTWZYCTMZ
 s98Q==
X-Gm-Message-State: AOJu0YxHw0lCDjoLp68Bd3WNas7cJNonnd1wFpX3ISBWtUZwbybr7i8G
 jDUZTVmXmmyCjaIBAtn8D44jOAKNmpadwamqF/q62/mKA53oD1F2PQlyIDlOfsgHxEW4UaxVQuO
 yRiF4/b8=
X-Gm-Gg: ASbGnctp3OBsFErDSJB6JX0z4WWmumaYBmx62d+yDVMNSqFiv5kp/lthONbW20iUc5g
 RJmVUdhKSSzD8WlTdv6CFHSedHmWEydWCr1WNZvON/oVzLi1fiLBDFcRZFUC5pFbOl0lFTIpObA
 mrXpgWnOc/D1YuhBhVKlcBHjJx3DmydMmeaFFsy1Ku6TMLQQ/FrzmoHPpHa1ThpuWiIgY0NMpTk
 TmTbuWlojrYOfp2HZBsOxinesqPO0Fl79vi7MVDKd4/p9Ac146aTMB46jzr1BvB/FZ42v6hJTv5
 syOROJLfpamwDBZoPtEJnJWkQgj0xyrDzcWcLo4naL02wPYK1fH4oksu+2ig4fQy8vbnhTD2Jz4
 N3522mPFD2+fNQT8GVg+fhPXshZn/xx87WcxFRgSbDTmy69sgsCCU19ImgLbq9ugUdTSWSsJq6O
 XLqOS1ffslWFYPhJDay9ha0wktdFMK5WLhMVPCPmo8V6kOm4VbjQ==
X-Google-Smtp-Source: AGHT+IH43JaqCsGF+Dg3g3sp3fOqNdl9z8W/tp37+DLwmkqQaVKU8i5EzNWGKg7gbWgE1DxG5GswRg==
X-Received: by 2002:a17:902:e88e:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-290c9ca72bcmr57384575ad.17.1760713366292; 
 Fri, 17 Oct 2025 08:02:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v5 1/8] eal: replace unnecessary comma operator
Date: Fri, 17 Oct 2025 08:02:02 -0700
Message-ID: <20251017150241.28511-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/rte_malloc.c | 4 ++--
 lib/eal/linux/eal_alarm.c   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3a86c19490..388e5a63b6 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -202,8 +202,8 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	}
 
 	user_size = size;
-
-	size = RTE_CACHE_LINE_ROUNDUP(size), align = RTE_CACHE_LINE_ROUNDUP(align);
+	size = RTE_CACHE_LINE_ROUNDUP(size);
+	align = RTE_CACHE_LINE_ROUNDUP(align);
 
 	/* check requested socket id and alignment matches first, and if ok,
 	 * see if we can resize block
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index eb6a21d4f0..a1433eb867 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -125,8 +125,10 @@ eal_alarm_callback(void *arg __rte_unused)
 		atime.it_value.tv_sec = ap->time.tv_sec;
 		atime.it_value.tv_nsec = ap->time.tv_usec * NS_PER_US;
 		/* perform borrow for subtraction if necessary */
-		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US))
-			atime.it_value.tv_sec--, atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US)) {
+			atime.it_value.tv_sec--;
+			atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		}
 
 		atime.it_value.tv_sec -= now.tv_sec;
 		atime.it_value.tv_nsec -= now.tv_nsec;
-- 
2.47.3

