Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CB6D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB5A40A80;
	Tue, 27 Jan 2026 00:24:47 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 80ABB40A84
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:45 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so39721995e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469885;
 x=1770074685; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=C5gfi4oWlCWuFHS7RewUA3phso1M4hZicuV1Y/h7sxizhK1HGg26egvKKSqedHfRKu
 6NyZA3InhBEn5wnhgHBnfdRXHQpf1/e/her/y5XAyDF5eNFubW9RBjmLfDhCESst9icF
 5Hc021viwZe46+Ne+Ksx7aG3B0xx1WUC9gf2gbn9g53HLCehE5z+qRHp+WTI+eugrT+v
 dnCtDpIC7Zd0gr8uK7AyvonWQB9TR1pF23RxjKPZdodcg4Ia7ej2Ep02UsItIZnvyXzL
 MotnH9KPhRD7ZZXuS26MS8XsXIbM869DQpN7t67QsViqb0g+zLIatnFTsySl2L248riS
 P6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469885; x=1770074685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=Kyz/4xTzJ6HqDY3AywBfW8sdgLpOjfLCvxt8uX+wm+MVbPgbPvC1kaI/Irl6UL2fDT
 dbfmxlpFr9D4mn4VdcwQmK0EKx+XXppjNG+R62SYjYx+RsXX5XQj2paiHXmaiHfSAmiA
 wVBImaW4PTJ/7H0Cz4jdkAtnce1uJx0X2X0zZc26bNr29OwgRfflG420/sP+a4pfqt4X
 9ar41AX4bPYbM5BPyhZDrRREhP/5z5VY01XWDiN4AuafzxuMPTw7tQk+HD8dpo12Gdm6
 1nafFt3arKFCtHfuWNhTg/Hqd5fFlPrdntPYUFQHD1aq+MyngLWnH9Uv/cF0mQIdHiYs
 9EDA==
X-Gm-Message-State: AOJu0YwuhWILyUdnVL1GS38ftfXBiW5DchIVl7vgaCg8DgwsxIFg+wxS
 f5faF0CxP8nquJbgwTNEb8/jteKU3OWjXTwd8F2zeQqTP/rnWbbF8Vj1/dl4h1fwRsnZmkLzSq5
 pIreo
X-Gm-Gg: AZuq6aJBlQEpPLQ8TMBI9t+aURoBLqrlfyCob871jYn8l1gMXIZ6EbHx+nYS8LQbRRj
 E59uJZVsZQB/qLe2Nsc5wyz6BslZ32SGgAWLcupdaeWSATbouTYXTzywM4YYysxnvwc5oEQwFjp
 6GtE1inbVvY04s6hbDK+ei6IFd13sbfkPLEIZhzDVMm8w8ijRrIrOyrhfOgVp3FcndvIAQlz+Gv
 S1+Bc8djT+dsXJ4V3pf6SKISmYOOIWT45yy/+r6feLjYfKbNKPD586pCVGpJVWxHzRiaDE15J9F
 1Px/fp5PpmahHug1wpM4Uhzn9JieuYkBE9MLyoFe297eT0Ha8ASATdQpxlczclMWF1/v9+w+t9j
 x7vLgtE6Gb2ADAETXVcZcUqhBWPdYct1pCvFZ83/viXOx5cKA/pW2d7eGBSrOx9BPmZBl1ULJNc
 qmzyvKfCuPzAAsySTd5EsryvZPAErSgLx58/vT9XVmayGa6Wz3Pg==
X-Received: by 2002:a05:600c:628c:b0:480:4c45:aff5 with SMTP id
 5b1f17b1804b1-4805d0663cdmr87665655e9.34.1769469885161; 
 Mon, 26 Jan 2026 15:24:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 05/17] telemetry: check for path overflow
Date: Mon, 26 Jan 2026 15:22:13 -0800
Message-ID: <20260126232428.276534-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

