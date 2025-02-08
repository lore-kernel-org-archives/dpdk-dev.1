Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E5C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A29406B8;
	Sat,  8 Feb 2025 21:32:19 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 133B340689
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:16 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fa2c1ab145so2932750a91.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046735;
 x=1739651535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0dGiUsM7XPLY76vdWYlKm0vJV6dsaLMqLz9vbQrmaY=;
 b=vy2JTmyISfBmtawhzK1c4e8w/yQZhtWPWIpKx2HOqYHIjOB+K5dyJ1apFu0vlEFHxW
 T7zkZ+15iYxieMf6XcoOEX3t70xsTj/Yg38kj2viUY7dCMBQhn2V6VA0IA6UQ/cLsc1J
 MqRjlxnHviRAK0a4CsyNAhM/RcMgJcaZlvB4qMsnnMBUB0Yf9W114PuFYJOqwycPgf6w
 uMnRg99wARzlomYflLdpEZj4Ear9U1OQwbYlvG+wCvbCLt+iWJVOcZZTjIXQz8y2ZFc2
 gwcifdQmGMBIqmmIVj73cZ6Rt6NrznQlt/wuoSgEdDHphUDJRvUHhU7bb5DfMcaZm0Ou
 KXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046735; x=1739651535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0dGiUsM7XPLY76vdWYlKm0vJV6dsaLMqLz9vbQrmaY=;
 b=JW8+YEG8pAeDD3WsBulzldazqjPSFqA+EaiIf8mruyz0Yoica/uWoyr7+85rTi9rsa
 7jtpBhcpWyZWjm2TIbKPCWewCZHHfKqxqPoO9pTH70l++uRpAAnNGnghAjNBisMVDQLe
 Myb4H5ISFwXc/GgRygDkJvRP7WIOdrw8TGs/7q1NFBC6R4dnqG8odj6c2kEXiP6dwpt/
 MwLuVRhm3cPMJdoIwuJda3VcKZqF/3051E6OtF0o/ZEwm4ldK2eDPvZn4ueokDVIXScQ
 lP/csYPpBZhCYjj5CgWBfUiQ5IPQtJejbiPS+ifEv2IH1hi8+Ra8xgeakQ0BzJ6OH9+o
 JVqg==
X-Gm-Message-State: AOJu0YwgGpsyFf06q7ahc+SmAtsqqWbKx3m3Eyruj77Okc0sK0MJJE1L
 XRbi2HOuppIAe9X6E9QoMCgroRWZaWt7HHEQm7GwHp2vsYd9Pbv0O4FI4NnEt7DUToTgk4frsx6
 y9xw=
X-Gm-Gg: ASbGncsmh5ALq8WH7iZfaZpmbIL8WMFKPawoQd7t4IhejPDYmcF6LEagfq6lzfV2d7H
 ck4tkBeFcAAU1+JqnvkQmj52cBPWDLu3SWaEmOKYYFj/fhpxb5KNJni43bEv/WRZgg/iUYx/dWS
 vnQZ48kPoqOon9nEBsuXLekJ/1/fhibljEXJIdXE/BHB2U4GaAiH6v1r/yAShlNMJKPY8Ljosl8
 ICk7GU7tzYKTJqFHkEhPHz6IG/genBuoIZiXPTRKzinBr04ESvYh35CqBpgIVp4yqDVB7gInKad
 z5B528uztKcPpjDX6FH+1pWUG6K++Az44o46wUeG4CF3wG93tvhsVsr3LEhJaym58rzm
X-Google-Smtp-Source: AGHT+IEd+kZnKcES+bAzyOyWl8EjDHm+7L3FRFBTJzLBIsWpUA99gQZmUWNfyNQe5ycf7/2K0v3aIg==
X-Received: by 2002:a05:6a00:f9b:b0:72a:8bb6:2963 with SMTP id
 d2e1a72fcca58-7305d49d1bcmr10657874b3a.13.1739046735280; 
 Sat, 08 Feb 2025 12:32:15 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH 17/32] crypto/qat: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:09 -0800
Message-ID: <20250208203142.242284-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 3 +--
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index af664fb9b9..478e766b97 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -277,8 +277,7 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 				RTE_CRYPTO_CIPHER_DES_DOCSISBPI)))
 			continue;
 
-		memcpy(addr + curr_capa, capabilities + iter,
-			sizeof(struct rte_cryptodev_capabilities));
+		*(addr + curr_capa) = *(capabilities + iter);
 
 		if (internals->qat_dev->options.has_wireless_slice && (
 			check_auth_capa(&capabilities[iter],
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
index e1302e9b36..7d2d234959 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -203,8 +203,7 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
 			continue;
 		}
 
-		memcpy(addr + curr_capa, capabilities + iter,
-			sizeof(struct rte_cryptodev_capabilities));
+		*(addr + curr_capa) = *(capabilities + iter);
 		curr_capa++;
 	}
 	internals->qat_dev_capabilities = internals->capa_mz->addr;
-- 
2.47.2

