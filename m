Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E40CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:51:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F7CF40E3F;
	Tue,  6 Oct 2026 01:51:03 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 85C4640E16
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:51:01 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3a7cfe8f761so108680a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244261; x=1791849061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7uVmCNqs3Jff/3UMmViKia6z1yQQmpS5574S2+M56LU=;
 b=LN7u3AL1WKhb3T2P7Lv+Pe2Qot754WwWmES1BDCUX+gHfum2AFeNi9DdTEUo81Jv7E
 WXewhVknDjg/S9eQx06YYCQFTFa5nG7eCiN1B9vbkL6R4AYLUNxLprcctzOt4hjvAVhM
 H/Y6n/ongshj/JbCWV6pxKCk2cTeCJdrBLRuNUHfsPPyMc/qMSBj2Jo9nBXvIrkfVRvr
 d3cFy1ey+TG9qo4OUi4uGz6efb5UNZ4oUK1vm5kvgvlOxO6AcKVIZGpNCbMJMBrD7pQl
 o+IBWP7skZa5n1gwEZsD2mD0DLFoE49QB4XfglOogYjx8Dy8KX+4jq7U5U64IQ8o0O3r
 R7zQ==
X-Gm-Message-State: AFq9FYK0gRSBNNcVjtHG2G7yeW+GbS8T9NzKWWLbXdc4E4+g/ZcF79Ct
 FmzkEDpBxk4hJaUdA0q9Su6pQqwtVI3j54jxxH5Obcbz+UFR+VJXKrJrSqHM/BqGu0q9ZzGee5+
 4zpyAZvMGL9PSVB5rQcFqIDq/jfhbmKguogGfaOpc78X5pFBLbtsPGzYOqo9O45pv2WYAajOhLN
 eOtuED/5Shd9tjuzlzezu/AirnegEZuWropXMPK53CHFg8+jg/f9TAgjBwoFowjeLCJrr7xQ==
X-Gm-Gg: AYBFou2LnreIwWtfESn9mjfnDxi32hD+tI8HzxoIDGDJMYfnKdXQ/EXyWcadOzguaRC
 iVijLu5Qq5tZIk2KnrNbAKvRZAFb+khrCGFzlcr2uwQwFSG83Xw6b+XaNPDnGSApsc8FTvcAG8s
 aozmbF+ndx5x7BOjbEPpgzDgcjuO+jZTkO8iqPxLx2ttATmfEXBLgcsxpE1efLO9ANBvKownHZh
 X5PLzGC1z2eJBML633YJdiROMshuR449r4skyDpGD4fiM4w0o8e1az8EBw6uOKq/5f64TC3LNwu
 5q5gHtE8tfEMQKNmm4XD/g9HJrmlRAnx5U4jxNoeY9P4Fb85Lv/v3Z3+LaRq5PwgafeM5SaOjLl
 qt/UJftCqHdJnEjlP7af1CAI1dQ5GwwB++EyilXpTwUU/GOZVanj0mE6swbeSFqwrwhYMTDhrLl
 ePxq+/6/gRKegQDRuiJQiOOWhGd6xShRH9nmht8g==
X-Received: by 2002:a17:90b:4f88:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-3a852ecb2a4mr662507a91.0.1791244260523; 
 Mon, 05 Oct 2026 16:51:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a853cc549dsm489948a91.7.2026.10.05.16.51.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:51:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179743a76eso8920596d6.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244259; x=1791849059; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7uVmCNqs3Jff/3UMmViKia6z1yQQmpS5574S2+M56LU=;
 b=SYjiaJmKL31Fc8O4dJ80BUAzQPb3JAV6y7jjctD1SN9DMWrHUl54pSD/JwZ2nuFdEV
 fTGoRYQT94iVeSFZfFIP+qe+U39aHzPTBWQz805AZdiicEvFgQg3AhWdfgyJCsj78IgK
 s0g6C1rGqpcnRyK9j/b1qHJbglep6OVXXKKqE=
X-Received: by 2002:a05:6214:29ee:b0:914:499b:2944 with SMTP id
 6a1803df08f44-9198587c5d4mr24035416d6.13.1791244259153; 
 Mon, 05 Oct 2026 16:50:59 -0700 (PDT)
X-Received: by 2002:a05:6214:29ee:b0:914:499b:2944 with SMTP id
 6a1803df08f44-9198587c5d4mr24035086d6.13.1791244258627; 
 Mon, 05 Oct 2026 16:50:58 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9197ae252a5sm26505326d6.47.2026.10.05.16.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:50:58 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: harden CPU index validation in stats cache thread
Date: Mon,  5 Oct 2026 18:50:56 -0500
Message-Id: <20261005235056.27126-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Use a < 0 guard instead of == -1 when checking the return values of
ulp_sc_find_free_cpu() and ulp_sc_get_first_dpdk_cpu() before passing
target_cpu to CPU_SET(). Both helpers only ever return -1 today, so
this does not change behavior for the current implementation, but it
makes the non-negative invariant on target_cpu explicit at the
CPU_SET() call site instead of relying on -1 being the only possible
failure value.

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 221b57cbf7..92defadc20 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -422,9 +422,9 @@ ulp_sc_mgr_thread_start(struct bnxt_ulp_context *ctxt)
 		/* Try to find a free CPU not used by DPDK lcores */
 		target_cpu = ulp_sc_find_free_cpu();
 		/* If no free CPU found, use first CPU from first DPDK lcore */
-		if (target_cpu == -1) {
+		if (target_cpu < 0) {
 			target_cpu = ulp_sc_get_first_dpdk_cpu();
-			if (target_cpu == -1)
+			if (target_cpu < 0)
 				return -ENOENT;
 		}
 
-- 
2.31.1

