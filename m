Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704D8CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 12:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1712740289;
	Wed, 24 Sep 2025 14:34:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 408084027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 14:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758717278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/j3PmgInjw6oHBR1hSJgNap0D3//aEFc72fKFXtCQI=;
 b=BDtHWiwORkDog/xZjv7tlW2CIrT3SwLScZqvJQxLXuOda5WrY29BhnKAq+pKCZHSiCmgNH
 T2wgm/mxAFgeApim1LcoIKvL+w4oIgRRJ+JtfvF+rAnWd78rZuNYKmY0xEwSIBqeDJhc5I
 E3g7kaVHb69jognn8jrw/O6BxJHwzVg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-sikEndt6NZye6IulbOKL1Q-1; Wed,
 24 Sep 2025 08:34:35 -0400
X-MC-Unique: sikEndt6NZye6IulbOKL1Q-1
X-Mimecast-MFC-AGG-ID: sikEndt6NZye6IulbOKL1Q_1758717274
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7145F180034C; Wed, 24 Sep 2025 12:34:34 +0000 (UTC)
Received: from rh.Home (unknown [10.44.34.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA9E91800447; Wed, 24 Sep 2025 12:34:31 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v2 0/2] build: add backward compatibility for nested drivers
Date: Wed, 24 Sep 2025 13:34:20 +0100
Message-ID: <20250924123422.224988-1-ktraynor@redhat.com>
In-Reply-To: <20250922110708.47879-1-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 710nkvCw0ZwhJ-NA2ZE4SM7pqpRjcWdIhDB8HW_gPYA_1758717274
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

