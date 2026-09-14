Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B3C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B1B40693;
	Mon, 14 Sep 2026 07:49:51 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id E1E3940A4B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:50 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1569036a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364990;
 x=1789969790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=MFTi+F1yWuEGGbFczdNVpmqxMCiAzyVATX+kgj+v0Puhscv7rUckpGvVR16AggWNb0
 JKaH0lU92yHZMm8v5dlD1XdELunMOHCeWLNW8OeWdyTY2p6mzvvDf2xyNC8GLaTp/zqG
 KiWaDZf4jIRWGeHsIoCSdTGNM1QTo79A7EObxSAyYakRqJJa+MLpzWINzta3+ZhCy4Ty
 tmibnfZdR5UfUjlZnu4vVqVS7P2s2ez/UsNGGqntibWTlN0iMQOJhPB4hDVw19WFZTN4
 XvfGtFwIUpCEC3vWz8XirloM2x7O6hLtI+T9KtbGgzviswWiOmBccmGEH/7E+7w2kOVu
 Y0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364990; x=1789969790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=NDh7WH41L2WGcoRXSGZ4cOjJcW/ut7SLx7cxESBjxvIgsBu9hyLCSaCk/sq+MI/8gs
 qTti5/e8PK5atOjg1uiBJmrWJcStRjwEo6py/eynHN5nSlbY7d3yrSf+Zcp09PzhnMUP
 IfRZKPjCsBwHcKSmR/gK4XQi1CjD0bnJU/4ZQekopgCwb2521kLkVcupVAyMJucLI7Lt
 8zTFXARsXiyS/JjSiFSUaTU9Dg9/2Y+R+RJ9GET7yWjJcEVtyVFEQbXXPIXdKJjbUdNh
 MV0QyNaBZ5Yevsxp9lin8WHXhVCcUyZeD264wpzEUrEt7FDhsFx0ARDW4ejiHEsGm6d1
 zEWg==
X-Gm-Message-State: AFuF++lFkTH4ICZa+5S4/mIAaKK0vYefBhyCN14Vl+0MChev75Ortwv9
 b+rA3cGmfiKRJcVOEcF/hCgwEzTARje3imQWzcWIkQGRm95Mt9BE6urZSYl+JWmoXdrN+DuPLTT
 v5oEYMQk=
X-Gm-Gg: AYBFou0Eq/aCQmXbZUeFoJ4x4zLUCRgBG2xOR4Ch8/aFrQonw9nPVxotxuX1YDVL59A
 FJW1OsbmW/EMzJjL5WkohcFldqmAIwRWxSmjZVbBRr1eAOgBHd0/K53UJQDL4yxcs5o9ey+ZqXS
 ByMjP8/xR6R+87E9pEx7bXHMtPu1YMmvR1yN/D8qSxUxqJ/CSH/dcncbN/w7N8YwOA8h9E/xcZC
 U0hyJm6pYuFVpUc8Zwvz0y69LlqD11XkScubwXqVmxGr80ujlNXTyX2En5IEoRwFssoD+modY4f
 AkYr4bUfMcuTJM8A0KN2GMRvSdzmVHPTTPQRdX6KzN2h3UnK0+8Cb4oXckJjfbQrQMNG3/jfOyr
 ov5wkjiiYPeW83qPK+ZASjzY2uYp53nrtwvpxoKpB7KyRxsfMO7LQ/dfPT6y48pnZIUskoHrq6Z
 kYNjMzvA+m0NhaKjv9fYHDlvLdnU6IEHErmwcjoWFZH8Tx347qH0V5GmmQu1Nly6QYKe1W56Nve
 YPOB/JQSmP7yjiVOF98Hgj0c9YnoqvSb7j8hQ==
X-Received: by 2002:a17:90b:3ecd:b0:39d:ba21:fd90 with SMTP id
 98e67ed59e1d1-39dec04f01emr2205786a91.16.1789364989937; 
 Sun, 13 Sep 2026 22:49:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 09/62] net/softnic: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:40 -0700
Message-ID: <20260914054912.755403-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

get_uint32() and get_uint16() check neither errno nor the end pointer,
so a malformed value is silently taken as zero and an out of range one
is truncated into the target.

The service cores argument is only ever tested for truth, so make it a
bool. It was declared int but written through a uint32_t pointer.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/softnic/rte_eth_softnic.c         | 30 +++----------------
 .../net/softnic/rte_eth_softnic_internals.h   |  3 +-
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 868e194509..81688d1dcf 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -344,28 +344,6 @@ get_string(const char *key __rte_unused, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-get_uint32(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	if (!value || !extra_args)
-		return -EINVAL;
-
-	*(uint32_t *)extra_args = strtoull(value, NULL, 0);
-
-	return 0;
-}
-
-static int
-get_uint16(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	if (!value || !extra_args)
-		return -EINVAL;
-
-	*(uint16_t *)extra_args = strtoull(value, NULL, 0);
-
-	return 0;
-}
-
 static int
 pmd_parse_args(struct pmd_params *p, const char *params)
 {
@@ -412,7 +390,7 @@ pmd_parse_args(struct pmd_params *p, const char *params)
 	/* Connection listening port (optional) */
 	if (rte_kvargs_count(kvlist, PMD_PARAM_CONN_PORT) == 1) {
 		ret = rte_kvargs_process(kvlist, PMD_PARAM_CONN_PORT,
-			&get_uint16, &p->conn_port);
+			rte_kvargs_handle_u16, &p->conn_port);
 		if (ret < 0)
 			goto out_free;
 	}
@@ -420,15 +398,15 @@ pmd_parse_args(struct pmd_params *p, const char *params)
 	/* CPU ID (optional) */
 	if (rte_kvargs_count(kvlist, PMD_PARAM_CPU_ID) == 1) {
 		ret = rte_kvargs_process(kvlist, PMD_PARAM_CPU_ID,
-			&get_uint32, &p->cpu_id);
+			rte_kvargs_handle_u32, &p->cpu_id);
 		if (ret < 0)
 			goto out_free;
 	}
 
 	/* Service cores (optional) */
 	if (rte_kvargs_count(kvlist, PMD_PARAM_SC) == 1) {
-		ret = rte_kvargs_process(kvlist, PMD_PARAM_SC,
-			&get_uint32, &p->sc);
+		ret = rte_kvargs_process_opt(kvlist, PMD_PARAM_SC,
+			rte_kvargs_handle_bool, &p->sc);
 		if (ret < 0)
 			goto out_free;
 	}
diff --git a/drivers/net/softnic/rte_eth_softnic_internals.h b/drivers/net/softnic/rte_eth_softnic_internals.h
index d3975dad10..a1f309afb1 100644
--- a/drivers/net/softnic/rte_eth_softnic_internals.h
+++ b/drivers/net/softnic/rte_eth_softnic_internals.h
@@ -5,6 +5,7 @@
 #ifndef __INCLUDE_RTE_ETH_SOFTNIC_INTERNALS_H__
 #define __INCLUDE_RTE_ETH_SOFTNIC_INTERNALS_H__
 
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <sys/queue.h>
@@ -34,7 +35,7 @@ struct pmd_params {
 	char firmware[SOFTNIC_PATH_MAX];
 	uint16_t conn_port;
 	uint32_t cpu_id;
-	int sc; /**< Service cores. */
+	bool sc; /**< Service cores. */
 };
 
 /**
-- 
2.53.0

