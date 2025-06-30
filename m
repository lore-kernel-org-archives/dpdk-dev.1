Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C768CC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 14:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0445A402CB;
	Mon, 30 Jun 2025 16:59:40 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 8581A402A5
 for <dev@dpdk.org>; Mon, 30 Jun 2025 16:59:38 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6fb01566184so40451506d6.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751295578;
 x=1751900378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4Gw7dKI6x1TubtDxEdeVNEJorijsVO4h5SEnhXxrUY=;
 b=ebQEagvqEXTFxyJsevkI1iqKCBDFhkqLvktopR423HW9qih9XB7UmSxPd7A7BynyqM
 YlNUiFfJxMeFO0N/MqNIlOB1EBXbObs5tnGm632UxPP2YSPaQ/EKroJRXqOdtgk5IUQx
 NNcsiEU+wINCOUwXg3+vMY+rCV9t1xYJ7zSI6mqbxM1enJU9SdBGubTP3hgTRfewzdMo
 XbtgdfYTfdgNzMiFyXdpndd03Cy/7M2jbopDPotHo+bkzBb4iMxTOBDDRfrDq8jtztun
 1H4MKt5UqHYeTgyUPvQ7dqJXJ5QzU4ara2WqDGsIHpgHxJjSMNw0dZIiPngdlo5AmXNI
 s15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751295578; x=1751900378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4Gw7dKI6x1TubtDxEdeVNEJorijsVO4h5SEnhXxrUY=;
 b=lEaysy0PmUgrk+gQVKl3HXq2M6VC2YBP89Pi1cyjeZoIMSfGzWERl7Rv3oNyLOFvCd
 tU2ElGSgBjJ2zRhQEO3X2zqT/7x5pglszPtixVIXd4ucMhJmDlo3c3IJwh++hkn+/zOQ
 QfHMsYfTMjxUxRzECQ9WrvIr1xrIGnFYGIpQBeheLYMvkfauFeuS6eUr5K+8A6twnqB+
 NixjAreos121FBar8Tw9Gghf+jYrAe6nOsc8//fDNFXXQxWicGZwON1veG0IDndnx46f
 hAvZqozH5BBQujkOlh2Xv8ohLY4myTWlGPq/LI6u1A417OB1kJyh8xd4wZAziWrKRKXh
 /tVQ==
X-Gm-Message-State: AOJu0YzK6NpmM207Xfe/GkXaPNrMQbNj9YYM4dTFRuzM0sN3PccnQCxa
 prlfL2LLo8G0OI5RhgXQewZAKLSP1JoNxCvYdWGT42K6+yuKhB0c3oS0HNydEteDo9vMt+9m15Z
 K6AOQ
X-Gm-Gg: ASbGncsFYSCxmfowyiwxmrk8IZ8Hpomkr5CFlMi73SpYzzasReunMAXOJM6pKccKX02
 bz/EWrSMwh7hCoyxqb/5NocmP/86RjysSyk7Gr2unyppCkG4DWJYR02xugl2lKFhF/IfhfD5W93
 mw4mcDi9Cj++93N9Qbm6Wx77dWDQCbTWwg5KXZgYs87fkq3hjKF9BFYq37pi5Nbb/j9MuceVO5X
 PNaHVPezHdtN89XImqTfSiMb/g6HK3BJyvpHPspuZTYkwQTOcsNntc2W06dN47J1JiuZS1Ec8xN
 0hARlG/nQT2DovZTpUp4sgFaqYs5dlt5ynNTW4xkHR+HA02KhSD897fzFzUCdGD3LH33j1qerXc
 k6rOaxO1LueJ1M3MpoBll4Q70ybq4qSgpvIaL
X-Google-Smtp-Source: AGHT+IHrgxj5AjWgFE/QFPvthpRDSnIRwVoPFaA9kNXGytiFq0J3Y+O0pLLpuJlYTFIPusVe9Sl3wg==
X-Received: by 2002:a05:6214:b66:b0:701:77a:88b with SMTP id
 6a1803df08f44-701077a08a5mr26110576d6.21.1751295577710; 
 Mon, 30 Jun 2025 07:59:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771d9c00sm68379566d6.48.2025.06.30.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 07:59:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	fengchengwen@huawei.com
Subject: [PATCH v2] test/argparse: change initialization to workaround LTO
Date: Mon, 30 Jun 2025 07:58:49 -0700
Message-ID: <20250630145934.56969-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627162305.340042-1-stephen@networkplumber.org>
References: <20250627162305.340042-1-stephen@networkplumber.org>
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

When compiled with Link Time Optimization, the existing code
generated an error, because the compiler was unable to intuit
that there was space in the flexible array.

In function ‘test_argparse_copy’,
    inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
    inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));

Initialiizing a structure with flexible array is special case
and compiler expands the structure to fit. But inside the copy
function it no longer knew that.

The workaround is to put the copy inside the same function
and use structure assignment. Also macro should be uppper case.

Fixes: 6c5c6571601c ("argparse: verify argument config")
Cc: fengchengwen@huawei.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - simpler fix is to just inline the copy

 app/test/test_argparse.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 0a229752fa..d5b777e321 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -71,7 +71,7 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 }
 
 /* valid templater, must contain at least two args. */
-#define argparse_templater() { \
+#define ARGPARSE_TEMPLATE { \
 	.prog_name = "test_argparse", \
 	.usage = "-a xx -b yy", \
 	.descriptor = NULL, \
@@ -87,25 +87,24 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 	}, \
 }
 
-static void
-test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
-{
-	uint32_t i;
-	memcpy(dst, src, sizeof(*src));
-	for (i = 0; /* NULL */; i++) {
-		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
-		if (src->args[i].name_long == NULL)
-			break;
-	}
-}
 
 static struct rte_argparse *
 test_argparse_init_obj(void)
 {
-	static struct rte_argparse backup = argparse_templater();
-	static struct rte_argparse obj = argparse_templater();
-	/* Because obj may be overwritten, do a deep copy. */
-	test_argparse_copy(&obj, &backup);
+	/* Note: initialization of structure with flexible arrary
+	 * increases the size of the variable to match.
+	 */
+	static const struct rte_argparse backup = ARGPARSE_TEMPLATE;
+	static struct rte_argparse obj = ARGPARSE_TEMPLATE;
+	unsigned int i;
+
+	obj = backup;
+	for (i = 0; ; i++) {
+		obj.args[i] = backup.args[i];
+		if (backup.args[i].name_long == NULL)
+			break;
+	}
+
 	return &obj;
 }
 
-- 
2.47.2

