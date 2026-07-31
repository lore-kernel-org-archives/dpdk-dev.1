Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566AC54FCD
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 08:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D549402BB;
	Sat,  1 Aug 2026 10:28:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DDB2B40299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 10:28:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com (unknown [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0A344226C7;
 Fri, 31 Jul 2026 16:53:47 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 12/32] stack: always use C11 memory model implementation
Date: Fri, 31 Jul 2026 16:53:45 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
In-Reply-To: <20260729175715.165120-13-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC 12/32] stack: always use C11 memory model implementation
Thread-Index: Ad0fg+LezXR4NzzOSNmmXE4rn1EFzwBdhykw
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-13-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>, <jerinj@marvell.com>,
 "Maciej Czekaj" <mczekaj@marvell.com>
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

+TO: x86 maintainers, ThunderX maintainers

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Wednesday, 29 July 2026 19.54
>=20
> The generic and C11 lock-free stack implementations differ only in
> memory ordering. The generic version uses a full barrier where its
> own comments state an acquire fence is sufficient, and seq_cst for
> all length counter operations.
>=20
> Only x86 and ThunderX still used the generic version. On x86 the
> switch removes a locked add per CAS attempt in push and pop; TSO
> provides the acquire semantics. On ThunderX the pop fence weakens
> from dmb ish to dmb ishld and the push fence goes away. Unlike the
> ring, no platform selected the generic stack for measured
> performance reasons.
>=20
> Remove it and use the C11 implementation everywhere.

The lack of measured performance difference documentation is not a valid =
reason to remove the generic version!

It would be reasonable to assume that x86 (and ThunderX) use the generic =
version for non-insignificant performance reasons.

If there is no performance difference, I agree with this patch. =
Otherwise not.
This could be verified by providing the missing measurements.

