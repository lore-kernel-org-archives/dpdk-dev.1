Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0E606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZ+WyTP2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D3140297;
	Tue, 24 Nov 2026 18:43:51 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mails.dpdk.org (Postfix) with ESMTPS id C1FC34027A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 18:43:49 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so44461775e9.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795542229; x=1796147029; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zYvkqVrVMG9nxu+3OL2fpFWTqGT3YE/3HTUO3XWqZE=;
 b=fZ+WyTP2YKWt6NFxRZJgPV47Gclcc8pdslhVkrZDe9kXlRDlbF23BDp5IC53Rd7hRa
 LE4rhfoJt6Ylad6gAAPGvwJ8djUGy332RwcgULEBIsr8LCfLo2b+VhxdE+HaLeXVyAA2
 Pnjx2P3Zn/e53Y0+cZHzQgF5WvbVhI/r2XrwOV8EK/0hTUZ5/1TS/9SIbsYTvPSQ74dJ
 Nvg/00vJb+LmVt1nKjIwkZHfmt1euzhkcZqklGeTMxapmgPXQw4cIFMvZUORxJdrR6Gi
 uSk1PX9DFvaS9jBlChRuCMXV4lYODfOrSilXCOCXF2Lqiqe5c7q2ALG6VG+W6wzVZBIX
 nfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795542229; x=1796147029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6zYvkqVrVMG9nxu+3OL2fpFWTqGT3YE/3HTUO3XWqZE=;
 b=xHexM3l42OUkXRG+ZiRoYsjrw9pUQplXLzi5ltzcdAnHyIQa2mobgXKErdoZ4kStHW
 6C+db7aShzXuMn50OXR9VoM7C4JAZCLOyGAYTpiJL7ehI0vk5q3IwUoorDRBr3dcyhDS
 x5aGc3J9W0EpyZH9YaGI+iRtGpCVvdsJdNnzIhEQ66k6/jYHZzrjGpxnL54Dh6smh5ER
 58et5KESZwr7QvTgNLLwb/QsaT+6zz1X/YerKLrVd9EiZUxffXAiwbEIuY67ZfOU/wjz
 8h/G6ITybgjZokA+u+9kVkA/djfbg0ePM2SKG+4I74BQGq5RkQcx/L9P0ygRBpuDzDH/
 LmxA==
X-Gm-Message-State: APuU4Z/zk1It6M4oab3cbaFChiME64wh2ZyjmGRAGNzZMM6Xlj4umcxn
 MX2wSGJ4bq7ucgBxTpcK5lhldzclKVv5qw72YbZtO5eAUrSUiTSqjOz7
X-Gm-Gg: AZFdTZc65RlYQstgD3pclodMOr842cdBx0SOLxOl5tagFFkYYbtv+c4FnIPWipnoBR1
 K7nc4Y8n5PL7JBo2bRvMDy6osViSI4IPM/d0AwDHKFN6g5T+wR+/Lqxkm3kgbmpCaYBWsT5/xHa
 S9GI+uHP3QZyjEAe0N5FRMd2V8c3DDuYA8nKB+hUvwjkRomhas8PC6hYzc5QOlVVa9Qu2Ucv00O
 JjH4ICwk5fP9wnFhUToG/fO+KdL6s5JrekdR0w9dQ3l5jX8q2Pz5l6UT9+4O63UupWq7V9dqdhz
 20FUTpqp6ej+DQ/rWqwApDU0MLfMUMWcsDo1Y8uhcTVascEXEMdFiq3l9Jxy13Zq/4E+0LLu65f
 JtXHfTu0lTWI/PNz0cb51TkbmmSFff9LWQq3Q8aqEeU/cdwH0wERJwkNWRCTICgP2jThUHFXVV5
 v/Q8AUeJMmH2fQDb1Sp3w9FFObNDjckXmhadZh8SLV552tEAAEG1TopcxM4y2RB+EpKUnKoh634
 UY7UAvQQVmK2bZLO3PhYGUSCNO3iunicmyEYRlEs+D1mOilIQgG9Sh/MF6yOHEKlVI3jCsuom3T
 vyY2NwfZD5DfiIs8RLEXlHNgucltRMGR7LQlsjyuC7DCX4dZefueYuTM1fwr
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4bb88824f38mr365232725e9.15.1795542228967; 
 Tue, 24 Nov 2026 09:43:48 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm21558089f8f.15.2026.11.24.09.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:43:48 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>,
	stable@dpdk.org
Subject: [PATCH 1/2] app/test-fib: fix byte order of addresses read from file
Date: Tue, 24 Nov 2026 18:34:17 +0100
Message-ID: <20261124173419.1011214-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

The IPv4 addresses of a lookup file (-t) are parsed with inet_pton()
and kept in network byte order, while the lookup takes them in host
byte order, like the addresses generated by the tool and the routes
read from a file. On a little endian machine every address of the
file is looked up byte-swapped, and a file written with -u is not
read back as it was written.

Convert the IPv4 addresses to host byte order when they are read.

Fixes: 103809d032cd ("app/test-fib: add test application for FIB")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test-fib/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index dd1a6d7297..05f9b9a1c7 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -525,6 +525,7 @@ parse_lookup(FILE *f, int af)
 {
 	int ret, i = 0;
 	uint8_t *tbl = (uint8_t *)config.lookup_tbl;
+	uint32_t *tbl4 = config.lookup_tbl;
 	int step = (af == AF_INET) ? 4 : 16;
 	char *s;
 
@@ -535,6 +536,8 @@ parse_lookup(FILE *f, int af)
 		ret = inet_pton(af, s, &tbl[i]);
 		if (ret != 1)
 			return -EINVAL;
+		if (af == AF_INET)
+			tbl4[i / step] = rte_be_to_cpu_32(tbl4[i / step]);
 		i += step;
 	}
 	return 0;
-- 
2.43.0

