Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2630CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 12:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DE6840697;
	Thu,  4 Sep 2025 14:15:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 044F24026D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 14:15:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E75CD2045E;
 Thu,  4 Sep 2025 14:15:09 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] mempool: hide zero value items when dump cache
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 4 Sep 2025 14:15:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FEBB@smartserver.smartshare.dk>
In-Reply-To: <20250904120942.51729-1-fengchengwen@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] mempool: hide zero value items when dump cache
Thread-Index: AdwdlM/ApEAbzYZTS42zfM5obBqFxQAAKBTQ
References: <20250904120942.51729-1-fengchengwen@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Chengwen Feng" <fengchengwen@huawei.com>,
	<thomas@monjalon.net>
Cc: <dev@dpdk.org>
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

> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> Sent: Thursday, 4 September 2025 14.10
>=20
> Hide zero value items when dump mempool cache.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

Yes, they were annoying. Thank you.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

