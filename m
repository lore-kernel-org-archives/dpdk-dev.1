Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0ECD4F5E
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 05:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59FF640276;
	Wed, 20 May 2026 07:40:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 880CF4025E
 for <dev@dpdk.org>; Wed, 20 May 2026 07:40:06 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 74781210AB;
 Wed, 20 May 2026 07:40:05 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 0/2] enhance telemetry list endpoint with device name
Date: Wed, 20 May 2026 07:40:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65885@smartserver.smartshare.dk>
In-Reply-To: <20260520035641.50555-1-fengchengwen@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/2] enhance telemetry list endpoint with device name
Thread-Index: AdzoDLz+F0pQwG3oRwSvm+DGcU8sxQADh1hQ
References: <20260520035641.50555-1-fengchengwen@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Chengwen Feng" <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
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
> Sent: Wednesday, 20 May 2026 05.57
>=20
> Currently, the /dmadev/list and /ethdev/list telemetry endpoints =
return
> only integer IDs, making it hard to identify devices. This series
> changes
> both to output strings in "ID    NAME" format for better usability.

For machine reading of the JSON output, it would be better returning an =
object with an integer and a string field, {ID, "NAME"}.

