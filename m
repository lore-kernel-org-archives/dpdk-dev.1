Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302ECA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0099540DD2;
	Mon, 28 Sep 2026 15:29:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2C98240BA6
 for <dev@dpdk.org>; Mon, 28 Sep 2026 15:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790602174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpkZSzMkklPsaEych4POtZw/J3+UkpO9YzELCqss1U0=;
 b=AtTVKjQvW+Q840mVEUWNvi27J7ja44EZ8CYGtjX7d1L2xfsKWtlfYD4gd/fK+w6EG3YYvG
 cdB7xfbWdSYyb+CSaqNLRaveA9Zaz6s+7rAvdFvGmymbTzkCf6zQPJtGP3awahyrtIFHaN
 ZBNcIf2amyiJw8Top+OzeGlVssakbXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-WIw4iJDhP_ep26DYidjNMA-1; Mon,
 28 Sep 2026 09:29:29 -0400
X-MC-Unique: WIw4iJDhP_ep26DYidjNMA-1
X-Mimecast-MFC-AGG-ID: WIw4iJDhP_ep26DYidjNMA_1790602168
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6D2F187A5F1; Mon, 28 Sep 2026 13:29:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.15])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7660776B; Mon, 28 Sep 2026 13:29:19 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>,
 jasowangio@gmail.com, chenbox@nvidia.com, david.marchand@redhat.com
Subject: [PATCH v2 01/11] build: define __counted_by as empty on unsupported
 compilers
Date: Mon, 28 Sep 2026 15:29:03 +0200
Message-ID: <20260928132913.1376278-2-eperezma@redhat.com>
In-Reply-To: <20260928132913.1376278-1-eperezma@redhat.com>
References: <20260928132913.1376278-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vx6HyYm0XSuNkIcRfqb9xEwl7dhx4xO-wmYblGp_TVU_1790602168
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

__counted_by is a GCC 14 / Clang 18 extension used in imported kernel
uapi headers. Older compilers reject it with an error. Define it as an
empty function-like macro when the compiler does not support it.

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
---
 config/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 344f68822be3..9777713ea434 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -474,6 +474,12 @@ dpdk_arch_headers += files('rte_config.h')
 # specify -D_GNU_SOURCE unconditionally
 add_project_arguments('-D_GNU_SOURCE', language: 'c')
 
+# define __counted_by as empty on compilers that don't support it
+if not cc.compiles('struct s { int n; int a[] __counted_by(n); };',
+        name : '__counted_by support')
+    add_project_arguments('-D__counted_by(a)=', language : 'c')
+endif
+
 # specify -D__BSD_VISIBLE for FreeBSD
 if is_freebsd
     add_project_arguments('-D__BSD_VISIBLE', language: 'c')
-- 
2.55.0

