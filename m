Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB61CCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 11:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B13D402DC;
	Fri, 31 Oct 2025 12:48:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0465B40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:48:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DBA50206E7;
 Fri, 31 Oct 2025 12:48:29 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 1/1] test/memcpy: reduce duration
Date: Fri, 31 Oct 2025 12:48:26 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65521@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251031114310.4062899-1-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] test/memcpy: reduce duration
Thread-Index: AdxKW5HGUOdeyl1xRU2L1U6xOCw2nwAAIN9Q
References: <20251031114310.4062899-1-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <david.marchand@redhat.com>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> Sent: Friday, 31 October 2025 12.43
>=20
> When running on limited platforms like GitHub Actions,
> the functional unit test "memcpy_autotest"
> may hit a timeout, especially when running with UBSan.
>=20
> This change skips testing some alignment offsets (from 0 to 31).
> It will test only every 3-byte offsets for the source buffer,
> and every 2-byte offsets for the destination buffer.
> So it is supposed to be 6x faster with a reasonably smaller coverage.
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Seems reasonable.
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

