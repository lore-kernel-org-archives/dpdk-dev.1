Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F718C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B91A402E4;
	Mon, 10 Feb 2025 18:44:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4F8B540150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQyPkpaDN2c3uQDEqS/7uWvboXefKgQwFnAHI12lO58=;
 b=gvPrKxxNtpnD+0lJZM8Ot4MdmoeOEq64RZvZMfLdzk4bJ0hj/tp837hqeKavdfA1KG+DzV
 MwllQDIamK9zUfdOgaGFmjNVIV7sHy5hroXExky04It7irgHHbFLOSAJsH0iVY1ddhSVh/
 TwV4WWvbhU7WMp+SZhR1v2k1fNvR5RY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-u7XA2YvGNtmXUw4toYUmNQ-1; Mon,
 10 Feb 2025 12:44:32 -0500
X-MC-Unique: u7XA2YvGNtmXUw4toYUmNQ-1
X-Mimecast-MFC-AGG-ID: u7XA2YvGNtmXUw4toYUmNQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7930F180036F; Mon, 10 Feb 2025 17:44:31 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9FB418004A7; Mon, 10 Feb 2025 17:44:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com,
	fengchengwen@huawei.com
Subject: [PATCH v3 0/6] Trace point framework enhancement for dmadev
Date: Mon, 10 Feb 2025 18:44:16 +0100
Message-ID: <20250210174424.3364021-1-david.marchand@redhat.com>
In-Reply-To: <20250124161408.310581-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ujZ1xfUC3SSoQvw-Cs-TS0Hmq68R3ATSyoiqZOBTlvc_1739209471
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

dmadev trace points have been working around trace point framework
limitations.
One of this workaround blocks enabling dmadev on MSVC.

Traces files were not checked in CI, so this series also adds a new
check.

-- 
David Marchand

Changes since v2:
- added check of traces validity in GHA,
- split patch 2 and fixed CTF metadata,


David Marchand (6):
  ci: check traces validity
  trace: support dereferencing arguments
  trace: support expression for blob length
  trace: support dumping binary inside a struct
  dmadev: avoid copies in tracepoints
  trace: fix undefined behavior in register

 .ci/linux-build.sh                         | 10 +++++
 .github/workflows/build.yml                |  2 +-
 lib/dmadev/rte_dmadev_trace.h              | 32 +++------------
 lib/dmadev/rte_dmadev_trace_fp.h           | 26 ++----------
 lib/eal/common/eal_common_trace_ctf.c      | 39 ++++++++++++------
 lib/eal/include/rte_trace_point.h          | 16 +++++---
 lib/eal/include/rte_trace_point_register.h | 46 +++++++++++++++++++---
 lib/ethdev/ethdev_trace.h                  | 27 ++++---------
 8 files changed, 107 insertions(+), 91 deletions(-)

-- 
2.48.1

