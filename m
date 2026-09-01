Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90536C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:32:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6435340DD0;
	Tue,  1 Sep 2026 22:32:39 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 265AA40BA6
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:38 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso324216b3a.2
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294757;
 x=1788899557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3UcY1AiVyT0fnXQ5SO5bzTH5aalJfeMNAgxsie3eXc=;
 b=fWxK6ASv52Bfx3vluMZ5sAUHjSkBjLuIchtYJvpQkBzpkEf1hCkdSHUdhEd+OA+5EX
 qeuWWGNlq46H8c2Z1VT4sPqK+dbr5Q+5DL/Y2rYh+8IWUGENuFHvw/MmWVq73RMjrW1+
 DsYEXM6z/XWkzgY/4DR9wWBZnWt+7hvdg9777uAn2yGlnm0jf+nHNrMBRnPenj8fCw+Y
 M08cLo1E+AjbmGccAooMWKyZCNwz6qyy+xRA/ajxUUcNUTiwpTM9Xgvmz3EweJ8mEKAa
 fmMPiq/NOjY9oso7p12LtP5Oqm27tDkvYgssCbZvSfKJU/i1LaxeiTdR9uUCUT6MdfsN
 QNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294757; x=1788899557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l3UcY1AiVyT0fnXQ5SO5bzTH5aalJfeMNAgxsie3eXc=;
 b=bl9BYwn2lB0EnvTzVD/dyGZhfA2+bbW3IIpoTq8GdNAzjnuclADAwaBE7AqkkS7LCw
 sc7ribwBWKXACR6O5EcQZvn1nujGhPNngZH9xziREv4uZrlveIGq4OCwLj3jUXcPsop/
 3QMKyVeBeK0S+xlB3iOWYpNssgIMFl2dP3wfOkLcykiC1R2QO9xr1uKKOsUodeLK4TOH
 VncOqNNOwOApJFz3PfAZ02mvAciwNcrCwD+sR3l7I9sjevSiChAl12W6Bc1pCp0ZfDqk
 4hXw4Dsatd3GcV7cwYkaa4DtzklCN38OAbYUWR2GGCoRW7j+JTAkwWbD1YpM1Ns9IpBt
 MqLg==
X-Gm-Message-State: AFuF++mOa0hHPLmc3gJ+Oz6X4/PnllrzrnwJo4P7l+CR71arCQaBasFr
 hgsm4lCHmzm6yA93UheX5ZxupVyZjXyyAeTP1UBJUAnlS5Rpw1uGeZ6cBKIAVpKnCXtpy3vicqx
 Ff2Vb
X-Gm-Gg: AR+sD1022gCoXzJOeKuE9hKW6Tk89ZzbeiQxrlkioTKgntFVdK0iNoiQfTSmYyDXdl7
 O4x7857W/vY5PGfqrewXjp14qJ/kXK0VMBmrfkxnSni13Cmcqr8+F4QyYCah9FWftlCwZyRMe5v
 tgREqDZPNrXVD90Al475eldMuzsyhyktxNvBT//ChZ8ymnsJ8UPtwQc6E/IzgvrinnKbDvZGxBr
 q8Esd6gEAdziot55tzp4a7mrsAhi8QiWOHVeUPXewaTSWRQFdY9Cfc8bPGkpqhi1M6Jdv/VFs0S
 KZ5xy76HTYJTWuCuVbkTCnXgg/r8zCg3PLUwyzZNwHK6+jG1RxX4jlHODme6dRCnDfQxo1sOs6b
 S5VZk7JMal/RECegggX8e4Hutwt2FrGq2yi3xK5O2mVHt+A79fpDpDetAbFsM7MoxZARfjOwAw7
 uS3k49Hdf5bk8fhhHNWXR6ZrEuqPMA4PIVmGLkJuHZOascdCws9nNRKeGVH2F/bc0WbzmD5QZQp
 yhvsG9KiB++L8AR8d1VYCKcQlFZk/KpFKycIg==
X-Received: by 2002:a05:6a00:3403:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-85ed9dad118mr403414b3a.22.1788294757092; 
 Tue, 01 Sep 2026 13:32:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 02/22] ethdev: promote module EEPROM API to stable
Date: Tue,  1 Sep 2026 13:23:01 -0700
Message-ID: <20260901203217.1485915-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

rte_eth_dev_get_module_info() and rte_eth_dev_get_module_eeprom()
were added in v18.05 to report SFF module identification and dump
the module EEPROM. Both are widely implemented by PMDs and their
signatures have not changed since they were introduced.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/ethdev/rte_ethdev.c                | 4 ++--
 lib/ethdev/rte_ethdev.h                | 8 --------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 03d4eaba40..8c533d87e8 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -98,6 +98,7 @@ API Changes
 * ethdev: Promoted the following API from experimental to stable:
 
   * meter (MTR) and policing: ``rte_mtr_*``
+  * SFF: ``rte_eth_dev_get_module_info`` and ``rte_eth_dev_get_module_eeprom``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..78ad12c2c0 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6952,7 +6952,7 @@ rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_info, 18.05)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_module_info)
 int
 rte_eth_dev_get_module_info(uint16_t port_id,
 			    struct rte_eth_dev_module_info *modinfo)
@@ -6979,7 +6979,7 @@ rte_eth_dev_get_module_info(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_eeprom, 18.05)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_module_eeprom)
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id,
 			      struct rte_dev_eeprom_info *info)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..7f0333cbd1 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5392,9 +5392,6 @@ int rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
 int rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the type and size of plugin module EEPROM
  *
  * @param port_id
@@ -5409,15 +5406,11 @@ int rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int
 rte_eth_dev_get_module_info(uint16_t port_id, struct rte_eth_dev_module_info *modinfo)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the data of plugin module EEPROM
  *
  * @param port_id
@@ -5433,7 +5426,6 @@ rte_eth_dev_get_module_info(uint16_t port_id, struct rte_eth_dev_module_info *mo
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	__rte_warn_unused_result;
-- 
2.53.0

