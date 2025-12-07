Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA073D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0C0A40658;
	Sun,  7 Dec 2025 20:13:01 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 155F940156
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:00 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso32070725e9.3
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134780;
 x=1765739580; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTtUKeUg/Ljll5X+Z97SOdDf/8WMPP7rUAcvn3wI2AI=;
 b=PoP2NA0H/JQC2Mr7XqUbUx6b8eu3cp8myZoCcFhmJItui0lcBs1LfCOK+to4ur+Uik
 Us+pdINPrlSAF2LsGlRcl4xyoJrqDZHs5/eiNciNrtxgBGTySvkN9JZMJOgyA8/5iXEu
 MyK48uz0Xp2TFeOrCZulweTeOYq8naNqNSNglmTsJlaN8Z7B3c5iW7gSFFExCVoyvP30
 4qxPBydW/zPjR3YlXfG9MUfd86LF2uFVpQpUD38El3F4jMO+WQOGUa68GbhLlMV5f0RZ
 urqyF5vr+UuhgUI952qZ8IlIOTYNKbV7wXkQosfmX4XjrSmk40Brmqrf+azd8o44bClK
 ZiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134780; x=1765739580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTtUKeUg/Ljll5X+Z97SOdDf/8WMPP7rUAcvn3wI2AI=;
 b=v+6Zx1SGFsXe/t/x6T5KWvpSfasHpjGXoYK9I+ZMTxDTv3OUeR4nrAiFDL/Z7R+t8N
 79+wo600mNGN/E5LqHWbEwhHHq8lSIeiTXQjOGKaAx+GsXRgzjlV4imaatnKGTOqlYKo
 giINQ7SIOOy6PXjbgyfB1Amjpyt+34nzQlPeFN6HOFeeUmxhhYcuHnD9nYMMD24u5EPv
 jcejd0s55inv77K6fF+b2v1m0VKrInrMxvlgQP9SFFaQPU3k11sUkGnMa3WTL321C2Ij
 QHLsyNVDAyE1YtFByH8smd3swEXKnVQ2VxLzsf6ExcF8kPrbPJ3/KawYjSOzUMSm/8JG
 7hMA==
X-Gm-Message-State: AOJu0YyR5DGbatPw7OdSXZMspFIO4BctmoHKO9OFrnNrrCL4IfC8jW7p
 7OWzJruiZ1TGnplvUMIEQq8r5wW3/v71+YAoSGvFSraVo0qSY16+qKFBsK78Bt5QLKFyNzh8L3L
 z+axv
X-Gm-Gg: ASbGncuuyM14dVmxbUjajxxx/kyJWZGFUEGcXpUqawM+fxXZYhHvi62wAkdunqXlWM/
 uwE16K7c8/DvxLVggeBSLPWcUzCNWnyIos+BQcKXQ/o6jRyzkIbm5iAkcqj7CUcRGmNwvOhDGDL
 ZBsQSwR0x6zifh3ZXUnQagC0v28QgNxeAeprtRhCBkBpPuH3fdT1za0LAtGBvsLgBrxl/0YQSq8
 +HQqBcQi83gjAq2ZY1sOHElNof9aJH9Jm7IOE53BK1Xn+DvzA+LLHXHmypcX3TCWhLxgHeyFS29
 F9+7HjL3B/l6oHB1fZCg3gmkMYKaojI2aQ4yWyFHhXJ0mXgyj7rqiL9vSXYnVBRlnMGsvY4nQeW
 0evvZw2GNRnpV+8n1bPtuSBG3wVAGJ4kKCYb1JTOQtU/stVAJ6179qYgNLGilo+N0Ezzy7HcrVU
 jTkxkHUr1kdXkJC9YHdnI7OdBjYPEIrR3TZFcZDn5BmS0ItUyYvUzzCQ/HR+Rm
X-Google-Smtp-Source: AGHT+IGqtd+mkqrTcPj5R5Rxpvn9I/r2AIGyIBPmoe06OpJQkDH/sJWnwzYB60N0wZRR3XvFH7IgWg==
X-Received: by 2002:a05:600c:3b8b:b0:477:af07:dd17 with SMTP id
 5b1f17b1804b1-47939e3897cmr85403755e9.24.1765134779627; 
 Sun, 07 Dec 2025 11:12:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 06/17] telemetry: avoid possible string overflow
Date: Sun,  7 Dec 2025 11:11:57 -0800
Message-ID: <20251207191242.165619-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

When registering client the input parameter could have a too
large unix domain path. Improve the string handling by avoiding
temporary buffer, and check the length.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 37 +++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..24f663eee7 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -82,34 +82,41 @@ static int
 register_client(const char *cmd __rte_unused, const char *params,
 		char *buffer __rte_unused, int buf_len __rte_unused)
 {
+	const char *colon = strchr(params, ':');
+
+	if (colon == NULL) {
+		fprintf(stderr, "Invalid client data: missing colon\n");
+		return -1;
+	}
+
 #ifndef RTE_EXEC_ENV_WINDOWS
 	pthread_t th;
-	char data[BUF_SIZE];
-	int fd;
-	int rc;
-	struct sockaddr_un addrs;
-#endif /* !RTE_EXEC_ENV_WINDOWS */
+	int fd, rc;
+	struct sockaddr_un addrs = { .sun_family = AF_UNIX };
 
-	if (!strchr(params, ':')) {
-		fprintf(stderr, "Invalid data\n");
+	if (colon[1] != '"') {
+		fprintf(stderr, "Invalid client data: missing quote\n");
 		return -1;
 	}
-#ifndef RTE_EXEC_ENV_WINDOWS
-	strlcpy(data, strchr(params, ':'), sizeof(data));
-	memmove(data, &data[strlen(":\"")], strlen(data));
-	if (!strchr(data, '\"')) {
-		fprintf(stderr, "Invalid client data\n");
+
+	const char *endquote = strchr(colon + 1, '"');
+	if (endquote == NULL) {
+		fprintf(stderr, "Invalid client data: missing end quote\n");
+		return -1;
+	}
+
+	size_t len = endquote - colon + 1;
+	if (len == 0 || len >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Invalid client data: path length\n");
 		return -1;
 	}
-	*strchr(data, '\"') = 0;
+	strncpy(addrs.sun_path, colon + 1, len);
 
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

