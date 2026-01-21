Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9592EC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 18:55:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88DB84279D;
	Wed, 21 Jan 2026 19:55:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CE5804027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 19:55:12 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1D59220AD6;
 Wed, 21 Jan 2026 19:55:12 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 0/4] examples: memcpy cleanups
Date: Wed, 21 Jan 2026 19:55:03 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65689@smartserver.smartshare.dk>
In-Reply-To: <20260121170540.785735-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/4] examples: memcpy cleanups
Thread-Index: AdyK+DIK2NdDaHknQ0CUY5sdfwno9gADsJoA
References: <20260121170540.785735-1-stephen@networkplumber.org>
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
> Sent: Wednesday, 21 January 2026 18.05
>=20
> Looking at examples and noticed stuff around use
> of rte_memcpy. Probably mostly copy/pasted.
>=20
> Stephen Hemminger (4):
>   examples/vhost: replace memcpy with assignment
>   examples/vmdq: replace memcpy with structure assignment
>   examples/vmdq_dcb: replace memcpy with assignment
>   examples: remove unnecessary include
>=20

Structure assignment is better than [rte_]memcpy().
And this is slow path only, so no need to discuss performance.

For the series,
Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

Thank you for cleaning this up.

