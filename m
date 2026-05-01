Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587CFF885A
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 09:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F08CA40657;
	Fri,  1 May 2026 11:54:12 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB2740299;
 Fri,  1 May 2026 11:54:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ECD5D40288
 for <announce@dpdk.org>; Fri,  1 May 2026 11:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777629249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iWw/1PdfZFOzOtJHx+DDCsIbRXNhMwP2kOc+u+7pOxo=;
 b=VJq/w6Y26OcUIDPpbb9iqiCTl3z46nboZHSz5zFdSiroDRTPk92KH8O4vZ1I7xb0qxMlVY
 +hur7e2Qy92ntq1lpBu2E0kSHzt9wIMuKWCs+wZGiwPRsYRloUmv3eX2rcwn15imWDHExd
 fgfuo3/8YEn7z0u+Hq6/ctmelIDFgpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-sXXp_ILYPLWrBpqCrN_0Dg-1; Fri,
 01 May 2026 05:54:07 -0400
X-MC-Unique: sXXp_ILYPLWrBpqCrN_0Dg-1
X-Mimecast-MFC-AGG-ID: sXXp_ILYPLWrBpqCrN_0Dg_1777629247
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCBFA1800378
 for <announce@dpdk.org>; Fri,  1 May 2026 09:54:06 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.33.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 138F41955D84
 for <announce@dpdk.org>; Fri,  1 May 2026 09:54:05 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: announce@dpdk.org
Subject: DPDK 25.11.2 released
Date: Fri,  1 May 2026 10:54:02 +0100
Message-ID: <20260501095403.548138-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qXAuctQXxD18BrLmTRYBEreJMNqY67b7fjCMuf7qxQU_1777629247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi all,

Here is a new stable release:
	https://fast.dpdk.org/rel/dpdk-25.11.2.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=25.11

This release is to address a regression in DPDK v25.11.1 as reported
at https://bugs.dpdk.org/show_bug.cgi?id=1941.

Thanks to Robin Jarry for reporting this issue.

Kevin

---
 VERSION                                |  2 +-
 doc/guides/rel_notes/release_25_11.rst | 16 ++++++++++++++++
 lib/net/rte_net.c                      | 29 +++++++++++++++--------------
 3 files changed, 32 insertions(+), 15 deletions(-)
Kevin Traynor (2):
      Revert "net: fix packet type for stacked VLAN"
      version: 25.11.2

