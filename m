Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB228CCD19A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01BC840E4F;
	Thu, 16 Oct 2025 11:28:40 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3435540269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:28:38 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 04B18206E3;
 Thu, 16 Oct 2025 11:28:38 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v6 5/7] app/testpmd: use space separator in dump commands
Date: Thu, 16 Oct 2025 11:28:35 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D2@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251014124046.1032293-6-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 5/7] app/testpmd: use space separator in dump commands
Thread-Index: Adw9B9FVtb4rfng9Tw+zyLCTTOFSAABd2EoA
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
 <20251014124046.1032293-6-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>,
 "Aman Singh" <aman.deep.singh@intel.com>
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

> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> Sent: Tuesday, 14 October 2025 14.34
>=20
> In order to make dump commands look like other commands
> which have keywords separated with space,
> replace these commands:
> 	- dump_physmem
> 	- dump_socket_mem
> 	- dump_memzone
> 	- dump_struct_sizes
> 	- dump_ring [name]
> 	- dump_mempool [name]
> 	- dump_devargs
> 	- dump_lcores
> 	- dump_trace
> 	- dump_log_types
> with these ones:
> 	- dump physmem
> 	- dump socket_mem
> 	- dump memzone
> 	- dump struct_sizes
> 	- dump ring [name]
> 	- dump mempool [name]
> 	- dump devargs
> 	- dump lcores
> 	- dump trace
> 	- dump log_types
>=20
> Both parsing functions (with and without name argument)
> are merged together.
>=20
> The function cmd_dump_init() is removed
> as it seems useless to define tokens at runtime.
>=20
> Trace is explicitly warned as not supported on Windows,
> because #ifndef in the tokens is not possible with MSVC.
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

