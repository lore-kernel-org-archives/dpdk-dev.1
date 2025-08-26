Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA3CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 06:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4224021E;
	Tue, 26 Aug 2025 08:58:53 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6E60B40156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 08:58:52 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4DF102071D;
 Tue, 26 Aug 2025 08:58:52 +0200 (CEST)
Subject: RE: [PATCH v2 2/4] hash: use static_assert
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 08:58:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE6E@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
In-Reply-To: <20250822182110.27599-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/4] hash: use static_assert
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwTkZccdAzp8lkwSLeUjYYL/hbV0QCxTrmA
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
> Sent: Friday, 22 August 2025 20.20
>=20
> Now that static_assert is available, better than pre-processor
> use of #if condition.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

