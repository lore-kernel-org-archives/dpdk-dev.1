Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09773606A331
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=UGLLM8S/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F55402EA;
	Thu, 19 Nov 2026 19:05:07 +0100 (CET)
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
 by mails.dpdk.org (Postfix) with ESMTPS id 8BDDC40151
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1254; q=dns/txt;
 s=iport01; t=1795111504; x=1796321104;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=GfQ8J4Xd79ygn9cwdWMkf+wtRrItXJat8lqTK6MRMIA=;
 b=UGLLM8S/G/laitEhaII8cO4hTA8M/h91kQVuOZQBp0LBtCxpQ39QFwKB
 TjWz7BaIPEF+jVKa1iUblrMEft/xFt/n3eVzYeibOewQJDSSirJGmJa8v
 IvueHfgrwjDVQAQ77pkEPgy5dr1zssftIBvN3zV+xvz7ha8FrOnHL8nWa
 IUkNlKkz40IA6z+hgBVIzrTQ2lw3KurkJ25hRs06J2nnqV178bzXwwJ98
 d1GusAF6EcsUgtuHAAUidSHz+ubhQ9LaNlLqiISX0XLPnK059XNAS7UD9
 Elnwwp5ZjXVR8nWGig5L65nIsOpyFuERk3hr3/sqlOsQHhE9WEb/PxnkU Q==;
X-CSE-ConnectionGUID: i3DOFNKOSW2Tb1MbHij9sg==
X-CSE-MsgGUID: D7GeiXlaT0KZOjTTX69czw==
X-IPAS-Result: =?us-ascii?q?A0C5AAATOv9q/5X/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wQBAQsBhCxChSCRdKAqDwEBAQ9RBAEBhQECAgKOIAImNwYOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXJATAgEDIw8BRhAlAiYCAkYQgxuCd?=
 =?us-ascii?q?QO6BXqBMoEBhH7ZS4F0FYEKLgGIYQGBcYQIhH0nFQaBSUSBFTKDOIUQgw+Ca?=
 =?us-ascii?q?gSCInoSmFYJgUEcA1ksAVUTFwsHBWOBBQOBBm4yHYEjOxcvWBsGBYEcgQcEE?=
 =?us-ascii?q?4ESgQNdgSsoXQEhgQiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBG?=
 =?us-ascii?q?jU8CSY/FQxnCxoFYQgCDQx0ORAwHiQvBRomPhsKgQwnHx4bDgIfCW09NxUZB?=
 =?us-ascii?q?D2XcVgjFEI/QncHOJcLjCeCIaERhCuheDOEBKZumQiCWaZsgX4mgVlNIxWDI?=
 =?us-ascii?q?1IZD+B8JnQHAgcPApF1LYFPAQE?=
IronPort-Data: A9a23:1X6eC6BQWbAa8xVW/33iw5YqxClBgxIJ4kV8jS/XYbTApD1w1WZSm
 DcfCj/SPauDY2qmeN1xbdi+8kgBscDTyYAyOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCC+G+39BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQb8imYpWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEwq5CK28QHqojxbxLCzhr/
 9wZKmEWYUXW7w626OrTpuhEnM8vKozveYgYoHwllGufBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY+BPjDS0Un1lM/Eo4/l+qAjXjkeDoeo1WQzUYyyzWPnVYpiuS1bbI5fPSmGupYn3acr
 16e3FbeAC0mBILOwiiapyfEaujn2HmTtJgpPLG16NZmmFGQgGsJB3U+Tke2ufm0jGa4Vs5AL
 FYX4i4zqKI/7gqsVNaVYvGjiGSPshhZX59bFPc3rVjXjKHV+A2eQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWYHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:uNVq3qtZEITbj8NruA/SWCtK7skDVtV00zEX/kB9WHVpmwKj+/
 xG+85rsCMc6QxhOk3I9urvBEDtexnhHNtOgbX5Xo3SODUOxlHIEGgK1+KLqAEIWReOldK1vp
 0OT0ERMrDNJGk/q9rm6w+lFNtl6tyG/Ke0wdr69R5WPGZXg2UK1XYBNu5deXcGIjV7OQ==
X-Talos-CUID: 9a23:094M6WwGWu03rTluhrcCBgUVQewCXFv+60zveXOyUENjaLyXGESfrfY=
X-Talos-MUID: 9a23:3ceeWAoK0rzfcwZ4By4ezx09G8pp06CnNBguo7IEh/W0a317KSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,221,1787011200"; d="scan'208";a="549202405"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
 by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Nov 2026 18:05:02 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 5C58D1800031F;
 Thu, 19 Nov 2026 18:05:02 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/1] log: add name query functions
Date: Thu, 19 Nov 2026 13:05:01 -0500
Message-Id: <179511150161.2.2469579962132494369.v2-0000-cover-letter.patch@cisco.com>
In-Reply-To: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com
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
owned by DPDK. Unit tests cover valid and invalid levels and types, and the
new APIs are documented in the programmer guide and release notes.

The original downstream implementation was authored by Walt Robinson.

Changes in v2:

- Return NULL for an invalid log level, matching the log type getter.
- Update the API documentation and test for the revised error convention.

Validation:

- Full native Meson/Ninja build with -Dwerror=true
- DPDK fast-tests / logs_autotest

Randy Tice (1):
  log: add name query functions

 app/test/test_logs.c                   | 11 +++++++++++
 doc/guides/prog_guide/log_lib.rst      |  7 +++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/log/log.c                          | 20 ++++++++++++++++++++
 lib/log/rte_log.h                      | 25 +++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

-- 
2.35.6

