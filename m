Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A3606A327
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A677040E34;
	Fri, 13 Nov 2026 21:26:02 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 891104028E;
 Fri, 13 Nov 2026 21:26:00 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 32E4B20972;
 Fri, 13 Nov 2026 21:26:00 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH v6] examples/l3fwd: fix RFC 1812 checks
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 21:25:59 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0D@smartserver.smartshare.dk>
In-Reply-To: <BydTunSNQoiltn4u_4EulQ@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6] examples/l3fwd: fix RFC 1812 checks
Thread-Index: Ad1zrMi629BCu7AdRz6yaWT5QIsh7QAAEFQw
References: <20260915105822.988106-1-mb@smartsharesystems.com>
 <20261113201423.596856-1-mb@smartsharesystems.com>
 <BydTunSNQoiltn4u_4EulQ@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBUaGlzIG5ldyB2ZXJzaW9uIGRvZXMgbm90IGNvbXBpbGUgb24gbWFpbjoNCj4gDQo+IGV4YW1w
bGVzL2wzZndkL2wzZndkX2FjbC5jOjEwOTQ6MTc6IGVycm9yOg0KPiBpbmNvbXBhdGlibGUgdHlw
ZXMgd2hlbiBhc3NpZ25pbmcgdG8gdHlwZSAnc3RydWN0IGxjb3JlX2NvbmYgKicgZnJvbQ0KPiB0
eXBlICdzdHJ1Y3QgbGNvcmVfY29uZicNCg0KTG9va3MgbGlrZSBhIHJlYmFzZSBtaXN0YWtlOyBJ
J2xsIGZpeCBpdCBhbmQgc3VibWl0IHY3IEFTQVAuDQoNCi1Nb3J0ZW4NCg0K
