Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 15:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F5B940276;
	Tue,  1 Jul 2025 17:42:08 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id E0A9540264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 17:42:06 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6443505b3a.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751384526;
 x=1751989326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHDLgRkVb3BE64QmIsLiimvSQWjPOlbugjEhlPxBpdk=;
 b=X2vra98mxQGuixeF3GZWhpRUeY2CQqC/Kxfed0Q2EIG56wjELE+Jul6+/r8rKKG/Vk
 LBkM1VpRORH3obxfR6sTfdY2clt4d57cW0ziOAHCnUxq6tAJHjDKIplDY0y/fzqB/3ZX
 A1ZAf12mYLNb6YKaTS78rwXOpGRG5qEaTvDHukI0Zo/b1iYd//1jwNhIIpYmKauaKMNc
 glyCwW8rcHcv4fR1O42tJZQNpYdDdg0JsesHQ9Bh5zwnvVGlQ1Pinyli8DUcSK1ugf6q
 JRVDykxwfAkmT5M7k0K3qiUpmCTwS3TS3nZ6fKeVhOSik5vWeI/tgJdyh0ph0h7t/K20
 V8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384526; x=1751989326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHDLgRkVb3BE64QmIsLiimvSQWjPOlbugjEhlPxBpdk=;
 b=o7WcWFn55x78SdpG+e6k4tIdOOu6oLS3P7YivQkDnmbMxDZ/lqxNtZ5j1WNIkIZafu
 QpP4Ms+ON1WM28jra/86Bg6iOGK4W7jBf8YMCfIhRwf8KBdDq/39q/jhoj4EDLtoUAwr
 Q/Y14fFzFg9GJBBRRF20r+9tEJICKiiHWvCsPVlphVsyrvUdSkjiTlYLkTUd9C7Cpjbm
 GukdyxgBITi4563csR7OE6bhjlnGqSo+fpBINmvnvehGGF/KJzNl/ecZLBwM7q2/2oWr
 lcfYOYaJTf6S4MVi7OAYvQUCs17+DlZ3BSw211NQ5F/D/q5VvGck+c237tykkg/H2LY/
 toRw==
X-Gm-Message-State: AOJu0YzeCvqUI0wREJtbJb+OPyGlS2Be2fGu0jFB3O68aLiPh7MRmGGN
 2eg4YeyCGy4hAZ97oA/PaJTfIm8rO5kgH2hStZzAzVqnfnPKc/SIwWyEbQXMFdZD3RYT4hr/WPm
 jD62zybc=
X-Gm-Gg: ASbGncte/ytFmf0Plr7K5R1g6PFMSfIBuyqbKjrq/dyDtwDbUGGWCK3ux9RFsKq+/Y7
 M7p5kg/99E/HLXl0HKL6QCRjBvjZ9PA6iDaI046Kjb/78fnOiz/nUGDQ70SFcSt5l7Yav3SxRVc
 Ah/aps2Kc5Iw5G0GMDRlpILHzxqj0ekUzyxSAMug3ForX1IWi3Nan8Nz1ahIYRQyhFw6Ws9tAPX
 x79WlmDTygBQ/Ru3Dm8Dkz9AU2OJTouXGSlPR1oL6GbbS8+olGGAa9rHfPTwzt1eDNj190ThVtE
 fNWMq1j5tusrr7d0cWrfgVrs6fCU4Cr6HWoWwPiWD0MA+92+7YnMcnquFlX0vMQRrJuyzEN9Tdx
 GTAGcopdm67JibSfXrYvlw/P3o5sM6kv9pMI3
X-Google-Smtp-Source: AGHT+IHzui0Kl/11tE1l9wkRKdkmbYccl4TuMZbB4o/vUFsdcBv/lAB1H/hmqg/e9Xf9hyU6tgR5Zw==
X-Received: by 2002:a05:6a00:2394:b0:748:2e1a:84e3 with SMTP id
 d2e1a72fcca58-74af6e94f7emr26830444b3a.8.1751384525720; 
 Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af541e5b6sm12827800b3a.54.2025.07.01.08.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	fengchengwen@huawei.com
Subject: [PATCH v3] test/argparse: change initialization to workaround LTO
Date: Tue,  1 Jul 2025 08:41:46 -0700
Message-ID: <20250701154202.237442-1-stephen@networkplumber.org>
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

Initializing a structure with flexible array is special case
and compiler expands the structure to fit. But inside the copy
function it no longer knew that.

The workaround is to put the copy inside the same function
and use structure assignment. Also macro should be upper case.

Fixes: 6c5c6571601c ("argparse: verify argument config")
Cc: fengchengwen@huawei.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

v3 - fix spelling errors

 app/test/test_argparse.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 0a229752fa..1d05196694 100644
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
+	/* Note: initialization of structure with flexible array
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

