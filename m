Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21939C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 15:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30B1140292;
	Tue,  8 Jul 2025 17:41:49 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 65C094025E;
 Tue,  8 Jul 2025 17:41:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 30B40208ED;
 Tue,  8 Jul 2025 17:41:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 8 Jul 2025 17:41:46 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDA8@smartserver.smartshare.dk>
In-Reply-To: <20250708122823.3406288-10-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
Thread-Index: AdvwBB1GzlLsFVL9RSC5vr9ax5IeWgAGaAaA
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-10-david.marchand@redhat.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Gage Eads" <gage.eads@intel.com>, "Olivier Matz" <olivier.matz@6wind.com>,
 "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

> From: David Marchand [mailto:david.marchand@redhat.com]
> Sent: Tuesday, 8 July 2025 14.28
>=20
> Fixes: 3340202f5954 ("stack: add lock-free implementation")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

> -	struct rte_stack_lf_head old_head;
> +	alignas(16) struct rte_stack_lf_head old_head;

I don't know if Bruce also commented on this one, like he did on patch =
12/18; so at the risk of repeating something already mentioned...

If all uses of struct rte_stack_lf_head must be 16-byte aligned, better =
fix the root cause by aligning the type rather than every use of it.
Please add such a root cause fix to the 25.11 TODO list, like the =
alignment of the struct rte_mp_msg type.

