Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF8EEA852
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 21:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B471C4025F;
	Thu, 12 Feb 2026 22:33:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C1D3840041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 22:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FpCyE3zDf/gJHm98n5rvtP4vRGoY9wC+T6BC/gGP/pA=;
 b=XP4ntXnZXdNiJJ4zwQ3JC9B2k/rKt7dZwIi+gChs6jtuplHyJBValNQ4l2nWHs8Lil6+sP
 dZ6NctUiUpBf1txn1K6TWdkhAdEnvcMDUFflOOVQGkoOtLxTVGe0RzBMkPDFxpF724CvTR
 niSBm3hWvgDgkXAPacDdlXojjcHUfhs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-em7v0uTYNBusienxpCLuYw-1; Thu,
 12 Feb 2026 16:33:38 -0500
X-MC-Unique: em7v0uTYNBusienxpCLuYw-1
X-Mimecast-MFC-AGG-ID: em7v0uTYNBusienxpCLuYw_1770932017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B881955DDF
 for <dev@dpdk.org>; Thu, 12 Feb 2026 21:33:37 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.32.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB9CC3000225; Thu, 12 Feb 2026 21:33:35 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 0/2] hash: safe data replacement on overwrite
Date: Thu, 12 Feb 2026 22:33:15 +0100
Message-ID: <20260212213313.1376294-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7PxvWX6IOz8OIvdiYssfsraTCn8sbM4ZCioX2eLhZWk_1770932017
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

When rte_hash_add_key_data() is called with an existing key, the old
data pointer is silently overwritten. With RCU-protected readers still
potentially accessing the old data, the application cannot safely free
it since the old pointer is never returned.

This series provides two ways to address the problem:

* Automatic: when RCU is configured with a free_key_data_func callback,
  rte_hash_add_key_data() now automatically defers freeing the old data
  on overwrite. No caller changes are needed.

* Explicit: a new rte_hash_replace_key_data() API returns the previous
  data pointer via an output parameter, giving the caller full control
  over the old pointer's lifecycle. No automatic deferred free is
  performed in that case.

Robin Jarry (2):
  hash: free replaced data on overwrite when RCU is configured
  hash: add replace API returning old data on overwrite

 app/test/test_hash.c                   | 214 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  12 ++
 lib/hash/rte_cuckoo_hash.c             | 146 +++++++++++++----
 lib/hash/rte_hash.h                    |  75 ++++++++-
 4 files changed, 417 insertions(+), 30 deletions(-)

-- 
2.53.0

