Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE438CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 10:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1190040669;
	Mon, 29 Sep 2025 12:05:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 49E9E4028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 12:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759140341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnY0h3XGJlKhUAUNBub5XsjHwS6SSW/5nZQdImcCfks=;
 b=YeTYkITxF2Gr/1AgyIz4/M+m4Ss6UPCkGeOMJi3eQ1JqiXsMDrFlovrt5eyb73KDRrFupC
 uRJhDS0+I1D0bz36lZv/vgDm/VZvCWE4NMWEYlvIgcEOna0Pg95tp7XiY3/IECWO1ua7DJ
 MzG/u/bXGcj9+JILOYPYnwEfQTfKRRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-1RXLv-w0P-CBz1_ZmWgagw-1; Mon,
 29 Sep 2025 06:05:38 -0400
X-MC-Unique: 1RXLv-w0P-CBz1_ZmWgagw-1
X-Mimecast-MFC-AGG-ID: 1RXLv-w0P-CBz1_ZmWgagw_1759140337
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43B73180048E; Mon, 29 Sep 2025 10:05:37 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D19319560A2; Mon, 29 Sep 2025 10:05:34 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, david.marchand@redhat.com, thomas@monjalon.net,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v3 0/2] build: add backward compatibility for nested drivers
Date: Mon, 29 Sep 2025 11:05:26 +0100
Message-ID: <20250929100528.18365-1-ktraynor@redhat.com>
In-Reply-To: <20250924123422.224988-1-ktraynor@redhat.com>
References: <20250924123422.224988-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o7uYvM67dM8a5FlH6IobORVpDgjlboH7kpyWjGVJc-E_1759140337
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

Since Intel drivers moved from 'net/*' to 'net/intel/*' there are some
changes required when enabling or disabling those drivers from the meson
command line. e.g. 'net/ixgbe' no longer works and needs to be replaced
by 'net/intel/ixgbe'

These patches are to allow backwards compatibility for legacy driver names
and wildcarding of nested drivers e.g. 'net/ixgbe' and 'net/*'

v3:
1/2
- update commit message as the warning was removed in v2

v2:
1/2
- removed deprecation warning
- simplified loop and updated comments
- added Fixes tag
2/2
- Updated list-dir-globs.py to allow recursive wildcards
- simplified to use '**'
- added Fixes tag

Kevin Traynor (2):
  build: add backward compatibility for nested drivers
  build: add backward compatibility for wildcarding nested drivers

 buildtools/list-dir-globs.py |  2 +-
 drivers/meson.build          | 43 +++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.51.0

