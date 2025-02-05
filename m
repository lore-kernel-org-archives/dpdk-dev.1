Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755FC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62A2B40BA5;
	Wed,  5 Feb 2025 17:25:51 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 990D440657
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:48 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso4125804a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772748;
 x=1739377548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WEmMwDvQTZJAP5rJn4dTAdKUMhak8r26KimFBXN/Uc=;
 b=Q2gKA6lJ45Y+0fRGJnEASGyTScXe6OjGV43yLqSTDSaSRY4wK3Cv4c1fuarN35S/Eh
 l3A0dkEAqYwFx10UrYudOHQvhunYWZh9hCKWt2inAqtKeaig+EiFjyA5hMnAwKXjkiId
 hVZ0ZGxZmltrxzWKkiMUj3BgEFEtBypvHXYFmd5HofzUcd37HOErmuRJGxXssBih7keM
 OnAaZ6e6TRLefUgwKTxz8fx+K/3x0/s5lncjLc9I+Swa2SHOjhraggT4gJoY89W4RR3I
 OXYni1+kUwl+tAZk24PLdqMzCgm6gTPDXoSneRmnhuKWG0pi1O3TuFyRqxpYuz/BS0dR
 jEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772748; x=1739377548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WEmMwDvQTZJAP5rJn4dTAdKUMhak8r26KimFBXN/Uc=;
 b=CJ5Utz5nePmXAYVYnRhBroj0d0HgR7yXfdVo2zVGp2njBfSkr+nu7uTXr3gJ74f70Q
 zlFvLZfha6FDA9ePV9OMk6i6WwrnoDuHpuZ+UDNbX9ZmWC2B7CmQtMYjWeQyDoX/8uEC
 mpEb99d7a6a4F6WRfxhownrvfwCQ2E0t8xS6neJ9ZE3TUA+s5QJvEANBsB9NlQQrR1iF
 bA2STUMrjQig0YJ9CrUNZgccVGPmLWcPXoY4kPtNLs8Bd3xxF26BFTMWEBN2xwiANc2V
 KOF8RPviLAb4RvmaMOrWfAIQ4D281sMesimBxnEqJXXcPzalCJBqp8aPQjuyB7R07UVH
 ZlhQ==
X-Gm-Message-State: AOJu0YxEDxWnryC0Uouy6yInvkUKsIbK9LSgFptiHAbSUAEZDXt4M0P/
 DPQD10LDb1+I5GCzkLc0fdCtDyDekG1b3HEFPq52Jnt/7/bp9vmKQzGGgBR0KYLjs2FUD06mA7L
 p
X-Gm-Gg: ASbGncuWh2bd75v1U1zh9jPHWTxocFDFN8LsNzPiYTbhmoBDxRZB/+ZO3pgAigLVT4x
 yzLvOFk15JBThMEutdEN7iFhj8iA9aXQg6CqDJb8z77l6V37Rp+g8gR275O9CCm9HXZgHeBG8Lh
 Zm6aNMgXwEt8CZ7G+SkZJV3EQu9XTmi3QAJBH8frELVr8FjrjAAa/c3HKswQIq2+TWf+pRDTG4m
 FIfKUO+lE92R3qj5e8YkAejImg0myz9CiR5W3YdJpFhR/D6RD9RQFNidIraag/uT8XwpxTtrcxJ
 Lf9ZqdOh5Nc40Gn/KfPPjDunR833AhL5ETMl0ALd3TJ9GXTbl6EDCSaAD/0/GrJVYSLi
X-Google-Smtp-Source: AGHT+IGICEXF1eAs42nuOqiiu7LOKSySGbrVaRZA4UeVzjlmk29fVK9QszHKFP6v3WUBD1+h+Ew55Q==
X-Received: by 2002:a17:90b:48cc:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f9e0810794mr4657992a91.26.1738772747765; 
 Wed, 05 Feb 2025 08:25:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rasesh.mody@cavium.com,
 stable@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v3 17/19] net/qede: don't use same loop variable twice
Date: Wed,  5 Feb 2025 08:23:18 -0800
Message-ID: <20250205162448.161161-18-stephen@networkplumber.org>
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

Using variable in outer loop, and inner loop is obvious bug.
This bug is in base code, so likely on other platforms as well.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/
Fixes: 81dba2b2ff61 ("net/qede/base: add LLDP support")
Cc: rasesh.mody@cavium.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/base/ecore_dcbx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/qede/base/ecore_dcbx.c b/drivers/net/qede/base/ecore_dcbx.c
index 31234f18cf..72bbedd65a 100644
--- a/drivers/net/qede/base/ecore_dcbx.c
+++ b/drivers/net/qede/base/ecore_dcbx.c
@@ -1363,7 +1363,7 @@ ecore_lldp_mib_update_event(struct ecore_hwfn *p_hwfn, struct ecore_ptt *p_ptt)
 	struct ecore_dcbx_mib_meta_data data;
 	enum _ecore_status_t rc = ECORE_SUCCESS;
 	struct lldp_received_tlvs_s tlvs;
-	int i;
+	int i, j;
 
 	for (i = 0; i < LLDP_MAX_LLDP_AGENTS; i++) {
 		OSAL_MEM_ZERO(&data, sizeof(data));
@@ -1381,9 +1381,9 @@ ecore_lldp_mib_update_event(struct ecore_hwfn *p_hwfn, struct ecore_ptt *p_ptt)
 		if (!tlvs.length)
 			continue;
 
-		for (i = 0; i < MAX_TLV_BUFFER; i++)
-			tlvs.tlvs_buffer[i] =
-				OSAL_CPU_TO_BE32(tlvs.tlvs_buffer[i]);
+		for (j = 0; j < MAX_TLV_BUFFER; j++)
+			tlvs.tlvs_buffer[j] =
+				OSAL_CPU_TO_BE32(tlvs.tlvs_buffer[j]);
 
 		OSAL_LLDP_RX_TLVS(p_hwfn, tlvs.tlvs_buffer, tlvs.length);
 	}
-- 
2.47.2

