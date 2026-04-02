Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC5DD6AAE9
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7654E40E2D;
	Thu,  2 Apr 2026 18:17:30 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 51CC740E1B
 for <dev@dpdk.org>; Thu,  2 Apr 2026 18:17:27 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so2279950eec.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775146646;
 x=1775751446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkMud/6bO0e9ZGjebdjKtv5leeHSf/unwD2nzqMKrl4=;
 b=t7TEP8Ipn6dpPw3E5C2vZb+xn2YY5X6WbwooTsL/pT9r4GylIHLJ+M5VLN5mlPYhV0
 9G0tEook7rpzYOQTB2yXugKW/IM4WdR67+OP4f4bG16ZcY1m2IYTdZyPOGEVgu+n7Ugh
 AkKTkpi/zYXyyrD/P1LdNkXfmVvmCHlHZ8gixCpDNhBLF95hnG4TZkzJ1OuiDnVv4Peo
 N4+OPovfrFExDIzQTcnKvuUkKLnzKekAh2SioFROSxrT2z+QznUUKaH8FI0xsX4aI0D+
 X7zQzWWWumxAZXHpZykrXZPrkRejFv5nZWCpK/C8mcfGbFgcU/GpLxlWVi9rmm7FVwKJ
 cGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775146646; x=1775751446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XkMud/6bO0e9ZGjebdjKtv5leeHSf/unwD2nzqMKrl4=;
 b=olkAVyFv+Z4GzLuTSw/EFBwWvG1wN+oyxgFSVghDHAEzTTaxXstJb2COBegz8LqqGe
 Eoli+yAmzs0oBpbf3lJdbaXg8qOtK5Y6lx4EyWYfrq4z8ZD++5RXx4luppwPGT1CDMn7
 TCOzk3gAFxjP3WInRdMfohROOu4wWskI030pmr/ADgOhDSdxuzEBPJ+aHBueD59ygHtQ
 /EmZQoMST3BwNXPjwRuhH2LJCj/caBzOh8h5Ov119eHrL7pg+K+vm8UOeSp2O1HdIIhD
 7qV39bYMeXBm3InqKv96nuew3M0vHDQCgj+u2NcD0Gy2D0a/R2ApR/EZ1MS11UpQJrBA
 fGUw==
X-Gm-Message-State: AOJu0YxbLiG2E+LMxc8M7tCmEIy3+LP11xKVY0uTAhlsyIsaINvNpmO0
 9sT78WAJftZu5DPoe6GTUpCyJUXS4QloLOqCabu7osFhRQAsXBcU3iGcs7TeILmXrzsZrQ0LFz1
 tA98u
X-Gm-Gg: AeBDievVq5TTYhKtD58KR/k1HjpzsEPu2IbaFhjxOszLIsztT9lVxJ0LpbOneFIM2Vf
 gY4rZ9jaAm3u0sg/QTZjCvJZ2w6AiPWbdY9WbpX9jyup9PcUrm0/1G4e1DafAN1lgxYQz2MJJQP
 4oSqX85To89s5Uoam4m7fduy/q+DlWxcPqjMKb3YDmtkB6P2D/kRvKA1u02gxjtkRCLMusfilBw
 YvRFK9xyxt656j2GCLnVe//BF3eN0xkqP2Mej7rLgUbhFPSvP4eXQxokIpyV/nqVTJ71qmBFhUg
 cIOSUpLhaPsMtpAISzLzDpTeprz/R6rImJT3ZDPQkAp5J20E7hokkwS+uGj1Uqp0Ng8hS8Yd90s
 QYI+H2rJKzu40L2jJBGx3FupT1rcrRpfCECy2AuPZzQIGL8qjxsDBr36wbHeRDRznu9KMTkK7T9
 UEawivu7G2cEv+XsXKRCJfAEwvfOGJ8eTA1G3wp3z7aCY=
X-Received: by 2002:a05:693c:2c88:b0:2c6:cdb3:bd8d with SMTP id
 5a478bee46e88-2c930c766d0mr4577807eec.7.1775146646334; 
 Thu, 02 Apr 2026 09:17:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca79e1d331sm2887311eec.13.2026.04.02.09.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 09:17:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 3/4] devtools: remove blank line requirement between trailers
Date: Thu,  2 Apr 2026 09:16:08 -0700
Message-ID: <20260402161719.82570-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402161719.82570-1-stephen@networkplumber.org>
References: <20260402161719.82570-1-stephen@networkplumber.org>
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

Remove the SEQ[4]="^$" entry that required a blank line between
relation tags (Fixes, Cc) and attribution tags (Signed-off-by).

In the Linux kernel, all trailers form a single contiguous block
with no internal blank lines.  This is also how git-interpret-trailers(1)
defines a trailer block: a group of consecutive trailer lines preceded
by a blank line.  A blank line within the block causes git to only
parse the lower portion, losing the upper trailers.

Use %(trailers:key-only) to feed tag names into the ordering check
instead of the previous grep+cut pipeline on the body.  This is
consistent with the %(trailers:unfold) change for tag extraction.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-git-log.sh | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/devtools/check-git-log.sh b/devtools/check-git-log.sh
index 3775b1587f..94cf68b926 100755
--- a/devtools/check-git-log.sh
+++ b/devtools/check-git-log.sh
@@ -223,28 +223,29 @@ done)
 	&& failure=true;}
 
 # check tag sequence
+# All trailers form a single contiguous block with no blank lines,
+# matching kernel/netdev convention and git-interpret-trailers(1).
 bad=$(for commit in $commits; do
-	body=$(git log --format='%b' -1 $commit)
-	echo "$body" |
-	grep -o -e "$reltag\|^[[:blank:]]*$\|$bytag" |
-	# retrieve tags only
-	cut -f1 -d":" |
+	git log --format='%(trailers:key-only)' -1 $commit |
+	grep -v '^$' |
 	# it is okay to have several tags of the same type
 	# but for processing we need to squash them
 	uniq |
 	# make sure the tags are in the proper order as presented in SEQ
 	awk -v subject="$(git log --format='\t%s' -1 $commit)" 'BEGIN{
-		SEQ[0] = "Coverity issue";
-		SEQ[1] = "Bugzilla ID";
-		SEQ[2] = "Fixes";
-		SEQ[3] = "Cc";
-		SEQ[4] = "^$";
-		SEQ[5] = "Reported-by";
-		SEQ[6] = "Suggested-by";
-		SEQ[7] = "Signed-off-by";
-		SEQ[8] = "Acked-by";
-		SEQ[9] = "Reviewed-by";
-		SEQ[10] = "Tested-by";
+		SEQ[0] = "Fixes";
+		SEQ[1] = "Closes";
+		SEQ[2] = "Link";
+		SEQ[3] = "Coverity issue";
+		SEQ[4] = "Bugzilla ID";
+		SEQ[5] = "Cc";
+		SEQ[6] = "Reported-by";
+		SEQ[7] = "Suggested-by";
+		SEQ[8] = "Co-developed-by";
+		SEQ[9] = "Signed-off-by";
+		SEQ[10] = "Acked-by";
+		SEQ[11] = "Reviewed-by";
+		SEQ[12] = "Tested-by";
 		latest = 0;
 		chronological = 0;
 	}
-- 
2.53.0

