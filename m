Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A13D5B85B
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 17:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1A7C4029A;
	Mon, 15 Dec 2025 18:54:54 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9D69740151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 18:54:53 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7FAEF202E1;
 Mon, 15 Dec 2025 18:54:53 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: improve Rx descriptor ring size checks
Date: Mon, 15 Dec 2025 18:54:50 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251215173543.1707960-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: improve Rx descriptor ring size checks
Thread-Index: Adxt6Uhf8eaV1R0fRoC02UqU8LV9JwAAmtbA
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
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
> Sent: Monday, 15 December 2025 18.36
>=20
> The default Rx ring size checks did not account for the fact that the
> port would not work correctly if the Rx ring size was only twice the
> free threshold size or less, so add in a new check for this. This =
would
> generally only apply in cases where very small rings sizes are being
> used, for example, with default Rx free thresh of 32, only ring size =
of
> 64 would cause issues.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Does dev_info.rx_desc_lim.nb_min returned by rte_eth_dev_info_get() need =
correction too?

