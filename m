Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19435606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ML8unSP7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C05F0402BF;
	Tue, 17 Nov 2026 18:41:04 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTPS id C3E77402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:41:03 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so48386b3a.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794937262;
 x=1795542062; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rqjUZCfHchiOY2PEbOx9pqfiZwoNSqpjQd6fXNIfA1Q=;
 b=ML8unSP7awfgeZJJu3GfubzGDnaVBALSdTMsbcqV1corcBSsXtDby2WbDD4lUK4bVI
 LoSY8oAvNEw26+ohx36FR61p0hf0DoYOgzBIf8qY45cTK01Fq2KGVgs//xbBxl8kBHfY
 sxs6HFvox6DqGElWZLes7wlGAWRr1pQ1CdFBm5Up8E3XhbzHQKwMk/v5hsXS1gYOOqRD
 jKHP6UVafg78bP/B0iZYkM+fe66ULeVPme8V1kT443gaWHm5gyOWR8KjbikuvMlmU5GB
 Jhwg2gmWER+JnT5LNa4K7JGcJDJN6inpvYjM+oGKdQ4RV9qAS66otVXloqG4EEZ7tr0w
 dNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937262; x=1795542062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqjUZCfHchiOY2PEbOx9pqfiZwoNSqpjQd6fXNIfA1Q=;
 b=qf1AlDZl1v3idB6/rkmYnh90bNQNqmv/WWhlR6B5NKNldwji97/LIUij/uWJ9WU8i+
 qaiJ6uMBYEneneeefw2y6o2ub7h6UKOyTmn06kHWT0W+DXb1rrKWygXGrb/gUvMWIp0E
 2i8NTh6gXeD0GzmhyeiXjHBJ2g4QVzDHpfVtu/va/5uWexxE7YFr0/utVpkbZFWtKjsV
 RzWfEaiyT4z+aQkGPe+40NBDnDcriv+qXsdqkcauiXHCWrOWhkJhKY6C39EYYZylUzCN
 AeOYnCPEvqxKmba60M5nII1TMhCi/ZQkNP/JjvecVfI9t9RcNWi0VpJFjq3BHgZmUCBo
 FpRg==
X-Gm-Message-State: APuU4Z/oYzzJwJY+xPDmSq3VzREY88H90UoUfHqAZYzn4E/lx8qGkeQF
 1A29htdj2Zjno0LyMsCTZiu+Vhryi5386RgucqZhabgsqQK1LbPGpvmHcbogfpyldwzutXnscip
 2dQ3NdlI=
X-Gm-Gg: AYBFou3GN/j8p/I8nFvVHLLXneq0LmDTQVp9/YowijyYldSG4GYXBGhNWBXF04fktTt
 LTuRp8Kd70l4RW10A0gWqs6j3SXXzqbGQo+KIlcqmxDSPggRy8W7zNmqJKf31bMAy0WjBa5ybbN
 HjN6Qr+c+fQ7CiYiA2T2x8ngGGiwYQHIg01AyRlI1cvLAIiTDTGiCkX5dvk9u6uIOK7SMaCxZbB
 5eTp8aLfTIwACANkmWffrauKpVrW91688eFIEIW+4UPQ2GaZADspv2lLWzncbeYVX+n7WgUxs4t
 FhtechxEbjQP1OVNlke6UxjbgLSL0OyR9ZSc2JlXGnBBZji4MP9Zxa1zaIdoZs5KF8PARAtTKMv
 1/slbOHo2XF8qn1ubq38+v388je84a97EfHGUOdvjk4RXMBy/HMuHVk/cSJe9JCHw8W4uRxIXEN
 bl9HX9e48ILEumxAHRdGthKc+Eop6asl9yGPMSNQnJObiLjTHnNmlN+NB1neBOyiVL10BqccpbE
 b8NamnQyjVtND4VsOuqTsfIrRhv/FO4oXFRAlRTltnte6oYddf4Y9FRSyrYWbW0+tby0CKv4KBQ
 QwErLkj16AmCpO5uH90MhqlyssSrnzVMfEI9VRSrFA3gB7A/9akRyjK7vUIFGwwlw5GUw4M=
X-Received: by 2002:a05:6a20:9183:b0:3e2:ad2b:8f69 with SMTP id
 adf61e73a8af0-3fe8b9eae35mr215225637.67.1794937261955; 
 Tue, 17 Nov 2026 09:41:01 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5ca7aa2b3sm5173b3a.9.2026.11.17.09.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:41:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] eal: silence unreachable code warning
Date: Tue, 17 Nov 2026 09:40:59 -0800
Message-ID: <20261117174059.736244-1-stephen@networkplumber.org>
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

Clang evalutes strlen of constant string at compile time, then
complains about unreachable code. Use extra parenthesis to
mark code as explcitly dead.

Bugzilla ID: 2135

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_version.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/rte_version.c b/lib/eal/common/rte_version.c
index 627b89d4a8..62572428fc 100644
--- a/lib/eal/common/rte_version.c
+++ b/lib/eal/common/rte_version.c
@@ -36,7 +36,9 @@ rte_version(void)
 	static char version[32];
 	if (version[0] != 0)
 		return version;
-	if (strlen(RTE_VER_SUFFIX) == 0)
+
+	/* extra paren to silence unreachable warnings */
+	if ((strlen(RTE_VER_SUFFIX) == 0))
 		snprintf(version, sizeof(version), "%s %d.%02d.%d",
 				RTE_VER_PREFIX,
 				RTE_VER_YEAR,
-- 
2.53.0

