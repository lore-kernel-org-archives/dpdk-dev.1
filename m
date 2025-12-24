Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DEE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A2EE40685;
	Wed, 24 Dec 2025 23:13:38 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 3450F40613
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:37 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42e2ba54a6fso2727421f8f.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614417;
 x=1767219217; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=WiUU7kueeUurF4VizV+BXOkFfUkjAral9kq7D44W/TmNZIv1FrKaMgwdZxZ2aDgGXJ
 kyAkmKRpo3DbEoOoTBwwcoOwCs+XI7Ai4CniEpjRD3q1/1czH7byUaBHPg/snVUvRd4b
 t1vlbbtH18U+2GtPI1XtdEDJejrIuAfT/M3T90EExqyb/nxmEKWFz4YmKuuoOqGD/hTa
 IUjlJp+ZoxVfDt0GlzKk4XzvJRcvRaZpmMGMKKbgimj7hiY5BHYqDmom+b/K1QKPDS/J
 /yAxwSbjNyHxxb5ZL4Sn8RbZ/UKecdZD2Fks8no8j57Kfhp2C/+9qAEy+g7OftaAOX7k
 XCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614417; x=1767219217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=nlthFYDZWFttjw/brTrRz7GUJXOtAFiHqL3/AX84S+BLHArIH9zkynN9FwENHNKUq9
 dFxYAiJHmSFtbkkOe6U5R7LH9QFxa0aonal6sb7z636NkiqfxgsdjlqvWJVE32WflPqo
 B3MtlvyA3H3I2HiXiaU0UikP7rLpYtV1Hl1FzOOeJ2P/sG2Oh0E0Zq+UuJ11ruLHKFr3
 T4N7qrNSQkT3EYFD7QiMjEWwG4UBKZHg2ocHwGg4XmlgjJ3CVIpuN4wLDGBZLQadZT/3
 S2nmxwgXQd+WuIevHKyM2WabyuWIRNOP288HxnZlpJyKmENhgHXrjoDLIg6LOS/TzLrq
 1SOQ==
X-Gm-Message-State: AOJu0YyNXe1bBMdH501v1+53lXUTT5pZMXrXOHJyimELVtZVgxyWLrKc
 I+zAyRdT8U9c+hmgK+dT3RARQQteLpLJJkeg9UUo7BWawOSf+5Ko9MmmEJWzN/g1gIi/E1tnF2E
 sBREXhuw=
X-Gm-Gg: AY/fxX4hdIYq1eKDSm7IFdPIKKdcSOqlyMC6aclpkJNNxd/5MQ+CEs2XcSc1fyZ8B/K
 YOdqKyd4GHipeH16mxPK80qWa/z1w71eBi8V89HvTkV+ORbb3A2Vjgu+pPaRj+F0pcJUHP4TBeq
 67gq3PwQsuOGB2++rB/jVVhLDBdJ5H7iGBnuVb/T/UCydYqlC0W0dzBT4jlpCCZdTQWf135ZFA6
 DjI9TBRYqf2Z6nhMlZ1z3XBLE0UuRBmDNZKZJ6O5IWF0J3f1jgjHOjzHFFVXwSBQ1tYD2oxAE3Z
 davLHjPmYzNRUk5cxfjJvEAVt9iLSji8A2K6cL+HMvS+KMiALaiAXFRuXV3wsG3GZgMISCixo6r
 yN/QRYj0bCuAejB5DfN1OUKcMErydRr1H4wsVXnTLVqdD+eILHTLELQNOmUZxXokomDYiPCOrh+
 NNEdAlFO8zCBp13rdFZzaJ2S4N2HjNOX8qcMgTw8tpNXy/85sEkxpQAeqC1wgR
X-Google-Smtp-Source: AGHT+IH5JOP1K160YGA2k1rKnm2XefobVFeNeZCEnHnksR9pA6lwPqLDQNkn9H8CEQ6UC8V4rz6luw==
X-Received: by 2002:adf:e703:0:b0:430:f7ae:af3c with SMTP id
 ffacd0b85a97d-4324e4f9408mr17702176f8f.31.1766614416800; 
 Wed, 24 Dec 2025 14:13:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 10/18] eal: add check for sysfs path overflow
Date: Wed, 24 Dec 2025 14:11:51 -0800
Message-ID: <20251224221301.52714-11-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

