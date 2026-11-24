Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D6606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSvdrvkR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E28740431;
	Tue, 24 Nov 2026 18:43:53 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 4EF5D40430
 for <dev@dpdk.org>; Tue, 24 Nov 2026 18:43:52 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so47041865e9.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795542232; x=1796147032; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gE+M0akpnF/evkzoEsecaY0VfdjZRWcKLDpkdHrsU0I=;
 b=KSvdrvkRbrf805oft5JqEY6pXWSWTfAzByrFmli6WYo0XByPrXFp5mtX+WupFN90fG
 sw42pDpliwUnY3VZR/XCiVnszhhHT2g7UqHsZog+XGfdDFg3vS4JIHvU0R0GXLmTHZiR
 hVcc3v9OvxNtn4OJIdwrT1q6IMWD3s3xUYb18mJq6wQyf4T90c/VMHHYRDtoPVTW5Qpg
 ZFtlpyGl3sGl1M6zjasmbed7eKseqGSPeXtGup6n78rquM0qvg5HCzrClgVfeB3EiMpC
 eqlrKStAfry9OnngZw8d4R1vZXOIG2w9ZnjLVpe30Tstw6XV+p4IKC5s+zDSVCGrFeQT
 r3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795542232; x=1796147032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gE+M0akpnF/evkzoEsecaY0VfdjZRWcKLDpkdHrsU0I=;
 b=auX+XpKP/PS4AeAovCY+OmJGRj8kaYKU9Ci8D4QKpphSYlkwfFz95LoVRZqYC/UEXm
 EJ5Bor/4xmITPMnq1FrApwo24a8sBc29MUyUrE7OW0pKHXP48o5C677ByOYhZcLNRPcd
 9462SfnA5+KpUHNQXoFpcxwwQaV0+9ZHJ5xND3o1Bfb9uuNNINfYhdUoK/4D+1PmBuXT
 MpjdHPwe+EBbKDxfOmXvPZE0QvxGnkXAsvxpYpiQcGeshQFlaFGWlZYJOfagY5olDac8
 eHfhznambaQ59Tzo0eOU905iwVb270eSC9p8JdGvoyGRhfT/uWk2g3/xyOC9lW12OChz
 UHQA==
X-Gm-Message-State: APuU4Z8k4zIG1Gs24uVnD5MQZVKFbB7qZx66bDEAcqV5bAxHBpNkBZPX
 zKYws6MJNpNqgovm0akpPyOhY7rZTMqcrwtPWXTDv57hQ5gOlVBW6HHy
X-Gm-Gg: AZFdTZdGNS1vCIfkpvzJ2ip4vQIWHret1aRDBY2Vbl3cEqZKKVuz5vKpsyohb81a0WI
 7UZgHlCn1EMBxLvDQGSTXo01wZ0CcDF0QhMJs9W6J77wE4RPgXLqoE44QQN/mzEHmhJ2wEHVm/O
 EqDxbMc8anQBSyzn90LEotePk7cV57VcTZeD6jSdeNOfQYsj3eqzd1tWzAvyHaebh0yr5ASlgb9
 gleGo193fzota2jlyezVE7IQ9aHXYjjR80Bru5V2U4C45ZiHoXk3tdAg0wwN28YkMarbrv5q2n6
 PDIm7LcAmYEghQhEgeqeqqeXWeiHN2SEDnUhDDvlF96cuKtoIJsYQge0Hy1/9FaZ/4chBtYy4Bv
 TsmAo6stNipm6mnmEVCF1Q0hAQZ6WNKW5zGLaZzzU3JfQiTANoTJvMpmRmqTDMgnb/7W8hIWVNV
 Z0ksbB56eMDCSCF6KPTENgeFoZmOQKLSxRMW2fJ8M/sOqH8vf5y8qERaYSk7Fn249eQrBGkHvR3
 makEIIngDKYYmq97HLaoPnZMAwEl+T9lnHk+OJK7uNTABsKSoYXFaUs345nWi/rLqxFx27jiweZ
 O8qXOqU30j6OWbUQL+MkvtPfC7GfIttQ/6WgiPCOi8/RODbVRuqJXvwKBJOr
X-Received: by 2002:a05:600c:e41a:b0:4bb:9959:54b8 with SMTP id
 5b1f17b1804b1-4bb9959552emr126039915e9.32.1795542231860; 
 Tue, 24 Nov 2026 09:43:51 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm506331925e9.10.2026.11.24.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:43:51 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>,
	stable@dpdk.org
Subject: [PATCH 2/2] app/test-fib: fix dump of IPv6 lookup addresses
Date: Tue, 24 Nov 2026 18:34:18 +0100
Message-ID: <20261124173419.1011214-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124173419.1011214-1-maxime@leroys.fr>
References: <20261124173419.1011214-1-maxime@leroys.fr>
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

The IPv6 lookup table became an array of struct rte_ipv6_addr, but
dump_lookup() still indexes it with i * 16 as if it were an array of
bytes. Writing the lookup addresses with -u in IPv6 mode reads past
the end of the table and crashes.

Index the table by address.

Fixes: e1a06e391ba7 ("lpm6: use IPv6 address structure and utils")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test-fib/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index 05f9b9a1c7..e757c0f464 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -562,7 +562,7 @@ dump_lookup(int af)
 			fprintf(f, NIPQUAD_FMT"\n", NIPQUAD(tbl4[i]));
 	} else {
 		for (i = 0; i < config.nb_lookup_ips; i++)
-			fprintf(f, RTE_IPV6_ADDR_FMT"\n", RTE_IPV6_ADDR_SPLIT(&tbl6[i * 16]));
+			fprintf(f, RTE_IPV6_ADDR_FMT"\n", RTE_IPV6_ADDR_SPLIT(&tbl6[i]));
 	}
 	fclose(f);
 	return 0;
-- 
2.43.0

