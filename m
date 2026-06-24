Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C94CDE000
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F6CA40150;
	Wed, 24 Jun 2026 12:27:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7C2B5400EF;
 Wed, 24 Jun 2026 12:27:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782296873; x=1813832873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8MwrGRDD3TIOqRmoJYJqiNgrDa8SAoq6RvCH0Z04saA=;
 b=NCED9nLYKCRy40D/3+K3kp4D5ceX3L3covpqudk183CEHtOrYfzxOLcC
 yD25ruN5nb7wcbgJGAe2LqePvRa0nmcshP73cgUG09se5qoXLOTP5m10X
 J+wF0rO8HJHpd2ODMJ5uKyfYY8CKe8vieXo13E8cTg2s8e8Sg/kiXjAGv
 on2KIZzGV3cGPThV8NBTHNRmSLJmx/5XVkavuSFnuBzdPkIT/iUPLtfyI
 IGDABRSppficiKcM6hFgWDP5AVjrAABDeuW3OaHPcFTqQT5TzPCLxKFLD
 EEKOXrhh7LDj+FDktR4R0pd6GPxT72dl9tg1pvFlCGyeesvofooE5iasy A==;
X-CSE-ConnectionGUID: TfcfTi27Tt2g+rkFQ9eZEA==
X-CSE-MsgGUID: pbi8Ku0TR2Kqrsjb4GsRIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100478583"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="100478583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:27:50 -0700
X-CSE-ConnectionGUID: dq02aisPQ6i6oWQjqq0DSA==
X-CSE-MsgGUID: xBUKbBZBRUayf92Sw8dNCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="273490450"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 24 Jun 2026 03:27:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2] examples: use strlcpy and strlcat
Date: Wed, 24 Jun 2026 11:27:34 +0100
Message-ID: <20260624102734.789631-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623154109.722441-1-bruce.richardson@intel.com>
References: <20260623154109.722441-1-bruce.richardson@intel.com>
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

Replace strncpy and other unbounded string functions, e.g. strcpy,
strcat, with the safer alternatives strlcpy and strlcat, so that we can
guarantee null termination of strings.

Fixes: 4bbf8e30aa5e ("examples/ip_pipeline: add CLI interface")
Fixes: 5f657a7fbe86 ("examples/pipeline: add message passing mechanism")
Fixes: 83f58a7b7b0a ("examples/pipeline: add commands for direct registers")
Fixes: 0d547ed03717 ("examples/ipsec-secgw: support configuration file")
Fixes: 63e8c07c7245 ("examples/ipsec-secgw: fix configuration parsing")
Fixes: 41e97c2ea9e6 ("examples/l2fwd-crypto: extend crypto information")
Fixes: e8ae9b662506 ("examples/vm_power: channel manager and monitor in host")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
V2: add string_fns.h header to two pipeline and ip_pipeline examples, to
    fix builds on older distros without a built-in strlcpy fn.
---
 examples/ip_pipeline/conn.c                 |  6 ++++--
 examples/ipsec-secgw/sa.c                   |  4 ++--
 examples/l2fwd-crypto/main.c                | 12 ++++++------
 examples/pipeline/cli.c                     |  4 ++--
 examples/pipeline/conn.c                    |  6 ++++--
 examples/vm_power_manager/channel_manager.c |  3 +--
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/examples/ip_pipeline/conn.c b/examples/ip_pipeline/conn.c
index 30fca80c14..b2406b7af1 100644
--- a/examples/ip_pipeline/conn.c
+++ b/examples/ip_pipeline/conn.c
@@ -15,6 +15,8 @@
 #include <arpa/inet.h>
 #include <errno.h>
 
+#include <rte_string_fns.h>
+
 #include "conn.h"
 
 #define MSG_CMD_TOO_LONG "Command too long."
@@ -115,8 +117,8 @@ conn_init(struct conn_params *p)
 	}
 
 	/* Fill in */
-	strncpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX);
-	strncpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX);
+	strlcpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX + 1);
+	strlcpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX + 1);
 	conn->buf_size = p->buf_size;
 	conn->msg_in_len_max = p->msg_in_len_max;
 	conn->msg_out_len_max = p->msg_out_len_max;
diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index 866ba04b86..b5068765b6 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -338,12 +338,12 @@ parse_key_string(const char *key_str, uint8_t *key)
 		if (pt_end == NULL) {
 			if (strlen(pt_start) > 2)
 				return 0;
-			strncpy(sub_str, pt_start, 2);
+			memcpy(sub_str, pt_start, 2);
 		} else {
 			if (pt_end - pt_start > 2)
 				return 0;
 
-			strncpy(sub_str, pt_start, pt_end - pt_start);
+			memcpy(sub_str, pt_start, pt_end - pt_start);
 			pt_start = pt_end + 1;
 		}
 
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index ff189b5fab..22ad825c91 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -1576,19 +1576,19 @@ l2fwd_crypto_options_print(struct l2fwd_crypto_options *options)
 	char string_aead_op[MAX_STR_LEN];
 
 	if (options->cipher_xform.cipher.op == RTE_CRYPTO_CIPHER_OP_ENCRYPT)
-		strcpy(string_cipher_op, "Encrypt");
+		strlcpy(string_cipher_op, "Encrypt", sizeof(string_cipher_op));
 	else
-		strcpy(string_cipher_op, "Decrypt");
+		strlcpy(string_cipher_op, "Decrypt", sizeof(string_cipher_op));
 
 	if (options->auth_xform.auth.op == RTE_CRYPTO_AUTH_OP_GENERATE)
-		strcpy(string_auth_op, "Auth generate");
+		strlcpy(string_auth_op, "Auth generate", sizeof(string_auth_op));
 	else
-		strcpy(string_auth_op, "Auth verify");
+		strlcpy(string_auth_op, "Auth verify", sizeof(string_auth_op));
 
 	if (options->aead_xform.aead.op == RTE_CRYPTO_AEAD_OP_ENCRYPT)
-		strcpy(string_aead_op, "Authenticated encryption");
+		strlcpy(string_aead_op, "Authenticated encryption", sizeof(string_aead_op));
 	else
-		strcpy(string_aead_op, "Authenticated decryption");
+		strlcpy(string_aead_op, "Authenticated decryption", sizeof(string_aead_op));
 
 
 	printf("Options:-\nn");
diff --git a/examples/pipeline/cli.c b/examples/pipeline/cli.c
index 215b4061d5..901706fab9 100644
--- a/examples/pipeline/cli.c
+++ b/examples/pipeline/cli.c
@@ -172,9 +172,9 @@ parse_table_entry(struct rte_swx_ctl_pipeline *p,
 	line[0] = 0;
 	for (i = 0; i < n_tokens; i++) {
 		if (i)
-			strcat(line, " ");
+			strlcat(line, " ", MAX_LINE_SIZE);
 
-		strcat(line, tokens[i]);
+		strlcat(line, tokens[i], MAX_LINE_SIZE);
 	}
 
 	/* Read the table entry from the input buffer. */
diff --git a/examples/pipeline/conn.c b/examples/pipeline/conn.c
index e168c4ddaa..5fb033904f 100644
--- a/examples/pipeline/conn.c
+++ b/examples/pipeline/conn.c
@@ -15,6 +15,8 @@
 #include <arpa/inet.h>
 #include <errno.h>
 
+#include <rte_string_fns.h>
+
 #include "conn.h"
 
 #define MSG_CMD_TOO_LONG "Command too long."
@@ -116,8 +118,8 @@ conn_init(struct conn_params *p)
 	}
 
 	/* Fill in */
-	strncpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX);
-	strncpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX);
+	strlcpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX + 1);
+	strlcpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX + 1);
 	conn->buf_size = p->buf_size;
 	conn->msg_in_len_max = p->msg_in_len_max;
 	conn->msg_out_len_max = p->msg_out_len_max;
diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index b69449c61d..339c7fbb93 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -875,8 +875,7 @@ add_vm(const char *vm_name)
 		rte_free(new_domain);
 		return -1;
 	}
-	strncpy(new_domain->name, vm_name, sizeof(new_domain->name));
-	new_domain->name[sizeof(new_domain->name) - 1] = '\0';
+	strlcpy(new_domain->name, vm_name, sizeof(new_domain->name));
 	memset(new_domain->channel_mask, 0, RTE_MAX_LCORE);
 	new_domain->num_channels = 0;
 
-- 
2.53.0

