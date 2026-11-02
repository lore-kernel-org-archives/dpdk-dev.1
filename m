Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C8606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 11:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB13540274;
	Mon,  2 Nov 2026 12:07:55 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id D9BF64003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 12:07:54 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7088F2056A;
 Mon,  2 Nov 2026 12:07:54 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 0/2] move module EEPROM decoding to a transceiver library
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 2 Nov 2026 12:07:50 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AEC@smartserver.smartshare.dk>
In-Reply-To: <20261029174151.1527906-1-roma55592@yandex.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 0/2] move module EEPROM decoding to a transceiver library
Thread-Index: Ad1nzNYAlo3eA2caTS+0lTKLJmFrfAC7LX6A
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261026200950.1094549-1-roma55592@yandex.ru>
 <1jOljJRtTQqpabyIXToQtw@monjalon.net>
 <20261029174151.1527906-1-roma55592@yandex.ru>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Roman Khromenok" <roma55592@yandex.ru>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>, <andrew.rybchenko@oktetlabs.ru>,
 <stephen@networkplumber.org>
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

> From: Roman Khromenok [mailto:roma55592@yandex.ru]
> Sent: Thursday, 29 October 2026 18.42

Are there any APIs to tell if a transceiver module is plugged into the =
transceiver module socket on the NIC, either in the ethdev library or =
under this new transceiver library?

