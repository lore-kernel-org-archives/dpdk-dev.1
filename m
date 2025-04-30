Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B46C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 18:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AECF402B1;
	Wed, 30 Apr 2025 20:40:57 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D1B71402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 20:40:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 05D72208BD
 for <dev@dpdk.org>; Wed, 30 Apr 2025 20:40:55 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Thread priority for background tasks
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 30 Apr 2025 20:40:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC19@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Thread priority for background tasks
Thread-Index: Adu5/2bGH34TeSqsQTuAupU5J5s1AQ==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

There are only two thread priorities in the enum rte_thread_priority: =
Normal and Real-time Critical.

I would like to poll ethdev counters, collect garbage and perform other =
jitter non-sensitive tasks in a control thread with lower priority than =
my ordinary control threads, so it will be preempted by any work ready =
for my ordinary control threads.

Which DPDK API am I supposed to use to assign this below-normal priority =
to my "background" control thread?

Or: Aren't we missing a priority like Linux' SCHED_BATCH?


Med venlig hilsen / Kind regards,
-Morten Br=F8rup

