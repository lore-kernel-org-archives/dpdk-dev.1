Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C2C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C310E40DFD;
	Thu, 13 Mar 2025 00:27:51 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id AC1D340144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:50 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-223fd89d036so7183715ad.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822070;
 x=1742426870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7OYi0xPo/C+t8l4oCOCWdLC68Lz2uagOv2GLK0qC4g=;
 b=YIEuzQwaz2kJnK9dI3fRqRD76X97n+igoXj7CPM+o3OXvRQxzqaNbvwdYDYf08BLg+
 22f6mceGul9YF0R9EHkccNhX32635IWRLMWpJ87dj7HX2mFTdiybKYbd2UtYmgbc498d
 yhDPejzwOkdwVSsRRNoLISO/8DtGKXD/svJywZvab3RNeVTHhbAU2vbpm6tQky3NEcXP
 /DKRTAFlIhw3mHbOB2ZmTmzJyKdz5SHUBja5meaRPL5MYL+H14BQA63DH4v9r5f0y9rG
 57TlSoj8rNhGpy3ppECQ7Cok7R/4qgAwSnre9xYC3zzru3QVpjqcy2Fifc0xB7G687iV
 /9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822070; x=1742426870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7OYi0xPo/C+t8l4oCOCWdLC68Lz2uagOv2GLK0qC4g=;
 b=sIPJhgYX8aDU4FLcrU/FXIKe3DIilEe5snhJFYWVdt8dGHiBNc4GhaYKanC/Qah51G
 C4cbk+H9ypdNk/LHwtATVFYb5KpjqDyacS8oHzRxEE66MLRCTJK6QBvkiwsdNnGJ/ZT/
 BOPVPKR5ALpLtOkjoP3DPFbBSjoiUxd5uEfvwItZWtFMuUpLW70YPHJpK+s1F5tJcsUC
 ZL+azDIgrai5Ay4ow31klOq4wCXsmEwtz5zbrIs2hIRbAl/L+KK+zi8oYosApWCzHhTC
 KgEHc0jmfY3+PRFZOp3a4iEHCfZPfNKMDfenbDf/lM7N5BdW7obTBCm9Px/Pt4+3vu3X
 sRag==
X-Gm-Message-State: AOJu0YwdnPcU083MEouMvyc7B5P845udyfD4kLRU4ywTZNs7CKExdlmq
 N/1xdezrcy1iaBqCS3bkzrFIVlF4Y3lD6y1C/mOQS0FsIO5FKCb5Rc3749ydQCCiAj4V5sCdaxM
 S
X-Gm-Gg: ASbGnct6079DlhBVL9au6hTJsQKhyq+WLmaCCN8JaGy/2vmHuLwKhUZq+gsTw6Wiwbj
 /9dqDsj/gs4N0PcJf/hZBZa34LPoC4x/imdcGtBYyevc4j2wPGkRtd634sVYFZMTL2UOm+blxtO
 AmUO/4ThD8SqLuLSNuENkqo4betEB4eedocT70tEJebloGSJnCFcZWDoQycITMFaYVxE+ViIhYR
 fk6a7yP85Q3lGQzBTTepZ3vJKczgpSZx4AHAxoxPMaUSMmJT3vHSouJBzppjNJ2rA5P/dNVFcS/
 cgCUWA9Od3fPgfiTfijjkj4+CSduYFzh1wG1sBSjxf3xUG7TksB9j1FPfTdRRvWt+TDd/nWFGtX
 jZhYspycHo01JKjLLv3x+1g==
X-Google-Smtp-Source: AGHT+IG+0kEr4v8H+eaF3B4oMiXyek28+KVfkx1U8Ww0rq/wmhajglclCsQZBPSFTbu3ZiO7020c7Q==
X-Received: by 2002:a05:6a21:6f07:b0:1f5:79c4:5da2 with SMTP id
 adf61e73a8af0-1f579c473bdmr23601453637.31.1741822069896; 
 Wed, 12 Mar 2025 16:27:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 1/7] eal: replace unnecessary comma operator
Date: Wed, 12 Mar 2025 16:26:58 -0700
Message-ID: <20250312232739.228295-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_malloc.c | 4 ++--
 lib/eal/linux/eal_alarm.c   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3eed4d4be6..f07fc3e245 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -176,8 +176,8 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	}
 
 	user_size = size;
-
-	size = RTE_CACHE_LINE_ROUNDUP(size), align = RTE_CACHE_LINE_ROUNDUP(align);
+	size = RTE_CACHE_LINE_ROUNDUP(size);
+	align = RTE_CACHE_LINE_ROUNDUP(align);
 
 	/* check requested socket id and alignment matches first, and if ok,
 	 * see if we can resize block
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index 9fe14ade63..fbbba2780e 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -117,8 +117,10 @@ eal_alarm_callback(void *arg __rte_unused)
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
2.47.2

