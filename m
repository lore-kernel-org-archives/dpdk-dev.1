Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99250E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:14:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E51F40658;
	Tue, 23 Dec 2025 19:14:35 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id A6F934064F
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:31 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so668183666b.1
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513671;
 x=1767118471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTtUKeUg/Ljll5X+Z97SOdDf/8WMPP7rUAcvn3wI2AI=;
 b=mPF8EHjB42QTdIaPTHKDtA7vefLeSthVZWnAwXgJKKwVd3pQC3uWZF2CJfN100QF+R
 izZ1hs5iExPxz40QDcii+1ssTWuMd/G5KozNqDOt8osfNo6Cc7eENYBoo7NKwkSVyxXW
 Mqh19cFelZGQLVbMsmCd+SQQB+sP1Os1kkH9lMhbz8wYFwp1p0t5dr6hAS/H3rYEK02D
 TX9Oz09CZlLDNK7aZeImo72AZqmErA01vrBcAbnmsU5mGYzFIj8zsv1OJ+8SGpee4Sjf
 5SE1CTN5Xc0kLHLzPPg5AAuafHOFB6b9grVpocoM+ohhoF5T/D9y5VMJ3fMz75stRu2z
 UDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513671; x=1767118471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTtUKeUg/Ljll5X+Z97SOdDf/8WMPP7rUAcvn3wI2AI=;
 b=LLioSF8G9Dqenui6961jovQxDUI/r+yBNo8CXMV96Z+9PjBpVjrgOBcNREMMsXoalN
 CO3HM/tnmOIdJlzp73m7PjT0tVUBXXbjX3YlPE+WNuau1zUqydkCDyrAJXvOjLmG3JZZ
 ieCDKKSpf5Ie5lHuRjv//zJPKFgOzktBBs15sZrPpph+DiJ2FdxoMczHdCvh2v51a97i
 e0yq9wlq2S2/N6Srs3WtXk8tzODF5aVwyb05C145aQlTpvthTYTscT3bBzsMMCdlsWud
 VR12ThCtOW06P6lXo25LiPTxcTT15fJSSN3J+RwsT7Sdjq9l3bHJMmbD/prKAxxYbmle
 l91w==
X-Gm-Message-State: AOJu0YwWST5sFfDbb9v1/6IyYR9JwjYxJAL4q/+HzoLRl9/yHXMlOVKi
 Xm2zWeXsZSRCbRYisTroLLwUzjQhi/oKu/g2HCM6hebq9LOlg6FPoGW5WLrdN3QA9m4ZPJPbr5q
 8ffGmI08=
X-Gm-Gg: AY/fxX6qcUMBMZRTq3XCpRGys30gHFSiDv6oR2Hmk0wvHc2oSZwT6gIDQq5BYtPfoqz
 7fN3+e4z9e6nL79bjbn2WKp+dZ//Lh0pLj2DPLuayV1SirK0FpB4Tm3mJmWIZpYDGWrAnRsVEi0
 xKI/vV8/W2qRS18/T5lypaX4PAR0+nb8qZ5yT4G/K+Hf4fLc/u/WFjBbRIunv4N3gYmRlXt6WtP
 OQPJdaUJpm582JM/4cg45EZTNXuj8ELTqqe/PLOih12rcpiCnL/Bk8xhi3acmc+v/zmZHHbccl8
 MA9Y4HSt0NEhQTjnpfPfhThhUboCa5oUbtt7Clx7i/6Uw+RwKqhzgOCkfgkd/V00S/LwV4RuK8j
 wDPAi9PoBwMlgekp6jzE2P+IqbqDA11CX1sk0iU+g5rKCnQag3WeuK7PhyKbKIxMPt14wuMvSif
 mS6H+QE3q31IjI5cmU7Y4d8oTAkvFLc9HDatbE7GSPslVYUwUXeg==
X-Google-Smtp-Source: AGHT+IGzpYn2mgqy7QU6NASoE4GfNKHHYu1fZkrXpx1579AnpyBGAidWnWizg9ddOhDQCPksKGEXKA==
X-Received: by 2002:a17:907:3da8:b0:b7a:1be1:983 with SMTP id
 a640c23a62f3a-b80372699eemr1720652266b.63.1766513671156; 
 Tue, 23 Dec 2025 10:14:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 05/18] telemetry: avoid possible string overflow
Date: Tue, 23 Dec 2025 10:13:03 -0800
Message-ID: <20251223181418.40834-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

