Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB2CCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 Aug 2025 07:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE5D400EF;
	Sat, 16 Aug 2025 09:46:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A647D4003C
 for <dev@dpdk.org>; Sat, 16 Aug 2025 09:45:59 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6D90C2051E;
 Sat, 16 Aug 2025 09:45:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 0/7] avoid unnecessary use of comma operator
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 16 Aug 2025 09:45:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE3B@smartserver.smartshare.dk>
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 0/7] avoid unnecessary use of comma operator
Thread-Index: AdwOAWJMyuulmrCoS3eOn81FfJzG6AAf6bLg
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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
> Sent: Friday, 15 August 2025 18.26
>=20
> Clang has ability to detect suspicious use of comma operator
> where a semicolon would have the same effect.
> Easy enough to fix in DPDK code.

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

Thank you for cleaning up DPDK with this improvement.

