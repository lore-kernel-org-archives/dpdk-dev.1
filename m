Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34015C54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 08:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BBA6402C2;
	Thu, 22 May 2025 10:29:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D4696402B9
 for <dev@dpdk.org>; Thu, 22 May 2025 10:29:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 28044206C2;
 Thu, 22 May 2025 10:29:50 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: eal patches with other licenses
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 22 May 2025 10:29:46 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC86@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: eal patches with other licenses
Thread-Index: AdvK860PbqZ1AmfYTAiC1zRRbXkpKg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>,
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

Andre,

Please try asking the respective original authors of getline() and =
asprintf() if they are willing to license these functions to the DPDK =
project under the BSD-3-Clause license. Or perhaps generally offer =
dual-license with BSD-3-Clause as an alternative to their original =
license.

-Morten

