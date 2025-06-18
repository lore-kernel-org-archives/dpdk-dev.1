Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A6C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDB4427AE;
	Wed, 18 Jun 2025 09:39:10 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E1222427AC;
 Wed, 18 Jun 2025 09:39:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B20F620462;
 Wed, 18 Jun 2025 09:39:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: DPDK libs as one big shared object
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 18 Jun 2025 09:39:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD09@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DPDK libs as one big shared object
Thread-Index: Adve2cjXRdUgmVzQTXCQB5mG0JHn+QBR5H7Q
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>,
	<techboard@dpdk.org>
Cc: "Tomasz Duszynski" <tduszynski@marvell.com>
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

> Why are we still building one .so file per DPDK library, instead of =
just
> building one big dpdk.so for all DPDK libraries?
> I think it's legacy from when DPDK libraries were versioned =
individually, and
> thus not relevant anymore.
>=20
> Wouldn't building one big dpdk.so eliminate the problems with circular
> dependencies between DPDK libraries?

Obviously, the source code should remain organized as individual =
directories per library.
I'm only suggesting linking them all into one object, so any DPDK lib =
can call any function in any other DPDK lib.

Perhaps only the core libs or always_enable libs should be linked into =
one object.

Here's an example benefit:
I'm currently trying to convince the PMU lib author to make PMU depend =
on EAL [1], so missing error handling of sysconf(_SC_PAGESIZE) can be in =
the EAL for all uses, instead of copy-pasting sysconf(_SC_PAGESIZE) =
error handling to everywhere it is used.
But this is difficult with the dependency chain for the patch adding PMU =
to Trace: Trace depends on PMU, and EAL depends on Trace, therefore EAL =
depends on PMU.

[1]: =
https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartse=
rver.smartshare.dk/

