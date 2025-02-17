Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E5C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 20:24:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D96940151;
	Mon, 17 Feb 2025 21:24:08 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 62FF7400EF
 for <dev@dpdk.org>; Mon, 17 Feb 2025 21:24:06 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3C67B2287B;
 Mon, 17 Feb 2025 21:24:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 00/11] Fix dev_ops dereferences
Date: Mon, 17 Feb 2025 21:24:04 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA48@smartserver.smartshare.dk>
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 00/11] Fix dev_ops dereferences
Thread-Index: AduBbdwyZRt3x8F0TvKnpDBnrhAWhwAC3mOw
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Monday, 17 February 2025 19.54
>=20
> A common pattern in DPDK internals is to have an array of function
> pointers. When using these pointers an unnecessary derefence is done;
> this is allowed in C because of a historical quirk but unnecessary.
>=20
> The PVS Studio checker flags these as:
>  https://pvs-studio.com/en/docs/warnings/v516/
>=20
> This leads to a large number of warnings marked as High severity.
> This patchset simplifies the source and gets rid of these warnings.
>=20
> It should have no impact on the resulting binary.

+1 to this RFC.
The code becomes much cleaner to read.

