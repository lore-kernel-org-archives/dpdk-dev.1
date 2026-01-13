Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E82D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C61240B97;
	Tue, 13 Jan 2026 21:24:06 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id AEFC040A89
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:24:04 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b874c00a3fcso129351666b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335844;
 x=1768940644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=z3a+c1Hkmp7efIs/Ln9C3F6uoEnextmMtvGDV2h8C2RtcS8tUZVbu2UUYeqEeyQPpG
 WoO+sJguqyYEzgwgZsFJAxCePosjbyIYCEgdTfO59QP8Hcel2cQRnKJCEd+QllndyHp3
 soIJMKsOAiXsP3wWxFzrnq+elEQDgA0dTKIeohzUpKjSnolrKQ/ICPmHC0RrEPzLhegu
 4k8tvZfGKedb7pqUEEE95VD//3c+D+pm8P5l7iVVzTiPy/gUuLPJJR4xIDUfyHfn+e6y
 kLbx3alk2rHb+AlVz5XtXuZVfv54NPBbnY73jlZLMfOzkY+XzGr94Mh5W8+JZNV5oDCW
 +Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335844; x=1768940644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=EwXRuSFcSKTsJRW5lIx7pQv3NkDGZfqEj/9LM2NsjduhEYYHQojoHms6MvaKxRwgj7
 ArVeS+tICMSTdMFyc23FtUs9wmlgAHum49ImW1aGjp0EUuC9bdS7aZ+vrdoMogqWiPPN
 83ePRlfNkOwXStGhUxE3r/NrFSeze7J4Mdot2qtH2vXgDTi+mf0Vty3hI6rMCF4jnYBp
 SeEwWgoN25ez61PLrZ5ZdEBfueZBgiNqSo8jIZP4djVpjaEY63A/bvxktzURQXBfmwNc
 AqgywHRi4jS6WMBzj/Wob0wRHdH8WB0DlbrQgk00l3omC1zW3wn45xCOj8Yo1IxgUsbT
 WSdw==
X-Gm-Message-State: AOJu0YxQGwUKcG6e43RKkce6hANorIUQSevR7I/Hzpk8WrlVWvNvpOI9
 4C7wAioVF2rKQZ6aEWvg9WAg48I5CVOorJ+xzLSLKAadONboBnHjg0/BZjGrI7M7zYg6zuz5zaT
 4soBi
X-Gm-Gg: AY/fxX6odoD52xvl/L3Y7lxwlFyxpcwFnLPX9bJOF+SwvjYtOjspt2rJV/iP8m2FtTv
 MmZkXZOpkuqqh9KCKTfNSZY5RIHpo1XkhfHFQ5c7unVPyP6RvFn1l11RZYgE+dP4P+H96ONNzpU
 RYv0M53DXltHKzr6oLTlKvBSX+VodJ4ha7/0Ibe/C8/GKqRUev3rDDWUqhy17WWA9DubGcai1GO
 rhh14DtCot9JhThqCE3S7feN3suBsBjLKUxOKHCmBAmaMLGAKWuXGesJM0IQAxE/OqbxsPuP3I2
 f1/bHiB2iPZiRpCJLlpRoa1Ix7t6mV1Ug8jfmgdcxdGu8zaFYPohH/W1HHMeIEHhp2kUuFBIjwx
 YXe3C4j1FVLMcLG/nUDflxUtf0qmK+9b0jmwTwokg3yl7Oaxh2AREqh+ZCPqHH/xDl3AxGxDGqS
 Ph50MjMkRNMafngwBYpQcC4Wmp66L3Hee0yGP2Ykp78cHh7/tTPQ==
X-Received: by 2002:a17:907:3da3:b0:b76:74b6:da78 with SMTP id
 a640c23a62f3a-b876124e4d0mr27395366b.35.1768335844213; 
 Tue, 13 Jan 2026 12:24:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:24:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v10 16/18] vhost: check for overflow in xstat name
Date: Tue, 13 Jan 2026 12:21:55 -0800
Message-ID: <20260113202329.35190-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

