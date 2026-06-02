Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AABCD6E6B
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC8DE402A9;
	Tue,  2 Jun 2026 12:47:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BF7C640150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 12:47:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 80F13208EE;
 Tue,  2 Jun 2026 12:47:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 3/3] build: deprecate HPET build option
Date: Tue, 2 Jun 2026 12:47:00 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260602090847.905721-4-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 3/3] build: deprecate HPET build option
Thread-Index: Adzyb3vBQbKvTcrSS828p33tLJlCrQACw8dw
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-4-bruce.richardson@intel.com>
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
> We can enable the building of the HPET code by default on Linux, since
> the timers are not used - or even initialized - by default. Instead an
> app needs to explicitly call rte_eal_hpet_init() to use the HPET timer
> APIs. Therefore, let's simplify the user experience by deprecating the
> option "use_hpet" and make it a no-op.
>=20
> To avoid issue with the dpdk-test binary which was trying to =
initialize
> the hpet on startup, move the hpet init call to the timer autotest -
> the
> only place where it was used.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Careful!
I think this patch has unintended side effects:

On Linux, it unconditionally enables HPET (and sets =
RTE_LIBEAL_USE_HPET), which was previously disabled by default.

So, if some Linux applications use #ifdef RTE_LIBEAL_USE_HPET, they will =
now tell DPDK to use that timer instead of the TSC.
We can fix the apps/examples in the DPDK repo, but it will potentially =
change behavior of DPDK user's applications.

I'm not opposed to unconditionally enabling HPET ability in DPDK itself =
on Linux.
But I'm worried about side effects of unconditionally enabling #ifdef =
RTE_LIBEAL_USE_HPET in Linux user applications.

