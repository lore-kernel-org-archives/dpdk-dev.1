Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D7ECCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC8BF402A8;
	Tue, 14 Oct 2025 10:45:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0212C40288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 10:45:31 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CB8B3206E5;
 Tue, 14 Oct 2025 10:45:30 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Date: Tue, 14 Oct 2025 10:45:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654C5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251014070517.922137-7-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Thread-Index: Adw82PboKKVO1OfiTrSQN3yoXTkLpwADT9cw
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
 <20251014070517.922137-7-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>,
 "Aman Singh" <aman.deep.singh@intel.com>
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
> Sent: Tuesday, 14 October 2025 08.59
>=20
> Dump the mbuf history to the console or to a file.
>=20
> The dump will contain:
> - Operation history for each mbuf
> - Summary and statistics about all mbufs
>=20
> Dump the history of all mbufs:
> 	testpmd> dump mbuf history all [file]
>=20
> Dump the history of one mbuf pool:
> 	testpmd> dump mbuf history mempool <mp_name> [file]
>=20
> Dump the history of one mbuf:
> 	testpmd> dump mbuf history one <mbuf_addr> [file]

The "one" seems superfluous. I think this would suffice:
	testpmd> dump mbuf history <mbuf_addr> [file]

>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

With or without suggested change,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

