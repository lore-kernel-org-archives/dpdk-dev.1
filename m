Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50524D12D5F
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 13:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 464CE402B7;
	Wed,  3 Dec 2025 14:29:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0A15B4029D
 for <dev@dpdk.org>; Wed,  3 Dec 2025 14:29:06 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CD5B420B9F
 for <dev@dpdk.org>; Wed,  3 Dec 2025 14:29:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5] eal/x86: optimize memcpy of small sizes
Date: Wed, 3 Dec 2025 14:29:04 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655B8@smartserver.smartshare.dk>
In-Reply-To: <20251201155525.1538260-1-mb@smartsharesystems.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] eal/x86: optimize memcpy of small sizes
Thread-Index: Adxi2uy53ykX+C/DTau4jitEo9BWDQBfaf6g
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251201155525.1538260-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
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

UmVjaGVjay1yZXF1ZXN0OiBJbnRlbC1jb21waWxhdGlvbg0KDQo=
