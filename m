Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562B606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 410004064A;
	Wed, 11 Nov 2026 14:00:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id C0B0640297
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:00:12 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 45DED20547;
 Wed, 11 Nov 2026 14:00:12 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v3 3/3] test/mempool: add list walk race test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 11 Nov 2026 14:00:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B03@smartserver.smartshare.dk>
In-Reply-To: <20261109144054.3784583-4-rsanford2@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 3/3] test/mempool: add list walk race test
Thread-Index: Ad1wWGTJPbidZJkATvi7ZmQ8XpE/pgBg1OPQ
References: <20261103173543.130142-1-rsanford2@gmail.com>
 <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261109144054.3784583-4-rsanford2@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> +	f =3D fopen("/dev/null", "w");

"/dev/null" is "NUL" in Windows. Look here for inspiration:
https://github.com/DPDK/dpdk/blob/v26.11-rc2/app/test/test_cmdline_lib.c#=
L24-L28

With that fixed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

