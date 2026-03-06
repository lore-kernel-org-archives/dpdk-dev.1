Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C30F0180E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 08:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD46402D3;
	Fri,  6 Mar 2026 09:47:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5895240278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 09:47:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772786848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MH7SDRM6PxY2eeKZCHYRz4WDpxMUPU+r+ZYw0Wos/Bc=;
 b=V+cUb1ll1VnIY5D4IpOV6gqI3bjJWaegN/CGNtIlfKZPmv+Bjz11VRTocqr4f8/L9je0ry
 BeIFL3o7knM9mDUADRegOxYePDXQdhQlhsmO4oah+epxo1ftyncZolffSStuRZvFyzWwoL
 HeTpIScIaFOsXpDyPzVCRtsUkomqWgM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ynhys4zEMAK7TYnZCtVx-A-1; Fri,
 06 Mar 2026 03:47:22 -0500
X-MC-Unique: ynhys4zEMAK7TYnZCtVx-A-1
X-Mimecast-MFC-AGG-ID: ynhys4zEMAK7TYnZCtVx-A_1772786841
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6648319560A7; Fri,  6 Mar 2026 08:47:21 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.178])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1128B1958DC5; Fri,  6 Mar 2026 08:47:19 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Date: Fri,  6 Mar 2026 09:47:10 +0100
Message-ID: <20260306084710.492520-4-rjarry@redhat.com>
In-Reply-To: <20260212213313.1376294-5-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Azzv8188T7AgTAPr5Gby2DVkeKuXavdAYasJBn1Qb6A_1772786841
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

This series fixes the issue in two places:

* When RCU is configured with a free_key_data_func callback,
  rte_hash_add_key_data() now automatically defers freeing the old data
  on overwrite. No caller changes are needed.

* If rte_hash_del_key() fails to enqueue the deleted entry in
  RTE_HASH_QSBR_MODE_DQ, it falls back on RTE_HASH_QSBR_MODE_SYNC to
  avoid leaking slots and data pointers.

v3:

* Use rte_atomic_exchange_explicit() to swap the new data pointer with
  the old one in search_and_update().

* Removed the rte_hash_replace_key_data() API which required to bubble
  a potential old_data pointer from search_and_update() to all
  intermediate callers down to __rte_hash_add_key_with_hash(). It made
  an already complex code even more obscure.

v2:

* New patch to fallback to SYNC mode when DQ fails on delete.
* Check key_idx == EMPTY_SLOT in DQ mode to differentiate when old_data
  is NULL.
* Also fallback to SYNC mode when DQ fails on replace.

Robin Jarry (2):
  hash: avoid leaking entries on RCU defer queue failure
  hash: free replaced data on overwrite when RCU is configured

 app/test/test_hash.c                   | 134 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   7 ++
 lib/hash/rte_cuckoo_hash.c             |  47 +++++++--
 lib/hash/rte_hash.h                    |   8 +-
 4 files changed, 187 insertions(+), 9 deletions(-)

-- 
2.53.0

