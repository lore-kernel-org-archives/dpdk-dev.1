Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA7C98321
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 19:37:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDAB940288;
	Thu, 24 Sep 2026 21:37:50 +0200 (CEST)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mails.dpdk.org (Postfix) with ESMTP id 9069F4026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 21:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1589; q=dns/txt;
 s=iport01; t=1790278669; x=1791488269;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=b5k18VCGD2sNEg4fyDXywca5t/TaJj5o3WBjAVaI1Xs=;
 b=Lp8i0cpYwCHnZis3cmDFRREAlPj2D9Dhe61co9A2jJMxMhav3TG0RKgA
 BiyJhi+zvVcAHolPFb3UOK+tOxpFLiNP6hdW6MCzTje5eCwRqVrGSCsg/
 zPijjjzIi49P9hSm9adfg6iWxNiCxiTzBPo50X5GijbwQJYRUyVZXt90z
 Gpa7i43BARyVk7RG4tkB7knAAhxKH7jSafPq3uR67IzNRzeRkOelYlwt9
 EnQRSh9MqIH127gdB0MaqXeyQwieD5F+vo2CG3p+e0O5yxhb9po4S3Tyg
 TKDsp2ZdL5dEPDnhkFJEjZYig+z40AEJqDq9i9l8mQn1OpSFXMv5HB2T9 g==;
X-CSE-ConnectionGUID: yWEydNMASaSxQC3X1Dp9rg==
X-CSE-MsgGUID: zW1gi9l1SDuz74gos6xsXg==
X-IPAS-Result: =?us-ascii?q?A0BcAwAye7Vq/5IQJK1aHgEBCxIMggULg0xhQkmEV5Fzn?=
 =?us-ascii?q?h2Bfg8BAQEPNxoEAQGFAQICjgsCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4Thk8NkBUnDwFGNQImAkiDKwGCdAPCQXqBMoEBhH7ZSoF0F?=
 =?us-ascii?q?YEKLohfAYFxhAiEfCcVBoFJRIFHgzeELWODDoJqBIMcEpUbCYFBHANZLAFVE?=
 =?us-ascii?q?xcLBwVhgQUDgQZuMh2BIz4XL1gbBgWBHYEJBBOCGiMZNnqBCV6BKylgARAXg?=
 =?us-ascii?q?QmCBwKCVIIBAgFJQw4HRVMJJUEKEkcmIggSCQETGjALgSM6QQkoC209NxUZB?=
 =?us-ascii?q?D2RIh6BcnMBMEoUBztklF+Dfo9/n1qEKIwilVQzhVulEpkIqUOBaDyBWU0jF?=
 =?us-ascii?q?YMiCUoZD5FGhy7FZSg1PwcCBw8CkXQBJgeBTwEB?=
IronPort-Data: A9a23:DOCq5aLRRQ0h99tlFE+RvpQlxSXFcZb7ZxGr2PjKsXjdYENS32dSn
 zEfWGrXb6ncZGf9fI0gaY2190oEsJDTm4RiTgUd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH9imQoajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1/M2wnMas9091+OnF33
 qcocRwVPwqM0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBXLAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMnwsYDUXUrsTIIgineylrnL+aDZf7lmSoMLb5kCDkVYggOK0aYe9ltqiV/oMkUfJo
 jv903nrXU0VM8fB2SG1/Sf57gPItWahMG4IL5W0++BCjEWfxSoUEhJ+fVGhvPK0zFS/UNJWM
 UAP/SwGrK4u+UjtRd74NzW9qlafuxcGR8FQGvc38xCW1qfR+ECSAW1sc9JaQNUisMlzQXkh0
 UWE2ou4Qzduq7aSD3ma8994sA+PBMTcFkdaDQdscOfPy4OLTF0b5v4XcuteLQ==
IronPort-HdrOrdr: A9a23:LOVp/6OHk/6m1MBcTvWjsMiBIKoaSvp037Dk7SxMoHtuA6+lfq
 GV/MjzuiWbtN98YhsdcLO7Scu9qA3nlKKdiLN5VdyftWLd11dAQrsO0aLShxv9Bib56ulRkY
 1kc6R4FZnMKGISt7ee3OF9eOxQp+VuN8uT9IPj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AJg+cEmgeTpta0ut1AGbtUp0p8TJuY0Lw3Xv2Bma?=
 =?us-ascii?q?DAF15cZbOeQa84PJ+nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AVRiH1g27O6xq8r9HV+owx2v3VjUj8Zv3B0Fclcw?=
 =?us-ascii?q?9l9SWanB/PCzDnC+HTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,121,1787011200"; d="scan'208";a="852982115"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
 by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Sep 2026 19:37:48 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 19F411800015C;
 Thu, 24 Sep 2026 19:37:48 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, bruce.richardson@intel.com
Subject: [PATCH 0/1] mbuf: add optional dynfield3 storage
Date: Thu, 24 Sep 2026 15:37:47 -0400
Message-Id: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-09.cisco.com
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

This patch adds build-time optional backing storage for the Dynamic
Mbuf Fields allocator.

The new mbuf_dynfield3_cnt Meson option reserves an additional
cache-line-aligned area at the end of struct rte_mbuf. The default value
is zero, so the default mbuf layout is unchanged. A non-zero value makes
the area available to the dynamic mbuf field allocator and to the normal
dynamic-field copy path.

The enabled configuration increases sizeof(struct rte_mbuf). The release
note calls out mempool/octeontx as a known fixed-size assumption that
needs follow-up before that driver can be built with a non-zero setting.

Validation:
- devtools/check-git-log.sh -n1
- devtools/checkpatches.sh -n1
- devtools/checkpatches.sh on exported patch
- devtools/get-maintainer.sh on exported patch
- Meson setup with default mbuf_dynfield3_cnt
- Meson setup with invalid -Dmbuf_dynfield3_cnt=1, which failed at
  configure time with the expected cache-line multiple error
- native Meson/Ninja build with default mbuf_dynfield3_cnt
- native Meson/Ninja build with -Dmbuf_dynfield3_cnt=0
- native Meson/Ninja build with -Dmbuf_dynfield3_cnt=8 and
  -Ddisable_drivers=mempool/octeontx

Randy Tice (1):
  mbuf: add optional dynfield3 storage

 app/test/test_mbuf.c                   |  5 +++--
 config/meson.build                     | 10 ++++++++++
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/mbuf/rte_mbuf.h                    |  3 +++
 lib/mbuf/rte_mbuf_core.h               | 16 ++++++++++++++++
 lib/mbuf/rte_mbuf_dyn.c                |  3 +++
 meson_options.txt                      |  2 ++
 7 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.35.6
