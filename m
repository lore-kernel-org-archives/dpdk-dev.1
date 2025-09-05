Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D6CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 14:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 938064064E;
	Fri,  5 Sep 2025 16:45:27 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1106E402E5;
 Fri,  5 Sep 2025 16:45:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.74.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 22CB9E0F3F;
 Fri,  5 Sep 2025 18:45:24 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 22CB9E0F3F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1757083524;
 bh=x6jtXHm3/U+tsNuVsxIll5L5u5Fq1uFt7v61WIFlMe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o53nGuLpBqh7p1//ywR2XfAw0GDzmCPMc2+8VCGmw7qj1Lp/jkzSyiPbllkHVyCS7
 5595HrvFJjJJ1oZBWCRKsO3wt4UEQak6V5anEWU6SUsxIUMe/3Qjf6gnFOVNk9SIS+
 EVpHUySWD93Fmvciftz2Jx3xateV6iCMN1Z9CvtgKdwh6Q3qTmMRGIvtinj2YjfJwl
 /ugdrlZHbf5e7FQYqKdeUxfXdAiwVN+9EJuetYr4iUfNKph17GHZoy1ojvJb2BFzDe
 fY4gIF67C1SYXOgv3MUZdpob4L3FTO4y3CYQZrKytCkJ4n8LngwPO0IjrAS7cZgzzl
 NfwfYvyTuDj5g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 2/4] common/sfc_efx/base: default to auto fcntl with netport
 MCDI
Date: Fri,  5 Sep 2025 18:45:12 +0400
Message-ID: <20250905144514.11698-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905144514.11698-1-ivan.malov@arknetworks.am>
References: <20250905144514.11698-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
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

Doing so helps to avoid lengthy link renegotiation at start of day.

Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 599daa7a60..69a5a75b6c 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1023,6 +1023,9 @@ efx_np_attach(
 
 	epp->ep_mac_pdu = ms.enms_pdu;
 
+	/* For faster link up, use autoneg. flow control by default. */
+	epp->ep_fcntl_autoneg = B_TRUE;
+
 	/* Subscribe to link change events. */
 	rc = efx_np_set_event_mask(enp, epp->ep_np_handle, B_TRUE);
 	if (rc != 0)
-- 
2.47.2

