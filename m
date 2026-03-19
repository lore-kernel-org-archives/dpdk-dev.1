Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4414E109023F
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 15:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D303402BD;
	Thu, 19 Mar 2026 16:55:40 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 83ACC4025D
 for <dev@dpdk.org>; Thu, 19 Mar 2026 16:55:39 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4C5FA205CA
 for <dev@dpdk.org>; Thu, 19 Mar 2026 16:55:39 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7] eal/x86: optimize memcpy of small sizes
Date: Thu, 19 Mar 2026 16:55:37 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A9@smartserver.smartshare.dk>
In-Reply-To: <20260220110824.235784-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] eal/x86: optimize memcpy of small sizes
Thread-Index: AdyiWUDSmttu37yVSCavLego/gIH9AVXz+Uw
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260220110824.235784-1-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

UmVjaGVjay1yZXF1ZXN0OiBnaXRodWItcm9ib3QNCg0K
