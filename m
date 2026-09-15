Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B8EC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2401242E3A;
	Tue, 15 Sep 2026 21:22:43 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id ED00B42E78
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:41 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so92732a91.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500161;
 x=1790104961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c4e0kQje+fXBYsSC2/knueG5ePgskpaTE91N4Qqui6I=;
 b=Cz5qhOOSza+SJ+GrarFsfdnDz3wfk4wb9ogURtKCXAVZGrjiZnHjj0KkerjjBRpJvT
 b0dHlzzcPOom+W4OmRpljW99VI48SvIkinyMqYaFEqaaQuymoHU3595bKSv/s2/YEu2A
 kNEtLNFAebUPBRiVg8bTTCMruwZKseVwMT5rMRWGL4QPpK/UzPV/PQUz7ROqc6o7269T
 HxTCiLZho6l6uEKgro7NAYcH+kIRQkXw8P1v62UZLJtAvwIJOLIZDOyLvM+q+bC3h/4Z
 +F2ctUOWpvNDGKchbIQgXXj+2R4I7QV0Snwzom3SBKeFKqXZ2lI3XMp4QsTPudJYPK/J
 AnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500161; x=1790104961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c4e0kQje+fXBYsSC2/knueG5ePgskpaTE91N4Qqui6I=;
 b=DPIVu87hrLNfZz9G5TTgHdtp/TyNTCdErvDeoJSSY470CkC+5W/GuWmyGeUARnkrc7
 pDqBRK3HwcvpIHK8QkUdx9HkxQBQiVzTDdhXmML+4sTrPvoKLMtnM/YggQGM6F3c9M/N
 m84xiZv3RuoyKdnkUU2jUynxzOPP467g1W01zYr1dwlji18ybd7OhQF7bLgCo2F5DXqX
 vVgXQ1nvPJVBDE9aQx/1S3Q0RLY8DfezLL1QXoAz4RjvL5hNqJo/202VgXKbjzsKq/nn
 BA343xpjNd1qodUoOFJl50uw6qTFpZDWCoRojWY46v24WWnab6x+FvykIvYtP2+NOkpd
 HiZw==
X-Gm-Message-State: AFuF++kmWyfxO0G56BbkfmhM/TKcp3ywnsBhA60PzEOuOS6GWn3QL+xY
 76h1Tt2V75BmA2cH3N7SxV+UrzEuh2IwlhCTJG583WEhJSTQADs44l8Chpv+F0002HR3vhlJDks
 9ZTms
X-Gm-Gg: AYBFou0SZZaBUyZ1hsQa0DhMDfEOAfP6RFbODvE1L34VxREkb+ApBpqfqUdSpnNHLTn
 L21kWKneM0gF+ziMQV+Uuv9LjlObkxO/BbQP4h2exN2ad2oBC0hV4wQb1LB/a5rag3Wj/7L1yqn
 DphJAI2lyouTHyLSXXTlAbWPKTq1TQohCBDwpHGZczJ1xkf8eyT+cmPBGbtjW/Dk0p7/elXn/dd
 yj2rdE+GZ+OxLWvi1HkEaTBjTnsie1YG9wVDCMukLgfMBbiPCO6ChU5U0LXLxJ0xTDgOa+cYjma
 HRpnZ5+NpLNhjX1tWZuEuW1xW5WzKdFeiCy8UTtvm2PLv1bHYXQXkJBfcIkeTZq3X4eEibO0Jvm
 Dzw/8OA2FiZ5fYy4u1dH00nl2N7myEdaAuWjCkDQ870eHC37yg31jWZwYPu18aLgoP6Ni3epYfR
 641qRq1E/x+jhuadVRkY6gvI5Coao5tR8UZlNtA4Qtq/9SirDWpuVOTzhkEPfWtpGtV1HaUkQvE
 YoE2qhThDcOvd6pAxE2PP6HCU1NdPFu9a3OO3UfhY1bP8Fx
X-Received: by 2002:a17:90a:6d97:b0:39d:ec43:df74 with SMTP id
 98e67ed59e1d1-39dec43dfbbmr11480500a91.12.1789500160980; 
 Tue, 15 Sep 2026 12:22:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 08/18] pipeline: use secure random for IPsec salt
Date: Tue, 15 Sep 2026 12:21:06 -0700
Message-ID: <20260915192207.3926217-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

The salt for AES-CBC and 3DES-CBC was generated with rte_rand().
Unlike the other cipher cases, where the salt comes from the key
material supplied by the application, this value is generated
internally and ends up in the IPsec transform.

rte_rand() is a fast pseudo-random generator whose state can be
recovered from a few outputs, so use rte_random_bytes() instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pipeline/rte_swx_ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/pipeline/rte_swx_ipsec.c b/lib/pipeline/rte_swx_ipsec.c
index 553056fad2..9959009aab 100644
--- a/lib/pipeline/rte_swx_ipsec.c
+++ b/lib/pipeline/rte_swx_ipsec.c
@@ -1460,7 +1460,8 @@ crypto_xform_get(struct rte_swx_ipsec_sa_params *p,
 		switch (p->crypto.cipher_auth.cipher.alg) {
 		case RTE_CRYPTO_CIPHER_AES_CBC:
 		case RTE_CRYPTO_CIPHER_3DES_CBC:
-			salt = rte_rand();
+			if (rte_random_bytes(&salt, sizeof(salt)) != 0)
+				return NULL;
 			break;
 
 		case RTE_CRYPTO_CIPHER_AES_CTR:
-- 
2.53.0

