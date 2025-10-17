Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E590CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A11DB42DE3;
	Fri, 17 Oct 2025 17:02:50 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6623E42DD4
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:49 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b57bf560703so1427954a12.2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713368;
 x=1761318168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aydu+/gl9O4zMch/Npq7hqtwlELXw2OtTHV6xYD4RY=;
 b=fhTKKWW3/J5IwelXPWEHLfnwhF5m7BTFMX9Y6/zayV5x/x1/GNOr70HXDx/i8C+Ydi
 beRmsvhzAb/8nC/tK/4LnXQzy7g5MeJVuYAz7xklXCZmOvnlr4/xS2oQIsQ1H7tMcl9A
 NC5X9T1PTp/h/a7kwfsD3mOj2YStdAXgv6Rfh9WaAKVu6S6cdrBM2g+dPGtzMrfoBBHi
 w7L+unP4lsJ7asHdsbPwX6ZsMJg3bPGcZq6Lj74q1uApOsPHMYC5ZgfAIB02tekTBH8S
 ZnLEVK6aWAos9bBh2kir7Avhk85E6EXhLAfCj+Zn0UiVcObZ5kjO1trTpZMzBDJPs9F/
 D2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713368; x=1761318168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aydu+/gl9O4zMch/Npq7hqtwlELXw2OtTHV6xYD4RY=;
 b=HMxxyd6OM3/1g9995fGbJjs3GWsiynhiZHKZWEYZVUGyJUfk8ITyRsr6RU0V3TWCO4
 Dav1JVEa2lVm4grKQzZY7yXpPo3FXstezVyOJkAzKnHPbKEHqxgGV3S16EfM9PD39gY8
 ndVHyzlpAHDDC3Pmi2tQbJTw1rNxsS4XQ0zuXJKZN1nX3BOt1YoXJlNdErJavhUAWl2a
 OQ2gHLdUJVejmobtmDEAm90NrOt4/j6Nc0GsoKaFSC7r8MupeioAjJXv+lQw0EQT/sBW
 wvp6gsoMA0mGWiutXzk4vLmwskjGgKv9+cC80/hezWsO9+5/y8gkOyqI3OqqQgVsO+Lk
 Xs0A==
X-Gm-Message-State: AOJu0YyXNsYQygnO6WPRBE/40wGsECOtgiBS0tq1cL6cSIbLDRPQin1Y
 chw9CVHmeOPHn/afFOghPENhJ77ARCWDuBZWadgvICG9P3716fnxJ2L13CPf0ymrgemueNX3f28
 8FtLQVl0=
X-Gm-Gg: ASbGnctPm6zKrNT9tBBqjjNjNDGIgFFaQr231zDBI8+bfCkiMWsKceaH9boKaz0hLPL
 POxxmKWZ9CuLHjcz4Y2DZFdEmMgMpeZZDsP4/Pne3DJ6Q1kUyFFmtzT+UAcvBC12YWjU+niLIft
 6BIY7ChUF0qDg4B7kjUMwmwHBZ/+G5xf/fJ8at6U3LP6ujXFbVIXvRX3pI1S6M7fth0QcoFMerH
 FoVzUQq8howIpGitXhEWSIi0oOAyPKmKojOYw6wvwlvrBnGfni42lQ6alD+ScUrx6oJptA2kanU
 ny6En1ToZNQEl54Pw0o3gonqUg+JPW/Bz8fx2GcgreSsYHDOnTFCFZanKcKKcOltoJSlvjONaru
 Z87EsOVibCZysOP8b2iyOgS/R/2JL1U3Hd2MXjcxEdh0ABnqiqzwKa2uZfYCrJ39v7u+Pv0vCNv
 DfRmvLoej3JoI6pWdy17GkO6AhRIt/O5qp9e10oZxyeiSezy3BUA==
X-Google-Smtp-Source: AGHT+IGtBETQMyR9xy4p7wx4LdpwDJ3LvwNRjyLe84BUhNjrjG9gylEQefOdbeTH4OHOyJ4C1XfiIg==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-290cba4edaemr44002905ad.31.1760713367937; 
 Fri, 17 Oct 2025 08:02:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 2/8] ipsec: replace unnecessary comma operator
Date: Fri, 17 Oct 2025 08:02:03 -0700
Message-ID: <20251017150241.28511-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ipsec/misc.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
index fd4d3f5256..eee3bb0c1f 100644
--- a/lib/ipsec/misc.h
+++ b/lib/ipsec/misc.h
@@ -19,12 +19,9 @@ static inline void
 move_bad_mbufs(struct rte_mbuf *mb[], const uint32_t bad_idx[], uint32_t nb_mb,
 	uint32_t nb_bad)
 {
-	uint32_t i, j, k;
+	uint32_t i, j = 0, k = 0;
 	struct rte_mbuf *drb[nb_bad];
 
-	j = 0;
-	k = 0;
-
 	/* copy bad ones into a temp place */
 	for (i = 0; i != nb_mb; i++) {
 		if (j != nb_bad && i == bad_idx[j])
@@ -126,7 +123,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
 
 	const uint32_t vnum = RTE_DIM(vec);
 
-	j = 0, n = 0;
+	j = 0;
+	n = 0;
 	vofs = 0;
 	for (i = 0; i != num; i++) {
 
-- 
2.47.3

