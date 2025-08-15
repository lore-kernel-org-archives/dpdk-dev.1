Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4192CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E36140648;
	Fri, 15 Aug 2025 18:26:44 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 964D240612
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:42 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so14275745e9.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275202;
 x=1755880002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7AmENNFnWYyHV6n1i9xXyO/SChjPPpkFYuu9uF2mJA=;
 b=i1iY6cYX+tXot0m0DK7e9OOnBMX4H8Y/h0U4aUm0KFG7ySLYZbtucIQMpQXwzFzSLq
 ua5SbpVN6bXJbuscX1Qyx6451YUmSrfWhrp6hFNo3c4dEZSzoAicTSUl6vyNDDxzFBHy
 A7fY6/PSJyrK6OBuJd4lsj5+880VM+L8EllJF19ms4O+zkLl8Z2QWsBxjL4mGvCRptfg
 kALXQJnaY90hUhar/bSTGvSw4nat/9WgNkno3nr3vR9n58xMDzvhANVVS6HJ6xF3xk4c
 9FAyh06oEsm6Vkawcnb45M0BouiUWkjc4MMj2DeNfJRWd2BSM3VWYoVP09gQXhFvryno
 te5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275202; x=1755880002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7AmENNFnWYyHV6n1i9xXyO/SChjPPpkFYuu9uF2mJA=;
 b=ZCrt3Evuuku1hK//Llf7Agtf0M3Ju+Zu4c4GL6e6DfQRzlv6qqJVVokcOblnzfXy1W
 9uJ6jngwO0RWkpj8rF3OJpiLsU9TMMvIPVVAZPA6mqbN/L7NFeiZeadb9qm3y4/6bBPR
 np7Tk+/65AYovqjQ332he3YkIOtVE5yNPv1I/eyBLjPZ5Puyt5lydr+TMTOu1NYJvyGU
 /r/j+uvgzmIJld5d8BLa7DH57Duly6OZdscwRyeH5NvitO81oAax7lTgYwIfZifA0oiO
 uxi+27ESXVgm1Eg927ZogmzudUolvm6F173SeW+RFo4Q3l1nfch6ZJzTV/TexD+w6wGy
 Ubug==
X-Gm-Message-State: AOJu0Ywi/dACe2YP4ZPK9wbpUg3RxOEd4APr8q5t2V46L7l+QD+U5wcd
 lgF6Z+Xt8ZS9qFIyDd/JjHWBxLxpvkHMqq6IwRvsv9jH+V/CHnNcxFmjoScy7cu5WP/yEsgcqUq
 8EAF8
X-Gm-Gg: ASbGnct1JvFnO89+8dtiytxyAdQ4h55HwFY44jW8VkLLyZaUaKhe0Q6r8Xb1aF4cPcl
 iF56JI70CVhlg17Z/knoxe4sFa7npQbrQq3GMV06raIowXZXK1JikVK/XxWKxP6g22HgxjGkJod
 Nc/NeX7x3lcadXxKJViPBUayvSvxf/RV67z4OCOiy6PjPOw8+a0xmNzh1JzLPCIjO9c1Nvbc8hM
 z/nUIzywuokh1wh6kl4jcHi8JxvytnV4F57kLvLyuBVkV3/AS8NFG3Pl0FmSGrtFxvAlv/9pxpl
 eVUnHKD+a2PuxAWJAOpvN/j6LMA3ph/bZcx4DYgEdTIvWFvNVFQl+NNTwQkhw5B/GiggaPDvigb
 v/HT1xtRJDFKnr2fTaHOk5oEGFW1x24mi2o4IawmeeUSSaT3pvq3TwU1yeRQyVyoGZI0vwMQf
X-Google-Smtp-Source: AGHT+IGA2yueJ+G4GNagi6WkEieksRtNDQkfc6qKXv7liZStgBBPJ6ck8bNmUiFH9/IKlV3HOuTJ3Q==
X-Received: by 2002:a05:600c:5286:b0:459:db80:c2ce with SMTP id
 5b1f17b1804b1-45a21e7f2e8mr20630565e9.7.1755275202130; 
 Fri, 15 Aug 2025 09:26:42 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v3 3/7] graph: replace unnecessary comma operator
Date: Fri, 15 Aug 2025 09:26:19 -0700
Message-ID: <20250815162629.161782-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/graph/graph_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index eac73cbf71..588508b473 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -254,7 +254,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 	*stats_in = NULL;
 
 	/* Clear the new struct cluster_node area */
-	cluster = RTE_PTR_ADD(stats, stats->sz),
+	cluster = RTE_PTR_ADD(stats, stats->sz);
 	memset(cluster, 0, stats->cluster_node_size);
 	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
 	cluster->stat.id = graph_node->node->id;
-- 
2.47.2

