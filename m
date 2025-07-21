Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299F6C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DAD402DC;
	Mon, 21 Jul 2025 17:44:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D4A640297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753112654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0jMgBW2RPLj/J9JiQbNk4VPl/maKBQeoFEGFzU8XF2k=;
 b=EnlkwGMn1kaK6zthbmMJ73Yx2pZVYR3bzwyYvICGcZkj9x09V9FpnhQBhrrlESShin5Ukr
 QrBdJQlGCI2vlWgydl23mo4JiFHa+7Mav8cvFPFmW+e6QyLumBlJlpL4HQNfNYVFqXiw54
 s8hwSE/mlkOBPBlJ834ii9P80B0j1Ic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-lP3IQ74JPiO0iQM6HZnmBQ-1; Mon,
 21 Jul 2025 11:44:10 -0400
X-MC-Unique: lP3IQ74JPiO0iQM6HZnmBQ-1
X-Mimecast-MFC-AGG-ID: lP3IQ74JPiO0iQM6HZnmBQ_1753112650
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA24E1800C3F; Mon, 21 Jul 2025 15:44:09 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78A2618002B6; Mon, 21 Jul 2025 15:44:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH] mailmap: keep only one name per contributor
Date: Mon, 21 Jul 2025 17:44:01 +0200
Message-ID: <20250721154403.2688034-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XUxe_p_5_EJUbaf1tWYIoRcKt36Y7oCzaBiGdRWu5x8_1753112650
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Some duplicates have slipped in the mailmap file.
Clean this up.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .mailmap | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 75e550e47a..656fcf826a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -488,7 +488,6 @@ Gaurav Singh <gaurav1086@gmail.com>
 Gautam Dawar <gdawar@solarflare.com>
 Gavin Hu <gahu@nvidia.com> <gavin.hu@arm.com>
 Gavin Hu <gahu@nvidia.com> <gavin.hu@linaro.org>
-Gavin Li <gavinl@nvidia.com>
 Geoffrey Le Gourriérec <geoffrey.le_gourrierec@6wind.com>
 Geoffrey Lv <geoffrey.lv@gmail.com>
 Geoff Thorpe <geoff.thorpe@nxp.com>
@@ -704,7 +703,6 @@ Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>
 Jian Wang <jianwang@trustnetic.com>
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>
 Jianfeng Tan <jianfeng.tan@intel.com>
-Jiang Yu <yux.jiang@intel.com>
 Jiangu Zhao <zhaojg@arraynetworks.com.cn>
 Jianping Zhao <zhao305149619@gmail.com>
 Jianwei Ma <jianwei.ma@intel.com>
@@ -767,7 +765,6 @@ Joongi Kim <joongi@an.kaist.ac.kr>
 Jørgen Østergaard Sloth <jorgen.sloth@xci.dk>
 Jörg Thalheim <joerg@thalheim.io>
 Joseph Richard <joseph.richard@windriver.com>
-Josh Hay <joshua.a.hay@intel.com>
 Josh Soref <jsoref@gmail.com>
 Joshua Hay <joshua.a.hay@intel.com>
 Joshua Washington <joshwash@google.com>
@@ -1862,7 +1859,6 @@ Yuying Zhang <yuying.zhang@intel.com>
 Yu Zhang <zhangyu31@baidu.com>
 Yvonne Yang <yvonnex.yang@intel.com>
 Zaiyu Wang <zaiyuwang@trustnetic.com>
-Zalfresso-Jundzillo <marekx.zalfresso-jundzillo@intel.com>
 Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
 Zengmo Gao <gaozengmo@jd.com>
 Zerun Fu <zerun.fu@corigine.com>
-- 
2.50.0

