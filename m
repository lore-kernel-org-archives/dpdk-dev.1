Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98528C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 15:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF2D40A6B;
	Sat, 15 Feb 2025 16:44:30 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 64040400D7
 for <dev@dpdk.org>; Sat, 15 Feb 2025 16:44:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 235DA2077A;
 Sat, 15 Feb 2025 16:44:29 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 0/7] Introduce FOREACH_SAFE macros
Date: Sat, 15 Feb 2025 16:44:27 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA40@smartserver.smartshare.dk>
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 0/7] Introduce FOREACH_SAFE macros
Thread-Index: Adt/BO4z7zSPNniHTzmUP9fnKTZ3QAAumyCw
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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
> Sent: Friday, 14 February 2025 18.20
>=20
> This series adds common macros for safe iteration over lists.
> It is a subset copy of the macros from FreeBSD that are
> missing from the Linux header sys/queue.h
>=20
> Chose this over several other options:
>   - let each driver define their own as needed.
>     One Intel driver got it wrong, others will as well.
>   - rename all the queue macros to RTE_XXX variants.
>     Seems like useless renaming and confusion.
>   - Several distros have libbsd package with the correct macros.
>     But adding yet another dependency to DPDK would be annoying
>     for something this basic.
>=20
> There are more macros in FreeBSD header that could be useful,
> but we can add those later as needed here.

100 % agree with all of the above.
Especially that adding RTE_ prefix to "industry standard" macros would =
be silly.

And all patches in this series LGTM.

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

