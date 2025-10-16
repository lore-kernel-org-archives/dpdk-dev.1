Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:30:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 784324279F;
	Fri, 17 Oct 2025 00:30:38 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B3BBA4026D
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:30:36 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 73F21206E3;
 Fri, 17 Oct 2025 00:30:36 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v7 1/7] doc: explain debug options in mbuf guide
Date: Fri, 17 Oct 2025 00:30:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D8@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251016203557.2554678-2-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 1/7] doc: explain debug options in mbuf guide
Thread-Index: Adw+3ICSOSgIsNvUSvmEEY/8169/WwAD/Dfg
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
 <20251016203557.2554678-2-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>
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
> Sent: Thursday, 16 October 2025 22.35
>=20
> Mention RTE_LIBRTE_MBUF_DEBUG and RTE_ENABLE_ASSERT
> which enable many debug checks in the mbuf library.
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

