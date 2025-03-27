Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478AAC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97FD440275;
	Thu, 27 Mar 2025 09:23:53 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CF8C140261;
 Thu, 27 Mar 2025 09:23:52 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9431821733;
 Thu, 27 Mar 2025 09:23:52 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: DPDK for rust
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 27 Mar 2025 09:23:52 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DPDK for rust
Thread-Index: AduOnPuz8O/sje8tRyKCvevtuAlXCQQUoX0Q
References: <20250306133713.393057-1-getelson@nvidia.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Gregory Etelson" <getelson@nvidia.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>, <thomas@monjalon.net>
Cc: <mkashani@nvidia.com>,
	"Bruce Richardson" <bruce.richardson@intel.com>
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

> From: Gregory Etelson [mailto:getelson@nvidia.com]
> Sent: Thursday, 6 March 2025 14.37
> Subject: [PATCH] rust: support DPDK API
>=20
> The patch converts include files with DPDK API to RUST and binds new
> RUST API files info dpdklib package.
>=20
> The RUST dpdklib files and DPDK libraries build from C sources
> allow creation of DPDK application in RUST.

Do we want the DPDK project itself to support rust?
Or should parts of this be a DPDK hosted project, like grout?

I don't object to supporting rust, quite the opposite. I'm only trying =
to think ahead...

I would hate to see a DPDK patch being rejected because it doesn't =
support rust, or needs additional work to not break DPDK for rust.

And how about the CI - do we want it to test "DPDK for rust", and how =
many resources are we going to put into this?

-Morten

