Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D479EC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E340642EB8;
	Fri, 20 Jun 2025 12:24:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C19B9400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:24:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A8A6520A80;
 Fri, 20 Jun 2025 12:24:28 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RTE_ETH_RSS_IP support by Intel NIC drivers
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 20 Jun 2025 12:24:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD17@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RTE_ETH_RSS_IP support by Intel NIC drivers
Thread-Index: AdvhzX6fHeFxWgfLT22/of488A1Yvg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>
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

Don't the Intel i40e and e1000 drivers support RSS on IP addresses [1]?
It looks like they do, but don't report it.

For i40e:
Accepted: 0x2288 FRAG_IPV4 NONFRAG_IPV4_OTHER FRAG_IPV6 =
NONFRAG_IPV6_OTHER
Unsupported: 0x8104 IPV4 IPV6 IPV6_EX

For e1000:
Accepted: 0x8104 IPV4 IPV6 IPV6_EX
Unsupported: 0x2288 FRAG_IPV4 NONFRAG_IPV4_OTHER FRAG_IPV6 =
NONFRAG_IPV6_OTHER

The RSS offload types [2] have no descriptions, so it's hard to guess =
which alternatives would be viable.

[1]: =
https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L78=
3
[2]: =
https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L55=
3

-Morten

