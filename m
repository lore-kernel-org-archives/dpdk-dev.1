Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC95E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C45E64064F;
	Tue, 23 Dec 2025 19:14:33 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 0EF88402D8
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:30 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b83949fdaso6319410a12.2
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513669;
 x=1767118469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=BUd4x/BWdfRlE/x1Gv/1ziMhQcfw4NJ5Is4WGRmBpk8GNeFStyuOY5ZEPA/XELGOkM
 Unyvghbdqzpho0sR1EIThXfPAFl4fU0GjhAk/rZ/fBj0yCFVxNFPDSD7p6LI61EHR/jW
 lTkTHBhkSXxMFmchZijAuGgcGj1pK31ddI7BRZbiAw9qp5PfpFe82CLJ2KfREjC9W66Q
 X41JPRm+FxRc6XbSvW5/RSoNIIuwrxSuRa6IHTdkeaoTWrQGbC9GuyqOmqT34838s5jN
 +Hd+hxkmcYAquNH7AX8W0o72uK57xQ9EJDz2Ue0p/ULwqUnih/skdHluPa5gsx3mVaNu
 enKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513669; x=1767118469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=E+0vHdgb9crPBfzMLslcofDac5cHac4pr4k5WZUTbPCKy96aml3MtpnZJ9XmMns+8Y
 YhiLQGoIo94URthipE4xRmSFqy8wBv/Q4kCzNBAsC11aZ79oJywmfDv3RGhrMPeeDIYB
 ZGxMxGZ4Znffp9W/nSii1ATpvbeQOgFHaRUx7CPtqve3zXw/tPGi7GZfYNeBRsgI2O8D
 Sa32PORKGEhcuNXEoP+kdyIADscrd02KfWZFMDuub/WP50Obf2n9xpnl0fe7+jOxD1c8
 FVUUsj3UrVIuTdXnEts2SJZIrVKc//iNPhd0bGlEf8aXpYr7ek+B6WThlf23dKuihS+X
 7QPA==
X-Gm-Message-State: AOJu0YyR5Ds2ZkRFFFmFjtGybME1vNpCIJeGBWxAvC370arq2VLpPw9N
 7LTsy70K8EqnHDJvNe1ffyaw6Gl0aNZaUMocdH3b6X6qTRQrz0ovZMNWtmXeY64b921nCL5+CaD
 kB6TUMpA=
X-Gm-Gg: AY/fxX6afZQWQjYxLP+jJYHdBigTaz2zHFCCbk6YtPomrC7g+DUmsgCcBOqDkqQPe26
 ZH0Rt+xegdE8J+uykRg/cmP9ZGkgYKo/YlbJSMWvaclgDw0+s2iLSjmYhAcybFRH6dMdqf4Bb87
 tYDiuTjc7HxD7wosFGseXZbr7z/ie1uMz4IQDzZuKCkpc0Q2q401C5YmPFRqT2G9jAL9KyrzI3x
 ARzPx711aJwpwewJzc52wikzcwsKD+c00GnYBXKQf3mnLE4vnlYCk1SIaBbtUkcjXs9pJ1Sri/j
 lGisZweVPgAltO+ohfRyxRpxziCYY9je0llRhh1UUoLcgbIr7JsEe0Th2DrAW9t8Ga59XT3Auha
 Y4VhDrn2J6sWK3ImScN9srG9WJj06v49eQO666Pdb/QnB13mStwlVca4Mxr0WTto39ROqRXypsj
 NK74xlCMe3MnlOyCI0nFI/MwP1SbKdSAjaZVPpr1E78+xW07UQ4WYN8wH1yY9d
X-Google-Smtp-Source: AGHT+IGCN1ANKe7KRvEv4PHHhpKrS1EbX4qCAT0yLRVs7zf7kL2Ztf5FNbG5+tb7vMFXNAYTgPNGMg==
X-Received: by 2002:a17:907:7e91:b0:b7c:fe7c:e36e with SMTP id
 a640c23a62f3a-b8036ec639cmr1679426966b.11.1766513669629; 
 Tue, 23 Dec 2025 10:14:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 04/18] latencystats: add check for string overflow
Date: Tue, 23 Dec 2025 10:13:02 -0800
Message-ID: <20251223181418.40834-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

The copy of latency stat names could get truncated if in the
future a new value is added. Add warning if that happens.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..0861d00c6b 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -405,9 +405,12 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 	if (names == NULL || size < NUM_LATENCY_STATS)
 		return NUM_LATENCY_STATS;
 
-	for (i = 0; i < NUM_LATENCY_STATS; i++)
-		strlcpy(names[i].name, lat_stats_strings[i].name,
-			sizeof(names[i].name));
+	for (i = 0; i < NUM_LATENCY_STATS; i++) {
+		if (strlcpy(names[i].name, lat_stats_strings[i].name, sizeof(names[0].name))
+		    >= sizeof(names[0].name))
+			LATENCY_STATS_LOG(NOTICE, "Latency metric '%s' too long",
+					  lat_stats_strings[i].name);
+	}
 
 	return NUM_LATENCY_STATS;
 }
-- 
2.51.0

