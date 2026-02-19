Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B9E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 07:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35B7C402CC;
	Thu, 19 Feb 2026 08:20:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4DE44402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 08:20:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 14D54208F6;
 Thu, 19 Feb 2026 08:20:48 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Date: Thu, 19 Feb 2026 08:20:44 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6572C@smartserver.smartshare.dk>
In-Reply-To: <20260219004449.114564-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Thread-Index: AdyhOP3UP0QrXcF9QMuNcKpNapBu8wANxM6g
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <20260219004449.114564-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>
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

> + * If a packet cannot be transmitted due to an error (for example, an
> + * invalid offload flag), the driver must still consume it and free
> the
> + * mbuf, rather than stopping at that point. Such packets should be
> + * counted in the *tx_errors* port statistic.
> + *

Looks like v1.
Please update with my feedback.

-Morten

