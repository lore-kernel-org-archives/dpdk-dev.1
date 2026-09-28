Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1864CA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26332402F0;
	Mon, 28 Sep 2026 20:16:58 +0200 (CEST)
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 by mails.dpdk.org (Postfix) with ESMTP id 8755440275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=2100; q=dns/txt;
 s=iport01; t=1790619416; x=1791829016;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hzb/vD4qY7M67scCXUa2OVAHXsBdXmA3ttxY6PXS4u0=;
 b=U8pW4/4ZlRRLJ5kDgXnSOElNFmVW+iz1v6804K7LzG6RyOaJE8FKKSro
 3xyq1Cf88oITQ6bHqf//hDCyTOCLFDJjjoYDKA+3XO3n0mSwiHNQei/Eq
 XRqj6WdGiHQvSKBENVvsq/MlUgsYVOppKPft90TfyB6oFwBmFyDDj1xJS
 Ld7d3NrpWpXawerjla8ua+1Gl3dFNCc8gdt7gYSLybbObuF9TeZF1ilea
 HvQ5MRt47LN94V/g9X0c+fJjBFX658FzpggiUqScahIUsZeF2zXJd06L8
 dZq2cRjXhzQi5YVeZr2EoSlbaQ5Cf98YYF5DYeOeWUK6U2zIL6eq1lYIA g==;
X-CSE-ConnectionGUID: CvfmqYIPQcm+akWsq4pTXQ==
X-CSE-MsgGUID: 0AUsZNYOS9OgcVw91O1Ckw==
X-IPAS-Result: =?us-ascii?q?A0BhAwAwrrpq/4r/Ja1aHgEBCxIMggULg0xhQkmEV5Fzk?=
 =?us-ascii?q?UyMUYF+DwEBAQ83GgQBAYUBAgICjgkCJjQJDgECBAMCAwEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QoBAQUBAQECAQcFgQ4Thk8NkBMCAQMjDwFGECUCJgICRhCDGwGCdAPCXnqBM?=
 =?us-ascii?q?oEB3kiBdBQBgQouiF8BgXGECIR8JxUGgUlEgRUygzeELWODDoJqBIMcEpUgC?=
 =?us-ascii?q?YFBHANZLAFVExcLBwVhgQUDgQZuMh2BIz4XL1gbBgWBHYEJBBOCGSMZNnqBC?=
 =?us-ascii?q?V6BKylgARAXgQeCBwKCVIIBAgFJQw4HRVMJJUEKEkcmIggSCQETGjALgSE4Q?=
 =?us-ascii?q?QkoF209NxUZBD2RJh6BcnMBLAQoNoFuk3qEG69ZhCiMIpVUM4QEgVelFJkIg?=
 =?us-ascii?q?lmhGRSFPYFoPIFZTSMVgyIJShkPkUaHLsVlKDU/BwIHDwKRdAEmB4FPAQE?=
IronPort-Data: A9a23:k6LQi6w1cygno0/YhvB6t+cpxyrEfRIJ4+MujC+fZmUNrF6WrkUEz
 GpKXWGPM6yDMGujfdpzboi/9EsGuJLdztIwHgtq+VhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHyYuCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4yaT/H3Ygf/hWYlaDJMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJGooM4gBy8dPOGpLt
 vUbFysUMgi/t9vjldpXSsE07igiBNPgMIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bM3WjOX9PYH46tP20h3LyWzZZs1mS46Ew5gA/ySQsiuiwYIKIKoHiqcN9xm+lv
 VDgzkPCUzYVP+KAmGOiq1mvmbqa9c/8cMdIfFGizdZmjUO7ynQfC1sRT1TTifOjl0WzHcheI
 Ewd4CY1qq4a9Uq3Q927VBq9yFaEvRcYQdN4FuQg9gyJzuzf5APxLnMYQyZBZdoOssIqWjsw1
 UeNgtbjCCYpt6eaIVqY/J+PqDqoJTMVJHUPfj4fUQYA+J/op4Rbs/7UZsxoHKjwipj+Hiv9h
 mjT6iM/nL4Uy8UM0s1X4Gz6vt5lnbCRJiZd2+kddjjNAt9RDGJ9W7GV1A==
IronPort-HdrOrdr: A9a23:4J7F8qg882k7ZAKMvXvtlAz+4nBQXvoji2hC6mlwRA09TyVXra
 yTdZMgpHrJYVcqKRMdcL+7VpVoLUm3yXcx2+ks1NSZLW3bURWTTb2KhLGKq1bd8m/Fh41gPM
 xbHJSWZuecMXFKyeDn/QK/D9EshPOD8KyumKPi6k0Fd3AMV0mlhD0Jczpy1SZNNW97OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AYDEQy2gcoCOOLbYO4bGUhioaojJuWWPTyW7hAne?=
 =?us-ascii?q?BAmMqQb6qUkbM4J9Uqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOF3lZw+Kh0zUmK/J1n3BRs+Qf59B3r+cLnEqqsQ?=
 =?us-ascii?q?htMK6Kn0pHG62jyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,128,1787011200"; d="scan'208";a="528580585"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Sep 2026 18:16:55 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 9984F180001CD;
 Mon, 28 Sep 2026 18:16:54 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/1] mbuf: add optional no-copy dynamic field storage
Date: Mon, 28 Sep 2026 14:16:54 -0400
Message-Id: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
In-Reply-To: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
References: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
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

This revision reworks the optional dynfield3 area around explicit no-copy
semantics.

The area remains managed by the dynamic mbuf field registry, but is only
used by fields registered with RTE_MBUF_DYNFIELD_F_NO_COPY.  Normal
fields, with flags set to 0, continue to use the existing copied dynamic
field storage and are prevented from overlapping dynfield3.  The generic
mbuf dynamic-field copy helper remains unchanged and copies only the
existing copied storage.

This keeps the registry benefits for consumers that need additional mbuf
metadata, while making the non-copy behavior explicit per field and
avoiding a build-wide dynfield3 copy policy.

Randy Tice (1):
  mbuf: add optional no-copy dynamic field storage

---
v3:
- Reserve dynfield3 only for fields registered with
  RTE_MBUF_DYNFIELD_F_NO_COPY.
- Keep flags=0 dynamic fields in existing copied dynamic-field storage.
- Prevent copied fields from overlapping or straddling dynfield3.
- Drop the mbuf_dynfield3_copy build option and avoid changing
  rte_mbuf_dynfield_copy().
- Widen dynamic-field allocator score storage to uint16_t.
- Disable mempool/octeontx when mbuf_dynfield3_size is non-zero.
- Add mbuf unit-test coverage for no-copy placement and copy behavior.
- Add devtools build coverage with mbuf_dynfield3_size enabled.
- Update programmer guide, release notes and commit rationale.

Validation:
- git diff --check HEAD~1..HEAD
- devtools/check-git-log.sh -n1
- devtools/checkpatches.sh -n1
- ninja -C build-v3-dynfield3
- build-v3-dynfield3/app/dpdk-test ... mbuf_autotest
- ninja -C build-generic

 app/test/test_mbuf.c                   | 72 ++++++++++++++++++++++++--
 config/meson.build                     |  5 ++
 devtools/test-meson-builds.sh          |  3 ++
 doc/guides/prog_guide/mbuf_lib.rst     |  9 ++++
 doc/guides/rel_notes/release_26_11.rst | 17 +++++-
 drivers/mempool/octeontx/meson.build   |  5 ++
 lib/mbuf/rte_mbuf_core.h               |  6 +++
 lib/mbuf/rte_mbuf_dyn.c                | 54 ++++++++++++++++---
 lib/mbuf/rte_mbuf_dyn.h                | 11 +++-
 meson_options.txt                      |  2 +
 10 files changed, 172 insertions(+), 12 deletions(-)

-- 
2.35.6

