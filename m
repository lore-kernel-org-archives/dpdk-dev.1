Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B10606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F6EGso2Y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79B06402E4;
	Tue, 10 Nov 2026 03:04:09 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 922CA4027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 03:04:08 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso799242a91.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 18:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794276247;
 x=1794881047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=07E7z+deuIGAtZxocoEmpy930ZaJe1gdf1fBKrN6tIQ=;
 b=F6EGso2Ycp3K4fmDO7WlY9RyTTOiZz1g5fpa70YQPGTtMWBGVQ1Ub9z9ad0tUnMd3k
 MzkPCIS8K4MvbolxIdLvYo6ixp4JNH6ATpe+1ivoMndIQZ4/RLiRlUKOEx9Y3quY4KsZ
 FxvsDWhmOIu4cx7rsWJF8pVU6qhnhJbKDMmONU35Mih8pQ4HgtyqXf73vYEgD9DpAtW6
 28d+Vw5OSPb2eRMI/JdYAEia3jbtkQgzqY8KNmaqNQ/YpMgFYtsDOrztS+Ml5O8QJZ6A
 tO1rm11jXBYmP+RBjdIAr9mPg1ytU32eqeHq58d5eA5vRJg6fdA/IxEjDBr4iwoqWy/A
 oxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794276247; x=1794881047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07E7z+deuIGAtZxocoEmpy930ZaJe1gdf1fBKrN6tIQ=;
 b=BH6sqfnw71lg3nGij2zWePvONvucr6c+Kssta5U6aYZCYLShk6XlfDbjSXAFXZx9u4
 NMvldpCTfWOlPKCESOuzQsfQf8JaJjFVQlxbpmxi8cFAgZvP3gmVx2aFXxXXIey6MDoi
 iTT5yr7GsREmGW+9Ad49yE3ajMhH6S/uHgsUAXPu2WcKRzRRhdHyX8PuEy03gg4J1PR4
 TXxBKN8DCPXju64Ukb8emckiN/P/6DkuKvAjMw/eDULYq6l2a1RZ/wiJiQJwvSGjQrpO
 FSbFfEVgl+vofzxA4lWLlxu8ES/XXaUQ+ExjTl346Kcsklra33XBNNNXYqIt9eOoFSqd
 BFIg==
X-Gm-Message-State: APuU4Z/qjoUxITV2tX7vOXyrOrWh8or4sQAmncc9YU+PfNlJKfYnNToV
 OSHK7r7TcLuLT9U2Xlqranx0YwuzjqQZ1+XSp+uSW6Ra8iRhw6pM2rGUeEUBaFyH3J4lotqDPzA
 I68sPQSg=
X-Gm-Gg: AYBFou08hdyr0ixoflKl0uVXlSuhu742ZQyqG1H0wtXkxyC7HRJ9qP43kCQVowpXR8U
 v4wREVIOtvze+gBC2jgGGkaRQij1MR4J9hrOnzQLfCFKJvK3TDp5KBXL6anyAZT6EOmGjAxT1UF
 tn3LFXnFkr5QaimEXfjdG646p27n7o8PrNWSfEWtsLavyouEClcsk5qPv2T6v/iaZ8wtHXHbb5f
 J/lw4tFgRatxM21TMt2KsQK1vAPhVajBTW9PTV45tsROb1L0rkocYFjrbQrpPcp0ygs+K1osT2y
 6PbuDfo4ObKOKRzLSg6LeSYwFCcToVdZmzGL5yAlAJlcpwXePl48c2lYDgOtqTOQ2gAi48fnfsP
 EbqiEEFrp3LzQTpBLxfDuytJ+y7YIvJI1ZrHdbNFk82n3j2f7/WYOO8jYz9u8h/ZPFaWDEkc1oa
 FQmadaRcCU4cU/3iWNjBzA52GBHMkUr8Kkm7OeFPrFFFwQqogJKkqfGmXZ4KU7W7q80GLiGpl6z
 Z8GaZ9Dc8um3CDbKt4zH2A+sGVeUn1fZWDqI2zcn+5sAUGTvbCZCMyi9j32eLOB5MlHRrXrjpfy
 nwDfc6uxVkWqY7YyG4X17rnOjlMnNNjPh4KzwGAZJVVmf+snQ/FlojQc6posI7tFyrbzBkIeze7
 AFgYv33oVLvM+Zg==
X-Received: by 2002:a17:90b:3ec5:b0:39e:59a0:46b5 with SMTP id
 98e67ed59e1d1-3b166cae968mr1683644a91.24.1794276246882; 
 Mon, 09 Nov 2026 18:04:06 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16775d010sm1737343a91.16.2026.11.09.18.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:04:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Michal Jastrzebski <michalx.k.jastrzebski@intel.com>
Subject: [PATCH] examples/qos_sched: fix build with LTO
Date: Mon,  9 Nov 2026 18:04:03 -0800
Message-ID: <20261110020403.419111-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_cfgfile_section_num_entries() returns -1 on error, which is used
unchecked as a VLA size. With LTO gcc inlines the library call, sees
the -1 path and fails with -Wvla-larger-than.

Return error if the entry count is negative.

Fixes: db935d0171dd ("examples/qos_sched: use librte_cfgfile")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/qos_sched/cfg_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/examples/qos_sched/cfg_file.c b/examples/qos_sched/cfg_file.c
index 3ca06c2ff9..e73d9f7cdd 100644
--- a/examples/qos_sched/cfg_file.c
+++ b/examples/qos_sched/cfg_file.c
@@ -438,6 +438,9 @@ cfg_load_subport(struct rte_cfgfile *cfg)
 			}
 
 			int n_entries = rte_cfgfile_section_num_entries(cfg, sec_name);
+			if (n_entries < 0)
+				return -1;
+
 			struct rte_cfgfile_entry entries[n_entries];
 
 			rte_cfgfile_section_entries(cfg, sec_name, entries, n_entries);
-- 
2.53.0

