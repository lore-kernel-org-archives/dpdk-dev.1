Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE5CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2382D42E48;
	Thu,  1 Oct 2026 00:43:56 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 6838242D7F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:52 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e69so2016517a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808231;
 x=1791413031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=rJ1VzdLEBxrqEeJx+11HL26RFDCYAHOWWdfH1Cj/ifQoF3OmULcXm309C56f/5+uyN
 Xrtirs/UKAEWndj3AvpPcdekz0AXwrQf1avuZ6GLYAj3NnkzSmT4NklgwFTzpRBbUOYJ
 tVkwslahrexxhvezZIfFXTBab7ZEqZ1b1hBZH8ufP3t9BTwu7Np7/4CJRsrCLlDl70OA
 wb3DRRiFp3giYcuCsz29vJ1Q1wrB85N8RnJwJ6d/rR4P5vlPvhfjIS4xBSUsP9LxTLj5
 9tkXDypoamqGI50bnDbD1p/G8QuG3Ox+53f+3oSIUtQXfEmOdJUqhIPVEibtiUUrBhiM
 WGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808231; x=1791413031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3yXRH9gAqEJW3IPR0K2qKQbXFFTby7VEkIyx95jLSbE=;
 b=yOQgH7iFtG0LDszYejapTxUpxKRlEx8yiF9dx9kfS/pKOaMm4usFs00sCAWimnW7Wq
 I7giTBMGd9Pn3Hnfwc80YMDGGnqhpHJUJURIKG8lG+8a7xnfAUVwRVd+JTbUND1/KXIv
 E5rdovPhJIjrCTQSuIuOBfrtTiQh6Lq0ZnsGHdbAFkpTPIS0RjWglKaJc5lXW2ojJbG9
 G2TFtZcUd2f02Gl3kroPgIOy/3XOJlCOIr3QQ6tBaIC60ytjgKWrJLeEArD96hJwEfoG
 884hgdPl3kJwpphHJgcO2re0BKvFRShCgBsVoowxjzAxiUFEWa4DgHsrThI7vBZyEF/m
 aB0g==
X-Gm-Message-State: AFq9FYLhtJ9DJ6050Fu6zjZ9hB6z6dFn1R5zyjglTXJDdh4oynPVGoGg
 Za9aWQcevoP7WPiMIQt2zTtxXCCGGCE81NBfibRTPvPTFTjwsKZButyVGr/Pzyf8YL8Rg7DJC52
 mK3s9OJI=
X-Gm-Gg: AYBFou3fYxIYfZ3tB4xsUCIks/PATM8jYR/e/xCh3qoxWWLRTNBaEi7f/H0mVFszUiP
 I4XoQkR660V1kng9VSZZP0yXXXZ942UhfgCG5D07JSoAoRCGP+lNtJlyf3tQgPTSb6+5iDUlm/i
 s0nyJQrgqI+4JruZ9YLmH9MMuxKXxYjDySzFEe93s3R2/CXfCW/XUbsaVY8dhxBEnzvaBlLFpSc
 H9A0/cY4m/WsAoSKrkhEH5VuC5qq3W9kHTx7mKGWjfdBo58z5Z9x9fBi+xaiBGtPH1/wfUkE/C0
 AYBe06vysFIO9FYRnUqHv85djBdXBC7cBt+L8W0fQ+ES3GBzwhFOz3ai+HWAbW2nym4aOwYFuOu
 QmFsq9SMttX44tql91br+CcbN+kmgx1bl/DK05k5jz72dsnF6MCUtgInbKajD6FNPoMskmuPR6/
 ZwD1GT2Jec+al8RUWByYP6Mc3eaReyaXtIFOorb5Qo8s8gHVPloYOgfZzRahrKocEq+Gg/MUt/J
 C6j1JWGS+5wOLcQ0slm1CCuRJH26ajdP4WJIg==
X-Received: by 2002:a17:90a:c885:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-3a4d0f0225bmr2187817a91.1.1790808231572; 
 Wed, 30 Sep 2026 15:43:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v3 09/65] net/softnic: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:27 -0700
Message-ID: <20260930224340.58580-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

