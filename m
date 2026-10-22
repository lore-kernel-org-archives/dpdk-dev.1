Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E7606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GsxdBuh4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB332406FF;
	Thu, 22 Oct 2026 19:45:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A354F40A73
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWLiDeHo1A8mQs/jr+SyByVYQnC6zQo3TU1q+b4g2go=;
 b=GsxdBuh4rGmddBFvmAvMwdIK7Z2hN1AeQwn6cSxSuoVz2A4Lwpq0arIhQryCuMei28FxjJ
 Crw9PTMk9n3jdhPcOuJwugnr9GfSqqnw4Wgo7fRWKP1HGwYs39KzI0pK54O7XFmPnlx4yB
 rPZ8rDlSb6BIYb+R6TdEWzwhYhHfAcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-_JfdHi7eOm6SB4PJvBuTLw-1; Thu,
 22 Oct 2026 13:45:34 -0400
X-MC-Unique: _JfdHi7eOm6SB4PJvBuTLw-1
X-Mimecast-MFC-AGG-ID: _JfdHi7eOm6SB4PJvBuTLw_1792691133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D3891801352; Thu, 22 Oct 2026 17:45:33 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 620173000738; Thu, 22 Oct 2026 17:45:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Andy Pei <andy.pei@intel.com>, Dan Wei <dan.wei@intel.com>
Subject: [PATCH v3 09/13] doc: fix DCB capability for some Intel drivers
Date: Thu, 22 Oct 2026 19:44:36 +0200
Message-ID: <20261022174447.412638-10-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1DRsT7P5Ei7MlZrho1kZ1ffKiixY4pylrOhc1Fq6C0A_1792691133
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Those drivers never supported DCB.

Fixes: 83a4a15404ef ("doc: fill nics features matrix for e1000/igb and ixgbe")
Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

