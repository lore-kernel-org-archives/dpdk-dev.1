Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED11CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455E140A6E;
	Fri, 26 Sep 2025 18:25:43 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id A550640A6E
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:25:41 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-62f24b7be4fso4273355a12.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758903941;
 x=1759508741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntKd7R56dgal2ip13LqBL6XI+4NZf/GlxpHyeen/72s=;
 b=pEwnuzjgpQFUxx/B1ERK7RDLA7zJ2y3dGYEsWNgT1h58s9TgIRQeC9gef2VfTS5TGv
 ALIP+/KBYoVypgCZnjaMB8c3NAJV1pBkHeS9tSA4vBXESAbcZUMnnRyr9n/mOc943BFZ
 buROWdTSVN3Y0u/XXeYTOwAby0d3UK3NipZBakSNmsOAFZCrKvne/cZZDr26hveLxHZU
 QdNgw4ry7T3GQXreGjW8/3oSC+imYsNBEqgEbZAYeSnLSnrxobiSRdEkn+djmFLcsMyg
 +XYfe5LcyiLd1NuovbZceiEjnpyj2pIIBRf74mfUpqAWtKwgN1GEaaZJQ4XJrR6u4j3r
 RQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758903941; x=1759508741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntKd7R56dgal2ip13LqBL6XI+4NZf/GlxpHyeen/72s=;
 b=i0xdraye7KX7l500pFtKBNzDtwMiVyN46VEaldZW1KrE0BlNz6v4yApqDwOtH2Zji1
 FBwsf24vv08+iu07AqIyBN7wDsRvahksMb4YhLMmEUUSiTOBGPkJHd9uLFKjGpoWgJs1
 xfd92PVk8jVwIk8klz6MSm1lF8Ady84l/UbUhEhlcTXi51LQ6rcanhNJ+40YNJ2m9FAI
 Za4hhrjKNnP7qrVGrn1eMO+oiqkW+J9RewtxS0pDnfJyWFllLUwGMQYQVw1FGK+pACx5
 3/mmWzCGnSy+H7HPEjUIBlklXef4poz6/Z7uocoKYR8NHrxuvn15LGJ41bTdTGFILbWu
 xP2g==
X-Gm-Message-State: AOJu0YyCR9xnUk113oqOQRckmisnX4IKpg+aUkd6hIzX0olV1m7BRTvt
 TIaQVnMWjAMS/77T+TPfSUGCBbcy3jQVw2mBSeTf+E317cFiXuR8R+2zwyLUGeZG80NBDqT0imv
 4vk8TuYI=
X-Gm-Gg: ASbGnctlPWaS10rinQn2VnWsjo7/IIWOVB7uWLWp6AiQIwjlgzYYxgKWh2KiVhrWF85
 vR2EpT4GItfepVX4djlongcNQqggSJabSvxTTnPE9wGhKRAw5i7lAejVMyyJ/91+HWhwmYIrXNC
 z+LW0e6u2vQIe1m8wBr6Eeeavyot1nYjG9YwoWazSOAiR04C5BkdUJFHQwXhimHDWllmlEXEVZC
 htC5hfrzr3nUBiSfKeHJZTr/KRnAS8PCkE6waWYuHPVpttq5eDQzNj4xZNrNqeqlg+73oJCL1hX
 i88Ipf3BT9O/x39Ec8nVA7fY5gO90j+2PgNnNeAAjRDFUGozLIEYe4yZM1DNmC0rSpPvnU8INGf
 kFxbqz+uUe899JKtOK5+Fi8rFAgJqjUo/rS0j3OwT/nma/GOVrEhymwPcjtI+WwETKaLlqih6
X-Google-Smtp-Source: AGHT+IF0vgIU1tG4xqoitVzUNROgAZyyg79qd70hTSLyK4mDfrr9qgV0zQUWCeza7hLA2ErG5wLpdA==
X-Received: by 2002:a17:907:2da7:b0:b33:d10a:535c with SMTP id
 a640c23a62f3a-b34bd932331mr877556466b.64.1758903940872; 
 Fri, 26 Sep 2025 09:25:40 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efa406asm386638866b.23.2025.09.26.09.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:25:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [RFC 1/3] net/ntnic: rename nt_log_ types
Date: Fri, 26 Sep 2025 09:24:46 -0700
Message-ID: <20250926162534.401577-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926162534.401577-1-stephen@networkplumber.org>
References: <20250926162534.401577-1-stephen@networkplumber.org>
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

Use the driver name as prefix as is commmonly done by other
drivers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntlog/ntlog.h  | 16 ++++++++--------
 drivers/net/ntnic/ntnic_ethdev.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntnic/ntlog/ntlog.h b/drivers/net/ntnic/ntlog/ntlog.h
index 810b07efd0..c1efa9694f 100644
--- a/drivers/net/ntnic/ntlog/ntlog.h
+++ b/drivers/net/ntnic/ntlog/ntlog.h
@@ -10,14 +10,14 @@
 #include <stdint.h>
 #include <rte_log.h>
 
-extern int nt_log_general;
-#define RTE_LOGTYPE_GENERAL nt_log_general
-extern int nt_log_nthw;
-#define RTE_LOGTYPE_NTHW nt_log_nthw
-extern int nt_log_filter;
-#define RTE_LOGTYPE_FILTER nt_log_filter
-extern int nt_log_ntnic;
-#define RTE_LOGTYPE_NTNIC nt_log_ntnic
+extern int ntnic_logtype_general;
+#define RTE_LOGTYPE_GENERAL ntnic_logtype_general
+extern int ntnic_logtype_nthw;
+#define RTE_LOGTYPE_NTHW ntnic_logtype_nthw
+extern int ntnic_logtype_filter;
+#define RTE_LOGTYPE_FILTER ntnic_logtype_filter
+extern int ntnic_logtype_ntnic;
+#define RTE_LOGTYPE_NTNIC ntnic_logtype_ntnic
 
 #define NT_DRIVER_NAME "ntnic"
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 42aa2d4095..67908e3807 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2729,7 +2729,7 @@ RTE_PMD_REGISTER_PCI(net_ntnic, rte_nthw_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ntnic, nthw_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ntnic, "* vfio-pci");
 
-RTE_LOG_REGISTER_SUFFIX(nt_log_general, general, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_nthw, nthw, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_filter, filter, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_ntnic, ntnic, INFO);
+RTE_LOG_REGISTER_SUFFIX(ntnic_logtype_general, general, INFO);
+RTE_LOG_REGISTER_SUFFIX(ntnic_logtype_nthw, nthw, INFO);
+RTE_LOG_REGISTER_SUFFIX(ntnic_logtype_filter, filter, INFO);
+RTE_LOG_REGISTER_SUFFIX(ntnic_logtype_ntnic, ntnic, INFO);
-- 
2.47.3

