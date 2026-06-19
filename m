Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC0CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 13:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D42C402C3;
	Fri, 19 Jun 2026 15:24:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D80984029D
 for <dev@dpdk.org>; Fri, 19 Jun 2026 15:24:12 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B5BD9201E4;
 Fri, 19 Jun 2026 15:24:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 0/6] ip_frag: fix reassembly defects and add test
Date: Fri, 19 Jun 2026 15:24:10 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6592B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] ip_frag: fix reassembly defects and add test
Thread-Index: Adz91BXz0A8rlNX9QA+F8h3SqxcBlQCGq/9A
References: <20260616210656.464062-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Tuesday, 16 June 2026 23.06
>=20
> The IP reassembly library tracks only a running byte total and =
reserved
> slots for the first and last fragments, with no coverage map. As a
> result
> it mishandles duplicate, overlapping, oversized, and misheadered
> fragments, and the IPv4 key is missing a field RFC 791 requires. There
> was also no functional test to catch any of it.
>=20
> These came out of reviewing a duplicate-fragment report on the list.
>=20
> Patches 1 and 2 are interdependent: the overlap discard relies on the
> duplicate handling so an exact duplicate is dropped on its own rather
> than discarding the whole datagram. The rest are independent.
>=20
> Patch 6 adds a functional test modeled on the Linux selftest
> ip_defrag.c.
> It passes on this series; with any single fix reverted the matching
> case
> fails.

With patch 2/6 fixed,
Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

