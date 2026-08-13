Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE348C5DF6A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 16:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 569C342E55;
	Thu, 13 Aug 2026 18:11:12 +0200 (CEST)
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
 by mails.dpdk.org (Postfix) with ESMTP id 698D5427B8
 for <dev@dpdk.org>; Thu, 13 Aug 2026 18:11:11 +0200 (CEST)
Received: by mail-pz2-f0.google.com with SMTP id
 41be03b00d2f7-cbb92a1213fso309284a12.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786637470; x=1787242270; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n4oK0SdW9OWPkOB4SBgYe+21SPoVlgro4NObsrbqwwo=;
 b=aIt6C6A0Ui8QjBfUiigjzkbTTA2S2sUu7Y5HTejaKS2dYHW5YHRUBQhko96y5qceWo
 xBbVzj8V7Icq1PmOzVX03poqANDzicPNQWn0at4QLjb1j5pBmbbZ8/4+eM8OI01KuM1z
 zotCZE0ubhB+i2zY+5dadjzZVxmAP7rddK131oTi/H9cNbtwjbu8rCa3Dv4br1JyiONJ
 SWhUUPRbGgBwalGCY0FN+sibMro/XrutLmbwrV0q64/AWf9awuiMrrmMo+SC44btMATK
 alvCUZ0PUNq40q9WjULKeEdtUulzVVpw2Sh7Lim5DH2TxQORhJtke0kZeS+6WRsUNEeX
 94jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637470; x=1787242270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n4oK0SdW9OWPkOB4SBgYe+21SPoVlgro4NObsrbqwwo=;
 b=QqAVCMIoOeV3RN4hIUvoCoFhdY2pMqL/gejq+8aaAhaYHQhh3XWbJqcWxzUNzcyiax
 YqMDkKuQISOi8eyuEU+3YPH8Ds30R7/LjYVDQsfJlSNB8JWWQ5CqKiabABKIAvE9eG7p
 kkT9zJ/wFbRSQr/HfqvM0NX7klviGHoTidbzrO4RE7/bo3cAvPZ2mLE+0ehvlp6do8Iu
 ai/jYBKnO6cK7ulcmyk2tRTf9IeakGNk8B948zaEkqUtq5Ar+D7nyt2yfqw/t70G0rHj
 RqLAE1IdjMKHnbKAdxe1V8jHSpwj/yqcyhZNKiLQWHT8947t8VIKxBhKHpnqF1BBkPBJ
 7HpA==
X-Gm-Message-State: AOJu0Yz98DPTlasBvi/FGbWWpbqBInpP6O//Ub6juh4Ojb0uqc+YQ8j7
 KRVi1zrgrXYsRJB8yOFko8RH2ydiwb+hwICywH0yT0PkT6wVDix9VAEQHee4yG4XRpXvTUQa34Q
 =
X-Gm-Gg: AR+sD13YKwTpxYejoR/zqLFtRPd2flzpXeRP1TX5P3VFglK7wQi9fePNs4uOmEpkvfN
 3PHoZzkcsKQNsMwGOpzwe1HYTZS8SsU1lWFAmChYjiJmxYBeOo/uNCjz81coSf17s/fCyxoIQWz
 DsgSo02HEXiW0phPxiWFuOnCFUO43UsXB9/yyap4bAldq9PxeF3rqZ4/FkroeLItWMpJfUxIIJh
 SF0Xr7TdOSoL9yRrTBinozWyD08ssC51Bs9QfPJ3jUYg8k7RDeLP+UKmR7k7neh/W/MR/OLOwWD
 9NYopj/z75+LRYAk+jzHzcwj1pIA4ZWMyMejP+n/7TPGrB4sWgNYMs8/XNhoKtAnYrHYqCnI5zk
 KTZShBTC2JJqczbVPLcNjKNgHP19tzy5JOFen1adUv3IssZZU2UzV+pPzPYF+RrQz4TbTnbiYRF
 Q/UVLqqxv7Rg4D9Fwd7S9qP17Omuaug2hlbAl0AAfgxNaAUj8cRgXY5N9kco2Ts+O2dkz3fl4hJ
 Fe2FZfWPiQU
X-Received: by 2002:a05:6a00:22c9:b0:846:bc81:3e29 with SMTP id
 d2e1a72fcca58-84fc6c878bcmr7904686b3a.2.1786637470266; 
 Thu, 13 Aug 2026 09:11:10 -0700 (PDT)
Received: from LAPTOP-H6E44CS6.localdomain ([20.78.144.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc45692eesm1184766b3a.11.2026.08.13.09.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:11:09 -0700 (PDT)
From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 Yang Xiaoliang <xiaoliangyang69@gmail.com>
Subject: [PATCH v2 1/1] examples/skeleton: fix typo in initialization comment
Date: Fri, 14 Aug 2026 00:11:02 +0800
Message-ID: <20260813161102.41575-2-xiaoliangyang69@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813161102.41575-1-xiaoliangyang69@gmail.com>
References: <20260813161102.41575-1-xiaoliangyang69@gmail.com>
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

Fix "Initializion" typo, should be "Initialization".

The sample app guide includes the comment via literalinclude with
:start-after: anchored on the same string, so update both files
together to keep the snippet extraction working.

Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
---
 doc/guides/sample_app_ug/skeleton.rst | 2 +-
 examples/skeleton/basicfwd.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_app_ug/skeleton.rst
index c4a29033fe..8a436b1182 100644
--- a/doc/guides/sample_app_ug/skeleton.rst
+++ b/doc/guides/sample_app_ug/skeleton.rst
@@ -55,7 +55,7 @@ function. The value returned is the number of parsed arguments:
 
 .. literalinclude:: ../../../examples/skeleton/basicfwd.c
     :language: c
-    :start-after: Initializion the Environment Abstraction Layer (EAL). 8<
+    :start-after: Initialization the Environment Abstraction Layer (EAL). 8<
     :end-before: >8 End of initialization the Environment Abstraction Layer (EAL).
     :dedent: 1
 
diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index e8c18d5b87..3fdb83519f 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -176,7 +176,7 @@ main(int argc, char *argv[])
 	unsigned nb_ports;
 	uint16_t portid;
 
-	/* Initializion the Environment Abstraction Layer (EAL). 8< */
+	/* Initialization the Environment Abstraction Layer (EAL). 8< */
 	int ret = rte_eal_init(argc, argv);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
-- 
2.43.0

