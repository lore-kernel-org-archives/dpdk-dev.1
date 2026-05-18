Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF066CD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F064060A;
	Mon, 18 May 2026 15:27:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CF940402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEgubdx75PPVyeh1ly5s843aQFOXTDFPRkYx16K95xw=;
 b=i7zZ/A1jKpgs5s2ySJWsZbO3/EMDVrYetdUs6SP3D4Kx8+JYzDUVMdZ26YJ6g8c8T7VUik
 sZSv1x+thX9iPskPY2Nz2frSGuANdxkkzCzVOCIMtpqWbQIN2lR2JHi7mt8iSjgc0OEVE0
 5Uh9QpSDaXYYsScHfaa+zgxxMjcKLSU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-VaIAmYbSMJKkMSUm49wzcQ-1; Mon,
 18 May 2026 09:27:32 -0400
X-MC-Unique: VaIAmYbSMJKkMSUm49wzcQ-1
X-Mimecast-MFC-AGG-ID: VaIAmYbSMJKkMSUm49wzcQ_1779110852
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF2011956059
 for <dev@dpdk.org>; Mon, 18 May 2026 13:27:31 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0857719560B1; Mon, 18 May 2026 13:27:30 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v5 0/5] Fix and improve VLAN/MPLS parsing in
 rte_net_get_ptype
Date: Mon, 18 May 2026 15:27:14 +0200
Message-ID: <20260518132712.70913-8-rjarry@redhat.com>
In-Reply-To: <20260422102814.645299-2-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oJLgiKg3t9bl5fAMSHRwKVK4odTMZB5bpDH08Srp9v8_1779110852
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

Revert commit 1f250674085a ("net: fix packet type for stacked VLAN")
which introduced a regression causing single VLAN frames to be
misidentified as QinQ due to incorrect use of |= on the ptype.

Replace the separate VLAN and QinQ code paths with a single loop
that handles arbitrarily stacked VLAN tags. Fix the MPLS path to
use the bottom of stack bit instead of a hardcoded label limit,
and parse the L3 protocol of the MPLS payload by inspecting the
first nibble.

Add unit tests for rte_net_get_ptype covering Ethernet, VLAN, QinQ,
MPLS, IPv4/IPv6, and truncated packet scenarios.

v5:

* Split the series in multiple patches.
* Revert the commit that introduced the bug.
* Add support for stacked VLAN/QINQ as suggested by David.
* Fix MPLS bottom of stack detection. Try to guess MPLS payload.
* Add more test cases.

v4:

* changed the approach again. Only set VLAN or QINQ ptype for the first
  encountered vlan/qinq ether type.
* unit tests not changed

v3:

* changed the approach: initialize pkt_type=0 and only set it to
  RTE_PTYPE_L2_ETHER if neither of VLAN nor QINQ matched.
* extended the unit tests to check for header lengths and added ipv6 / tcp
  cases.

v2: added new ptype tests

v3:

* changed the approach: initialize pkt_type=0 and only set it to
  RTE_PTYPE_L2_ETHER if neither of VLAN nor QINQ matched.
* extended the unit tests to check for header lengths and added ipv6 / tcp
  cases.

v2: added new ptype tests

Robin Jarry (5):
  Revert "net: fix packet type for stacked VLAN"
  net: support multiple stacked VLAN tags
  net: add unit tests for rte_net_get_ptype
  net: parse L3 protocol after MPLS labels
  net: add truncated packet tests for rte_net_get_ptype

 app/test/meson.build      |   1 +
 app/test/test_net_ptype.c | 326 ++++++++++++++++++++++++++++++++++++++
 lib/net/rte_net.c         |  72 +++++----
 3 files changed, 369 insertions(+), 30 deletions(-)
 create mode 100644 app/test/test_net_ptype.c

-- 
2.54.0

