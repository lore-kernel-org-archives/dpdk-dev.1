Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A1C44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E594026C;
	Wed, 21 Jan 2026 11:01:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27502400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768989700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dwyXVeVI5ukDwTPIs2USeTXbcjNtJhHf5H6Zb7ljCbk=;
 b=Mj3EyFONUqT9b/pn/KeIDPp+37+KALjXsvzTRZqYZCzrL05jnN8W1i2YPMHju+MGJ1ldCQ
 hO3e1qMgzJb0RRv2hJbRW8njYeP+ICZV8pqR5FtYHnGuWDQ/dL7EjxveFGcX35aHX0Pt32
 dkI0DlhY4jVZkd7wT0TxFkW20YWjH3Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-a90FOt_4OAiU42zwgyfkYA-1; Wed,
 21 Jan 2026 05:01:38 -0500
X-MC-Unique: a90FOt_4OAiU42zwgyfkYA-1
X-Mimecast-MFC-AGG-ID: a90FOt_4OAiU42zwgyfkYA_1768989697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CF351955DD5; Wed, 21 Jan 2026 10:01:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.231])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24C48180049F; Wed, 21 Jan 2026 10:01:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: probb@iol.unh.edu,
	bruce.richardson@intel.com,
	thomas@monjalon.net
Subject: [PATCH] doc: raise an error on warnings for dts
Date: Wed, 21 Jan 2026 11:01:27 +0100
Message-ID: <20260121100127.1701459-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: taB5FxYNGvYu82iFNKL6pJ-J_Qk-SLz_irqzX5K4tOA_1768989697
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

Similarly to commit 6572fc926037 ("doc: make sphinx comply with ..."),
pass -W to sphinx to catch warnings.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/api/dts/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/api/dts/meson.build b/doc/api/dts/meson.build
index 8a6d061879..fc147f13f3 100644
--- a/doc/api/dts/meson.build
+++ b/doc/api/dts/meson.build
@@ -12,6 +12,9 @@ if python_ver_satisfied != 0
 endif
 
 extra_sphinx_args = ['-E', '-c', join_paths(doc_source_dir, 'guides')]
+if get_option('werror')
+    extra_sphinx_args += '-W'
+endif
 
 # DTS docs are generated inside main Doxygen docs build directory
 # DTS docs relies on main docs to install it so does not define install dir
-- 
2.52.0

