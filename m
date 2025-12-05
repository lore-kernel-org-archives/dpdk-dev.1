Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFED2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE8D40B98;
	Fri,  5 Dec 2025 03:30:07 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id BB85740A87
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:03 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ee13dc0c52so13384551cf.2
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901803;
 x=1765506603; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iOosTun2nK0xBkHrvQXSTNP1waDUwxGooaLJQ5C04I=;
 b=XS3qPZDv5TvMwmuoF+5IAOqaeK5gQgvvtfHUTBYI8LqBigW91+8aDHgB1xIbXW81Bd
 O6OQmKo5gfMolJ3yunYUy+OEn27thUe83RJEk3leoVwdZL5jBq67RjbIHf55g/3F9DWD
 vIqyATKu8YTrU7dFp791BdyR8kjjzKsI79GKGOopML4mpXQo6HEaNMQKbjHMq10LidIP
 Wfcr95NTh96MQoO2xJarOdkWJDZlSZsZalkGofPFOr/PjWKSyqaoivuhRuUkRXqbyz0o
 PMqD6pnQQQyLz9tJVUHGwUlqoOsWtorh2btNBvaDkR0nglmUkyehLYdfv18yYD6+rLRv
 ezWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901803; x=1765506603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iOosTun2nK0xBkHrvQXSTNP1waDUwxGooaLJQ5C04I=;
 b=FXfeUDgjiAUmwLNkyzYAgXNEM9xO1Pdo+K4+AK6Yk4cPgCtbG/3mT1IV7s8MSFcpcE
 KQN8x3dEgV3WwH1NUcO9VjTbsp/LOS/+xlwaQYk/Q0mMC6FxhSV8yW0nH/U8kWdlobkI
 YMJlJuxo+pQCfF4nlVOs6KP67QbVGeBdsnwBAsq32E2G9K31PIYMfgjto87lapHqnVj1
 jPZjOZhJkufq6A6zTmfkK0HgWPWulhzDpizSI3J+G1LiPKt8J6TCJ4P721nK21NEaz43
 U/9fPvFo5748P+VxJhH6I+MolPm+ifpF6WNQQYAZ4l8KU7nqjipC6iw7Hz/23LVzN2On
 UXpA==
X-Gm-Message-State: AOJu0Yz1EfQhrPxxONsG29c0OVb2j996T3kuJ/t/EiL+ujcP/G1kbAhc
 /Sri2QQ1nKAc57agyXgaZO8WDhQ5FpFcRdy1lmnsFXLphxjXmzh+fOWYyEoJqVeoAy7PBEYYGPO
 MOTkI
X-Gm-Gg: ASbGncuGwMciZH2ZzsZvdHjp02Rpyh1MJrKBjQSH0o1Ez0S1QRjsnq9d622nCpCLzbw
 eiZFzl2cg6DZzWHcnzt+41Efe4GhC6RB6iX8w+6lVwuQOnBNBcQXu/WiyLkRxRCnpZGjH0NLI0c
 r1imORc2vInkoQ3lEoLMSzlWrs/46SMZlqsCzQcMXV4jkgPdEf2QNWnlYKDXdVKuYyZemHjBwXx
 BxtLKPYwnoy0nhSmuNspCji2c5olKrw5mCpYGgITKFdSwjSQHQ3vl4C6kiXlxed7U4JcOp/J2hX
 bV0TeJSfp+7RFRbZSUd9TvLAcjY3nB34HM6OMoMhBroHFQufCc2RqeOdiYGeEgJeF0lsAZMliR/
 zviDAarS/GnsVnuS8hrRbK21TCie9pu66bjn7Ei/VTsLmAYdX4QD1humGRIYEJ3Bflyjpu6OZZ1
 kqECCAU3GA6duKyq4znfr9WAk++TAhj79R9aDk/LTRcJ2/0qftiQ==
X-Google-Smtp-Source: AGHT+IHbYNVVYuO4gLjzEWBTt1AdgT2lM0RrXMDWInLgVoAsUG+s57uAZyr3P/onlKpVMR3NZk6DbA==
X-Received: by 2002:a05:622a:307:b0:4ec:f628:ea6c with SMTP id
 d75a77b69052e-4f01763efe1mr128979461cf.48.1764901802611; 
 Thu, 04 Dec 2025 18:30:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 10/14] efd: avoid overflowing ring name
Date: Thu,  4 Dec 2025 18:28:19 -0800
Message-ID: <20251205022948.327743-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

The efd library allowed table name to be longer than would be
safe when prefix was added for a ring name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..b4ea8fdf33 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -36,6 +36,9 @@ RTE_LOG_REGISTER_DEFAULT(efd_logtype, INFO);
 #define EFD_LOG(level, ...) \
 	RTE_LOG_LINE(level, EFD, "" __VA_ARGS__)
 
+/** Prefix used on ring name for hash */
+#define EFD_HASH_PREFIX "HT_"
+
 #define EFD_KEY(key_idx, table) (table->keys + ((key_idx) * table->key_len))
 /** Hash function used to determine chunk_id and bin_id for a group */
 #define EFD_HASH(key, table) \
@@ -527,6 +530,17 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 		return NULL;
 	}
 
+	if (name == NULL) {
+		EFD_LOG(ERR, "Invalid name '%s'", name);
+		return NULL;
+	}
+
+	if (snprintf(ring_name, sizeof(ring_name),
+		     EFD_HASH_PREFIX "%s", name) >= (int)sizeof(ring_name)) {
+		EFD_LOG(ERR, "ring name '%s%s' overflow", EFD_HASH_PREFIX, table->name);
+		return NULL;
+	}
+
 	/*
 	 * Compute the minimum number of chunks (smallest power of 2)
 	 * that can hold all of the rules
@@ -698,7 +712,6 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
-- 
2.51.0

