Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78665CF9C42
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FDA9402E8;
	Thu, 20 Nov 2025 17:23:38 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 76C24402D4
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:23:35 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bc0e89640b9so678323a12.1
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763655814;
 x=1764260614; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAV57wDUV45aKAL0XKKVCh8ZsI+MeYnrrt8UIS4GUBo=;
 b=QHxtVBxZETpkKMV106ntrE+IG/QHhgH3/uiXobcr/P6xCv5/e4zxGk0DTeT/ZQWcEP
 015wtBz4YJmQZu3C8WVUYlPeAlKKHwFxZKivUyZA5R1ONSuiuSGTI9SqlbrNgXS9Htq/
 M9ZRs2VMexK6L7tzZw1LI0rpnZ3Ez9h/N1sPbodKe8NUnQTq1MeTfnA+xwVVFHPI7CMr
 Ldrf+cIRjVkbWAyVx6776ZuVgMDA4p9+AVlmgMBw66XNw1GGTmO+EMqdx/baBW04CIP0
 aWd9LPG8dojtKCng9HVcdF7RdBH0GIFqnekxjNosFPvVHgamX+OXffxb1jyiUVeQ0EvP
 5DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655814; x=1764260614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAV57wDUV45aKAL0XKKVCh8ZsI+MeYnrrt8UIS4GUBo=;
 b=wAYW5uIiy+mqL5IQY3mP3jsz/gAj1AEy5vv/UdlQUzKH1nVTFLj+euxr0H6fJM7U6H
 NKrD+Np+n8vo3aMPpS8ErlNwARubCywBdNSISOuszlx8tgbZE8N+uwvjQ7cTr+1ySPFZ
 Sl8wR8oxQlKxH0lrHN2Mv4NVKcQVbZAEF4DdPkv036eeQ1xP2/DsINqoQzXMXW3++9Jn
 ugZ3kvACBDbAGRgrquVHDkJfJTxj9kWzuK0yAw0CJXOpXxf8Zgqy+M6zNUI+Olf+RnGU
 vHOG2iydD1z6t9BGzHwK7wNAq1+w3gpJ18ATfNFBnK+ExXpzRvaGohaoNjP1s+8mjp3l
 fXdQ==
X-Gm-Message-State: AOJu0YywxY7dz7dsUa4azqYAsAaujJm/evukvNJlGxxFSWNER6qqCILL
 wfzdPsHJqNjKfi+y/K5EloedUWjG/6NYQku29Ar75UEOLoR5VOigeM+pGl0QfLlwO6irO9IF3Y+
 GdPkl
X-Gm-Gg: ASbGncuPwTOvSgefgK3k/A/zR8/8Qupjrf4mb6DopNuELxirjHIoUiwmMVm2nDDfvpF
 kDjRs0gXtIV6ue6bbTUel7lUXqyY9VYIAajz1Y+wCKDecugg9DCxol2mT1rd5uhAngWYYE7gzSg
 HnQ0lKRD9fKVejVndRVF50jHpIbJcwFRWL+Azj6GhZ6Ykak+mINHDgSlOFpS9XXc8V6CWAr+pqZ
 62YCPlXywrNvNEpX6GgESMcNqLEeY17UYAS2mX8pLF+KRMcd7s4c4U6wTAhUiztmaiIJDWlgA5M
 /Xz4NWKeRsrXRrn+VUauQIb2NhYx11flpqU0IYez024dYMeLXDIZvUj1tIckP2+QQu+IJeL4MFb
 1sHYuf1jYRv4WJrsoLw6F/oE4jueM+fsL3F5NLoMVvB2M/C1R+207SLopEQvR3+uwiZwTFeK7Rd
 m6sUZYnOn5nZ6WY5icTihk78xIR/pRPBcCSjpx33ENv2AynJE3nQ==
X-Google-Smtp-Source: AGHT+IHzY/zSs3N916P7DdZZB9UZT/RSTKNIA2sK2KiDqOrABMCYB98NTPaaME7wI04raQx9ET/lVw==
X-Received: by 2002:a05:7022:fc0a:b0:119:e56c:18b8 with SMTP id
 a92af1059eb24-11c947fe1cfmr915389c88.32.1763655814470; 
 Thu, 20 Nov 2025 08:23:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e3e945sm12096427c88.6.2025.11.20.08.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:23:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, maxime.coquelin@redhat.com,
 stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH v4 2/4] examples/vdpa: fix format overflow warning
Date: Thu, 20 Nov 2025 08:22:00 -0800
Message-ID: <20251120162327.78062-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120162327.78062-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251120162327.78062-1-stephen@networkplumber.org>
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

The ifname is limited to 128 characters, but it would allow up
to 128 characters as prefix then could overflow creating ifname.

Change to limit path prefix (iface) to 123 (128 - sizeof("1024"))
to avoid possible format overflow

../examples/vdpa/main.c:501:76: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  501 |                         snprintf(vports[devcnt].ifname, MAX_PATH_LEN, "%s%d",
      |                                                                            ^
../examples/vdpa/main.c:501:25: note: ‘snprintf’ output between 2 and 139 bytes into a destination of size 128
  501 |                         snprintf(vports[devcnt].ifname, MAX_PATH_LEN, "%s%d",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  502 |                                         iface, devcnt);
      |

Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")
Cc: maxime.coquelin@redhat.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vdpa/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 289db26498..08aa933272 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -22,6 +22,7 @@
 
 #define MAX_PATH_LEN 128
 #define MAX_VDPA_SAMPLE_PORTS 1024
+#define MAX_VDPA_STR_LEN sizeof(RTE_STR(MAX_VDPA_SAMPLE_PORTS))
 #define RTE_LOGTYPE_VDPA RTE_LOGTYPE_USER1
 
 struct vdpa_port {
@@ -36,7 +37,7 @@ struct vdpa_port {
 
 static struct vdpa_port vports[MAX_VDPA_SAMPLE_PORTS];
 
-static char iface[MAX_PATH_LEN];
+static char iface[MAX_PATH_LEN - MAX_VDPA_STR_LEN];
 static int devcnt;
 static int interactive;
 static int client_mode;
@@ -74,9 +75,8 @@ parse_args(int argc, char **argv)
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

