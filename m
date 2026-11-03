Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD74606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:15:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39A834042F;
	Tue,  3 Nov 2026 15:15:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 53532402DE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:15:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 058AC207E3;
 Tue,  3 Nov 2026 15:15:05 +0100 (CET)
Subject: RE: [PATCH v1 3/3] test/mempool: add list walk race test
Date: Tue, 3 Nov 2026 15:15:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AF6@smartserver.smartshare.dk>
In-Reply-To: <20261103011107.3658840-4-rsanford2@gmail.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 3/3] test/mempool: add list walk race test
Thread-Index: Ad1rMDu1hu6j6jYsRyGoOh17bCG/xQAbUmPw
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103011107.3658840-4-rsanford2@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Robert Sanford" <rsanford2@gmail.com>,
	<dev@dpdk.org>
Cc: <andrew.rybchenko@oktetlabs.ru>, <olivier.matz@6wind.com>,
 "Robert Sanford" <rsanford@akamai.com>
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

> From: Robert Sanford <rsanford@akamai.com>
>=20
> Walk, look up and dump the mempool list on some lcores while other
> lcores create and free mempools, in two phases of 500 ms. In the
> first phase, mempools are created and freed as fast as possible. In
> the second phase, every other mempool is created empty and populated
> after a short delay, so that the walkers also find mempools that are
> not populated yet.
>=20
> Without either of the two previous patches, the test crashes. It
> needs at least 3 lcores and is skipped otherwise. It adds about one
> second to mempool_autotest.
>=20
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---

This patch 3/3 might need some changes when patch 2/3 has been changed.
Holding back on reviewing until v2 of the series.

-Morten

