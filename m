Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E024C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:21:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F33FC40A7D;
	Wed,  5 Feb 2025 18:20:27 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 3A9F340A72
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:22 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-71e287897ceso43689a34.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776021; x=1739380821; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4F+ezsTfyQiTlz+XpsQS1y58OXwpnowdwfis2twB6io=;
 b=C5WDQ+yqsCSeB4UUIqd+qdhwobanRVwS8IBQE4l+2v2822JMb858Pmn32JjJVp6SCr
 CM0AC06si4mphGnnXxnmU0EJLXgIUCld1o+MtYofDpV9y0CUfSR+h9YdcYavCV6Sd53Q
 efh1rYNnTwSZe73qvAGTq2FfhvHlndE6w4TE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776021; x=1739380821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4F+ezsTfyQiTlz+XpsQS1y58OXwpnowdwfis2twB6io=;
 b=gpNk5qIN2ZBt9quqN9UJ1pVg9J8gK45XXQyzGSTN8H7uGB8rrE9tLaFrNqKjr2jxDR
 gUtrLea2x9BvQllKXFhrbRrHLTSSUSptSco4EEQt1ghrrwPAUow0wtXbfYgHpMS4jSl2
 LZFBQQaJ9GOJtROlRtBQt0kM4c3OK6/f3LsP7YrC1cfytfBhWIVS4IECRZMKaqSzEGNr
 4FgYo2LO5REkS3yaEZGjfTmF6zJUm2cWX5W+GAc7/cXmJ8jUPDDyMUmbjePpMKlgxX0q
 YZ2bLB5luvib7D+ckXhS3HURZQtRr7N1ee2GkynNKOAjYkhd90VSc7xj4ZA/DBjMJzq/
 HLuA==
X-Gm-Message-State: AOJu0YyB0KBJsFd+DJEL/BKwijaKCgiBfNun3PODwqMWRsQbWK4jvUSG
 Dh7nQOKQoJDKpq13WLo8ni8r2lqLME3fkelnGNzXWZl08EyyxBhFP7s+OIY+iujEEBCfcy9MD1/
 ZZbvChE23YeW5owXlnxAjXRPYRO2FwtpikFXWoAiKzGWvMPYr6GdLoJloYCX8YgLlXp9iQ4yMAv
 Dn8wLteKhrQFqOXiuE5F0Rgh6G3lYO
X-Gm-Gg: ASbGncuB23EZLKqx/1pjTlPkWvPgOTMoa9z5o+r+xc8JByMYPMpjCz60DBIbxR1bS6e
 q2wyGIQo6wcb3usHWNe0yxj+AlLoydqUKErJWL85F31Bj/AcNNmZ614ZyJ/Nn/3F4TsUk4z3a9Q
 YKie4THlJgZOafTlriv9VRhj0HTdLs8OFAQll1Oxa+IqPKSEkrlfgGODVttLrqTuIu6VcOZD03s
 YywMWESMpYRoreBJ9yAPf5UnCRrgYGEtHTycsuMTxMUyp+ZBacj/dooE1R+491bcBbbDRPUKrr1
 xN+XsyyazXE/6DPKXeUZGUVnjRztnBOOZGk1gZ/dlSiLdsY9GExXrOB5bINcb6VOC6MkkY3FBLN
 ukT/9RbDD
X-Google-Smtp-Source: AGHT+IGtG2l88uEewze0SiUl0qjTCDqEy391iup8PAJSpPMy5Os1vUt4qdL112iqsOORk1Yttyw4BA==
X-Received: by 2002:a05:6830:4494:b0:71e:72:3ab6 with SMTP id
 46e09a7af769-726a427eb7fmr2388079a34.26.1738776021268; 
 Wed, 05 Feb 2025 09:20:21 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:21 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 10/11] net/bnxt: address coverity uninitialized variables
 issues
Date: Wed,  5 Feb 2025 09:20:03 -0800
Message-Id: <20250205172004.50395-11-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449065:  Uninitialized variables (UNINIT)
issues reported by coverity.

Coverity issue: 449065
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 1 +
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index a70e35b6b1..d460ff2ee0 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -560,6 +560,7 @@ int tfc_em_delete_raw(struct tfc *tfcp,
 	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_LONG;
 	mpc_msg_out.msg_data = &rx_msg[TFC_MPC_HEADER_SIZE_BYTES];
 	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
+	mpc_msg_out.chnl_id = 0;
 
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 5fa8e240db..57cbaaf09c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -224,6 +224,7 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 			if (bnxt_ulp_cntxt_acquire_fdb_lock(ctxt))
 				break;
 
+			batch_info.enabled = false;
 			rc = tfc_mpc_batch_start(&batch_info);
 			if (unlikely(rc)) {
 				PMD_DRV_LOG_LINE(ERR,
-- 
2.39.5 (Apple Git-154)

