Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46170C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFA5240E28;
	Thu, 20 Aug 2026 07:25:24 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8C0D140E2A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:21 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caed617615so19264255ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203521;
 x=1787808321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KeuSAIy0j/sL9f1f59AKmKFJ3B1k11xveherJjb1q3A=;
 b=WQlyUwh1SusX36wdi54dGV7yUKrtwD1vSh3AESckVTueOwxvpRSc8BsvbQZ45JOqki
 KNy/gKIvMg1D4NGxi3CynkYtoHgAESh0LeFSBLXZtrvXlNyhu9BH/tR+MUTbCbWA01PF
 L9IJzha1//Fsl+lo6SisbdSWYaGNZTTzDqHdXtmKK4OyW4vWu+12yZzjcXU6OabwcQ7B
 3Z6GypcXtfhrahmqXlg8u3hrpEMfuGTJ3PZqyufXus27f4SCwngK8HOrerqlhBG11v7P
 WmdJEaN6PIrBX7iNF8GMqOW2cvCfC0HRFIqDeDlUEl/Mg/bbRzLDokIK4rNUQZJU7NAi
 e7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203521; x=1787808321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KeuSAIy0j/sL9f1f59AKmKFJ3B1k11xveherJjb1q3A=;
 b=PRil1tq+qPhZ6xj+MVjTisa5eZ5b72ixQQfjYIeIyaYfVKFm9rrxyeZTftH4DNpwSr
 lzfNHZFt3ZKVojaOQNqeJQfNJU4QV3mTVkWCoHoFq7ZZev2Y5b0ADkwiMbiEdybrmxct
 aJ/FVRCs0ZPFG+OotFzdMzb4mWTU1MBmwcKfolwmRhY2WiF/0ZMrejgEWsldQQl4YWCZ
 rBQyPtSGsX+0DzDRh6oKLlzqSdibn3352h1mc/W+HMXaxz9FkHMgHDgncmplJe3C8/EQ
 1E/3i7TQcWwOyrTd96rkcprApLRoONLErqPhQ5c/ILXgFQb7Y8D62fqpufa31JO4RfHs
 V4VA==
X-Gm-Message-State: AFuF++k15TQRbW1hx//8YfIYYWeMivjzdP8uWTBwGISDYHJboAy6ZFLN
 ZNehQHvK+zpof6tYVUd1P+FjtsBjhpngwBAfkVGpsBUkwz3Xm71++X+zZnTwy/KCykF2f85Wywl
 RcsB9
X-Gm-Gg: AR+sD13XWL57NV5P80BKUWmITMJnA0sUPXBltP3a5YRXCB1+kQTgDtYJ+gvsAduoi/I
 G3kLyULXGqpbHNL8Lfcr8/nH+8AJmVStudcPcH4A0sBQDuIxDV9ShpfaK5WS+7piqgBabUiAKLX
 BiXlsUCloWbFWz6bOV45ek6GTaTu4GRYK88voY/yfQJk+nemSTA7r6gFf5f6NmM6W+XMGfi+93s
 AWCQTq+Wvh6QolcmU7J3na3z3d1QDO/L7orgUwsmssr4OMx2l9buChRAPyIXF36ZhNQeN9JTjEH
 1U9wRDkfixoK5TjAcoh2nOioh7sD/8JEDiP55MVAGKGCjWseig7s7kjY7VROhzi5au4jA6zkwjM
 U0So+J4rV0Wk5yOoLUhOVAn+bajsIzuVVKVmab9MNW4YaUxyairoBCuhgAJoGPfseUnBdtsf5Sq
 E8dlxa2lNnFe/tD/W+W/Euekeu+K21SkZW179JKUIvam0qemt2KYNreoyIfyRg22QzDKwtWqBhG
 5ep3z1Ve2K4WEtPhcytHWY2Qb8=
X-Received: by 2002:a17:902:f68e:b0:2d0:cc92:f7af with SMTP id
 d9443c01a7336-2d5ff7c7f9amr187345645ad.9.1787203520543; 
 Wed, 19 Aug 2026 22:25:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH 38/61] net/qede: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:28 -0700
Message-ID: <20260820052251.1453273-39-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_main.c b/drivers/net/qede/qede_main.c
index fd63262f3a..32fa2016d2 100644
--- a/drivers/net/qede/qede_main.c
+++ b/drivers/net/qede/qede_main.c
@@ -180,7 +180,7 @@ static void qed_handle_bulletin_change(struct ecore_hwfn *hwfn)
 	is_mac_exist = ecore_vf_bulletin_get_forced_mac(hwfn, mac,
 						      &is_mac_forced);
 	if (is_mac_exist && is_mac_forced)
-		rte_memcpy(hwfn->hw_info.hw_mac_addr, mac, ETH_ALEN);
+		memcpy(hwfn->hw_info.hw_mac_addr, mac, ETH_ALEN);
 
 	/* Always update link configuration according to bulletin */
 	qed_link_update(hwfn);
-- 
2.53.0

