Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A0C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 416324064A;
	Wed,  5 Feb 2025 17:25:08 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 4EC3440608
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:03 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f9f5caa37cso722359a91.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772702;
 x=1739377502; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQR7HMFBLn+vHlNygZ1YrWong0eA4S4pgzdM13oH2Qg=;
 b=xYBgxcnjoL7yg5Hw8R0Lx2T6qI6eqpdOnuDdK+06QFgs7mV1RI9tw6gE46zYEB88dL
 CgJoLeIZJhGPgI4I01I+C55dOJC3H93UsqDsIMA5SOvzTCy8eTaOJlE145N3GFWqD3lQ
 QZUtD3OsAFNz2oPJlaqwb1gNYa9woJK9wdqc9iDNCZPoq7JRSlVEouWhmtCravikO0JC
 fquGU/2ftvNsNRs0jtjH17lbUshHOPLzIeHq5Y0uj8HZxIsmadPP0WTuuWwE0nlGx6Yt
 vYjIvo76xnenRqzE0qLXN8matMvyYJasavMI2deg734nfxIMhNqcvK4sA0+Smt7yczRj
 DzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772702; x=1739377502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQR7HMFBLn+vHlNygZ1YrWong0eA4S4pgzdM13oH2Qg=;
 b=cNPmGTRXPoLV3Dra3H7rNoBmWNjqipHT3UCwy3SxnzJcHmsGCOkPvWtll9AJKLkU6m
 qlQ5KxOaXCQr7IYWG1vL2pde0jvQG5DqBVLpQ/qmwv5qFRSJn/fJjOsJ9yOK4SrhcBLo
 V22fDcky25aqOQsjex8Qn2XFkUhaNTdfjidJsXSS/KROIPolF11u0Wu+3ywbgIrZF0bm
 YVZDguaEqI0A11RZWKAH3GJkHZCc42iV7kWDsGTJwsl7NYlix6OksP/PEW5HYFD9un0v
 ju4ri6D5Y4PzxWSKZhi58w9C3Po5szQ6O94HFjXe39KG8JOhqztqI01spvAjt7A3Z+fw
 OA+g==
X-Gm-Message-State: AOJu0YyFTK4ooAuhMfjflQq1pCQb8+sOMBe4OxSwNsfStn1kwk1+tMtY
 +NyPAKilYy0KRXyeNEnn/RxfghIygtgrB9cmsLHkqxWpjfc7IjHQgvF5LCcXxSWt3PF9NoufpOt
 9
X-Gm-Gg: ASbGnctfelQde7IG3cDYAhjwzYgyqN/ukvCbTUB0vIynGw/TKTtmpzh0QlNkdb++InN
 ci4wc03nRlDvXdO6+9pscTY9g7ygPx0ahFAPVkJp+dfqOlri1bz14sBvWycvBE/RkqOA6DIOzmb
 jRIzHEJeJygg+SY5eseoMO3HISuXNtk2xeDGdYurp9M1KnYfxFRNvBkNn0NAc5OUQ7pK+G48k4u
 Zy8LXPy/I3DXiACZpaNhF7xmXBySnUXnw569TW6d4W3xszKsq9MZrycK71+ArOmpulLdAlKaMu9
 43I4p9Zin6UL0BZWXrKU9R2nBS6uMnIcuPCobbi8PzOj1R7+2UjMYdxkzcZeGk3wBS2z
X-Google-Smtp-Source: AGHT+IEkXVgCaAp3Fud+979m5DDQ4vmW3r6bMjIc5fgQ/PI46BDwvpgM5tiqI+svOmZbtIGDg1L2oA==
X-Received: by 2002:a17:90b:1d88:b0:2ee:823e:39c4 with SMTP id
 98e67ed59e1d1-2f9fddd6945mr125358a91.7.1738772702491; 
 Wed, 05 Feb 2025 08:25:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, tduszynski@marvell.com,
 stable@dpdk.org, Jakub Palider <jpalider@marvell.com>
Subject: [PATCH v3 03/19] raw/cnxk_gpio: fix file descriptor leak
Date: Wed,  5 Feb 2025 08:23:04 -0800
Message-ID: <20250205162448.161161-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The function would leak file if fscanf failed.
There is a working version in other file, clone that.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: 0e6557b448fa ("raw/cnxk_gpio: add self test")
Cc: tduszynski@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c | 24 ++++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c b/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
index 2f3973a7b5..a0d9942f20 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
@@ -34,24 +34,30 @@ cnxk_gpio_attr_exists(const char *attr)
 static int
 cnxk_gpio_read_attr(char *attr, char *val)
 {
+	int ret, ret2;
 	FILE *fp;
-	int ret;
 
 	fp = fopen(attr, "r");
 	if (!fp)
 		return -errno;
 
 	ret = fscanf(fp, "%s", val);
-	if (ret < 0)
-		return -errno;
-	if (ret != 1)
-		return -EIO;
+	if (ret < 0) {
+		ret = -errno;
+		goto out;
+	}
+	if (ret != 1) {
+		ret = -EIO;
+		goto out;
+	}
 
-	ret = fclose(fp);
-	if (ret)
-		return -errno;
+	ret = 0;
+out:
+	ret2 = fclose(fp);
+	if (!ret)
+		ret = ret2;
 
-	return 0;
+	return ret;
 }
 
 #define CNXK_GPIO_ERR_STR(err, str, ...) do {                                  \
-- 
2.47.2

