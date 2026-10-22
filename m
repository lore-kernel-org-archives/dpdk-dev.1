Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280B606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=O6KPmwTZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91BD440264;
	Thu, 22 Oct 2026 20:41:16 +0200 (CEST)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mails.dpdk.org (Postfix) with ESMTP id 9871A4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1066; q=dns/txt;
 s=iport01; t=1792694474; x=1793904074;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=M0KuXM3ICTPn4RZYAE21dkscW9kVmMw++79gnpSLqlI=;
 b=O6KPmwTZ/TgpOYq2aMgF4UyE28IYyzs8iyVDrSM0YablgGcC4m5hPqGM
 st7u0ifujJ36atogKsN7qvnXxgdGzaS8LxbSwn1FfkeXj6N8kdp5o0jxO
 opj27vnF1dvyJpVhCy2dN7371L6OjbQ08Ip5yYH4uu/gQ5xLsS/LQ0SM5
 JKtOLLK85YmNCIJL9naKz4qjsLAO7Dv5HlK5Tnxms5SDuxiSBS3uxkm47
 /3Rg12p1r4aqu16WL+wPfxNpCXVIwiM8+PVQTeziEHatCAE6hWgy0RAdo
 Gr+xvufZpHd1BWX53aRg26vALRVskCmxvRQKYbgzNvwR6W+ot9/p88cQa w==;
X-CSE-ConnectionGUID: 0NgaeJJwT7WsNo+Xlv2vDg==
X-CSE-MsgGUID: hAKrYTASQDyX8zihSqZ2UA==
X-IPAS-Result: =?us-ascii?q?A0AYBABjV9pq/44QJK1aHgEBCxIMggULhC1ChSCRdJ4fg?=
 =?us-ascii?q?X4PAQEBD1EEAQGFAQICjhcCJjUIDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyQFScPAUY1AiYCSIMrgnUDthJ6gTKBAYR+2UqBdBWBCi6IX?=
 =?us-ascii?q?wGBcYQIhHwnFQaBSUSBFTKDN4UQgw6CagSCInoSlkkJgUEcA1ksAVUTFwsHB?=
 =?us-ascii?q?WOBBQOBBm4yHYEjPhcvWBsGBYEdgQcEE4EWIxk2a4EJXYErKWABIYEIgXYCg?=
 =?us-ascii?q?lGCAAIBSUEOB0VTCSVDEkckIggSCQETGi4LgRo4PAkmQRUMZgsaBWIIAg0Mf?=
 =?us-ascii?q?zkJbT03FRkEPZVcWDeBAUJ3l0qMKKMwhCihdjOqb5kIqUOBagI4gVlNIxWDI?=
 =?us-ascii?q?1IZD+B6KHQHAgcPApF1LYFPAQE?=
IronPort-Data: A9a23:90NHTKA+Liks6BVW/3ziw5YqxClBgxIJ4kV8jS/XYbTApDkl1z0Dx
 zYXUTrQPKrfMzfze9sjO9vjpE1QusCDxtVnOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQf/gWYpWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEm9NhBUwUH5IkpdlsJ2YNx
 fgGci4hYUXW7w626OrTpuhEj8AnKozveYgYoHwllWyfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWAHgBfoO3WjPn8NFJM1kc+jh2L0dHtTr1f9Sa8fszeOkVctjOK8WDbTUtyjZt9kom+jn
 07XzzTrAxEhLe7F9BPQpxpAgceKx0sXQrk6GLCm3vJyjF7VwXYcYDUNSVajofS/okizR81YM
 U8M/jcrp6UoskuxQbHAswaQqXqAuFsYHtFXCeB/sFzLwavP6AHfDW8BJtJcVOEbWAYNbWRC/
 je0cxnBXFSDbJX9paqhy4qp
IronPort-HdrOrdr: A9a23:gJ+yCquLOM7ou3O8eWRfiNZK7skDQtV00zEX/kB9WHVpmwKj+/
 xG+85rtiMc6QxwZJhOo7690cW7K080lqQFg7X5Q43CYOCOggLBR72KhrGM/9SPIUDD398Y87
 t8eK5jD9C1J117gcHmpDScKb8bsby6GGTCv5a485+rJjsaD51d0w==
X-Talos-CUID: 9a23:03M3am8DePLkyl0oMxWVvxYyFckoUF/C8CjvOGm/SlZtVueLZVDFrQ==
X-Talos-MUID: 9a23:iTt6aQQrZEEGhYEGRXTsrRJ4BftB2J2CGXBdg5QGgNC2bxFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,172,1787011200"; d="scan'208";a="875534429"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 22 Oct 2026 18:41:13 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPS id E9CBB18000141;
 Thu, 22 Oct 2026 18:41:12 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/1] log: add name query functions
Date: Thu, 22 Oct 2026 14:41:12 -0400
Message-Id: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applications that display or export DPDK logging configuration can query
numeric log levels, but have no direct way to retrieve the corresponding
level and component names. They must currently duplicate the level mapping
and cannot safely query a registered component name.

Add experimental APIs to return the canonical name for a log level and the
registered name for a log type. The returned strings are const and remain
owned by DPDK. Unit tests cover known and unknown levels and types, and the
new APIs are documented in the programmer guide and release notes.

The original downstream implementation was authored by Walt Robinson.

Validation:

- Full native Meson/Ninja build
- DPDK fast-tests / logs_autotest

Randy Tice (1):
  log: add name query functions

 app/test/test_logs.c                   | 11 +++++++++++
 doc/guides/prog_guide/log_lib.rst      |  7 +++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/log/log.c                          | 17 +++++++++++++++++
 lib/log/rte_log.h                      | 25 +++++++++++++++++++++++++
 5 files changed, 65 insertions(+)

-- 
2.35.6

