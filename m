Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D10106ACD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D24C740666;
	Thu, 12 Mar 2026 19:54:08 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id 62EDF402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:54:07 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d749f99691so760335a34.3
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773341646;
 x=1773946446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yNNBWrHBR+Y9kqbTHRRDprEAhwvxcmlhjsD66RdJT4k=;
 b=wmP4HuCI6LKT2NxnJlGL4ozt7KXwCgKtGj7MwjntaMu7ZGIe7yXMXjRpzNTspAblIn
 VTHRsHmZDXiOxWVYuC2Z3m+bn1Om//LqtCtTQJBi7nkaYQGO8vycRcryTEesvKUDBJXP
 +aaLaShWTwJ60fVhKwcegUiFgeR1SnQmXaKCxRb6QikfMfw9WnZXxwJDbgW0PRq4VI97
 76XziyIKP8e8zhVlA6/L+KHkS5cYEVo0SmIhX/7H5gOzpl+UgC5BjZ+qukv4jZ06g+ns
 0xsCUIP8ReeFgMqSOSOMthsyiH6EW165Q+84zJJCFB1Z+c21pqLlg5a5ixfmMx6ZmFgL
 8wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341646; x=1773946446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNNBWrHBR+Y9kqbTHRRDprEAhwvxcmlhjsD66RdJT4k=;
 b=Qd+du3wqKKBig3KNA2lPKW5QDN3FRxVZBeYIz0nfTbstU+JiG0ycD0U7oo5FeO4FAe
 zYL/kGQOf1Vdm9ZJx0oLg4D47bjPVbbobuQwWjML9H9lqHCcUkanTgA0ats/2NRn11vm
 7Se7Z374gjgMhN6rsHYCJVv87aYb7zSBwcRebOxauP9ks+E7Gxuw1reiYPr7QMJxYH4w
 z+7YrESFGrKIplFcti0PgfCBo0QRmv8Jd4el0bGbs7LEVbnve3rSNc7bH0suHbka7CiQ
 WTV1LfG2MlgNsdIL+Wtcri5B2rft56tMqeFRK7mgqrPl3Ot1sxmdZupmXnlT08So2P0t
 62Bg==
X-Gm-Message-State: AOJu0YxdIoat/DV+o+g+dNKXnm/l+3M7kLdgIVgadvWijSFRa+J5ZSTG
 DyC/grV6Cy+BqmrdesNmZJtbWgbIM8CnS2hfWQayHu9eqCuPJDlpokk+bOtzgfC2Jp03cxQqluT
 h3cGa
X-Gm-Gg: ATEYQzya/HB50c25hiO3OQwwNwKDfZdlZXqH92IUOoSQYN/EN+3+SfZ76us3MExadN0
 oeQOae9b7aXiIQtSyTwVmIMgjMomsb4QJskjneIFdtnxH0XWu+UdOlRnCxTsGW6qRRb20jro5I8
 k8c/O0G4z7Glq3eDXFezWWWvP9GmguQsYu4Yrfu1Iw9+nMixpY9WpjAFosliLywQmmCM6flLx4b
 DLqq7XvIgSLh/AuvlILNzjQCrvgyK52gVNjkTrr+kMchoMj82NBKrDaWMlA4F0XLfNIj3ocWLjb
 NMRALIOk5qe+ZS47GPnN6agfTKWVXIsL8QkXefd+n3jqLPAcop57JB2I3dp2xiL3YHVtU1+ttmW
 S8ETOCsXtpNsV0OC5WoNDku6lm9JNuFoHlIfY5Go1EeW3lSzXWWJGTh8HppDcS5YO3xDhrdvFP3
 a2ZQam7amTjdynlvD/P44FBWQM/0SJa+AQ
X-Received: by 2002:a05:6830:44ac:b0:7d7:5e62:4f0f with SMTP id
 46e09a7af769-7d7825a098bmr326038a34.34.1773341646350; 
 Thu, 12 Mar 2026 11:54:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d77a60d664sm1856537a34.6.2026.03.12.11.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:54:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] devtools: add Co-developed-by to commit log check
Date: Thu, 12 Mar 2026 11:54:03 -0700
Message-ID: <20260312185403.1051832-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Add Co-developed-by to the recognized tag pattern and tag
sequence order in check-git-log.sh.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-git-log.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/devtools/check-git-log.sh b/devtools/check-git-log.sh
index 45a58fab4f..dee4056dad 100755
--- a/devtools/check-git-log.sh
+++ b/devtools/check-git-log.sh
@@ -53,7 +53,7 @@ bodylines=$(git log --format='%b' --reverse $range)
 fixes=$(git log --format='%h %s' --reverse $range | grep -i ': *fix' | cut -d' ' -f1)
 stablefixes=$($selfdir/git-log-fixes.sh $range | sed '/(N\/A)$/d'  | cut -d' ' -f2)
 tags=$(git log --format='%b' --reverse $range | grep -i -e 'by *:' -e 'fix.*:')
-bytag='\(Reported\|Suggested\|Signed-off\|Acked\|Reviewed\|Tested\)-by:'
+bytag='\(Co-developed\|Reported\|Suggested\|Signed-off\|Acked\|Reviewed\|Tested\)-by:'
 reltag='Coverity issue:\|Bugzilla ID:\|Fixes:\|Cc:'
 
 failure=false
@@ -233,10 +233,11 @@ bad=$(for commit in $commits; do
 		SEQ[4] = "^$";
 		SEQ[5] = "Reported-by";
 		SEQ[6] = "Suggested-by";
-		SEQ[7] = "Signed-off-by";
-		SEQ[8] = "Acked-by";
-		SEQ[9] = "Reviewed-by";
-		SEQ[10] = "Tested-by";
+		SEQ[7] = "Co-developed-by";
+		SEQ[8] = "Signed-off-by";
+		SEQ[9] = "Acked-by";
+		SEQ[10] = "Reviewed-by";
+		SEQ[11] = "Tested-by";
 		latest = 0;
 		chronological = 0;
 	}
-- 
2.51.0

