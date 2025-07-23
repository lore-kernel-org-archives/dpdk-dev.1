Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13868C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10A4840BA0;
	Wed, 23 Jul 2025 15:11:10 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BC77940B99
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:11:07 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2349f096605so76141005ad.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753276267;
 x=1753881067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1Fn+BpV/lBpkBNymNKkD0FjlFvW9o40VVxaZUaxgWQ=;
 b=oO0l0k69lR2tGB34dPkHWvbpVaCeC1ss0Ky8ze4lLs6+yQl2ksIQjhatGFQ8lLyuAW
 6+6z3tdz4OhQAevSTo/keDJoTMNBJO7m+TyhSHcXeNFtYU9X+CLrIQ8rkyqAgd4Sm+qW
 fMvS5IsOJGNF9NlBErJ8tbhuegiDt//va41cUiivMh1CsW7azmjpn2bK6lxy+YVBP/rA
 mfBVNNJD9XDtbEZv/svP8CC2CakHtJTiOhvpiWFYyvRXKjcKeqWzDO9VkoUSJqwLPaVO
 f79EHTJqZVkjbDiux/Z6jZI+PtKe8nRBOD+/JJnsvg07biRSi89gy1HDekomASnSniKd
 97GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753276267; x=1753881067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1Fn+BpV/lBpkBNymNKkD0FjlFvW9o40VVxaZUaxgWQ=;
 b=iqPwkyf+fKY9YZSEK0+LtpvXyZptJ04hGiEnINdbVXHid+pXGIp7bcV5cj7npk3y6l
 DsHRAnptVP9aNo7ip8tXzzL3K4IAcULQPsz6R9lYdGT8k15yksq9+aafthVslgRuPrWp
 DZ55y2SNqIf5m/CuA6IzVhYIgX/gY1LgcesanBFnymkzTBMtLGSc7k1ouTUbp4O2SWPe
 dLDBl/084lrfLhLDQIZ9M074QStnFH+VvTDKKXzxJn0LXzvvZUtyW4wQav5S5bZYcypU
 NPp70mmQq/vKYsv8fkJElHnszm001EhmjzJwpqT4fioIoPqIpNWBRpDAag6eAZEO+2Ca
 oMPQ==
X-Gm-Message-State: AOJu0YyZ2d3xCNrt05LMeBzs1T/b28SLe29TE2vt0WMf0p8xYyUDiJsL
 aigIUlPNeJG2VJUQu8zNbjJ4PlFyYQcLj3Hoy3kyfRErn9KNB+pHT1CVUkSC/eoE9bQ=
X-Gm-Gg: ASbGncsx8CmRt5vNAEe6i7ikVQWPSsLbN0gNZ0Y8e1mM5p2ESi5/iqXn+6EAW7Yfc4a
 RTfuk521LcPjlmZJkSttQxotAnb7QhTKPM9qi1tNYiZl+1HTAgDB/xYbiQDkYC/FETtl5ycSzS7
 yefjNbcFHnWbxJIsaSrcXX3V0hMZkIb+m3tOIUuIvy5fiwwS+fCg2S+xgo2Pl7I1/QhktFruDZO
 h4jn0e5ZLrKxV3k3oCP7UaJi5R2pLF8gUShAPfYpl2MyS6EIUo0IinTgBhaOxCQRVHHA/JcuSwK
 2lN3d70hKzkIsArFsW1Qb0ir5Qe6s/n5YtSqE50JlwQQDaj78zamqrv/SsCH0CBhuraWqEqoCu1
 VMtRYyPbY84/8XXN3xtvwDsWS3O1eub8MxWtf5vtAQ8Fp4jDC
X-Google-Smtp-Source: AGHT+IEz92xfZNQNAbfsfwzYYsaT1RswUvqn7AyrIowSs5s1GhzUtFN5AGNsj5pNlnpWpqDasjCdqw==
X-Received: by 2002:a17:902:d603:b0:23f:904b:a748 with SMTP id
 d9443c01a7336-23f9813e760mr40286575ad.20.1753276266840; 
 Wed, 23 Jul 2025 06:11:06 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6d23cfsm96232615ad.135.2025.07.23.06.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 06:11:05 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Date: Wed, 23 Jul 2025 09:10:49 -0400
Message-ID: <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, directly accessing 'dev->data->dev_private' can
cause a segmentation fault if the primary process has exited or if the
shared memory is no longer accessible.

Secondary application not only breaking on device closing,
but also getting segfault when we do "show device info all" from secondary
after primary closes.

This patch adds safety checks while using rte_mem_virt2phy(), with an
unlikely() branch hint to minimize performance impact in the fast path.
This ensures 'dev_private' is still valid before accessing it.

Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/ethdev/rte_ethdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..343e156a4f 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
@@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 			port_id);
 		return -EINVAL;
 	}
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		(dev->data->mac_addrs == NULL)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
 
 	rte_eth_trace_macaddr_get(port_id, mac_addr);
-- 
2.43.0

