Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA46C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A5614042F;
	Tue,  6 May 2025 19:41:03 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6D0402EB
 for <dev@dpdk.org>; Tue,  6 May 2025 19:41:00 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQfg6vjZz3QP6;
 Tue, 06 May 2025 17:40:59 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQfg60SXz3wtS;
 Tue, 06 May 2025 17:40:59 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jFuad61oUyrwfDrHjgMMs+2OEwFeXERcLsJXiPiFcQ=;
 b=HbLptHMtUu9ml6VhrlZZHSzCw0LA+cOGF0iDTNo2bJF8SGmUNnBB64EIK/My12A76wz0t/
 dnx/XpyHl+EIfq4FOkoXszM6+7UWkOBZ07/ll2EG5muZdWZAE7NC2+UrvAkFv5GCG5HNq8
 hgEvLT6X9UBb7a7oj2DvcDHq1X/M/lS1lwTiNsT1SISBxCn9AqNvmkG1pohwhegieJsr3/
 znpLBC7LRAN2XFn83OUBgp+QcbBXdog4CSjM916yroQoIRhWbnccWPTyJek6PDxMtTwm3Y
 E3dOvFGfex6okD7tPyODrro5yUxjEyiHIY68jJvw8+r2aYjpIsMkoNKZl5YYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jFuad61oUyrwfDrHjgMMs+2OEwFeXERcLsJXiPiFcQ=;
 b=WmhhSdlCYvtPWrPlB/EfnUeHElCxqw0iaiTeVRjkgkepepD3LuekXsG4G+bjXre20MZZTt
 3Op+zPndZPMOVFqCf3aXDbJlz7CNwgCmt6xMyzDOVRcoOtYt+/+6wR0bRYFMyLdXkw/I5/
 Dk9GjqNUQgYrz3UY31JHAn+DHy2WjGnk++wx/k2rETBDWGgzBkddXwcF03u3ew6j0L3MF9
 XknKzrp6pjvytWqnCf8q9iDESY4ECt7nnbRi12yatpSlRDB5V0/KBELNDmPkd/6FXQ5qMb
 ukASR/PA8kRw+tJ2Rc5Wosz/hOg23lF+w0WPo/Y32SxFvA6HIHCq00gDy1hDEg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553259; a=rsa-sha256; cv=none;
 b=my9GwrjUWxUcUtV5tcXjMq0nDnLAPBL6kocWqjWO8QCtvL3OndbMCajL2lKoeCWhFkX5RL
 dCJSe4kMFn7jsUo4UR/Nam60NrgCFAph3rTcCrbOqsehk/yclYzCXuB2OgMD4cN4bUI6wo
 1xTl9XGfgXnYNys9JOb/B3zwmA+75bSKD1w1b7KoKpGH+rTbSnM2s8ADfRw2O3bWefwLDP
 MaxpsIwfYQIKGXYkZbz7XksFqtBH9/FkJoCbZYb6p9vbjKS8y7JlGeVCPYuTVlmZbyjiRR
 ShUJZcjZOSgKagmLfigDjAAHeOVcaqaeS0W6NaLLPNZTxzg0hYxKQ/AhHWBAhA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQff50Bxztg8;
 Tue, 06 May 2025 17:40:58 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 3/4] bus/pci/bsd: Eliminate potential overflow
Date: Tue,  6 May 2025 12:40:43 -0500
Message-ID: <20250506174046.1136711-4-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506174046.1136711-1-jfree@FreeBSD.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
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

When calling rte_pci_write_config(), use memcpy(3) to copy @len bytes
of @buf into local memory instead of casting it to a uint32_t pointer
and dereferencing it. This prevents us from reading data outside of
@buf in the case that @buf has a length less than 32 bits.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 drivers/bus/pci/bsd/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 0581daf130..c64cd2c86c 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -467,7 +467,6 @@ int rte_pci_write_config(const struct rte_pci_device *dev,
 			.pc_func = dev->addr.function,
 		},
 		.pi_reg = offset,
-		.pi_data = *(const uint32_t *)buf,
 		.pi_width = len,
 	};
 
@@ -476,7 +475,7 @@ int rte_pci_write_config(const struct rte_pci_device *dev,
 		goto error;
 	}
 
-	memcpy(&pi.pi_data, buf, len);
+	memcpy(&pi.pi_data, buf, MIN(len, sizeof(pi.pi_data)));
 
 	fd = open("/dev/pci", O_RDWR);
 	if (fd < 0) {
-- 
2.47.2

