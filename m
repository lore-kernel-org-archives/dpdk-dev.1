Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD2C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B736C40DD7;
	Mon, 14 Sep 2026 07:50:21 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8F18940DD8
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:20 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2dd664da0f5so4202605ad.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365020;
 x=1789969820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6yQuU2lkHp6Bw0bML1MjPRB+OHPLqdHvU4nNhiop6c=;
 b=zFLj2fVBlXrfZINlmg9q3GqI5WePegOa65VaA6N6zpWcmmi2E+/9kXncuYgvbh2FXG
 fV0cw+VVHPz4MF5pInraW/7TZt35VtBsDyArjYO9+gb8s1GOKabJ8ipmf/hi3tuXzODD
 udABulGWsWqX9gMR7nqThQ0mpxp6Uvk5/xkK/loalU1BcjYMjc6k9wk1zyhbTOaUbTXW
 NiIjzwX7v3t2A2Ky0fkstIqOnHY18BnAfwxRgGflCE/5Ihgiq3g0S2k+L3IURpiX/HLC
 aYjxZ5dlr3bqDjVXCiK/404X50JfDPul4KrvKDvkhcPwTZEdMktfr/HMzQxoC/cloJJJ
 FI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365020; x=1789969820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m6yQuU2lkHp6Bw0bML1MjPRB+OHPLqdHvU4nNhiop6c=;
 b=BEVrmrBTNlX50pyPKpP4A+N8QWSc1w8mT6c9K1krxK0TAS5RY9nQLfWBI2zrwH/aJ9
 NvsmZgq2j8Lg8nA71fmXKoKJQRf/pIfOzP3ok+ykzrg2AvNhPDmO3RmaxlQfR5hZDt9c
 JwJcQN2GYCZAsrdC89ZcTI+p2uwzfpcv3eRZYbN0hGCPLdaj3t3jZj0inJkICzRrDaCE
 sd5cewi5it01Dd/ty8IrYvqvmkov0UHcJKHN2kaNyfY9qsoMUJmGTz+qplgDuf5KvzQh
 S08ojpxt1P+NwRVeHkdWBceqhNVde2+sLXtyhCV5e4ijrKxUHhpMoMpenysLTzuAqZVN
 BA7w==
X-Gm-Message-State: AFuF++l1oDW6dHdLReQjRO64D3nae6n353QIyNMgrd69qS3/8S8uzcGH
 FgkBScuZtytwcBD1j1kG95FDTv1d6OkXZwHN6iCOv34rtsHMuBjba4RUNi/y1C7crL4Oy7lNKML
 bz4a3m9Q=
X-Gm-Gg: AYBFou2/Fz79A7Zt+WNBILOTDnx0w4KAUkcWDwoPyLU9tAECmCwEd30B5/Mx2iMgOdO
 aW/3YaZtBU9YUcaVKGUnLzob0hJ9rGIf7jyKLzey4w2v3fhqta+BZqurlFk3C9juRzrdYLtwUiv
 jmCPl62RgKmKTWJ6kivrgdNuFfYD/p/UI/obfFO1skEC67YzeabpLQJQyG52fjQNjd2QFklqJcE
 TJenikPxiat8aqu6zDwetxBATuJdlGqMPRcGVJyiPVeMMe8y2batNq4ErdobQsQHaCqd+w58KxT
 awYJ41BQk0FiyiU25tx9i7E91vsUs50Cy2J47gqRA5el04pkZ6zDwtIy+8EtWrpR2uue+yC0k4q
 6WYKF+zSqqaRChE83G8uA9xi/AJnRCLL1W88KARmcNiHnihyK4mLx2jmXXuQALa+HBaWz8SDQYm
 V7eU+I6Fnik1AwHfBlK5WMENfioGwlbH95Tf4tswJ7egU4h0DWRQeZs/bblnh0tjDW3LDklROBo
 AkaXi4O8Qsa8XGsuERhoyo0gXBgbZoOuwLZAw==
X-Received: by 2002:a17:90b:4cc4:b0:39d:f024:c7f0 with SMTP id
 98e67ed59e1d1-39df024c8bdmr1074230a91.2.1789365019623; 
 Sun, 13 Sep 2026 22:50:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH 18/62] net/ark: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:49 -0700
Message-ID: <20260914054912.755403-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

The packet director argument is stored in a uint32_t but converted with
strtol() with no validation, so a malformed value is silently taken as
zero and a negative one wraps around. It is also converted through a
signed long, so on a 32-bit build a value above INT32_MAX saturates at
LONG_MAX rather than being stored.

It is documented as "Pkt_dir=0x00110F10" and read as base 16, so use
rte_kvargs_handle_hex32(), which keeps hexadecimal with or without the
0x prefix and validates the whole string. Both the documented form and a
bare "00110F10" are unchanged.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ark/ark_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 9272e271e6..8810b02849 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -896,7 +896,9 @@ process_pktdir_arg(const char *key, const char *value,
 	struct ark_adapter *ark =
 		(struct ark_adapter *)extra_args;
 
-	ark->pkt_dir_v = strtol(value, NULL, 16);
+	if (rte_kvargs_handle_hex32(key, value, &ark->pkt_dir_v) < 0)
+		return -EINVAL;
+
 	ARK_PMD_LOG(DEBUG, "pkt_dir_v = 0x%x\n", ark->pkt_dir_v);
 	return 0;
 }
-- 
2.53.0

