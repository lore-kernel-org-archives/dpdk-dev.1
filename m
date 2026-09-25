Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C9C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 19:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0818400D7;
	Fri, 25 Sep 2026 21:31:11 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id 04031400D7
 for <dev@dpdk.org>; Fri, 25 Sep 2026 21:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1922; q=dns/txt;
 s=iport01; t=1790364671; x=1791574271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=YF7DdFfdBvmovhKn4zxL1ALDv+A3hHctcAilW9bJObM=;
 b=OOjMHk6t/2CHdFvG6/wxdbd7nwCDymTCxZgW/HkyJ7JyzDcpyIGSFvfT
 MyReQFjKIufl/hJnY7fRamdWUxBb8Tb8d2V/sCihLiac4/rPSZzHfsFUR
 LolVpt5EOtQiH9l0lItRgkRBoFsbCGcOmgIJeSNDhPKo5ia8Cp4kRvZYT
 WcsRP3je0ic9r+GwtyyajPmuKtwlpi8CwMqbp/FkkbmFU4nRXPNQPXFLw
 ajPqInYMDn1ta0vhpyBGfCBFIbcT2BDvDaee19MesAJND83iayrTU9h8d
 B88Dtczh1zV3eXxu0nv2wQ0uUOGC2cAM80aKklHLiZ+7V+zBG8CVjb28+ Q==;
X-CSE-ConnectionGUID: 7dhJnrKVRhGPiLH2GrscRQ==
X-CSE-MsgGUID: p1pSdh+CQNOProWLHHc70g==
X-IPAS-Result: =?us-ascii?q?A0A6AADVyrZq/4wQJK1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?0thQkmEV4gbiVieHYF+DwEBAQ83GgQBAYUBAgICjgkCJjQJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQoBAQUBAQECAQcFgQ4Thk8NkBMCAQMjDwFGECUCJgICRhCDG?=
 =?us-ascii?q?wGCdAPBG3qBMoEB3kiBdBWBCi4BiF4BgXGECIR8JxUGgUlEgUeDN4QtY4MOg?=
 =?us-ascii?q?moEgxwSgyeRcwmBQRwDWSwBVRMXCwcFYYEFA4EGbjIdgSM+Fy9YGwYFgR2BC?=
 =?us-ascii?q?QQTghkjGTZ6gQlegSspYAEQF4EHggcCglSCAQIBSUMOB0VTCSVBChJHJiIIE?=
 =?us-ascii?q?gkBExowC4EhOEEJKAttPTcVGQQ9kSAegl4HATBegSaBGDeTNYNZr1mEKIwil?=
 =?us-ascii?q?VQzhVulFJkIqUOBaDyBWU0jFYMiCUoZD5FGhy7FZSg1PwcCBw8CkXQBJgeBT?=
 =?us-ascii?q?wEB?=
IronPort-Data: A9a23:K0x6IaxBhIjKIu1Wz2d6t+dYxyrEfRIJ4+MujC+fZmUNrF6WrkUBx
 jFKUWHQb/+CZmekc9hxOoqz9UJSu5PXz9U1QVE+/1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHyYuCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4yaT/H3Ygf/hWYlaD9MscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJB46Pa8e4MVJO2Fhz
 f08CGoidAuIvdvjldpXSsE07igiBMDvOIVavjRryivUSK59B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUiYC/FMEg9/5JYWhvupjXTXeDxDo1XTrq0yi4TW5FwsiOG2aIKKJ7RmQ+1Nx16jq
 mKF1F3fJSkAM+O76RqOrSqj07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTq+OkgUP4QdNUK
 0UO9jEpq4Az8lCmSp/2WBjQiHuOlgUZUsBMCO0z8gyW27HI7gOCQGMDS1Z8hMcOvcsyQ3kuk
 1SOhd6sXWcpu7yOQnXb/bCRxd+vBRUowaY5TXdsZWM4DxPL+enfUjqnog5fLZOI
IronPort-HdrOrdr: A9a23:6T36qKktAnFN1czLGuXUPivgdvrpDfIM3DAbv31ZSRFFG/FwWf
 rDoB19726QtN9xYgBDpTnuAse9qB/nn6KdpLNwAV7AZniDhILXFuBfBOLZqlWKJ8S9zJ8/6U
 4KScdD4bPLYGRSvILd/BSyFcomzZ2s9aClgvqb8lJWJDsaDJ2JK2xCe3+m+oocfnghOaYE
X-Talos-CUID: 9a23:UxLSVGMY+X+2+O5DByVn1kgOOf4fclLlzVPweWCiEm1TcejA
X-Talos-MUID: =?us-ascii?q?9a23=3A53chQA0QcChNEZWT7fEW3toYSzUj+/22M0wN0r4?=
 =?us-ascii?q?/ne68LytPHxe9h2vvTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; d="scan'208";a="850130075"
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Sep 2026 19:31:09 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 55AFF18000426;
 Fri, 25 Sep 2026 19:31:09 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/1] mbuf: add optional dynfield3 storage
Date: Fri, 25 Sep 2026 15:31:08 -0400
Message-Id: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
In-Reply-To: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
References: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com
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

This version updates the dynfield3 proposal based on review feedback from
Morten.

The optional area is now configured by byte size instead of pointer count,
so the configured value is independent of 32-bit or 64-bit builds.  The
storage is represented as uint64_t elements, and the configured size must
be a multiple of sizeof(uint64_t) and reserve a multiple of the cache line
size.

The extra area remains part of the dynamic mbuf field allocator.  To
preserve the historical behavior expected for dynamic fields while still
supporting per-mbuf private metadata use cases, copying this area is
controlled by a separate build option.  The default does not copy dynfield3
in the generic mbuf copy/clone path; users that want the existing copied
dynamic-field semantics can opt in with mbuf_dynfield3_copy.

This version does not add a per-field isolate registration flag.  The
immediate use case needs a configured per-mbuf metadata area whose contents
remain local to each mbuf by default, matching the downstream storage this
replaces.  Keeping dynfield3 allocator-backed preserves the dynamic-field
extension model, while the build-time copy option lets deployments opt in
to copied dynamic-field semantics without imposing that behavior on private
metadata users.

Validation:
- devtools/check-git-log.sh -n1
- devtools/checkpatches.sh -n1
- default generic-all build
- build with mbuf_dynfield3_size=128 and mbuf_dynfield3_copy=true
- mbuf_autotest with default and enabled builds

Randy Tice (1):
  mbuf: add optional dynfield3 storage

 app/test/test_mbuf.c                   |  5 +++--
 config/meson.build                     | 16 ++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/mbuf/rte_mbuf.h                    |  6 ++++++
 lib/mbuf/rte_mbuf_core.h               | 17 +++++++++++++++++
 lib/mbuf/rte_mbuf_dyn.c                |  3 +++
 meson_options.txt                      |  4 ++++
 7 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.35.6
