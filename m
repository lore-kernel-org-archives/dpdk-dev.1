Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1E606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 01:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA0740296;
	Thu,  5 Nov 2026 02:46:29 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTPS id 0FA3040288;
 Thu,  5 Nov 2026 02:46:26 +0100 (CET)
X-QQ-mid: esmtpgz16t1793843181t87cd651c
X-QQ-Originating-IP: F9AdcBm4QrqvaUf+gJFBNxJpPu3N2OAMJe4kkIkZOFs=
Received: from w-MS-7E16.trustnetic.com ( [125.118.252.238])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 05 Nov 2026 09:46:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14005045147000546185
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, stable@dpdk.org
Subject: [PATCH] devtools: fix packed attribute check false positive
Date: Thu,  5 Nov 2026 09:45:50 +0800
Message-ID: <21975EFAD48C9F0A+20261105014550.2893157-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODcDgdcDagQK/KktCa8NXqAg6x02lGkkXqIbN5F2UKnPofXKfR6jTuP+
 bhd8A0RZE7G53YsA6nP2gWWCpgT3s7oPNJb321PlCU6c80fZRp29UuUwCrVV3KRVT9ooWmS
 EWp3RgQU9X+d8qZvYANFuYGts9jKbv/Lap2xXpFyVnjy837q/nZbVnT5qZzfaR69dgENUJL
 DhWjlggAaLtKTNM3ncWrS3PAS+u07spOXcGh3ii2o6M9CC/jKETuI8bxwndmTtOP8nU1uAV
 IYWM8Lz9ZxQr7wX5jj+TgwpFkW8bVJJqlH/Q42IINd4X3TPzYNwyvz8oMF4TKAtI04NFarn
 AGSoXpQk7iEfuPirTBVriNYZTZJIfQTw1cjYdQwaW7UFu4NLTVG6FYxFlB++BeYBtZ47Bjv
 CViQWWnmHEUW4pNHvk/KThLfOeb4C/mAOFWcTqTSlMIdg408KmwkWgdolG13eST0SURuZAx
 r2nZZjRMUUYuH8JZZ/pwWbDkw+ESE8aMgmAdtCOLbpoax97yZU3CALinPgzeEnTU4ONt769
 blJ+C+f3tjIFmv6cLRUaQ+Ugw14D07A+nq4/XIx95aPOx+mubI5wkSEpPB/WherdRtCIGOU
 Ev1Idy3ETc7dWv8COo3FcK4YDWrOd44IrVHzpBXks9DPraHKhYt7NOhTEbQkgn7Jaam3o48
 IsZOyppJJffExacUqv8uao2nj55vyJ4AoQTJ200jC3FpLhJ92el2W5JaVeiZRIWzMwabUEp
 E5p94VrRDuMG300UVkoSLf+aXZyd2Ygdwhfsg9/gFtQ4YGGRQi1NfhvU1bXhlhzJ7cfQNiS
 mI016kJLQluOaVn+3MOGQewXu2AwPAGcZvb4iwVol7JX4TYoV3yRs7i0nDbBnWSLvTqbs18
 oPwmjn2jh75zY7ty17hW8lZ5o6pOdLtO7JJ1KIRldmNn3Iyae7g0MZ0QnrfVXxdpBqcmtax
 FTQ/a4adusMaPzoy2nqex85ybcXYL43eLW3bsbfKJD5zl1EXYjLexe4f228Wn16H7xK6gmj
 dWGNmRF7vwRwPhOVUltlSNAOhcGS7etQ8TIkZ1UThJ6IlMZeHtnw6GIhkD6DA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

check_packed_attributes() counts __rte_packed_begin and __rte_packed_end
in the whole patch text, including the hunk headers git generates.  Git
labels a hunk with the nearest preceding line that starts in the first
column, so when a patch adds a struct right after an existing packed
struct, that label is the struct's own opening line and carries the
marker.  The occurrence in the header is counted, the two counts differ,
and a patch whose added lines are balanced is rejected with

    __rte_packed_begin and __rte_packed_end should always be used in pairs.

The trailing part of a hunk header is informational, so it should not
contribute to the counts.  Restrict both greps to added lines, as the
check above already does.

Fixes: fac4bc0d06c9 ("eal: add packing macros for MSVC")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 devtools/checkpatches.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index c52fb5d1b6..ab3c51e0f1 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -395,8 +395,8 @@ check_packed_attributes() { # <patch>
 		res=1
 	fi
 
-	begin_count=$(grep '__rte_packed_begin' "$1" | wc -l)
-	end_count=$(grep '__rte_packed_end' "$1" | wc -l)
+	begin_count=$(grep -E '^\+.*__rte_packed_begin' "$1" | wc -l)
+	end_count=$(grep -E '^\+.*__rte_packed_end' "$1" | wc -l)
 	if [ $begin_count != $end_count ]; then
 		echo "__rte_packed_begin and __rte_packed_end should always be used in pairs."
 		res=1
-- 
2.51.0

