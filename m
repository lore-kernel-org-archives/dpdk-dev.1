Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA2606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=a+oSesMY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E87740264;
	Thu, 22 Oct 2026 18:29:54 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id C7A5E4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:29:52 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso11201a12.0
 for <dev@dpdk.org>; Thu, 22 Oct 2026 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792686591;
 x=1793291391; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pPlDSamZVLpibAl5G/XAzL/66lB+SbC5jwtfJ8XDzeA=;
 b=a+oSesMYW4rXucCTCa7k5zEtEzaIv6m0VJl1dqoMc6p8AcZmddEvk1MSq6ul+y6DSe
 DvnuU8iqwZy+Z9l51Nb9CvybCQdT3nO7FTEI7qdNHkIMGJm0eX1hPN1cPLgLpL+IJGaT
 wrD4NCuBC21Vlwk03TreMSHg10lFREJwaKs+Q9ljHXS14Jq5qdL2Dbjknq3w6XO3T0Jw
 NFwav3SUQDhq8lgM5Ni4iz96GBMaEUAfIGKWHkC68MCdkcJr+MAoxdZdWiHDhVEZ4k2n
 ReIHk8H/4rCkHCHAuB2nrkwvW9JALGfbZnqRcpP1ShqrxlqTv56xGHfwUU/BfXcW9TMC
 rA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686591; x=1793291391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pPlDSamZVLpibAl5G/XAzL/66lB+SbC5jwtfJ8XDzeA=;
 b=B2o8AYafUigivdgRnhbuQbkiGvULGIVJ6xNBoVm3geQacuYcYVPBHZ0bRbxv8aYh7u
 IOpuTIU7Th9IL+muAxWEtIsXkbOazsLP+f5z9J1PFt1xMJ2xHNXtOPEdEF++gjvXdCKJ
 Jh6heODGPtxfcty9Xht9pOWYzdjaxa0HC48nL29IHkB8JKMQ0krEZvBaDWDkmnJjahmA
 FqAhrbi5d6y6CnSSDNVumxwa+gatHCUx+PidAr+R+a9OwqkdhKux8EwcocnnUbhNBDYe
 JuYeUDdejYKZtDoVn6btUemmkC7lNG+94/Hb6CpCZ/11Qfs7dLyOLYi2Qc0O1LOJOolD
 rVzg==
X-Gm-Message-State: AFq9FYIscH2q6YtJsvk0EkXlC4ZEZ0JEa3NcYxPXlZNtZbGr8ieMqudJ
 DWpgRS/8FPLgTcHllN2hI5sxwKxinmaG8sY4hvQiNiKs1/oeTYdpyePeF9Vm2Easf3+Zg+71XCC
 ttsX16P4=
X-Gm-Gg: AYBFou0fZujRc2xQYWfL44sEHTQpkGDBJ/5dWwZbjCDLtotJtMvR6QdE8B4gCJldYnS
 kLxgcoeqKOc+ThuqSVp2oBcSGZr8Gx4nkptNLiuc07/EOCZmCC7KZjW71WqQhBjmCQpliYzywTN
 GDkhcbDT/hrw0cDtkxMHRjN8c188WVqAQV3Ab/H2mzM0fu2MRffnJH7MG/BHjMJyKXa2KJavYTr
 9Ev5yIp+AwI8Au63GdSK/HtK4OufCB/tcwFHMCJWB2cQs3USvt4Ql9u4zqpuEgw/oXlZWi36jZs
 2mEIxmugoXdeHIBN49uAbj2rYlUPENEZqY9g3u8l9ycQiYzTmp6i7W+5t355weC4QVZG2p50R6q
 8i+9/CUjv/aadXl9pfEKaW31XJAxTu4X6Sp1hf1Q1DzBoKwV+bFDL3COrfaSvaWuGXJmo4I65gf
 aFQbof/knO/28EyeDTxuwKYiefRuIi0mQeyJMNJDUin03U+ok0SqJEP1DoYO3/BTxN1d6QzeWuG
 i3qkiI9XIYaDygM2cAstR7llFcexEt4ELs1FrNZC5KLVSe2fhPAYpMtRocAtggtE8zLoa/7XQzG
 w18003qfpLknKLlkPgg5teKd3jZWoLcNAvvHT716
X-Received: by 2002:a17:90b:4d85:b0:3a6:f1d2:57f3 with SMTP id
 98e67ed59e1d1-3ad86cc4d50mr4766286a91.58.1792686591433; 
 Thu, 22 Oct 2026 09:29:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6b84b5352sm1436080a12.11.2026.10.22.09.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:29:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: use single GPG key for security team
Date: Thu, 22 Oct 2026 08:26:58 -0700
Message-ID: <20261022152658.182731-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reports should be encrypted to the shared key published
for security@dpdk.org, not to individual team members.
Document the fingerprint and how to fetch it via WKD.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/vulnerability.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/guides/contributing/vulnerability.rst b/doc/guides/contributing/vulnerability.rst
index 9a0684df22..d07662d51e 100644
--- a/doc/guides/contributing/vulnerability.rst
+++ b/doc/guides/contributing/vulnerability.rst
@@ -41,6 +41,17 @@ This address is open to all,
 but access to its inbox is intentionally limited to a small group
 to minimize the risk of early disclosure.
 
+Encrypt the report to the DPDK security team key for security@dpdk.org,
+with fingerprint::
+
+  912D 9514 04F5 D8CE 36C7  A338 7305 BE09 7E37 712D
+
+The key is published through WKD and can be retrieved with::
+
+  gpg --locate-external-keys security@dpdk.org
+
+Check the fingerprint above before using the key.
+
 GPG-sign any one-on-one correspondence related to the vulnerability report
 as part of maintaining a secure communication process.
 
-- 
2.53.0

