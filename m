Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE460CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E820842E5B;
	Tue, 29 Sep 2026 18:38:22 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 5D02842DAC
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:16 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1990585b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699895;
 x=1791304695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=BLDr+uWRT2qlf78iXMDuQ/uHAXybIXPayGmMpWhUj84M4GDaX3ZgkR5E2PwKUF895e
 zTG1PwXi5NmxdSPuwyBaxHHeMtiDVHwsGGhY5AVWHJbwe1ShIZSuKWrcIxPECIU0mas7
 OO/got0RUdycbZ9UBBSJTpZxwZ2wYkdDPPfB9fZDb+k+NJu1CWtu9Uqdm5LuU9j7HD9Q
 Hk1fi8lNG32xf3DTwa/XNrduWsZJIMUsD712wvTvl4G79e6XXoZlNErpAzB62oRItsOS
 ybfCl+u+F2JTf/r5WR7DNL5XuApH3Hpq/uScC/PJyJu2Jhw7PjmpPfbXwikDf+QzeGZc
 XbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699895; x=1791304695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=fal5Xqg+XAI/a56clOKC/1g6AsXP8WzDPmgnh+7oiPha806xqk/AnsbAkp4TMqrWge
 F6sPIM9iItYsfd9Yq2FqtWH23ofIBgFpjdlogco+KlYRPIfBgrsKbhsScmG82c4YBxCg
 wF7Yc3W8k0QH0MwEmKpydOCQ3VzJM56s3MiXjzp6EKmmcgM3YBly/dNWRdEewU8EqSJK
 kJ8a5fVjtd4YEg84OmC0wKgJjeJ12By154O6NlgO7ZseYZJXgEKf7zzveXT58t5R+MUI
 1TsWmBJFADwFznq216ZCVrlV5MeI3eNAME2CHYHQSI+h5QO2lm2lCf9HtD5o9D91bHw+
 zIxw==
X-Gm-Message-State: AFuF++kHdvaLsp/McHQdD+VaReElGWI6buud5YKDMQPI/4R0Po1a9oV9
 sInzipLa1GOHa1S2NJzOwx6rgjwfasl+D8AnmIr+mwdpHFQ9M8Ox5Ic+j3DqpyGQdo/HL7zAeBf
 CHWh/jlc=
X-Gm-Gg: AYBFou11lsZ8GQKuQNDC2G+6WKO+h3heAKkmcMPFl1XOinD8V0xxEuOrIBO88Oaikbi
 dhJpJ6Z6csvKvMko0SLutDqqYmaIl855QI7kLZbkTEspkPysPm2lwwiKT9uyAXi3i5WJ6aGggyv
 tNwjKk95soziqQxKugvGJLMdH8xBeydmaR7L9YYjx5mVp26IoBdVno1K6KewSFjn/3Eynrcd87x
 mAvA1R7haFzvT0xboqvOKbAiFte+aAp4j43NubuOQ1OAVk/QL0d2qXPQvRylOXpd9xe/Q33w1st
 cvAGu7lcRfLSDAkAYoHx5STTXIh3siaAqFDmyO7yNxliBC96chmHzG+l1H8YU36zsXeYnEz1MgV
 GFztpOhF6S2tSUyxWuab4fN23sGUrzWi/7K2kl4AyWcCEEWwJbA6ifqP9NEREgFBKffb/JoQnWC
 PUWmZSd/YRWahr1/je81AbqoxhXhddsg8Pz4/ADAZGcF2MuAu+G4rjnbrmKm9bdOBIGIpO5L/bu
 6vCz7asEEIfdW7FZY/fcmi18jxcjSDD6FgN0Q==
X-Received: by 2002:a05:6a00:e18:b0:886:27ad:1f42 with SMTP id
 d2e1a72fcca58-88627ad226cmr1339776b3a.60.1790699895501; 
 Tue, 29 Sep 2026 09:38:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 08/61] net/softnic: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:11 -0700
Message-ID: <20260929163800.1108305-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

