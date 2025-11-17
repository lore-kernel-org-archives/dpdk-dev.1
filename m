Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD6CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA5B40262;
	Mon, 17 Nov 2025 12:51:55 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7C06A4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:51:53 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 45BDE20C65;
 Mon, 17 Nov 2025 12:51:53 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: bugs in rte_pktmbuf_copy
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Nov 2025 12:51:51 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65567@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: bugs in rte_pktmbuf_copy
Thread-Index: AdxXuJADak3EaX9JRha/+FtEefjhEg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <stephen@networkplumber.org>,
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

While working on a rte_pktmbuf_copy_bulk() function, I noticed a couple =
of bugs in rte_pktmbuf_copy():

1. If the copy is allocated from a mempool using pinned external =
buffers, the copy's RTE_MBUF_F_EXTERNAL flag is lost.
This is simple to fix:

-	/* copied mbuf is not indirect or external */
-	mc->ol_flags =3D m->ol_flags & =
~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNAL);
+	/* copy flags except indirect and external */
+	mc->ol_flags |=3D m->ol_flags & =
~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNAL);

2. If the packet is copied with non-zero offset, much of the metadata do =
not apply to the copy, e.g. many of the offload flags and the =
packet_type field.
Maybe metadata should be reset when copying with a non-zero offset?
Or maybe rte_pktmbuf_copy() should be considered "payload copy", so the =
copy should have all metadata reset?


Venlig hilsen / Kind regards,
-Morten Br=F8rup

