Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E6CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 926A341144;
	Fri,  2 Oct 2026 12:16:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CED5240281
 for <dev@dpdk.org>; Fri,  2 Oct 2026 12:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790936167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQOv1yjJAf8EtQq08Tl2WyQ2jePrPA4ukdwl97xV5Sg=;
 b=Z0t6rafo+WIH3AFYOZ8mHR4Jqw24+9ZJd7IBJU+srC+SOQ9ot47e7ijo44Lk1cYx27QVN2
 29HUieVT0Iulnn+yCxe1+XCGcNSKpgBgf3OOPlWNcG7b7FK/Iv/nG46xuSECtj1faNSrgA
 7XN1bmAc+NsX4nVk69c9L/JI5JcfTzU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-LVrSkIWQPsiFyEk_9_n_jQ-1; Fri,
 02 Oct 2026 06:16:06 -0400
X-MC-Unique: LVrSkIWQPsiFyEk_9_n_jQ-1
X-Mimecast-MFC-AGG-ID: LVrSkIWQPsiFyEk_9_n_jQ_1790936165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35E671800759
 for <dev@dpdk.org>; Fri,  2 Oct 2026 10:16:05 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70E041800370; Fri,  2 Oct 2026 10:16:04 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v2 0/2] rib: allow iteration to include the top-level
 route
Date: Fri,  2 Oct 2026 12:15:25 +0200
Message-ID: <20261002101523.383527-5-rjarry@redhat.com>
In-Reply-To: <20260518095900.29655-6-rjarry@redhat.com>
References: <20260518095900.29655-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MqAjhTX0N9skNoABJE1TaaB-SwCbwmdX-Wt04anqCHM_1790936165
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

v2:

* fixed rib6 unit test (0 -> &unspec)
* added release notes entry
* changed enum names (rte_rib*_nxt_mode -> rte_rib*_get_nxt_mode)
* minor style nits

Robin Jarry (2):
  rib: rename nxt flag parameter to mode
  rib: add mode to include top-level route in traversal

 app/test/test_rib.c                    | 16 ++++++++++++++++
 app/test/test_rib6.c                   | 16 ++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 lib/rib/rte_rib.c                      | 20 ++++++++++++++------
 lib/rib/rte_rib.h                      | 19 ++++++++++++-------
 lib/rib/rte_rib6.c                     | 20 ++++++++++++++------
 lib/rib/rte_rib6.h                     | 20 +++++++++++++-------
 7 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.55.0

