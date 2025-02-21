Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17088C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 16:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28DE402CC;
	Fri, 21 Feb 2025 17:58:23 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C499D402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 17:58:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7909C206C7;
 Fri, 21 Feb 2025 17:58:22 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Intel FAST_FREE offload question
Date: Fri, 21 Feb 2025 17:58:21 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel FAST_FREE offload question
Thread-Index: AduEgc/iFU9SU4gMQ7+UWHhx8oUUTw==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Ian Stokes" <ian.stokes@intel.com>, "Jingjing Wu" <jingjing.wu@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>
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

Intel NIC folks,

Why do the Intel network drivers, when using =
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, fall back to normal freeing when the =
mempool cache is empty (cache->len =3D=3D 0)? It doesn't make sense to =
me.

Example:
https://git.dpdk.org/dpdk/tree/drivers/net/intel/common/tx.h#n146

Med venlig hilsen / Kind regards,
-Morten Br=F8rup


