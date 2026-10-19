Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD1CCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE75F402B6;
	Mon, 19 Oct 2026 08:20:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 71E8940269;
 Mon, 19 Oct 2026 08:20:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C1E0B20678;
 Mon, 19 Oct 2026 08:20:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] test: defer timer initialization
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 19 Oct 2026 08:20:26 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65ABC@smartserver.smartshare.dk>
In-Reply-To: <20261017144747.2155513-1-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] test: defer timer initialization
Thread-Index: Ad1eRopMBZun0dw8QNmZcYkXewW2EwBS1mcw
References: <20261017144747.2155513-1-david.marchand@redhat.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>, <bruce.richardson@intel.com>, <stable@dpdk.org>,
 "Anoob Joseph" <anoobj@marvell.com>,
 "Volodymyr Fialko" <vfialko@marvell.com>,
 "Erik Gabriel Carrillo" <erik.g.carrillo@intel.com>
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

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>


