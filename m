Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32386CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 06:23:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A5D04026D;
	Tue, 11 Nov 2025 07:23:56 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id DA7674026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 07:23:54 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47755de027eso26073295e9.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762842234; x=1763447034; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsKxvFFu7rhyDKUAgs1BGyYJLBYZRq3f2fFIrpvJEZU=;
 b=J9vqc+1Xb4nDwYhoaIFvXeZqV47HZrZNCU267//VJfvrzDM9bPl/tSQJw+hjK1OMcS
 On0dMBKcqbiZsdyeyHsF8Z4dxfSyR+dwA75rv0dP5hSNVtflEGe2/hCFR2Iru18YM5Y6
 ZiKYA0SqGW8lhHF+jGG3NOCZgGqn0KjDyZjaf0RNdWlGvxLvJ5EUlMwqMwLWlK/MlOnK
 ItAyLR+nmTCOW0dbxtw9csqjLawU2z3CVBf6HvvKSQzpYi+h2YOJ5mf6GvrzbNLcM7hN
 68gTFuut4FffSuk/zN2HdvbrsK2P6iziwWrHCVxdKvlhK04RL2HZE+YhtWaQ1JrCrRrm
 3G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762842234; x=1763447034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DsKxvFFu7rhyDKUAgs1BGyYJLBYZRq3f2fFIrpvJEZU=;
 b=jy+jtn0iFw2atA04kocnpyUP84NYhdHEOG3DvuY6vQofHo++LiLrIyeYKu+hBToAYe
 wr+sr8sbtM5+OwA3qZ2CeCoygb393XsORp9blnSmibIJECFxOT0C3Rvc7zhFTkacRhV7
 0aOt7hlwbgxZ9Xr00YOhDNU+az0qF5zu4+Xpv4JQr1vLlNB2HKhQvgyyxrsJIULQg1rO
 8dBWaKHTLISy+ekuhTywkIoNIQleNjRYEwsra8tNNjWdo0LnC9mT1PgTdHL8NzQVSyak
 yRBigJ2PaAKO34eC0PNY7zJXIrnF/u23lQzJyOgyFDzJFl0S3HMvjBzdGssl7POxrQ3y
 OuPw==
X-Gm-Message-State: AOJu0YzNOQMA3LO4r1Y0ltd4RWK+CV1hL3wUmJQUw6r1LbuSPs+L/bPg
 K1uoiboa3oWmLujoX7SMMNKW2K1uOrjZneoeyyloGCSRjueZ0YSwsqxG
X-Gm-Gg: ASbGncvwe3vJCLD+eNGCPmr59nwp50NU+as+HZe7t/0VTCFCrVdLQ40/JAqnryVcbeP
 jz0wq0JJFsUWYmKRkF9n9GmArFqnPgGHCIlSovns5+hE84ovRyuRZfzkUkKFCotLkA0h+qedsM+
 wEWxbdI9oQbQjK2z1fjv2IE3abrWK8JcPTk1CWedDJAVq810nwJfb+bMjoery9QwLj1CdUJ+cJF
 lcF5eWX67ftP8CPBCpQ797OOavOVd0QLnMfQXWReDHBwiWBmTgHdXgCd1CXBQp1zMk7SRQnMv7T
 SMkzzRxJp1iupBFkM52qFx5Cx7OudzH0CYVEzM38G9Vxl4WSHdHelW+ETr4Uv8LIREXbLjGG29q
 DpH5gGFkHSinNwBwaIXajc6OgfZOIcaW52rPhVjxS/PblTHpLH/gJL98NBbCd4iPF8RLF5V8dMs
 oL0TlmGs8Emg==
X-Google-Smtp-Source: AGHT+IFVZmaDyrT5sDCQcGnaG8PKbmZR7uP6qqN9r4dLjfCdSube7Xq/1CHA38Ii1P0oaaoiVtjh8A==
X-Received: by 2002:a05:600c:3b8f:b0:476:651d:27e6 with SMTP id
 5b1f17b1804b1-47773287419mr92715745e9.36.1762842234220; 
 Mon, 10 Nov 2025 22:23:54 -0800 (PST)
Received: from localhost.localdomain ([46.210.196.60])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4775ce20ff3sm350067825e9.10.2025.11.10.22.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 22:23:53 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, Isaac Boukris <iboukris@gmail.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3] lib/ring: do not allow zero size ring
Date: Tue, 11 Nov 2025 08:22:52 +0200
Message-ID: <20251111062253.578121-1-iboukris@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251110222827.575488-1-iboukris@gmail.com>
References: <20251110222827.575488-1-iboukris@gmail.com>
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

this might happen when for instance the ring size is read from
config, and would cause runtime crash. Do so by using the
RTE_IS_POWER_OF_2 macro.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---

v3:
* changed to use the RTE_IS_POWER_OF_2 macro.

v2:
* move the fix to the POWEROF2 macro itself.
* fixed style in the test code.

 app/test/test_ring.c | 7 +++++++
 lib/ring/rte_ring.c  | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index ba1fec1de3..3078348b2f 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -505,6 +505,13 @@ test_ring_negative_tests(void)
 	struct rte_ring *rt = NULL;
 	unsigned int i;
 
+	/* Test zero size ring */
+	rp = test_ring_create("test_zero_size_ring", -1, 0, SOCKET_ID_ANY, 0);
+	if (rp != NULL) {
+		printf("Test failed to detect zero size ring\n");
+		goto test_fail;
+	}
+
 	/* Test with esize not a multiple of 4 */
 	rp = test_ring_create("test_bad_element_size", 23,
 				RING_SIZE + 1, SOCKET_ID_ANY, 0);
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index edd63aa535..f10050a1c4 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -25,6 +25,7 @@
 #include <rte_string_fns.h>
 #include <rte_tailq.h>
 #include <rte_telemetry.h>
+#include <rte_bitops.h>
 
 #include "rte_ring.h"
 #include "rte_ring_elem.h"
@@ -46,9 +47,6 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
 		     RING_F_MP_RTS_ENQ | RING_F_MC_RTS_DEQ |	       \
 		     RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ)
 
-/* true if x is a power of 2 */
-#define POWEROF2(x) ((((x)-1) & (x)) == 0)
-
 /* by default set head/tail distance as 1/8 of ring capacity */
 #define HTD_MAX_DEF	8
 
@@ -67,7 +65,7 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 	}
 
 	/* count must be a power of 2 */
-	if ((!POWEROF2(count)) || (count > RTE_RING_SZ_MASK )) {
+	if ((!RTE_IS_POWER_OF_2(count)) || (count > RTE_RING_SZ_MASK)) {
 		RING_LOG(ERR,
 			"Requested number of elements is invalid, must be power of 2, and not exceed %u",
 			RTE_RING_SZ_MASK);
@@ -227,7 +225,7 @@ rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 		r->mask = r->size - 1;
 		r->capacity = count;
 	} else {
-		if ((!POWEROF2(count)) || (count > RTE_RING_SZ_MASK)) {
+		if ((!RTE_IS_POWER_OF_2(count)) || (count > RTE_RING_SZ_MASK)) {
 			RING_LOG(ERR,
 				"Requested size is invalid, must be power of 2, and not exceed the size limit %u",
 				RTE_RING_SZ_MASK);
-- 
2.49.0

