Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7977CA0EDB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 20:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7312E4026A;
	Tue, 12 Aug 2025 22:07:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AA224400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 22:07:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 730E92051E;
 Tue, 12 Aug 2025 22:07:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 1/1] ethdev: add link speed 800G
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 12 Aug 2025 22:07:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE31@smartserver.smartshare.dk>
In-Reply-To: <20250812144249.316120-1-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] ethdev: add link speed 800G
Thread-Index: AdwLl22Fh2PhNsEaRX64yPHTxf3b8gALJE2Q
References: <20250812144249.316120-1-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: "Aman Singh" <aman.deep.singh@intel.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>
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
> Sent: Tuesday, 12 August 2025 16.43
>=20
> There are some devices supporting 800G speed,
> and it is well standardized in IEEE.
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

