Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3BD6AAE9
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7055640E31;
	Thu,  2 Apr 2026 18:17:31 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 331C040E26
 for <dev@dpdk.org>; Thu,  2 Apr 2026 18:17:28 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c1632faeb9so2108628eec.0
 for <dev@dpdk.org>; Thu, 02 Apr 2026 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775146647;
 x=1775751447; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNazV1FmYKgHUyzTP+ZQ+EDkc+VRUpd7RbBw+cN8k3c=;
 b=BG510ImlR5POr8o/rHVdCYF0w0zP2KoY6WyE3Gstjzsplczmho7AKxzYJKfqb98X8Y
 ddciHi3keSt8FKuplXag5IuN3ts5vE/kbCEHPGSTHXm9xnX58zk9lTvWRGVGwCmFYYmo
 v3CT4n6UcyJFDqW9X5an7dMCevNGKVMRD1qQmhWKRQh7vxgo94UTAlHA7fH59F2q+EHx
 kEDeRmbHT0PT4yezvBEDJrpjN2TLkcokhFn19TCvdZKkedhdpdA4z7c3RTxb60YFJDr/
 LVtMQ46TFB89lZt/a3coHAu/ykYF57XfRz223Ghm+/ctWyHYoaKIXAv77PNxT0JwzCTP
 1b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775146647; x=1775751447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yNazV1FmYKgHUyzTP+ZQ+EDkc+VRUpd7RbBw+cN8k3c=;
 b=jkK+1hb26w8KyYW8HEbWk/emnMgZBTCvCDpk74vJ14FiVWD6d1SCHqzOzAd/c88tel
 qFq3UUGKzxxSXyghhEV4SfWMgf0K8n8ImY+taossTYzSYWdwsEG8G7kpZteh8uqrK1Zj
 kqavWWGXLoSgk2vB7gFmDc/jtjK1wUIveS+vGeSH3h6622c6gvlPHTcWH4P/dQZ3+0SZ
 bz0+roJehyOeaGKwU1VT4EDhU3UPd0D4ORRmKNji0OV+1HrdOg/4Qcm7Nnt0+v7KrUSj
 78K9Ma6diWvsz8eAnV65ehh4goGheDctB9h8ZIVUqALnvQcdJznbAVQmxdrNkcmOp7hv
 w+fQ==
X-Gm-Message-State: AOJu0YxWNtDaFZITce5241HzVpHjCykqcpFlIN40r81IL3+ICB2uCWF7
 nsEC2STVMrKUujWiQyABcSkMwFJfwRhCIJ5jS2CN4tL9MHolYFcWK2OuQFtcpONev0yTtYWCOKe
 YTUVL
X-Gm-Gg: AeBDieua93udVXuAYrbQM3YTSLvgs2+dOpaCTk0JQE5SPlgbiHObysAah4ILnCfQChV
 FT+1rA36tzst16YEJ0VunZjmvhngl1GksLjCJobsErz/oS8kB63Dy0dlba+dOOBJ9pNwiB8bLCy
 Vtwsai2nGJHGcQUbG1JXhQammixgaSGJIDYGOsmHa1+JTLD2/qtnf6a2foso6rs2IETYH4roQmd
 WW1ZVfI4Vqbmc9ib89+Nm2FB7vSTcxm1/9K47BVfO1gxFG/VCGZsghyCQqYmaAhoAz9wTA4Ah4l
 N4Ca0i86fPKaFJ2On2uY6v24+dHEx+N1FGuMep7r9avE+O/R/xaIUyO8fBMNAdBesbZuvnrx79v
 sOQa2fFKnFSruZUDbM6rDOY9HtA/fXBx7YBK9+Wpkby1VaXCBy+nvKkoFKPY/l+Kdn7ZyKzmlG6
 Fdl9aUc9UXy3/LtY7DcRt9Z/j31487bf8I
X-Received: by 2002:a05:7301:fa0d:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-2c930e75004mr4532574eec.14.1775146647250; 
 Thu, 02 Apr 2026 09:17:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca79e1d331sm2887311eec.13.2026.04.02.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 09:17:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 4/4] devtools: demote tag ordering to warning
Date: Thu,  2 Apr 2026 09:16:09 -0700
Message-ID: <20260402161719.82570-5-stephen@networkplumber.org>
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

The Linux kernel does not enforce a strict tag ordering via tooling.
Ordering is a convention, enforced socially by maintainers rather
than by checkpatch.pl.  The b4 tool has a configurable trailer-order
preference, but it is not mandatory.

Demote the tag ordering check from an error (which sets failure=true
and causes a non-zero exit) to a warning (printed but does not
affect the exit code).  This avoids rejecting patches that are
otherwise correct but happen to have Reviewed-by before Acked-by
or similar minor ordering differences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-git-log.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/devtools/check-git-log.sh b/devtools/check-git-log.sh
index 94cf68b926..5b621f5c8d 100755
--- a/devtools/check-git-log.sh
+++ b/devtools/check-git-log.sh
@@ -266,8 +266,7 @@ bad=$(for commit in $commits; do
 			chronological = 1;
 	 }'
 done)
-[ -z "$bad" ] || { printf "Wrong tag order: \n$bad\n"\
-	&& failure=true;}
+[ -z "$bad" ] || printf "WARNING: non-preferred tag order: \n$bad\n"
 
 # check required tag
 bad=$(for commit in $commits; do
-- 
2.53.0

