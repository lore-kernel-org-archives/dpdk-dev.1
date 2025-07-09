Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1ECC83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 18:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A83640A87;
	Wed,  9 Jul 2025 20:02:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 51F6640A7D
 for <dev@dpdk.org>; Wed,  9 Jul 2025 20:02:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 10CF720625;
 Wed,  9 Jul 2025 20:02:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Secondary process access control mechanism
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Jul 2025 20:02:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDAD@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Secondary process access control mechanism
Thread-Index: Advw+6MqmWnke3nFRe+DvLS+7fk4yQ==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anatoly Burakov" <anatoly.burakov@intel.com>
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

Are there any access control mechanisms to govern what a secondary =
process can do to a primary process?

Let's say I'm running a primary process, and want to allow only =
authorized secondary processes to attach to it. No unauthorized =
secondary processes should be able to attach to it.

I assume there is no fine grained control over which features various =
secondary processes can access.


Med venlig hilsen / Kind regards,
-Morten Br=F8rup

