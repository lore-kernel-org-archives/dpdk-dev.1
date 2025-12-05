Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114B8D2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 695F540A81;
	Fri,  5 Dec 2025 03:30:03 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2378840697
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:59 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8b28f983333so169781085a.3
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901798;
 x=1765506598; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kl+nMGCbzsY7wpBsW42ipYcEgPWsUOOMfA0AdYbFZfU=;
 b=wQ6TZrHfSEklUE17iz1IoqNjqdZQVy993NTqKDaDYM3rseqpLdZ8YCxEU52V8ooeEl
 DlT4HpHfemZPs0RNDBBpMAVEYAmIkvxSKe6SGkE2HtD6HYikHaWlt0k346hua/PvEQEr
 C0ZAykjD8M3cxITxCewcOlRAgAIDEw1DlyXENSsI9VZ68Gbx7xe/iEpFFLfGsdWCdi8i
 BIqO4Dlkxa8D2w8XEJAqB3g1f6CPOWuIPGrEkzMXODhXlRgClAu99uTTVF0xBY0Sy3rd
 /jydSgTlc+Cvfu/WQRCvhiALLw+Qmi6j9Q5NNSCtzRIfF74sbCavGqVegwdLpV0jOhMt
 smsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901798; x=1765506598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kl+nMGCbzsY7wpBsW42ipYcEgPWsUOOMfA0AdYbFZfU=;
 b=ZZ9ISc3Ut6cKPai6bJzS+E3/kl2L7JyHYAk8YifYtZ5gVW1e/uICfzbLsAb++CS3jq
 TozSiyMwNmVLOAFCp+go8nWeOGqEgzqpoDJGSLE+3Z2ATK0hTj7+bKDilm4uvL8tcvFu
 DAHQaUreRRCvfZmZB3S0DGhD7F/815p3mt5gnAK8XfCcQdltUjC9MlxCPfNlCbkA6D9U
 rKT4sMQJl86Q7Fnkqw+/JcAC04/FAPyuPoLGE9sL9vjYO/jHF8WmwLGafPh2p/sKdnSp
 StUCHMWXnAWDI0EHSYMLVqQUUfgAnboeymEOrzap/5wug/sA4Cbb+fsgFQ/X1moHMkf5
 qzFA==
X-Gm-Message-State: AOJu0YxgXA62ykhA1E5+wMjFZxeW63g8rIgeDnaIEVT98F4V4DippYWO
 Q+GAXTMXmu6G5RhG9dxfK9GJR7L2vmNASluo8wsgaaTLzv3fJ7YMcKwahPFXNxeivs0hXokw8V+
 KFimU
X-Gm-Gg: ASbGncsXXbH+X/z7F8Wc07DGFwMpKEW3HD2142kISv4m7zjrKYqvDznKaaBpHCuSwl2
 /PpobBpHOGHBAZuGN2VGnTbheomm3fN1nB/MbtGJ0LE1guZNeV/bnocCO5IaDETeEWUIUm775Pe
 40v9yiljdqGUquD0L0nFfrFdbJvdUDBNO0P9bupK62pFkbOKaqdAf/WNRu80n8PaV6JA1yuRC8M
 f+R9u+1qEj7B53Og2NxM/BejEH9jegVZ/Om9TPr3lUbqY0yNOvwfwsXfvGn1JLo1uoxAhQ+CHi6
 yNiZIu4KV32Qrbb6rLthtE9uT5DjWB44XJ9qET2X2MijVbYdAzSyksrCU3cSOoDYUZuQLcR4Q3f
 IuptfZICf8BTlq1KBeiNLsn1mokzCjycXCsv+CE4Lz4DqGklOTmC1lZyzU2h0/h56ST+KBDi0FT
 3Q04aLqFmO+LSdVa5xX4LRLjHOP2m9QUDqZUNTpHaIDOEP5+rjSw==
X-Google-Smtp-Source: AGHT+IEFNIUjBxKw3YEeqGBIcPHdHkYfraSwAklhwQyd0DvER9xXuQuwZ5vo2j8tGwcG1F5HOwVsZg==
X-Received: by 2002:ac8:5991:0:b0:4ec:ef20:ac52 with SMTP id
 d75a77b69052e-4f023ae3483mr84476971cf.79.1764901798388; 
 Thu, 04 Dec 2025 18:29:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 06/14] eal: warn if thread name is truncated
Date: Thu,  4 Dec 2025 18:28:15 -0800
Message-ID: <20251205022948.327743-7-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

