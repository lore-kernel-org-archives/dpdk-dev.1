Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6BCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 693C942ED1;
	Tue, 29 Sep 2026 18:39:29 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 95D944026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:36 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so2136212b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699916;
 x=1791304716; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYRTEvEe46WC0C+AwHz4YjSYwURJM+70ApF8Le7oqy8=;
 b=VnaziLOmJupNGkdDZ/HrSJ4Ez1mWRC4hah6WTIkAtZiBQ/PbflxCuApEAXYkMk/9Za
 faDt3UcpeLRvOK3QZ72tgoe6AzUSQrIfKp6aXnsAlY4pEAs45PhEPFkIoDf7VgWi9LEk
 s3izRizDC6Pinx0mfiN7hI30mvc5rp5Or4FWtBch/Dsnn7dUccBFo7JNhH0l4C1WZN6n
 UldYegGfaCkhbTGf7m9MgBKD3FsdtZiZLGr6J2HXTseTHdNYQlaXhtDJR1ICiBuKOnkh
 2LlVKaYWFGEChuHcpxMz9qYOlPnh52mpW7K07YCH+UN2df+EX+jia/AT11N5cVXadhtq
 VdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699916; x=1791304716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DYRTEvEe46WC0C+AwHz4YjSYwURJM+70ApF8Le7oqy8=;
 b=l5d4qZULj7Ae4hR8OYfa4sNDiwZEEoRswN1g6KBTBiak0pLuxrtWwPajBXTwx50NjV
 IfwVn2r/mMszvcUK/DjcuUAimaG+qwHHphomfblcQh8u4n8PeF2fJM6NHVGJcIZFbDE2
 r0CwEgmvOamWq/RFn4gQWk8sru3Jjur9xsm2ztxpj1EWqHj1Pn3Txmey8X3ad/UxaL7/
 NiN/gL2j/VQkE+t8BnSb+r66LiWzj6Sq5c3KY9waEUE0YuADkEcWrpK0atpk6WgEqcmJ
 JiFzUKzLyFxa/V5EI0H4RsInDXvPDDuc7iJqpPeILDFYjzBV+jQIfcuh+488EMroi9a0
 opqw==
X-Gm-Message-State: AFuF++lk20UHsMNE/RclKkXiJz0G1cKEnOTEbaV/QRNAZmDwXo5gSbOr
 JxU5Bupv5XH53wKpUYOUFYjebX0DJva0ood1RuDYi9X07vWeRI0TI0kTIqSNU9veOI0TFdq5ThM
 YJOU57Tk=
X-Gm-Gg: AYBFou0bK9yyaj9tLEpziDvgoETujszpbDArQbCJpjV65/L+2hZu1rsbIN8CwaKsL11
 vFXEGar2DiIWDvMhts4wpqLIyenm+xW5+3VGSCLtJgrrcqtLDIRFDTiL+dIGxZTiIq+JyvW7X2F
 9MBiAv10xJTWrUDggRDVFS7zbzjDUOeXlIpiNg9Rgr8uxHOifrjzAYNsBhNmLY+FI5IYlupAU0h
 p4VYc1fhshWBFXb8DnLr9YdqTAkVptSqEXVCfBEgN3v8f7i9rJfGrGrj2zouCvqOi5eych82Kkp
 PzdYcsPkZgtrWY8dVr7Ai6WuloJCUB9lYbBnFhFJB6uJRmO9hG4NuoP3c9+647pLparXuOS21mj
 XDKEIn45c8pEzP5fL0TSlXOJaINvwgHf70zEZ7xHB/wEVRQ6FxZh7jMdwT+hts/NR99YXWz4Q6z
 rCrTPBhnx8YBuy1oBSJjldJGR5F1RXZs12SPu6OyK/P7tV3/E0Yzszzq3/NdYsDoBB/ctzF71Y7
 jLd1sVz9lRYax4tiWNcMjxTxU3j/HWeGMqEyw==
X-Received: by 2002:a05:6a00:2290:b0:881:a443:499b with SMTP id
 d2e1a72fcca58-881a4435b94mr7591121b3a.9.1790699915782; 
 Tue, 29 Sep 2026 09:38:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v2 31/61] net/octeon_ep: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:34 -0700
Message-ID: <20260929163800.1108305-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

parse_flag() uses atoi(), which cannot report an error, so a malformed
value is silently taken as zero. The result was only ever used as a
boolean, so use rte_kvargs_handle_bool() and drop the local handler.

This also accepts the usual spellings such as "on" and "true" in
addition to 0 and 1.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeon_ep/otx_ep_ethdev.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 85b3c09155..3d6521d084 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -29,21 +29,11 @@ static const struct rte_eth_desc_lim otx_ep_tx_desc_lim = {
 	.nb_align	= OTX_EP_TXD_ALIGN,
 };
 
-static int
-parse_flag(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-
-	*(uint8_t *)extra_args = atoi(value);
-
-	return 0;
-}
-
 static int
 otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_epvf)
 {
 	struct rte_kvargs *kvlist;
-	uint8_t ism_enable = 0;
+	bool ism_enable = false;
 
 	if (devargs == NULL)
 		goto null_devargs;
@@ -52,11 +42,11 @@ otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_
 	if (kvlist == NULL)
 		goto exit;
 
-	rte_kvargs_process(kvlist, OTX_ISM_ENABLE, &parse_flag, &ism_enable);
+	rte_kvargs_process_opt(kvlist, OTX_ISM_ENABLE, rte_kvargs_handle_bool, &ism_enable);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
-	otx_epvf->ism_ena = !!ism_enable;
+	otx_epvf->ism_ena = ism_enable;
 
 	return 0;
 
-- 
2.53.0

