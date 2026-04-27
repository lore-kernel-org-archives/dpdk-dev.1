Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80FAFF8868
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E47940611;
	Mon, 27 Apr 2026 19:26:22 +0200 (CEST)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43]) by mails.dpdk.org (Postfix) with ESMTP id AFBB0402EA
 for <dev@dpdk.org>; Mon, 27 Apr 2026 19:26:21 +0200 (CEST)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6949831a7bcso3804912eaf.1
 for <dev@dpdk.org>; Mon, 27 Apr 2026 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777310781;
 x=1777915581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tstIt7OQzpk+cJq/AW8NOIw/IAdRuHyBRvpEsycM/dQ=;
 b=DjS0iR2mgbIU0qksSAosC92Dd3vgOmDcwN/ZA01zlLS+Hc3msbnVZSFem3uXA46n7W
 ikZ1LUBh8kYh5UT1F8i/SrL46J55IJ17J+AUdS5dXaGA3QJG8FTzmp1OYJh+Ue1dHxXW
 3wMxXvH5jnlz5J95LHXU/Dweb6kLfz2yeoidQroVpW6CYLW/U7f/Apa73ZncTfbYrebI
 zXhSLuSGORtSJSASTLo8pXZMRhGv48KAg1NI54ifrhr4uVhzjK8L4sl0Y/ISV2mOMpRy
 JFN6wJ/0CN0gtxgruWhCJt372J54kwziHXWmU01uFVLYMT6JjYQV7mVvUKugVtShbzMY
 TsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777310781; x=1777915581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tstIt7OQzpk+cJq/AW8NOIw/IAdRuHyBRvpEsycM/dQ=;
 b=UB8LLURDRw32kwGGjR0hpOt7TNBo0c+8PmP1muxRalOSD1NU7OhiwYg7N4kWiIXSPI
 RLHO/bDeU5UcrNcLSMw48VCDwABtMeBCVnwL3s9/066R4CeQYlZImQVHVol7jwTuhRr5
 xbO4kGF2Ujfnav2leqvs1Nycbd+GsTbL+sfIQVHOo9oSCQNYGNaH6Jmwv0f7itA0celW
 mTh3Nnfkn7OYK3X9u2PV7FjcbJ6eTEzJc2RqSfF+sgixmcxD41i9VD98XLh+r9DXEqGY
 uyMRB9qevqYSMz4O4Y7A/nl45Mr+LkBetF714T4pevhzILY9rZOycW/dxEAEsTB/sugF
 TmyA==
X-Gm-Message-State: AOJu0YwAoNYukqgmIpizEJit1IMK89sQJgeT7mqUE1R/p/7KQHa96xk9
 FKhTL1R6FusMYjKRhknswNr+iPukxtm5Qi9EP16Gpr1UQupNczJSZ8uPqMigzvQr/2gTAtbwQ/c
 hHy7m
X-Gm-Gg: AeBDiesklkQJeFQsShCOVvsvp8x65NCFRLhR78UKj8IUQMeD/NAMmxt8+Bu/qh7a/4u
 hwQatfKtWPmkSLM6QOiOCFglduCsP3ZsFthC+fBtDsDvij78yRHWu3Bzwc5vQntH6R/QrBXIXdk
 t2DKrrT2cCGoNXBwBx98ON2b3D/vmAVKfqLeZr6FcV2YOOLmUftozdNbZqtcqBL31s0MxOdref8
 v0bQlkk/L33HEvNY9idf7JKmwTpBARUoNPnatSfzvacJcjPs5gYrLgZ7wodlm4ar6BMJrUJaBks
 h4hPZi2ELurkEj6VjYaTlZ1YyQ+HxPeseJ3cqysCXIosDcPYPdf5KVt+6HZyJOhLuxBY1P8X0Nx
 kkHRW6GfjNn50Igu1tYQH/+0bU0f9wnYuSEX8buF5XDN8Ap3Xz2ZIqgTt4XsPR7Fzv3VlVxiXEb
 vEuPmn7I8r8aolVRB/jcnyFuUro5QzKdWJfbDx7hpYuBY=
X-Received: by 2002:a05:6820:1c8f:b0:696:1cbd:27ac with SMTP id
 006d021491bc7-6961cbe02fdmr10299409eaf.49.1777310780681; 
 Mon, 27 Apr 2026 10:26:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm27940929fac.13.2026.04.27.10.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:26:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sunyang Wu <sunyang.wu@jaguarmicro.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH] app/test-pmd: terminate process on second signal
Date: Mon, 27 Apr 2026 10:26:17 -0700
Message-ID: <20260427172617.295684-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
References: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
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

The SIGINT/SIGTERM handler starts a graceful shutdown via
prompt_exit(), after which prompt() frees the cmdline object with
cmdline_stdin_exit(). A second signal delivered during or after
that free re-enters prompt_exit() and dereferences testpmd_cl,
producing a use-after-free.

Set SA_RESETHAND so the second signal terminates the process via
SIG_DFL instead of re-running the shutdown path. On Windows the
C runtime's signal() already resets the disposition after delivery,
so behavior is consistent without an #ifdef.

Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
Cc: stable@dpdk.org
Reported-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..d93c696057 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4603,9 +4603,14 @@ main(int argc, char** argv)
 	signal(SIGINT, signal_handler);
 	signal(SIGTERM, signal_handler);
 #else
-	/* Want read() not to be restarted on signal */
+	/*
+	 * Do not restart read() on signal (no SA_RESTART), and reset
+	 * to SIG_DFL after first delivery so a second SIGINT/SIGTERM
+	 * terminates instead of re-entering the shutdown path.
+	 */
 	struct sigaction action = {
 		.sa_handler = signal_handler,
+		.sa_flags = SA_RESETHAND,
 	};
 
 	sigaction(SIGINT, &action, NULL);
-- 
2.53.0

