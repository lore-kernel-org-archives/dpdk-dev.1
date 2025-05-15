Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2821BC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4814410DF;
	Thu, 15 May 2025 20:33:36 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4484141060
 for <dev@dpdk.org>; Thu, 15 May 2025 20:33:33 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c54b651310so160579985a.0
 for <dev@dpdk.org>; Thu, 15 May 2025 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747334012; x=1747938812; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtFtXM1p/zjRlelxcIx4fdpTN5GbmrbVHbesIta97CA=;
 b=TKjgBc5T7qgP9NEdKX2yyasYs3LMXMGeVm4V7Don1ZXku6QPOYutFlwi+jhrVXpyYv
 74QM3Fmo+5pOv+twn6ZeDQsCf9c8QydT8/6x4ORTzTc9XMCFNoGpfYJ40xFOvLRE0KtW
 lNRDnWmsTwKrfJvzmDb2G1tSUajCi2K68AZdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747334012; x=1747938812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtFtXM1p/zjRlelxcIx4fdpTN5GbmrbVHbesIta97CA=;
 b=frZr6wlOJB8DH9c+yiMAs6Qpg+2aAmU2mxmYnCMhiqWVYh6HbcUV6mWtHFsyNQhm61
 Vim7BbEIXKEVO6K+rn7O292yqKK3+og7IfTovk3AkSIt3tz7EWg0HaIvPgcciP8FnIUe
 k1DPbZc/nkAYE/E+Ap7PKOHhUjY3IiKhfJ9LIESY2cUuKyB9iojJn9MkMx3zr6HVtooZ
 ZAS5DsWC3jnM59IOhaaK03yImVhjHD7XIAdh5YWAG9u/n/CcauGUkXA3UDjcTPfSGArx
 /ZBuemoQecAnK+FnzHeLTNJDq1ZrqYDoPIRyGpYg6yVr90NQ6qu7icBUw+OGCTbmSQ9m
 oDqA==
X-Gm-Message-State: AOJu0Yw1RDDGES0ywJjnRyH4eG7E3Cm7vSGMJWbeHvMy6gY5mBstN3rK
 kT13YBqCrt3seOoetTyaj84yO9WHZ+dCCguSo3hpcuKEfhEYEoZsHHsMzvQMbNhBoGo=
X-Gm-Gg: ASbGnctkUHmd3i+SHCwkUNhWB35h7kIp72TBvopkubsWxQAlQoDGtmno2AF8PowNR4c
 Tu3mAyn6Flz1+a11UST9iodLAUz1G5ZiKumpBB1tGF1Q8YOADiF2JuqO8vCVfxm4NK1Qi8l3fTt
 a7QiS2z1CWMbwWTg0htVgawmCHKRjIFSQegUlCBOH0iNnLMqz+YIpulPPPuqQcotgrt2E2hpZFf
 al68fivAMpsb9Lhd+tH4XEj78fbtc0Hm/EPqB2CmBiayHBK9VeEMSgVnV8fHVRWXeIB8WankCOM
 lB7KGvfrnVPcyVHjoYdAS10XQGK+hXpb0fp6qGnNHWjswgAnDLeuSRpTp+KJ3Q==
X-Google-Smtp-Source: AGHT+IHmeNiQbtF0AT+hO3JEOQU+w8xKbRZkCRjE1tkLlCYwGoJJhYLSx4vfw/U+3mNp6bLABrIIQQ==
X-Received: by 2002:a05:620a:288a:b0:7ca:e971:8335 with SMTP id
 af79cd13be357-7cd46707057mr93114685a.8.1747334012606; 
 Thu, 15 May 2025 11:33:32 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bc7d1sm18100185a.1.2025.05.15.11.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 11:33:32 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 3/4] dts: remove unnecessary capability requirement
Date: Thu, 15 May 2025 14:33:26 -0400
Message-ID: <20250515183327.191912-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515183327.191912-1-dmarx@iol.unh.edu>
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250515183327.191912-1-dmarx@iol.unh.edu>
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

Remove capability requirement from checksum offload test suite
that was not required to run the test cases.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 83879b0512..c9efdcaa1c 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -30,7 +30,6 @@
 
 
 @requires(topology_type=TopologyType.two_links)
-@requires(NicCapability.RX_OFFLOAD_CHECKSUM)
 @requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
-- 
2.49.0

