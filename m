Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1EDC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0566B427CE;
	Tue, 15 Sep 2026 19:04:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1C9D04003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 19:04:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CD485206CA
 for <dev@dpdk.org>; Tue, 15 Sep 2026 19:04:38 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 6/6] mempool: no cache size limit
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 15 Sep 2026 19:04:35 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A4A@smartserver.smartshare.dk>
In-Reply-To: <20260910103613.808038-7-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 6/6] mempool: no cache size limit
Thread-Index: Ad1BEDk2XiNEAGbdRDmV1ArPGTx1xwEI7iBg
References: <20260910103613.808038-1-mb@smartsharesystems.com>
 <20260910103613.808038-7-mb@smartsharesystems.com>
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtdW5pdC1hcm02NC10ZXN0aW5nLCBpb2wtbWVsbGFub3gtUGVy
Zm9ybWFuY2UNCg0KVGhlIGFybTY0IHRlc3QgZmFpbHVyZSBzZWVtcyB1bnJlbGF0ZWQuDQpUaGUg
bWVsbGFub3ggcGVyZiB0ZXN0IHJlc3VsdCBzZWVtcyB1bmxpa2VseS4NCg0K
