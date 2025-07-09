Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670FFC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 14:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE41402DA;
	Wed,  9 Jul 2025 16:59:54 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C35BB402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 16:59:52 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8C80F204A9;
 Wed,  9 Jul 2025 16:59:52 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Intel i40e rx burst API non-conformance?
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Jul 2025 16:59:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDAB@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel i40e rx burst API non-conformance?
Thread-Index: Advw4h85COHvVJEXQNirT1unXqARPw==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
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

Looking at the i40e driver source code, I think it doesn't conform to =
the API when requesting small bursts.

Let's say the hardware has received 31 packets.
rte_eth_rx_burst(...,16) will return 16 packets and leave 15 in the =
driver's staging buffer (which has capacity for 32 packets).

Time passes, and more packets are received.

Now, rte_eth_rx_burst(...,16) will only return the 15 packets from the =
staging buffer, and not proceed to check for more [1].
It thereby (according to my interpretation of the API description) =
informs the application that no more packets are ready to be received, =
which is incorrect.

[1]: =
https://elixir.bootlin.com/dpdk/v25.07-rc2/source/drivers/net/intel/i40e/=
i40e_rxtx.c#L640

PS: I stumbled across this while reviewing how the very old 32 packet =
limit bugs (where it truncated large rx/tx requests to 32 packets) had =
been fixed.

