Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE0C369C9
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 18:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94BDC402D5;
	Thu, 17 Apr 2025 20:12:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 634E5400D6
 for <dev@dpdk.org>; Thu, 17 Apr 2025 20:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744913538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkcA8Kuvbppdky0CFnGgoX4C8uG1OCijS2wle0KAnz8=;
 b=UsORyaBHoHy/e7VGBlm2BeHan/+gnbtC0ysx7tXVT12SUYBxoMw65IjukjUYpFnc1EHFwO
 YBtFtnp6xfAiAOPLu1qAuYi8aGouH4tutGHuXiooXfZA1Bm+br8ZPrF+mjCkedYd/HRx+d
 NwOj9fX7bryC1z99vMCs+DHzTb6umDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-aHtIZ-QcNaCdI4CUttrG2w-1; Thu,
 17 Apr 2025 14:12:15 -0400
X-MC-Unique: aHtIZ-QcNaCdI4CUttrG2w-1
X-Mimecast-MFC-AGG-ID: aHtIZ-QcNaCdI4CUttrG2w_1744913534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63F251800980; Thu, 17 Apr 2025 18:12:14 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.64.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3888B19560A3; Thu, 17 Apr 2025 18:12:12 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] doc: Document frequency and volume limits on patches.
Date: Thu, 17 Apr 2025 14:12:11 -0400
Message-ID: <20250417181211.727663-1-aconole@redhat.com>
In-Reply-To: <20250305013351.2209789-1-aconole%40redhat.com>
References: <20250305013351.2209789-1-aconole%40redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tx9uBWJEIhebgFdCXhsY9LHesHp3i7M0j2pXSvJllRY_1744913534
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

The DPDK project has two constrained resources - reviewers and
public CI infrastructure.  These are shared among the entire
project, and there are true costs associated with using these
resources.  Thus, there are two motivations behind this change:
  - Encourage developers to spend more time ensuring their
    changes are in a state that things have gone through some
    basic testing
  - Encourage people to give reviews by guaranteeing that the
    time between series is long enough that comments will be
    valid.

We want to document the guidelines for submitting to the list
to encourage more time for reviews, and also encourage
developers to spend a bit more time to put their submissions
in a 'default accept' condition.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
RFC->v1: Incorporate feedback from Thomas.

 doc/guides/contributing/patches.rst | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 8ad6b6e715..e4c593b053 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -644,6 +644,49 @@ environment) by the person named.
 person.
 
 
+Frequency and volume of patches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Please allow at least 24 hours to pass between posting patch revisions.
+This ensures reviewers from different geographical regions have time to
+provide feedback.
+Additionally, please do not wait too long (read: weeks) between revisions
+as this makes it harder for reviewers and maintainers to recall the context
+of the previous posting.
+If you have not received any feedback within a week, it is appropriate to
+send a ping to the mailing list.
+
+Please do not post new revisions without addressing all feedback.
+Make sure that all outstanding items have been addressed before posting a new
+revision for review (this should involve replying to all the feedback).
+Do not post a new version of a patch while there is ongoing discussion unless
+a reviewer has specifically requested it.
+
+Do not post your patches to the list in lieu of running tests.
+**YOU MUST ENSURE** that your patches are ready by testing them locally before
+posting to the mailing list.
+Testing locally should involve, at a minimum, running compilation with debug
+and release flags, and invoking the unit tests.
+Your changes are expected to pass on an x86/x86-64 linux system.
+The infrastructure running the tests is a shared resource among all developers
+on the project, and many frequent reposts will result in delays for all
+developers.
+We do our best to include CI and self-test infrastructure that can be used on
+an individual developer basis.
+
+For details on running the unit tests, see :ref:`Running a test <unit_test>`
+section of the ``unit_test`` documentation.
+It is also recommended to run the **DTS** comprehensive tests.  See
+the ``dts`` guide.
+Finally, you can also push to a branch on the GitHub service to trigger
+a comprehensive set of compile and unit test runs.
+
+Please keep all patch sets to a reasonable length.
+Too many or too large patches and series can quickly become very difficult
+for a reasonable review.
+It is recommended to appropriately split patches and series to groups of
+digestible logical changes.
+
 
 Steps to getting your patch merged
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.1

