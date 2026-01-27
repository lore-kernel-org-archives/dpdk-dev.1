Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF88D340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC6F41140;
	Tue, 27 Jan 2026 17:33:37 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 6DF144113C
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:36 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so4026748f8f.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531616;
 x=1770136416; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=RvM4eVghS/phogjxF+EhD+B2SNE5XnPQ4UdBKcFeNGayyFSzz3GN2PTw/UTPUgHIrK
 tNvT9wpAKdmKXORaFlN+F5tKKvjwRhIYaJezt2nfocP69euUcU3iiLsCxm4bYfx2Ceib
 RDjt+RRo1JaszHWHsljgF9Hiup9HWiqeJ32d9xGtOFRSCYSrrAEC/As3pjqBSaaLfHu8
 rhgrkuxlfR/eq3cB3aL1U0qGnG0EVroJXwakAJ69r+ZWwwAEmnR1fjrCxK5uAz0JRro/
 DjhC5xCEq3Xmh/3AjIxjwTIH0ob9n4EqxtHf0ktowSj808t8nuEpPbh2bI+NJiqOjmJY
 jEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531616; x=1770136416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=SRkx7b+SPpjSdVtmcqTE7EeKATtk4SZgnu9ZmFNvMVagMgLnpo3AvAsDxryDHeRe7c
 GToSO0TGI0hKKl15Dt1PueOHntR54EwYl9tKM7WruzAjBRKHyYK6UcdZQK79WpNLB2SL
 LiLhhO6jJXSKkqoPOm54vMtieWFza6U4Vony2qmPVTHgS9VAaKPP0hKwv5ChUpS25Fu5
 3XRxQ70JKpGMBI6934nUCF8Klyv4ejqSviGDKspaV0w4eRUSQHyw4S8AGTJzCuXZWzTI
 WZKRPAxvD8EPNqYWfG6ZuF6t9m6gGcqNTGnHBp0hOYXMtyWK6KKWvPCS/Cd9f3UZCAkE
 jpwA==
X-Gm-Message-State: AOJu0YwNrjHsqeTqNvsGbxKQeyE5Xv95ZlqmkaPmLFH9OeKtS1IGBxm5
 dWs9pzGAm4yTws50hcmOZKv/Xn9iDc6TQP5euav8217pHG2+lqgZGz6IBBteJyG486Y/TvxoguS
 lLvIC
X-Gm-Gg: AZuq6aIZWgFekq9IMk0m8VzsNisV1JC0zTwrG4TeLUmFvlvrnC1Fx0qbPzb8IdpXkes
 kz66CvIE4eLaqPExUkmCs8zzEu8anE/r2BGMLWfirqiQqgQlmFWtDVglOKK53Febs0XAJzX8BeH
 erAyIKI7OQzTnqiE9+VXVh8k0mvOuD8zkM5xYbl9/guNIxJBifI+Qv44yJdV7cSwrjhQpy40vtc
 RHBzRYgPuAVj7HTRQMZM4W8tlVUlMuDsuBAbaym5l8+EIl7nnTFPUTs3x8JYg4221ts8dYciBKw
 1hAXg5zBIjzJXu2sQtveO27pXFOtayVX6qg/A04PffGD5erXRX6ZAjyiSdVmClgT+nnqVdjWWuA
 Wd0cLWYq88hKGcGdPdiq+r0DuMhRkdl/TOXA+/BiXESGyPp29JSrkQ/GeqaM7EkJP+zfIUP/RJq
 r3K0yuYw8yqNyE2VB1i+TaN8sQC3l4SJy3YjKjmv/4E+mFy+lp6g==
X-Received: by 2002:a05:6000:26c7:b0:435:a135:7772 with SMTP id
 ffacd0b85a97d-435dd029989mr3568145f8f.4.1769531615945; 
 Tue, 27 Jan 2026 08:33:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v13 15/17] vhost: check for overflow in xstat name
Date: Tue, 27 Jan 2026 08:30:29 -0800
Message-ID: <20260127163258.75566-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

