Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E6CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 06:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 693F74027D;
	Thu, 28 Aug 2025 08:44:39 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7C14340263
 for <dev@dpdk.org>; Thu, 28 Aug 2025 08:44:37 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2988C20A24;
 Thu, 28 Aug 2025 08:44:37 +0200 (CEST)
Subject: RE: Ubuntu 20.04 EOL
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Aug 2025 08:44:35 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE7C@smartserver.smartshare.dk>
In-Reply-To: <20250827213430.41806a48@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: Ubuntu 20.04 EOL
Thread-Index: AdwX1RF4ghbr01s4RLCOg8fpRv8eLwAEHa/w
References: <20250827213430.41806a48@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 28 August 2025 06.35
>=20
> Looks like Ubuntu 20.04 LTS (Focal Fossa) reached the end of standard =
support.

Paid support is available until May 2030:
https://ubuntu.com/blog/ubuntu-20-04-lts-end-of-life-standard-support-is-=
coming-to-an-end-heres-how-to-prepare

> Should we drop it for DTS?
>=20
> Asking because the recent patch to handle shadow warnings doesn't work =
on
> compilers like Gcc 9.4 which don't know what -Wshadow is.

Our current minimum GCC compiler requirement is version 8.0:
https://git.dpdk.org/dpdk/tree/doc/guides/linux_gsg/sys_reqs.rst#n32

Which GCC version is required to support -Wshadow, and which GCC =
versions are included in relevant distros?

Maybe the -Wshadow can be added conditionally, depending on compiler =
version.
Shadow variables will not be caught locally, if using an old compiler =
version. But the CI will catch them in the tests running on recent =
compiler versions.

