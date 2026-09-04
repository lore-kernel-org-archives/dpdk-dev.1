Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E125C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 084A442FBB;
	Fri,  4 Sep 2026 14:12:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E5CFA42F5F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 14:12:38 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A5C2820910;
 Fri,  4 Sep 2026 14:12:38 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v7 00/24] remove legacy atomic functions
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 4 Sep 2026 14:12:37 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A31@smartserver.smartshare.dk>
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 00/24] remove legacy atomic functions
Thread-Index: Ad0lU0hRckUUqUO+SvCYt1UInS5QngXE015Q
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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
> Sent: Thursday, 6 August 2026 05.23
>=20
> The rte_atomicNN_* family was flagged for deprecation in 2021 by
> commit 3ec965b6de12 ("doc: update atomic operation deprecation")
> but removal had stalled and usage contined to grow.
>=20
> This series finishes converting every remaining in-tree caller to
> the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
> removes the legacy functions. The deprecation has been out there
> long enough so not a big surprise to users.
>=20

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

