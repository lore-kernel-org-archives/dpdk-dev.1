Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C93EDF148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EDA40431;
	Fri, 13 Feb 2026 11:34:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D2A66402F1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770978894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ7laD5ppTjCrw5NRV3SbCCGtFYljmxd49bx3L6+XfY=;
 b=OJPZvjm7WCJAAxMY4sPjGtZvQaErfI+vd/5KI9r9iS1186t9qnfjGdpRvFDDuuy2ATMPPn
 lWjq+hctL67ubUqMiYxjbvObxGJMsAxY3jhFNbB4lAq/BHQveUz4/S7PZ9Oi0pOc1UCXA0
 /sXWLQvQEbRLJ/TdN6/Ki4CnMefyzNA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-e4Bfs4bmMLaOYnS1sRQRMQ-1; Fri,
 13 Feb 2026 05:34:52 -0500
X-MC-Unique: e4Bfs4bmMLaOYnS1sRQRMQ-1
X-Mimecast-MFC-AGG-ID: e4Bfs4bmMLaOYnS1sRQRMQ_1770978892
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E170018003FC; Fri, 13 Feb 2026 10:34:51 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA7D819560B9; Fri, 13 Feb 2026 10:34:50 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v2 0/3] hash: safe data replacement on overwrite
Date: Fri, 13 Feb 2026 11:34:38 +0100
Message-ID: <20260213103441.1505659-1-rjarry@redhat.com>
In-Reply-To: <20260212213313.1376294-5-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Lbuo-RJSVcmgIkY4RsLtjp0aBdBtYk_KDOdiISNeZA_1770978892
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
  over the old pointer's life cycle. No automatic deferred free is
  performed in that case.

v2:

* New patch to fallback to SYNC mode when DQ fails on delete.
* Check key_idx == EMPTY_SLOT in DQ mode to differentiate when old_data is NULL.
* Also fallback to SYNC mode when DQ fails on replace.

Robin Jarry (3):
  hash: avoid leaking entries on RCU defer queue failure
  hash: free replaced data on overwrite when RCU is configured
  hash: add replace API returning old data on overwrite

 app/test/test_hash.c                   | 214 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  12 ++
 lib/hash/rte_cuckoo_hash.c             | 150 +++++++++++++----
 lib/hash/rte_hash.h                    |  75 ++++++++-
 4 files changed, 415 insertions(+), 36 deletions(-)

-- 
2.53.0

