Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59683FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA8ED40666;
	Tue,  7 Apr 2026 05:52:27 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 687BC402C4
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:23 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-127380532eeso2679481c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533942;
 x=1776138742; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuGE/5q8+czGBbpCzRS/fuOWI5wa2AQ1a1cp+JKKjJ4=;
 b=FjppiQop8F1wVWG6oTnK5LwSSr40mXYwxKowiaKIH+OzuQAWo4fH+2OVDyVTOHXIuO
 RiY8qoJbMm/Qs3LiQk19Pojj+2r3XfsUU+v6I7zRCNeiCr4GOu7YkXCv8kPiAKncPdzK
 JZCcf+qo/h3QqnqpKPMMR0NEC0HfUiLDfhnYbJJyx0oVzt5vWJJqFuZg7KPFHnddMcbO
 sUWlQlr2HfX5VuZMIf3k1eGL7KawMkNn/79+IlQq65x0vT+xWXleuAdQQ+kyn6YaBOut
 80tJ/feJzGzkyWdVrzjBRiCSDXvtA3lEwfIL8nHM1THQhWQL8xGiZ9Tin4kWQwJyrfQH
 8A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533942; x=1776138742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FuGE/5q8+czGBbpCzRS/fuOWI5wa2AQ1a1cp+JKKjJ4=;
 b=RlSzc+nprD9lGwfo3E3qKB96N4k97TBaug3ww/jHm+nFpztpP967cMhmBUIMSvT/md
 Te3GJh6uaynr6fq8pExORHeyj1QMMe7HaXowEpPNg+uSaAOLYxFq85GnUDbevYq2KFzc
 mEfW8Nkq5v4tzM4sSBhj8jTItMKJT9O4KpHg7qomtkzJNKmvnD03z6vd/HzzCZC9Ga29
 kjgO9rHz/TiyO9fg92ROXv4WBxgv+kF/JVO82M7JZoH6IwQAoIiBZ3PtQO/Uw2EKpcX2
 kUBw2rWpHrCR7+RLIgWuXsds23V91rMWfBW0mYM8FQRUwoEjRZAed6Fqa7olvuSDDdar
 OLvg==
X-Gm-Message-State: AOJu0YwtItfGbphPzCZ3l47kSLBOL8sLQ+hhQq6VKBsGRyO0/68JehSZ
 IHR3Yi9mXA6aG2gCh9K9ecl40Y2Ck1c11zMZkxuJFKJaXuT9GExFSpECL/eoDwjh14ckZTVn7zg
 FUzMQ
X-Gm-Gg: AeBDiesGKYiFFQe9NdQw0KJ+t8mIC6XyIfapySJqtfbrw2bs9K2CEXdOV6+85aAztmO
 HKUOHGAG0/ZqINwAhvaoZabOSDw/sX0Kkl/etNoxPXumskKExaY1ORan6uBIdiVwOGmmzDDkCdk
 fCHLEjrdl3u3OuCLmz+yM/edfwHG0lphFuW3k7Ekyk+DZXtd+EtLLHrEJJoIKSu1rb9W05Wha8c
 ScIn0sOVJvLsURgC8sugLvD+EVvtzXvI8ynmCvxXiVNy9GxmjKZkOoh+fX9QUq01hc5oWkBM/cQ
 88K7cub8cl9tyBX7gDfHgLeHUwCYRhR2KKxQtFYrfmUuepJEOsZxhQ7SzjmkoW3KtY2jZm28Kl0
 p0dpMD/i+v1vp9XWtuljY3K7dY03cpCWagJwB/YvAddL75tXK3Rq5G0kOhA0bP8E5kbeuPFLQ7J
 EMX7KtBdAsHHSajeEHLuaS1xlOPLktXBVP
X-Received: by 2002:a05:7022:61f:b0:12a:713b:8964 with SMTP id
 a92af1059eb24-12bfb6f6569mr8656583c88.11.1775533942411; 
 Mon, 06 Apr 2026 20:52:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 11/23] examples/multi_process: fix shadowed variable
Date: Mon,  6 Apr 2026 20:49:37 -0700
Message-ID: <20260407035209.650419-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

The string passed to parsing function number of clients
shadowed global declaration. Also avoid similar problem in
parsing portmask.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../multi_process/client_server_mp/mp_server/args.c  | 12 ++++++------
 .../client_server_mp/mp_server/meson.build           |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/examples/multi_process/client_server_mp/mp_server/args.c b/examples/multi_process/client_server_mp/mp_server/args.c
index 3c2ca266b0..60dbb3c626 100644
--- a/examples/multi_process/client_server_mp/mp_server/args.c
+++ b/examples/multi_process/client_server_mp/mp_server/args.c
@@ -42,18 +42,18 @@ usage(void)
  * array variable
  */
 static int
-parse_portmask(const char *portmask)
+parse_portmask(const char *str)
 {
 	char *end = NULL;
 	unsigned long long pm;
 	uint16_t id;
 
-	if (portmask == NULL || *portmask == '\0')
+	if (str == NULL || *str == '\0')
 		return -1;
 
 	/* convert parameter to a number and verify */
 	errno = 0;
-	pm = strtoull(portmask, &end, 16);
+	pm = strtoull(str, &end, 16);
 	if (errno != 0 || end == NULL || *end != '\0')
 		return -1;
 
@@ -80,15 +80,15 @@ parse_portmask(const char *portmask)
  * and convert to a number to store in the num_clients variable
  */
 static int
-parse_num_clients(const char *clients)
+parse_num_clients(const char *str)
 {
 	char *end = NULL;
 	unsigned long temp;
 
-	if (clients == NULL || *clients == '\0')
+	if (str == NULL || *str == '\0')
 		return -1;
 
-	temp = strtoul(clients, &end, 10);
+	temp = strtoul(str, &end, 10);
 	if (end == NULL || *end != '\0' || temp == 0)
 		return -1;
 
diff --git a/examples/multi_process/client_server_mp/mp_server/meson.build b/examples/multi_process/client_server_mp/mp_server/meson.build
index a31eea764e..9e585e80b9 100644
--- a/examples/multi_process/client_server_mp/mp_server/meson.build
+++ b/examples/multi_process/client_server_mp/mp_server/meson.build
@@ -14,4 +14,3 @@ sources = files(
         'init.c',
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

