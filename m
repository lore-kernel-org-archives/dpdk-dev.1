Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA8CAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:39:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2747402D3;
	Thu, 11 Sep 2025 12:39:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0517E402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:39:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B408220CE7;
 Thu, 11 Sep 2025 12:39:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v12 1/1] ethdev: add link connector type
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Sep 2025 12:39:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FEE1@smartserver.smartshare.dk>
In-Reply-To: <20250911103610.2405666-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 1/1] ethdev: add link connector type
Thread-Index: AdwjB+mG74GEy0fHTUiRtqN7reZe8gAAFejQ
References: <20250911084943.2383151-1-skori@marvell.com>
 <20250911103610.2405666-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <skori@marvell.com>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: <dev@dpdk.org>,
	"Nithin Dabilpuram" <ndabilpuram@marvell.com>
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

> From: Sunil Kumar Kori <skori@marvell.com>
>=20
> Adding link connector parameter to provide the type
> of connection for a port like twisted pair, fiber etc.
>=20
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
>=20
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---

LGTM now.
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

