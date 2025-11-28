Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6BD116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06C00402BB;
	Fri, 28 Nov 2025 14:57:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B42C54060F
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbYQKd3oMqafzQVunXUShk3Km5P4LwbUuc14XkCMEV8=;
 b=E2MiFzBBeOjwmvlc2W+f+d7THY11xjDaOBOM9kFdK5j5RdC/MCk1LdPlvBezpH/ZvQRSAH
 Bii4q+fDK2/lbJi6GjDXMIFCnU+MHJOpV/RIJ4Wb9VRhfYUdVKFNcuEdNrd/gBQnLdoedt
 KHEAabMVks0EIizyaPP4z95n+XJ8BPc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-IQ0M0639MP292-Y90tXAtw-1; Fri,
 28 Nov 2025 08:56:58 -0500
X-MC-Unique: IQ0M0639MP292-Y90tXAtw-1
X-Mimecast-MFC-AGG-ID: IQ0M0639MP292-Y90tXAtw_1764338217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFFEE1800350; Fri, 28 Nov 2025 13:56:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 890CB19560B0; Fri, 28 Nov 2025 13:56:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Roman Korynkevych <romanx.korynkevych@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH 7/7] app/procinfo: fix const pointer in collectd format
Date: Fri, 28 Nov 2025 14:56:15 +0100
Message-ID: <20251128135616.2662164-8-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oVzIKWhE4JmaxgM9ggCEH2AN67a76vezcSh63EPeALQ_1764338217
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

With latest glibc (Fedora Rawhide):
../app/proc-info/main.c: In function 'collectd_resolve_cnt_type':
../app/proc-info/main.c:689:26: warning: initialization discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  689 |         char *type_end = strrchr(cnt_name, '_');
      |                          ^~~~~~~

Fixes: 2deb6b5246d7 ("app/procinfo: add collectd format and host id")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/proc-info/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index b09c03ab35..5925bbb765 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -686,7 +686,7 @@ nic_stats_clear(uint16_t port_id)
 
 static void collectd_resolve_cnt_type(char *cnt_type, size_t cnt_type_len,
 				      const char *cnt_name) {
-	char *type_end = strrchr(cnt_name, '_');
+	const char *type_end = strrchr(cnt_name, '_');
 
 	if ((type_end != NULL) &&
 	    (strncmp(cnt_name, "rx_", strlen("rx_")) == 0)) {
-- 
2.51.1

