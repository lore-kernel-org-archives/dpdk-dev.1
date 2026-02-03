Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28EE83061
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:18:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD294042C;
	Tue,  3 Feb 2026 09:18:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F3EBA402A2;
 Tue,  3 Feb 2026 09:18:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B9FDF206EC;
 Tue,  3 Feb 2026 09:18:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v19 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Date: Tue, 3 Feb 2026 09:18:07 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656E3@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260202044841.90945-2-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v19 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Thread-Index: AdyT/zj1wfdNwPTkTjCDynqJfvZpZAA5lrhA
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-2-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, "Cyril Chemparathy" <cchemparathy@ezchip.com>,
 <stable@dpdk.org>
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

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

