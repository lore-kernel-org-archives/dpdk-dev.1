Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A3CCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 11:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54A47402BC;
	Wed,  3 Jun 2026 13:56:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2B8D3402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 13:56:06 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F32EB20CFD;
 Wed,  3 Jun 2026 13:56:04 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: ARM v8 rte_power_pause
Date: Wed, 3 Jun 2026 13:56:04 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ARM v8 rte_power_pause
Thread-Index: AdzzT/Q/gutdQ3oPTzyy3YuhY3IVZA==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>
Cc: <dev@dpdk.org>,
	"Maxime Leroy" <maxime@leroys.fr>
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

Hi Wathsala, Hemant and Sachin,

Over at the Grout project, we are discussing power management in the =
context of 100 Gbit/s latency deadlines [1].

rte_power_pause() is not implemented for ARM v8 / Cortex-A72.
Syscalls such as nanosleep() have too much overhead, and cannot be used.

Any suggestions for a power-reducing method to make a CPU core "sleep" =
(i.e. do nothing) for durations in the order of 1 microsecond?

[1]: https://github.com/DPDK/grout/pull/624#issuecomment-4602036364

-Morten

