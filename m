Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A954C88E5C
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 08:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6122402BA;
	Mon, 26 Jan 2026 09:19:53 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1AA402B6
 for <dev@dpdk.org>; Mon, 26 Jan 2026 09:19:52 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 898A22061A;
 Mon, 26 Jan 2026 09:19:51 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [REVIEW] eal: RTE_PTR_ADD/SUB API improvements
Date: Mon, 26 Jan 2026 09:19:49 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656B6@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260125193618.499170-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [REVIEW] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: AdyOMefvY7BbPAt1QTmYqQZbEaXWDwAaatHw
References: <20260125111211.34800-1-scott.k.mitch1@gmail.com>
 <20260125193618.499170-1-stephen@networkplumber.org>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Scott Mitchell" <scott.k.mitch1@gmail.com>
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

U3RlcGhlbiwNCg0KVGhlIGVtYWlsIHN1YmplY3Qgc2hvdWxkIHJlZmxlY3Qgd2hpY2ggdmVyc2lv
biBvZiB0aGUgcGF0Y2ggdGhlIHJldmlldyBjb3ZlcnMuDQoNClBTOiBUaGFua3MgZm9yIGFsbCB0
aGUgd29yayB5b3UgYXJlIHB1dHRpbmcgaW50byBBSSByZXZpZXcgYW5kIGF1dG9tYXRpbmcgaXQs
IFN0ZXBoZW4uIEl0J3MgZ3JlYXQgdG8gZm9sbG93IHRoZSBwcm9ncmVzcyBmcm9tIGV4cGVyaW1l
bnRhdGlvbiB0byBwcm9kdWN0aW9uLiA6LSkNCg0KLU1vcnRlbg0KDQo=
