Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146FCCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BF5C40652;
	Tue, 11 Nov 2025 23:19:06 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id D5A9040395
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:03 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-34372216275so255667a91.2
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899543;
 x=1763504343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MonaQP1LjuvQRMKWbmuTBsl8mIS88e1arwah1zLJjck=;
 b=CdufmIFo6TjyBZcoha8dtvw7qscZmUXiGOsFglLW0pbO1HBGuUGvSO9ktDokD2VyUP
 A1DgmE+WGr/ompBXnW+rAvMEf39rTkOnLMLLBDJ8p5Mz52aaYTgDIwRLYFBsXVxCMxuM
 u9xJy0gBwznQGJTxHFZo8Y46TeQdbMx3Qu5BLAZbkIC/QsUEh4rbXXsBsBv3QFMAr+AH
 H3VHkXyQBPVMU9f2Yd03o9mYpLi0Gad/kd9+hGMN24WxS/Xy6oUej4gjwQ+T7Ur6h9yM
 hfRGSI9KpOWorwASpjuRMzasXz8uBTnFuUyId0+w+7WjKOyQwraOJcSX9KYGAGDBjGAl
 Jwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899543; x=1763504343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MonaQP1LjuvQRMKWbmuTBsl8mIS88e1arwah1zLJjck=;
 b=dghw29mH2Ng+4t5q8a2nm5K6WWlSVHkZ5uE31ryRM0yiSBXxMnL53lgoAs5OPKH9Cr
 2Zrz4czwJh3NfjHqorH7v326FPNLAbjxWkEsYaGqtAlTskjacS7Zeqk5ybRjOUznV8zu
 hhLeCn8ORQdvWvfYf3SYenrb3bUuqNtXqPMy28Jvx6oUPxd/u2MdcO1E4ZlMNHscF2j8
 fWvqQ3lIqHSkWs0f9RjR2F45fuWsV8mYbNV+PxmB/6q3qXVVRTWzz9jXlCNak2KrmoYl
 3mSE6lbbIvHqpVNBRFdOGeyqa8lZlLCj/mMRns5/22oCdGOfrYeJFYBAPZ+nM7hMb8Ff
 ixAw==
X-Gm-Message-State: AOJu0YwaWvR+6wUnksMA9IwnqBrll9PqcKJsNtpsKA+eKJ0ES7ZTt8x7
 6QIgArC3HVIT4VtkF4/C6qdqIzYhwzzHlWDWGs4rnKKFNnjoxHbP/aygge4Oxxhfkeoqekx/rbk
 CNNdc
X-Gm-Gg: ASbGncsQQ5Hxj1olrbGnOTrCr0HjEirTFiflmkSChAAjW4FsFYckbGx7/loKoYuGZFg
 Q27SWaskKnd0/pJQroeOHXW0VAahlSHFJka2VW9MkiMlQaAgWi6auuvV0R1zOMVzOj1q01rLucI
 k7+IP2OsrfzYn64HqCcnAW2CVLWI6VSpQtJMex6s7RHw72Pts+CnxhsNEXuqs4KV1adP/J59jWU
 VcLNOy6a9WFKX2E+7Cq7xef7sphNEaL7w8f2C2iJ46hbD0YiwM8ZopWl6NYAK+noXa+iTkWam4k
 TMgkejrJyQ6LU8ek8P9SUFENEY2vPLDtcSJQnm+p/aUsfzxbgYZ1ucfV23oBInxh3KT0X4KfO8C
 WSIf48pESRfPG1ZnwFc+vs0UWG4tKb8/2MN2PXC18ZtcLkdxQILpv41NpRESsa4WAvtwpDq0tGy
 o0LnB+RxmFzq6VR/TGj1udUVqbTgtpL4O00CY1E7Q=
X-Google-Smtp-Source: AGHT+IE5nRQGzklLgfqWIj+R6Y81sIz8lA7wwJom4x5Y9xkIJHvpHViK1kJJjq1HJ+v9xOr4oZ5q0Q==
X-Received: by 2002:a17:90b:4f45:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-343dddbb353mr999835a91.4.1762899542922; 
 Tue, 11 Nov 2025 14:19:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, maxime.coquelin@redhat.com,
 stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH v2 2/7] examples/vdpa: fix format overflow warning
Date: Tue, 11 Nov 2025 14:17:19 -0800
Message-ID: <20251111221857.443752-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

The ifname is limited to 128 characters, but it would allow up
to 128 characters as prefix then could overflow creating ifname.

Change to limit path prefix to 124 (128 - sizeof("1024"))
to avoid possible format overflow

Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")
Cc: maxime.coquelin@redhat.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vdpa/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 289db26498..7fd0e55b20 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -22,6 +22,8 @@
 
 #define MAX_PATH_LEN 128
 #define MAX_VDPA_SAMPLE_PORTS 1024
+#define stringify(x) (#x)
+#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))
 #define RTE_LOGTYPE_VDPA RTE_LOGTYPE_USER1
 
 struct vdpa_port {
@@ -36,7 +38,7 @@ struct vdpa_port {
 
 static struct vdpa_port vports[MAX_VDPA_SAMPLE_PORTS];
 
-static char iface[MAX_PATH_LEN];
+static char iface[MAX_PATH_LEN - MAX_VDPA_STR_LEN];
 static int devcnt;
 static int interactive;
 static int client_mode;
@@ -74,9 +76,8 @@ parse_args(int argc, char **argv)
 			break;
 		/* long options */
 		case 0:
-			if (strncmp(long_option[idx].name, "iface",
-						MAX_PATH_LEN) == 0) {
-				rte_strscpy(iface, optarg, MAX_PATH_LEN);
+			if (!strcmp(long_option[idx].name, "iface")) {
+				rte_strscpy(iface, optarg, sizeof(iface));
 				printf("iface %s\n", iface);
 			}
 			if (!strcmp(long_option[idx].name, "interactive")) {
-- 
2.51.0

