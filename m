Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC9FC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 19:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 724E640A7A;
	Mon, 14 Sep 2026 21:28:17 +0200 (CEST)
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
 by mails.dpdk.org (Postfix) with ESMTP id 2439240A77
 for <dev@dpdk.org>; Mon, 14 Sep 2026 21:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=928; q=dns/txt;
 s=iport01; t=1789414096; x=1790623696;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K060nYyod5a7dcl2J/PaFFfwIcVwBjXUsUj5ded9yz4=;
 b=GYO5KdU50gKGnMO1/B5iHO0Y3Ox8WXw/gX1FSB6Eg1job7scfRz/JmSv
 Y80zjgPYzbPUCC3FTPDCKCu9JIjHGmdEEeFhNm5eE4wIQaN9Ez8Q+yt5R
 sTUliLaOSbNlzPv6B0rJWd4d2yYIrnjKGofpys9oFRPxmDxrGuF5sqkAt
 t4ZnqR2XtDFOPlt9w8U7AIQnNieWbU+Dx0B3ouAdR/zd+WjPv0JUqnpP8
 SWwn4Vb4Hgl0sWC1tYuhA0spU8kzLzmegbYUe5cA+5BzmQkabaypIMLOs
 BN50ilr+oJMqA+fqXC2PBd1Uyb2HhkDoQQM+NlWqU/F2D33AjSCMKInsE Q==;
X-CSE-ConnectionGUID: lgLqobHvS2qRw/BdoRajWg==
X-CSE-MsgGUID: 3xJ2K247RgSePcPeIan+ow==
X-IPAS-Result: =?us-ascii?q?A0BYAwAQSahq/5X/Ja1aHgEBCxIMggULhC1ChSCwEYF+D?=
 =?us-ascii?q?wEBAQ9RBAEBhQECAo4IAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4ZckBUnDwFGNQImAoZoA8UUeoEygQGEftlKgXQVgQouiF4BhXiEf?=
 =?us-ascii?q?CcVBoFJRIEVMoM3hRCDDoJqBIMcEoNXkFBIgQIcA1ksAVUTDQoLBwWBZgM1E?=
 =?us-ascii?q?ioVbjIdgSM+Fy9YGwYFgR2BJ4JiIxk2eoEJXoErKWABEheBCYIIAoJUggECA?=
 =?us-ascii?q?UlDDgdFUwknQQoSTCkiCBIJARMaDxgNSBEsNxUZBD0BbgeSJYEPgXg4xyyEK?=
 =?us-ascii?q?KF2M6ptmQikWoRpgWg8gVlNIxV9BlaBSlIZD95ZKHQHAgcPApNxAQE?=
IronPort-Data: A9a23:AzK0JaK9H6TZzuWQFE+RnpQlxSXFcZb7ZxGr2PjKsXjdYENSgWcDz
 GsdXGrUPqvbYWehKI0jO4y18x9S6JCEnNNgQFAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH9imcoajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1qA2UvOoc45N0tGFtRs
 tYULwoEbC+M0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEWojx5nYj/7DLokgOaji1H0ciZTrxSeoq9fD237kVQgjeexbYaFEjCMbZ5FvBy7/
 D6ZxWvCDykRDNG+wDzG9W3504cjmgu+Aur+DoaQ+vN0qFGLym9VDwcZPXOnof68g1WWXtVZK
 UUQ/Sxoq6UunHFHVfHnVBG+5XrBtRkGVp8JSasx6RqGzezf5APx6nU4cwOtoecO7KceLQHGH
 HfQ9z81LVSDaIGodE8=
IronPort-HdrOrdr: A9a23:Sq4F56+y61SC/Vlwi49uk+DyI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HKoB17726XtN9/Yh8dcLy7UpVoIkmslqKdn7NxAV7KZmCP01dAR7sM0WKN+VDd8lXFltJ15O
 NHb7V0DsH2ABxRiMb35xT9LvMbqeP3lJxBQYzlvhFQpcYAUdAG0ztE
X-Talos-CUID: 9a23:RHG2YG1Q/ZAsb/ovetsFlbxfHs8Ba3rX7GnreVaCFiFDRLqvQF2v9/Yx
X-Talos-MUID: 9a23:KjK0iApDIo7qK7pi9NEez2pyFp1LufjxMk82nK0Ng8SlPCozPCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; d="scan'208";a="509574548"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
 by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 14 Sep 2026 19:28:15 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id C97E1180001D0;
 Mon, 14 Sep 2026 19:28:14 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Randy L Tice <rtice@cisco.com>
Subject: [PATCH 0/1] eal: add CPU socket lookup API
Date: Mon, 14 Sep 2026 15:28:14 -0400
Message-Id: <178941409436.3.13205580340776837645@cisco.com>
X-Mailer: codex-smtplib
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com
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

Add rte_cpu_socket_id() as a public API for mapping an OS logical CPU
ID to the NUMA socket containing that CPU. The implementation reuses
the existing per-OS EAL lookup internally, while keeping the
eal_cpu_socket_id() helper private to EAL.

Randy L Tice (1):
  eal: add API to get CPU socket ID

 .mailmap                               |  1 +
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/eal/common/eal_common_lcore.c      |  7 +++++++
 lib/eal/include/rte_lcore.h            | 14 ++++++++++++++
 4 files changed, 25 insertions(+)

-- 
2.35.6
