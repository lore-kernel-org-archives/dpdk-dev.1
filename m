Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C1ECDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B56C94029D;
	Tue, 23 Jun 2026 17:41:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1D74140150;
 Tue, 23 Jun 2026 17:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782229281; x=1813765281;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yH8GQ2VK22JAcDCkCDftGjdGQ+iIvSMmdMi7rqGkERs=;
 b=hM7Isa/sToIClwSfP0M756x/Agi54tx8ic6zxMyvHmSxzICRqKkHWrpU
 0xqIbXFhlSZROZRfVUjlVva3hVpvi/PvbWBQXqh4YxxzhUdFC+4zc6DII
 4NiOeaqJq/MqWGOhtmYZybPOS++2Km5haGHmIl8VrZh9XnXd+brdE72TX
 DcE5N60cJDhGfLqwXfhk/2qW4IZaNO+wfR10uGROvH2Sm1aZ9j/xTA5JB
 Kuh4Ug7oXXD2RUYM+iMvB9Vnx8wafoYrXyoCqzPETdDvjYoQRvAle5ljo
 r+745wQNX10zHqiZM97ECNFqZaVe1MiU9Fc7zqULJ+GoR3WECCHoPb+GU A==;
X-CSE-ConnectionGUID: BHeCWOBcSRWQyNr1RpQDVQ==
X-CSE-MsgGUID: mobeHGVORwKlRzgIB5ZcBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83066892"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="83066892"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 08:41:19 -0700
X-CSE-ConnectionGUID: HjhPQ+KuS1mTh669FXHtWQ==
X-CSE-MsgGUID: W290WdrQQXqsd1h05dD5fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="287685495"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 23 Jun 2026 08:41:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Alan Carew <alan.carew@intel.com>
Subject: [PATCH] examples: use strlcpy and strlcat
Date: Tue, 23 Jun 2026 16:41:08 +0100
Message-ID: <20260623154109.722441-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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
---
 examples/ip_pipeline/conn.c                 |  4 ++--
 examples/ipsec-secgw/sa.c                   |  4 ++--
 examples/l2fwd-crypto/main.c                | 12 ++++++------
 examples/pipeline/cli.c                     |  4 ++--
 examples/pipeline/conn.c                    |  4 ++--
 examples/vm_power_manager/channel_manager.c |  3 +--
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/examples/ip_pipeline/conn.c b/examples/ip_pipeline/conn.c
index 30fca80c14..9f347fd1c2 100644
--- a/examples/ip_pipeline/conn.c
+++ b/examples/ip_pipeline/conn.c
@@ -115,8 +115,8 @@ conn_init(struct conn_params *p)
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
index e168c4ddaa..257f3c9f78 100644
--- a/examples/pipeline/conn.c
+++ b/examples/pipeline/conn.c
@@ -116,8 +116,8 @@ conn_init(struct conn_params *p)
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

