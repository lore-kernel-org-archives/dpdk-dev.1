Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D5FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F03C040655;
	Tue, 28 Apr 2026 15:53:28 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 64A2940395
 for <dev@dpdk.org>; Tue, 28 Apr 2026 15:53:28 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7dcd89701acso6288347a34.1
 for <dev@dpdk.org>; Tue, 28 Apr 2026 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777384407;
 x=1777989207; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF+x0bwZPrU0SIpl4J0lUCPMSLkUkTMIvmkrFh+zu/8=;
 b=NPCdsHxCOxvI7LS+ipOYctJgdJCmvDeV2GGSjKtbzTdRF9LC7HPK80VTmSf7xTPdXt
 4ffisas6KYFDyJ8kpZb3NIDa45L+2V5lx1HK0rb8tliiWcTcP+J+FrlqP6jw8RbhNt9M
 X2Kx8cevJ3RvwZtub18lG2+EA90pmKyYczpC+AAM7g5tYegQhkWZunxoKMs0GnzaZNfQ
 5Zg9dGHovFxgMkc0P3DaFXn+cNbZYO1QIt675Ed9DXOwqYIDfgICdnIKjIIvXOl/j++3
 QMJwftqeQLLnF7oSD04ZtFGTXEpFuD9Ket7/3uYaADB5QH+rFj3GVMXxQIuAj5+IBa+R
 dUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384407; x=1777989207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UF+x0bwZPrU0SIpl4J0lUCPMSLkUkTMIvmkrFh+zu/8=;
 b=CdKDTjFWL6ndzMw18DskqSOJ0F4m5mxjN7GSjoZSjz5DTpEEApwaQvjVo9u9YMHolE
 i3dW6X/MvjwkTi+tTiPcd8ox2Qjwm5IgYBsvnvC7aHVb52ybfbg8TAVjcywe+ICFjm5E
 VNe0jHGR+KeLfcXhdPsL3SRnDNbd8VJrvgfYSh2k+oOtNn4eJyFadaxTP8zy6ivkFAL3
 gxCYGjC59/QnPqOe23VlSV8rORaFEdsMHrDdjZlFFuVkKtEJ/hiS7yDaTifYdgQiUV8y
 QgnM1ksm3cUCHqk5kBSwCI+PXoQb6vj1EhfVXqOUKgWPp+/9d2ApyRDcfaviBsWKEqPU
 SVuA==
X-Gm-Message-State: AOJu0YzwifA9qEfkI9uWvRJqN+9PtrH701HQYXgF6nHIMM4t5qQ7yd78
 yNlR0dHjLX33BKr7c41HY2e3MFvWj3PhibHbkztHfqWXcMUqTcotewBp0gahMn0g4fCJstBHb9q
 MVw4r
X-Gm-Gg: AeBDiet97fAbLeaxOhWyvTKQPu7RrAY0hf1e89gYbHEE/Mv+XnR6D1tB7texfo4UN0L
 g5iNIGQAxQpKU2hYqaC15K+oBNXZ/VgGNLmLKtE88wejznJQebqDN6YfP0dhKQLHLnwtu83wctQ
 m3lJFxeTQ/wv9awwEzyHAHJQOKJC4tGPa9/S2M+upfJPO2iRl8/uzMu8AF+ZoBKTp1oPkXCgYX2
 MbCu95tzSY5qqwO6SWH3350mhIlT8lpumzNSDCa5dIoPlBWZ0sbzZchXfDggy6N8rQgCrghAmZI
 pDyvFn3Qjt2nY11Lm/Yjs5hxonUlNIUmXOG5X0EhMDFw1qjiCl7A5+cTbKS1ja3/e7spYIUOeeR
 8UcmeFp41v617bGT1CRnhw9AIVrcR/Z0w8yVkd+0lLP/L8L0mY7NZ9dQNxr5xeagnSihwJjCIHf
 vvBIYj/hK46vrmuKtomZNkBRlQCZeXTM1quAHasRmdNj8=
X-Received: by 2002:a05:6830:61c6:b0:7dc:67:8c9b with SMTP id
 46e09a7af769-7de99f9910amr1998735a34.4.1777384407435; 
 Tue, 28 Apr 2026 06:53:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de98509581sm1923165a34.10.2026.04.28.06.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:53:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sunyang Wu <sunyang.wu@jaguarmicro.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH v2] app/test-pmd: terminate process on second signal
Date: Tue, 28 Apr 2026 06:52:48 -0700
Message-ID: <20260428135323.119782-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427172617.295684-1-stephen@networkplumber.org>
References: <20260427172617.295684-1-stephen@networkplumber.org>
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

Reset both signals to SIG_DFL so the process will immediately
exit if second signal arrives.

Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
Cc: stable@dpdk.org
Reported-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2 - handle the case of SIGINT followed by SIGTERM

 app/test-pmd/testpmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..59372838a5 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4555,6 +4555,8 @@ print_stats(void)
 static void
 signal_handler(int signum __rte_unused)
 {
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	f_quit = 1;
 	prompt_exit();
 }
-- 
2.53.0

