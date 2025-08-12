Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A3C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 07:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2237B4026A;
	Tue, 12 Aug 2025 09:56:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 36AB740264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 09:56:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F3BE92051E;
 Tue, 12 Aug 2025 09:56:13 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: CI failures
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 12 Aug 2025 09:56:09 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE2D@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CI failures
Thread-Index: AdwLXpCepZ7ACmmFSt+vDNRiQZw2Rw==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>,
	<thomas@monjalon.net>,
	<stephen@networkplumber.org>
Cc: "Patrick Robb" <probb@iol.unh.edu>, <bruce.richardson@intel.com>,
 "Aaron Conole" <aconole@redhat.com>, "Gao, DaxueX" <daxuex.gao@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 "David Marchand" <david.marchand@redhat.com>,
 "Xu, HailinX" <hailinx.xu@intel.com>,
 "Cui, KaixinX" <kaixinx.cui@intel.com>
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

Hi all,

The merged patch "[v3,3/3] ethdev: Reject conflicting TX offloads =
configuration" [1] is causing CI failures.
Specifically, the test_txoffload_queue test case in the =
rxtx_offload_test_plan test plan fails.

The patch depends on "[v3,1/3] testpmd: Do not enable mbuf fast release =
TX offload by default" [2], which has not yet been merged, and a =
modification of the test plan related to this patch 1/3.
I'm working with Patrick and others to fix the test plan accordingly.

[1]: =
https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-3-mb@=
smartsharesystems.com/
[2]: =
https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-1-mb@=
smartsharesystems.com/


Med venlig hilsen / Kind regards,
-Morten Br=F8rup

