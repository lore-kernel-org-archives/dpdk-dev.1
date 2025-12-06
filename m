Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145FD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9EF240671;
	Sat,  6 Dec 2025 19:44:40 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id E33364066C
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:38 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42e2e08b27eso1384197f8f.1
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046678;
 x=1765651478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=Uxatzkf4pUOlB81eWHy2aXJfjDp6rIyRIhdFffqiBA1B/kYAK/uH2ovTnboD32GdRF
 LB8JXGm5CRIaGbJfb3lvfrPH9uSiZ4Jtsq6sdkgLGsz2gnv2tnmMTz/3LtgITdTrpanv
 QB1srD9wgOJKMCzIeNBCq2gm71n4O9XrAMkQo4dpcJT5xNPSBUiepWaii1i3TFjuwUqB
 6/jIHv5lH7qJ2PTI+PQ+C01C9RQVvZy2Wbf9m0b8g1LH4Tp8/ZEQgotzkc06UZ1OwQPr
 VIom7AOFrb1Td8Y0sAPrkerXkZBTDlASOeja+BXd5bthXHLE3nk4bJFJV0o/cspSInzB
 5+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046678; x=1765651478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=uccMJ3rEEm529AmDkESyHyAs4yonwvzlaW5jnQc+OSOpCA7XO7alulGSNkxHbB+Tk8
 GIdw7CpYUAhbX2yd8EAJ+bvqi3/cPilCQx2gMF9uvCsR9A3k88xn8avua6ZHMEev3a++
 Z0fyPUmYmLIdMVmTKHDrPsXP53zB7U35TWboAfVyftVJw/fUAUgThyts+k+wiY7AV5XC
 D31sa19S+SNzqZLE49rLJJdf90O7TpeDOqSSM4rf/Rpe8Dc9RYI+J8YYSxizbpj8OirQ
 +SI4o5u5Adh8ib2rbNE22AoST/tPgJPnAQ5FCagGpGBPogjIiURWuB/U8R2VFJGfkZj2
 4mJg==
X-Gm-Message-State: AOJu0YyLnKyx8T1LDtWae9dxEf4on8jPbTpLywLq5SOHCzzmHy13yVK9
 l544RQ11PA+4bph3ZXByIauTLxhChUkHQuDG/MopX+DuNi1ZVHt+yD55UEM/uBwCAqmfXZGcXdG
 fJ/7B
X-Gm-Gg: ASbGncv5eArFpoRWj6xo2xuaRKUHH8jbLlBA1mZ6csEsdpMYkDlyFcJgmKESZwY0x7j
 N5GteOkhdwWMpLnnXb7TTKfPWdejHA5zhBfyMj7ZFQTWAqFfHLKQO5AQrOokHQsIUERyhpPakNt
 Q1F2WLSFzI3f0sBByAMs54SsAAso1zZlylCEp0MTr6ZqYzrhDNcrcxjkbnZHxBNO5ruzEXAjaL0
 xILb2ka2coKHJtbNwLUP2dEBIpGMo+DG+0zkPh9iiVFJQc1U5gNJrk6g7R5LE1gCYMGcHZytoRA
 pbe7UDEC3utOaF58t2iNdn4X3okHJ2ykeAmh14QE+ISm129a8LaKLb7ufE+B8rKgF4VAYCleWIE
 1pQ0RjMsxCE+Pddi4bf4RFnf41P3tNxYAK4P5bmMHexNOlLNU6+xqCS0S1D3lu7XXZQxymJQEiy
 acJBiO8fs+TzK5djsMm4kO8x91DuoFgme9VhX5AiUu0+zlsTSRMg==
X-Google-Smtp-Source: AGHT+IGfeD6z3wY2YtX4hO0PXTK3t6PaDdp/y+LE9X74pFwXRGZhYJ3FN53MymPYJ0dSoCIR1g9isg==
X-Received: by 2002:a05:6000:2905:b0:42b:5521:31c6 with SMTP id
 ffacd0b85a97d-42f89f63592mr3358833f8f.54.1765046678541; 
 Sat, 06 Dec 2025 10:44:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 12/16] eal: check tailq length
Date: Sat,  6 Dec 2025 10:43:13 -0800
Message-ID: <20251206184410.542725-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_tailqs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..7502836c6d 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -67,6 +67,11 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
-- 
2.51.0

