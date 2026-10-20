Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914A606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C3640270;
	Tue, 20 Oct 2026 11:01:10 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2367B40144;
 Tue, 20 Oct 2026 11:01:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E69BE20678;
 Tue, 20 Oct 2026 11:01:08 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3] net/vhost: fix SW checksum when zero
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 20 Oct 2026 11:01:06 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AC8@smartserver.smartshare.dk>
In-Reply-To: <CAO55csz5i1-b+7XYgVZad2ZxU1+_egNR+HkPCfD2=B3Q6zdErw@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] net/vhost: fix SW checksum when zero
Thread-Index: Ad1gBjPEYpJwSWABSDWDA7x7tc3pPgAaxZnA
References: <20261017165952.3139535-1-mb@smartsharesystems.com>
 <20261018092037.3143058-1-mb@smartsharesystems.com>
 <CAO55csz5i1-b+7XYgVZad2ZxU1+_egNR+HkPCfD2=B3Q6zdErw@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: <stable@dpdk.org>,
	"Maxime Coquelin" <maxime.coquelin@redhat.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBSZXZpZXdlZC1ieTsgTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNv
bT4NCg0KRm9yIFBhdGNod29yaywgcmVwbGFjaW5nIHNlbWljb2xvbiB3aXRoIGNvbG9uLi4uDQpS
ZXZpZXdlZC1ieTogTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4N
Cg0K
