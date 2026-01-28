Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D1FD46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE68540A73;
	Wed, 28 Jan 2026 20:47:39 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 85F5B40A6E
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:34 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4327555464cso197640f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629654;
 x=1770234454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aOSKtSsebtNx9yW6ptSEKS1EkRxFwU7gQGqCJEnon8=;
 b=XhnieLzN7WVQOGcBCP47Y0P2SH8CSDantvsf6VUqNusURo5aaYfdCSPsx5LBRhPmkO
 XAnB+3WiaDY2BQU/xOgjXfxH5RuKFiC5kBpEsH1f4Vh7AaATp5lX0PVaCInSY382I5iK
 Zp3k6QwiB+1Qk+ay0rrxVEgHmBvSUApC/vuU9RMDujuWZTRbMJpUydszp7soGST7Ts7E
 pclcDcztAO5+vYD6HpSnsDDogZS9e49enxtp+hXNc1BJoTkG3cVmdUm2MYOX4TTx8AiR
 bGknzdZReH/O5XIMWa/zxL6XOEwi/LUf4Edgis9FHWmNsfrsDk7lRb+tawF9tRA043oK
 bhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629654; x=1770234454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5aOSKtSsebtNx9yW6ptSEKS1EkRxFwU7gQGqCJEnon8=;
 b=RxcmZmOtILNqe/QXiU2Ut6NOcpbhZ5kkDHPYWRQyxePAYB2gxNfqQ289bjOjT5SHZH
 T944YbOkFuoVYK18YfUDAf9faWsxa63pdgpIp8Qz0mh7SDvlIpVvum7OnLVIZncQPat2
 H9K1GmF43TsFedm/ePQEYNLajZzPCCdfz0pbBErc8dgt7qEk11i9nMZ1lrtdolgnpSAc
 nPVMWSu+IGvnWq8hi2YGYELKYOqdKXlOqBnoSkB0kGft/ZGzIuFDfRBfsZx1F0lrncey
 /7uctNUfLzT9jTo3s6FDvmixCQ/mVORGj9+iUtRaUGjDI9DH/yHNCeXiy6H5H65ppQyp
 bjWw==
X-Gm-Message-State: AOJu0Yzb1JIFo/9TWLyYx0QWGv3kyzJKc6AhStnZ0Nop5YakzaPunrG0
 0+t9LEvJwfNDOhFImYnVdfVw0bTCp5QvhJGxSuKncAitJKoHWMD+dr7fhL/6v/DDmz/BkK0E+XZ
 ZFBsn
X-Gm-Gg: AZuq6aL9NR4/4oFo4WZJdcuIzBD4uEYQpcDtpQVTpk2zc5k5rJnwSGEQNCuV2BEm1rJ
 Jsh5hx8/UWoYC2FKe5w2DjQZO7/IJwm5slDgrLkkhqCrnUYSPbH7m1etQhEOXl/FDNAiD2htitm
 4IlyarNLVOP/NWMghN1hytHL2w0m4Pkht0EmEGe+ozvIxYOGIi6hd7WjaGlq6h5FVK5oxDq2h7M
 R1bQwZXGvse9qdlHDeJlXGNsCenSrPdBFZXjkQPJ4YuBRB7TlobIIEnJJajN+3ls69vY4GMT+0H
 silD8W3eoidQoEVcxnbZ6UHy290LhkcCcr8U21bozexEXkqbROAqlhg2RVOQdxPLqvIQBjFXDQS
 UetClXezDdiSBB7BcEVQe2tWs4sv983cZog/BsdT7Hpoy0NsZPr1kGgDR6w9j1nj5G+XR6bbGP2
 vpRq37HOTWwJVtPgX5XT3DlSyH/WEmucFZm95x2zNVV79IgQE6ew==
X-Received: by 2002:a05:6000:401e:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-435dd0b822dmr9454228f8f.32.1769629654116; 
 Wed, 28 Jan 2026 11:47:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 4/8] doc: correct typos in switch representation guide
Date: Wed, 28 Jan 2026 11:46:03 -0800
Message-ID: <20260128194722.480862-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

Two typos corrected:
- "according on" to "according to"
- "physical of virtual" to "physical or virtual"

Correct minor grammatical issue in the switch representation guide:
- Add missing article "a" before "large number of ports"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/switch_representation.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/switch_representation.rst b/doc/guides/prog_guide/ethdev/switch_representation.rst
index 2ef2772afb..3d9d8d8d60 100644
--- a/doc/guides/prog_guide/ethdev/switch_representation.rst
+++ b/doc/guides/prog_guide/ethdev/switch_representation.rst
@@ -19,7 +19,7 @@ managed by the host system and fully transparent to users and applications.
 
 On the other hand, applications typically found on hypervisors that process
 layer 2 (L2) traffic (such as OVS) need to steer traffic themselves
-according on their own criteria.
+according to their own criteria.
 
 Without a standard software interface to manage traffic steering rules
 between VFs, SFs, PFs and the various physical ports of a given device,
@@ -84,7 +84,7 @@ thought as a software "patch panel" front-end for applications.
 - Among other things, they can be used to assign MAC addresses to the
   resource they represent.
 
-- Applications can tell port representors apart from other physical of virtual
+- Applications can tell port representors apart from other physical or virtual
   port by checking the dev_flags field within their device information
   structure for the RTE_ETH_DEV_REPRESENTOR bit-field.
 
@@ -124,7 +124,7 @@ thought as a software "patch panel" front-end for applications.
 
 - For some PMDs, memory usage of representors is huge when number of
   representor grows, mbufs are allocated for each descriptor of Rx queue.
-  Polling large number of ports brings more CPU load, cache miss and
+  Polling a large number of ports brings more CPU load, cache miss and
   latency. Shared Rx queue can be used to share Rx queue between PF and
   representors among same Rx domain. ``RTE_ETH_DEV_CAPA_RXQ_SHARE`` in
   device info is used to indicate the capability. Setting non-zero share
-- 
2.51.0

