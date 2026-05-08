Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACBCD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 06:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9035340268;
	Fri,  8 May 2026 08:32:48 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 32E8D4013F
 for <dev@dpdk.org>; Fri,  8 May 2026 08:32:47 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EB2D1208C9
 for <dev@dpdk.org>; Fri,  8 May 2026 08:32:46 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v9] eal/x86: optimize memcpy of small sizes
Date: Fri, 8 May 2026 08:32:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6585F@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v9] eal/x86: optimize memcpy of small sizes
Thread-Index: AdzXw/PmeX/YfpvgTCWiMb+z5esAQgABrDuAAbpdJPA=
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260429103548.220354-1-mb@smartsharesystems.com> 
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

UmVjaGVjay1yZXF1ZXN0OiBnaXRodWItcm9ib3QsIGlvbC11bml0LWFybTY0LXRlc3RpbmcsIGlv
bC1zYW1wbGUtYXBwcy10ZXN0aW5nDQoNCg==
