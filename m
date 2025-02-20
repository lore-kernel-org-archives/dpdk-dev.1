Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF77C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA0DF4065A;
	Thu, 20 Feb 2025 17:57:10 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3F0A5402ED
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:07 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-221050f3f00so25274515ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070626;
 x=1740675426; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzSUGu+G5sOroUww3h77G3MFLaAHCauGYtlx26Wa1nA=;
 b=jSHkHTVLkII398XLdGyLAA6pFy2vbCjilfrdaGaaM2uixRFeijV94icOAede3gFswj
 vs0KeAlNkxTjYUhafIMiu7dlIN/1R57mCRzsnBnrr3P/EAfuYRZpgdj9kSWjB3rfJ+yT
 z5+wFRu18CWuRwS8WloxeGHmIEXc2BrJ1Mh0J2MwSNjAOFgwIyCv/I12UkTOrJu3L6gg
 9ZzO0bgXRcI/wEmd0+Of5d2b/zovJbm10CDsPLQoEZ6bUr2REPYRCzhbTMViComDPVie
 gnhXUpZteCzvRJlpVcAU2HCCHpnmXHSnZ5SvUMh6UkrR140VG9u+TN6ENO/jW0tSf+hS
 06Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070626; x=1740675426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzSUGu+G5sOroUww3h77G3MFLaAHCauGYtlx26Wa1nA=;
 b=oSmAxVXPdS1OcSNCpJI7oju6oVSTlkbIs8cyxzfAFM7IaXp6VIs49bRgseK2X/BK7Y
 kYs0jUDsUhdcozCTHE+YeVN3DJxH5LlsXXFcoW3eBUGhmD26uB39VtZeKLQcosEwwGBb
 koGP0ku1CM8ZeqFaC+MLfTeql05SdH7emLBHbF1Yf77I6WIWVVsjllkChB/pXH6T+Vz6
 5ru9zdaavQFuUP7yOs2rj+YciaZNklVQv9Mp/btyJRqnnxJX4xSS00e3p/MGrUGCxJEJ
 wZ/aFdldlCulOtEsX3Oqw2m7d7xekUtwSB/oA9WZ8fRElSvVwMyQY4RCiJncuxTKUNkS
 tR5g==
X-Gm-Message-State: AOJu0YxmF9D2dmKoi3vy41rtMOSmlCr8GJk+CMeM9lU0yJ90CQ+WRvuI
 1EnYN8dTfQ7+M4nkXrUm/X1vrd575onOZeiLUTkbE65PE5XEWG1A/UOsBDSrLdjOZdXvQiO4ZRB
 G
X-Gm-Gg: ASbGncvdKowZvGmlSgaacX/i1XHpyPvShVAfYaAi+WUK7YqDFftKnYBhws/W4dk2Cb1
 j7KZQO1pgCZnzUcKWcswZGHfAOwfY3yrq17AbSXVEhOBpoEsGk8PcaE4dtNeinxfWc42qXy/VHh
 KLLBvvtCF2+hfcJIhwo+3dKJ7Oo4NGNwBxw8DLHniMCmqocV/SqWUf+YPU3s4+lyQzoLLbXDNyG
 rOi81lWrZgEBWhW++Uq0uqo1Rg8K8fM9KrP88zusHMobM4wXAQJ5ASbTeHxaauuvmx+YwQGgp2P
 Vd3y9NqoDkpJrrIvuKuBz+xCvxReoGj3u9HPb3dLdW4OYxKTuluh/RY1Zg69KEHt97HU
X-Google-Smtp-Source: AGHT+IGTV+p/VuGwlk802p0DmQPeouG5X5th1D+fBJ8C922tPuBFJ3h/x71DCQEIADWmC+o4T5xqvg==
X-Received: by 2002:a17:902:e546:b0:216:5294:619b with SMTP id
 d9443c01a7336-221040d82e7mr382259375ad.47.1740070625905; 
 Thu, 20 Feb 2025 08:57:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 04/14] net/ixgbe: remove unnecessary dereference
Date: Thu, 20 Feb 2025 08:55:18 -0800
Message-ID: <20250220165644.16421-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The expression *dev->dev_ops->vlan_strip_queue_set and
dev->dev_ops->vlan_strip_queue are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index 15c28e7a3f..5a7d66d9b9 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -291,7 +291,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	if (on > 1)
 		return -EINVAL;
 
-	if (*dev->dev_ops->vlan_strip_queue_set == NULL)
+	if (dev->dev_ops->vlan_strip_queue_set == NULL)
 		return -ENOTSUP;
 
 	/* The PF has 128 queue pairs and in SRIOV configuration
@@ -310,8 +310,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 				  RTE_ETH_64_POOLS;
 
 	for (q = 0; q < queues_per_pool; q++)
-		(*dev->dev_ops->vlan_strip_queue_set)(dev,
-				q + vf * queues_per_pool, on);
+		dev->dev_ops->vlan_strip_queue_set(dev, q + vf * queues_per_pool, on);
 	return 0;
 }
 
-- 
2.47.2

