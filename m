Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A83D3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55AA6402E7;
	Fri,  5 Dec 2025 21:16:13 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 45A8640697
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:12 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so16045275e9.2
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965772;
 x=1765570572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=vOmxtaGYrHGcxmcBuJoSvaw41tKBhmQBJOEbGq44l1N9+dY2DZbY4C+PpMgU8l7ehs
 6sTojxn+yvV8zQFmGVoeFVgIy+dxzOLD5StoYUX/d6WOjYdF/mwgs4vtLgh8K9SEzzQB
 B5TUGGUfsLBqB3Hon1lR/M3LTqHfqgeWHmL+US3HbXVVsE7pSNP3HcQ6ptdqzOUW4jKa
 PTtv7913ASSh9+r6P/uR/zS2YGigVV2xniuRZ1nUnqK8G2wqxUv1moLr0g9V863KwEob
 eMu6UW7obOf6MKkhwexCDjmfH4+u+k1D0h7IBPIZnfSOXOsN0RflxpICDOtJHAFhGuaH
 Ezrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965772; x=1765570572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=X43FQ1a2V/JDiIwgzUEQ9ePE1cueJkw/SLVdO4pXULbgaFSog7qnbb0g7OI6UZvGMY
 rQom6RStbK5OszGQtjpoZ3K90HLv/u/kdVc1L/Y6J2kd13mm3OYHDHZHCY0tvEu/n6wg
 XUk3K17WgoXgzYEwTm1iaHEawWOoCVNhJ4CkN1iEzRQResLB3wnFzfB9kSud3aV2TeE5
 zzMyZS6qWPSvLIFohDVORyu+ZhklverkX4Mi144zSWsR+gm+N7wxpId8WNRxrXlQRXiy
 5T6/U+/sTeR5vHWGnrcPd8G5X8nKAm7qpckaqOOLlbG85PLJWtebACVVtA4KxLddIQ/T
 cLig==
X-Gm-Message-State: AOJu0Yy+/SYvZEY4a/zWHJWzpV7ckMT3AxpgCmLWP0OG87sIS9WRWTfh
 xPIUa23ewH1PeoJgWGIWm8oGqUmAORPmtSu1gE+1zKlis/os1xoBH0ZO2vFYqs+QxEkHKnp4Eeu
 tuURM
X-Gm-Gg: ASbGncvRkJm4xpliIDQC6jZsoQhT67oz/aPWzWVEBCYHEp3uCo/MRw394pFPRFTIdi/
 bIN207e5PdcBQ7eP+GJlRrFVGEr0Y8A4eDH2Lo49nxgAzGTpnIJxTKoUiFgdEQi9SZOWXC+0OZl
 /LndxKTcG23M0PYtG/WaUJNeh7XHo1pnmfOL7bglBaxklt9kPVpkKq2pS581i39OTJ41mambmvB
 KK/TY8gQlzJ4KvXkaXfc0wxI6JHayhlQ2wLLP+r9FCIA70yF2TV/HJ/mvU7yL0PKpnEBqSkVpY7
 ikqg4/MQsXtOI7ziCDESKe4wdf8XYhShiClmOZip2ypQX2q8hwqXuIVeyFQlBzT2ffZ/lpzTpNE
 kL1qEDBYCLhXhmfitJ01w6k1HjxheWm8MqywtJWzSPA1L8SEiJ7xFiOGpMi0zSzvNa5Y2IY1j2n
 82G4KTziRD8DELPob1YI76utm2lHoluzeaTAcYab2S9yg0axUDzg==
X-Google-Smtp-Source: AGHT+IHFOvXlkbatc5RtroGqlwGgdbQPCrih1NeGcYD4WzXCZ+jR5SpJBL/LlztPwvKZZ8pKmHLhVw==
X-Received: by 2002:a05:600c:3f0e:b0:477:9e10:3e63 with SMTP id
 5b1f17b1804b1-47939e5fb90mr6134745e9.35.1764965771905; 
 Fri, 05 Dec 2025 12:16:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 15/16] vhost: check for overflow in xstat name
Date: Fri,  5 Dec 2025 12:11:44 -0800
Message-ID: <20251205201537.251131-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

The snprintf to format an xstat name could overflow if called with
a long rte_vhost_stat_name. Check if that happens and warn.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/vhost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 416f082dca..540f4e0635 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -2200,6 +2200,7 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 {
 	struct virtio_net *dev = get_device(vid);
 	unsigned int i;
+	int ret;
 
 	if (dev == NULL)
 		return -1;
@@ -2213,10 +2214,15 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 	if (name == NULL || size < VHOST_NB_VQ_STATS)
 		return VHOST_NB_VQ_STATS;
 
-	for (i = 0; i < VHOST_NB_VQ_STATS; i++)
-		snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
-				(queue_id & 1) ? "rx" : "tx",
-				queue_id / 2, vhost_vq_stat_strings[i].name);
+	for (i = 0; i < VHOST_NB_VQ_STATS; i++) {
+		ret = snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
+			       (queue_id & 1) ? "rx" : "tx",
+			       queue_id / 2, vhost_vq_stat_strings[i].name);
+		if (ret >= (int)sizeof(name[0].name))
+			VHOST_CONFIG_LOG("device", NOTICE, "truncated xstat '%s_q%u_%s'",
+					 (queue_id & 1) ? "rx" : "tx",
+					 queue_id / 2, vhost_vq_stat_strings[i].name);
+	}
 
 	return VHOST_NB_VQ_STATS;
 }
-- 
2.51.0

