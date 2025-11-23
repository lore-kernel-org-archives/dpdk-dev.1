Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2DCFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C91DE40659;
	Sun, 23 Nov 2025 18:45:26 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3EC31402E1
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:12 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2956d816c10so41660355ad.1
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919911;
 x=1764524711; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=15uYb3orNbHHHg/gdBWpYvg37owDZvQUD5P1z9mtCHqTzAZiVroBRuQGkinVITSJKk
 gybV/1rGqL4U9dnkuAZIz/LS9CR8ijjTFP96n8Xy86+cmcldElIstIfWMQhhAjdqzK0C
 5/LoT/aXaJwVhYHtDijhFK8ZzNnAvjjTeTz0nIvTPBIFsd8EnosMSuZI8uMG/5CJhF57
 EjHQLRSW3sVmw27fK0et8xskizoT4jlytK1zjjANN+mSjkdTkkLJR483ZoETUVA/IBX/
 URRMKfGTZY684Yxr2vxPiUsF1TOXRgdPS9jPKxohRbAyazw7Wmc5bvKGodpkOnnFl8ix
 4lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919911; x=1764524711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=Fdat56O+n78zufpMtZjIa7h4iLXwFzeO7y7/Niz2+wa4GD0Fs2Cfm4M662Qrj3kh+/
 D5PgrOMM+gBgXQcoGqHsOTrB/1Z1v98+ZpDTQdlkFQzdGt/gYl+S8Q1YICMre/aeh4ld
 83p4b0V8/t2SwnWlO4xckQGesDNR52gGaomt9x+yLdWqWuoTmoyIHKg/c9UulmOB5GFp
 FZs8URK5YNu7oyxR0gMX6FHcThmKjtnT4E9WcGq7tIYK8uA71E0Y+8bH0CGiG9DKH84g
 IYI3X0SGiO3koLC9EBRocU4+Sb+tgGOhkjBzl14auWw7WFaZIrw7YjFms2rLd0DmZGUI
 keSg==
X-Gm-Message-State: AOJu0YzDz5Xovi2jGSda6UEt24BvHqkL4wOG9+/SWuYF+t/PRa+DNCao
 47fzZKm/7t95Tky0hl8soZWgGOjEdbSbs1ISqyNEHfscx4EkghwBohCUgzbubThwvTH7BDo+qcT
 jqP5R
X-Gm-Gg: ASbGncskrTHeEGRoGSpR2sPnObyHID/zN/GWyejEpoM4W3allsPD4Fc8+Msb8g++QP/
 yWaYlMQT4s8Fx7QsaXZr0As82nzuFne8v7LpEWU7WxDGXutY7v+J1kPStAW6h9SN50EckWxlcUZ
 /gG/NplyudEOSeVcnqDJbQL+znQPMXKBmuPuGJRoFA6K6ooDWKvFhky6oAg7aCH5eyDQZdj+6Mg
 l5wd51lRK+aicgJQbpE6fDNRxMauHPfoKMI+2cdUH9XzxnSPKCd/TCLbuO7dvUtyihGW0nA92Qm
 DoF6g4aOl7mXz8V4VxLISlaUaljDaaxz18euhIuz3dAIUMcFWNWavOlUoL0lYsb6NYyxws+RDHq
 OEzBR2uu+bmWi1imxUKRN2Z1K2OHgBQeuFiJpj26mSRbpgTa+5V1WkPpjPLR15LgqODAFVEIDnA
 N1kLNZuoXIHkXyMqDPtSM7cU5cmGRH3fHepOvfziO41k8Vis8sdw==
X-Google-Smtp-Source: AGHT+IEoSBirViySbwcPpXKfAMMbJVi1rKJk07YHIKr+L/00n1kjgZ4IGtyX9J//l/nlNeamIzKlGw==
X-Received: by 2002:a17:903:2346:b0:298:68e:405e with SMTP id
 d9443c01a7336-29b6bf9b0a5mr106293535ad.59.1763919911444; 
 Sun, 23 Nov 2025 09:45:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Ciara Power <ciara.power@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v6 7/9] test: fix format overflow in cryptodev test
Date: Sun, 23 Nov 2025 09:43:30 -0800
Message-ID: <20251123174503.20880-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

The vdev args buffer could in theory get truncated if there were
lots of sockets or lcores. Handle that by checking return value
of snprintf.

Fixes: 8bfdd8a7f0f1 ("test/crypto: refactor to use sub test suites")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cryptodev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 9bdd357727..bd6a2d3fa6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -17713,8 +17713,16 @@ scheduler_testsuite_setup(void)
 		RTE_LCORE_FOREACH_WORKER(i) {
 			if (worker_core_count > 1)
 				break;
-			snprintf(vdev_args, sizeof(vdev_args),
-					"%s%d", temp_str, i);
+			ret = snprintf(vdev_args, sizeof(vdev_args),
+					   "%s%d", temp_str, i);
+
+			/* If too many args the result will have been truncated */
+			if (ret >= VDEV_ARGS_SIZE) {
+				RTE_LOG(ERR, USER1,
+					"Cryptodev scheduler test vdev arg size exceeded\n");
+				return TEST_FAILED;
+			}
+
 			strcpy(temp_str, vdev_args);
 			strlcat(temp_str, ";", sizeof(temp_str));
 			worker_core_count++;
@@ -17728,8 +17736,14 @@ scheduler_testsuite_setup(void)
 			return TEST_FAILED;
 		}
 		strcpy(temp_str, vdev_args);
-		snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
-				temp_str, socket_id);
+		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
+			       temp_str, socket_id);
+		if (ret >= VDEV_ARGS_SIZE) {
+			RTE_LOG(ERR, USER1,
+				"Cryptodev scheduler test vdev arg size exceeded\n");
+			return TEST_FAILED;
+		}
+
 		RTE_LOG(DEBUG, USER1, "vdev_args: %s\n", vdev_args);
 		nb_devs = rte_cryptodev_device_count_by_driver(
 				rte_cryptodev_driver_id_get(
-- 
2.51.0

