Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11573606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dOZi6puz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2179F40A8A;
	Wed, 21 Oct 2026 12:31:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8764B40B8C
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRvKgXUfA1ylh9VXH3+a1biP7wXDgIoW2kDCuw4wsFM=;
 b=dOZi6puzsF1P1Kmv2MfmoeaH7yPXIFq62QK6T2fLzaw8qP4WKwFfEsKZNv7p2VvHF/dSRT
 HgjpGYb5KbAa8BFfWKR9LcSIhLa5DdtQGktiDuRGKo0MHvcHBScQVswbW9kDi5AoGwvjcM
 vdOmV9PStK6PdiGA4f1cZVY18bfvydw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-7EV1mCL2MXqY9WFGNnYPYQ-1; Wed,
 21 Oct 2026 06:31:06 -0400
X-MC-Unique: 7EV1mCL2MXqY9WFGNnYPYQ-1
X-Mimecast-MFC-AGG-ID: 7EV1mCL2MXqY9WFGNnYPYQ_1792578665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A1E81800660; Wed, 21 Oct 2026 10:31:05 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F4831956087; Wed, 21 Oct 2026 10:31:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Rosen Xu <rosen.xu@altera.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Dan Wei <dan.wei@intel.com>,
 Andy Pei <andy.pei@intel.com>
Subject: [PATCH v2 08/12] doc: fix DCB capability for some Intel drivers
Date: Wed, 21 Oct 2026 12:30:22 +0200
Message-ID: <20261021103027.2050351-9-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSmD3oFqmcaisuBTikUYOXRLsGbSx_7-qzOW_Mt4F9g_1792578665
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Those drivers never supported DCB.

Fixes: 83a4a15404ef ("doc: fill nics features matrix for e1000/igb and ixgbe")
Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/nics/features/igb.ini    | 1 -
 doc/guides/nics/features/ipn3ke.ini | 1 -
 2 files changed, 2 deletions(-)

diff --git a/doc/guides/nics/features/igb.ini b/doc/guides/nics/features/igb.ini
index 4ee500e114..451cf30948 100644
--- a/doc/guides/nics/features/igb.ini
+++ b/doc/guides/nics/features/igb.ini
@@ -20,7 +20,6 @@ RSS key update       = Y
 RSS reta update      = Y
 VMDq                 = Y
 SR-IOV               = Y
-DCB                  = Y
 VLAN filter          = Y
 Flow control         = Y
 CRC offload          = Y
diff --git a/doc/guides/nics/features/ipn3ke.ini b/doc/guides/nics/features/ipn3ke.ini
index ba43b9d91c..6abaf9e4f9 100644
--- a/doc/guides/nics/features/ipn3ke.ini
+++ b/doc/guides/nics/features/ipn3ke.ini
@@ -19,7 +19,6 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 SR-IOV               = Y
-DCB                  = Y
 VLAN filter          = Y
 Flow control         = Y
 Traffic manager      = Y
-- 
2.54.0

