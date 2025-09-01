Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD6CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 14:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F0BF402ED;
	Mon,  1 Sep 2025 16:44:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6F228402EA
 for <dev@dpdk.org>; Mon,  1 Sep 2025 16:44:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 26D692045E;
 Mon,  1 Sep 2025 16:44:25 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v3 3/4] hash: reduce architecture special cases
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 1 Sep 2025 16:44:23 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FEA6@smartserver.smartshare.dk>
In-Reply-To: <20250826144922.74010-4-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 3/4] hash: reduce architecture special cases
Thread-Index: AdwWmK2EHaeFD6U/TQivySmVhjDqGQEtivhQ
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
 <20250826144922.74010-4-stephen@networkplumber.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
> Sent: Tuesday, 26 August 2025 16.49
>=20
> Make comparison of sizes compatible across platforms.
> Keep the special case code for 16 bytes for x86 and arm64 but
> also add simple xor for others.
>=20
> Need to keep rte_hash_k32_cmp_eq() exposed because ip_frag
> code poaches it.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

LGTM now.
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

