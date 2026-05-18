Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45EDCD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 10:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0520E402EB;
	Mon, 18 May 2026 12:01:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9871F402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 12:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779098481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=usWGx6NyDQ2bdNJSsvQ/eg9NjLZt1Wyl/NejEHjRq+U=;
 b=HAnFmSZAWZQ65v502WX30HQjzVu4u9S2u/xGwSbI3U/X0tf9U8X8+YHCj7/NjBRi83aTPo
 /y+F8aZUeBc7U367ERlReK/zDklI+jsZFVReZKqEnz8EJuIVlA2MI7YbLEWcAzZvE3Qz/G
 VKHCOsFF63bOBQK/G+Y6U8RwDYzWbPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-7BcNe5nXO16tYBVLykOcZQ-1; Mon,
 18 May 2026 06:01:19 -0400
X-MC-Unique: 7BcNe5nXO16tYBVLykOcZQ-1
X-Mimecast-MFC-AGG-ID: 7BcNe5nXO16tYBVLykOcZQ_1779098478
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5778C195609F; Mon, 18 May 2026 10:01:18 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.250])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5FBB1800352; Mon, 18 May 2026 10:01:16 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk 0/2] rib: allow iteration to include the top-level route
Date: Mon, 18 May 2026 11:59:03 +0200
Message-ID: <20260518095900.29655-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S-Wr1RaBvCDDwHU1xwdj69Dte5l_RVB18X7zyuQP99U_1779098478
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

rte_rib_get_nxt() and rte_rib6_get_nxt() use an untyped int parameter
and anonymous enums for the traversal mode. The first patch gives these
enums proper type names (rte_rib_nxt_mode, rte_rib6_nxt_mode) and
renames the parameter from "flag" to "mode".

The existing traversal modes (ALL and COVER) always skip the exact match
top-level route. The second patch adds a RTE_RIB_GET_NXT_ALL_TOP mode
(and its IPv6 counterpart) so that callers who need the full subtree
including the root can get it without a separate rte_rib_lookup_exact()
call.

Robin Jarry (2):
  rib: rename nxt flag parameter to mode
  rib: add mode to include top-level route in traversal

 app/test/test_rib.c  | 16 ++++++++++++++++
 app/test/test_rib6.c | 16 ++++++++++++++++
 lib/rib/rte_rib.c    | 16 ++++++++++++----
 lib/rib/rte_rib.h    | 16 ++++++++++------
 lib/rib/rte_rib6.c   | 16 ++++++++++++----
 lib/rib/rte_rib6.h   | 18 +++++++++++-------
 6 files changed, 77 insertions(+), 21 deletions(-)

-- 
2.54.0

