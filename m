Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBC1CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 17:57:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68D4402EB;
	Tue, 19 May 2026 19:57:54 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EBFBC402E9
 for <dev@dpdk.org>; Tue, 19 May 2026 19:57:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B949A2085F;
 Tue, 19 May 2026 19:57:53 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Date: Tue, 19 May 2026 19:57:47 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65883@smartserver.smartshare.dk>
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Thread-Index: AdznqcRxOlisudhEQL6nNfNPJrmM2gADg07A
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 19 May 2026 18.06
>=20
> This RFC proposed to replace all instances of rte_memcpy in Intel
> (and former-Intel) net drivers with just regular memcpy. This is
> done on the basis that the memcpy use is not datapath, but is used
> for flow configuration, virt-channel (to firmware or PF) messaging
> and other control path functions.
>=20

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

Interesting that using rte_memcpy() emits stringop-overflow warnings =
when not disabled [1], while using memcpy() doesn't [2].
The warnings are not correct, but still an interesting difference.

[1]: =
https://github.com/ovsrobot/dpdk/actions/runs/25104438552/job/74968218420=

[2]: =
https://github.com/ovsrobot/dpdk/actions/runs/26110738743/job/76786987619=


