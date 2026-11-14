Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03332606A884
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 14:54:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 074D640269;
	Sat, 14 Nov 2026 15:54:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id CB3684021E
 for <dev@dpdk.org>; Sat, 14 Nov 2026 15:54:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 535DC20972;
 Sat, 14 Nov 2026 15:54:22 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] eal: remove atomic flag operations
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 14 Nov 2026 15:54:19 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0F@smartserver.smartshare.dk>
In-Reply-To: <20260917204100.2289205-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] eal: remove atomic flag operations
Thread-Index: Ad1G5N1uNOiGkj8VTsmBBeQnBGqY3wtYw59w
References: <20260917204100.2289205-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 17 September 2026 13.41
>=20
> The rte_atomic_flag_test_and_set_explicit and
> rte_atomic_flag_clear_explicit macros were added in 23.11 with the =
rest
> of the stdatomic API and never had an in-tree user.
>=20
> They cannot be used portably:
>=20
> * Only test-and-set and clear were wrapped.
>   C11 makes atomic_flag opaque with no load operation.
>=20
> * The operand type differs between the two implementations, and no =
type
>   works in all builds: across stdatomic and gcc vs clang.
>=20
> No portable application can be using these, so removal cannot break
> correct code. Use rte_atomic_exchange_explicit,
> rte_atomic_load_explicit
> and rte_atomic_store_explicit on an RTE_ATOMIC(bool) instead.
>=20
> Removed without a deprecation notice as the API cannot be used as
> specified. 26.11 is an ABI break release.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

