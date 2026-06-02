Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669BCD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F0C9402A9;
	Tue,  2 Jun 2026 11:24:55 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E2DBF40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:24:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AFF00208EE;
 Tue,  2 Jun 2026 11:24:53 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 1/3] build: deprecate kernel dir option
Date: Tue, 2 Jun 2026 11:24:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260602090847.905721-2-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 1/3] build: deprecate kernel dir option
Thread-Index: Adzyb3T3vaY08URHTI+Ye0ovWUB3RAAAddzQ
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-2-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 2 June 2026 11.09
>=20
> The kernel_dir option does nothing, so it can be deprecated and =
removed
> in future.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Good cleanup.
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

