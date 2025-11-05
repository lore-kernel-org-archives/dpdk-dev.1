Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89852CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA52640676;
	Wed,  5 Nov 2025 09:43:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0142340689
 for <dev@dpdk.org>; Wed,  5 Nov 2025 09:43:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762332214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFh0a7Q7N+A6kxwHiIAgk1aNDOBhuOIK+E1SoSHtMUs=;
 b=iZ4tHowawSmkvYpXcMHpoTh5N55Nl6dtu4lzLwKHZrPhMk0s5j6HukzYFUygjViWXT55qu
 Bye9AXAnYSEg/0I4AOGTdrpHFYL+eHVd5PUGHnSADdqepUKutfZm54YCzbgACfDo34Frv2
 tWFUhzZ64YnuSGn9NMzY+pvfpwBFRLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-sk5tm0AvPN2zEahipW3sQQ-1; Wed,
 05 Nov 2025 03:43:33 -0500
X-MC-Unique: sk5tm0AvPN2zEahipW3sQQ-1
X-Mimecast-MFC-AGG-ID: sk5tm0AvPN2zEahipW3sQQ_1762332212
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA151956080; Wed,  5 Nov 2025 08:43:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56F7619560A2; Wed,  5 Nov 2025 08:43:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: sivaprasad.tummala@amd.com, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH 2/2] ci: add dependency in GHA for AMD uncore power driver
Date: Wed,  5 Nov 2025 09:43:09 +0100
Message-ID: <20251105084309.3851898-2-david.marchand@redhat.com>
In-Reply-To: <20251105084309.3851898-1-david.marchand@redhat.com>
References: <20251105084309.3851898-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOvR51e6nQiCTPB6U9LrVT_CqRFG4q2GYStoVGn37I4_1762332212
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

Adding only for Fedora, as I could not find the library for Ubuntu.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index e7090dcee1..39b4275816 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -248,6 +248,7 @@ jobs:
     env:
       build_deps: |
         ccache \
+        esmi_ib_library-devel \
         intel-ipsec-mb-devel \
         isa-l-devel \
         jansson-devel \
-- 
2.51.0

