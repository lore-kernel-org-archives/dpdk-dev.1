Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2014FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6EE44067D;
	Tue,  7 Apr 2026 05:52:26 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 746944064E
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:22 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12732165d1eso6303376c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533941;
 x=1776138741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Uv4Eg8s+HkZA/OZ512xnHvUaWkX2GzzIftpT1D54dc=;
 b=GLFjWUIV8G74NXIiIfNIUq8M51duwlgHydhyms0JRkFt01hxPKjgpsTooqARWpyePC
 J8S10bm3Ss9TdEMC+6GdOhQPUnLC3qVbZcJFIklszMt4CtqIQz1Y+myPlBURdmOGcLDe
 bbiTeBf/PfJQCOzT4lvbdzAPc0xZpT+ncY9r1pmQVWLBuplmupTiwM3Iixgi5xcvJ5rZ
 06Ag9z3WUStO7TiQT8O4z8kMQrp708oULfRr1AsPoCrR+IgC5e2x4J+iyCSVB2+l8dA2
 UxL7zqLX8XAaq8LGR4xum03hj4y5KaU3FE73xFENLmb5XZH63dMm8V6fMvozJjrc0JmI
 7b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533941; x=1776138741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Uv4Eg8s+HkZA/OZ512xnHvUaWkX2GzzIftpT1D54dc=;
 b=FTV32b8yIfriFk0vJTriLU3AzStozxTuEtdqneM7ymWtEbiiZSB65uVh/GaWXZBMcN
 PX0KrDKHqAiRP9aRTcvwqRi/9fnuzwY4qnYF5CROdYZQ+cxyGHy2Pmrxa9iljDmQTxTZ
 Z03h9Th4JHwG1Gc358PcAwLAacWAGXJHrgY59oVznvlQ5JjzxvZQqftZbcFbw1BSzyUC
 a/OBJfHWugxZfiK2eD4u9bC87IKXGuhms4+IkI5oT5WYQ6TQDGgngbZLTHPz698hgM7m
 jKjUl/9biP5GVoUc82NXGdIOwDl06s8AJ6xX2/ln4w+vQN3kPh5DqPnlgRqEgl1Ry03W
 iigw==
X-Gm-Message-State: AOJu0YweN3yP5/fW+Fq52yXM9qeF1YpupQ/xfLfHK9+9tlsbWQFEB5+9
 hpVrhtk3LHc3WvsQelEG5yzRguY21YmaaNWSZfxExVUmdMRO7AXBY4RUhiqcoQCphTEwZ6wfl4Y
 75XrD
X-Gm-Gg: AeBDieswWc80QxwKBrW0xKqRZ7KtlDpgzOI1WwHpi5pYC091poa2PqVobGsqhHEIAsZ
 TK7gJn4fyB8px//jJsp6+3z3IZInX5ufZzpBm8OA3LA96VvHsOpxGg+jU6n7mvC9HopifxS0Q+w
 LCx23K3y2R3MoL1eLWQFVYRAGWZC4h507fYTH0jOxK5HSQOSi84/X9cjTg38xEI+SW1yg3YPlc7
 7DN/Lsu43HbrthMIbLDFHWFGK9RT9b11ylbVzoGnge9MCvkdFUWhulM//I59RnX+yecSVbADd+t
 LW7lfYUe4B9BmE6bmfvM5IZRBIsH13IUv+KJ2xVyTU1RH2+0WTTANeJT6FoqGm7I5g4SFlmsJBD
 zC+SJs951HD5FExTEON5YCYY1glnXxWrkdn/O5NIiHOtCAih4LngGRIOBTCNwTULymQcOy0URMH
 Kt561IQ+zuGwX8CEWVr0E+Tg49KjfT4XOP
X-Received: by 2002:a05:7022:6629:b0:128:c1be:152b with SMTP id
 a92af1059eb24-12bfb6eddcamr7389729c88.4.1775533941498; 
 Mon, 06 Apr 2026 20:52:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 10/23] examples/ip_pipeline: fix shadow variable
Date: Mon,  6 Apr 2026 20:49:36 -0700
Message-ID: <20260407035209.650419-11-stephen@networkplumber.org>
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

The variable p was used for both pipeline and parameters.
Rename first instance.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ip_pipeline/cli.c       | 9 ++++-----
 examples/ip_pipeline/meson.build | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/examples/ip_pipeline/cli.c b/examples/ip_pipeline/cli.c
index 766fc8e46e..935c9b39d5 100644
--- a/examples/ip_pipeline/cli.c
+++ b/examples/ip_pipeline/cli.c
@@ -4721,7 +4721,7 @@ table_rule_show(const char *pipeline_name,
 	uint32_t table_id,
 	const char *file_name)
 {
-	struct pipeline *p;
+	struct pipeline *pipeline;
 	struct table *table;
 	struct table_rule *rule;
 	FILE *f = NULL;
@@ -4732,12 +4732,11 @@ table_rule_show(const char *pipeline_name,
 		(file_name == NULL))
 		return -1;
 
-	p = pipeline_find(pipeline_name);
-	if ((p == NULL) ||
-		(table_id >= p->n_tables))
+	pipeline = pipeline_find(pipeline_name);
+	if (pipeline == NULL || table_id >= pipeline->n_tables)
 		return -1;
 
-	table = &p->table[table_id];
+	table = &pipeline->table[table_id];
 
 	/* Open file. */
 	f = fopen(file_name, "w");
diff --git a/examples/ip_pipeline/meson.build b/examples/ip_pipeline/meson.build
index c5cda980f9..68049157e4 100644
--- a/examples/ip_pipeline/meson.build
+++ b/examples/ip_pipeline/meson.build
@@ -28,4 +28,3 @@ sources = files(
         'thread.c',
         'tmgr.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

