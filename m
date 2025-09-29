Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE7DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1161140696;
	Mon, 29 Sep 2025 19:48:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DBA774065C;
 Mon, 29 Sep 2025 19:48:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9956C202E1;
 Mon, 29 Sep 2025 19:48:24 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Date: Mon, 29 Sep 2025 19:48:19 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65481@smartserver.smartshare.dk>
In-Reply-To: <20250929145049.153078-1-kai.ji@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Thread-Index: AdwxUHd4EFXv1RQvT4qM0/S5ISte7AAGBUeA
References: <20250926160209.56496-1-kai.ji@intel.com>
 <20250929145049.153078-1-kai.ji@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Kai Ji" <kai.ji@intel.com>, <dev@dpdk.org>, <stephen@networkplumber.org>
Cc: <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>,
 <bruce.richardson@intel.com>, <thomas@monjalon.net>, <stable@dpdk.org>
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

> From: Kai Ji [mailto:kai.ji@intel.com]
> Sent: Monday, 29 September 2025 16.51
>=20
> Bugzilla ID: 1773
> Cc: stable@dpdk.org
>=20
> [0] https://bugs.dpdk.org/show_bug.cgi?id=3D1773
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

@Stephen: V4 also includes equal, which you was asking for.

