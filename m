Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC3CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 11:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECFD40678;
	Mon, 22 Sep 2025 13:07:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD12140678
 for <dev@dpdk.org>; Mon, 22 Sep 2025 13:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758539262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZqn0nffLj1S4b8Pjh60cMB3cWF8kq3MzNkBgny1a7w=;
 b=K4b5oRN36zHcwFFn+BbsCNXdIQdBPBSib/VJObdlOMDrTb3zxxRA6WOvMnYoZIy1XEkOHr
 T4g9D5iEkB5XxTJGulfXlKwqCN3fn9FiNp27Mg6LHiVmcUPzmy/3oyE/E43B+Fyqrl8Rat
 WxibWeIBh4O3efVETHFVSWj3koa1e9g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-bt_stEPqMbGGuLncTXUZ-Q-1; Mon,
 22 Sep 2025 07:07:39 -0400
X-MC-Unique: bt_stEPqMbGGuLncTXUZ-Q-1
X-Mimecast-MFC-AGG-ID: bt_stEPqMbGGuLncTXUZ-Q_1758539258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDAA31800366; Mon, 22 Sep 2025 11:07:37 +0000 (UTC)
Received: from rh.Home (unknown [10.44.34.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFB5418004D8; Mon, 22 Sep 2025 11:07:35 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 2/2] build: add backwards compatibility for wildcarding nested
 drivers
Date: Mon, 22 Sep 2025 12:07:08 +0100
Message-ID: <20250922110708.47879-2-ktraynor@redhat.com>
In-Reply-To: <20250922110708.47879-1-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9HVwStuJIbmthoorcE3gA4tqAiyHC-KbakDtWhgilGM_1758539258
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

Up until DPDK 25.03 'net/*' could be used with meson options
enable_drivers or disable_drivers to explicitly enable or
disable all net drivers.

In DPDK 25.03 commit
c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")
moved Intel drivers to 'net/intel/*' and 'net/*' no longer enabled
or disabled the Intel drivers.

Expand wildcards handling to include nested drivers.
e.g. 'net/*' will also enable/disable drivers in 'net/*/*'

This adds backwards compatibility so that so that 'net/*' will
continue to enable/disable Intel and any future nested drivers.

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 3fbf04e1cd..ccd25e4d18 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -58,4 +58,9 @@ foreach driver_type : [['disable', get_option('disable_drivers')],
                     .format(driver, driver_mapped))
             driver = driver_mapped
+        elif driver.contains('*')
+            if driver.endswith('/*') and not driver.contains('/*/*')
+                # for wildcard add nested wildcard
+                driver = driver + ',' + driver + '/*'
+            endif
         endif
         if driver_list_name == 'disable_drivers'
-- 
2.51.0

