Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC07E78497
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FBFE40A6D;
	Wed, 24 Dec 2025 23:13:55 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 59C1E4067E
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:54 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so29255615e9.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614434;
 x=1767219234; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=YoASQEvIyu+7a9oVcCQyyZPPOJBmwXOy82P+BbF/qeLr+n8evQGIGbc3bhtZ9Wd2M1
 rWfUjKbLrpvb5+oyVQb84gQQy02T2c0nH+Ummxyf0RhDr75kW1PNCAHYfmZk7p9m16oe
 JA+10scbVDdBppqS7khjIRsLK7FTM6u+04MqMXfMvhlJ2l5ocskCrV2S/hgL2HrpTc8o
 cUIy9cvcO3MtZWnB37Cq4Fa9jtH7xBZLedNlALyFI7Rw4cxrHwxumqQyQvBd+xnLYaS4
 J7zsqa5Sn2CxlPXOgSeEjQ0BOsQDvhuU3az0M7OGbU+oA814LDjs3XMh4N8S7QdBwKyb
 GHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614434; x=1767219234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=Rsd2IqrnHVmYI7In8I6vHxMM3Qd4z7fjAAbdJLhZfGq07bgSw2ImdHl7fg0n7tlVG4
 lSodEyXRrKahaH/Q/C1KNAiRtXqsZhQgIsTUq9y8N7k18vz9YL+clLndXJ+ISISFqZwV
 qfXbIuevL+jsvtLoyz/4LHerPT8mwRbdQQVMPA0LOl6FbetHTdcEYCuYRA7+wsdSPPZc
 v+T1xbD9smUHg3EtolaBz2nwYnb2jxo81h/Aiy6JpB8JVxBeWSFcX+TFHTunyCp7hOG2
 NqAv2EVUGSd68DFGxoK899ZkIFsUlCxGRjQPO5W8tYOj4VT/HkvL6AigNlnWT4OmflfX
 ZRrA==
X-Gm-Message-State: AOJu0Yw2dCwdgQZfF4eSq0WaPt5QDcn8NOn80KZRC1dANLwbeEqBEBJF
 OiqFi4jJb0B2gMrshLLE9kf7PIGJuT+RT1VhkMoOTbGgIGpR8O77HzykhRNj0qAT7sqymPvIemG
 5pTlw6cI=
X-Gm-Gg: AY/fxX6ZCpi/bLG/e5UtrelCn8F6TOc2e/8RwJG/A318dJOuD9psbWy0iqhL1EQ+ZyG
 kZOLyhTvbGrJ0WvsBagnF0KHwbpzj9x/ySFlvRho1SmQussJPPSTB1SBMtPjaQ9cbONnisHYWxs
 tc55u3nKr+8JnjHBcX7Ig8G3htu0p1NpSYCGQGjPaesuaEoSOl+Ycos0BpDUDC6ZMx1qs1nntwm
 NZYmjv5WZq4lmVEEVdYLcwecXrFDxYKaN2zSz1B2YhpVW8S1FOt7e7CmW6thqPmvnuxFl3C8KbM
 gK5o6iMqoC3cygFogCU3qXNhD2Gx+oglyQGL7mXCbyP0j+mruUQTqt8Dh0qWdM67glw7XV8i/82
 HVpQzwCHippYxpITCAdD//1+Q7Ji9FCaHvEOpSXTRd+kHtNvxqIDk8v9lRcSoIR4Jf3Dk/Xd1hy
 Sikrpp75bNwu/nNwV1ldIA/yAFlYfXOxO2Gwn609vnxfQCVDGReg==
X-Google-Smtp-Source: AGHT+IHXrmTOKl1U3ejUTvyJno1d4ppUNMQKpwNzidvUq3oREHz5YJdumylgDTCL3W/i0pNEYym0TQ==
X-Received: by 2002:a05:600c:444b:b0:477:8ba7:fe17 with SMTP id
 5b1f17b1804b1-47d1953bce7mr160733185e9.7.1766614433911; 
 Wed, 24 Dec 2025 14:13:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v7 16/18] vhost: check for overflow in xstat name
Date: Wed, 24 Dec 2025 14:11:57 -0800
Message-ID: <20251224221301.52714-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

