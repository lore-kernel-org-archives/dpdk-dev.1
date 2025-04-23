Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001EC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 173F140B9F;
	Wed, 23 Apr 2025 18:00:37 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 366A74042F
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 87F48E0142;
 Wed, 23 Apr 2025 20:00:29 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 87F48E0142
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424030;
 bh=pthlBcaX7RHuhSs1EMdJJaUANWr0OEtXjLWfmoIUb7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xy7OKK9w7H1HahvLIvW0aRXg3ixxKTS9qe6hsx+2IP9vHexF8ob2oB1aZQ0lRzSkP
 TiiSlZNjpEiVxJkeMsZVsTDaKTdXPclSi+EfQvCEYcIUjYL73bS5Ao4hYGrNcv3b6V
 WJLIwOdlbOvJ+oThzdePC4l2KCS9Jxo/hjcOr1PqMS8hY9UOPc87G1OEjxHoBdgXh2
 fXo69n1gHQxuM1Ya4lRidb5DBW770HpzbYwaXfmARbg1KW6rhu6k6afnZqBk/qFfYD
 r9ezQcuP+YU7zYnK91UrA8felrCQ8uX4LU9iThAvOKzxXCx6nvLICCQXX50Cz9X/b2
 oIlj+fYS/uOJw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 21/45] common/sfc_efx/base: obtain assigned netport handle
 from NIC
Date: Wed, 23 Apr 2025 19:59:38 +0400
Message-Id: <20250423160002.35706-22-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

Get an 'assigned' netport handle for the current MCDI entity.
This handle will be used when sending other netport commands.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h |  4 +++
 drivers/common/sfc_efx/base/efx_np.c   | 50 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 9ad973ded7..4952f45121 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -335,6 +335,8 @@ typedef struct efx_virtio_ops_s {
 } efx_virtio_ops_t;
 #endif /* EFSYS_OPT_VIRTIO */
 
+typedef uint32_t efx_np_handle_t;
+
 typedef struct efx_port_s {
 	efx_mac_type_t		ep_mac_type;
 	uint32_t		ep_phy_type;
@@ -378,6 +380,8 @@ typedef struct efx_port_s {
 #endif
 	const efx_mac_ops_t	*ep_emop;
 	const efx_phy_ops_t	*ep_epop;
+
+	efx_np_handle_t		ep_np_handle;
 } efx_port_t;
 
 typedef struct efx_mon_ops_s {
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index abb8e20e4d..404d2887b0 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -41,12 +41,53 @@ efx_np_assign_legacy_props(
 	encp->enc_port = 0;
 }
 
+static	__checkReturn		efx_rc_t
+efx_np_get_assigned_handle(
+	__in			efx_nic_t *enp,
+	__out			efx_np_handle_t *nphp)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_GET_ASSIGNED_PORT_HANDLE_IN_LEN,
+	    MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_LEN);
+	efx_mcdi_req_t req;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_LEN;
+	req.emr_in_length = MC_CMD_GET_ASSIGNED_PORT_HANDLE_IN_LEN;
+	req.emr_cmd = MC_CMD_GET_ASSIGNED_PORT_HANDLE;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	if (req.emr_out_length_used < MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_LEN) {
+		rc = EMSGSIZE;
+		goto fail2;
+	}
+
+	*nphp = MCDI_OUT_DWORD(req, GET_ASSIGNED_PORT_HANDLE_OUT_PORT_HANDLE);
+	return (0);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
 	__checkReturn	efx_rc_t
 efx_np_attach(
 	__in		efx_nic_t *enp)
 {
 	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	efx_port_t *epp = &(enp->en_port);
+	efx_rc_t rc;
 
 	if (efx_np_supported(enp) == B_FALSE)
 		return (0);
@@ -63,7 +104,16 @@ efx_np_attach(
 
 	epp->ep_fixed_port_type = EFX_PHY_MEDIA_INVALID;
 	epp->ep_module_type = EFX_PHY_MEDIA_INVALID;
+
+	rc = efx_np_get_assigned_handle(enp, &epp->ep_np_handle);
+	if (rc != 0)
+		goto fail1;
+
 	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
 }
 
 		void
-- 
2.39.5

