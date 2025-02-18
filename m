Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B99C021AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 17:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11DEC402CF;
	Tue, 18 Feb 2025 18:12:08 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EA78740264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 18:12:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B18D02076D;
 Tue, 18 Feb 2025 18:12:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Date: Tue, 18 Feb 2025 18:12:04 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA4C@smartserver.smartshare.dk>
In-Reply-To: <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Thread-Index: AduCIrjlQUDmnDI6RSmTTXHNPphwrAABNBUA
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: <dev@dpdk.org>, "Chengwen Feng" <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>
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

> From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> Sent: Tuesday, 18 February 2025 17.32
>=20
> There's no MSVC equivalent for compiler extension =
__builtin_constant_p.
> EAL already had __rte_constant which was used as a first attempt to
> workaround __builtin_constant_p when using MSVC. However, there are
> pieces of code that would benefit from being able to provide a default
> value to be used instead of it being always 0 like how it was done by
> __rte_constant.
>=20
> A new macro is added here allowing such default to be provided by the
> caller.

NAK to the new macro.

Please use the sizeof() hack suggested by Stephen to provide an =
implementation of __rte_constant(e) for MSVC.
Here's a link to an example of the hack:
https://news.ycombinator.com/item?id=3D16720172

