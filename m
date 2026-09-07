Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22486C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1918F40A6E;
	Mon,  7 Sep 2026 19:05:09 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 8051940262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:08 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747eefae4so916245ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800707;
 x=1789405507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUbLAWmRiTkn57G0IB2+2FiWtAXCi4BlTB5SaJ4rADE=;
 b=ivabxFQFua+Q6YjWrBuC0KrRMPDOwRkcvMLYb5EQxnislK1ZNPJyhWdrmlmx4e6g/V
 Qde8l3YM5/5lkYNAOqqzdIEdQRBgV+XNhvJAxfSn5/Rh25Q2TZarghvtpJwOWJ4shXb2
 15m61g48I7yemCE+bTVaoAK5us4CZvq01uAdYD2rRUVSx3IZUvDEXwEX4jta8zyEQhRi
 OY4Qv2fgfQUXRQEyDBIqgeVr5IyOOHJEpNuwbp7Ce9ACBXgQjT19SLiLON3pIHzH7sif
 dAZza8hsO91olkYRuTouaoZT+WuFpLNhTtXiTVHdZ6HuJk1Xe8JJ6jD4s6pjiJ4VH+od
 WW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800707; x=1789405507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUbLAWmRiTkn57G0IB2+2FiWtAXCi4BlTB5SaJ4rADE=;
 b=Du6/qYQFEy6QPCTI0AVbqOSykdzoNTtaBjSef6EzRKrDXTeDnyVvyNXfQJz+fHpRRw
 NpFbWvg++AT6fuk8l9NYZT+WnXNfEgdc4DRQfCsIQf70RY7Z+pLoMYtczubQc04U1IAv
 bsihBV7kbF0e5JhcNhFSHRut+MU+B97i7Wt2sN9UfpSAEjyo4bwHGrHECg7YxDaWa5RY
 EgGWWrfjUpvCWFzhr/q/yJBgibUOgw2IhSLCQ8LELY8WYcstumtg56V07l5OVjVahjfr
 v2Zw8Rwn5A0s/LNGzwOhQO2GHNBP91J7GRIo+Pf+KpO0Udkr/5I863JzdR3IyQcNLyDD
 2e5w==
X-Gm-Message-State: AFuF++kV7QbkgJgHZ7J4f2sqq3OUP2vPu3IXM8vpdF020KhsO/1AJpIe
 sebTWtRDViVXnxS0JFcOf0w9FCYKUnw/DgBELwICEagFIFfLN69F/YCHU8cOxwcRkq4gJnO1Pe5
 bZatE
X-Gm-Gg: AYBFou1ToX5mj1Nirp7Sl8DjS8kjTdBNQxU1LYgYHp+wn+W1kPK16Ak5RQp8j+YLW0s
 Z5BSPmIO1AJXq2RfSrGPttNKPiv+c3VETQnuhZcS6YRZH0nxWfhA+Cyh7cYoLVMoAvCA+8Ox86a
 n9LL6FxvSQ9vg8EvRcyXAaXudFyZ6iEchfBu5RJwYp9IXper0F1klxQs+p9J6TCKpnovsNWwRmp
 Elqrn1u+9HOYFzac5sSCsP+a+mT5HUrRvXTKwEmw28zvaEAwiyQdyKVK4OV9DBmc2DirlDrmu2v
 OXg3z6Co9IK1/1ydckZDUmiO9Ky0MiPtSr69qX2mU/9nH3IKf2tAEm0gDHt5h7iymWt4nkktPcV
 k5Xs7+seHnN20WOy8bSTxy0YMVEbDgCinjKUxCPRyKywi6NMGHWUvBNd5sFmQRV3K8PWqwn9++B
 aHbAF4mv/uDCYb6mvMK4CVcc98JNoPXbtFVKxojoCECIkr6wKBLkOoGkQ5ZQMKuro+hYiJ4qotK
 lBNwEMh7YovU+5IaegjCrWd/l4=
X-Received: by 2002:a17:90b:4405:b0:398:9bd3:d6d4 with SMTP id
 98e67ed59e1d1-39b8bf0ce55mr1680549a91.14.1788800705971; 
 Mon, 07 Sep 2026 10:05:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 01/13] graph: do not call printf in signal
Date: Mon,  7 Sep 2026 10:03:19 -0700
Message-ID: <20260907170454.351647-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

Printf is not signal safe and calling it in a signal handler
get flagged as an error by GCC analyzer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/graph/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/app/graph/main.c b/app/graph/main.c
index 56294f2693..d36d60bf94 100644
--- a/app/graph/main.c
+++ b/app/graph/main.c
@@ -49,10 +49,8 @@ static struct app_params {
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n", signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 static int
-- 
2.53.0

