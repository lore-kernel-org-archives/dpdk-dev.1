Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB30340659;
	Wed,  5 Feb 2025 17:25:12 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 086B640656
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:06 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2f9d5f6df4cso2357297a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772706;
 x=1739377506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+SIaV/lHu2jExzmnNWYeH0+4AAstRGe4I7fI5Kd3LU=;
 b=oSjjyXRxEoWeIs1hrGfvDmUMBYh5pL5S89OK0HvA/5eEwZIIZo5s8Y2zTvVPPIhe9k
 aN9g40AaPEzujrMjsaXitM1frZnTiF5kmWVthxmRcBHmoFQqXNuM56dR6KfBdiUjoTjR
 CIWEXKfdDQlkep7mIAAgV2Qav+uzK8kptlz+6LW0QB90tISrwVLPUvLp374Bh/XkP/HX
 iCMJsv7nmGKu70xBdyjKTpcVIoBjAlRmNETJZ7d+S/g0B3aRDkLrbxnE+bV6mS+ppmcZ
 3Tva/02DEX0juaGeaTlsld79zz5eZhebqURnc+RgBtvr2z8PoQMeMnaYoxGbkbYQESzX
 nACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772706; x=1739377506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+SIaV/lHu2jExzmnNWYeH0+4AAstRGe4I7fI5Kd3LU=;
 b=ikdKcBsvbzsgmhHW4TBGImeIRiNRTbVDkDqp2JXD4R8qexcuZVYNkZ1rM621gfeRkE
 LIKWqiki+zHi1moH/cYkg62+7NE63lgPXwMIlTVSS2gx7KEyBdKDFgFsT8t9CMuwyYND
 l7fR3tvL5rj/CtS9KvUjv3bstheA+NkLmKgptqWxJ3YmaidSIaoJWkL/v7t0/FaMOH/C
 Kxl2L6PfTawTXetBIyz/+LR4SPlTiAginoryAunCE8Jpa0Jx6zsxrJizBaMHxrqJdpDH
 mZOcxrjAzv2reZcSOY2M1HKcUBBjdLj9RDjoMkjuOmyN/H8FrbShp7GpxIX8gN4r1IeA
 O97g==
X-Gm-Message-State: AOJu0YzKMg6MvV4t78SJz/+fpDwkWSnuhb7tbCoWXQ5x7b7SWy4Ur4p0
 Ja6vJjHWWQRsbxTO1lbgKb/0gxamVBzvE2K9J+0Hc9QJSu9dZfX7xC2GjjXyKCMZfG1MiTR0oa1
 R
X-Gm-Gg: ASbGncvl73UL0Sm7ujk7rGt4+cNIJMEOB4in1FnE5ABXnqwfDOotn8t1lPiBNLktvUA
 6Xvgqulh+n3WYtp2O+nW4Kd3cBVFd5ML/uBphGh21RV85MSPWG9dsc9t2Wq+zr1HzWmUfw1idD8
 227EnzJFONg7Wh1/SigaZ+zl4JeuMzIRfZTemvOAwQOCB/jmOCV23mqBBs6US6KjUvjTI1kueDb
 hrrN6RQUNyveleciw4e/L/FA0+4k43CuQuHyViyjEM4EqdYR4Cy1V2K5GezQZ0ZjuyppMCGmO66
 zvdw/1C4ztCEBEg0Dzr5F20jrQs3FbV2HublbKZCIlA5u0MNaSplsRHoqEgxYJoapeeT
X-Google-Smtp-Source: AGHT+IEocN13XgBIFv9BcSLAp03r01MbPmxt7LzpW3QF2FtMENuJjyA8hx1qH87r7E+eAbUfVwCJEA==
X-Received: by 2002:a17:90a:d604:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2f9e074c788mr4833776a91.6.1738772706100; 
 Wed, 05 Feb 2025 08:25:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rmody@marvell.com,
 stable@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH v3 07/19] net/qede: fix missing debug string
Date: Wed,  5 Feb 2025 08:23:08 -0800
Message-ID: <20250205162448.161161-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The array of debug status strings did not match possible enum
values. Add the missing element and a static assert to make sure
the table has all possible values.

For more complete description see.
Link: https://pvs-studio.com/en/blog/posts/cpp/1176/

Fixes: ec55c118792b ("net/qede: add infrastructure for debug data collection")
Cc: rmody@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 18f2d988fb..1d3147b724 100644
--- a/drivers/net/qede/qede_debug.c
+++ b/drivers/net/qede/qede_debug.c
@@ -4,6 +4,7 @@
  * www.marvell.com
  */
 
+#include <assert.h>
 #include <rte_common.h>
 #include "base/bcm_osal.h"
 #include "base/ecore.h"
@@ -82,6 +83,7 @@ static const char * const s_mem_group_names[] = {
 	"TM_MEM",
 	"TASK_CFC_MEM",
 };
+static_assert(RTE_DIM(s_mem_group_names) == MEM_GROUPS_NUM, "memory group string mismatch");
 
 /* Idle check conditions */
 
@@ -5614,6 +5616,8 @@ static const char * const s_status_str[] = {
 	/* DBG_STATUS_INVALID_FILTER_TRIGGER_DWORDS */
 	"The filter/trigger constraint dword offsets are not enabled for recording",
 
+	/* DBG_STATUS_NO_MATCHING_FRAMING_MODE */
+	"No matching frame mode",
 
 	/* DBG_STATUS_VFC_READ_ERROR */
 	"Error reading from VFC",
@@ -5759,6 +5763,7 @@ static const char * const s_status_str[] = {
 	/* DBG_STATUS_MISSING_TRIGGER_STATE_STORM */
 	"When triggering on Storm data, the Storm to trigger on must be specified"
 };
+static_assert(RTE_DIM(s_status_str) == MAX_DBG_STATUS, "status string table mismatch");
 
 /* Idle check severity names array */
 static const char * const s_idle_chk_severity_str[] = {
-- 
2.47.2

