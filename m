Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB8CFD364
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 08:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFC0406B6;
	Tue, 25 Nov 2025 09:19:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7D72E402E8
 for <dev@dpdk.org>; Tue, 25 Nov 2025 09:19:11 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4005C208EA;
 Tue, 25 Nov 2025 09:19:11 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4] eal/x86: optimize memcpy of small sizes
Date: Tue, 25 Nov 2025 09:19:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6558A@smartserver.smartshare.dk>
In-Reply-To: <20251124203122.1339526-1-mb@smartsharesystems.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4] eal/x86: optimize memcpy of small sizes
Thread-Index: AdxdgU1DpKZIZ8iHREmpXFjJuNvsTQAYj86A
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251124203122.1339526-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBBbHNvLCBhbGwgdXNlcyBvZiBTU0UyIF9tbV9sb2FkdV9zaTEyOCgpIGludHJpbnNpY3Mgd2Vy
ZSB1cGdyYWRlZCB0bw0KPiBTU0UzIF9tbV9sZGRxdV9zaTEyOCgpLg0KPiBUaGUgSW50ZWwgSW50
cmluc2ljcyBHdWlkZSBub3RlcyB0aGF0IGl0IG1heSBwZXJmb3JtIGJldHRlciB3aGVuIHRoZQ0K
PiBkYXRhIGNyb3NzZXMgYSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KDQpJdCB0dXJucyBvdXQgX21t
X2xkZHF1X3NpMTI4KCkgaXMgbXVjaCBzbG93ZXIgdGhhbiBfbW1fbG9hZHVfc2kxMjgoKS4NCldv
dWxkIGhhdmUgYmVlbiBuaWNlIGlmIHRoZSBJbnRlbCBJbnRyaW5zaWNzIEd1aWRlIG1lbnRpb25l
ZCB0aGF0Lg0KDQpNYXJrZWQgdjQgcGF0Y2ggYXMgTm90IEFwcGxpY2FibGUsIGFuZCBjaGFuZ2Vk
IHYzIHBhdGNoIGJhY2sgdG8gTmV3Lg0KDQo=
