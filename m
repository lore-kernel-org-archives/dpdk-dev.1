Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9006C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 15:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD2F440608;
	Tue, 15 Jul 2025 17:04:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5FB1C4028C;
 Tue, 15 Jul 2025 17:04:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0AADA200BA;
 Tue, 15 Jul 2025 17:04:45 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 15 Jul 2025 17:04:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDB5@smartserver.smartshare.dk>
In-Reply-To: <aHU1EJNHLjmynoUs@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Thread-Index: Adv031UNKC9n1QYPRsy9LvghDCkGrQADYruw
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB4@smartserver.smartshare.dk>
 <aHU1EJNHLjmynoUs@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Dengdui Huang" <huangdengdui@huawei.com>,
 "Vladimir Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>,
 "Patrick Robb" <probb@iol.unh.edu>, "Dean Marx" <dmarx@iol.unh.edu>
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

FYI:
Last time I looked, it seemed like the VLAN/QINQ "tag present" mbuf RX =
flags were only set along with the RX _STRIPPED flags, i.e. not set when =
stripping was not enabled.
Although setting the "tag present" flags (and the =
vlan_tci/vlan_tci_outer fields) without stripping would be nice to have, =
I think we should initially focus on stripping behavior.

