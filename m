Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E587BC5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 11:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24E7D402B8;
	Wed, 12 Aug 2026 13:43:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 237054027E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 13:43:23 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E22DA22820;
 Wed, 12 Aug 2026 13:43:22 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] lib: fix mempool name prefixes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:43:20 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659D8@smartserver.smartshare.dk>
In-Reply-To: <20260812110258.1128632-1-anurag.mandal@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lib: fix mempool name prefixes
Thread-Index: Ad0qSkUTllPZIxmFT8SaZOZ7LV6QawABSTVA
References: <20260812110258.1128632-1-anurag.mandal@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anurag Mandal" <anurag.mandal@intel.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<vladimir.medvedkin@intel.com>
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

> Subject: [PATCH] lib: fix mempool name prefixes

The title could probably be improved...
Something like:

fib & rib: fix name prefixes

