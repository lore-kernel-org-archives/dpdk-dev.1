Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43AC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 09:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48D9F402AC;
	Mon, 19 May 2025 11:59:34 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 810D840276
 for <dev@dpdk.org>; Mon, 19 May 2025 11:59:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 57106208BD;
 Mon, 19 May 2025 11:59:31 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: rte_lcore_has_role() return value
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 19 May 2025 11:59:29 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3A==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Pavan Nikhilesh Bhagavatula" <pbhagavatula@marvell.com>
Cc: "dev" <dev@dpdk.org>
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

Pavan,

The rte_lcore_has_role() documentation says it returns bool.

Its implementation returns a true value (-1) if given a non-compliant =
lcore_id, e.g. LCORE_ID_ANY.

I think it should behave like rte_lcore_is_enabled(), i.e. return false =
if given a non-compliant lcore_id, e.g. LCORE_ID_ANY.

Use case:
A control thread in an application might or might not register itself, =
and the registration might not succeed.

At exit of this control thread, it should unregister itself if =
registered.

Fixing rte_lcore_has_role() as suggested would simplify the application =
from this:

	if (rte_lcore_id() !=3D LCORE_ID_ANY &&
			rte_eal_lcore_role(rte_lcore_id()) =3D=3D ROLE_NON_EAL)
		rte_thread_unregister();

To this:

	if (rte_lcore_has_role(rte_lcore_id(), ROLE_NON_EAL))
		rte_thread_unregister();

-Morten

