Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD72C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D47E42DCE;
	Sun, 18 Jan 2026 20:14:36 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id E46B742DF0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:33 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso449088066b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763673;
 x=1769368473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oepGDxYJE+K5gYpLWVNXI23EojrB4FQSqXKgiSyFKU=;
 b=MmAQXgUGQGex3WUOh5DlLRsuiwLT5MbSLaStw15V58oqvmJhcD4mZS9R+mtiw6F1dJ
 yGx9c6bvTGFMvN1rGUg/PAfrHtInqsyc6yLB5ihvEUyHGnjXrTf8sjRq/MKPKo7OanFa
 9r/o7GhPT59K/PO1YI8cGte7WQPyxVaZW9ihKAgPBpcGTqWs4rSWF27hLiTTXELlBeId
 wh9ozamobn2NuFn18tHyQu3N32Ny2uRXRpvpOySXBLlAR/G5agM86h6vvlTjV6M8wrOQ
 B8EqNMXcZPGoEcaBtZxkmHR0L16W74zNOJGmDwk+Ku2RxZtmEEpLzgALwYoD9tTEoxtS
 mdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763673; x=1769368473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7oepGDxYJE+K5gYpLWVNXI23EojrB4FQSqXKgiSyFKU=;
 b=fgTq5G4u3qR3SUhjv3xz+kKQ7aZPuWliREXR4uKJYGKRXWPGEts3BwuyohoOkT5lCO
 u/6n05Y8/jOnXTIRz42fmCcki8AxxLqsxgIcs6jVd1GUvY2Hdi6WV/TQUxTwyGysKrbN
 3RY8Tpy5735B0koKKVoxaFCkyDZKZYYx5EzWbTQcihlLCyme1YRhqKDR/MvbofhJQHPE
 iRViFsNFb3b6HVwBPZpD0A+4wcDPAFZ99JWnDAjCs+GY/khrOGHq1FWR/jAptpPCYFiF
 2HoON1IcFX+QMLWJdZeCI5Jb0aQ9dJkvaBX9dNOqslDh7L3gWk968wMDM8Xr9ULqytpk
 zIOg==
X-Gm-Message-State: AOJu0YzHYQZQWdyE9BIFfoCOrSUeedyLu2C7+urEl/ZhsaW5NpgcaQZD
 rViBO6kx05jCP51qfAApTDi3U8Z3p3Y6JQhx5qbGkLJD04HHpbkKBPziBMixtppDBqakXiCsdqp
 wjBdy
X-Gm-Gg: AY/fxX4q7gNLvj9I9eR1raHnLUXUyUNNTPKNx5h7tb/DHrWFbp9thBl8JEob56k+vzL
 bZyUDkx189Sf9rP4FOE5F/BFyz509Rl1dmRyWDIA0sRVFfswBURoL6oLVRcK1VMjOF902PpkJEa
 CxNn70RzhsC99WUn0nQv/vwf+YR4mNsMARnpSN6MbS2YlbIGaMJhPEeOeIPKkNPV7v+a2/WyWr9
 qO48UqGE0rofSSdJIwZnseVabAsCvb9l2nzdNl3ICYMEzhe/i5c6kgqYvlc13+E6EQIdtvm+vnZ
 l3hIR9DWQdZKKpNVFwJac39sbG6+DtOIM4/v8Zboj/NPSVH9Qj57qVtjqIh4I4c8AKGc4jwaGik
 EC+cTXOjRMci2peHCRg+PvdVTiN1is/Tt8MW2be+4K9u/OcSaUcO2/hyBQK+PXifE313wMGidub
 Xgnu/acuYDs2r/ZdesVNtx1y93mxMXZG7I9BE3DyR0qIE3R22OWKOajpG4GZ1e
X-Received: by 2002:a17:907:d8f:b0:b84:2075:b902 with SMTP id
 a640c23a62f3a-b8796afc7cemr680854466b.36.1768763673456; 
 Sun, 18 Jan 2026 11:14:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 42/54] doc: correct grammar in PDCP library guide
Date: Sun, 18 Jan 2026 11:10:45 -0800
Message-ID: <20260118191323.241013-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar issues in the PDCP library documentation:

- use "high-performance" instead of nonstandard "high performant"
- add missing articles and fix pluralization for APIs
- use present tense consistently instead of "would" conditional
  since the library is implemented and we're describing current
  behavior
- fix subject-verb agreement in multiple places

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/pdcp_lib.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/guides/prog_guide/pdcp_lib.rst b/doc/guides/prog_guide/pdcp_lib.rst
index 266abb8574..4123dcfde9 100644
--- a/doc/guides/prog_guide/pdcp_lib.rst
+++ b/doc/guides/prog_guide/pdcp_lib.rst
@@ -7,7 +7,7 @@ PDCP Protocol Processing Library
 DPDK provides a library for PDCP protocol processing.
 The library utilizes other DPDK libraries such as cryptodev, reorder, etc.,
 to provide the application with a transparent and
-high performant PDCP protocol processing library.
+high-performance PDCP protocol processing library.
 
 The library abstracts complete PDCP protocol processing conforming to
 `ETSI TS 138 323 V17.1.0 (2022-08)
@@ -34,27 +34,27 @@ to work with cryptodev irrespective of the protocol offload features supported.
 PDCP entity API
 ---------------
 
-PDCP library provides following control path API that is used to
+PDCP library provides the following control path APIs that are used to
 configure various PDCP entities:
 
 - ``rte_pdcp_entity_establish()``
 - ``rte_pdcp_entity_suspend()``
 - ``rte_pdcp_entity_release()``
 
-A PDCP entity would translate to one ``rte_cryptodev_sym_session`` or
+A PDCP entity translates to one ``rte_cryptodev_sym_session`` or
 ``rte_security_session`` based on the config.
 The sessions would be created/destroyed
 while corresponding PDCP entity operations are performed.
 
 When upper layers request a PDCP entity suspend (``rte_pdcp_entity_suspend()``),
-it would result in flushing out of all cached packets and
+it results in flushing out of all cached packets and
 internal state variables are updated as described in 5.1.4.
 
 When upper layers request a PDCP entity release (``rte_pdcp_entity_release()``),
-it would result in flushing out of all cached packets
+it results in flushing out of all cached packets
 and releasing of all memory associated with the entity.
-It would internally free any crypto/security sessions created.
-All procedures mentioned in 5.1.3 would be performed.
+It internally frees any crypto/security sessions created.
+All procedures mentioned in 5.1.3 are performed.
 
 PDCP PDU (Protocol Data Unit) API
 ---------------------------------
@@ -84,8 +84,8 @@ PDCP packet processing API for control PDU
 
 Control PDUs are used in PDCP as a communication channel
 between transmitting and receiving entities.
-When upper layer request for operations such as re-establishment,
-receiving PDCP entity need to prepare a status report
+When upper layers request operations such as re-establishment,
+the receiving PDCP entity needs to prepare a status report
 and send it to the other end.
 The API ``rte_pdcp_control_pdu_create()`` allows application to request the same.
 
@@ -99,13 +99,13 @@ Since cryptodev dequeue can return crypto operations
 belonging to multiple entities, ``rte_pdcp_pkt_crypto_group()``
 is added to help grouping crypto operations belonging to same PDCP entity.
 
-Lib PDCP would allow application to use same API sequence
+Lib PDCP allows the application to use the same API sequence
 while leveraging protocol offload features enabled by ``rte_security`` library.
 
-Lib PDCP would internally change the handles registered
+Lib PDCP internally changes the handles registered
 for ``pre_process`` and ``post_process`` based on features enabled in the entity.
 
-Lib PDCP would create the required sessions on the device
+Lib PDCP creates the required sessions on the device
 provided in entity to minimize the application requirements.
 Also, the ``rte_crypto_op`` allocation and free would also be done internally
 by lib PDCP to allow the library to create crypto ops as required for the input packets.
-- 
2.51.0

