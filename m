Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20709D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F9B40B9C;
	Thu, 29 Jan 2026 02:43:57 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 4FBFC40297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:51 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-481188b7760so1646735e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651031;
 x=1770255831; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=IRZuzvMNTSJ8v0p7e6rBvZR4QLj03rgmV9VB9dOwJqKM3b9SjBQravTxkOQ0NoVYNK
 0PSh95jd/ZbevKilTdvngzFrQ3FUo1We2PaK5R96hz42fbo932165tQ3X5vZerApLre4
 d6bYs5u4DYjl0oKP0kWxQQH74+VA+8LXstWXPCFHlXF8VQGI0jqgScsdSm3Vc/DXRHe2
 F40nNh7Ek9Q6k/k+Z+OLDeyu6X32ZbPx6DYCsttpRTzx6smWkxPW+6T7f9DW1VpnYQx9
 Up/nq4dSL2QFQto50Lug9twBTYVXhomNRTWrEuV9P+KijWxDnBE+KNU7trf/DBaF0sSP
 y3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651031; x=1770255831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=jLKFc9r7Qm3kt/G7NPgqq8ocT32r6AAPo3wbwH2Cw+jarc4a1EUQroqPIHcFPz4yIG
 DPYVs5LCHt2PCza/iyQ1wsP+fy4smR7N/DrOycinbp50xQM6fjsmoNFxAOMbUvgAeEgx
 BG3ZPDWpbgHeXZBj16JKAs9YU4IdwJxAYEyDUIDTfW6ErNE3c1TVu6gWH3BYTjcMDgkj
 n1aEw5QtWLM1M7cUX78ugA/dLWg4cmx7GaD/ycGmBLHkHVijIb1gbNDNdY2YO+QHvfqw
 GeRD9JkHJ9AYvkVeJFDpTjNsD5vBZFs91p+PbZre/Wp0cn2UFJ41uGmHYPI6firHL0f7
 iqHw==
X-Gm-Message-State: AOJu0Yyaw6sDxBeKZi/YDCsQ58GRkkX0qArp/F/MKnX6qT0t7SDJF4ou
 m2lGw4KCAg+s/IeeZpjHZuHnjTygsL7srdwEYb0XuN6A7z6M+1bZkq44N96KOxmKEQK1IPwxKCW
 +a9E8
X-Gm-Gg: AZuq6aKp+VlNwTWDN0RK8qQz99x2KjRVoBEx18OnU2V5e9NC4dxdTdzrFcXxFXlfqNU
 fkz+I6RsOzWlwlUVRppcb7JpzZx7ne+wR5yxqXyZMm1rTCjMTbPUuHpYp75pDj6TaFg+73yE1KM
 saBkOm4NRDSbsRJvdAfqRDDxs5ZT/GoUjIi+1dTjNkvp76VEruKwlbBb1VG9cnCY2iQgvCpUW0x
 HouJlqG5qb55AN5Nnf/F3MZzgf1UAGlxhxcemIIWmSyFMcKQBPkkdMqhUFSL8zwx546de4cyiMV
 pxNS9ZD1VVAc9gG5xjYBGIjfe503judg14xOCQnK4SQYZorkeA+CTqhXixjhN4c6KCzjQE4iaJH
 j8Too/AmwJ5hQMBoHDoeFr2iD1ZnsPxtz3zKBGN51cd7fPG7YACArO08JW8szYQVPd2un1wJVb0
 3waaieNgt+hArRIcilNp0EHBCj/60Goq/9O76NISOTLw/mUp2n4w==
X-Received: by 2002:a05:600c:c081:b0:480:73ef:e73b with SMTP id
 5b1f17b1804b1-48073efe766mr13688655e9.25.1769651030875; 
 Wed, 28 Jan 2026 17:43:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v14 15/17] vhost: check for overflow in xstat name
Date: Wed, 28 Jan 2026 17:41:18 -0800
Message-ID: <20260129014313.939831-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

