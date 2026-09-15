Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E390C982C1
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86BF9427C3;
	Tue, 15 Sep 2026 17:05:11 +0200 (CEST)
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
 by mails.dpdk.org (Postfix) with ESMTP id 3042340A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1062; q=dns/txt;
 s=iport01; t=1789484710; x=1790694310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3+g0rhrz067s6KgO0TLDsgp7r5QZ/Zs4PJG5cMfyqpY=;
 b=Crd76xomUgCm2du82ZRRh/fV0sNaifP6m7qvyp6DkXBqfyaFNj+kNPHA
 9VhzI8yXSJPTSArdzM4UnUMjZcROuFJtpS6Id8nPqlwjYm7d+sg4jnHlX
 gWEMR6wdzEIHgdy1rZBOYXM3+ZzRrq5ylBUnc0jbu8JBs1D7bq/s4/ya/
 VA23/PzdQSjLSGf8jTSkpBIzsk0CBmqVpI/4Yp+yuHOjWxD2FRfYY2hLO
 zPWNhRvcUWRca7iLmIfPd5kcQjpM1+o1GWRnacHY5gohORzCs9G6CTwmP
 5X9zxM73uYrfNj5NHo0n4gkMmCskqwbv34nZvYo5scVD+7RP9UeA2hfGX g==;
X-CSE-ConnectionGUID: vYntsRcnR1epPbi4AGTZ1g==
X-CSE-MsgGUID: TpqdkDFoQfeVqRPgJj2qCw==
X-IPAS-Result: =?us-ascii?q?A0BYAwB/Xalq/5H/Ja1aglmELUK1MYF+DwEBAQ9RBAEBh?=
 =?us-ascii?q?QUCjgcCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQE?=
 =?us-ascii?q?wIBAzIBRhBRVoMbgnUDwX6CLIEBhH7ZSoF0FYE4jWF2hHwnFQaBSUSBFYNph?=
 =?us-ascii?q?RCFeASDHBKDV5BVSIEeA1ksAVUTDQoLBwWBZgM1EioVbjIdgSM+F4EHGwYFg?=
 =?us-ascii?q?R2BJ4JiIxk2eoEJXoErKWABEheBCYIIAoJUggECAUlDDgdFUwknQQoSTCkiC?=
 =?us-ascii?q?BIJARMaFxgNSBEsNxUZBD5uB5IpgQ+BeDjHLIQooVwaM6ptmQikWoRpgWg8g?=
 =?us-ascii?q?VlNIxWDI1IZD95ZKHQHAgcPApNxAQE?=
IronPort-Data: A9a23:9enTDakCCBMPjMP6/tsbdNTo5gzOJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaDW6Gb/uPNzOmKdpwao6ypEwEuMKHy4NjSws6pCBmEVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4Errav6+/SEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZK31GONgWYubDpFsv7b8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZMp/PpsO2pIz
 6UVMAgHb0yqqN6Emb3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiTBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZz/7C7pm9AusrmPjcjZVgFmUvqEwpWPUyWSd1ZCwaoGEIYTUGp09ckCwm
 nrf82fVLBYjOtGh0AC9/VCu3PbkgnauMG4VPPjinhJwu3Wfy3I7BAUaVh28u/bRolK+XNdWM
 GQR/SwspKw18gqtQ8WVYvGjiGSPshhZX59bFPc3rVndjKHV+A2eQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWUHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:qC2YqqPn2HknKsBcTuGjsMiBIKoaSvp037Dk7SxMoHtuA6ilfq
 +V8sjzuSWftN9VYgBCpTniAtjkfZqjz/9ICOAqVN/IYOClghrLEGgI1+TfKlPbdhEWjtQ86Y
 5QN45jFdb3EV92yez+4AW+DpIc5ePvytHOuQ8bpE0dND2DrMpbnmFENjo=
X-Talos-CUID: 9a23:889ajmzuWnf932gS9lGoBgUKK8Y5aUfWyk2JLleAA2c1YZKpewafrfY=
X-Talos-MUID: 9a23:WYthoQrMcGRbYIecbZAezw16Lctrz4qpMU4Ar4w8g8amN3ZpECjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; d="scan'208";a="523930670"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
 by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Sep 2026 15:05:08 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id D9E51180005A7;
 Tue, 15 Sep 2026 15:05:07 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
	Randy L Tice <rtice@cisco.com>
Subject: [PATCH v2 0/1] eal: add CPU socket lookup API
Date: Tue, 15 Sep 2026 11:05:06 -0400
Message-Id: <20260915150507.3-1-rtice@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <178941409436.3.12421464753538796039@cisco.com>
References: <178941409436.3.12421464753538796039@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com
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

Some applications need to derive socket-specific EAL configuration
from OS CPU IDs before EAL lcore IDs are useful. One example is
building socket memory policy from the CPUs available to the process.

Existing public socket APIs do not cover this directly. rte_socket_id()
reports the calling thread socket, while rte_lcore_to_socket_id()
requires an EAL lcore ID and uses EAL lcore configuration.

Add experimental rte_cpu_socket_id() as a public API for mapping an OS
logical CPU ID to the NUMA socket containing that CPU. The
implementation reuses the existing per-OS EAL lookup internally, while
keeping the eal_cpu_socket_id() helper private to EAL.

v2:
- Mark rte_cpu_socket_id() experimental in the declaration, export
  macro, release note and commit message.

Randy L Tice (1):
  eal: add API to get CPU socket ID

 .mailmap                               |  1 +
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/eal/common/eal_common_lcore.c      |  7 +++++++
 lib/eal/include/rte_lcore.h            | 18 ++++++++++++++++++
 4 files changed, 29 insertions(+)

-- 
2.35.6
