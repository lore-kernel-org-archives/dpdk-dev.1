Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA0C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 03:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2503C400EF;
	Wed, 26 Aug 2026 05:58:51 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2559F400D7
 for <dev@dpdk.org>; Wed, 26 Aug 2026 05:58:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CFAF8209C8;
 Wed, 26 Aug 2026 05:58:49 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 5/5] app/test/mempool_perf: adjust test to work with
 many cores
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 26 Aug 2026 05:58:49 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A15@smartserver.smartshare.dk>
In-Reply-To: <20260826020133.2644805-6-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 5/5] app/test/mempool_perf: adjust test to work with
 many cores
Thread-Index: Ad00/u4IdrZZV4pnSqaIYv3CAKwXIgAEDxfQ
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
 <20260826020133.2644805-6-stephen@networkplumber.org>
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

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

