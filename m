Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1CDCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A3D4066C;
	Wed, 29 Oct 2025 17:24:04 +0100 (CET)
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by mails.dpdk.org (Postfix) with ESMTP id DC8DD40657
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:24:02 +0100 (CET)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-54aa4b86b09so20750e0c.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755042; x=1762359842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=PnVmq9majjvGTLK4Lyml7ri5hJ11AYQWKNep78V/c94fG5s6sGFJkfG6Hc/s+JkH1o
 f2ZSUztQMz67MklgYUvlO1ix9UrIBEDKCuf3MqoP7r+YIT9kx1O/GBoLwSFRXZOOw2Ml
 /ExedtIqGrgrcIhviC1mqZN13bO35N7+Y/FC5Hpg00q2ftY2EdrHPez/9UL4YpXO7Jw7
 6zV4BvEnZrSZGosU3jygEkX03K4in5yaG5t3rgVM6VbNi4KKKd2BvLqPza1Y9CyJmTMX
 MTAF1kXeLJOtAnfn1aX7eH7bLy/zmemY2rskKK0fnE+oeNTSjwj9hukXXVztrnaopQJK
 /Zwg==
X-Gm-Message-State: AOJu0YwRd2oDQHk94gPQOJ5MaFdDQPeJ2XRg9KyYEH+lfrRJAN2UqdID
 msDiInZheWw35avvg1Zyh7OkbN1Axeq3Sp2BNokmZ4pZy1k+vnDjdv7sKP6k15wnilIGbapA7TN
 xHa27nI4aq2un2+AOAz0p10eBWXteSNoEHV7tidwr7j2z9JDu5ys7bTmkyDyyRsKvRv/VwUBQT8
 nmsOhozZZz+8j55Nd/lSQF2YD1VFHGj73TD+n9L9N5ZlBXEm6+aKI69Gc5w+RtDGqV2/IajA==
X-Gm-Gg: ASbGncukBvuBosYPnExqkY4pJ2FaymyS7IyZ/SKTYgZ8ZYKS9YEJaIdGO8bamSfxI06
 LycDSBa7+Jdh+xZ4he40x46P0KiT49bi/X+ZgWo9Vesgpbc3aqrbX/s3AnEpgq9+DQi//Wq7IAA
 twIjDR36YUUV34D7GZp+GokMGNLd8kX+lHpkFX5ClnnyQnW10mkKVDgs/cPUreXAh2KvUtEC8mt
 hIIm1QuFUOSu+/47dbrD775nJNC6tcStlce3ANy+XOvB20C681S1DF4+kcftUWxQ26ZhxD+VuE3
 2IwkBiz4bJsXG2POmKBgYthmcfv0UBS06BSlHD1Yq1H3c7fm1Q93pylp3bZNXbVL4ySCWWwKU+u
 5vOkAXcDLYLLI/1FQnTvDv/h+gFRmqHDKgmmgHvQBXqAemoMerTaDytTls3RlUGTkfLA1q1MP+z
 YeWIul0umVSpNe7LvD/DDt0CZtfSBdhmWQ/Wig
X-Google-Smtp-Source: AGHT+IG2xbRl1rvkEAOaJGqzIlBTJ6bP3ftScJ89B/L8p55exzywenhUcx79KAKEHNE7V+YmYuxQiRFfQpy/
X-Received: by 2002:a05:6122:30a9:b0:53c:6d68:1cd0 with SMTP id
 71dfb90a1353d-5581424766amr1274189e0c.14.1761755042072; 
 Wed, 29 Oct 2025 09:24:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-557ddab68bcsm1667980e0c.1.2025.10.29.09.24.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:24:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a9ec099b5cso101857785a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755041; x=1762359841; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=JJYZP5cK3Owd3vu9kk3AtfTH/AzIGcM7AOnM3u3OCqhc644urmZzdEFrHmSNqSWUUx
 Y0ys9W2v97z3EaYxpN9a2JPtwEgUhwWb7b8XfxHQTyGrTl/xilwN3XZZSECW5XCxo4Le
 4oZIx4G1V6Rfk4/N8+e01yVhERl2Vdu72H6NU=
X-Received: by 2002:a05:620a:bce:b0:8a4:19a:dd5c with SMTP id
 af79cd13be357-8a8e43612fbmr526355885a.1.1761755041078; 
 Wed, 29 Oct 2025 09:24:01 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:8a4:19a:dd5c with SMTP id
 af79cd13be357-8a8e43612fbmr526350585a.1.1761755040498; 
 Wed, 29 Oct 2025 09:24:00 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:24:00 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 52/57] net/bnxt/tf_core: remove excessive debug logging
Date: Wed, 29 Oct 2025 12:07:07 -0400
Message-Id: <20251029160712.58519-53-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change removes a debug message of questionable usefulness
that can spam the terminal if more than 5K flows are created.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 47870747e1..3fe4dbe3fe 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -1012,13 +1012,7 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 
 			count--;
 
-			if (j != start_index) {
-				PMD_DRV_LOG_LINE(INFO,
-						 "%s: OOO comp. Opq Exp:%d Got:%d j:%d",
-						 __func__,
-						 batch_info->comp_info[j].opaque,
-						 opaque, j);
-			} else {
+			if (j == start_index) {
 				start_index++;
 
 				while (count &&
-- 
2.39.5 (Apple Git-154)

