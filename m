Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA3D31A00
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 269A54066E;
	Wed, 14 Jan 2026 02:52:06 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 5CC4D40667
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:52:04 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so81875545e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768355524;
 x=1768960324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=TKBxBqvjcSDGJwSnmtuXJe03syNmQKe2cO8uqxyowvqHR69SnmhTKzheW0pEclWLi1
 VJdpCyKfOGGJIm4BuI67MNIwRMNb5pfwpiJrkzLnCSnTr1d7cTgDzHFgi2euLlVofAGp
 e1pq+ZFODrqVNMlmlDCeghuvir2PZdbjc1gjBpOWAOmHmDGyRhCww12djn8BwePdx2TB
 UIME6t3fVyVzaAlh1F59gKV2XJCc71UFD0fz2gBC0SFN2BNG8aG2QD37bvD5YvWRZ6WH
 CUkjVDCGfEhc5tP4tFmWl/wPoqoeGHd26YmoxjoSXVJDMYjz/5sAvPXYBdwmFIbVALWt
 LtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355524; x=1768960324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=tnMDwzhLJmVYJtHjpqIrkPYrVFJ3LPdUsYJ/kNTmSY8ya4d3Yryk0K7pc+5twJK0aC
 aFqZExRd1qMllKvTufBFeZjqv60dWIxXf9Xi+54fnKouvh2QTQ/aralpBS4QwP5obn6j
 8qyrW3wLYTO7mkvwC8tdh6NercnO3x67CP0Yx1Ub4KVpmJHOD9pRtlDbcJX8mZdhbli2
 JsqhTGGY2Mk/2+t3X2CvXAb3JaUBWo1dEUmnh8H/JHR6AZKpcuZYgDRxy3iniVMACbTY
 5B+yU7RNszGzuzBucmWUpT57LZTzxj5BNvpoTxrbsQaz2KQiv3Wbdv+3sWXxnAEuwdtH
 BV3A==
X-Gm-Message-State: AOJu0YzBf4ueWyW7jvfYfSZBemE+43+ssvaHozF4tuEBB5rQG5A4wPUB
 DWHmKzdOYgOy4lbOwTIiosiRIsa4o/5ZDzYWHFwQvDQFTUjDzNSqW+R5zQUE8nFKZ3sfNYqpMjz
 RjQjp
X-Gm-Gg: AY/fxX58hMfLtdgRK/qnCjWjvNYsNRhIacRAxaHkkqPv3EIysmvn6VqkXVKg2UrQQ+o
 B0fALg4ZUIJCxJpp4M/SAIuFS7errLH/OeRTT6hhoZABWW6OI07wCzsgA1F9NoGRAxW6/rPFAKi
 xTyV5zjzQ7PHWcfX6BQKIco7d4Ctle4T0KcSWVfverab7R35QYKcg+/RZSK78xkeU/Yx0Gs8RPY
 qVB38OqIPlK8oS/GrikOcKaKnyMGgqNp+eS62Dz3rS8Cv1vKAn8tu8me09uATkf5WtmwQoLIS/f
 nENCSQs15qqnx6cnDFHLjIB+4vvJHM82lAVcFS00pcaRNSRX3MkM4HKykTcQWN614qdImmGHa+K
 Ziua28ky8wsBebBJyPT92D91zdwOxjxi2t/dXUqP25Otb0mYQ0rPXyrmcYdoVLoKvVHlFpsed24
 9lEqDfOP7urdozmnH7lyBTjppdTIoksBssbJT6unj4SgChRhFwFw==
X-Received: by 2002:a05:600c:3d96:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47ee331113dmr13492685e9.16.1768355523986; 
 Tue, 13 Jan 2026 17:52:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm47619810f8f.17.2026.01.13.17.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:52:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 3/3] common/cnxk: re-enable vla warnings
Date: Tue, 13 Jan 2026 17:50:01 -0800
Message-ID: <20260114015149.70983-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114015149.70983-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260114015149.70983-1-stephen@networkplumber.org>
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

The code in common/cnxk no longer uses VLAs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index daffc15afd..58ebf4c99f 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -94,8 +94,6 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
-cflags += no_wvla_cflag
-
 if meson.is_cross_build()
     soc_type = meson.get_external_property('platform', '')
 else
-- 
2.51.0

